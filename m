Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 14D4DC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC1B208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ILKT69de";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Jp4tOpxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC1B208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754354AbeFLLY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 07:24:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51318 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753909AbeFLLY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 07:24:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F316D60791; Tue, 12 Jun 2018 11:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528802697;
        bh=hy7sY7cUmfGXtOkvRQiTwfiwMGDZEAFfWh68rduKH0o=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ILKT69deknV3FkxfvDvKMmLx96w6aoDOMZl4jqSO298Ek9MzgKsi4rMhYhsdLTej8
         cU43zHgJwCgkgRbJwEGQQT9o9hskXYBaX4533/OMt+VwQvVgW15UcNPVmaMaQm3t/5
         T0K6UVmHFTAYFcmQ1E0s3RCTCNicnmzmD0HJiY38=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B8871602BD;
        Tue, 12 Jun 2018 11:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528802696;
        bh=hy7sY7cUmfGXtOkvRQiTwfiwMGDZEAFfWh68rduKH0o=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Jp4tOpxznQrWmqXi3gr3o9CbCksJ5KIe9Dl2fitDe4ZjGfZb5gMGVdpc5aOdnJ4PQ
         TGIsT7eJRclXERtFrju+4xWCm8bgMLG9jJr5cL58Sw8ybvm/4LjU7nnzoPV/MeRJSX
         0QxmDtEyEey/Oz6pTnUcJ2NPQjwu96EdvzRCaY0Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B8871602BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Govind Singh <govinds@codeaurora.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath10k@lists.infradead.org
Subject: Re: [PATCH] ath10k: snoc: use module_platform_driver() macro
References: <20180611193540.190255-1-briannorris@chromium.org>
Date:   Tue, 12 Jun 2018 14:24:51 +0300
In-Reply-To: <20180611193540.190255-1-briannorris@chromium.org> (Brian
        Norris's message of "Mon, 11 Jun 2018 12:35:40 -0700")
Message-ID: <87sh5sckn0.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> ath10k_snoc_init()/ath10k_snoc_exit() don't add much value;
> module_platform_driver() can remove the boilerplate.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  drivers/net/wireless/ath/ath10k/snoc.c | 20 +-------------------
>  1 file changed, 1 insertion(+), 19 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
> index a3a7042fe13a..ee74e0060504 100644
> --- a/drivers/net/wireless/ath/ath10k/snoc.c
> +++ b/drivers/net/wireless/ath/ath10k/snoc.c
> @@ -1388,25 +1388,7 @@ static struct platform_driver ath10k_snoc_driver = {
>  			.of_match_table = ath10k_snoc_dt_match,
>  		},
>  };
> -
> -static int __init ath10k_snoc_init(void)
> -{
> -	int ret;
> -
> -	ret = platform_driver_register(&ath10k_snoc_driver);
> -	if (ret)
> -		pr_err("failed to register ath10k snoc driver: %d\n",
> -		       ret);
> -
> -	return ret;
> -}
> -module_init(ath10k_snoc_init);
> -
> -static void __exit ath10k_snoc_exit(void)
> -{
> -	platform_driver_unregister(&ath10k_snoc_driver);
> -}
> -module_exit(ath10k_snoc_exit);
> +module_platform_driver(ath10k_snoc_driver);

Yeah, makes sense. And I also checked that this shouldn't conflict with
Govind's qmi patch:

https://patchwork.kernel.org/patch/10448183/

-- 
Kalle Valo
