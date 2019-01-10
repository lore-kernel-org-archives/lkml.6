Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A23C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE23E20665
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbfAJUK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:10:56 -0500
Received: from gateway36.websitewelcome.com ([192.185.187.5]:27490 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729366AbfAJUKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:10:55 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 087D5400C8BDD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 13:23:05 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id hgfHgZrC02PzOhgfHgDwhv; Thu, 10 Jan 2019 14:10:55 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=41258 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ghgfG-002dTS-M6; Thu, 10 Jan 2019 14:10:54 -0600
Subject: Re: [PATCH 13/41] scsi: csiostor: csio_wr: mark expected switch
 fall-through
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     linux-kernel@vger.kernel.org
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <5e846a635bfaf121af56e1f60a99816091e55170.1543374820.git.gustavo@embeddedor.com>
 <a05a7975-b09b-fd0a-8af1-82ab3b90596e@embeddedor.com>
Message-ID: <8f7b1fb9-260a-93aa-ec88-8d48ca9b2513@embeddedor.com>
Date:   Thu, 10 Jan 2019 14:10:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <a05a7975-b09b-fd0a-8af1-82ab3b90596e@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1ghgfG-002dTS-M6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:41258
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 40
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Friendly ping (second one):

Who can ack/review/take this patch, please?

Martin: apparently, the only maintainers for
this driver are you and James.

Thanks
--
Gustavo

On 12/19/18 9:39 AM, Gustavo A. R. Silva wrote:
> Hi,
> 
> Friendly ping:
> 
> Who can ack or review this patch, please?
> 
> Thanks
> -- 
> Gustavo
> 
> On 11/27/18 10:28 PM, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> Addresses-Coverity-ID: 1056538 ("Missing break in switch")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/scsi/csiostor/csio_wr.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/scsi/csiostor/csio_wr.c b/drivers/scsi/csiostor/csio_wr.c
>> index dc12933533d5..b6861ea66c9f 100644
>> --- a/drivers/scsi/csiostor/csio_wr.c
>> +++ b/drivers/scsi/csiostor/csio_wr.c
>> @@ -808,6 +808,7 @@ csio_wr_destroy_queues(struct csio_hw *hw, bool cmd)
>>                   csio_q_eqid(hw, i) = CSIO_MAX_QID;
>>               }
>> +            /* fall through */
>>           case CSIO_INGRESS:
>>               if (csio_q_iqid(hw, i) != CSIO_MAX_QID) {
>>                   csio_wr_cleanup_iq_ftr(hw, i);
>>
