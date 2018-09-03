Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB60EC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E2E20652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E2E20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbeICTIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:08:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36211 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeICTIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:08:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id f4-v6so988643edq.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 07:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vI+efUYFl0M3X0GnW2E9xtkZwKm5/VQNepy1Z3Ki1o0=;
        b=B8uCJaXjzUGEZtflZNPc+FD/n8az+S/h4ops1EX656PthwAkHO4Ri+aFdLZRpS0icY
         sn2MZMzeN0i8R2pm48bHprxFuhJeOERdAYIDw6CzeRX3sEf3JlnPnNh9zstBsCsm9B9N
         Q3XnQH+/dboEt+QrkLtY3fmlMCsjV+fo16zeUSqMZ850siilS+vXtqUxV5YKE/EGnrth
         SI8kX1TMhIDAv+Gn52olecZLIbX0ybRKmKAerMbfL9mlQyjTiy05zrH4SqEIFJPh7VQ7
         LTDZzzSkTEvBeosP/28d7LJp6EQD/Nxpe/nYE363eIc7jiOs3qFkAJ+osl94UDnHDsan
         aEgA==
X-Gm-Message-State: APzg51A8TzbRCf7AgNEpZJUHVoT1KBj4L0Jqdw/y1lchER5ktQkwnRAu
        qpIA+a3ZOMFTcOu7Hdv1vrp3GA==
X-Google-Smtp-Source: ANB0Vda7lZznjOtCl9S5gkco0j1F5u62qzmMycri449ngULPVSpg+JmA/fhP9Fj+7YHJVlh7Zlsitw==
X-Received: by 2002:a50:908d:: with SMTP id c13-v6mr33242787eda.179.1535986079712;
        Mon, 03 Sep 2018 07:47:59 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id x32-v6sm10810855eda.81.2018.09.03.07.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 07:47:58 -0700 (PDT)
Subject: Re: [REGRESSION] boot-screen override by "34db50e55656 efifb: Copy
 the ACPI BGRT"
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Herrmann <dh.herrmann@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fbdev@vger.kernel.org, linux-efi@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <CGME20180903132353epcas4p373e876f1b52dbed6df7bd3acc73fcdf4@epcas4p3.samsung.com>
 <CANq1E4QwNg0VuAZZtatOTXspv7Y-z_HSa-9CHzK2Y28CGK8W4Q@mail.gmail.com>
 <1982440.Fn0LzJ7a3l@amdc3058>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <dc7f08d7-77fc-92ca-b6ec-f9d5a8f24cf3@redhat.com>
Date:   Mon, 3 Sep 2018 16:47:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1982440.Fn0LzJ7a3l@amdc3058>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03-09-18 16:16, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Monday, September 03, 2018 03:23:38 PM David Herrmann wrote:
>> Hey
>>
>> Since this commit:
>>
>>      34db50e55656 efifb: Copy the ACPI BGRT
>>
>> the kernel will override boot-splashs unasked. This breaks the
>> graphical boot-process on our setups. In particular, we have a setup
>> where an efi-boot-entry draws the early boot-splash on-screen, then
>> hands-over to the linux-kernel + initrd. The boot-splash daemon in the
>> initrd then takes over control of possible animations.
>>
>> With the mentioned commit compiled in, the kernel will redraw the
>> firmware logo on screen at a random time without any way to intervene.
> 
> You have CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER=y (the deferred
> console takeover support introduced in v4,19-rc1). I assume that this
> is intended?
> 
>> What is the intention of this commit? Why is the kernel re-drawing the
>> firmware logo unasked? If someone during the boot-process draws
>> content on the screen, I would prefer if the kernel does not clear
>> that on driver load.
> 
> +/*
> + * If fbcon deffered console takeover is configured, the intent is for the
> + * framebuffer to show the boot graphics (e.g. vendor logo) until there is some
> + * (error) message to display. But the boot graphics may have been destroyed by
> + * e.g. option ROM output, detect this and restore the boot graphics.
> + */
> +#if defined CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER && \
> +    defined CONFIG_ACPI_BGRT
> ...
> +static void efifb_show_boot_graphics(struct fb_info *info)
> ...
> +#else
> +static inline void efifb_show_boot_graphics(struct fb_info *info) {}
> +#endif
> 
>> Can we either provide an option to disable this feature, or revert the commit?
> 
> Hans?

We use the ACPI bgrt extension to get the logo to draw and then
draw it since some devices rely on the OS to draw it and otherwise we
just end up with a blackscreen when doing silent / flickerfree boot.

Ideally you would be able to get your vendor to put the logo in firmware
in the ACPI bgrt extension, then you also do not need to play any tricks
with an EFI binary drawing your own logo. But I can understand if you don't
have control over this, so you need to do this with the EFI binary trick.

I can also understand that you want to use deferred console takeover
in a setup like yours to avoid fbcon messing up what is on the display
during boot, that is exactly what it is for. So I think a reasonable
approach here is to add a kernel commandline option, say:

video=efifb:nobgrt

David, would that work for you?

Regards,

Hans
