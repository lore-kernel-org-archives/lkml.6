Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83AAC070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F9E20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gs7HqqLE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F9E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeINL2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 07:28:22 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45758 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbeINL2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 07:28:21 -0400
Received: by mail-io1-f68.google.com with SMTP id e12-v6so5099585iok.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 23:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HSl75cAlxsdEKK1NOhLd3+rcWGnC7SHutCiO/fuC4B8=;
        b=Gs7HqqLEzbQjhmrVodpsIHWgrL2+a/moKehA6pslD+fpWMqQ6KcIdnaIWRKXF5mnQN
         zhb83ezwd8Rq+suOLIpdSFfxg1ieortqYPS5R+Go9mrcoyGk1lsvl+D/iP6WZTaywxga
         90rEwDrptA8s3fhS+1oESjJ8aHX/D8gsD20zA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HSl75cAlxsdEKK1NOhLd3+rcWGnC7SHutCiO/fuC4B8=;
        b=SDEu3EUCmpBqVWJarLSfW0RDxX5co6L3a2iDmfuGYNXpBvhkYSgAApI2hCxGUeedMW
         0r02ewPOWVvydHv+MEp3n8P0N7mbSRo3xK4evD3uiz04jfr+UxYJYcNTNTEPL2ws6Ulv
         2iQR/WQ8OraAYDvY9XI/IEG+LflaD/oglYZmcnZqDYVgvzB4ot27PO+0umWWXw4OyraW
         JvvzbfPRZIFnhSqaOdbdBTnyAw1iaCi4+YUDxJZ8TkyfNLJ8DBJzxg5ndGDILL5/RBM0
         yJwGqxV5BZW3++KQSgqWiz5ucmZ5D3xC8jBMq5LipdD172W8/e+qxdzLAoI4s9lCxlib
         AAog==
X-Gm-Message-State: APzg51BLAJ5AZ5SGLUARqUqa54hZgyInCpSbX2IxCi25Ii+/LBMzc+Oj
        6xMiKX0WF9dedcVr7JPUy/vqM+hz2lg5gzg8wOtaaA==
X-Google-Smtp-Source: ANB0VdY2l4waBjOfUrbZbqRyau4oIqVJ2CTC4D8kkxw1dKjVFq9j3kcfI7q6wn5J8MrAzc7A+6ooJ2zwCVZxkO1kzbc=
X-Received: by 2002:a6b:ba86:: with SMTP id k128-v6mr8815094iof.170.1536905725278;
 Thu, 13 Sep 2018 23:15:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 23:15:24
 -0700 (PDT)
In-Reply-To: <CAHmME9qjTyYpm_PsQ5_oZSfZBGa29zME1XHVak9F4Ued-qm67g@mail.gmail.com>
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-3-Jason@zx2c4.com>
 <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
 <CAHmME9rTEFLaYmzFrc719LW2DWS2Ua_vL6by1UXZ9uDvMpbhYw@mail.gmail.com>
 <CAKv+Gu9RGo9rtGsmwMLZ_=-WSQ_h7har4agXP-2XOKupq-KYtA@mail.gmail.com>
 <CALCETrU2qkLVaxC=cpU5iAeT5B7xGsR+m2ZWtLVK37jMMWtcAA@mail.gmail.com>
 <CAKv+Gu8z1r7F_wbR6-e0Vbryqby7djDy2OR6JJURCsTo6ZMa2g@mail.gmail.com>
 <CAHmME9pcODNc2m26DH1cQY6R+grxYW5dvFpNDpz_GiugM3qufw@mail.gmail.com>
 <CAKv+Gu9GVbSETjp01tANMwJgA6O9aexhnH+47836KjZg+71q2A@mail.gmail.com> <CAHmME9qjTyYpm_PsQ5_oZSfZBGa29zME1XHVak9F4Ued-qm67g@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 14 Sep 2018 08:15:24 +0200
Message-ID: <CAKv+Gu8zULznCmgz++LNNTwfTifaz5L92h=vvWb4yh5fHh-huQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 September 2018 at 17:58, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Thu, Sep 13, 2018 at 5:43 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> I'd prefer it if all the accelerated software implementations live in
>> the same place. But I do strongly prefer arch code to live in
>> arch/$arch
>
> Zinc follows the scheme of the raid6 code, as well as of most other
> crypto libraries: code is grouped by cipher, making it easy for people
> to work with and understand differing implementations. It also allows
> us to trivially link these together at compile time rather than at
> link time, which makes cipher selection much more efficient. It's
> really much more maintainable this way.
>
>> I think AES-GCM is a useful example here. I really like the SIMD token
>> abstraction a lot, but I would like to understand how this would work
>> in Zinc if you have
>> a) a generic implementation
>> b) perhaps an arch specific scalar implementation
>> c) a pure NEON implementation
>> d) an implementation using AES instructions but not the PMULL instructions
>> e) an implementation that uses AES and PMULL instructions.
>
> The same way that Zinc currently chooses between the five different
> implementations for, say, x86_64 ChaCha20:
>
> - Generic C scalar
> - SSSE3
> - AVX2
> - AVX512F
> - AVX512VL
>
> We make a decision based on CPU capabilities, SIMD context, and input
> length, and then choose the right function.
>

OK, so given random.c's future dependency on Zinc (for ChaCha20), and
the fact that Zinc is one monolithic piece of code, all versions of
all algorithms will always be statically linked into the kernel
proper. I'm not sure that is acceptable.

>> You know what? If you're up for it, let's not wait until Plumbers, but
>> instead, let's collaborate off list to get this into shape.
>
> Sure, sounds good.
>

BTW you haven't answered my question yet about what happens when the
WireGuard protocol version changes: will we need a flag day and switch
all deployments over at the same time?
