Return-Path: <kernel-hardening-return-11829-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225sy3G7DJmtDhaV91E6uoRRbQKbbXsTsdw8BhdOsKK1Ytys+YG9Ck41UggbeHKlDP1jk3PB
ARC-Seal: i=1; a=rsa-sha256; t=1519144847; cv=none;
        d=google.com; s=arc-20160816;
        b=s/SRv8/VIBaETxrfcwB4udNIIiqG2ESLNCyx96fa80un7/NxQ8NRQ3/qxtzxVHmfGN
         3icdZ1GoP9dzcmsJk5qtcsVQWjTkwJztt4PWlIDzArWOzlTXP6FaVoaeocvlkggUrFdI
         Md8kyi6KTM9d2De0SKFVvF2S0mv93pqZknT1OgpFnzc0VYTNqoF5yia0cqT4SEk4Ih+e
         4MdJ2sAZtwvM27rJ5lkcK9ky18ewQ7B4xU07k0Wtm+9ncPjjvcEJNWwTgHjC7vBxa7Fm
         rrXqDra1aiInV0b1TXHY++Cvf3RHWPJ7f3XDHOFOo+4Mk//cJrHhkSDnwdZ8lop53S+I
         7KNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=Rc8p6AuhAxUZakZuHhyXjOew7lfKcMQZihAb191TmQA=;
        b=V4qVzs5d5k+deUl9jenwKY4eueuSgdL4iV3MgYuS3QT/ZE6zp88l+ngBBSEjf/DXFC
         dZBrvmz+C3AeWawL9Sn/utEub/mKSFaJslZ6W5uN1rbXL7lL77uUw0c1wwVOyQ//NGmP
         jHixkzBOfvfO5OgDauWtK1iE0WLLJb2CbcYNfNajSWMoeiFxTFJQFOpfmhBuu7Hu0SZf
         2R0uCZdNM0CrUD4hyjOj5BLsL2egz3Fp0JFo4CekMjPxVqUvc/QLleFDqx9YS4TJ+JQq
         pmExdO7st6lw0k68cOz4YQo8sM52hFLFKxGdutA14vMu7RxY0EyRZ6ts3YfqQ1T1ewvX
         bHXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11829-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11829-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11829-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11829-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 5/6] Pmalloc: self-test
To: Kees Cook <keescook@chromium.org>
CC: Matthew Wilcox <willy@infradead.org>, Randy Dunlap
	<rdunlap@infradead.org>, Jonathan Corbet <corbet@lwn.net>, Michal Hocko
	<mhocko@kernel.org>, Laura Abbott <labbott@redhat.com>, Jerome Glisse
	<jglisse@redhat.com>, Christoph Hellwig <hch@infradead.org>, "Christoph
 Lameter" <cl@linux.com>, linux-security-module
	<linux-security-module@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, LKML
	<linux-kernel@vger.kernel.org>, Kernel Hardening
	<kernel-hardening@lists.openwall.com>
References: <20180212165301.17933-1-igor.stoppa@huawei.com>
 <20180212165301.17933-6-igor.stoppa@huawei.com>
 <CAGXu5j+ZZkgLzsxcwAYgyu=A=11Fkeuj+F_8gCUAbXDmjWFdeg@mail.gmail.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <bd11826b-f3c1-be03-895c-85c08a149045@huawei.com>
Date: Tue, 20 Feb 2018 18:40:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+ZZkgLzsxcwAYgyu=A=11Fkeuj+F_8gCUAbXDmjWFdeg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592215146511084234?=
X-GMAIL-MSGID: =?utf-8?q?1592938828373626696?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 13/02/18 01:43, Kees Cook wrote:
> On Mon, Feb 12, 2018 at 8:53 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:

[...]

>> +obj-$(CONFIG_PROTECTABLE_MEMORY_SELFTEST) += pmalloc-selftest.o
> 
> Nit: self-test modules are traditionally named "test_$thing.o"
> (outside of the tools/ directory).

ok

[...]

> I wonder if lkdtm should grow a test too, to validate the RO-ness of
> the allocations at the right time in API usage?

sorry for being dense ... are you proposing that I do something to
lkdtm_rodata.c ? An example would probably help me understand.

--
igor
