Return-Path: <kernel-hardening-return-11589-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226ccS5avPlqx4AR2P3H4Y6UpwQPNR69NDLZzP4gKi87wbh+2KXW/BQfhPfyWr78xNjNzY9K
ARC-Seal: i=1; a=rsa-sha256; t=1517845226; cv=none;
        d=google.com; s=arc-20160816;
        b=XHfR7CJJ0aYY2H16GUo2VvgASKMyR8e5pBZksSpE0l19MDtWstI9FZDHbXZkxbvLUw
         smA9KmWfotsB4cGNPGQTZn+iX6UkuA2DpgBG0IYFgkipMuXk23djP2umbbgkbhCRTt/p
         S0rflONO60bF5FzHEqxZ7UlMX/eOvNOS9Uu1pp5fpO6PU5kiSTX4kPLl41zFEa6Wylja
         EkMF4/hByru3ptRl/bb2Cu/nRjWZkFE4BZCcoyxFv4mtoXERB1JJWsgFTBVRspOWlkrd
         lITjU5W3xYUdcVLbsaJaCAHSBkK2tN0T6Otxse4NsyvDj9ZEaQKEScPF3WaWLy2B6MQq
         K8rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=IzN8ktAM/vEp+lB+VbU6GbAjZMh2oZm5qoY2RtDWm7o=;
        b=ULMjzXn4tvPdLI1Xm84DlPXdNwsIPtc0tU7i8oy85jKbumX8PlrXNz3x7ivvsh3KeC
         AkAGU0rPFHO7p5UaiDgTTP6h4UtCOTibQQj5SrKMHNKlqmfpVw9/aA3ey5y6ys3P5/WR
         Zy7Oi3atUrDSEyYkUxP8/152bQ/N2aZu6IiO06jt8tpSAQ2N6UCs9HVcnAQDJ+sicyQn
         9hc9GpvU0HhB3mLj0ok3dOeBimgVemCJmx1gmDZojsqz0Vx2cLtLywDiGvLcx12alAfw
         ofJRuBnbQ489qkMF8i44TYmUEbmrKlbUNHBqBfSweGbboVUgwMG+cJq4rfJPICpI8N8V
         T2Sg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11589-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11589-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11589-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11589-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 5 Feb 2018 09:40:04 -0600 (CST)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Igor Stoppa <igor.stoppa@huawei.com>
cc: Matthew Wilcox <willy@infradead.org>,
    Boris Lukashev <blukashev@sempervictus.com>, Jann Horn <jannh@google.com>,
    jglisse@redhat.com, Kees Cook <keescook@chromium.org>,
    Michal Hocko <mhocko@kernel.org>, Laura Abbott <labbott@redhat.com>,
    Christoph Hellwig <hch@infradead.org>,
    linux-security-module@vger.kernel.org, linux-mm@kvack.org,
    kernel list <linux-kernel@vger.kernel.org>,
    Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [kernel-hardening] [PATCH 4/6] Protectable Memory
In-Reply-To: <f2ddaed0-313e-8664-8a26-9d10b66ed0c5@huawei.com>
Message-ID: <alpine.DEB.2.20.1802050935300.10705@nuc-kabylake>
References: <20180124175631.22925-1-igor.stoppa@huawei.com> <20180124175631.22925-5-igor.stoppa@huawei.com> <CAG48ez0JRU8Nmn7jLBVoy6SMMrcj46R0_R30Lcyouc4R9igi-g@mail.gmail.com> <20180126053542.GA30189@bombadil.infradead.org> <alpine.DEB.2.20.1802021236510.31548@nuc-kabylake>
 <f2ddaed0-313e-8664-8a26-9d10b66ed0c5@huawei.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfOuDenMWjvRTdB3OucW8B35Hwl+YpqUNNKozVBgi8IOqxnfGik3gQ0feLbH3YoTTPc60hubgIWujyEa+Pxa6piPEFNMlsAGjgKjHl8Bu5j5XHl9CkYqX
 1SRuxXs5U3rNXqJlAzD8xd6HnQfCqRKGI1AGHjeif+xTIcp20zMxwn1Js47PInZBsK38vq/TIxN+T5FG88kW8Q7Ux0LvAFqWVS1QYRdTG3+hS+HJW43AVp4h
 buarqIXfoC4AB8kqvFH0gecNh2yiLiPFFAA418eI7reHTasf2O361A07cymjS1sBRXWP2xCV+MFItFPbP67cEvf1dJteNVOWmqL3naHcfSIvNIIXtBkWOf9k
 gkSj0gXI1BpHBI8uDE1YKR1Ktam2cAL792Z7ObCCdBlPNqdjDnZZHIL5tVplPhRtC1CHIBxbBzbo1E6QxDYF+Gdr8QBxNAaOewid7+RkqrA3HJW5k3oPjePL
 +xScujzgyY3pir1ZB8/pyC9ZsCHRqfxIJJHJeay6ILhprZ3diWmFYRZiSfOvmxbnO86Brb7o+1gKqRo0jnGt9o3Cz+Acrs5v1zw0CA0p4aNw/+P6BAQjLwv7
 mPg=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590497635371449856?=
X-GMAIL-MSGID: =?utf-8?q?1591576076579816152?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 3 Feb 2018, Igor Stoppa wrote:

> > We could even do this in a more thorough way. Can we use a ring 1 / 2
> > distinction to create a hardened OS core that policies the rest of
> > the ever expanding kernel with all its modules and this and that feature?
>
> What would be the differentiating criteria? Furthermore, what are the
> chances
> of invalidating the entire concept, because there is already an
> hypervisor using
> the higher level features?
> That is what you are proposing, if I understand correctly.

Were there not 4 rings as well as methods by the processor vendors to
virtualize them as well?

> > I think that will long term be a better approach and allow more than the
> > current hardening approaches can get you. It seems that we are willing to
> > tolerate significant performance regressions now. So lets use the
> > protection mechanisms that the hardware offers.
>
> I would rather *not* propose significant performance regression :-P

But we already have implemented significant kernel hardening which causes
performance regressions. Using hardware capabilities allows the processor
vendor to further optimize these mechanisms whereas the software
preventative measures are eating up more and more performance as the pile
them on. Plus these are methods that can be worked around. Restrictions
implemented in a higher ring can be enforced and are much better than
just "hardening" (which is making life difficult for the hackers and
throwing away performannce for the average user).
