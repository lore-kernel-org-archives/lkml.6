Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EF5C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7BB2075B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B7BB2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbeKQMsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:48:41 -0500
Received: from smtprelay0012.hostedemail.com ([216.40.44.12]:50084 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729714AbeKQMsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:48:40 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 323A5100E806B;
        Sat, 17 Nov 2018 02:33:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: toes79_329f9f93b808
X-Filterd-Recvd-Size: 2399
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sat, 17 Nov 2018 02:33:41 +0000 (UTC)
Message-ID: <138f1c15387c47fe65f4a0448f35afdd9db81933.camel@perches.com>
Subject: Re: [PATCH net-next v2] geneve: Use empty braces for addr6
 initializer
From:   Joe Perches <joe@perches.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 16 Nov 2018 18:33:40 -0800
In-Reply-To: <20181116153701.GA16184@flashbox>
References: <20181112221248.11477-1-natechancellor@gmail.com>
         <20181113061146.12182-1-natechancellor@gmail.com>
         <20181116150432.2408a075@redhat.com> <20181116153701.GA16184@flashbox>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-16 at 08:37 -0700, Nathan Chancellor wrote:
> On Fri, Nov 16, 2018 at 03:04:32PM +0100, Stefano Brivio wrote:
> > On Mon, 12 Nov 2018 23:11:47 -0700
> > Nathan Chancellor <natechancellor@gmail.com> wrote:
> > 
> > > Clang warns:
> > > 
> > > drivers/net/geneve.c:428:29: error: suggest braces around initialization
> > > of subobject [-Werror,-Wmissing-braces]
> > >                 struct in6_addr addr6 = { 0 };
> > >                                           ^
> > >                                           {}
> > > 
> > > Most initializations of structs in the kernel seem to use this format.
[]
> > So { { { 0 } } } seems to be the safest option. We could go with static
> > but it looks even uglier to me.
> > 
> > Joe, suggestions?

If this is really an issue, I don't know why the other uses
haven't been reported.  Perhaps change the rest of them too?

$ git grep -P "struct\s+in6_addr\s+\w+\s*=\s*{\s*}"
include/net/ip6_fib.h:          struct in6_addr in6_zero = {};
include/trace/events/fib6.h:                    struct in6_addr in6_zero = {};
net/6lowpan/iphc.c:     struct in6_addr network_pfx = {};
net/6lowpan/iphc.c:     struct in6_addr tmp = {};
net/6lowpan/iphc.c:     struct in6_addr tmp = {};
net/6lowpan/iphc.c:     struct in6_addr tmp = {};
net/6lowpan/iphc.c:     struct in6_addr tmp = {};



