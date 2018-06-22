Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B85C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1629723E7D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BrSg8YcL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1629723E7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932636AbeFVHy1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:54:27 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:38192 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbeFVHyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:54:23 -0400
Received: by mail-io0-f195.google.com with SMTP id l19-v6so5365957ioj.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 00:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SOjW5k1Pu/qce8VGWUgO4dMAq9KKoNMpDllP2ts03yk=;
        b=BrSg8YcLRhMsptYwv/x/ovc5kg+F9lfRV02NIYrI+4gIU2aCnNCVPWiHrqh3GncWpG
         sz2r9isxZNlFqo47f+BD09QNbHCl/0MWu0gPHf0xfiPVvkXEdzGJCpZaB14DIVcu8TPs
         nO++kI6YdBrTYCv1g6bL0zrNLnKzras9sWyZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SOjW5k1Pu/qce8VGWUgO4dMAq9KKoNMpDllP2ts03yk=;
        b=mtkNKfc0ivkhMm0Xv3wBtEcLU0nfIBKQ1/u+3Vn/4q2iZ5+MJMiLItXbZH+qHAzYEO
         BxFBYkM37UGRnj0NpQcNxbIUZTSBiTSKd2iuNnbxZ9TGOZl432UiwR8/vLa34xCRelAH
         UOICrkaN1nSxyyqsA4Szr+oMCQCl1DrHdyPTHRfQpLkBRO0bp5EX6LsgCv4OBaynlFO2
         l1HbeNX5Nvbn4XrPG4DFnFiwX3d8FHn6uc8qsmQvNOkP5exfGkRvaU3+zM7qbRsubARg
         rIzjY81F/4wmsJs36o9S3SNoKg9J6tSspR1XnrMJ4QhpzDqruTrzKFOV+mTCoHhTKMDW
         foIA==
X-Gm-Message-State: APt69E2SLyhef5l2GeHcCBK2r/+5ffFl+JxlOrO9eu1hxy39hZuhIbBP
        Z7466EIIyr/LB+nsuTVWlqpnLldl+ZXXzqVbGZaFQw==
X-Google-Smtp-Source: AAOMgpf7NriePXmksIDuTJRCFbAnSi6AI0AwOsi/HmpQEFlW/1UPtTfN1Pue7vItM9EWyT1AYJeA71IsjH3etIMw4p0=
X-Received: by 2002:a6b:520d:: with SMTP id g13-v6mr469663iob.60.1529654062755;
 Fri, 22 Jun 2018 00:54:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 00:54:22
 -0700 (PDT)
In-Reply-To: <6376822.ENUjdQ58sn@amdc3058>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <CGME20180613154552epcas5p4877f53310b66cf9d3e17196b0d028e41@epcas5p4.samsung.com>
 <CAKv+Gu9+M8zOtACPQ4_UMgp-M1LfZnciYe1VTQNqn_zNWJea4g@mail.gmail.com> <6376822.ENUjdQ58sn@amdc3058>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 22 Jun 2018 09:54:22 +0200
Message-ID: <CAKv+Gu9dFGudOr1uTmOnM=X47gsOAgpdUJ6UMiDJJ_7phH1ZzA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Peter Jones <pjones@redhat.com>, Sinan Kaya <okaya@codeaurora.org>,
        "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        Timur Tabi <timur@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 June 2018 at 18:08, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> On Wednesday, June 13, 2018 05:45:48 PM Ard Biesheuvel wrote:
>> On 18 May 2018 at 16:17, Sinan Kaya <okaya@codeaurora.org> wrote:
>> > A host bridge is allowed to remap BAR addresses using _TRA attribute in
>> > _CRS windows.
>> >
>> > pci_bus 0000:00: root bus resource [mem 0x80100100000-0x8011fffffff window] (bus address [0x00100000-0x1fffffff])
>> > pci 0000:02:00.0: reg 0x10: [mem 0x8011e000000-0x8011effffff]
>> >
>> > When a VGA device is behind such a host bridge and the resource is
>> > translated efifb driver is trying to do ioremap against bus address
>> > rather than the resource address and is failing to probe.
>> >
>> > efifb: probing for efifb
>> > efifb: cannot reserve video memory at 0x1e000000
>> > efifb: framebuffer at 0x1e000000, using 1920k, total 1875k
>> > efifb: mode is 800x600x32, linelength=3200, pages=1
>> > efifb: scrolling: redraw
>> > efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
>> >
>> > Use the host bridge offset information to convert bus address to
>> > resource address in the fixup.
>> >
>> > Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>
>> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>
>> Bartlomiej, could you please take these via the fbdev tree for v4.19?
>
> Sure, I will queue it after the current merge window.
>
>> Peter already gave his ack but Sinan dropped it (presumably because of
>> the split in v2)
>
> Peter, can I (re)add your ACK to V2 patches?
>

Actually, it would be better if we could take this through the EFI
tree instead, with your ack. Would you mind?

There are some other efifb changes coming up, some of which depend on
core EFI changes, and taking these through different trees is going to
be more trouble than it's worth.

https://marc.info/?l=linux-efi&m=152929425329015&w=2 from Hans, and the series

[PATCH v2 0/2] efi: add support for cacheable efifb mappings

that I just cc'ed you on a minute ago.

Thanks.
