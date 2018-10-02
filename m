Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59604C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1FC920684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NrH8PIBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1FC920684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbeJBNAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 09:00:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46964 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbeJBNAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 09:00:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id v5-v6so127665plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 23:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vBC16zRhhpl/FWMvNay4Y6NFeKxR+UjhwN37peUPwN8=;
        b=NrH8PIBfj8N3SMjBhqBFB0PX1Ca9J1TTJvby/iyhlqH7Mrwxymp2SlvqhlrtwQNKUp
         FwUSaSI7jpIFPUG1iZWzBN6vMubOSTHDbFU6+T9Q665XkmCcWcqGgZKiB8p+y4tI8SJ7
         iGBdLXqea8M8562Kny1jEKhnPfuUx+pwy4NUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=vBC16zRhhpl/FWMvNay4Y6NFeKxR+UjhwN37peUPwN8=;
        b=tDjLbi6JOW1smXQSOCu6OZhMTp4pg4eazum+cxy5aNBv/Hf33FUuX4BPBU1UH/3aeW
         mkg8gU2I7E4JF2gt0fWZ7WBoHcbnGIV/AycOEGQh2TVuFNObC9eFfamS1cCnEMzXiXFl
         Xg9t2nmbEqibNPWsDeUvBhf8GiX30xx7M73/i9g0R0Rh+fwarnBipvMszk+hzwkGC5aA
         9J6ZHddEvar21dDcrKVNiJucJ3JVdQPPRgGtbHWr+Fu5oJarPhTj0Rdy71NHmzPfhkpW
         9bUaZV52ZC5ateuse4ryawcC0FA7MimzdD2ZuOTC4kppWEL+3RtXN35OfcWWYL/0veAj
         pv7Q==
X-Gm-Message-State: ABuFfoi5l+TwfEqdF+5SXO9jAZUz3ZE+5GtW8sV2fZWBKH9bbyYz2l6A
        JPKWGLEpehyY7ZrX9bg/LdcYzzyKtL0=
X-Google-Smtp-Source: ACcGV63XjG4Xb1RJ8LchejxG6cPOG4eboLQ/2paXzMzjulRE5BV/6FIgdAu/OzLbgmF0302mkbJASA==
X-Received: by 2002:a63:6a42:: with SMTP id f63-v6mr13512354pgc.48.1538461136445;
        Mon, 01 Oct 2018 23:18:56 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id q26-v6sm22912185pfj.127.2018.10.01.23.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 23:18:55 -0700 (PDT)
Date:   Tue, 2 Oct 2018 15:20:23 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Dave Young <dyoung@redhat.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, bhe@redhat.com, arnd@arndb.de,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        prudo@linux.ibm.com, james.morse@arm.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v15 04/16] powerpc, kexec_file: factor out memblock-based
 arch_kexec_walk_mem()
Message-ID: <20181002062021.GE32578@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Dave Young <dyoung@redhat.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        prudo@linux.ibm.com, james.morse@arm.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180928064841.14117-1-takahiro.akashi@linaro.org>
 <20180928064841.14117-5-takahiro.akashi@linaro.org>
 <20180930100834.GD6950@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180930100834.GD6950@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 06:08:34PM +0800, Dave Young wrote:
> Hi AKASHI,
> 
> On 09/28/18 at 03:48pm, AKASHI Takahiro wrote:
> > Memblock list is another source for usable system memory layout.
> > So move powerpc's arch_kexec_walk_mem() to common code so that other
> > memblock-based architectures, particularly arm64, can also utilise it.
> > A moved function is now renamed to kexec_walk_memblock() and integrated
> > into kexec_locate_mem_hole(), which will now be usable for all
> > architectures with no need for overriding arch_kexec_walk_mem().
> > 
> > With this change, arch_kexec_walk_mem() need no longer be a weak function,
> > and was now renamed to kexec_walk_resources().
> > 
> > Since powerpc doesn't support kdump in its kexec_file_load(), the current
> > kexec_walk_memblock() won't work for kdump either in this form, this will
> > be fixed in the next patch.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> > Acked-by: Dave Young <dyoung@redhat.com>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Acked-by: James Morse <james.morse@arm.com>
> 
> [snip]
> 
> > +
> >  /**
> >   * arch_kexec_walk_mem - call func(data) on free memory regions
> 
> The function name should be updated as well.

Ah, thank you.
-Takahiro Akashi

> >   * @kbuf:	Context info for the search. Also passed to @func.
> > @@ -510,8 +560,8 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
> >   * and that value will be returned. If all free regions are visited without
> >   * func returning non-zero, then zero will be returned.
> >   */
> > -int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
> > -			       int (*func)(struct resource *, void *))
> > +static int kexec_walk_resources(struct kexec_buf *kbuf,
> > +				int (*func)(struct resource *, void *))
> >  {
> >  	if (kbuf->image->type == KEXEC_TYPE_CRASH)
> >  		return walk_iomem_res_desc(crashk_res.desc,
> > @@ -538,7 +588,11 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
> >  	if (kbuf->mem != KEXEC_BUF_MEM_UNKNOWN)
> >  		return 0;
> >  
> > -	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
> > +	if (IS_ENABLED(CONFIG_HAVE_MEMBLOCK) &&
> > +			!IS_ENABLED(CONFIG_ARCH_DISCARD_MEMBLOCK))
> > +		ret = kexec_walk_memblock(kbuf, locate_mem_hole_callback);
> > +	else
> > +		ret = kexec_walk_resources(kbuf, locate_mem_hole_callback);
> >  
> >  	return ret == 1 ? 0 : -EADDRNOTAVAIL;
> >  }
> > -- 
> > 2.19.0
> > 
> 
> Thanks
> Dave
