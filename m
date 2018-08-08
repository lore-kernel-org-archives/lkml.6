Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C63C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4464D2170A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 06:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgwBlrja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4464D2170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbeHHJKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 05:10:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44625 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeHHJKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 05:10:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1-v6so611390pgp.11;
        Tue, 07 Aug 2018 23:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=reTqHYG81E8dus0QXhgPXLEntiwrqPYoYtM+tpi7MaY=;
        b=XgwBlrjaWmCbcOS+pqOzCGpT/xTrq5uwPD6q983Qb3PLsHg1l5gstd0Iact1L1igbD
         doWGw6MQAowxDoKSsBL57/hl/HpMUcZcrAlAF6aPqw5uHRoTfkrOP4fMy49dBAfivdaT
         g/oJdhCyHEAma6hiWYtO4OLYDGnsomqapTz0dQlLFeIX4XnKe0BF4EO+g/AbDJbkixz4
         0K9vBbYAfBu1VUNPZRu4s6IN9tG8kfup6qTzUHgwgL4yV1GG4J7qEGs9IGTMT9XVAZrk
         MyXBph8fhDkHNhp97a6PQ021nUUAgvFcGerFiueMA6syV9sTWT+b409li1ae255dUwWy
         LPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=reTqHYG81E8dus0QXhgPXLEntiwrqPYoYtM+tpi7MaY=;
        b=CZEK4in8JXuvsiAHxLWP524VG1Faur1tkVNf+3ji0aPSWGfj19Ceh+i3cUfEahgcY0
         K4FVyDmwoHMnrTNU3k89NFraSNIWLAKfkLh4lmAiIz0qC13ScS9m+QqS9g5rq3TYRTPP
         rLAvOEELHPtCvgAUi2ROkdHkslELmsAxuh6x68FfiKUVSYkemCqNVDnd+ewDu8zqJFj+
         it8EdHJsql2p3MNZNB6TxM9++fZbe1fQqbkDCvVPjMvw/OA4CGMel7S26uUUPpRJu9DS
         vtb0WJGvbSWUYSOQrc3B+BfNNidp9C+3J6eDsv7PaBKTTBJKNhtSHlF1xluH+ugQ4ZV8
         ubNw==
X-Gm-Message-State: AOUpUlG6X2h8RE/4Nkz28cVlJyqSaSxBJ+RFhVEryI40WGMrSsb9cIsg
        liSNEihqr2u5E8saAZxEG4pV6hTiRBAD3g==
X-Google-Smtp-Source: AA+uWPyhlYs6ftW5B4cKf8Lt3ntvB+6zlw+QbQ0lJofRVOsCN2vBlcC1Yi0ckdvz/q9Rnvy1ffqxYw==
X-Received: by 2002:aa7:87d0:: with SMTP id i16-v6mr1563272pfo.82.1533711133278;
        Tue, 07 Aug 2018 23:52:13 -0700 (PDT)
Received: from linux-zmni.apac.novell.com ([45.122.156.254])
        by smtp.gmail.com with ESMTPSA id y63-v6sm5026088pgd.94.2018.08.07.23.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 23:52:12 -0700 (PDT)
Date:   Wed, 8 Aug 2018 14:52:05 +0800
From:   Sean Fu <fxinrong@gmail.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/buffer.c: Optimize grow_buffer function.
Message-ID: <20180808065205.GA21134@linux-zmni.apac.novell.com>
Mail-Followup-To: Al Viro <viro@ZenIV.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1532194217-19002-1-git-send-email-fxinrong@gmail.com>
 <20180721182116.GC30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180721182116.GC30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 07:21:16PM +0100, Al Viro wrote:
> On Sun, Jul 22, 2018 at 01:30:17AM +0800, Sean Fu wrote:
> > Use PAGE_SHIFT and i_blkbits of bd_inode directly to avoid ugly sizebits
> > calculation.
> > Remove ugly sizebits calculation.
> > Remove unnecessary sizebits parameter of grow_dev_page.
> > 
> > Reduces code size:
> > 
> > Before:
> > 
> > sean@linux-zmni:~/sda5/source/linus_repo/linux> size fs/buffer.o
> >    text	   data	    bss	    dec	    hex	filename
> >   34037	   1510	     16	  35563	   8aeb	fs/buffer.o
> > 
> > After:
> > 
> > sean@linux-zmni:~/sda5/source/linus_repo/linux> size fs/buffer.o
> >    text	   data	    bss	    dec	    hex	filename
> >   34021	   1510	     16	  35547	   8adb	fs/buffer.o
> 
> First of all, 16 bytes is pretty much noise.  What's more, the "remove ugly
> sizebits calculation" part really needs an explanation of the reasons why
> it's safe.  You assume that size == 1<<bdev->bd_inode->i_blkbits; where's
> the proof that it always holds?

Got it, Thanks
This size can be page size(4096) besides block size (1<<bdev->bd_inode->i_blkbits).

I have another question about __getblk_slow function in fs/buffer.c
Actually __find_get_block already was invoked before entering __getblk_slow.
Can we move __find_get_block after grow_buffers in for loop of __getblk_slow?

for (;;) {
	...
	ret = grow_buffers(bdev, block, size, gfp);
	...
	bh = __find_get_block(bdev, block, size);
	...
}
