Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49038C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C642229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439315AbfBNOo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:44:59 -0500
Received: from smtprelay0085.hostedemail.com ([216.40.44.85]:51643 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439303AbfBNOo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:44:59 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 717A5100E86C0;
        Thu, 14 Feb 2019 14:44:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: milk93_4846db7892745
X-Filterd-Recvd-Size: 2268
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Thu, 14 Feb 2019 14:44:56 +0000 (UTC)
Message-ID: <4a6844c41d187d113e0c54dd156ba91c2635c361.camel@perches.com>
Subject: Re: report: scripts: checkpatch: Spell Checker Does Not Run with
 '-f'
From:   Joe Perches <joe@perches.com>
To:     federico.vaga@cern.ch, Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 14 Feb 2019 06:44:55 -0800
In-Reply-To: <3030138.e1gdHPWlgN@pcbe13614>
References: <3030138.e1gdHPWlgN@pcbe13614>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-14 at 13:48 +0100, Federico Vaga wrote:
> Hello,
> 
> Recently I have produce a couple of patches but I get different warnings if I 
> run checkpatch on the file (-f) or if I run it of a patch file. In particular, 
> the problem I found is with the spell checker which seems to run only when the 
> option '-f' is not used. I am wandering if there are other similar cases.
> 
> I do not know Perl, so I cannot investigate more, but I have a practical 
> example. I have this simple patch applied on my tree that introduces a spell 
> error:

If you want spelling fixes on files you have to use --strict

> 
> From: Federico Vaga <federico.vaga@cern.ch>
> Date: Thu, 14 Feb 2019 13:29:39 +0100
> Subject: [PATCH] script: checkpatch: buggy(?) output with -f option
> 
> Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
> ---
>  drivers/i2c/busses/i2c-ocores.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
> index b32d67c..f4deb90 100644
> --- a/drivers/i2c/busses/i2c-ocores.c
> +++ b/drivers/i2c/busses/i2c-ocores.c
> @@ -301,7 +301,7 @@ static int ocores_poll_wait(struct ocores_i2c *i2c)
>  		/* on going transfer */
>  		mask = OCI2C_STAT_TIP;
>  		/*
> -		 * We wait for the data to be transferred (8bit),
> +		 * We wait for the data to be transfered (8bit),
>  		 * then we start polling on the ACK/NACK bit
>  		 */
>  		udelay((8 * 1000) / i2c->bus_clock_khz);

