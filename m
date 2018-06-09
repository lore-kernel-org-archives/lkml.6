Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 3DXgDTQHHFs5CAAAmS7hNA
	; Sat, 09 Jun 2018 16:58:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D53B2608C1; Sat,  9 Jun 2018 16:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528563512;
	bh=BJiuEoj4dp7vlkanweuRE6GS3PpurrIC4N6m2glDG7U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=N7VdLd84DYwMZTo+jYLFtGcYHupTiwzPHTkC+HLzj0AzIuDYfN0vVQt/Stdbhg7nl
	 ItWwBUuY749lBTVIEiXeBz/MZczuQmnHeg9bQ6QfF2g/ew1IYSDi67/KwMMICbnHKL
	 K0cLp9LR8kuurHIktbi2enrR2R/5WiL6npbacG/w=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 58984608BF;
	Sat,  9 Jun 2018 16:58:32 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n/hXDBvk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I8yPz+qc"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 58984608BF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753472AbeFIQ63 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 12:58:29 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60142 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753426AbeFIQ62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 12:58:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 44038608C8; Sat,  9 Jun 2018 16:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528563508;
        bh=BJiuEoj4dp7vlkanweuRE6GS3PpurrIC4N6m2glDG7U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n/hXDBvkSu7FLmSCN56jWW+1+ek2TiAFr1Tv3Biejm3vLzKgeiYfc6xv6q8TmNr5e
         rLZtLsL6nMI4ZZH/vYRC6bU1X3aG0wl+sppRSkc+BhhCSOjGgDmAYs8yECU2UgtmM/
         qlofj6W7ivDH5jKwr7AqkFYSS0wZ22L85Cjj4bC0=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7D270607DC;
        Sat,  9 Jun 2018 16:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528563507;
        bh=BJiuEoj4dp7vlkanweuRE6GS3PpurrIC4N6m2glDG7U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I8yPz+qcXL1+TAMcsrYOMzhYlbG36ijxYPJwD4nCQYNcozvT/9xylsmHzFUKga8/w
         AbX5U9dPbzoxilskf1/MG5M4Ir+fGBq2sZHjjqaE9QaxezqR3BD4KiQSCOIdU1Kikj
         qcSYJHlYR66ZQaC7hrrxB9q+1iFvM/fzBMAtHXf4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat, 09 Jun 2018 12:58:27 -0400
From: okaya@codeaurora.org
To: Anton Vasilyev <vasilyev@ispras.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Gaurav Pathak <gauravpathak129@gmail.com>,
        Hannes Reinecke <hare@suse.de>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH] staging: rts5208: add check on NULL before dereference
In-Reply-To: <20180609163829.30619-1-vasilyev@ispras.ru>
References: <20180609163829.30619-1-vasilyev@ispras.ru>
Message-ID: <ddb00f65153abf3dfe81d9da86c9b98c@codeaurora.org>
X-Sender: okaya@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-09 12:38, Anton Vasilyev wrote:
> If rtsx_probe fails to allocate dev->chip, then NULL pointer
> dereference occurs at rtsx_release_resources().
> 
> Patch adds checks chip on NULL before its dereference at
> rtsx_release_resources and passing with dereference inside
> rtsx_release_chip.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
> ---
>  drivers/staging/rts5208/rtsx.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/rtsx.c 
> b/drivers/staging/rts5208/rtsx.c
> index 70e0b8623110..952dd0d580cf 100644
> --- a/drivers/staging/rts5208/rtsx.c
> +++ b/drivers/staging/rts5208/rtsx.c
> @@ -623,12 +623,13 @@ static void rtsx_release_resources(struct 
> rtsx_dev *dev)
> 

I think you should bail out if dev->chip is null rather than adding 
conditiinals.


>  	if (dev->irq > 0)
>  		free_irq(dev->irq, (void *)dev);
> -	if (dev->chip->msi_en)
> +	if (dev->chip && dev->chip->msi_en)
>  		pci_disable_msi(dev->pci);
>  	if (dev->remap_addr)
>  		iounmap(dev->remap_addr);
> +	if (dev->chip)
> +		rtsx_release_chip(dev->chip);
> 
> -	rtsx_release_chip(dev->chip);
>  	kfree(dev->chip);
>  }
