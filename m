Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61AFC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8A62087F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8A62087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeH2CI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:08:58 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44745 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbeH2CI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:08:58 -0400
Received: by mail-oi0-f66.google.com with SMTP id l82-v6so5679535oih.11;
        Tue, 28 Aug 2018 15:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q92o+/MTFzemYB+oF9CFOWkQs2qQg3w8xxD+zSEfsrA=;
        b=WJnNrxfZ05A64Byr8k1BbVPwdr8OVy+XRFGG3oCgkxr8zBKLc/HvIdUokaW92M+NH4
         WyyvNsVT294ZeBMGiTItAEMLsuuL6ffo7wDlOa5/nPqrbyWH7cd/M+rpvXF6mYCrsNLF
         g4dvyKpfakSIvcrDZpI/gyZEcg0cEf0UY/O7k3fL9cSb7TRg3VaAQw1D1oIlb28PVbG4
         oR6dl2/hDk4ISAtU2X/H9m5ChVD0/FisSOOJL8thOucP8fUQbKZL60tqDDHmqSUt0Igs
         H4c/jYrQPYU4xs9IMZMdt+2ldFvJQDU0Rz5tqb9+zt+T0BiTwknQFpNx1qDW4u5c4Wxp
         1m0g==
X-Gm-Message-State: APzg51BnMmdmkYX4VFdhfhOV2AY9Ul79hnlnvPVh4tpvYcVaypEYlgDF
        JAnIr9HyljRT+18GCNHwNg==
X-Google-Smtp-Source: ANB0VdakDDlIturEJm8KIDUD9Q7hU8eoL/AFD8y36+bOK60ZmHI4WREx/3nYrp+p6oQfVTjRs7QumA==
X-Received: by 2002:aca:f0d4:: with SMTP id o203-v6mr52632oih.21.1535494516194;
        Tue, 28 Aug 2018 15:15:16 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v202-v6sm1445519oie.47.2018.08.28.15.15.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 15:15:15 -0700 (PDT)
Date:   Tue, 28 Aug 2018 17:15:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vikash Garodia <vgarodia@codeaurora.org>
Cc:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        arnd@arndb.de, bjorn.andersson@linaro.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, acourbot@chromium.org
Subject: Re: [PATCH v6 4/4] venus: firmware: register separate
 platform_device for firmware loader
Message-ID: <20180828221514.GA8820@bogus>
References: <1535034528-11590-1-git-send-email-vgarodia@codeaurora.org>
 <1535034528-11590-5-git-send-email-vgarodia@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535034528-11590-5-git-send-email-vgarodia@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 07:58:48PM +0530, Vikash Garodia wrote:
> From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> 
> This registers a firmware platform_device and associate it with
> video-firmware DT subnode. Then calls dma configure to initialize
> dma and iommu.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  .../devicetree/bindings/media/qcom,venus.txt       | 13 +++++-

In the future, please split binding patches.

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/media/platform/qcom/venus/core.c           | 14 +++++--
>  drivers/media/platform/qcom/venus/firmware.c       | 49 ++++++++++++++++++++++
>  drivers/media/platform/qcom/venus/firmware.h       |  2 +
>  4 files changed, 73 insertions(+), 5 deletions(-)
