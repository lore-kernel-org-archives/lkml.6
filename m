Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4101065-1525227654-2-7402534948379939938
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525227653; b=fiUcx2F8nJtppcAfQc7D6h2i5OY5XBVIkzqI7CLMW0ceMpzj5y
    LFA2GZh2WENCfqVRbvEPSvhWyNB1zP2nkNEdJ05MSsY82OtUgzwaIXstsuKm+q6Q
    MSIwwBQ8zXlMzhtKyN9GGOLCI9QcuGUAqjIM9l/P8n0sSaOPA3gYtV2ZGyJbT0e7
    fs5SdeZidPJE1s/GKHppnXEirugOO4XRpXtOpkMNOK7wv6s3JIarzcyvEZJabc8I
    MTCjHbc+ScOu2HzJw43/X0fA8RzfG4nbds4XW43WHgsNgQB3f842hCf8wwNPyIbZ
    32HpQ054vrjbKOMtc/c/HnTFcahCjZns4psA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525227653; bh=Yu45mQ3V8+IKRQsPov+O9cWL9SPnklwVhOYUoS20l6
    o=; b=KqE+iB8tPYYhFnP7lZkHy8RtKGUGx4/AYhAELSJvvVP40HCxTzB2WAHYqo
    t8HpP+Rexyb+ln51YNdHjMtTvwb6LsmRmbMZzKkmQj8iEXJ3E80QlHdiLEfIb2QM
    /KiJ/o6Ojftg3Tfq3Z/BuHMm9mb6rUGoKxdzQ7l7+lxe/MZDglZAnV1T7obCmld2
    XBpOPQItmwuXtQ3yzoOZm1g6gX/JlKtk8ENj/tIS/eYsM4WA8H+M0dOi0XGsAlkG
    +58rZCAsOb/La2/jgIPs5jw5h6b2gdyAKTBvXtdPqaPMD3zSE+uBlMsn9rki4VUZ
    1H19UUx5fLlD+Eu5MRmbBKmMYt+g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=chromium.org header.i=@chromium.org header.b=DF2DIJGb
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=CwreXqv0 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=eJfHSy3G;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=chromium.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=chromium.org header.i=@chromium.org header.b=DF2DIJGb
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=CwreXqv0 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=eJfHSy3G;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=chromium.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOwNtjd6mrT5gTNVs6FIL6Y1oT1lcYXEhjymz30vBqVWX65zkIhBO3kIMbI1OFCP/y63Bklk9Ycj93FZhk9FxguIDlkjiTPz0sjyH/mkw3qYInVtHchJ
    4iw0C3YWJ36YAvv8WIhS4bQRgyN0fv+LlJ8rhuYgllzWAW2iEpslXMp/kNNYrQFEnXU3xs5sVaNRaN15gzagrKmk+sjceRwdwaIVdlbAnU5/PWRGCBwBayR2
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8 a=u8X-_MVfL5-CnWtI_rcA:9
    a=6n3tkgy90iZQw_m3:21 a=FZbIMMrfNYDRBlOn:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750999AbeEBCUv (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 22:20:51 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:44208 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeEBCUu (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 May 2018 22:20:50 -0400
X-Google-Smtp-Source: AB8JxZrKFwe5Kk9BEs7Z5sARTaHoHofTvCg+uriU1dvTid2ENMbc846jAMHLBBF1xHPSC9mdCDHbMSTeW/zxaPZRATc=
MIME-Version: 1.0
In-Reply-To: <20180418071436.21392-1-tmricht@linux.ibm.com>
References: <20180418071436.21392-1-tmricht@linux.ibm.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 1 May 2018 19:20:48 -0700
X-Google-Sender-Auth: 8p3jXzqf796h4b78XW5HVQqz-lI
Message-ID: <CAGXu5j+wnRsecDVZjOFVmLLdptfqSJ2QCLAY-x+EaiUAd0yfjA@mail.gmail.com>
Subject: Re: [PATCH v3] module: Fix display of wrong module .text address
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: Jessica Yu <jeyu@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        brueckner@linux.vnet.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Tobin C. Harding" <me@tobin.cc>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 12:14 AM, Thomas Richter <tmricht@linux.ibm.com> wrote:
> Reading file /proc/modules shows the correct address:
> [root@s35lp76 ~]# cat /proc/modules | egrep '^qeth_l2'
> qeth_l2 94208 1 - Live 0x000003ff80401000
>
> and reading file /sys/module/qeth_l2/sections/.text
> [root@s35lp76 ~]# cat /sys/module/qeth_l2/sections/.text
> 0x0000000018ea8363
> displays a random address.
>
> This breaks the perf tool which uses this address on s390
> to calculate start of .text section in memory.
>
> Fix this by printing the correct (unhashed) address.
>
> Thanks to Jessica Yu for helping on this.
>
> Fixes: ef0010a30935 ("vsprintf: don't use 'restricted_pointer()' when not restricting")
> Cc: <stable@vger.kernel.org> # v4.15+
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> ---
>  kernel/module.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/module.c b/kernel/module.c
> index a6e43a5806a1..40b42000bd80 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -1472,7 +1472,8 @@ static ssize_t module_sect_show(struct module_attribute *mattr,
>  {
>         struct module_sect_attr *sattr =
>                 container_of(mattr, struct module_sect_attr, mattr);
> -       return sprintf(buf, "0x%pK\n", (void *)sattr->address);
> +       return sprintf(buf, "0x%px\n", kptr_restrict < 2 ?
> +                      (void *)sattr->address : NULL);

Errr... this looks reversed to me.

I would expect: "kptr_restrict < 2 ? NULL : (void *)sattr->address"

-Kees

-- 
Kees Cook
Pixel Security
