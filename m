Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2859260-1522260792-2-11483721485372786363
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
    t=1522260791; b=USvw/c2OR8MN2cN/hNzLtE4YNgdvwNiBQOAt9b6m8NWzeIn
    iLHF9EpkyQGwhSDTQFH9aw3XLr2JLt0GQAgmypRFtLtFmC705mJjWKDFbmgUIqKL
    ZS3fnd94ywZAuNPjd5FsR2aq1oZKub6oru6MYYPD9fwwXZMFGQ/8gdUI0oDm8WwC
    glaZNoWn5H0jQuRpK39SRsY/kOwSvDVlcVjGtB7pimy/nAN+gkkTmxd/doHcXnsU
    MkwCti9qyR9k/OrkN7YDtw4c31iRX1sZ8I0KKRg4cwRRyP4plUf99CkSgKzhW6mb
    KYy7hIMiQrfaQ7SzfgsLeey3dDivkQET+lIjCfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=arctest; t=1522260791; bh=0mmn0rDTWTuXU0HdamFDLi+XIwLp+TwVcZA
    6BsUc2HQ=; b=w/FgmE15OX6r9C4u/bbdqhazyW6WcBGbT6Qck4vaCm6XCQGOP7s
    q5wSviNj/A/8l6NB4G85+yAcuNxCUj31sCFr6k0HhOXdldVvrOHhtTxzBqwCX4oQ
    oeBjjMxPq7QhG1cgUZojiSFgO9SKUGzKpbCfK+al+NKQv5M3GzPPgPr1WvxRWpGI
    3DTEwmER3lVAt957jTwE1k1xVKLkjsPJSik1lE1ls/hHhDKvJXQrhDsXTPxsUhKX
    juvdlQ45B0tsIZwPTk4XZ39jKiGusJP5ejTXYvqHCdm1VFRIpZEPemrUpUWl0+cP
    wOtvEYC79G9IS0grb2dvtMKYxo4lqKCZjaQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=s-opensource.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=s-opensource.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfCGucsKSIVr9PLbFjq1ChZsHusUbUFxDpbVSSDXDy6zgrTSSphyECM5Ef7XSglKzTmoYi23awtRXnmyhvpuM6iWG76+1ie5r+by1WERk0ifj8PYnVA06
    UbNdeuc2hn2+VN5Bb+CpfKI8gC4bIcJ5jm8EuBptK+WA86uuOYEh8VjqtVhK74MSOrZshvDFMY4d3/H9J4t9zy6j6n27KwlUC+41/Mn6SwAIo0JOHkuwArhk
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=AUd_NHdVAAAA:8
    a=QyXUC8HyAAAA:8 a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8 a=YP2KvR8Wy1L_L1kZNSwA:9
    a=NGXS0kB0m_rannUenejW:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753010AbeC1SNH (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 14:13:07 -0400
Received: from osg.samsung.com ([64.30.133.232]:59787 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752995AbeC1SNF (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Mar 2018 14:13:05 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Linux Media Mailing List <linux-media@vger.kernel.org>,
        stable@vger.kernel.org
Cc: Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH for v3.18 13/18] media: v4l2-compat-ioctl32.c: don't copy back the result for certain errors
Date: Wed, 28 Mar 2018 15:12:32 -0300
Message-Id: <9d0bb62c2dc7caee1fd2b9199fc1a22ec8479395.1522260310.git.mchehab@s-opensource.com>
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

commit d83a8243aaefe62ace433e4384a4f077bed86acb upstream.

Some ioctls need to copy back the result even if the ioctl returned
an error. However, don't do this for the error code -ENOTTY.
It makes no sense in that cases.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
index a5f74a508f58..9e5807842dad 100644
--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -943,6 +943,9 @@ static long do_video_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 		set_fs(old_fs);
 	}
 
+	if (err == -ENOTTY)
+		return err;
+
 	/* Special case: even after an error we need to put the
 	   results back for these ioctls since the error_idx will
 	   contain information on which control failed. */
-- 
2.14.3
