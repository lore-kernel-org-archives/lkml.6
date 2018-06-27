Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EF7C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4FA244EF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GuqshIcK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D5VDYmzV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B4FA244EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934916AbeF0Pzu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:55:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43442 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934746AbeF0Pzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:55:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0D0CF60AD8; Wed, 27 Jun 2018 15:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530114948;
        bh=05BPjB5wztF1mDiFnUCXXoLzxc0UpHDKdbA8cBeyQOs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=GuqshIcK5xlBFzibP93xa5ktdqBHY3NRh13pfpXzXydJXX0Rt7/M6MpzrQ+soZKp0
         LG65ZbLtvrf/WPlpENmyjN4znjTGuQhxiNM4Z516dH+MCvvpmD1n9OU6Iis5QG2GVg
         +urhYUbPwCTdmcJcA/ah4Hp/Xfwwyu6DA3rapJGk=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 98029606FA;
        Wed, 27 Jun 2018 15:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530114947;
        bh=05BPjB5wztF1mDiFnUCXXoLzxc0UpHDKdbA8cBeyQOs=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=D5VDYmzVMOCfvKr8uslOi8me/blBzeP+XX68gkUk67a+HgcBy+D1f/Ift4pHHLsis
         LHaLkQXnHicEhpG/PFdeywhz+sc7z/quhnHcvhc16vu89Y05aUPFPwKvr48t4Am07p
         z6N8se8VTzclt6A6W4Otkx/URQgvEuGwF45tNGsE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 98029606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: brcmsmac: Remove unnecessary parentheses
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180601021413.4031-1-rvarsha016@gmail.com>
References: <20180601021413.4031-1-rvarsha016@gmail.com>
To:     Varsha Rao <rvarsha016@gmail.com>
Cc:     Nicholas Mc Guire <der.herr@hofr.at>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Varsha Rao <rvarsha016@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180627155548.0D0CF60AD8@smtp.codeaurora.org>
Date:   Wed, 27 Jun 2018 15:55:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Varsha Rao <rvarsha016@gmail.com> wrote:

> This patch fixes the clang warning of extraneous parentheses, with the
> following coccinelle script.
> 
> @@
> identifier i;
> expression e;
> statement s;
> @@
> if (
> -(i == e)
> +i == e
>  )
> s
> 
> Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Varsha Rao <rvarsha016@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

eb5d2f3afc0f brcmsmac: Remove unnecessary parentheses

-- 
https://patchwork.kernel.org/patch/10442401/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

