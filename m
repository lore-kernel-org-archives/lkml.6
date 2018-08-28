Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B158C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4912087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 23:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="giXL20cY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B4912087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbeH2DqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 23:46:08 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39681 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbeH2DqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 23:46:08 -0400
Received: by mail-qt0-f195.google.com with SMTP id o15-v6so3833240qtk.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 16:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=H7DJrGqGJef5RWJ0y5DZALQeh35kEgheLtOZvllkCnc=;
        b=giXL20cYnifrHmrue3Rshzt+d2Ui6aMF6nY5xkgKCW+18gAmOwkTYjAFTl3Ipq3oAG
         nFcm+VLAYh6oZUTNf8KNTWtmSdRE4xaAoVAR+Weu6RqD79OP7vYuzF0DZhw60b0V9wNK
         O3/31wBSBYMiX+WfadYSPNCgDC3ODbwShvRx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=H7DJrGqGJef5RWJ0y5DZALQeh35kEgheLtOZvllkCnc=;
        b=AzsJiJ8v6DyKWgXcBZYvJ6BjXXWD/iBYC8Om5eb3YJqROZd8VlmYiTk2fYwPIJxW0b
         ZdvEoDT9n8DE7njDOsNk/63a68+fBeqv7snpg3UR2t66NaW6rd03pCFHz36Strj++iiR
         ciP8Nur+1QjvvfzIVjtNsRi9yqmz8F4AwR6/yjHK0r1bpysqOSzsUQ36kFDqZbKG3oBO
         Wj0XEK7VGpdGFTEdH7W5eJd+AeyQ8QeQm641tbuSdmW4VsweAQg7wq8jvAW3JG7fs+6N
         IZSJNDxukNBd2ov/fZy4Fqq2s5TuAi40KUOqNGfXs46xSOJFjG5utaYaz3Em4AndicHR
         SPhg==
X-Gm-Message-State: APzg51CUaQmDUjErkPQb3Az0Dch0adaxt2dVKEYI4PUagXm6nrrZJNtQ
        13+2P4RdhzxUDCMiLPVgdubQsA==
X-Google-Smtp-Source: ANB0VdbrA6dBxyj5c/TVaUtk98KVn/gVOtkITMFkox3ufDprT3Cd5IUypMsh9tKCwCi4QfMcXvIfXQ==
X-Received: by 2002:ad4:50ce:: with SMTP id e14-v6mr3956825qvq.232.1535500325441;
        Tue, 28 Aug 2018 16:52:05 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id w9-v6sm1643608qta.13.2018.08.28.16.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 16:52:04 -0700 (PDT)
Date:   Tue, 28 Aug 2018 19:52:03 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Matthew Wilcox <willy@infradead.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] cramfs: Convert to use vmf_insert_mixed
In-Reply-To: <20180828220427.GA11400@bombadil.infradead.org>
Message-ID: <nycvar.YSQ.7.76.1808281940360.10215@knanqh.ubzr>
References: <20180828145728.11873-1-willy@infradead.org> <20180828145728.11873-2-willy@infradead.org> <nycvar.YSQ.7.76.1808281235060.10215@knanqh.ubzr> <20180828220427.GA11400@bombadil.infradead.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018, Matthew Wilcox wrote:

> On Tue, Aug 28, 2018 at 01:49:25PM -0400, Nicolas Pitre wrote:
> > On Tue, 28 Aug 2018, Matthew Wilcox wrote:
> > > -			ret = vm_insert_mixed(vma, vma->vm_start + off, pfn);
> > > +			vmf = vmf_insert_mixed(vma, vma->vm_start + off, pfn);
> > > +			if (vmf & VM_FAULT_ERROR) {
> > > +				pages = i;
> > > +				break;
> > > +			}
> > 
> > I'd suggest this to properly deal with errers instead:
> > 
> > -			ret = vm_insert_mixed(vma, vma->vm_start + off, pfn);
> > +			vmf = vmf_insert_mixed(vma, vma->vm_start + off, pfn);
> > +			if (vmf & VM_FAULT_ERROR)
> > +				ret = vm_fault_to_errno(vmf, 0);
> 
> By my reading of this function, the intent is actually to return 0
> here and allow demand paging to work.  Of course, I've spent all of
> twenty minutes staring at this function, so I defer to the maintainer.

Demand paging is used when the filesystem layout isn't amenable to a 
direct mapping.  It is not a fallback for when we're OOM or some other 
internal errors which ought to be reported immediately.

> I think you'd need to be running a make-memory-allocations-fail fuzzer
> to hit this, so it's likely never been tested.

Well, it has been tested sort of, e.g. when vm_insert_mixed() returned 
an error due to misaligned addresses during development.  Normally, 
vm_insert_mixed() and vmf_insert_mixed() should always succeed, and if 
they don't we certainly don't want to ignore it.


Nicolas
