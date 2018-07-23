Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6AFECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398E220854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4mAvWJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398E220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388187AbeGWMrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:47:37 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42018 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388011AbeGWMrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:47:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id u202-v6so231524lff.9;
        Mon, 23 Jul 2018 04:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RznM9m3c8MWP1nCHvlWx+pGFryc21g3Q0lsyZNIEWks=;
        b=R4mAvWJxxogiJy1S9EA+hfVV6Z+18MwXNIMSNyd9LkFAoHlmJRXuYPucvaITuzxlhO
         rQwALHRCMEoXpoDhLbkH/YoR4wMh5BuS6Gp3xtHuLZI7TRZtXxO4MJq/yEkQ0HG63vYm
         b9Gbjfw1bkcouw1PaDRG8ANMeD274X7OoRFkguMaWnEhkVgekqVBuUdebptjne5IYEMn
         YT7u9O8yaoZdGoBI6JhHKeJTpzv/7njxbehtx6RWzkfY5T/7A33lzN6Kf3SzfUFTvZky
         cOxxoq+y1IkJ919maBAbSxuTLPoY/TtekociKSnotwtnKRmBXt7Co9lojCguIs5kTRK2
         NCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RznM9m3c8MWP1nCHvlWx+pGFryc21g3Q0lsyZNIEWks=;
        b=obRKSXXwb/pBoMNFPAaPfd/nB5ln+m/tnF+F0daw6rNgKQxLVnxljXXgahhM8DDMxD
         +2GMPev1xjJJvdhY+hNHRZNvrvjyMHxP+6Z8Gxnzhca6s06Zr6WxkBlnP8I4oDxo6brj
         +RCVHRAQCECqBC2o7TFfs5nZS2fb6S6LpJp0oWSivRuQTVIAB/K+/FHDrc3OvTtGQjjS
         4QAT6v4YCcgHMS7oJEew3uDS5t23Z3dHu6yhnnW5yrgB9/rsbI68b/3pp4j/vatsDksb
         Kn65fWzTszq8AQpR+3kKhKtpus0vqDjzSEgKbh5HmsM84SiPiANt7c9HczZejPvjKTmK
         ljxg==
X-Gm-Message-State: AOUpUlF9R1WsBraJQECh4oaSIiNEG73lAApiJSitv3OOXcZnrtN/47Z4
        oQKJ8zN66C6EL8sCDLFnn4w=
X-Google-Smtp-Source: AAOMgpdp5eEOpt392+g1M82NddQF13qqhWaXzeLlZW8qUu2GE1hMvRVCZa5GMveGbA8xWfCh8JjL7Q==
X-Received: by 2002:a19:b2c7:: with SMTP id t68-v6mr6949164lfk.132.1532346404415;
        Mon, 23 Jul 2018 04:46:44 -0700 (PDT)
Received: from ?IPv6:2001:2012:22e:1b00:f2e2:9015:9262:3fde? ([2001:2012:22e:1b00:f2e2:9015:9262:3fde])
        by smtp.gmail.com with ESMTPSA id o27-v6sm1386721lfb.78.2018.07.23.04.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 04:46:43 -0700 (PDT)
Subject: Re: [PATCH] net/9p/trans_fd.c: fix double list_del() and race in
 access
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net,
        jiangyiwen@huawei.com, davem@davemloft.net,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
References: <20180720132801.22749-1-tomasbortoli@gmail.com>
 <20180723030251.GB24608@nautica>
From:   Tomas Bortoli <tomasbortoli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tomasbortoli@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8b2c1367-9a3b-3cd6-d141-870eb2f4f0ed@gmail.com>
Date:   Mon, 23 Jul 2018 13:46:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723030251.GB24608@nautica>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 05:02 AM, Dominique Martinet wrote:
> Tomas Bortoli wrote on Fri, Jul 20, 2018:
>> This patch uses list_del_init() instead of list_del() to eliminate
>> "req_list". This to prevent double list_del()'s calls to the same list
>> from provoking a GPF. Furthermore, this patch fixes an access to
>> "req_list" that was made without getting the relative lock.
> 
> Please see comment about locking.
> 
> As for list_del to list_del_init, it feels a little wrong to me, but I
> don't have a better idea so let's go with that.

Yes, it's not the best solution.

> Do you know what happened to trigger this? one thread running
> p9_conn_cancel then the other thread doing p9_fd_cancel ?
> 

I don't see how races should be prevented. The bug is triggered in
p9_fd_cancel and in this case it's due to the status of the request
being REQ_STATUS_UNSENT but list_del(&req->req_list) is used 4 times in
trans_fd.c:

- p9_read_work()
with the lock but updating the status afterwards  (brings to race)
- p9_conn_cancel()
without the lock and updating the status afterwards  (brings to race)
- p9_fd_cancelled()
.. ?
-p9_fd_cancel()
with lock, run on conditional status
BOOM

So, maybe we can try to see if it's the problem of syncing the status
between different threads or if it's more but idk.

