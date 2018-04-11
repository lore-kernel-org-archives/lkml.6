Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2932816-1523467387-2-15229640357588975438
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523467386; b=XEBmDVowjOk/EYlSEBGFjWJ4ALYy4YgjVEix25m3lii72N2IBU
    nuzjI988iXiAeR5Gy14hxlp6/PM7diqKGpfL+rb1dSBRUYgRM22qVsMcli4CFa7Y
    XWwV0kK7+ojPy0aZaz0t2vEYrtzmhyXn4YneqcthFVkWJb3iUQ2jEf6zGmTIPWYu
    U41ERQkWhjYN7B5rbMW7ZQiHoUAmsJXTTXNUnb5B0Pr/XCKrjpy+e8f7ynkt2rl3
    gaQeAQsQKSzrtIyaQwFC8EN8lvNqJs4zQ8r1+qPsIKvYx8rYvX1Gci1+7O5Aak7Y
    BIDyR3ihIqkVdIdKagIjTQks2Mxlclu7bRoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523467386;
    bh=ujnDUD7Fi1DU7iIKH5Ry9xQPDBmVt7PoJGwiPhjkrW8=; b=EgdqNudpM1p6
    /Dlj3E0rRjtSgZMjEfAdVzDcoHMca344VJxkmktudistJUtFH+E0++Ia3DrZ8DCg
    VBpfcCPRUJb6QSiJPgDdlf4Ku/L/rwZKXnZ3O3esOmwPuaIlk3AeLwz1EHP9pkiR
    i0az1YlHEVHUl/+y6lXvac+tHsa9DKdAJeS2DN01RQiGZYBl9W8+m1g2lNXJJF06
    0zr78aEgeSSz8V2CKznaxmccV7VlBOyEhyGDJSSKZlpl76urUFwB9QR5GqHskrv6
    l3+t8Kb9DyC69a/Ga8ljGmJ06YS14YBOtZyGsd7TMrq5fJO76lnuewQdKJQLIZeW
    W6CMlRAQ9Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=e4M4+Z3m x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=e4M4+Z3m x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC9GXnHxNzUwpGufwfojrpwG9V8Ie8LSdbX4Dz3xVR8oykaN4SZVuzqTaSLsTTzhUA1BneYmU0LJeRLcjRbnGDWYePVVqxnRMe9lOTsDleN3UiXkY/5K
    R4yjZVs79WVWXl+3SP3juVUxL7Mo4cVi1lrwGogo8eCXHsWhqqcrs8oBgkXG+Ezsf//5lgolfljO40mTKGPEq7/9MJYzeJZnOeenzBNv9MyNKw5oUyspNpnz
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=z1H5ADGQAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=XWzBy8cq5xu9FNUHXQYA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=cNhwqobjEIRUxE0uuXBi:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753536AbeDKRWu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 13:22:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35112 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753227AbeDKRWs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Apr 2018 13:22:48 -0400
Subject: Re: [PATCH 18/24] Lock down module params that specify hardware
 parameters (eg. ioport)
To: David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
 <152346399627.4030.8043878470312297727.stgit@warthog.procyon.org.uk>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <17b6d3ad-367c-be6f-40d8-a9f60c7edae3@infradead.org>
Date: Wed, 11 Apr 2018 10:22:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152346399627.4030.8043878470312297727.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/11/2018 09:26 AM, David Howells wrote:
> Provided an annotation for module parameters that specify hardware
> parameters (such as io ports, iomem addresses, irqs, dma channels, fixed
> dma buffers and other types).
> 
> Suggested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  kernel/params.c |   26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/params.c b/kernel/params.c
> index cc9108c2a1fd..2c08c4aa376b 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -108,13 +108,19 @@ bool parameq(const char *a, const char *b)
>  	return parameqn(a, b, strlen(a)+1);
>  }
>  
> -static void param_check_unsafe(const struct kernel_param *kp)
> +static bool param_check_unsafe(const struct kernel_param *kp,
> +			       const char *doing)
>  {
>  	if (kp->flags & KERNEL_PARAM_FL_UNSAFE) {
>  		pr_warn("Setting dangerous option %s - tainting kernel\n",
>  			kp->name);
>  		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
>  	}
> +
> +	if (kp->flags & KERNEL_PARAM_FL_HWPARAM &&
> +	    kernel_is_locked_down("Command line-specified device addresses, irqs and dma channels"))

s/dma/DMA/

Other patches use PCI instead of pci, CIS instead of cis, MMIO instead of mmio,
BPF instead of bpf, MSR instead of msr, etc...


> +		return false;
> +	return true;
>  }
>  
>  static int parse_one(char *param,


-- 
~Randy
