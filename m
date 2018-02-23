Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519414908-2-210018187544946190
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414908; b=LwSO8zmYsRNAVgSBFbGBPHfkNTnncHEDCaG+9JktcVwRDQF
    kifU8PrHIUqrmwwfq6Ij2Q+PrxnCIMK0+H0uUTzX5+O+La1vwoeqk/XpIC2ky6Fc
    nJLHxFrxtTD1XMSo1ClVpP5PsnCwkJdbJO8sT+b1jyLOVQ9byLaIY8EuOv/Yo7rX
    bjP0u8DIGDiC6+hiSvsUvJjvK6VSLbaPlQw9lN0a+E+zOZe1xn2ADdDtU7LApWgI
    IBgR4VKR23OBZIFibgtWZQwWrt0HlnxVrzrfiTwWFkyMgob+p25ZplXcln4Ns/Dn
    DdG/7Lr7ySc5aTK+IBMXE2/D2sY7IK0nhJgmtVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414908; bh=cd/ESo/5j90qYAAqKz4IgQZBnu
    E6CH9oPpKZAu2bze8=; b=nC6U3eBpGzd1EerUXJ8uhOJO53Uc4BNiXTXzIVueQD
    dFBQkkEnr7PPS1h5oSqzeIEfZPc/nF42W4V4Wp0Vg3yxVGKEhw4w4FcESsRB2N9+
    URvLEkNqE+jM3zVjDjrKZB+HwebsdfZ2wdmjIt3W97VO7hIIaIj6hz/S+sD2D9jf
    SaWmZGxny1ZnST5eYoudUKjREwp0VY3NGEQcA7cyvkWX9f6Rn0ysfJ5ZmQrAQSbZ
    omf7+wveSh/IWXlBRUEOH3wUCsLj68b3A6ZnPbCUze5taJvpBPQf2nkj92iBy9R9
    +yFsTr+UPI2myJc6iCzX4CjAV29ctT9XKta1ATJjHRDw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754775AbeBWTla (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:41:30 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45200 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933827AbeBWStM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:49:12 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.9 129/145] [media] em28xx: only use mt9v011 if camera support is enabled
Date: Fri, 23 Feb 2018 19:27:15 +0100
Message-Id: <20180223170741.460941835@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 190b23b4eb997767afad186bd8c96badceabf39e upstream.

In randconfig builds that select VIDEO_EM28XX_V4L2 and
MEDIA_SUBDRV_AUTOSELECT, but not MEDIA_CAMERA_SUPPORT, we get
a Kconfig warning:

 warning: (VIDEO_EM28XX_V4L2) selects VIDEO_MT9V011 which has unmet direct dependencies (MEDIA_SUPPORT && I2C && VIDEO_V4L2 && MEDIA_CAMERA_SUPPORT)

This avoids the warning by making that 'select' conditional on
MEDIA_CAMERA_SUPPORT. Alternatively we could mark EM28XX as
'depends on MEDIA_CAMERA_SUPPORT', but it does not seem to
have any real dependency on that itself.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/em28xx/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/usb/em28xx/Kconfig
+++ b/drivers/media/usb/em28xx/Kconfig
@@ -11,7 +11,7 @@ config VIDEO_EM28XX_V4L2
 	select VIDEO_SAA711X if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_TVP5150 if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_MSP3400 if MEDIA_SUBDRV_AUTOSELECT
-	select VIDEO_MT9V011 if MEDIA_SUBDRV_AUTOSELECT
+	select VIDEO_MT9V011 if MEDIA_SUBDRV_AUTOSELECT && MEDIA_CAMERA_SUPPORT
 
 	---help---
 	  This is a video4linux driver for Empia 28xx based TV cards.
