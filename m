Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B10CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D6F2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="nGIJb0pI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732964AbeLQRPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:15:45 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39083 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbeLQRPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:15:45 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so6436402pld.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 09:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kkfcbf586gQhuhWbJ/CjJr0JrDh12V7PDJAswCw8ShU=;
        b=nGIJb0pIzkcj1mU7Oan7wzRB5g9TwwGYfl0rU0d572v0MlDWFK5fPAQK2RAvnnAJMF
         XnI3q/OJHHFsQsV1s5exereUsS0pcsjpdwrAgyn/LjjfLQt5pWcY5ZH2wwN/OSnGg5P5
         3pxhhYMhFqCEqa4p38Tdfyn9MDgwGrKIczkR5+YM+cJDGwcmsINCaz+8te13I0qkolGM
         FiJ7SMaQy4hxPVlXLoIoD/P8/WwLIAzD9J51ry0h9vFwRE0u4HKQx/gcmDgCZkHn3DKS
         AinxNwUUUSomEo2FDAFSV2aRVdg9j2f8UIw4nkLCaa6HTSGfQooIQQwA86HOzaF3uNNq
         gi8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kkfcbf586gQhuhWbJ/CjJr0JrDh12V7PDJAswCw8ShU=;
        b=Llv9ysI0JicbVRd49giYNM8eFYsBZHpA2/G2UQxmXYzOSSx3SUio7fPplHzG+69UaA
         LsqvWFphrEkPC1tRBFmI3FflQcLzWoWpgcN/iBSbpel1hI6eha8LSpHFj5BK4+qz13zM
         4GD8HPBnJSaD+PZZsUzP/xKQfTP9atkwt1Wyng/Oc5pdWg+zD4WbAcNCObx064AUFEqW
         +l8KUWOMUjccvboufNiH41lF4oevIILuZsxwcx0GsOgF9WLtDApRGTjyh/WIW8hoYllF
         pD/4sm154EN1J0e2X0D9xSztuY1PlyWjT2YazaCUWpbtKZiaaFBxxr05SLWrrpkUPq3K
         MVyQ==
X-Gm-Message-State: AA+aEWY+1c5X4SH36Q299qswU9GW2VDR+w+k5VZubyRsdT6JQ4R2Cb0E
        T/bOTF1cnoeKXN8kUo4azsGDMw==
X-Google-Smtp-Source: AFSGD/XJUq9c3AsvV1OKLoRlo1Zs7kAJgnQPwh4D86DECVx0lWN1kpEDviSgXCNdifa/Y06K5VQmoQ==
X-Received: by 2002:a17:902:a03:: with SMTP id 3mr13525827plo.112.1545066943925;
        Mon, 17 Dec 2018 09:15:43 -0800 (PST)
Received: from xeon-e3 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id b26sm27597337pfe.91.2018.12.17.09.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 09:15:43 -0800 (PST)
Date:   Mon, 17 Dec 2018 09:15:36 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'devel@linuxdriverproject.org'" <devel@linuxdriverproject.org>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "'apw@canonical.com'" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Return -EINVAL for the sys files
 for unopened channels
Message-ID: <20181217091518.5004d4c7@xeon-e3>
In-Reply-To: <PU1P153MB0169DDAA2CBC2901505AE692BFA00@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB0169DDAA2CBC2901505AE692BFA00@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 16:35:43 +0000
Dexuan Cui <decui@microsoft.com> wrote:

> Before 98f4c651762c, we returned zeros for unopened channels.
> With 98f4c651762c, we started to return random on-stack values.
>=20
> We'd better return -EINVAL instead.
>=20
> Fixes: 98f4c651762c ("hv: move ringbuffer bus attributes to dev_groups")
> Cc: stable@vger.kernel.org
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

The concept looks fine, but maybe it would be simpler to move it into
hv_ringbuffer_get_debuginfo and have it return an error code.

Since so much of the code is repeated, I would probably make a
macro which generates the code as well.

