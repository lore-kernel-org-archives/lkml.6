Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A0EC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFE220880
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QyiORBjX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EAebkKNS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFE220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbeHXPYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 11:24:08 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51712 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbeHXPYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 11:24:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A3212604BE; Fri, 24 Aug 2018 11:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535111389;
        bh=xFs57E//tVXHyZytv+gEp4hpHSK02YAIYCIxKwEaRek=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=QyiORBjXfJv79iaBX0UxjZ2X7oFbj/NuX/oPvLtRyTzWm+IPOWrKKtZInKKSg3a/I
         2WFMNvMlYoVUQ30h3zSMlA7pODv3DhqD1WraZ1g+p0gvIuY48gjNZDsVwLkGcFtEWV
         hMdXuNVG0VQms+9cNNajqiLe3zSgetJoRCkZDH3g=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 615DD6037C;
        Fri, 24 Aug 2018 11:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535111388;
        bh=xFs57E//tVXHyZytv+gEp4hpHSK02YAIYCIxKwEaRek=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=EAebkKNSTB2+8ONXpBGInzfP2YwDchdL5nzCy+yT+ZqDAE6wloL2UysgWAljjByJ4
         k+ltEFZQqczei0inspYWECOI4WYldFqb2rnYCD9QYwOLu2afUldb9H8ow6fKiplnUW
         8mAP+BI4sMyAR1YO656ORfZp0TczwETfUXP1cL74=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 615DD6037C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wcn36xx: Use kmemdup instead of duplicating it in
 wcn36xx_smd_process_ptt_msg_rsp
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180724114317.18580-1-yuehaibing@huawei.com>
References: <20180724114317.18580-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <wcn36xx@lists.infradead.org>, YueHaibing <yuehaibing@huawei.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180824114949.A3212604BE@smtp.codeaurora.org>
Date:   Fri, 24 Aug 2018 11:49:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> wrote:

> Replace calls to kmalloc followed by a memcpy with a direct call to
> kmemdup.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

3f96556f639e wcn36xx: Use kmemdup instead of duplicating it in wcn36xx_smd_process_ptt_msg_rsp

-- 
https://patchwork.kernel.org/patch/10541903/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

