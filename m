Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEA1C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E18208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIzr+D+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E18208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbeG0OSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:18:36 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:43533 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730314AbeG0OSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:18:36 -0400
Received: by mail-oi0-f67.google.com with SMTP id b15-v6so8853095oib.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 05:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6v/0N8AiFLlSLTV0L4auuUkXb03OdHWLa0gwiyViN1E=;
        b=KIzr+D+Y6xNEjtdPPy6ZaVa7AFYhleYb/LDNZKwfEbLsAwHwNMs0MFO88itmZ4JTcw
         CPgnoVyUVuV3nle1f8qsW7LdsvPEOBQso25BIYOj7cTa2WFFIHc+VfRdXaioetzHulJI
         fNHPob22SJgDkB0vIITP724J9GZ+W81bOzPVc2o6Ah/h3u3G4mA7b6oK334csatAlXbc
         qYw4FHV9YAsgq4SNDy/9xRe3bxmFvarIdLdkrSaIaO8Vdo8iDCDNcxlK6xw5dZ7JhXgf
         Vet90l9dXsQRJn+h3vyscRUwZ90mRaUryu07/POkWA1l5qlMtI2/jvlw/xaVxNllA/qK
         RK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6v/0N8AiFLlSLTV0L4auuUkXb03OdHWLa0gwiyViN1E=;
        b=Q9o3RAG5gED3v+hHB5x2z3hNFvPAKp1OBbA+qHd429hOFnBFwkTOCypJC36kQ2YPrX
         vY9xog3mSl9wBQYAjIrFaUGw04UDw30G8UjQnhP8EeDnfHLCF6asULmMqXaQj8WxAq5K
         qPnQuRf7QxU9kXlviEqQoywcTYjDVIGfZ+MYcYtDrf+I3mup5VFSx8zgW8Ez8U5vEmfa
         O7B0r619CtLyZ/JnMHF75ldj0Gj00GCQpSmlKQ7pLeC8cGeOLL8V4iZPviXISjzi7+OA
         rfjIqx9q372G9EFtU6bK25UunGFkj9qynjeryVmkaTIoQM6LhNqe2DBheAw03D+cS56Z
         uv8Q==
X-Gm-Message-State: AOUpUlEjTf+S2tQ2Us0mzwNs0HYldXFQo/6YHoZccFUY7bfNebeUovQs
        JX+p1OEw5ftALO9veaEl0SXoANr3iGv/booTS08=
X-Google-Smtp-Source: AAOMgpcMm2J0GA+LeHRz9xqzTAtphdXEqjmzwx2yTn77pDOSmluRykh7PHDouanoL8zewwF2nxbExVzq7OHzcUsTIt0=
X-Received: by 2002:aca:4e50:: with SMTP id c77-v6mr5931334oib.254.1532696206959;
 Fri, 27 Jul 2018 05:56:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7702:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 05:56:46
 -0700 (PDT)
In-Reply-To: <3ed2046c-6912-9380-7ea4-4d921981c64c@arm.com>
References: <20180419171234.11053-1-ganapatrao.kulkarni@cavium.com>
 <c6c3655b-cef2-1112-e8a7-79c99f9ddac6@arm.com> <CAKTKpr67gqCK5y6atsterc7kCAg9fK_NKx2yMD3OjY+1L=j0sQ@mail.gmail.com>
 <CAKTKpr4skf3=Aw1YJNPppSjUT7w7_CF6QhefeHZDQXzENCfm5g@mail.gmail.com>
 <CAKTKpr7BmaR-rwqf=z8JiNpaoQNhpSXuUp8sZogUgSLpfcCe0A@mail.gmail.com>
 <CAKTKpr694WntjTB+pbXN--wthH+sw1mrr=JWjDfddG4bHdLwjw@mail.gmail.com>
 <CAKTKpr74X9e2X-deraxFQzeoTio09LqoZoLDgod4J5AOn+vPMg@mail.gmail.com> <3ed2046c-6912-9380-7ea4-4d921981c64c@arm.com>
From:   Ganapatrao Kulkarni <gklkml16@gmail.com>
Date:   Fri, 27 Jul 2018 18:26:46 +0530
Message-ID: <CAKTKpr5eERRzxDcH5cno5kDQ10XO9nHXbLTmk=ShEi8HK05fsg@mail.gmail.com>
Subject: Re: [PATCH] iommu/iova: Update cached node pointer when current node
 fails to get any free IOVA
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, tomasz.nowicki@cavium.com,
        jnair@caviumnetworks.com,
        Robert Richter <Robert.Richter@cavium.com>,
        Vadim.Lomovtsev@cavium.com, Jan.Glauber@cavium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Wed, Jul 25, 2018 at 7:50 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 12/07/18 08:45, Ganapatrao Kulkarni wrote:
