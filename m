Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA2EC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB552173A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 02:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tW3wbEWu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB552173A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbeI1IsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:48:22 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32911 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbeI1IsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:48:22 -0400
Received: by mail-qt1-f195.google.com with SMTP id i10-v6so5127477qtp.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 19:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vgg734w2VRTbLIrmv6jPK5C1q8TmThIc5Lqdq3tXCso=;
        b=tW3wbEWu9+E9Hx51GDWjHRq5VxXYN4lvBKEeI1Rv/iQ5CsF3u/ZNXQ/Wmje9/c700O
         IilZ3JSBAy9fK6JsePWay5TU44RA3KondiFg2AFKZROxEgcuFoS7P+2bzzpgah4tZVax
         Nc7bWCsHNvJGvcwkVa+1MvjgF/t1UWGBl9cRqqqT/RfdmabWN88+ua9EWXw451fAS04f
         8lRL3TnzL1Akt1YHw+vPpL4LhN+fxJ8YH3JcFOitVjSCfXa2U/X0Ve5DhI+W48egWQNm
         kC5sX/WPYtGD/wXqbcIYY4q1vXOy9PUkDCYOPkbQmXtIp9HhwNTj+B8tX8azVv86Z+15
         ZiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vgg734w2VRTbLIrmv6jPK5C1q8TmThIc5Lqdq3tXCso=;
        b=mRyRtRqko25H1mBdxgUhbY60rYMHzZkGztEJ+aIPjgv025HLfmds0Chaa1n9shtrqb
         GS4LlOF9PQX8NKnkXsIFxUHXZgsnlLNUVcBKoAx7zkDoY1sfDS7qAY2y0zAbMJHEJkZq
         eUcKuObdl7Ao/J31rLp45y5KBgNfLIYq25yPh9GedAs+YY5iN9Cr0CgD4+Eg5ZqmF+y+
         EFgoXoF7gTMndWfjnqyGBH7II2Jb9K9qlRZX0eP5OTOsZXfDVlw+CLUKwn+uftgKWaGk
         ZViALJSvtVIN+OONAafFWpgsFp6xpnMQcXSSGORr6h6T+ycdWucTNO30Phww6sFf6p9J
         ByMg==
X-Gm-Message-State: ABuFfohrgVjyV+RqK2giGzTKQ4beKtk8LFlidj7UCAIra0rnNfNohvLl
        yEb5gCBMgjmoOdeXVVBQ7w==
X-Google-Smtp-Source: ACcGV62phdMLIhjCiBNQL4QABdkkGB9/dYv220K85RCwKP5CU1t6Ff/RY91/C5urV/9foSDkzIw6lQ==
X-Received: by 2002:ac8:910:: with SMTP id t16-v6mr10721033qth.169.1538101618316;
        Thu, 27 Sep 2018 19:26:58 -0700 (PDT)
Received: from gabell ([2601:18f:600:d880:61f5:1cd1:112d:c09c])
        by smtp.gmail.com with ESMTPSA id f184-v6sm2139582qkc.23.2018.09.27.19.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 19:26:58 -0700 (PDT)
Date:   Thu, 27 Sep 2018 22:26:56 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] docs: kernel-parameters.txt: document
 rand_mem_physical_padding parameter
Message-ID: <20180928022655.xxt6raznpewrc7cs@gabell>
References: <20180927203146.12201-1-msys.mizuma@gmail.com>
 <20180927203146.12201-4-msys.mizuma@gmail.com>
 <20180927211747.GD19687@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927211747.GD19687@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:17:47PM +0200, Borislav Petkov wrote:
> On Thu, Sep 27, 2018 at 04:31:46PM -0400, Masayoshi Mizuma wrote:
> > From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > 
> > This kernel parameter allows to change the padding used
> > for the physical memory mapping section when KASLR
> > memory is enabled.
> > 
> > For memory hotplug capable systems, the default padding size,
> > CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING, may not be enough.
> > The option is useful to adjust the padding size.
> > 
> > Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 92eb1f4..de43cdf 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3529,6 +3529,13 @@
> >  			fully seed the kernel's CRNG. Default is controlled
> >  			by CONFIG_RANDOM_TRUST_CPU.
> >  
> > +	rand_mem_physical_padding=
> > +			[KNL] Define the padding size in terabytes
> > +			used for the physical memory mapping section
> > +			when KASLR memory is enabled.
> > +			The default value is
> > +			CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING.
> 
> Yet another kernel parameter which forces me to go look at what the
> code does because this help text doesn't really help. And I see that in
> previous iterations ok lkml it was *actually* properly explained why
> this parameter is needed.
> 
> So please summarize that explanation here so that the user can make an
> informed decision when reading this help text. Always think of explaning
> this to a colleague of yours who doesn't know about the memory padding
> and memory hotadd problematic and try to write it in such a way so that
> your colleague understands it.
> 
> :-)

You are right, I didn't make it clear enough...
Thank you for your comments, I'll fix the description.

Thanks!
Masa
