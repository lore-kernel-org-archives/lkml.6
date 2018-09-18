Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F1EECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5303D214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ki/HSFDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5303D214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbeIRVXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:23:07 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36108 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbeIRVXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:23:06 -0400
Received: by mail-it0-f68.google.com with SMTP id u13-v6so3660552iti.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 08:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ifG8VSzIPit15i+8vXcpkivV2jOLfhjQLDmzRCbF+fI=;
        b=ki/HSFDfFKvjLtYAuNLKcs0aJaHysHkb5mcTDl/WbU10Yt7d/nmu8k+DQhOJfezHQA
         CYAorVBsZQw/6gV9z5tEAfa5c/zHQZuNggOnanMoRtoGNf6ROTM5bBV+HZwoBdHdvctt
         RrT29VFormzFA4uYwndxdd5mqCT0Zfw5bfMFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ifG8VSzIPit15i+8vXcpkivV2jOLfhjQLDmzRCbF+fI=;
        b=GoDFyDboHdyUgfgU7XNyPjOCKIQ/k0pvQcHETJL4pypwKEHIwGULWwGcI62WqNLwoV
         INF0GtyYq0sfMtW0eZWR6CJtQ95LQI7W3lOKZRQecmZWaK98/bH3z5Mrig7gk3mS9QX3
         iJnfLWHL8nF5AAA7JJefFlL5kahexdLmC4VBCgPxAA1oJL7cGrM8g26sLg+GbDx5UPVS
         MqOYFhdmmlvswU6v2Bkkd9jVHgjoc7kqj/868ldXMRdfNmKg3pmrwRmR5yNKdv8+wF7d
         8zDV/bs0I1AKNTvSFsTWNf0kRbaJCd00xabjKgCMiMLrsqCmWUs2lIIRxPMlut+HYkxv
         3rQA==
X-Gm-Message-State: APzg51CpAc89+ANxfbOOb5W/MvjK5P7663ySA5c2ofkjeQ9rxn/LOWij
        FpNcO98Jzz36aKle2fyyyOe3V+OQjHDljEaga8tpjQ==
X-Google-Smtp-Source: ANB0VdYpG9b1V0IlJB0yycQVT68/90lPoD/xadTCFlHSmBv751tB6lT06sIiHjkIHuf9VHISo+8hetRLa8fN+FUvf4k=
X-Received: by 2002:a24:52cd:: with SMTP id d196-v6mr16808714itb.58.1537285791347;
 Tue, 18 Sep 2018 08:49:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 08:49:50
 -0700 (PDT)
In-Reply-To: <20180916043825.23247-1-stefan@agner.ch>
References: <20180916043825.23247-1-stefan@agner.ch>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 18 Sep 2018 08:49:50 -0700
Message-ID: <CAKv+Gu8_WwcOaJnSP6L03ihNg_+GGLyzaRtCcpkFetbACy3rAQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufeature: avoid warning when compiling with clang
To:     Stefan Agner <stefan@agner.ch>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 September 2018 at 21:38, Stefan Agner <stefan@agner.ch> wrote:
> The table id (second) argument to MODULE_DEVICE_TABLE is often
> referenced otherwise. This is not the case for CPU features. This
> leads to warnings when building the kernel with Clang:
>   arch/arm/crypto/aes-ce-glue.c:450:1: warning: variable
>     'cpu_feature_match_AES' is not needed and will not be emitted
>     [-Wunneeded-internal-declaration]
>   module_cpu_feature_match(AES, aes_init);
>   ^
>
> Avoid warnings by using __maybe_unused, similar to commit 1f318a8bafcf
> ("modules: mark __inittest/__exittest as __maybe_unused").
>
> Fixes: 67bad2fdb754 ("cpu: add generic support for CPU feature based module autoloading")
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  include/linux/cpufeature.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/cpufeature.h b/include/linux/cpufeature.h
> index 986c06c88d81..84d3c81b5978 100644
> --- a/include/linux/cpufeature.h
> +++ b/include/linux/cpufeature.h
> @@ -45,7 +45,7 @@
>   * 'asm/cpufeature.h' of your favorite architecture.
>   */
>  #define module_cpu_feature_match(x, __initfunc)                        \
> -static struct cpu_feature const cpu_feature_match_ ## x[] =    \
> +static struct cpu_feature const __maybe_unused cpu_feature_match_ ## x[] = \
>         { { .feature = cpu_feature(x) }, { } };                 \
>  MODULE_DEVICE_TABLE(cpu, cpu_feature_match_ ## x);             \
>                                                                 \
> --
> 2.19.0
>
