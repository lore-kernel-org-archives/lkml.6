Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED81DC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5F3223A6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="WWOOEBwo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GyXc+eTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5F3223A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeHKA0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 20:26:01 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:35137 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725754AbeHKA0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 20:26:00 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A9FA821E;
        Fri, 10 Aug 2018 17:54:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 10 Aug 2018 17:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Z0fwvBjK/vhko80D9qlRnuU1JQwHLv8owOQaQ+OaGR0=; b=WWOOEBwo
        jJ3B13KJlW5m8640j4/jS/Rf8zZivhKz5ImrRtFZPQLY0H2Jsa7+kK0K9dQZ5RoU
        IHh5CAJNbBfN+A86bu3WvXXxiqzViVR2g/T+auqqaP+DUUVhqs7209+T9J/+XLaF
        e6aUIYFjvqAQWAyTtb2FSCiGc/i+vVuNPk65Iymdu3BPEc/lrcjwAcna59QHAGI1
        p2/wgTDHs8nlctJZbL55/pkkacM+WAzWn/lk4uqvbUveH2sMChu8dqaORHzhN5VW
        kOYtjplit8/EnmKDGv2kjqS/y3wwAxpf91rt5JJub+lgIllK97hOFUc/mHIY9KFi
        bi0PCWNsiq4u7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=Z0fwvBjK/vhko80D9qlRnuU1JQwHL
        v8owOQaQ+OaGR0=; b=GyXc+eTGVMro56QyC3fk5Nhzm6UtuNPKx9jmi6Q5uvqXR
        XixFsipoWjUjFhcdL5My6J3bm8k7IC1RFe8uBbxdisLnhnQwzz+c9K44BiBUXCaO
        g2sxLeTfdpbjC/ke8oTIIslZTPcEKkUhyQClsEsCXK+YTD6F2WygdmkJaVb28SZF
        NyhIBKW6pZK+vVxat0XXrv0hUfpnj7mVttk8ytJjvUByLfkZ7iub9tY68Sd6Yemj
        NAthvc+tbQBJ08td3kMkiXVbKnfZTknDpoR5gtoFFcbJ7gufEOjulOfcYQ3roCaf
        t4Zz8GdO7FY/7uXpwwtKnLCrI3RloWc5xA0eKL02g==
X-ME-Proxy: <xmx:iAluWzRqbSnsP24f1QBJlhIYopVGXadmKQ9dhjb4Z6GBxq5NUFBfdA>
    <xmx:iAluWwcpl2SAsUHaGmQ-o6KyRNdnOIBBW4BxWSwmvg6C8ejqDDCkXQ>
    <xmx:iAluW1TDIbjfCULNS8F6o2BnaS5R7BNbyGNQ77C-T7AY5eBeLEDFqA>
    <xmx:iAluW8J6awEidpaxWG4b8Rrc4DZMsc_t9CycisMnLZ6kz2Xyq6hFhg>
    <xmx:iAluWyII6Goy1R0ecldqQM2NoiVnAuNHGg2CtbEil_IrPwbFoalNtQ>
    <xmx:iQluW07oQO6ICOoM3qEEbwVeL0KzB0EKcJQ26Oe27s8Xp0dXCb-0kw>
X-ME-Sender: <xms:iAluW4V7Kz-0I0YvVPeiEZSx8rfatLpW-ojkdqags2ncy5ulWiv8Kg>
Received: from localhost (124-169-145-41.dyn.iinet.net.au [124.169.145.41])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6955BE455F;
        Fri, 10 Aug 2018 17:54:15 -0400 (EDT)
Date:   Sat, 11 Aug 2018 07:54:12 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/4] Convert filter.txt to RST
Message-ID: <20180810215412.GM32374@eros>
References: <20180809052328.27942-1-me@tobin.cc>
 <20180809060734.rtqqu4sexbwzuqmm@ast-mbp>
 <20180809072753.GF32374@eros>
 <80bdc251-9f57-602f-6536-b34651684bb7@iogearbox.net>
 <20180810014636.GJ32374@eros>
 <20180810065752.2ab5473d@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810065752.2ab5473d@lwn.net>
X-Mailer: Mutt 1.9.4 (2018-02-28)
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 06:57:52AM -0600, Jonathan Corbet wrote:
> On Fri, 10 Aug 2018 11:46:36 +1000
> "Tobin C. Harding" <me@tobin.cc> wrote:
> 
> > Thanks for clarifying.  My understanding is now; this is a case where
> > checkpatch is too verbose and we do not actually need to add a specific
> > license identifier to the documentation files (new or otherwise).  They
> > get an implicit GPLv2.
> 
> The objective actually is to have SPDX tags in all files in the kernel.
> That includes documentation, even though people, as always, care less
> about the docs than they do the code.
>
> As I understood it, the complaint with the tags you put in wasn't their
> existence, it was your putting GPLv2+ rather than straight GPLv2.  In the
> absence of information to the contrary, you really have to assume the
> latter, since that's the overall license for the kernel.

Righto, thanks Jon.  GPLv0 tags going in for v3


	Tobin
