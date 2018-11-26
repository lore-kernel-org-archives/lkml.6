Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD8EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A08208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AULWr3Pc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A08208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbeK0H5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:57:49 -0500
Received: from mail-eopbgr1320091.outbound.protection.outlook.com ([40.107.132.91]:54432
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727234AbeK0H5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:57:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCDoT32HaPgqlVo/OP2cmn5IdGbUYp88HSHabJbnbo0=;
 b=AULWr3PcIljFk+umAJj/sQxmNSmf9bE2ydzM7K2our8/Fv2N867WXMRhqeXoDGsm6v0cu9vU646SzxlvDlyQNp06imowcRPnfN15JfqAVr2UvoeBS8YYsaDlgbJQlooWYWubmTc4QJDWfaAH7vISotO+OTkmRom8A+T/YB6AcNY=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0170.APCP153.PROD.OUTLOOK.COM (10.170.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.3; Mon, 26 Nov 2018 21:02:20 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3d50:29f2:1244:8b4b]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3d50:29f2:1244:8b4b%8]) with mapi id 15.20.1404.002; Mon, 26 Nov 2018
 21:02:20 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Sasha Levin <sashal@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 1/2] Drivers: hv: vmbus: check the creation_status in
 vmbus_establish_gpadl()
Thread-Topic: [PATCH 1/2] Drivers: hv: vmbus: check the creation_status in
 vmbus_establish_gpadl()
Thread-Index: AQHUhW3RlYtortOYlEO7A2u32Gmm3aViiu0A
Date:   Mon, 26 Nov 2018 21:02:19 +0000
Message-ID: <PU1P153MB0169EA984A78A3DAE518AF30BFD70@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <20181126022958.11320-1-kys@linuxonhyperv.com>
 <20181126095254.824D420672@mail.kernel.org>
