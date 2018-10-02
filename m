Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430C4C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094C8206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MBfsT2/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094C8206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeJBTed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:34:33 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36059 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbeJBTed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:34:33 -0400
Received: by mail-it1-f196.google.com with SMTP id c85-v6so3413605itd.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 05:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ksmGJD08Ey5q2A4EhjIeV7maWIK5gZq+9o7pe2CR9Bk=;
        b=MBfsT2/h9l2o/lpmI9rOxzm8t2zobwWMC+8RlhVlxFYMthPZyNLMYNY21IJFIRWz6U
         EpUXobCLkzgxstvJmZY6k1RhOVWG3xW8fc4IDqk/TtlLQZMO3zqdQmpkJxQjQaZ/gMDW
         7ICrxk3IeNQirpJIETi8kTTjha5rXTFc/DBEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ksmGJD08Ey5q2A4EhjIeV7maWIK5gZq+9o7pe2CR9Bk=;
        b=YEH2cH+PAfAuiEGebZHw9shHw39Eu+aAhoJW+qqyVAhhY/hKCcjS37jSYN83KUyA/M
         Wj75bFQUlMalILcRbs6fgNTQUrjNm9kEOpgP1GVCFmWdUXJm2EqJbSahbujWrA+ygt7n
         pBFg0YrSqjp6ruqV2kocwYgxTee6tDH50cNrCIQdHw+VHCn4hMotWTbWeP4QXwsQWFUx
         R6gf4ACDrxyRPKLAfo285HC20nwf2dMERt7/kJPOCkwLCVWh8UPZPix0OWgb17X8tahk
         Oaurz4vedWTI1K9ByQb30x8aA5Qi1C26xRNE6N8Rbii+WQCMcRGlKOlm5Df2sJ84Fw5W
         ZaBQ==
X-Gm-Message-State: ABuFfogbnKtyMIhwv8h0uwdcDTaPihjz4KXcGU2zw7+tii7qsjfm+kGF
        DpbVTDf30ZG8PGFsgKlYRL6MwYYuPPfNeSEXF1F2Gw==
X-Google-Smtp-Source: ACcGV63Utwr4rH6t7Vg5c6WxAKVj7AQfhD3S5hG/uVM4kMWE3ctm0snn4e5Vj98HkgezFnXa/c/EGfKs8vTFClDlrbw=
X-Received: by 2002:a02:2505:: with SMTP id g5-v6mr11686371jag.112.1538484681116;
 Tue, 02 Oct 2018 05:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180921103604.13361-1-ricardo.ribalda@gmail.com>
 <20180921103604.13361-2-ricardo.ribalda@gmail.com> <153803107307.119890.10052910965015646333@swboyd.mtv.corp.google.com>
 <ffe11a8c-368b-8c74-54a7-a088c3997032@kernel.org> <3e07cab8-0f3e-7474-8f6d-e6bb16e8f998@codeaurora.org>
 <5aea282d-6fc9-cd70-cec4-10f28aa819b9@codeaurora.org> <CAOZdJXUUWUWHzus+3sbEXbW_q92e+SSzTQJCqCyQp6Y6_HOo3g@mail.gmail.com>
 <D3E6F4C4-E1C4-4D88-B118-878576BF5281@gmail.com> <CACRpkdawwrpEe6AAfdaxw6OMFXkCnq0gpznk1Up5p1=Wigx_2g@mail.gmail.com>
 <CAPybu_1P-RWCP8yjQKkFYAX11KtYGhAfASY24Q_NZ19PD09gxA@mail.gmail.com>
 <CACRpkdaN5G4ephY+6BPLRF+aUrO4-sPa+2erRYrwTGwPBwu8fw@mail.gmail.com>
 <CAPybu_33WNiCdkwgNtkiTP2PL+9ai85Z2LiMB6yqNZrV5JdmXw@mail.gmail.com>
 <CACRpkdaccTSqpKQeUc1c6UEMo+fZmB+w0BQJL--gubrLMmKSgw@mail.gmail.com> <aa06e450-84a7-11f9-3972-08f1c9dbd1c4@kernel.org>
In-Reply-To: <aa06e450-84a7-11f9-3972-08f1c9dbd1c4@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Oct 2018 14:51:07 +0200
Message-ID: <CACRpkdbBOHwgy_Xp3UG4bW4vLnVhOAgY+97Rs-ANJjve+cS1hQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: Show correct direction from the beginning
To:     timur@kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        jhugo@codeaurora.org, Stephen Boyd <swboyd@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 2:26 PM Timur Tabi <timur@kernel.org> wrote:
> On 10/2/18 2:38 AM, Linus Walleij wrote:
> >> But as today the only driver that seems to be using valid_mask is msm,
> >> so perhaps a hack is something better and then when we have a second
> >> driver that requires it we figure out the real requirements. But it is
> >> definately your decision;)
>
> Please note that MSM is supposed to be the *first* driver, not the only,
> driver that needs valid_mask.  So let's not make any code changes that
> limit this feature to the MSM driver.

I just recently encouraged Thierry to reuse this for the Tegra186
driver:
https://marc.info/?l=linux-gpio&m=153787164826821&w=2

Yours,
Linus Walleij
