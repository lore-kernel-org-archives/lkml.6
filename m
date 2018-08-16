Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C908C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFE72147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2VBUtBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AFE72147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391747AbeHPRTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 13:19:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44788 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbeHPRTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 13:19:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id f23-v6so2767893edr.11;
        Thu, 16 Aug 2018 07:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mPNAyvUc5igL1QygBGgNImKNgLha/c/d1hs8DeQhV5k=;
        b=B2VBUtBzh/fOoelUqAdJue7rhE/zTaKNs8kxX3tvkDFTxjfkexLb89nopZCVAH4ORP
         vy7fXn2V7OW0Je1NwhDIhGyd23GVxOAPAfTmFs3IwEkW7mtaFn3YJLKzlzd4b6Hzyboh
         UMJAHhyIZSqdBUebEkLcxO/XuRpveEBjSFB5ba0Ya+aJtzkwW6QY7/EItNVboudQpYZH
         j69SAcCT4LSsNTj/9RooTDy5CP4/pTXnTxU8jCWpKV+p2vmGLUC76JUfPXfVSL9QLa1E
         9UXAnVVwfiOtmiprhaH0KVoDX+jUUJp0txgWlFTzOuepYz1dnRXM8Qs150F4RklV2zR0
         qmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mPNAyvUc5igL1QygBGgNImKNgLha/c/d1hs8DeQhV5k=;
        b=rMvJDBKig6irFV8rj/MAfvJoZoXXK8tGjWAZijc9YAkP8zYv0T3I+zhgCyl7i7TYOQ
         tNy4ZRWlHrlF3g0IEBXsHwXrH8LGIAWhiJ9w/48vLIBmdS2d2CF6s1onq+7nA7zTN9Gd
         V36Su0qU+8LIjykkYkNbCB2jQOkRri7Jc8B4T4BYCdpqkJoFvIEP/llKt9yx2+b5pALI
         +/aMVmP109+ovlpYOVkP6tFn7dArbUylwPUy2798Hy/0GmqFdslXJSVtWmI72+40YZQh
         yUtE6GI6WCx+Jd1kfC+mCPdafjIzOvAO66Oio0MfpNeO/XN6hktatey0kCiPSDl8DWmn
         b6jA==
X-Gm-Message-State: AOUpUlHkEab0tlZZIEKMPYbRwHE0g/nJ/APOjrRBcvbHbXvRrqjq+DRP
        tVcm+ddcKeMKE349i0uCHQ==
X-Google-Smtp-Source: AA+uWPz2mRRQ4iz1dqFEs/3AJqky+0+iKMS3qhmKKTMO6BzB3263w2DR5h7BaboZJBHec9bN8pLUJA==
X-Received: by 2002:a50:b505:: with SMTP id y5-v6mr37080920edd.195.1534429247864;
        Thu, 16 Aug 2018 07:20:47 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id c34-v6sm1497412edc.71.2018.08.16.07.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 07:20:46 -0700 (PDT)
Date:   Thu, 16 Aug 2018 17:20:44 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 4/4] mm: proc/pid/smaps_rollup: convert to single value
 seq_file
Message-ID: <20180816142044.GB15817@avx2>
References: <20180723111933.15443-1-vbabka@suse.cz>
 <20180723111933.15443-5-vbabka@suse.cz>
 <cb1d1965-9a13-e80f-dfde-a5d3bf9f510c@suse.cz>
 <20180726162637.GB25227@avx2>
 <bf4525b0-fd5b-4c4c-2cb3-adee3dd95a48@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf4525b0-fd5b-4c4c-2cb3-adee3dd95a48@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 10:53:53AM +0200, Vlastimil Babka wrote:
> On 07/26/2018 06:26 PM, Alexey Dobriyan wrote:
> > On Wed, Jul 25, 2018 at 08:53:53AM +0200, Vlastimil Babka wrote:
> >> I moved the reply to this thread since the "added to -mm tree"
> >> notification Alexey replied to in <20180724182908.GD27053@avx2> has
> >> reduced CC list and is not linked to the patch postings.
> >>
> >> On 07/24/2018 08:29 PM, Alexey Dobriyan wrote:
> >>> On Mon, Jul 23, 2018 at 04:55:48PM -0700, akpm@linux-foundation.org wrote:
> >>>> The patch titled
> >>>>      Subject: mm: /proc/pid/smaps_rollup: convert to single value seq_file
> >>>> has been added to the -mm tree.  Its filename is
> >>>>      mm-proc-pid-smaps_rollup-convert-to-single-value-seq_file.patch
> >>>
> >>>> Subject: mm: /proc/pid/smaps_rollup: convert to single value seq_file
> >>>>
> >>>> The /proc/pid/smaps_rollup file is currently implemented via the
> >>>> m_start/m_next/m_stop seq_file iterators shared with the other maps files,
> >>>> that iterate over vma's.  However, the rollup file doesn't print anything
> >>>> for each vma, only accumulate the stats.
> >>>
> >>> What I don't understand why keep seq_ops then and not do all the work in
> >>> ->show hook.  Currently /proc/*/smaps_rollup is at ~500 bytes so with
> >>> minimum 1 page seq buffer, no buffer resizing is possible.
> >>
> >> Hmm IIUC seq_file also provides the buffer and handles feeding the data
> >> from there to the user process, which might have called read() with a smaller
> >> buffer than that. So I would rather not avoid the seq_file infrastructure.
> >> Or you're saying it could be converted to single_open()? Maybe, with more work.
> > 
> > Prefereably yes.
> 
> OK here it is. Sending as a new patch instead of delta, as that's easier
> to review - the delta is significant. Line stats wise it's the same.
> Again a bit less boilerplate thans to no special seq_ops, a bit more
> copy/paste in the open and release functions. But I guess it's better
> overall.
> 
> ----8>----
> From c6a2eaf3bb3546509d6b7c42f8bcc56cd7e92f90 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Wed, 18 Jul 2018 13:14:30 +0200
> Subject: [PATCH] mm: proc/pid/smaps_rollup: convert to single value seq_file

Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
