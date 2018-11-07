Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43539C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100422086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100422086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeKHHY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:24:27 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33848 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeKHHY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:24:26 -0500
Received: by mail-qk1-f194.google.com with SMTP id a132so23280855qkg.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 13:52:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RzHpnFGbmLZ5VwzZe7EkETPzozPMvBGuhN5RhH5MRlY=;
        b=j4C3XLtl1Mcm9MbdC6jjJPbdbb6T6uLk1T/PgeLE48FSUYt8PdqlR+7QlRwbdpLUhc
         IQrZw9emHaR3sMA9W7h8GszsV4uSzbk22ea+JSx3eFeTp0hFsWoFTROSj8NcqJa87bq4
         O+KuvYWtp+o3qC/xRBLbuqA36eP3CtmYpa51YoBTGEi+jPxo3M3skg4xddI3TK9rDOvS
         NmzVXhzd/bUsMswlx0aqaHg6RenIAalnR7hSVQKKieun5AdXQFv7zCEfDSDX4UKV48sk
         18A18DDAIos2DqIZHUWdQJ7SHrk8LpCmMdqzIMLZnr4BtHz1vury31k1Ssa0FRaOukVM
         C8Pw==
X-Gm-Message-State: AGRZ1gL2AnHHMEPCfTRrndEZ2JfWhu9COnqstehkT/UZb+CKkX0dq1wV
        aJLzU/RmdqfoTH+a/Lg7TAwUflOOLHO/BCO/04Jdnw==
X-Google-Smtp-Source: AJdET5dR8Ca74swmRJKzMNZNOX66fZeXofjpTw8Mlt/JifIe3V+OAfDY2fDJEFkZzB0WqQK2BpdlE/GrttuRee9LeMc=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr1883695qkf.330.1541627527950;
 Wed, 07 Nov 2018 13:52:07 -0800 (PST)
MIME-Version: 1.0
References: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr> <6eb79d2e-1857-39b5-90f5-29bc13bce16a@free.fr>
In-Reply-To: <6eb79d2e-1857-39b5-90f5-29bc13bce16a@free.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 7 Nov 2018 22:51:51 +0100
Message-ID: <CAK8P3a1QE1Vr8_3m1=dhgjWkn9HLYwpmNUVZ4+fVZdRwpX=ZEQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Regenerate arm64 defconfig for current kernel
To:     marc.w.gonzalez@free.fr
Cc:     arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 9:39 PM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> Arnd, Olof,
>
> The following patch series was sent to arm@kernel.org
> but the messages bounced because the SMTP server is
> currently blacklisted. Can you get the patches through
> the LAKML mailing list?

Yes, that worked fine, and they ended up in the right folder for
me because of the to:arm@kernel.org recipient.

All patches look good to me, thanks a lot for doing this!

One point about the changelogs: in some of them you just
list the commit that changed things, but don't explain what
the impact of that commit was (symbol dropped, always
selected, etc). I always like to see changelog texts in full
sentences, so if you can spend a few more minutes on this,
would you send a v2 with that changed?

       Arnd
