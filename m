Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE6DC71134
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC8F2089E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jSyR0joi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Y/I0ulsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC8F2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeJOXJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:09:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55828 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeJOXJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 19:09:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B67B160B11; Mon, 15 Oct 2018 15:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539617007;
        bh=nyjN7qq1PvtguNg4Y6PxoqcBtH3pcL+JZC3w707cLGU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jSyR0joislUEfxn4CXToS9t/MeRRoRlirAmevnt91yZw/nkNL5/PlcBR1S+YnAAgL
         SJrL4qA0t6EgY38ANZRjedWgcAOIOzzaDADYVxupB77Vzb71W/BOF9fvxeX8wN7Grx
         /8JyyBAQSfV/z3tTOze9F6g+un+IARB6Jzt9OQPA=
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2038F60B11;
        Mon, 15 Oct 2018 15:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539617005;
        bh=nyjN7qq1PvtguNg4Y6PxoqcBtH3pcL+JZC3w707cLGU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y/I0ulsv92+J6FyJNyhdBw+BkBslCnYAdblaCKwnb71lYcV/MHiNw7jnrkHkw1Y2y
         dm+OaJHwGLG47kBC5qPhXyY2cxUqvxadVjeRRQz4nENHcjIS4XHf+Ry2w1hGDZfMQC
         RXl8VAvFBK9SAxGT8SsX1yiSQ5NwukqSwoaA9gv4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2038F60B11
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Received: by mail-qk1-f169.google.com with SMTP id p6-v6so12075390qkg.1;
        Mon, 15 Oct 2018 08:23:25 -0700 (PDT)
X-Gm-Message-State: ABuFfoh24pd4RCVkt6rSKnG2ZViZdxHulKudFLOqp0m+rHR1ryP8Zcd0
        cY79Xt3YSFXKOpmyP/wAFNuJUaarhl024HCrtYE=
X-Google-Smtp-Source: ACcGV60BSWPVdmquTX0WJHaZe+qe7nooFtH0O77n/YKHZsiGMC+zeeyV/0RErhuCYOd8XX2xQxw2PYty3LG0/fLIx3w=
X-Received: by 2002:a37:6388:: with SMTP id x130-v6mr16052393qkb.118.1539617004202;
 Mon, 15 Oct 2018 08:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20181012213926.253765-1-dianders@chromium.org>
In-Reply-To: <20181012213926.253765-1-dianders@chromium.org>
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
Date:   Mon, 15 Oct 2018 20:53:12 +0530
X-Gmail-Original-Message-ID: <CAFp+6iFy8V34cs6pEOie_tBX5wJqM7teUnH_XLLZ7cioPrX_hA@mail.gmail.com>
Message-ID: <CAFp+6iFy8V34cs6pEOie_tBX5wJqM7teUnH_XLLZ7cioPrX_hA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: ufs: Fix the compatible string definition
To:     Doug Anderson <dianders@chromium.org>
Cc:     "robh+dt" <robh+dt@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Can Guo <cang@codeaurora.org>, evgreen@chromium.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        sayalil@codeaurora.org, asutoshd@codeaurora.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, liwei213@huawei.com,
        open list <linux-kernel@vger.kernel.org>, malat@debian.org,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Sat, Oct 13, 2018 at 3:09 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> If you look at the bindings for the UFS Host Controller it says:
>
> - compatible: must contain "jedec,ufs-1.1" or "jedec,ufs-2.0", may
>               also list one or more of the following:
>                  "qcom,msm8994-ufshc"
>                  "qcom,msm8996-ufshc"
>                  "qcom,ufshc"
>
> My reading of that is that it's fine to just have either of these:
> 1. "qcom,msm8996-ufshc", "jedec,ufs-2.0"
> 2. "qcom,ufshc", "jedec,ufs-2.0"
>
> As far as I can tell neither of the above is actually a good idea.
>
> For #1 it turns out that the driver currently only keys off the
> compatible string "qcom,ufshc" so it won't actually probe.
>
> For #2 the driver won't probe but it's not a good idea to keep the SoC
> name out of the compatible string.
>
> Let's update the compatible string to make it really explicit.  We'll
> include a nod to the existing driver and the old binding and say that
> we should always include the "qcom,ufshc" string in addition to the
> SoC compatible string.
>
> While we're at it we'll also include another example SoC known to have
> UFS: sdm845.
>
> Fixes: 47555a5c8a11 ("scsi: ufs: make the UFS variant a platform device")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt       | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> index 2df00524bd21..69a06a1b732e 100644
> --- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> +++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> @@ -4,11 +4,14 @@ UFSHC nodes are defined to describe on-chip UFS host controllers.
>  Each UFS controller instance should have its own node.
>
>  Required properties:
> -- compatible           : must contain "jedec,ufs-1.1" or "jedec,ufs-2.0", may
> -                         also list one or more of the following:
> -                                         "qcom,msm8994-ufshc"
> -                                         "qcom,msm8996-ufshc"
> -                                         "qcom,ufshc"
> +- compatible           : must contain "jedec,ufs-1.1" or "jedec,ufs-2.0"
> +
> +                         For Qualcomm SoCs must contain, as below, an
> +                         SoC-specific compatible along with "qcom,ufshc" and
> +                         the appropriate jedec string:
> +                           "qcom,msm8994-ufshc", "qcom,ufshc", "jedec,ufs-2.0"
> +                           "qcom,msm8996-ufshc", "qcom,ufshc", "jedec,ufs-2.0"
> +                           "qcom,sdm845-ufshc", "qcom,ufshc", "jedec,ufs-2.0"

Thanks for the patch. It looks good to me.
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>

P.S.: While you are at it, can you please move 'ufs-qcom.txt'
to Documentation/devicetree/bindings/phy/qcom,ufs-phy.txt.
The current name and file location is misleading.

Thanks & Regards
Vivek

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
