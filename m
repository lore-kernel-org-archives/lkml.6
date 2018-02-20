Return-Path: <kernel-hardening-return-11832-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225Gne8nehtVFcY1W6DVU4fkTj8CKgpATk+QEz9ckflpwY3t+ocGMuKGlq6oM1kjol+ydZQ3
ARC-Seal: i=1; a=rsa-sha256; t=1519147041; cv=none;
        d=google.com; s=arc-20160816;
        b=o0H4jbP4vdVhaGFQaTlDFmErsjoET0Gltq46CyxGxZT77vIhwfD2wmBkkn6TFDktur
         7qe3LYg0G7wZeAk/HrTa0X6Fy6SltihIBCZMxqhHsHmg+Mt2FVR0Pk0HOSSdFyS83cl9
         0QPq8VL02+7uPX+dMiiNRSqyJU6aOMoOnwu/b5K9Unt1h98nybZYINw2sakoKxoVO7Pi
         yL4azT+asQqwOrJil7CLevU7k1HbF+3gTRo78LqAxkr11h4K3tMJgR2BIDOEiqF2yvdq
         R+6xa8YJzOwm9QsZIvKF/tETEH3eeaWNr7uuqloYpCD4FbzF/7OttLGTSona4MUPcqT+
         WUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=peq29rO+lEudFRt58AETGTmOCzazMk2EzrAW3ppOj20=;
        b=l+TWeL9hzLmASOZ8qi7mTmkQ8nM00+X03wQ7ervbM25u6g8uyfE7o2Gg43QGvU0sGq
         siy/YAGA7+8UIahSl4TKATZm1be2TtVjFA3z+kjJhLIWtaGqNOjpOFGqYMyYFP5Q8DCZ
         mzWnmdBTF4hPYRCHeAfxG5xcOYS8WwR3XY90ch4IW6v3Za1HIwrQbxwhfNWY3/wj0kMd
         xdd/2lii9ZCuyhZQ8lMVWSFfzq03dR0UCdM1yRRtRUIh9owvKNErXswdZ4oKkDoDPjOT
         FLwSbvYQYpXhs2U7Y0tshaqeAmHptST99vXEFL7YPZZVHk9Ow9HdRcvOT1veWAZ3hcNH
         vPcw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11832-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11832-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11832-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11832-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [kernel-hardening] [PATCH 4/6] Protectable Memory
To: Laura Abbott <labbott@redhat.com>, Kees Cook <keescook@chromium.org>
CC: Boris Lukashev <blukashev@sempervictus.com>, Christopher Lameter
	<cl@linux.com>, Matthew Wilcox <willy@infradead.org>, Jann Horn
	<jannh@google.com>, Jerome Glisse <jglisse@redhat.com>, Michal Hocko
	<mhocko@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	linux-security-module <linux-security-module@vger.kernel.org>, Linux-MM
	<linux-mm@kvack.org>, kernel list <linux-kernel@vger.kernel.org>, "Kernel
 Hardening" <kernel-hardening@lists.openwall.com>
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
 <13a50f85-bbd8-5d78-915a-a29c4a9f0c32@redhat.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <7972cf4d-dfb2-6682-b1cb-e514a41196a6@huawei.com>
Date: Tue, 20 Feb 2018 19:16:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <13a50f85-bbd8-5d78-915a-a29c4a9f0c32@redhat.com>
Content-Type: text/plain; charset="gbk"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590497635371449856?=
X-GMAIL-MSGID: =?utf-8?q?1592941127670136391?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 13/02/18 20:10, Laura Abbott wrote:
> On 02/13/2018 07:20 AM, Igor Stoppa wrote:
>> Why alterations of page properties are not considered a risk and the physmap is?
>> And how would it be easier (i suppose) to attack the latter?
> 
> Alterations are certainly a risk but with the physmap the
> mapping is already there. Find the address and you have
> access vs. needing to actually modify the properties
> then do the access. I could also be complete off base
> on my threat model here so please correct me if I'm
> wrong.

It's difficult for me to comment on this without knowing *how* the
attack would be performed, in your model.

Ex: my expectation is that the attacked has R/W access to kernel data
and has knowledge of the location of static variables.

This is not just a guess, but a real-life scenario, found in attacks
that, among other things, are capable of disabling SELinux, to proceed
toward gaining full root capability.

At that point, I think that variables which are allocated dynamically,
in vmalloc address space, are harder to locate, because of the virtual
mapping and the randomness of the address chosen (this I have not
confirmed yet, but I suppose there is some randomness in picking the
address to assign to a certain allocation request to vmalloc, otherwise,
it could be added).

> I think your other summaries are good points though
> and should go in the cover letter.

Ok, I'm just afraid it risks becoming a lengthy dissertation :-)

--
igor
