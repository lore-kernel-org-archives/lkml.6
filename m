Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE97FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B16321925
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDmzcwac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B16321925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933120AbeGCHev (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:34:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932517AbeGCHes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:34:48 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 429F224D8A
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jul 2018 07:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530603288;
        bh=u3zbrA98NF5fIHVxVyqlklfjH7gStWjHGxbZOipPJvM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uDmzcwacsEPgmiuSeQUG/ZFLBK7GAwoA+AJJQRGZ5Uxa456j/dQP0Br+B9EV+PnZn
         DK5GbLYmYI+DFlVkS5RYHdChJXmov1NhayEzBhgPdsTQNufo6QY45sgMTxVZ6D8KGq
         3cKf2ogUzm/8qUgtWPdf3r3BQE+Ict+PjROsqIBU=
Received: by mail-ed1-f52.google.com with SMTP id e19-v6so876975edq.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 00:34:48 -0700 (PDT)
X-Gm-Message-State: APt69E3VzpyBdLqIhhhdiQzG60j8MR8MUZ2uiDgFXA3vHhzC+rVJqOfb
        SbdwCeOwdttvV3nBa8hxSffOIvflKJCDUtZfcE9e5Q==
X-Google-Smtp-Source: AAOMgpdmkHY32U5Saumkq1qXA/rvBV5yFPbhWA5fiB/QX9Azza8wrtO4w9QILPW5iKfDxcdDoC0IFcIZ9WVQ/iY/F6o=
X-Received: by 2002:a50:80e6:: with SMTP id 93-v6mr24368244edb.252.1530603286720;
 Tue, 03 Jul 2018 00:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1527225682.git.viresh.kumar@linaro.org> <e4504945d2b684fae2850bbcf03a6d02917a8c8a.1527225682.git.viresh.kumar@linaro.org>
In-Reply-To: <e4504945d2b684fae2850bbcf03a6d02917a8c8a.1527225682.git.viresh.kumar@linaro.org>
From:   Shawn Guo <shawnguo@kernel.org>
Date:   Tue, 3 Jul 2018 15:34:31 +0800
X-Gmail-Original-Message-ID: <CAAQ0ZWRsroAAKRyxdd9ZCreriAjdBecmJy01sRy+6i_iQsMKgw@mail.gmail.com>
Message-ID: <CAAQ0ZWRsroAAKRyxdd9ZCreriAjdBecmJy01sRy+6i_iQsMKgw@mail.gmail.com>
Subject: Re: [PATCH 2/6] arm64: dts: freescale: Add missing cooling device
 properties for CPUs
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     arm@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        chris.redpath@arm.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2018 at 1:40 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The cooling device properties, like "#cooling-cells" and
> "dynamic-power-coefficient", should either be present for all the CPUs
> of a cluster or none. If these are present only for a subset of CPUs of
> a cluster then things will start falling apart as soon as the CPUs are
> brought online in a different order. For example, this will happen
> because the operating system looks for such properties in the CPU node
> it is trying to bring up, so that it can register a cooling device.
>
> Add such missing properties.
>
> Do minor rearrangement as well to keep ordering consistent.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied, thanks.

Please use my kernel.org email address for future patches.

Shawn
