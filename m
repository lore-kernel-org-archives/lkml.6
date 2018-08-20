Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D931C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA9A21581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 14:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X9rGNPWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA9A21581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeHTRiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 13:38:11 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38615 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeHTRiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 13:38:11 -0400
Received: by mail-lf1-f67.google.com with SMTP id i7-v6so1463203lfh.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 07:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n7xp5JGqCgqHux3F1QscYajVK4o6g0A/p3dZSDH90jQ=;
        b=X9rGNPWt1tJ9EA6XYqXFJe3tUzltWHsm5f5AvCAy6uRDU9pdeHyy6FUfWWUhorcqIW
         XixrrY8PH53a9+Z9ZjoF5z1DNUpsumDlpIFI0B9s0KrRm2vgSt5nlNsyJA0HvyJS3PBI
         MVdQZ92g4FDbHHrya/nOxt2rj5StOQrJbtQ6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n7xp5JGqCgqHux3F1QscYajVK4o6g0A/p3dZSDH90jQ=;
        b=LS2Vud0azwEfW8nHjwzLmKgqljIRK9eSO63MBHI2FMwmVXKMTYa2wVzuxxQmUSXad4
         IPleC3E1dZQtV9I7Kjq/tWECKS3Nxi4qmt/8kTh15Xy0qmAimDWAqVN3j8JOub18SF4r
         4iw7+5xPq6xGrMcvjKe+18DZvtKX8X7l6xJIw6uHR8fkRISlK5LQPeKyqlzUFVDO04K4
         La3FAnA0ibRNlcjr66bDBjH2SIWLcW8z638tefh6G1yIES7D7mLbrH4NagW+PkY/7VmU
         aIoAYH6PAPXTJSGpZoVuoESeqISd4O6fV0KoL8PmNKaCMlqVFeNkm+rve1Af26e/SXii
         T5ZA==
X-Gm-Message-State: AOUpUlGc1sQTkTfOMDheqhrwSMx9uhB8rWN9EGvbt65GxzKzBPF2WAjC
        cGU4orndjx/4P1xCefo9rY3M3ag0Q0M6K5MjCmwOlw==
X-Google-Smtp-Source: AA+uWPw9TQZLJDIhRCbCkZ5Wa7o6VDCt4/57y8gOYvG87We7PxT3Qd/VgplyY6JeZM3BxmyYm/pv1en7OLHCivlW1iU=
X-Received: by 2002:a19:23c5:: with SMTP id j188-v6mr3897058lfj.137.1534774939821;
 Mon, 20 Aug 2018 07:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <1534770297-5242-1-git-send-email-igor.opaniuk@linaro.org>
In-Reply-To: <1534770297-5242-1-git-send-email-igor.opaniuk@linaro.org>
From:   Shawn Guo <shawn.guo@linaro.org>
Date:   Mon, 20 Aug 2018 22:21:58 +0800
Message-ID: <CAAQ0ZWS1X6=+tEzG48mOvGdA9NiwPE1ChafTPJM0dk-X3PuLUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mmc: dw_mmc: hi3798cv200: add MMC_CAP_CMD23 cap
To:     igor.opaniuk@linaro.org
Cc:     linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        tianshuliang <tianshuliang@hisilicon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 9:04 PM Igor Opaniuk <igor.opaniuk@linaro.org> wrote:
>
> Enable access to the RPMB on the on-board eMMC of the
> Poplar board.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
