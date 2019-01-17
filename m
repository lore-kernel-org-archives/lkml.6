Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4BEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3F1205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 02:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="RlZ8R1JK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfAQCr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 21:47:28 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36519 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfAQCr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 21:47:28 -0500
Received: by mail-qt1-f194.google.com with SMTP id t13so9792876qtn.3;
        Wed, 16 Jan 2019 18:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jhUYHlWsp4dPPCUUpYGivzzrUbq5nG0j5/GyKUMF+SE=;
        b=RlZ8R1JKHdUHs1UOia+dTIgj4dWHMJN220b4Zfmw0OoGXX8CW3WsSHtH0CX5n7YaAO
         sTQaJ2V+dzEYl+w6UmgRjlJxlhxBYs35b/WqWxYZZr6pdHoMPvwLaKNQNpjtmlRprC2Z
         4zP4XW0CJFhAiVlfjnCgmx3s9vQsgZ9yY8b7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jhUYHlWsp4dPPCUUpYGivzzrUbq5nG0j5/GyKUMF+SE=;
        b=iyZIZfc4UZxRxaAF23HayG/COMLwB1aC0TSRm1910UyOaDmPkdBiLMZ58UeK6xYLNu
         Ro4DhpzP9q7yTwX24hEhdBtb4+ISyGxxG9iJuGLtddYxOuhUMePQHoGUyHsXKtS1tQXi
         3YriTZ4ysOG46dvMmAqTzLb40klaim9rpXDtUFAfEUJ5CbZBFrZthl7vwysxNRUXodnQ
         dskzxv6x8g5xLmTquuk2Ho6Ba4THUI4gwx/rEugVOR8cLB9MIbs6VJv80WGGuidOiZCO
         wsCQkeuyfF/MxE75kwpx4z5HyHrlhO2tZvuNxYnpbccmr8Uoi+Bz6uocNJIFjMsKWA+p
         4oOA==
X-Gm-Message-State: AJcUukfjlInB9dZhqWk3f2rcetgHZxS8DxQEj9Ong4j0pFV7Cw76Dd2e
        9lPtWAEp8R6f4Ed4Y20mugdVs6BFZov+Imatf0xIoIzQvgE=
X-Google-Smtp-Source: ALg8bN5/9+t2WoEt4JnZeWiSXM/fyx3B4LuA6Q61b5VpQmLE39xvSZZiUASfk9dyCE7X8KzSY6olpwG7yy5+rcT1wTA=
X-Received: by 2002:aed:2764:: with SMTP id n91mr9903046qtd.37.1547693246995;
 Wed, 16 Jan 2019 18:47:26 -0800 (PST)
MIME-Version: 1.0
References: <20181217200405.2904551-1-vijaykhemka@fb.com> <20181217200405.2904551-2-vijaykhemka@fb.com>
In-Reply-To: <20181217200405.2904551-2-vijaykhemka@fb.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 17 Jan 2019 13:47:15 +1100
Message-ID: <CACPK8Xe2SbmxoY+Fj3jr7eZ7qA9bqgSgpuS=L9iVcL+wu26_wQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ARM: dts: aspeed: Add KCS support for LPC BMC
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 at 07:04, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Added kcs device support for lpc BMC.
>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Applied to the aspeed tree for 5.1.

Cheers,

Joel
