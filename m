Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F88C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00CE21990
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="R/zNHccA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Mz13XSLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00CE21990
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732495AbeHIRib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:38:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45458 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731227AbeHIRib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:38:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 980EC60BEA; Thu,  9 Aug 2018 15:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533827589;
        bh=+5YmBGoxBzglvOJam5bqloGLtr/uxMrtpuEjA3zsWVM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=R/zNHccAaXLaRl/COIBK1Bgasbp945GEtplOoXWD9Lc175Ozanjqd7b4bUlqqUrBw
         qXylz6hNKw3KEkG0lmhtHy8KCmE2N9ZBsEWeKPllN/IXUHjULvBGJtGAGxvDUT8dBY
         fC1tirn+pd/2Ba9Gw/THVfP91Jf69TcJibm6kgrQ=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7C2F560C60;
        Thu,  9 Aug 2018 15:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533827588;
        bh=+5YmBGoxBzglvOJam5bqloGLtr/uxMrtpuEjA3zsWVM=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=Mz13XSLPPa8t/QD2DeRut9mm+jL4d4EPjG7B2AZzciTcs7L+afDrMkWdLqwzmPMj0
         jK9lb9pfS2Q7bd3GQG6yJ9OgyMIy6ybUbJDD89U7nGCJZ32wu5eEot7Ju5qs5TX5Sh
         cOJufhLubVcCOAHwVRb+t0ylH3CkCt8sbjiEan/s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7C2F560C60
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mt76: fix build for MediaTek MT7610U USB wireless dongle
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <145751.1533759414@turing-police.cc.vt.edu>
References: <145751.1533759414@turing-police.cc.vt.edu>
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180809151309.980EC60BEA@smtp.codeaurora.org>
Date:   Thu,  9 Aug 2018 15:13:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis Kletnieks <valdis.kletnieks@vt.edu> wrote:

> The mt76x0 driver requires the mt76 core driver to actually function.
> So add a 'select' to avoid embarrassing 'symbol unknown' errors
> when attempting to modprobe it in a module tree that doesn't
> include mt76.ko
> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

Patch applied to wireless-drivers-next.git, thanks.

1ec49a236565 mt76: fix build for MediaTek MT7610U USB wireless dongle

-- 
https://patchwork.kernel.org/patch/10560477/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

