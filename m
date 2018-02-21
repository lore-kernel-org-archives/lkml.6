Return-Path: <kernel-hardening-return-11869-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226YRTmH2lzzVX3OcJ6ZycobRMho06+AKfeVdoKl4E8T1FCvP600eDTTjW+DHtxAI/mDsuOc
ARC-Seal: i=1; a=rsa-sha256; t=1519252164; cv=none;
        d=google.com; s=arc-20160816;
        b=VUt5zJfRohr01FEWxUp5O5tjmX9a5+ZSTnhPyBQd+lv+QyZ7VqfIhsGNJ+5KXOLgvH
         LI9+EiwA0UUtwbZ0Nv8P2jdQwAEjbCeBYKbxYgtdZqc0l9K86+HEOUTrbeYCNkLOulfN
         taYMDm+O9lyXQkcWkQmkKjT11VE7ItMQbHDNwMr1LGub3mMaiqU2yH53k+CZVQftFJJx
         NC8vbJvVXjWA7Ztal3A/9j2FZ6FJoNduL5T4OOwROzXxB2aMke0r7+yp9iFUrl8WMGaC
         hHvQTHbwPeUs3tzMUg7dSW3iasmVZZdTVCdHUDagVkiLJEc6yxVzebN7C2/7MHj5CQTq
         B6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=C0fcIHCjttbewRrhkePkkrffDfGHv9EnXtnJ/NVIYN8=;
        b=E724zdhe5fuhmrz4fmGxU0nS7GHOidNwqrwI/XD53LKnBw6Uk5mbsYrR2zCLsnqy6h
         b/23Ut9w5KKU3d1D+bu42EU51GOwnKlyz+KaSMBXxTTTWQGyCTVoJRhA7IEPfrhIsoYZ
         cvwoG3fOyaJu/NVOKOOqfGRDHxaTsJpFuqxj3oxAcxOz7VWcYtu7iru8ZPCpPtitqabb
         utHfcE88sQLtyGJldGJwfH4rUUNZMN4tvv1JfC47rda1pW0uEQ+tgbg4FBXmseTDulvv
         QMn7fV7kAsEzLY7y3D2ZyGVLkHJ4O5hnuJ3ORtGETR6mh1oFjHMHBRrWig9mE4SH9NW4
         I6nw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=r1rBjOG+;
       dkim=pass header.i=@chromium.org header.s=google header.b=lWulQZV1;
       spf=pass (google.com: domain of kernel-hardening-return-11869-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11869-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=r1rBjOG+;
       dkim=pass header.i=@chromium.org header.s=google header.b=lWulQZV1;
       spf=pass (google.com: domain of kernel-hardening-return-11869-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11869-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <daaee36a-e6c7-8fbf-b758-ecee5106da9a@huawei.com>
References: <20180212165301.17933-1-igor.stoppa@huawei.com>
 <20180212165301.17933-2-igor.stoppa@huawei.com> <CAGXu5jJWLdsBr-6mXiFQprT-=h2qhhXAWRLQ+EaKKiubKOQOfw@mail.gmail.com>
 <daaee36a-e6c7-8fbf-b758-ecee5106da9a@huawei.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 21 Feb 2018 14:29:06 -0800
X-Google-Sender-Auth: s9RFmPJ9v-TMiJ77DXayPUeP2CQ
Message-ID: <CAGXu5j+zRQfxRXoSC5G8EjeSkPkpeMxfedJbHEgFyYcyXWmW9w@mail.gmail.com>
Subject: Re: [PATCH 1/6] genalloc: track beginning of allocations
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Matthew Wilcox <willy@infradead.org>, Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, Laura Abbott <labbott@redhat.com>,
	Jerome Glisse <jglisse@redhat.com>, Christoph Hellwig <hch@infradead.org>, Christoph Lameter <cl@linux.com>,
	linux-security-module <linux-security-module@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592214925267848300?=
X-GMAIL-MSGID: =?utf-8?q?1593051357351070636?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 9:07 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
> On 13/02/18 01:52, Kees Cook wrote:
>> On Mon, Feb 12, 2018 at 8:52 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>>> @@ -738,14 +1031,16 @@ EXPORT_SYMBOL(devm_gen_pool_create);
>>>
>>>  #ifdef CONFIG_OF
>>>  /**
>>> - * of_gen_pool_get - find a pool by phandle property
>>> + * of_gen_pool_get() - find a pool by phandle property
>>>   * @np: device node
>>>   * @propname: property name containing phandle(s)
>>>   * @index: index into the phandle array
>>>   *
>>> - * Returns the pool that contains the chunk starting at the physical
>>> - * address of the device tree node pointed at by the phandle property,
>>> - * or NULL if not found.
>>> + * Return:
>>> + * * pool address      - it contains the chunk starting at the physical
>>> + *                       address of the device tree node pointed at by
>>> + *                       the phandle property
>>> + * * NULL              - otherwise
>>>   */
>>>  struct gen_pool *of_gen_pool_get(struct device_node *np,
>>>         const char *propname, int index)
>>
>> I wonder if this might be more readable by splitting the kernel-doc
>> changes from the bitmap changes? I.e. fix all the kernel-doc in one
>> patch, and in the following, make the bitmap changes. Maybe it's such
>> a small part that it doesn't matter, though?
>
> I had the same thought, but then I would have made most of the kerneldoc
> changes to something that would be altered by the following patch,
> because it would have made little sense to fix only those parts that
> would have survived.
>
> If it is really a problem to keep them together, I could put these
> changes in a following patch. Would that be ok?

Hmmm... I think keeping it as-is would be better than a trailing
docs-only patch. Maybe Jon has an opinion?

-Kees

-- 
Kees Cook
Pixel Security
