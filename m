Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3687C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81BBA20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfSDZT5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81BBA20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeJPXBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:01:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeJPXBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:01:12 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 307B32145D;
        Tue, 16 Oct 2018 15:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539702618;
        bh=MH1CHJW234BPXNzpLzthAv6AhbCcCscU0nSrlmg4ANk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TfSDZT5hYAfG0vvomVv0Arxa4Ud2Mb+ig5LV7Xu+3rPD2FKeLbwVuc5kTKz8dxlSW
         Qj38OawQaB7/b99Wo8mq8xAwzJD6zA6CpqzYtjdI9IkeIjSLXHTJhjzEdSzh9TgjCP
         jX6hwXApHPPYFjTkIyb0h9AKdZdCk7cn/qGr4MEI=
Received: by mail-wm1-f48.google.com with SMTP id 143-v6so22682778wmf.1;
        Tue, 16 Oct 2018 08:10:18 -0700 (PDT)
X-Gm-Message-State: ABuFfohAbLXVeq8auNkd20cOieJzwQ57dr0N6/MLltz403ZoJu0g4ESW
        rgXm5b5Vqfjy96Wn2eUs6OjvJJbYxkXXPiJXGoU=
X-Google-Smtp-Source: ACcGV63KbVbq4MG0XRosMdyes23xDa+Urwwbp7ajn0QvsECvECC868cxRijyODh8L8Mp/A/JjVyM1qS3pJ7kI8NN3Aw=
X-Received: by 2002:a1c:ab54:: with SMTP id u81-v6mr16807601wme.45.1539702616630;
 Tue, 16 Oct 2018 08:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181016145648eucas1p275ad5f845a04e40e5b9d0bbea624f34a@eucas1p2.samsung.com>
 <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com> <20181016145648eucas1p275ad5f845a04e40e5b9d0bbea624f34a~eHqM4Yhz82489624896eucas1p25@eucas1p2.samsung.com>
In-Reply-To: <20181016145648eucas1p275ad5f845a04e40e5b9d0bbea624f34a~eHqM4Yhz82489624896eucas1p25@eucas1p2.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 16 Oct 2018 17:10:05 +0200
X-Gmail-Original-Message-ID: <CAJKOXPemhDTF7moU4H=PS=6ZZZRDR7Mobo0Z+-kBd_hw0vB1kw@mail.gmail.com>
Message-ID: <CAJKOXPemhDTF7moU4H=PS=6ZZZRDR7Mobo0Z+-kBd_hw0vB1kw@mail.gmail.com>
Subject: Re: [PATCH 07/11] DT: arm64: exynos7: add support for thermal trip irq-mode
To:     l.luba@partner.samsung.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 at 16:56, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> This patch adds support for new flash which indicates
> that trip point triggers irq when temperature is met.
> Exynos5433 supports 8 trip point which will trigger irq.

Exynos7?

Beside that comments from previous email apply (no need to duplicate them).

Best regards,
Krzysztof
