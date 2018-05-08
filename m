Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1824247-1525738819-2-3219286410350686931
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525738819; b=mVJO0qzduufGcJAYfW+Az/xMlqd/b9vuwKUznaonSkungE0Nak
    tzoTFuVVnEKDjS7tCKNa8ZZdUquuAKHPJ87RClJs+4tHq00glg24J33RzcjyJoHG
    hCniZeG0iuLu3CQ8j6g4ueFUf47ursgjLuQnMI7ZFjB4QtUURK51uS10rAVGylNP
    9OSitFLY6bT6uxTs99jnDBvNQKn+4VTCM3JvDHx8t2tHwD3FOOWfvNOo+SUNvFtz
    F3GgsrJVqxj448WIe60axzV4nmtkVGjVnW8qjG6BJ80C2visBKto4gUyrRs6r/eh
    E9UbWSj8Jl2cTRoXvrwN8Gm85lzcN7FAqVFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525738819;
    bh=EZ8FU7eOcfbLTiwz9UhK7+ZfzDepa5qD+Ry73oQTNKg=; b=m2cM76W9U4TX
    dtHjjkidrjuoI/nvcE+K3mJtjq1msgu4K646oGdi9sioXUwEUeGglkRQlUBayGLg
    1oy0qRdUOtEnKNqJy5KDqfqvcUnb37e3edW3h/e4JTuD3bEamvPZ/mCGojnk5CZd
    8BoIqiQH5xggEWf8UfdPaxOrs+qG9NwNbDjknoja5VAmI+vteLrT1XYtJza/L2IA
    YbFQtYrwyX+rqa6KmPy+qbWBw0k8YKlHiP0TEvIYYkvmxKYH/UpGgl953Ls47MBJ
    AvMoe6sgAmYwJKYtcs+d77BkSKs5J4O3ck3rImfzFBlRtPaOkj5uOjEXj+41WcAf
    vLGXbHpu+Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=JnAXwURf
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=JnAXwURf
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=merlin.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGHIxQ8m0FcQWV67+ZNRD6C7xUyKWkTGpCTaTvqE21lX3ezY1kXeemjJf+/tzk2LltGQPMBKxQaiGwwzQcXZq/p+A53jZ9qyym9A0J8Tr0h/qsNIvzBz
    nIZXTM6lxzfqiz1OHHrbI72dr+i/QUF5OgObSOPQN8V7y8fZzadVlb5ixtfRS4nLQbPQ5ppUyK2Gp1xxozVlHWKIfRTEDEqbZKIdwRz+uq7/3qTuHlohCTCz
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=PuvxfXWCAAAA:8 a=V3jxa7o0ir11VDymlMYA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=uAr15Ul7AJ1q7o2wzYQp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753398AbeEHAUR (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 20:20:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55620 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753387AbeEHAUR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 May 2018 20:20:17 -0400
Subject: Re: [PATCH] mm: expland documentation over __read_mostly
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, tglx@linutronix.de,
        arnd@arndb.de, cl@linux.com
Cc: keescook@chromium.org, luto@amacapital.net, longman@redhat.com,
        viro@zeniv.linux.org.uk, willy@infradead.org,
        ebiederm@xmission.com, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20180507231506.4891-1-mcgrof@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e2aa9491-c1e3-4ae1-1ab2-589a6642a24a@infradead.org>
Date: Mon, 7 May 2018 17:20:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507231506.4891-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/07/2018 04:15 PM, Luis R. Rodriguez wrote:
> __read_mostly can easily be misused by folks, its not meant for
> just read-only data. There are performance reasons for using it, but
> we also don't provide any guidance about its use. Provide a bit more
> guidance over it use.
> 
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
>  include/linux/cache.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> Every now and then we get a patch suggesting to use __read_mostly for
> something new or old but with no justifications. Add a bit more
> verbiage to help guide its users.
> 
> Is this sufficient documentation to at least ask for a reason in the commit
> log as to why its being used for new entries? Or should we be explicit and
> ask for such justifications in commit logs? Taken from prior discussions
> with Christoph Lameter [0] over its use.
> 
> [0] https://lkml.kernel.org/r/alpine.DEB.2.11.1504301343190.28879@gentwo.org
> 
> diff --git a/include/linux/cache.h b/include/linux/cache.h
> index 750621e41d1c..62bc5adc0ed5 100644
> --- a/include/linux/cache.h
> +++ b/include/linux/cache.h
> @@ -15,8 +15,14 @@
>  
>  /*
>   * __read_mostly is used to keep rarely changing variables out of frequently
> - * updated cachelines. If an architecture doesn't support it, ignore the
> - * hint.
> + * updated cachelines. Its use should be reserved for data that is used
> + * frequently in hot paths. Performance traces can help decide when to use
> + * this. You want __read_mostly data to be tightly packed, so that in the
> + * best case multiple frequently read variables for a hot path will be next
> + * to each other in order to reduce the number of cachelines needed to
> + * execute a critial path. We should be mindful and selective if its use.

                                                                 of its use.

> + *
> + * If an architecture doesn't support it, ignore the hint.
>   */
>  #ifndef __read_mostly
>  #define __read_mostly
> 

-- 
~Randy
