Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7DAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F37522419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXvMalY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F37522419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732824AbeKMV2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:28:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56187 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732474AbeKMV2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:28:13 -0500
Received: by mail-wm1-f66.google.com with SMTP id i73-v6so6235232wmd.5;
        Tue, 13 Nov 2018 03:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vctUhLnsUc7tdWAoKKcNuWXZjvL7vRAvEZCe7l6JX+0=;
        b=AXvMalY90whxOvbyyZ6A/zhzz8Iu4tafXCAHWeKJ16XlGFoHkBt5vq2A8V3/auMIiX
         RyUK2eRquUyr7+wEMgX/olgGbiXQdvxeAUZhDmPD/9QIH54ASmGj61YYru2Z71VC9OA+
         fmlP00KAH0RJP+8txz7xVwKU/K25u0I2vND/xEWfJhIuJhf2B5T88cyf6ecw/obtaWuO
         l8xRPfYnKsCY+sRGsv5NhKDzaDcW3zvdodVDwo9ClAVD3reDdbRKwzb6qdAVlxq9PRvu
         29TZdk7WmfH8ehXslF0ePa6T7wdzACLjbCNRpY+GERGq4w/tBBOaPMNGBvRhsz9+iPfN
         sAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vctUhLnsUc7tdWAoKKcNuWXZjvL7vRAvEZCe7l6JX+0=;
        b=ipp6UHI35WLgeFzOe4Cq9xrDU/+8fG27dhfjFttrGRUCgCwjBCP6sd1WWsQx4jT79Y
         NZHK/XpK4xsVyL/RxM4j3nPjwsIfDbzGFMhz+DXQUV1e4+E/h8b0pDUPTdc/KMpNZMgU
         aPj6eNhA5/iSMuxpDnb8CwNp2kr7xgOV7OScd4DAo/Ym9PizhHWmLuwbc57LzNB4uF1T
         bvcFlt16eDhV//G7T4LeAKYfzl7np7h344lAfm0ZNC/zq3bOgKLwGAux2XZEQR1g8Euy
         mW/d/nCEjsmYZIkxaMjLaVSgM6esfADBp/y1vB+VQJBaNZBNyOSBMO1GmThh7OQDbt5O
         NGJA==
X-Gm-Message-State: AGRZ1gLJf7kYJ/lpEY2D6SCWMzujPlKnW9SfTEB0mpA4dpGaD7ckE+mS
        RA+jbi2utXrngE8PQrtVxVI=
X-Google-Smtp-Source: AJdET5eOylwOPQ/0pjOsxVza+GKCWRibzYf6zOD3GxXrJMQJ4rctqIRw3LRQcul+e49sMTov6051Yw==
X-Received: by 2002:a1c:af47:: with SMTP id y68-v6mr3025981wme.33.1542108628946;
        Tue, 13 Nov 2018 03:30:28 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c6-v6sm1814554wre.45.2018.11.13.03.30.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 03:30:28 -0800 (PST)
Date:   Tue, 13 Nov 2018 12:30:25 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86: set a dependency on macros.S
Message-ID: <20181113113025.GC4788@gmail.com>
References: <20181112150215.508-1-namit@vmware.com>
 <20181112150215.508-3-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112150215.508-3-namit@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nadav Amit <namit@vmware.com> wrote:

> Changes in macros.S should trigger the recompilation of all C files, as
> the macros might need to affect their compilation.
> 
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  scripts/Makefile.build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index d2213b041408..ffe3e1a01210 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -312,13 +312,13 @@ cmd_undef_syms = echo
>  endif
>  
>  # Built-in and composite module parts
> -$(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
> +$(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) $(ASM_MACRO_FILE:.s=.S) FORCE
>  	$(call cmd,force_checksrc)
>  	$(call if_changed_rule,cc_o_c)
>  
>  # Single-part modules are special since we need to mark them in $(MODVERDIR)
>  
> -$(single-used-m): $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
> +$(single-used-m): $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) $(ASM_MACRO_FILE:.s=.S) FORCE
>  	$(call cmd,force_checksrc)
>  	$(call if_changed_rule,cc_o_c)
>  	@{ echo $(@:.o=.ko); echo $@; \

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
