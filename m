Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488632-2-10064730950146930275
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
    t=1520488631; b=brcZ/2bDPVltYv0rfPu6Ze48RP9y4PjZqo5PA3AEpYA7pZc
    tV3DYoTA5KXO4sztd71o6SZvzXTnH2dqxCPovrKxGPL9tyAHSM6G4y9GYj2ZHwWy
    58GzscIJX6z60Ao5vnX2iohtZc8vHOP7i8sBZeHwfCn0oj1Gy5/QtM53C2MpNe+/
    Yx1l1ZFKhZhgS7abELX0NFBtCrSzyjjbgxkfHrm9Olje7RU0maTBY6Bupe8KfHD3
    1ZJ3njaoSlDy1Rhc/E3wRTqJR7LGEwN3entz70+j5VZ0C6Pb3t/cUmhPPHzgM2SN
    zH4pWkzcgV3tJnoyyX8g7RVzEjx+Xvv/TFgyltQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488631; bh=xHIgHV
    I1y8QhxiDal2TGB+Y75gZ0NupwD4yUXk7tyN8=; b=pzEOCRRoZMXr0xxtK2YhnQ
    mEBwT86FIhJRjqXTudLo/ON9BTnL+ddyGHsv57cNVJ6aSpSr8diUJpLNbyazxR1f
    Ki0GPwSseyq10kTI8y8esBMUGdMCFmjJ1GSGPsVLxfFxaDnLGvLnq2acozpNS9b1
    dFyF8UN+j1DLPvJ+qxEtHMpqtUuOisTmnYzVGBmUQqPh2WkMBCSbF8j7jSKKqS0F
    zSbSDIyjcLlhfEbZK5EJkAZ4XkqReu+Rn8B9kstsvI5YLZ23aIqAlmYGfOPk8s0k
    j8VgHxMXbdvQMYlNvTGLLpLayBr+m2XLGtMatt7/XwbRhWrq87vkkFP9Ky6fTl4w
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nTCMs5y1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nTCMs5y1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966365AbeCHF4u (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:56:50 -0500
Received: from mail-sn1nam01on0117.outbound.protection.outlook.com ([104.47.32.117]:16747
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966024AbeCHFDa (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:03:30 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Maksim Salau <maksim.salau@gmail.com>,
        Bernie Thompson <bernie@plugable.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 138/190] video: fbdev: udlfb: Fix buffer on
 stack
Thread-Topic: [PATCH AUTOSEL for 4.9 138/190] video: fbdev: udlfb: Fix buffer
 on stack
Thread-Index: AQHTtppLJVr87vVctUi4p6OGmgub7g==
Date: Thu, 8 Mar 2018 04:59:52 +0000
Message-ID: <20180308045810.8041-138-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1013;7:YWVUnI2X7fGNER2ENKkj2Va23LCQQS1tz+w9d2IwnIhZo44yf3Oxim/vzAbsXt0EIVkUIyiDdgmK+nmC3M5yRsokTqbHmqhfBAqNfNRFUP6q1aoG7WB/C/n4lCQK142navDKXyvDi4m8EFqAaQfrTPuhZUwIusiViEXM0L5llNTOCGQCL1i/pvLPqhzIFFyhMac88aYboSfgB48sqfQflx5xEbd2redOYtw6k/1QrNgGm/R2n4pBV2zPLka6U86N;20:QPNyBZsaJnm/k38JVaJAA98D2LU4REu7/YUId4WfRVYwW3hwl4YZTn5kg5WB73QFGexrPjsBNgAbgHJPY8HbdLCiO3GCToekgutgCuGAE8sFWeT2oGcAv1zwen5XH4UhIoDQsf7bgatLqj0IHFXSGmwTEqZfa44k/hraOh28HUY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f5c0101-9650-4236-b502-08d584b1e7bc
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1013;
x-ms-traffictypediagnostic: DM5PR2101MB1013:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10131A645B4A1A40C4121229FBDF0@DM5PR2101MB1013.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1013;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1013;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(76176011)(6506007)(107886003)(6486002)(22452003)(105586002)(2950100002)(6436002)(26005)(99286004)(53936002)(6666003)(97736004)(36756003)(3280700002)(102836004)(5660300001)(2501003)(68736007)(6512007)(186003)(2900100001)(59450400001)(106356001)(3660700001)(4326008)(2906002)(25786009)(5250100002)(14454004)(7736002)(10090500001)(66066001)(3846002)(305945005)(6116002)(316002)(10290500003)(478600001)(86612001)(8936002)(39060400002)(54906003)(72206003)(8676002)(86362001)(81166006)(110136005)(1076002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1013;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ZzsA7rnNiSq3zkDZOFkXL2OnwIZZFAh31Pke86h2v6HPVygKPQAEZ6StICFmYUFEwoutSWfvk7YPIUZE0ORg/bK1qn0VLXpQ1dsuYZ0i0kboSgW+Oa4r5rIcbMAsYTpcXmS5RpPu6H/KPihuOCmx6aBh218uPBcv8PhwHM5Mt/XKaznyRF7I5AH79o51qmYmw8xgERKQcgH2G0N7NLMq+JNRZIvwQ9FzfsM3A0kD9uaM+y4Hs5bNRYX/d48QBumCs8SxZ5hsxoHzCilHaCxxnpEXxv6ktWjqY75iW85OFdDJO/rZuSShBc45AcyR3sseLEp0JJm3grYPWtHEe+RQ9Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5c0101-9650-4236-b502-08d584b1e7bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:52.7452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1013
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
