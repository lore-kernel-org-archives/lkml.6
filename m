Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D08C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F6E20854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Xejba/Z6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F6E20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbeIMARr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:17:47 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44543 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeIMARq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:17:46 -0400
Received: by mail-oi0-f67.google.com with SMTP id l82-v6so5917567oih.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 12:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=p/C2ewZ01sw8ZsAsK04nW0LIg5rrrjD3JzMzWWfKltM=;
        b=Xejba/Z6F2yTsjZSn+Mb0TtZbMuteunsvXC144hojjEDm/2ZJ99/st9ftk3Mz0c3nr
         lXaa7TpVXUd2MGMNZ/nW/3wKsETwuqYLMYRzPexs2o15q5esPfNsQvcSQH9IoEU27rrV
         5wRToaHAg9P4rPWL3L/s762zzP1ZK9bdW3bXLWbrnNPpctdn3tlZMc5Xrst3qnsC52dh
         9scfucExZtaPvhjtk8VU1mhiQHYBjqOBYVvzi5lKrUybjNRIQD0QAHSAeOhMM9bmvCn1
         oT1gkMVP2fzqrPDXzVOFCj4vRgEEIf0OeE7Q47S+HagRg3I8lUqmhkWpczfMt1K1iBjE
         cavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=p/C2ewZ01sw8ZsAsK04nW0LIg5rrrjD3JzMzWWfKltM=;
        b=V8SgB7gKhswUoAVNfUWCFKMYr41vytykVfb/PvvqORVmSM8STZ/4UlGBotg9m5zNzz
         zsRh93AM4wMTxiDmukxZbfYcjSbG5hVZMCfuekw/4BkaFi1cz3Uwwrjcby7FdkSrToWC
         MI6aKm66DfIlaLiQfO9c4G3WImxpwyBArE8mtX7PRhWaooslSPcX2ZtQOhJfR7ILVOZh
         eHbvBH3sIBO9u/Q7HHaDPOTMUjCaLt2hhsUPvC32xkiIQcQLYV3wD19QLXYojVlkHcog
         xdqGoff82p279PGOgYMo/zNkHebQ4IAEE7raARjB1DATqNLYZAeixOviij08ltnFcfaL
         4MXA==
X-Gm-Message-State: APzg51BaprNEdbND2B7D+NAZzVPA8wbuljG9pOhsMzyn8Or0NWs9zx2F
        QIdpndWF03L01fHT4rXUG047KAwGccdyUhTkHLdhpw==
X-Google-Smtp-Source: ANB0VdYMOzNHj/9TA2/uJayJJQ2H/KivhDMtPOM2ugT9ds2xjqS++43E2i3Sw+YKbd+Ne9GjyZn04IuIkisDXn4PqHU=
X-Received: by 2002:aca:ed57:: with SMTP id l84-v6mr3259548oih.62.1536779511782;
 Wed, 12 Sep 2018 12:11:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:8e85:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 12:11:51
 -0700 (PDT)
In-Reply-To: <fac5a6f4-3dda-2ec4-81ec-4a4a7ad2a571@microsoft.com>
References: <20180910232615.4068.29155.stgit@localhost.localdomain>
 <20180910234354.4068.65260.stgit@localhost.localdomain> <7b96298e-9590-befd-0670-ed0c9fcf53d5@microsoft.com>
 <CAKgT0UdKZVUPBk=rg5kfUuFBpuZQEKPuGw31x5O2nMyuULgi0g@mail.gmail.com>
 <CAPcyv4gEDwp8Xh4_E8RNBC_OqstwhqxkZOpvYjWd_siB4C=BEQ@mail.gmail.com> <fac5a6f4-3dda-2ec4-81ec-4a4a7ad2a571@microsoft.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 12 Sep 2018 12:11:51 -0700
Message-ID: <CAPcyv4j5mHT8OrHkGdDeCCc30pF8z8ZD0f6p7T5KDd2ejmUetw@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
To:     Pasha Tatashin <Pavel.Tatashin@microsoft.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 10:46 AM, Pasha Tatashin
<Pavel.Tatashin@microsoft.com> wrote:
>
>
> On 9/12/18 12:50 PM, Dan Williams wrote:
>> On Wed, Sep 12, 2018 at 8:48 AM, Alexander Duyck
>> <alexander.duyck@gmail.com> wrote:
>>> On Wed, Sep 12, 2018 at 6:59 AM Pasha Tatashin
>>> <Pavel.Tatashin@microsoft.com> wrote:
>>>>
>>>> Hi Alex,
>>>
>>> Hi Pavel,
>>>
>>>> Please re-base on linux-next,  memmap_init_zone() has been updated there
>>>> compared to mainline. You might even find a way to unify some parts of
>>>> memmap_init_zone and memmap_init_zone_device as memmap_init_zone() is a
>>>> lot simpler now.
>>>
>>> This patch applied to the linux-next tree with only a little bit of
>>> fuzz. It looks like it is mostly due to some code you had added above
>>> the function as well. I have updated this patch so that it will apply
>>> to both linux and linux-next by just moving the new function to
>>> underneath memmap_init_zone instead of above it.
>>>
>>>> I think __init_single_page() should stay local to page_alloc.c to keep
>>>> the inlining optimization.
>>>
>>> I agree. In addition it will make pulling common init together into
>>> one space easier. I would rather not have us create an opportunity for
>>> things to further diverge by making it available for anybody to use.
>>
>> I'll buy the inline argument for keeping the new routine in
>> page_alloc.c, but I otherwise do not see the divergence danger or
>> "making __init_single_page() available for anybody" given the the
>> declaration is limited in scope to a mm/ local header file.
>>
>
> Hi Dan,
>
> It is much harder for compiler to decide that function can be inlined
> once it is non-static. Of course, we can simply move this function to a
> header file, and declare it inline to begin with.
>
> But, still __init_single_page() is so performance sensitive, that I'd
> like to reduce number of callers to this function, and keep it in .c file.

Yes, agree, inline considerations win the day. I was just objecting to
the "make it available for anybody" assertion.
