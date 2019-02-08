Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86254C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D172146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UfmgS11b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfBHOe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:34:28 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35954 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfBHOe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:34:28 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so3203685ljk.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 06:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8GCOkO/IBbi3wq9vrh8TnsKVR8g+iPaU8EIWte2XV1o=;
        b=UfmgS11b5iJGOzYnLGu/oP9mTJaXhVJVDbwtY/JXfXtK1ZFIFl9H3lLciuMkDNkIMK
         ri4e6GqjuwpkukHWuG/GFlKtAsHZdkT6nTe4nbSYNmOT4WfR4ObZn4fd4PiNQUGg/3yz
         HhR9xYbb60gn7gzcKc40KESJLLFReDjNTBoMnn8k8gB+wau3uPBt1X2oFKaZMOND79LK
         zko+LsljQTlyAOroJuF/Q4w++3dPoQWmyjN9ywAZL1dLZE8I4R18hltapxl+XX2E1OGU
         33eWA83Liez/eElt4h4njC6fs6kI7cRQNgKwRZ5QBSwCDWoSMc7zNEViILsyT/VZGhIz
         h6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8GCOkO/IBbi3wq9vrh8TnsKVR8g+iPaU8EIWte2XV1o=;
        b=P0z4rMJuKOLoz1iYrGOjpDCVzwNP82ci20RffNc00J9zC0VXiuUdMMoJ5vLWyhRCrD
         NE2W2WdWUcFRFg5AslkU8fTTiJVMb0JRJRhU4zna4wZRbdrK8PwFu8ghjv1FXK7GnZIc
         FpEZ7bRhnLd8oHiDDvsWdmPpmxi4AJcMUHkQZJHjb7j52Q+/qB5vD67botYyABp9lfMy
         IDBYZEzkOhfnSmizNcyW0/iwFXCgArsQ7bVdQRBTAPZpH9l8ej9mtOYuh8h13AIxKQ0p
         ZN48mbwsM7T72xf+LW5JU07+SDgcuh5gjm/3LcrAEayTXMm13yaI6PSGvL41IIstGtEb
         z2rQ==
X-Gm-Message-State: AHQUAubgqZFoyQhJOG6zMtDmucPYf6gM4FpcqfCT0i3THs1DHXDjxdb/
        G1WOfVZK0S0JLPkGRu8mW3I/sJ/nrh8DA8IfRHUtKw==
X-Google-Smtp-Source: AHgI3IZkkce7zSgD3TezZQDa7UObHIOFYyYI0BMFPzEiSnjTFFVpf/Jl1pwaDQrVR80M3/QBSJmbBkg+CdPUaXeG6RE=
X-Received: by 2002:a2e:9356:: with SMTP id m22-v6mr13733492ljh.135.1549636466209;
 Fri, 08 Feb 2019 06:34:26 -0800 (PST)
MIME-Version: 1.0
References: <20190208115411.7675-1-thomas.petazzoni@bootlin.com>
In-Reply-To: <20190208115411.7675-1-thomas.petazzoni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 8 Feb 2019 15:34:14 +0100
Message-ID: <CACRpkdbd8zEXVW_R-Qui89ot4JAGJB1HXZm65OWsbf=zfVn7bg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: drop Hoan Tran, e-mail is bouncing
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Hoan Tran <Hoan@os.amperecomputing.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 12:54 PM Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:

> Hoan Tran's e-mail is bouncing:
>
> <hotran@apm.com>: host ASPMX.L.GOOGLE.COM[64.233.167.26] said: 550-5.2.1 The
>     email account that you tried to reach is disabled. Learn more at 550 5.2.1
>     https://support.google.com/mail/?p=DisabledUser q194si1780402wme.147 -
>     gsmtp (in reply to RCPT TO command)
>
> So let's remove this e-mail address from the MAINTAINERS file, and
> update the status of the driver he was maintaining.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Hoan should we simply change it to:
Hoan Tran <Hoan@os.amperecomputing.com> ?

Yours,
Linus Walleij
