Return-Path: <kernel-hardening-return-11558-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226Og8LmkWY1cMhAxb/xYAncV6ygFMxH6YzS2CCDADI2NR11ArCysfsLRwWrGlAw66pXlDFb
ARC-Seal: i=1; a=rsa-sha256; t=1517596781; cv=none;
        d=google.com; s=arc-20160816;
        b=lc0CqrYR8l5TjPDaMLc9VYVmYEIEVvVBAibywcUmTi/njVINDxgFHdqjVih/JHULQ4
         h9Df8E8AJE2l3aVZAJe45BYmdCAb9k26Q32W8v7USu+2EMnT0M3joBCsfKrdr7Gz8Ltr
         AFIcKbVaFuObZBtM8Z5UqdPEzU425jcGJoeMLKyjPVvOx92xil+GoRg1KfRh8xy6LuKh
         RwJNOquAponnLwwtUonHmoWlAYRKicVmVuKrGs3fJSlPCFA8Nht2uBXIGa4kHhpTjyWq
         m7YjZoU3GO3+4Fng5W1+IS/rdr0iYZpUjE8aydXy15x0TcbjZEHxxe9sbyj5tme9J1Hm
         Xyow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=qquVEt/AaaHjDBLBI+V8m9/sYTKXmJQ1PVXv++GJGfY=;
        b=FFSThLTJMduOK6vCou1nzRWhVlALMpTwI6yNOcaRv8mcC1Gi520C7pJIDvVqcd0E2M
         ot3Oh5HlhX/US/YAQmOsypxPBoptlQsnqHXVfIpaxUxnVK1AcCvWAJg0b/sdYv7OVMzE
         nff8bw90GfVtgRGFbnt8jKrGa6V37C1SRDVanU3JvonT2NF7KncxHoKF1YnuVrsTiE4U
         gzQR6PsqjkMwpO6r8bzAGhyNAB5PaVvOzRxTXJPjB0RKJ2J6+R53kP3hghP4MqDlAoY0
         1PPR6mkZqOo3cQe4MUjMjji+sQelIRFCIZ2RHIzy6ThRsdY+e5Womtw7dzHNYGx8NUEt
         uw+A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11558-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11558-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11558-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11558-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 2 Feb 2018 12:39:20 -0600 (CST)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Matthew Wilcox <willy@infradead.org>
cc: Jann Horn <jannh@google.com>, Igor Stoppa <igor.stoppa@huawei.com>,
    jglisse@redhat.com, Kees Cook <keescook@chromium.org>,
    Michal Hocko <mhocko@kernel.org>, Laura Abbott <labbott@redhat.com>,
    Christoph Hellwig <hch@infradead.org>,
    linux-security-module@vger.kernel.org, linux-mm@kvack.org,
    kernel list <linux-kernel@vger.kernel.org>,
    Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [kernel-hardening] [PATCH 4/6] Protectable Memory
In-Reply-To: <20180126053542.GA30189@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.20.1802021236510.31548@nuc-kabylake>
References: <20180124175631.22925-1-igor.stoppa@huawei.com> <20180124175631.22925-5-igor.stoppa@huawei.com> <CAG48ez0JRU8Nmn7jLBVoy6SMMrcj46R0_R30Lcyouc4R9igi-g@mail.gmail.com> <20180126053542.GA30189@bombadil.infradead.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfC6w0dLJQbIt5zYTb6CjF/WsneRPRKjVLjEPDTLV/VEr2cHFDWd1R8t8hgIrZOfg5QuFmiAcVtypl3J3YWYrleTz7SsX/YrEGnfMlqPrn52RbfLEePB6
 BetgN0aFbtfO22uHEQKhVrBIzzGxstj3K95GBJJ9etuFLQGpRKMWtGtcN5Me5vX1IU/KKNaEP53vWOg0MQH5H//gsDb6I8PbvYdXu3ZEC9tTJQf8FlJhabcQ
 hG0YIq+IdMn/8IZOxO5JvVfTkR2fdUFy3J5VJGwfoz7yO9c8qGqjmT+aPzzrQMIwUoWQ4HJSgWY7TfupwpIJUJhhNaE19+LrojYW6RmxUeqZjhAaktWl1aE5
 0ytmuXmDdjOuz+IvYVZcZGGd43sHxXxs/gFWFbIpTYwRTIiAQucw7abLH06WrjuCDLYoTAGJG3Cmd8/BMJc8yEsV+NBbNA4HckbCxNEJ1czSeDapYJNoR7nW
 CPoKCxbuYqU4tub3c4ef52C5F1VHXD/265uiNv51yKWFqwr5ROGwK8DLVxY7rabSfiKADhgM++LLpUN5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590497635371449856?=
X-GMAIL-MSGID: =?utf-8?q?1591315562486264119?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 25 Jan 2018, Matthew Wilcox wrote:

> It's worth having a discussion about whether we want the pmalloc API
> or whether we want a slab-based API.  We can have a separate discussion
> about an API to remove pages from the physmap.

We could even do this in a more thorough way. Can we use a ring 1 / 2
distinction to create a hardened OS core that policies the rest of
the ever expanding kernel with all its modules and this and that feature?

I think that will long term be a better approach and allow more than the
current hardening approaches can get you. It seems that we are willing to
tolerate significant performance regressions now. So lets use the
protection mechanisms that the hardware offers.
