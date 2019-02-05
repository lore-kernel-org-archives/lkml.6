Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D07C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 04:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1143B20818
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 04:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="LugmjNOo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aj5iM51Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfBEEFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 23:05:31 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43117 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725864AbfBEEFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 23:05:31 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 35D0021E49;
        Mon,  4 Feb 2019 23:05:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 04 Feb 2019 23:05:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=zjdfF6fptfX7K6A8RaIXFGiKuRz
        QA5sSSQPwlsRUNkI=; b=LugmjNOo8xPlcZpoJSrbsH4HqYVvyMsgfdkS39bI2mP
        0Rj2GLsP30vReN2b/TI7L73VqJ9Gt47reLRcEvREwkAhLv89+hZuTDpsbz48dcs5
        UdfaBt85rUYM3fJEyeFkjbbXCwETRh1LXOjkxBpIP0me3cfTGrZdjaeQFjR40CNS
        bVavL6Qh62AzVn6vc932Gp/3yQvw/Skp3B71u0zTfR5MjxEcfJJrdwb4nmja/LHg
        d2oNS/0qE2SLe+uciJKuoWsLgdQ3Ndx9RtWNA++t41oBmUbVdjdEJ/eAws4SRcLx
        xQi0Oksh4DQZQQghsfdjIxMBdRctiLVOKhixuS2Pb/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=zjdfF6
        fptfX7K6A8RaIXFGiKuRzQA5sSSQPwlsRUNkI=; b=aj5iM51YIuEY22ew+Ns4P+
        Kdw1r07aVzPWKMdzYUUBj6hHiTLCIXvj0N3QlKtgi1FSN9SInDwgf/3ZjSikFrsO
        zp4l88etf6QOhFtLO0S/45pgMJGcjCw4MWk0b8TqYIX7bU6eUY1A2Wp/lWZAX2XH
        MIpGkEiGJwSym3edafz3ipNGDvB9wUh544iTogSswc98/+UtlVopH78hlAnkKJZl
        m8g4uL6BlmGud4iw+++l/+Ixg3BFBwhgcyZ0YeLX5r2NnOF7zgMu4KHGlKhBT/to
        TaONxCw5bD6Z9XnoM5O77MoHAr5oNMyPJPUK3P19Yr62mYw1/aEswvQKbiEAXzqQ
        ==
X-ME-Sender: <xms:iAtZXHJ8W9ASse7Tb6dFvhzK7O_Jbw0lqgYZ64njkkZi0uVOuu2eMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrkeehgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdlfedtmd
    enucfjughrpeffhffvuffkfhggtggujgfofgesthdtredtofervdenucfhrhhomhepfdfv
    ohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtohgsihhnrdgttgeqnecukfhppe
    duvddurdeggedrvddukedrvddtudenucfrrghrrghmpehmrghilhhfrhhomhepmhgvseht
    ohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:iAtZXEtgqNo3ELnQBPlOUbIgbPPRimLbKMnOItGk_zmDNAptXRbBYw>
    <xmx:iAtZXLJE5QxF0p4TyFRSl_QoaJaZiVlcEl7FFLg-A03llUA6axjqoQ>
    <xmx:iAtZXPFszyjgAftuTROa7heIlLRs36ts1reOnhnfkR8rZXjheJtoqQ>
    <xmx:igtZXFX3_5YGDM7jJ83l51edoII50ubWESP8DgX5TvFUtz3caC83uA>
Received: from localhost (ppp121-44-218-201.bras1.syd2.internode.on.net [121.44.218.201])
        by mail.messagingengine.com (Postfix) with ESMTPA id A5106E4046;
        Mon,  4 Feb 2019 23:05:27 -0500 (EST)
Date:   Tue, 5 Feb 2019 15:05:21 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] slub: Do trivial comments fixes
Message-ID: <20190205040521.GB30744@eros.localdomain>
References: <20190204005713.9463-1-tobin@kernel.org>
 <20190204150410.f6975adaddfeb638c9f21580@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204150410.f6975adaddfeb638c9f21580@linux-foundation.org>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 03:04:10PM -0800, Andrew Morton wrote:
> On Mon,  4 Feb 2019 11:57:10 +1100 "Tobin C. Harding" <tobin@kernel.org> wrote:
> 
> > Here is v2 of the comments fixes [to single SLUB header file]
> 
> Thanks. I think I'll put these into a single patch.

Awesome, thank you.
