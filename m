Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1427278-1518184550-2-10444766944620863247
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518184549; b=vUQd8J3rk9cCvUmZYGlNtjvqxYhD8io1UJPIvNsNVwtAgr3
    HbM+YcjWSrLYnVbq0IRsQeaWeCHno9p9U+Y0xHJov6aYMm1iJK5t/QPwt0F4IYGV
    2/aEmx8+FeyyVNri27hLmjkRvG4UHCTD1N8LnPSVB5L5bRzgfY9SmO/HHf2yBlwL
    Vz0kOSZjYq2LHpNrbpMLNQSes6Gz4QDKOdSWtlA3za8YE44V4Cj6zTSOYzOkbCKN
    5lB94apWunj/lDG47L8xc0fu/avrsexfJl0I8+uk8FmJyKIQGfcFq8XAlhoCCqC8
    RWTZc+GlaHmr+K2ZoLsGLjead08duzkdWon6U/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184549; bh=PGUeU566rYMo+IeO4RrDvFDZoU
    uKRLuWFKm0QADVUz8=; b=htZHy/ffvYsK7cDzm26+ZnkjHMoVl6ggIFVWtBBFHx
    z2cQq599pB6Ibnd9/f0t3PZao/+uczXg08GAX+a6gts09dBmjTq8rlVHcCoXVp8N
    0O32BEen4quUW/BMShfHP+Ld3Ff5H10/WCDBfR3+zv0SVo/V7hk3BipCPq6LxKS1
    bX1M+twEI5gCKWpDtcIrZFCeY8BZyn60O6iW+1sIeSsmWhVWzgrQm5duQZwO1WAh
    UwzLRJFsgEtu7z0zeajlP6rcgssvwpGptKV10WPQ8S1NKHHoSAqoof5CbSrlSgjB
    RaKAMx0QSWsjcyWJRU+vPPBZW8oZ/nwibmkZ/uJGw1rA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753618AbeBINpX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:45:23 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51796 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753199AbeBINpV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:45:21 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jesse Chan <jc@linux.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.14 17/22] media: mtk-vcodec: add missing MODULE_LICENSE/DESCRIPTION
Date: Fri,  9 Feb 2018 14:40:06 +0100
Message-Id: <20180209133935.371152504@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133934.024795822@linuxfoundation.org>
References: <20180209133934.024795822@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Chan <jc@linux.com>

commit ccbc1e3876d5476fc23429690a683294ef0f755b upstream.

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/media/platform/mtk-vcodec/mtk-vcodec-common.o
see include/linux/module.h for more information

This adds the license as "GPL v2", which matches the header of the file.

MODULE_DESCRIPTION is also added.

Signed-off-by: Jesse Chan <jc@linux.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c
@@ -115,3 +115,6 @@ struct mtk_vcodec_ctx *mtk_vcodec_get_cu
 	return ctx;
 }
 EXPORT_SYMBOL(mtk_vcodec_get_curr_ctx);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Mediatek video codec driver");
