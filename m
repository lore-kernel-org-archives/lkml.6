Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EF8C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F90421C17
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Om1qo28D";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KeBrPd/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F90421C17
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbeHIHjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 03:39:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48214 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbeHIHjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 03:39:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 107B060B7A; Thu,  9 Aug 2018 05:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533791777;
        bh=oMvkwUoOO6u6u/Fb5pshNnBGM+UE53zkQDQW103xuOA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Om1qo28DGkQvCmBCMxVoD7bueHaA6PQKkuUCnzc3Yp2O79bsi+gMIEGEX+ZnmKWFd
         zGtSGlJkWzi9ztoNLRQvNqRLFA4/mSv/28DNJhjoUsO0yKqr5IoaRLMJL7fyBKWSD6
         yClLkCisA/D6omfBoB/qXTQShbqyKyx8Ts4eqdKM=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4937D60AD9;
        Thu,  9 Aug 2018 05:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533791776;
        bh=oMvkwUoOO6u6u/Fb5pshNnBGM+UE53zkQDQW103xuOA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KeBrPd/OouoydpiaDTybrwrVDXQwPQr897Uz1yGjvFSmtYPjv8eLdbtqeb5x1vmxL
         cjMKRR0PWpnO/AVl2fLXf1Azl0PmKKyWb43SGh5ZdFmBbZHRas1D8AZEt5StDz8Nva
         AZ7AAHh47XKbPLrajnJ7etwu7SyaYsvWgy37hFeU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4937D60AD9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     valdis.kletnieks@vt.edu
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] fix build for MediaTek MT7610U USB wireless dongle
References: <145751.1533759414@turing-police.cc.vt.edu>
Date:   Thu, 09 Aug 2018 08:16:12 +0300
In-Reply-To: <145751.1533759414@turing-police.cc.vt.edu> (valdis kletnieks's
        message of "Wed, 08 Aug 2018 16:16:54 -0400")
Message-ID: <87wot02k83.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

valdis.kletnieks@vt.edu writes:

> The mt76x0 driver requires the mt76 core driver to actually function.
> So add a 'select' to avoid embarrassing 'symbol unknown' errors
> when attempting to modprobe it in a module tree that doesn't
> include mt76.ko
>
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

I'll add "mt76:" prefix to the title and queue this for 4.19.

> Still need to figure out why it totally fails to see the 5gz band,
> it works find on 2.4 but ends up locked at 72mbits/sec. Works
> OK otherwise...

Great, thanks for the feedback.

-- 
Kalle Valo
