Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EA5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B93B208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 07:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oqphSa9q";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l7l6RvJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B93B208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbeGaJAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:00:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57858 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbeGaJAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:00:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D79D860376; Tue, 31 Jul 2018 07:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533021712;
        bh=hpL0ALPXuc3s7A/FzbB7qpFmcXbtV1DFJp6dgoK5dQM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=oqphSa9qWMW5mtz7nElLdGpHWxswAxH6zYLEYggyKoTpBktDOEoyEvicexJbE3Ckj
         u2YFpkPPzRRFj7X623RfgHlXGYGBvXwO+CbvCeO3utkAB9ln3Q3cDa3VoB80ZJfL8l
         uyLRnZ7rFZSZ8ygOGOXChzWWiGAGI9YnAdtfGQck=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B242D60376;
        Tue, 31 Jul 2018 07:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533021712;
        bh=hpL0ALPXuc3s7A/FzbB7qpFmcXbtV1DFJp6dgoK5dQM=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=l7l6RvJfTc1/tNm0+v2pjWJ9A1kz1/NmNBSyK/zc6sjhV2yYaKwaVhruSzpppjP6U
         DYotkjjd2zEODducyTw1LkxoPhNnBoSJHfg3T4qUN946ii81bpPs7kV5APh1nHJImn
         5+0hHzyQNEAQrR7wJxhFeZejC1/ilv8zIf07/GHg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B242D60376
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] hostap: hide unused procfs helpers
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180713070317.6724-1-yuehaibing@huawei.com>
References: <20180713070317.6724-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <j@w1.fi>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <davem@davemloft.net>, YueHaibing <yuehaibing@huawei.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180731072152.D79D860376@smtp.codeaurora.org>
Date:   Tue, 31 Jul 2018 07:21:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> wrote:

> When CONFIG_PROC_FS isn't set, gcc warning this:
> 
> drivers/net/wireless/intersil/hostap/hostap_hw.c:2901:12: warning: ‘prism2_registers_proc_show’ defined but not used [-Wunused-function]
>  static int prism2_registers_proc_show(struct seq_file *m, void *v)
> 
> drivers/net/wireless/intersil/hostap/hostap_proc.c:16:12: warning: ‘prism2_debug_proc_show’ defined but not used [-Wunused-function]
>  static int prism2_debug_proc_show(struct seq_file *m, void *v)
>             ^
> drivers/net/wireless/intersil/hostap/hostap_proc.c:49:12: warning: ‘prism2_stats_proc_show’ defined but not used [-Wunused-function]
>  static int prism2_stats_proc_show(struct seq_file *m, void *v)
>             ^
> drivers/net/wireless/intersil/hostap/hostap_proc.c:177:12: warning: ‘prism2_crypt_proc_show’ defined but not used [-Wunused-function]
>  static int prism2_crypt_proc_show(struct seq_file *m, void *v)
>             ^
> 
> fix this by adding #ifdef around them.
> hfa384x_read_reg is only used by prism2_registers_proc_show,so move it
> into #ifdef.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied to wireless-drivers-next.git, thanks.

6ade689711ee hostap: hide unused procfs helpers

-- 
https://patchwork.kernel.org/patch/10522651/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

