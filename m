Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE823C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CB0244CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dFAlkE9b";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="il6l0jmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CB0244CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932648AbeGDJ7Q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:59:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46990 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753046AbeGDJ7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:59:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 85B7F60131; Wed,  4 Jul 2018 09:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530698353;
        bh=PRUIgUWyONj7YqXg0IIRGiJzfeXSkPiHfpheP0vzTNE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=dFAlkE9bgslZGXNXBFus0RTGbLk39e32m6BDGcEJjhRPDpj4p3oY3D74aVjlUqGNm
         dpitlst2H9f39WgcwwRbZEI0ehvfpU8dNbsCDTrHQGLjTcFkLfhjPtXYziXO77M3S8
         mI+lbY6lqQSMAxA/WR+qyH6drsqO6QEUU9MML1bQ=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 80C396031A;
        Wed,  4 Jul 2018 09:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530698353;
        bh=PRUIgUWyONj7YqXg0IIRGiJzfeXSkPiHfpheP0vzTNE=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=il6l0jmcOkCuEnOJJfL0QOkBDRd2HGgwLUqYKV1FC+v04xbfRmmgNO+wUtiYaC3dm
         lN2hPF4YCScIYzi/27nCPbj1V2q+aghjE7ZGfDEGbPU5Yc+wdRWcoPAZpBtkw28Fjv
         6qAnx3gxRfEqQcnvsUHAp1cPEVZ8bfyuaHVXzOKE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 80C396031A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [2/2] ath10k: allow ATH10K_SNOC with COMPILE_TEST
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180612113907.15043-2-niklas.cassel@linaro.org>
References: <20180612113907.15043-2-niklas.cassel@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180704095913.85B7F60131@smtp.codeaurora.org>
Date:   Wed,  4 Jul 2018 09:59:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Niklas Cassel <niklas.cassel@linaro.org> wrote:

> ATH10K_SNOC builds just fine with COMPILE_TEST, so make that possible.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Note to myself, I see these dependencies in linux-next (but not in Linus' tree yet):

67cd0eec5b62 rpmsg: smd: Add missing include of sizes.h
376e1f304fc7 firmware: qcom: scm: add a dummy qcom_scm_assign_mem()

These I don't see in linux-next yet:

  soc: qcom: smem: Add missing include of sizes.h
  soc: qcom: smp2p: Add select IRQ_DOMAIN
  soc: qcom: smsm: Add select IRQ_DOMAIN
  soc: qcom: Remove depends on ARCH_QCOM

-- 
https://patchwork.kernel.org/patch/10460103/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

