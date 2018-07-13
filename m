Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839B7ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A1D2084E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aMEC4jXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A1D2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbeGMSrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 14:47:37 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:39781 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbeGMSrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 14:47:37 -0400
Received: by mail-pf0-f176.google.com with SMTP id s21-v6so23113623pfm.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 11:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=r3FMSDiQV3JmxZWMJ14PXkNEu/22n4rUc4n/TyQF7WI=;
        b=aMEC4jXUSGk/Zpx2m78YZ3pg0+52QFmMXd1Hk1FHHQiljOxiH2NUjYQoGTLjSB/WI/
         35jT42gZMorldC1Rpi7qY8XC2RmNSqop942k8WKyx1G9Sp4kqaYEuqETmoqda/UJYQPV
         fhfX7sNdElJq9sw5gc45qEfU0A3aKKJmkJA2A6Jv4vfZKUGMVO3ZQC8WCl9svZfB6b3X
         WriRlS8evbiuUgZHhN3PxEexi3Ts62rTd82fAbajqK6hM/O4eegB/1JrPt3+Yu7G9p8a
         1SSGTEQyPxJ/u3odZbebJClNtWcgXGl44bLYB//c3Uj3nKVyDzd0UsGzIkroPxauJleo
         bzfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=r3FMSDiQV3JmxZWMJ14PXkNEu/22n4rUc4n/TyQF7WI=;
        b=TEkuYR+BnLcxzB5GATMKyRAnSxEbCVbyPHPHD/rttKNFmQD6BhOb03nr3koNMYbrrq
         dOSvyAcFTm/4IA46P7H9A+9SOspT4lYC/LmE1iITDCazU+bX9FTIsaH/IZjM7ens9lEq
         Zxegl/0a/eMv1DriGXvz99WIwgj0DMbQ1T2x2VC42Lt+aVbSz/lzYP364bAzOwGvpS/b
         +XIiaUvmCxbzen8zMVsTdJTgjejCWrMDmyXSWYaKxbwOJ9UUfjOnyOfJ5d4R0l9diKpd
         /nAPRxkRqozKOtvaw2C5nG81Pu4Wn+lLD0ilsigSpo31QRE+4+LrhYe5lqU25oCTQNu+
         MYNQ==
X-Gm-Message-State: AOUpUlHsvr+TDxeYkeYaPxIxpsixSP0JQxt3sva7HPjWDhWfdeJI2ScL
        6he1FiJK5OCVErSxBcbNxbh5Ug==
X-Google-Smtp-Source: AAOMgpeVSXgEsoidpZ0QwiZ64MatDmAKxrMxyrH3twI2WK860jOeeb/YqACesjTu/rBfvtuSCSLuJA==
X-Received: by 2002:a62:3f99:: with SMTP id z25-v6mr8307042pfj.250.1531506709502;
        Fri, 13 Jul 2018 11:31:49 -0700 (PDT)
Received: from [100.112.85.58] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id q26-v6sm10218715pff.9.2018.07.13.11.31.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 11:31:48 -0700 (PDT)
Date:   Fri, 13 Jul 2018 11:31:41 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "Metzger, Markus T" <markus.t.metzger@intel.com>
cc:     Hugh Dickins <hughd@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephane Eranian <eranian@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [bug] kpti, perf_event, bts: sporadic truncated trace
In-Reply-To: <A78C989F6D9628469189715575E55B236B3308EE@IRSMSX104.ger.corp.intel.com>
Message-ID: <alpine.LSU.2.11.1807131111440.6085@eggly.anvils>
References: <A78C989F6D9628469189715575E55B236B330102@IRSMSX104.ger.corp.intel.com> <alpine.LSU.2.11.1807121743050.5425@eggly.anvils> <A78C989F6D9628469189715575E55B236B3308EE@IRSMSX104.ger.corp.intel.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jul 2018, Metzger, Markus T wrote:
> Hello Hugh,
> 
> > A little "optimization" crept into alloc_bts_buffer() along the way, which now
> > places bts_interrupt_threshold not on a record boundary.
> > And Stephane has shown me the sentence in Vol 3B, 17.4.9, which says "This
> > address must point to an offset from the BTS buffer base that is a multiple of the
> > BTS record size."
> > 
> > Please give the patch below a try, and let us know if it helps (if it does not, then I
> > think we'll need perfier expertise than I can give).
> > 
> > Hugh
> > 
> > --- 4.18-rc4/arch/x86/events/intel/ds.c	2018-06-03 14:15:21.000000000 -0700
> > +++ linux/arch/x86/events/intel/ds.c	2018-07-12 17:38:28.471378616 -0700
> > @@ -408,9 +408,11 @@ static int alloc_bts_buffer(int cpu)
> >  	ds->bts_buffer_base = (unsigned long) cea;
> >  	ds_update_cea(cea, buffer, BTS_BUFFER_SIZE, PAGE_KERNEL);
> >  	ds->bts_index = ds->bts_buffer_base;
> > -	max = BTS_RECORD_SIZE * (BTS_BUFFER_SIZE / BTS_RECORD_SIZE);
> > -	ds->bts_absolute_maximum = ds->bts_buffer_base + max;
> > -	ds->bts_interrupt_threshold = ds->bts_absolute_maximum - (max / 16);
> > +	max = BTS_BUFFER_SIZE / BTS_RECORD_SIZE;
> > +	ds->bts_absolute_maximum = ds->bts_buffer_base +
> > +					max * BTS_RECORD_SIZE;
> > +	ds->bts_interrupt_threshold = ds->bts_absolute_maximum -
> > +					(max / 16) * BTS_RECORD_SIZE;
> >  	return 0;
> >  }
> > 
> 
> Your patch fixes it.

Oh, very welcome news! Thanks for putting in all the effort you did to
track down from your end: I'm relieved it was easier to fix than that.

> 
> Will you send it to the list for inclusion?

Sure, I'll send to x86 guys and lkml later today.  I can't promise that
it will make 4.18, since the regression it fixes pre-dates 4.18-rc; but
they don't usually insist on that rule for something as small and benign
as this, so I expect it'll make it.

> I'd appreciate if it could also be backported
> to 4.15, 4.16, and 4.17.

I'll mark it Cc stable, so that it will soon percolate through to the
4.14 longterm and 4.17 stable trees.  But 4.15 and 4.16 stable trees are
now EOL, so you'll have to apply the patch where you need it yourself -
it has no release-dependent subtlety, it should apply cleanly at offset.

Hugh
