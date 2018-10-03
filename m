Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEB6C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80ACC2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOje09TE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80ACC2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeJCRsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 13:48:42 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46652 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJCRsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 13:48:42 -0400
Received: by mail-yw1-f66.google.com with SMTP id j202-v6so2065952ywa.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 04:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8z87P4HtDiOXCFZtuVfdZIeyCnzQ45X44de/aMR3EUE=;
        b=jOje09TEXv1XenN6nhi4R2oIQXuHoo1M2j68thmLwgFTyUJIQLBodTF0hV1eKgdwsk
         QUj49IMw76B2lQQjB11Ra5awzG9l8umYBEn0eOtJmdhapij0xmw1tsbdJmKoOQrmEUxF
         q3rwRyoChM5Y4CBeH8ohVF7qKH9N4sm/AU6q63Tpulle37i1OMAWOhBpwDa2LZXmZ1e/
         BAB13gFSuk8Sfds6rdjMDwz95LBN5FTl2ljXNgd8odH6KdEtHbBOesKybWelP8RfLK8y
         j05HiCtnN301EktCU1h5p6TK87AkjqZJdbAiNDYHjNKVo1TpW8/SVIIxnJUF3Ehp/kuE
         6WWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8z87P4HtDiOXCFZtuVfdZIeyCnzQ45X44de/aMR3EUE=;
        b=sDItDZGVENf3sHOqZAU3H27NuD012USgYPLrxF4DO3NAHCuYe/Yzqj8ijiv69C2dlG
         Bt/xxvyetWjSvS0eJYAS9xQJtwHl6cEiVIAoN12ihhoYNPigKKZziNAvgaOJXmd3FDv7
         vKCzqvvM5obtRt7cY1JLYEywlp+gGNKTc0Og7qUpH8AHgt52HlVe9NSCkKC8kGRkqGU/
         Ir1H6ZEznuXYsDmZq5kLIafJYpYkvid3Sy1op1aVmGO4Kksw/KAiLIeLgZVkwfaZJZai
         yJnpLgjZUfsD+pzcL4JZMpAd1K2WyTL+AJqSj4B+3/RWQ0Vez3Nj9I4lNyP6Iopz3MHx
         A0vA==
X-Gm-Message-State: ABuFfohMEUzu9E+Syw/vIKh+7Tph+Q6+iOJspck6rJYbpNuSmYnSh7YB
        r5pE9+PDpWtWLSFeq/qk1w==
X-Google-Smtp-Source: ACcGV61CGhVNs1ktFBfAWv2tA0NtAydY7fE4RQf2MpfrUkuBbDOlfj3haa6To9aTN3BcPl+Wk+4C/A==
X-Received: by 2002:a81:4316:: with SMTP id q22-v6mr436031ywa.298.1538564448939;
        Wed, 03 Oct 2018 04:00:48 -0700 (PDT)
Received: from gabell (c-98-229-178-29.hsd1.ma.comcast.net. [98.229.178.29])
        by smtp.gmail.com with ESMTPSA id w6-v6sm377479ywg.3.2018.10.03.04.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 04:00:48 -0700 (PDT)
Date:   Wed, 3 Oct 2018 07:00:46 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] Add a kernel parameter to change the padding size
 for KASLR
Message-ID: <20181003110045.naxl3r6dhi3vkbk4@gabell>
References: <20181003013323.4162-1-msys.mizuma@gmail.com>
 <20181003065219.GA28386@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003065219.GA28386@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 08:52:19AM +0200, Ingo Molnar wrote:
> 
> * Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
> 
> > This patch series are adding an kernel parameter to change
> > the padding size used for KASLR. It is useful for memory hotplug
> > capable system. User can adjust the padding size to use it.
> > 
> > It is better if the padding size is calculated automatically,
> > however, ACPI SRAT is not available at the KASLR initialization
> > time. So, I add a message for user to tell the suitable padding
> > size. User can set it on next reboot.
> > 
> > This patch series don't change the current default padding size.
> > 
> > Change log from v5:
> >  - Fix build error if CONFIG_RANDOMIZE_MEMORY is not defined.
> 
> Please send a delta patch on top of tip:x86/boot with the get_rand_mem_physical_padding() fix, 
> when doing that you'll see that I did some minor cleanups when applying the patches which your 
> v6 series undoes.

I have sent the delta patch. Thanks!

- Masa