>>
>> Hi Robin,
>>
>>
>> On Mon, Jun 4, 2018 at 9:36 AM, Ganapatrao Kulkarni <gklkml16@gmail.com>
>> wrote:
>>>
>>> ping??
>>>
>>> On Mon, May 21, 2018 at 6:45 AM, Ganapatrao Kulkarni <gklkml16@gmail.com>
>>> wrote:
>>>>
>>>> On Thu, Apr 26, 2018 at 3:15 PM, Ganapatrao Kulkarni
>>>> <gklkml16@gmail.com> wrote:
>>>>>
>>>>> Hi Robin,
>>>>>
>>>>> On Mon, Apr 23, 2018 at 11:11 PM, Ganapatrao Kulkarni
>>>>> <gklkml16@gmail.com> wrote:
>>>>>>
>>>>>> On Mon, Apr 23, 2018 at 10:07 PM, Robin Murphy <robin.murphy@arm.com>
>>>>>> wrote:
>>>>>>>
>>>>>>> On 19/04/18 18:12, Ganapatrao Kulkarni wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> The performance drop is observed with long hours iperf testing using
>>>>>>>> 40G
>>>>>>>> cards. This is mainly due to long iterations in finding the free
>>>>>>>> iova
>>>>>>>> range in 32bit address space.
>>>>>>>>
>>>>>>>> In current implementation for 64bit PCI devices, there is always
>>>>>>>> first
>>>>>>>> attempt to allocate iova from 32bit(SAC preferred over DAC) address
>>>>>>>> range. Once we run out 32bit range, there is allocation from higher
>>>>>>>> range,
>>>>>>>> however due to cached32_node optimization it does not suppose to be
>>>>>>>> painful. cached32_node always points to recently allocated 32-bit
>>>>>>>> node.
>>>>>>>> When address range is full, it will be pointing to last allocated
>>>>>>>> node
>>>>>>>> (leaf node), so walking rbtree to find the available range is not
>>>>>>>> expensive affair. However this optimization does not behave well
>>>>>>>> when
>>>>>>>> one of the middle node is freed. In that case cached32_node is
>>>>>>>> updated
>>>>>>>> to point to next iova range. The next iova allocation will consume
>>>>>>>> free
>>>>>>>> range and again update cached32_node to itself. From now on, walking
>>>>>>>> over 32-bit range is more expensive.
>>>>>>>>
>>>>>>>> This patch adds fix to update cached node to leaf node when there
>>>>>>>> are no
>>>>>>>> iova free range left, which avoids unnecessary long iterations.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> The only trouble with this is that "allocation failed" doesn't
>>>>>>> uniquely mean
>>>>>>> "space full". Say that after some time the 32-bit space ends up empty
>>>>>>> except
>>>>>>> for one page at 0x1000 and one at 0x80000000, then somebody tries to
>>>>>>> allocate 2GB. If we move the cached node down to the leftmost entry
>>>>>>> when
>>>>>>> that fails, all subsequent allocation attempts are now going to fail
>>>>>>> despite
>>>>>>> the space being 99.9999% free!
>>>>>>>
>>>>>>> I can see a couple of ways to solve that general problem of free
>>>>>>> space above
>>>>>>> the cached node getting lost, but neither of them helps with the case
>>>>>>> where
>>>>>>> there is genuinely insufficient space (and if anything would make it
>>>>>>> even
>>>>>>> slower). In terms of the optimisation you want here, i.e. fail fast
>>>>>>> when an
>>>>>>> allocation cannot possibly succeed, the only reliable idea which
>>>>>>> comes to
>>>>>>> mind is free-PFN accounting. I might give that a go myself to see how
>>>>>>> ugly
>>>>>>> it looks.
>>
>>
>> did you get any chance to look in to this issue?
>> i am waiting for your suggestion/patch for this issue!
>
>
> I got as far as [1], but I wasn't sure how much I liked it, since it still
> seems a little invasive for such a specific case (plus I can't remember if
> it's actually been debugged or not). I think in the end I started wondering
> whether it's even worth bothering with the 32-bit optimisation for PCIe
> devices - 4 extra bytes worth of TLP is surely a lot less significant than
> every transaction taking up to 50% more bus cycles was for legacy PCI.

how about tracking previous attempt to get 32bit range iova and avoid
further attempts, if it was failed. Later Resume attempts once
replenish happens.
Created patch for the same [2]

[2] https://github.com/gpkulkarni/linux/commit/e2343a3e1f55cdeb5694103dd354bcb881dc65c3
note, the testing of this patch is in progress.

>
> Robin.
>
> [1]
> http://www.linux-arm.org/git?p=linux-rm.git;a=commitdiff;h=a8e0e4af10ebebb3669750e05bf0028e5bd6afe8

thanks
Ganapat
