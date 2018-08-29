Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7384C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BED2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="UQlLJOZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76BED2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbeH2RUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:20:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46242 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeH2RUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:20:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id b129-v6so2309497pga.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 06:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XYyeJaOOdJiXslDb0WDNj6spb/ulDuxRoYmX2IaFZB4=;
        b=UQlLJOZ2dhTo66awR/bS/3AZYPCofeNopIbkOC239b41wbJqYes8IuGjmvRWlQze+0
         aWhRRYNZOOWZPVVwclCafNvApfMvtvBel74xGNTPFEiTQp8CgFQzAqJc9cmFLBDGu8UI
         sGSYpczztU3kWsyWoZNyscPjmFpB6XaUbATPecHVvPkMS3vpISROIHPSP5UUVWJkwpHf
         T8QjwbG/QkXWAgJvCnE7rn1MvGkh2Be6BGhGedN0MJb+7deu7mACg8B8OBDELasq7/oD
         I75mfzXuwnFIyW80uxxpye/TyiFpDSDK53+LUu3izfOAeIm8XQ4QBKEA1zN7Wxx/zs3K
         6YoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XYyeJaOOdJiXslDb0WDNj6spb/ulDuxRoYmX2IaFZB4=;
        b=Ua4/ybfOulIO0vBd+Z0AY2kX5abJQJOjpwNQkUsUuypZK1xEje54dAQv/tIDPnpFMA
         JkpWImARHUBKQcjuXV2tdkqk2XxoRIs5bKku9WahvZKiT0ORqiRT/6gx36kaqQjGsEHP
         M5q19ac+IajbI5aY0DqKXySXAxPi1AKHoHWCy3IHiikZjButl223//pu3mybcCMgNbIc
         aDQIuGCsLggAoJxbR662ZXY1nFSvaNbmLbR32xp1Av8g0/DLJIbTifjfn/U+WDhtFIHd
         Ue97LHoMhBSCX+w29MP8z3JaxOF7HllbQXTvktAoFO5805C6owkjR1D33uurjhK81PiO
         zbjw==
X-Gm-Message-State: APzg51Aev87bZTY1fkCBT/0u0PGYvPS6gZLgYdTgHAv9Vxo6MO+PN8l2
        X3enrp10R3FJeak/oD66Gcq54Q==
X-Google-Smtp-Source: ANB0VdY3F6nQrW8cQczCgpe8KFzHx6MR5VWMizni3TbrP1tICHQwCb3TwOzZM/6wvrJuoF1MPhKzEA==
X-Received: by 2002:a63:26c6:: with SMTP id m189-v6mr413441pgm.70.1535549030463;
        Wed, 29 Aug 2018 06:23:50 -0700 (PDT)
Received: from [10.86.62.45] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id p64-v6sm8749352pfa.47.2018.08.29.06.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 06:23:49 -0700 (PDT)
Subject: Re: [PATCH 2/7] lightnvm: pblk: fix mapping issue on failed writes
To:     hans.ml.holmberg@owltronix.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com, hans.holmberg@cnexlabs.com
References: <1535545414-550-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1535545414-550-3-git-send-email-hans.ml.holmberg@owltronix.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <eb5ca95c-6c4a-71a0-4cf1-634b211b52ce@lightnvm.io>
Date:   Wed, 29 Aug 2018 15:23:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1535545414-550-3-git-send-email-hans.ml.holmberg@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2018 02:23 PM, Hans Holmberg wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> On 1.2-devices, the mapping-out of remaning sectors in the
> failed-write's block can result in an infinite loop,
> stalling the write pipeline, fix this.
> 
> Fixes: 6a3abf5beef6 ("lightnvm: pblk: rework write error recovery path")
> 
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-write.c | 45 ++++++++++++++++++++++++++++++++++---------
>   1 file changed, 36 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
> index 1bc879ab679d..fd67325f6e54 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -103,6 +103,41 @@ static void pblk_complete_write(struct pblk *pblk, struct nvm_rq *rqd,
>   	pblk_rb_sync_end(&pblk->rwb, &flags);
>   }
>   
> +static int pblk_next_ppa_in_blk(struct nvm_geo *geo, struct ppa_addr *ppa)
> +{
> +	int done = 0;

Could this please be renamed to last to signify it is the last ppa in 
the ppa.

> +
> +	if (geo->version == NVM_OCSSD_SPEC_12) {
> +		int sec = ppa->g.sec;
> +
> +		sec++;
> +		if (sec == geo->ws_min) {
> +			int pg = ppa->g.pg;
> +
> +			sec = 0;
> +			pg++;
> +			if (pg == geo->num_pg) {
> +				int pl = ppa->g.pl;
> +
> +				pg = 0;
> +				pl++;
> +				if (pl == geo->num_pln)
> +					done = 1;
> +
> +				ppa->g.pl = pl;
> +			}
> +			ppa->g.pg = pg;
> +		}
> +		ppa->g.sec = sec;
> +	} else {
> +		ppa->m.sec++;
> +		if (ppa->m.sec == geo->clba)
> +			done = 1;
> +	}
> +
> +	return done;
> +}
> +

Can you please move this function to core? I want to avoid introducing 
more if's around 1.2/2.0 in targets.

>   /* Map remaining sectors in chunk, starting from ppa */
>   static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
>   {
> @@ -125,15 +160,7 @@ static void pblk_map_remaining(struct pblk *pblk, struct ppa_addr *ppa)
>   		if (!test_and_set_bit(paddr, line->invalid_bitmap))
>   			le32_add_cpu(line->vsc, -1);
>   
> -		if (geo->version == NVM_OCSSD_SPEC_12) {
> -			map_ppa.ppa++;
> -			if (map_ppa.g.pg == geo->num_pg)
> -				done = 1;
> -		} else {
> -			map_ppa.m.sec++;
> -			if (map_ppa.m.sec == geo->clba)
> -				done = 1;
> -		}
> +		done = pblk_next_ppa_in_blk(geo, &map_ppa);
>   	}
>   
>   	line->w_err_gc->has_write_err = 1;
> 

