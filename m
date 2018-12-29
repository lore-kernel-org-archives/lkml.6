Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBF6C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 20:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F2A217F4
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 20:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="RqY7fyMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbeL2UWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 15:22:13 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34593 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeL2UWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 15:22:13 -0500
Received: by mail-qt1-f193.google.com with SMTP id r14so26462588qtp.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 12:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FwRsmL1DfOhHxmJWMc/vCvURXQbKWXH1LRxKROrAQWk=;
        b=RqY7fyMunItIUY8GckjRmSbB3HXewFTeXhlBdZRI77BA5YMclKHs0mKozal9oPLTMY
         iEjaTjKyIth00izitS7/RpK/6eGXt8qC2CVEvIDqz3Cs3fMbZm7KCHZToBn3m77b4+Ql
         Jr4tmXArdCU7v94V0wY55wvLY7A7nTlVbWh3UoTijXpdoHwKE6WUOfkh9UU15dta/EJg
         6QlgPpYJoJAs4uDLHhaMcWG2aBfVJynGpuq/3WUKVYjmdgahbaSPWEByquo8vw0fLYPF
         +xI7+PHsWS4ldKBYG7ZNMyDCSyVVbee2Y4SUOsQi0TCHRz01yOYrFQ6pNvLda3n6sMx4
         1N5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FwRsmL1DfOhHxmJWMc/vCvURXQbKWXH1LRxKROrAQWk=;
        b=c/6/4DJPUhOsPT64fA6sF/uW59HT8fwsI799+ZUDtpeRCjYAHTKeeDVinxbS4ur7Cy
         WMLn16OjM1wTJaN+UoKQe+M4slK+qsmg8tULTg2JAOeaAb/u/5QXhI2MkYlTeAryvWqZ
         rBurb1WUUBJdAYs2BR3/aBv3a3O41GRaULLW2mPpmIIQYOUY1bmDmaMzKVM4GUhkj5Dq
         LPj3SqEowVJeWR9QJzbFaafz8mUP21ndNweffIFj2Gz2S++3xP+vYwi2c0DbGJJNqJYR
         Tm0F+xifqB/3Hv0vgUfI9p9jseLGReaWfqf65Az30stlyVBoVzXu1CwodMoW8Wu0j1j8
         yYOg==
X-Gm-Message-State: AA+aEWb1cBRbiLO+LkH5QiUYnmlwl6SUk+TlQxZ4B4O1JC4MGtBHSdfR
        teCfJIweZZHGjBGMaDosTgLPVssQ3XKBuA==
X-Google-Smtp-Source: ALg8bN4tX+ktxGWKDXhchW1HezRbpBrqZ6A9d7AgdekIWMhds7HER4f5+P8lwlF+l1BiwWGkPCHUaA==
X-Received: by 2002:aed:29c7:: with SMTP id o65mr30553302qtd.353.1546114931566;
        Sat, 29 Dec 2018 12:22:11 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y2sm21041999qtb.88.2018.12.29.12.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 12:22:11 -0800 (PST)
Subject: Re: [PATCH -mmotm] efi: drop kmemleak_ignore() for page allocator
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181226023534.64048-1-cai@lca.pw>
 <CAKv+Gu_fiEDffKq_fONBYTOdSk-L7__+LgNEyVaNF3FGzBfAow@mail.gmail.com>
 <403405f1-b702-2feb-4616-35fc3dc3133e@lca.pw>
 <CAKv+Gu_e=NkKZ5C+KzBmgg2VMXNKPqXcPON8heRd0F_iW+aaEQ@mail.gmail.com>
 <20181227190456.0f21d511ef71f1b455403f2a@linux-foundation.org>
 <CAKv+Gu98AOB2LfQGMUHNc_B0MBvd3gATvtPypQaV1vgTcf87ww@mail.gmail.com>
From:   Qian Cai <cai@lca.pw>
Message-ID: <70d2a620-d9d8-f351-78fb-1135d264d824@lca.pw>
Date:   Sat, 29 Dec 2018 15:22:09 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu98AOB2LfQGMUHNc_B0MBvd3gATvtPypQaV1vgTcf87ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/18 4:17 AM, Ard Biesheuvel wrote:
> On Fri, 28 Dec 2018 at 04:04, Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Wed, 26 Dec 2018 16:31:59 +0100 Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>
>>> Please stop sending EFI patches if you can't be bothered to
>>> test/reproduce against the EFI tree.
>>
>> um, sorry, but that's a bit strong.  Finding (let alone fixing) a bug
>> in EFI is a great contribution (thanks!) and the EFI maintainers are
>> perfectly capable of reviewing and testing the proposed fix.  Or of
>> fixing the bug by other means.
>>
> 
> Qian did spot some issues recently, which was really helpful. But I
> really think that reporting all issues you find against the -mmotm
> tree because that happens to be your preferred tree for development is
> not the correct approach.
> 
>> Let's not beat people up for helping us in a less-than-perfect way, no?
> 
> Fair enough. But asking people to ensure that an issue they found
> actually exists on the subsystem tree in question is not that much to
> ask, is it?

It is not too much to ask to test on EFI subsystem tree only for this patch, but
if every maintainer asked for the same thing to test each subsystem tree after
found a bug even a trivial one in -mmotm or linux-next, it then become an issue.

There are people genuinely interested in the kernel in general rather than focus
on a few subsystems (yet). There are many subsystem git trees out there. It at
least needs to figure out which branch to test and adjust the config file
accordingly. Those subsystem trees usually are not well-documented like
linux-next or -mmotm trees. Then, they may need to deal with the subsystem
tree-specific issues.

Those people may just better switch to use mainline instead where they don't
need to bother testing the subsystem tree for every single patch. However, that
will cause delay in fixing those issues because mainline is usually a bit lag
behind the development.
