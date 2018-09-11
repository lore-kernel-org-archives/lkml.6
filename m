Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97514C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BC720865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 22:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="yfSi0H+g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nClL6Bmm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35BC720865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeILD11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 23:27:27 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:58079 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726885AbeILD11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 23:27:27 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id BBA30405;
        Tue, 11 Sep 2018 18:26:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 11 Sep 2018 18:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=EX9fz+jznYzp6OjyJa09OmG/gL8Tu2NLPviA3H5ND9g=; b=yfSi0H+g
        XnO3NnpnNlWPwFNPixbktkqBaSnrvp0zcSTSksVcyL1u5J1L6pfYSibHxobXFueh
        sJfyEre2kL3I+zqdad6OeUHpxRXKO39YA2ti0EPHyluFUXlE23OLhPQWjdi1DdZI
        b4EQUfHwQe6mno+2VFv6NET3tr9F0XJxmcQt+sMKYelBy83GA7OkuJrIzmsbCMYL
        LkeJ9B+zn65B3msiJ8t3Wcu/Z9ZlvHRhzBq9cvaesbIDSxorHBfZ2tirPNzxRGOg
        2Q9UX5Y3Z5t3AMDYoFD+K/zQLWIkx0FTofoFuxM3wNbSFFKkZEV2g0PL10kwr/7z
        L4S9B9pCdwwNYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=EX9fz+jznYzp6OjyJa09OmG/gL8Tu
        2NLPviA3H5ND9g=; b=nClL6Bmmooj/K44VLzNkI+BarJO8FEIDGmJBBzi7k1VOl
        P3lMK1bde2oFd/z7AEHzS+XOaK2mbcfcFdgU1agDVTrJcF7bi1VXCIpncaM3WjmD
        7WYw1cE+IrIsPW0ZI12qNqcaPPlMWf2hXgeOf+Tg9yzhqfTtR0o7GI7aKSHkwMRW
        VVqjGUX3Otamcn17Y3Xiss9seU1j6PteCTAKYBHVJlo3WzdzejexBlQvLlfMzvnP
        nLXobr4PILOWDdX7RVB4fVDzdGYdM6WeZ7piXxeaXZKigxXo23aff1I9c3RkUDwl
        m9QarPmt6sAsE9pXXYi4XPK5lTJvPuEMJhPELNQ5Q==
X-ME-Proxy: <xmx:-UCYW13G1iB1lqE6zkk2swzRkv-5wwEQniRP7SJN0Si9TuirmDj1cg>
    <xmx:-UCYW8T5rqlSb1n9pCEha9C0NeAA6EFz71Uoe0COX0gy-24xt7ZRAQ>
    <xmx:-UCYW3u5cNTV5qDAkr3N8Vspi9BVhuNei_kGhMjMBCYsHyKIKdcVhQ>
    <xmx:-UCYWxb5zUtbOKKWvGxoJldugx_qXgaP6Z-idHcG0GyD0_7NiFhQgw>
    <xmx:-UCYW8u9XKaEt9HrIo-2JZAkCojYBermPUfJQtqzoju4LdqPMgiLiA>
    <xmx:-UCYW2r20vB4FCC7vpxVtjkD0T5Ht-v6pGBkuhr_G-l7HFCjbBD7Mg>
X-ME-Sender: <xms:-UCYW_h47mV11aohVH7eHm0Hr_WHKmSqK0HVJkuhVYN7Q-HPTnQCXg>
Received: from localhost (ppp121-44-246-110.bras2.syd2.internode.on.net [121.44.246.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id 999F3102A0;
        Tue, 11 Sep 2018 18:25:59 -0400 (EDT)
Date:   Wed, 12 Sep 2018 08:25:55 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND net-next] docs: net: Convert tcp.txt to RST format
Message-ID: <20180911222555.GD3854@eros>
References: <20180911071324.11199-1-me@tobin.cc>
 <7f50abcd-f2fa-c043-9e5b-8e5ca89c52a1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f50abcd-f2fa-c043-9e5b-8e5ca89c52a1@gmail.com>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 03:30:19AM -0700, Eric Dumazet wrote:
> 
> 
> On 09/11/2018 12:13 AM, Tobin C. Harding wrote:
> > Restructured text is the kernel documentation format of choice now.
> > Some text from tcp.txt is out of date, specifically the function
> > tcp_write() does not appear to be in the tree anymore.  Also the
> > following data members have been removed
> > 
> > 	  sk->tcp_pend_event
> > 	  sk->transmit_queue
> > 	  sk->transmit_new
> > 	  sk->transmit_end
> > 	  sk->tcp_last_tx_ack
> > 	  sk->tcp_dup_ack
> > 
> > Remove section 'How the new TCP output machine [nyi] works'.  This
> > leaves only a single section so we can name the document with that
> > section heading now.
> > 
> > Convert tcp.txt to RST format.  Add GPLv2 SPDX tag.
> > 
> > Signed-off-by: Tobin C. Harding <me@tobin.cc>
> >
> 
> I dunno, this 'doc' is probably useless and should be deleted.

Cool! The best type of patch - line removal only.  I'll put it in.

thanks,
Tobin.
