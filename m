Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2B2C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1661A2083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hDsiCg/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1661A2083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbeJAPRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:17:08 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42808 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeJAPRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:17:08 -0400
Received: by mail-io1-f67.google.com with SMTP id n18-v6so8706785ioa.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 01:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WHSCcKDAoYqkVNkgL7cJnsWhuWzfSpHs9yySKunkwU0=;
        b=hDsiCg/h9SXZ52kmSLAnAFsyL3uJeM2O9xGAbKXp28YVHti/1avgW2CbKFUCTpBqWs
         edlStFZMToNu3nMeK8q8bsrrPGVi55RsiAjQEajrhIJOe6Q8dtlBsFsnTSSawpKl4EoB
         OaVTNzcLkJhSUEjxc3RFIVFR7quIxTruQn6z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WHSCcKDAoYqkVNkgL7cJnsWhuWzfSpHs9yySKunkwU0=;
        b=EEjCJP2woD60vOD8f6dEPh9ujeGWggxrEQchCaBCb4AhK/u8a1ij41UDhMYmDM3gYx
         YKL4fU4A/UcFJlZgtGGSArEmK2fwCMekCH5xSb0fBFuxME9JH3ADlkyX9JmfQbAD1kVj
         TIZsGcYX8yxaJmrEDBJszq+/8cEhJqTJ+E5MII1dSXywqZkMZKJTPyjD867Ld+zm4tZw
         vlfYQ+UWpkHcMxEaa1Rp8WLjVaXoVVqGmU3xMxYPT5bDQ48ATyPuAbq0Bf0NbBK78FJo
         7dwd7ZV7Lb7XtsqsPq9RxCr748tCaEioS1/91+Y5ft3Ki4+J5ycamtRoSUDXs2D2BNwC
         +hRQ==
X-Gm-Message-State: ABuFfojWW9khJZEluWjuqdfyESx+OmLZCRIlQdAPcXnQ0e0+OqnM6t9W
        a/QrIz//Qx22dNewOV54TD0KcKROhyfm+MzxGQEeMA==
X-Google-Smtp-Source: ACcGV60RELazadMKUddbGvHvx4m7xHoYPnJayE8Zfb2SsdRuCvuexZdFMzq65jNDcRaEcrFkVaA369SeT4xL2SJDUr8=
X-Received: by 2002:a6b:5d12:: with SMTP id r18-v6mr6163494iob.170.1538383229944;
 Mon, 01 Oct 2018 01:40:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 01:40:29 -0700 (PDT)
In-Reply-To: <20181001072003.GA17784@Red>
References: <1537351855-16618-1-git-send-email-clabbe@baylibre.com>
 <1537351855-16618-3-git-send-email-clabbe@baylibre.com> <CAKv+Gu9VCZx=UHSoN7SexZeTzLK6yk9YAe5qMdhhDMUFnqTSCQ@mail.gmail.com>
 <CAKv+Gu8jgEyaUA2OOzxNT5nvWoC7qZgf+KazzH1Q5yWj60V2TQ@mail.gmail.com> <20181001072003.GA17784@Red>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 1 Oct 2018 10:40:29 +0200
Message-ID: <CAKv+Gu9u+_Vyqo173qY16gBfYMvjf8u-4FZO9HLYQttOjfAvMw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] crypto: tools: Add cryptostat userspace
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        nhorman@tuxdriver.com,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 October 2018 at 09:20, LABBE Corentin <clabbe@baylibre.com> wrote:
> On Fri, Sep 28, 2018 at 07:03:11PM +0200, Ard Biesheuvel wrote:
>> On 28 September 2018 at 15:13, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> > On 19 September 2018 at 12:10, Corentin Labbe <clabbe@baylibre.com> wrote:
>> >> This patch adds an userspace tool for displaying kernel crypto API
>> >> statistics.
>> >>
>> >> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>> >
>> > How do I actually build this thing?
>> >
>>
>> Never mind.
>
> Nope you are are right, this patchset clearly lack documentation.
>
> I will send a subsequent patch with it.
>
> Furthermore, since you seems to use cryptostat, what's your usage/opinion about it and what statistic it miss.
>

To be honest, I mainly used it to check whether a certain cipher is
being used at all or not, i.e., to check whether the my mac80211
interface is really using the arc4 and ccmp ciphers it allocates, or
whether they are simply there as a fallback.
