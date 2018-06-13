Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3DBEEC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEA5208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bVNLu6OX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEEA5208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935871AbeFMPGM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:06:12 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:44925 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935662AbeFMPGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:06:09 -0400
Received: by mail-io0-f196.google.com with SMTP id g7-v6so3762730ioh.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tAH4nBuyOy+ok4Ji2N7q3zZe8kpF3Ed5BYpwYW8cQfs=;
        b=bVNLu6OXtQ+2k4pxlORFwozijimHcuBH+v1MDVgVzkLdyZVD6gWaKn1/1L8QJLHial
         cFc5JD3wCwTbbmKWBjpL09U5rFGtAx8mI/3s38LSirm9+fdPyephEtRjKON3RUwdkRHo
         NGbXlodPFyZJGdgy7W0x9c3+Vb3aBAKPKuqXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tAH4nBuyOy+ok4Ji2N7q3zZe8kpF3Ed5BYpwYW8cQfs=;
        b=P48+McNLX5qk1Nc0Ov/2UOjGjjmFcX1p+57byOWHxBbYrjK9Hjdz7E3H3VHoDodkPS
         XIQ4EBamCIj6GZjfO9KCa8+1muD5WXfNsymSzYkjzNvwGAewLv/6DHsmSvtERnZRpUJo
         E7NWmKKWqIfdTJEGZdjI99wGKENOpSGemRLN8UFXyUDsB5HHwj9XNKcn+oONG2NeKf8/
         k7Kfc6qntlg6D4c9M/j1QvP2H/awkzFZ1xS2MxIn2rha/jXxBSzy29VbYDn6/cyVzjh+
         Bl9pXD233wx5mWDeo/SJ165STaDuOqDVs4Kuea7Id6NQIbXudyr0j9r8vvYasvvjBx8n
         l9/w==
X-Gm-Message-State: APt69E14eEFAT25RZ4J/d71SkAp1uFWZBWFqGkK+7/sC4wqFDMlL+Mhf
        GkepC8b2RSuvqktVuD1TZ9EFx95MSludOXIlI34F3Q==
X-Google-Smtp-Source: ADUXVKKVx7LlvE99ewqkKSQxzdlzHfJvQw0CHF6ZWYD4zL+6+FbKH1ZTmGQsQdr2MhTQHQgGNyk9cGkvklfQOK1hQMo=
X-Received: by 2002:a6b:6709:: with SMTP id b9-v6mr4911838ioc.170.1528902369342;
 Wed, 13 Jun 2018 08:06:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 08:06:08
 -0700 (PDT)
In-Reply-To: <26470c5c-55db-9dff-3794-4e4a96c8bcb6@codeaurora.org>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <1526653072-7153-2-git-send-email-okaya@codeaurora.org> <26470c5c-55db-9dff-3794-4e4a96c8bcb6@codeaurora.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 13 Jun 2018 17:06:08 +0200
Message-ID: <CAKv+Gu8UG_D0AAR8Usdi7DrucqaEs+f-JTU1voR-CcrtNY2ZEQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
To:     Sinan Kaya <okaya@codeaurora.org>
Cc:     "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        Timur Tabi <timur@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Peter Jones <pjones@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 June 2018 at 16:22, Sinan Kaya <okaya@codeaurora.org> wrote:
> Hi Ard,
>
> On 5/18/2018 10:17 AM, Sinan Kaya wrote:
>> A host bridge is allowed to remap BAR addresses using _TRA attribute in
>> _CRS windows.
>>
>> pci_bus 0000:00: root bus resource [mem 0x80100100000-0x8011fffffff window] (bus address [0x00100000-0x1fffffff])
>> pci 0000:02:00.0: reg 0x10: [mem 0x8011e000000-0x8011effffff]
>>
>> When a VGA device is behind such a host bridge and the resource is
>> translated efifb driver is trying to do ioremap against bus address
>> rather than the resource address and is failing to probe.
>>
>> efifb: probing for efifb
>> efifb: cannot reserve video memory at 0x1e000000
>> efifb: framebuffer at 0x1e000000, using 1920k, total 1875k
>> efifb: mode is 800x600x32, linelength=3200, pages=1
>> efifb: scrolling: redraw
>> efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
>>
>> Use the host bridge offset information to convert bus address to
>> resource address in the fixup.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>
> I didn't see any messages about these getting picked up for 4.18.
>
> Are they queued on your own branch?
>

No, you never cc'ed me on them until now.
