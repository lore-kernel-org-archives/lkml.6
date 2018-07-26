Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9962BC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DECC20893
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W0XrajHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DECC20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbeGZI0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:26:01 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:37895 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbeGZI0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:26:00 -0400
Received: by mail-yw0-f193.google.com with SMTP id r3-v6so236699ywc.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 00:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZjrMfx6KCt0ZHIbnH+z8EWJRYZlVJLR/F0SMlAuL4pw=;
        b=W0XrajHaPVLnkL8W4wdaIcFKWsfvQYgM8ZmORGdTAsqV9gjt5JtlAaFPHeZtkfvfiS
         HRKoHYnyEmfimZZO76V22PEBiBXtaZIT1PduivZ4gMkvgxWzzf89mBV4H3Zag9enVdbF
         UhoFaI9pC6HCewNSxliZnzHSB6asxxB/PTWhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZjrMfx6KCt0ZHIbnH+z8EWJRYZlVJLR/F0SMlAuL4pw=;
        b=SHSWuk/sIHBE6vVcAW/B2Bb4aDgZ3tYZ6mso+phqpaY6pw8CZQ+9nYsZ/LlMmieQyW
         sgfpkm4ZeTcAdn+fxoRYjjxefzl68+MWN9FmcIeDvk8QQw0V3UW3nkTArad/SaU3y8LG
         YZ18bNcy9H1DmXLtmFbsAb79Lhw3SvVnImL2EdwGFQh7lvaUvhMXzJxhhSlOPVX2X1hO
         WV3LIEB9kBs55GQ4AmesbObL7l5ZB4ZAwQW9jSGD/M5MrTrPQi08j6iaBgNPnCgKRhGw
         1OGQ3CjcKhDtzdv/c5kHjqPBHq7Zcqw2ixIgLmhZZApCEBT7ArBBbVgEYR98pe//u9VB
         Eeqg==
X-Gm-Message-State: AOUpUlHKBi7/94JjJXxIu49jVToHS3XrAXwC1gptC9UFmtGtqneIrYPv
        oiR9oyQ6sTQ5EI+0PBQQGp6DPGwfGlF1uDCjkiBLog==
X-Google-Smtp-Source: AAOMgpeIcVHSbbHsRVmkdq0au8mBL30Kicsv/NYs3r4BvJq0Pe3xKCgkUbweMaM2hV4R2UUuZdI7eMOXHoFSJyw++cQ=
X-Received: by 2002:a81:77c3:: with SMTP id s186-v6mr319453ywc.31.1532589033722;
 Thu, 26 Jul 2018 00:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180626153213.676-1-anders.roxell@linaro.org>
In-Reply-To: <20180626153213.676-1-anders.roxell@linaro.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 26 Jul 2018 09:10:23 +0200
Message-ID: <CADYN=9Lu8uCLGaFXTRah2g13Tk2Zs+O8UDRSek0n=0fer4yDxA@mail.gmail.com>
Subject: Re: [PATCH] selftests: mount: remove no longer needed config option
To:     Shuah Khan <shuah@kernel.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2018 at 17:32, Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Since commit eedf265aa003 ("devpts: Make each mount of devpts an
> independent filesystem.") CONFIG_DEVPTS_MULTIPLE_INSTANCES isn't needed
> in the defconfig anymore.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/testing/selftests/mount/config | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/testing/selftests/mount/config b/tools/testing/selftests/mount/config
> index b5d881e48548..416bd53ce982 100644
> --- a/tools/testing/selftests/mount/config
> +++ b/tools/testing/selftests/mount/config
> @@ -1,2 +1 @@
>  CONFIG_USER_NS=y
> -CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
> --
> 2.18.0
>

Ping.
