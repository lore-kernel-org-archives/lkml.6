Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EACC04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA992081C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V11bvIeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA992081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbeK3Nae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 08:30:34 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:42431 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeK3Nae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 08:30:34 -0500
Received: by mail-vk1-f196.google.com with SMTP id y14so927374vky.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 18:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GybPNpowQosWEQ8Uz6Fnm0hdyGhsMXH/2kYpCK7AZ8A=;
        b=V11bvIeMPvxfWjQFyrZnfcEnW7Z9UkP/RrQ5HyOEqG7JZdZyqLwVgIEKmeQXKogNFa
         Rcy+G2Oah5ZbrD2ss8PTvBg4vEgLlcsijqRuA7CX17uv+mWG/F7765vsWoQ3/5qI3eB0
         tDqJQbei2uc+iYCX3h+aQbq2ZkrqO03vceZeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GybPNpowQosWEQ8Uz6Fnm0hdyGhsMXH/2kYpCK7AZ8A=;
        b=JXyBVziGwuom35yLV8Uik7PfpgcZEKQGbbJxSb/bBOYduo/jg3l9ABNljqkib8syC4
         TZw0fk61u44JfOk4z4fxoOgdW2bPoJ/OqOmCCce0WqWw+GB9HQU1NHm4H0tD1e5do/Q2
         gtp5UxzgUIqLRWrE2kWdzy9KLkK1bKtt9CuRZGpKnzHwgr1s8DhbBSmJXA6urWuheSso
         qYrzzJENkU9hHNOu2MNwrRHuDYaA0V7dNxh4fN5xz1tPfdBxcoHuVuBCsM2FLOSOmnxU
         KvO9nSoTHJDnnbo6SgYuU1OpwsQHCS3rdnT7Mph88AmdEYkWkiocGVsOSCk4elS+p7eV
         HAQw==
X-Gm-Message-State: AA+aEWZXhWAId4l/kJmdaYPGupEWwVWN7ZwrwTBNFsUiFS5RKefrPQPz
        aAnOtfh2z2M55hIsAZzYW6SVer2XBbU=
X-Google-Smtp-Source: AFSGD/X4rofZlwT5iiZdtTyaQvmmPDvDAabUTPbGpQRxstI8rI1a5GB/afmxFZ9SLMQEyfhDVbxjJA==
X-Received: by 2002:a1f:9042:: with SMTP id s63mr1695357vkd.17.1543544574772;
        Thu, 29 Nov 2018 18:22:54 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id n200sm630828vke.44.2018.11.29.18.22.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 18:22:53 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id b18so939082vke.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 18:22:53 -0800 (PST)
X-Received: by 2002:a1f:1881:: with SMTP id 123mr1748214vky.40.1543544573175;
 Thu, 29 Nov 2018 18:22:53 -0800 (PST)
MIME-Version: 1.0
References: <20181130021840.75861-1-ryandcase@chromium.org>
In-Reply-To: <20181130021840.75861-1-ryandcase@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 29 Nov 2018 18:22:41 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WX5Dcs4a1puEf3_DO0x6di48T67buVGoacMneeJG2obw@mail.gmail.com>
Message-ID: <CAD=FV=WX5Dcs4a1puEf3_DO0x6di48T67buVGoacMneeJG2obw@mail.gmail.com>
Subject: Re: [PATCH v3] tty: serial: qcom_geni_serial: Fix softlock
To:     ryandcase@chromium.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Evan Green <evgreen@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 29, 2018 at 6:19 PM Ryan Case <ryandcase@chromium.org> wrote:
>
> Transfers were being divided into device FIFO sized (64 byte max)
> operations which would poll for completion within a spin_lock_irqsave /
> spin_unlock_irqrestore block. This both made things slow by waiting for
> the FIFO to completely drain before adding further data and would also
> result in softlocks on large transmissions.
>
> This patch allows larger transfers with continuous FIFO additions as
> space becomes available and removes polling from the interrupt handler.
>
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
>
> Changes in v3:
> - Reworded comment for clarity
> - Fixed mips compiler warning
>
> Changes in v2:
> - Addressed nits raised by Stephen
>
>  drivers/tty/serial/qcom_geni_serial.c | 56 +++++++++++++++++++--------
>  1 file changed, 39 insertions(+), 17 deletions(-)

Looks happy to me now.  Thanks and sorry for misunderstanding how
"active" worked on v2.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