>> Signed-off-by: Tomas Bortoli <tomasbortoli@gmail.com>
>> Reported-by: syzbot+735d926e9d1317c3310c@syzkaller.appspotmail.com
>> ---
>>
>>  net/9p/trans_fd.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
>> index a64b01c56e30..131bb1f059e6 100644
>> --- a/net/9p/trans_fd.c
>> +++ b/net/9p/trans_fd.c
>> @@ -223,7 +223,9 @@ static void p9_conn_cancel(struct p9_conn *m, int err)
>>  
>>  	list_for_each_entry_safe(req, rtmp, &cancel_list, req_list) {
>>  		p9_debug(P9_DEBUG_ERROR, "call back req %p\n", req);
>> -		list_del(&req->req_list);
>> +		spin_lock_irqsave(&m->client->lock, flags);
>> +		list_del_init(&req->req_list);
>> +		spin_unlock_irqrestore(&m->client->lock, flags);
> 
> Just locking around one item if you're afraid it might change won't be
> enough - list_for_each_entry_safe is only "safe" from removing the
> current element from the list yourself, not from other threads messing
> with it, so you'd need to lock around the whole loop if that's what
> you're protecting against.
> 

Right, I thought I had to unlock before p9_client_cb() as here:

https://github.com/torvalds/linux/blob/master/net/9p/trans_fd.c#L375

However, also locking the client mutex for the whole loop doesn't seem
to give problems. See patch below

> (Also, since I've taken the other patchs to change spin locks on
> client->lock to spin_lock instead of spin_lock_irqsave, please use that
> function for new locking of that variable - in general just basing your
> patchs off linux-next's master branch is a good idea.)
> 
>>  		if (!req->t_err)
>>  			req->t_err = err;
>>  		p9_client_cb(m->client, req, REQ_STATUS_ERROR);
>> @@ -369,7 +371,7 @@ static void p9_read_work(struct work_struct *work)
>>  		spin_lock(&m->client->lock);
>>  		if (m->req->status != REQ_STATUS_ERROR)
>>  			status = REQ_STATUS_RCVD;
>> -		list_del(&m->req->req_list);
>> +		list_del_init(&m->req->req_list);
>>  		spin_unlock(&m->client->lock);
>>  		p9_client_cb(m->client, m->req, status);
>>  		m->rc.sdata = NULL;
>> @@ -684,7 +686,7 @@ static int p9_fd_cancel(struct p9_client *client, struct p9_req_t *req)
>>  	spin_lock(&client->lock);
>>  
>>  	if (req->status == REQ_STATUS_UNSENT) {
>> -		list_del(&req->req_list);
>> +		list_del_init(&req->req_list);
>>  		req->status = REQ_STATUS_FLSHD;
>>  		ret = 0;
>>  	}
>> @@ -701,7 +703,7 @@ static int p9_fd_cancelled(struct p9_client *client, struct p9_req_t *req)
>>  	 * remove it from the list.
>>  	 */
>>  	spin_lock(&client->lock);
>> -	list_del(&req->req_list);
>> +	list_del_init(&req->req_list);
>>  	spin_unlock(&client->lock);
>>  
>>  	return 0;



diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index a64b01c56e30..2ae5f03d872f 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -199,15 +199,14 @@ static void p9_mux_poll_stop(struct p9_conn *m)
 static void p9_conn_cancel(struct p9_conn *m, int err)
 {
 	struct p9_req_t *req, *rtmp;
-	unsigned long flags;
 	LIST_HEAD(cancel_list);

 	p9_debug(P9_DEBUG_ERROR, "mux %p err %d\n", m, err);

-	spin_lock_irqsave(&m->client->lock, flags);
+	spin_lock(&m->client->lock);

 	if (m->err) {
-		spin_unlock_irqrestore(&m->client->lock, flags);
+		spin_unlock(&m->client->lock);
 		return;
 	}

@@ -223,11 +222,12 @@ static void p9_conn_cancel(struct p9_conn *m, int err)

 	list_for_each_entry_safe(req, rtmp, &cancel_list, req_list) {
 		p9_debug(P9_DEBUG_ERROR, "call back req %p\n", req);
-		list_del(&req->req_list);
+		list_del_init(&req->req_list);
 		if (!req->t_err)
 			req->t_err = err;
 		p9_client_cb(m->client, req, REQ_STATUS_ERROR);
 	}
+	spin_unlock(&m->client->lock);
 }

 static __poll_t
@@ -369,7 +369,7 @@ static void p9_read_work(struct work_struct *work)
 		spin_lock(&m->client->lock);
 		if (m->req->status != REQ_STATUS_ERROR)
 			status = REQ_STATUS_RCVD;
-		list_del(&m->req->req_list);
+		list_del_init(&m->req->req_list);
 		spin_unlock(&m->client->lock);
 		p9_client_cb(m->client, m->req, status);
 		m->rc.sdata = NULL;
@@ -684,7 +684,7 @@ static int p9_fd_cancel(struct p9_client *client,
struct p9_req_t *req)
 	spin_lock(&client->lock);

 	if (req->status == REQ_STATUS_UNSENT) {
-		list_del(&req->req_list);
+		list_del_init(&req->req_list);
 		req->status = REQ_STATUS_FLSHD;
 		ret = 0;
 	}
@@ -701,7 +701,7 @@ static int p9_fd_cancelled(struct p9_client *client,
struct p9_req_t *req)
 	 * remove it from the list.
 	 */
 	spin_lock(&client->lock);
-	list_del(&req->req_list);
+	list_del_init(&req->req_list);
 	spin_unlock(&client->lock);

 	return 0;

