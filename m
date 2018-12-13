Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8BBC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F42120870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2w+cF7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F42120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbeLMPO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 10:14:58 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36373 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbeLMPO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 10:14:57 -0500
Received: by mail-oi1-f195.google.com with SMTP id x23so1899952oix.3;
        Thu, 13 Dec 2018 07:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0K7Vgu45Q5zb1gXqW3WpfRR2bbAKtlzOKOIgHepxPOs=;
        b=V2w+cF7tje+Pspt2bmBWa5Al0WAdwOM92AXRk1kO3KqIAM936K7DlqvOQhhu90+v0c
         a5n2Skefa7/MJ7AjCT/7qgtk/Bu7Hr9KIH+KeCoNuPgKKbfgPat+44ZHcmBDoEhxtQEZ
         fltyUzi5hELhwEIl9ZbVMVLkOOSq2Lkz+m1tyICzo2mOyvnVyRTBJZ12wnKQATkIsJDA
         PdC0/XZqGrhQU9sJxG/FZvoYSLg4JtU2EPYqBnFS2ihKBwwP4ttIL9iJOg8AYGZWcd/u
         ma83CSWNeujAQVZjuJOiawYu939tE6djag+LBWnV7s15e2+dpeoqVLXKxF/R6qNVnJWU
         FQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0K7Vgu45Q5zb1gXqW3WpfRR2bbAKtlzOKOIgHepxPOs=;
        b=dXhiZazmii6Ue0yd6ArDmSgKnQE+xZac+HkL/JRK7bzUX9qtsXLm4ek5grfAFOhk+u
         4/e9TapNiz8eSED6FzS1URn2/vrd9TGKabqhVeg8VQAMiyEHBH4brcp5iXhaWAck2+63
         Sf/q4P+Q+p3lbMjuNlaSVMU1SjsNNAopXZRhH9skTqe08WkK8C5DBbvaQN0l9mUxIn/G
         PTVGEUxpXZA3uQ1guDTucLm5IRkdTkJ8yO2AjPP7M8T7JBRp+dkSgFakngOwmk0s6t9Q
         V4YUFXtLy0vOtUbx10xMXbOHRlANnzUZ+8lLxbPguzB9JBNX/RkaJdMYCHQpPTvjcZOu
         M4GA==
X-Gm-Message-State: AA+aEWb+yBAJjaQsrQNo7EhdNlyBNYf7TcE08UavASqUSmQeVm31LoBw
        iGLrB/7o44VmPEOnkf1NpnL+cI6nu2o=
X-Google-Smtp-Source: AFSGD/XfCV73JQ5yrvlryRQc1CqIcyHtmiTNl4kksVUGOGlRfqBb2gXYhRjoSR7/8wfi5JmcQMgKAA==
X-Received: by 2002:aca:dfc4:: with SMTP id w187mr3220000oig.35.1544714095841;
        Thu, 13 Dec 2018 07:14:55 -0800 (PST)
Received: from [0.0.0.0] (104.194.84.186.16clouds.com. [104.194.84.186])
        by smtp.gmail.com with ESMTPSA id p129sm936128oif.17.2018.12.13.07.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 07:14:54 -0800 (PST)
Subject: Re: ubifs: fix page_count in ->ubifs_migrate_page()
To:     Richard Weinberger <richard@nod.at>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, hch@lst.de,
        linux-fsdevel@vger.kernel.org
References: <1544624037-3436-1-git-send-email-openzhangj@gmail.com>
 <5829763.q4qAXljTxb@blindfold>
From:   zhangjun <openzhangj@gmail.com>
Message-ID: <16c76437-d331-ac37-9c08-148189f9d98f@gmail.com>
Date:   Thu, 13 Dec 2018 23:14:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5829763.q4qAXljTxb@blindfold>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/12/13 下午10:23, Richard Weinberger wrote:
> Hello zhangjun,
>
> thanks a lot for bringing this up!
>
> Am Mittwoch, 12. Dezember 2018, 15:13:57 CET schrieb zhangjun:
>> Because the PagePrivate() in UBIFS is different meanings,
>> alloc_cma() will fail when one dirty page cache located in
>> the type of MIGRATE_CMA
>>
>> If not adjust the 'extra_count' for dirty page,
>> ubifs_migrate_page() -> migrate_page_move_mapping() will
>> always return -EAGAIN for:
>> 	expected_count += page_has_private(page)
>> This causes the migration to fail until the page cache is cleaned
>>
>> In general, PagePrivate() indicates that buff_head is already bound
>> to this page, and at the same time page_count() will also increase.
>> But UBIFS set private flag when the cache is dirty, and page_count()
>> not increase.
>> Therefore, the expected_count of UBIFS is different from the general
>> case.
> As you noted, UBIFS uses PG_private a little different.
> It uses it as marker and when set, the page counter is not incremented,
> since no private data is attached.
> The migration code assumes that PG_private indicates a counter of +1.
> So, we have to pass a extra count of -1 to migrate_page_move_mapping() if
> the flag is set.
> Just like F2FS does. Not really nice but hey...
>
>> Signed-off-by: zhangjun <openzhangj@gmail.com>
> Fixes: 4ac1c17b2044 ("UBIFS: Implement ->migratepage()")
>
>> ---
>>   fs/ubifs/file.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
>> index 1b78f2e..2136a5c 100644
>> --- a/fs/ubifs/file.c
>> +++ b/fs/ubifs/file.c
>> @@ -1480,8 +1480,15 @@ static int ubifs_migrate_page(struct address_space *mapping,
>>   		struct page *newpage, struct page *page, enum migrate_mode mode)
>>   {
>>   	int rc;
>> +	int extra_count;
>>   
>> -	rc = migrate_page_move_mapping(mapping, newpage, page, NULL, mode, 0);
>> +	/*
>> +	 * UBIFS is using PagePrivate() which can have different meanings across
>> +	 * filesystems. So here adjusting the 'extra_count' make it work.
>> +	 */
> Please rewrite that comment.
> /*
>   * UBIFS uses PG_private as marker and does not raise the page counter.
>   * migrate_page_move_mapping() expects a incremented counter if PG_private
>   * is set. Therefore pass -1 as extra_count for this case.
>   */
>
>> +	extra_count = 0 - page_has_private(page);
> if (page_has_private(page))
> 	extra_count = -1;
>
> That way this corner is much more obvious.
>
> Thanks,
> //richard
>
>
Hello Richard.

Thank you very much for your help.

1. Can i use your description for comment? like this:

/*
  * UBIFS uses PG_private a little different.
  * It uses it as marker and when set, the page counter is not incremented,
  * since no private data is attached.
  * The migration code assumes that PG_private indicates a counter of +1.
  * So, we have to pass a extra count of -1 to migrate_page_move_mapping() if
  * the flag is set.
  */

2. It's more obvious, but the branch may break the cpu pipeline?

