Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565A7C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E8F21726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ii9u7By8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfAWJm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:42:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44474 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbfAWJm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:42:58 -0500
Received: from zn.tnic (p200300EC2BCA6A0051BB6489C2CE9B52.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:6a00:51bb:6489:c2ce:9b52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5ED561EC0242;
        Wed, 23 Jan 2019 10:42:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548236577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2QC5fF112KWSqW9boc0e0jMFrA8GLrSmsvveA+7lv7g=;
        b=ii9u7By8Red6jCDiMCk5It8tAvPSMRizUEf1/C4fXx32NkV2xzyi59uidDY2/gt9kk4fIh
        LwR3gnCjv5tMWYM8cxmEOoigNv/IeAGU/+S0iuf4kdHCxLjUJzxzsnqat0K4l8S9u/k/Sz
        Z/qbZSLLPZtVtffxRbYIczXkCD4vvpo=
Date:   Wed, 23 Jan 2019 10:42:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH] edac: no need to check return value of debugfs_create
 functions
Message-ID: <20190123094250.GA3227@zn.tnic>
References: <20190122152151.16139-17-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190122152151.16139-17-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 04:21:16PM +0100, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-edac@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/edac/debugfs.c     | 45 ++++++++++----------------------------
>  drivers/edac/edac_module.h |  4 ++--
>  2 files changed, 13 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/edac/debugfs.c b/drivers/edac/debugfs.c
> index 92dbb7e2320c..fd27ea0453a3 100644
> --- a/drivers/edac/debugfs.c
> +++ b/drivers/edac/debugfs.c
> @@ -44,10 +44,6 @@ static const struct file_operations debug_fake_inject_fops = {
>  int __init edac_debugfs_init(void)
>  {
>  	edac_debugfs = debugfs_create_dir("edac", NULL);
> -	if (IS_ERR(edac_debugfs)) {
> -		edac_debugfs = NULL;
> -		return -ENOMEM;
> -	}
>  	return 0;
>  }

Applied after making that function void too.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
