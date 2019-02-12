Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBE1C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D716217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="IJmz77rn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbfBLQHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:07:42 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33104 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730567AbfBLQHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:07:42 -0500
Received: by mail-qk1-f194.google.com with SMTP id x9so9035208qkf.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 08:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AmZLIJO0gfRSAXKTvAHHDhr2asaovb+Mn3AnBaO8fWs=;
        b=IJmz77rnrC8aJW1GrGatM3SA8D/tKAe8meBIuPnbPzQ6ZJ5P9o7NCZ3r4N13peq6o8
         +/gKU+1WITFhUHRlvL1LzPFEO4z3NJnlj2JhQ1D4bLltpp91uiFMoeRIzmAzKTr8+9nC
         GP5JoJ3wzcj8b2+8Z7W61BokztvK2VWhzw8EYh9O0B7lEh132Yj4nrMdNyrTbjhszMAI
         S12t1gcmQs9aBfqon559lbESBEz+j6gqk8pkuQzcFuihRWD3B340l8A4eUj7h4OD6Yag
         0y74V1+yLA9xBNskGYP6FuOA222FS3JCSjx+cyV6vI8iWm3FlYBI2icCDDLfxS7qjNyw
         afVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AmZLIJO0gfRSAXKTvAHHDhr2asaovb+Mn3AnBaO8fWs=;
        b=XLS8W6kzJTEB8NI3RrqbiCOGJIoOUVHYMZxDeNa1Qo1zianMgz0feBfuAiZimu1i9H
         zG5cGHHg3P/iR6bPaGL/rpARswE6I+51lABTKfLP35eEpjiPsbDTCo2jZ1Uj9kT50Wvx
         LK3EzL0GwNjqblb8MnIQJQWbnuGG0b6+AyX5sFd+nuAeNNJwN8s2ReFhfDQBliWbPw+l
         eEAyf4jnzDxcAc7bqy6gtgmnz11Q8DsfAwvzcht7HWBHkjEwmZILDZcR2EM3OLyQI0kz
         CsQt4BT/pKzNNHgHR7ZNliohQXGq0i//aiR9X+TjIfoIFFUazT8Qbra/1ebRNT/egGeR
         VmRA==
X-Gm-Message-State: AHQUAuYFHTw+NFxG0Gn4r9taIMuZ78uF7C8SOuq5kJF0o2mRoAT0BJH7
        9/kTr+ObBH+oaMoeOo1vgiMb4w==
X-Google-Smtp-Source: AHgI3Ia+DhAJkD6C0s1c/mrgU8uSC41QzR5n3/jMZ+a7rJV2bORVchdq16empf7IT7JXeM8ZkVFEVA==
X-Received: by 2002:a37:a114:: with SMTP id k20mr2990613qke.274.1549987660729;
        Tue, 12 Feb 2019 08:07:40 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s128sm13293494qkh.59.2019.02.12.08.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 08:07:40 -0800 (PST)
Subject: Re: [PATCH 5/5] kasan, slub: fix conflicts with
 CONFIG_SLAB_FREELIST_HARDENED
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>
References: <cover.1549921721.git.andreyknvl@google.com>
 <3df171559c52201376f246bf7ce3184fe21c1dc7.1549921721.git.andreyknvl@google.com>
 <4bc08cee-cb49-885d-ef8a-84b188d3b5b3@lca.pw>
 <CAAeHK+zv5=oHJQg-bx7-tiD9197J7wdMeeRSgaxAfJjXEs3EyA@mail.gmail.com>
 <c92d6890-a718-a968-9937-13bdfeda773c@lca.pw>
 <CAAeHK+xDYvjMxrkczTQaDbMSu5u3GsxW_mFi1=9OAjCi2Q-6iQ@mail.gmail.com>
From:   Qian Cai <cai@lca.pw>
Message-ID: <a9d73c21-744c-84f2-78db-a32773b83ddc@lca.pw>
Date:   Tue, 12 Feb 2019 11:07:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAAeHK+xDYvjMxrkczTQaDbMSu5u3GsxW_mFi1=9OAjCi2Q-6iQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/12/19 9:42 AM, Andrey Konovalov wrote:
> On Tue, Feb 12, 2019 at 2:43 PM Qian Cai <cai@lca.pw> wrote:
>>
>>
>>
>> On 2/12/19 8:26 AM, Andrey Konovalov wrote:
>>> Hm, did you apply all 6 patches (the one that you sent and these five)
>> Yes.
> 
> I'm failing to reproduce this in QEMU. You're still using the same
> config, right? Could you share whole dmesg until the first BUG?
> 

Yes, same config and,

https://git.sr.ht/~cai/linux-debug/tree/master/dmesg
