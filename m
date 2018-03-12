Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3443661-1520826843-2-10429270300073598750
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520826843; b=IWSWI+1T0Uv1/R1zppjgeOx6CFDrjLQoTzHlovhZfjXe58a
    6JOcYYECv4V4YIgFxGZUOZmCmtRmWlj0N9TwT49zsXBhATP3Scd+IvHJ3Y6KIQxc
    jn7LkcU1O20bHEOxQoQe1dHV+9pq598H9rmY4wrTybWqtmjNqoLVwkFq6Po+9QXU
    /lpyeX/OCvprYDoZEMfAYybz2S11//epU8nI5b7DTgUWk5tBKG0tq6H8G+YzPubn
    oK5Tjrl1dJERUXGlEG9MdP/W5fdy5iH/QZ8QJsawDc4uUFSdRcrABXAcbOg3a40f
    zcbI9FfhM/NidC7TYbdt84sx8xRpkNLWh5r3/rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826843; bh=pLNyKP8fSSLqsGSNvNm
    i2pflRKzFhr2cYrRroGtC6Ug=; b=f2IbJKLyZIkCQtvH6tYxmBArjghMrBVkVVZ
    AFIE0wPBRc239z2RIbCHlSqi18AQWiT9CAs5rZRFbes4VsBXdTyrCJq8ioLzqlz5
    Fo2PgKxJyfTb+KHDdzo0ZrBu10DJDTv97/F6mF9COBWuM6WNWEitUZKfAa/gjziP
    yluqO6qKpHq60t40FFgOLWheV03UjtEmUDrFxF9lbKw5eUT0nQyNqI5xj6mhxCR6
    rbOf/YrOL2mAGHpIPEkWYUKcWOL+VdRj3fAvBmRPUCj0ZNnR2fTVnaX3UrfAW1fy
    v/3V3fPy6QTHcF2P0Vj77xyAp0Eb2oahj9rINUI0s0Y9m+VtdkQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932560AbeCLDxG (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:53:06 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41015 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932543AbeCLDHi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:38 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "John W. Linville" <linville@tuxdriver.com>,
        "Alexandre Oliva" <oliva@lsd.ic.unicamp.br>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.551469585@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 001/104] brcmfmac: work-around gcc 4.7 build issue
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>

commit 5addc0de28f5e286f9d121112c4222250807b5a5 upstream.

Alexandre Oliva <oliva@lsd.ic.unicamp.br> says:

"It's an issue brought about by GCC 4.7's partial-inlining, that ends up
splitting the udelay function just at the wrong spot, in such a way that
some sanity checks for constants fails, and we end up calling
bad_udelay.

This patch fixes the problem.  Feel free to push it upstream if it makes
sense to you."

Signed-off-by: John W. Linville <linville@tuxdriver.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c
+++ b/drivers/net/wireless/brcm80211/brcmfmac/wl_cfg80211.c
@@ -2465,7 +2465,7 @@ static s32 brcmf_init_iscan(struct brcmf
 	return err;
 }
 
-static void brcmf_delay(u32 ms)
+static __always_inline void brcmf_delay(u32 ms)
 {
 	if (ms < 1000 / HZ) {
 		cond_resched();
