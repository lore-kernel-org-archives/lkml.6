Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D20C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E9C208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2rP4GuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E9C208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389392AbeHAO4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:56:49 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33239 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389258AbeHAO4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:56:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id s12-v6so16824709ljj.0;
        Wed, 01 Aug 2018 06:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=vjc7HIePcjq+XhaewLnO4SeuYrWFG/YmmWFr77WsSu4=;
        b=k2rP4GuAqwVv95kzsCZkUPG1t/IRVspbVXGVhxWMnZVRsUQNLVmlsJwRdLJiEB4VCm
         CnZSdcUwNJ6ivs+nQDy/tpSc+55oda9iW/vUVjcYNmksDg/tVskc9VpexhiT9oV0XVjM
         QAvNwyYexOol1Su+LfJHuwdrg4ztR7DXd/OMmOWWD+mtXeOaTQC3FKxmBsllFlFLyFJL
         wnWHu2eSJFCNv9xBkwBGcB6xT+WyFYcTZt2jtJWtlp2re454ibHjSFCEAt3qLEuCtLOm
         JV7X9c7D8zd9H4ke6mNqULIBX+cA7Mobqiw4rdja6jdLl0DbXHWPO4TjvZQiNLm0ilX7
         GjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=vjc7HIePcjq+XhaewLnO4SeuYrWFG/YmmWFr77WsSu4=;
        b=LoS7VZLUBuAx435D4R2NU8ya1rBkx/+6uLJY6xEp5fTN0/Ggtb80zSOil4SnQ/WQAv
         JZZfBAAvr6FEO+WstzSu/lr0Pt6UyiIr+LUMy6ERR7xSbItM1KINI1Ta5ZQzjKX+UWYT
         W2zpAwaiUeXnzWXrbIoAqihCOx6HALZhECx6T+xZ9NI8d/Syib9AyMTFs/a/d0wMI2P/
         tekUhCqglPBfCl3cBHE39uYEhN2DlpHuI1vlopEqYf8lTFUSURMaxvAKdFkBY7V4nIUa
         tEbmSEvg51uDyAE41jL/v05vR26bHZNTMU6YA69A9VqYMDW74l5cmC88AR1WU4rwtNvo
         AldA==
X-Gm-Message-State: AOUpUlGfNwBoYltl1D6CBpONoVoOUHhK5fUJ5dWO3howFTWXUjU1Z7Va
        V/GxHluyYoSb2X4m69v88Qz/B0caDtcH8i9egwU=
X-Google-Smtp-Source: AAOMgpcSHip68P7HN/pARYI0RlI8gu8h3pqSMMm43wTZ6PuBArtJqIBwsm+37Y9mqujdnpLAOcGkVgzKhK1gBhi8IYA=
X-Received: by 2002:a2e:5617:: with SMTP id k23-v6mr18994715ljb.86.1533129063862;
 Wed, 01 Aug 2018 06:11:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 06:11:03 -0700 (PDT)
In-Reply-To: <CAFqt6zbxpj5DS=ONUGTJ9zaeH5k=qZpQYy-J+08tr9y0gOsCAg@mail.gmail.com>
References: <20180728085000.GA9136@jordon-HP-15-Notebook-PC>
 <20180801125512.GA10761@thunk.org> <CAFqt6zbxpj5DS=ONUGTJ9zaeH5k=qZpQYy-J+08tr9y0gOsCAg@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 1 Aug 2018 18:41:03 +0530
Message-ID: <CAFqt6zZw6YJXWKPFqfKSoSjQfLbfUzN=LRQDgjORH+9xQ5J9Eg@mail.gmail.com>
Subject: Re: [PATCH] ext4: Convert int to vm_fault_t type
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, adilger.kernel@dilger.ca,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Greg KH <gregkh@linuxfoundation.org>, kemi.wang@intel.com,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 6:34 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> On Wed, Aug 1, 2018 at 6:25 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>> On Sat, Jul 28, 2018 at 02:20:00PM +0530, Souptick Joarder wrote:
>>> Use new return type vm_fault_t for ext4_page_mkwrite
>>> handler and block_page_mkwrite_return.
>>>
>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>
>> FYI, this patch was very sloppy, and didn't do the right thing.  That's
>> because of how you messed with the changing how the return codes are
>> now handled.
>>
>>> --- a/fs/ext4/inode.c
>>> +++ b/fs/ext4/inode.c
>>> @@ -6108,27 +6108,27 @@ static int ext4_bh_unmapped(handle_t *handle, struct buffer_head *bh)
>>>       return !buffer_mapped(bh);
>>>  }
>>>
>>> -int ext4_page_mkwrite(struct vm_fault *vmf)
>>> +vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
>>>  {
>>>       struct vm_area_struct *vma = vmf->vma;
>>>       struct page *page = vmf->page;
>>>       loff_t size;
>>>       unsigned long len;
>>> -     int ret;
>>> +     vm_fault_t ret;
>>>       struct file *file = vma->vm_file;
>>>       struct inode *inode = file_inode(file);
>>>       struct address_space *mapping = inode->i_mapping;
>>>       handle_t *handle;
>>>       get_block_t *get_block;
>>> -     int retries = 0;
>>> +     int retries = 0, err;
>>
>> OK, ret now is a vm_fault_t, and err is an error return....
>>
>>> @@ -6138,9 +6138,9 @@ int ext4_page_mkwrite(struct vm_fault *vmf)
>>>               do {
>>>                       ret = block_page_mkwrite(vma, vmf,
>>>                                                  ext4_da_get_block_prep);
>>
>> But block_page_mkwrite() still returns an int, not a vm_fault_t....
>>
>>>  -            } while (ret == -ENOSPC &&
>>> +             } while (ret == VM_FAULT_SIGBUS &&
>>>                      ext4_should_retry_alloc(inode->i_sb, &retries));
>>
>> So this is Just wrong,  This needed to be:
>>
>>                 do {
>>                         err = block_page_mkwrite(vma, vmf,
>>                                                    ext4_da_get_block_prep);
>>                 } while (err == -ENOSPC &&
>>                          ext4_should_retry_alloc(inode->i_sb, &retries));
>>                 goto out_ret;
>>
>> That's because out_ret is what will translate the int error code to
>> the vm_fault_t via:
>>
>>         ret = block_page_mkwrite_return(err);
>>
>> The fact that ext4_page_mkwrite() returns a vm_fault_t, while
>> block_page_mkwrite() returns an int which then has to get translated
>> into a vm_fault_t via block_page_mkwrite_return() is I suspect going
>> to confuse an awful lot of callers.
>
> We have also changed block_page_mkwrite() to return vm_fault_t, but in
> a different patch. Hopefully that patch will be in linux-next tree soon.

Link to other patch where block_page_mkwrite() is changed to return
vm_fault_t type.

https://www.spinics.net/lists/linux-fsdevel/msg130670.html

>
>>
>> I'll fix up the patch, but I just wanted to call your attention to
>> this pitfall in the patch which confused even you as the patch author....
>>
>> (BTW, the buggy patch triggered a new failure, ext4/307, which is how
>> I noticed that the patch was all wrong.  If you had run any kind of
>> static code checker you would have noticed that block_page_mkwrite()
>> was returning an int and that was getting assigned into a variable of
>> type vm_fault_t.  The fact that you *didn't* notice makes me worry
>> that all of this code churn may, in the end, not actually help us as
>> much as we thought.  :-(
>>
>>                                               - Ted
