Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23840C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8E520657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goXaIwUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8E520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbeKAVSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:18:48 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42118 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbeKAVSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:18:48 -0400
Received: by mail-oi1-f196.google.com with SMTP id h23-v6so16391512oih.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 05:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BWgaB3EEVsV+i7XOhMQZSwzQH6K5RrOr97/lwgXbhNQ=;
        b=goXaIwUTcEHYfJQW5IlSmt0TMcLKozunufEsTfpbYyhnd/qIe7NwkcmRuIpOsguCXp
         w6E2eptfchrOUReQp0gnsz67PtQtP65vQ/5wRgCE4ii4fcD6MdF43ENmkjTGbJFe19d1
         boIiAtUpGGSv/L7zxWTLd0pVyN1HRJNa9DJuBspHzO4bQPira5f14c6Yox61LiwIbgxR
         L09hAC2kMBYBGrPfLcGdZexdQC1ELy7Dik0hdUrHYG1s/eQGqtw4z0eWwkJ4QJTlIkFq
         HdmKc/zLe6rRn8Ky31ckYcbmcS7EnVwpoY1LTMtOIWnoEQmuWhC98ZX+hqAavl7EQKQi
         no2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BWgaB3EEVsV+i7XOhMQZSwzQH6K5RrOr97/lwgXbhNQ=;
        b=trYJyJHjpE9aubZYZpysOJWf/6To5epbCocUBpIZNnOFwI3mmWOp4zn0pnD8ypzYPY
         +uDzAoIAaxrJwhE78eIMKIaPYVZMoQWcd8sAQlDwPpgdFfgL5KuXi6APc9pvjsZyco8C
         4/n0NDZLLvI6sYNkTLkRWoKI7xohyY+h9jUvmim4stJWmPdzatqu1CjeMCxtZjP5FO6h
         xaZYEpZ3WcQhwoYFvZjCw5nT1AKasgKMjuCa9GL868D/9tD+dlVHuEkJ6s8AUkxJI4Kb
         U4u4r6UwdpHpN7f8BIx1Q+gJXjgPcmQ9eK2I2OdVC6oqjD3glPRSTdMrudgqnQgiMEod
         J7Jw==
X-Gm-Message-State: AGRZ1gIpdt9Id2H9qbtXP3xlwuqMs4vGCZ/1cbVXuzbN6jL8AH9HpEPK
        e3yiU7ULP+w2XwBo+G0BR5A=
X-Google-Smtp-Source: AJdET5cDOMpueE3rg/sFlCtKBzNtaObCXeW95V+FYI7TDDh7HnC2sFkw5f+y6yQhb82axyfJbaAmgw==
X-Received: by 2002:aca:b504:: with SMTP id e4-v6mr4317375oif.25.1541074564576;
        Thu, 01 Nov 2018 05:16:04 -0700 (PDT)
Received: from JosephdeMacBook-Pro.local ([47.89.83.53])
        by smtp.gmail.com with ESMTPSA id c29sm11450468otj.58.2018.11.01.05.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 05:16:03 -0700 (PDT)
Subject: Re: [Ocfs2-devel] [PATCH V3] ocfs2: fix dead lock caused by
 ocfs2_defrag_extent
To:     Changwei Ge <ge.changwei@h3c.com>, Larry Chen <lchen@suse.com>,
        "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20181101071422.14470-1-lchen@suse.com>
 <c07c65cb-8492-d866-6a1f-ffa64b293ea0@gmail.com>
 <63ADC13FD55D6546B7DECE290D39E37301277DE397@H3CMLB12-EX.srv.huawei-3com.com>
