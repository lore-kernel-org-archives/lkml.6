Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600F8C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F9F267DA
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iDG6dQt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F9F267DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934293AbeFZJah (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:30:37 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:41032 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933680AbeFZJad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:30:33 -0400
Received: by mail-io0-f195.google.com with SMTP id k16-v6so12564533ioa.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fl2MpFEGWGkaSJmXtrwUyVSXVcH5opogVHZk2v2SIQ4=;
        b=iDG6dQt/AfrQ+1ZWbcYfX7LDfD3JhqdV4kKkMXj7gNChcNAIgEf4SmI0n1JBv+buDc
         5iIeU4t1sZBPtJbUNJnVNSnd+ldywHu9+IorHhq9MbD/qI+c0EQnd3L21GRLfgb+CAOp
         wYeDyY9D8i7e1anwnoeiIOHHgrnjR4XFn5OOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fl2MpFEGWGkaSJmXtrwUyVSXVcH5opogVHZk2v2SIQ4=;
        b=iFmRuAQu0KAZVwrYVdcfIyb/c6DSCEFku+iL6tQnk4CmehzAxRnPLTM2h/VZluD1Zn
         ERzeHpCKqHqh3UzqfRZNND3ZMWkQCyPVn6UspX27dbdmPVDy7QIijC0YfEYQufGo++aV
         rBvWNtDHQFjaU+GEIxQinWlZO5qrwq5TwckOObjsh+ezNZ+8gyZ1h+NRL3r9xF+zl2Gn
         6YOiA6lhiJd7jJoNoTAKBxZVudalSLDGQfOGvhQV0X0s3SfhNCeSh8LEcAVRQgk20Y+e
         SlmXvG8pWPIWS125+l033XESaWg5ArJQZe7rEAbvIvzNQvCxlhTzwiWXk5GTyowNLfUl
         KKaQ==
X-Gm-Message-State: APt69E2ZKS90vkn0jbf3444xov6abBWNacRGH9H3xFxv0CLIbo3GxxKe
        f/y8Q7ZEuKgeDVsFIfxBxX+9JHHiThB4gRc16nWrFw==
X-Google-Smtp-Source: AAOMgpdgNzVOv+SbdykvDSzV9IC3k1S/TCjE9YQ1oCrDFOkTXtntEj+CuxWvCSSjDUA6SHiE1SB5bDfSAOnDctcSyAM=
X-Received: by 2002:a6b:1902:: with SMTP id 2-v6mr545886ioz.304.1530005433076;
 Tue, 26 Jun 2018 02:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com> <1528235011-30691-20-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1528235011-30691-20-git-send-email-suzuki.poulose@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Jun 2018 11:30:21 +0200
Message-ID: <CACRpkda17Txr4X=En8HUeE6z6a5WQOVXy8HObbKy7sOJ1V-DUg@mail.gmail.com>
Subject: Re: [PATCH 19/20] dts: ste-dbx5x0: Update coresight bindings for
 hardware port
To:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        mathieu poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, arm-soc <arm@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        matt.sealey@arm.com, john.horley@arm.com,
        Charles Garcia-Tobin <charles.garcia-tobin@arm.com>,
        coresight@lists.linaro.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, mike.leach@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 11:45 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> Switch to the new coresight bindings
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

I think I was requested in another mail to hold back applying this
patch until it's been discussed.

I will apply once Mathieu (etc) ACKs the series.

Yours,
Linus Walleij
