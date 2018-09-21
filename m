Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFF1C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A96E21522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A96E21522
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389212AbeIULov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 07:44:51 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:54485 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbeIULov (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 21 Sep 2018 07:44:51 -0400
Received: from [10.160.4.48] (charybdis-ext.suse.de [195.135.221.2])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Fri, 21 Sep 2018 07:57:32 +0200
Subject: Re: [PATCH] scsi: advansys: Remove unnecessary parentheses
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Matthew Wilcox <matthew@wil.cx>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180920205858.6035-1-natechancellor@gmail.com>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <9432dde7-c63f-9c0c-fc9b-8728a0715ff3@suse.com>
Date:   Fri, 21 Sep 2018 07:57:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180920205858.6035-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/18 10:58 PM, Nathan Chancellor wrote:
> Clang warns when multiple pairs of parentheses are used for a single
> conditional statement.
> 
> drivers/scsi/advansys.c:6451:20: warning: equality comparison with
> extraneous parentheses [-Wparentheses-equality]
>                                  if ((sdtr_data == 0xFF)) {
>                                       ~~~~~~~~~~^~~~~~~
> drivers/scsi/advansys.c:6451:20: note: remove extraneous parentheses
> around the comparison to silence this warning
>                                  if ((sdtr_data == 0xFF)) {
>                                      ~          ^      ~
> drivers/scsi/advansys.c:6451:20: note: use '=' to turn this equality
> comparison into an assignment
>                                  if ((sdtr_data == 0xFF)) {
>                                                 ^~
>                                                 =
> 1 warning generated.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/155
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>   drivers/scsi/advansys.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
> index 713f69033f20..44c96199e00a 100644
> --- a/drivers/scsi/advansys.c
> +++ b/drivers/scsi/advansys.c
> @@ -6448,7 +6448,7 @@ static void AscIsrChipHalted(ASC_DVC_VAR *asc_dvc)
>   				sdtr_data =
>   				    AscCalSDTRData(asc_dvc, ext_msg.xfer_period,
>   						   ext_msg.req_ack_offset);
> -				if ((sdtr_data == 0xFF)) {
> +				if (sdtr_data == 0xFF) {
>   
>   					q_cntl |= QC_MSG_OUT;
>   					asc_dvc->init_sdtr &= ~target_id;
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
