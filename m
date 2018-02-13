Return-Path: <kernel-hardening-return-11739-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226+cmsIc4ReB2fpCKop5DM0o/WPkX/bxCWMQEIrf1BK0ftb8WsR3lZuT5B8KhxqVY/LK4vx
ARC-Seal: i=1; a=rsa-sha256; t=1518482464; cv=none;
        d=google.com; s=arc-20160816;
        b=nHSqfny4F5JxnBbqgFcIoMwm0YAvZ7mhdm1P0DbCwWPGpc3m9y7etGSksamtKbzOcA
         8h1+NaJm5Y2bTdltyGaVmRi7HlrS47ohtlrxcoZsE4/YFRYex16kokdesEuLBC9niDWF
         iZNrpmZfFNKNsyq7+mky3taR3pvCJsDXElurRDzhzI7A16OyHMFBtXOSKDG2qcDl+92w
         YX8W6ycJtv7txpE5o4unJjxJSr6gb6zSk5oYZxfXz3mwdpEIiiT9gig6XTbm3vap1WML
         7W4K24rm09dZ2ZQVvijnHVTwURpizeJXvIc4Gohi7DsXVjfX7SLCOkdeRa5o2gPxoTIu
         aIcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=Ru3pkGVKqmWMsL9s1P38nF9SelU4RWhwjsnI0yuJRsI=;
        b=oIke9vudVkGBsUB1iJ4bx7HaBj7ZzSegSBTQbCqDHTKGess+Yvsm3r/ei+nm38IRbX
         j85aeDUWuBrxC5k6KYX5TeZg1oa9xVt5oOmnGeNaZKYa11Ci0HHtcjE7TWFbK3JqwTij
         m8nrBsboz1ShHG96IQ3H+5hR+F8Fqo/cCCeS5WYlDH2t+L7u1LeVlwcgBnFlYBFgP3YE
         KhbwuwVwU/59aRbLDsqMbfIIjCRyush9JJV2k5JsJA7tHi3jk7s3ZbWWnXdvSQh+Ahc2
         XBJHLYlmDJnd3rSQ4Fmk/VT94kIBvg+9YDKkvMPQmN8nruLtP6/1rf9mFtb3J65ugcZM
         amcw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11739-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11739-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11739-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11739-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [kernel-hardening] [PATCH 4/6] Protectable Memory
To: Kees Cook <keescook@chromium.org>, Igor Stoppa <igor.stoppa@huawei.com>
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
From: Laura Abbott <labbott@redhat.com>
Message-ID: <414027d3-dd73-cf11-dc2a-e8c124591646@redhat.com>
Date: Mon, 12 Feb 2018 16:40:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+LS1pgOOroi7Yxp2nh=DwtTnU3p-NZa6bQu_wkvvVkwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590497635371449856?=
X-GMAIL-MSGID: =?utf-8?q?1592244268029169993?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/12/2018 03:27 PM, Kees Cook wrote:
> On Sun, Feb 4, 2018 at 7:05 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>> On 04/02/18 00:29, Boris Lukashev wrote:
>>> On Sat, Feb 3, 2018 at 3:32 PM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>>
>> [...]
>>
>>>> What you are suggesting, if I have understood it correctly, is that,
>>>> when the pool is protected, the addresses already given out, will become
>>>> traps that get resolved through a lookup table that is built based on
>>>> the content of each allocation.
>>>>
>>>> That seems to generate a lot of overhead, not to mention the fact that
>>>> it might not play very well with the MMU.
>>>
>>> That is effectively what i'm suggesting - as a form of protection for
>>> consumers against direct reads of data which may have been corrupted
>>> by some irrelevant means. In the context of pmalloc, it would probably
>>> be a separate type of ro+verified pool
>> ok, that seems more like an extension though.
>>
>> ATM I am having problems gaining traction to get even the basic merged :-)
>>
>> I would consider this as a possibility for future work, unless it is
>> said that it's necessary for pmalloc to be accepted ...
> 
> I would agree: let's get basic functionality in first. Both
> verification and the physmap part can be done separately, IMO.

Skipping over physmap leaves a pretty big area of exposure that could
be difficult to solve later. I appreciate this might block basic
functionality but I don't think we should just gloss over it without
at least some idea of what we would do.

Thanks,
Laura
