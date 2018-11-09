Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA52C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDD120883
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDD120883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeKIVUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 16:20:38 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37327 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbeKIVUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 16:20:38 -0500
Received: by mail-qk1-f194.google.com with SMTP id 131so957691qkd.4;
        Fri, 09 Nov 2018 03:40:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oum+toPf621R0xaQ60JDahqKDtyXnFbn55zYgi5DzXQ=;
        b=VKNTquMUdHG4K1eJTp6wzFShZnIcIztjiS0RBn9D9PjaQ4qp3+9b4fRXaHB5wbpX0m
         P8odnOdybxq++LDN3xZSi9tC8e34I9lJcU6BuyL01MEGMpiP++Uu0wIuTlJGGdOVhoIH
         Q+8AT3bn03D22+Z6JvXwpvcH0TGYUyPUd3VNMhc3wr55eJ6kN7icnj1aDI2pyRBW2ImI
         rH7jKczq1v/AlgzBJbhYvCCQz1i1AIE8kBposSytvhXLGtBqxHV7A8xOc3rtFTPMS+Kr
         f1g+Hf0iWvCAsyxJ5gz66sQPBPP6NY3KjJjGSkeprx09GC8lxFS5XGA0yH86KB12tz/p
         GkcA==
X-Gm-Message-State: AGRZ1gI/raDJq4Kxq7lVdZ8jPFibyUmUK/SM7l23SlEYSJi26mCAP/Z9
        bbAXS4AVfMQOSfcn5wwoebfHqQiS/saT7TiaGJqY0Q==
X-Google-Smtp-Source: AJdET5fv9xMk3tDYNUV7JpWDZ8uXYKcjMhGKYxEqNMqFJiY0cT7UGRIvhYHp4B7tV4Hj76mMHCCxmM0QAYc2aDLi0cM=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr8086158qtr.319.1541763622912;
 Fri, 09 Nov 2018 03:40:22 -0800 (PST)
MIME-Version: 1.0
References: <20181109070349.20464-1-chris.packham@alliedtelesis.co.nz> <20181109070349.20464-6-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20181109070349.20464-6-chris.packham@alliedtelesis.co.nz>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 9 Nov 2018 12:40:06 +0100
Message-ID: <CAK8P3a3PNvBhyQw0bfGxKmxj+KeJB2_TXtDx2R1BpjTCYNqVkA@mail.gmail.com>
Subject: Re: [PATCH v6 5/9] dt-bindings: ARM: document marvell,ecc-enable binding
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Borislav Petkov <bp@alien8.de>, jlu@pengutronix.de,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>, linux-edac@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 8:04 AM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> Add documentation for the marvell,ecc-enable and marvell,ecc-disable
> properties which can be used to enable/disable ECC on the Marvell aurora
> cache.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---

Why do you need both enable and disable? Wouldn't one of them be enough here?

      Arnd
