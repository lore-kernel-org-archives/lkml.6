Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DABC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7878C20855
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="esDv+HWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbfA3XOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:14:16 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44875 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfA3XOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:14:14 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so480828pgr.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 15:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:from:message-id:cc
         :references:user-agent:to:in-reply-to:date;
        bh=Z2kUd9T1hLZPhMu+tVqGLrjwPLXqPCCDErL6IvJu4J4=;
        b=esDv+HWVINM0oMkbc14eE/yrjVCiFk/Rm0xqyfds7kI7hV+wF09iS2fYL+yupiezg5
         OFiOZJ49b8wbyTHK+4trwKBUZBxb3LXmByuZwmclEuTLz2EjTAWWmPKTdpGgcBJBmSXm
         yT+vSbNpt/i63O1NlCWIZbQqysvDq39GhNJrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :from:message-id:cc:references:user-agent:to:in-reply-to:date;
        bh=Z2kUd9T1hLZPhMu+tVqGLrjwPLXqPCCDErL6IvJu4J4=;
        b=n8VRnTpi6HcxnUAS6oIj/glH1rz2hQcwTXaTtr7uL7GRHADJiJKISa1fRJCu8zzGC/
         GU4sti57iW6FeyR0WEwOzNjmro3x726lLCUd0ZcbhBQB8QDRxifMD0b88iXz5ZZRKwjI
         A0nP4wLdPvgAc+3lXyc9x5LpDJrgZUvQG/VasfDvydTjlGmmMbrbyIZtn76MYi2HdYO4
         m5zu4E/obJqm0oirpojBLHSpcLleKhRQ7QWBoOA9htUKLHi6U4Fp7Py0STEKQvRvWVIo
         7RNTaNarN3pyZS3JuOjDx4qPE+oX+kSnRTdmSRrhd4khSkhXgFe6QKNqdjjb1ipg2iNv
         BbUw==
X-Gm-Message-State: AJcUuke7zh8q5Yr7HFBvOyq2RN7vGe4tmvuQv+cykFPJ3guvfF7uPf+b
        0p2W+EhamaYJsEQg2tMx8UOiytizul5f4A==
X-Google-Smtp-Source: ALg8bN7dq+ofwpT8s8cSi66dNn6JyXssp2Zv50pDIiZAJyE2aTZNUS61quLFIS6ozt23emARl3fEug==
X-Received: by 2002:a62:76cc:: with SMTP id r195mr32158606pfc.38.1548888330336;
        Wed, 30 Jan 2019 14:45:30 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id l19sm5847806pfi.71.2019.01.30.14.45.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 14:45:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 5/8] drivers: pinctrl: msm: setup GPIO irqchip hierarchy
From:   Stephen Boyd <swboyd@chromium.org>
Message-ID: <154888832839.169292.6913084380036629941@swboyd.mtv.corp.google.com>
Cc:     linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        linus.walleij@linaro.org, Lina Iyer <ilina@codeaurora.org>
References: <20190124202205.7940-1-ilina@codeaurora.org> <20190124202205.7940-6-ilina@codeaurora.org>
User-Agent: alot/0.8
To:     Lina Iyer <ilina@codeaurora.org>, evgreen@chromium.org,
        marc.zyngier@arm.com
In-Reply-To: <20190124202205.7940-6-ilina@codeaurora.org>
Date:   Wed, 30 Jan 2019 14:45:28 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-01-24 12:22:02)
> To allow GPIOs to wakeup the system from suspend or deep idle, the
> wakeup capable GPIOs are setup in hierarchy with interrupts from the
> wakeup-parent irqchip.
>=20
> In older SoC's, the TLMM will handover detection to the parent irqchip
> and in newer SoC's, the parent irqchip may also be active as well as the
> TLMM and therefore the GPIOs need to be masked at TLMM to avoid
> duplicate interrupts. To enable both these configurations to exist,
> allow the parent irqchip to dictate the TLMM irqchip's behavior when
> masking/unmasking the interrupt.
>=20
> Co-developed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>=20
> ---
> Changes in v2:
>         - Fix bug when unmaksing PDC interrupt

What was the bug? Is that why the mask callback in this gpio chip no
longer calls the parent irq chip? We should keep calling the parent
irqchip from what I can tell. Otherwise, we may never mask the irq at
the PDC and only mask it at the GPIO level, which may not even care
about it if it's being monitored by the PDC.

This causes me to get a bunch of interrupts on my touchscreen when I
touch it once vs. only a handful (like 4) when I fix it with the below
patch:

Can you fold it in?

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinc=
trl-msm.c
index dd72ec8fb8db..9b45219893bd 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -682,6 +682,9 @@ static void msm_gpio_irq_mask(struct irq_data *d)
 	clear_bit(d->hwirq, pctrl->enabled_irqs);
=20
 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+
+	if (d->parent_data)
+		irq_chip_mask_parent(d);
 }
=20
 static void msm_gpio_irq_unmask(struct irq_data *d)
