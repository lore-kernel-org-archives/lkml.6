Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDB516256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20B120857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n5qefHqU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AxWsLrao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20B120857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732032AbeG3Tap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:30:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36528 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbeG3Tap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:30:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 377C362203; Mon, 30 Jul 2018 17:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532973278;
        bh=0cwkWdwykzc/a8M2VbANolm/HcVXf1tbfZ4qVKO2pfI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=n5qefHqUCnRejfeebyJGbyxEmkOU4Mbd9daIwL3hk+Hgnn8xa1AV3JXGh3di0lkRj
         uPorwJ69KvO28k+aQGYnZhR/vskQs+04lpYaRPoTCgVUUxj+4g+cwjSEBjBbq55n0H
         no6+OJD0NYsj6cPeN+DQuBOeO3tgjxQDIas6Wdw8=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F1BC5621C9;
        Mon, 30 Jul 2018 17:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532973277;
        bh=0cwkWdwykzc/a8M2VbANolm/HcVXf1tbfZ4qVKO2pfI=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=AxWsLraoEmx1P1uiO/Q2DhPG/P/hqaXiymP4rCwThlXsRh6kBXPHiIyK+iQd/aQNt
         aJ9wASfI63EcvmbpRh/Suh/y6KjT2DtCAgHkhmZlfRQcZgyFqI36NT7PGfLkznnR++
         ZXoxn2YzpINDP5OvBU8vVlZz9z0C7b9lySBzKuGI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F1BC5621C9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: remove redundant pointers 'dev' and 'noa'
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180709123446.14796-1-colin.king@canonical.com>
References: <20180709123446.14796-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180730175438.377C362203@smtp.codeaurora.org>
Date:   Mon, 30 Jul 2018 17:54:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King <colin.king@canonical.com> wrote:

> Pointers dev and noa are being assigned but are never used hence they
> are redundant and can be removed.
> 
> Cleans up clang warnings:
> warning: variable 'dev' set but not used [-Wunused-but-set-variable]
> warning: variable 'noa' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

e6712aa1244f ath10k: remove redundant pointers 'dev' and 'noa'

-- 
https://patchwork.kernel.org/patch/10514521/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

