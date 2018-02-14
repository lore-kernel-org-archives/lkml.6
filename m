Return-Path: <kernel-hardening-return-11757-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x2247+WFvpGYw3b69353gj4zVPLqfDx9j/wiSWhf9uRHYd8BgX6wDuZhPPluKqIKpurC5oQgN
ARC-Seal: i=1; a=rsa-sha256; t=1518635188; cv=none;
        d=google.com; s=arc-20160816;
        b=d0Ngx1qco/QOTWTZTEtJzP4OSre+6NSvulbRiHoFIrEzM+GpB20gF8hlFCWIg4y96Z
         RzZI/jRBgd/Dy2HURDLF7sIoMsOgZc0BpVzAWUNDKr/lrZ2tPtW+whB3qkO8SrMPFaEh
         7aLr64RgfmCTWKHeikWgHHq2QiRmR73wI0DTtsvPrutTNpXJs1uWqZ/qqldG5G8ggGmp
         qQIgyEJnytvaIzI7CNZpCcs1o7/PMFoorXy924Ll0eZadoFVKZxMsxX9lfDz63yENSDK
         CF/vpFAyAISsCGD2EQDV80iPlxvSDIbOI9GIWB4MGmoUgZ9LeQa0/wrr85og1J87wFnc
         O/3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=93Q1VlZoqaYmYkLqdTvgbtufpo3VARs2s4WLpe0DBHY=;
        b=LJ8rcfJfTmC5svmkUct+EqwP6tAXBQx10HJjCdQRkvZUt6lEVse92qYV5324Xk4rtc
         ZEveh9WlWqgRLl6Ov/ZYkz43joPBGYush6xagIMj29uruM7iHpuoJWEYEHKDAmN2AMmJ
         w97KrBNFObHXsqrKSj4QjHcorW0NeNzjddJCr43g380xPuGfXIIlInS3ycxpirepUsse
         XaprdL7H7bmGgSzpGorYpHgA+qhrGrS7hd3vriVeJhKFuTrnirbM+6Al9NbK3rt9hnSL
         d6UhmJ5QIANA2ToZT2r20bBwxlWD9dkSXgqyaqTLbsUL1p08S6qcQh/YDDoJ6dZNQbdS
         1O8g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11757-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11757-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11757-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11757-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: arm64 physmap (was Re: [kernel-hardening] [PATCH 4/6] Protectable
 Memory)
To: Kees Cook <keescook@chromium.org>
Cc: Jann Horn <jannh@google.com>, Igor Stoppa <igor.stoppa@huawei.com>,
 Boris Lukashev <blukashev@sempervictus.com>,
 Christopher Lameter <cl@linux.com>, Matthew Wilcox <willy@infradead.org>,
 Jerome Glisse <jglisse@redhat.com>, Michal Hocko <mhocko@kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 linux-security-module <linux-security-module@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>, kernel list <linux-kernel@vger.kernel.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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
 <CAGXu5j++igQD4tMh0J8nZ9jNji5mU16C7OygFJ5Td+Bq-KSMgw@mail.gmail.com>
 <CAG48ez1utN_vwHUwk=BU6zM4Wa_53TPu8rm9JuTtY-vGP0Shqw@mail.gmail.com>
 <f4226a44-92fd-8ead-b458-7551ba82f96d@redhat.com>
 <CAGXu5j+zOCLerneUt2b-tvyLLg7fEbr9B0YYow-4DH6oV-nnCw@mail.gmail.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <2f23544a-bd24-1e71-967b-e8d1cf5a20a3@redhat.com>
Date: Wed, 14 Feb 2018 11:06:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+zOCLerneUt2b-tvyLLg7fEbr9B0YYow-4DH6oV-nnCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592404410626838547?=
X-GMAIL-MSGID: =?utf-8?q?1592404410626838547?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/13/2018 01:43 PM, Kees Cook wrote:
> On Tue, Feb 13, 2018 at 8:09 AM, Laura Abbott <labbott@redhat.com> wrote:
>> No, arm64 doesn't fixup the aliases, mostly because arm64 uses larger
>> page sizes which can't be broken down at runtime. CONFIG_PAGE_POISONING
>> does use 4K pages which could be adjusted at runtime. So yes, you are
>> right we would have physmap exposure on arm64 as well.
> 
> Errr, so that means even modules and kernel code are writable via the
> arm64 physmap? That seems extraordinarily bad. :(
> 
> -Kees
> 

(adding linux-arm-kernel and changing the subject)

Kernel code should be fine, if it isn't that is a bug that should be
fixed. Modules yes are not fully protected. The conclusion from past
experience has been that we cannot safely break down larger page sizes
at runtime like x86 does. We could theoretically
add support for fixing up the alias if PAGE_POISONING is enabled but
I don't know who would actually use that in production. Performance
is very poor at that point.

Thanks,
Laura
