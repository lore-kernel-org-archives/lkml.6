Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C671C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BB420841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iSv+YJPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BB420841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbeJKSEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:04:34 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55675 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727851AbeJKSEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:04:33 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B9BFB21F39;
        Thu, 11 Oct 2018 06:37:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 11 Oct 2018 06:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Z4EsgP
        +JPWR35RPAfe9tNVUDJ7nDmAbJ3BggOgiX7io=; b=iSv+YJPiOASZSyHPxbA6Tw
        eK/u6jUI30jOJNIyM7Zw5OVs4DLgZMl1YH43D1imWOkq+1qlLOysmYEhZguvOKxQ
        9mN0mXiEg+D5I6blm5YvOX1ORa6AgU7qQhah9PePTCkOrSw+p4F8o18EY4EXYfIc
        HZP892NY3bzH7OQVpZHY4HpJRwUw4YdREzOL4D/EVMZ4tnbmMN6HRGCtMTbJv8NM
        SW+DRBDpz4GUrKD/KW0QfzpgsuaE9QYYNmNdiwd6jxaeAw9PtOVoTDitt4dyh54y
        xiWtynWNPnBv9izYcKdI8PRcJsIk/pOsg1UGhqz7/h6UaOR7F4dgUTir3rYbW93w
        ==
X-ME-Sender: <xms:ACi_W65CL6zUX_c9BVm8XeUUKDvE5lXU15va22SO4u6shO8E-x0Xcg>
X-ME-Proxy: <xmx:ACi_W8QB5sGGj7NPInqHG6C8z-gveBJ-a7myDdCySCD8B-ZTP8t-TQ>
    <xmx:ACi_Wyh0XWqkCnA6D-X_oXXVTS52KlAO98xI-7xYT2tnjH7q5JqTTQ>
    <xmx:ACi_W4iEpU-LHFDA_MISi5RlSaw1T2G1buUWxwbnkkSB4gVU7VFz2Q>
    <xmx:ACi_WyY1Bh73-aAzdeF7r0JdxGGG97YLRZrBxJo0X7GXDtrgvRv2LA>
    <xmx:ACi_W5WEI-ttAA6pXDy9lbQLRXaIMb1gSkjd3cuYs39GFj7FMbLFeA>
    <xmx:ASi_WwrJ-dQSNVeo6TBT2liOknYLGckyXgZe-1xxpj7NDtXjWpog8w>
Received: from localhost (unknown [178.228.10.138])
        by mail.messagingengine.com (Postfix) with ESMTPA id F1EC0102DD;
        Thu, 11 Oct 2018 06:37:51 -0400 (EDT)
Date:   Thu, 11 Oct 2018 12:37:50 +0200
From:   Greg KH <gregkh@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>, arnd@arndb.de,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus <torvalds@linux-foundation.org>
Subject: Re: linux-next: build warnings from the build of Linus' tree
Message-ID: <20181011103750.GA29735@kroah.com>
References: <20180824172053.20fa197294f51496dcec5605@kernel.org>
 <20180824204756.e787765461975cd1e27502dc@kernel.org>
 <20180824224211.2934d7c0@canb.auug.org.au>
 <20180826171058.e07f99e6e03f7497e5a46ed3@kernel.org>
 <20180828072333.36af4d5d@canb.auug.org.au>
 <20180828094341.d20d8fbcb9dca310d44df951@kernel.org>
 <f0ca0036-abe1-4252-6d30-b810dd22097d@linux.ibm.com>
 <20181011114809.5590ecb3@canb.auug.org.au>
 <d5b166d6-461c-f382-e3d2-8993b845bd5a@linux.ibm.com>
 <20181011205849.6f6645fa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011205849.6f6645fa@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 08:58:49PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> On Thu, 11 Oct 2018 09:44:36 +0200 Peter Oberparleiter <oberpar@linux.ibm.com> wrote:
> >
> > On 11.10.2018 02:48, Stephen Rothwell wrote:
> > > OK, I have been carrying this "quick fix" patch in linux-next since
> > > September 7.  Is anyone going to pick this up and send it to
> > > Greg/Linus, please?  
> > 
> > Sorry about that - I posted a modified fix at
> > 
> >   https://lkml.org/lkml/2018/9/13/367
> > 
> > but didn't get a response. I guess I should have reposted sooner. But
> > before I do that:
> > 
> > Arnd: Is this something that you can pick up or should I include someone
> > else?
> 
> It would be nice if it could go in before the v4.19 release because the
> commit that exposed the warnings went into v4.19-rc1.

I agree.  If someone could at least review/ack it, that would be great.
What tree does this normally go through?

thanks,

greg k-h
