Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91667C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613F12084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548324215;
	bh=uNKkycmoJEidVa6IAHUV0WWovL+DoXD5gOD4QJk09dY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WOQ9FBgg0xDTYrcucQFtOi4Lek2Es7gljAGjIXKpVClWeprH93t6lg1sEtiz5t3uw
	 OO96EEC2A6mODlxzxF2WRvK3oLnOYmDNKoNtSQ2tHVlIoq3Ag4oGWZ6lbAlZIKhaee
	 Buht0MuzRO+7CQ5vIjPMzPoQsCdTPy9XTgqIHb7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfAXKDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:03:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:55440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfAXKDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:03:33 -0500
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D238218AD;
        Thu, 24 Jan 2019 10:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548324212;
        bh=uNKkycmoJEidVa6IAHUV0WWovL+DoXD5gOD4QJk09dY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MXkbQ2CFp313tn8Y2eecF5GOaRrmBlsRN6Pf4Mrc6LRS5IkgF5gSSl7hMkazfyETl
         tv6CaoOTWQIH7wt56+wkO9yCfxEHfDDSkYET08xHIZZeJSev4gu+7ts3qqZOyEElhQ
         MFEV23TQnAdBesQNZFgiZdPvsLQ2/YIwNYrCIl0A=
Received: by mail-lj1-f178.google.com with SMTP id n18-v6so4671882lji.7;
        Thu, 24 Jan 2019 02:03:32 -0800 (PST)
X-Gm-Message-State: AJcUukcDpg4P/vcajTkKqQ7IVNv4Ji+PIKbc7gKiFw/LA1lmfETAkDpt
        gdeS2cNP/DsFrfv+gbSKesJVh28LTUYc4U4wyDs=
X-Google-Smtp-Source: ALg8bN6cybt7wNDpWyiORKPAnWUgGBRLVVIDcOnYSOvUI9xhZvxk+l75CTSOV7O+bsN9X5NyrHPbO/0qyQ2GHo1x1ZU=
X-Received: by 2002:a2e:9a16:: with SMTP id o22-v6mr5036922lji.112.1548324210587;
 Thu, 24 Jan 2019 02:03:30 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190123165551eucas1p1cd99462e3767dbb4feb88b996225ed21@eucas1p1.samsung.com>
 <20190123165533.29645-1-k.konieczny@partner.samsung.com> <20190123165533.29645-4-k.konieczny@partner.samsung.com>
In-Reply-To: <20190123165533.29645-4-k.konieczny@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 24 Jan 2019 11:03:19 +0100
X-Gmail-Original-Message-ID: <CAJKOXPes9CmAX4ZE+2jwGdid2b9na_yqpauvgYZEFq17wk7Cnw@mail.gmail.com>
Message-ID: <CAJKOXPes9CmAX4ZE+2jwGdid2b9na_yqpauvgYZEFq17wk7Cnw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] crypto: s5p: add AES support for Exynos5433
To:     Kamil Konieczny <k.konieczny@partner.samsung.com>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019 at 17:55, Kamil Konieczny
<k.konieczny@partner.samsung.com> wrote:
>
> Add AES crypto HW acceleration for Exynos5433, with the help of SlimSSS IP.
>
> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
> ---
>  drivers/crypto/s5p-sss.c | 50 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 46 insertions(+), 4 deletions(-)
>

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
