Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7A0FC6122
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDAF205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="j6p6nGTN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q9Eimkr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCDAF205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732004AbeG3TfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 15:35:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37930 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeG3TfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 15:35:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AE84D60769; Mon, 30 Jul 2018 17:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532973549;
        bh=XoQytGIinmUaOUlvAlU03eqOK4CyaWZYX2/ObWaCSrM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=j6p6nGTNuj7ITTq2qofxYhE4IfBwFMN9Sv65q8tWthjicDlat6VHkhTh7PwfMWqDw
         WcAPStq2XSqNBBaF8S9GFA0nEoqKez0Tea5JwgA6PkgGnvQoXuUHbG9yg6JuVz0oF/
         JOIIBhCWIBwyhnciBK7p+pb3O8KZKXKWlLznpJXA=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3E2C060500;
        Mon, 30 Jul 2018 17:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532973548;
        bh=XoQytGIinmUaOUlvAlU03eqOK4CyaWZYX2/ObWaCSrM=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=Q9Eimkr2yBskKakQSkALMPyrZokKes5hmwMiGJyfDbbS9HsuDGQkAvctyLS/82AxR
         umzW1rCUebyAtQeBWU8GrXZJoQdOS+LfqSrpcZfnzM7yY2t9Cggxa656DOIcc5WhFX
         9MNEMMFWbtBM671CDzNQwzOcp0hi6M/8M7mNEkzU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3E2C060500
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: htt_tx: move lock into id_get function
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1531589900-29220-1-git-send-email-hofrat@osadl.org>
References: <1531589900-29220-1-git-send-email-hofrat@osadl.org>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180730175909.AE84D60769@smtp.codeaurora.org>
Date:   Mon, 30 Jul 2018 17:59:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Mc Guire <hofrat@osadl.org> wrote:

> This is only code refactoring as all call sites of
> ath10k_htt_tx_alloc_msdu_id() take the same lock it can be moved into the
> id_get function and the assertion dropped.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

e82f57c8b970 ath10k: htt_tx: move lock into id_get function

-- 
https://patchwork.kernel.org/patch/10524837/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

