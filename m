Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800D5C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363C221E1F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hc9RSpoq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IuA5hlkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363C221E1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732622AbeHIRlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:41:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47240 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731793AbeHIRlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:41:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6A1BE60B23; Thu,  9 Aug 2018 15:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533827773;
        bh=AAB9tZhtA+Uh2rBTTGhGDEmyv3m28TyRGMU5Qlk+GyA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=hc9RSpoqMo2cnfGuV+DaFXAVOdKIY4TK6ZCRBR4OSO3Y8NBJL3o1zYdAt1OmdSGXq
         29LPOWoYgKXsX+K4x2V/ewCcadihm9OaY/LRpHtb5ekIaJPbXdkVq1Xh0f0IMwU6aW
         hdVuub+c0Z826XeJSxz5IhFVBrdqsXYqNoXYCSZw=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D739C60B74;
        Thu,  9 Aug 2018 15:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533827762;
        bh=AAB9tZhtA+Uh2rBTTGhGDEmyv3m28TyRGMU5Qlk+GyA=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=IuA5hlkXK3lSD3usy0ZxofW6Fib1mbtLIlcSIbiXIQNE6H8l1Y2RcUKpmAuLOGOAi
         BF3EhIPDfkQak8SE+bokrlmiWcFGPoHcXUssAihXxZosWTnaelHEHu5J+bktwH26Np
         bwc5Qjd8/9OlhxfopqCemLu975cyW+QVkYJUU4qc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D739C60B74
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ssb: driver_gige: use true and false for boolean values
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180805000453.GA19115@embeddedor.com>
References: <20180805000453.GA19115@embeddedor.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Michael Buesch <m@bues.ch>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180809151613.6A1BE60B23@smtp.codeaurora.org>
Date:   Thu,  9 Aug 2018 15:16:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> Return statements in functions returning bool should use true or false
> instead of an integer value.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Reviewed-by: Michael Buesch <m@bues.ch>

Patch applied to wireless-drivers-next.git, thanks.

c7743c428111 ssb: driver_gige: use true and false for boolean values

-- 
https://patchwork.kernel.org/patch/10555985/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

