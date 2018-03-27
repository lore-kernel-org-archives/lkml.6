Return-Path: <kernel-hardening-return-12765-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuCKhpOVXCMBadwU5yJp+rWKsSteu8HowmxYLiwateimxvmBco6hAfU5UU84O8XJHLIiFcG
ARC-Seal: i=1; a=rsa-sha256; t=1522158101; cv=none;
        d=google.com; s=arc-20160816;
        b=iu6hDmDDqwNNbpWCP8rnU5jGB4mubipeRYovI6BEr0aHzZXSPJg3qfj1bEJ/yT0oUu
         7QXqI8NJXR62PL9jc/L5q4jQ11MlzjnEKLMN0XkO64kNlpRMfVlgGqcjZIPgjMKSWYuY
         kofp5uygUXj4Iqn507TFeFgpjRQS+XHI3oYyybvFkzyFV/En77i0eKcWmdYYBSR/1ko/
         rwHR+sBqGly3WoyWjS/OoJRcx9GlnhW2pwzUdtoL/Ou1DXxqeDcOz4AkhMYCK8nofwnJ
         S8oKpPQiETxIIDlzHp2osLrJTtTRemX32QhilCcS47YT+GS1yBIPEjHytojzDAM+isR3
         IMlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=86QHRQo7aM9dZfRQOdEmnGPdgQe6yiUgRks03IzMsik=;
        b=hfzYqM3Bl/qB09+K9dncFj4FH29aTGP3QKda2SlEjN/76wf1Q0bwQ7H5XQa3cJVoM/
         jc3z0cIVUVsvRl1sqzMgKCl+wXuGCW2oEWi3SYYahyyHNqz4iLcFqSzijZZJMNxeS/vw
         NsDf20GK+kGC0+fhy5ut0TzsYMFENJvEkX2vGWu8Vt6S1pm5tNtH6tgW42byzBUAKOrz
         hWGa1ka3mZmnt/fTUv+/6gSlRwt1VDAagfvq2RmsCtqocHx/IlgoBNKGpNIldZgznJ2Y
         gGDvt/ids2VtpZEgIuZhGv8KjuKd9/h8CUJUq5ZFFbdUmOhYG6LfSza0wX3qSMM0SI95
         MvCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=dfMYPZ1v;
       spf=pass (google.com: domain of kernel-hardening-return-12765-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12765-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=dfMYPZ1v;
       spf=pass (google.com: domain of kernel-hardening-return-12765-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12765-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <90e40062-cedb-be32-ab17-56136c78dbad@redhat.com>
References: <20180315180030.20001-1-labbott@redhat.com> <20180315180030.20001-5-labbott@redhat.com>
 <21a2e869-62fb-75ef-ae7b-a27e136696f7@electromag.com.au> <90e40062-cedb-be32-ab17-56136c78dbad@redhat.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 27 Mar 2018 15:41:23 +0200
Message-ID: <CACRpkdafSd0R1czzw8w7bB8Stbvrx6LoP7tR7BQQnB1RSKQysQ@mail.gmail.com>
Subject: Re: [PATCHv2 4/4] gpio: Remove VLA from stmpe driver
To: Laura Abbott <labbott@redhat.com>
Cc: Phil Reid <preid@electromag.com.au>, Kees Cook <keescook@chromium.org>,
	Patrice Chotard <patrice.chotard@st.com>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595027652990122948?=
X-GMAIL-MSGID: =?utf-8?q?1596098453705166681?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Laura,

sorry for slow response :/

On Thu, Mar 22, 2018 at 10:43 PM, Laura Abbott <labbott@redhat.com> wrote:
> On 03/18/2018 06:29 PM, Phil Reid wrote:
>>
>> On 16/03/2018 02:00, Laura Abbott wrote:
>>>
>>> The new challenge is to remove VLAs from the kernel
>>> (see https://lkml.org/lkml/2018/3/7/621)
>>>
>>> This patch replaces a VLA with an appropriate call to kmalloc_array.
>>>
>>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>>> ---
>>> v2: Switch to GFP_KERNEL. There was some discussion about if we should
>>> be doing the allocation at all but given a) the allocation is pretty
>>> small and b) we can possibly take a mutex in a called function I think
>>> this is fine.
>>
>>
>> I still think it's a bad idea. It's simple to preallocate the buffer.
>> But it's up to the maintainer.
>>
>
> I'd feel a lot more confident about doing the global buffer with
> guidance from the maintainer. But looking at the platform data, the
> maximum number of GPIOs is 24, or 3 banks. Maybe we should just always
> stack allocate the maximum since it's fairly small.

Either way works fine, global (in the state container struct stmpe_gpio)
or stack allocation for 24 bits.

I guess I am maintainer for this, I can test it at least.

Yours,
Linus Walleij
