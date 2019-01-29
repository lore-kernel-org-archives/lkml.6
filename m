Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A87C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5139A214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548774967;
	bh=4NCiHZKgNSMpmQtSj+IGKHh8nlqC8bRt2/41yc9jj8E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=m9ZWXNmfGpu2knmGRpakpW0GjtXIcX0AyqKPKCcTaGHfDSTI7xb0m0VxpbGcry+/r
	 BMYY+ZTf/bY7FlwsJuM7p3MtyQBCLRENMAyDCG6lv9bnkuj5twDt7YA0U94WaDFyw5
	 PVUJuRz7hvnXL/a0PoOq8g+xTpzKnxH6Blo98hgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfA2PQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:16:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:51932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfA2PQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 10:16:05 -0500
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 970E921852;
        Tue, 29 Jan 2019 15:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548774964;
        bh=4NCiHZKgNSMpmQtSj+IGKHh8nlqC8bRt2/41yc9jj8E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TmH1jqxwzKYulUw01J1To1zwwv8zNJnizv7EX2sbj+UYXkx0jJgXcAEB03qe6hF0d
         YUaq3NwwDIBKe9AN6pEs1ZiNE32Ai2d7HbFs7iDv/NOt5SYmE29GgqwLrSckpf0r1P
         Nro++Rp22bMKUugkwyRy4CkelTMSjL3ebjoKAKeQ=
Received: by mail-lf1-f53.google.com with SMTP id a8so14893501lfk.5;
        Tue, 29 Jan 2019 07:16:04 -0800 (PST)
X-Gm-Message-State: AJcUukfOedYIqr7S7X1LKYaKnZ3neBuOFQSEooLFv6Cj39Q0nXCi3+r9
        4eRuFY9lCtoDUuo0eEUYp2MwRsK+DNU6QMeHE08=
X-Google-Smtp-Source: ALg8bN53ZIctZPdAG12671uYZPyVQOuDf+rCJtTBciiq0EEM59Mzj/M/pL3brVxYKKmLsDuAur030T+Hml3dOkRIwjU=
X-Received: by 2002:a19:4948:: with SMTP id l8mr10240023lfj.156.1548774962763;
 Tue, 29 Jan 2019 07:16:02 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190128192155eucas1p13fa8616c0da161cd2f041ba241dba3d5@eucas1p1.samsung.com>
 <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com> <1548703299-15806-9-git-send-email-l.luba@partner.samsung.com>
In-Reply-To: <1548703299-15806-9-git-send-email-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 29 Jan 2019 16:15:51 +0100
X-Gmail-Original-Message-ID: <CAJKOXPeN78Gpv0JM1onp3hYq0ZCVamh9wog_Vf_aJoOJFTHQbA@mail.gmail.com>
Message-ID: <CAJKOXPeN78Gpv0JM1onp3hYq0ZCVamh9wog_Vf_aJoOJFTHQbA@mail.gmail.com>
Subject: Re: [PATCH 8/8] arm: config: exynos: enable DMC driver
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, myungjoo.ham@samsung.com,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Commit title/subject prefix:
ARM: exynos_defconfig:

On Mon, 28 Jan 2019 at 20:21, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Enable driver for Dynamic Memory Controller in Exynos SoCs.

"Enable driver for Dynamic Memory Controller dynamic frequency and
voltage scaling in Exynos SoCs".

Best regards,
Krzysztof Kozlowski
