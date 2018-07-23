Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92A6ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D3C20856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 16:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMuLlv/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D3C20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388896AbeGWRxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 13:53:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34712 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388703AbeGWRxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 13:53:45 -0400
Received: by mail-lj1-f196.google.com with SMTP id f8-v6so1141733ljk.1;
        Mon, 23 Jul 2018 09:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tZr1StP6kJnmpv0fkJrvlE3LjUC1pZlCQlUsdxi0lTU=;
        b=eMuLlv/DmtM35BNfpSnpdj5qLcmb+TrpBTQT52qqU+XKW36BkEGa3NUQN9K/7jTW/b
         0SwI5nrQ7kVPIxIIGirPUCjQ56VihpAIy2wBwOdR7iBk0TceKwFhlTN2vbm3i45DcA1j
         IVHrqG3+xROnyL8RtWc14E5IhAVKaAc5a/yDLaaxnn76ESCu7d+UjzAS2FmnppEXFmg1
         Yjzh7MuHLVnvyrnlpcSniHVmroFhdc0mgeQlVarIG/3wnUgozx7aKmlPDVHTuw4wW7Ps
         8f0GlPYU/dagO6Aht/Ffc2xy1xrHsgIxC3/fqyPC7tc88PoaLLBNuJvaXKVBuGov9MoO
         l77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tZr1StP6kJnmpv0fkJrvlE3LjUC1pZlCQlUsdxi0lTU=;
        b=pjSfLA4OITZn6maQMD3rkb8uzlDRj0FyjB3QKEl+xfvi+5aZR3j7BhQ6PZOMq2Yohd
         0POgHcRgrBLhLPjGVRSJtIHTwWCUVDCMFVh+cwSuAuAcG9gyyac0vfriZ1oGLzAryQv6
         wD4nOIRp0LlnGXpG+CjCqMyuid1VxyDPPsphjh5hTtpBzbvPUB4Wh9TVxVW6qOk5wQ6o
         czvXIDE1FcZuWVtzrU/RcSwFOAn3Kj/M4ZkSkOrv9/PNhRaBa89tKvyLZYEjEQ7xnEXh
         h3AIPfY6yTDQeQQwYPl0/6lnbkdvv0ndm8BFbCKrqjq7KV/64QClLGMTqnaMMwP1IrtV
         vPRA==
X-Gm-Message-State: AOUpUlHKrrdFuof+78UAEtFy36TLVdwg2a/K0zycA+Jw9A3eeNOCRI30
        TOTHagTtwvIo2NN1Blz9JWs=
X-Google-Smtp-Source: AAOMgpcrQ3AeFFnR5SAu0uerctLluBCKA9tKT1ubcIYR94O7RQOkfDf9txY9o7po8z7Ri1/YPPICYA==
X-Received: by 2002:a2e:9c82:: with SMTP id x2-v6mr9915103lji.131.1532364697298;
        Mon, 23 Jul 2018 09:51:37 -0700 (PDT)
Received: from ?IPv6:2001:2012:22e:1b00:f2e2:9015:9262:3fde? ([2001:2012:22e:1b00:f2e2:9015:9262:3fde])
        by smtp.gmail.com with ESMTPSA id w12-v6sm1921338lji.63.2018.07.23.09.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 09:51:36 -0700 (PDT)
Subject: Re: [PATCH] net/p9/trans_fd.c: fix double list_del()
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net,
        jiangyiwen@huawei.com, davem@davemloft.net,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
References: <20180723121902.20201-1-tomasbortoli@gmail.com>
 <20180723125701.GA17971@nautica>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8c11b552-b5d7-120c-0ac1-2c62162c10af@gmail.com>
Date:   Mon, 23 Jul 2018 18:51:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723125701.GA17971@nautica>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 02:57 PM, Dominique Martinet wrote:
> Tomas Bortoli wrote on Mon, Jul 23, 2018:
>> A double list_del(&req->req_list) is possible in p9_fd_cancel() as
>> shown by Syzbot. To prevent it we have to ensure that we have the
>> client->lock when deleting the list. Furthermore, we have to update
>> the status of the request before releasing the lock, to prevent the
>> race.
> 
> Nice, so no need to change the list_del to list_del_init!
> 
> I still have a nitpick on the last moved unlock, but it's mostly
> aesthetic - the change looks much better to me now.
> 
> (Since that will require a v2 I'll be evil and go further than Yiwen
> about the commit message: let it breathe a bit! :) I think a line break
> before "furthermore" for example will make it easier to read)
> 

agree

>>
>> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
>> Reported-by: syzbot+735d926e9d1317c3310c@syzkaller.appspotmail.com
>> ---
>>  net/9p/trans_fd.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
>> index a64b01c56e30..370c6c69a05c 100644
>> --- a/net/9p/trans_fd.c
>> +++ b/net/9p/trans_fd.c
>> @@ -199,15 +199,14 @@ static void p9_mux_poll_stop(struct p9_conn *m)
>>  static void p9_conn_cancel(struct p9_conn *m, int err)
>>  {
>>  	struct p9_req_t *req, *rtmp;
>> -	unsigned long flags;
>>  	LIST_HEAD(cancel_list);
>>  
>>  	p9_debug(P9_DEBUG_ERROR, "mux %p err %d\n", m, err);
>>  
>> -	spin_lock_irqsave(&m->client->lock, flags);
>> +	spin_lock(&m->client->lock);
>>  
>>  	if (m->err) {
>> -		spin_unlock_irqrestore(&m->client->lock, flags);
>> +		spin_unlock(&m->client->lock);
>>  		return;
>>  	}
>>  
>> @@ -219,7 +218,6 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
>>  	list_for_each_entry_safe(req, rtmp, &m->unsent_req_list, req_list) {
>>  		list_move(&req->req_list, &cancel_list);
>>  	}
>> -	spin_unlock_irqrestore(&m->client->lock, flags);
>>  
>>  	list_for_each_entry_safe(req, rtmp, &cancel_list, req_list) {
>>  		p9_debug(P9_DEBUG_ERROR, "call back req %p\n", req);
>> @@ -228,6 +226,7 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
>>  			req->t_err = err;
>>  		p9_client_cb(m->client, req, REQ_STATUS_ERROR);
>>  	}
>> +	spin_unlock(&m->client->lock);
>>  }
>>  
>>  static __poll_t
>> @@ -370,12 +369,12 @@ static void p9_read_work(struct work_struct *work)
>>  		if (m->req->status != REQ_STATUS_ERROR)
>>  			status = REQ_STATUS_RCVD;
>>  		list_del(&m->req->req_list);
>> -		spin_unlock(&m->client->lock);
>>  		p9_client_cb(m->client, m->req, status);
>>  		m->rc.sdata = NULL;
>>  		m->rc.offset = 0;
>>  		m->rc.capacity = 0;
>>  		m->req = NULL;
>> +		spin_unlock(&m->client->lock);
> 
> It took me a while to understand why you extended this lock despite
> having just read the commit message, I'd suggest:
>  - moving the spin_unlock to right after p9_client_cb (afterall that's
> what we want, the m->rc and m->req don't need to be protected)

yes, better.

>  - add a comment before p9_client_cb saying something like 'updates
> req->status' or try to explain why it needs to be locked here but other
> transports don't need such a lock (they're not dependant on req->status
> like this)
> 

ok

thanks for the feedback
