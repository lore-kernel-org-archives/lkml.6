Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2ACC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC6620820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksX2jJJy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC6620820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbeKAQ1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 12:27:02 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35143 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbeKAQ1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 12:27:02 -0400
Received: by mail-ot1-f65.google.com with SMTP id 81so1162211otj.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 00:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3L8Pa44gmONniU7GipoHDkaXSmBj1+lug9DBcJLZGTM=;
        b=ksX2jJJyQaMGkTKEnSrWwUgEwn85grOVkm9j9zyG5EE+XFznbNh5fjKEVORmdM9Z+q
         rLZcG43uCNshfNCxkOO1k78R9f5jo7nj+l/hpQiXKqcjjDtbo2aZlMqU6Kfu/sNU/5J4
         r/gu6z8sHVu7ovtQ/IGvsgTmEMHMe+4jccxGRce9qaGeuaHawY249UIuac8KySKkQ4kF
         qt46KcQhr1TsjvwOXi/8Wc4k+qN2L1CQP673DABXJTWNRP5gyigZGaqLUtRqaUzRzq9i
         z3B3gGgFquEP7FomEgUChbaWDWHUF/PCg8Lg4hxojSANUFiFUIRVK1QC5AmU80TPM1ym
         da1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3L8Pa44gmONniU7GipoHDkaXSmBj1+lug9DBcJLZGTM=;
        b=nszxnHUHwTtJpY5Lt0o++tWC5K+mqY7cUBkNixmdP2CO2moPb8Sg/mtGEdPs/mTgPG
         YibfPj2HzNayL91lFs7vEqU095UgLf2KIc34ITTkyNnUJuyG+RmLJEw8yq2bO1xlEJ30
         NfiwyYe4reg2u8gigUESfkL5Dx+ytorB9x0zX3pMGVLkiu6zbUWBgR9bw68YnrwGwxc+
         TgA/yWtYtRs2E6PFtEA22gpHfnXPvpwEtpVfcZxr8NaHe2KzZV7SJ+3JrbETMs2E69Tn
         cfp9EdXfGDXFo88NLXmoTs16To2mkdyta7zdyQyx81D5NSEEEedkLaum8bSWW42q+v0C
         oEGg==
X-Gm-Message-State: AGRZ1gICUgBkDSHLkRazof4AL4ArRBlnIuuVx2qcKlVENVOuR2jpFr52
        G6XcnZuttkgMgBXfmc8UUdE=
X-Google-Smtp-Source: AJdET5ch0PDODgbEAhzeiRUhcmUDoYs7VXIOso7sCUOPWJyWMl7n2VG9Pmz+pryH26XxbeRdKDK1Kg==
X-Received: by 2002:a9d:44a6:: with SMTP id v38mr3353578ote.282.1541057113778;
        Thu, 01 Nov 2018 00:25:13 -0700 (PDT)
Received: from JosephdeMacBook-Pro.local ([47.89.83.53])
        by smtp.gmail.com with ESMTPSA id e198-v6sm10069437oic.5.2018.11.01.00.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 00:25:13 -0700 (PDT)
Subject: Re: [Ocfs2-devel] [PATCH V2] ocfs2: fix dead lock caused by
 ocfs2_defrag_extent
To:     Changwei Ge <ge.changwei@h3c.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Larry Chen <lchen@suse.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>
References: <20180902091455.23862-1-lchen@suse.com>
 <20181031142632.c523108bc137caa8cb1c6282@linux-foundation.org>
 <63ADC13FD55D6546B7DECE290D39E37301277DDF02@H3CMLB12-EX.srv.huawei-3com.com>
