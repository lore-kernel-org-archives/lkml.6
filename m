Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D11C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7470E20675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545068324;
	bh=/l9I2cK4UGgS8qmiufKHDyayT7j9sYtHwkPA5XnsZdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KGD2sAYcWkzcC9I8DCb8rE+quWR8zR6e8bvDbeqaz/4ElPCqSQIwZDkEjcBLt2i2x
	 i9kFzfNJ4LzC+VFdgPUMGdZQe+wuQwfyUxD1o6ahorG4R0Lqven37JEF2FwFMF5ylD
	 PaKgYIT2a0pAtDKOkuofJh+WlYlxkTJ77vG5BuVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388413AbeLQRin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:38:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52304 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbeLQRim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:38:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so72492wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 09:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QI32N1/Ik+sjU8OtrfnB3GuwjuycitfojzmO7vI7aNM=;
        b=kn2DzdN7pSpkz4+jklu1degMcB4hKAFRNLliBXxvTV71qtxwyXC21CfnRvbdL2Io7q
         EVLRTFn8Si1b9Di/p7sXHHtZJx7Da+7T6jo8RUh3ak1D/YxeBVuceZE0wzXgRTDeHLQQ
         iRdIroxJhhELrV6CXTPICqPvgDghmeG6RXaJWc4JX82rnSMDmNWOuO0eT524ZNvTta6Q
         iiH1MmNvsrYbUXQ43vHuCGURPRJeyuPUfbA8HE197k6Ra1Ybe/QKPceBQ7zdhhFxr5h0
         4hLONUqR5i+Vt0W+Acj8+yeSLy7xsU50pG1yDFRt78S+e+AIVC2AtPShiGlAZFRs4hRg
         Pbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QI32N1/Ik+sjU8OtrfnB3GuwjuycitfojzmO7vI7aNM=;
        b=M/diD8j1ly/1iyYHI+3F16SFvA6GFZ9dtciaox4XZSofladNLKTI9YwjgnCSlZWQtT
         UQPajqB+xKuxqN45sxAX+qAMnNmPe7395RmBLxyaoxSONbre+nUTjOFW9UfYodaTwzdQ
         fM+kQe3D1WEtkN/hsgrzn0zH5AH01KLsWIjloM+S/eOcK4w//GQOW92OmQxGVqvqiUwj
         YvrGqVL/8Rk68+rMeiiePeTivevFbu24DkycsekAJHcjtkudlWZzw1NqhXTDgzMONHSg
         KufKxwUmF/G04uXKtkGJT7ZKiU/OG7gJM0blOdadJk3vfdibRXVPCV5APyzPYtni6OPJ
         ulmg==
X-Gm-Message-State: AA+aEWbjtixIlyrcM2n7nl+cItYI2Mv7ekrypylC7lvEBPjnrLMsTXRl
        dFfcClalaVX3O/G9TxhU34o=
X-Google-Smtp-Source: AFSGD/Vw2Jp44szAO6I5exHGC96CIFy0ejbxKjoLJU33oHK9e2XFMTbsPl3Ms74shO5rlfYeaJimng==
X-Received: by 2002:a1c:a895:: with SMTP id r143mr30527wme.95.1545068320379;
        Mon, 17 Dec 2018 09:38:40 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id n5sm969654wrr.94.2018.12.17.09.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 09:38:39 -0800 (PST)
Date:   Mon, 17 Dec 2018 18:38:37 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v14 3/5] x86/boot: Introduce bios_get_rsdp_addr() to
 search RSDP in memory
Message-ID: <20181217173837.GC90818@gmail.com>
References: <20181214093013.13370-1-fanc.fnst@cn.fujitsu.com>
 <20181214093013.13370-4-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214093013.13370-4-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:

> +		/* Check the standard checksum */
> +		if (compute_checksum((u8 *) rsdp, ACPI_RSDP_CHECKSUM_LENGTH))
> +			continue;

Could you please run your patches through checkpatch, does it not 
complain about this line?

> +/* Search RSDP address, based on acpi_find_root_pointer(). */
> +static acpi_physical_address bios_get_rsdp_addr(void)
> +{
> +	u8 *table_ptr;
> +	u32 address;
> +	u8 *rsdp;
> +
> +	/* Get the location of the Extended BIOS Data Area (EBDA) */
> +	table_ptr = (u8 *)ACPI_EBDA_PTR_LOCATION;
> +	*(u32 *)(void *)&address = *(u16 *)(void *)table_ptr;

what? So you take the address of 'u32 address', which turns it into an 
u32 * - then you cast it to void *, then back to u32 * and then deference 
it???

Thanks,

	Ingo
