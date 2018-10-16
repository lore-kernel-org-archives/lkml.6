Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185E4C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F372086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UdJ5Eggf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XiMqsblu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F372086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeJPXq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:46:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38592 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeJPXq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:46:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 503E761371; Tue, 16 Oct 2018 15:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539705322;
        bh=HwANtpuqMIdsyUS4oA2YYWn7x6qZYsPoJD2MJ3yp3cE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UdJ5EggfSjZFR2lfZ4rH/Z43v0Mv8Zy0kOl8HHw9Bpbsdig1JY8cfM8AAGDo/AB+K
         WjlwOAhnr/DZ2WKBXdoAHy7mzEcWASggHTngrgfHyuFRAshJd2+B4DZvyOjO2cGvjQ
         T6FQKAayJ6Y477dK52o+6FuZ/Xv3qdUoLV7EVJYo=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6762761330;
        Tue, 16 Oct 2018 15:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539705319;
        bh=HwANtpuqMIdsyUS4oA2YYWn7x6qZYsPoJD2MJ3yp3cE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XiMqsbluXzRayWXq4yhtduwlqM4Fx2hePUHu5OMmJLD1C4003uSVBoZThPzpMNnZL
         b6Gj846bE5oyLhOiCgZvtpOf8oQEb8r4Vz9mghRi7e8XMysBNwTU0cAoA74eH/yE8z
         UfXmRLQZxEeX+a0T/GTI9lZe6jyjofdXY4oRWgeE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 16 Oct 2018 21:25:19 +0530
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org
Subject: Re: [PATCH v11 0/5] Venus updates - PIL
In-Reply-To: <1539005572-803-1-git-send-email-vgarodia@codeaurora.org>
References: <1539005572-803-1-git-send-email-vgarodia@codeaurora.org>
Message-ID: <fb81c8b7946898bc61e9b8c793c74184@codeaurora.org>
X-Sender: vgarodia@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<A Friendly reminder for review>

On 2018-10-08 19:02, Vikash Garodia wrote:
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
>  .../devicetree/bindings/media/qcom,venus.txt       |  14 +-
>  drivers/media/platform/qcom/venus/core.c           |  24 ++-
>  drivers/media/platform/qcom/venus/core.h           |   6 +
>  drivers/media/platform/qcom/venus/firmware.c       | 235 
> +++++++++++++++++++--
>  drivers/media/platform/qcom/venus/firmware.h       |  17 +-
>  drivers/media/platform/qcom/venus/hfi_venus.c      |  13 +-
>  drivers/media/platform/qcom/venus/hfi_venus_io.h   |   8 +
>  7 files changed, 274 insertions(+), 43 deletions(-)
