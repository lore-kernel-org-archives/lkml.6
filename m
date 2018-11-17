Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7ECC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 05:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B771420858
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 05:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKT3I168"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B771420858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbeKQPfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 10:35:42 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34697 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbeKQPfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 10:35:42 -0500
Received: by mail-pl1-f193.google.com with SMTP id f12-v6so12109685plo.1;
        Fri, 16 Nov 2018 21:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a7dNnNkvZDAMWYUfe3qtXZ1duI1DtoS9WPn8Xt85hKg=;
        b=EKT3I168RNuTaxLaYO4b16UdsepPEGKYf1LLXGUqShilsYCRb7ooG4n7mLiyQ/sf9o
         Vbm7CTD+owvdpSpSjvJzeAdDP/0Ex3zXtp2lbTMM2sZHQr3c7Rbzuz35tBr4bDKMKV5Z
         lARBjOa7MzriH1DzFiQY9NVne9WbjfA5vSil/Bx1iHaAWuzI1oplw1UC8pY+6y6YNEPz
         tGc1guHUpqXkbQpUbc3+UlGnF1HyiW1qqvMwqlquhPWOu3cPqy+HTneHgBvIWlHqSI+M
         OMaaortF4Lm8EL1KnziqYSCXkjwwivXVb0XWqNd3Z2bmGG7LEVkPODbXcw2WSnIz4CfW
         TTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a7dNnNkvZDAMWYUfe3qtXZ1duI1DtoS9WPn8Xt85hKg=;
        b=nu+CAkIn3UVZ2hn6P2x70XYFmB9JvKs4AZVMqmxdbIxxm8zLsOUts5CpCYp1ysk5bV
         HYCK3AVCR07DV3aW8TUH8r3+vbjO110r2foq/zx8sKJOo2ubLfKTVF+nxhfgqwDxhI6e
         2MvsApDlNfr6wPAvbZI0R66xJb5oyHfJKh6PsDSIbvdm27O0VqxF8WysBMij75XPFtcz
         nBhS8wcMREwVhotNKBfOhhqpFiWWS7vNIiJFCSSYwzazsul9AQDsnQ0dVDwpgCnWkf0E
         lwrbyXY+XGF7luc/aoenplUWMj0TkgXZSVw1fHy2ttP/rapO/5gwXoUSWv6AWMMbJqvZ
         mCRA==
X-Gm-Message-State: AGRZ1gJCOrf0G+KzlYleXvkpHBZVtuc8vZqMZ6b6KkrZbjIp7bSGtmYl
        cyjS229QFKtS1eAnbOPo4Dw=
X-Google-Smtp-Source: AJdET5dLivVgQVflPRwDJvINZgHs8dM2qI684I4fiMRgrfuT8g8PTXWqSPWg62bwA+J4RdkKmPZAvA==
X-Received: by 2002:a17:902:7848:: with SMTP id e8mr14084329pln.100.1542432014133;
        Fri, 16 Nov 2018 21:20:14 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:eb1f])
        by smtp.gmail.com with ESMTPSA id s9sm25073880pgl.88.2018.11.16.21.20.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 21:20:13 -0800 (PST)
Date:   Fri, 16 Nov 2018 21:20:11 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Roman Gushchin <guro@fb.com>,
        daniel@iogearbox.net
Subject: Re: [PATCH bpf] bpf: allocate local storage buffers using GFP_ATOMIC
Message-ID: <20181117052010.y3ta6vsdmye7iah5@ast-mbp.dhcp.thefacebook.com>
References: <20181114180034.25558-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114180034.25558-1-guro@fb.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 10:00:34AM -0800, Roman Gushchin wrote:
> Naresh reported an issue with the non-atomic memory allocation of
> cgroup local storage buffers:
> 
> [   73.047526] BUG: sleeping function called from invalid context at
> /srv/oe/build/tmp-rpb-glibc/work-shared/intel-corei7-64/kernel-source/mm/slab.h:421
> [   73.060915] in_atomic(): 1, irqs_disabled(): 0, pid: 3157, name: test_cgroup_sto
> [   73.068342] INFO: lockdep is turned off.
> [   73.072293] CPU: 2 PID: 3157 Comm: test_cgroup_sto Not tainted
> 4.20.0-rc2-next-20181113 #1
> [   73.080548] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.0b 07/27/2017
> [   73.088018] Call Trace:
> [   73.090463]  dump_stack+0x70/0xa5
> [   73.093783]  ___might_sleep+0x152/0x240
> [   73.097619]  __might_sleep+0x4a/0x80
> [   73.101191]  __kmalloc_node+0x1cf/0x2f0
> [   73.105031]  ? cgroup_storage_update_elem+0x46/0x90
> [   73.109909]  cgroup_storage_update_elem+0x46/0x90
> 
> cgroup_storage_update_elem() (as well as other update map update
> callbacks) is called with disabled preemption, so GFP_ATOMIC
> allocation should be used: e.g. alloc_htab_elem() in hashtab.c.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>

applied to bpf tree, thanks

