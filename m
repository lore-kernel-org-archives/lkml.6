Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2859260-1522260857-2-11360733612151862815
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522260855; b=W8FrsdLUir1a0jASOycIb8qwTzuu2VzHo41WGYM5aplukaw
    BxfYRZVYAgrv39pwzvD/Qfi+tAMvoh0jpYyv+GdTCvlxmSUTgyD8M3/j2LAXaZZO
    lu0/WG8edgkilxrlGchjR7//obGPAoD4hw5Inz6qIS06yP7azZmcjoUWPx+vyES1
    1A1D93U5O+I/hfTBjZjnPuz0GgFy3xYm3RRP1g50XOQFb++QE99wbiOgU7Ic/vrU
    Tafl0tHL0oIsNojX63IvlKSYCO9FAocG9z9G94Gn/wddT3xbziuYRnq3d2KmMXE7
    heoZYxFlrCcxhy8wPNlCEIUAEFWS3J6LlISf0ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1522260855; bh=61apyH3WqiioYq/kTW8tKMn8WOybxvrIzFP
    xiKPHkoc=; b=uFO02Ijvcwb4FAgTvozGWflGrR2br1ILNXC8Bch3bD9P8FSwECD
    JCeaZd5T+TTonbJRt5pI3SIc12gdc67nEuBvqvvRibL5VTCbWbk+EPPrFZgB5tY9
    edxBFSqyawwy94BQ8o80+71wziYq0Oo+J49sdPj4Zn1AUK+d8LADkgQqG6AYt8Nq
    5Cp+wjv7IqJ2/1jatDgIxeWxHtxyQtamqTls2cLIoepqdgksqXnMb9WnRx/9ycHq
    EI2kYQzvxAQSLFQnBq2vLREeDzcKgfPHCS/aw4OC7dx284v6gn6ufnjWAS/maEvA
    xW/tVhthmBuBTYMFE8r95EbiMqGoKtQmZww==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=s-opensource.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=s-opensource.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=s-opensource.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=s-opensource.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB23pMnl1OfonFUBUrgIdjpyPU9cZAYUWQLUyqZguEjeTVTCaC89SxgJqpPuVA3Z8xfKsfH8a8AWdYn7iOzPxhBd0+qfV2RWMEuNcbo8xJ1WUWtkfqVK
    3ZumdSe3ay4mBmNeYGe1im0FzBHgH40ryMFVSmpsuOHm98TpO/1IjRv3tAwBxo72C6O4bFj0f7Jy/k6+xdaM4rpGDQV9GSCTGhTrIc4vuHiaWXv7RMm3Ktn2
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=AUd_NHdVAAAA:8
    a=QyXUC8HyAAAA:8 a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8 a=t67oJYobhs1EGYhFwloA:9
    a=NGXS0kB0m_rannUenejW:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753656AbeC1SNV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 14:13:21 -0400
Received: from osg.samsung.com ([64.30.133.232]:33646 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753632AbeC1SNU (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Mar 2018 14:13:20 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Media Mailing List <linux-media@vger.kernel.org>,
        stable@vger.kernel.org
Cc: Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH for v3.18 01/18] media: v4l2-ioctl.c: don't copy back the result for -ENOTTY
Date: Wed, 28 Mar 2018 15:12:20 -0300
Message-Id: <81169feb046d1b88c0b3a2ee83de5921d11f8102.1522260310.git.mchehab@s-opensource.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1522260310.git.mchehab@s-opensource.com>
References: <cover.1522260310.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1522260310.git.mchehab@s-opensource.com>
References: <cover.1522260310.git.mchehab@s-opensource.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans Verkuil <hans.verkuil@cisco.com>

commit 181a4a2d5a0a7b43cab08a70710d727e7764ccdd upstream.

If the ioctl returned -ENOTTY, then don't bother copying
back the result as there is no point.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 9ccb19a435ef..bb2387fcbfee 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -2539,8 +2539,11 @@ video_usercopy(struct file *file, unsigned int cmd, unsigned long arg,
 
 	/* Handles IOCTL */
 	err = func(file, cmd, parg);
-	if (err == -ENOIOCTLCMD)
+	if (err == -ENOTTY || err == -ENOIOCTLCMD) {
 		err = -ENOTTY;
+		goto out;
+	}
+
 	if (err == 0) {
 		if (cmd == VIDIOC_DQBUF)
 			trace_v4l2_dqbuf(video_devdata(file)->minor, parg);
-- 
2.14.3
