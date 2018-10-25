Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46090C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3162075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HrXTww0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3162075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeJYTun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:50:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34287 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeJYTun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:50:43 -0400
Received: by mail-lf1-f65.google.com with SMTP id n26-v6so6477970lfl.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 04:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pQuybqbBvnNwsXOTAGuS0DG+GY4NTtpSJsTobw7y1A=;
        b=HrXTww0bn7i/k5CeqjEUgfGfT9585qcdQ0hRu747371HHH1if5UfDTXnJ++VfRWhdO
         ZDvWet6ztdLWKNu1ISFqmcsDR2EdN3UyOl19WG7JI0Q3dGKO0tUJfcsds62gGjoR9oQm
         PrJ5QvCM77/i+4lYKfs4kQmKR6YOpfLfmmBec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pQuybqbBvnNwsXOTAGuS0DG+GY4NTtpSJsTobw7y1A=;
        b=mZAKDzDD20OoKvfxu0HQZCENmr3O+Z6omNxbF8JDzMmY8CNRUpbqU2Bdbz0P0VblCh
         MfDOmXDmNwDlBMzwFANsnFir62e4cRq1H4EQlMsssqCeqs22ctx+FHOK2iDyXKBTthJL
         YGzL29FceCAkLKmhDUhtHrTkeP7pBWw7hgIBPvMsHLSLvZKbKqkeyDMOCIhc9Xnnd3yP
         dt6aEfPxz1RgCjzrgoibqiJr9KDzM+kFepz8ehKHYC4goFZt8paXk+WNIqZjJz7HYn3J
         C3V4HVGpdhoLAH7JcWGk+Sl1YMElIPWXcrjT75LR4Rrwi3yDDE7A50NtMGzJbQ3jp7Qt
         GHqg==
X-Gm-Message-State: AGRZ1gK+JsYJ+VBKAM+3fWYW6V5iRdcXJcozOK0rzoIVBE18PUbLVwz5
        jxNLuyvyawGhj0nT///D3xRMEIqPQ8tvon3YAlOUjZrtNpg=
X-Google-Smtp-Source: AJdET5diUqL27KNq0Z39NewfCFtgIqL9RMVtLApYYnW8Z0ld08/rZeTO/vqVi67z4y9yK7ug1XT7u4Of2NfBbkDSsCI=
X-Received: by 2002:a19:9a0e:: with SMTP id c14-v6mr953477lfe.11.1540466301686;
 Thu, 25 Oct 2018 04:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <1540365564-30645-1-git-send-email-zhang.chunyan@linaro.org>
In-Reply-To: <1540365564-30645-1-git-send-email-zhang.chunyan@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Oct 2018 13:18:09 +0200
Message-ID: <CACRpkdb3uwW+UoeeivAP-+67kMKGD9dP0rh2nk=WTHhpgnkJ1A@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Conver sdhci_allocate_bounce_buffer() to
 return void
To:     Chunyan Zhang <zhang.chunyan@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Lyra Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 9:19 AM Chunyan Zhang <zhang.chunyan@linaro.org> wrote:

> The function sdhci_allocate_bounce_buffer() always return zero at
> present, so there's no need to have a return value, that will also make
> error path easier.
>
> CC: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>

Good catch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
