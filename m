Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F5BC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540EB21AA9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="pHDSipKW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CxGZVL/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 540EB21AA9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731707AbeHIAm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 20:42:57 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37815 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731564AbeHIAm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 20:42:57 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 87A4920D9A;
        Wed,  8 Aug 2018 18:21:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 08 Aug 2018 18:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=OX6tQx7ps+SZlK3fKMH1jWQJjkFGCJdebm5bDBLM71I=; b=pHDSipKW
        wCoEKXvaOnBK2oeKx0ri8j2QPF1Upvg5sO740Yf70zPT+bp7bzRR2xYAc/YBC9L+
        o+12Kvcql1WF7jVnCs2N6v1n2i1Zfmy2RMFhBWuEKbaLf0AumvkeA3j+xK1JB8qp
        JwoYw0P7tdWS2f6PiYyMMLs/Amb5/L4FOffPwVjzQHh6INM+BZcG5GmL2KY5ItJl
        s9kD+JizfDcDYEcF68pd2bCDfc2iym5E2PQbGwXlqMo1XOnBXKB3j1bKstDRqNEP
        4jU+zcwCt/s1jKV04Jtth+/epi116Jg6x41HU319AkYf1nyauFzWfDJlm/OOLBY9
        IWz9D3W7LfWpVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=OX6tQx7ps+SZlK3fKMH1jWQJjkFGC
        Jdebm5bDBLM71I=; b=CxGZVL/xfJqlhVy64Ui8Om6Ni9RScGBB/OyRIoyWDBJqC
        jjmhDJ5potS2toRV8QOLadjZXQZFvuqOCDEkJXBNvPffJudUNEjaObf/ndIWMwD5
        FBa1+U/aYN10iHsIP32XK9VUQikrBZbSsGiL9yKeaFKEh9LziZ6sPgUmyR+7KQkx
        oHoTbIyyb677ap9ChWvwEaKBv0v1oajXyy201eAc5GDBjxAMi1bNiRX/OKQpKIfl
        lRNsfYIYnYYzx6aohOgtSXqGDUh5kX3CyoovKmx95onMgBkq4ZbnFUw+PsnNYacz
        1LK2I3cP64ScCDZJ/d6t1urxMym7kGNjUhXuIKxxg==
X-ME-Proxy: <xmx:2mxrW1w8p9MR0LL82bg-EFG1f5UlN0t5XKDfJbG_zJd5nfHpIYRbng>
    <xmx:2mxrWxcH5K1pZBx_JgxAEkSml6YQi1cLGnikfz_fj_KVZUvi60Fstw>
    <xmx:2mxrW2cVemiHr7TC2R_D_2t6TgRg_k761X96o2Yo_cR_oBSVhlIkBg>
    <xmx:2mxrWzEJtSavJf9e1K74H2LVdhcPtcuVM8ggnqu2Li3lnexC_d0HuA>
    <xmx:2mxrW4WP9vn4APxgBkfoRyL7_-Ic_pESEnvTUie56dnX9rq00wWCKQ>
    <xmx:22xrWzCH1BYMhohFP1RKfvPXjCQUyqU1m2N-hXbsuJySbRrwQlli_Q>
X-ME-Sender: <xms:2mxrWwtY0Ck9ayvOV6jKuP1KeEaQMXS7Q8a9th68bRDj7Bb9lrw3WQ>
Received: from localhost (ppp121-44-213-17.bras1.syd2.internode.on.net [121.44.213.17])
        by mail.messagingengine.com (Postfix) with ESMTPA id DEE2610261;
        Wed,  8 Aug 2018 18:21:13 -0400 (EDT)
Date:   Thu, 9 Aug 2018 08:21:10 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Markus Heiser <markus.heiser@darmarit.de>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 12/13] docs: net: Fix various minor typos
Message-ID: <20180808222110.GH11191@eros>
References: <20180801050908.29970-1-me@tobin.cc>
 <20180801050908.29970-13-me@tobin.cc>
 <76cf11bc-61b3-8068-5546-79d3ff3a58e9@iogearbox.net>
 <20180808014248.GF11191@eros>
 <20180808072310.4695cea4@lwn.net>
 <99c50323-601e-91ea-cac3-98c1f381f9ac@iogearbox.net>
 <1cfb4fb3406621c1ffd98e8072f2cc38812107d8.camel@darmarit.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cfb4fb3406621c1ffd98e8072f2cc38812107d8.camel@darmarit.de>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 06:26:50PM +0200, Markus Heiser wrote:
> 
> 
> Am Mittwoch, den 08.08.2018, 15:45 +0200 schrieb Daniel Borkmann:
> > On 08/08/2018 03:23 PM, Jonathan Corbet wrote:
> > > On Wed, 8 Aug 2018 11:42:48 +1000
> > > "Tobin C. Harding" <me@tobin.cc> wrote:
> > > 
> > > > Thanks for doing such a careful review that you noticed this.  I'm
> > > > working on this more ATM and I've moved the document to use double
> > > > spaces between _all_ full stops.  Currently the document uses mostly
> > > > single spaces but there are some sections with double space.  The
> > > > internet tells me this is a 'style' issue not a rule.  And I've seen
> > > > single and double spacing in tree and do not know if one is favoured.
> > > > 
> > > > Do you care? 
> > > 
> > > I'm not Daniel, but let me just say that, for docs in general, I'm
> > > absolutely uninterested in patches adjusting the number of spaces after
> > > periods.  It really doesn't matter one way or the other, and I don't think
> > > we benefit from that kind of churn.
> > 
> > Yep, agree.
> 
> FWIW: even if it is not a patch worth, 'fill-paragraph' within emacs benefit
> from.

That's why I originally started using double spaces :)

thanks,
Tobin.
