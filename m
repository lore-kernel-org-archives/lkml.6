Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /VclKckaG1v4WAAAmS7hNA
	; Sat, 09 Jun 2018 00:09:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 994C0608BA; Sat,  9 Jun 2018 00:09:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 292FD602FC;
	Sat,  9 Jun 2018 00:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 292FD602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932335AbeFIAJo (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 20:09:44 -0400
Received: from ale.deltatee.com ([207.54.116.67]:60734 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932297AbeFIAJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 20:09:42 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1fRRRq-00049e-A7; Fri, 08 Jun 2018 18:09:39 -0600
To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Shuah Khan <shuah@kernel.org>
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-7-logang@deltatee.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f0b74e71-d3ef-9d51-24ab-9becd8b80f33@deltatee.com>
Date: Fri, 8 Jun 2018 18:09:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180609000819.13883-7-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: shuah@kernel.org, Shyam-sundar.S-k@amd.com, fancer.lancer@gmail.com, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 5/8] NTB: perf: Don't require one more memory window than
 peer
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, sorry, I double posted patch 5. Please disregard the second one.

Logan

On 08/06/18 06:08 PM, Logan Gunthorpe wrote:
> NTB Perf should not require more than one memory window per peer. This
> was probably an off-by-one error.
> 
> Fixes: 5648e56d03fa ("NTB: ntb_perf: Add full multi-port NTB API support")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/ntb/test/ntb_perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 2a9d6b0d1f19..fe27412ffe91 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -655,7 +655,7 @@ static int perf_init_service(struct perf_ctx *perf)
>  {
>  	u64 mask;
>  
> -	if (ntb_peer_mw_count(perf->ntb) < perf->pcnt + 1) {
> +	if (ntb_peer_mw_count(perf->ntb) < perf->pcnt) {
>  		dev_err(&perf->ntb->dev, "Not enough memory windows\n");
>  		return -EINVAL;
>  	}
> 
