Return-Path: <kernel-hardening-return-11707-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224bUmDMBlvSZKirD8VNnhqXKMkZpI05fScJMNfVXfANqseDimIVoqKD4wZr9KoWpFwwZXSU
ARC-Seal: i=1; a=rsa-sha256; t=1518381423; cv=none;
        d=google.com; s=arc-20160816;
        b=wgmR/hjzIeFsYYLN0wkzVTHugOHWnV40dx1uKOf0/2VJFsrqvBI257A3uCIcfnjr8x
         aC+PSN8CU1gdrktxFYebEODinYENig3do/q6DJMnUo9wsEOFbWFNAW0xBiDKIqDLyTuh
         V5FzzhlSr6y12olH39AWeMcwKUI95PdfrOmGjBb8vVyQbMPYrRBKoQKBOPaebp3A1fRe
         Sz1gPByORj6ve02zJnWHZsbhxXqYLc0ECU6n9+plLF1bO4LYbyzAxYJOHpI1DxTx3a0E
         +uijbaOVuzLCKhyaGOqUA/QZjj8T5rFrSo3UzIuHkTKmhROQ0wO3y8lFprbNzsyzEQ1X
         +G9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=C7o5VJ0421YNuiGJHQl2NpJXnpyMKGjBUvWvmElJFjM=;
        b=iCAS2trRD0pUUA1TUfc31WA4cH0VRI7dCBus5P2wJkxyjk2aNM3+LvQoK75u8g1Csb
         /UPDtdlM0+Z0PWqsExcEjyA4oiInKiR/HUDa0jNEQj+J4oInRlqwMktozS57WYpqrNaJ
         wBwNlVV8BnvXbiS13dTud6cPF1vRMSHA9Ay439JDQuHCFdeyX7fOcoLQTeD2df+QtMdM
         13yGbaDlrDHxD1YxLuRl3cXpV2toUIt3PRLhSW83WzWG/A1akKsYoMmYS+eJ8LWM6evt
         1c6poitNK4lJ6SsLtCIu3ufCDOHo5KIkmKQJeCd/yzSFJZet/vKCIS1uW350VtKstkmg
         fCAg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=I2Qjy0/u;
       spf=pass (google.com: domain of kernel-hardening-return-11707-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11707-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=I2Qjy0/u;
       spf=pass (google.com: domain of kernel-hardening-return-11707-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11707-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180211031920.3424-3-igor.stoppa@huawei.com>
References: <20180211031920.3424-1-igor.stoppa@huawei.com> <20180211031920.3424-3-igor.stoppa@huawei.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Sun, 11 Feb 2018 21:22:34 +0100
Message-ID: <CAOFm3uGNVu87qYzPufu+gGbTwuhp3cjfhKuNDkcmwn3+ysKTdg@mail.gmail.com>
Subject: Re: [PATCH 2/6] genalloc: selftest
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Matthew Wilcox <willy@infradead.org>, Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, mhocko@kernel.org,
	labbott@redhat.com, jglisse@redhat.com, Christoph Hellwig <hch@infradead.org>, cl@linux.com,
	linux-security-module@vger.kernel.org, linux-mm@kvack.org,
	LKML <linux-kernel@vger.kernel.org>, kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591489783349137888?=
X-GMAIL-MSGID: =?utf-8?q?1592138319210985942?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 11, 2018 at 4:19 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
> Introduce a set of macros for writing concise test cases for genalloc.
>
> The test cases are meant to provide regression testing, when working on
> new functionality for genalloc.
>
> Primarily they are meant to confirm that the various allocation strategy
> will continue to work as expected.
>
> The execution of the self testing is controlled through a Kconfig option.
>
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>

<snip>

> --- /dev/null
> +++ b/include/linux/genalloc-selftest.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0

nit... For a comment in .h this line should be instead its own comment
as the first line:
> +/* SPDX-License-Identifier: GPL-2.0 */

<snip>

> --- /dev/null
> +++ b/lib/genalloc-selftest.c
> @@ -0,0 +1,400 @@
> +/* SPDX-License-Identifier: GPL-2.0

And for a comment in .c this line should use C++ style as the first line:

> +// SPDX-License-Identifier: GPL-2.0

Please check the docs for this (I know this can feel surprising but
this has been debated at great length on list)

Thank you!
-- 
Cordially
Philippe Ombredanne
