Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0F9ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF0821479
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="A0YuXx10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF0821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390959AbeIUXey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:34:54 -0400
Received: from mail-sn1nam02on0040.outbound.protection.outlook.com ([104.47.36.40]:37856
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390180AbeIUXex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yilSPQHiL71KZ2jOaKrq5qRHjTykxsq/DMg2uo7QGxI=;
 b=A0YuXx10/3dhgKLFyhwDoWIt8jOUTOqfBJrAkbOvkkO/Qox8aHQpnJaf3QRWfY3s9nRGRxxuN00LSiY+zYF15mHRnJVDA74yKGZKjCRNpSG2vUIAu4HwcVbbuIxyhJ02SX/7BtO9yW8eH0rbStLULZAhodKkqSs6Z0YdXcqoYUM=
Received: from SN1PR12MB0175.namprd12.prod.outlook.com (10.162.3.15) by
 SN1PR12MB0847.namprd12.prod.outlook.com (10.164.26.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.15; Fri, 21 Sep 2018 17:44:54 +0000
Received: from SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::2d1b:5638:5680:80e7]) by SN1PR12MB0175.namprd12.prod.outlook.com
 ([fe80::2d1b:5638:5680:80e7%5]) with mapi id 15.20.1143.019; Fri, 21 Sep 2018
 17:44:54 +0000
From:   "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 0/2] Provide options to enable spectre_v2
 userspace-userspace protection
Thread-Topic: [PATCH 0/2] Provide options to enable spectre_v2
 userspace-userspace protection
Thread-Index: AQHUUGV5bSUg7rHX5kCrUgywYzutiqT5YAsAgAEvOYCAAGzvAIAACJeA
Date:   Fri, 21 Sep 2018 17:44:54 +0000
Message-ID: <fce1f42f-cbca-c715-d281-3bb0933a1592@amd.com>
References: <cover.1537392876.git.tim.c.chen@linux.intel.com>
 <3609a852-1477-a5b2-3858-c2cbfb3999a9@amd.com>
 <52076088-a97e-d43e-7a75-40059fc394da@amd.com>
 <f0308518-6444-815a-cdcf-9e7d43887727@linux.intel.com>
In-Reply-To: <f0308518-6444-815a-cdcf-9e7d43887727@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR16CA0012.namprd16.prod.outlook.com
 (2603:10b6:404:f5::22) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0847;20:xvNQ6Aa5QGZ7Y/b8kNVo+6d4jSpwZgEqBy0DpJ9yG+xf2xoY7MIqLwKmd0DEnpYBrPM6PKLBi6yWTmoyzuXOc54qbK6odcjo1PSzek9HsMBCle7pPK0zS03m53PnqV7KIIDCpWcmfGwaBg+3XwbgXA85Yw+GYE6FaBQglckC2/a03NPoQ5k4PAg53YMK7DJUTp+46bPznazGnD+sYIg3ESQlBDXvduRbK4ykmKtaqZwsPUK8FSQ8R4YxyvwhTbBs
x-ms-office365-filtering-correlation-id: e1c31857-0f34-4849-aa4a-08d61fe9f02f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0847;
x-ms-traffictypediagnostic: SN1PR12MB0847:
x-microsoft-antispam-prvs: <SN1PR12MB0847ED91F94A723C3508DE68EC120@SN1PR12MB0847.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051);SRVR:SN1PR12MB0847;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0847;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(366004)(136003)(189003)(199004)(106356001)(36756003)(8676002)(52116002)(5250100002)(76176011)(93886005)(2900100001)(31696002)(71190400001)(71200400001)(6436002)(25786009)(86362001)(14454004)(5660300001)(6512007)(72206003)(7416002)(478600001)(6486002)(53936002)(8936002)(6246003)(26005)(53546011)(186003)(386003)(102836004)(6506007)(476003)(4326008)(446003)(2616005)(97736004)(229853002)(486006)(11346002)(256004)(99286004)(31686004)(6116002)(105586002)(54906003)(305945005)(81156014)(2906002)(68736007)(81166006)(7736002)(110136005)(3846002)(66066001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0847;H:SN1PR12MB0175.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9qaj51Fx4hHXUYhuLWlVBhO9bJI/20z2AKLuRS40D5WYA95hnUJ1rCkM55LOAsnK5OIOGVTbeC1XiUeHiAsr/QlVpo6UWdQiVsYZ+rphzMeCy+LLFlTaqQbFvNp959Gc3rMdxFZ18gzJuI1mMSa6U17bFh6OD9cv1/X1qW5Mssw2hdOj1VHldUwIiqb3pyvkMheVCPbLHqydLLapvAEtFKTaYHOjPxoMxW/68UTyhIO42skiod900k9nX0ppwwkNaz1exRPKwE444uRYyXj/RR7F043ddXm9/q35AhptlmN3nPiPpi4WnPP4fMZ/rYHCDZJFZ54veThb9aaU/0SpPsDNgVtozeBO7d8H3o5fYN4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C10B6AA44703E4C91AB5E13DB7E596F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c31857-0f34-4849-aa4a-08d61fe9f02f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 17:44:54.4343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0847
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA5LzIxLzIwMTggMTI6MTQgUE0sIFRpbSBDaGVuIHdyb3RlOg0KPiBPbiAwOS8yMS8y
MDE4IDA4OjQ0IEFNLCBMZW5kYWNreSwgVGhvbWFzIHdyb3RlOg0KPiANCj4gDQo+PiArCWlmIChz
dGF0aWNfY3B1X2hhcyhYODZfRkVBVFVSRV9TU0JEKSkNCj4+ICsJCXg4Nl9zcGVjX2N0cmxfYmFz
ZSB8PSBzc2JkX3RpZl90b19zcGVjX2N0cmwodGlmbik7DQo+PiArDQo+PiArCXg4Nl9zcGVjX2N0
cmxfYmFzZSB8PSBzdGlicF90aWZfdG9fc3BlY19jdHJsKHRpZm4pOw0KPj4gIA0KPj4gIAl3cm1z
cmwoTVNSX0lBMzJfU1BFQ19DVFJMLCBtc3IpOw0KPj4gIH0NCj4+ICANCj4gDQo+IFNob3VsZCB0
aGlzIHBhcnQgYmUgcy94ODZfc3BlY19jdHJsX2Jhc2UvbXNyLyAgPw0KDQpZdXAsIEkgbWVzc2Vk
IHVwLiBUaG9zZSBzaG91bGQgIm1zciB8PSIsIG5vdCB4ODZfc3BlY19jdHJsX2Jhc2UuDQoNClRo
YW5rcywNClRvbQ0KDQo+IA0KPiBUaW0NCj4gDQo=
