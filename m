Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521804495-2-3126798592721412076
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
    t=1521804495; b=NnR9xOsFycgVIPomxBqvx99yqjJpVpwpoiNkeYpM1919wDF
    2vQ3jftgSNmOZ3QRu949ifwm/6mh4s63gLzfs7vPb4TENuwaThpcNBzZKdHnPXdz
    idC8esT3Odb8kfzpgkE8wPwftyXdjDiuuLg7qdaj9XYU1DVaDFJgpKv2+X9fbizn
    ajU2Yj/VmC+hT3ND9SQEp0V2IWLqYwMCIwcTjdi0xG9WDumLvtqY/P7VMZVp4Ds3
    GL7oKmYgf4O0TFwvInz16W5zdr+irxhQLWYa9SiVTmtzUpZhfiDwDeSJefQ0WClX
    Bs/QjbGYwjqiuZ5tjwm3uvaKuHuYw2yl6g55Weg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804495; bh=Q3pQB7lrd288VpsLhgsDIC+iNx
    anG54xqDsm1zE3+WA=; b=nTCzRS8xMi2y2FqdhmDW2O4Cy03GmEZZYtIipZeu1q
    iuaMw3DFmsifQY4uUgXnjyxta/CPWYaFWrDA2gs9aXqG+uTy4XlyvIMj+A9GMknr
    /a/IehbLq+7JtWWJ+/CqHbOdoxx0FXkajqXEo53XQZKFJF6rFmaGH86bTtbcgw5o
    iZWN4EYvTY6n/pqWmcRVwtkqOgEkJt5+qTqFhrUmSPokik8l0x/qc0PFBcCu7ZZu
    e+Jm76yov3wxFezFpZCWtFGjvxTfjlJ0zjQOD3CcbcBHT9C4TqgkSqLzcTklZDva
    k3u/CA9IOR/p83O6nJO26NVdJXvw9sl1elupL3KRsk0Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
        id S1755339AbeCWL2B (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:28:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41014 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932218AbeCWKGz (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:06:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert White <rwhite@pobox.com>,
        Liping Zhang <zlpnobody@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 065/177] netfilter: nft_dynset: continue to next expr if _OP_ADD succeeded
Date: Fri, 23 Mar 2018 10:53:13 +0100
Message-Id: <20180323094208.206701990@linuxfoundation.org>
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

From: Liping Zhang <zlpnobody@gmail.com>


[ Upstream commit 277a292835c196894ef895d5e1fd6170bb916f55 ]

Currently, after adding the following nft rules:
  # nft add set x target1 { type ipv4_addr \; flags timeout \;}
  # nft add rule x y set add ip daddr timeout 1d @target1 counter

the counters will always be zero despite of the elements are added
to the dynamic set "target1" or not, as we will break the nft expr
traversal unconditionally:
  # nft list ruleset
  ...
  set target1 {
      ...
      elements = { 8.8.8.8 expires 23h59m53s}
  }
  chain output {
      ...
      set add ip daddr timeout 1d @target1 counter packets 0 bytes 0
                                                           ^       ^
      ...
  }

Since we add the elements to the set successfully, we should continue
to the next expression.

Additionally, if elements are added to "flow table" successfully, we
will _always_ continue to the next expr, even if the operation is
_OP_ADD. So it's better to keep them to be consistent.

Fixes: 22fe54d5fefc ("netfilter: nf_tables: add support for dynamic set updates")
Reported-by: Robert White <rwhite@pobox.com>
Signed-off-by: Liping Zhang <zlpnobody@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nft_dynset.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -82,8 +82,7 @@ static void nft_dynset_eval(const struct
 		    nft_set_ext_exists(ext, NFT_SET_EXT_EXPIRATION)) {
 			timeout = priv->timeout ? : set->timeout;
 			*nft_set_ext_expiration(ext) = jiffies + timeout;
-		} else if (sexpr == NULL)
-			goto out;
+		}
 
 		if (sexpr != NULL)
 			sexpr->ops->eval(sexpr, regs, pkt);
@@ -92,7 +91,7 @@ static void nft_dynset_eval(const struct
 			regs->verdict.code = NFT_BREAK;
 		return;
 	}
-out:
+
 	if (!priv->invert)
 		regs->verdict.code = NFT_BREAK;
 }
