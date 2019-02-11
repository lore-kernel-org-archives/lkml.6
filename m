Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B65C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C112146F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 05:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="lUhDym1H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5tRK88u9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfBKFbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 00:31:50 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59439 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725931AbfBKFbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 00:31:50 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id BB79122049;
        Mon, 11 Feb 2019 00:31:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 11 Feb 2019 00:31:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        iQrzwT+3QN8OUTCOoToNX4n1hFuDq3qOqpp6KL+nwZY=; b=lUhDym1HMoqCNJPi
        xCyFrZpv6PaNcQ4gs4ZXXfOfr4S7BMK37QWzblmbxMHUaLTMnqHGzJtLZ3O5I9dr
        QY+tpF62PAIetVWu61jLAT6pcIwYwqKihFu3zwzWigGKENei5AL3+9r9/BPLPMqm
        Q4Kl2oyggmZSeZFSb9AD4VgV4k/qjTSFm7s7lssilFsDmsSVAm3C2uD5C9OkYBPC
        sJDukrVkTXicINLU9OkDFKQjhuZUUyo7z5YT3o35De0voHJJKzp2HKPm6YfHV1+M
        TNqYwPx5ZI5SX1C3/GL7BxxbHTc1gGKX3AO/TRukjCiHvlJJGSeDeJnmGAO7hhyz
        BCZdEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=iQrzwT+3QN8OUTCOoToNX4n1hFuDq3qOqpp6KL+nw
        ZY=; b=5tRK88u9ZdPsaLQqGUASQJOhI0tl3A9RPfW5DmYFV3vI259u/FjnfmkK1
        MrjTGR+euxa9JVWul2uCuS8Jw/kfNIqtNNYCM9D/XKD81aMEIi1dAwwF1D3nzIL+
        1PQFLDHM6LMrvs0sDB83M4l5ORhn6OGG0B6G2x0UJVpuOPxnzsSbsPNre5g8Ku7h
        XdgOOfTqI8DICNXVww90B1ZbpVUwlNdqQz2kd+yM2UcBEJ44emxwipyKL2qEFsml
        kpt+qdZ8AGdR+x3wAO4LcHdUV9BVltbjcaW0Apgr29g8Gjn76aguaJhNpqHGxt9L
        /BAsQGnlIiSkKhLvT25cVmFYftzjQ==
X-ME-Sender: <xms:wwhhXMOJUuoNJXbbWr6KaJMvryfnLW3pZRBa35pHneesOrTf9ZwKDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrleejgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucenucfjughrpefkuffhvfffjghftgfoggfgsehtjeertdertdejnecuhfhrohhmpe
    fkrghnucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudek
    rddvtdekrdduiedurddufedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:wwhhXP2uy40g7xHf9t-RmVLqMfiYctDCVCFqgGX4_S5e2czLPFhGgw>
    <xmx:wwhhXDCFuSMwA1sdWjZUABFDlXLvW5_tVEVKz6KYGrqyq2SYdtYfOw>
    <xmx:wwhhXEIFZ81X_F4GhNPdVWcTsqRQDAG4mCkO3mU1IoZvsoLL1JNfoQ>
    <xmx:xAhhXBkUskx-zbMtuVtZpkgKmrrldCEirF2NSR8iW5wRndzC509mpw>
Received: from localhost (unknown [118.208.161.132])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0DA1DE4597;
        Mon, 11 Feb 2019 00:31:45 -0500 (EST)
Message-ID: <dddb59ed3d0bc790bea9424784998e2ab264d75b.camel@themaw.net>
Subject: Re: [PATCH] autofs: clear O_NONBLOCK on the pipe.
From:   Ian Kent <raven@themaw.net>
To:     NeilBrown <neilb@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     autofs@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 11 Feb 2019 13:31:43 +0800
In-Reply-To: <871s4fi5b5.fsf@notabene.neil.brown.name>
References: <871s4fi5b5.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-11 at 10:37 +1100, NeilBrown wrote:
> autofs does not expect the pipe it is given
> to have O_NONBLOCK set - specifically if __kernel_write()
> in autofs_write() returns -EAGAIN, this is treated
> as a fatal error and the pipe is closed.
> 
> For safety autofs should, therefore, clear the O_NONBLOCK flag.
> 
> Releases of systemd prior to 8th February 2019 used
>   pipe2(p, O_NONBLOCK|O_CLOEXEC)
> and thus (inadvertently) set this flag.

Thanks Neil, this does look like an obvious problem.

> 
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  fs/autofs/autofs_i.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
> index 3e59f0ed777b..331192bed0d5 100644
> --- a/fs/autofs/autofs_i.h
> +++ b/fs/autofs/autofs_i.h
> @@ -215,6 +215,8 @@ static inline int autofs_prepare_pipe(struct file *pipe)
>  		return -EINVAL;
>  	/* We want a packet pipe */
>  	pipe->f_flags |= O_DIRECT;
> +	/* We don't expect -EAGAIN */
> +	pipe->f_flags &= ~O_NONBLOCK;
>  	return 0;
>  }
>  

