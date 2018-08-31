Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82D5C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DE32054F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RMyOil2M";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E4o/l07p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DE32054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbeHaT4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:56:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34578 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbeHaT4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:56:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9D0E96038E; Fri, 31 Aug 2018 15:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535730498;
        bh=lZlJTPavt0A+0INRTGKqsHoToP76mFeGF0RkRilhyNs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=RMyOil2MzyqUXnkkTSPZLphoIhn0Fjgc5oa+FDWWgjCljneZjxkKjvXJ4SF4hEpCG
         mEPCfQCA9iJZc6YZKWG/07OS/5AAOu5LAGqUypn96giPtyp069ryZFQRkPIGyPDZ+o
         lihfd7CUU2cTAad/Eo4SacLd3xPddZx8g/+dvoSA=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BA7766032C;
        Fri, 31 Aug 2018 15:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535730498;
        bh=lZlJTPavt0A+0INRTGKqsHoToP76mFeGF0RkRilhyNs=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=E4o/l07pZtNcZWL6N5foMSv/xofoM7EZUoalzDsZxgUjjL0PEsDMa5XLE1dRz4O5Q
         XymyQdavb29TnPhWjrfp58Ce6+9CWV0l+hg4ftJLgSN8ZBLZ9DcnRv4sYmIj8qdBD+
         f1xzO/OaPwduVX8RZTTo+cHTloc9Hawg8gMigUhQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA7766032C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcmfmac: fix wrong strnchr usage
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180822132215.27669-1-linux@rasmusvillemoes.dk>
References: <20180822132215.27669-1-linux@rasmusvillemoes.dk>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180831154818.9D0E96038E@smtp.codeaurora.org>
Date:   Fri, 31 Aug 2018 15:48:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> strnchr takes arguments in the order of its name: string, max bytes to
> read, character to search for. Here we're passing '\n' aka 10 as the
> buffer size, and searching for sizeof(buf) aka BRCMF_DCMD_SMLEN aka
> 256 (aka '\0', since it's implicitly converted to char) within those 10
> bytes.
> 
> Just interchanging the last two arguments would still leave a bug,
> because if we've been successful once, there are not sizeof(buf)
> characters left after the new value of p.
> 
> Since clmver is immediately afterwards passed as a %s argument, I assume
> that it is actually a properly nul-terminated string. For that case, we
> have strreplace().
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Patch applied to wireless-drivers-next.git, thanks.

cb18e2e9ec71 brcmfmac: fix wrong strnchr usage

-- 
https://patchwork.kernel.org/patch/10572951/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

