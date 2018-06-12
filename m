Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6EA69C004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 01:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C09208BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 01:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mLq/CCQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C09208BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934913AbeFLBTE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 21:19:04 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:39574 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934694AbeFLBTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 21:19:01 -0400
Received: by mail-io0-f193.google.com with SMTP id f1-v6so26144791ioh.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 18:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V4AGn+9LkgufB4zANkIpMRfecrTzAsCn3CcKC6SBfbk=;
        b=mLq/CCQ6Pf7SrZVY/7mL/RNNSMdXVQzfFxVL4IP9AfjdtNyzIiydQrtVXPe33+wRO7
         RK5nsyk6c7V50Q2l4s9bd+Hj5eGkkba2DyVOjV99HCCWTTPExIvo3Q6p3uunmN7k/84n
         uPTX/A+4bZ7Jv7bXzXvKD/w2mMVB79PI96xZKtJM84PKCc5gNp8tpJ1K5m9u3gNbGJdr
         ia64KVQm09st0raD4w8ecOzRsQcdmDcVPLLUfkbu59SlJKiQljtbofahKOfChbtS5hjw
         lVxV67GvyUcIFkgHdizNcUJ6iEIqXpsQyg6wMqVaZhPrtSnXU5jRBtYcGAqTH+D0tdHs
         hAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V4AGn+9LkgufB4zANkIpMRfecrTzAsCn3CcKC6SBfbk=;
        b=JzMReH8DxilvdbaWK6Qx+1f1yi1RaOJxneDXRfx0AFCatipkwxGW6PCRGopaDXy4zx
         FDZsgLQt5mX9pGzDlECRfwbNB3B5gled7kOKw43o0OB6VTT8lEjajvr+hU8Tl8zOBc0e
         S5VSkQGBwlrrSDfyQq8ciTHJGz8TUmhQ0lcZEjXS+PApTWNRHXR7NaYovBqJG+K25aTJ
         A47YNJ30Jgm3jYUF2n3BKzLfi2WCrnl63Iq5ZVZslcqqQezYzTOcQLiIpv9ARWGfeQHZ
         1gFIAivMyDXgj7HNtWSIzcPuwxL1eoHi8atujmtZk0w9aM0sPwrUAa7MPv06Z8VCmXa/
         8qyA==
X-Gm-Message-State: APt69E2JN0XhcY4OxOjAdIXze6WoVTVAtrczusGq1mQpguPir7tQzMdz
        OyXFC7Kg0qq0f5nJfJAA39/fcQ==
X-Google-Smtp-Source: ADUXVKLVXoxkd6M3mPwGWhG0i4POsfWM2Yxt5jmOrTNX+5U6HVfaKlkn1HOg4fASXb7x/7ns6Faq7g==
X-Received: by 2002:a6b:3446:: with SMTP id b67-v6mr1477125ioa.6.1528766340304;
        Mon, 11 Jun 2018 18:19:00 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id f12-v6sm4748028itc.41.2018.06.11.18.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 18:18:58 -0700 (PDT)
Subject: Re: [PATCH 1/2] Convert target drivers to use sbitmap
From:   Jens Axboe <axboe@kernel.dk>
To:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, linux-usb@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        qla2xxx-upstream@qlogic.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Matthew Wilcox <mawilcox@microsoft.com>
References: <20180515160043.27044-1-willy@infradead.org>
 <20180515160043.27044-2-willy@infradead.org>
 <3a56027b-47bc-dcb8-a465-3670031572f1@kernel.dk>
Message-ID: <02326395-3241-c94b-ad70-3de27a6f5a8c@kernel.dk>
Date:   Mon, 11 Jun 2018 19:18:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <3a56027b-47bc-dcb8-a465-3670031572f1@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/18 10:11 AM, Jens Axboe wrote:
> On 5/15/18 10:00 AM, Matthew Wilcox wrote:
>> From: Matthew Wilcox <mawilcox@microsoft.com>
>>
>> The sbitmap and the percpu_ida perform essentially the same task,
>> allocating tags for commands.  Since the sbitmap is more used than
>> the percpu_ida, convert the percpu_ida users to the sbitmap API.
> 
> It should also be the same performance as percpu_ida in light use, and
> performs much better at > 50% utilization of the tag space. I think
> that's better justification than "more used than".
> 
>> diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/iscsi/iscsi_target_util.c
>> index 4435bf374d2d..28bcffae609f 100644
>> --- a/drivers/target/iscsi/iscsi_target_util.c
>> +++ b/drivers/target/iscsi/iscsi_target_util.c
>> @@ -17,7 +17,7 @@
>>   ******************************************************************************/
>>  
>>  #include <linux/list.h>
>> -#include <linux/percpu_ida.h>
>> +#include <linux/sched/signal.h>
>>  #include <net/ipv6.h>         /* ipv6_addr_equal() */
>>  #include <scsi/scsi_tcq.h>
>>  #include <scsi/iscsi_proto.h>
>> @@ -147,6 +147,28 @@ void iscsit_free_r2ts_from_list(struct iscsi_cmd *cmd)
>>  	spin_unlock_bh(&cmd->r2t_lock);
>>  }
>>  
>> +int iscsit_wait_for_tag(struct se_session *se_sess, int state, int *cpup)
>> +{
>> +	int tag = -1;
>> +	DEFINE_WAIT(wait);
>> +	struct sbq_wait_state *ws;
>> +
>> +	if (state == TASK_RUNNING)
>> +		return tag;
>> +
>> +	ws = &se_sess->sess_tag_pool.ws[0];
>> +	for (;;) {
>> +		prepare_to_wait_exclusive(&ws->wait, &wait, state);
>> +		if (signal_pending_state(state, current))
>> +			break;
>> +		schedule();
>> +		tag = sbitmap_queue_get(&se_sess->sess_tag_pool, cpup);
>> +	}
>> +
>> +	finish_wait(&ws->wait, &wait);
>> +	return tag;
>> +}
> 
> Seems like that should be:
> 
> 
> 	ws = &se_sess->sess_tag_pool.ws[0];
> 	for (;;) {
> 		prepare_to_wait_exclusive(&ws->wait, &wait, state);
> 		if (signal_pending_state(state, current))
> 			break;
> 		tag = sbitmap_queue_get(&se_sess->sess_tag_pool, cpup);
> 		if (tag != -1)
> 			break;
> 		schedule();
> 	}
> 
> 	finish_wait(&ws->wait, &wait);
> 	return tag;
> 
>>  /*
>>   * May be called from software interrupt (timer) context for allocating
>>   * iSCSI NopINs.
>> @@ -155,9 +177,11 @@ struct iscsi_cmd *iscsit_allocate_cmd(struct iscsi_conn *conn, int state)
>>  {
>>  	struct iscsi_cmd *cmd;
>>  	struct se_session *se_sess = conn->sess->se_sess;
>> -	int size, tag;
>> +	int size, tag, cpu;
>>  
>> -	tag = percpu_ida_alloc(&se_sess->sess_tag_pool, state);
>> +	tag = sbitmap_queue_get(&se_sess->sess_tag_pool, &cpu);
>> +	if (tag < 0)
>> +		tag = iscsit_wait_for_tag(se_sess, state, &cpu);
>>  	if (tag < 0)
>>  		return NULL;
> 
> Might make sense to just roll the whole thing into iscsi_get_tag(), that
> would be cleaner.
> 
> sbitmap should provide a helper for that, but we can do that cleanup
> later. That would encapsulate things like the per-cpu caching hint too,
> for instance.
> 
> Rest looks fine to me.

Are you going to push this further? I really think we should.

-- 
Jens Axboe

