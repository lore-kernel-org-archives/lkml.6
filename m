Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BCEC282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 03:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4522148D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 03:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LnfkthGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfBBDcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 22:32:14 -0500
Received: from mail-eopbgr1320090.outbound.protection.outlook.com ([40.107.132.90]:1056
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726528AbfBBDcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 22:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9rE893K75W7PEcNhLgjaYHX1NUJBeskwGbXVTW834A=;
 b=LnfkthGPZeF+gvn9+I7rAmYPjPFiEnf4Er4UqotEC5OR3Pwl2nMi4gPVcOaBrra+q13ypx68Vh3SIX0bjavuXtgvwkyta6/CifwMjIbMSSJy0cOjoPJ4JqiQiGFwsuxPgFlKXNhKt4j1mDwihXKtUVLQ4fvOGA3WKX64q9+7e6M=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0203.APCP153.PROD.OUTLOOK.COM (52.133.194.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.6; Sat, 2 Feb 2019 03:32:01 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f%9]) with mapi id 15.20.1601.011; Sat, 2 Feb 2019
 03:32:01 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Josh Poulson <jopoulso@microsoft.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>, Len Brown <lenb@kernel.org>
Subject: RE: [PATCH v2] nfit: add Hyper-V NVDIMM DSM command set to white list
Thread-Topic: [PATCH v2] nfit: add Hyper-V NVDIMM DSM command set to white
 list
Thread-Index: AdS3bN9R4nkrWGwLQkueB3AG7WN74AA93MgAAHsdi6AAALlsgAAB+BMAAAs5uIAAAJW/gAABbyoAAAGFroAAAeNCcA==
Date:   Sat, 2 Feb 2019 03:32:01 +0000
Message-ID: <PU1P153MB01692AB56F732623399A9EC5BF930@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB01690EDA138D3ABDE5B4A482BF970@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4jD1oRWzA4ZiMYZm1uxsbOdgqzbb9raH70-HBDqapcE_g@mail.gmail.com>
 <PU1P153MB0169977604493B82B662A01CBF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4haUouYs_Vfju2SMvjcwc7rqY06zqT8NJ-3uakGMZSu0w@mail.gmail.com>
 <PU1P153MB01694FCAF062E089059CD441BF920@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4gdWJ8qtiASU9ggz56Mkrm9OXfsO74RM9OOrXFmBw_A9Q@mail.gmail.com>
 <PU1P153MB0169D8F7C6E29C22FE122F3FBF930@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <PU1P153MB0169D661955195EA070E7EF0BF930@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <CAPcyv4iEcCG0h+HLPkfSC0aNDLq9hdoO00XErF93PHTmEgO-TQ@mail.gmail.com>
