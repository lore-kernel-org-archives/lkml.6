Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1465196-1518185628-2-12801824241101902613
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518185627; b=isSOuJ1xNMrqg7bJgn2l8QKNQmhrrp7CdoTv8PCs77Qh2+c
    UcqFHjNmoQ1xIxuDqq0hpCQZAwzyNewXkDpgGkyFouMdubWA/DddEYkUNJikk/2m
    0D7WCwqFj1aqJ1yyAoNhcIZCBoI+fub5FlrghTgRp1RBF+0qstHNffU4L3LpluRR
    Yc4vDDdVFsCRh7qTsslox8fBqgFLoQv9WAVd3NO6dbqLif9XoAIaWZmfjRmbXpM/
    XxTD5gRus/ixATJZHbT4u28l3Uh54GWqRTaPni+EuemkvylK2bLRe0tDq8K7nc1t
    4wNDDKlZ8a6Wrf6DQs+7wprMffDky7nmkOvPg7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185627; bh=NrExqCn6jJz38zituwFUoW59qY
    4O0v38o6XeG1LgpVc=; b=nNQIvQqTLjadBMt0A/K5G0F9XU3lAV8OnTV3Rb4js8
    KOYRQXboQ+E36v50qqzG2Z7Hnqxta5MJxOcaKv75S4dPMtw3BEc5e8TE5VEB0j3a
    v0LZU7Cm+RhE7+onKFNBCTPXOrYrbq+84i6+Mw+vOgMyt746HW0apkHu3mekrKPT
    PtxV4TFOl4DsLL6ueIBPeWLA5K0Xkln1rqHPXDiG6IURfyE3DvUGc6XxTkKQ0+3T
    z6plrNVuOU9GSWUtr89tpdc+jX9e8SGNGGSzXHw0L1qYwqFPPJiNeeaIaT2up+aG
    X+5+SRSirbnqhj6dEjkBA3LOr8HUeJW6+udYYA7g6QmA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751038AbeBION3 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 09:13:29 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49362 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752657AbeBINlo (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:41:44 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.9 33/92] b43: Add missing MODULE_FIRMWARE()
Date: Fri,  9 Feb 2018 14:39:02 +0100
Message-Id: <20180209133933.556318090@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 3c89a72ad80c64bdbd5ff851ee9c328a191f7e01 upstream.

Some firmware entries were forgotten to be added via MODULE_FIRMWARE(), which
may result in the non-functional state when the driver is loaded in initrd.

Link: http://bugzilla.opensuse.org/show_bug.cgi?id=1037344
Fixes: 15be8e89cdd9 ("b43: add more bcma cores")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/broadcom/b43/main.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -71,8 +71,18 @@ MODULE_FIRMWARE("b43/ucode11.fw");
 MODULE_FIRMWARE("b43/ucode13.fw");
 MODULE_FIRMWARE("b43/ucode14.fw");
 MODULE_FIRMWARE("b43/ucode15.fw");
+MODULE_FIRMWARE("b43/ucode16_lp.fw");
 MODULE_FIRMWARE("b43/ucode16_mimo.fw");
+MODULE_FIRMWARE("b43/ucode24_lcn.fw");
+MODULE_FIRMWARE("b43/ucode25_lcn.fw");
+MODULE_FIRMWARE("b43/ucode25_mimo.fw");
+MODULE_FIRMWARE("b43/ucode26_mimo.fw");
+MODULE_FIRMWARE("b43/ucode29_mimo.fw");
+MODULE_FIRMWARE("b43/ucode33_lcn40.fw");
+MODULE_FIRMWARE("b43/ucode30_mimo.fw");
 MODULE_FIRMWARE("b43/ucode5.fw");
+MODULE_FIRMWARE("b43/ucode40.fw");
+MODULE_FIRMWARE("b43/ucode42.fw");
 MODULE_FIRMWARE("b43/ucode9.fw");
 
 static int modparam_bad_frames_preempt;
