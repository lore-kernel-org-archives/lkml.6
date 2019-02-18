Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B07EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B01C206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498337;
	bh=2N9Id1O2JMhalhWmYK5tom3qJWqfyXKi3YUmGWniI+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PXtTJRTe34J6a5uc+hbk4yf+K9DoHXZLUMXvVvBh4RZtuxUNdiWwqJ5Ffly/64wct
	 g0W7wttUK1ivK+TpC8SQ30XC3m3JnnSEcqz/cJrc6Tc+RU4YUgD4bpX/XqpUAXzbA4
	 6fj5z7ySNtp6kZMTS1inoXCbdSm1nnP4hLwtElns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731794AbfBRN6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:58:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:39658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733259AbfBRN6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:58:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC7612077B;
        Mon, 18 Feb 2019 13:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498332;
        bh=2N9Id1O2JMhalhWmYK5tom3qJWqfyXKi3YUmGWniI+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SJyQBbQO9NWTUc+kBxhS29mfaKIh1Va3JT7fIsvMzfoPvqdgfD480DSvoL0v0E5V+
         Yi+wWtwKxg9FOtnK5yx7Ns4b3u3oVNzrDwMNH+pV9BN0mv3lyPyEc9ghvY/qUX1jBt
         XIivBK200otkB8V0xlQFknvUXIiJSGV3yQu9QOOo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.9 35/58] Revert "Input: elan_i2c - add ACPI ID for touchpad in ASUS Aspire F5-573G"
Date:   Mon, 18 Feb 2019 14:43:56 +0100
Message-Id: <20190218133511.362145272@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133508.567416115@linuxfoundation.org>
References: <20190218133508.567416115@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit f420c54e4b12c1361c6ed313002ee7bd7ac58362 upstream.

This reverts commit 7db54c89f0b30a101584e09d3729144e6170059d as it
breaks Acer Aspire V-371 and other devices. According to Elan:

"Acer Aspire F5-573G is MS Precision touchpad which should use hid
 multitouch driver. ELAN0501 should not be added in elan_i2c."

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=202503
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/elan_i2c_core.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1240,7 +1240,6 @@ MODULE_DEVICE_TABLE(i2c, elan_id);
 static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN0000", 0 },
 	{ "ELAN0100", 0 },
-	{ "ELAN0501", 0 },
 	{ "ELAN0600", 0 },
 	{ "ELAN0602", 0 },
 	{ "ELAN0605", 0 },


