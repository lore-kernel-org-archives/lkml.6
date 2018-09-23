Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF303C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 15:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529C821479
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 15:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529C821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbeIWVjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 17:39:32 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:48232 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726222AbeIWVjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 17:39:32 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1g46Vl-0000zK-Gt; Sun, 23 Sep 2018 17:41:29 +0200
Date:   Sun, 23 Sep 2018 17:41:29 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Christian =?iso-8859-15?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc:     fw@strlen.de, pablo@netfilter.org, kadlec@blackhole.kfki.hu,
        davem@davemloft.net, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, jmorris@namei.org,
        serge@hallyn.com, selinux <selinux@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 1/2] netfilter: nf_tables: add SECMARK support
Message-ID: <20180923154129.ht55keytmgxcnl73@breakpoint.cc>
References: <20180923091611.19815-1-cgzones@googlemail.com>
 <20180923135555.7kwa3kyachwcfy24@breakpoint.cc>
 <CAJ2a_DfCmbFmpTngFnXzYy07gvEzN5UhAhrE8Cd8PowevrLUNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ2a_DfCmbFmpTngFnXzYy07gvEzN5UhAhrE8Cd8PowevrLUNw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Göttsche <cgzones@googlemail.com> wrote:
> > Can you change this to:
> >
> > struct nft_secmark {
> >         u32 secid;
> >         char *ctx;
> > };
> 
> Does the nla_policy struct needs an update too? (regarding then .len member)
> 
> +static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
> +        [NFTA_SECMARK_CTX] = { .type = NLA_STRING, .len =
> NFT_SECMARK_CTX_MAXLEN },
> +}
> 
> NFT_SECMARK_CTX_MAXLEN might be dropped then..

Better keep it, we can always increase this later it if needed.
Given the length matches what xtables uses it should be fine.
