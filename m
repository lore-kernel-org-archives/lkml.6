Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF52C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8B020831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SKWX0rUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C8B020831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392575AbeKVR7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:59:05 -0500
Received: from mail-eopbgr40057.outbound.protection.outlook.com ([40.107.4.57]:49833
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392564AbeKVR7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7ysfWPXSO/H8+uqceuQ/h3IBEmZjOv8RE2vg6AKTXE=;
 b=SKWX0rUqTp0OeEk0xWIoDbJ8CcI1WNt+Ck9UdEbx3RAA8enOu81VNChLDaE14gt12F7tgTnEb9WHNH1d7CtOVLuViLFHZpePLOOiE39pb/aYm8vN4sllN/XtUTnKJ2OnCppks11HhQxgcpbGreW6EE7kgc+MlKiI7t1vyI8VWAM=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2756.eurprd04.prod.outlook.com (10.175.41.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Thu, 22 Nov 2018 07:20:54 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::600c:8cd7:5992:a3d9]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::600c:8cd7:5992:a3d9%5]) with mapi id 15.20.1361.016; Thu, 22 Nov 2018
 07:20:54 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RESEND: About VBUS glitch happen on DWC3 host mode enabling process.
Thread-Topic: RESEND: About VBUS glitch happen on DWC3 host mode enabling
 process.
