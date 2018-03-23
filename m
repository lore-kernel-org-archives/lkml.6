Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521804047-2-9442491451178961441
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804047; b=sEqe6eDMnOQBa9Bkf11pAZGy9RQJMvpmc4acKtHBHiTkYBY
    HL9ZknSPsKryc8unushnLzaT+rRyQhqpxAH9MJbmYGw90Qc1maLM0NfFhXrs710S
    JTviXJ9rt9ehrl4l8Wkoh/EzjGXnNtWfzuHG4O8nuOg+Ef9k4P+2+0OROZLksVXE
    ubudyOihCoD3vTSkIgmATCAmtX4OJmGrkMzdO2K5UOSOZ/4vSOJ32FLjAuBbSyNv
    P4PzYTUNKb6VijtR6LOOXFVKBYSuLr2bBzLyAaVUAEX0EVe09F1QTycS8shmd74r
    YLmLqNjnSLbltNgBc/+0N+CJNxpzOY3ctCVzE+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804047; bh=zeQuApFWPZrOzWf8VzZQNVPExQ
    w7IDiokfJtjl4AiWM=; b=Wrx7WzQZ2Wi6puK+6MSngfwQAl0yg9qE4b41BsLdj2
    SwR27vjoniphE6kNMbJihp1p1tHbaz47kbgzV+Swrx2VO/5dE8XyddhgCuVUt49g
    JhJVGIWWQ4CL1cH7aGwmjjeFEgKDLslJwYlpE2IDUrMo6neWzI6Q2PC+ol3vw0lo
    opgbkfbwpanNo/yZvEp4thdBuPb6zB7d0tMWvjsP+yC254ULm14gIE/8Rl99WPXl
    +Sx5oIkgD9kwTCJDi9KSIiZGDiScV3IDx5YLkq7BNpimg7iOWvzv0L9abiidCx5J
    tVseDQ7yLlthg1Tejy5ER+YqRz4DCdMnPdt17OYAkpqg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbeCWLU3 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:20:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41768 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755588AbeCWKIj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:08:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mario Kleiner <mario.kleiner.de@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 101/177] drm/nouveau/kms: Increase max retries in scanout position queries.
Date: Fri, 23 Mar 2018 10:53:49 +0100
Message-Id: <20180323094209.745952203@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Mario Kleiner <mario.kleiner.de@gmail.com>


[ Upstream commit 60b95d709525e3ce1c51e1fc93175dcd1755d345 ]

So far we only allowed for 1 retry and just failed the query
- and thereby high precision vblank timestamping - if we did
not get a reasonable result, as such a failure wasn't considered
all too horrible. There are a few NVidia gpu models out there which
may need a bit more than 1 retry to get a successful query result
under some conditions.

Since Linux 4.4 the update code for vblank counter and timestamp
in drm_update_vblank_count() changed so that the implementation
assumes that high precision vblank timestamping of a kms driver
either consistently succeeds or consistently fails for a given
video mode and encoder/connector combo. Iow. switching from success
to fail or vice versa on a modeset or connector change is ok, but
spurious temporary failure for a given setup can confuse the core
code and potentially cause bad miscounting of vblanks and confusion
or hangs in userspace clients which rely on vblank  stuff, e.g.,
desktop compositors.

Therefore change the max retry count to a larger number - more than
any gpu so far is known to need to succeed, but still low enough
so that these queries which do also happen in vblank interrupt are
still fast enough to be not disastrously long if something would
go badly wrong with them.

As such sporadic retries only happen seldom even on affected gpu's,
this could mean a vblank irq could take a few dozen microseconds
longer every few hours of uptime -- better than a desktop compositor
randomly hanging every couple of hours or days of uptime in a hard
to reproduce manner.

Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nouveau_display.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -106,7 +106,7 @@ nouveau_display_scanoutpos_head(struct d
 	};
 	struct nouveau_display *disp = nouveau_display(crtc->dev);
 	struct drm_vblank_crtc *vblank = &crtc->dev->vblank[drm_crtc_index(crtc)];
-	int ret, retry = 1;
+	int ret, retry = 20;
 
 	do {
 		ret = nvif_mthd(&disp->disp, 0, &args, sizeof(args));
