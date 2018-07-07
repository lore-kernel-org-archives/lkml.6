Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BBDC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C3621A61
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXh/xgIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C3621A61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753630AbeGGLEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 07:04:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37510 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbeGGLET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 07:04:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id v9-v6so559903ljk.4;
        Sat, 07 Jul 2018 04:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jOiME9o6E3e8xTQrEajxP9m/fpIFn8QIBG3vVt2G7LM=;
        b=FXh/xgIrsOnbs6TkvJgSrk6IhEl6rfMWLlGqihj93ttgU/ehn8U5TFEe++/JztCHSi
         pIoqh/sAxRmBzZ7ibF+bnymJEv047rkyo2hkZtR3b26swVtFLttJEOX/BCFsxjJ7bY/G
         CxkMDnG8LRAgtuR1E8VwxIBlExl+WBteoxFvULhT/nbRAmOXgbA2qbMw8htllXl180/t
         +k307cAYfh+LwJJ+urmyE0tHmUfV8whpXTMNdWYQ5l5pJwXh+KNDZAZlJ7YXR6xW9b9l
         hxNC5hOCe95aYeSS3pqiexHfdNnifwhsSLXFehAtPjZzx5RV0zoBXCXSbsvoFItzhR9A
         olOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jOiME9o6E3e8xTQrEajxP9m/fpIFn8QIBG3vVt2G7LM=;
        b=khBv+8FVUnK0EiCCOMphEaMIz5riteH4g01RS1mCDYwkuKvMKF1KRye6nXUuqMrRPd
         Q1aK5zk1nLIUHPhG/YxC8aZJQdwcxc8DuuddSfyK6RJtMIqNDVsNMZcDwQbBNYIWlnFV
         SZZj1XBGq3s1PKgQAR4WMO55XPgXURySlq6SFZQ6SA5vigphQ5FHET3rKPoWxepxn0dP
         mi/PHE9CRZDNJB7tT16WTOjZVWkBHMnpfO6FHvLLyLxmkBgpCco3ifdjwd3i1RXp+2IT
         Zg/EhYK8rzM6wJletp499g2tWK2z8u/aT110nBc4EvspPfihiL1mmEgRFM2bjYCta6UB
         X/Sg==
X-Gm-Message-State: APt69E07sCi2Lw6gbp9NwUzIq+WhQvMoKiX+c7ogg3aZHMr22vu1ZUb+
        9E+xqMioDdA0J5+GS3+ru2JFEB5r
X-Google-Smtp-Source: AAOMgpdCqnL7vutIDtM/EOBRay++LOzPiQHGnKiqI6Jm3oWxfnmGSofoQrE6H/MTapooHRWfLQQBgw==
X-Received: by 2002:a2e:7113:: with SMTP id m19-v6mr8396827ljc.66.1530961457774;
        Sat, 07 Jul 2018 04:04:17 -0700 (PDT)
Received: from dimapc.localnet (109-252-91-84.nat.spd-mgts.ru. [109.252.91.84])
        by smtp.gmail.com with ESMTPSA id b14-v6sm2316015lfa.62.2018.07.07.04.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 04:04:17 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] ARM: dts: tegra20: Add Memory Client reset to VDE
Date:   Sat, 07 Jul 2018 14:04:08 +0300
Message-ID: <13312712.2eTibFZX3d@dimapc>
In-Reply-To: <20180520134846.31046-1-digetx@gmail.com>
References: <20180520134846.31046-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 20 May 2018 16:48:44 MSK Dmitry Osipenko wrote:
> Hook up Memory Client reset of the Video Decoder to the decoders DT node.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Thierry, is there anything I could do in order to get these patches applied?


