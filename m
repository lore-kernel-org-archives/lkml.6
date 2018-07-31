Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531CCC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04AD7208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lXv9ytgo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XqgNoh3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04AD7208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbeGaIhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:37:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48470 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbeGaIhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:37:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0027C606DD; Tue, 31 Jul 2018 06:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533020315;
        bh=sZKoLjD3TB3Ed4ZkE4mtDWBgh/1p1ZBstu53CR+Ho5Y=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=lXv9ytgor4iVg5uqKfKceierHeIFqcQqfzBUw8sULtiOj2cDJV33hqq/habZEtXZ4
         7A+pq++6ud1OjPrDBE10o4uJlRxS2TMqm8IfWXMkjvQnlfAcd/kkOnfH63YacHCuxG
         JQmaDipNuWnxtH1ROWvqr088XSENJJ6aMRgSGdcs=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D80E560397;
        Tue, 31 Jul 2018 06:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533020314;
        bh=sZKoLjD3TB3Ed4ZkE4mtDWBgh/1p1ZBstu53CR+Ho5Y=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=XqgNoh3YGlhhLpyHpXmOiDRCKFvaZ12kipD5RZAavfODrZZRs9bpkjVqpWTCfCoWY
         LrVJTSTBy9244QW1z1ebQ0UtYehktBa6u19AcFhlzF4VVfQwudYKQXwT06IJxljXvK
         L7rit+cRmRW3ndaxWYz8Vk0LNP1iEant+iXqIx0k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D80E560397
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mwifiex: Fix skipped vendor specific IEs
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1532432847-2885-1-git-send-email-roman.stratiienko@globallogic.com>
References: <1532432847-2885-1-git-send-email-roman.stratiienko@globallogic.com>
To:     roman.stratiienko@globallogic.com
Cc:     akarwar@marvell.com, nishants@marvell.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sergei.shtylyov@cogentembedded.com,
        Roman Stratiienko <roman.stratiienko@globallogic.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180731065835.0027C606DD@smtp.codeaurora.org>
Date:   Tue, 31 Jul 2018 06:58:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

roman.stratiienko@globallogic.com wrote:

> From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> 
> Mwifiex firmware inserts only Microsoft information element
> Allow other vendor specific IEs to pass from userspace
> 
> Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>

When you submit a new version fo a patch please always add a version number to
the title and include a changelog:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#patch_version_missing

But this is for the future, no need to resend this patch.

-- 
https://patchwork.kernel.org/patch/10541923/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

