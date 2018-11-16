Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E980C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 14:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6042087A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 14:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYNsSh4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6042087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389682AbeKQAp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 19:45:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44771 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbeKQAp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 19:45:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id j17-v6so25087205wrq.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 06:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/Ds6kY7caoXv7q2oOebUUecloBqAClLsY7lsUUakJxY=;
        b=XYNsSh4KcZqM1teisP3y25Mhhq8mZChM9oodmj96FEWNfX0/vL3SkAGkHjA15r6+uG
         9yAxq5mLa+4C/b5UawpE1z63m6hDHPVGcrkKYwI5pdPh1f6NwCD4COUReKLzQ9C65P36
         JgTYyAiQc94XYSoxSui24sq7F3JbVY8K5Em/YavjZBtm7rJU5lxT1zRIovN2naFbvxSO
         v5uid3d5wUdWnI4n0TCpV0SahdHHD0zZNjpZ9S2oj/akqHYsq6wACZrhYC9Tw/kQjeaC
         dc8HiB6DEYzlLBQtpZDL7By712lPpzOqxmZCzBEqO9+kB1opENuduSOpHkdcjGajI+jH
         kpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Ds6kY7caoXv7q2oOebUUecloBqAClLsY7lsUUakJxY=;
        b=gnEoXdEzF0ThXFtvm/oDe/rYBMTrez7wdtwJzJHGnySQBUYbRzWIMCW28pNyQimkKO
         ieJAy2aKv24S8Z5LwXM8mxbLxP/1Ge0saKtUdqh1IRZHpJOIif1VnVmqnY/VITAv1PR1
         +0enDKMiT+TOipN08r8brvn2lEx5euo9Kf4PClJO2Jzj5XgGUyWsMExxc76tMP8OIhqH
         GcVT7kFrehh/4njw3dazp8Ji0R0dj1/wnzvSqn1H1Y7m/dTy4L9S8A4v+UaAwDky/jKM
         8Oo/zMJBO3i09NDv+8o5vlq8UkaYUIbbvuAqgStIzlY9p8++aTKnwT9EbXnyGL0x6Xn2
         9+7w==
X-Gm-Message-State: AGRZ1gJF5wqewj+SLW/3mnv4dlAsEIAnIB98ff1T+lepDM3OLr4NlMSr
        4dysALnBe0CjbPisueabfiw=
X-Google-Smtp-Source: AJdET5fjRl46+lTPZoKVgHMKrs704z0rdJ5kEojqnXXu6Wv3LlafPBXlkfhIE65gpCIsWCqUUa/2Uw==
X-Received: by 2002:adf:92e5:: with SMTP id 92-v6mr9721353wrn.124.1542378797297;
        Fri, 16 Nov 2018 06:33:17 -0800 (PST)
Received: from debian ([148.252.241.226])
        by smtp.gmail.com with ESMTPSA id j13sm18506253wrx.5.2018.11.16.06.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 06:33:16 -0800 (PST)
Date:   Fri, 16 Nov 2018 14:33:14 +0000
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: Re: [PATCH] udf: fix dvd mounting error
Message-ID: <20181116143314.qn7jmtyz4ad4bax6@debian>
References: <20181115122600.15821-1-sudipm.mukherjee@gmail.com>
 <20181116125633.GG24157@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116125633.GG24157@quack2.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 01:56:33PM +0100, Jan Kara wrote:
> On Thu 15-11-18 12:26:00, Sudip Mukherjee wrote:
> > Some DVDs are failing to mount with the error:
> > 
> > [  632.305370] UDF-fs: warning (device loop0): udf_load_vrs: No anchor found
> > [  632.305372] UDF-fs: Scanning with blocksize 512 failed
> > [  632.307837] UDF-fs: warning (device loop0): udf_load_vrs: No anchor found
> > [  632.307839] UDF-fs: Scanning with blocksize 1024 failed
> > [  632.309320] UDF-fs: incorrect dstring lengths (32/32)
> > [  632.309361] UDF-fs: Scanning with blocksize 2048 failed
> > [  632.309530] UDF-fs: warning (device loop0): udf_load_vrs: No VRS found
> > [  632.309531] UDF-fs: Scanning with blocksize 4096 failed
> > 
> > This particular DVD used to work with v4.4 kernels, and has stopped
> > working after updating the kernel to v4.14. Did a git bisect and that
> > pointed to:
> > c26f6c615788 ("udf: Fix conversion of 'dstring' fields to UTF8")

<snip>

> From e1a7680b960fe25821f2419b4c0b1215f8ab2f9b Mon Sep 17 00:00:00 2001
> From: Jan Kara <jack@suse.cz>
> Date: Fri, 16 Nov 2018 13:43:17 +0100
> Subject: [PATCH] udf: Allow mounting volumes with incorrect identification
>  strings
> 
> Commit c26f6c615788 ("udf: Fix conversion of 'dstring' fields to UTF8")
> started to be more strict when checking whether converted strings are
> properly formatted. Sudip reports that there are DVDs where the volume
> identification string is actually too long - UDF reports:
> 
> [  632.309320] UDF-fs: incorrect dstring lengths (32/32)
> 
> during mount and fails the mount. This is mostly harmless failure as we
> don't need volume identification (and even less volume set
> identification) for anything. So just truncate the volume identification
> string if it is too long and replace it with 'Invalid' if we just cannot
> convert it for other reasons. This keeps slightly incorrect media still
> mountable.
> 
> CC: stable@vger.kernel.org
> Fixes: c26f6c615788 ("udf: Fix conversion of 'dstring' fields to UTF8")
> Reported-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

It works perfectly. Thanks.

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

>  fs/udf/super.c   | 16 ++++++++++------
>  fs/udf/unicode.c | 14 +++++++++++---
>  2 files changed, 21 insertions(+), 9 deletions(-)
> 

<snip>

> -	if (ret < 0)
> -		goto out_bh;
> -
> -	strncpy(UDF_SB(sb)->s_volume_ident, outstr, ret);
> +	if (ret < 0) {
> +		strcpy(UDF_SB(sb)->s_volume_ident, "Invalid");

Just a suggestion. Even on failed cases, having the volume identification
as "Invalid" might confuse the users. Since you have a maximum limit as 31
maybe something more meaningful like "No Name" ?

--
Regards
Sudip
