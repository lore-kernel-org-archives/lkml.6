Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 358ABC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1FB208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OuTKdGD4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kgi62gd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1FB208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936113AbeFNPNg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 11:13:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47840 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755166AbeFNPNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 11:13:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AF0636074D; Thu, 14 Jun 2018 15:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528989214;
        bh=UmH08nvdhLSE0N/tbTY9uXFPQCE++qBZ2TEARyb4EW0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=OuTKdGD4d4/tXwpfQBOQYJMvlohM81tkUAFqLMYT2+75F32c5LxFWILWLGBmhmBM4
         lZiWTeCmR1rSTRRFTAmmnBmttHHmozGt21aBCCH5eQUhSN1DwdNTpFQzWbTnizhILo
         tri0DJOZ9+I4hCPnkboS/faHZSdqKlOPltguzE0Y=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 169096022C;
        Thu, 14 Jun 2018 15:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528989214;
        bh=UmH08nvdhLSE0N/tbTY9uXFPQCE++qBZ2TEARyb4EW0=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=kgi62gd5+MXEJy7sufxooPzfrZevSdcKFZd7SF5cIshaPK/JGg48UHNLNlbviH8bZ
         2hiLRKLvNQsqlzF3t0Owob/Xwk10gcwL3M2bDrcYXLlfRCDpUzyWLa/yhrA1n4iXU7
         TTAla2b3elcBnbJN/bs9FwuZu+lykoWRnFbPDR8s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 169096022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: ath10k: use crash_dump enum instead of magic numbers
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180611181935.155032-1-briannorris@chromium.org>
References: <20180611181935.155032-1-briannorris@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Kalle Valo <kvalo@qca.qualcomm.com>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180614151334.AF0636074D@smtp.codeaurora.org>
Date:   Thu, 14 Jun 2018 15:13:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Norris <briannorris@chromium.org> wrote:

> The comments are telling you what the enum could tell you instead.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

7f8f72d8511a ath10k: use crash_dump enum instead of magic numbers

-- 
https://patchwork.kernel.org/patch/10458637/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