In-Reply-To: <20181126095254.824D420672@mail.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-11-26T21:02:15.8234675Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:a:c89a:7a8:d1d9:2c8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0170;6:vb6f+3sExTOFRIOm4faBTkcwb7OYI8d9j6o/2FiL3Ho60Ix8MrMU5j5vZ0i0K99aAly6MypB07Vq4Vm+cG4lzWPazUj2DNF5e1cJa0Wexv/ZiRCCkzJ7qnYoqn380F8/56V1uY0bQbbU5NAzEIDu+xAAUWeWUeoWPnmMOAoXeBz5qOVzGqjpO/4jsFep7MvhTvrcLQPtliA0liclF0xRjU7eLs7iuRjrMztJAyl5vSaxvCsI1QrePp3UsR+3Q4PfRBGgtBFF43zvSlD98+AbUGP5M0kWL1E83IRYqJz9jFWa1LK79nljD/TW9gDAsz0yBRJOJ1t1QtIldZJ1kxeGOFdgclt5WLR5NLMQ2bu8Rj/tBedWH+0awZkobSEtMgvqphj6LqIz3Of6UKXGAio+lKhozcWb34fw3AHXOXmStysyhB4f/EG7nR/WAUuQEyw299EE+BrPkqyiTvpmCwn0Hw==;5:9dx6V/U1gGFU/EpdOw9UiGZDUxK+d2B7+mKfcaTh1zciHL6KwyETzGaSbTZ0emD6wUq0OB+3roKdhxC5rINeppnKvM6sMZEYJ7BeaJRiSxq9BzGmT96J5NnU56eXhQ9IgpqUpf/RbPlhXiW4Jn4fSUjzCvWf054KhQIPNGa0mt8=;7:Mc3HyrbLaiWVAhoQOTEsuW8V9mkcEUsIhGDv4ftTPaXVdqjG+tPShlfoaGM8/BVMJtSFPu9AGt880a/LOawuAUunr+RbISZ2rUH12psbYy1fScJLf3t+4p659lyz7bEEP0VQ+XPE6efwWuUhzXGmkQ==
x-ms-office365-filtering-correlation-id: 5f610d80-0212-449b-f435-08d653e27471
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(49563074)(7193020);SRVR:PU1P153MB0170;
x-ms-traffictypediagnostic: PU1P153MB0170:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-microsoft-antispam-prvs: <PU1P153MB01705B572358605B538B2AA0BFD70@PU1P153MB0170.APCP153.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(8220035)(2401047)(5005006)(8121501046)(3231443)(944501421)(4983020)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:PU1P153MB0170;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0170;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(346002)(366004)(39860400002)(376002)(189003)(199004)(86612001)(10090500001)(99936001)(102836004)(305945005)(6506007)(486006)(14454004)(256004)(5660300001)(5024004)(110136005)(46003)(316002)(33656002)(8936002)(54906003)(68736007)(7696005)(99286004)(2501003)(76176011)(74316002)(81156014)(81166006)(8676002)(86362001)(10290500003)(2201001)(105586002)(4326008)(6116002)(6246003)(71200400001)(71190400001)(478600001)(476003)(11346002)(446003)(186003)(9686003)(2906002)(6436002)(8990500004)(55016002)(229853002)(53936002)(22452003)(7736002)(106356001)(97736004)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0170;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: c0K3IhuoDwudNRLGB5AY/CAmAnilp59N4IdX68ZT0pIhZbvIxFyB9sfnCaIaIia+6RF5MSyFaAwofI7EzR8ux0fULB1jq3K8o4ub4Nf0bD5WEKwn4AZl75zdrJcLSc5IWirmaxvXgXb59DhwrzoNavbz0rELvKCdP6g7oXGV12q08XU648p2DIWM4Hl7pHqbhr6s4rSIZ9S5CVYc5eZuiuivp5aTcu3Gh7GSQeTaf5KFqXjiTBiLXXtVvNXrynqfYlMtXgH8I3IGMCzqRxood+sssSB3ICKIO7wBIkOJFoFqEHLoNvz4JUq84aEbP0Q2Rg0ODjPCv32y99b1BojhdrsdF8OTJSCjmBHoAk8ibtg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/mixed;
        boundary="_002_PU1P153MB0169EA984A78A3DAE518AF30BFD70PU1P153MB0169APCP_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f610d80-0212-449b-f435-08d653e27471
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 21:02:19.6580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_PU1P153MB0169EA984A78A3DAE518AF30BFD70PU1P153MB0169APCP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> From: Sasha Levin <sashal@kernel.org>
> Sent: Monday, November 26, 2018 1:53 AM
> Hi,
>=20
> [This is an automated email]
>=20
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: all
>=20
> The bot has tested the following trees: v4.19.4, v4.14.83, v4.9.140, v4.4=
.164,
> v3.18.126.
>=20
> v4.19.4: Build OK!
> v4.14.83: Build OK!
> v4.9.140: Build OK!
> v4.4.164: Failed to apply! Possible dependencies:
> v3.18.126: Failed to apply! Possible dependencies:
=20
> How should we proceed with this patch?
>=20
> Sasha

Hi Sasha,
Please see the attached patch, which is a rebase for both v4.4.164 and v3.1=
8.126.

Thanks,
--Dexuan

--_002_PU1P153MB0169EA984A78A3DAE518AF30BFD70PU1P153MB0169APCP_
Content-Type: application/octet-stream;
	name="0001-Drivers-hv-vmbus-check-the-creation_status-in-vmbus_.patch"
Content-Description:
 0001-Drivers-hv-vmbus-check-the-creation_status-in-vmbus_.patch
Content-Disposition: attachment;
	filename="0001-Drivers-hv-vmbus-check-the-creation_status-in-vmbus_.patch";
	size=1770; creation-date="Mon, 26 Nov 2018 20:59:18 GMT";
	modification-date="Mon, 26 Nov 2018 20:59:18 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwMzg0ODFjOGI3NzFiZDIyZTQwY2Q1ZDYyMmRjMTQ3ZDQ4NmI5N2M4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPgpEYXRl
