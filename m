Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B426C282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 05:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F912083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 05:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TwdYaJ1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfBDFqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 00:46:07 -0500
Received: from mail-eopbgr1310100.outbound.protection.outlook.com ([40.107.131.100]:51672
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725953AbfBDFqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 00:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoNhh3aXF8M3aqpiL5xqhxf2dRx/tvD5Ns57oaPeJzo=;
 b=TwdYaJ1KEl6DyB2BsBeKjfOddhqIQiSdnm3eYiAHovResLIoek3zza+hNtPecP2Lh/KGy9UO0A1l6PcqnUYcx8ey0FfgZUXKzT42AmvqmwyAfJQ8TKHo0xmm5ACO4OXZtZcUn+jRGVNRwTn18/4mJ60BwkZOh8IHr3LXn8lsPmQ=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0140.APCP153.PROD.OUTLOOK.COM (10.170.188.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.5; Mon, 4 Feb 2019 05:45:58 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::7822:a20:e63c:de2f%9]) with mapi id 15.20.1622.000; Mon, 4 Feb 2019
 05:45:58 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] acpi/nfit: Require opt-in for read-only label
 configurations
Thread-Topic: [PATCH] acpi/nfit: Require opt-in for read-only label
 configurations
Thread-Index: AQHUu/h4qMqaz/qVYUuw9L1iVtgkOaXPHv8A
Date:   Mon, 4 Feb 2019 05:45:57 +0000
Message-ID: <PU1P153MB0169B2995B66A08CEA44458DBF6D0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <CAPcyv4iMau=fvOfubDvK=cg5v5287TvXqBCm=p8nqbz2es6YEg@mail.gmail.com>
 <154922213038.3561630.15221922065373676874.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <154922213038.3561630.15221922065373676874.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-02-04T05:45:54.8935904Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=468300f5-912d-49a9-a85c-3718b3074598;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:1760:442d:d709:49df:d11c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0140;6:TU74MiA2AvB1TkQXrXiu4xgtojD23+1JdzOethmkfD7vpdUMUykBwalEO0R+WqzDK7IpJdeEQoH/eHb6CRXl4nQ0SkRwgw14/n/VoMSjEe4+t4sp+8cwJX1n+z7RX7VsSTm5Q7qTceICEelA/dkTxwQ8Un2Ogqd56Pu6Is0K2g4DprEhcN6QQkgkyJZCHj8bKUb+5O2vzPciIJ6Zl+l3zlxWA8V+xdMrbTGwzd2Ryu9XkHn4KnxR2JXNDkql5Soa0R35L49JvueHflFIXG1T2evC5mvTgHGm7LL/WIwT545rA01fBG+GX0Ag2NJ3KPqdbblw8ilrXURfOC59kOiLP3m6731zQIB5JZZEl6vSb4EMGTusIC5FX/veiu5E9DBoqVjDbHwJ0oqh0CrBi+Jn7m5RY4jzJvPSMFRywvvKIscMRcISLGpPFOrhApGUu904SJRPiGRgIICyJ8EVFlAmxg==;5:CYXuTouHRqnf6tLbROqcaAEVo8pPvYUmVng6grGOrfwuy3jT5IGFjpUPIfeW648e5Xq4PhuTWAtkKl7Xz203Xs7BNG0hkkcl1GP85vkVpVy5CyVftr6JhP9nfdVibpZFgCXuxzzKowkY6J04e2bl1e5X9SmwMXjhnZc77G8xq4ptHFj7K/U5DCGI0DMQBRWVWFrFAwmHt1hGRkW6gwBCRw==;7:rS766DHJelwgecDULbKklALGBZiKD7mfmPeIglFH7j289JOBt/rSIaxaa4pognNSVATcjWR2Ib0pTl0IoMLYaTl/C2srBYjHoa4aKg+DwF8KoqEdn35lnxydofValk0EvScRjuUlYzOhtQ5Dko7QLQ==
