Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D309C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37E520020
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uGhJUwJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37E520020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755305AbeFRQhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:37:04 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33485 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752835AbeFRQhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:37:02 -0400
Received: by mail-pl0-f67.google.com with SMTP id 6-v6so8788752plb.0;
        Mon, 18 Jun 2018 09:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FFJMHnQxon32CH/Kf/cZX8Dka4Jp+BGDOK26vI4EXqI=;
        b=uGhJUwJsr3kPf5CvZbQbWqlP8X6TMI9fAIckMJFW1Lc3MYxTqm/iHFdlekwfkYzhd+
         ALdGmhsgtAtw8u1Mq+KbYFlADdp2dFefuF0D4RdSF172oG6LbgNuJymmV3+7tsbMUSvo
         WVcDsKjpUdWHrrUyYh9eQIfHKSfev66xw8wqpZYoJ4O/QHFOA/BX0LHbAO6hIdXcsQV6
         6cv95uA9M00l6Rxf2G9+eXeMx1g7RUAvO6o8LNJmUrY9eMou+wEIQyFIYhUoDzZ5T+Uf
         x2GT5pZavmmp6Tr0kWVVvKAPBiADeN6drd9ucMbP+xmJuAe6+C3E96ZwCjG4oOmuWISz
         466g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FFJMHnQxon32CH/Kf/cZX8Dka4Jp+BGDOK26vI4EXqI=;
        b=PjeG4vI4gEoQ1kwoTk3U3c0LswDBDypqEU3xuR8bGWyEG01yCFvgdT0guaCD6wreCJ
         wJcb7q5HXx/g7Eq8ATSxc+iCnUFTa4jB+USVRG/BZlEVwwAd+3RKo2XdV0kO58mJ4ZOr
         ceYEkNX3AY1k98+dQAgbSjGZuvAgqGMR9sYjD19+QFWM+Z/qvNnOAdiEj3AWZxOtwDRk
         xR8tjTAYuIgogthvY++yjxjc/08uC9lBQe1cTdSZMmSPshM9EYfN+4DTMzzbdKsXlqiB
         mLdJnXy0DyIT+KhMkIb6SvO+bRfSQ8hpbZ+h1LFU3AbM8z75IA+oRGEsD7wz3ajiutXv
         QRdQ==
X-Gm-Message-State: APt69E2hiXJL0GltElyf+/Nkcos5IieIpR94zTv6OkNVtLIPFTxj4JM+
        7DPJH6QRAe8zPLY2oQdyl0M=
X-Google-Smtp-Source: ADUXVKJA9PfZmzM1ijpyjtMuIh3oyl6tfnbDVZ7FGVr0L6M+8+VIEXTAILcdmHMVK0suSCfb9DKLcg==
X-Received: by 2002:a17:902:563:: with SMTP id 90-v6mr14782290plf.327.1529339822126;
        Mon, 18 Jun 2018 09:37:02 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id u90-v6sm40638147pfa.101.2018.06.18.09.37.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 09:37:00 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] ARM: dts: NSP: Fix i2c controller interrupt type
Date:   Mon, 18 Jun 2018 09:36:59 -0700
Message-Id: <20180618163659.27039-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180611224714.7007-2-f.fainelli@gmail.com>
References: <20180611224714.7007-1-f.fainelli@gmail.com> <20180611224714.7007-2-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jun 2018 15:47:12 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The i2c controller should use IRQ_TYPE_LEVEL_HIGH instead of
> IRQ_TYPE_NONE.
> 
> Fixes: 0f9f27a36d09 ("ARM: dts: NSP: Add I2C support to the DT")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to devicetree/fixes, thanks!
--
Florian
