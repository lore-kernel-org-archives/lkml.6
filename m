Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A717BC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CE320841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQbza69q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63CE320841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeJKVcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:32:13 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45273 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbeJKVcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:32:13 -0400
Received: by mail-qk1-f194.google.com with SMTP id m8-v6so5470145qka.12;
        Thu, 11 Oct 2018 07:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=HNXf9W7V/wD40YRTGMxzc7Qog2qrZ2B59zvSLziNQsI=;
        b=kQbza69qoHg4mSxP16YrB5IA9iITCg6RyCUaJEGPqBhgWuOgVHxPp1PKl6YrepMg+k
         2Ky2iG2tFf9GD5XYQLM3AWq7kdeMx4sBrAbIK73KSKVWRGZC48kpN+xpFBzRdI7E0b7n
         qDZqtsCLdH0kZoiwHHP2dbBqGNifPqaV7Tjvq0Jd7VZ+yKW9RBJKiUIHQeJy5wAHoFia
         mplmW8q5vBf+hJq5UR3Xc6ndM6g8Lp0KrJbZt6/xwPjrKxJ5w4LCBBEMXfjDdFOV3z5Q
         9ZYs3uVYYg+aFKFyhZU6Eq05GAE7gUipblHK+UhgBe7daiVZrqqlvS0Ldy3u/YWjQ0zz
         sinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=HNXf9W7V/wD40YRTGMxzc7Qog2qrZ2B59zvSLziNQsI=;
        b=f7rtLVbGJa/BVvGCZCkILTkKCwZRWkNsaC22iSnrg8VoZUjI8ZjIaXa1NpnkpIGXof
         W3N25MX3zg7CuNpAUiykNr2Pd0vvrnh7bG55YGz7hb+EitmUzmuImkhCQMaHJFrZKTme
         0zOWBA/lZwqb0azNtsjaDSTj1BJ0v5s47d1UpB1SrLmmNpJznWmBSYVpN2neqB0LaBGO
         5JyCAmhhzVIiR7dKgrwk+jyyMfURhtlTu8DeYsOuGKzzZwR0fds3HcVSrmJEDKAXfvXJ
         oAi1DPMtkpvYluMFNsJNKGCVMHE6LM4cecY0+WQHeRZ4CnKeEnhoxvFuF2PNI79bOezq
         KdbA==
X-Gm-Message-State: ABuFfohKoDla0kQz8XLvUWeeBy3U5ecPY5vWI86PkDm96tijzqeq/Hm8
        53zhJtw+waQc6JZiiMkWKX27+fdfgU/shsY98aA=
X-Google-Smtp-Source: ACcGV63j++AupoF2gZzNJxB6/TINlzmnWVJMf6zqCa0r6RSgrcyhT4ie31sK4TxfGYkCQ+icQDEF2saqwrSj7/ucbcw=
X-Received: by 2002:a37:2b12:: with SMTP id r18-v6mr1502068qkh.343.1539266692647;
 Thu, 11 Oct 2018 07:04:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:fd8b:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 07:04:51
 -0700 (PDT)
In-Reply-To: <20181010182558.7034-2-krzk@kernel.org>
References: <20181010182558.7034-1-krzk@kernel.org> <20181010182558.7034-2-krzk@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 11 Oct 2018 16:04:51 +0200
X-Google-Sender-Auth: h9ymsoN9iNBuwxjYtZPCfwTrL0Q
Message-ID: <CAK8P3a2_i+iwrtiZ8o053C+7uML=ULb9oaTr56hy359X_4ZtPA@mail.gmail.com>
Subject: Re: [GIT PULL 1/4] ARM: dts: exynos: Second round for v4.20
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Olof Johansson <olof@lixom.net>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
>   ARM: dts: exynos: Correct audio subsystem parent clock on Peach
> Chromebooks (2018-09-24 18:55:16 +0200)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git
> tags/samsung-dt-4.20-3
>
> for you to fetch changes up to 48ab742ce3b0312f2ee23ed825d3c8820eda7acf:
>
>   ARM: dts: exynos: Add pin configuration for SD write protect on Odroid XU
> (2018-10-01 18:51:51 +0200)
>
> ----------------------------------------------------------------
> Samsung DTS ARM changes for v4.20, second round
>
> Add proper configuration for Odroid XU SD write-protect pin.

Pulled into next/dt, thanks!

     Arnd
