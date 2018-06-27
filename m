Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1983FC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF24525C28
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CpGdHK4o";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Nz8rRJ3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF24525C28
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935025AbeF0QFE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:05:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48212 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934936AbeF0QFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:05:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E369660B10; Wed, 27 Jun 2018 16:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530115501;
        bh=iFq0yz2yQ7Dsh9NNFWrDBT0jFF3Qc09blMmUFCPS4Cs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=CpGdHK4ou7p1FDVXtGzloSjgkPlGLhIub3PsWkATgVjNWKV/4IlJMqW6VlM2pIF9n
         EVV7mC3i48B9JDZeJ2Az7MXSG5aSL/OoM0JkXSt6ZoE5F98rt1XOGhYwxLZEmwZc+Y
         tfN0VH4p1E073t1LPRA734t8p3FtSHS3T/8g8NEI=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B48D76034E;
        Wed, 27 Jun 2018 16:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530115501;
        bh=iFq0yz2yQ7Dsh9NNFWrDBT0jFF3Qc09blMmUFCPS4Cs=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=Nz8rRJ3No/xy3IDXqQwVhDHXnkwSQe/c3zuLeaaKXSwFh1YPx58Q78cP28MSE3xm4
         b8hni7UWqMW1ApqqCrg5GNVe8LD4Wc1y8Emwjf4F/9Gx6nmbOXhfsTXq17ZYylgF/3
         CiyLWmNHVU+rw+JV/0u2VrjwVjK1AzymWcBRGDR4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B48D76034E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: net: ipw2x00: Replace NULL comparison with !priv
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20180603111136.4262-1-rvarsha016@gmail.com>
References: <20180603111136.4262-1-rvarsha016@gmail.com>
To:     Varsha Rao <rvarsha016@gmail.com>
Cc:     Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <der.herr@hofr.at>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Varsha Rao <rvarsha016@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180627160501.E369660B10@smtp.codeaurora.org>
Date:   Wed, 27 Jun 2018 16:05:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Varsha Rao <rvarsha016@gmail.com> wrote:

> Remove extra parentheses and replace NULL comparison with !priv, to fix
> clang warning of extraneous parentheses and check patch issue. Following
> coccinelle script is used to fix it.
> 
> @disable is_null,paren@
> expression e;
> statement s;
> @@
> if (
> - (e==NULL)
> +!e
>  )
> s
> 
> Signed-off-by: Varsha Rao <rvarsha016@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

4e5f881d430a net: ipw2x00: Replace NULL comparison with !priv

-- 
https://patchwork.kernel.org/patch/10445241/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

