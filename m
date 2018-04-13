Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx48aQ3dR3K+AgIBM+FMf8Sqnyc2xAvMf+zd6IsQpZQEnOrAlUBKb/roO7oTMS38YoSvzsHP5
ARC-Seal: i=1; a=rsa-sha256; t=1523652749; cv=none;
        d=google.com; s=arc-20160816;
        b=TM9vEiWRF3pGZjQMuO54r9GpqPWgO6hHylV4at/T8BHoerTsP1TgcAPV5f15BdW3Y5
         wik0QgTgE4VoBHy7O5fXKCtg1PwzWrdAHfQO1Z4U7YTemcRPtgxKXlqDORsA6vTNHZDS
         9i38HBCKNp3frrJJetV5S5hzenVHkv6a0EhZhOa6bWhXvZYKbT+aUIRhOl/3mTXrhr/9
         f7iKrw6loMYa7BIOIg3H7EaJR3EzGZKX9ruJU4yinhkpruLP8YAlAUAo7HxBVW8kLF3Z
         NZtbAB5WzMuYnEQL+8GpMJe/jAREj2c6wgdOlSWzg/nrAel2SZGIiLto8M4Gmp8Mwqn8
         8nPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:organization:from:references:cc:to:subject
         :arc-authentication-results;
        bh=Wc1YncMeJ5mLqNv53MkdrAqOpX1EPfKMnPHtzSnvR3I=;
        b=zsZ/ckq1Yp/4NAWjnfRrLMfizux7a2ZxnKxgOFbSEGDtuaoCH1IJo+lDRZlNllMJ3t
         t8zetvk80MHQyYWRn8Dc6pMu+DvOD87z1ZzIoLClXyEawmoaKT3wUiUPxPD7GSukke7x
         PwJN6g0pIUVmacX2URquBE0o/w+hB9aVrgFHsBU//FFrDS7haEEY8vzTfW06GaZTZoHT
         c5FL5PXWxbvlxaEsHjHnL/O2vd6A9xMxdl4cCQ1kQD+E39AWNO2ONd9EPZzYBrou+O0a
         hPqBtbN8ao6updLM+AfycEjVkvXuDh3ILrNoIBldBNHnlcfKFTsOZJFKnsPPblUd/anH
         vriw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751002AbeDMUw3 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 13 Apr 2018 16:52:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750980AbeDMUw2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Apr 2018 16:52:28 -0400
Subject: Re: [PATCH v3] selftests/livepatch: introduce tests
To: Miroslav Benes <mbenes@suse.cz>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        =?UTF-8?Q?Libor_Pech=c3=a1=c4=8dek?= <lpechacek@suse.com>,
        Nicolai Stange <nstange@suse.de>,
        Artem Savkov <asavkov@redhat.com>
References: <1523544871-29444-1-git-send-email-joe.lawrence@redhat.com>
 <1523544871-29444-2-git-send-email-joe.lawrence@redhat.com>
 <alpine.LSU.2.21.1804131118080.17969@pobox.suse.cz>
From: Joe Lawrence <joe.lawrence@redhat.com>
Organization: Red Hat
Message-ID: <c9f4b440-c672-e45f-ddcc-63548b0411e2@redhat.com>
Date: Fri, 13 Apr 2018 16:52:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.1804131118080.17969@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597552611970926096?=
X-GMAIL-MSGID: =?utf-8?q?1597665706213095393?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/13/2018 07:20 AM, Miroslav Benes wrote:
> Hi,
> 
> On Thu, 12 Apr 2018, Joe Lawrence wrote:
> 
>> Add a few livepatch modules and simple target modules that the included
>> regression suite can run tests against.
> 
> Could you include a brief description which features are tested?

I can add this to the commit msg:

      - basic livepatching (multiple patches, atomic replace)
      - pre/post (un)patch callbacks
      - shadow variable API

Or do you prefer a little more detail?

>  
>> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
>> ---
> 
>> diff --git a/lib/livepatch/test_klp_shadow_vars.c b/lib/livepatch/test_klp_shadow_vars.c
>> new file mode 100644
>> index 000000000000..18c75b21cb9e
>> --- /dev/null
>> +++ b/lib/livepatch/test_klp_shadow_vars.c
>>
>> +/*
>> + * Shadow variable wrapper functions that echo the function and arguments
>> + * to the kernel log for testing verification.  Don't display raw pointers,
>> + * but use the ptr_id() value instead.
>> + */
>> +void *shadow_get(void *obj, unsigned long id)
>> +{
>> +	void *ret = klp_shadow_get(obj, id);
>> +
>> +	pr_info("klp_%s(obj=PTR%d, id=0x%lx) = PTR%d\n",
>> +		__func__, ptr_id(obj), id, ptr_id(ret));
>> +
>> +	return ret;
>> +}
> 
>> +void shadow_free(void *obj, unsigned long id, klp_shadow_dtor_t dtor)
>> +{
>> +	klp_shadow_free(obj, id, dtor);
>> +	pr_info("klp_%s(obj=PTR%d, id=0x%lx, dtor=PTR%d)\n",
>> +		__func__, ptr_id(obj), id, ptr_id(dtor));
>> +}
> 
> Sparse (make C=1) would be happier with those two being static.

Ah right. I wonder why the kbuild test robot didn't complain about
those, too.  Easy enough to fix up, thanks.

> Otherwise it works as expected. Good job!

Thanks for reviewing.  I'll hold off on posting v4 until Petr (and
others) get a chance to comment.  Perhaps there are other tests that
would be helpful?

-- Joe
