Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC37CC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7137E2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yf+J9fHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7137E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbeLDUrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:47:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:39114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbeLDUrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:47:19 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEF4E20851;
        Tue,  4 Dec 2018 20:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543956438;
        bh=zW2Y815AcZCf0dgxrKDpK82uj+u2eUm7+taADcR4F3g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yf+J9fHKQNJIzKa+yJgOcllqPKrKvbcWv1eDibC9JJhJbRYjnxEF+U7y5S+quThyo
         qwA52cmoNPrk0nyzKPGt4ErP5dPvVymrOEyzoa3XTNx7Z678P0CyZAFb57TLXJmVTc
         9qVh2UWs2DsnbqtJnB+/smDFq5PtQ5v54SR9Znl4=
Received: by mail-qt1-f172.google.com with SMTP id y20so19740274qtm.13;
        Tue, 04 Dec 2018 12:47:18 -0800 (PST)
X-Gm-Message-State: AA+aEWZTyLG/W9VE8HyqqGeqOq1pbsBlx8oZezUmAiE3S1cyetQla1r2
        fSJ/0ZJVsBXmYS7o/9iCjf/QmY5i62RkrqBpRA==
X-Google-Smtp-Source: AFSGD/U0v5VvRDsJZq3H0UgVtV9j/5z3guMvn0taHNIw1h5mWpwY6201yjtXxc4p2L+Rpns8t0VbXdVR62ttHa6k9jk=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr20489067qtd.257.1543956437975;
 Tue, 04 Dec 2018 12:47:17 -0800 (PST)
MIME-Version: 1.0
References: <20181114090027.7580-1-benjamin.gaignard@linaro.org> <CA+M3ks5m1=gsGqB55T4xSGtAQW9Ct3Fxqx-gbYg=GoNwoX6B-w@mail.gmail.com>
In-Reply-To: <CA+M3ks5m1=gsGqB55T4xSGtAQW9Ct3Fxqx-gbYg=GoNwoX6B-w@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 4 Dec 2018 14:47:06 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Em=7NeBCwkZyzmAfG8po-2E9SfO_Ukf0+h1CqH_3vxQ@mail.gmail.com>
Message-ID: <CAL_Jsq+Em=7NeBCwkZyzmAfG8po-2E9SfO_Ukf0+h1CqH_3vxQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Add support of STM32 hwspinlock
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 8:45 AM Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:
>
> Le mer. 14 nov. 2018 =C3=A0 10:00, Benjamin Gaignard
> <benjamin.gaignard@linaro.org> a =C3=A9crit :
> >
> > This serie adds the support of the hardware semaphore block for stm32mp=
1 SoC.
> >
> > version 4:
> > - add Linaro SoB
>
> Gentle ping on this series

Maybe you want to fix the 0-day error and resend.

Does adding the hwlock to the interrupt controller depend on this series?

Rob
