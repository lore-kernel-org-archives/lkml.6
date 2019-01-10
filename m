Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF996C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A528D20879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbfAJT4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:56:34 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.36]:46843 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728382AbfAJT4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:56:34 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 2C32A4C96C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 13:56:33 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id hgRNg6tHdYTGMhgRNgrva1; Thu, 10 Jan 2019 13:56:33 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=41042 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ghgRM-002QfO-DR; Thu, 10 Jan 2019 13:56:32 -0600
Subject: Re: [PATCH 37/41] scsi: st: mark expected switch fall-throughs
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     =?UTF-8?Q?Kai_M=c3=a4kisara?= <Kai.Makisara@kolumbus.fi>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <e0f4aa25970996146427e633bbf92be3eeee2e35.1543374820.git.gustavo@embeddedor.com>
 <99e896e6-b54b-540f-9c44-52dede4f2265@embeddedor.com>
Message-ID: <f6feeaf0-1d2d-2e9f-7a25-898a6a95fccc@embeddedor.com>
Date:   Thu, 10 Jan 2019 13:56:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <99e896e6-b54b-540f-9c44-52dede4f2265@embeddedor.com>
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
X-Exim-ID: 1ghgRM-002QfO-DR
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:41042
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 21
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Friendly ping (second one):

Who can ack/review/take this patch, please?

Thanks
--
Gustavo

On 12/19/18 6:08 PM, Gustavo A. R. Silva wrote:
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
> On 11/27/18 10:33 PM, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> Addresses-Coverity-ID: 114994 ("Missing break in switch")
>> Addresses-Coverity-ID: 114995 ("Missing break in switch")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/scsi/st.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
>> index 7ff22d3f03e3..7c7a742a5ef7 100644
>> --- a/drivers/scsi/st.c
>> +++ b/drivers/scsi/st.c
>> @@ -337,12 +337,14 @@ static void st_analyze_sense(struct st_request *SRpnt, struct st_cmdstatus *s)
>>           switch (sense[0] & 0x7f) {
>>           case 0x71:
>>               s->deferred = 1;
>> +            /* fall through */
>>           case 0x70:
>>               s->fixed_format = 1;
>>               s->flags = sense[2] & 0xe0;
>>               break;
>>           case 0x73:
>>               s->deferred = 1;
>> +            /* fall through */
>>           case 0x72:
>>               s->fixed_format = 0;
>>               ucp = scsi_sense_desc_find(sense, SCSI_SENSE_BUFFERSIZE, 4);
>> @@ -2721,6 +2723,7 @@ static int st_int_ioctl(struct scsi_tape *STp, unsigned int cmd_in, unsigned lon
>>       switch (cmd_in) {
>>       case MTFSFM:
>>           chg_eof = 0;    /* Changed from the FSF after this */
>> +        /* fall through */
>>       case MTFSF:
>>           cmd[0] = SPACE;
>>           cmd[1] = 0x01;    /* Space FileMarks */
>> @@ -2735,6 +2738,7 @@ static int st_int_ioctl(struct scsi_tape *STp, unsigned int cmd_in, unsigned lon
>>           break;
>>       case MTBSFM:
>>           chg_eof = 0;    /* Changed from the FSF after this */
>> +        /* fall through */
>>       case MTBSF:
>>           cmd[0] = SPACE;
>>           cmd[1] = 0x01;    /* Space FileMarks */
>>
