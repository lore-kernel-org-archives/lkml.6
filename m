Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF4FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341AC20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341AC20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeKGWMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:12:37 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37463 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbeKGWMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 17:12:36 -0500
Received: by mail-qk1-f193.google.com with SMTP id 131so20461107qkd.4;
        Wed, 07 Nov 2018 04:42:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y55hNUlpPoJRfkqdR0AEOQOUS0jEFkuQSDG73K2n+XY=;
        b=hsnu8elt8bdeRgwAkAzxGyegY7EUrz866pfzu9bPw/VDKlmWkHJ6CEFuc0/bgfRxgd
         MRTLWvFycA2g9kygYcXXm0YQ6m460pqLYyiez5hoeuXGLwa5KcOFDHpLVr35vqju3q7E
         7oaVg2diPrj6eVf2C75I6dEK44jzrIJ1/WJ9ywSLT9bIvqD4vCO7eCixj3Xlhz0LASWZ
         LB3T6TDJLox0n7I9NSfGnugRWVe2nCXGN4zEOKtRQtTRWI1mzm6UX2QENjADV3vfRiMF
         Y2HP7JlNDc0DkfNwEMmvF79bLM6GqgbMoQ84Jr5Aj2/WzU3bom4LL7M0gjRm7kYsa8c0
         dpOA==
X-Gm-Message-State: AGRZ1gLYVrmLWBk/KDFu63SPpiLSVjok50hvlXgarGKPMlkWzvHssjFX
        amrbI+RwdOUbStKP1D00SbYCcsoYIYq5pPXUWNI=
X-Google-Smtp-Source: AJdET5cFtz12ZghAbOJendtz8NkgaL20s1kPDF1y4ppDlirIzgVS8KX7R7LRRxVWzGzM8AaFw5DoXIqff0t6t7qzW8Y=
X-Received: by 2002:ac8:1d11:: with SMTP id d17-v6mr1383108qtl.343.1541594112361;
 Wed, 07 Nov 2018 04:35:12 -0800 (PST)
MIME-Version: 1.0
References: <20181107003250.5832-1-elder@linaro.org> <20181107003250.5832-13-elder@linaro.org>
In-Reply-To: <20181107003250.5832-13-elder@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 7 Nov 2018 13:34:56 +0100
Message-ID: <CAK8P3a2X1zstSWP89uDxyf+rvyzzDY98_cvE4fzc-ZGbyVz23w@mail.gmail.com>
Subject: Re: [RFC PATCH 12/12] soc: qcom: ipa: build and "ipa_i.h"
To:     Alex Elder <elder@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Networking <netdev@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:
> +config IPA_ASSERT
> +       bool "Enable IPA assertions"
> +       depends on IPA
> +       default y
> +       help
> +        Incorporate IPA assertion verification in the build.  This
> +        cause various design assumptions to be checked at runtime,
> +        generating a report (and a crash) if any assumed condition
> +        does not hold.  You may wish to disable this to avoid the
> +        overhead of checking.

Maybe remove this from the submission.

> +#define ipa_debug(fmt, args...)        dev_dbg(ipa_ctx->dev, fmt, ## args)
> +#define ipa_err(fmt, args...)  dev_err(ipa_ctx->dev, fmt, ## args)

These macros refer to variables in the caller that are not passed as arguments,
which is generally a bad idea. They also trivially wrap a standard kernel
interface, so better just that directly.

> +#define ipa_bug() \
> +       do {                                                            \
> +               ipa_err("an unrecoverable error has occurred\n");       \
> +               BUG();                                                  \
> +       } while (0)
> +
> +#define ipa_bug_on(condition)                                          \
> +       do {                                                            \
> +               if (condition) {                                \
> +                       ipa_err("ipa_bug_on(%s) failed!\n", #condition); \
> +                       ipa_bug();                                      \
> +               }                                                       \
> +       } while (0)

According to a discussion at the kernel summit, we should generally
try to avoid BUG() as it rarely does anything useful: it crashes the
current task, but in a network driver that usually means killing the
entire kernel since you are not in process context.

Try questioning each one to see if it can possibly happen, or if the
code can be rewritten in a way to guarantee that it cannot.

If continuing after the bug was detected does not cause a security
hole or permanent data corruption, you can also use WARN_ON()
or WARN_ONCE() (without a wrapper).

> +int ipa_wwan_init(void);
> +void ipa_wwan_cleanup(void);
> +
> +int ipa_stop_gsi_channel(u32 ep_id);
> +
> +void ipa_cfg_ep(u32 ep_id);
> +
> +int ipa_tx_dp(enum ipa_client_type dst, struct sk_buff *skb);
> +
> +bool ipa_endp_aggr_support(u32 ep_id);
> +enum ipa_seq_type ipa_endp_seq_type(u32 ep_id);
> +
> +void ipa_endp_init_hdr_cons(u32 ep_id, u32 header_size,
> +                           u32 metadata_offset, u32 length_offset);
> +void ipa_endp_init_hdr_prod(u32 ep_id, u32 header_size,
> +                           u32 metadata_offset, u32 length_offset);

I'm surprised to see many functions that don't take a pointer
to an instance as the first argument, which often indicates
that you have global state variables and the driver won't
work with multiple hardware instances.

      Arnd