From:   Joseph Qi <jiangqi903@gmail.com>
Message-ID: <4f96339a-6209-eee1-3792-4720eca35688@gmail.com>
Date:   Thu, 1 Nov 2018 20:15:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <63ADC13FD55D6546B7DECE290D39E37301277DE397@H3CMLB12-EX.srv.huawei-3com.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/11/1 19:52, Changwei Ge wrote:
> Hello Joseph,
> 
> On 2018/11/1 17:01, Joseph Qi wrote:
>> Hi Larry,
>>
>> On 18/11/1 15:14, Larry Chen wrote:
>>> ocfs2_defrag_extent may fall into deadlock.
>>>
>>> ocfs2_ioctl_move_extents
>>>      ocfs2_ioctl_move_extents
>>>        ocfs2_move_extents
>>>          ocfs2_defrag_extent
>>>            ocfs2_lock_allocators_move_extents
>>>
>>>              ocfs2_reserve_clusters
>>>                inode_lock GLOBAL_BITMAP_SYSTEM_INODE
>>>
>>> 	  __ocfs2_flush_truncate_log
>>>                inode_lock GLOBAL_BITMAP_SYSTEM_INODE
>>>
>>> As backtrace shows above, ocfs2_reserve_clusters() will call inode_lock
>>> against the global bitmap if local allocator has not sufficient cluters.
>>> Once global bitmap could meet the demand, ocfs2_reserve_cluster will
>>> return success with global bitmap locked.
>>>
>>> After ocfs2_reserve_cluster(), if truncate log is full,
>>> __ocfs2_flush_truncate_log() will definitely fall into deadlock because it
>>> needs to inode_lock global bitmap, which has already been locked.
>>>
>>> To fix this bug, we could remove from ocfs2_lock_allocators_move_extents()
>>> the code which intends to lock global allocator, and put the removed code
>>> after __ocfs2_flush_truncate_log().
>>>
>>> ocfs2_lock_allocators_move_extents() is referred by 2 places, one is here,
>>> the other does not need the data allocator context, which means this patch
>>> does not affect the caller so far.
>>>
>>> Change log:
>>> 1. Correct the function comment.
>>> 2. Remove unused argument from ocfs2_lock_meta_allocator_move_extents.
>>>
>>> Signed-off-by: Larry Chen <lchen@suse.com>
>>> ---
>>>   fs/ocfs2/move_extents.c | 47 ++++++++++++++++++++++++++---------------------
>>>   1 file changed, 26 insertions(+), 21 deletions(-)
>>>
> 
>> IMO, here clusters_to_move is only for data_ac, since we change this
>> function to only handle meta_ac, I'm afraid clusters_to_move related
>> logic has to been changed correspondingly.
> 
> I think we can't remove *clusters_to_move* from here as clusters can be reserved latter outsides this function, but we
> still have to reserve metadata(extents) in advance.
> So we need that argument.
> 
I was not saying just remove it.
IIUC, clusters_to_move is for reserving data clusters (for meta_ac, we
mostly talk about blocks). Since we have moved data cluster reserve
logic out of ocfs2_lock_allocators_move_extents() now, then left
clusters_to_move related logic here is odd.

>>>   					u32 extents_to_split,
>>>   					struct ocfs2_alloc_context **meta_ac,
>>> -					struct ocfs2_alloc_context **data_ac,
>>>   					int extra_blocks,
>>>   					int *credits)
>>>   {
>>> @@ -192,13 +188,6 @@ static int ocfs2_lock_allocators_move_extents(struct inode *inode,
>>>   		goto out;
>>>   	}
>>>   
>>> -	if (data_ac) {
>>> -		ret = ocfs2_reserve_clusters(osb, clusters_to_move, data_ac);
>>> -		if (ret) {
>>> -			mlog_errno(ret);
>>> -			goto out;
>>> -		}
>>> -	}
>>>   
>>>   	*credits += ocfs2_calc_extend_credits(osb->sb, et->et_root_el);
>>>   
>>> @@ -257,10 +246,10 @@ static int ocfs2_defrag_extent(struct ocfs2_move_extents_context *context,
>>>   		}
>>>   	}
>>>   
>>> -	ret = ocfs2_lock_allocators_move_extents(inode, &context->et, *len, 1,
>>> -						 &context->meta_ac,
>>> -						 &context->data_ac,
>>> -						 extra_blocks, &credits);
>>> +	ret = ocfs2_lock_meta_allocator_move_extents(inode, &context->et,
>>> +						*len, 1,
>>> +						&context->meta_ac,
>>> +						extra_blocks, &credits);
>>>   	if (ret) {
>>>   		mlog_errno(ret);
>>>   		goto out;
>>> @@ -283,6 +272,21 @@ static int ocfs2_defrag_extent(struct ocfs2_move_extents_context *context,
>>>   		}
>>>   	}
>>>   
>>> +	/*
>>> +	 * Make sure ocfs2_reserve_cluster is called after
>>> +	 * __ocfs2_flush_truncate_log, otherwise, dead lock may happen.
>>> +	 *
>>> +	 * If ocfs2_reserve_cluster is called
>>> +	 * before __ocfs2_flush_truncate_log, dead lock on global bitmap
>>> +	 * may happen.
>>> +	 *
>>> +	 */
>>> +	ret = ocfs2_reserve_clusters(osb, *len, &context->data_ac);
>>> +	if (ret) {
>>> +		mlog_errno(ret);
>>> +		goto out_unlock_mutex;
>>> +	}
>>> +
>>>   	handle = ocfs2_start_trans(osb, credits);
>>>   	if (IS_ERR(handle)) {
>>>   		ret = PTR_ERR(handle);
>>> @@ -600,9 +604,10 @@ static int ocfs2_move_extent(struct ocfs2_move_extents_context *context,
>>>   		}
>>>   	}
>>>   
>>> -	ret = ocfs2_lock_allocators_move_extents(inode, &context->et, len, 1,
>>> -						 &context->meta_ac,
>>> -						 NULL, extra_blocks, &credits);
>>> +	ret = ocfs2_lock_meta_allocator_move_extents(inode, &context->et,
>>> +						len, 1,
>>> +						&context->meta_ac,
>>> +						extra_blocks, &credits);
>>>   	if (ret) {
>>>   		mlog_errno(ret);
>>>   		goto out;
>>>
>>
>> _______________________________________________
>> Ocfs2-devel mailing list
>> Ocfs2-devel@oss.oracle.com
>> https://oss.oracle.com/mailman/listinfo/ocfs2-devel
>>
