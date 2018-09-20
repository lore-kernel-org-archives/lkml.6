Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CABC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8192147D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMnYH6ZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8192147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733291AbeITWKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:10:53 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33445 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeITWKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:10:53 -0400
Received: by mail-qk1-f195.google.com with SMTP id z78-v6so5383156qka.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MhPWFBY78zUpTDmkiFrlIEKWr/KZ4azW1Fn/GPrQpxE=;
        b=QMnYH6ZHGKFRxuVgPkNKRfu73Gttw/Px1jKK4M3owBB15VVkAJZE4dBN3UDliYfwV/
         Bk3AeBZETMiKOnSN4RoGmy0l8a5ftZVGl2/aN1eSbhrHQztvQd/G8AivN+YIyPE50xlt
         4/QbdJHXdBKvV92kUGBtekWdDnbtKwQf9tgTs+G6B1jn6oFAn0CpsZeh3iXjz1yWiooL
         CEhMiuTNSd/Oyk02h8t3A/IxP+l7AZXMLGKWi9S/kBf7XsHxkOF4/1kjh975fckXU5D6
         fT3ya0n8dWXBzw3VL+CvsjALqOrQH8F590GHPwdT0EytisPPlB0mfTWdWtUJjTZ/aWqI
         cBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MhPWFBY78zUpTDmkiFrlIEKWr/KZ4azW1Fn/GPrQpxE=;
        b=dgIRh3EC3V3Wq/Fwoq+MCEELohGyJlWd3Q2800tMa9H+O1gIEesil8IE0C38an7LJl
         WXSZX3AVSLJCpWQFCx8TqR+B9PoWlmmCviGQ1H6B1CjNsboSkcBfhfApWXwsSIcYgEZz
         Y0nTZApaqgMM4f+/SF9LSTyJLHijtEYRjPtBYMC/j/VVbyX5FLMGjZGhfP1ghzeMj19O
         pgRDk0d4jP+8ZqAhAekiEhqqMwxzBoknqliPKBoqUvFVZLDOicb+dPoKeufthYHPVabx
         0+Me4FJhU+Cu8L672hv9MdSP2n7IdNg8RPhHgydQ+vMSDkZKSqK86Z91WVEisUYaJIRT
         Ro7A==
X-Gm-Message-State: APzg51AaxO5rglboT6IR+uxocuDKYj2gURlhl29o6T5CM/ciD+LhCw61
        JNUuxLSNITxBfN27wZUS/w==
X-Google-Smtp-Source: ANB0VdY27T4gzYcB/fEAvakrooI7kdgmS09O2VOSbkA84MnLWTxmdVXL9PO+MRxIYH1+q7S1yKUPNg==
X-Received: by 2002:a37:be06:: with SMTP id o6-v6mr27241155qkf.214.1537460796526;
        Thu, 20 Sep 2018 09:26:36 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id p57-v6sm19343713qtj.42.2018.09.20.09.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 09:26:35 -0700 (PDT)
Date:   Thu, 20 Sep 2018 12:26:29 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     "Travis, Mike" <mike.travis@hpe.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>, Baoquan He <bhe@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>
Subject: Re: [PATCH v3 1/2] x86/mm: Add an option to change the padding used
 for the physical memory mapping
Message-ID: <20180920162628.dv6dsckfzwhcx4gk@gabell>
References: <20180904151141.20264-1-msys.mizuma@gmail.com>
 <20180918133026.gzyix3oyrfcsrdcx@gabell>
 <20180919121720.GA47424@gmail.com>
 <alpine.DEB.2.21.1809191421500.18945@nanos.tec.linutronix.de>
 <20180919124806.GA48413@gmail.com>
 <20180919141058.krruhvsjkm6hqgmf@gabell>
 <474aaa27-c463-4ba7-8284-ee54d7c33ae5@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <474aaa27-c463-4ba7-8284-ee54d7c33ae5@hpe.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 11:05:32PM +0000, Travis, Mike wrote:
