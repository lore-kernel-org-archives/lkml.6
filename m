Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F99C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00EAE208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 06:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6fn6Qr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00EAE208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754776AbeFRGO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 02:14:27 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34760 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754458AbeFRGO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 02:14:26 -0400
Received: by mail-pl0-f68.google.com with SMTP id g20-v6so8441429plq.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 23:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EBIq2zYTdekMHYe0MUFpLFiOUiGloZohbSOfSDMHbMU=;
        b=e6fn6Qr+L4VKYfuRtOKX4sldmjn9pNC+2gHVKKxIr4tDs8pLe2hBgwlrK1DcYBuBYZ
         niNlNv6E+q3Mttb2y/msaVWrtNiGAg3vyYL3d05prcuCye4XwuqHUw2z+spScCFaM0W5
         Pa8QevG1xk01Vnb5k3PzbeUBF6wyOoCnFMOmmPdO04bltGHZALc36HGrYu4IycTQkHKe
         d3VpQ2ewhBCPEvP9IMV3fGELUTkZcWWn08M6dg6IwoB4jOSGv0H1rKLzuTmsnfXpB6eH
         geCLOBpAUqQDXZv1Oz/UPSXw6h6qS1u7+B1TkXMkN9T6gfl6Mm2FT/9/+QbJOvbWVAVk
         bdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EBIq2zYTdekMHYe0MUFpLFiOUiGloZohbSOfSDMHbMU=;
        b=RndxQb2fA16S1bEdQfRA8QkPlouEeBdSEGLq1XAPHLrYfQNtdLsiqGrBjiItLXtIWL
         WiI2QM1kqvnCaP0EGB5T3eKomRiRLOlAPFxGqmk2OhN1BPX3j0hVkP/m3KqG0v1tUlov
         aHkxvM4z/ovRcryVCFiXZ/E++ZK00m6VNslK64m/1ozJloR/GRBC3nsFlPPSAIjeQFjC
         dVTC0zmKv1j+c3H6XZ+cquzjelBAX6I+w2TbD3ZkB0gucGQLynYSVgAXC777+57eqhLK
         at/oGGrnY0O5QXX4/Crnf1yW1x8tsMwhGApFkXTxS8umgjd9euAl5UvTEhsKukY4JEfA
         qZQA==
X-Gm-Message-State: APt69E2gJZWzRetYEIVa0uhDKFUoCI4I1UuB/lZQ/AYQySGgZYYYqUpM
        xODP8AVNCtV5+7tz1QOPlVk=
X-Google-Smtp-Source: ADUXVKLobkOqlWbm7FHLmo7Va4FVH4805dk6nKUJGPQerwGIBMs76rlg7Ydtk5975DkIHhjohpZnEg==
X-Received: by 2002:a17:902:3181:: with SMTP id x1-v6mr12582576plb.198.1529302465215;
        Sun, 17 Jun 2018 23:14:25 -0700 (PDT)
Received: from localhost ([110.70.54.122])
        by smtp.gmail.com with ESMTPSA id x72-v6sm26317271pff.176.2018.06.17.23.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 23:14:23 -0700 (PDT)
Date:   Mon, 18 Jun 2018 15:14:20 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Maninder Singh <maninder1.s@samsung.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        pankaj.m@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH v2] printk: make sure to print log on console.
Message-ID: <20180618061420.GB448@jagdpanzerIV>
References: <CGME20180601090029epcas5p3cc93d4bfbebb3199f0a2684058da7e26@epcas5p3.samsung.com>
 <20180601090029epcas5p3cc93d4bfbebb3199f0a2684058da7e26~z-a_jkmrI2993329933epcas5p3q@epcas5p3.samsung.com>
 <20180608083906.fwx3r3y2pxtv3ga6@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608083906.fwx3r3y2pxtv3ga6@pathway.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/08/18 10:39), Petr Mladek wrote:
[..]
> It might make sense to document the limitations reported by
> Sergey. I mean to add something like:
> 
> "There are still some corner cases where this patch is not enough,
> for example, when the messages are flushed later from printk_safe
> buffers or when there are races between console_verbose() and
> console_silent() callers."

Agree. Probably a link to the email would also be helpful.

> > reused flag LOG_NOCONS as its usage is gone long back.
> > (5c2992ee7fd8a29d04125dc0aa3522784c5fa5eb)
> > 
> > Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> > Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> 
> Anyway. the patch helps in many situations and it is a step in the right
> direction:

So I'm not objecting the patch and will review it shortly.

For educational purposes only:
Would be appreciated if you guys could point out what those "many
situations" are (in the mainline kernel). Could you do that for me?
This is a real question.

Otherwise it feels like I'm missing the real [mainline kernel] importance
and significance of this patch.

	-ss
