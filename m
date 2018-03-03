Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120442-2-12815880452843898225
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520120441; b=weco2DKii2n4yxXIYkOHCe/vFaCG+JsEhXo73y38Pgwwhcv
    KEAWMWD8V3uv8/R7Hv5PQaFv5XASoVA1x9DyapJ9O0SjsEqIQACCvlO3wAQgytaz
    +gT0jp9hkmOb77sJYHxWjc6GXZ51s6Z0EIEnx2EbYIty5ZO2ehHgyc8sFF6YLD3U
    7Ju7dmph7ZPOg5knoSKUxYGyh5yCsZ1GtAbw2DUMXEOJnwXfE/6i6c88RCzH+YQl
    oZzeEkN+iuSdQaFz6w+ejpb7sz04fCqsQ6W5oiEizqdQxlC5edm0EgPup4uehIWg
    N7S/4URwdyIsrFg4iLZLY2aFKDxmFwRdnFK8e3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120441; bh=Ur6i+H
    ZQyI4I/Um0jfqCnKfsg6KcGiehYsSmY8lXabw=; b=su3VpoXtzAvKhq6g8G46KS
    dP9dRz5kHIDeHnMJ4tOxFpqAk/urshhizWKpdilYhkyCEh0GS8jA1ONJjzzeGS9x
    LDbBcHpDk6bSpihwO3L7G/CRLYcYzR7o4I2k8KAG0freZMBVRKtGLwRkW34/RNDC
    yLKXQkFLLPV+6Mj7dH4SO+FfTRkNNTiyOMRkOmSOl3N5148EE2T2vVNPEE73oEPF
    nU0Dlwnxu0YdQNoUofyPzOXPc/kWQmGrdXErzHtWM8QeaFsw1FHzHOB16H7mmP9d
    wW7Yrfp3wVsM6iDWftmiP8h42B3w7zSHJ0Y4uAyu/xY/2BJvcUUzwI6sNA0GecIQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HqfFs3Iv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HqfFs3Iv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933874AbeCCWfE (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:35:04 -0500
Received: from mail-sn1nam01on0132.outbound.protection.outlook.com ([104.47.32.132]:20800
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933677AbeCCWfA (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:35:00 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 140/219] [media] v4l: vsp1: Prevent multiple
 streamon race commencing pipeline early
Thread-Topic: [PATCH AUTOSEL for 4.9 140/219] [media] v4l: vsp1: Prevent
 multiple streamon race commencing pipeline early
Thread-Index: AQHTsz8RoU7X7hjY4kOELp8+LHy1zg==
Date: Sat, 3 Mar 2018 22:29:17 +0000
Message-ID: <20180303222716.26640-140-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0924;6:jVsqxPzDyV7rDX5olPh5SEGZHY8CdhbK9NLrRxCZnIy3mcgvcbzBqUvlYxpdzkfMMi8DH/2oZMvZO/fXqB2diav3XBCkggCqlkt/PNDPf4zdE9oLT9SSBmTQiBOD5SkhiUt3KQSi7BgM4yfhdyI0/bZCCfPDu8z2/1gLxhucXPMvQbDGcCMk6+snjAvKgSbVf1TtkLAGtZ4UjbMlGjb6wa7Bx56t65WXnN2XyZUgB4mkzf9Q/4rKMg6+IuFt+KMfkuvyEcBuSiKOK+i3HwSxH1G+gxUhcTO7U0qhzIqsmburmtGRg3LueyZPLAHUOmqJ+WCSDmkLCZVg87mvPg76Kj/bC123CEf2eYld6fEgKI0=;5:mUbw7+YY3X8lT1NVMlEf/ez3APolVuFJtXknsB0XaWC9clAx8h4VNlZd+xMuyVaUkPHyVZBB3DUCvMNVBllkHTfmGFK8S1uIzwH73JifhK2/JVMa4RnOB9NEzmG67GchTwCydjeqSI1igC87sSOuz7gNGAe/V6/hC4tyUzlN69Q=;24:AmU977Qp45yGMqj6xFK0kbjJapW6PgTOWYot+dL1OZCD5GNKz1Y1rKHohm70L2Hr0VACV3wllBakszO82GNp+vL6veamofBNZESkhi+lR5c=;7:jb9F5CtnM0kD8T/smwXFO+an/ThVfSII+j15pf5scpGzj67E0UN5pjZsV7Ucic18F6oRa6CHQlY6BLk2xzclHU3BPLbPhxWFfb0FMmNIZ/tlBcD9no9nRAmMn3m3v3UwiGMgKqkOdwOv1aMryGvgjQyC9cMoxVIdTrnbLi8DrcVY4Xum6NjFVhD9tYrcN/7EEb4psEYQRMBKsKDFyRCqvH3D/E8dzYPu1pY+ZmVw1W4y3jp7mZRLZRqdRsnzfyyX
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4c2e1d2c-b625-4a16-32e4-08d58156fd95
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0924;
x-ms-traffictypediagnostic: MW2PR2101MB0924:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0924A59BCD44BA134F24F186FBC40@MW2PR2101MB0924.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0924;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0924;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(189003)(199004)(102836004)(2950100002)(10090500001)(6666003)(316002)(26005)(186003)(25786009)(2900100001)(2906002)(54906003)(22452003)(110136005)(97736004)(6506007)(59450400001)(7736002)(4326008)(305945005)(5250100002)(86362001)(575784001)(2501003)(99286004)(68736007)(72206003)(53936002)(6436002)(6116002)(3846002)(5660300001)(66066001)(1076002)(76176011)(14454004)(36756003)(3660700001)(6486002)(86612001)(81156014)(8676002)(81166006)(10290500003)(6512007)(8936002)(3280700002)(478600001)(107886003)(106356001)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0924;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2e1d2c-b625-4a16-32e4-08d58156fd95
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:17.9163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0924
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

[ Upstream commit 4461c84b52b4a952c657505ef7e4e06b016783df ]

With multiple inputs through the BRU it is feasible for the streams to
race each other at stream-on.

Multiple VIDIOC_STREAMON calls racing each other could have process
N-1 skipping over the pipeline setup section and then start the pipeline
early, if videobuf2 has already enqueued buffers to the driver for
process N but not called the .start_streaming() operation yet

In the case of the video pipelines, this
can present two serious issues.

 1) A null-dereference if the pipe->dl is committed at the same time as
    the vsp1_video_setup_pipeline() is processing

 2) A hardware hang, where a display list is committed without having
    called vsp1_video_setup_pipeline() first

