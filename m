Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD87C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 05:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1619F20660
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 05:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="teT9Qkvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1619F20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbeKZQAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 11:00:08 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44359 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbeKZQAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 11:00:08 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so5958626pfh.11
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 21:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8qUeRwI4QTL0hDlyKkNOdtn4Av5ixLXUe9MNaaBK/aw=;
        b=teT9QkvcR4dUPwMyPSkvcQCDQmzGEtnPsRq2Ao60lxkLc1S4uBE0VoDd9M/ObqOOU0
         iP6tqUQP2wF4RqDdH2GgLtXbp/y9RHZu7I2qd2RWyQ14ADu94eQ/MD5BufJVGDRld8lZ
         Dpc4u6twiE3tQucUWzXKTHmawgmJy6CzcnQQU0m4ZPTdhk8SmHEChjzgKARW5ER5nnVt
         b4F1FL97/DbtSi1mWiWW1fybLM/Gf8E/Q3tQuircTqHMn7Ib3TKg7Qf3nXC45vX1XZ1c
         zWDBo0EKq2Ve7DmvCFV5pfqSCkQ47iUEmqSues3WjtaViOH56pEd2o7Ed06F3TUHVTCg
         cf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8qUeRwI4QTL0hDlyKkNOdtn4Av5ixLXUe9MNaaBK/aw=;
        b=HAonwNsu9gU0Z4gdJcDY21knaHdMX9+vBUtEb1mGkTvS3ixL1eK+7Q8tCXVlNEwZhM
         m3AMzmFkOVhKqrlcgX210WYVSQV+r5R1aRNZZkBUaanTk7btUX5N4Cm6JmOoAvn7i7Qb
         xZ/gEro/gpOLuWS51x2fw6upvQQT8aSrG3bxXdOBJdXor5w1Q6Mlf65bN9QS/+vzh/Uu
         j9wLR/aI/KP5sQuaDLKLxYVsZoIapL0v9tYtMSlhPqeanxOaOoEGwGTtvPZh/XHLOiFt
         TnAizmk+FVu83rc7MLyPiRlkjOMGmGIoFQ1R+MLfq6I3YrQQGvsSTJrs51Xjtv4KhuRK
         mR8g==
X-Gm-Message-State: AA+aEWYYGHoQBbu3yI2FkjFiS4D/PWPJMmaHTGt+JNdbjzgQjoHy0WwG
        dICPAP+QrjSKzl0pO5tbEOw=
X-Google-Smtp-Source: AFSGD/VkNLzuoNbYdG49w5eSJunaex0BYclwo0q6ZRojHIRro3KKvyfkqGYlzomFczegpKqVlcsQbg==
X-Received: by 2002:a63:66c6:: with SMTP id a189mr23405451pgc.167.1543208832897;
        Sun, 25 Nov 2018 21:07:12 -0800 (PST)
Received: from localhost ([175.223.33.236])
        by smtp.gmail.com with ESMTPSA id 125sm8216018pfd.124.2018.11.25.21.07.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 21:07:11 -0800 (PST)
Date:   Mon, 26 Nov 2018 14:07:08 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Carmeli Tamir <carmeli.tamir@gmail.com>
Cc:     axboe@kernel.dk, sergey.senozhatsky@gmail.com, jthumshirn@suse.de,
        bvanassche@acm.org, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: Replaced 11 magic to MSDOS_NAME for volume label
Message-ID: <20181126050708.GE540@jagdpanzerIV>
References: <1543096879-82837-1-git-send-email-carmeli.tamir@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543096879-82837-1-git-send-email-carmeli.tamir@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/24/18 17:01), Carmeli Tamir wrote:
> The FAT file system volume label file stored in the root directory should
> match the volume label field in the FAT boot sector. As consequence, the
> max length of these fields ought to be the same. This patch replaces the
> magic '11' usef in the struct fat_boot_sector with MSDOS_NAME,
> which is used in struct msdos_dir_entry.
>
> Please check the following references:
> 1. Microsoft FAT specification 2005
> (http://read.pudn.com/downloads77/ebook/294884/FAT32%20Spec%20%28SDA%20Contribution%29.pdf).
[..]
> Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>

Looks good to me,
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
