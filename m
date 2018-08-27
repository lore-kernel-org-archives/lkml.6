Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683ACC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5C7208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20150623.gappssmtp.com header.i=@mojatatu-com.20150623.gappssmtp.com header.b="ZLaiczwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5C7208B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbeH0SM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:12:56 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:44088 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbeH0SM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:12:56 -0400
Received: by mail-io0-f193.google.com with SMTP id 75-v6so12923015iou.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 07:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Je71mQP9k2ulgeyMLgbTeWh40ubvX/3LJLVlUgowNK4=;
        b=ZLaiczwUUKBDDTWJbo/CPlfe2lmvA8sPFn5X28JowA9KRyiISeGv81iyCAwAmlJshs
         5w3xCCvpRCGy5FnUXxbubsQjjGi57UmInOF1Jg/wBEiWqbCIVGl1YDs1ZO2NCWarnbun
         chdvgNlIEAL0raR3r3WC+4dYFusd8FGO7e3qKAN3lC5dihHmeiVH9wvn0s1xJ2Fv+el/
         76rx7IxxSH62tjnc7XkurpLHVCqONCDBTK/iOGoIlW+jbah/edmYdXa0j35uhgHN8/9B
         OruyA1POYHoKGxmrR2pLCYkwa5tDkC1ytu9isjWNkZGrs/Qc3Chv4U7ZJN+HzUXndH2F
         TNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Je71mQP9k2ulgeyMLgbTeWh40ubvX/3LJLVlUgowNK4=;
        b=tRplWf5RQbfj0fybDJ9anUmB9we8ueD3JAVQ9mbtR1EnrVd7LDYpFUcfQMGCmp352H
         KklTKmVKjOPuvc59dQh4GhG7kfrXcs99nBMAc+zy0TnzoZ+bbOVenKbdSIy1lNoW062G
         sS7vd9LuObE8UjBaSPIBR9536i10R1cTSO3YHU3+w9HDk5Y6uG3st3DMiM9ki7jDpNe3
         H0Wwswn7pdxCz92PY1AhyQiAGFsm8JQQXUOBYINXO2wn5UvTDveQoDafDXRgJVLdSgok
         He9v6mNuLrSyfkjzFfbhweiPPCCs+wxAUzQMcLW+P8UNs5ZRd7iZksGLtDzvTClRMcBa
         lp8w==
X-Gm-Message-State: APzg51AT+xzCnXkk0iJO0QSBsAcBHwwcmsqwjf7rs+oLo3iSoWbHYuM5
        nwgnTr4H2YBgmqXnKCPSKxNlkg==
X-Google-Smtp-Source: ANB0Vdblk1gae3gH+mD+7aPKsZEZeVBA4V+tABJJPJkCjn7d45VMankbgCyDGtrdP6e6LVot6Tpowg==
X-Received: by 2002:a6b:1acf:: with SMTP id a198-v6mr2160071ioa.286.1535379964933;
        Mon, 27 Aug 2018 07:26:04 -0700 (PDT)
Received: from sevai ([64.26.149.125])
        by smtp.gmail.com with ESMTPSA id 185-v6sm1171448itk.28.2018.08.27.07.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 07:26:04 -0700 (PDT)
From:   Roman Mashak <mrv@mojatatu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH] net: sched: Fix memory exposure from short TCA_U32_SEL
References: <20180826055801.GA42063@beast>
        <20180826061534.GT6515@ZenIV.linux.org.uk>
        <CAGXu5jK7VzayzZTcxgZBf-+YHWO+Hv7s8utj2rzTc3gFtA8pFQ@mail.gmail.com>
        <5c88b08d-b9ca-f3df-ae78-cf685ee6723a@mojatatu.com>
        <CAGXu5jJZ-BfJPA+m1BOuVVQxPb8SXpSRo+F2cVTF62C9JTyRXQ@mail.gmail.com>
        <d68f13e6-339a-2a40-9c0d-7549cd9aabb3@mojatatu.com>
        <CAGXu5jJD++hegH4j0ajZNejg8mgcHjqVyjveWj9BFaXwRCV_dQ@mail.gmail.com>
Date:   Mon, 27 Aug 2018 10:26:03 -0400
In-Reply-To: <CAGXu5jJD++hegH4j0ajZNejg8mgcHjqVyjveWj9BFaXwRCV_dQ@mail.gmail.com>
        (Kees Cook's message of "Mon, 27 Aug 2018 07:08:22 -0700")
Message-ID: <85zhx7zy10.fsf@mojatatu.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Mon, Aug 27, 2018 at 4:46 AM, Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>> On 2018-08-26 5:56 p.m., Kees Cook wrote:
>>>
>>> On Sun, Aug 26, 2018 at 10:30 AM, Jamal Hadi Salim <jhs@mojatatu.com>
>>> wrote:
>>>>
>>>> We should add an nla_policy later.
>>>
>>>
>>> What's the right way to do that for cases like this?
>>
>>
>> Meant something like attached which you alluded-to in your comments
>> would give an upper bound (Max allowed keys is 128).
>
> The problem is that policy doesn't parse the contents: "nkeys"
> determines the size, so we have to both validate minimum size (to be
> sure the location of "nkeys" is valid) and check that the size is at
> least nkeys * struct long. I don't think there is a way to do this
> with the existing policy language.

While at these changes, could you also add and export in UAPI max
allowed keys count, which is currently 128? For example,
TCA_U32_NKEYS_MAX in pkt_cls.h
