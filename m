Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FB9C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F0720657
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jzIjVuoR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F0720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbeI1X1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:27:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38920 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeI1X1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:27:52 -0400
Received: by mail-io1-f68.google.com with SMTP id l7-v6so4688453iok.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 10:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FXAVLPPiD/Rujvmt4pV0XZrfngaOvc5BhCA1Pjr4Zm4=;
        b=jzIjVuoRGd6j6kUhsBBoGF0OFedmwatKZvRZBjQdEwnhFyN12PwbRlpv1HPN5bu0WJ
         gOuRgaKJMPQoQpbDhKayVFCOeXEpkDGq6iB3sZlCZHR2hAJwnU2/5lBWau6LnzzFTr4Z
         Or7V5WeaLDzTzJ6tAWUaVSXwvYd3DLVE6l1yA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FXAVLPPiD/Rujvmt4pV0XZrfngaOvc5BhCA1Pjr4Zm4=;
        b=A5iOAACGjjL3zkBJui+MvHacJV6PMculn3llfcQZJtqNgTdynaspYWDcmMxEvOobGb
         RQH8hmgLfDP46tfBpD8rt7AxvkuwSAFPSy/GKggnPerASwTQ4V8j/aifYCjvy+pOv7BR
         wVoWr5PJYnPmgITxCBVPk+ph69132LIGSI7DgN2HJGEi9sL8v9PE4JetD6kBw0Q6jqJ5
         KmixiUuogeVQZxGRB47n8I0S+JoF5jK1uOpeBXEECuPiW64OgLLmjmIEQHdwsCm+PWfG
         0CvivWbXvCI3UO4BSNEp4SGOVO4hqCcysIdgAA2zyCbyXVkgapAD/9SGaLJU2Dd/ZSfS
         kxHg==
X-Gm-Message-State: ABuFfojwDgBe6DJO9jp6eShyJDP1D56avJSC04ah6P5V6kmSe91g1Wcd
        ue8V4T2i05sY8MEPuxpdPDptPAjCY9anhSV87p0fdA==
X-Google-Smtp-Source: ACcGV60AkKep0cpavojw/XwkCBwmDJX6xVJIQuHZd+0AKcNSVeC4p5kHPYFfV5e6oUxItqGi1LQ3AlbssNkSqWY4y1o=
X-Received: by 2002:a6b:5d12:: with SMTP id r18-v6mr12306348iob.170.1538154192122;
 Fri, 28 Sep 2018 10:03:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 10:03:11
 -0700 (PDT)
In-Reply-To: <CAKv+Gu9VCZx=UHSoN7SexZeTzLK6yk9YAe5qMdhhDMUFnqTSCQ@mail.gmail.com>
References: <1537351855-16618-1-git-send-email-clabbe@baylibre.com>
 <1537351855-16618-3-git-send-email-clabbe@baylibre.com> <CAKv+Gu9VCZx=UHSoN7SexZeTzLK6yk9YAe5qMdhhDMUFnqTSCQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 28 Sep 2018 19:03:11 +0200
Message-ID: <CAKv+Gu8jgEyaUA2OOzxNT5nvWoC7qZgf+KazzH1Q5yWj60V2TQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] crypto: tools: Add cryptostat userspace
To:     Corentin Labbe <clabbe@baylibre.com>
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

On 28 September 2018 at 15:13, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 19 September 2018 at 12:10, Corentin Labbe <clabbe@baylibre.com> wrote:
>> This patch adds an userspace tool for displaying kernel crypto API
>> statistics.
>>
>> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>
> How do I actually build this thing?
>

Never mind.
