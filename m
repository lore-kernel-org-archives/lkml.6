Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B57DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85C72098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85C72098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbeIXX45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:56:57 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:42373 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbeIXX44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:56:56 -0400
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w8OHrCSC021129;
        Tue, 25 Sep 2018 02:53:12 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp);
 Tue, 25 Sep 2018 02:53:12 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w8OHrC8t021126
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 25 Sep 2018 02:53:12 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v4 00/19] LSM: Module stacking for SARA and Landlock
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        LKLM <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
References: <e9bfb2d5-d987-55ce-4011-9b32ff745d36@schaufler-ca.com>
 <CAGXu5jK=+FuL+JiSxcHy0i9Ppha=BQYdJW5zvbm1Redbo12wmw@mail.gmail.com>
 <680e6e16-0890-8304-0e8e-6c58966813b5@schaufler-ca.com>
 <CAGXu5j+7FpFDNuOowdHzJ5RXgfETQMv=Fe-EU1gWo+nWK+goZA@mail.gmail.com>
 <39457e79-3816-824b-6b4d-89d21b03f9ce@i-love.sakura.ne.jp>
 <b209d4b8-81a5-30aa-f4d1-9372bbb1b842@schaufler-ca.com>
 <da179a76-691e-32f5-9391-c432a72fe37e@i-love.sakura.ne.jp>
 <3350edec-c233-9428-73b0-58d582d1e3b9@schaufler-ca.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <eb1525f6-a3f8-4386-778f-8758c42326e5@i-love.sakura.ne.jp>
Date:   Tue, 25 Sep 2018 02:53:12 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3350edec-c233-9428-73b0-58d582d1e3b9@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/09/25 2:16, Casey Schaufler wrote:
>> Not all of LKM-based LSMs use security blobs. And some of LKM-based LSMs
>> might use security blobs for only a few objects. For example, AKARI uses
>> inode security blob for remembering whether source address/port of an
>> accept()ed socket was already checked, only during accept() operation and
>> first socket operation on the accept()ed socket. Thus, there is no need
>> to waste memory by assigning blobs for all inode objects.
> 
> The first question is why use an inode blob? Shouldn't you
> be using a socket blob for this socket based information?

Indeed. AKARI can as well use security_sk_free() using address of
"struct sock" as a key.

> 
> If you only want information part of the time you can declare
> a pointer sized blob and manage what hangs off that as you will.
> I personally think that the added complexity of conditional
> blob management is more pain than it's worth, but if you want
> a really big blob, but only on occasion, I could see doing it.

LKM based LSMs are too late for updating blob_sizes.* fields.
Even if they could, they after all have to somehow check whether
corresponding init hook was called. That's checking for NULL.

>>
>>>> @@ -1202,11 +1183,11 @@ void security_file_free(struct file *file)
>>>>  {
>>>>  	void *blob;
>>>>  
>>>> +	call_void_hook(file_free_security, file);
>>>> +
>>>>  	if (!lsm_file_cache)
>>>>  		return;
>>>>  
>>>> -	call_void_hook(file_free_security, file);
>>>> -
>>> Why does this make sense? If the lsm_file_cache isn't
>>> initialized you can't have allocated any file blobs,
>>> no module can have initialized a file blob, hence there
>>> can be nothing for the module to do.
>>>
>> For modules (not limited to LKM-based LSMs) which want to use
>> file blobs for only a few objects and avoid wasting memory by
>> allocating file blobs to all file objects.
>>
>> Infrastructure based blob management fits well for LSM modules
>> which want to assign blobs to all objects (like SELinux). But
>> forcing infrastructure based blob management can become a huge
>> waste of memory for LSM modules which want to assign blobs to
>> only a few objects. Unconditionally calling file_free_security
>> hook (as with other hooks) preserves a room for allowing the
>> latter type of LSM modules without using infrastructure based
>> blob management.
> 
> There is a hypothetical issue here, but that would require abuse
> of the infrastructure. Having a file_free_security hook that doesn't
> free a security blob allocated by file_alloc_security may coincidentaly
> be useful, but that's not the intent of the hook.
> 

The free hook might be used for freeing resources which were not allocated
by alloc hook. Yama is using task_free hook without task_alloc hook.
Someone might want to use file_free hook without file_alloc hook.

