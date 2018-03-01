Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4026909-1519943620-2-2125385799852108442
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519943619; b=IRvp24qgRfE9e+OqaebX+jbD0R85TNUx3ZrO9XUac2sPqOR
    P1ZCPyAbsfGmsB4qLEQBuIy6hYjKbXsvnC5V8Yagz0cVtfRVSjEoBWFKyyFj6zbz
    i844q2o/lsr7tQ96Aec3eiCZS2PeYiSw53F2q54ZUegUAjBQhD+26MeJw/R89qni
    FL8vsaAL+AVlP+S43D+oJT1SKbKHK82860BxVl58ylT+1Lm0LGVDuupTrnuLVuUE
    nzNxkYr6P3R+zuF38tdjrCPpn9TcOx3lZUkX9s+1keqlbrtMNzcL+z0fFG05Uj+h
    LteCUwCEtDhyUvtMjOOc4zqJpsnsqaKZVvEP9AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519943619; bh=GLhc/oZAnnCpqBALhtxstmDsurm+YJJ6jucyT0
    GWAD8=; b=NVHf1dwjqcMW82hU0CvEU+8agIEnLkKruOjD4r7u7OMabDMS2IMohR
    ifEEjVaMEaEMNySnrbkWCqexMJAdOy7evDDoLUmS4sMJmp5vXw4xvftIuqHZN+jp
    p1YK/5cB3qMYmQ8iZM7zQEU1p0lRPJztJ9U9x28texBAhDq04Wx2Rne/Lwkart7B
    l9+9h7wZdpDAL5C2DGjf1Pqo3i/RNWqg+X8FXuz9F2XJnSpeZcLF0OHuySgWpzk3
    xnk9MjtazqpQ1A36G7B6pPFXS8AnZrIyJJJYEVoAuhUkhCNp/ZOfx5rAZz22b16F
    x2dMqWOEO/4ZfY/K6Hwfs5Q4oiX1czHQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Y/3/bE7G x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uRjEATVc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Y/3/bE7G x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uRjEATVc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162641AbeCAWdH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 17:33:07 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:51260 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161204AbeCAWdD (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 17:33:03 -0500
X-Google-Smtp-Source: AG47ELtiI+ooAPmOFembg9+D1Nu/OFAM+QmMHm/FJ3Zm8ckBzxnYayRTc4LmuVc4rIjC6LuiZuSYGDUg7/OMvJWQhpQ=
MIME-Version: 1.0
In-Reply-To: <20180220181751.20826-1-krzk@kernel.org>
References: <20180220181751.20826-1-krzk@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 1 Mar 2018 23:33:01 +0100
Message-ID: <CACRpkdbAhPdpRTx0P3yvazGgRvtUMmJ-qese1LFoCqNSPuR+sw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: samsung: Validate alias coming from DT
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 7:17 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Driver uses alias from Device Tree as an index of pin controller data
> array.  In case of a wrong DTB or an out-of-tree DTB, the alias could be
> outside of this data array leading to out-of-bounds access.
>
> Depending on binary and memory layout, this could be handled properly
> (showing error like "samsung-pinctrl 3860000.pinctrl: driver data not
> available") or could lead to exceptions.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: <stable@vger.kernel.org>
> Fixes: 30574f0db1b1 ("pinctrl: add samsung pinctrl and gpiolib driver")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Issue is present since first version of this driver so this should be
> backported as far as possible.
>
> Tested on Odroid HC1 (Exynos5422). Tests on S3C24xx, S3C64xx, Exynos
> ARM64 and any other chips are highly appreciated.
>
> Linus,
> I can take it through samsung/pinctrl tree and later send you again as
> pull request... or you can apply it directly as I do not have any other
> pinctrl patches queued so far.

Patch applied for fixes with all the tags.

Yours,
Linus Walleij
