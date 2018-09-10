Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ADAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65CA2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pi6cYHJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D65CA2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbeIKANa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 20:13:30 -0400
Received: from mail-eopbgr680060.outbound.protection.outlook.com ([40.107.68.60]:60384
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727877AbeIKANa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 20:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DesxbP+PQNoqOyikWG/lwgwxS9YJGVkTSAYnKznQYl4=;
 b=pi6cYHJXgirCGIOdSOG5OVi2Xy+2rJE8UIUU8GzB4CpgfXvxUBRQ/tPPmViaPSZ40oNFKd7fZz/b5DW+PGk5GbnwgfuCm+O0WkWe1ty4X8KYB4m+PSZz0xDL87dBf4LehoPH7tnG0iTKn8Zf0sn8GgyvWKBYW4qeVSBkDRBTpxE=
Received: from CY1PR02MB2138.namprd02.prod.outlook.com (10.166.190.144) by
 CY1PR02MB1119.namprd02.prod.outlook.com (10.163.15.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Mon, 10 Sep 2018 19:17:49 +0000
Received: from CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::d401:dced:c223:a99a]) by CY1PR02MB2138.namprd02.prod.outlook.com
 ([fe80::d401:dced:c223:a99a%4]) with mapi id 15.20.1122.019; Mon, 10 Sep 2018
 19:17:45 +0000
From:   Jolly Shah <JOLLYS@xilinx.com>
To:     Olof Johansson <olof@lixom.net>
CC:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michal Simek <michals@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Subject: RE: [PATCH v11 03/11] firmware: xilinx: Add zynqmp IOCTL API for
 device control
Thread-Topic: [PATCH v11 03/11] firmware: xilinx: Add zynqmp IOCTL API for
 device control
Thread-Index: AQHUK1L7QuzmZ44/ikWDKXlbsDGCKaTnX36AgAK/pTA=
Date:   Mon, 10 Sep 2018 19:17:45 +0000
Message-ID: <CY1PR02MB2138BF2252E1CE2C1747A78AB8050@CY1PR02MB2138.namprd02.prod.outlook.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
 <1533318808-10781-4-git-send-email-jollys@xilinx.com>
 <CAOesGMi7Q9L4oZkUubKtV-m8XD67MQ05ZFhPA_0Hwky_qVUxfg@mail.gmail.com>
