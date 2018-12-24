Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5BFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 07:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B7B21736
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 07:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mgyh/2Xp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeLXHin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 02:38:43 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50819 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726702AbeLXHin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 02:38:43 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CABEF21AB4;
        Mon, 24 Dec 2018 02:38:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Dec 2018 02:38:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=gF3qij
        XNdKYXVkQLgiGlCMCuj12T0mHaoXSwJyKHqM8=; b=mgyh/2Xpsvw0K1YLWnWWrj
        KkA49e6wzuz3QxOJzqTUG5BpdA8QPT5V8oTS/Jbib52jlm/8J5D5nBUNcG/uq3sy
        qtKphEcj2IfaO7XeAa2Jw/wJRAfjrUfAtiOjGPn/BwA/Y2GUIzMwpHwN1yO3/4YD
        +F4Ao4jR6Ce3T5lgUxphbSJjTNEiyWvdxza9LM5qfRo40sDP8yZ3LVgzFP6DBH/U
        DkJ7Ep8ESR7qnNrxJimK53coMr+Id+CR+PpB6S3Fe7+kDWS6MTPCJx7bJby/M8s8
        2rVbt8bHSMzrNEl88o05/stAWg3WJ6yOkl7Y+WTbQQ767PloWqiRcRlMr3VlsdoQ
        ==
X-ME-Sender: <xms:AI0gXHN1-xO9CeK99cyuuBmzI6YdnYlEwGkYZLHF07gm5L8lsDw44A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudektddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukf
    hfgggtuggjfgesthdtredttdervdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceo
    ihguohhstghhsehiughoshgthhdrohhrgheqnecuffhomhgrihhnpehkvghrnhgvlhdroh
    hrghenucfkphepudelfedrgeejrdduieehrddvhedunecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehiughoshgthhesihguohhstghhrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:AI0gXKJo00n9pCUr8vlJ8WYH43nnP7vRiAwHC0mqrrk-NyC1xbANGA>
    <xmx:AI0gXOXEATPi4r2E_V70dOAhxWEFvkJr8dIN9ho_Vfvh6lCPbjrQxA>
    <xmx:AI0gXB36kmxojTImIi8TAqBUtd4mVhTjWXyeRAmJ_JFcgQe0P_8Rvg>
    <xmx:AY0gXIkkIyDTbr4Yj_vSFBq1xwMGL9Tv_uHhUfvgxGb7g_aro3riRA>
Received: from localhost (unknown [193.47.165.251])
        by mail.messagingengine.com (Postfix) with ESMTPA id 922A3E44D4;
        Mon, 24 Dec 2018 02:38:39 -0500 (EST)
Date:   Mon, 24 Dec 2018 09:38:38 +0200
From:   Ido Schimmel <idosch@idosch.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jiri Pirko <jiri@mellanox.com>, Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlxsw: spectrum_acl_bloom_filter: use struct_size() in
 kzalloc()
Message-ID: <20181224073838.GA11051@splinter>
References: <20181224052741.GA22098@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181224052741.GA22098@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2018 at 11:27:41PM -0600, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     void *entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Ido Schimmel <idosch@mellanox.com>

But net-next is closed (http://vger.kernel.org/~davem/net-next.html) and
this isn't a bug fix. Can you please re-submit when net-next opens
again? Alternatively, I can apply the patch to my mlxsw queue and submit
in your stead. Let me know what you prefer.

Thanks!
