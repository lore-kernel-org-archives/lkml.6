Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E67C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A0C20898
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ICkFaQjS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ICkFaQjS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A0C20898
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbeH1QgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:36:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48850 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbeH1QgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:36:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 80C4860227; Tue, 28 Aug 2018 12:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535460283;
        bh=MugCxOfDVGECnv7/F5OC1VUqoYDDpbsdeMXDYVxk/HY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ICkFaQjSfPP8KO9xT8RWBowk4Ayhjoh1CP7tRxZdsowU+QK98Vu1cRejmgpPi2CUi
         wVmBFCItnqTda7DeD9EgxdWa+dfBocKvZv/BdtlrPQrS+BRpjkGdrkEBOdC+79YFfX
         e89U/BD9Y9CFZCYgM5YnneeMGLgKfe+b+Ren7bR0=
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 16D7960227;
        Tue, 28 Aug 2018 12:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535460283;
        bh=MugCxOfDVGECnv7/F5OC1VUqoYDDpbsdeMXDYVxk/HY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ICkFaQjSfPP8KO9xT8RWBowk4Ayhjoh1CP7tRxZdsowU+QK98Vu1cRejmgpPi2CUi
         wVmBFCItnqTda7DeD9EgxdWa+dfBocKvZv/BdtlrPQrS+BRpjkGdrkEBOdC+79YFfX
         e89U/BD9Y9CFZCYgM5YnneeMGLgKfe+b+Ren7bR0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 16D7960227
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Yuan-Chi Pang <fu3mo6goo@gmail.com>
Cc:     johannes@sipsolutions.net, davem@davemloft.net,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mac80211: fix to follow standard
References: <1535423074-130862-1-git-send-email-fu3mo6goo@gmail.com>
Date:   Tue, 28 Aug 2018 15:44:39 +0300
In-Reply-To: <1535423074-130862-1-git-send-email-fu3mo6goo@gmail.com>
        (Yuan-Chi Pang's message of "Tue, 28 Aug 2018 10:24:34 +0800")
Message-ID: <87ftyyu0co.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yuan-Chi Pang <fu3mo6goo@gmail.com> writes:

> IEEE 802.11-2016 14.10.8.3 HWMP sequence numbering says:
> If it is a target mesh STA, it shall update its own HWMP SN to
> maximum (current HWMP SN, target HWMP SN in the PREQ element) + 1
> immediately before it generates a PREP element in response to a
> PREQ element.
>
> Signed-off-by: Yuan-Chi Pang <fu3mo6goo@gmail.com>

The patch title is quite generic, you could make it a bit more
informative and unique. For example:

mac80211: fix HWMP sequence numbering to follow standard

-- 
Kalle Valo
