Return-Path: <kernel-hardening-return-11716-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227vqyJIGirlUTmb6LAdP8uYz5qF6kaNNpzoRBv1wlNofGdKh4oQpWmLP3EA28W1LEMJys09
ARC-Seal: i=1; a=rsa-sha256; t=1518435422; cv=none;
        d=google.com; s=arc-20160816;
        b=acbYxkxJ7ZEgoFGIpMzFQXeQb/pmKOb1xWiQUnBM6PRM2EMiPw0/Ddc44KxxI9pNxK
         uHb31j4EuK0RxsDnA30KpsfBz80jkW5RvIcLzloBw17fUnOyZ7zEaF1W32+1im46Yu+U
         I6MmyudKiyMZ8nXrSYPV9p5THSJ20NLTPASwvSuVdI4pvok45t9XqO186Bco/QRckc+I
         pNTvqyTgF4vlirADiGZXL7E9BGT9OQRW2Hp8bxYxz76KQgwQxN4sZ8mYS0d8ifMCKWk/
         1mTvjCoQ2gXyoHer2igBVIsBXhNmyUUwKrqoYLVQ8df/6mJchKdJgmm/cz32wpKsWGeb
         nrOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:user-agent:in-reply-to:content-disposition:mime-version
         :references:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=j7bEYliD6rmBQLBKtPc9YusOpczVh97BEvYmj7DUzmU=;
        b=dgaigfFdnf8MYSM066T1yYEpfC+j9SOivdOZcMEsUt+xVZ2ikRgfxGu/FBE5gIAiJS
         LYzOCk1obn5auo0oNKhCLKcjWMH2DYsOcHOmdggNhbK7T/W20HnPu+ehbvOQE2KKRjrK
         y0/Dxyne0N3IclEXh0C1QGspU7nSPKJwmP5D2aez6cJnwgGKzZuAsrz/7LTv47w/JVNG
         EGhrBz0hFA9c9f84Afrkg+f/YovAxRc5kU/EeOWX3Mx/LzibHSqQuHDXJ4I0dmkwatYp
         c+BSPNuRgWR6yBy/C8i8SKx5KlkKCdJm3cR+25wYLJS0ZmhWN6YNyMm1KvkKd0F23UPl
         4Nhg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11716-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11716-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11716-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11716-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 12 Feb 2018 13:36:33 +0200
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: willy@infradead.org, rdunlap@infradead.org, corbet@lwn.net,
        keescook@chromium.org, mhocko@kernel.org, labbott@redhat.com,
        jglisse@redhat.com, hch@infradead.org, cl@linux.com,
        linux-security-module@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 1/6] genalloc: track beginning of allocations
References: <20180211031920.3424-1-igor.stoppa@huawei.com>
 <20180211031920.3424-2-igor.stoppa@huawei.com>
 <20180211122444.GB13931@rapoport-lnx>
 <f0a244f2-f63a-376b-28f2-debbe914da34@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0a244f2-f63a-376b-28f2-debbe914da34@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18021211-0016-0000-0000-00000521DC6C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021211-0017-0000-0000-0000285E9F12
Message-Id: <20180212113633.GC20737@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802120151
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592073112440630013?=
X-GMAIL-MSGID: =?utf-8?q?1592194941737503087?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 01:17:01PM +0200, Igor Stoppa wrote:
> 
> 
> On 11/02/18 14:24, Mike Rapoport wrote:
> > On Sun, Feb 11, 2018 at 05:19:15AM +0200, Igor Stoppa wrote:
> [...]
> 
> >> +/**
> >> + * mem_to_units - convert references to memory into orders of allocation
> > 
> > Documentation/doc-guide/kernel-doc.rst recommends to to include brackets
> > for function comments. I haven't noticed any difference in the resulting
> > html, so I'm not sure if the brackets are actually required.
> 
> This is what I see in the example from mailine docs:
> 
> /**
>  * foobar() - Brief description of foobar.
>  * @argument1: Description of parameter argument1 of foobar.
>  * @argument2: Description of parameter argument2 of foobar.
>  *
>  * Longer description of foobar.
>  *
>  * Return: Description of return value of foobar.
>  */
> int foobar(int argument1, char *argument2)
> 
> 
> What are you referring to?
 
I'm referring to "foobar() - brief description" vs "foobar - brief
description".

The generated html looks exactly the same in the browser, so I don't know
if the brackets are really required.

> [...]
> 
> >> + * @size: amount in bytes
> >> + * @order: power of 2 represented by each entry in the bitmap
> >> + *
> >> + * Returns the number of units representing the size.
> > 
> > Please s/Return/Return:/
> 
> :-( I thought I had fixed them all. thanks for spotting this.
> 
> [...]
> 
> >> + * Return: If two users alter the same bit, to one it will return
> >> + * remaining entries, to the other it will return 0.
> > 
> > And what if there are three or four concurrent users? ;-)
> > 
> > I believe that a more elaborate description about what happens with
> > concurrent attempts to alter the bitmap would be really helpful.
> 
> ok
> 
> --
> thanks, igor
> 

-- 
Sincerely yours,
Mike.
