Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5203EC67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A1B206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SBw2cksV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A1B206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeJMCGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 22:06:47 -0400
Received: from mail-co1nam03on0058.outbound.protection.outlook.com ([104.47.40.58]:6224
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726097AbeJMCGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 22:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYL6qSxXwQ2ruD4+REbfreawJl79X3RE9FzYT7BvNZI=;
 b=SBw2cksVGKvq43hKql6d9SVnveFAyXudu1Wq4J0+PPhPGxI0iXxoKYqdSgLmY3JxA4aB1qWT1QPHoJnVHUKtvTZbWQG7h5BmuewhvP7Qe/2LLj8rGo/WLNNdApxoF0GgmyObD6Q5NFz5JvTZeV0A48JPB0Ld2Hm7oIfQAGm7jD8=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1452.namprd12.prod.outlook.com (10.172.38.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Fri, 12 Oct 2018 18:32:53 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::bd60:9d30:b818:b828%3]) with mapi id 15.20.1228.020; Fri, 12 Oct 2018
 18:32:53 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Borislav Petkov <bp@suse.de>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "vikas.shivappa@linux.intel.com" <vikas.shivappa@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "luto@kernel.org" <luto@kernel.org>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "jannh@google.com" <jannh@google.com>,
        "dima@arista.com" <dima@arista.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 09/11] arch/x86: Introduce new config parameter AMD_QOS
Thread-Topic: [PATCH v3 09/11] arch/x86: Introduce new config parameter
 AMD_QOS
Thread-Index: AQHUYaGv1vrx53eHGU6x4h2+Q6V546UamQ+AgADC/ICAAFR2gIAAQDCA
Date:   Fri, 12 Oct 2018 18:32:53 +0000
Message-ID: <5715b473-046c-cc19-bc41-e555b7f829b4@amd.com>
References: <20181011203223.18157-1-babu.moger@amd.com>
 <20181011203223.18157-10-babu.moger@amd.com> <20181011220255.GB21876@zn.tnic>
 <0cf1ea65-0528-b133-2b89-2e04644ea2e6@amd.com>
 <20181012144305.GA11859@zn.tnic>
In-Reply-To: <20181012144305.GA11859@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0035.namprd02.prod.outlook.com
 (2603:10b6:803:2e::21) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1452;20:4RQ0WExHDAEMIPwlwj0lFzowba9F5XNt4AsYoZxoBjxjXWIoL0967JlagPKVzLnOK/8NcUet+iCTjmdIZ/ZeqTSq6PiySESqXkDEI6LX1nLhMvRxrHEYFeXJHNCa99SbBBC+VOTxVVKXVKIU0vtQRP6WPiAN+0k5AWv02OlcIKUB2afAV8dSRJ2ahK4iNlvseEGVLslGIQK7T5Hud8KPoyiao/wE4WzrJBh4pr8QREkhcILcreUSysO9cEqOqV14
x-ms-office365-filtering-correlation-id: ff67739b-c5b3-4921-a13f-08d630711ef8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1452;
x-ms-traffictypediagnostic: DM5PR12MB1452:
x-microsoft-antispam-prvs: <DM5PR12MB14523E9719ED984644BE1DA495E20@DM5PR12MB1452.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991067);SRVR:DM5PR12MB1452;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1452;
x-forefront-prvs: 0823A5777B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(366004)(189003)(199004)(71190400001)(81156014)(66066001)(81166006)(229853002)(93886005)(8936002)(7416002)(71200400001)(53546011)(305945005)(7736002)(5250100002)(316002)(386003)(11346002)(6506007)(31696002)(478600001)(26005)(256004)(52116002)(476003)(5660300001)(2616005)(76176011)(99286004)(86362001)(6486002)(8676002)(68736007)(72206003)(486006)(2900100001)(25786009)(6512007)(36756003)(105586002)(3846002)(31686004)(14454004)(186003)(6436002)(54906003)(2906002)(446003)(102836004)(6916009)(97736004)(4326008)(53936002)(6246003)(6116002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1452;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: NThyPaqYBjJXQISoZW9XQg+1UukkJgQCDjLctW1AVCdRW481qoqrbcyphfq7UtU+eyW0YnIxUozJRVe47wcYp7qS/YHphvmDHAzBLx9dNXFHLo5BkwAgUSrIxReBI9pEU5QRtpgJaKbA4S+f+89BVtz+cYyYP22k9z29vtv9snd+PumsL8h6rLq+Czom1+eA/x93EW/vLH/ITrrVNaE+TtKLmaSyWDrp1JulNk+ir5dp4bFK/rF9XhcyPb+Hr5TYcJgjMoceyGD3fxGPsaIWa7POsLyxihcCzvr+RC0x64VR4q1+foHFA+1FhmrcJv5anr6tvf4SBFaybV6+YtZRp/koZ2wSqEnufMy6rqlAIos=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC3969BEF4A91B41BC8DD67B93582168@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff67739b-c5b3-4921-a13f-08d630711ef8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2018 18:32:53.3836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMC8xMi8yMDE4IDA5OjQzIEFNLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+IE9uIEZy
aSwgT2N0IDEyLCAyMDE4IGF0IDAyOjQwOjUwUE0gKzAwMDAsIE1vZ2VyLCBCYWJ1IHdyb3RlOg0K
Pj4gVGhhdCBpcyBjb3JyZWN0LiBDUFVfU1VQX0FNRCBpbXBsaWNpdGx5IG1lYW5zIHg4Ni4NCj4+
IFRvIGJlIG1vcmUgc3BlY2lmaWMsIEkgd2lsbCBjaGFuZ2UgaXQgdG8NCj4+ICJkZXBlbmRzIG9u
IFg4Nl82NCAmJiBDUFVfU1VQX0FNRCIgYXMgdGhpcyBmZWF0dXJlIGlzIGZvciBYODZfNjQgb25s
eS4NCj4gDQo+IE5vLCB3aGF0IEknbSBzYXlpbmcgaXMsIG1ha2UgaXQgZGVwZW5kZW50ICpvbmx5
KiBvbiBDUFVfU1VQX0FNRC4NCg0KU3VyZS4gV2lsbCBkbyBpbiBuZXh0IHJldmlzaW9uLiBUaGFu
a3MNCg0K
