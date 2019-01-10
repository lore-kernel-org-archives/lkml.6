Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1198BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF95A20879
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbfAJUei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:34:38 -0500
Received: from gateway20.websitewelcome.com ([192.185.54.2]:42038 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730351AbfAJUeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:34:37 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id EB6D4400C63BC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 14:12:15 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id hggZgZsEc2PzOhggZgDxjY; Thu, 10 Jan 2019 14:12:15 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=41260 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ghggY-002eKy-9Y; Thu, 10 Jan 2019 14:12:15 -0600
Subject: Re: [PATCH 12/41] scsi: bfa: bfa_ioc: Mark expected switch
 fall-throughs
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1543374820.git.gustavo@embeddedor.com>
 <520fb16cd3630d612c5768989e2ffa90f1a73f97.1543374820.git.gustavo@embeddedor.com>
 <b5f0c0bf-f671-65b0-dfed-39cefcd3fde1@embeddedor.com>
Message-ID: <16aade69-ac0e-7d8c-0ffb-35564ee334cd@embeddedor.com>
Date:   Thu, 10 Jan 2019 14:11:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b5f0c0bf-f671-65b0-dfed-39cefcd3fde1@embeddedor.com>
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
X-Exim-ID: 1ghggY-002eKy-9Y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:41260
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 55
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
> On 11/27/18 10:27 PM, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> Notice that, in this particular case, I replaced "!!! fall through !!!"
>> comment with "fall through" annotations, which is what GCC is expecting
>> to find.
>>
>> Addresses-Coverity-ID: 146155 ("Missing break in switch")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/scsi/bfa/bfa_ioc.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/scsi/bfa/bfa_ioc.c b/drivers/scsi/bfa/bfa_ioc.c
>> index 16d3aeb0e572..32b24e51cce6 100644
>> --- a/drivers/scsi/bfa/bfa_ioc.c
>> +++ b/drivers/scsi/bfa/bfa_ioc.c
>> @@ -978,9 +978,7 @@ bfa_iocpf_sm_enabling(struct bfa_iocpf_s *iocpf, enum iocpf_event event)
>>       case IOCPF_E_INITFAIL:
>>           bfa_iocpf_timer_stop(ioc);
>> -        /*
>> -         * !!! fall through !!!
>> -         */
>> +        /* fall through */
>>       case IOCPF_E_TIMEOUT:
>>           writel(1, ioc->ioc_regs.ioc_sem_reg);
>> @@ -1056,9 +1054,7 @@ bfa_iocpf_sm_disabling(struct bfa_iocpf_s *iocpf, enum iocpf_event event)
>>       case IOCPF_E_FAIL:
>>           bfa_iocpf_timer_stop(ioc);
>> -        /*
>> -         * !!! fall through !!!
>> -         */
>> +        /* fall through */
>>       case IOCPF_E_TIMEOUT:
>>           bfa_ioc_set_cur_ioc_fwstate(ioc, BFI_IOC_FAIL);
>> @@ -6007,6 +6003,7 @@ bfa_dconf_sm_final_sync(struct bfa_dconf_mod_s *dconf,
>>       case BFA_DCONF_SM_IOCDISABLE:
>>       case BFA_DCONF_SM_FLASH_COMP:
>>           bfa_timer_stop(&dconf->timer);
>> +        /* fall through */
>>       case BFA_DCONF_SM_TIMEOUT:
>>           bfa_sm_set_state(dconf, bfa_dconf_sm_uninit);
>>           bfa_fsm_send_event(&dconf->bfa->iocfc, IOCFC_E_DCONF_DONE);
>>
