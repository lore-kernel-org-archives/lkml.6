Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EA5C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 22:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27278216FA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 22:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27278216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeH0CKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 22:10:53 -0400
Received: from smtprelay0231.hostedemail.com ([216.40.44.231]:41676 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726802AbeH0CKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 22:10:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id DABA2180A8847;
        Sun, 26 Aug 2018 22:26:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: news54_3c9724538b734
X-Filterd-Recvd-Size: 1809
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sun, 26 Aug 2018 22:26:56 +0000 (UTC)
Message-ID: <eca48539a3dede3bfaed9ab9a6c06794cf8160e0.camel@perches.com>
Subject: Re: [PATCH] net: sched: Fix memory exposure from short TCA_U32_SEL
From:   Joe Perches <joe@perches.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Julia Lawall <julia.lawall@lip6.fr>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>
Date:   Sun, 26 Aug 2018 15:26:54 -0700
In-Reply-To: <20180826212421.GW6515@ZenIV.linux.org.uk>
References: <20180826055801.GA42063@beast>
         <20180826061534.GT6515@ZenIV.linux.org.uk>
         <CAGXu5jK7VzayzZTcxgZBf-+YHWO+Hv7s8utj2rzTc3gFtA8pFQ@mail.gmail.com>
         <20180826173236.GU6515@ZenIV.linux.org.uk>
         <d31fe59160e0b7d40e09536a3c74619ebb1f3b13.camel@perches.com>
         <20180826212421.GW6515@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-08-26 at 22:24 +0100, Al Viro wrote:
> On Sun, Aug 26, 2018 at 11:57:57AM -0700, Joe Perches wrote:
> 
> > > That, BTW, is why I hate the use of sizeof(*p) in kmalloc, etc.
> > > arguments.  typeof is even worse in that respect.
> > 
> > True.  Semantic searches via tools like coccinelle could help here
> > but those searches are quite a bit slower than straightforward greps.
> 
> Those searches are .config-sensitive as well, which can be much more
> unpleasant than being slow...

Are they?  Julia?
