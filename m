Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4063258-1526868526-2-10514804373784297939
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526868526; b=P3PnSNQTRP1dQFyvoGFrptRYybCsKVxuy9bRJKlb+75ENVtbhb
    HcZfGuIj/3Yc/i7SrFUnTieWs7sFLCRPdqIswA9KWTYxeyurUDZwv8UN2D5Qoq0c
    VSqT+iFQjlhdQ/3pB9A9QFZ79HrLU6yb939MWi9Z1Ixj6OMAacguKCrGNjr5GFqE
    1DJZKpxZ/1tHJ+8p2724csKm332UGqvyq624Nbs7S2v2usZHVRuY7+H3Zy4EWbxA
    s3btmfM00yYh3Lchmv6WFUGQay0en7hvJ1mXJcCgm8itscok7Ih1PYHaNzrhg7Gl
    nlBL/FGzIBWAP0cCD3zXBNISjUQ3dcMzWidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526868526;
    bh=6CF1cmzQaO5wjSV9g2Tl5ZJBx8TfwpMc3Au1wQRL6Jw=; b=fgOxlKBIeyvI
    PbVJKqdKjGTPsMfdvZ+ncBy5As07F542acl8uXyQzahw9ALmUOLyL+xEacGIFaFD
    yI5RoEfmiXo8airfTurrYoPXasUhxbV5DxqK0if7Tk0+RPnCNIO0UbWN4L7k9nvc
    iy5f+6E0QNRCurbKowP48sO1WR4BvH03oCcssvXJbSG6rUvK/3HzwAcRC0hfX14H
    sfo/aoadqXbv5aZfC0yOvgVJqvSJVmz9B2/YgHmUj6ZT/cjank4IOfUiTj7gjO4f
    ccnrrX5o8uFiMlN35IR6gXnIvygrcMBGAgE+7kUG9hqrMGAlowZBUZ30/nm2pbF/
    tx05ll9+eg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=KO103m+b
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=KO103m+b
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNjzCMZ5lA94RHxSz9fmC/RmpIw8IPUxXq8ctm7QXalAOyChg2BoVzfOi6ETzBMgczI/cgmJYWvNDtSzp6F1tf10G0lBx+zAcaqGtt+feC/9rFm8YbmY
    mHOTaPEhN8tAiPPD4abNSUix32KMI9t7mdR+Ia1J78Fc++Xy9dJCYL4ZF1msa7UdNGJGkDR8eohlw0v9y7nInhVl2o5wgu/hJJC1iAlIdmI7yCky49ahFfpc
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jUFqNg-nAAAA:8 a=JfrnYn6hAAAA:8 a=5v8iQKqjmhiA7JilWVoA:9 a=QEXdDO2ut3YA:10
    a=-tElvS_Zar9K8zhlwiSp:22 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751745AbeEUCIo (ORCPT <rfc822;linux@kroah.com>);
        Sun, 20 May 2018 22:08:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60812 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbeEUCIn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 May 2018 22:08:43 -0400
Subject: Re: [PATCH] autofs - make autofs4 Kconfig depend on AUTOFS_FS
To: Ian Kent <raven@themaw.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <152686465885.5980.4013776735694914550.stgit@pluto.themaw.net>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c0eb4d04-9d75-7fc2-0bce-f2caac9d2056@infradead.org>
Date: Sun, 20 May 2018 19:08:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152686465885.5980.4013776735694914550.stgit@pluto.themaw.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/20/2018 06:04 PM, Ian Kent wrote:
> Setting AUTOFS_FS and AUTOFS4_FS to y or m results in a compile
> failure.
> 
> It isn't possible to unset one if the other is set because it
> introduces a circular dependency.
> 
> But adding "depends on AUTOFS_FS = n && AUTOFS_FS != m" will make
> autofs4 appear under the autofs entry which should call attention
> to it. It also results in AUTOFS4_FS being removed from .config
> for any setting of AUTOFS_FS except n.
> 
> Adding a "NOTE" to the AUTOFS4_FS help text will hopefully raise
> awareness of the change to smooth the transition.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
> Cc: Randy Dunlap <rdunlap@infradead.org>

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  fs/autofs4/Kconfig |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/autofs4/Kconfig b/fs/autofs4/Kconfig
> index 53bc592a250d..2c2fdf989f90 100644
> --- a/fs/autofs4/Kconfig
> +++ b/fs/autofs4/Kconfig
> @@ -1,6 +1,7 @@
>  config AUTOFS4_FS
>  	tristate "Kernel automounter version 4 support (also supports v3 and v5)"
>  	default n
> +	depends on AUTOFS_FS = n
>  	help
>  	  The automounter is a tool to automatically mount remote file systems
>  	  on demand. This implementation is partially kernel-based to reduce
> @@ -30,3 +31,10 @@ config AUTOFS4_FS
>  	  - any "alias autofs autofs4" will need to be removed.
>  
>  	  Please configure AUTOFS_FS instead of AUTOFS4_FS from now on.
> +
> +	  NOTE: Since the modules autofs and autofs4 use the same file system
> +		type name of "autofs" only one can be built. The "depends"
> +		above will result in AUTOFS4_FS not appearing in .config for
> +		any setting of AUTOFS_FS other than n and AUTOFS4_FS will
> +		appear under the AUTOFS_FS entry otherwise which is intended
> +		to draw attention to the module rename change.
> 


-- 
~Randy
