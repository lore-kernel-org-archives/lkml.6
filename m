Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B925C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F012083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPiKrrHG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F012083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756001AbeFSFHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:07:08 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34474 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755432AbeFSFHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:07:06 -0400
Received: by mail-lf0-f68.google.com with SMTP id v84-v6so4906799lfa.1;
        Mon, 18 Jun 2018 22:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yeih5T4FrU2eYoSk9f51gOJMqhzQz4LhB9/PJc34qZk=;
        b=iPiKrrHG5enXGJkjIi8EqV2pdmpsJHrfJ8zvSJirmJQV7CYsYqiITHo9k0CaksUL6/
         /cqx4Xqdfe4Dh/qYZifZsYDFTP2ykcrQFh5l+zqv8WkgM4hafdR/z/Q76VdibYj+2p38
         g0t74M2Fnxjzp4jBoIZoqSVTXWtO0Jhrx5EeVqto018yTVByy4UZplKASpTRdx5E9chN
         UYJWXAqDJfOJLw9wRZ6JmDC4J/s+gfkLQxc6aQycossBR5yabnrFkgX2wOBfeQPX0KiD
         h9nGBFaCxmg4LWZZxthuvCKAnxw2O5r3/QFfEfbqONaHwGXVXbsw37po+xOIqRI7/bEG
         5kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yeih5T4FrU2eYoSk9f51gOJMqhzQz4LhB9/PJc34qZk=;
        b=HAxWrvWlcKv5RR289f+7uXmLYJMhOsMcZf75vBxKl3kW6EEn+IwuYNBIJuEXSwC7Td
         gELBSNGGL7B0rkt+XMm3xqCQQ2U34Ko86n9PuwoJExQM4pmGjrMOw0oNoHOoXVsqJ6ro
         xaid1UAvvZK5h6i/W4JfgfClrMVkb+UnEahIwqbRYbjJ7aMjj1cyYteEFNrS7uPhl4d0
         lpNypKBBgKJmgEoJ6FfrPUYtU1W8R5Y80IFUPlmN6gQil8dF7AInY3qa1MsaQuO6JWkP
         dert8lThQ22FTvkrbysB94agPQG05aAkkT98mWNXL3aqvXBD5qR1+KFcwvbGpHU4LvhV
         rIiA==
X-Gm-Message-State: APt69E0xcrjU+u79pBfVXsQq4jKgtsnb19ePIn2QrwzYH3lX9Qygi7/2
        CZVCstV5Zcs5N0sw3JJjgr+3Tv/BPV8o/2ROFuE=
X-Google-Smtp-Source: ADUXVKJ+0Jaw55MxbxQyxpi4k9kmRN4w6uIDPMwcxhltKofnPdynvSvN+rATAIz0u5+3Nk4Wz0oAF+bg78S2ySSkv64=
X-Received: by 2002:a19:2544:: with SMTP id l65-v6mr276433lfl.84.1529384824930;
 Mon, 18 Jun 2018 22:07:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b43:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 22:07:04
 -0700 (PDT)
In-Reply-To: <CAFqt6zaDdhG9=ak1ufeY2x8sr+nin8e+cgMQoi=-2o41uS5jxA@mail.gmail.com>
References: <20180610095640.GA4061@jordon-HP-15-Notebook-PC> <CAFqt6zaDdhG9=ak1ufeY2x8sr+nin8e+cgMQoi=-2o41uS5jxA@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 19 Jun 2018 10:37:04 +0530
Message-ID: <CAFqt6zaueQ6FW-NTgOUboPjpMReHBiGOAFG2dadOKnZYz_QB7Q@mail.gmail.com>
Subject: Re: [PATCH] fs: 9p: Adding new return type vm_fault_t
To:     Eric Van Hensbergen <ericvh@gmail.com>, rminnich@sandia.gov,
        Latchesar Ionkov <lucho@ionkov.net>
Cc:     v9fs-developer@lists.sourceforge.net,
        Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 3:26 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> On Sun, Jun 10, 2018 at 3:26 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> Use new return type vm_fault_t for page_mkwrite
>> handler.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
>> ---
>>  fs/9p/vfs_file.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
>> index 03c9e32..5f2e48d 100644
>> --- a/fs/9p/vfs_file.c
>> +++ b/fs/9p/vfs_file.c
>> @@ -533,7 +533,7 @@ int v9fs_file_fsync_dotl(struct file *filp, loff_t start, loff_t end,
>>         return retval;
>>  }
>>
>> -static int
>> +static vm_fault_t
>>  v9fs_vm_page_mkwrite(struct vm_fault *vmf)
>>  {
>>         struct v9fs_inode *v9inode;
>> --
>> 1.9.1
>>
>
> Eric, as requested, posted it in net-dev and lkml mailing list.

Eric, any comment on this patch ?
