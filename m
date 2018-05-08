Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2846941-1525786746-2-13162845537822225242
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525786745; b=KWHmr2TxnC4uQungZkBRdx3E/IFzkTJs0gI6gigKHz3vo6Szn8
    112vfNaCccX6PXjim/02y4ncea5ubKwo+2wdXQmWqB5Ksiw1LQJ4FltXAoWSITjO
    zXuYKxWV/El5I1XJbZ0Phz5acto19XTXlSOiNx4aDOrN+E6ZaOUi0F6GfiUfdkdV
    fgF61/xLVijhldJBV2tq1dJozMAPrq5O8pmxSJB+n1Dt886zrDuMP/3qPsBvjdPc
    hfRbDFtRv1H/QQDjFHs62/Mk9Xfs3brNDqjtT8+S79vo87KBMAYCjcSi7JqyqrYn
    DhbEoguggXAA3nWIAPImqlED2vNX6HNRTHLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525786745; bh=L8Tyw
    YBEvlgMWxXy0fF671BZBZnIxvwQxefbrWEelxY=; b=DQ4Ya+Yc17CN2pEPC1vlv
    Rc4/y2buhDwqAz7r+F5l3RpXAaKM+C5iofbKJv3f4vMeICMtLkbOeOeeZ/Q9Ummb
    IvufNIJnrs2+U2cGTn7E3WjgHA2pQFRkqZrMbirEZoEDd3KqnwkobOsaPwJ+/iEh
    e7bTft6ev6Onp/W4cXUN0E7rLd1kbNJR+eDwCTkzi8gxsn2+L3wi9WdT/Q3xmdYs
    SKfaRVAUtVOjdyaSD0wo68UhgcY9VltzxmQzKDvn1CjPjrwnXZ+8GNxOmYRY5/6c
    xkJ+7bESSWtlWSDe1ysZ5ghR6BjChnM8evz4nH4kW2sb6ku4RqTkaTcco32RO27N
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=android.com header.i=@android.com header.b=VulWaoUM
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=M99lCCaz;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=android.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=android.com header.i=@android.com header.b=VulWaoUM
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=M99lCCaz;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=android.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP2TtRoR7/4aUOFH43XvjHYLAEBhCYjGe/872bFmLyx2hEVyZftfkH1K7jwerukJT0YymvzO227f+l6/yoLHvT3TxvepYGUj6hRBw1X+8HgytfDhwYn1
    ihn/FWcChZT8SVPmy4q5J4p+XNlGrokkQhLet0m1g7qeAKh2YSWz51ks90FF8VmHrTmnnPzWudkiS6vc0DQCAwC8WnPeH0YeoT98Y/qujhnDqGWHmzgbZOUz
    s5js9cwRDCMG1BREW1GS0g==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=WztzqDAP0gftaO-_khcA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZq/lRl810srCk3FtzzynZNIIB4Cj9qElac71CKHhtJePZc9s0/w9yD4BNhbgT3MWdIitQQB63wtSfDcuEv1Mfo=
MIME-Version: 1.0
In-Reply-To: <20180508090639.14275-1-baijiaju1990@gmail.com>
References: <20180508090639.14275-1-baijiaju1990@gmail.com>
From: Martijn Coenen <maco@android.com>
Date: Tue, 8 May 2018 06:38:58 -0700
Message-ID: <CAB0TPYHVNhNoHTSuDR2Ew8iOeMo9SaKfoY2bF6WF7C5ADCyU+Q@mail.gmail.com>
Subject: Re: [PATCH] android: binder: Fix a possible data race in
 binder_alloc_mmap_handler
To: Jia-Ju Bai <baijiaju1990@gmail.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 8, 2018 at 2:06 AM, Jia-Ju Bai <baijiaju1990@gmail.com> wrote:
> The write operations to "alloc->buffer" are protected by
> the lock on line 679 and 730, but the read operation to
> this data on line 712 is not protected by the lock.
> Thus, there may exist a data race for "alloc->buffer".

It's read by the same thread that just wrote it, there is no data race.

The locks at line 679 and 730 protect against multiple threads calling
mmap() at the same time.

>
> To fix this data race, the read operation to "alloc->buffer"
> should be also protected by the lock.
>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/android/binder_alloc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 5a426c877dfb..596acc3a84e4 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -709,7 +709,9 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
>                 goto err_alloc_buf_struct_failed;
>         }
>
> +       mutex_lock(&binder_alloc_mmap_lock);
>         buffer->data = alloc->buffer;
> +       mutex_unlock(&binder_alloc_mmap_lock);
>         list_add(&buffer->entry, &alloc->buffers);
>         buffer->free = 1;
>         binder_insert_free_buffer(alloc, buffer);
> --
> 2.17.0
>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
