Return-Path: <kernel-hardening-return-12741-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+m9bAp79RbqWdFSsHgz2zKLZS1VyZVUndp9xJFAp92FHuOIMjBr1VKngGteIvYJkNFwQQN
ARC-Seal: i=1; a=rsa-sha256; t=1522103958; cv=none;
        d=google.com; s=arc-20160816;
        b=NC8qa9zsZtx8GvK5ut6vU8F/+PGVtMiv5F9CI75a+9sJzjDXYbOGCEWbGveE4dASxQ
         khKVdJj7PIn+Fklq6mKjZ0PQ+RRLMnXBP84kTKxqh31+CRmgf15Zx6R21+5OBVMYbJG1
         /V10YBJts/U0BFDv8IhVsPqOqDiYKaUbz0R9HFJqKyPGmgc2tEVK5WVfgYxQlmBtgr7L
         L09W6YAT2BuF/b/gcSdzaCpCmjUcB9KFzADEE44TFHvmRSM3p8Tj0hmir1hPaL8lIv03
         wiq8mEICBfz2P9wHDWwOM3aNexnRR1jcQumfZ7swpjpR8fdsrUm+2k4cMnTmlfwQhYcS
         NOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=6/X+W8pbHgOlH5x84kmi2lqQF0CHEo2jqz5FPOz0JQw=;
        b=Nf9ct8xFWnfz6Kpx3zdKZf1kKcuvavw4erSBinVQIu9E92NhY4rNWT9wfPpvPd31QA
         0jGtnTbWKv8RZ+IuWwJGhok4tZ+nfRWy9fzpf193H0gQX+dwbsHgCtY2lgCCRXTjeOrS
         nvWejwEh0kKDyFzwgYEFLzdklY5Qslr7eZ2M6tgGsXEG0QNGfZE4glcHpndjflDOHhI/
         ei9Qard5HzhpaP9/Nj6/yqjW3bVZRZhJdFaO1eE0VX53kITf/ZQw1wGqbeaizIR2GGTy
         FFp0/+XYLsV9NLEj5L5P/3KdL9thuqRXeOeERk5CDTOf4OvvRKRn6jiHvWyQsYqT8Hk1
         /MSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=VpbgFWui;
       dkim=pass header.i=@chromium.org header.s=google header.b=TcLFggfP;
       spf=pass (google.com: domain of kernel-hardening-return-12741-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12741-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=VpbgFWui;
       dkim=pass header.i=@chromium.org header.s=google header.b=TcLFggfP;
       spf=pass (google.com: domain of kernel-hardening-return-12741-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12741-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180316155632.GI7095@gondor.apana.org.au>
References: <20180308215702.GA9902@beast> <20180316155632.GI7095@gondor.apana.org.au>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 26 Mar 2018 15:38:59 -0700
X-Google-Sender-Auth: P8aZvoy1aONEE7RMVQ8kf6kW4yM
Message-ID: <CAGXu5jKJ-05xb8x7A4dZmFQm10z5g9x1LhFbC1nzLT7kdVVbGg@mail.gmail.com>
Subject: Re: [PATCH v2] crypto/ecc: Remove stack VLA usage
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Tudor Ambarus <tudor.ambarus@microchip.com>, "David S. Miller" <davem@davemloft.net>,
	linux-crypto <linux-crypto@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594317666211482580?=
X-GMAIL-MSGID: =?utf-8?q?1596041680471953970?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 8:56 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Thu, Mar 08, 2018 at 01:57:02PM -0800, Kees Cook wrote:
>> On the quest to remove all VLAs from the kernel[1], this switches to
>> a pair of kmalloc regions instead of using the stack. This also moves
>> the get_random_bytes() after all allocations (and drops the needless
>> "nbytes" variable).
>>
>> [1] https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Patch applied.  Thanks.

Hi, sorry for the noise on this one: I messed up looking at the ecc
code (I confused myself into thinking there was only a single instance
of the problem). The applied patch is both incomplete and inefficient.
I have a much simpler solution, and I'll send that with a revert...

-Kees

-- 
Kees Cook
Pixel Security