In-Reply-To: <CAPcyv4iEcCG0h+HLPkfSC0aNDLq9hdoO00XErF93PHTmEgO-TQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-02T03:31:58.7600160Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fd88a137-ea30-44bd-8a5d-696eb3d2d852;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:1760:214f:1d46:c540:588e]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0203;6:ltTHa5Yqx3U/oA2mYUpyHqlBmnRhy8UlCE1S08Le1zhPThxpYMFZHWIXbr1jayEMyYZNYWxuWiO/2CWvefL4/FoGqFwmRoDfbqP2jeG4Pzu1i5ocq72UWTkGSEwozm1ADyViuyvfIxG2zglaXsoKF/WqCkk+nl4Gsiv2K2zxk4ps7lbdkxk9b96wvA8oA8zQAShIB9oimFJwCXJLIeeo1NuxchJTUP8CGivyL3cIkR4heZltLlMwxZHBlPD8E4WcZv2ErJVpROVNCXtvRW25JBOFGXQFuGGN/KiK+ff6/44swrDTIIiHQw+QxzUkkXwvQ8Jp2mLqGOyFjd+vmah2TAfFI8ASQJjhyXUNyAkGFs5etRgKRFxDCPLifMBSnEY5ANc/nxgN3fKDrGC9f4Z1M6ivMyGIZtsWUM8L9e4w4Nmz+gzsFpJzoLEDzCkEVwa+TfnVFM+hww9ochIityBfDg==;5:sfdUECXCSh+KDY9HUHGcFnY0JkL1wl93CANM1VxZClkhUr/yvIbyjrjFv/hXWxPTZj+OxF96m1HgptfCQ3h/Va2zHY0koJ5qlflrpq/sqNbsE0bynKEgImrQh707SdNWZGOTh5I2gzDqN0seLaexnv0FL9qiZDrQWrUOtBCp/p+sQ+XqlW5wEGvLOTnC7rqaYdWlwJL0MwxJEmqWcsuNkw==;7:ZV+O8oI24t4wjshCdF+TtR586cOTwnVH+PeJa1VxM/Kr9F1Er/gweL2g8gOB8uuO3Eur3BH1bwtnwYb/A6m8E9bfVGlO6dUeSkYs+5Rx28y1irBjLF96UsHkLbnu111PsUJrfTZ2ApFpdXWjOKRuEg==
x-ms-office365-filtering-correlation-id: 9d4f9cc0-36eb-4c72-a268-08d688befea1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0203;
x-ms-traffictypediagnostic: PU1P153MB0203:
x-microsoft-antispam-prvs: <PU1P153MB020300E3F9C4148D64E3F7AFBF930@PU1P153MB0203.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 09368DB063
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(366004)(376002)(39860400002)(396003)(136003)(199004)(189003)(25786009)(2906002)(86612001)(97736004)(478600001)(33656002)(256004)(316002)(7736002)(14444005)(6506007)(217873002)(305945005)(68736007)(14454004)(86362001)(7696005)(76176011)(229853002)(11346002)(486006)(476003)(446003)(6246003)(106356001)(93886005)(81156014)(102836004)(8676002)(22452003)(81166006)(46003)(105586002)(99286004)(74316002)(55016002)(186003)(4326008)(4744005)(6436002)(8936002)(10090500001)(54906003)(9686003)(10290500003)(71200400001)(53936002)(71190400001)(8990500004)(6116002)(6916009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0203;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o/bAQBwcDlIXw/0cFZ4fp223rT5S31bBFJ1hbC3S5gVoUL74tZer448HAwrhoeGBeHAWnkSAnnu3W4lZyHgStYY1eFi34FFwgUPq2L8Qq/er/WzbsjYc4tBO1Ayv5FYQOUM1lcHpC7lbsesE98ybIBVMRyZhGzVcY3mwy5q8hyqlI/q/M6oxAzYKcOu9Q5aBnE/HwkJTapIItSiT5QedakcJ1s3wHOwJxGJZtpA7z0P2Z0+7UM2wX8BWKLRoZcVOJ4ggwDenmdtQdth92OHi7tp6bLxm/c3Y4PmUFrQrH3EYVccqfzM/Hg62y9yPwZchFfGN4T8+h/u615Z8bddv3bE6WV9IK4OAc4ZEUUmreaFIT5fNSKpHnDmv2C9o2eLSxaDcWa5LCm7RQxlWmSgire4R4SEutSYCX/8N3Q0Bz6o=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4f9cc0-36eb-4c72-a268-08d688befea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2019 03:32:01.2875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gU2VudDog
RnJpZGF5LCBGZWJydWFyeSAxLCAyMDE5IDU6MjkgUE0NCj4gLi4uIA0KPiBIb25lc3RseSwgdGhl
IHF1aWNrZXN0IHBhdGggdG8gc29tZXRoaW5nIGZ1bmN0aW9uYWwgZm9yIExpbnV4IGlzIHRvDQo+
IHNpbXBseSBkZWxldGUgdGhlIF9MU1Igc3VwcG9ydCBhbmQgdXNlIHJhdyBtb2RlIGRlZmluZWQg
bmFtZXNwYWNlcy4NCj4gV2h5IGhhdmUgbGFiZWxzIGlmIHRoZXkgYXJlIHJlYWQtb25seSBhbmQg
dGhlIHJlZ2lvbiBpcyBzdWZmaWNpZW50IGZvcg0KPiBkZWZpbmluZyBib3VuZGFyaWVzPw0KSHlw
ZXItViBWaXJ0dWFsIE5WRElNTSBjYW4gYWxyZWFkeSB3b3JrIHdpdGggVWJ1bnR1IDE5LjA0IHZp
cnR1YWwgbWFjaGluZQ0KcnVubmluZyBvbiBIeXBlci1WLCBpLmUuIEkgY2FuIGNyZWF0ZSBhIHJh
dyBvciBmc2RheCBuYW1lc2FwY2UsIGFuZCBjcmVhdGUgYQ0KeGZzIG9yIGV4dDQgZmlsZSBzeXNl
dG0gaW4gL2Rldi9wbWVtMHAxLCBhbmQgbW91bnQgdGhlIGZpbGUgc3lzdGVtIHdpdGggYW5kDQp3
aXRob3V0ICItbyBkYXgiLiBUaGUgYmFzaWMgZnVuY3Rpb25hbGl0eSBpcyBnb29kLg0KDQpNeSBy
ZWNlbnQgd29yayBpcyBtYWlubHkgZm9yIG5kY3RsIHN1cHBvcnQsIGkuZS4gZ2V0IHRoZSBoZWFs
dGggaW5mbyBieSBuZGN0bCwNCmFuZCB1c2UgbmRjdGwgdG8gbW9uaXRvciB0aGUgZXJyb3IgZXZl
bnRzIChpZiBhcHBsaWNhYmxlKS4NCg0KVGhhbmtzLA0KLS0gRGV4dWFuDQo=
