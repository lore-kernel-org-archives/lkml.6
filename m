Return-Path: <kernel-hardening-return-11568-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225unF/jyn5RJ2M0dLmisGb8wea+M0LK0hXi/Lfey8Y+PvaBW+cjVPLiKHYNU61wRthrV4W1
ARC-Seal: i=1; a=rsa-sha256; t=1517688760; cv=none;
        d=google.com; s=arc-20160816;
        b=u6uET6xJCYKwVCeTmJ8JfZAe00/H4KfeF2/BTS0B+KupBJivtPuVcUtKYvhRyveJVa
         1Ggy1yPHl+t1wk1EnO3uY5WMqlaso5lqex5bhicRjIYqdR1LorbCzIEHepLe2qzLHFpg
         e4mSV9AsUSGiUeG5DBigi6uAgBH7AQj2PJdXSeofqyQttGF95S1+xDUizYAXaN1Cbl2V
         KnnMN03ujStKNoBKKW2BuWxKeb39oGay6LVSXb/w1X6aAyWiQ3gklwLVNKahBwxXxdjW
         BJzvECMjTPJA4YPHfUeVE8TeEUfAkPVBb+Lm47VXhyWtkFkf2qQdZ/ld5oIE6b1AzVKZ
         wm0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=9mb3tdu9ZGh0R7T5nHZshl5Tv3ni5T+voO1FmPyxoSU=;
        b=hjRGsUh09Jzg+6uklwUGybToW4rkuivvH4q4YEt4XHlT2ELW765y58pKgAfj51Dqly
         x4sXdlTHbsVRlxae4chalT3MAT95anR5cUngHyl6QVItYcpo6yfz+Q6vpK7HeemAfYre
         wlD+FHt/uxjj/F7EjuDj3OU1loz5vPbqed5eU4hEooZT7Kr6VTltGGKhgOuiKSZTrLdG
         OTghAjAGFZq93DS7tSlydkbs2z7aQnGIggayxSSjPyufuDu2pD4x3RbEcn1zQCMTVekt
         FwiFplQZ/1W0tJ0MlRImnyWtfSm/Or6CPjtUBLu21/xYxpHYRWO2GJ/WoGJXyf39xvIZ
         lk3A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sempervictus-com.20150623.gappssmtp.com header.s=20150623 header.b=GhGsQuKV;
       spf=pass (google.com: domain of kernel-hardening-return-11568-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11568-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sempervictus-com.20150623.gappssmtp.com header.s=20150623 header.b=GhGsQuKV;
       spf=pass (google.com: domain of kernel-hardening-return-11568-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11568-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
X-Originating-IP: [72.70.61.204]
In-Reply-To: <b75b5903-0177-8ad9-5c2b-fc63438fb5f2@huawei.com>
References: <20180124175631.22925-1-igor.stoppa@huawei.com>
 <20180124175631.22925-5-igor.stoppa@huawei.com> <CAG48ez0JRU8Nmn7jLBVoy6SMMrcj46R0_R30Lcyouc4R9igi-g@mail.gmail.com>
 <20180126053542.GA30189@bombadil.infradead.org> <alpine.DEB.2.20.1802021236510.31548@nuc-kabylake>
 <f2ddaed0-313e-8664-8a26-9d10b66ed0c5@huawei.com> <b75b5903-0177-8ad9-5c2b-fc63438fb5f2@huawei.com>
From: Boris Lukashev <blukashev@sempervictus.com>
Date: Sat, 3 Feb 2018 15:12:20 -0500
Message-ID: <CAFUG7CfrCpcbwgf5ixMC5EZZgiVVVp1NXhDHK1UoJJcC08R2qQ@mail.gmail.com>
Subject: Re: [kernel-hardening] [PATCH 4/6] Protectable Memory
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Christopher Lameter <cl@linux.com>, Matthew Wilcox <willy@infradead.org>, Jann Horn <jannh@google.com>,
	Jerome Glisse <jglisse@redhat.com>, Kees Cook <keescook@chromium.org>,
	Michal Hocko <mhocko@kernel.org>, Laura Abbott <labbott@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	linux-security-module <linux-security-module@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
	kernel list <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590497635371449856?=
X-GMAIL-MSGID: =?utf-8?q?1591412009297729595?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 3, 2018 at 2:57 PM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>>> On Thu, 25 Jan 2018, Matthew Wilcox wrote:
>
>>>> It's worth having a discussion about whether we want the pmalloc API
>>>> or whether we want a slab-based API.
> I'd love to have some feedback specifically about the API.
>
> I have also some idea about userspace and how to extend the pmalloc
> concept to it:
>
> http://www.openwall.com/lists/kernel-hardening/2018/01/30/20
>
> I'll be AFK intermittently for about 2 weeks, so i might not be able to
> reply immediately, but from my perspective this would be just the
> beginning of a broader hardening of both kernel and userspace that I'd
> like to pursue.
>
> --
> igor

Regarding the notion of validated protected memory, is there a method
by which the resulting checksum could be used in a lookup
table/function to resolve the location of the protected data?
Effectively a hash table of protected allocations, with a benefit of
dedup since any data matching the same key would be the same data
(multiple identical cred structs being pushed around). Should leave
the resolver address/csum in recent memory to check against, right?

-- 
Boris Lukashev
Systems Architect
Semper Victus
