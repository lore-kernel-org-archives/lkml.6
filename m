Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903FCC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156BD21523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 156BD21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388170AbeIUAu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:50:27 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:37164 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbeIUAu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:50:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5472660A3596;
        Thu, 20 Sep 2018 21:05:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id TtxIrW6SplYz; Thu, 20 Sep 2018 21:05:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0DBB360A3599;
        Thu, 20 Sep 2018 21:05:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gKdYVRSRfdIt; Thu, 20 Sep 2018 21:05:29 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id A511A60A3596;
        Thu, 20 Sep 2018 21:05:29 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Ritesh Raj Sarraf <rrs@debian.org>
Cc:     Ritesh Raj Sarraf <rrs@researchut.com>,
        Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Don't hardcode path as it is architecture dependent
Date:   Thu, 20 Sep 2018 21:05:29 +0200
Message-ID: <2232247.seiAqWBpkp@blindfold>
In-Reply-To: <20180920062640.23038-1-rrs@debian.org>
References: <20180920062640.23038-1-rrs@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 20. September 2018, 08:26:38 CEST schrieb Ritesh Raj Sarraf:
> The current code fails to run on amd64 because of hardcoded reference to
> i386
> 
> Signed-off-by: Ritesh Raj Sarraf <rrs@researchut.com>

Thanks for spotting this!

> ---
>  arch/um/drivers/port_user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/um/drivers/port_user.c b/arch/um/drivers/port_user.c
> index 9a8e1b64c22e..5f56d11b886f 100644
> --- a/arch/um/drivers/port_user.c
> +++ b/arch/um/drivers/port_user.c
> @@ -168,7 +168,7 @@ int port_connection(int fd, int *socket, int *pid_out)
>  {
>  	int new, err;
>  	char *argv[] = { "/usr/sbin/in.telnetd", "-L",
> -			 "/usr/lib/uml/port-helper", NULL };
> +			 OS_LIB_PATH "/uml/port-helper", NULL };
>  	struct port_pre_exec_data data;
>  
>  	new = accept(fd, NULL, 0);

Thanks,
//richard


