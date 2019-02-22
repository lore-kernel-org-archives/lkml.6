Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DB0C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2302320700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 16:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="We65ejXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfBVQuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 11:50:50 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:37197 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfBVQus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 11:50:48 -0500
Received: by mail-vk1-f196.google.com with SMTP id 17so641172vkf.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 08:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r+ptFvJ18N0UnrAzJS/StVWMlNtZYWTc8hvWf6ejkBs=;
        b=We65ejXbgJU3m0qEqWdZ5pkgpwzViF7OafNrhV1Fu+TJ6nid9Fq/eOuhV1Myp65GvN
         9halQAbpVVdhVo4Lqnc7zataJNvTlR/h15ECHkgErA/AOLXa8gEQyxyu8XdP+T4zAMos
         RiyA9iEL3xBQNHbxaNElyxPKYjq+K/pPTpfWUcgEECihXGU9DNN3tYV+mj5OgH2NC++2
         to8ReVSG3DJsozn7TzPJ/jQ1I6G2ZnNKRVGKBMAuGi+Fs0daqOBKXvWfUnBjqDHMk0bF
         z+f3lkKHnGgiVt/hesbj1ez1OoBegWQuKJmoTVGtIuex382aUQGKzLXW7UYyaxYL2bNT
         uaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r+ptFvJ18N0UnrAzJS/StVWMlNtZYWTc8hvWf6ejkBs=;
        b=Ou/2uEDuDJtJaLKx5jWgu4OYiBvbR1dpF3OQIzCeEkIP6kVoCnkZAJ+TMW3J2IZ2/g
         UxsabNihz4msJxO290O2cAL4gbuqCAdMXNMv1Y0Tkr3Xf7iYOjAZ/KMbu6Vw1+UVbjox
         XIf03BprIaw3drrBkwQZr/gJg3/YS/wNkN7nnutxRVradkBaXghT/1HL9VB3aCfcA8ie
         i8h1z3Ia4OCD+LwEQCDhozQISWPoZoYKcLPHfqCIa9VuOiqNPULMryWteRTBctjGhaXl
         FUmU5CDI7AFhJu8N1WxdHNaL4+tp9CbSkU9pBjQQpJFCwP1AkhzUmsABFDA3CHhVv3Ui
         ce4g==
X-Gm-Message-State: AHQUAuZc9rJmoN2AAFycSqcvsJCsh+YzFW/TAW9nGWmGgHT3IT6cNcyU
        BzgvoLCXaAWSAyuTsrtQ8IhcKGoOUCz2JPi5pRA=
X-Google-Smtp-Source: AHgI3IYIqZ4L0j4TdzyxEehdq3XbpGtscHTZl6FHyUapP+jJ8S76S2SeCLhQ2/SNvNgZJbCpqeywfit6lXKg7gOlR6U=
X-Received: by 2002:a1f:a986:: with SMTP id s128mr2668480vke.53.1550854246377;
 Fri, 22 Feb 2019 08:50:46 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLhDtRJDBnwuV1kQ47Zd9B00qh2bXDNQvh9tXfTyYqAWDQ@mail.gmail.com>
 <20190222141059.GJ42419@lakrids.cambridge.arm.com>
In-Reply-To: <20190222141059.GJ42419@lakrids.cambridge.arm.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 22 Feb 2019 22:20:35 +0530
Message-ID: <CAOuPNLixfZUzVyv4uHzwWPXWQmCYwNUtTOtNXFwOg8aPZda3aw@mail.gmail.com>
Subject: Re: arm64 Kernel build for qemu-system-aarch64 ?
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernelnewbies@kernelnewbies.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 7:41 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Feb 22, 2019 at 07:17:00PM +0530, Pintu Agarwal wrote:
> > Hi All,
>
> Hi,
>
> > I want to build Linux Kernel 4.20 for arm64 and use it on qemu-arm64.
> > I see that there is a defconfig available in arch/arm64/configs/defconfig
> > But I am not sure whether it will work for qemu-arm64, and by default
> > which machine type is supported.
> >
> > I already have working setup for qemu-arm for both versatile and
> > vexpress machine. There is already a defconfig available for these
> > under arch/arm.
> > So I can build the kernel for it.
> >
> > But, whether these defconfig are supported for arm64 ?
> > If anybody have setup for qemu-arm64 kernel, please share the steps.
> > About rootfs, I am planning to use the arm32 version of busybox itself.
>
> The arm64 defconfig is intended to work for all platforms.
>
> I use that with qemu's '-machine virt'. Assuming you use virtio-net and
> virtio-block, no additional drivers are required.
>
> For example, I can boot a defconfig kernel using the followign QEMU options:
>
> qemu-system-aarch64 \
>         -m 2048 -smp 4 \
>         -net nic \
>         -net user,host=10.0.2.10,hostfwd=tcp::65022-:22 \
>         -nographic \
>         -no-reboot \
>         -machine virt,accel=kvm,gic_version=host \
>         -cpu host \
>         -hda ${FILESYSTEM} \
>         -snapshot \
>         -kernel ${KERNEL} \
>         -append "earlycon root=/dev/vda panic_on_warn"
>
> Thanks,
> Mark.

oh thank you so much for your information.
I was exactly looking for this option.
Let me try it on Monday.


Thanks
