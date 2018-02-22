Return-Path: <kernel-hardening-return-11886-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226eQIQA7GLzl4QlCScbZGaqaN5mmZAPJkgW+bBuF/Qs1wwknH/Dzl6ViJzD7KdALY00LWhx
ARC-Seal: i=1; a=rsa-sha256; t=1519289986; cv=none;
        d=google.com; s=arc-20160816;
        b=cBdvn8qDZLL9tnh5wsYlq+OdWw0jmwNomovIev2TcrZSRvLhT6dsXKryp4x1THKe+R
         1O10mftITe3BRAQmvi1yRQGPCdSlcjruTa+Zxjwonj0cVY7bxqZMH5X8oxhnHU8w7dHU
         nn7VntuJ+Cme54wLQCtk2xhTFlIzAR2oU4oD+2gk/HIddfRl8sOiCllwsaIWheNfqFF+
         hEjnjMrLjAQvmzfpAWswSnxH7zsyq0Qp4YvyTC9i9TFaV+jNoXJWhn0ITJbgEyl9HHnZ
         bk/hrIWSTEokge/vkME0d0QrtYVzDDwFIdD9mSkUTzRD9Ex/OD1BoiG8lBTrDEHGx06X
         RJpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=fN7C8KztLG+ggUPIzl31HH3+43Glh1jkBnV2FaS2FKw=;
        b=B0ZCLMXnaXc2TQeBAAXGF9RKiZv8Zv02XXO1xyQCiqcBJmgq/Ox7DItaGnayDsSpVh
         w/jQ1KbUx/NKtpN0G+1vWH31Qt4RH+LtIqjjE5V5mKRc4XExFor27NPtTnYAY0+fX2wn
         ao6jjGR4ZnOEfMI4Kr2d07KjMxoEF7rn8/NRwvUcnLS2pC4tRi7u3urxZx9ui3Or1W0c
         oiyJ5w3fq1uRcmo64y8bdsJEl1rzqwACGVxwsHM/5XSlPoEToNrA2Us5fjWtNMAQt1LI
         Omjd3GeJ4YeuoFgTnubK+pWKbt6rsCYetoIVk3G7XA+oI5uP5vW8/c74Sl1gNlg33oeD
         PJjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11886-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11886-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11886-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11886-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [RFC PATCH v16 0/6] mm: security: ro protection for dynamic data
To: Dave Chinner <dchinner@redhat.com>
CC: Matthew Wilcox <willy@infradead.org>, Kees Cook <keescook@chromium.org>,
	Randy Dunlap <rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>, Laura Abbott <labbott@redhat.com>, "Jerome
 Glisse" <jglisse@redhat.com>, Christoph Hellwig <hch@infradead.org>,
	"Christoph Lameter" <cl@linux.com>, linux-security-module
	<linux-security-module@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, LKML
	<linux-kernel@vger.kernel.org>, Kernel Hardening
	<kernel-hardening@lists.openwall.com>
References: <20180212165301.17933-1-igor.stoppa@huawei.com>
 <CAGXu5j+ZNFX17Vxd37rPnkahFepFn77Fi9zEy+OL8nNd_2bjqQ@mail.gmail.com>
 <20180220012111.GC3728@rh> <24e65dec-f452-a444-4382-d1f88fbb334c@huawei.com>
 <20180220213604.GD3728@rh> <20180220235600.GA3706@bombadil.infradead.org>
 <20180221013636.GE3728@rh> <46a9610a-182b-4765-9d83-cab6297377f3@huawei.com>
 <20180221213629.GF3728@rh>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <77b1e91b-ca65-f13c-ada5-b24c55c87cb3@huawei.com>
Date: Thu, 22 Feb 2018 10:58:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221213629.GF3728@rh>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592214870438978682?=
X-GMAIL-MSGID: =?utf-8?q?1593091016987084977?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 21/02/18 23:36, Dave Chinner wrote:
> On Wed, Feb 21, 2018 at 11:56:22AM +0200, Igor Stoppa wrote:

[...]

> It seems lots of people get confused when discussing concepts vs
> implementation... :)

IMHO, if possible, it's better to use unambiguous terms at every point.
__ro_after_init is already taken :-P

In this specific case, I wanted to be absolutely sure I understood
correctly what you need. I think I have now, thanks.

>> is this something that is readonly from the beginning and then shared
>> among mount points or is it specific to each mount point?
> 
> It's dynamically allocated for each mount point, made read-only
> before the mount completes and lives for the length of the mount
> point.

ok. And destroyed when the mount point is unmounted, I expect.

[...]

>> The "const" modifier is a nice way to catch errors through the compiler,
>> iff the ro data will not be initialized through this handle, when it's
>> still writable.
> 
> That's kinda implied by the const, isn't it? If we don't do it that
> way, then the compiler will throw errors....


I might be splitting the hair, but since I'm advertising something I
worte, I don't want to look like a peddler of snake oil, in hindsight :-P

To clarify my previous comment:

* const can mean the world to the compiler, but that doesn't
automatically translate into write-protected memory, yet I do appreciate
the advantage of teaching the compiler what should not be altered.
And I have nothing against doing it.

* even if some handle will be const, it still needs to be aliased to
some other pointer that is not const, at the beginning, because it must
be initialized and it's anyway writable. So, this cannot be avoided.

--
igor
