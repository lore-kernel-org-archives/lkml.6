Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97204C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301F320854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2MS9KyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 301F320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeIKM54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:57:56 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38120 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbeIKM54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:57:56 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so317961wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 00:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hzDMpX9TKVM2IaIssiLXo1iQdMhmfk7pHedfjBNqboQ=;
        b=l2MS9KyANvxEWqU0hOB+hRzTKbFybGXOvIg+3y0QpAVf9DlhEx8RfCY7WHSA1qsqyM
         XJgSyOjwjvP9xQVZeQGfKWWRCzHSRLoicWJ/UlSp+QXbHG4m4re79BjTfClUZGX2+PCT
         rK0WyReeH/9XGTumDq3XrfwCGs1C7cupkIF5/xul3coLa/RNsi6WWcaKOdN4QW2j9TNn
         0Ll1P6cmmbvd7uR6v/7X9N2Pt4wrlarmawLFeBLb3lbDIbxDVJZrenLPdnZUpK4SJ4Ww
         M23889udYhCyFrrEXZyOBiGaKFI4mJut4h0JmPNsd+sEd7Eb9wISPZMr5p+Lf/u50oQ9
         +06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hzDMpX9TKVM2IaIssiLXo1iQdMhmfk7pHedfjBNqboQ=;
        b=Dt1UmnWbIuL6yMlLF/iTjd/C6OhiCULRWLuuGiqDHmQEspiyC4sG5TGt/zpNgPq5xo
         2uSq0ZsQ4k1n+CW0/hwWRX39dPMY6Fx1/oCcprofPI0S2oQ+stlfOtQF533JOTyUtGv1
         aLwXc38EVV98A47XzxgchQeZqS1CRCHT9+36u9quOMy1DNoRaM1IcHTajz2bEcrHX0zw
         6YHY5QAi4lnbyZ13jWAMZpkzzi3ZAOVca3YIS18W7cWS5BouxJelObP9N6741w9vYA0X
         RCSmixHMJhf5SojxWG+RuFKL5YliuXRJ/s+clrJ9Xo1IxtWQYrm+1HY3o6snm821Pz6l
         R9jg==
X-Gm-Message-State: APzg51CGzcf1cjCIooZIwo4pvE3XL5TfWLSnmDELXjst3dEJwpNFyVTF
        CDT9hdZa0bsBwAHSSD6L4co=
X-Google-Smtp-Source: ANB0VdY1wvXZYRY3IpgXd3ux+BZkXrjaU0uI0yA+ugl9fMq6ep7B5U7FZHM5LIFg7Z/MLgL6AehtLw==
X-Received: by 2002:a1c:85cb:: with SMTP id h194-v6mr449492wmd.54.1536652788913;
        Tue, 11 Sep 2018 00:59:48 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g7-v6sm15511397wrw.30.2018.09.11.00.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 00:59:48 -0700 (PDT)
Date:   Tue, 11 Sep 2018 09:59:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     tglx@linutronix.de, hpa@zytor.com, thgarnie@google.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 2/3] x86/mm/KASLR: Calculate the actual size of
 vmemmap region
Message-ID: <20180911075946.GA97454@gmail.com>
References: <20180909124946.17988-1-bhe@redhat.com>
 <20180909124946.17988-2-bhe@redhat.com>
 <20180910061151.GA85199@gmail.com>
 <20180911073057.GW1740@192.168.1.3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911073057.GW1740@192.168.1.3>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Baoquan He <bhe@redhat.com> wrote:

>  /*
> + * Memory regions randomized by KASLR (except modules that use a separate
> + * logic earlier during boot). Currently they are the physical memory
> + * mapping, vmalloc and vmemmap regions, are ordered based on virtual
> + * addresses. The order is kept after randomization.
> + *
> + * @base: points to various global variables used by the MM to get the
> + * virtual base address of the above regions, which base addresses can
> + * thus be modified by the very early KASLR code to dynamically shape
> + * the virtual memory layout of these kernel memory regions on a per
> + * bootup basis.
> + *
> + * @size_tb: size in TB of each memory region. Thereinto, the size of
> + * the physical memory mapping region is variable, calculated according
> + * to the actual size of system RAM in order to save more space for
> + * randomization. The rest are fixed values related to paging mode.
>   */
>  static __initdata struct kaslr_memory_region {
>  	unsigned long *base;

LGTM mostly, except the @size_tb field, see my comments further below.

Here's an edited version:

/*
 * 'struct kasl_memory_region' entries represent continuous chunks of
 * kernel virtual memory regions, to be randomized by KASLR.
 *
 * ( The exception is the module space virtual memory window which
 *   uses separate logic earlier during bootup. )
 *
 * Currently there are three such regions: the physical memory mapping,
 * vmalloc and vmemmap regions.
 *
 * The array below has the entries ordered based on virtual addresses.
 * The order is kept after randomization, i.e. the randomized
 * virtual addresses of these regions are still ascending.
 *
 * Here are the fields:
 *
 * @base: points to a global variable used by the MM to get the
 * virtual base address of any of the above regions. This allows the
 * early KASLR code to modify these base addresses early during bootup,
 * on a per bootup basis, without the MM code even being aware of whether
 * it got changed and to what value.
 *
 * When KASLR is active then the MM code makes sure that for each region
 * there's such a single, dynamic, global base address 'unsigned long'
 * variable available for the KASLR code to point to and modify directly:
 *
 *       { &page_offset_base, 0 },
 *       { &vmalloc_base,     0 },
 *       { &vmemmap_base,     1 },
 *
 * @size_tb: size in TB of each memory region. Thereinto, the size of
 * the physical memory mapping region is variable, calculated according
 * to the actual size of system RAM in order to save more space for
 * randomization. The rest are fixed values related to paging mode.
 */

The role of @size_tb is still murky to me. What is it telling us?
Maximum virtual memory range to randomize into? Why does this depend
on system RAM at all - aren't these all virtual addresses in a 64-bit
(well, 48-bit or 56-bit) address ranges?

I could read the code to figure this out, but the comment should already
explain this and it doesn't.

Thanks,

	Ingo
