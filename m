Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58F3C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 05:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E19D21EF3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 05:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYOHAjKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E19D21EF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751651AbeGGFwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 01:52:15 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43987 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbeGGFwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 01:52:14 -0400
Received: by mail-oi0-f66.google.com with SMTP id b15-v6so27234444oib.10;
        Fri, 06 Jul 2018 22:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ltT1ZmzWjXkWj6cAUCCP+j2oHaRusXPyd/CwjofEUNA=;
        b=EYOHAjKrHMXRgTd+CPJXj7brrVwp8zUDgc8UxBWozmLt8unXOich4rctlF5AGcePcr
         Ix83BJ3or1PArnVfYDuR0omOb4ruZqsT7o9s5HqjXY3tjOnPQXvG/ahzQ/PiuPa42Qir
         U5V2V4umfGwemKhb3zaduVnfF3O/jR3OAxEpDyCyqdvMUaeTS7Pm+66UMnOMvuTYnwnw
         tbMICQ32F+VJSUQMUJY22ZhgwL4OfYefWpI6WcOh/E5+CsCHyEPimQZzahyGUAYB2DkT
         zNNRz1EBkXEo/xGbnnO3zMT4wnT8DkzMQxopyY3HgHVXgnq1Uhxj74VAc+JKW9/6clll
         Fi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ltT1ZmzWjXkWj6cAUCCP+j2oHaRusXPyd/CwjofEUNA=;
        b=igx5g1o78WVJjSEfrUQ2E+eYysnnSBUy0Q5Pg+9281yr+ZPuUiY2aRAzwfnQaW24fV
         FNPlFZijdN1XEAMmtsRO1JfkDkTgGT+hP9H0o6otWn86W9xqXrPD8HgX6oN03bMNKU2W
         6uyTSmw/rO7rIqVjfrdI+W6CNInT/7ApkNaD3WGl0F2+AJxv4p9r8bn1X3vpAmjuGBuM
         BZ20Px3um1tf6byZLEDsevJTEwAGU5utAGA5HBGpBuGHV8ZDJbKTi+IOUZafFp8CCANg
         n5n+v6tFkfph1AJM6sM4D++kYjgdHAtKk1e7C8Q9iifEUmBNMq3Vs6cnXW6L14fuL4mE
         BnLg==
X-Gm-Message-State: APt69E3DSfGN4XkyFgFuFy7AzNlyr/n3zZjKdsn/83w05nhu0bwl6ohp
        mlYM8WdBDl1XIk1dxwML/nQGhKAijTZoLLgijuA=
X-Google-Smtp-Source: AAOMgpcBS0nIswQYdPDG9W67LZnKxemyWPBsjkS58CIANLmDkCfzElkrSgGPw6FM64yt5Uj2iIXNLUGpWn25wI0XjKU=
X-Received: by 2002:aca:3407:: with SMTP id b7-v6mr14046356oia.345.1530942733381;
 Fri, 06 Jul 2018 22:52:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:9a35:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 22:52:12 -0700 (PDT)
In-Reply-To: <20180621063338.20093-3-ganapatrao.kulkarni@cavium.com>
References: <20180621063338.20093-1-ganapatrao.kulkarni@cavium.com> <20180621063338.20093-3-ganapatrao.kulkarni@cavium.com>
From:   Pranith Kumar <pranith.foss@gmail.com>
Date:   Fri, 6 Jul 2018 22:52:12 -0700
Message-ID: <CADYwmhHdTuK-z4GcGCYypYo2dvvPj7udihPcMmTkHTSU2fOWWw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU driver
To:     Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Will.Deacon@arm.com,
        mark.rutland@arm.com, jnair@caviumnetworks.com,
        Robert.Richter@cavium.com, Vadim.Lomovtsev@cavium.com,
        Jan.Glauber@cavium.com, gklkml16@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ganapatrao,


On Wed, Jun 20, 2018 at 11:33 PM, Ganapatrao Kulkarni
<ganapatrao.kulkarni@cavium.com> wrote:

> +
> +enum thunderx2_uncore_l3_events {
> +       L3_EVENT_NONE,
> +       L3_EVENT_NBU_CANCEL,
> +       L3_EVENT_DIB_RETRY,
> +       L3_EVENT_DOB_RETRY,
> +       L3_EVENT_DIB_CREDIT_RETRY,
> +       L3_EVENT_DOB_CREDIT_RETRY,
> +       L3_EVENT_FORCE_RETRY,
> +       L3_EVENT_IDX_CONFLICT_RETRY,
> +       L3_EVENT_EVICT_CONFLICT_RETRY,
> +       L3_EVENT_BANK_CONFLICT_RETRY,
> +       L3_EVENT_FILL_ENTRY_RETRY,
> +       L3_EVENT_EVICT_NOT_READY_RETRY,
> +       L3_EVENT_L3_RETRY,
> +       L3_EVENT_READ_REQ,
> +       L3_EVENT_WRITE_BACK_REQ,
> +       L3_EVENT_INVALIDATE_NWRITE_REQ,
> +       L3_EVENT_INV_REQ,
> +       L3_EVENT_SELF_REQ,
> +       L3_EVENT_REQ,
> +       L3_EVENT_EVICT_REQ,
> +       L3_EVENT_INVALIDATE_NWRITE_HIT,
> +       L3_EVENT_INVALIDATE_HIT,
> +       L3_EVENT_SELF_HIT,
> +       L3_EVENT_READ_HIT,
> +       L3_EVENT_MAX,
> +};
> +
> +enum thunderx2_uncore_dmc_events {
> +       DMC_EVENT_NONE,
> +       DMC_EVENT_COUNT_CYCLES,
> +       DMC_EVENT_RES2,
> +       DMC_EVENT_RES3,
> +       DMC_EVENT_RES4,
> +       DMC_EVENT_RES5,
> +       DMC_EVENT_RES6,
> +       DMC_EVENT_RES7,
> +       DMC_EVENT_RES8,
> +       DMC_EVENT_READ_64B_TXNS,
> +       DMC_EVENT_READ_BELOW_64B_TXNS,
> +       DMC_EVENT_WRITE_TXNS,
> +       DMC_EVENT_TXN_CYCLES,
> +       DMC_EVENT_DATA_TRANSFERS,
> +       DMC_EVENT_CANCELLED_READ_TXNS,
> +       DMC_EVENT_CONSUMED_READ_TXNS,
> +       DMC_EVENT_MAX,
> +};

Can you please provide a link to where these counters are documented?
It is not clear what each counter does especially for the L3C events.

Also, what counter do you need to use to get L3 hit/miss ratio? I
think this is the most useful counter related to L3.

Thanks,
--
Pranith
