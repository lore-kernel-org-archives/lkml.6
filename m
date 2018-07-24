Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C5AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4232220875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTVaM8q/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4232220875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388369AbeGXKs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:48:56 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46749 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388291AbeGXKs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:48:56 -0400
Received: by mail-pl0-f65.google.com with SMTP id t17-v6so1520655ply.13;
        Tue, 24 Jul 2018 02:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uXcbrGi4377CC9QuyKQBTj2/X0VCpApo4qU0FNFN5zc=;
        b=XTVaM8q/icWkkJ55Y2lYVJJMwOtBC1jYYBGp6Wot6+xXYxrIF0Dcsx0gbTpHlP1sOf
         hRh+JiKFz0Q/rQMmxjJNjtYasg/jcZW2ygq04gweCc9HeZQ10X+0CFvYE+chlkSpCIyB
         dwjUH+VSQA7iNbYQxvYIVm7EKqoBAMMZwyvYEz3t5cjojpPQCtfloFB8p5FpXgIVVOwo
         C+KTiqLV4V2ieLPxin8FNyI07lqS1KrwN9YIrSWRxtQGEC0pmZDsyVoJscAP8SUbQ6SH
         UQd263hN+Hq2wE7zaVLDZ4cnMA1flGvVLQ309lvVLwMtED3MllaqeEoyRsYa5CGoLQYu
         w/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=uXcbrGi4377CC9QuyKQBTj2/X0VCpApo4qU0FNFN5zc=;
        b=HV6s1HdHJM7DWSui4iHkjZXlPD9alNW43FZTDkA78HPGSM47mQ77owg+eyrpFMaUBK
         1nexDE+Jry2lLlCGoSmGtoZci/K5ixJbIlvFvq0UsgRweNNvptY+sflUTLqDBVBCQGsL
         8Bja89KRW9BNbQH2KKd+oT83ZQ1QX5J8k7BcrMdpazAIOjJgiUe1Jo/5aeelEnL7BIJA
         b7WEjuEYTiOOyCqbmdA78N8lqkQGvUwjuEzzw5wCAqujmwr+hVU/OijNeen7WJvpsIJd
         edFHI5bTHm2PbsknwkEJe1O9l2fd2HbbXAQ9YMO1ncdRJfkqB3xltwHaJ7Lw5A4Y2W+5
         oz2g==
X-Gm-Message-State: AOUpUlF84O1EG8mEl0lCt1cmgJ1chj+5HfJZNt2+yi9NRsB/MeE3C8aM
        2fVstgW4wZMPbW6vk5IJoSAv9VfJNbM=
X-Google-Smtp-Source: AAOMgpfy0WL6p8e5NImDmRaNhTGTu8mpCVAqGofFx4yLL+00i3Sb0vyXjlYw+Qy9EnXCW/yOKP4E1w==
X-Received: by 2002:a17:902:5a4c:: with SMTP id f12-v6mr16308082plm.253.1532425398936;
        Tue, 24 Jul 2018 02:43:18 -0700 (PDT)
Received: from linux-zmni.apac.novell.com ([45.122.156.254])
        by smtp.gmail.com with ESMTPSA id l70-v6sm14158691pge.64.2018.07.24.02.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 02:43:18 -0700 (PDT)
Date:   Tue, 24 Jul 2018 17:42:51 +0800
From:   Sean Fu <fxinrong@gmail.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/buffer.c: Optimize grow_buffer function.
Message-ID: <20180724094251.GA32366@linux-zmni.apac.novell.com>
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
Thank your for taking a look and apologize for the noise.

I will take a deep look at it and especially history commits regarding with this.

BestRegards
Sean
