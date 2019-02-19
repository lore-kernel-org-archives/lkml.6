Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EC1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC7221773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 01:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHEuY5Bd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733175AbfBSB6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 20:58:47 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46087 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbfBSB6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 20:58:46 -0500
Received: by mail-pf1-f195.google.com with SMTP id g6so9408725pfh.13;
        Mon, 18 Feb 2019 17:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mJaXXtt6mxMahdxX/YIuY7GYUAfUUphS6M5uYpHX8mQ=;
        b=qHEuY5Bdqm6paE0PmGtt7/ZRmyYJ6uy/NZRRj3FYUuoa9ub8XiAeFaWF2NhESeNQyE
         aAH85l/ty4ReGed2zS4YzQ+WgfJG1iL0vauWK1VCM4SsOxcJ+vl7tt62AgBpb9kQY2Vu
         bxDTxKtYDCbPzaRhSbF38A3q/gZQYZXxuLh8c30qVjw1GvFIUo+J3EZUQrfSCF4/Lvw9
         cHflEqAyz/TS7/wa+iUDnbcs2UC6QUUvBeF5mMNRlNnAnEQTk6MzFuVoiYXHl/QGkplu
         /++qMdpNzz4KNOEBQcitOzoYIg3m4A/y2JONuRcg2faETpCS5KKVLHj8UF1SDZTPSZ/T
         EMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mJaXXtt6mxMahdxX/YIuY7GYUAfUUphS6M5uYpHX8mQ=;
        b=UY1Kyzji7aSlYgsxASLBpoGTH4Ifabl4HnI86TNcj4VXy1ACvJt0wuUOLQ6e8uQuqC
         2pray/84Elo+oqcA8CY+gqONJJ5AB/BVd4368TyobnOsFZY0Qr0Uq8T/5KEsEv4unLlW
         XA7l4iKGq/7WhLyF4gG/LENpMHrWcTS2kVVm4JtwWZA2ClOyqaQNRmmo6ORdpSCgUnc+
         +R4CFg3q63gUJa+G1WNps5Ott+jCatAKXG3nyOu8O87zsfG9AFq5oLOt4Lt6lSj8169t
         pEl0VV4DBn6QO4+8a40LXW819fBHKwTk8ZrH+JnGM2KbkMcYLPL/Sj+XwW/UsyPt63gg
         44hg==
X-Gm-Message-State: AHQUAuYjI/3fNG2YAtDkN196gdeYRGBPFUJ/dt7aS5u/ci5zicPu2oQ4
        +wADDRPjylv76781GSURhh0=
X-Google-Smtp-Source: AHgI3IZtzTFMqqMAlbAY6EMcJHogEm8ojE16/NX4VKbFOVhaeqThdUMAwE5UnJCXMkt3dV1fdBDHxA==
X-Received: by 2002:a63:3541:: with SMTP id c62mr21626641pga.191.1550541526164;
        Mon, 18 Feb 2019 17:58:46 -0800 (PST)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id u13sm14343223pfa.169.2019.02.18.17.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 17:58:45 -0800 (PST)
Date:   Tue, 19 Feb 2019 01:58:43 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: Re: linux-next: Fixes tag needs some work in Linus' tree
Message-ID: <20190219015842.tkdahxo24wnu35nh@mail.google.com>
References: <20190219073345.11c39f70@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219073345.11c39f70@canb.auug.org.au>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 07:33:45AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> [Just a note for some future improvement]
> 
> In commit
> 
>   2c4f1fcbef0b ("kprobe: Do not use uaccess functions to access kernel memory that can fault")
> 
> Fixes tag
> 
>   Fixes: 9da3f2b7405 ("x86/fault: BUG() when uaccess helpers fault on kernel addresses")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").
> 
> --
Thanks for reminding. The scripts/checkpatch.pl does has such check but
it only checks the commit message body. I will try to extend it to
include tags, and hint how to configure git.

> Cheers,
> Stephen Rothwell



-- 
Cheers,
Changbin Du