Something like this:

=46rom c6bbdbcde933c85098f7b3e71650a8479d52810c Mon Sep 17 00:00:00 2001
From: Stephen Hemminger <sthemmin@microsoft.com>
Date: Mon, 17 Dec 2018 09:13:24 -0800
Subject: [PATCH] hv: vmbus: check for ring in debug info

---
 drivers/hv/ring_buffer.c | 31 +++++++++---------
 drivers/hv/vmbus_drv.c   | 71 ++++++++++++++++++++++++++++++++++------
 include/linux/hyperv.h   |  5 +--
 3 files changed, 79 insertions(+), 28 deletions(-)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 64d0c85d5161..1f1a55e07733 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -164,26 +164,25 @@ hv_get_ringbuffer_availbytes(const struct hv_ring_buf=
fer_info *rbi,
 }
=20
 /* Get various debug metrics for the specified ring buffer. */
-void hv_ringbuffer_get_debuginfo(const struct hv_ring_buffer_info *ring_in=
fo,
-				 struct hv_ring_buffer_debug_info *debug_info)
+int hv_ringbuffer_get_debuginfo(const struct hv_ring_buffer_info *ring_inf=
o,
+				struct hv_ring_buffer_debug_info *debug_info)
 {
 	u32 bytes_avail_towrite;
 	u32 bytes_avail_toread;
=20
-	if (ring_info->ring_buffer) {
-		hv_get_ringbuffer_availbytes(ring_info,
-					&bytes_avail_toread,
-					&bytes_avail_towrite);
-
-		debug_info->bytes_avail_toread =3D bytes_avail_toread;
-		debug_info->bytes_avail_towrite =3D bytes_avail_towrite;
-		debug_info->current_read_index =3D
-			ring_info->ring_buffer->read_index;
-		debug_info->current_write_index =3D
-			ring_info->ring_buffer->write_index;
-		debug_info->current_interrupt_mask =3D
-			ring_info->ring_buffer->interrupt_mask;
-	}
+	if (!ring_info->ring_buffer)
+		return -EINVAL;
+
+	hv_get_ringbuffer_availbytes(ring_info,
+				     &bytes_avail_toread,
+				     &bytes_avail_towrite);
+	debug_info->bytes_avail_toread =3D bytes_avail_toread;
+	debug_info->bytes_avail_towrite =3D bytes_avail_towrite;
+	debug_info->current_read_index =3D ring_info->ring_buffer->read_index;
+	debug_info->current_write_index =3D ring_info->ring_buffer->write_index;
+	debug_info->current_interrupt_mask
+		=3D ring_info->ring_buffer->interrupt_mask;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(hv_ringbuffer_get_debuginfo);
=20
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 283d184280af..403fee01572c 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -313,10 +313,16 @@ static ssize_t out_intr_mask_show(struct device *dev,
 {
 	struct hv_device *hv_dev =3D device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info outbound;
+	int ret;
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
+
+	ret =3D hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound,
+					  &outbound);
+	if (ret < 0)
+		return ret;
+
 	return sprintf(buf, "%d\n", outbound.current_interrupt_mask);
 }
 static DEVICE_ATTR_RO(out_intr_mask);
@@ -326,10 +332,15 @@ static ssize_t out_read_index_show(struct device *dev,
 {
 	struct hv_device *hv_dev =3D device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info outbound;
+	int ret;
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
+
+	ret =3D hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound,
+					  &outbound);
+	if (ret < 0)
+		return ret;
 	return sprintf(buf, "%d\n", outbound.current_read_index);
 }
 static DEVICE_ATTR_RO(out_read_index);
@@ -340,10 +351,15 @@ static ssize_t out_write_index_show(struct device *de=
v,
 {
 	struct hv_device *hv_dev =3D device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info outbound;
+	int ret;
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
+
+	ret =3D hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound,
+					  &outbound);
+	if (ret < 0)
+		return ret;
 	return sprintf(buf, "%d\n", outbound.current_write_index);
 }
 static DEVICE_ATTR_RO(out_write_index);
@@ -354,10 +370,15 @@ static ssize_t out_read_bytes_avail_show(struct devic=
e *dev,
 {
 	struct hv_device *hv_dev =3D device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info outbound;
+	int ret;
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
+
+	ret =3D hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound,
+					  &outbound);
+	if (ret < 0)
+		return ret;
 	return sprintf(buf, "%d\n", outbound.bytes_avail_toread);
 }
 static DEVICE_ATTR_RO(out_read_bytes_avail);
@@ -368,10 +389,15 @@ static ssize_t out_write_bytes_avail_show(struct devi=
ce *dev,
 {
 	struct hv_device *hv_dev =3D device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info outbound;
+	int ret;
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
+
+	ret =3D hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound,
+					  &outbound);
+	if (ret < 0)
+		return ret;
 	return sprintf(buf, "%d\n", outbound.bytes_avail_towrite);
 }
 static DEVICE_ATTR_RO(out_write_bytes_avail);
@@ -381,10 +407,15 @@ static ssize_t in_intr_mask_show(struct device *dev,
 {
 	struct hv_device *hv_dev =3D device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info inbound;
+	int ret;
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+
+	ret =3D hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+	if (ret < 0)
+		return ret;
+
 	return sprintf(buf, "%d\n", inbound.current_interrupt_mask);
 }
 static DEVICE_ATTR_RO(in_intr_mask);
@@ -394,10 +425,15 @@ static ssize_t in_read_index_show(struct device *dev,
 {
 	struct hv_device *hv_dev =3D device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info inbound;
+	int ret;
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+
+	ret =3D hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+	if (ret < 0)
+		return ret;
+
 	return sprintf(buf, "%d\n", inbound.current_read_index);
 }
 static DEVICE_ATTR_RO(in_read_index);
@@ -407,10 +443,15 @@ static ssize_t in_write_index_show(struct device *dev,
 {
 	struct hv_device *hv_dev =3D device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info inbound;
+	int ret;
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+
+	ret =3D hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+	if (ret < 0)
+		return ret;
+
 	return sprintf(buf, "%d\n", inbound.current_write_index);
 }
 static DEVICE_ATTR_RO(in_write_index);
@@ -421,10 +462,15 @@ static ssize_t in_read_bytes_avail_show(struct device=
 *dev,
 {
 	struct hv_device *hv_dev =3D device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info inbound;
+	int ret;
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+
+	ret =3D hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+	if (ret < 0)
+		return ret;
+
 	return sprintf(buf, "%d\n", inbound.bytes_avail_toread);
 }
 static DEVICE_ATTR_RO(in_read_bytes_avail);
@@ -435,10 +481,15 @@ static ssize_t in_write_bytes_avail_show(struct devic=
e *dev,
 {
 	struct hv_device *hv_dev =3D device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info inbound;
+	int ret;
=20
 	if (!hv_dev->channel)
 		return -ENODEV;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+
+	ret =3D hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+	if (ret < 0)
+		return ret;
+
 	return sprintf(buf, "%d\n", inbound.bytes_avail_towrite);
 }
 static DEVICE_ATTR_RO(in_write_bytes_avail);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 14131b6fae68..ed74888087f1 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1176,8 +1176,9 @@ struct hv_ring_buffer_debug_info {
 	u32 bytes_avail_towrite;
 };
=20
-void hv_ringbuffer_get_debuginfo(const struct hv_ring_buffer_info *ring_in=
fo,
-			    struct hv_ring_buffer_debug_info *debug_info);
+
+int hv_ringbuffer_get_debuginfo(const struct hv_ring_buffer_info *ring_inf=
o,
+				struct hv_ring_buffer_debug_info *debug_info);
=20
 /* Vmbus interface */
 #define vmbus_driver_register(driver)	\
--=20
2.19.2

