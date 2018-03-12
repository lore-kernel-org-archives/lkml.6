Return-Path: <kernel-hardening-return-12459-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsaCkRg7JLVaMEhlUjQfeIqJ4uyOSBiMnpqxCunJ1IpExiSwKXSzcgIP/8trlVXj6qZSpye
ARC-Seal: i=1; a=rsa-sha256; t=1520859037; cv=none;
        d=google.com; s=arc-20160816;
        b=q1TAupI+33Xt9iSz8RwLM9kgIhlj/ci6a1ADS25rmHo2c9mltCAe3sI8eHfOSPnYbQ
         SAFa3nScRm8Jl0AEFJJPQjiv9ZKh003eEjbaF31uFVDadMbUE0j7qA3ORHXyff3Q8VXS
         TG41uncFCKz885hXyHkPJPnuCJ8h9nWZfUXkBOaEk7CQv1oIhfcCxSRHALu1P06Q57jp
         SnFkSD5Lo//1MYYzHpF4ubALqp9WtUny+n9E/mQPwbTwtH4/kEVhFMGfYFnfviOunZOc
         gyRG+69pobONgyDoRTsox8yR3/QlwkuSybzXBEdLzidMiAc4AjTz0Aeb8SOqQaPvEcKa
         gM0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=8yzjvNLbiW8OgI7swlRqINNEXnI/eh7321F05UrEMRM=;
        b=YcK/20Mswvp6hd1WlAs/u07ri4NbVCTSk9cO+GoJkJjiKnXYSDBRYR9T3SsZYNb9QX
         bfM0DrYE4tRRKVYOWoO5FdrGuHS6S0CA7CJILBWSVnwOgicKZuKJMojU34OYTMtu27T/
         BrosiBkkwcc1BqDfMJ7s+MSlXHDOecTfk6pF+ls6x50pv5ddk4N+okN3AytxVM3wtRw6
         50YyQNHfiHeI3euGLRC9KJVcXHa+SK+cTo1kTHu3AZVBTQ//xFDWYvPuvxRIlfJ6bxEj
         eMNHpvGosB31O9LcTid9inc5yUPkShVVZCPQ4y3kyJ6Wmr7emV4d1UIXrGVrKN1Q0Aky
         n6Aw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=U//lZxcH;
       spf=pass (google.com: domain of kernel-hardening-return-12459-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12459-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=U//lZxcH;
       spf=pass (google.com: domain of kernel-hardening-return-12459-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12459-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180312050623.GD8631@eros>
References: <1520830180-25452-1-git-send-email-me@tobin.cc>
 <20180312050204.GC25480@zzz.localdomain> <20180312050623.GD8631@eros>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 12 Mar 2018 10:57:08 +0100
Message-ID: <CAOi1vP-TrD9xp4ottwSUEx=h_-uLOYs5BuEMAgSJrK2gmdZoDg@mail.gmail.com>
Subject: Re: [PATCH] rbd: Remove VLA stack usage
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Eric Biggers <ebiggers3@gmail.com>, Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>,
	Ceph Development <ceph-devel@vger.kernel.org>, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com, Tycho Andersen <tycho@tycho.ws>,
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594706055475539474?=
X-GMAIL-MSGID: =?utf-8?q?1594736285483350834?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 6:06 AM, Tobin C. Harding <me@tobin.cc> wrote:
> On Sun, Mar 11, 2018 at 10:02:04PM -0700, Eric Biggers wrote:
>> On Mon, Mar 12, 2018 at 03:49:40PM +1100, Tobin C. Harding wrote:
>> > The kernel would like to have all stack VLA usage removed[1].
>>
>> Can you please stop writing this?  The Linux kernel isn't sentient; it doesn't
>> "like" anything.  You need to explain why *you* (and other people) believe these
>> changes should be made.
>
> No worries, will re-spin with better description.

I'd prefer a single patch covering both functions.

Also, as these are char arrays, use sizeof instead of ARRAY_SIZE.

Thanks,

                Ilya
