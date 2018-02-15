Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2179907-1518719631-2-14239425684654407430
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518719631; b=pxLKfVty7tp3PfZbcVIESb3Z8DWb23d2Yk8MH+Aj6J9gTlG
    vN+wjKkyt9uFbrTCnChsISvGks0Qjoz+IDcbNiXP+0k+qKYym/MIWXYgvyh6vGjj
    xQ4oxypVTImaf9ulsiW+t0z/HfSLwN4iJx9jRKwuTzCVOqIc5AwNrKpTavyx/AUq
    MKMxl5VEymu6enKB7M1RjINYTQ+0zwJw2UD82h8vafChshxs9yn2KWW8mXpsEJmJ
    Knq+tTRtomGx07UjRSNf7w85jfTvErXkVepdFeNWZeBN743ogh3QKvHsqODEwwgm
    67/PE1xjlWkLISxiyJo9wtNkLEPVTf9vJpe9/bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518719631; bh=3BNRhIuNPhkuBz/jcUi913LwAG
    vYy7g755iLIpTsN88=; b=Ts6HSMv4cV8vURoDmoI6b6BfIz421pcFxeFSY39d5B
    HJrPGLqL8EBofjWyHtaLqoUYWx0dz/iDm/mHv1fjjlw7TgQ2mYmMNaVydVIG2N3Z
    Kf7Z5SnLgy7bWaIhHEH1GXc0Nj751Jbw8XZUORJQq5mkV8mBo7mQLRTSPgcxuSAx
    aoAqTPy2LvHFrcc52Do5acE8xdZbq/VeFQvmdWaiPmb5Y14BqcrxVQFE0n5q0BlS
    0QOXx26AhxvUfn6Xak0AYg4RYv09jxewApKKDq01XDRW/9+mtk9XgY4DdezAG01r
    xRYb1ZGe3uOxGBYGBuC781zPI2kGWX4fyGH48woxra5Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162954AbeBOPYp (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:24:45 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51948 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161886AbeBOPYm (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:24:42 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Cvek <petr.cvek@tul.cz>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.4 048/108] usb: gadget: uvc: Missing files for configfs interface
Date: Thu, 15 Feb 2018 16:16:45 +0100
Message-Id: <20180215151229.152971288@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Cvek <petr.cvek@tul.cz>

commit c8cd751060b149997b9de53a494fb1490ded72c5 upstream.

Commit 76e0da34c7ce ("usb-gadget/uvc: use per-attribute show and store
methods") caused a stringification of an undefined macro argument "aname",
so three UVC parameters (streaming_interval, streaming_maxpacket and
streaming_maxburst) were named "aname".

Add the definition of "aname" to the main macro and name the filenames as
originaly intended.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/uvc_configfs.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -2202,7 +2202,7 @@ static struct configfs_item_operations u
 	.release		= uvc_attr_release,
 };
 
-#define UVCG_OPTS_ATTR(cname, conv, str2u, uxx, vnoc, limit)		\
+#define UVCG_OPTS_ATTR(cname, aname, conv, str2u, uxx, vnoc, limit)	\
 static ssize_t f_uvc_opts_##cname##_show(				\
 	struct config_item *item, char *page)				\
 {									\
@@ -2245,16 +2245,16 @@ end:									\
 	return ret;							\
 }									\
 									\
-UVC_ATTR(f_uvc_opts_, cname, aname)
+UVC_ATTR(f_uvc_opts_, cname, cname)
 
 #define identity_conv(x) (x)
 
-UVCG_OPTS_ATTR(streaming_interval, identity_conv, kstrtou8, u8, identity_conv,
-	       16);
-UVCG_OPTS_ATTR(streaming_maxpacket, le16_to_cpu, kstrtou16, u16, le16_to_cpu,
-	       3072);
-UVCG_OPTS_ATTR(streaming_maxburst, identity_conv, kstrtou8, u8, identity_conv,
-	       15);
+UVCG_OPTS_ATTR(streaming_interval, streaming_interval, identity_conv,
+	       kstrtou8, u8, identity_conv, 16);
+UVCG_OPTS_ATTR(streaming_maxpacket, streaming_maxpacket, le16_to_cpu,
+	       kstrtou16, u16, le16_to_cpu, 3072);
+UVCG_OPTS_ATTR(streaming_maxburst, streaming_maxburst, identity_conv,
+	       kstrtou8, u8, identity_conv, 15);
 
 #undef identity_conv
 