In-Reply-To: <CAOesGMi7Q9L4oZkUubKtV-m8XD67MQ05ZFhPA_0Hwky_qVUxfg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JOLLYS@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR02MB1119;6:peWqiyAlnvtlhDNN/Vd6noWveLdWQY81dGb38HXVwOEZvPkyZwZ6oIDZG+wC/rzZkb7pyKnsWfwwKnygbviEM7CsDxYG/9xoHWdBD0kpbh7jcbZMFY0Nk0XtNWpwfZP+VC1CW9KXEOhqwvXXcZGNpB0PvIbnjCHfzndIWfwbevbIsPvrG7otUTc9hoepudxuu1zunab2RRwQdcmza+yw0Fki3AX7WPeVYhVTeWL/rBVyLT30HPo/O022JA0FPvtTcs9Df4qyZ1uwzydi9tHth5EuqmGAyQjumYlxDhnC5iSYHkz5cEKSxs5KJazuwCNZp6YEmGcQ2i3BdO5Qag9CjyFRljQLuBOCGM+fnRDtkg2gY9fekHhgOpNbyqQjJIYUNayQGX22LcBhfJG5OQEnTu2MmjxjwfxYvyqv/YrlZSP/D+6vzQR0O+2h5XBvZmmCT95ikLGUJY+fZ9lOFk1oJQ==;5:lWFQUU1Ml4TAzooAUrCHVtkvoam7jt5O0dFUAFv9eDL+3PRAA9j4apc8DAFPrVggifi67dPkUpRistegU2t5Ng7FlC5Otzdwm6eesYrOtwQ5+OOVyEbpUnJ5vBC2siWScqcRJ90N46Ql0koIQNV6SSiZU+XYZJY1YJgu9MrlNaM=;7:XXjlkYLc30o7/NpUhbs+djMLjKeSQflCljQ4cg2RP2+Na4Gbe7XpVt/Ra7jyNmkd6JAm+UkHWNmPaF4QEShJlVlxx+DpPOPWhlVN91p7k0TziFh0zfdnMyTvEWcQZwANwdA3bQJ62Njr9I/MNj84cEFiZBb8hZDnm1yFmdxAt4L3Pzx52KQurf2mH0CMykxtW972XojEkfRhmT6iiB1qWg90ZSizvVInU4qzPYlhR/WQqtNpe07sT7n+IWrS+/Sh
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(396003)(136003)(346002)(53754006)(13464003)(189003)(199004)(74316002)(2900100001)(316002)(305945005)(8676002)(53546011)(6506007)(33656002)(53936002)(81166006)(76176011)(81156014)(68736007)(2906002)(7736002)(54906003)(186003)(6116002)(3846002)(106356001)(105586002)(8936002)(486006)(99286004)(7696005)(102836004)(26005)(11346002)(446003)(229853002)(66066001)(476003)(72206003)(9686003)(39060400002)(5660300001)(6246003)(25786009)(4326008)(86362001)(14454004)(5250100002)(7416002)(478600001)(97736004)(6436002)(55016002)(6916009)(256004)(14444005)(217873002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1119;H:CY1PR02MB2138.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 469a16c3-d6ee-42df-ffbd-08d617521699
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR02MB1119;
x-ms-traffictypediagnostic: CY1PR02MB1119:
x-microsoft-antispam-prvs: <CY1PR02MB111966B66FAB0ED914F1FE37B8050@CY1PR02MB1119.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(192374486261705)(9452136761055)(85827821059158)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:CY1PR02MB1119;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1119;
x-forefront-prvs: 07915F544A
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 15wzZ8qcxeJ2lt1eRB71mkYVUw2ePohXvN9r1OA4o6ntY+OE+T4t6/SXQd8oM2IdbDxawVyQ3iR4OpmOmHAEizoAeGXuMcXvDMjYdul6fNEKGZ6UQw+ZKts4JOrMr4gi5YYJ0HDUIEoWZmHJ0/VPljEZq6tX9tFWDPOvVy40KFpjmJjX0tvN9aO+tZLrZNm2YR99jDNvPF4vk4ccA9grQ44iHbIpMQiOlcfm5+C0EN2uXiTopifndeYwAW+TlS7TUXpmqr6WHEvEA57TpkNj4+AHpFKEz+JH3/RxFPGHsSZeOXR3rLj4MZ3vfVsxefKG3n6FRjRmR3mG69ZJYUY9hfmjzrjP8lzG1EMtmBn8UfU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469a16c3-d6ee-42df-ffbd-08d617521699
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 19:17:45.2202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxsLA0KDQpBZGRpbmcgbW9yZSBjbGFyaWZpY2F0aW9uIG9uIHRvcCBvZiB3aGF0IE1pY2hh
bCBzYWlkOg0KSGVyZSBpb2N0bCBpcyBub3QgYSBzeXN0ZW0gaW9jdGwgYW5kIGp1c3QgYSBlZW1p
IEFQSSBsaWtlIG90aGVyIGludGVyZmFjZSBBUElzLiBJdCBjYW5ub3QgYmUgY2FsbGVkIGZyb20g
dXNlcnNwYWNlLiBPbmx5IExpbnV4IGRyaXZlcnMgY2FuIHVzZSB0aGlzIEFQSSBmb3IgZGVmaW5l
ZCBpb2N0bCBvcGVyYXRpb25zLiBUaGlzIEFQSSBpcyBtZWFudCBmb3IgYW55IHBsYXRmb3JtIHNw
ZWNpZmljIG9wZXJhdGlvbnMgd2hpY2ggbmVlZHMgdG8gYmUgbWFuYWdlZCBieSBmaXJtd2FyZS4g
RmlybXdhcmUgd2lsbCBhbHdheXMgdmFsaWRhdGUgdGhlIHJlcXVlc3QgZm9yIGFjdGlvbiBiZWlu
ZyBwZXJmb3JtZWQuDQpEZWJ1Z2ZzIGludGVyZmFjZSBpcyBqdXN0IGZvciBkZWJ1Z2dpbmcgZHVy
aW5nIGRldmVsb3BtZW50LiBXZSBjYW4gcmVtb3ZlIGRlYnVnZnMgc3VwcG9ydCBmb3IgaW9jdGwg
QVBJIGlmIHlvdSBzdWdnZXN0Lg0KDQpUaGFua3MsDQpKb2xseSBTaGFoDQoNCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBPbG9mIEpvaGFuc3NvbiBbbWFpbHRvOm9sb2ZA
bGl4b20ubmV0XQ0KPiBTZW50OiBTYXR1cmRheSwgU2VwdGVtYmVyIDA4LCAyMDE4IDY6MTkgUE0N
Cj4gVG86IEpvbGx5IFNoYWggPEpPTExZU0B4aWxpbnguY29tPg0KPiBDYzogYXJkLmJpZXNoZXV2
ZWxAbGluYXJvLm9yZzsgSW5nbyBNb2xuYXIgPG1pbmdvQGtlcm5lbC5vcmc+OyBHcmVnIEtyb2Fo
LQ0KPiBIYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IG1hdHRAY29kZWJsdWVw
cmludC5jby51azsgU3VkZWVwDQo+IEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT47IGhrYWxs
d2VpdDFAZ21haWwuY29tOyBLZWVzIENvb2sNCj4gPGtlZXNjb29rQGNocm9taXVtLm9yZz47IERt
aXRyeSBUb3Jva2hvdiA8ZG1pdHJ5LnRvcm9raG92QGdtYWlsLmNvbT47DQo+IE1pY2hhZWwgVHVy
cXVldHRlIDxtdHVycXVldHRlQGJheWxpYnJlLmNvbT47IFN0ZXBoZW4gQm95ZA0KPiA8c2JveWRA
Y29kZWF1cm9yYS5vcmc+OyBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGlsaW54LmNvbT47IFJvYiBI
ZXJyaW5nDQo+IDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFu
ZEBhcm0uY29tPjsgbGludXgtY2xrDQo+IDxsaW51eC1jbGtAdmdlci5rZXJuZWwub3JnPjsgUmFq
YW4gVmFqYSA8UkFKQU5WQHhpbGlueC5jb20+OyBMaW51eCBBUk0NCj4gTWFpbGluZyBMaXN0IDxs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGlu
ZyBMaXN0DQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgRFRNTCA8ZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc+OyBKb2xseQ0KPiBTaGFoIDxKT0xMWVNAeGlsaW54LmNvbT4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MTEgMDMvMTFdIGZpcm13YXJlOiB4aWxpbng6IEFkZCB6eW5x
bXAgSU9DVEwgQVBJIGZvcg0KPiBkZXZpY2UgY29udHJvbA0KPiANCj4gSGksDQo+IA0KPiBPbiBG
cmksIEF1ZyAzLCAyMDE4IGF0IDEwOjUzIEFNLCBKb2xseSBTaGFoIDxqb2xseS5zaGFoQHhpbGlu
eC5jb20+IHdyb3RlOg0KPiA+IEZyb206IFJhamFuIFZhamEgPHJhamFudkB4aWxpbnguY29tPg0K
PiA+DQo+ID4gQWRkIFp5bnFNUCBmaXJtd2FyZSBJT0NUTCBBUEkgdG8gY29udHJvbCBhbmQgY29u
ZmlndXJlIGRldmljZXMgbGlrZQ0KPiA+IFBMTHMsIFNELCBHZW0sIGV0Yy4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFJhamFuIFZhamEgPHJhamFudkB4aWxpbnguY29tPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEpvbGx5IFNoYWggPGpvbGx5c0B4aWxpbnguY29tPg0KPiANCj4gVGhpcyBwYXRjaCB3
b3JyaWVzIG1lIHNvbWV3aGF0LiBJdCdzIGEgdHJhbnNwYXJlbnQgcGFzcy10aHJvdWdoIGlvY3Rs
IGRyaXZlci4gSXMNCj4gdGhlcmUgYSBzcGVjIGF2YWlsYWJsZSBmb3Igd2hhdCB0aGUgaW1wbGVt
ZW50ZWQgSU9DVExzIGFyZT8NCj4gDQo+IFNob3VsZCBzb21lIG9mIHRoZW0gYmUgcHJvcGVyIGRy
aXZlcnMgaW5zdGVhZCBvZiBhbiBvcGFxdWUgcGFzcy10aHJvdWdoIGxpa2UNCj4gdGhpcz8gQ291
bGQgc29tZSBvZiB0aGVtIGhhdmUgc3RhYmlsaXR5IGltcGFjdCBvbiB0aGUgcGxhdGZvcm0gc3Vj
aCB0aGF0IHRoZXJlDQo+IGFyZSBzZWN1cml0eSBjb25jZXJucyBhbmQgdGhlIGxpc3Qgb2YgYXJn
dW1lbnRzIHNob3VsZCBzb21laG93IGJlIHNhbml0aXplZD8NCj4gDQo+IFdoYXQncyB0aGUgaW50
ZW5kZWQgdXNlY2FzZSBhbnl3YXk/IEp1c3QgYSBkZWJ1ZyB0b29sIGR1cmluZyBkZXZlbG9wbWVu
dCwgb3INCj4gc29tZXRoaW5nIHRoYXQgeW91IGV4cGVjdCBoZWF2eSB1c2Ugb2YgYnkgc29tZSB1
c2Vyc3BhY2UgbWlkZGxld2FyZT8NCj4gDQo+IA0KPiAtT2xvZg0K
