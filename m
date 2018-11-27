Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9F8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC3F20664
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APF4VPda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC3F20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeK0NEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:04:13 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46133 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbeK0NEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 08:04:13 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so14790188ply.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 18:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BlnmJVYVEGZKLMQ25R2Xgla7R6htgSgHhtIQgm4J3Fo=;
        b=APF4VPdaH7OltL6Z+YvnAMPArkq4fpl3+fG6NluJSP2gLPCkuCJjwLs5t1TmEvwHTd
         7Ollz3z+VWcvt96SuquzClGJCZ0PoMuVTO7vvveAy3ABzHpG+BQWeK4ww+lJZr3XBd/9
         CF82Rgb88fpuqk1NWU6cmqE/o1vM1ifTLkUuDAHBtEAbIXcSZp0SKY08o20/dH7F22wO
         bzk8SG2fenBqmJfDmJSVCgX7Szg1DQZpuVZ+8aXCgIdxR7GkTN3wgvM950B5p3ACJHl9
         wFutP8h9O0nsk+MDpFyeYxinY2zzCtZmg/GcUTQzbPWTo2HGrLPQTn28PUMqh3Ke7plH
         pE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BlnmJVYVEGZKLMQ25R2Xgla7R6htgSgHhtIQgm4J3Fo=;
        b=RNgvgTZPoeqy7ruZtymj7qDQGn2FbE0TeWQp2WLJmAd5VoSOyevZdXKBwD3odhUuk/
         Xzgl3s6/9wjb2gMfI/BgPBPzYE8J0gsLtWnH+lrZB/jractECAtEy8AKLo1SBIUL9vHy
         Xdm2xF5qr4NrbVV1xCjnz8Rn27KyWz5ADwOG60mHK0CzUm6LCuUqIPUwsTLpmwOMpbxT
         T02DkqLd4ZCnFT/uVFYv67Q4gQEijX2BwvJw6VKfkAXgK4+sRC6xcExb44iJa6NHQBLD
         aWFIhdyHO9Qv8TcrJJl2ZKb3UmAPpA8wLQaiLrE7zQymWTy2SfQJ60bYvjuV/rg7kCAU
         yhIg==
X-Gm-Message-State: AA+aEWZ5zbgnsq7+CPJ4wSZKIsuEk460B06pc411ADRONAc5QDW3zawx
        w2jFtCtDtK2G3+n8+7j1GaSfSgh6NQg=
X-Google-Smtp-Source: AFSGD/XpaLegHDduOCRGFr7+ULiiNS2tpNqgHFVR9qkzeBHee31LSWdj8V3/KPgKBzRwCZT5sqSzuA==
X-Received: by 2002:a17:902:e101:: with SMTP id cc1-v6mr30909414plb.165.1543284479554;
        Mon, 26 Nov 2018 18:07:59 -0800 (PST)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id 6sm4837512pfv.30.2018.11.26.18.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 18:07:58 -0800 (PST)
Date:   Tue, 27 Nov 2018 11:07:54 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v2 6/7] zram: add bd_stat statistics
Message-ID: <20181127020754.GB237537@google.com>
References: <20181126082813.81977-1-minchan@kernel.org>
 <20181126082813.81977-7-minchan@kernel.org>
 <20181126125833.e95a21088ae60ccc6fd55022@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126125833.e95a21088ae60ccc6fd55022@linux-foundation.org>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 12:58:33PM -0800, Andrew Morton wrote:
> On Mon, 26 Nov 2018 17:28:12 +0900 Minchan Kim <minchan@kernel.org> wrote:
> 
> > +File /sys/block/zram<id>/bd_stat
> > +
> > +The stat file represents device's backing device statistics. It consists of
> > +a single line of text and contains the following stats separated by whitespace:
> > + bd_count	size of data written in backing device.
> > +		Unit: pages
> > + bd_reads	the number of reads from backing device
> > +		Unit: pages
> > + bd_writes	the number of writes to backing device
> > +		Unit: pages
> 
> Using `pages' is a bad choice.  And I assume this means that
> writeback_limit is in pages as well, which is worse.
> 
> Page sizes are not constant!  We want userspace which was developed on
> 4k pagesize to work the same on 64k pagesize.
> 
> Arguably, we could require that well-written userspace remember to use
> getpagesize().  However we have traditionally tried to avoid that by
> performing the pagesize normalization within the kernel.

zram works based on page so I used that term but I agree it's rather
vague. If there is no objection, I will use (Unit: 4K) instead of
(Unit: pages).

