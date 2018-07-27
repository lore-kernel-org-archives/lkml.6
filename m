Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C290C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF08020897
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NMI21SPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF08020897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbeG0Kto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:49:44 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:42907 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeG0Ktn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:49:43 -0400
Received: by mail-io0-f195.google.com with SMTP id g11-v6so3650809ioq.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 02:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dH3xVyi6lW0ha4f8h/1y/kZERBGG0qDesgXSLjnpkyk=;
        b=NMI21SPjQOUJp/UeMVxOEx+hEgOY21e5mHMuTu1WtygHWi1iN9Kuq8J4S1rU5gTXrK
         zO0A6N0K3XK0x8Ics2Q9Ulkwb0xjM8CB6Qj/dK13ygCO4P5Nc7m4FAI9FMW1saS/W4Ai
         Ll80QCgNI9ud0vXyumZGOsuaIYGSpsS4/P5l4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dH3xVyi6lW0ha4f8h/1y/kZERBGG0qDesgXSLjnpkyk=;
        b=Fc+qZs5M/0hYD6K6LO6zkfHbCWVrHqJNHXd0rG9YUQuQW2d/+zlmNtEFCBQkVo/+zm
         osz2CXOTw42kZVB7KrfmOdhWZiUNd1Mp6eW7IZAVtPxAA0Eyqn+Sk14tJ40EHYoe3rio
         uB1JuisLo84uKJqqdd4FB6SgMMItWglM01KMCe7Xr0cI3u4yXC4RVWSTyLfeNO7xDuy4
         4XxLPK241XkIS35k8LN80oAzcQOTTbtmGNDahCjyNB+sqc7sPUxJLT7rbd0U4N9dwbzb
         VqXpAM+O9NhMJd474q1XjX3FuOK/3VLs5REX2HlCkdRZLihy3/MmlaJHbYC/QNWKLFiu
         YWFw==
X-Gm-Message-State: AOUpUlEqF46zjmkDz4ri+cjzXddaQCJSFI+Ztj/KrQpQ70Ug7rej79Jn
        ckt0qVk4ZljBQIx08RYrRdDbEKv1NzZm9OQ+z1CJUQ==
X-Google-Smtp-Source: AAOMgpcRhNIllZ3YzSluACx8Rk0MissRRBWhGvjY25Uk7iwFtN6EMMCrvhLtHcmcJiI3x4Ots5MQV+ij16RE5DWhA4Y=
X-Received: by 2002:a6b:5208:: with SMTP id g8-v6mr4629356iob.60.1532683721779;
 Fri, 27 Jul 2018 02:28:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 02:28:41
 -0700 (PDT)
In-Reply-To: <405b6708-4518-d81e-3938-39032c2b487e@arm.com>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-17-takahiro.akashi@linaro.org> <50b31f17-fc85-aa72-06f5-d3b62060a91f@arm.com>
 <20180727083104.GI11258@linaro.org> <405b6708-4518-d81e-3938-39032c2b487e@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 27 Jul 2018 11:28:41 +0200
Message-ID: <CAKv+Gu9jw9rFx5P3vO8Frq5=LCWugScRiNHfb2ceHkgtS9opLA@mail.gmail.com>
Subject: Re: [PATCH v12 16/16] arm64: kexec_file: add kaslr support
To:     James Morse <james.morse@arm.com>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 July 2018 at 11:22, James Morse <james.morse@arm.com> wrote:
> Hi Akashi,
>
>
> On 07/27/2018 09:31 AM, AKASHI Takahiro wrote:
>
> On Thu, Jul 26, 2018 at 02:40:49PM +0100, James Morse wrote:
>
> On 24/07/18 07:57, AKASHI Takahiro wrote:
>
> Adding "kaslr-seed" to dtb enables triggering kaslr, or kernel virtual
> address randomization, at secondary kernel boot.
>
> Hmm, there are three things that get moved by CONFIG_RANDOMIZE_BASE. The
> kernel
> physical placement when booted via the EFIstub, the kernel-text VAs and t=
he
> location of memory in the linear-map region. Adding the kaslr-seed only d=
oes
> the
> last two.
>
> Yes, but I think that I and Mark has agreed that "kaslr" meant
> "virtual" randomisation, not including "physical" randomisation.
>
> Okay, I'll update my terminology!
>
>
> This means the physical placement of the new kernel is predictable from
> /proc/iomem ... but this also tells you the physical placement of the
> current
> kernel, so I don't think this is a problem.
>
>
> We always do this as it will have no harm on kaslr-incapable kernel.
>
> We don't have any "switch" to turn off this feature directly, but still
> can suppress it by passing "nokaslr" as a kernel boot argument.
>
> diff --git a/arch/arm64/kernel/machine_kexec_file.c
> b/arch/arm64/kernel/machine_kexec_file.c
> index 7356da5a53d5..47a4fbd0dc34 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -158,6 +160,12 @@ static int setup_dtb(struct kimage *image,
>
> Don't you need to reserve some space in the area you vmalloc()d for the D=
T?
>
> No, I don't think so.
> All the data to be loaded are temporarily saved in kexec buffers,
> which will eventually be copied to target locations in machine_kexec
> (arm64_relocate_new_kernel, which, unlike its name, will handle
> not only kernel but also other data as well).
>
>
> I think we're speaking at cross purposes. Don't you need:
>
> | buf_size +=3D fdt_prop_len("kaslr=E2=80=95seed", sizeof(u64));
>
>
> You can't assume the existing DTB had a kaslr-seed property, and the
> difference may take us over a PAGE_SIZE boundary.
>
>
>
>
> + /* add kaslr-seed */
> + get_random_bytes(&value, sizeof(value));
>
> What happens if the crng isn't ready?
>
> It looks like this will print a warning that these random-bytes aren't
> really up
> to standard, but the new kernel doesn't know this happened.
>
> crng_ready() isn't exposed, all we could do now is
> wait_for_random_bytes(), but that may wait forever because we do this
> unconditionally.
>
> I'd prefer to leave this feature until we can check crng_ready(), and ski=
p
> adding a dodgy-seed if its not-ready. This avoids polluting the
> next-kernel's
> entropy pool.
>
> OK. I would try to follow the same way as Bhupesh's userspace patch
> does for kaslr-seed:
> http://lists.infradead.org/pipermail/kexec/2018-April/020564.html
>
>
> (I really don't understand this 'copying code from user-space' that happe=
ns
> with kexec_file_load)
>
>
>   if (not found kaslr-seed in 1st kernel's dtb)
>      don't care; go ahead
>
>
> Don' t bother. As you say in the commit-message its harmless if the new
> kernel doesn't support it.
> Always having this would let you use kexec_file_load as a bootloader that
> can get the crng to
> provide decent entropy even if the platform bootloader can't.
>
>
>   else
>      if (current kaslr-seed !=3D 0)
>         error
>
>
> Don't bother. If this happens its a bug in another part of the kernel tha=
t
> doesn't affect this one. We aren't second-guessing the file-system when w=
e
> read the kernel-fd, lets keep this simple.
>
>      if (crng_ready()) ; FIXME, it's a local macro
>         get_random_bytes(non-blocking)
>         set new kaslr-seed
>      else
>         error
>
> error? Something like pr_warn_once().
>
> I thought the kaslr-seed was added to the entropy pool, but now I look ag=
ain
> I see its a separate EFI table. So the new kernel will add the same entro=
py
> ... that doesn't sound clever. (I can't see where its zero'd or
> re-initialised)
>

We do have a hook for that: grep for update_efi_random_seed()
