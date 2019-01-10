Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8CBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB42320665
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfAJT6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:58:15 -0500
Received: from gateway31.websitewelcome.com ([192.185.143.39]:17040 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbfAJT6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:58:15 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id E44B736F94
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 13:58:13 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id hgSzgtxsR4FKphgSzgL5WZ; Thu, 10 Jan 2019 13:58:13 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=41052 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ghgSz-002RxO-Gf; Thu, 10 Jan 2019 13:58:13 -0600
Subject: Re: [PATCH 34/41] scsi: osst: mark expected switch fall-throughs
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Willem Riede <osst@riede.org>, osst-users@lists.sourceforge.net
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <c4e37b918b0e3aa338406b7adea6c2e9760b360b.1543374820.git.gustavo@embeddedor.com>
 <a52ce9b1-3a15-6ade-5f69-64d2d9d5a511@embeddedor.com>
Message-ID: <7d03d419-339e-afbc-d522-ba8ae66bfdd0@embeddedor.com>
Date:   Thu, 10 Jan 2019 13:58:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <a52ce9b1-3a15-6ade-5f69-64d2d9d5a511@embeddedor.com>
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
X-Exim-ID: 1ghgSz-002RxO-Gf
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:41052
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 31
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

On 12/19/18 6:07 PM, Gustavo A. R. Silva wrote:
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
>> Addresses-Coverity-ID: 114983 ("Missing break in switch")
>> Addresses-Coverity-ID: 114984 ("Missing break in switch")
>> Addresses-Coverity-ID: 114985 ("Missing break in switch")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/scsi/osst.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/scsi/osst.c b/drivers/scsi/osst.c
>> index 664c1238a87f..7e877b43785d 100644
>> --- a/drivers/scsi/osst.c
>> +++ b/drivers/scsi/osst.c
>> @@ -216,12 +216,14 @@ static void osst_analyze_sense(struct osst_request *SRpnt, struct st_cmdstatus *
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
>> @@ -591,6 +593,7 @@ static void osst_init_aux(struct osst_tape * STp, int frame_type, int frame_seq_
>>           dat->dat_list[0].flags    = frame_type==OS_FRAME_TYPE_MARKER?
>>                               OS_DAT_FLAGS_MARK:OS_DAT_FLAGS_DATA;
>>           dat->dat_list[0].reserved = 0;
>> +        /* fall through */
>>         case    OS_FRAME_TYPE_EOD:
>>           aux->update_frame_cntr    = htonl(0);
>>           par->partition_num        = OS_DATA_PARTITION;
>> @@ -4086,6 +4089,7 @@ static int osst_int_ioctl(struct osst_tape * STp, struct osst_request ** aSRpnt,
>>       switch (cmd_in) {
>>        case MTFSFM:
>>           chg_eof = 0; /* Changed from the FSF after this */
>> +        /* fall through */
>>        case MTFSF:
>>           if (STp->raw)
>>              return (-EIO);
>> @@ -4101,6 +4105,7 @@ static int osst_int_ioctl(struct osst_tape * STp, struct osst_request ** aSRpnt,
>>        case MTBSF:
>>           chg_eof = 0; /* Changed from the FSF after this */
>> +        /* fall through */
>>        case MTBSFM:
>>           if (STp->raw)
>>              return (-EIO);
>> @@ -4312,6 +4317,7 @@ static int osst_int_ioctl(struct osst_tape * STp, struct osst_request ** aSRpnt,
>>                          name, STp->block_size);
>>                return 0;
>>            }
>> +        /* fall through */
>>        case MTSETDENSITY:       /* Set tape density */
>>        case MTSETDRVBUFFER:     /* Set drive buffering */
>>        case SET_DENS_AND_BLK:   /* Set density and block size */
>>
