Return-Path: <kernel-hardening-return-11871-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x2247WoCd3PjhMqs5oSHVINZ0ylMDh4rF/Lo3ReuBY6DdaYSwLCBtQwCTyxnZhcCkoD4+eqRk
ARC-Seal: i=1; a=rsa-sha256; t=1519252650; cv=none;
        d=google.com; s=arc-20160816;
        b=SYvrLm9poskDduSrBTltOtLlOEuxEEjcJL6bjfNJ3Rq9fZOOPWCjxTrB5B0pbKyWvf
         ylFeslMJucLJPUVhp0TD9LzyPLHWQMf9Fiv2RdF+JJGgnxeLy+EbuMBFXBl5mAWQrjrw
         GeXCcEHTjyGWaJ/P0xH7lrl2jmjN5W9YGAC6HWSAhZ/Vc1Zjzb1wf4EI8aLSvOZtPI+4
         RyFfh+OO6grWgnj+cEOREis3aSM7KohIT77ienpnMcqSQ3DguN9JqdVoUwoXffQBaSIM
         qYFU0CMpxHcxbIYCvXUdL8nFI8BLhxldNXiZpdrDdaNTUpcy04DOQzl/RcwRlp2PU5AA
         Ec6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=ZRMqBX3R5K5P4L+obH4NCwmgDzJqD8ae3Vb9sTIKdkE=;
        b=hMu7mHY9sgR9NXGDX03m1YZExpHPL+7RluVKsh7VyhpTacJihLm9GZYaaseQN3DAOA
         leNy27FIj99c7bA8Kr8GaH805XWloalf9idjlPXZwohCtb+/kuy3cZd1FpT+l4HRkQ1S
         Zn1xhKIIBlvmIRPYFH+Y+NuZewEniLnNfHtGR3/F57CQxvAloDPMmO7Zmy4EqLWlI/gq
         2EgPk0803KuDGArpzCIH6yhLnNP6nNfsBTZ6+aMVlUqrQYwQr7NhdTFM8hQR7rI3gMhV
         nN0pSpZ1Jm1SNbG1kGtVNREpB1pbLDY69BkcmaAb4Mw0ZCKYWMyuA2LlQvZjAhpajMIt
         aF7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=iVePh5P7;
       dkim=pass header.i=@chromium.org header.s=google header.b=iksHW2/0;
       spf=pass (google.com: domain of kernel-hardening-return-11871-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11871-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=iVePh5P7;
       dkim=pass header.i=@chromium.org header.s=google header.b=iksHW2/0;
       spf=pass (google.com: domain of kernel-hardening-return-11871-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11871-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <7972cf4d-dfb2-6682-b1cb-e514a41196a6@huawei.com>
References: <20180124175631.22925-1-igor.stoppa@huawei.com>
 <20180124175631.22925-5-igor.stoppa@huawei.com> <CAG48ez0JRU8Nmn7jLBVoy6SMMrcj46R0_R30Lcyouc4R9igi-g@mail.gmail.com>
 <20180126053542.GA30189@bombadil.infradead.org> <alpine.DEB.2.20.1802021236510.31548@nuc-kabylake>
 <f2ddaed0-313e-8664-8a26-9d10b66ed0c5@huawei.com> <b75b5903-0177-8ad9-5c2b-fc63438fb5f2@huawei.com>
 <CAFUG7CfrCpcbwgf5ixMC5EZZgiVVVp1NXhDHK1UoJJcC08R2qQ@mail.gmail.com>
 <8818bfd4-dd9f-f279-0432-69b59531bd41@huawei.com> <CAFUG7CeUhFcvA82uZ2ZH1j_6PM=aBo4XmYDN85pf8G0gPU44dg@mail.gmail.com>
 <17e5b515-84c8-dca2-1695-cdf819834ea2@huawei.com> <CAGXu5j+LS1pgOOroi7Yxp2nh=DwtTnU3p-NZa6bQu_wkvvVkwg@mail.gmail.com>
 <414027d3-dd73-cf11-dc2a-e8c124591646@redhat.com> <5a83024c.64369d0a.a1e94.cdd6SMTPIN_ADDED_BROKEN@mx.google.com>
 <13a50f85-bbd8-5d78-915a-a29c4a9f0c32@redhat.com> <7972cf4d-dfb2-6682-b1cb-e514a41196a6@huawei.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 21 Feb 2018 14:37:11 -0800
X-Google-Sender-Auth: KGbeCWaf393KOHWkinLMJjlfvH4
Message-ID: <CAGXu5j+9yKyUG-4YqK5Vo4kvV7P3vNAr_B4XkXuoishGEyY_Ag@mail.gmail.com>
Subject: Re: [kernel-hardening] [PATCH 4/6] Protectable Memory
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Laura Abbott <labbott@redhat.com>, Boris Lukashev <blukashev@sempervictus.com>,
	Christopher Lameter <cl@linux.com>, Matthew Wilcox <willy@infradead.org>, Jann Horn <jannh@google.com>,
	Jerome Glisse <jglisse@redhat.com>, Michal Hocko <mhocko@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-security-module <linux-security-module@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
	kernel list <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590497635371449856?=
X-GMAIL-MSGID: =?utf-8?q?1593051867647989887?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 9:16 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>
>
> On 13/02/18 20:10, Laura Abbott wrote:
>> On 02/13/2018 07:20 AM, Igor Stoppa wrote:
>>> Why alterations of page properties are not considered a risk and the physmap is?
>>> And how would it be easier (i suppose) to attack the latter?
>>
>> Alterations are certainly a risk but with the physmap the
>> mapping is already there. Find the address and you have
>> access vs. needing to actually modify the properties
>> then do the access. I could also be complete off base
>> on my threat model here so please correct me if I'm
>> wrong.
>
> It's difficult for me to comment on this without knowing *how* the
> attack would be performed, in your model.
>
> Ex: my expectation is that the attacked has R/W access to kernel data
> and has knowledge of the location of static variables.
>
> This is not just a guess, but a real-life scenario, found in attacks
> that, among other things, are capable of disabling SELinux, to proceed
> toward gaining full root capability.
>
> At that point, I think that variables which are allocated dynamically,
> in vmalloc address space, are harder to locate, because of the virtual
> mapping and the randomness of the address chosen (this I have not
> confirmed yet, but I suppose there is some randomness in picking the
> address to assign to a certain allocation request to vmalloc, otherwise,
> it could be added).

Machine-to-machine runtime variation certainly affects the mapping
location, but for early boot allocations, these become surprisingly
deterministic, especially across similar hardware/memory layouts (both
the virtmap and physmap locations). However, using
CONFIG_RANDOMIZE_MEMORY makes it MUCH more difficult. (Note that
RANDOMIZE_BASE on arm64 effectively includes RANDOMIZE_MEMORY, as it
uses the entropy for multiple base offsets, including the physmap,
IIRC.)

>> I think your other summaries are good points though
>> and should go in the cover letter.
>
> Ok, I'm just afraid it risks becoming a lengthy dissertation :-)

It's rare to have anyone say "your commit log is too long". :)

-Kees

-- 
Kees Cook
Pixel Security
