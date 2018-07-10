Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9B1C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9C8208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoXTQrwQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9C8208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754384AbeGJMlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:41:08 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46192 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754089AbeGJMlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:41:07 -0400
Received: by mail-lf0-f65.google.com with SMTP id l16-v6so18156493lfc.13;
        Tue, 10 Jul 2018 05:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2WYcp4qMyDYJKiNvUL+e78MSqll9uCXV9YK8bUiXSHw=;
        b=AoXTQrwQEy/xhX4P6bfZdHDMyvvaRnCEcDT8JihrojKwUb/qFY+8UPxOzK6P9SPqgx
         jkqChg8T3NaVRyDPp3Tyq6QCx0t9QndfV3GX2B1OxUbd7xD5aevdXbeVWlOdP1+5rHRb
         wSRGB154hKxqI7Q1Hp1Zmt3g4DSJvQBkrw1tcExgcfciwKgwxNUi81Esmd4UGXf7qsNf
         yekfdb8e/BljNaeiewS0YPuxyySUMPqhrDZtWYsReNkffBeTWPWXBgNWoF4PNpXH/m1E
         4/zi4XpWwxq9/epT1mzWxubb/UkUk+iCL7WXEBgq9HvMq8gePvds2mbpG50VWDerFLrx
         rcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2WYcp4qMyDYJKiNvUL+e78MSqll9uCXV9YK8bUiXSHw=;
        b=jApNDEBeF59YtEkDjiejHdY9TaayHnwwPruCPjnRzsrLFqb59xdmtJ0mEtpjk4faZc
         oXE9NKPYhBUXqiC9+DmIXfpvWqIIO4NS3ff1AFRXVUpvX+P3QDjiSIxZ3X6OOS3nJjWL
         +n7puMNJO9VddyLkfYXoCm74UVLL5Ies9JQPUNrZSfRXDCMybo9Hk/ges/XP4dIzQMgi
         6uSj0bYYe1sssQyP2SWsY58H2UUKBmGMsAZTwQhIxdsmvO/r2NBFx3K8uNUN/DrUGQgv
         89wE3fsClnbmxgR6jC4MNrmU6OgAgWehx6SNhmLHCPcrJiaIOQ5YTmi2Yr+9BeQQEc7g
         sJIg==
X-Gm-Message-State: APt69E3K/QOsyW1vgrPI5DoZho4Gk0KbzOSoGrJXCwVDvoUra9eyUNf7
        jrAs8ajICwZEDFlJlQfGWnA=
X-Google-Smtp-Source: AAOMgpdi5+STxYPoT/7FuuNiqe090pCV8jbEgPNNEEy4yYWuVSIlRLdNiTpmE63eVLkfneHvAj4T9Q==
X-Received: by 2002:a19:5418:: with SMTP id i24-v6mr2634088lfb.34.1531226465776;
        Tue, 10 Jul 2018 05:41:05 -0700 (PDT)
Received: from dimapc.localnet ([109.252.91.84])
        by smtp.gmail.com with ESMTPSA id b14-v6sm4370076lfa.62.2018.07.10.05.41.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 05:41:05 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] memory: tegra: Correct driver probe order
Date:   Tue, 10 Jul 2018 15:41:04 +0300
Message-ID: <6928630.1YQN54N9Yp@dimapc>
In-Reply-To: <20180526142035.21741-1-digetx@gmail.com>
References: <20180526142035.21741-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 26 May 2018 17:20:35 MSK Dmitry Osipenko wrote:
> The Reset Controller should be registered in the end of probe, otherwise
> Memory Controller device goes away if IRQ requesting fails and the Reset
> Controller stays registered. To avoid having to unwind the MC probing in
> a case of SMMU probe failure, let's simply print the error message without
> failing the MC probe. This allows us to just move the Reset Controller
> registering before the SMMU registration, reducing code churning. Also
> let's not fail MC probe in a case of Reset Controller registration failure
> as it doesn't prevent the MC driver to work.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---

Thierry, this patch should be good to go.


