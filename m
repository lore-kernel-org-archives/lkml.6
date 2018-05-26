Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031353AbeEZI65 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 04:58:57 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36143 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031247AbeEZI64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 04:58:56 -0400
Date: Sat, 26 May 2018 10:58:38 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>
Subject: Re: [PATCH v3 13/16] mtd: rawnand: qcom: minor code reorganization
 for bad block check
Message-ID: <20180526104900.139dd19b@xps13>
In-Reply-To: <1527250904-21988-14-git-send-email-absahu@codeaurora.org>
References: <1527250904-21988-1-git-send-email-absahu@codeaurora.org>
        <1527250904-21988-14-git-send-email-absahu@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,


> @@ -2141,12 +2127,10 @@ static int qcom_nandc_block_bad(struct mtd_info *mtd, loff_t ofs)
>  		goto err;
>  	}
>  
> -	bbpos = mtd->writesize - host->cw_size * (ecc->steps - 1);
> -
> -	bad = nandc->data_buffer[bbpos] != 0xff;
> +	bad = bbm_bytes_buf[0] != 0xff;

BTW, as there are host->bbm_size bytes that can inform on the block
state, don't we need to check all of them?

>  
>  	if (chip->options & NAND_BUSWIDTH_16)
> -		bad = bad || (nandc->data_buffer[bbpos + 1] != 0xff);
> +		bad = bad || (bbm_bytes_buf[1] != 0xff);
>  err:
>  	return bad;
>  }

Thanks,
Miquèl
