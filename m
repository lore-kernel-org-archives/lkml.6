Return-Path: <kernel-hardening-return-11854-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226t4bENawRuXV59fFlt0COjUO9Ql4IVqXw53sJKOGNwG6rjIg+mpD93klBfWmRGoBviBRzQ
ARC-Seal: i=1; a=rsa-sha256; t=1519214524; cv=none;
        d=google.com; s=arc-20160816;
        b=kbZtdFXEoIg9M8bOzwV7fsaIr7gJdC6+ilDQdONWKRetD02PB7YmhAVTSd2qCnS5SS
         aquKW7Bt74GkLnQNvlkRBPGL6bRUD3Gr3wEusPNTQq0QBjc9/0cHITWghseWU/ZPMrmo
         RH1VEJmqN9rZyYIAxnz/cSpNYuLH3klx2j8fDVGu0OcSfaDaHzi8Pee7JGvWut3ajiSd
         t+Nkmj324klQVsVat0P/ZXsOO/XxIT4017hmB09QwqP0qNyQN32TehkQJCztPJ3v78jS
         sH05Y3WoVXGNVTu+S/+1TgDCT7ke7ba+Sz7OLJJ7G+8ZAJ+oZCXmic3u/c13BMov2vcl
         qWSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=Eywmp9abR1RtY2zl0ikfAcRDEGiiYw7KYmkvq5otBKM=;
        b=xsnZ6sA0pXafCRUpk2EFUmkAhI3MYOm1Rx27uDgKY+eDjEKttJUAByhv+Xarmz2O/U
         sX3Q8yFjyAK+14NkXOmOFGWfi9d5hDgwF8BWcr90X035KNsiL38Kn+U8JCW3M/N46Fa3
         KRA8XlrKaFg+jFYFI1PUkHiBTNvJj8NQ77v2LrwygpOig0pCKioPaosVk/K95eix/ZAT
         hvWJrPCVIAPRlX3bXUtK/XzmqxHhdzJfY7D3jh+SUyy6ft3RLljHTfScDsplYO3+Gh4m
         AhA/aiTNVB7+MEfxFsVtmKuUFEuHU7KdiWBq9v5EZpZ5K8tg+Hy8ei94TF+EYQkiV6OI
         fKsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11854-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11854-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11854-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11854-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 3/6] struct page: add field for vm_struct
To: Matthew Wilcox <willy@infradead.org>
CC: <rdunlap@infradead.org>, <corbet@lwn.net>, <keescook@chromium.org>,
	<mhocko@kernel.org>, <labbott@redhat.com>, <jglisse@redhat.com>,
	<hch@infradead.org>, <cl@linux.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>
References: <20180211031920.3424-1-igor.stoppa@huawei.com>
 <20180211031920.3424-4-igor.stoppa@huawei.com>
 <20180211211646.GC4680@bombadil.infradead.org>
 <cef01110-dc23-4442-f277-88d1d3662e00@huawei.com>
 <b59546a4-5a5b-ca48-3b51-09440b6a5493@huawei.com>
 <20180220205442.GA15973@bombadil.infradead.org>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <c4c805ed-5869-81c2-4c05-cf53bfbef168@huawei.com>
Date: Wed, 21 Feb 2018 14:01:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180220205442.GA15973@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592073184128407406?=
X-GMAIL-MSGID: =?utf-8?q?1593011889375359627?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 20/02/18 22:54, Matthew Wilcox wrote:
> On Tue, Feb 20, 2018 at 09:53:30PM +0200, Igor Stoppa wrote:

[...]

>> It was found while testing on a configuration with framebuffer.
> 
> ... ah.  You tried to use vmalloc_to_page() on something which wasn't
> backed by a struct page.  That's *supposed* to return NULL, but my
> guess is that after this patch it returned garbage.

it seems to return garbage also without this patch, but I need to clean
up the code, try it again and possibly come up with a demo patch for
triggering the problem.

I'll investigate it more. However it doesn't seem to be related to the
functionality I need. So I plan to treat it as separate issue and leave
find_vm_area untouched, at least in pmalloc scope.

--
igor
