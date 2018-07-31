Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761F5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AE0208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="f55Hryxj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VBHZSwVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27AE0208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbeGaJGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:06:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34212 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbeGaJGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:06:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6141960708; Tue, 31 Jul 2018 07:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533022023;
        bh=0FfgnG9WoYM828o8JXWnJIU7oWBDbL3AT1YkpDmHBC0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=f55Hryxjdyvoo2AFTJUGj9xM/f7pq/32C2liqlN09dy02xPl4SZJyRtE/eHFW6AiS
         41E7djKdkzruzVGdwrBRWmV9s+vlA0Zj7PwCatV1QsORg7tYZ+WAUJHncFhDKHxKud
         f6S+tYbB9RlCsQIOc3ksR7YtODE3V/3JcPPqjJk4=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ED03A60376;
        Tue, 31 Jul 2018 07:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533022023;
        bh=0FfgnG9WoYM828o8JXWnJIU7oWBDbL3AT1YkpDmHBC0=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=VBHZSwVygdBqlJzn8io3Pqzfxgthu9lH9J592EJ3SRIr2ZW7gEKvq1mPZS6zsMoWj
         WrC+F1lRfyJde2PVpyf7OXekK4ezcrCsxyHd7EJtZNe0M+TTGW88f0WL20i2P0tOyd
         7wSzqWXtwA31/LCfHdmItoKi7jdx1vSj6rY6A5HE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ED03A60376
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtl818x: Replace mdelay() with msleep() in
 rtl8225se_rf_init
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180727085045.3949-1-baijiaju1990@gmail.com>
References: <20180727085045.3949-1-baijiaju1990@gmail.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180731072703.6141960708@smtp.codeaurora.org>
Date:   Tue, 31 Jul 2018 07:27:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jia-Ju Bai <baijiaju1990@gmail.com> wrote:

> rtl8225se_rf_init() is never called in atomic context.
> It calls mdelay() to busily wait, which is not necessary.
> mdelay() can be replaced with msleep().
> This patch only replaces the mdelay() that has >20ms time to wait.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

622e938240db rtl818x: Replace mdelay() with msleep() in rtl8225se_rf_init

-- 
https://patchwork.kernel.org/patch/10546749/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

