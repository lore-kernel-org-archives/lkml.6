Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBFBC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 952C92087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhGXXuTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbfAHGat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 01:30:49 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40858 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfAHGat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 01:30:49 -0500
Received: by mail-it1-f194.google.com with SMTP id h193so4604020ita.5;
        Mon, 07 Jan 2019 22:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=no9yURgFGOF+JNGr7I2e/L7w/SeBvbNlziuubDWSiV8=;
        b=KhGXXuTzN4cUh/Im9i1NUz9KyDgAnmWpDsYHKR4PG+mNqawlaEg4FP/POcSfPJmClB
         D16HuPdTnUeYyE+WvOGzYVwKVFaEQplAavah+vMrPZlQD1wbtA+iTeSHl1lfcetPfScg
         WI8Hj71Wj0YE8Je6F/v//oqpL8PfzSNisUdRV0T3PvVQick/tV/ovOhpwz8nwm7CiZng
         CFVdWQmqwl+EtBLgYmTdBPJvc402BOwRVg8+vCk9Ea6qD4czuoxH8fWb36W8zQvDfYM6
         P3BT3ehQ2d+wEZ7ApZbeV5II0mBNa8I8QcOzCKNtycdTNYb9AVgjFo74zaKf9HursW+B
         22QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=no9yURgFGOF+JNGr7I2e/L7w/SeBvbNlziuubDWSiV8=;
        b=gd6nZJQjL/uRr/LSwtsJfMjjc2xQ0DOgVnWehB7uW9/jwclUAO4uarnwKnxARAVOal
         As8ctMPcdKckTCqGAc1io0+DnHR06hI+G9U5f0ORQ1YEFra1bwElmXP0KPMJw7jE4qLN
         UeLnvmyhDGF6GipJo0SKBxcOY6h9hPlKQFcjo9WuIC3l6CjQ3sAZk7JphAl1JuhorWNS
         Isbw7Ez/sKuQKCoSwnWyP4v8h3a/sco4DzUFSkVNPKBHrvahaHTLU0ZbAxwNxK8EkSHV
         jUI6iOLz9ncg/C8XFQpVex9P6txP26vH2qd/UisoJAsza4Docw7tHZqKXLprklckeE/m
         1qug==
X-Gm-Message-State: AJcUukd96lHDOlSYp9wdM9PBiZvUbTD1ed/kmm89l9qtT+UezSRWmBZR
        KaFu/shAZ3LB0CL1rwlNPq4Dn0cYZXONr1Je1g==
X-Google-Smtp-Source: ALg8bN4+M5BHEYAZUi3StTjsKYb2Y8E06ntomTv8n0p28G396Jet+eaoaFZUNC1wcf63udPI2XZ9/wYZS0ueL8I8miY=
X-Received: by 2002:a24:7a94:: with SMTP id a142mr423624itc.88.1546929047867;
 Mon, 07 Jan 2019 22:30:47 -0800 (PST)
MIME-Version: 1.0
References: <1546849485-27933-1-git-send-email-kernelfans@gmail.com>
 <1546849485-27933-3-git-send-email-kernelfans@gmail.com> <fe24007c-c726-720e-f018-6a08d1a6b66a@intel.com>
In-Reply-To: <fe24007c-c726-720e-f018-6a08d1a6b66a@intel.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 8 Jan 2019 14:30:36 +0800
Message-ID: <CAFgQCTs=xSdawO5G0-mEg=JN9TuchY4Me=Yc8kK-7wFgS3NR-A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] x86/setup: parse acpi to get hotplug info before init_mem_mapping()
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     x86@kernel.org, linux-acpi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 1:11 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
>
> On 1/7/19 12:24 AM, Pingfan Liu wrote:
> > At present, memblock bottom-up allocation can help us against stamping over
> > movable node in very high probability.
>
> Is this what you are fixing?  Making a "high probability", a certainty?
>  Is this the problem?
>

Yes, as my reply on another mail in detail.
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index acbcd62..df4132c 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -805,6 +805,20 @@ dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
> >       return 0;
> >  }
> >
> > +/* only need the effect of acpi_numa_memory_affinity_init()
> > + * ->memblock_mark_hotplug()
> > + */
>
> CodingStyle, please.
>

Will fix.
> > +static int early_detect_acpi_memhotplug(void)
> > +{
> > +#ifdef CONFIG_ACPI_NUMA
> > +     acpi_table_upgrade(__va(get_ramdisk_image()), get_ramdisk_size());
>
> This adds a new, early, call to acpi_table_upgrade(), and presumably all
> the following functions.  However, it does not remove any of the later
> calls.  How do they interact with each other now that they are
> presumably called twice?
>

ACPI is a big subsystem, I have a hurry through these functions. This
group seems not to allocate extra memory, and using static data. So if
called twice, just overwriting the effect of previous one. The only
issue is printk some info twice. I will pay more time on this for the
next version.
> > +     acpi_table_init();
> > +     acpi_numa_init();
> > +     acpi_tb_terminate();
> > +#endif
> > +     return 0;
> > +}
>
> Why does this return an 'int' that is unconsumed by its lone caller?
>

No special purpose about the return. Just a habit.
> There seems to be a lack of comments on this newly-added code.
>
> >  /*
> >   * Determine if we were loaded by an EFI loader.  If so, then we have also been
> >   * passed the efi memmap, systab, etc., so we should use these data structures
> > @@ -1131,6 +1145,7 @@ void __init setup_arch(char **cmdline_p)
> >       trim_platform_memory_ranges();
> >       trim_low_memory_range();
> >
> > +     early_detect_acpi_memhotplug();
>
> Comments, please.  Why is this call here, specifically?  What is it doing?
>
It parses the acpi srat to extract memory hotmovable info, and feed
those info to memory allocator. The exactly effect is:
acpi_numa_memory_affinity_init() ->memblock_mark_hotplug(). So later
when memblock allocator allocates range, in __next_mem_range(), there
is cond check to skip movable node:  if (movable_node_is_enabled() &&
memblock_is_hotpluggable(m)) continue;

Thanks,
Pingfan
