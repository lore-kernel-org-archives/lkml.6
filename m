Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580A4C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8DA2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="qnxOyBqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8DA2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeJHXSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:18:45 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:42257 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbeJHXSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:18:45 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id e40a6255
        for <linux-kernel@vger.kernel.org>;
        Mon, 8 Oct 2018 16:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=RVtDRqyWO8fSF+PEwXfPEnWS2Y8=; b=qnxOyB
        qcO3UMaQ3cia9la1o83Q/hRMAwcqaU5AKw4On6jtEHnSI8LfCnk/E8kr+j2LT9Wd
        l8X/suhPZjOy9sT7dxwMaBMKHnoyDn496CESq8yhXIsAOFZ/eAb0gqKpz/TfMOZ9
        L1hMZRUYpw+8atMNIZ5oKR05OUzlDPmPsx0I78/b+sZdZQOzgdYx9DHv6kekz0/G
        Pl3KON9duWbkFyXC+T44pnp0UsYHyU584ysauS8qv+poNYAcvdcw/NnxXJ9ypy8j
        g2tN1k2RYe2g4MHnxo+n3pJVXCkv6zaoCIYdbF4HikppuqL1pBW/AbpdDK1sgqPs
        LmsohoekHbEIPiVQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6886425b (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 8 Oct 2018 16:05:28 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id e17-v6so15878592oig.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 09:06:16 -0700 (PDT)
X-Gm-Message-State: ABuFfoj1WBIL1YrsIwY2dct3KQ25pZbldrlnGd9DBXFxG9wzivTpTmZk
        sYStoI3F5A3wBt5zlL5j8PTtH4fOV4BFeMQabnI=
X-Google-Smtp-Source: ACcGV63kRvQdBfniw5rXpACoZ15NCcMItoNeNSR6AQ00RLLZeI/7Y5T4t492BI1yQLQoB+jD7yAJF3sYEGEjYLPM3yY=
X-Received: by 2002:aca:d4d3:: with SMTP id l202-v6mr4735011oig.15.1539014775544;
 Mon, 08 Oct 2018 09:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9ofzanQTBD_WYBRW49d+gM77rCdh8Utdk4+PM9n_bmKwA@mail.gmail.com>
 <CANiq72=hXXvzfYz-1EdgDNBVfYMiRp2RbjjNF=wwiiPVU+jmuQ@mail.gmail.com>
 <3cbaf145ee577f017cf7aea953c9dd1eb88ed4b4.camel@perches.com> <CANiq72=bfYHM6XjQZ9dG_auahA_w59naEXM+VZHGm0m=_7nOqA@mail.gmail.com>
In-Reply-To: <CANiq72=bfYHM6XjQZ9dG_auahA_w59naEXM+VZHGm0m=_7nOqA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 8 Oct 2018 18:06:03 +0200
X-Gmail-Original-Message-ID: <CAHmME9pWGsc5wLzNK5pe4gVLPNb4uUWYF8AARK8_K=WYLwdGfQ@mail.gmail.com>
Message-ID: <CAHmME9pWGsc5wLzNK5pe4gVLPNb4uUWYF8AARK8_K=WYLwdGfQ@mail.gmail.com>
Subject: Re: list iterator spacing: clang-format vs checkpatch
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Joe Perches <joe@perches.com>, Andrew Lunn <andrew@lunn.ch>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the clarification Joe. I'll adjust my codebase to roll with
checkpatch's conventions.
