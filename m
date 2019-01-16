Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582E3C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B1220840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aj+r9yLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731484AbfAPTj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:39:56 -0500
Received: from mail-eopbgr720065.outbound.protection.outlook.com ([40.107.72.65]:44185
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731174AbfAPTj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:39:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0G+Dp78AOqe2D2rjvZlk8M5e3dPkdEwJSCya8e5G90=;
 b=aj+r9yLLM/48MIqlxgX6NOQGvor9xBxCRVPxOs6P5ebNW9iT7xMhfCejJV4Q2XKtHXCXjEYjuT4TG+en6iAyQw3SI/BFWTjQqMr+6TvP/bWeGl5GGxSHGpGPFP2Drb4jvDGXwn4cf1rV2FDYsd5uk6erkLYlejL8j8gSwFshdpU=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1772.namprd12.prod.outlook.com (10.175.91.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Wed, 16 Jan 2019 19:39:50 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9dfd:2b7b:1999:aff2%2]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 19:39:50 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>,
        Xiaochen Shen <xiaochen.shen@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/10] selftests/resctrl: Add resctrl selftest
Thread-Topic: [PATCH v4 00/10] selftests/resctrl: Add resctrl selftest
Thread-Index: AQHUmYz8wtnOL0tCbku6Pwhl6uvgeqWxz7uAgACcLoCAAAd3AA==
Date:   Wed, 16 Jan 2019 19:39:50 +0000
Message-ID: <6f267b9a-f621-0cdc-9189-996cd3c40d13@amd.com>
References: <1545438038-75107-1-git-send-email-fenghua.yu@intel.com>
 <09e6d4f2-94c8-918c-4d54-0000c3d809b2@amd.com>
 <20190116191304.GA221444@romley-ivt3.sc.intel.com>
In-Reply-To: <20190116191304.GA221444@romley-ivt3.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0041.namprd02.prod.outlook.com
 (2603:10b6:803:2e::27) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1772;20:CljeeqUlCUU/QiRf6cwdZb6TMLRrJzGyIhADPEI3j1ylcibcvoGHRFZ6XnCYMJ10OXfUCEsPhdDCcLyVGaLvam86f2VsZyiNPTtHYxSq8ttIsKW8yVdzJBKrJSccofwkBdWOQTKnHsp1s5MGRsNTnU6aC9o26MZVOjimfgCjur+uTyucW0cVdD09at3ME/kqxI54pPM2jd/A3njC/hELRWhYHS7n9fF4+9DsmD10ukc724uJgE1WO6BF+pOQ5nDt
x-ms-office365-filtering-correlation-id: 67f24b1d-e897-4e97-2bee-08d67bea613d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1772;
x-ms-traffictypediagnostic: DM5PR12MB1772:
x-microsoft-antispam-prvs: <DM5PR12MB17726FF6B225C240C2952CFD95820@DM5PR12MB1772.namprd12.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(396003)(376002)(136003)(199004)(189003)(6916009)(105586002)(31686004)(99286004)(4326008)(6246003)(316002)(97736004)(6116002)(3846002)(53936002)(54906003)(8936002)(25786009)(8676002)(6512007)(36756003)(81156014)(446003)(81166006)(11346002)(2616005)(6436002)(476003)(478600001)(186003)(72206003)(26005)(6486002)(256004)(14444005)(66066001)(86362001)(102836004)(4744005)(68736007)(71200400001)(71190400001)(229853002)(7416002)(76176011)(486006)(2906002)(7736002)(53546011)(31696002)(305945005)(52116002)(106356001)(14454004)(6506007)(386003)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1772;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hda1Xm5ZUsLiKRVTF2mK62ad0moBboHKehDBMrxdI8JEzRqAFrjG9YH3fK5c+u9qq7n8NRun2tF74A9bsZUUiC7viq9Wi9u+ElrsgoKzetI5T0hEeEUd5srkQoc3YRis0NxiBBO5s1sgE65ui5JR2m83/h8IRRo7Htri1adcE+zC6rRi9aJX+jNv7LNkNWFGmAXUs3WfGS7XI3qox1DZQYYAIVHn+nUy6pVgAFax6Yss1kDaoIgfsltGuNPWqGAvPp+49M4zgs/PccpCwVLa8ASVCXIRQLHwk/F4Th8FA74txKDgiVgPBXpS/ozVL4ph1QJtr8Dc6WT0JfTdgGijhwAPnh5uJAJsZCAthT8hNHeAaxvGoyRuaeko/fL8GjKPIQMwgccqgzvuTMkOazRasPrxv+Ox+9UG189TjQY3iok=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBD6433702DE6544B2E326FC3F2C1A6C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f24b1d-e897-4e97-2bee-08d67bea613d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 19:39:49.6435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1772
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8xNi8xOSAxOjEzIFBNLCBGZW5naHVhIFl1IHdyb3RlOg0KPiBPbiBXZWQsIEphbiAxNiwg
MjAxOSBhdCAwMzo1NDowN1BNICswMDAwLCBNb2dlciwgQmFidSB3cm90ZToNCj4+IEhpIEZlbmdo
dWEvU2FpL0Fyc2hpeWEsDQo+PiAgIFdlIHdlcmUgdGhpbmtpbmcgb2YgdXBkYXRpbmcgdGhlc2Ug
c2VsZnRlc3RzIHRvIHdvcmsgb24gYm90aCBJbnRlbCBhbmQNCj4+IEFNRC4gV2hhdCBkbyB5b3Ug
Z3V5cyB0aGluaz8NCj4+DQo+PiBJZiB0aGF0IGlzIG9rLCBJIGNhbiB1cGRhdGUgdGhlc2UgcGF0
Y2hlcyBhbmQgcmVzdWJtaXQuIElmIHlvdSBoYXZlDQo+PiBhbHJlYWR5IHVwZGF0ZWQsIHBsZWFz
ZSBwb3N0IHRoZSBsYXRlc3Qgc2VyaWVzLiBJIHdpbGwgdXNlIHRoZSBsYXRlc3QNCj4+IHZlcnNp
b24uIFBsZWFzZSBsZXQgbWUga25vdy4NCj4+IFRoYW5rcw0KPiANCj4gSGksIEJhYnUsDQo+IA0K
PiBTdXJlLiBQbGVhc2UgZ28gYWhlYWQgdG8gdXBkYXRlIHRoZSBzZWxmdGVzdHMgdG8gd29yayBv
biBib3RoIEludGVsIGFuZCBBTUQuDQo+IFRoYXQncyB3b25kZXJmdWwgZm9yIHJlc2N0cmwgb3Zl
cmFsbC4NCj4gDQo+IFdlIGRvIHBsYW4gdG8gdXBkYXRlIHNlbGZ0ZXN0IGFuZCBhZGQgcmVzY3Ry
bCBmcyBpbnRlcmZhY2UgdGVzdGluZy4gQnV0DQo+IGFzIG9mIG5vdyB3ZSBkb24ndCBoYXZlIHVw
ZGF0ZWQgc2VsZnRlc3QgeWV0LiBQbGVhc2Ugd29yayBvbiB0aGUgdjQgcGF0Y2gNCj4gc2V0Lg0K
DQpTdXJlLiBUaGFuayB5b3UuDQoNCj4gDQo+IFRoYW5rcy4NCj4gDQo+IC1GZW5naHVhDQo+IA0K
