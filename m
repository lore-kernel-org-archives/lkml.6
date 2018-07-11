Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59008C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22D92084A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22D92084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733142AbeGKM6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:58:09 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:64560
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733079AbeGKM6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:58:08 -0400
X-IronPort-AV: E=Sophos;i="5.51,338,1526335200"; 
   d="scan'208";a="272618882"
Received: from unknown (HELO var.youpi.perso.aquilenet.fr) ([193.50.110.112])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2018 14:53:53 +0200
Received: from samy by var.youpi.perso.aquilenet.fr with local (Exim 4.91)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1fdEAk-0005Vv-GW; Wed, 11 Jul 2018 14:24:42 +0200
Date:   Wed, 11 Jul 2018 14:24:42 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Colin King <colin.king@canonical.com>
Cc:     William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: speakup: remove redundant variable l
Message-ID: <20180711122442.mele6xunacmpbxe3@var.youpi.perso.aquilenet.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Colin King <colin.king@canonical.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180711112607.31292-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180711112607.31292-1-colin.king@canonical.com>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King, le mer. 11 juil. 2018 12:26:07 +0100, a ecrit:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable l is being assigned but is never used hence it is redundant
> and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'l' set but not used [-Wunused-but-set-variable
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  drivers/staging/speakup/varhandlers.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/speakup/varhandlers.c b/drivers/staging/speakup/varhandlers.c
> index 54a76b6752ad..1b545152cc49 100644
> --- a/drivers/staging/speakup/varhandlers.c
> +++ b/drivers/staging/speakup/varhandlers.c
> @@ -179,7 +179,6 @@ int spk_set_num_var(int input, struct st_var_header *var, int how)
>  {
>  	int val;
>  	int *p_val = var->p_val;
> -	int l;
>  	char buf[32];
>  	char *cp;
>  	struct var_t *var_data = var->data;
> @@ -237,9 +236,9 @@ int spk_set_num_var(int input, struct st_var_header *var, int how)
>  	else
>  		cp = buf;
>  	if (!var_data->u.n.out_str)
> -		l = sprintf(cp, var_data->u.n.synth_fmt, (int)val);
> +		sprintf(cp, var_data->u.n.synth_fmt, (int)val);
>  	else
> -		l = sprintf(cp,	var_data->u.n.synth_fmt, var_data->u.n.out_str[val]);
> +		sprintf(cp, var_data->u.n.synth_fmt, var_data->u.n.out_str[val]);
>  	synth_printf("%s", cp);
>  	return 0;
>  }
> -- 
> 2.17.1
> 

-- 
Samuel
> Allez, soyez sympa ... traduisez-lui "linux"
Linux, c'est comme le miel : c'est vachement bon mais ça attire les
mouches. En plus, ça colle aux doigts et on a du mal à s'en défaire.
-+- TP in: Guide du linuxien pervers - "Barrez vous les mouches !"
