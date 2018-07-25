Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FCDC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8CA20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fa6+4QJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8CA20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbeGYEMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 00:12:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44105 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbeGYEMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 00:12:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1-v6so4245539pgp.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 20:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sOqjT5qmJX81JGsm2ome1Z9Xe+pvDRGlNEfx+NRFyrM=;
        b=fa6+4QJs6Er5MpXMxdwWNOhsKfqQGgVdxJ56Hs5Fv+XZ+CWn1HvkGVYPeGmJNlbpoG
         hWgGP5rcAECMNfQVBppXHtEx11Q91CNWWs9J5FUOY7xVGC9rW0sKdF3XnfWznG+hxXhP
         yNEH5dp5j/cntloAVy480xC4nlvn9wJRnaAdlWgYguu0HQIdAC/aKEnFT9fl/5HLyeDp
         jIlvbYd9p6c6X0Dn1YbCkvjUB6zaoo6gv8QmXczwMw8glCj+7PWqwpXpZ83xev5nUvlq
         VPp9cbM0KnIUtLtsnwga/vXHMrvT1tNFdCw8tQDt3cx6P0fTVXWIfPH03lus6mqCA0Bu
         CC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sOqjT5qmJX81JGsm2ome1Z9Xe+pvDRGlNEfx+NRFyrM=;
        b=XQ2WwDC2NZyQigwAidh7JUzrJ4PCr8FxnWLjmWo2SFg8PKnoYZLlJClN7HF4RADZLS
         Ar2/qz8o5iKtF26lL2/YpRFsxE2fTfEiaHX6Ic0K8xpnSosqU4m0b6d6y5JMryFZgtKT
         cEOUBc5hieXrq2HCRBXBh3fx8mPSmfECgDbnX7dp7NMpEP5Ttv4SBwEpEECvb8PdG9oS
         j+TnxMzcl7vIss4o4RcHXk96SbOCXwMUi3j/IoLV8EfAZuR7yF2JdAQQxgrqftLMs4oV
         urNjfbCp+OjDQOj/xqvN8Sf5bt4LL3PRjKWL8EodhctLMqbUg4VjQbmjB+0SF74Qnu3G
         PI3Q==
X-Gm-Message-State: AOUpUlE8rbyRRFcPW7sY/xjYgJgZ2B2XCwBQ/Viewx/3/WPcuxaDf2wr
        PuqD1sLvCLz38QsbeK8agjg=
X-Google-Smtp-Source: AAOMgpdmvtFwZ2+ttB2fHFOP9SN5EX+XGhkcfmUHjef/3kgNEwDbX4RLzHm0FSqHnkze6kM/OzwIXQ==
X-Received: by 2002:a62:642:: with SMTP id 63-v6mr20404586pfg.222.1532487763460;
        Tue, 24 Jul 2018 20:02:43 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id j191-v6sm22820882pfc.136.2018.07.24.20.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 20:02:41 -0700 (PDT)
Date:   Wed, 25 Jul 2018 12:02:37 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Tino Lehnig <tino.lehnig@contabo.de>, ngupta@vflare.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Zram writeback feature unstable with heavy swap utilization -
 BUG: Bad page state in process...
Message-ID: <20180725030237.GA105976@rodete-desktop-imager.corp.google.com>
References: <0516ae2d-b0fd-92c5-aa92-112ba7bd32fc@contabo.de>
 <20180724010342.GA195675@rodete-desktop-imager.corp.google.com>
 <d4f4b5a1-9e31-375d-0599-b6d8b0ebc9df@contabo.de>
 <20180725013250.GA66792@rodete-desktop-imager.corp.google.com>
 <20180725015502.GA16271@bombadil.infradead.org>
 <20180725021657.GA87819@rodete-desktop-imager.corp.google.com>
 <20180725023532.GB16271@bombadil.infradead.org>
 <20180725025106.GA99093@rodete-desktop-imager.corp.google.com>
 <20180725025525.GD16271@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725025525.GD16271@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 07:55:25PM -0700, Matthew Wilcox wrote:
> On Wed, Jul 25, 2018 at 11:51:06AM +0900, Minchan Kim wrote:
> > On Tue, Jul 24, 2018 at 07:35:32PM -0700, Matthew Wilcox wrote:
> > > There is NOTHING in a union with _refcount.
> > 
> > Confusing. Matthew, what am I missing?
> > 
> > Before:
> > 
> > counters consumes 8 bytes
> > units and _refcount consumes each 4 bytes so memory space is not overlapped.
> 
> Correct.  _mapcount is at offset 24, as is units.  _refcount is at offset 28.
> 
> >         union {
> >                 unsigned long counters;
> >                 struct {
> >                         union {
> >                                 atomic_t _mapcount;
> >                                 int units;                      /* SLOB */
> >                         };
> >                         atomic_t _refcount;
> >                 };
> >         };
> > 
> > 
> > After:
> > 
> > Now, units is overlapped with _refcount and _mapcount.
> 
> No.  units is at offset 24, as is _mapcount.  But _refcount is still at
> offset 28.

Ah, got it what you mean. Sorry for the noise, Matthew.

> 
> >         union {
> >                 unsigned long counters;
> >                 int units;                      /* SLOB */
> >                 struct {                        /* Page cache */
> >                         atomic_t _mapcount;
> >                         atomic_t _refcount;
> >                 };
> >         };
