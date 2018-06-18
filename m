Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF764C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0AC20020
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFA2Pqnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0AC20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933684AbeFRQhN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:37:13 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33727 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755306AbeFRQhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:37:07 -0400
Received: by mail-pf0-f196.google.com with SMTP id b17-v6so8451900pfi.0;
        Mon, 18 Jun 2018 09:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t+F/Pc+xxWNn0zQ+i+IgQumsS/92kl/4XNlRxeXWZjw=;
        b=TFA2Pqnp+2COkvZXIRaS6FeAHo39MxBXvjg2mrUQK12zNZYOgXGNsQM/+1b0MDYNf1
         XqfJiUCiZCclIoPpZnjyAaAhn2HFBCgh/ShCS8CDHXYKA3xwr+kVWZGdAESSont4kYTa
         qqvwxc+0jpyKlIYF0l4d2sQ0bqFMxuCgHPWA+trh1cB6xS5Fl0elnPyNPjMsQHiB5hrO
         zvuxkv4SohxOHHvdLjhYIVAcqdjt6hudCxL8vC6LcOxQp/eg3lh3xw+4vzDzh/t6aa36
         9hx9tuScFHMo5oSadeYwwqEWDszK60i2WbB3rGMn0JQG4v/FpeKM+cSgetpJCU712LRK
         mEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t+F/Pc+xxWNn0zQ+i+IgQumsS/92kl/4XNlRxeXWZjw=;
        b=Q76lVWeokJSkLkgq3RkZ8IsEJz2i9FC2Nt6HB3nvhOPYVLOwzWNeay8rHT6UNPyBPA
         PWoaOujwCijPM/l7/0+ACq71cy1EI4R8gfLr3D7nw3RxrJC93LhCxkHFPuS3pl4dR8NV
         MOMHnEm2CRgUrKpabviTZhUtx9BtsKZ32hIFejz6ViQsI+dr1h/eeSJS6LxW8AfOQLbV
         fb1vjJ3g0nBXUhmyOCKTANdFA3nzunuTfTzRdXFMOer7Gv5LyrhjtCgNHZF9C37el1lh
         1ri4xRYXm32Ib3F6XSZDN68grNls3xSNLwSU01r4f7TjYjK4TD2FNiAErdIHcw37oqP5
         oyzw==
X-Gm-Message-State: APt69E0K9BhFd+DTRgGYDHAtoxK3sesQO3ppUsYKhUt5QB5+kWQwCYY7
        fsG/Jz//p9eLs0oKTEF0kdA=
X-Google-Smtp-Source: ADUXVKIKEhq82venMeAtHRAc5VOE9ASqkmy3GZL5UQW6QWDiQhYvztH3TU4HD2r5POoHg1ndGG06Ww==
X-Received: by 2002:a63:3c4c:: with SMTP id i12-v6mr11741897pgn.309.1529339826929;
        Mon, 18 Jun 2018 09:37:06 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id d65-v6sm23557444pfj.20.2018.06.18.09.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 09:37:05 -0700 (PDT)
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
Subject: Re: [PATCH 2/3] ARM: dts: NSP: Fix PCIe controllers interrupt types
Date:   Mon, 18 Jun 2018 09:37:04 -0700
Message-Id: <20180618163704.27123-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180611224714.7007-3-f.fainelli@gmail.com>
References: <20180611224714.7007-1-f.fainelli@gmail.com> <20180611224714.7007-3-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jun 2018 15:47:13 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The interrupts for the PCIe controllers should all be of type
> IRQ_TYPE_LEVEL_HIGH instead of IRQ_TYPE_NONE.
> 
> Fixes: d71eb9412088 ("ARM: dts: NSP: Add MSI support on PCI")
> Fixes: 522199029fdc ("ARM: dts: NSP: Fix PCIE DT issue")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to devicetree/fixes, thanks!
--
Florian
