Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DB9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD372077B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ny7M77qB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD372077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387501AbeKOUxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 15:53:16 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45819 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbeKOUxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 15:53:16 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so13767792lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 02:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G0P6Of7tmguLZdiTxOr++KjXl7lh17z2dhTzH0WZGfg=;
        b=Ny7M77qB/jb/4gLILfcmHcrRC5Jr9gzeViFrXAAC6K6DxCgNHxqONOEb2QjoJPS47k
         nc7XJB8BvFU4SjUaUc1LMGRk4IpISPQJAEtE2ORopbg1e79QNUmTRFY02JuMXEU90dmR
         EcJx5XIqZMgWTfJWei7k0Bn7HdO18rpZu+UKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G0P6Of7tmguLZdiTxOr++KjXl7lh17z2dhTzH0WZGfg=;
        b=oq0vJ55OOeRDPgeqEeDdeP2eSSHadxOM5xKot8LiJQ5QceKOrBnpZHXqrp4RA+gLuU
         5+IFnrw6IYMGPJClBlcJYxNcrZ0CEqlk/dKykB6RdkoNXu3nWR57WY5FtnXhhmym0BwX
         igSwXQfyWUrE1rV1a3IRWvLcMyAPEzIxDQS9d11Ki4Pb+J801vlpj068/2ir1/cB/NU3
         r95e6DzrpOZ6+bjRR+gs/AsF2dbd+LRH16TR0R9AmbLY5KVN54Jw5PkLw2UwR1SEGowi
         z+JLjPKEBwxvpDRCAADruKKFmsvMsCOmiGgpTI4xuMhbMRN9iRn3InDzQUZEvwvMwfMG
         UoZA==
X-Gm-Message-State: AGRZ1gKyOj6/iP4Q+eNMOu3dfdQpwByzIAKpTfCkKxhpxRrzzf0Kc8R2
        ITXR6gl7kARd99FbSEF4iFikudZAdKJEoU/LSAlFhw==
X-Google-Smtp-Source: AJdET5dEeZEh5GzzxadNttU3SYzsNtX299b3j4RAbfhL7ErVNKoIqKQKaaLJIhJKKMOxTnK1Q+Urnrunr6tu2XknYYA=
X-Received: by 2002:a19:41c4:: with SMTP id o187mr3287078lfa.32.1542278756681;
 Thu, 15 Nov 2018 02:45:56 -0800 (PST)
MIME-Version: 1.0
References: <20181107201746.14705-1-jmkrzyszt@gmail.com>
In-Reply-To: <20181107201746.14705-1-jmkrzyszt@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Nov 2018 11:45:44 +0100
Message-ID: <CACRpkdb5=2iAaZfLfzuGm9EhHwZxXe4E7-yB28Dn3LAxnyszNg@mail.gmail.com>
Subject: Re: [PATCH 0/3] ARN: OMAP1: ams-delta: Post-GPIO-refresh cleanups
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     ext Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 9:16 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Janusz Krzysztofik (3):
>       ARM: OMAP1: ams-delta: Drop board specific global GPIO numbers
>       ARM: OMAP1: ams-delta: Drop unused symbols from the board header
>       ARM: OMAP1: ams-delta: Move AMS_DELTA_LATCH2_NGPIO to the board file

This series:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
