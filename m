Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729E9C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 23:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2979A206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 23:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvsjHSUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2979A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeJAFou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:44:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45146 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbeJAFou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:44:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id q5-v6so5300316wrw.12;
        Sun, 30 Sep 2018 16:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9Ru3w1XBfC+OISQYR9sy7Tdn36wsK6C5RBkgIhLlVYk=;
        b=qvsjHSUEVxQmn8J5xeUEL+zl6wkdjkioC7cLctFQiaShNKtsdSd3ecu+73BGte/uVN
         WX5vxGAmEJl68DJga3GhiFFLXFsv45BRzSHQKtagLfU6HW8uQSC3of15IAKhxqswfa4b
         v940+cvx+s+PiEJWH4OkzamGUj27FjFLk0gl02qb5mEt6C0IbbyM62UcZKYH4n9VBz6Q
         EowfaAUEFwU2mj0laWvNvGj9oKxDO5NuRgD3Zn8jHEGaVtQgMnS5SabmIroMEWa7ftr5
         o/fOlD6+cFWEZ01SSdFRxwFMlWeVCpAGX9dlcPuTTtD+LpYSRyp0+hvJ//vT7XxEwBfU
         gsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9Ru3w1XBfC+OISQYR9sy7Tdn36wsK6C5RBkgIhLlVYk=;
        b=m/m24xTYzgiRq00QHxOe+irRqQTtP/5TUF61SgHCCQqHwQtCSf9mUIXT1QXshDKaDi
         WWBr8XNBjOTDXKmHQn4HjAlrP3TRVfXloAcryXXYOua5ATA4PRTlX1gQJM+SENldY7iz
         gP2i8I6sAgS4+y/o8aSbmVmJ7CHVollB1SqIPZHKeu2A5mvoIjFH5Imvdn4kFUihPUXu
         X5a3SboU5PSF1Qn60Ssk5KMCo0EEJXInqMx4sCpO+ptn+eeo1HmKthVxzqIvZ1X1WBSm
         O3aztORabszQDyExHA/9XJmyUUuGb2ex3+sYiZagoArwJjWhHmorHILuXDZbnRrBNzAO
         RGyw==
X-Gm-Message-State: ABuFfoh42iHuHPaXEdfMbWRiqcUNZLURix7HgAEemGFz3ntMcvUp8pKe
        EsnM8ABm4vc1QhZV0lSeGLWFDwHg9cMzuw==
X-Google-Smtp-Source: ACcGV63KjsE7nUJPFNO1sAjGrjWgRgd1NjUIGShF9ffKxgwvFmN8H4JJIF/EiqopTe+V3nDmXAOftQ==
X-Received: by 2002:adf:9068:: with SMTP id h95-v6mr5005899wrh.65.1538348995552;
        Sun, 30 Sep 2018 16:09:55 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id a105-v6sm30423058wrc.23.2018.09.30.16.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Sep 2018 16:09:55 -0700 (PDT)
Date:   Sun, 30 Sep 2018 16:09:53 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: message: fusion: clean up clang warning on
 extraneous parentheses
Message-ID: <20180930230953.GA12922@flashbox>
References: <20180930223123.17907-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180930223123.17907-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 11:31:23PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are extraneous parantheses that are causing clang to produce a
> warning so remove these. Also replace pointer comparison with NULL
> with the !ptr idiom.
> 
> Clean up clang warnings:
> equality comparison with extraneous parentheses [-Wparentheses-equality]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/message/fusion/mptbase.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
> index dc1e43a02599..ba551d8dfba4 100644
> --- a/drivers/message/fusion/mptbase.c
> +++ b/drivers/message/fusion/mptbase.c
> @@ -335,11 +335,11 @@ static int mpt_remove_dead_ioc_func(void *arg)
>  	MPT_ADAPTER *ioc = (MPT_ADAPTER *)arg;
>  	struct pci_dev *pdev;
>  
> -	if ((ioc == NULL))
> +	if (!ioc)
>  		return -1;
>  
>  	pdev = ioc->pcidev;
> -	if ((pdev == NULL))
> +	if (!pdev)
>  		return -1;
>  
>  	pci_stop_and_remove_bus_device_locked(pdev);
> -- 
> 2.17.1
> 

Hi Colin,

I already sent a patch that was picked up by Martin a few days ago: https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?id=90ded4e2005b1195a5e781009be991e1cd049c10

I've been sending several warning fixes for Clang over the past few
weeks that have been documented on GitHub. You may consider checking
them out since I have started to see some overlap.

Link: https://github.com/ClangBuiltLinux/linux/issues

Cheers!
Nathan
