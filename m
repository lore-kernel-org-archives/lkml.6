Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B03C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 05:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8402172D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 05:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UyniyzfB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UyniyzfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8402172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbeHUJKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:10:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53988 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeHUJKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:10:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AD15D6143F; Tue, 21 Aug 2018 05:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534830716;
        bh=hp0huJ5MZ2rp9oEBtBSYbHnDh90I6IiiyLKXBCgNTbk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UyniyzfBvwt+9Oj7FqWRi3Ga9YGYIqppCsmz/G9g/qOcaCKvsePFVF8Vus0uNvxGE
         BtxhZUEQuM8Hz4DVU+JDbX3bcIeBz84tKO0KzKSHPO8FqhcNThJta/E5PtmBEE+uqo
         NB8wguc8ne2ppK3ruT7U23Zp/NbJqxUy7O//dHhw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 1815E609A1;
        Tue, 21 Aug 2018 05:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534830716;
        bh=hp0huJ5MZ2rp9oEBtBSYbHnDh90I6IiiyLKXBCgNTbk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UyniyzfBvwt+9Oj7FqWRi3Ga9YGYIqppCsmz/G9g/qOcaCKvsePFVF8Vus0uNvxGE
         BtxhZUEQuM8Hz4DVU+JDbX3bcIeBz84tKO0KzKSHPO8FqhcNThJta/E5PtmBEE+uqo
         NB8wguc8ne2ppK3ruT7U23Zp/NbJqxUy7O//dHhw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 21 Aug 2018 11:21:56 +0530
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, acourbot@chromium.org,
        linux-media-owner@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Venus updates - PIL
In-Reply-To: <1533562085-8773-1-git-send-email-vgarodia@codeaurora.org>
References: <1533562085-8773-1-git-send-email-vgarodia@codeaurora.org>
Message-ID: <1cf867118f803a359b258dcc823e1442@codeaurora.org>
X-Sender: vgarodia@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<Friendly reminder for review>

On 2018-08-06 18:58, Vikash Garodia wrote:
> Hello,
> 
> Here is v4 with following comments addressed:
> 
> * inline function for setting suspend and resume.
> * keep firmware size as 6 MB.
> * comments related to indentation, cleanup, etc.
> 
> As per comments from Bjorn, qcom_mdt_load_no_init is being used in this
> patch series to align with 
> https://patchwork.kernel.org/patch/10397889/.
> 
> Comments are welcome!
> 
> Vikash Garodia (4):
>   venus: firmware: add routine to reset ARM9
>   venus: firmware: move load firmware in a separate function
>   venus: firmware: add no TZ boot and shutdown routine
>   venus: firmware: register separate driver for firmware device
> 
>  .../devicetree/bindings/media/qcom,venus.txt       |  17 +-
>  drivers/media/platform/qcom/venus/core.c           |  60 +++++--
>  drivers/media/platform/qcom/venus/core.h           |   7 +
>  drivers/media/platform/qcom/venus/firmware.c       | 192 
> ++++++++++++++++++---
>  drivers/media/platform/qcom/venus/firmware.h       |  17 +-
>  drivers/media/platform/qcom/venus/hfi_venus.c      |  13 +-
>  drivers/media/platform/qcom/venus/hfi_venus_io.h   |   6 +
>  7 files changed, 268 insertions(+), 44 deletions(-)
