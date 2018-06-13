Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1E82FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F84208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IRtLfZ4Y";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Z8YGnyrs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F84208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935156AbeFMJ4K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:56:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47960 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934279AbeFMJ4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:56:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5048C606DB; Wed, 13 Jun 2018 09:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528883768;
        bh=cwXDZjf0VI/k25MlgHjqTx0zEFXMzMvnL67qhaZHSx0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=IRtLfZ4YFIMmweVBm+kFehwC6MK4Oiv1tCPmB7cnqjbD00dSaySe9RM2N5FlhAVYp
         zqfB2ibIk2eJz4Vb24QUbDI9a0QUtL0NdCqKEna40PQfAjvBLUYubclguASCTP2w+j
         I6CMio9dFdNTcp8Ceqg8ID6FmRAlcloYHiyJjXPs=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 09B81602BC;
        Wed, 13 Jun 2018 09:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528883767;
        bh=cwXDZjf0VI/k25MlgHjqTx0zEFXMzMvnL67qhaZHSx0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Z8YGnyrszOa0LLyXf2Sj5JbdPFNrLKxVZRLBySFLrtNzAruGw3aP6P2M9V0zRHuQa
         l1ID46Pwl2o3uJV7Qhpg5aoPoEgpJjTP9UnGMojr+W5MkhVnGGOd6J6Uj7j3s0jjOI
         ailo/FFIwz6Vlpnqcnsb3CN/rZ+y49LEl1YITIEQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 09B81602BC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>, kbuild-all@01.org,
        "David S. Miller" <davem@davemloft.net>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ath10k: allow ATH10K_SNOC with COMPILE_TEST
References: <20180612113907.15043-2-niklas.cassel@linaro.org>
        <201806122228.8vAQXcD6%fengguang.wu@intel.com>
Date:   Wed, 13 Jun 2018 12:56:02 +0300
In-Reply-To: <201806122228.8vAQXcD6%fengguang.wu@intel.com> (kbuild test
        robot's message of "Tue, 12 Jun 2018 22:50:37 +0800")
Message-ID: <87h8m7au31.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild test robot <lkp@intel.com> writes:

> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on ath6kl/ath-next]
> [also build test WARNING on next-20180612]
> [cannot apply to v4.17]
> [if your patch is applied to the wrong git tree, please drop us a note
> to help improve the system]
>
> url:
> https://github.com/0day-ci/linux/commits/Niklas-Cassel/ath10k-do-not-mix-spaces-and-tabs-in-Kconfig/20180612-194241
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git ath-next
> reproduce:
>         # apt-get install sparse
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF=-D__CHECK_ENDIAN__
>
>
> sparse warnings: (new ones prefixed by >>)
>
>>> drivers/net/wireless/ath/ath10k/snoc.c:823:5: sparse: symbol
>>> 'ath10k_snoc_get_ce_id_from_irq' was not declared. Should it be
>>> static?
>>> drivers/net/wireless/ath/ath10k/snoc.c:871:6: sparse: symbol
>>> 'ath10k_snoc_init_napi' was not declared. Should it be static?
>
> Please review and possibly fold the followup patch.

There's already a patch pending to fix these:

ath10k: make some functions static

https://patchwork.kernel.org/patch/10440159/

-- 
Kalle Valo
