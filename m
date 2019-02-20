Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638CAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FE521773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="twHREtIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfBTJl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:41:57 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44141 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfBTJl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:41:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id q128so20159731ljb.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 01:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=coW99miv52Oebix0UpxqugpmQqA6e89avvbbbDjxFyE=;
        b=twHREtIo4ImtaX/cgoO1GofFO3Mv3V2td0STXWoNTH6MfzJgQFY1EgUoEc/E6YRf3A
         +oy7QZLbd/8YXVqodIsf+MkfoLauf6jDvStSd5HQRPVCSJxYZvbzg+AMjka1MD5fLpBH
         1AZe0Pbx0ACYsLs54ZY3G2H30cmSvb4LQwstsxPnR5+Wt8ijIR8bTLeZ9T4qIVKt5ucG
         Wn4oCz6FOrAlpQvHaoz7URC1OJtPjHFQx+KqaGdDGKFDQ5Q7Gd0jJ4F6pXMsLr0m56ui
         vcEvC1KM8fwcdqRHMa7EN4BvcIe24hYo4D4gmxmE73fwX5vIEZdOLSgF4ZlEB+IhYvk1
         fxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=coW99miv52Oebix0UpxqugpmQqA6e89avvbbbDjxFyE=;
        b=QjNjpr16hUXihsBPq5MvtJ/uLFLy/LFEPEjIVQ51kEhMPxfvS/ids7kau1h6Q+NWvI
         D9xTVf0skFuAckehUas9gTFsw3tTEcndzuvccjpHJwr/G4lzzDqD/BA1l/H7tAXkdr8L
         MoW1XWWTAOZpdsCbbYppa723oHA0vmA9l8jKer/pFHbujCsuLrsJ/nWhWEvscHXHYs7C
         hpfL4BFg4J/drmGCNlJA4oWHJ+gCpyOznu/foT7yYpE2dBlaEbEqFVBl6ZAP5e9j0jtU
         3zjY10kllulbBd2XAE+rA0xsq8PAtjKXE0Cv0qtmdV68Ubhg6s4/4rkvxIXE3lo2nP8P
         IJ1A==
X-Gm-Message-State: AHQUAubJSCaSct4K3ytgBAwJ4if3jn1rNYF7ZzVAZVYfL87+8dlupHpc
        UedqTyUxX1dRIivDSW1JHlqnZtTX/wTY1NM3iCWG5Q==
X-Google-Smtp-Source: AHgI3IbUqbLT+SRx4BO45Bm00sPCeH8GZZhxXBS14tqNdIXqzSEl8UfNJ21vroYjYvAFj9IW9ozMDa4HJ8otsw1IF8k=
X-Received: by 2002:a2e:6109:: with SMTP id v9-v6mr19804106ljb.126.1550655715094;
 Wed, 20 Feb 2019 01:41:55 -0800 (PST)
MIME-Version: 1.0
References: <1550163266-19975-1-git-send-email-alexandre.torgue@st.com>
In-Reply-To: <1550163266-19975-1-git-send-email-alexandre.torgue@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Feb 2019 10:41:43 +0100
Message-ID: <CACRpkdbaBzRZTea4nmm8b-wt9iUipPLaY1MbaAKEPxoY+HFVjA@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctrl STM32 updates
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 5:54 PM Alexandre Torgue
<alexandre.torgue@st.com> wrote:

> Please find 2 updates for STM32 pinctrl driver:
>
>  -Fix a memory leak issue present since the beginning of the driver.
>  -Handle error case when a hwspinlock can't get locked.

Patches applied for v5.1.

Yours,
Linus Walleij
