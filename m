Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A0AC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B9721721
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3TkLoqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32B9721721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbeHHICW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 04:02:22 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44842 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeHHICW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 04:02:22 -0400
Received: by mail-oi0-f66.google.com with SMTP id s198-v6so1687485oih.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 22:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=r2Jj0iKJEpP8LOwEUKwYlu1ybkzUKGbWw+aXQnRcwm0=;
        b=f3TkLoqWToEtSoOjL3XQgX2xbtxDxTgJWqT040JJmvbzPWH+w6CHAKoaoB/3DPJUzf
         1V0cExqRObyUwhigBIQ0UPZkhRkatFn8W710Fd/quBVya55D62A7hq/aIbVSJI33U6Jn
         Dg4rU2r3eE7Dnw4AWso628JuRVxhlxlvTYzqHNy8/AnrqodUzpxq9k6h+JMT4xwYIG5s
         /lM3JeFOyKnpZ9ZduMJ33PEwmqHmZM0AibPMNzoFe4kJd2fnFeMn+ipqLr551pTq847B
         uJrMntwrYgFnyKECVUqICBPlVihq1Og4axQLsj7xSGMYpA4Ihc9dwO6WLNSzjziIxRUi
         DMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=r2Jj0iKJEpP8LOwEUKwYlu1ybkzUKGbWw+aXQnRcwm0=;
        b=FtCEmrtVoYSTpum8MaxflG0Mgn+jw+PHUBVZalSNmN/qsVxFkagZWKYnEswHEap1lm
         Qhm8D9zRun7tcgu6oW/YZHO9MuhVSb64SPFJm1Bq4YaHNM5KvwToTw8hywuIgUY/iIWo
         Jr877spBKXygnVk4Vv0Wq1SsrA6MY8ldWpFoTW41f1yNFTBf+eq402616pRJrrH1pMMX
         GvN/Z3oOZyW/sbD0CIG48Bsa7C8r6QqxJkqC6Pbbb2jkupQQILW4wyxfGdru21/DdRbD
         VnGr2oyQlcBvp2kA8iRLGBHc98LwTIm0kJ9QAsQE6gTYVofGtPOS1mtyIJAaCn5xISdR
         ZoeQ==
X-Gm-Message-State: AOUpUlE5cc6ir7ubGK4s0B1byfbla4bjcjDHevoUOMihV7G33qCvQN5e
        sYO+HZsIlkgRSfmD06rsBbngSXJzxojmmL2aGwY=
X-Google-Smtp-Source: AA+uWPx0N400vrrPbCW+ncMGOehnNG082o5QxSyqb5vfyPyrrB6jUGJnGEalq5qVq80bZ9vfarQZXspf5L0ioQZ8Qes=
X-Received: by 2002:aca:3091:: with SMTP id w139-v6mr1591822oiw.67.1533707065427;
 Tue, 07 Aug 2018 22:44:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:1785:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 22:44:24 -0700 (PDT)
In-Reply-To: <5543a32a-20f9-18ff-dc13-73737257ed99@suse.cz>
References: <20180806065224.31383-1-rashmica.g@gmail.com> <5543a32a-20f9-18ff-dc13-73737257ed99@suse.cz>
From:   Rashmica Gupta <rashmica.g@gmail.com>
Date:   Wed, 8 Aug 2018 15:44:24 +1000
X-Google-Sender-Auth: 3CcNXzJVzGBQMT6Ujv8wK_EDwa8
Message-ID: <CAC6rBs=SySU9Amq2tr0AA6YMJVBmVhNyVCUfi+2b5MaSA=iLiw@mail.gmail.com>
Subject: Re: [PATCH v2] resource: Merge resources on a node when hot-adding memory
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     toshi.kani@hpe.com, tglx@linutronix.de, akpm@linux-foundation.org,
        bp@suse.de, brijesh.singh@amd.com, thomas.lendacky@amd.com,
        jglisse@redhat.com, gregkh@linuxfoundation.org,
        baiyaowei@cmss.chinamobile.com, dan.j.williams@intel.com,
        mhocko@suse.com, iamjoonsoo.kim@lge.com, malat@debian.org,
        pasha.tatashin@oracle.com, Bjorn Helgaas <bhelgaas@google.com>,
        osalvador@techadventures.net, yasu.isimatu@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 9:52 PM, Vlastimil Babka <vbabka@suse.cz> wrote:
> On 08/06/2018 08:52 AM, Rashmica Gupta wrote:
>> When hot-removing memory release_mem_region_adjustable() splits
>> iomem resources if they are not the exact size of the memory being
>> hot-deleted. Adding this memory back to the kernel adds a new
>> resource.
>>
>> Eg a node has memory 0x0 - 0xfffffffff. Offlining and hot-removing
>> 1GB from 0xf40000000 results in the single resource 0x0-0xfffffffff being
>> split into two resources: 0x0-0xf3fffffff and 0xf80000000-0xfffffffff.
>>
>> When we hot-add the memory back we now have three resources:
>> 0x0-0xf3fffffff, 0xf40000000-0xf7fffffff, and 0xf80000000-0xfffffffff.
>>
>> Now if we try to remove a section of memory that overlaps these resources,
>> like 2GB from 0xf40000000, release_mem_region_adjustable() fails as it
>> expects the chunk of memory to be within the boundaries of a single
>> resource.
>
> Hi,
>
> it's the first time I see the resource code, so I might be easily wrong.
> How can it happen that the second remove is section aligned but the
> first one not?
>

I probably shouldn't have used that word... When I said "a section of memory"
I really meant "a chunk of memory" or "some memory".


>> This patch adds a function request_resource_and_merge(). This is called
>> instead of request_resource_conflict() when registering a resource in
>> add_memory(). It calls request_resource_conflict() and if hot-removing is
>> enabled (if it isn't we won't get resource fragmentation) we attempt to
>> merge contiguous resources on the node.
>>
>> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
> ...
>> --- a/kernel/resource.c
>> +++ b/kernel/resource.c
> ...
>> +/*
>> + * Attempt to merge resources on the node
>> + */
>> +static void merge_node_resources(int nid, struct resource *parent)
>> +{
>> +     struct resource *res;
>> +     uint64_t start_addr;
>> +     uint64_t end_addr;
>> +     int ret;
>> +
>> +     start_addr = node_start_pfn(nid) << PAGE_SHIFT;
>> +     end_addr = node_end_pfn(nid) << PAGE_SHIFT;
>> +
>> +     write_lock(&resource_lock);
>> +
>> +     /* Get the first resource */
>> +     res = parent->child;
>> +
>> +     while (res) {
>> +             /* Check that the resource is within the node */
>> +             if (res->start < start_addr) {
>> +                     res = res->sibling;
>> +                     continue;
>> +             }
>> +             /* Exit if resource is past end of node */
>> +             if (res->sibling->end > end_addr)
>> +                     break;
>
> IIUC, resource end is closed, so adjacent resources's start is end+1.
> But node_end_pfn is open, so the comparison above should use '>='
> instead of '>'?

You are right. Thanks for spotting that.

>
>> +
>> +             ret = merge_resources(res);
>> +             if (!ret)
>> +                     continue;
>> +             res = res->sibling;
>
> Should this rather use next_resource() to merge at all levels of the
> hierarchy? Although memory seems to be flat under &iomem_resource so it
> would be just future-proofing.

I don't know enough about the hierarchy and layout of resources to comment on
this.

>
> Thanks,
> Vlastimil