Thread-Index: AdSCM8MvCI7yckQaSlCgunl/AtiROw==
Date:   Thu, 22 Nov 2018 07:20:53 +0000
Message-ID: <AM5PR0402MB2865186039501C213CB19C1DF1DB0@AM5PR0402MB2865.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2756;6:I0aTqcQis5nPbI0cz6GCyfevmA5mFrXsdovnFWJ86TTFXy3Qwmx9JlqaQwLF4qAHmgEJJyUTAoBgCYrDjDy4/w6+MX4GNLoZOf1dybg7aZ62a67z8ngKzKq7TOf1T8o4mWsEPjd3Y0d1tzpMNHP3Jw1TVKbU3wo/pcd+UwfLPm2fq5Ro5aOmfTre598rF3T5e70gIWQLfSCMvyTAMMuOkuF/F5l4q5L2AK4Ui20BpXOdiOihz6vuOZqrpTq5Nj5HBp/hai1eFpFMveIm931rOwuEPaf8JBZutjoK+Gl5VAzCku/ZzDM4FErpuDS9zK6P7Q7a+Py5XsTqX87wudtNvXs6+Nx+vwhcRck09OW+HkvR+C5QX57T6w5wYTi6hvLEruc3QcCBY1uMdd4EZ3bZmD/RI2LFyXyE+LSzk5xJATrMGhYbIEGj8yq8k3TmSFbRPtRsCzrj2C+tLvCoh3WN6w==;5:yJr3jkyU0JuBrKr2CW4nCX4q4NjBvpJXVTVfe+MMvAVoDsg/DVJbfeBndxvQiaJtbrClm9i9nqhFxobO74vqi7ms2i5mgEUzHWpnJxrisVK7dtR832e+83w7RQOngemhYdXpG5TJonRClfJAcbwxlEnON5nViq3NaJ3rGvPWQew=;7:21IH770vAmWqkAKB1iyYs5Ce66sFES+OmNnlOR7nkE2Jnn9ZlDSirZzclE3x+7s2/Sns0sPU8Du9V9fd0Fs/9lNPYV6EniT7b271zt/GsI1+kCGBFz61iMY+4e3fF88slc+h+MtdV5iTZeb3aYobfw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6e5dc283-456a-4fdc-bc36-08d6504b0a2d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2756;
x-ms-traffictypediagnostic: AM5PR0402MB2756:
x-microsoft-antispam-prvs: <AM5PR0402MB2756381F3AD714E5B35CDFFEF1DB0@AM5PR0402MB2756.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231442)(944501410)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM5PR0402MB2756;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0402MB2756;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(346002)(366004)(396003)(189003)(199004)(486006)(476003)(81166006)(74316002)(81156014)(6436002)(256004)(99286004)(53936002)(8676002)(4326008)(3846002)(6916009)(97736004)(55016002)(66066001)(478600001)(33656002)(7736002)(86362001)(305945005)(8936002)(6116002)(9686003)(106356001)(105586002)(5660300001)(2900100001)(186003)(71200400001)(71190400001)(25786009)(14454004)(2906002)(102836004)(68736007)(26005)(316002)(6506007)(54906003)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2756;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: pygaoxDYX/GpQWCTPrWxS1XIry41UzM08lBotIEnnPjyiJ411xskzLrJNzxcAARz4jDKWZUhiaz7HNOpxYd7sN07HoomFVMjj/SlUwNR/Bt4ZO26HVPyZLkUnH3xUJ9yaRdO6YALfsedPudD+09Pr9rwLe42lWXhOFKEwO/MQzlS2rb4nm1fvQpNWi3vjDp5FWaDEGYIpNjWl7mG26OQR1W5dd0ULcftJIBier6QyjfyeG50nMuc/ZJ/jOfTakLaCMLxww3ZfXl3zojPGOYbDO836NcDiHlchr0qnqZumi1oWw31/mjYc3wR5Qa7+OBZM1thDja+PT+MwtCnGJYkzbY/t0bAUlBphiLdzSV9GMA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5dc283-456a-4fdc-bc36-08d6504b0a2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 07:20:54.0230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmVzZW5kIHRoaXMgbWFpbCBpbiBwbGFpbiB0ZXh0Lg0KDQpIZWxsbyBGZWxpcGUsDQqhoVdloa92
ZSBmb3VuZCBvbiBzb21lIExheWVyc2NhcGUgcGxhdGZvcm1zIHdoaWNoIGludGVncmF0aW5nIERX
QzMgVVNCMy4wIERSRCBjb250cm9sbGVyLCBWQlVTIGdsaXRjaCBoYXBwZW5lZCBhbmQgY2F1c2Vk
IHNvbWUgVVNCIGRyaXZlcyBlbnVtZXJhdGlvbiBmYWlsLCBsaWtlIHRvIGRpc2N1c3MgdGhlIGRl
dGFpbHMgYXMgYmVsb3cuDQqhoQ0KoaFTdG9yeSBpcyB0aGF0LCB3ZSBmb3VuZCBvbmNlIGZ1bmN0
aW9uIGR3YzNfY29yZV9pbml0X21vZGUoKSBnb3QgY2FsbGVkIGFuZCBlbmFibGVkIGhvc3QgbW9k
ZSBieSBjYWxsaW5nIGR3YzNfc2V0X3BydGNhcChkd2MsIERXQzNfR0NUTF9QUlRDQVBfSE9TVCkg
d2hpY2ggd291bGQgd3JpdGUgcmVnaXN0ZXIgW0RXQzNfR0NUTF0gYml0IDEyfjEzLCBzbyB0aGUg
cGluIChzdWNoIGFzIFVTQl9EUlZWQlVTKSB3aGljaCBjb250cm9sIFZCVVMgZHJpdmluZyBjaGlw
oa9zIEVOIHBpbiB3b3VsZCBiZSBwdWxsZWQgaGlnaCBpbW1lZGlhdGVseSwgc28gZGlkIHRoZSBW
QlVTICh1cCB0byArNVYpLiBUaGVuLCBEV0MzIGNvcmUgZHJpdmVyIGNvbnRpbnVlZCB0byBjYWxs
IGZ1bmN0aW9uIGR3YzNfaG9zdF9pbml0KCktPnBsYXRmb3JtX2RldmljZV9hZGQoeGhjaSmhrSB4
aGNpX3BsYXRfcHJvYmUoKS0+dXNiX2FkZF9oY2QoKS0+eGhjaV9wbGF0X3NldHVwKCktPnhoY2lf
Z2VuX3NldHVwLT4geGhjaV9yZXNldCgpLCB3aGljaCB3b3VsZCByZXNldCB4SENJIGNvbnRyb2xs
ZXIuIEF0IHRoaXMgcG9pbnQsIHRoZSBWQlVTIEVOIHBpbiAoVVNCX0RSVlZCVVMpIHdhcyBwdWxs
ZWQgbG93IGZvciBhYm91dCAxNXVzLCBjYXVzaW5nIHRoZSBWQlVTIGRpZCB0aGUgc2FtZSBkcm9w
IHRvbywgdGhlbiBiYWNrIHRvIG5vcm1hbCB2b2x0YWdlIHdoZW4gSFcgcmVzZXQgY29tcGxldGUu
IFdlIGhhdmUgY29uZmlybWVkIHRoaXMgd2hvbGUgcHJvY2VzcyBhY2NvcmRpbmcgdG8gc2NvcGUg
d2F2ZWZvcm0gd2l0aCB0ZXN0IGNvZGUgb24gRFdDMyBkcml2ZXIuIEltcGFjdCBpcyB0aGF0IFZC
VVMgZ2xpdGNoIGhhcyBsZXQgc29tZSBVU0IgZHJpdmVzIChzdWNoIGFzIFRyYW5zY2VuZCA0R0Ig
VVNCMi4wIChqZXRmbGFzaCkgYW5kIEtpbmdzdG9uIDE2R0IgVVNCMi4wIERUR0U5KSBtYWxmdW5j
dGlvbiBkdXJpbmcgZW51bWVyYXRpb24gKHBhcnRpY3VsYXJseSBoYXBwZW4gd2hlbiBkcml2ZSBp
cyBjb25uZWN0ZWQgdG8gcm9vdC1odWIgcG9ydCBwcmlvciB0byBMaW51eCBib290KS4NCqGhDQqh
oVBlciBteSB1bmRlcnN0YW5kaW5nLCBWQlVTIG5lZWQgdG8ga2VlcCArNVYgb25jZSBlbmFibGVk
IHdpdGhvdXQgYW55IGRyb3AvdW5zdGFibGUuIEFuZCBhYm92ZSBnbGl0Y2ggbG9va3MgbGlrZSBj
YXVzZWQgYnkgdGhlIGdhcCBiZXR3ZWVuIERXQzMgZGVzaWduIGFuZCBkcml2ZXIgaW5pdCBwcm9j
ZWR1cmUuIA0KoaENCqGhT25lIG9mIHByb2JhYmx5IHdvcmthcm91bmQgY29tZSB0byBteSBtaW5k
IGlzIHRvIHByb2dyYW0gYWxsIHJvb3QtaHViIHBvcnRzoa8gUE9SVFNDW1BQXSB0byAwYiBpbW1l
ZGlhdGVseSBhZnRlciBlbmFibGluZyBob3N0IG1vZGUgKGNhbGxpbmcgZHdjM19zZXRfcHJ0Y2Fw
KGR3YywgRFdDM19HQ1RMX1BSVENBUF9IT1NUKSksIHNvIFZCVVMgd2lsbCBrZWVwIDBWIHRpbGwg
eGhjaSBpcyByZXNldCBieSB4aGNpIGRyaXZlciBsaWtlIGFib3ZlLiBJIGhhdmUgdGVzdCB0aGlz
IGFuZCBpdCB3b3Jrcy4NCqGhDQqhoUkga25vdyBpdCBpcyBub3QgYW4gZ29vZCBmaXggYmVjYXVz
ZSBEV0MzIGNvcmUgZHJpdmVyIHdvdWxkIHRvdWNoIHhIQ0kgY29udHJvbGxlciB3aGljaCBvdWdo
dCB0byBiZSBoYW5kbGVkIGJ5IHhIQ0kgZHJpdmVyIGluc3RlYWQsIHNvIGxpa2UgdG8gc2VuZCBv
dXQgdGhpcyBtYWlsIGZvciBkaXNjdXNzaW9uIGZpcnN0LCBzZWUgaWYgYW55b25lIGhhcyBiZXR0
ZXIgc29sdXRpb24gb24gdGhpcyBpc3N1ZS4NCqGhVGhhbmtzIGZvciB5b3VyIHRpbWUuDQoNClJl
Z2FyZHMsDQpSYW4NCg==