x-ms-office365-filtering-correlation-id: 0678effe-0566-4189-f3c4-08d68a6409aa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0140;
x-ms-traffictypediagnostic: PU1P153MB0140:
x-microsoft-antispam-prvs: <PU1P153MB01400B1D546E42D65D930D86BF6D0@PU1P153MB0140.APCP153.PROD.OUTLOOK.COM>
x-forefront-prvs: 0938781D02
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(136003)(396003)(366004)(189003)(199004)(51914003)(55016002)(305945005)(9686003)(7696005)(7736002)(76176011)(107886003)(53936002)(4326008)(99286004)(74316002)(14444005)(256004)(2501003)(6436002)(25786009)(97736004)(102836004)(8936002)(186003)(11346002)(446003)(81156014)(6246003)(81166006)(8676002)(476003)(486006)(2906002)(46003)(86362001)(110136005)(8990500004)(10090500001)(33656002)(68736007)(316002)(22452003)(6116002)(6506007)(54906003)(106356001)(10290500003)(71200400001)(71190400001)(478600001)(14454004)(4744005)(86612001)(105586002)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0140;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Xc1Z7KRpVraiMrVCabJvTsSY4JKLli0v2NZAMGZcgTrLSUxUhngjz9v0yO1a8wbZ62elWuFGgZjdSf1kGE3Jwnje4+HaT6Hl1QdrWp+NI39GLqE1yy2rWL3CzxwsyaB3V2pQ1AMbJmcSzgSErxq72i6d3wUZ8VwCMpWd9XorElFQP7w66ar8lmIVoLl7GLrrIWBuwbMVycYGrbz3674o9GwvN9W9YQAWt45jXP7qT6FZOZ+euDEMZtCGXFS9Ac/vqwHHqfi944tp3nqwfciXhAUx4nt2kIieJo0ktPqPdt/FxDp7Euz9+ed8uXRlD0XXTsVS/2XSDPumWaPN4IZk6m5HzBYXeIBJ7YFJ7fst5v/cjjq7gzbxgY/UpCyn+K/QMSkZpPuKbAne9GAvAJ0islejhn4UfX/5suAu27SokLQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0678effe-0566-4189-f3c4-08d68a6409aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2019 05:45:57.7977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gU2VudDog
U3VuZGF5LCBGZWJydWFyeSAzLCAyMDE5IDExOjI5IEFNDQo+IC4uLg0KPiBSZWNlbnQgZml4ZXMg
dG8gY29tbWFuZCBoYW5kbGluZyBlbmFibGVkIExpbnV4IHRvIHJlYWQgbGFiZWwNCj4gY29uZmln
dXJhdGlvbnMgdGhhdCBpdCBjb3VsZCBub3QgYmVmb3JlLiBVbmZvcnR1bmF0ZWx5IHRoYXQgbWVh
bnMgdGhhdA0KPiBjb25maWd1cmF0aW9ucyB0aGF0IHdlcmUgb3BlcmF0aW5nIGluIGxhYmVsLWxl
c3MgbW9kZSB3aWxsIGJlIGJyb2tlbiBhcw0KPiB0aGUga2VybmVsIGlnbm9yZXMgdGhlIGV4aXN0
aW5nIG5hbWVzcGFjZSBjb25maWd1cmF0aW9uIGFuZCB0cmllcyB0bw0KPiBob25vciB0aGUgbmV3
IGZvdW5kIGxhYmVscy4NCj4gDQo+IEZvcnR1bmF0ZWx5IHRoaXMgc2VlbXMgbGltaXRlZCB0byBh
IGNhc2Ugd2hlcmUgTGludXggY2FuIHF1aXJrIHRoZQ0KPiBiZWhhdmlvciBhbmQgbWFpbnRhaW4g
dGhlIGV4aXN0aW5nIGxhYmVsLWxlc3Mgc2VtYW50aWNzIGJ5IGRlZmF1bHQuDQo+IFdoZW4gdGhl
IHBsYXRmb3JtIGRvZXMgbm90IGVtaXQgYW4gX0xTVyBtZXRob2QsIGRpc2FibGUgYWxsIGxhYmVs
IGFjY2Vzcw0KPiBtZXRob2RzLiBQcm92aWRlIGEgJ2ZvcmNlX2xhYmVscycgbW9kdWxlIHBhcmFt
ZXRlciB0byBhbGxvdyByZWFkLW9ubHkNCj4gbGFiZWwgb3BlcmF0aW9uLg0KPiANCj4gRml4ZXM6
IDExMTg5YzEwODlkYSAoImFjcGkvbmZpdDogRml4IGNvbW1hbmQtc3VwcG9ydGVkIGRldGVjdGlv
biIpDQo+IFJlcG9ydGVkLWJ5OiBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCg0K
SGkgRGFuLA0KVGhhbmtzIGZvciB0aGUgcGF0Y2ggYW5kIGFsbCB0aGUgZGV0YWlsZWQgZXhwbGFu
YXRpb24hIFdpdGggdGhpcyBwYXRjaCwNCnRoZSAiZnNkYXgiIG5hbWVzcGFjZSBjYW4gYmUgcHJv
cGVybHkgZGV0ZWN0ZWQgbm93IQ0KDQpUaGFua3MsDQotLSBEZXh1YW4NCg==