> 
> 
> On 9/19/2018 7:10 AM, Masayoshi Mizuma wrote:
> > On Wed, Sep 19, 2018 at 02:48:06PM +0200, Ingo Molnar wrote:
> >>
> >> * Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >>> On Wed, 19 Sep 2018, Ingo Molnar wrote:
> >>>> * Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
> >>>>
> >>>>> Ping...
> >>>>> I would appreciate if someone could review it because this patch
> >>>>> fixes the real memory hotplug issue...
> >>>>
> >>>> Yeah, so I generally try to resist random new boot options that
> >>>> work around real bugs, so please convince me that this patch
> >>>> is the best option:
> 
> I whole hardily concur, that having boot options which are not easily 
> understood should be avoided.  The very best is the system should just 
> work.  But on very large systems, these boot options are typically 
> determined by either automated scripts, or careful instructions to the 
> trained onsite customer engineers, who are required to "get it right".
> 
> >>>>
> >>>>>
> >>>>> On Tue, Sep 04, 2018 at 11:11:40AM -0400, Masayoshi Mizuma wrote:
> >>>>>> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> >>>>>>
> >>>>>> If each node of physical memory layout has huge space for hotplug,
> >>>>>> the padding used for the physical memory mapping section is not enough.
> >>>>>> For exapmle of the layout:
> >>>>>>    SRAT: Node 6 PXM 4 [mem 0x100000000000-0x13ffffffffff] hotplug
> >>>>>>    SRAT: Node 7 PXM 5 [mem 0x140000000000-0x17ffffffffff] hotplug
> >>>>>>    SRAT: Node 2 PXM 6 [mem 0x180000000000-0x1bffffffffff] hotplug
> >>>>>>    SRAT: Node 3 PXM 7 [mem 0x1c0000000000-0x1fffffffffff] hotplug
> >>>>>>
> >>>>>> We can increase the padding by CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING,
> >>>>>> however, the needed padding size depends on the system environment.
> >>>>>> The kernel option is better than changing the config.
> >>>>>>
> >>>>>> Change log from v2:
> >>>>>>   - Simplify the description. As Baoquan said, this is simillar SGI UV issue,
> >>>>>>     but a little different. Remove SGI UV description.
> >>>>
> >>>> Could you please explain it a bit better where the higher padding requirement comes from?
> >>>>
> >>>> 'system environment' is very opaque.
> >>>
> >>> As I understand it, it's depending on the actual physical characteristics
> >>> of the machine. So setting a fixed value in Kconfig might work for one, but
> >>> not for others and having a command line option allows to tweak that at
> >>> boot time and having a common kernel image.
> >>>
> >>> Ideally we would calculate that from SRAT, but AFAICT SRAT is not available
> >>> at the point where this needs to be done.
> > 
> > Yes, that's right. The KASLR initialization is early boot sequence,
> > so SRAT is not available at that time.
> 
> Some facts are available via the x86 boot options structure passed from 
> BIOS.  Is there enough info in there to help determine what the optimal 
> value of this parameter should be?  Even a safe guess gets the system 
> booted and can then be refined for the next reboot.

Unfortunately, the bios information doesn't useful for the padding
size for memory hotplug. ACPI SRAT is needed, but it is not available
at the KASLR initialization time...

> 
> >>
> >> Yeah, so could we at least do something like this:
> >>
> >>   - See whether using the maximum padding as the new default padding would work for everyone?
> >>     A bit more virtual memory used, or are there other costs as well?
> > 
> > The current default padding size if CONFIG_MEMORY_HOTPLUG set is 10TB.
> > IMO, it should not be increased because it gets the available entropy
> > decreased...
> > 
> >>   - Add checking code to the later SRAT case to at least _detect_ bad padding after the fact.
> >>     We don't utilize RAM with bad padding until that, right?
> > 
> > I have an idea as following. Does that make sense?
> > 
> > Add a warning message which shows the padding size is not enough
> > for the physical memory mapping and tell to the user about
> > recommended padding size. User can change the padding size in next
> > reboot to add the boot parameter.
> 
> Again, leaving it solely up to the user is probably not the best 
> approach, either for single workstation users who may not understand 
> what's up, or large system users which will just generate a customer 
> service call, because something went wrong and they can't boot.  Or 
> their performance went down the drain.  [Normally upgrades that change 
> the system config use an onsite CE, but that's not strictly required.]
> 
> So basically a deterministic method of calculating what this padding 
> should be works best from a customer support angle.  For an individual 
> workstation user, having the kernel determine what's correct for proper 
> operation is the best.

I agree it is better to set the padding size automatically for users,
however, we cannot do so at the KASLR initialization timing because
of the above reason.
So, I will try to add warning message to show the recommended padding
size for the memory hotplug.

Thanks,
Masa
