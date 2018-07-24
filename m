Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6146C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8028B20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvG6ZspS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8028B20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388597AbeGXTg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:36:56 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:40764 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388386AbeGXTg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:36:56 -0400
Received: by mail-ed1-f41.google.com with SMTP id e19-v6so4946349edq.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 11:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pF1E53ahFgFoZEzrq0Bn5AJykCFtor6bJ4xRAeCaIJo=;
        b=UvG6ZspSyvTtH/MYuUD4XfsSsif7hi/dSun53QFAx+HzMWjYGsG2pmjutLAY9Zitmf
         qSMCXREdXmEJe8OPr/kmIPLaX60p5tHzGsa050m+ZOGvkoOCcbm6rOru/4N8zqFtHzSx
         nKPTDdic4GpoIiT7BaY0iLDB/qGuVnQzz65AiKwgk74F+fQsCkFNOHwK/w3lJfhDmSjI
         SC+YesS+3OyCEtNGkAOe/J49Z79DyHQxvPxgs88iTmmTfweEtLb1gy3rlhdaZdAQUZU+
         KUz7pdfNlvq8gAMW1EJV4JPCspOIrHFtpaBY3l+9aFrJ/sLfHBzjtCppGyCA9nai0j2k
         ka7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pF1E53ahFgFoZEzrq0Bn5AJykCFtor6bJ4xRAeCaIJo=;
        b=WbMTQ6B54k5oYgXp6eXbluTCtWLfiopuF6GWAOuEm9vCkdY2s9XT7Zh8Lnsc1RV22Z
         RQ5izBNvjT4K5swAN2tM99cY5d6NXck7+zWJXRx3Z54gZH3TJl1yVKhNOQcXmCvE9Zw3
         Y5NRPWSeK0A9WfYS60kpppgxdqdUbyvLijeE4tJLHOHSjCzhh0dg9vvU/Xr99oYjdlzY
         Omaa91zGE8AxYaj6UaWIDQsO2bD1bPccJdN0s4P5qyo3mOc0Wh7dhVX2+fv1sfGVzodE
         ZNkLFTvGmGAnNVSojJD9/TFuzeyIvCuQdQ+BapG1+9a8Gl5V0ViPCOi9GJqchPHdgQmd
         pIhQ==
X-Gm-Message-State: AOUpUlHlLcS5KHoAcHrNm/pSrdJuS91xXsRaRdLh/udc6K7ctVuPIODJ
        QUhqyrL7fUxl8a3RpmZgnko9zm0=
X-Google-Smtp-Source: AAOMgpfX8LQOU4FQM3C8FXwcp4xyKpq8en9Pi6qHUvLVKxF/jsyDQ3A+bwpg57VQjg+uRcjVVQxPZw==
X-Received: by 2002:a50:f049:: with SMTP id u9-v6mr19848441edl.91.1532456950683;
        Tue, 24 Jul 2018 11:29:10 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id e20-v6sm4883031eds.20.2018.07.24.11.29.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 11:29:10 -0700 (PDT)
Date:   Tue, 24 Jul 2018 21:29:08 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, dancol@google.com, vbabka@suse.cz
Subject: Re: +
 mm-proc-pid-smaps_rollup-convert-to-single-value-seq_file.patch added to -mm
 tree
Message-ID: <20180724182908.GD27053@avx2>
References: <20180723235548.nLTzP%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180723235548.nLTzP%akpm@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 04:55:48PM -0700, akpm@linux-foundation.org wrote:
> The patch titled
>      Subject: mm: /proc/pid/smaps_rollup: convert to single value seq_file
> has been added to the -mm tree.  Its filename is
>      mm-proc-pid-smaps_rollup-convert-to-single-value-seq_file.patch

> Subject: mm: /proc/pid/smaps_rollup: convert to single value seq_file
> 
> The /proc/pid/smaps_rollup file is currently implemented via the
> m_start/m_next/m_stop seq_file iterators shared with the other maps files,
> that iterate over vma's.  However, the rollup file doesn't print anything
> for each vma, only accumulate the stats.

What I don't understand why keep seq_ops then and not do all the work in
->show hook.  Currently /proc/*/smaps_rollup is at ~500 bytes so with
minimum 1 page seq buffer, no buffer resizing is possible.

> +static int show_smaps_rollup(struct seq_file *m, void *v)
> +{
> +	struct proc_maps_private *priv = m->private;
> +	struct mem_size_stats *mss = priv->rollup;
> +	struct vm_area_struct *vma;
> +
> +	/*
> +	 * We might be called multiple times when e.g. the seq buffer
> +	 * overflows. Gather the stats only once.

It doesn't!

> +	if (!mss->finished) {
> +		for (vma = priv->mm->mmap; vma; vma = vma->vm_next) {
> +			smap_gather_stats(vma, mss);
> +			mss->last_vma_end = vma->vm_end;
>  		}
> -		last_vma = !m_next_vma(priv, vma);
> -	} else {
> -		rollup_mode = false;
> -		memset(&mss_stack, 0, sizeof(mss_stack));
> -		mss = &mss_stack;
