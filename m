Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C776C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B675208AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uQUT+N8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B675208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeH0TY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 15:24:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33695 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbeH0TY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 15:24:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so7925623pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 08:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NAU2QFwQIvF/QrV4WbIjBVbOO2SnP/hwier+0WbMwwc=;
        b=uQUT+N8u1KXgRRVTt8kY0nFNqBAP2H2bDbG2npyOrxy8xB5Klns1WrwwEgpudOLWev
         dvVEaNKGnjUIej/Kpy7Y7RPmyWYvWnYaR9I083ngRnB8dCPjbdAU+KySCz5Mt/4quhPW
         7to+xa3JIw96BD7ZHkX/z+Vwy/KJYaIlbMtTuu1HWgnK3G85xgk02MqqTlracuwHJApe
         S4uXR5d5GALrZJhtopQrjnhzVY8wwjit/KBz+FJWWx7dlvjSYUrPqPKvX3wT3oo8E6hN
         aVTc3nb6ivxVVXXrbqgh1xptV6L26DgOMKmt9zSPPu/Zd6M2+LoxbiZCdOVe1XmjX+f8
         gYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NAU2QFwQIvF/QrV4WbIjBVbOO2SnP/hwier+0WbMwwc=;
        b=FK60RsiukvsgJZU/SJscFKMyyEC/dAbRzg3l+tkG/RAjS642hKjIQG+TcPFWPfSwli
         lQOaqM47Xqn6/hFLv+ZO5OKI58+n71QSN8HiZfwcAN2DuWRGaSomr6AEbFWfTCsvpdBz
         wmaIJZogFNKl/szRQPmRw6miz/VlJa4JwxQ3vR8M1c41AAZKhr7jNAXjwb3SU01cJMk8
         YbyJ3OCT2e8SWjYr6fyhJwKZbN1UI1qjgR3ciE1OvP8A/D+2ZmqshBOHY7nb53c0mdVn
         L8ifuDQ4N771J6PbU97Vs3Pn0oQy5wtVK0YPIumSk7Xk4hP+qIGb8MvyPhBbVpiNCzRL
         kzng==
X-Gm-Message-State: APzg51DeTBlIIci6tRXussITtR8UeK7/8byDJD+vHckNAUBVFsQ+GchF
        I92b8BrfhF46ApKIzGRTGj4/As741lQ=
X-Google-Smtp-Source: ANB0VdbzeQQBJMoJfZA9letGZOJGPQq8I3CyDRI87+8STR3jIKw8dt0i+KLKFND0V0kKNbYyukrudA==
X-Received: by 2002:a63:ce43:: with SMTP id r3-v6mr13006530pgi.439.1535384270348;
        Mon, 27 Aug 2018 08:37:50 -0700 (PDT)
Received: from ?IPv6:2620:10d:c081:1133::121a? ([2620:10d:c090:180::1:8ad2])
        by smtp.gmail.com with ESMTPSA id t70-v6sm24592308pgd.54.2018.08.27.08.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 08:37:48 -0700 (PDT)
Subject: Re: [PATCH] blk-wbt: get back the missed wakeup from __wbt_done
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Anchal Agarwal <anchalag@amzn.com>
Cc:     fllinden@amazon.com,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1535029718-17259-1-git-send-email-jianchao.w.wang@oracle.com>
 <bd84ff08-b75a-0a2f-6b37-07a104452bff@kernel.dk>
 <da9458c632cb4c4695660664bf7c3fb3@EX13D13UWB002.ant.amazon.com>
 <20180823210144.GB5624@kaos-source-ops-60001.pdx1.amazon.com>
 <3eaa20ce-0599-c405-d979-87d91ea331d2@kernel.dk>
 <20180824181223.GA9049@kaos-source-ops-60001.pdx1.amazon.com>
 <677c8648-63fd-601c-b906-40a8502f9782@kernel.dk>
 <20180824203305.GA4690@kaos-source-ops-60001.pdx1.amazon.com>
 <dc734449-7cd8-3a8e-9fdc-d7d854393900@kernel.dk>
 <2fecf2f2-f00b-f6ba-710a-54ceaacfedbb@kernel.dk>
 <00445460-d826-4d85-c5f4-fa565892da01@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cc7b19f7-b5c5-e89d-eb12-cdff6e35fb4d@kernel.dk>
Date:   Mon, 27 Aug 2018 09:37:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <00445460-d826-4d85-c5f4-fa565892da01@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/18 9:52 PM, jianchao.wang wrote:
> Hi Jens
> 
> On 08/25/2018 11:41 PM, Jens Axboe wrote:
>>  	do {
>> -		set_current_state(TASK_UNINTERRUPTIBLE);
>> +		if (test_bit(0, &data.flags))
>> +			break;
>>  
>> -		if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
>> +		WARN_ON_ONCE(list_empty(&data.wq.entry));
>> +
>> +		if (!has_sleeper &&
>> +		    rq_wait_inc_below(rqw, get_limit(rwb, rw))) {
>> +			finish_wait(&rqw->wait, &data.wq);
>> +
>> +			/*
>> +			 * We raced with wbt_wake_function() getting a token,
>> +			 * which means we now have two. Put ours and wake
>> +			 * anyone else potentially waiting for one.
>> +			 */
>> +			if (test_bit(0, &data.flags))
>> +				wbt_rqw_done(rwb, rqw, wb_acct);
>>  			break;
> 
> Just use 'bool' variable should be OK 
> After finish_wait, no one could race with us here.

I was mostly concerned with the check post prep_to_wait(), but since the
spin unlock should include a barrier, the bool should actually be enough.
I'll change that back once I test.

-- 
Jens Axboe

