Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995A0C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545012087C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="APRU+VPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545012087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754314AbeGCFok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 01:44:40 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33171 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753987AbeGCFoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 01:44:37 -0400
Received: by mail-it0-f66.google.com with SMTP id y124-v6so2750474itc.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 22:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mcaquU+1e1r7p4X4LXexkFMycZ+W3UGU2XEsKtLHsec=;
        b=APRU+VPvyIWsEVnslx9SIAJ6WS/uS7pL457eTdviGYcpW0EYNqDSEyozzUSnl5fvI7
         Jp8ziky2BzRZVuqVhR1XweTvXNjMn6hOIZUO9BtP6cIhITivz5/MxlbZ0YjVfMOty66o
         GkDYnD6tADAz/GQdxWuYm3G5/SWeXrfoSMbf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mcaquU+1e1r7p4X4LXexkFMycZ+W3UGU2XEsKtLHsec=;
        b=QvyIm3N4RfOFBMgrH9SUDHQnt31QBQak+aWhH5qMrfC94jOs/S6/z2YP19CwfDfcPA
         SmCQ6ytBN4z3MP1AsuT+BjcClipomnQNOTw56JywE/IyTLgkVTRidSx0WSPc7HVVUhFG
         dUwe6y499H6+KtHA54IDBD7aD6ODLeNaJCq1UVQwL6/0vuSsZpX2ilVaEDDukb61UQSt
         ShvGnqiJgzNb+oLqbDgDX+79XJJovdSS1mOdmT9zZjT160Guf+BToZpoklPDOWdwpdfI
         p3KdSyLPItaRT2Lqyp9EI9+aTJAEkPbdd+IsXNclThUoY2vaZwlyGpSIGdC5sQ//PGCY
         WXzA==
X-Gm-Message-State: APt69E3ZD1+JDoxzPvigEyJajaw7uZCXbIL9vsCTg8zGYxuhLLMYHAY/
        SLKrJvQevID5YHhhfNUgPd/u3CEl2+hoGOEwVILvmA==
X-Google-Smtp-Source: AAOMgpdrAexNR1c7J606j3IFMQiyB6Nf8BPpQW5oxNgW7jrtDdZ5zWMGRzYAFa5+LqTWeEc3EcagIeScWn6OsxS3v6s=
X-Received: by 2002:a24:69cb:: with SMTP id e194-v6mr13060184itc.102.1530596676739;
 Mon, 02 Jul 2018 22:44:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 22:44:36 -0700 (PDT)
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 3 Jul 2018 07:44:36 +0200
Message-ID: <CAPDyKFpy8rpjRTBsHUFa_L0M_C=vH+6qjq=Kxdn+0j+T5NNSMQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/26] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lina Iyer <lina.iyer@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael,

On 20 June 2018 at 19:22, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Changes in v8:
>  - Added some tags for reviews and acks.
>  - Cleanup timer patch (patch6) according to comments from Rafael.
>  - Rebased series on top of v4.18rc1 - it applied cleanly, except for patch 5.
>  - While adopting patch 5 to new genpd changes, I took the opportunity to
>    improve the new function description a bit.
>  - Corrected malformed SPDX-License-Identifier in patch20.

There have only been a minor comment from you at patch3 (about
squashing it with patch21), with that fixed and assuming there are no
further comments - would you like me to collect the changes and send
it to you as a pull request?

[...]

Kind regards
Uffe
