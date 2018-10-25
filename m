Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D49C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BF420834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGaQporp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BF420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeJZAUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:20:22 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35240 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeJZAUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:20:21 -0400
Received: by mail-yb1-f194.google.com with SMTP id k132-v6so3879338ybc.2;
        Thu, 25 Oct 2018 08:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sH5Gozn1Wz0uDZYz82i1bnQjXEKyec4gsJcz8H/2kNA=;
        b=cGaQporpSt9Zlas8iE/k4PJPF21vtK4Hu1yStTR/TwOnh14lYxGPUwAE699WA/Cm8a
         WYzWH8WJGX+E9+TbxBTXnnsNLnIamg7A1iqJSr/JSAPjJRLG4VuWuL9rZ0C+JOP5BpWS
         XP9l2FSccxSEtdfZBI+1FD+DYpDoJTbNC1JLv5NsNBLu6MBKHYwKT2E0jpRaGZFHWK9k
         juVl3i0U+ldM1GY/AyOOCrVbRlhdNXO5x5HhZQud9c0Ev13ytebp3V1DBJ6UiOrjc7cx
         fFX/AdTZLmptQOcri1m+9tOtR4ms5TkuTRgk6xdDmNqd5N9gaBLDTkI0UzP3tGZLcyjS
         Sgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sH5Gozn1Wz0uDZYz82i1bnQjXEKyec4gsJcz8H/2kNA=;
        b=fIIs5UZ3+T55Q1JKVtMBbX274sgvI26f0VB1eeyRekVpWBKv+QhWKpoNQpyuKzVvIN
         2utgYWSR6vTse/PNWoNi7ZKNT+N+KubtclV4fR2XhTnIY5X5og6me8lRFnRslii7k3Gn
         PHBx8p19yHI6MhFCrmjuHVm4WmxhnibG9iUfgE49wzGRDxOixePL57MrhvV76G/DHP6+
         qc/ouQMH5G6YE/I4qPujZTdCrghmZUE6CaVbluGKlK0GzTcvGSorbsz5Lr/lZIBdVxgK
         VwOL0na17Ggkzn+X+oKx47bOgQ/vb0/v1yfL0ohlNdqiKL7BNEbbjJPq3sZNd2NQp32T
         CnuQ==
X-Gm-Message-State: AGRZ1gLx1Fy56zdt8rCjg4Oti+3ncNI2TSQtES/1eliyHwVz7pYgjyia
        mVJv3JK6eLfv+JvqkJsi0oM=
X-Google-Smtp-Source: AJdET5d+AY54eO24i/vZsAzi2PmbCEuX9GEzUTzVn8qS/qVakfE7MxZStFQVcCVGdyo6GOvkU/K/eA==
X-Received: by 2002:a5b:ccd:: with SMTP id e13-v6mr2024092ybr.404.1540482421034;
        Thu, 25 Oct 2018 08:47:01 -0700 (PDT)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id l30-v6sm7889525ywa.104.2018.10.25.08.46.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 08:47:00 -0700 (PDT)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     svendev@arcx.com, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, afaerber@suse.de, treding@nvidia.com,
        david@lechnology.com, noralf@tronnes.org, johan@kernel.org,
        monstr@monstr.eu, michal.vokac@ysoft.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, linus.walleij@linaro.org,
        maxime.ripard@bootlin.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH anybus v1 2/4] dt-bindings: anybus-bridge: document devicetree binding.
Date:   Thu, 25 Oct 2018 11:46:56 -0400
Message-Id: <20181025154656.10153-1-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> This is why the bridge driver has a dependency on a pwm.
>> If the pwm could be enabled individually, I could drop this dependency.
>> Can you think of a way?
>
> How about using the pwm-clock device tree binding to turn the PWM into
> a clock?
> Documentation/devicetree/bindings/clock/pwm-clock.txt

Looks like a winner. Thanks !!
