Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486944-2-12710791510950631067
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520486943; b=pgHfw1jG2KkixEg9XNslnHepb3jfaSkejLZbKKA/9Tn9iPt
    ikWzGxDGj2I6ZFr4LYv/jip6qviE6/AIegK6HK156NV5A/ElfrDztYbOteADKEd4
    a8w/2NSkTf+jxqNrwXIHTBq3m54rm0lHJtcE9M/tROJ8k5sTMXlCy+ByexqNCtp7
    nLmbuS83hYLr0FkC79oAwcnwMEvWAG/ETUWVjNqN+JfNOr81l/tPkXfPPiFijMMH
    EoJ3ua0REGNYm7K7u7QUP/wPXnCzvHk+qc5eo7I5mzin1PNixMhm8pCiJxLcXlex
    H5xZm1JckIDXA7CoEhiXGY0PLUo7elTnK/uIBWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486943; bh=xHIgHV
    I1y8QhxiDal2TGB+Y75gZ0NupwD4yUXk7tyN8=; b=Qzw/ND57Jr2FQwzDo99CsB
    wMDk8zyjCLHG9a2ZIyMqaVu4LlD3OYeApphYXlenE6vkJYV3rluhACigbqHc9On1
    pG5sKDDI0DIYRvOvHIpiF+IcwWH68bQjnMsfJkiMD6+NAfgluChtVqld0QWHvoBA
    HJ75xQ5MEB9OzSA06W1VS1vwAhh3CLuq/4nJDLrFkVUryju8Anevm4adLTEo1y8F
    kwmJ7/jiXcOzQZGPWgyQYPbWFHMPQ6ltQmLe9x3e51l3r0rWRWHV4TG1Adkz+Qvd
    cdpbLAptSAKTVtMfFdeikf4M8t5LR2f4ndVbu1jE0QpE0SBjPnljnpXNm0SjrK4A
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kI0edsLc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kI0edsLc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750728AbeCHF2c (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:28:32 -0500
Received: from mail-cys01nam02on0114.outbound.protection.outlook.com ([104.47.37.114]:25064
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966506AbeCHFHC (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:07:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Maksim Salau <maksim.salau@gmail.com>,
        Bernie Thompson <bernie@plugable.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 071/101] video: fbdev: udlfb: Fix buffer on
 stack
Thread-Topic: [PATCH AUTOSEL for 4.4 071/101] video: fbdev: udlfb: Fix buffer
 on stack
Thread-Index: AQHTtpqY2Wgf9CgCdkCwlwuNyYDMqA==
Date: Thu, 8 Mar 2018 05:02:01 +0000
Message-ID: <20180308050023.8548-71-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1016;7:iEF5XIL71gLwm/fgRIV3dL8SgZUnarFfPohitLdwVvYcFDMj8XXEmQk/eHeFGp2tO1wDve38YRb3rlmF/5Rh48B4iT+C1ARDPy7vxeilwDmcUFaEyjUl6M5XryZpXffv/8vrizbtadgbpovVzd9s/3S6lxF9Xt1A2ghIH8uo8wXe05O5UfOJNDVBXGUcvJRqxMi3U7ps9Mw8qkGFVXCdA85mD/N4hWJISpBoki1lBdShTeNTEleoiwP0BWw0fl60;20:31ds7tMJtnxPmUr9TUud/y/6cupOFDZ75x31W81jmUhF3Y3LHT2CZLO0sSHbaJRzD+G74Cs35etrmXLug/pEZfgR4eQXPKjJ5OQPVtvTjje37W3nK/G2Qm0OV3TT+N69nu/FYVTgHbLKIplxgGR0fiQQzfTcd6JKi7jiDibvKZE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9face023-5706-45dd-8ea6-08d584b26cb0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1016;
x-ms-traffictypediagnostic: DM5PR2101MB1016:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1016657E95DF4BCB30FCD7CBFBDF0@DM5PR2101MB1016.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1016;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1016;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(366004)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(3660700001)(10290500003)(14454004)(25786009)(478600001)(53936002)(5660300001)(6436002)(6486002)(68736007)(39060400002)(110136005)(54906003)(316002)(6512007)(105586002)(22452003)(3280700002)(2900100001)(3846002)(6116002)(72206003)(4326008)(2906002)(59450400001)(6506007)(102836004)(86612001)(1076002)(36756003)(76176011)(26005)(186003)(107886003)(2950100002)(7736002)(97736004)(8676002)(99286004)(5250100002)(8936002)(81166006)(81156014)(86362001)(305945005)(2501003)(66066001)(106356001)(10090500001)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1016;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: rRR+cTkadz7RfhbOVL9N4hmJN2JIdcmIY+DDptsSxL0xul2GlIR/7tXr7cIUyYe5BQ3+eYslrKhgSIM1+Trx3ZMBPqPRxFHtxtoDUunA90Wnu8HPRIYMA0t5XaLWAj4O2Sxbk2N4BlFVVsz5CmoLvbK8gUYdhBtK2hmr1vgr0YmhQjfth1epU4ze9mP85pArC86PsZrqYzUm7BJ0yoptZxY+JovLY5yFweBWMs7ddJhkyQQcZM46ALNkimsJVamIftpasAx7D2f65uRXcddqO9fEqbvQV1aqxskXsXG8RTq1jGra2jyjgBLJYZY7W5QsNeWKZfpgUaAClMbXKd9ruQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9face023-5706-45dd-8ea6-08d584b26cb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:01.8185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1016
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Maksim Salau <maksim.salau@gmail.com>

[ Upstream commit 45f580c42e5c125d55dbd8099750a1998de3d917 ]

Allocate buffers on HEAP instead of STACK for local array
that is to be sent using usb_control_msg().

Signed-off-by: Maksim Salau <maksim.salau@gmail.com>
Cc: Bernie Thompson <bernie@plugable.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/video/fbdev/udlfb.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 53326badfb61..2add8def83be 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1487,15 +1487,25 @@ static struct device_attribute fb_device_attrs[] =
=3D {
 static int dlfb_select_std_channel(struct dlfb_data *dev)
 {
 	int ret;
-	u8 set_def_chn[] =3D {	   0x57, 0xCD, 0xDC, 0xA7,
+	void *buf;
+	static const u8 set_def_chn[] =3D {
+				0x57, 0xCD, 0xDC, 0xA7,
 				0x1C, 0x88, 0x5E, 0x15,
 				0x60, 0xFE, 0xC6, 0x97,
 				0x16, 0x3D, 0x47, 0xF2  };
=20
+	buf =3D kmemdup(set_def_chn, sizeof(set_def_chn), GFP_KERNEL);
+
+	if (!buf)
+		return -ENOMEM;
+
 	ret =3D usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, 0),
 			NR_USB_REQUEST_CHANNEL,
 			(USB_DIR_OUT | USB_TYPE_VENDOR), 0, 0,
-			set_def_chn, sizeof(set_def_chn), USB_CTRL_SET_TIMEOUT);
+			buf, sizeof(set_def_chn), USB_CTRL_SET_TIMEOUT);
+
+	kfree(buf);
+
 	return ret;
 }
=20
--=20
2.14.1
