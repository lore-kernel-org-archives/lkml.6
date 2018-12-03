Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC149C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE17206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXTvJ2ql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FE17206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbeLCCpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 21:45:49 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38481 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbeLCCpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 21:45:49 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so5578450pfi.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 18:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gfen10dG6YT9Prvd1UobyjA0IZvF5ReVDP00piYoFKc=;
        b=KXTvJ2qlxPx//my2namKLzG90bW+SCEVmtmz7lS8dhj8TcinH93yR8/4RXZHjUu0wt
         /T5P980dmfr1gV+GxGjLGWfeLc128+YHrb9zyXVAErpd+KEMb4a2oQcc5BNs1SBFQfkP
         TIpyJG77brOwr+bl3lz3X6Cb0cVAQEicJ7S5BCinBZJtpI8U+YkvrLui1sz1nLf3BHBI
         cgPxu0zPEwr2Iuk7TLSQlNTbp4CCyvX13cRoYgg5EhIqsukXaj2PmV5W06j977xyGJzG
         Li1nHd2FaBwlyPnLZMMImG93y+6A0ckWllvF2gY5wsp3JBUcMEgeOTJ8IrRq++Oa+hLM
         YnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gfen10dG6YT9Prvd1UobyjA0IZvF5ReVDP00piYoFKc=;
        b=tGVZA4+sFqYvTrl4Uh3JlMKV7OC9AXWVJyxFY8ruLC71CMKalM0IIHtYVsiWA4qAm2
         UFcm771bNBGchrBJ/dlmM3rNDiHuTk0a7N0I8NtnHs+eD4evEyX584vQi1dKjhHbnK3R
         zsvMDHcy9xumKLnxyLHA0Vriko45ngruR8OTaazBYqRw1pf2K+OKXH4U7RPnyLyfj/Zy
         sIs3N+QIzw13GUrdXWwLcueF2gTnM2+DAblU5tALdJJRMTvvZ38NhYhDP9SaF173go9b
         K1rMz0pPczGPgHaPCaGe0MhtdQ0lBOTtnvRoqNWTvY3I3FY+iDFxyAdDHPFY+AWOYzIu
         dD+g==
X-Gm-Message-State: AA+aEWZpTxlwROZdfnIfBkjcecRn2srbD2KKLHgFRQAUAsr4+6hWeLG9
        zGiCratLJoeUzcs+WFXA+Fg=
X-Google-Smtp-Source: AFSGD/XJ7ih9izIMVL2JHPWOhQg82D2OYINv8TMNQxfMEvBtyWDDpv5wFFkVVPNdydwmVZWi3asgCA==
X-Received: by 2002:a63:801:: with SMTP id 1mr11720912pgi.275.1543805144162;
        Sun, 02 Dec 2018 18:45:44 -0800 (PST)
Received: from localhost ([175.223.22.143])
        by smtp.gmail.com with ESMTPSA id j185sm19142043pge.72.2018.12.02.18.45.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 18:45:43 -0800 (PST)
Date:   Mon, 3 Dec 2018 11:45:39 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH v3 7/7] zram: writeback throttle
Message-ID: <20181203024539.GC427@jagdpanzerIV>
References: <20181127055429.251614-1-minchan@kernel.org>
 <20181127055429.251614-8-minchan@kernel.org>
 <20181129022358.GA6379@jagdpanzerIV>
 <20181202231829.GA21560@google.com>
 <20181203023040.GA427@jagdpanzerIV>
 <20181203024146.GA149587@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203024146.GA149587@google.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/03/18 11:41), Minchan Kim wrote:
> On Mon, Dec 03, 2018 at 11:30:40AM +0900, Sergey Senozhatsky wrote:
> > On (12/03/18 08:18), Minchan Kim wrote:
> > > 
> > > Per andrew's comment:
> > > https://lkml.org/lkml/2018/11/27/156
> > > 
> > > I need to fix it to represent 4K always.
> > 
> > Aha.
> > 
> > Then we need to increase bd_writes PAGE_SIZE/4K times in writeback_store()?
> > 
> >    wb_count = atomic64_inc_return(&zram->stats.bd_writes);
> >    ...
> >    if (wb_limit != 0 && wb_count >= wb_limit)
> >        zram->stop_writeback = true;
> > 
> > bd_wb_limit is in 4K units; but in writeback_store() we alloc a full page
> > and write it to the backing device. So the actual number of written bytes
> > can be larger on systems with page_size > 4K. Right?
> 
> Hey Sergey,
> 
> I changed interface in recent version v4. I belive it would be more
> straigtforward for user. Could you review it?

Hi Minchan,

Just received v4. Will take a look!

	-ss
