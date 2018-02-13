Return-Path: <kernel-hardening-return-11749-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225pG6X/j6B25jFdKlkqqW2xKWz/WSJdYWRLcRns9G/Sa864GXKpevcLLt5Obog6pXpETsB0
ARC-Seal: i=1; a=rsa-sha256; t=1518545435; cv=none;
        d=google.com; s=arc-20160816;
        b=qpj/zH6+iBs3KTaGVB5rgOgaxP1mENM0UEMm1VBnmfh+3fP0PF9UPdDTWkfnNneTbL
         dyaeLwhYZOW1Pwk66eI07BYCeonOY36LgqaNJPmBz/xpaglRn0gla9RbpNR8tyNFDI6j
         AAEuGns0jlx2O4eEIekzOAefWAohI8Pnt9Btgv/L6l8N6tSX5niMfSCW3UNbj9ixR88L
         b/2vHGon1MppxJL8C1zuYltqQiPw8h03RRSuJ/J/sG9aljbsOw64GC9KxGKBrS316wDf
         YMsZNYEG9Yq19W5ePml1JI33gRiR+S3VDI36bZWCzR3qan7ZUxxrw01Y5c2hKzMKdINj
         upQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=1bNsNkFJa7v7t9BQAdRMgdl1W7HmzNK27j/L0OjIw14=;
        b=GiHiMKu8BZKBDXBW3r0szynAkcO/gjms4VuBfoOW/4wlGjfL1g07EFYNL2pxUAKfuG
         0GJYVNi0pcXmARvn7IKI43yM1Wl6KfxdXs3j58wXtQ6wcTFPfEYpR89AjXuZ6GmarOQQ
         1hKfCjsjvw1A5GgrJ0dOtxy8M9XeRVqU7PPJGn9xuptNAYf6jYXJNS2t+oz9evef7Vbm
         GlTCzyfa9SqJZ6nOJNfR+/JuSo8nuK/TXCkJxxKAmgrVNgXhLpFturFfkaIpk9SuZg8p
         d5ZVQ4e7MbdcCeJSsF6ew182BXPU4tOODGwppvEvzFUirTNs5sO0O782qoMcuDVOlRZg
         ACQA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11749-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11749-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11749-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11749-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [kernel-hardening] [PATCH 4/6] Protectable Memory
To: Igor Stoppa <igor.stoppa@huawei.com>, Kees Cook <keescook@chromium.org>
Cc: Boris Lukashev <blukashev@sempervictus.com>,
 Christopher Lameter <cl@linux.com>, Matthew Wilcox <willy@infradead.org>,
 Jann Horn <jannh@google.com>, Jerome Glisse <jglisse@redhat.com>,
 Michal Hocko <mhocko@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>, kernel list <linux-kernel@vger.kernel.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>
References: <20180124175631.22925-1-igor.stoppa@huawei.com>
 <20180124175631.22925-5-igor.stoppa@huawei.com>
 <CAG48ez0JRU8Nmn7jLBVoy6SMMrcj46R0_R30Lcyouc4R9igi-g@mail.gmail.com>
 <20180126053542.GA30189@bombadil.infradead.org>
 <alpine.DEB.2.20.1802021236510.31548@nuc-kabylake>
 <f2ddaed0-313e-8664-8a26-9d10b66ed0c5@huawei.com>
 <b75b5903-0177-8ad9-5c2b-fc63438fb5f2@huawei.com>
 <CAFUG7CfrCpcbwgf5ixMC5EZZgiVVVp1NXhDHK1UoJJcC08R2qQ@mail.gmail.com>
 <8818bfd4-dd9f-f279-0432-69b59531bd41@huawei.com>
 <CAFUG7CeUhFcvA82uZ2ZH1j_6PM=aBo4XmYDN85pf8G0gPU44dg@mail.gmail.com>
 <17e5b515-84c8-dca2-1695-cdf819834ea2@huawei.com>
 <CAGXu5j+LS1pgOOroi7Yxp2nh=DwtTnU3p-NZa6bQu_wkvvVkwg@mail.gmail.com>
 <414027d3-dd73-cf11-dc2a-e8c124591646@redhat.com>
 <5a83024c.64369d0a.a1e94.cdd6SMTPIN_ADDED_BROKEN@mx.google.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <13a50f85-bbd8-5d78-915a-a29c4a9f0c32@redhat.com>
Date: Tue, 13 Feb 2018 10:10:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <5a83024c.64369d0a.a1e94.cdd6SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590497635371449856?=
X-GMAIL-MSGID: =?utf-8?q?1592310298728828395?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/13/2018 07:20 AM, Igor Stoppa wrote:
> Why alterations of page properties are not considered a risk and the physmap is?
> And how would it be easier (i suppose) to attack the latter?

Alterations are certainly a risk but with the physmap the
mapping is already there. Find the address and you have
access vs. needing to actually modify the properties
then do the access. I could also be complete off base
on my threat model here so please correct me if I'm
wrong.

I think your other summaries are good points though
and should go in the cover letter.

Thanks,
Laura
