Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520486176-2-3576734479425886550
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
    t=1520486175; b=IsE9XkhIlGAxFgRfN3CGLhfQqn0+1TvPdgaO901Xllqbkf6
    UBx+mrJnd8fABwRPYGbsuuNXKXBIj/UOA92LqRocKTc1/k0sRR8xg54hHPq9gP9k
    DXL3T0+IO5W0lNY3E4zLMQByfJiOD5rK5J533XkSF6REhtvvlvO+kz0UsiPjUS2a
    +JYNitzRQ35bI7b2fKX+evc5qvO4ETE0MgcysvG+pN12Da7Yj8HLuzTdLCXcIlmp
    OyIfANE5uXaOhDtEmT2xMlPu5qXRyI16z3O4FlcWivHGFssFMO9oSHHVFS4KwoiY
    8W2akfPvxeq78m93GwrccM/RPkW71hfI28vXwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486175; bh=CCHLoG
    FFdQLnjnwg4HiWRHK3WHZNCHdV1cRHSaC9KpE=; b=KlVCrNukpj4ra6eCEWDYUy
    6DbIzfpV+vrkczv4VdvhyHMAnS6CiN9A89wTD7HC6ucj2vwMZzcCi5Atlmlb19dd
    wHI4+k/TRypb+5nA7pB6/jLb76UhaDBDA1ZS+LR16yHR1DHmiDMUua4xVW4ry/Ny
    BIjm4usbdLOHVLVzEp+4mnOjQNgDf137YevsuL1RKMFFDAP6ZfOyubAYRbJ7esCy
    vs7lOnlUHOT/eOxUMZiDgaQeadsliPo7T3EStPjSKG41r8WrbxALi9ZqXlSXbvd4
    i43zndmmQ4fxs6KWa7dnA6QN4MzcEPt8ABRsbkiSQEN/yVdDVYY88a30NZ/wyY5g
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Wv7a9n8k x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Wv7a9n8k x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966839AbeCHFQA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:16:00 -0500
Received: from mail-cys01nam02on0137.outbound.protection.outlook.com ([104.47.37.137]:8100
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966872AbeCHFLm (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:11:42 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Maksim Salau <maksim.salau@gmail.com>,
        Bernie Thompson <bernie@plugable.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 41/53] video: fbdev: udlfb: Fix buffer on
 stack
Thread-Topic: [PATCH AUTOSEL for 3.18 41/53] video: fbdev: udlfb: Fix buffer
 on stack
Thread-Index: AQHTtprJI989Lt6D6E+pjsDitBu3lw==
Date: Thu, 8 Mar 2018 05:03:25 +0000
Message-ID: <20180308050230.8876-41-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1030;7:CnYz3ODwHMwhx12mCNFjJAJVcUElThr9Kgj2BriCaOXMZWw9jhNzKZAsjX0RIMM7wm84cdgVLbIsv4RTYVecgh2A3Bzcj9xwE9khg4nvWU5RaDa09KxP62DtMu9ipvYRkVNCnqVWAzdVJejkCmFeoseyjVihXVEb7nuwZ7enbwLg6BYE3kOziniyNeQPAfb2OkUuJs8hD0ZiZXbuq6Qwfs6CEp34gan4rFAXx5lvMC4wYYdVyu8sPcli0uH+gAUe;20:wy9Nd9vJxSxTaiBRgoG+WdfWOoKSPq294fgy/5ptIp+mkJKto/pnU4hxAwVCWcOIEAf4FELnuHuksKWFjqstsRyvXyjRi93RQr/xZXZ+EGzXstgz/PpS95y2zFFW8wfLE4vD4QpRqrXgwxBd06P2ZcpmB82NUxi5FnS3zTErQek=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f67cbf91-9ea9-4b43-45fe-08d584b30ff1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1030;
x-ms-traffictypediagnostic: DM5PR2101MB1030:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1030FCC864A1E95C807173A7FBDF0@DM5PR2101MB1030.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1030;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1030;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(5250100002)(316002)(39060400002)(6666003)(6506007)(2950100002)(26005)(76176011)(68736007)(53936002)(6512007)(59450400001)(2900100001)(86612001)(3660700001)(106356001)(10090500001)(99286004)(2501003)(4326008)(14454004)(102836004)(25786009)(97736004)(6486002)(86362001)(36756003)(7736002)(6116002)(2906002)(478600001)(6436002)(107886003)(72206003)(186003)(3846002)(66066001)(81156014)(10290500003)(1076002)(22452003)(305945005)(110136005)(81166006)(105586002)(3280700002)(54906003)(8936002)(5660300001)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1030;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: b5TXEo8cpdyr84uKx4Vhsl86XuVLl2UsYiFUgvCSl1RvyDy8kiKRX3sPRB9fAA6LcyT5187KPcGEM2skwC8Qn4qUdplzTzMAcLbA9rVx+qspETvdCdqsXrxahZDuPtZ9BeY+8cKNYSCiPaF6rUQyCZDNflHywnVvwH422qsUvA5gQ/W4z1LRBeN2tD3+Klfr6wAW1n7X/oRa0EhGrEELj/OhltYW9Q4YJEN5QP5YjYDYq//JcrluXex4zZCp/JTsGfjgRTEb0LxRaLXXQ624/x7tBBgSuxGKP/qO6swFpb6cwGgj7a5d7a1+tPVNTNHqLq4qqaXcAzv+tG9ym2rVbA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f67cbf91-9ea9-4b43-45fe-08d584b30ff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:25.3532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1030
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
index ef7d23bb2e28..868cba997585 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1490,15 +1490,25 @@ static struct device_attribute fb_device_attrs[] =
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
