Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 732DEC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2979E20693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ixKUeoTh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2979E20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935983AbeFMPW3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:22:29 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:46266 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935691AbeFMPW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:22:27 -0400
Received: by mail-io0-f193.google.com with SMTP id d22-v6so3816968iof.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fyEXvMhLkO9SZrUqxqlvv8Rm1hSheVFC9tfQ3aTcN/4=;
        b=ixKUeoThG5kb+DUx+RKTVQXHNkkBT6Wnk/rAgztZljxJ+NUPKRVuRG1G4S2+hXQQ30
         f7pPf/S+RFGJ7A3KJ1tcM3B8CRAEw7hWXiuDp/5tTN0g2CmGFJ24cik5hs79nIDt1kYl
         1KfnBG/62I2nE5h8ZkPXD9t5iw9WjmNMHTWN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fyEXvMhLkO9SZrUqxqlvv8Rm1hSheVFC9tfQ3aTcN/4=;
        b=IRH4RTidmibICZnZGCtgO0daXtk8Ah0kLBhfXP3AnndYkrIm8VeJS7MFq7epo+Trp5
         Smr5+M0y+FpeInOLg0AJh0MYTu8PxRVcPWx8ZVQ+w5UYR9N/xc4G1gYzIOuY/WZ2fdW1
         6KzUh9zS2J6ErBf4PX6Qyb4ukfBbu+j+0ug0cpZEHyVS3QMZdR9YfIjNvvUpRWTFah2U
         PzU02Jo6yy017slNjKKJKXcX65qwcseZBxriGRgyRwOP0R5Swa/WnRIibHMNLo1JkGba
         /fODNQBROrtYjMsx7AxmbwRJaOLiSovo9M3oMCSPeZFjaGO4aN9uvboqMfSB/jgFEuO0
         LNiQ==
X-Gm-Message-State: APt69E3NdPNxsLCEu0LTtnd+xZN4REUOjs02+77iXiMxo8dLef2Y/Y6Z
        pphMPlOK7ZK9OJNRr51kUMKuQLmKu6FbPBL+in0sug==
X-Google-Smtp-Source: ADUXVKIqQUtE1gVAYZVVWHGnMBBTSeD3sogiTewKaGNS72TrH7SJzxR1BBOH6v0Xs2Gpbp5o434q2JcfLzgNYxgCFCY=
X-Received: by 2002:a6b:6709:: with SMTP id b9-v6mr4971898ioc.170.1528903346831;
 Wed, 13 Jun 2018 08:22:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 08:22:25
 -0700 (PDT)
In-Reply-To: <442896963833043f84dd9d0c14d88351@codeaurora.org>
References: <1526653072-7153-1-git-send-email-okaya@codeaurora.org>
 <1526653072-7153-2-git-send-email-okaya@codeaurora.org> <26470c5c-55db-9dff-3794-4e4a96c8bcb6@codeaurora.org>
 <CAKv+Gu8UG_D0AAR8Usdi7DrucqaEs+f-JTU1voR-CcrtNY2ZEQ@mail.gmail.com> <442896963833043f84dd9d0c14d88351@codeaurora.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 13 Jun 2018 17:22:25 +0200
Message-ID: <CAKv+Gu_ZRNvW9CeqRyUpQGnrkkoOi1Hh08re=_Gz=EGVTAvbsA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
To:     Sinan Kaya <okaya@codeaurora.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
        Timur Tabi <timur@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Peter Jones <pjones@redhat.com>,
        "open list:FRAMEBUFFER LAYER" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 June 2018 at 17:17,  <okaya@codeaurora.org> wrote:
> On 2018-06-13 11:06, Ard Biesheuvel wrote:
>>
>> On 13 June 2018 at 16:22, Sinan Kaya <okaya@codeaurora.org> wrote:
>>>
>>> Hi Ard,
>>>
>>> On 5/18/2018 10:17 AM, Sinan Kaya wrote:
>>>>
>>>> A host bridge is allowed to remap BAR addresses using _TRA attribute in
>>>> _CRS windows.
>>>>
>>>> pci_bus 0000:00: root bus resource [mem 0x80100100000-0x8011fffffff
>>>> window] (bus address [0x00100000-0x1fffffff])
>>>> pci 0000:02:00.0: reg 0x10: [mem 0x8011e000000-0x8011effffff]
>>>>
>>>> When a VGA device is behind such a host bridge and the resource is
>>>> translated efifb driver is trying to do ioremap against bus address
>>>> rather than the resource address and is failing to probe.
>>>>
>>>> efifb: probing for efifb
>>>> efifb: cannot reserve video memory at 0x1e000000
>>>> efifb: framebuffer at 0x1e000000, using 1920k, total 1875k
>>>> efifb: mode is 800x600x32, linelength=3200, pages=1
>>>> efifb: scrolling: redraw
>>>> efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
>>>>
>>>> Use the host bridge offset information to convert bus address to
>>>> resource address in the fixup.
>>>>
>>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>>> ---
>>>
>>>
>>> I didn't see any messages about these getting picked up for 4.18.
>>>
>>> Are they queued on your own branch?
>>>
>>
>> No, you never cc'ed me on them until now.
>
>
> Ouch, I hoped that you would get it via get_maintainer script. Sorry for
> that.

Actually, get_maintainer is right: this should go through the fbdev
tree not the EFI tree

Were you going to resend them? If not, I can find them in my archive
and ack them, and we will ask Bartlomiej to take them for v4.19
