Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E7BC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B49720878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ijOT99EE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ijOT99EE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B49720878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbeJHUq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:46:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48628 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbeJHUq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:46:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B56666078C; Mon,  8 Oct 2018 13:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539005681;
        bh=2AWTHAa4UqQDaKLnvdrWBAtIXRD+MVgSJ7EI9goPDNo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ijOT99EEFPrvliZgLP4ep0JjzuUWzK4w8XenWJd7zC8xZA4Y64P6/UE64QWZaQ3el
         ax4CQkv2qvtvo+pA+MNF5IGx0tFp2HLZ8lDMxMeNr6xS4wbsu4V8dnxy7L2PE1/NoM
         /hlIKgYjwtTLqlVMGz9rZghP6U00EagA93UEBVDA=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 28D586078C;
        Mon,  8 Oct 2018 13:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539005681;
        bh=2AWTHAa4UqQDaKLnvdrWBAtIXRD+MVgSJ7EI9goPDNo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ijOT99EEFPrvliZgLP4ep0JjzuUWzK4w8XenWJd7zC8xZA4Y64P6/UE64QWZaQ3el
         ax4CQkv2qvtvo+pA+MNF5IGx0tFp2HLZ8lDMxMeNr6xS4wbsu4V8dnxy7L2PE1/NoM
         /hlIKgYjwtTLqlVMGz9rZghP6U00EagA93UEBVDA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Oct 2018 19:04:41 +0530
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        linux-media-owner@vger.kernel.org
Subject: Re: [PATCH v10 0/5] Venus updates - PIL
In-Reply-To: <1539004982-32555-1-git-send-email-vgarodia@codeaurora.org>
References: <1539004982-32555-1-git-send-email-vgarodia@codeaurora.org>
Message-ID: <20bef432f5c7c98e6fc623efdded8c94@codeaurora.org>
X-Sender: vgarodia@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this version. Forgot to update the documentation.
Updated the same in v11 and posted it.

On 2018-10-08 18:52, Vikash Garodia wrote:
> This version of the series
> * extends the description of firmware subnode in documentation.
> * renames the flag suggesting the presence of tz and update code
>   accordingly.
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
>  drivers/media/platform/qcom/venus/firmware.c       | 235 
> +++++++++++++++++++--
>  drivers/media/platform/qcom/venus/firmware.h       |  17 +-
>  drivers/media/platform/qcom/venus/hfi_venus.c      |  13 +-
>  drivers/media/platform/qcom/venus/hfi_venus_io.h   |   8 +
>  7 files changed, 273 insertions(+), 43 deletions(-)

Thanks,
Vikash
