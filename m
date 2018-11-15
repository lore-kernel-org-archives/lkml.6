Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B93C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F65208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vWrVQuTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F65208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbeKPGDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:03:20 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34426 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeKPGDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:03:19 -0500
Received: by mail-pl1-f193.google.com with SMTP id f12-v6so9986668plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 11:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Aewx7xs7fSoFRBP5YKN1c/T7Wnbr8mS1551G+7RyKtw=;
        b=vWrVQuTGKe+61n39Kn+9ca3TvFQYImk13UVHkjLzHNAyUE+CfgiKBjKNhqtWdCRnyM
         vm73HVslb3zSYQAXUWVSFDyR6Z8lNLs9JmN3J/ln+ffiZUwYazTG3fueNhTjJyJX8TXV
         dGRpvwkFeUNrqkReVBKhh8SCiYGFDQIxh1OQJyNbHOl6FXyt9+AogJh/A7cT7NSqln/1
         ONz6swWL7+AvN8PBgTwZyjfMShclIAseoq8iQu+F4tqoHuexMHJqaZtKM4mgiqvTElrI
         Q6ivqPT49Dd7jVNu42P6W0vLHSfhajEY+dXFEBZzogZJvTQVCJmej1uTfxfCnd+/jTsg
         pMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Aewx7xs7fSoFRBP5YKN1c/T7Wnbr8mS1551G+7RyKtw=;
        b=SzxvuWaZUGLFn9bHr3WkcbGGPMVBKbpssl+U1srkboDiRD7FYI/pI5q1Eek5XAqT+1
         9v5hc+y/pbCwMtBSelvC/d3aqt6LnoE22llaiDSeUyH7grVoWCTppSovKN4fIjYObMlL
         sy280yEnsVkTlC76Vpu2gjAE+eE3IoCHcp4luy9ejChTG5FkbM+qIyIGoW9ZOV48idMJ
         7Dc0Kuw6gCeikyN6V9V8UngakATHNY+uc2DvXQ0Exuzkm6DohCt7qqQLUuna3lgtP3kH
         n6DMsVdd+HjMD2FFOjWws6I1EB+X3b6ZsN7+3I/7ylrCG55nHq1SfL5aqx6KD+Jq8oES
         u7qA==
X-Gm-Message-State: AGRZ1gJlmFH/tV/29JGtMYxzdU7FCyL/pPrOPsT0nXhMkxjo0oE5aE6o
        7j8EO8JdHDwBpJtikdlaJOQBaw==
X-Google-Smtp-Source: AJdET5ePf5LFWf+1IeaL3l7YIoLWi9WYK0mrcWVp54d7nCgY/kF8xKUb8aVU8ZoA1jun1ed863W82Q==
X-Received: by 2002:a17:902:bf03:: with SMTP id bi3-v6mr7767636plb.288.1542311647207;
        Thu, 15 Nov 2018 11:54:07 -0800 (PST)
Received: from localhost ([107.181.189.87])
        by smtp.googlemail.com with ESMTPSA id w10-v6sm33087345pfg.1.2018.11.15.11.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 11:54:06 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] arm64: dts: meson-gx: fix GPIO lines names
In-Reply-To: <1541587550-17842-1-git-send-email-narmstrong@baylibre.com>
References: <1541587550-17842-1-git-send-email-narmstrong@baylibre.com>
Date:   Thu, 15 Nov 2018 11:54:05 -0800
Message-ID: <7hwopedsma.fsf@eze.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> The gpio line names were set in the pinctrl node instead of the gpio node,
> at the time it was merged, it worked, but was obviously wrong.
> This patches moves the properties to the gpio nodes for the board DT having
> the GPIO lines names.

Queued for v4.21 (branch: v4.21/dt64)

Kevin
