Return-Path: <kernel-hardening-return-11867-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226kIc1qPcSbf/H+3KBm7A/evjo943tX90NfkZxf+ofZuUx8ZVK/LBHGfDcIEjvlpvp9jeef
ARC-Seal: i=1; a=rsa-sha256; t=1519251901; cv=none;
        d=google.com; s=arc-20160816;
        b=bwo6D/qL9X4rL2TObDnFGqhRvNDR8MdZLW7/uDKzIhlvwn+09PwIlFBWycdg3QxJ+3
         OwEgbNWJaDF9hk5dCNOY78xR0mgPGwcf8W0ldj1pumwhlm0VCx6PFoiZLHljhTlCv14L
         M59U2VQUIM9qqhjyPF4p12jj7xIsR3PBCUapCMiL5+udDe0jVQs1hmXXj0YT9Ub4BNGJ
         u6xU5DnndWc8k8HeUKHCv4MqIR4lIP+M/BaIC6IWeluI9t0QlS05uAqrTEwqbeiroen/
         rhNX3fsmy2UcuMVHIm+uwBr+Q5nxcXhF/XTMqdwCQN6hHfCgLLcDn/x4nGOdD8A9S467
         wgqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=Wo+kXFYqhbdcohQqURSKyC3b9doTwKo1/7oUeciALDc=;
        b=O/vZyfpxZ+iNxAJZ6G1Dma6xSrfGPj7NVoP/hQ/BsuxDrnnVe5C+NUyOoUJXDTQeYt
         Cw4aQlnY8z5pY4m1gfYJAYbiEN6g+4eZsy942DnvkakUWJqRRDc5kRT4qzlmkivyVxJB
         7lQIiqq/7C1Gyhs536Ykvrc5TjrmhYAei1eZ/A16wYcEsyvwb2YHyp5QA+2W9yrRW3ig
         e/JkfxoLq7IxxAabngkHjBoC8NtcxQvXIVt0doCjtTW/0r5lmosHZjAh8fO3CciWMuG+
         mLwb4+AetNIY+JZNOGE6rTgOBMniZ6I6pztBFakMhwuenlQbTaNP7lrOR/5chP3wr3wR
         KmJA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=B70RrIaA;
       dkim=pass header.i=@chromium.org header.s=google header.b=TPdLN+J2;
       spf=pass (google.com: domain of kernel-hardening-return-11867-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11867-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=B70RrIaA;
       dkim=pass header.i=@chromium.org header.s=google header.b=TPdLN+J2;
       spf=pass (google.com: domain of kernel-hardening-return-11867-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11867-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <bd11826b-f3c1-be03-895c-85c08a149045@huawei.com>
References: <20180212165301.17933-1-igor.stoppa@huawei.com>
 <20180212165301.17933-6-igor.stoppa@huawei.com> <CAGXu5j+ZZkgLzsxcwAYgyu=A=11Fkeuj+F_8gCUAbXDmjWFdeg@mail.gmail.com>
 <bd11826b-f3c1-be03-895c-85c08a149045@huawei.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 21 Feb 2018 14:24:42 -0800
X-Google-Sender-Auth: LLnroS9k8MPf9ANkgEu23KSd2a8
Message-ID: <CAGXu5j+ivd0Ys++6hqCjkipx8RFKTAmWf+KbtxEwT3SECD5C6A@mail.gmail.com>
Subject: Re: [PATCH 5/6] Pmalloc: self-test
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Matthew Wilcox <willy@infradead.org>, Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, Laura Abbott <labbott@redhat.com>,
	Jerome Glisse <jglisse@redhat.com>, Christoph Hellwig <hch@infradead.org>, Christoph Lameter <cl@linux.com>,
	linux-security-module <linux-security-module@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592215146511084234?=
X-GMAIL-MSGID: =?utf-8?q?1593051081817031331?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 8:40 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>
> On 13/02/18 01:43, Kees Cook wrote:
>> On Mon, Feb 12, 2018 at 8:53 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>
> [...]
>
>>> +obj-$(CONFIG_PROTECTABLE_MEMORY_SELFTEST) += pmalloc-selftest.o
>>
>> Nit: self-test modules are traditionally named "test_$thing.o"
>> (outside of the tools/ directory).
>
> ok
>
> [...]
>
>> I wonder if lkdtm should grow a test too, to validate the RO-ness of
>> the allocations at the right time in API usage?
>
> sorry for being dense ... are you proposing that I do something to
> lkdtm_rodata.c ? An example would probably help me understand.

It would likely live in lkdtm_perms.c (or maybe lkdtm_heap.c). Namely,
use the pmalloc API and then attempt to write to a read-only variable
in the pmalloc region (to prove that the permission adjustment
actually happened). Likely a good example is
lkdtm_WRITE_RO_AFTER_INIT().

-Kees

-- 
Kees Cook
Pixel Security
