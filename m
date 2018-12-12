Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF84C6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3E220839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEveNnsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3E220839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbeLLC3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:29:12 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36207 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLLC3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 21:29:11 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so7574656pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 18:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5mZYtCBKjITqnAc9S0LTiVjuUCOxwCAK6ZwKb/8bhHs=;
        b=TEveNnsQrZgovABZwpJjEiY3CnkS+QWkiQFA8Tq5zLMCRs+se8crJRBhWvKoIq/Axh
         MlXLVI/OHDY1OVFtnlpiu/cdsFPMyRAQGeRaL4ksR90WZSmTgM+7+UdKXdUNiM50Pp/x
         YZbF7LTQI+YlCwl3biHSxt9UsHoLZLLyiPK9ca4Jt+OewGcZCj2Ai145YDsJljbW7iOO
         7ou8bjRD9lQESFdSv8kDPdS6C1sbjhScTne2tq68bpTNKMtLSakEk9Kr5Ymsm6o2vbLg
         5YrSVF8JuiwdwmR692EpZD8TwqKi/Tba0Lw8GekEfPr7eNVknynGADub4r6dFp1TsAcl
         GoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5mZYtCBKjITqnAc9S0LTiVjuUCOxwCAK6ZwKb/8bhHs=;
        b=OOUlgUH2Rdur4FG82rM62bNP4/cXcFr9f6cqwQHhXLgRknJyygFb2lR1LYBAfQZ5H/
         g1VoVsWrhfIc0bDDU7XN9fjMJhFE63sHGL0wLo47GCy/UQgeFPUiFoM9a48ohfYKdr0C
         UEd+r/GK+sZ0hGE16xIcGs5TewBsuK0weCbvgk38DPJ/Xnnj2h3kIJjZMjLTVsLBzfWw
         bGPp/9ZUrCvVli83vKWl636T3ydcMq6daQbQe+Ju90eFkuy03KXYCpFmgSdm9wbdouia
         LGE1CL3l1ZXFqNAyNCWIZ6rMDgbMNP9FSfP48UNllYG50TRZSGk+tg9WLTVajuotsa9t
         r/ag==
X-Gm-Message-State: AA+aEWbCXHPheCmUBoDgIS3r7V+hmNtE7zKaf2w6QoyAJHynhsHs5Oyv
        XT3xWOHZt9B8JRj2fFeeqGU=
X-Google-Smtp-Source: AFSGD/VZfdGEN8BBexxmyWO9uZnt5CgSJjIevv8ju+gwYett7hWFI/L1AI2Z7R9c/zWL8At5YKSvuA==
X-Received: by 2002:a62:cf02:: with SMTP id b2mr19326854pfg.183.1544581750053;
        Tue, 11 Dec 2018 18:29:10 -0800 (PST)
Received: from localhost ([211.246.69.141])
        by smtp.gmail.com with ESMTPSA id e23sm23922175pfh.68.2018.12.11.18.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 18:29:09 -0800 (PST)
Date:   Wed, 12 Dec 2018 11:29:05 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>, Dmitry Vyukov <dvyukov@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] printk: Add caller information to printk() output.
Message-ID: <20181212022905.GC431@jagdpanzerIV>
References: <20181130154024.ls3mntfdr4zvluub@pathway.suse.cz>
 <f224bd68-7394-ff70-cad6-d3fbbb3b5f7d@i-love.sakura.ne.jp>
 <20181203150603.cdqii263e4kmmibo@pathway.suse.cz>
 <b38c6957-c3c1-54fc-781e-06d7eed6a9b1@i-love.sakura.ne.jp>
 <20181204152724.ypk44mi4a56nrud4@pathway.suse.cz>
 <459018db-763b-9520-ead2-2c0d5975fbf3@i-love.sakura.ne.jp>
 <20181210130930.bas4fozjhe3dc5nu@pathway.suse.cz>
 <c5b5d660-d217-35f0-c4f1-7252367934d1@i-love.sakura.ne.jp>
 <e3f69846-ef08-c8f5-368f-4dada13c9970@i-love.sakura.ne.jp>
 <20181212022526.GB431@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212022526.GB431@jagdpanzerIV>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/12/18 11:25), Sergey Senozhatsky wrote:
> On (12/11/18 19:26), Tetsuo Handa wrote:
> > @@ -688,12 +701,21 @@ static ssize_t msg_print_ext_header(char *buf, size_t size,
> >  				    struct printk_log *msg, u64 seq)
> >  {
> >  	u64 ts_usec = msg->ts_nsec;
> > +	char from[18];
> 
> [..]
> 
> > +#ifdef CONFIG_PRINTK_FROM
> > +static size_t print_from(u32 id, char *buf)
> > +{
> > +	char from[12];
> 
> Are those supposed to be of different sizes: 18 and 12?

Yeah, they are. strlen(",from="). Sorry for the noise.

The patch looks good to me.

	-ss
