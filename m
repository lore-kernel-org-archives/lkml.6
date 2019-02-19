Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F18C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC5D21773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digidescorp.com header.i=@digidescorp.com header.b="YktYwDIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfBSORN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:17:13 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39432 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfBSORN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:17:13 -0500
Received: by mail-it1-f193.google.com with SMTP id l15so6450352iti.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 06:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Fqx6wMPErDpY6UbPKmtvXSefKHHo5BRDjyvseIdxoSU=;
        b=YktYwDIcDC3oqQsjlbz0N2PROXJbYQQc0wjWdmW4uO0dKHo2B2TM9mBGmCSvEJZMTQ
         8GbknQ9vDiZbH3dt585Q4U1syIO31sRtGMRx0kZRct7UPv8eRQqwEQ06b+Vt34s4tty2
         4hRJQWvr/Vyyvm7wDwSkLJiBwMMA9GEZgQu3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Fqx6wMPErDpY6UbPKmtvXSefKHHo5BRDjyvseIdxoSU=;
        b=E9nqbVbYPNh36Oml/OGEc8t6PP+e1ichbNZWnMO1vIV/96BZFl5hDaWkio98Y2fAaf
         hNKLTr6jk6szGtAQdWUHva7XbKQqMMlT8dJwC3+dNtprdIzZbVtExcBqGZFMdBADWNOf
         08nfDr5fvMp64zEA0qN/Ohxvd8cHbS+8MMMqnkYN10qPqXMlIQGUEMP7ZtK9o3nXNOJv
         NnNTgJ9Soky9edfoKxqH3DgBiqL8iB1LmNBOjVFC3+0+q96Du2nxUYulWh2tUfy3LFTR
         2+O/slLVfY4e+RqcO0CXIx5AyeYh3pbbSPotwZEKK60Mpqf1PQbhvssK8IqkYpBLzU+j
         gV+w==
X-Gm-Message-State: AHQUAub25GnfcnGNax5I8cgpNHX37GrZLzJGL8ewzVS7ewWyqb03l9mg
        g66D411iXWa+iyfGwXQx0mpBI4kZ5fM=
X-Google-Smtp-Source: AHgI3Ib3U61uqF6z50d0xfNeW/k50ZTj9lkI8XNUmEON188LOvuHQR9xViQGZaf6bJIART5bhpFIQA==
X-Received: by 2002:a5d:9357:: with SMTP id i23mr5402700ioo.236.1550585832046;
        Tue, 19 Feb 2019 06:17:12 -0800 (PST)
Received: from [10.10.6.111] ([50.73.98.161])
        by smtp.googlemail.com with ESMTPSA id c1sm1260460itd.23.2019.02.19.06.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 06:17:10 -0800 (PST)
Subject: Re: [PATCH][udf-next] udf: don't call mark_buffer_dirty on a null bh
 pointer
To:     Jan Kara <jack@suse.cz>, Colin King <colin.king@canonical.com>
Cc:     Jan Kara <jack@suse.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190219114403.24771-1-colin.king@canonical.com>
 <20190219140240.GA31849@quack2.suse.cz>
From:   Steve Magnani <steve.magnani@digidescorp.com>
Message-ID: <aef899da-4dc1-1e40-30c9-fc2ca87f2380@digidescorp.com>
Date:   Tue, 19 Feb 2019 08:17:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190219140240.GA31849@quack2.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/19 8:02 AM, Jan Kara wrote:
> On Tue 19-02-19 11:44:03, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> There is a null check on the pointer bh to avoid a null pointer dereference
>> on bh->b_data however later bh is passed to mark_buffer_dirty that can also
>> cause a null pointer dereference on bh.  Avoid this potential null pointer
>> dereference by moving the call to mark_buffer_dirty inside the null checked
>> block.
>>
>> Fixes: e8b4274735e4 ("udf: finalize integrity descriptor before writeback")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Thanks for the patch! In fact it is the 'if (bh)' check that's
> unnecessarily defensive (we cannot have sbi->s_lvid_dirty and
> !sbi->s_lvid_bh). So I'll just drop that check (attached patch).
>
> 								Honza
>
>> ---
>>   fs/udf/super.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/udf/super.c b/fs/udf/super.c
>> index a6940d90bedd..b7e9a83d39db 100644
>> --- a/fs/udf/super.c
>> +++ b/fs/udf/super.c
>> @@ -2336,13 +2336,13 @@ static int udf_sync_fs(struct super_block *sb, int wait)
>>   
>>   			lvid = (struct logicalVolIntegrityDesc *)bh->b_data;
>>   			udf_finalize_lvid(lvid);
>> -		}
>>   
>> -		/*
>> -		 * Blockdevice will be synced later so we don't have to submit
>> -		 * the buffer for IO
>> -		 */
>> -		mark_buffer_dirty(bh);
>> +			/*
>> +			 * Blockdevice will be synced later so we don't have
>> +			 * to submit the buffer for IO
>> +			 */
>> +			mark_buffer_dirty(bh);
>> +		}
>>   		sbi->s_lvid_dirty = 0;
>>   	}
>>   	mutex_unlock(&sbi->s_alloc_mutex);
>> -- 
>> 2.20.1
>>
Reviewed-by: Steven J. Magnani <steve@digidescorp.com>

Doh! Thanks for the catch Colin.

------------------------------------------------------------------------
  Steven J. Magnani               "I claim this network for MARS!
  www.digidescorp.com              Earthling, return my space modulator!"

  #include <standard.disclaimer>

