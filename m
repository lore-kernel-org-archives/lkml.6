Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27470C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625CE276EB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="j+KqAhsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625CE276EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754559AbeF1Qvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:51:48 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39759 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030323AbeF1QvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:51:20 -0400
Received: by mail-wr0-f196.google.com with SMTP id b8-v6so6199894wro.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 09:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hN1PSpVVCB8Fc2dTaGwuRSYBOFHw261D8SYBja0zj1s=;
        b=j+KqAhsU8lvRS581/HOAZP8br4ZTA6BjQwgQYKDrjKBMutSWWMCk8weGmTM1j3IEeN
         542HCYOk0wzOYSaxHxlzWqU3UG3R6So+y4FzoXYSIg3/sdE3AK+psV8Ym4OZ1WSxiMNC
         lMtrJ2G4qgs2/xkji23CtQVV/sAVk6Got4vX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hN1PSpVVCB8Fc2dTaGwuRSYBOFHw261D8SYBja0zj1s=;
        b=SzH616hsHDuP+3CSVj/Eill8J8nWPzseOqmixYdRXC0+KS8Tzr+vOk1CKBhAaeFYfK
         DACzv13jYFXstNwBRKuqZFmV4oYbz24LA67Wtjt5z8ZvaJSMrHx3RLXGkxh9k2lgWWBI
         tNI/Zaq5ToTVFnVhWdxgt4np1ntmSNHfYKghoFPRqIlbatcXBW3L3aZzSn3/zxIFvExB
         4v9xhNKYpuUpBDMiQJLNtTeuNphDt5JMS+/XS5VkXnDgvXbZJwJwMUyStA15BJrizxNF
         FiJv3oBk59KHfs0ri4lFAykGNROI7za8OdOPj0ZSNUs8hBgbOkAVQyB3SMlEnDH/UIp+
         fTqw==
X-Gm-Message-State: APt69E04EUFUIW3YFoDeaNiwpl61INgtJhR45AwnyAsV2knuffGS5lGm
        v1BTfqinWVHpRbBQjgDBn6Eong==
X-Google-Smtp-Source: AAOMgpdD3Zs02wLYSs/X77HOBhc/kpAIoFfNMfSgnv1TrnVwT/C1lqlNTnQzVMkcz5yuxQKp9ZgiQQ==
X-Received: by 2002:adf:e3c5:: with SMTP id k5-v6mr8383454wrm.94.1530204679087;
        Thu, 28 Jun 2018 09:51:19 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id e3-v6sm11915953wmd.2.2018.06.28.09.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 09:51:18 -0700 (PDT)
Date:   Thu, 28 Jun 2018 18:51:11 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        akiyks@gmail.com, boqun.feng@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, npiggin@gmail.com,
        peterz@infradead.org, stern@rowland.harvard.edu,
        will.deacon@arm.com
Subject: Re: [PATCH 0/2] tools/memory-model: remove ACCESS_ONCE()
Message-ID: <20180628165111.GA4013@andrea>
References: <20180628123347.52963-1-mark.rutland@arm.com>
 <20180628123845.GA14456@andrea>
 <20180628152140.GK3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628152140.GK3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 1bc179880fba docs: atomic_ops: Describe atomic_set as a write operation
> 
> 	The above patches need at least one additional Acked-by
> 	or Reviewed-by.  If any of you gets a chance, please do
> 	look them over.

Glad this came out. ;-)

No objection to the patch: feel free to add my Reviewed-by: tag.

(BTW, atomic_set() would be better mapped to WRITE_ONCE()... in fact, to
 be fair, some archs do it the __asm__ __volatile__() way).

I do however have some suggestions concerning "the process":  searching
LKML for the patch and the related discussion, I could only find:

  [PATCH] docs: atomic_ops: atomic_set is a write (not read) operation

and I realize that none of the person Cc:-ed in this thread, except you,
were Cc:-ed in that discussion (in compliance with get_maintainer.pl).

My suggestions:

  1) Merge the file touched by that patch into (the recently created):
  
        Documentation/atomic_t.txt

     (FWIW, queued in my TODO list).

  2) Add the entry:

	F: Documentation/atomic_t.txt

     to the "ATOMIC INFRASTRUCTURE" subsystem in the MAINTAINERS file so
     that developers can easily find (the intended?) reviewers for their
     patch. (Of course, this will need ACK from the ATOMIC people).

  Andrea
