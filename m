Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519414891-2-8857171665217716367
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
    t=1519414891; b=qrfQDzMJGrnduMLQwtEgpEaz3tuu8LqLJ84DXYGto+BvOg4
    FQkf1a/RZ3A4WyxEeF4VUAs8kJwPjCbo2WMoKglB/aL+hbII3gpM3JGICwDety/N
    sic5HaWSHE0rhFpyc+NzLbLT93B44Aoo7+2TxYZgtMwjn4BZfPbO5dvOZw6eb44R
    Tx4Q2gfSwE/wjxJoV5VzG1XZ3/VzJG1cZhp71arE9QOYTw6Oehkr/bZ8Wn7RY0pF
    zo8WlRV+VVgAO7WB+nWDQg9CtWx17UaAk2kv0Hn+CpweOa6wf7I2tE5oUztBNU7T
    aCEBq0ogWrDuhFhONRGddoWDtOM+mux6XoEBOGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414891; bh=754VRWN/ksy/VL92wObm8B0m6X
    NT1i3ncqs8qYYfXUE=; b=UhE9/4ma8l1L1IlIc6UrJDNclevB/Hix5OA6NO7D+r
    bOFIjUM1NymowLkLYusruKHHXiaQB/DumZUUSSDTKfTRzsaaU+O/BoRMzNsPWksU
    dKlPV6M+CLWAFNc7yXbccWuKKjVwz9weKUPst1qEjWAg3B+Yw8pDhlMx5ULBO0EI
    ECUceX6qtR3YCgH5NsNf5Ap6aeNlBKoudx6JQFRGAAbski9DVnG3XlmMK8Tlx1kY
    gWloXOvvIRFwimGYYLbK3ME/h6XkXeS6ydkR4zSBlujz/BVhe95E67hY/feXI/Uu
    w7pf4IFQwmBJqzx/yA9KZg0IqA2XKszael/ZyYCOgzVA==
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
        id S934222AbeBWStP (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:49:15 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45182 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934483AbeBWStK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:49:10 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.9 128/145] [media] go7007: add MEDIA_CAMERA_SUPPORT dependency
Date: Fri, 23 Feb 2018 19:27:14 +0100
Message-Id: <20180223170741.348607409@linuxfoundation.org>
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

commit fa6317eedd6341f2144ed1097706d8c34f18b6e4 upstream.

If MEDIA_SUBDRV_AUTOSELECT and VIDEO_GO7007 are both set, we
automatically select VIDEO_OV7640, but that depends on MEDIA_CAMERA_SUPPORT,
so we get a Kconfig warning if that is disabled:

warning: (VIDEO_GO7007) selects VIDEO_OV7640 which has unmet direct dependencies (MEDIA_SUPPORT && I2C && VIDEO_V4L2 && MEDIA_CAMERA_SUPPORT)

This adds another dependency so we don't accidentally select
it when it is unavailable.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/go7007/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/usb/go7007/Kconfig
+++ b/drivers/media/usb/go7007/Kconfig
@@ -11,7 +11,7 @@ config VIDEO_GO7007
 	select VIDEO_TW2804 if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_TW9903 if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_TW9906 if MEDIA_SUBDRV_AUTOSELECT
-	select VIDEO_OV7640 if MEDIA_SUBDRV_AUTOSELECT
+	select VIDEO_OV7640 if MEDIA_SUBDRV_AUTOSELECT && MEDIA_CAMERA_SUPPORT
 	select VIDEO_UDA1342 if MEDIA_SUBDRV_AUTOSELECT
 	---help---
 	  This is a video4linux driver for the WIS GO7007 MPEG
