Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4848C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622D82083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 16:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GaALm7gb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bmpbZdop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622D82083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbeIFUkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:40:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34434 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeIFUkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:40:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 93AA16081A; Thu,  6 Sep 2018 16:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536249882;
        bh=9MePEtxzGvabSh+osrjcrx9bRyevag9NOYTU5dPsnz4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=GaALm7gb38OAXRuEX7oGep9hPN6OIgPqvBlLGsbkfUKVdTTrQLg+u/PyvtourYhWH
         mfAwGYWZ/l826xSZ705Yy8WIADpQNQFpMAg1emyhw25o/rceyhBOWLRFUlstDaUkE0
         6tKNMqSOw/qa+L/MRIqosNMj/Kxr7DSK8v86tMi4=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E4B4C607B5;
        Thu,  6 Sep 2018 16:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536249877;
        bh=9MePEtxzGvabSh+osrjcrx9bRyevag9NOYTU5dPsnz4=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=bmpbZdopRma9vOLhy6aHmM2o6M9cabT9IWZtFa0rKL+o0QcunRW/qM0cWZrrFWnC7
         GAyl5GIo2tkjtZyxKvkYXcqtdWiVUbVBk1WIpfiR1XnBsvU+hHYm3wPokaZadj/o0g
         52YtGO8DEHX1h0VuEaMSj4OrIBanUKLRhRJrVx0E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E4B4C607B5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/1] ath10k: avoid possible memory access violation
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1533292805-9709-1-git-send-email-vijay.bvb@samsung.com>
References: <1533292805-9709-1-git-send-email-vijay.bvb@samsung.com>
To:     "K.T.VIJAYAKUMAAR" <vijay.bvb@samsung.com>
Cc:     davem@davemloft.net, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, cpgs@samsung.com,
        vijay.bvb@samsung.com
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180906160442.93AA16081A@smtp.codeaurora.org>
Date:   Thu,  6 Sep 2018 16:04:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"K.T.VIJAYAKUMAAR" <vijay.bvb@samsung.com> wrote:

> array "ctl_power_table" access index "pream" is initialized with -1 and
> is raised as a static analysis tool issue.
> [drivers\net\wireless\ath\ath10k\wmi.c:4719] ->
> [drivers\net\wireless\ath\ath10k\wmi.c:4730]: (error) Array index -1 is
> out of bounds.
> 
> Since the "pream" index for accessing ctl_power_table array is initialized
> with -1, there is a chance of memory access violation for the cases below.
> 1) wmi_pdev_tpc_final_table_event change frequency is between 2483 and 5180
> 2) pream_idx is out of the enumeration ranges of wmi_tpc_pream_2ghz,
> wmi_tpc_pream_5ghz
> 
> Signed-off-by: K.T.VIJAYAKUMAAR <vijay.bvb@samsung.com>
> [kvalo@codeaurora.org: clean up the warning message]
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

97c69a70dc2c ath10k: avoid possible memory access violation

-- 
https://patchwork.kernel.org/patch/10554929/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