OiBNb24sIDI2IE5vdiAyMDE4IDAyOjI5OjU2ICswMDAwClN1YmplY3Q6IFtQQVRDSF0gRHJpdmVy
czogaHY6IHZtYnVzOiBjaGVjayB0aGUgY3JlYXRpb25fc3RhdHVzIGluCiB2bWJ1c19lc3RhYmxp
c2hfZ3BhZGwoKQoKVGhpcyBpcyBhIGxvbmdzdGFuZGluZyBpc3N1ZTogaWYgdGhlIHZtYnVzIHVw
cGVyLWxheWVyIGRyaXZlcnMgdHJ5IHRvCmNvbnN1bWUgdG9vIG1hbnkgR1BBRExzLCB0aGUgaG9z
dCBtYXkgcmV0dXJuIHdpdGggYW4gZXJyb3IKMHhDMDAwMDA0NCAoU1RBVFVTX1FVT1RBX0VYQ0VF
REVEKSwgYnV0IGN1cnJlbnRseSB3ZSBmb3JnZXQgdG8gY2hlY2sKdGhlIGNyZWF0aW9uX3N0YXR1
cywgYW5kIGhlbmNlIHdlIGNhbiBwYXNzIGFuIGludmFsaWQgR1BBREwgaGFuZGxlCmludG8gdGhl
IE9QRU5fQ0hBTk5FTCBtZXNzYWdlLCBhbmQgZ2V0IGFuIGVycm9yIGNvZGUgMHhjMDAwMDIyNSBp
bgpvcGVuX2luZm8tPnJlc3BvbnNlLm9wZW5fcmVzdWx0LnN0YXR1cywgYW5kIGZpbmFsbHkgd2Ug
aGFuZyBpbgp2bWJ1c19vcGVuKCkgLT4gImdvdG8gZXJyb3JfZnJlZV9pbmZvIiAtPiB2bWJ1c190
ZWFyZG93bl9ncGFkbCgpLgoKV2l0aCB0aGlzIHBhdGNoLCB3ZSBjYW4gZXhpdCBncmFjZWZ1bGx5
IG9uIFNUQVRVU19RVU9UQV9FWENFRURFRC4KCkNjOiBTdGVwaGVuIEhlbW1pbmdlciA8c3RoZW1t
aW5AbWljcm9zb2Z0LmNvbT4KQ2M6IEsuIFkuIFNyaW5pdmFzYW4gPGt5c0BtaWNyb3NvZnQuY29t
PgpDYzogSGFpeWFuZyBaaGFuZyA8aGFpeWFuZ3pAbWljcm9zb2Z0LmNvbT4KQ2M6IHN0YWJsZUB2
Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0
LmNvbT4KU2lnbmVkLW9mZi1ieTogSy4gWS4gU3Jpbml2YXNhbiA8a3lzQG1pY3Jvc29mdC5jb20+
ClNpZ25lZC1vZmYtYnk6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+Ci0tLQogZHJpdmVycy9odi9jaGFubmVsLmMgfCA4ICsrKysrKysrCiAxIGZpbGUgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9odi9jaGFubmVsLmMg
Yi9kcml2ZXJzL2h2L2NoYW5uZWwuYwppbmRleCBkMDM3NDU0Li5iODE1MTZjIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2h2L2NoYW5uZWwuYworKysgYi9kcml2ZXJzL2h2L2NoYW5uZWwuYwpAQCAtNDI0
LDYgKzQyNCwxNCBAQCBpbnQgdm1idXNfZXN0YWJsaXNoX2dwYWRsKHN0cnVjdCB2bWJ1c19jaGFu
bmVsICpjaGFubmVsLCB2b2lkICprYnVmZmVyLAogCX0KIAl3YWl0X2Zvcl9jb21wbGV0aW9uKCZt
c2dpbmZvLT53YWl0ZXZlbnQpOwogCisJaWYgKG1zZ2luZm8tPnJlc3BvbnNlLmdwYWRsX2NyZWF0
ZWQuY3JlYXRpb25fc3RhdHVzICE9IDApIHsKKwkJcHJfZXJyKCJGYWlsZWQgdG8gZXN0YWJsaXNo
IEdQQURMOiBlcnIgPSAweCV4XG4iLAorCQkgICAgICAgbXNnaW5mby0+cmVzcG9uc2UuZ3BhZGxf
Y3JlYXRlZC5jcmVhdGlvbl9zdGF0dXMpOworCisJCXJldCA9IC1FRFFVT1Q7CisJCWdvdG8gY2xl
YW51cDsKKwl9CisKIAkvKiBBdCB0aGlzIHBvaW50LCB3ZSByZWNlaXZlZCB0aGUgZ3BhZGwgY3Jl
YXRlZCBtc2cgKi8KIAkqZ3BhZGxfaGFuZGxlID0gZ3BhZGxtc2ctPmdwYWRsOwogCi0tIAoyLjcu
NAoK

--_002_PU1P153MB0169EA984A78A3DAE518AF30BFD70PU1P153MB0169APCP_--
