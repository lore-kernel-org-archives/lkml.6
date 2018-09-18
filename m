Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF6DC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343022133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Uu32mj2F";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Uu32mj2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343022133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbeISFUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 01:20:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44318 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeISFUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 01:20:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B2F3A607F7; Tue, 18 Sep 2018 23:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537314338;
        bh=GrMKHQbvjrvLt+Il+xFZNYDXaET2eaFc6U/PQopNfIY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Uu32mj2FPEb7hrkgqf8+jCnDaEcxHFvyxTDyjmofRB1y7xxN/AglvFD6UlMKTBn3q
         EiYs/5bYxAQL51vYYA0YQWT7DWgj4APQ12PLV/yfhIOJ8HJLFSjU0mrgk1Fh7TRppb
         q7mZ+HYDgBC4M9v1rmmsL1ZDb7C1sK4obdU/+w+I=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 17582600ED;
        Tue, 18 Sep 2018 23:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537314338;
        bh=GrMKHQbvjrvLt+Il+xFZNYDXaET2eaFc6U/PQopNfIY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Uu32mj2FPEb7hrkgqf8+jCnDaEcxHFvyxTDyjmofRB1y7xxN/AglvFD6UlMKTBn3q
         EiYs/5bYxAQL51vYYA0YQWT7DWgj4APQ12PLV/yfhIOJ8HJLFSjU0mrgk1Fh7TRppb
         q7mZ+HYDgBC4M9v1rmmsL1ZDb7C1sK4obdU/+w+I=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Sep 2018 05:15:38 +0530
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, acourbot@chromium.org
Subject: Re: [PATCH v8 0/5] Venus updates - PIL
In-Reply-To: <1537307954-9729-1-git-send-email-vgarodia@codeaurora.org>
References: <1537307954-9729-1-git-send-email-vgarodia@codeaurora.org>
Message-ID: <72fb5d7d570c7f5520cc304bea800ae6@codeaurora.org>
X-Sender: vgarodia@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore the v8 of this series. The code that was modified was added to 
wrong
patchset while handling the git rebase.
Please review the version 9.

On 2018-09-19 03:29, Vikash Garodia wrote:
> This series just fixes the compilation for of_dma_configure.
> Minor #define name improvement and indentations.
> 
> Stanimir Varbanov (1):
>   venus: firmware: register separate platform_device for firmware 
> loader
> 
> Vikash Garodia (4):
>   venus: firmware: add routine to reset ARM9
>   venus: firmware: move load firmware in a separate function
>   venus: firmware: add no TZ boot and shutdown routine
>   dt-bindings: media: Document bindings for venus firmware device
> 
>  .../devicetree/bindings/media/qcom,venus.txt       |  13 +-
>  drivers/media/platform/qcom/venus/core.c           |  24 ++-
>  drivers/media/platform/qcom/venus/core.h           |   6 +
>  drivers/media/platform/qcom/venus/firmware.c       | 234 
> +++++++++++++++++++--
>  drivers/media/platform/qcom/venus/firmware.h       |  17 +-
>  drivers/media/platform/qcom/venus/hfi_venus.c      |  13 +-
>  drivers/media/platform/qcom/venus/hfi_venus_io.h   |   8 +
>  7 files changed, 272 insertions(+), 43 deletions(-)