Repair this issue, by ensuring that only the stream which configures the
pipeline is able to start it.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/platform/vsp1/vsp1_video.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/media/platform/vsp1/vsp1_video.c b/drivers/media/platf=
orm/vsp1/vsp1_video.c
index d351b9c768d2..743aa0febc09 100644
--- a/drivers/media/platform/vsp1/vsp1_video.c
+++ b/drivers/media/platform/vsp1/vsp1_video.c
@@ -792,6 +792,7 @@ static int vsp1_video_start_streaming(struct vb2_queue =
*vq, unsigned int count)
 {
 	struct vsp1_video *video =3D vb2_get_drv_priv(vq);
 	struct vsp1_pipeline *pipe =3D video->rwpf->pipe;
+	bool start_pipeline =3D false;
 	unsigned long flags;
 	int ret;
=20
@@ -802,11 +803,23 @@ static int vsp1_video_start_streaming(struct vb2_queu=
e *vq, unsigned int count)
 			mutex_unlock(&pipe->lock);
 			return ret;
 		}
+
+		start_pipeline =3D true;
 	}
=20
 	pipe->stream_count++;
 	mutex_unlock(&pipe->lock);
=20
+	/*
+	 * vsp1_pipeline_ready() is not sufficient to establish that all streams
+	 * are prepared and the pipeline is configured, as multiple streams
+	 * can race through streamon with buffers already queued; Therefore we
+	 * don't even attempt to start the pipeline until the last stream has
+	 * called through here.
+	 */
+	if (!start_pipeline)
+		return 0;
+
 	spin_lock_irqsave(&pipe->irqlock, flags);
 	if (vsp1_pipeline_ready(pipe))
 		vsp1_video_pipeline_run(pipe);
--=20
2.14.1
