Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BA1C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E35320846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6AiO0S8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E35320846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932224AbeFTRpU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:45:20 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37385 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932763AbeFTRpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:45:14 -0400
Received: by mail-pf0-f195.google.com with SMTP id y5-v6so161269pfn.4;
        Wed, 20 Jun 2018 10:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jPjzLayK2qqkVIoZweAl4wIlbeWqWt8wJ6ii3s36pnc=;
        b=T6AiO0S8RORzpMG71B/V0t8FN8BFBiMfb7cjY3XPLvdsigHpUnQtfP6im4xhNGZ8Xg
         H5srn3PihF2exuDB4fF7VuyB2u0ZRHVTZiTCBpmaM9vzyiawaLcZk3RRPzpLtTph8bo8
         jRxKncl/XajchkJnOD5KbVGO36/Tx5bDUFCbxhIRU1TeKYIFREEMTjIpBKowjKZzm+LL
         dmkNGVxbFpQDsFLg0UkgzxSrfOMGkXXWLpdpNRKTQ033lNBVCx58NC21/7GozrlVV7dz
         URn3UVNnpgVNIFeDIl54+uJxi9ZkPzVSrzDFOVmLx2Db4hv8vJgPIUx5A2my+Ir892SW
         1VbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jPjzLayK2qqkVIoZweAl4wIlbeWqWt8wJ6ii3s36pnc=;
        b=GgD9hLH49RMJRJEKNOUhUSS6wiVRBYyPXnabhkuevTcfm/uIHgWkkRwOA5ccEBIUvP
         u0KhdByolUzWoqmnrycDC9sRD1sPRnqjpIJEHVqc2OBm1mU7ojH3t7dJCG6mrDZ/ZeVr
         O0jd1Gs+M7wEPkNW6L7mX3A8lXe8pEv73BdHkJ0bWk/mj1U8gHWv7l32HDd5qqnc+p+o
         aGyZ8aNl6lTYQ0kAZ1xdwdQebJPhRmyaaWD/aDXRual8VjR0JuvdtKhMIXmXLAPezFxm
         8hirNF01QluNdp9JO0PDFk1//90uPBvLokNdiukJ8iWby+/gyWp7NCVjMUaYMsu+L/vU
         l1/Q==
X-Gm-Message-State: APt69E0Jis/G1IFTkU9cdSaPkk7khTXX6LVAjjRNBvXcMq9S6fcvYOq8
        p+3ySsyqKGo4UnoDS7qFKIYt+bYn3DcBTKvKgMYQGdRu
X-Google-Smtp-Source: ADUXVKJbFTnsGYKwu6odvdTi0iLbRBPtd2EHy8ltPjTKGUXaX29Tk/G9kGtZ6+4f3dkCEV87P/usyTNhLiQWmUUDggY=
X-Received: by 2002:a62:4715:: with SMTP id u21-v6mr23913005pfa.89.1529516713387;
 Wed, 20 Jun 2018 10:45:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac03:0:0:0:0 with HTTP; Wed, 20 Jun 2018 10:45:12
 -0700 (PDT)
In-Reply-To: <20180620053204.GG13316@vkoul-mobl>
References: <20180618141259.23141-1-vkoul@kernel.org> <20180618141259.23141-4-vkoul@kernel.org>
 <20180619142853.wgi5easw4zv6ttrb@gondor.apana.org.au> <20180620053204.GG13316@vkoul-mobl>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Wed, 20 Jun 2018 23:15:12 +0530
Message-ID: <CANc+2y5-7S_1bvMYs54X3MqCkcsha3iNe1BGa-pG=_xH5xYn1Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] hwrng: msm - Add support for prng v2
To:     Vinod <vkoul@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Matt Mackall <mpm@selenic.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 20 June 2018 at 11:02, Vinod <vkoul@kernel.org> wrote:
> On 19-06-18, 22:28, Herbert Xu wrote:
>> On Mon, Jun 18, 2018 at 07:42:59PM +0530, Vinod Koul wrote:
>> > Qcom 8996 and later chips support prng v2 where we need to only
>> > implement .read callback for hwrng.
>> >
>> > Add a new table for v2 which supports this and get version required for
>> > driver data.
>> >
>> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
>>
>> Is this really a pseudo-RNG? If so it needs to be moved over to
>> the algif_rng interface.
>>
>> hwrng is for true hardware RNGs only, because it may be directly
>> fed into /dev/random.
>
> I am trying to find how how much random output this hardware generates.
>
> Meanwhile, can you please point out examples/Documentation for algif_rng
> and if any test tools for this?

As Herbert suggested exynos rng is a good example. It was wrongly
using hwrng framework then switched to using crypto framework.

I have a patch for msm rng using crypto framework, only compile tested
though. You can find the patch at
https://pastebin.ubuntu.com/p/44r6BJgBkN/. I am having a hard time
sending patches via git send-email form a gmail account so I have put
it in pastebin. Feel free to use it if that is useful.

Regards,
PrasannaKumar
