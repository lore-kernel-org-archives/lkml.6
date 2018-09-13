Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5CBC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91DC2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 03:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0dkgIOFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D91DC2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeIMJHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 05:07:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36546 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeIMJHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 05:07:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so2040614pfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 20:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=mqEGQ3zikDJjs36S2/FIqyzBxrV3ozntHoDAEHsZEdU=;
        b=0dkgIOFA63et5EiB7SOThHCDA3d02w/Yup5nw4Z+Kg2ebeC6yFoeCZZGCiyHxZfyxd
         rX7WYNhQyq77glvX6lJYrj5kFLaIJ+rjRfiVhKkPATMSc9M5CGoo2vUf7fPpBk3K5ggf
         oSRzuyw0A63POpiau6m4na3wddVTzxP9l99Pu/VKqyOQvXmLP81jRTY1Oj3PfTyQZp9M
         4vo70bkQts+9EcjyEqIWW1MYVRw6MxyCi80/9waKecjzJFOu5kqblJ6mgXnKj/RE2TLw
         LrmrR/UUQ3frDWY9vk23rV9w9x8e9ZVdZYjNQGTl0Z3/sAXB+sfUNs9F6Qu8IUnSgcD4
         BYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mqEGQ3zikDJjs36S2/FIqyzBxrV3ozntHoDAEHsZEdU=;
        b=Q1jrTzM4zdV8jdnllqJP7/2Td6q48zssrvvJwdyFXh06vKmtSkB+UPSyjyPvWecGNO
         tdGhjyS1kSxPDsdySN1AoPZIaDB0j8JnkfkZlBfvod/D+mq6LBTqZWCq5gmUugnjzYly
         Yh3/uzLL+Xwxv+7FrIfEAAliFXnoOMNjahIZspC3NpOdcVz30Ch2ON56j02CAzOq372T
         Xjii/5XFDc4zGPajnBHJO5Fgnxx53jB3XVCfs3LfOatv6GT7nBPkHdm+OTpG7gykQXZW
         +xL/Z5sSHP3aIW+QjqhdLSUukaTf8FQ2B9YHQFgaFQ1zK5RDr4lxcF59rLeuEkudFMF5
         +pnA==
X-Gm-Message-State: APzg51B82NODWFRTizClXXv+pGepQV/uizck7Xe7H7Rtq9HPwE6ZAFMW
        gwNPNvbiheUBnUdGLNmOP7WSCg==
X-Google-Smtp-Source: ANB0VdZUNDYqkvUfofdVONiWNXfp8winEffvdSmpBgc6DVWDFG4eWcrC14O63ZC/FQYKXdyEQ6SDtA==
X-Received: by 2002:a62:5290:: with SMTP id g138-v6mr5360379pfb.46.1536811195383;
        Wed, 12 Sep 2018 20:59:55 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id n29-v6sm3483099pgl.30.2018.09.12.20.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 20:59:54 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM64: dts: meson-gx: increase default shared CMA pool size
Organization: BayLibre
References: <1536085844-29328-1-git-send-email-christianshewitt@gmail.com>
Date:   Wed, 12 Sep 2018 20:59:54 -0700
In-Reply-To: <1536085844-29328-1-git-send-email-christianshewitt@gmail.com>
        (Christian Hewitt's message of "Tue, 4 Sep 2018 22:30:43 +0400")
Message-ID: <7hd0tixd1h.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Hewitt <christianshewitt@gmail.com> writes:

> Devices using the new V4L2 mem2mem vdec require a larger CMA pool. As
> nearly all GX* devices are video/media focused and will use it, set a
> larger (256MB) default value.
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>

Applied to v4.20/dt64,

Kevin
