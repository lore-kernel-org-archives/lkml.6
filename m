Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16662C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FD9224E6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hrC8Scdu";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kiwYVR3R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FD9224E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753172AbeGDPPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:15:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37502 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752145AbeGDPOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:14:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B581360B19; Wed,  4 Jul 2018 15:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530717270;
        bh=VesZxyDLpOrNF6gHlDoLFWcHbuwVjHUK8lwMIX+vzio=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=hrC8ScdudoOCqZEt5uR4phuzFzaDnZEEEwtVz9SC3na0nMVQCc/sFzNKHcqYOXdEp
         P0Ni1BiM9WpNLQz9+nTg+yf3ghtRJiCtVsxfIKiVsuMRYKQI89DyMbYERvrHb0SBd0
         vDos4GosgG27cNQjX50bRldYd8HfbhX+/wkNXrXs=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 893C76037C;
        Wed,  4 Jul 2018 15:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530717270;
        bh=VesZxyDLpOrNF6gHlDoLFWcHbuwVjHUK8lwMIX+vzio=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=kiwYVR3RSBP4802WlYfwb9UJub/qDCPZMoY1xgiJIu7d4p7cDefaCZtgQAvCaaAY9
         dYsBQWIgz6rQPhSPhpHWKv2fZIOah495KxIb3ZQwWBCENcxUEHt7PtAKfEbb14dm+F
         fjVahEYu5ymAqKgMlMgXJT8GvxB9aDjMBOrjVQ24=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 893C76037C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wlcore: Fix memory leak in wlcore_cmd_wait_for_event_or_timeout
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180628130809.GA8147@embeddedor.com>
References: <20180628130809.GA8147@embeddedor.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180704151430.B581360B19@smtp.codeaurora.org>
Date:   Wed,  4 Jul 2018 15:14:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> In case memory resources for *events_vector* were allocated, release
> them before return.
> 
> Addresses-Coverity-ID: 1470194 ("Resource leak")
> Fixes: 4ec7cece87b3 ("wlcore: Add missing PM call for wlcore_cmd_wait_for_event_or_timeout()")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Acked-by: Tony Lindgren <tony@atomide.com>

Patch applied to wireless-drivers-next.git, thanks.

04614fe46f31 wlcore: Fix memory leak in wlcore_cmd_wait_for_event_or_timeout

-- 
https://patchwork.kernel.org/patch/10493849/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

