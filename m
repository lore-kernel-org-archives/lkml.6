Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E91BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D8920656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="PvgyFExn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ueji2yuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfANJwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:52:00 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:35855 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726635AbfANJwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:52:00 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 8365E181B;
        Mon, 14 Jan 2019 04:51:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 14 Jan 2019 04:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=g/BTCiXdClDWzAzJNfjNJKk2UNV
        Shs8JJsSMkd0WLi8=; b=PvgyFExn/x/YmrEcWxNHapJj/WVu8WZ3K0uCipb8ujx
        Q/3zAVgkNfeeR9zBWqH+Nf6veeIoR2lrE0Ept2esb7SAJAGXUHvPCTO6TW5gaUSK
        nkw/AhYDNSmxDY0SDoi+xkx1E82Q01L8LOHcn8J1kgSylyxD3VH1bUURQBZA9pJu
        kkHqwda8k6+DEj/AKygZlzliSzDNcoXOutzvQYpddxqluXZAfh8N9PaPE8oB6E9O
        0omCHoOAO+F4WsENc7SmFB36kt3KcmG/SM6IuNvmDSyg5mYQzLkYa5Vd7v100Pai
        TMBWmThhQSAEA7VMVeG515SfXlJ+cW4RY7078hIPm2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=g/BTCi
        XdClDWzAzJNfjNJKk2UNVShs8JJsSMkd0WLi8=; b=ueji2yuzzGurlsOUaGe3j+
        e1l/22fkZ3w+Eh7MqUrubBiJcVDAN3c9/CqQTGtAG19yyr0yb5epq59++4bKDQpS
        oKta2WlUG8ZxSo6PlyelHMmebqf8NtryCmi56l+2+vpzQv7O2yVX20PWncfPnLcj
        jxN34vxbhTYru3WTmMVYtUAigEI1d8HhC8oQysYSW9B8TonzdeY2YFh4gFH+G80r
        pH7D5UoNPIwW+61SRkVSVoTcqFitzvR+TRolbRmklHtjsZMvzDnmDQL5HPDrx+Bc
        PZdH7nZBfNh6vnxk2ygzu3d/yPVvcw0/xuV6JD13LAkt5TGY7owYz6vhyA6+Pdpg
        ==
X-ME-Sender: <xms:vFs8XEdBZhY1Xr_BN6crmPkEkKkYDJW4YjUF6_C1mVe2ZTYpSunlKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrgedugddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgg
    gtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhm
    rghnuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepvdduvddrudejkedrvdduie
    drudeknecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhen
    ucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:vFs8XAcz3-EiPVM_TjqNLVYg7XdLhH1ycVkhV1uDRXoLOneRLYDmJw>
    <xmx:vFs8XHTSVr38Ud_O6n7-zVdOOovJEoi2RbSHTakiznzVhTxLB2umgQ>
    <xmx:vFs8XOgYIiUc_fcvlv2Pn7qazWbh6nb-WRacMk6BGyhEi8ZVq4yNmg>
    <xmx:vls8XKjKBGphSn4Mw0vgorgx0d7tBj9vV0bGQlcGEkCpKvVBCymc9g>
Received: from localhost (d4b2d812.static.ziggozakelijk.nl [212.178.216.18])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1270310281;
        Mon, 14 Jan 2019 04:51:56 -0500 (EST)
Date:   Mon, 14 Jan 2019 10:51:53 +0100
From:   Greg Kroah-Hartman <greg@kroah.com>
To:     Hugo Lefeuvre <hle@owl.eu.com>, Greg Hartman <ghartman@google.com>,
        Alistair Strachan <astrachan@google.com>
Cc:     Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Riley Andrews <riandrews@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: staging/android: questions regarding TODO entries
Message-ID: <20190114095153.GA29722@kroah.com>
References: <20190114082715.GB3017@hle-laptop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114082715.GB3017@hle-laptop.local>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 09:27:15AM +0100, Hugo Lefeuvre wrote:
> Hi,
> 
> This todo entry from staging/android/TODO intriguates me:
> 
>     vsoc.c, uapi/vsoc_shm.h
>      - The current driver uses the same wait queue for all of the futexes in a
>        region. This will cause false wakeups in regions with a large number of
>        waiting threads. We should eventually use multiple queues and select the
>        queue based on the region.
> 
> I am not sure to understand it very well.
> 
> What does "select the queue based on the region" mean here ? We already
> have one queue per region, right ?
> 
> What I understand: there is one wait queue per region, meaning that if
> threads T1 to Tn are waiting at offsets O1 to On (same region), then a
> wakeup at offset Om will wake them all. In this case there is a perf issue
> because only Tm (waiting for changes at offset Om) really wants to be
> waken up here, the rest is a bunch of spurious wakeups.
> 
> Does the todo suggest to have one queue per offset ?
> 
> Also, this comment (drivers/staging/android/vsoc.c) mentions a worst case
> of ten threads:
> 
>     /*
>      * TODO(b/73664181): Use multiple futex wait queues.
>      * We need to wake every sleeper when the condition changes. Typically
>      * only a single thread will be waiting on the condition, but there
>      * are exceptions. The worst case is about 10 threads.
>      */
> 
> It is not clear to me how this value has been obtained, nor under which
> conditions it might be true. There is no maximum to the number of threads
> fitting in the wait queue, so how can we be sure that at most ten threads
> will wait at the same offset ?
> 
> second, unrelated question:
> 
> In the VSOC_SELF_INTERRUPT ioctl (which might be removed in the future if
> VSOC_WAIT_FOR_INCOMING_INTERRUPT disappears, right ?), incoming_signalled
> is set to 1 but at no other place in the driver we reset it to zero. So,
> once VSOC_SELF_INTERRUPT has been executed once,
> VSOC_WAIT_FOR_INCOMING_INTERRUPT doesn't work anymore ?
> 
> Thanks for your work !
> 
> cheers,
> Hugo
> 
> PS: cc-ing the result of get_maintainer.pl + contacts from todo. Please
> tell me if this is not the right way to go.

Yes, it is the right thing to do but for some reason Greg Hartman (who
wrote the code) and Alistair (who knows the code better than I), were
not included in that list.  I've added them to the to: now...

Either of them can answer these questions better than I can, as I have
no idea what this code does anymore.  They are the ones who worked on
it.

thanks,

greg k-h
