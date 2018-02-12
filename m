Return-Path: <kernel-hardening-return-11719-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227yBtcKhwovdRB8dMtL2GgpXisvDLqM+Y0/H05KYFYlQeZd2L8naiJUYIM49RBSOyArEkkc
ARC-Seal: i=1; a=rsa-sha256; t=1518442955; cv=none;
        d=google.com; s=arc-20160816;
        b=CMIroico4zkX2Xr1C+AtH7xNImv/QxOsU6ZPFv3ELT8OLmThk1GXibP4Nlz/1R4hKO
         7+z121Speb6InN3IhopePOm0TpS1X/6D7ZMuzJ3yMgLGhyepwYls3qjWSCzWqizCLnDj
         81hE+lM5RMJAF7bYN4EkgO2tqdbJIJUvxD4RSLO7cAxtsBwQXUjpRI3DpNkbwIkoUqhI
         eI5Pea9sZP43kjL1yiHpr95zE59ro5OzDGhXmkR9MzglTclZ/WZ13QTjztunsvupqjwe
         OlaTc6gfqL5R5xjxMr/BuLRvIva69HqhgbrNlKDOZ/wc31udzUzfjxbMxWtbebeHgbTv
         RSeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=DxepBoi64MKAwY0ub57ERjueVqS6CzCSwagnuvA8GpY=;
        b=rhBlqq42r/fhDLTbEyHu8xFAbg2UkoKjoKedq7YRVe5jMhyO+6baZsuB5aW4dUPa7Z
         S9V6CqxFJTXWW76bl3hAP5rjeKgFP+IcbdxTmVZgEwSompTvsXkllAx4Mgiw4PdcrQp9
         YfnydDHPdjubvvZ0CSnrOguTlWBJQEH4K2+3c83/WA0zvkDk2sl8tOmQSIODFGSHi4Te
         kJbRI+NYFfDvYZNzlWHIZLjB1UtmjQD7jmP/y7E67yJoZQH4wHiSl5rTkWaP4iulWwkq
         T4/iQ4r5JKVSAMoXRe4VvobSYuvVdzrVQCj9KjYIy7f6TAnoW7ffpf9zT/3v8A/VhUb5
         dZ9w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11719-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11719-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11719-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11719-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 4/6] Protectable Memory
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
CC: <willy@infradead.org>, <rdunlap@infradead.org>, <corbet@lwn.net>,
	<keescook@chromium.org>, <mhocko@kernel.org>, <labbott@redhat.com>,
	<jglisse@redhat.com>, <hch@infradead.org>, <cl@linux.com>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>
References: <20180211031920.3424-1-igor.stoppa@huawei.com>
 <20180211031920.3424-5-igor.stoppa@huawei.com>
 <20180211123743.GC13931@rapoport-lnx>
 <e7ea02b4-3d43-9543-3d14-61c27e155042@huawei.com>
 <20180212114310.GD20737@rapoport-lnx> <20180212125347.GE20737@rapoport-lnx>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <68edadf0-2b23-eaeb-17de-884032f0b906@huawei.com>
Date: Mon, 12 Feb 2018 15:41:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180212125347.GE20737@rapoport-lnx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590497635371449856?=
X-GMAIL-MSGID: =?utf-8?q?1592202840718945296?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 12/02/18 14:53, Mike Rapoport wrote:
> 'scripts/kernel-doc -v -none 

That has a quite interesting behavior.

I run it on genalloc.c while I am in the process of adding the brackets
to the function names in the kernel-doc description.

The brackets confuse the script and it fails to output the name of the
function in the log:

lib/genalloc.c:123: info: Scanning doc for get_bitmap_entry
lib/genalloc.c:139: info: Scanning doc for
lib/genalloc.c:152: info: Scanning doc for
lib/genalloc.c:164: info: Scanning doc for


The first function does not have the brackets.
The others do. So what should I do with the missing brackets?
Add them, according to the kernel docs, or leave them out?

I'd lean toward adding them.

--
igor
