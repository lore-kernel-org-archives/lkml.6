Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9357BC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1F323C0C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 01:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwDan4t8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1F323C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934288AbeFVBaz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 21:30:55 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52804 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933948AbeFVBax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 21:30:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id p126-v6so522850wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 18:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DRJap80aN6hca01lyw+7BJXXOUvCiWkBqPZlzZV2+ds=;
        b=FwDan4t8QSQPqxOdzoLIZNx1+KfHvT6Ae2bRudJJoYT9RKybkdwX6a8HoQO+sas9J8
         x8dGqBDGTgbSpHFvwb3MT7i4JDf+zXHgKPF8bTAFd7yku6oql4FWH4PsewplATfaYMs+
         YmBNmPRyNi/Hzk/CVZw2/QSBQkAYa8WFz5oIvx1CpSDb8M36BnADvbA24ozxu6jIXPDS
         4ZC0dNrgpMzqEieFhEMqFCzRExB7FRiODQyKk88a5j0npQB/JryMStz50empMb2Ei/Kx
         xe+UnoT20UWGj0k7kGfbHe1II2nIHbXU9tat/lBooxqoQP0H0DXCPldKGWUBNTa4nO1Q
         bdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DRJap80aN6hca01lyw+7BJXXOUvCiWkBqPZlzZV2+ds=;
        b=cTIaBMKI1VctMY8MpvN+UbZEf7RvXjwb6zoAIWgJ4cjBo8O+D05raGmVPw1+FZnma1
         +rXn22V1zcebA1Aqgix5OYfKEIoyd5msYxaboD7NGy4Dsk253mu+mHOH2ZIHX8ckF8ev
         BQ4xFjNGGqDPqd3cJzH3jVhhytCKI+CuJrfi2TtnAjYArL6RSkmuAdn2XpWJe5qCUYDN
         foDzxCK9kp0anqdPy0vQe+0aKwBtxoT1wp439nssP2d97J3NfFcO0kLNulfg/o+rCFCt
         AAcdTQN1XTqm6kkS2gfjhQZ7QMCIwNVeweDcPMxfU/Xv2nZ6nKDnZEs5F/lb3Qdd2i5t
         TU5w==
X-Gm-Message-State: APt69E2e/DV/nMjQbi3icXzOQvU15daN/i0fqIuFGqQExCt3LzI8eb3e
        Ly0/ghMOY3TqUuFzXI5aT7s=
X-Google-Smtp-Source: ADUXVKKkKcIH/RlND/vgNdFCom8wQd3rc8dB5qqJLKdnst1O3UMLbuOY6zjYBEFt2fu6bVMDy628Pw==
X-Received: by 2002:a1c:3a91:: with SMTP id h139-v6mr7110559wma.94.1529631052321;
        Thu, 21 Jun 2018 18:30:52 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id k16-v6sm7386932wrh.25.2018.06.21.18.30.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 18:30:51 -0700 (PDT)
Date:   Fri, 22 Jun 2018 03:30:49 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        X86 ML <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] x86: optimize memcpy_flushcache
Message-ID: <20180622013049.GA12505@gmail.com>
References: <20180519052503.325953342@debian.vm>
 <20180519052631.730455475@debian.vm>
 <CAPcyv4jpY0x7kZtT+afAKnHKy8Uy1AC_N_QM7RrELSj_0iNrRw@mail.gmail.com>
 <20180524182013.GA59755@redhat.com>
 <20180618132306.GA25431@redhat.com>
 <20180621143140.GA14095@gmail.com>
 <alpine.LRH.2.02.1806211224470.19940@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1806211224470.19940@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mikulas Patocka <mpatocka@redhat.com> wrote:

> On Thu, 21 Jun 2018, Ingo Molnar wrote:
> 
> > 
> > * Mike Snitzer <snitzer@redhat.com> wrote:
> > 
> > > From: Mikulas Patocka <mpatocka@redhat.com>
> > > Subject: [PATCH v2] x86: optimize memcpy_flushcache
> > > 
> > > In the context of constant short length stores to persistent memory,
> > > memcpy_flushcache suffers from a 2% performance degradation compared to
> > > explicitly using the "movnti" instruction.
> > > 
> > > Optimize 4, 8, and 16 byte memcpy_flushcache calls to explicitly use the
> > > movnti instruction with inline assembler.
> > 
> > Linus requested asm optimizations to include actual benchmarks, so it would be 
> > nice to describe how this was tested, on what hardware, and what the before/after 
> > numbers are.
> > 
> > Thanks,
> > 
> > 	Ingo
> 
> It was tested on 4-core skylake machine with persistent memory being 
> emulated using the memmap kernel option. The dm-writecache target used the 
> emulated persistent memory as a cache and sata SSD as a backing device. 
> The patch results in 2% improved throughput when writing data using dd.
> 
> I don't have access to the machine anymore.

I think this information is enough, but do we know how well memmap emulation 
represents true persistent memory speed and cache management characteristics?
It might be representative - but I don't know for sure, nor probably most
readers of the changelog.

So could you please put all this into an updated changelog, and also add a short 
description that outlines exactly which codepaths end up using this method in a 
typical persistent memory setup? All filesystem ops - or only reads, etc?

Thanks,

	Ingo
