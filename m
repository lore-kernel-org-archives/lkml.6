Return-Path: <kernel-hardening-return-11868-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227irrsHlXlT/WByDuevMYRNLrasSbOHgMLOX09901p83On74IbpdVUy+UTUBxe/eA3Al/ni
ARC-Seal: i=1; a=rsa-sha256; t=1519252104; cv=none;
        d=google.com; s=arc-20160816;
        b=jRLcQGgGVT8WSsGguusj0UHjSDp/WGQUqxoKtx6PxrVGgiLdErlPj4aimB4MYgJaJv
         57dKvQY5WaCs0KuksxNb8ac7Lnguw38Otq5B1SODh7/eSpb8OA1LY5KP1polT16Nl/s2
         Rw6Eda7yNHK3XrN2kjGDXn48R8re7yNSxk7nwpPMKjgUTVBErPd7jCIl/jkpoA3So3kN
         OPrULjBdyjYcmCItk3tdAq2ptrQ+Kr9yypgIgP8+IlqsTfOsyxNpdnm3lMILkgJ7YrVR
         ijuqNZo4H7XjfhGxjCbuABb3smysqR/jVVztei3jG7LK1BTL5uPrNJTs6P1cw/29cZzu
         64+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=rJHru9O2xpb1JCzx5LFnVyzJS1EriUu/Modk1V8t3UI=;
        b=KvC4K+m0tTnnoSW1x39pDKmIRjubNXU7R53c2Z3cdlLHyTlcJUiKFSZNcWX3cXkdPH
         d7YYKDylWPw56NbOM2Lvl0xpeGLPYt6SAj1c+FMybCq8NfMQyhjAjkP8AwOE5Oy/gQ4J
         m5ZWIPWzyl2WSsqcuuu3RQiGWe8RRcC8764f1xkTF8VlKY+3kD5mHToCL2yhfpHwKNct
         W5TQq7T9EwAjbMD5jpeeN+S6W80s4k1aKp/wN/yB1AEtOqqWFuC3e0nLXenkRl1J/pSs
         Gz7igXFznpf8cbQwLTMbIMNwCFXlA8OWicJDvVd81vF201accQZOzyzjA/x5cwTO+ntE
         y/Gg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=S3+541gy;
       dkim=pass header.i=@chromium.org header.s=google header.b=GcMxDhD1;
       spf=pass (google.com: domain of kernel-hardening-return-11868-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11868-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=S3+541gy;
       dkim=pass header.i=@chromium.org header.s=google header.b=GcMxDhD1;
       spf=pass (google.com: domain of kernel-hardening-return-11868-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11868-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <f33112e4-608f-ae8c-bf88-80ef83b61398@huawei.com>
References: <20180212165301.17933-1-igor.stoppa@huawei.com>
 <20180212165301.17933-3-igor.stoppa@huawei.com> <CAGXu5jJNERp-yni1jdqJRYJ82xrP7=_O1vkxG1sJ-b8CxudP9g@mail.gmail.com>
 <f33112e4-608f-ae8c-bf88-80ef83b61398@huawei.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 21 Feb 2018 14:28:03 -0800
X-Google-Sender-Auth: A28LW73r4A5RNy3dN_wk6URMMMo
Message-ID: <CAGXu5jLeC285BGDW29aHgFZRV6CnqBmmkZULW2pzYmqd0pe9UQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] genalloc: selftest
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Matthew Wilcox <willy@infradead.org>, Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, Laura Abbott <labbott@redhat.com>,
	Jerome Glisse <jglisse@redhat.com>, Christoph Hellwig <hch@infradead.org>, Christoph Lameter <cl@linux.com>,
	linux-security-module <linux-security-module@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592214940015088630?=
X-GMAIL-MSGID: =?utf-8?q?1593051294656015387?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 8:59 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>
>
> On 13/02/18 01:50, Kees Cook wrote:
>> On Mon, Feb 12, 2018 at 8:52 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>
> [...]
>
>>>  lib/genalloc-selftest.c           | 400 ++++++++++++++++++++++++++++++++++++++
>>
>> Nit: make this test_genalloc.c instead.
>
> ok
>
> [...]
>
>>> +       genalloc_selftest();
>>
>> I wonder if it's possible to make this module-loadable instead? That
>> way it could be built and tested separately.
>
> In my case modules are not an option.
> Of course it could be still built in, but what is the real gain?

The gain for it being a module is that it can be loaded and tested
separately from the final kernel image and module collection. For
example, Chrome OS builds lots of debugging test modules but doesn't
include them on the final image. They're only used for testing, and
can be separate from the kernel and "production" modules.

> [...]
>
>>> +       BUG_ON(compare_bitmaps(pool, action->pattern));
>>
>> There's been a lot recently on BUG vs WARN. It does seem crazy to not
>> BUG for an allocator selftest, but if we can avoid it, we should.
>
> If this fails, I would expect that memory corruption is almost guaranteed.
> Do we really want to allow the boot to continue, possibly mounting a
> filesystem, only to corrupt it? It seems very dangerous.

I would include the rationale in either a comment or the commit log.
BUG() tends to need to be very well justified these days.

>> Also, I wonder if it might make sense to split this series up a little
>> more, as in:
>>
>> 1/n: add genalloc selftest
>> 2/n: update bitmaps
>> 3/n: add/change bitmap tests to selftest
>>
>> Maybe I'm over-thinking it, but the great thing about this self test
>> is that it's checking much more than just the bitmap changes you're
>> making, and that can be used to "prove" that genalloc continues to
>> work after the changes (i.e. the selftest passes before the changes,
>> and after, rather than just after).
>
> If I really have to ... but to me the evidence that the changes to the
> bitmaps do really work is already provided by the bitmap patch itself.
>
> Since the patch doesn't remove the parameter indicating the space to be
> freed, it can actually compare what the kernel passes to it vs. what it
> thinks the space should be.
>
> If the values were different, it would complain, but it doesn't ...
> Isn't that even stronger evidence that the bitmap changes work as expected?
>
> (eventually the parameter can be removed, but I intentionally left it,
> for facilitating the merge)

I'll leave it up to the -mm folks, but that was just my thought.

-Kees

-- 
Kees Cook
Pixel Security
