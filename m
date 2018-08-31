Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512F8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095A82083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="FLmFIGoU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fNNquWrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095A82083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbeHaTxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:53:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:32844 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbeHaTxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:53:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 78A9260242; Fri, 31 Aug 2018 15:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535730342;
        bh=Ge1rvhYh47FTWdXCJUyRhc8dnTJ3SA1cudGkeK1kPdA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=FLmFIGoUWYBrDnsDLhshAA+xUmC7b/uw6PR1Piw60RlykmgJ6Cv5Ves8mL5pXTlRe
         valmQxuHRSSQt6O10WvwEH+huZveuGvLit0ajjj05agca3XUEO3mubozz+oz8bv5qr
         lHXQIL7A5hSmJDDlOpRE7dy6IFjbJpwOA6Jk9leA=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C6E776032C;
        Fri, 31 Aug 2018 15:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535730342;
        bh=Ge1rvhYh47FTWdXCJUyRhc8dnTJ3SA1cudGkeK1kPdA=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=fNNquWrcE07wrcl3woX0drhECYKAM6dzqf5vZZbrVMsZ7oSA2QWYLuNCmeqsZlwBq
         zSKVsAy0E4UiSfRos+ir8RE1961TBB2QQ7nWXYLWvFq5rWfUEXDIDbMk70yEJ6nooz
         FC+1Jisgz4jFEnSQYAMVIotnb0azYLgwGHgbNaPk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C6E776032C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] orinoco: remove unused array encaps_hdr and macro
 ENCAPS_OVERHEAD
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180816125944.7804-1-colin.king@canonical.com>
References: <20180816125944.7804-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180831154542.78A9260242@smtp.codeaurora.org>
Date:   Fri, 31 Aug 2018 15:45:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Array encaps_hdr and macro ENCAPS_OVERHEAD are declared but are
> not being used, hence they are redundant and can be removed.
> 
> Cleans up clang warning:
> warning: 'encaps_hdr' defined but not used [-Wunused-const-variable=]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied to wireless-drivers-next.git, thanks.

5945310a1755 orinoco: remove unused array encaps_hdr and macro ENCAPS_OVERHEAD

-- 
https://patchwork.kernel.org/patch/10567409/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

