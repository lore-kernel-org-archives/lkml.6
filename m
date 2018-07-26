Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8134EC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C8E2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWq8gQI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C8E2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733013AbeGZRoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:44:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33127 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730413AbeGZRoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:44:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id x5-v6so1901542edr.0;
        Thu, 26 Jul 2018 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZsOuJMiPKpIqw1FwT7VFbgODgYasuEpTW/SHWxrQBKw=;
        b=HWq8gQI7Z7PusrpTjIjKj+1oBj31IwmjRFzCjuGuZX373WGsM1Ku1zyB//FSiNli2j
         GlMTWFT85Ww7axVByyy8IO70JaMhmwbr/Hl/mUDeqgHr+I0cf8NQuvz+2hdRTjZz6LX6
         GiaM7OgLgkZPdHui3Y/8zUpGbdwKQeFmP7oXHGLEGNNubBvQqrOGIFDAzUReIy5JLSvo
         PfxTniPzgg9DtGq762Pp3+gv6MOsFij17X7gZwrWp6ZASFnPFE+Ju4xRHQC+Nal6/Smr
         yMVXif79WZUot8zsvcgW6IzQ1rQ6i5KYc0dWMTXlgnlYsUyWs0Or4J/8PwG0/UYQCzzg
         1Qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZsOuJMiPKpIqw1FwT7VFbgODgYasuEpTW/SHWxrQBKw=;
        b=TP3GSmuQwSMn7QOCRCM5cOA6XHggoOjCRCskYk0oIRHpNaP5NBKLZQ25RoJ/BnRo6+
         nX0DAOoKG1L1je3SpR7HCN6o24s9mXLhLcg3nSZ2vImEQtxDy9EGTtNQf1akelH2vVmf
         hnxbmirF3tK3bJ2BkhYaZtLep2vn4Lf1YS2072Ie/Y+de+eNczLwCaqqkFgjp9pvRsg1
         yemK33XVTJKRtEtCDZ+f+TiMnBjDQwZuqXn+HJDZp4CvZILlQ1DSBMXELgbs73CsaI1n
         iMua4Z/FBfpSngVKFP8HizwD/+lVDZNG/SGWhYASRiUyK/bBmW1Oyd3mhhh+1+T0Whef
         k/SQ==
X-Gm-Message-State: AOUpUlHktDmaO5d6u9aHNtStIZSKVAUA3+tkyec+zy76x/YecWgwoiZO
        l8Tbkp1axPbxMVtfKJUTfw==
X-Google-Smtp-Source: AAOMgpfgnw73wVgd3BRixifPGouNyiBrlqm+o7JlpRgzoak7obFBPwIJR5XTW82tUgjPF1k496n21A==
X-Received: by 2002:a50:ba6e:: with SMTP id 43-v6mr3582102eds.292.1532622400526;
        Thu, 26 Jul 2018 09:26:40 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id o92-v6sm892261edb.85.2018.07.26.09.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 09:26:39 -0700 (PDT)
Date:   Thu, 26 Jul 2018 19:26:37 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 4/4] mm: proc/pid/smaps_rollup: convert to single value
 seq_file
Message-ID: <20180726162637.GB25227@avx2>
References: <20180723111933.15443-1-vbabka@suse.cz>
 <20180723111933.15443-5-vbabka@suse.cz>
 <cb1d1965-9a13-e80f-dfde-a5d3bf9f510c@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb1d1965-9a13-e80f-dfde-a5d3bf9f510c@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 08:53:53AM +0200, Vlastimil Babka wrote:
> I moved the reply to this thread since the "added to -mm tree"
> notification Alexey replied to in <20180724182908.GD27053@avx2> has
> reduced CC list and is not linked to the patch postings.
> 
> On 07/24/2018 08:29 PM, Alexey Dobriyan wrote:
> > On Mon, Jul 23, 2018 at 04:55:48PM -0700, akpm@linux-foundation.org wrote:
> >> The patch titled
> >>      Subject: mm: /proc/pid/smaps_rollup: convert to single value seq_file
> >> has been added to the -mm tree.  Its filename is
> >>      mm-proc-pid-smaps_rollup-convert-to-single-value-seq_file.patch
> > 
> >> Subject: mm: /proc/pid/smaps_rollup: convert to single value seq_file
> >>
> >> The /proc/pid/smaps_rollup file is currently implemented via the
> >> m_start/m_next/m_stop seq_file iterators shared with the other maps files,
> >> that iterate over vma's.  However, the rollup file doesn't print anything
> >> for each vma, only accumulate the stats.
> > 
> > What I don't understand why keep seq_ops then and not do all the work in
> > ->show hook.  Currently /proc/*/smaps_rollup is at ~500 bytes so with
> > minimum 1 page seq buffer, no buffer resizing is possible.
> 
> Hmm IIUC seq_file also provides the buffer and handles feeding the data
> from there to the user process, which might have called read() with a smaller
> buffer than that. So I would rather not avoid the seq_file infrastructure.
> Or you're saying it could be converted to single_open()? Maybe, with more work.

Prefereably yes.

There are 2 ways to using seq_file:
* introduce seq_operations and iterate over objects printing them one by one,
* use single_open and 1 ->show hook and do all the work of collecting
  data there and print once.

  /proc/*/smaps_rollup is suited for variant 2 because variant 1 is
  designed for printing arbitrary amount of data.


> >> +static int show_smaps_rollup(struct seq_file *m, void *v)
> >> +{
> >> +	struct proc_maps_private *priv = m->private;
> >> +	struct mem_size_stats *mss = priv->rollup;
> >> +	struct vm_area_struct *vma;
> >> +
> >> +	/*
> >> +	 * We might be called multiple times when e.g. the seq buffer
> >> +	 * overflows. Gather the stats only once.
> > 
> > It doesn't!
> 
> Because the buffer is 1 page and the data is ~500 bytes as you said above?
> Agreed, but I wouldn't want to depend on data not growing in the future or
> the initial buffer not getting smaller. I could extend the comment that this
> is theoretical for now?

Given the rate of growth I wouldn't be concerned.

> >> +	if (!mss->finished) {
> >> +		for (vma = priv->mm->mmap; vma; vma = vma->vm_next) {
> >> +			smap_gather_stats(vma, mss);
> >> +			mss->last_vma_end = vma->vm_end;
> >>  		}
> >> -		last_vma = !m_next_vma(priv, vma);
> >> -	} else {
> >> -		rollup_mode = false;
> >> -		memset(&mss_stack, 0, sizeof(mss_stack));
> >> -		mss = &mss_stack;
