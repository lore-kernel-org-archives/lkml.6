Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB60C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7DE217C5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 16:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7DE217C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbeHJTTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 15:19:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40779 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbeHJTTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 15:19:19 -0400
Received: by mail-ed1-f67.google.com with SMTP id e19-v6so5112382edq.7;
        Fri, 10 Aug 2018 09:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hrKhRLdDTOgr3Vrb/3Ym0AwV1xrARHDBpzo+/yKejis=;
        b=Ww8dwZlfA6of07k6UxApNm3b4H9C42fxsa+a29r2ljsFnUuTIysfvckSRIdwxdQ+ES
         al8SmdD1347jKsNBH74NsbBFt8WUyheDR057Qh73XmrRIu/aPXhMOtlpuJphk654VsHk
         nYOBM2fd8i35DuSKP9CvJ+vDiaDXGEQW8PJZTOr4y6/hhOWuqp4qmOvyUF7ZnJSmArnw
         N7XvPuG1X8q71H1YaNAwV1utI6923jN+mKZ6iomA1c+YzDkm3p2Iv1Kh5YE0HR9I/4RS
         5JJ0J+HKVRWQMGGsSpzxBR2OvMfDG7Nb8U+nT8y5UNt68xGYxqX7Zt78HxIQXzKnHY6l
         TUDQ==
X-Gm-Message-State: AOUpUlE3rs/R/ZawzSixY0DBOCUMA3674XTrgBppzGt6CMuSC3wlmQZC
        kmZJgq88L5P9Cw5D3xeXAQL7uXtqKCo=
X-Google-Smtp-Source: AA+uWPySvph8b2xLzpYTSFlAlba/bdkq9CZNrid5qwe2VLZqCYMDTmgJikHr9+KzQ6m7C3N2WYjSQQ==
X-Received: by 2002:aa7:c2c1:: with SMTP id m1-v6mr9328233edp.249.1533919720389;
        Fri, 10 Aug 2018 09:48:40 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id j42-v6sm5065350eda.2.2018.08.10.09.48.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 09:48:40 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id h9-v6so8880453wro.3;
        Fri, 10 Aug 2018 09:48:39 -0700 (PDT)
X-Received: by 2002:adf:8481:: with SMTP id 1-v6mr4920317wrg.34.1533919719672;
 Fri, 10 Aug 2018 09:48:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a101:0:0:0:0:0 with HTTP; Fri, 10 Aug 2018 09:48:19
 -0700 (PDT)
In-Reply-To: <20180810151638.30900-1-icenowy@aosc.io>
References: <20180810151638.30900-1-icenowy@aosc.io>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 11 Aug 2018 00:48:19 +0800
X-Gmail-Original-Message-ID: <CAGb2v66Wsjvz8Pdo+7JDHudOxqqWX_9qMX4kgiFHo8cJJou7Ew@mail.gmail.com>
Message-ID: <CAGb2v66Wsjvz8Pdo+7JDHudOxqqWX_9qMX4kgiFHo8cJJou7Ew@mail.gmail.com>
Subject: Re: [PATCH] clk: sunxi-ng: h6: fix PWM gate/reset offset
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Rongyi Chen <chenyi@tt-cool.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 11:16 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> From: Rongyi Chen <chenyi@tt-cool.com>
>
> Currently the register offset of the PWM bus gate in Allwinner H6 clock
> driver is wrong.
>
> Fix this issue.
>
> Fixes: 542353ea ("clk: sunxi-ng: add support for the Allwinner H6 CCU")
> Signed-off-by: Rongyi Chen <chenyi@tt-cool.com>
> [Icenowy: refactor commit message]
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Queued up for 4.20. Thanks

ChenYu
