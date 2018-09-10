Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F3CC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6036620866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 18:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NECRl8G0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6036620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbeIJXld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 19:41:33 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35033 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeIJXlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 19:41:32 -0400
Received: by mail-oi0-f67.google.com with SMTP id m11-v6so42242456oic.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 11:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7DD77+SKocKD26wXRIWdHmA2knOb3o7T3S6CMTFo1n8=;
        b=NECRl8G0ZGgXezF6hjQx0YRmeIqgmBBsVxYU+C5r1zwpaVfs2YOP2FPQddFpQ63CSM
         n5NMtCNiDvbbB/fbldIW6biy/ylFKiQRvAPFMavtqrcUmk1ji0JlHT7gTEhhUXy0MyMz
         M0/DqWagV1fErxNmpgZ+QXkrWvqaBC4Mv8auDVQjlR72SIwlJY1qVyvSOezJFdI/b1zR
         Ad34sY5hW77szm9WVDpLCRJl+cDUDNxHiQJkM1mfVn8JEj7zsqqIvgP2L3V+O18q+n5i
         +wSGZJuQebo4AC2k10t9L8HibYJLf1ZDwiKItYlzB2THsGakwjS40abE0GSneL00N1lC
         O08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7DD77+SKocKD26wXRIWdHmA2knOb3o7T3S6CMTFo1n8=;
        b=WaRf8gnK5bEWYHCuDGfWDcDcHXHvQlJe6eysVsQXc/MRQTXZBAJQRWMCPHMZg27BK1
         rAoGYK692q2TMm4uuKigVvv2LivHGfZwip6dijuXrbeH4S9F1pmm7mSDK2iC+XXTkK/k
         mwC3P3qVCs5K2lMwSTGeXXeadb+x//7X09aC+HM2pg63NknI9ZO0SFIGw7j27475Uba9
         4Mty3Jn1XEnidr/LD+Hx81Ad1ePdjEkaD47mmQe9p9RXrAnW8osVxgucBnLv4u5J8h7c
         rgH5CvVm2Qk7++mAZlYH1TGZKXrcJRtnG9vZ9NknpNsuoEFosRHv81d3C3ncXhzv9TxC
         FsvA==
X-Gm-Message-State: APzg51D5OiPsp6S6sWeMcTB4eLUIQk4TDjuq8ZO5j5gctuAogQfSQGBU
        bloNOw+X/6x6jXXSVddAC5yda3AvQ9hDAuKy/04K4l7l
X-Google-Smtp-Source: ANB0VdaAO6mrjwNV5hNJeXNt/wkwMZthyWD9q+ti3mUZW/3gV9DFRZOW3BAc4NkYR3rGaDITmj33vrpNS58ouMZ9D+o=
X-Received: by 2002:aca:d706:: with SMTP id o6-v6mr24266537oig.45.1536605166434;
 Mon, 10 Sep 2018 11:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <1536604395-31925-1-git-send-email-narmstrong@baylibre.com>
In-Reply-To: <1536604395-31925-1-git-send-email-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 10 Sep 2018 20:45:55 +0200
Message-ID: <CAFBinCDeHVZ5s2f5xhuRByg7pt+MTqqfO8_5C_s_B3hbZkDANg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson-axg-s400: Add chosen and memory nodes
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 8:33 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add missing chosen and memory nodes.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
out of curiosity:
- does the bootloader add the memory node (meaning that this is just a
cosmetic bit)?
- setting stdout-path is always a good idea, without it you can't use
earlycon (without parameters)

Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
