Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FE9C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCBF2489F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1nQ8I+om"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDCBF2489F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752978AbeGBUZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:25:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752584AbeGBUZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:25:53 -0400
Received: from mail-io0-f173.google.com (mail-io0-f173.google.com [209.85.223.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F5C224EF3;
        Mon,  2 Jul 2018 20:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530563153;
        bh=qKrGf1LDglKcppUO4kblux23nzEWaCFh7QENOHumQhA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1nQ8I+om2CBnFbPFVYT0q2dJm1N/ZfLeQdy01CCETL5gZwhUnN1dsWrZgoFxxZiaH
         lRz5facKbBwWapSXYCY1svqoZXIDpH2VwvwQnS1xFWvvZFVj4ihg0mf7fuaOnXLJJV
         Zv8lKjpxjCDh79YPHmLAIpL6z5zVbHZC7s7zAzXw=
Received: by mail-io0-f173.google.com with SMTP id q19-v6so8482872ioh.11;
        Mon, 02 Jul 2018 13:25:53 -0700 (PDT)
X-Gm-Message-State: APt69E11eQBxBk7a3sOmNfo8tWeO68FKMOpvlAtcaTMqBueCuaZwjmsS
        DJqqvEEEHSlC+ZKFwTYbGoEd1GM3PRbVNa9y8g==
X-Google-Smtp-Source: AAOMgpeXnsD3gZANIJrLuhCaiwz2TfMz/0Tm5hHhDti0V2MazX5WI/IkICEAD4GgrQyl+5B23UJmvVdpZyCSSXpLW4A=
X-Received: by 2002:a6b:6403:: with SMTP id t3-v6mr23424293iog.111.1530563152757;
 Mon, 02 Jul 2018 13:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1527244200.git.viresh.kumar@linaro.org> <f8a4e5c3062397736475ec599de730206846cb9b.1527244201.git.viresh.kumar@linaro.org>
In-Reply-To: <f8a4e5c3062397736475ec599de730206846cb9b.1527244201.git.viresh.kumar@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 2 Jul 2018 14:25:40 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJRKMREfJ8LoDfuda8BU3g5Eq1AX5cPZGzO3uN3vUhrAQ@mail.gmail.com>
Message-ID: <CAL_JsqJRKMREfJ8LoDfuda8BU3g5Eq1AX5cPZGzO3uN3vUhrAQ@mail.gmail.com>
Subject: Re: [PATCH 12/15] arm: dts: highbank: Add missing OPP properties for CPUs
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        ARM-SoC Maintainers <arm@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        chris.redpath@arm.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 4:32 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The OPP properties, like "operating-points", should either be present
> for all the CPUs of a cluster or none. If these are present only for a
> subset of CPUs of a cluster then things will start falling apart as soon
> as the CPUs are brought online in a different order. For example, this
> will happen because the operating system looks for such properties in
> the CPU node it is trying to bring up, so that it can create an OPP
> table.
>
> Add such missing properties.
>
> Fix other missing property (clock latency) as well to make it all
> work.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/boot/dts/highbank.dts | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>

ARM-SOC maintainers, Please apply this.

Rob
