Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12A4ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCE420671
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SZsl36h1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CCE420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeGTVNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:13:38 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:36045 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbeGTVNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:13:37 -0400
Received: by mail-io0-f196.google.com with SMTP id r15-v6so4677629ioa.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 13:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iy5EPmjuJuVexVlXnQRqAQymeys5SWBnTpDzIO+MPp0=;
        b=SZsl36h1/U7qsYfLBHPSgplcu/tDiYdN7UWHZaRP3g9qivYSCy1AeUvuKor4z7I40k
         dYctj5cGTt4bYbHjS1k3sXOz3ZnmQx3MML8NQIlAvM5oWPnQT46EWobnWI2EMjHT2GXz
         b6vSQc7aQ/x6lDJrmKYMa/muOxV1YaJi3gAlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iy5EPmjuJuVexVlXnQRqAQymeys5SWBnTpDzIO+MPp0=;
        b=LPai48Mpwx3M1Hp3R8qNljP/oVpTftn1gcq5t7rGLwws4BgVLjRLUsrU3Pj3etC4yu
         ocEAuyAP5BcQZzRl3kr/8HUposjfz3srO12Y9Nk5YiKeubIMFpRTPTq7NMYAOVoNPMHU
         zMqK3NPq21itzIGP1fQjAh0vwxZit4KrCvb3UpGO6lErBgoOC+vNVfKM8kmecdjQLMSQ
         PPGxUkP2eZC/OiGwyclRWkyavVRM3siigbzOdKfivZVsABuVLUIT2AONxZwgykMz4T71
         1SSJd3pb0TtacSMhxkaiqQBHNePGrhw34LYQrQsOdVdXliHaB4cPMnbFdRrsrYfjZ8Jo
         LKWw==
X-Gm-Message-State: AOUpUlFTs+5rOlSkFWbCm5+YDjvpc7uj5U9INAh+5cMS/PXSHxyggdtp
        8lRxYNWZ4WALMZkG7crPWbiW8CnEgjSjHM8lO46OnQ==
X-Google-Smtp-Source: AAOMgpelmF7niUIHzYDuAwSAk1XKqpmDjPp6hIVAYJrurzEiO4MycT24cfhnJyLI2YjYvlVCur+c8+OxGwqsMiD8Eng=
X-Received: by 2002:a6b:4a15:: with SMTP id w21-v6mr2603325iob.277.1532118226190;
 Fri, 20 Jul 2018 13:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <3502c393-e098-241b-c361-4e5069486d71@infradead.org>
In-Reply-To: <3502c393-e098-241b-c361-4e5069486d71@infradead.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 20 Jul 2018 22:23:33 +0200
Message-ID: <CACRpkdb7q6x1wJZZcjvkEKNwe7BmSyGsLHY=1zZki_XMSWV2Bg@mail.gmail.com>
Subject: Re: [PATCH -next] net/dsa/realtek: add MODULE_LICENSE()
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     netdev <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 6:16 PM Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
>
> Add MODULE_LICENSE() to net/dsa/realtek.o to fix build warning message.
>
> WARNING: modpost: missing MODULE_LICENSE() in drivers/net/dsa/realtek.o
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
