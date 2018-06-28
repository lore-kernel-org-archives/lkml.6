Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96180C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9B02411F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hMQi3+T8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="R301iYuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9B02411F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935160AbeF1J3H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:29:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35798 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935103AbeF1J3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:29:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 63600608C8; Thu, 28 Jun 2018 09:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530178144;
        bh=3ODUuId7atWp+61PfCi0G9AGdJuPPxgwVserjUxgnro=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=hMQi3+T80OdGc2/HZbFw0K1gZwUIwQLUpV/5tfKzVYnCflRFPeX7cHGAt1NwJ8Gse
         WJhFoJ/9IMGid5GS/U98YYw0RlitVTiGSpgNNN8VJy29J1ViHSRNQYCqgA9Hr5A+2t
         onYmT1xodadfs/7JrSUhqfvD+y1AblWao6xdi8ks=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 808E460711;
        Thu, 28 Jun 2018 09:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530178143;
        bh=3ODUuId7atWp+61PfCi0G9AGdJuPPxgwVserjUxgnro=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=R301iYuBZhHBKjjPh+kYsH1NBb1LoKE8o82vaQnWUsuMSXK0+zH7rtm8O9fvqsjzj
         7+v4G6ozU+XEjTwj+HQjkb7abKvYThXkLZP3c68jpx2gkgvUNcQN5Yjmb27Z4QtWAJ
         FYJd1sBiLBfbwGc7QA75y6+hJgiYg+cW5oQjYDFE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 808E460711
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: wcn36xx: Remove Unicode Byte Order Mark from testcode
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1528375527-22761-1-git-send-email-geert@linux-m68k.org>
References: <1528375527-22761-1-git-send-email-geert@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Eyal Ilsar <eilsar@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180628092904.63600608C8@smtp.codeaurora.org>
Date:   Thu, 28 Jun 2018 09:29:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Older gcc (< 4.4) doesn't like files starting with a Unicode BOM:
> 
>     drivers/net/wireless/ath/wcn36xx/testmode.c:1: error: stray ‘\357’ in program
>     drivers/net/wireless/ath/wcn36xx/testmode.c:1: error: stray ‘\273’ in program
>     drivers/net/wireless/ath/wcn36xx/testmode.c:1: error: stray ‘\277’ in program
> 
> Remove the BOM, the rest of the file is plain ASCII anyway.
> 
> Output of "file drivers/net/wireless/ath/wcn36xx/testmode.c" before:
> 
>     drivers/net/wireless/ath/wcn36xx/testmode.c: C source, UTF-8 Unicode (with BOM) text
> 
> and after:
> 
>     drivers/net/wireless/ath/wcn36xx/testmode.c: C source, ASCII text
> 
> Fixes: 87f825e6e246cee0 ("wcn36xx: Add support for Factory Test Mode (FTM)")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Ramon Fried <ramon.fried@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-current branch of ath.git, thanks.

371d5e9d99e1 wcn36xx: Remove Unicode Byte Order Mark from testcode

-- 
https://patchwork.kernel.org/patch/10451875/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

