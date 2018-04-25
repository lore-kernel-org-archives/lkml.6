Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-488755-1524652625-2-2505356460363170215
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524652623; b=a2QaUCB3XBSJ/j4+KajIiiROCHkuIOuXlCnzNLurJz4IoL3K3e
    t0Fr7cA37E2avaURDL6739UNT8fcGvgcGpchcXiWTworsBIjc6c29+kwz3UyXPdM
    K1S8ianwv+npCMN1exMQTjcPCVbveQg/SDhdqwl3noy0Kz4k+mi5DZqWu1A3G50c
    IHT9uc44umAkxk8fCZ5ErLstXlbZQn4smpZ+WwyP7nIe5YwsMiQ8RkA4jUA9ng6O
    qm5QjTDOxwAcc6AwfrxPQmHHlk6tg/1bKE7FJXds5F/Yzc8EgZvnWgcF2TxCUNbJ
    36H7BTb8iEeoOvcVn04bfdfLpN++yE101eCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652623; bh=l+aTdZyfgNgpKLsYJDBYi4fWUIKToX
    aBcZVGHU2ob4U=; b=s5SJ6w6IZokL8oNqHVqLrgaiWi98JaYMvUBA46/lg4uXMo
    9q+nlcrMhl4Qot5iMlXZQYVxvT8wyIfDVStx0XhjDZVH3B/skTRfzU/UcUNbpxtx
    hKmEqOueA2qT6doAbQhmapNHIRRoGE9qTt09T75Pq2ZEFDy/HJ253NlOBclBgGIq
    JHGmcAZJI4j7zb4j4QjPBuIQKDndue5vK9X6vMRMIYlmm/8K13iNbvpa8kdsqWdL
    oQ6f82m25aslo/fNR+Pp2RJ9kcaON395EGZzt/FYJFqVznlBR6uhaHSeBuLiNU7o
    buDayiBXl5JZivmbqIRHoz9R15pD+26z9GlFCgMQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGq0lSZnASDnlKmu6E6pMv6Z4CIN6yyLda5kLRJRUyh+ImxyKFi7T8MvJf0a/IaetEqDl8eFqkYs87t0I0T0iklo+smgPKRekNfnBb/OibR5DOh2sasQ
    al7beifnzouYI60QgMSEi+Uk5BTqP9ClaRIC05Btqr986vCYKCsTTUAeEr3b2paW1m6IeUteAL4SJ290XYDUgeDH8yvhvOtq9mJR1lhA5Uzmn854GU6BxdJb
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=3HDBlxybAAAA:8 a=ag1SF4gXAAAA:8 a=H94YMeAY_uT0aJD_LjIA:9 a=QEXdDO2ut3YA:10
    a=laEoCiVfU_Unz3mSdgXN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751741AbeDYKeb (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:34:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50858 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752771AbeDYKea (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:34:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.16 22/26] netfilter: x_tables: limit allocation requests for blob rule heads
Date: Wed, 25 Apr 2018 12:33:31 +0200
Message-Id: <20180425103315.732357223@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103314.842517924@linuxfoundation.org>
References: <20180425103314.842517924@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 9d5c12a7c08f67999772065afd50fb222072114e upstream.

This is a very conservative limit (134217728 rules), but good
enough to not trigger frequent oom from syzkaller.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/x_tables.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -818,6 +818,9 @@ EXPORT_SYMBOL(xt_check_entry_offsets);
  */
 unsigned int *xt_alloc_entry_offsets(unsigned int size)
 {
+	if (size > XT_MAX_TABLE_SIZE / sizeof(unsigned int))
+		return NULL;
+
 	return kvmalloc_array(size, sizeof(unsigned int), GFP_KERNEL | __GFP_ZERO);
 
 }
