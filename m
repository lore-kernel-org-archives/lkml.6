Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521803380-2-2260054109389837341
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_RHS_DOB 1.514,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521803379; b=KcZoZ1u73YlZ8XbOv/q4UJ4Im9Asli4PbWPQrXSiITi1urE
    q6jPJge38rpwI3k6fRMeYRsEnYVKAVGJwOBcMmY4+qRDxNjYkS7ozdDWYLXy5pCo
    Qp/EYpPSl+Dtn1LA2+B1WahFYouEX80o0eD7sFT7E/rNh1/bP2obFqmeMKh3YJCo
    533vExj/pT/U2KcbVaYkkrxV0OstcZHIvMTXEJ092+/4xNV9jb8pbveISAkqE7uD
    AlNj+jsjtg9XdLM+Te5bEPp17VtVArMXYpGCcWDoKQK1MNzuCiiry2UT72zjDNcO
    rgZF+wBgPiQpeLn5HI7TPth4IqBnJ5J8D851tVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803379; bh=GckTRq39EWjE2SH6dnNdyL5JT8
    iWzVod6tQzUudOX9I=; b=Rnw/SweEgipHbCFw/LrSIAcc3G5AdueCm+w0gET18u
    kJ/87dhQR2gmzOY5+oO2jWTmMTJ0uC/vjVQ+Y2/eotMwEWbgmHfgY5MI9sYA0KFp
    EPnufnhtCyAIf7N2L9uZGzjxsPN6vXqYlBXgzI3DdoDK9kWPwHmkeb02yv/HxBFX
    CDMz2/3y+B8UPJdi2f7/TNNN0L9qiwpB+lvp9yW6PIJpGoh9S4jO8wAIpEqGlocV
    Z5gqM7iNQ+UMHNOZWjaiA9I/0Q2GfpKf1huY1kn09oO/h5AKbIVerAE2lNc+0jCR
    NUIw0j6umyQVJpp15Ipdx+lwoEIlwhGFbuVxMA+g+8ZQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
        id S933019AbeCWKLh (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:11:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43922 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933002AbeCWKLg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:11:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 136/177] media: c8sectpfe: fix potential NULL pointer dereference in c8sectpfe_timer_interrupt
Date: Fri, 23 Mar 2018 10:54:24 +0100
Message-Id: <20180323094211.219307471@linuxfoundation.org>
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

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>


[ Upstream commit baed3c4bc4c13de93e0dba0a26d601411ebcb389 ]

_channel_ is being dereferenced before it is null checked, hence there is a
potential null pointer dereference. Fix this by moving the pointer dereference
after _channel_ has been null checked.

This issue was detected with the help of Coccinelle.

Fixes: c5f5d0f99794 ("[media] c8sectpfe: STiH407/10 Linux DVB demux support")

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
Acked-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
@@ -83,7 +83,7 @@ static void c8sectpfe_timer_interrupt(un
 static void channel_swdemux_tsklet(unsigned long data)
 {
 	struct channel_info *channel = (struct channel_info *)data;
-	struct c8sectpfei *fei = channel->fei;
+	struct c8sectpfei *fei;
 	unsigned long wp, rp;
 	int pos, num_packets, n, size;
 	u8 *buf;
@@ -91,6 +91,8 @@ static void channel_swdemux_tsklet(unsig
 	if (unlikely(!channel || !channel->irec))
 		return;
 
+	fei = channel->fei;
+
 	wp = readl(channel->irec + DMA_PRDS_BUSWP_TP(0));
 	rp = readl(channel->irec + DMA_PRDS_BUSRP_TP(0));
 