From:   Joseph Qi <jiangqi903@gmail.com>
Message-ID: <2fa82349-a32b-514c-d59d-8910a36cf255@gmail.com>
Date:   Thu, 1 Nov 2018 15:25:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <63ADC13FD55D6546B7DECE290D39E37301277DDF02@H3CMLB12-EX.srv.huawei-3com.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/11/1 11:11, Changwei Ge wrote:
> Hi Larry,
> 
> I still have a few tiny comments for your patch, please refer to them.
> 
> On 2018/11/1 5:28, Andrew Morton wrote:
>>
>> Folks, could we please review this patch for upstream inclusion?
>>
>> Thanks.
>>
>>
>> From: Larry Chen <lchen@suse.com>
>> Subject: ocfs2: fix deadlock caused by ocfs2_defrag_extent
>>
>> ocfs2_defrag_extent may fall into deadlock.
>>
>> ocfs2_ioctl_move_extents
>>    ocfs2_ioctl_move_extents
>>      ocfs2_move_extents
>>        ocfs2_defrag_extent
>>          ocfs2_lock_allocators_move_extents
>>
>>            ocfs2_reserve_clusters
>>              inode_lock GLOBAL_BITMAP_SYSTEM_INODE
>>
>> 	  __ocfs2_flush_truncate_log
>>              inode_lock GLOBAL_BITMAP_SYSTEM_INODE
>>
>> As backtrace shows above, ocfs2_reserve_clusters() will call inode_lock
>> against the global bitmap if local allocator has not sufficient cluters.
>> Once global bitmap could meet the demand, ocfs2_reserve_cluster will
>> return success with global bitmap locked.
>>
>> After ocfs2_reserve_cluster(), if truncate log is full,
>> __ocfs2_flush_truncate_log() will definitely fall into deadlock because it
>> needs to inode_lock global bitmap, which has already been locked.
>>
>> To fix this bug, we could remove from ocfs2_lock_allocators_move_extents()
>> the code which intends to lock global allocator, and put the removed code
>> after __ocfs2_flush_truncate_log().
>>
>> ocfs2_lock_allocators_move_extents() is refered by 2 places, one is here,
>> the other does not need the data allocator context, which means this patch
>> does not affect the caller so far.
>>
>> [lchen@suse.com: rename ocfs2_lock_allocators_move_extents() to ocfs2_lock_meta_allocator_move_extents(), add some comments]
>>    Link: https://urldefense.proofpoint.com/v2/url?u=http-3A__lkml.kernel.org_r_20180902091455.23862-2D1-2Dlchen-40suse.com&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=C7gAd4uDxlAvTdc0vmU6X8CMk6L2iDY8-HD0qT6Fo7Y&m=K8aRgOiMescamJW-IuHq-cW4mWedGQv2JTT-2KPy1RI&s=3fQHFtwgixirPeQ5Px4fRBnd_UcSx3rvSsLKLidwESo&e=
>> Link: https://urldefense.proofpoint.com/v2/url?u=http-3A__lkml.kernel.org_r_20180827080121.31145-2D1-2Dlchen-40suse.com&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=C7gAd4uDxlAvTdc0vmU6X8CMk6L2iDY8-HD0qT6Fo7Y&m=K8aRgOiMescamJW-IuHq-cW4mWedGQv2JTT-2KPy1RI&s=PQOJREyeElsg_1IlINdSGefNqA6w_cUrI1ezdVxyi7o&e=
>> Signed-off-by: Larry Chen <lchen@suse.com>
>> Cc: Mark Fasheh <mark@fasheh.com>
>> Cc: Joel Becker <jlbec@evilplan.org>
>> Cc: Junxiao Bi <junxiao.bi@oracle.com>
>> Cc: Joseph Qi <jiangqi903@gmail.com>
>> Cc: Changwei Ge <ge.changwei@h3c.com>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>
>>   fs/ocfs2/move_extents.c |   40 +++++++++++++++++++++++---------------
>>   1 file changed, 25 insertions(+), 15 deletions(-)
>>
>> --- a/fs/ocfs2/move_extents.c~fix-dead-lock-caused-by-ocfs2_defrag_extent
>> +++ a/fs/ocfs2/move_extents.c
>> @@ -162,7 +162,7 @@ out:
>>    * in some cases, we don't need to reserve clusters, just let data_ac
>>    * be NULL.
>>    */
>> -static int ocfs2_lock_allocators_move_extents(struct inode *inode,
>> +static int ocfs2_lock_meta_allocator_move_extents(struct inode *inode,
>>   					struct ocfs2_extent_tree *et,
>>   					u32 clusters_to_move,
>>   					u32 extents_to_split,
> 
> After removing 'reserving clusters logic' out of this function, I suggest to also change the function header comments.
> And I think there is no need for arguments _data_ac_ now.
> Otherwise this patch looks sane to me.
> 
Agree, I think I have commented this out before.

Thanks,
Joseph

> Thanks,
> Changwei
> 
>> @@ -192,13 +192,6 @@ static int ocfs2_lock_allocators_move_ex
>>   		goto out;
>>   	}
>>   
>> -	if (data_ac) {
>> -		ret = ocfs2_reserve_clusters(osb, clusters_to_move, data_ac);
>> -		if (ret) {
>> -			mlog_errno(ret);
>> -			goto out;
>> -		}
>> -	}
>>   
>>   	*credits += ocfs2_calc_extend_credits(osb->sb, et->et_root_el);
>>   
>> @@ -257,10 +250,11 @@ static int ocfs2_defrag_extent(struct oc
>>   		}
>>   	}
>>   
>> -	ret = ocfs2_lock_allocators_move_extents(inode, &context->et, *len, 1,
>> -						 &context->meta_ac,
>> -						 &context->data_ac,
>> -						 extra_blocks, &credits);
>> +	ret = ocfs2_lock_meta_allocator_move_extents(inode, &context->et,
>> +						*len, 1,
>> +						&context->meta_ac,
>> +						&context->data_ac,
>> +						extra_blocks, &credits);
>>   	if (ret) {
>>   		mlog_errno(ret);
>>   		goto out;
>> @@ -283,6 +277,21 @@ static int ocfs2_defrag_extent(struct oc
>>   		}
>>   	}
>>   
>> +	/*
>> +	 * Make sure ocfs2_reserve_cluster is called after
>> +	 * __ocfs2_flush_truncate_log, otherwise, dead lock may happen.
>> +	 *
>> +	 * If ocfs2_reserve_cluster is called
>> +	 * before __ocfs2_flush_truncate_log, dead lock on global bitmap
>> +	 * may happen.
>> +	 *
>> +	 */
>> +	ret = ocfs2_reserve_clusters(osb, *len, &context->data_ac);
>> +	if (ret) {
>> +		mlog_errno(ret);
>> +		goto out_unlock_mutex;
>> +	}
>> +
>>   	handle = ocfs2_start_trans(osb, credits);
>>   	if (IS_ERR(handle)) {
>>   		ret = PTR_ERR(handle);
>> @@ -600,9 +609,10 @@ static int ocfs2_move_extent(struct ocfs
>>   		}
>>   	}
>>   
>> -	ret = ocfs2_lock_allocators_move_extents(inode, &context->et, len, 1,
>> -						 &context->meta_ac,
>> -						 NULL, extra_blocks, &credits);
>> +	ret = ocfs2_lock_meta_allocator_move_extents(inode, &context->et,
>> +						len, 1,
>> +						&context->meta_ac,
>> +						NULL, extra_blocks, &credits);
>>   	if (ret) {
>>   		mlog_errno(ret);
>>   		goto out;
>> _
>>
>>
>> _______________________________________________
>> Ocfs2-devel mailing list
>> Ocfs2-devel@oss.oracle.com
>> https://oss.oracle.com/mailman/listinfo/ocfs2-devel
>>
> 
> _______________________________________________
> Ocfs2-devel mailing list
> Ocfs2-devel@oss.oracle.com
> https://oss.oracle.com/mailman/listinfo/ocfs2-devel
> 
