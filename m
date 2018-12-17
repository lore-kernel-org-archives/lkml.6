Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CE7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23FB20675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545068171;
	bh=NGvI7tNLBjuUlChROmwpBCU5IZXleZIY2RF6gtWILGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DiokUjJVPWKkrSqq5QeZKrHm8Bl3+SGr+/to5yQKs/pO/CMDN+2fEkT1m7oep7glI
	 J+Wt3Qnq/A6fxk1aHUFLc87a9btL4STv1uz9wIBmr9pFt6foEr10OtG8qecRzlwws8
	 MPTUq7jKrMOjJ77Cp0CXtej+ouEFTXua7ZdaQ5AU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388409AbeLQRgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:36:10 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38759 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbeLQRgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:36:10 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so60571wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 09:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XemRO3a6bdBl0gYVNNipKjil6OjlrYARZnxI9mdnIeY=;
        b=mKH+AvF52PYdErEaAjZJq1IyIEXyKIQxLwnX61kJPi52Y6g885EO3m/4zxpfZMPf4K
         DS4DAzLIMxXto2j1NWKKgLoaVy6CHeH/OT63KLLITwdxlooJTpY7vxX5nO817wGW3Qon
         +VDpdON+HqTyzMbRQAx4nagCywTqA18TjIcu6cAR1c/r6MSO8CemPflHZW620D6hLhB/
         fji9uh0fKW+uK9g0B81BZMVujyDxNPyjupp1RaWAU27ikGNsclcr4UkG7GaSkj8/QLxN
         aN1mchSQPL8Abtc6M1cpjz7PI4FT98Aa4e1I5uKYn1vOlrOhYz2I2+FZSqpyi/7wV/mY
         eb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XemRO3a6bdBl0gYVNNipKjil6OjlrYARZnxI9mdnIeY=;
        b=g33tcQijoAMGE7znWj5rOzEsc+pjZznKUfC7kghdGE0zpq7HCITgsWEm1X3S7S2my8
         zhPAhJ/cCjhHIDvA15A53Yjzhyg2xD3G0A0ptvpyHLIr7Jx+sdqUirLHQM0wVEh/mEDJ
         z3SvVhLMolcN/Olhkod6CAYfI8Q9lUxkdGQ3X/jysDKdHxhnkcqGm66HGmju2JFGE6wL
         /XKLdBnwarjAt2xKCwjBHAYT2AknmQBlPAc8iLPMOH5Wnv950LPpBV7rHnUDfqT5vxLj
         RUEEhyUdANqeaOjoB0JHCISpkovYzyTTIja1jq4yL1DqkmzF8AGhlUn4qt/cpHIrgf81
         URLA==
X-Gm-Message-State: AA+aEWaGf+QJsgwQ6OWOmDB/PkjoDHsa7Tc+qCeBALA3yYfZApG1qhpS
        hsVwtW34hS8oGeY1v5jHjCs=
X-Google-Smtp-Source: AFSGD/UQVCUcNK0yXvVJYqqHCTsPsMfUNhGx9+oRlPOoWxPdNDC6UEdAsP2oBBETeDwsTJZ2JMnatg==
X-Received: by 2002:a1c:7d54:: with SMTP id y81mr56858wmc.106.1545068168691;
        Mon, 17 Dec 2018 09:36:08 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x81sm15031525wmg.17.2018.12.17.09.36.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 09:36:08 -0800 (PST)
Date:   Mon, 17 Dec 2018 18:36:05 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v14 2/5] x86/boot: Introduce efi_get_rsdp_addr() to find
 RSDP from EFI table
Message-ID: <20181217173605.GA14613@gmail.com>
References: <20181214093013.13370-1-fanc.fnst@cn.fujitsu.com>
 <20181214093013.13370-3-fanc.fnst@cn.fujitsu.com>
 <20181217173032.GB90818@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217173032.GB90818@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> > +		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
> > +			rsdp_addr = (acpi_physical_address)table;
> > +		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
> > +			return (acpi_physical_address)table;
> 
> 'return' is not a function.

Disregard this - I got confused by the type cast.

The type cast is ugly nevertheless. 'table' is an 'unsigned long'.

So 'acpi_physical_address' is basically an u64/u32, depending on 
ACPI_MACHINE_WIDTH, right?

Since this is x86, can ACPI_MACHINE_WIDTH ever get out of sync with the 
native 'unsigned long' size?

If not then why not make the return type 'unsigned long', instead of 
'acpi_physical_address' that you have to wade through a couple of headers 
to figure out its true size. Does that cause complications elsewhere?

I.e. the excessive type casts are ugly and make the code somewhat 
fragile.

Thanks,

	Ingo
