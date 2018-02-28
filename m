Return-Path: <kernel-hardening-return-12045-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsigISW2VYOldaew7vdrnsB/yj3ADXFsgS8YSg8Q7xoCYCvv+FzVJp5o2smggrl7yr2aM0w
ARC-Seal: i=1; a=rsa-sha256; t=1519847692; cv=none;
        d=google.com; s=arc-20160816;
        b=XR1J0Q8/aB+ER0xLSaJ75mYkNmA7lP2oUdH5faxtvZXtaiVXcgQ707yexgZpkAzyUX
         IRtb2T2Is6oeQgxVflszGlyMd26B31MjzpoR7vwTNCtOapVEHALXTEqF1LQhHtQ4kzCb
         ZNvLxhLY5lgKn7bmCDuo/jxiwj14S24rUDE3ZyW4UEMquh38ckund+0la+6nOtFinQhg
         dc9R6jCd7pOrkDq5rjH7X4XX9csIT+fdtHWTGzSU+vj/fyMh4l3MZ2i0hC3diG/Fn6M/
         pxXyXT/vSxxjVBFz9VbtsVow280cwSYm2LSm2zI6dLJS+Dy7Q8nNE4da8OjoV0gamtsS
         GK8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:sender:mime-version:dkim-signature
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=8nuzetamnbDVzWdUqCnlwpKPojsVJmWt4zMEvyOeGZ8=;
        b=aKhEjflxvE5v1KyqNwd7loGpeuzrL3H3WiW3r1KulT+cq68HXobuas5GK0TFfvKSzK
         SxbYxv/iPGoWdOZiCNqcbKMIsfC+kPfoi90TY/MxSQYYHDfRqZ1Tiu4fvCOpDnaa+FkI
         a3eMWJsrrqV/N0YvPLOq8qs4FP6210huIu+sOfhLGqyhtH/8E4WzYpeyE3BWCxdbyZP+
         CoEMTWZSMFgspZT6Yz55u13Y5eH/QsKCht5FInLn5RshRCCPBYqj9gvJYt5bC7Kr5cSs
         cFxHDLCYQhctmi75+MCriWkhKEuqZr42Tlefr7tQcParFeuJphp4KNvQFDiF4+Ff7bpa
         OeIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=TKyB7lOw;
       dkim=pass header.i=@chromium.org header.s=google header.b=hhLx0wvF;
       spf=pass (google.com: domain of kernel-hardening-return-12045-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12045-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=TKyB7lOw;
       dkim=pass header.i=@chromium.org header.s=google header.b=hhLx0wvF;
       spf=pass (google.com: domain of kernel-hardening-return-12045-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12045-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <55C92196-5398-4C19-B7A7-6C122CD78F32@gmail.com>
References: <20180227131338.3699-1-blackzert@gmail.com> <CAGXu5jKF7ysJqj57ZktrcVL4G2NWOFHCud8dtXFHLs=tvVLXnQ@mail.gmail.com>
 <55C92196-5398-4C19-B7A7-6C122CD78F32@gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 28 Feb 2018 11:54:32 -0800
X-Google-Sender-Auth: NYFjIqahP2zR9JElan52x58o_IQ
Message-ID: <CAGXu5jLY4eX5BMU8-2HFr2myjSL717KE-m_SAQp1yeu=cg+w7g@mail.gmail.com>
Subject: Re: [RFC PATCH] Randomization of address chosen by mmap.
To: Ilya Smith <blackzert@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@suse.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Jan Kara <jack@suse.cz>, Jerome Glisse <jglisse@redhat.com>, Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>, Helge Deller <deller@gmx.de>,
	Andrea Arcangeli <aarcange@redhat.com>, Oleg Nesterov <oleg@redhat.com>, Linux-MM <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593560218941631465?=
X-GMAIL-MSGID: =?utf-8?q?1593675813334726122?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 9:13 AM, Ilya Smith <blackzert@gmail.com> wrote:
>> On 27 Feb 2018, at 23:52, Kees Cook <keescook@chromium.org> wrote:
>> What are the two phases here? Could this second one get collapsed into
>> the first?
>>
>
> Let me explain.
> 1. we use current implementation to get larger address. Remember it as
> =E2=80=98right_vma=E2=80=99.
> 2. we walk tree from mm->mmap what is lowest vma.
> 3. we check if current vma gap satisfies length and low/high constrains
> 4. if so, we call random() to decide if we choose it. This how we randoml=
y choose vma and gap
> 5. we walk tree from lowest vma to highest and ignore subtrees with less =
gap.
> we do it until reach =E2=80=98right_vma=E2=80=99
>
> Once we found gap, we may randomly choose address inside it.
>
>>> +       addr =3D get_random_long() % ((high - low) >> PAGE_SHIFT);
>>> +       addr =3D low + (addr << PAGE_SHIFT);
>>> +       return addr;
>>>
>>
>> How large are the gaps intended to be? Looking at the gaps on
>> something like Xorg they differ a lot.
>
> Sorry, I can=E2=80=99t get clue. What's the context? You tried patch or w=
hats the case?

I was trying to understand the target entropy level, and I'm worried
it's a bit biased. For example, if the first allocation lands at 1/4th
of the memory space, the next allocation (IIUC) has a 50% chance of
falling on either side of it. If it goes on the small side, it then
has much less entropy than if it had gone on the other side. I think
this may be less entropy than choosing a random address and just
seeing if it fits or not. Dealing with collisions could be done either
by pushing the address until it doesn't collide or picking another
random address, etc. This is probably more expensive, though, since it
would need to walk the vma tree repeatedly. Anyway, I was ultimately
curious about your measured entropy and what alternatives you
considered.

-Kees

--=20
Kees Cook
Pixel Security
