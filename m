Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7569C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 04:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3228B2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 04:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="S/aMpLwc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3228B2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeIMKGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 06:06:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35842 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbeIMKGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 06:06:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1-v6so2164507pgo.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 21:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=0qwwmOqujNLGFlxpsLC8KyJvgGflHrlSDD1paEjteeY=;
        b=S/aMpLwcQGxtriGggNHrPuV+MwVq+O5pqa79nxPmekGEFw8wWpaBlZksA/qbjuMSg0
         KyL9AqEyDtzOB7BSInBMjT4ZIGTzo3nvxS/vpUky4qXqxXC0Ugt5WyrkUJ/u97ZkhCg2
         osGG/AuwfYqoeJvNgtayJ7cry4RA/vlenhvuFk1TWx7/8++0ZMhgguwiokhtw6D4os7+
         kRuLqDwNiLPXHOs0I2GqCuSUfOC9kMQ/4AeaFYI4gRbV/3uUro9HUSzcuVzvLpC4rRWr
         Q3RCEoDmsGaF+bVGKErbcwkG7pdoTKE63X7L+530tv3+5nGYyfUqbPhyldNoOlOsKsbB
         2HZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0qwwmOqujNLGFlxpsLC8KyJvgGflHrlSDD1paEjteeY=;
        b=KCL2ph0lElHV/K+fVRYYXxLotYEqWorKONBDDRnC6A73ewESBYLJyUuUludHHlwZx8
         P4S5HEVX/zM7MN4kZANxReBGAoO08Rr0kiABy2c9amB4hu5d7BqeHf8zhUN2aOU4tNkw
         lC23nUeJqn/x3HKY3jgNxo26urUY6aRuO6pVaoe47hfHNJTrIAxPYWb3qeaI4SlxXASM
         1wmLlZV2UEpAm0x5iz3VkQquBrEDxKNiCEgVyfhKy0qrIo/e3fDfUaC3aAcUFRdtyQ+y
         mcnRBATwWnI0e0zW8ZUcLKOjfxvDfQ5/HpkZGpF3TZwY95XZptURTa5zVlrTqkr+yNG5
         Cu3A==
X-Gm-Message-State: APzg51CB4mCDU2HOiSQjdJcBknM13ZBOTxfnz6nEABBoTrv6AzKaLmI8
        RIku6J5lFfI7a/cNKjfRW9yoZA==
X-Google-Smtp-Source: ANB0VdaegkS8Nimpf2RghV8llZc/wjGZNcb4UTrLFFGRpN1Ul1Ua+0fDn5kkpOghmJpsGyprevGx7A==
X-Received: by 2002:a62:ea05:: with SMTP id t5-v6mr5604042pfh.228.1536814712435;
        Wed, 12 Sep 2018 21:58:32 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id r19-v6sm8417193pgg.39.2018.09.12.21.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 21:58:31 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson-axg-s400: Add chosen and memory nodes
Organization: BayLibre
References: <1536604395-31925-1-git-send-email-narmstrong@baylibre.com>
Date:   Wed, 12 Sep 2018 21:58:30 -0700
In-Reply-To: <1536604395-31925-1-git-send-email-narmstrong@baylibre.com> (Neil
        Armstrong's message of "Mon, 10 Sep 2018 20:33:15 +0200")
Message-ID: <7h4leuvvrd.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Add missing chosen and memory nodes.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.20/dt64 with Martin's ack.

Thanks,

Kevin
