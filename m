Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF86ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8320320BED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyTSfZKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8320320BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbeGPMXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:23:02 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:32839 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbeGPMXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:23:02 -0400
Received: by mail-qt0-f179.google.com with SMTP id c15-v6so12214451qtp.0;
        Mon, 16 Jul 2018 04:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=maBIJUQybzJG/mP/mn5Dgsx4u3boUn2IiroNR+dHHFw=;
        b=NyTSfZKNkdZYyzhlUkrO7F5HGT6aIQYWfyLSWSJvsTNHKhHH63r0qHQ3gZRHRv+Y4B
         5+YxUSs96nVp2Rz08DITK9bAeA8TQLqQ1feefFFW2JiE6e9CU+Z4TtAegi1W8DQIKqoJ
         sHWj9SOxmC39a5O7/CSXr8/6xtzPEzjxxJ+AMxCPqNMEky8R9v3FwrlltSc7DOCeYeWq
         DJKxrRIFn0Nv8gnBvS7PWIv+cs7df/Bp8YKBpJdYbNZTWAOD7OaMiQ8uvZMw5dI44ec3
         xlywYGFDCcWyqzbDQ6pKFnCflyB5AEuQO/uDX3tX/64a+C+t7DcoupVjNNve/ESJ0fHt
         0xiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=maBIJUQybzJG/mP/mn5Dgsx4u3boUn2IiroNR+dHHFw=;
        b=WyqrY8I4G51BOVjj39nIlfHfN0/wHAKD3EINNBcvTpYIAspPloRftL9bqbs3JpWddP
         t2apN5nTNpfbi7HzXq1FLnYkb7aU9mrJXcnKIU3urKDYXA8TPUkMKT5a0Wqmsu9tY19G
         7S7ODG15RRNogYAsUfg28uKfwpI11DTLAD7ycvb9YJINTeD5HmVbN0P26/PIkFbZ4kie
         yipeP3P5AWLX0HDMAUICTN+6Ev9viLB1Sk94T6FjWivtCtySk+QXts5qmgQhUnZJ81bs
         UNfKw6Xd8s7XBHIib1BJ/FxFvJW9tyw6Gs6CEhXZgOTSTpDka4BvhHpb0yf0icyRDoGr
         sFtw==
X-Gm-Message-State: AOUpUlGoVhFma40kO/gzOi4e+drjmSjpijz/RBZAe4jkn4DOpWEmay7f
        IuOqGf/ZWfgFi6w+fOT+KdM=
X-Google-Smtp-Source: AAOMgpd15brXQnR9YbfTipRK8dzcapUt/nqCKM9v6OyCpfvqEqjZpd7+EZ3qKVyYZyGx4BeCCQqryQ==
X-Received: by 2002:a0c:f9c8:: with SMTP id j8-v6mr17685994qvo.177.1531742155587;
        Mon, 16 Jul 2018 04:55:55 -0700 (PDT)
Received: from [10.178.50.179] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id f17-v6sm18338359qtp.1.2018.07.16.04.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 04:55:54 -0700 (PDT)
Subject: Re: linux-next: Signed-off-by missing for commits in the arm-soc tree
To:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Anholt <eric@anholt.net>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>
References: <20180716075718.4e5ef491@canb.auug.org.au>
 <CAOesGMhVeo6Wc=nMcEnusa+FfwQBWJnxs0LY-zXm4HMau+SMhg@mail.gmail.com>
 <6a9fa6f3-7aef-a83b-72a6-dc9492964b5e@gmail.com>
 <CAGb2v667K4Z6o-KEQROWuCbgJbKLNX_OCpCBOWaECb_qfRMBpw@mail.gmail.com>
 <20180716095700.GC17271@n2100.armlinux.org.uk>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <6a6d47fa-cc7f-b977-339e-ea215bc40541@gmail.com>
Date:   Mon, 16 Jul 2018 04:55:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180716095700.GC17271@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/16/2018 02:57 AM, Russell King - ARM Linux wrote:
> On Mon, Jul 16, 2018 at 05:24:08PM +0800, Chen-Yu Tsai wrote:
>> On Mon, Jul 16, 2018 at 5:13 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>
>>>
>>> On 07/15/2018 03:50 PM, Olof Johansson wrote:
>>>> Thanks Stephen, I keep saying every time you catch these that I need
>>>> to run the same script. :(
>>>>
>>>> Florian, I wonder if this happened when you rebased to squash in the fix?
>>>
>>> Humm, could be, all I did (and it was not the first time) was to do an
>>> interactive rebase with --preserve-merges. AFAICT, all of these commits
>>> came from Eric's pull request, so what I typically do is just sign off
>>> on the merge commit, but do not apply my SoB to all commits coming from
>>> that pull request if that makes sense?
>>
>> When you rebase, if the commit is re-applied, the committer changes to
>> you, so you need to add your SoB to all commits you rebased.
>>
>> I suppose you could override it with GIT_COMMITTER_NAME and
>> GIT_COMMITTER_EMAIL environment variables, but that sort of distorts
>> the SoB if any changes were added due to rebasing, such as resolution
>> of merge conflicts.
> 
> A different point: should *anyone* be rebasing commits that they did not
> themselves commit.  Discuss.
> 
> IMHO no - the commits were made public, and anyone could pull the tree
> from which they came in order to do further work before submitting that.
> Rebasing changes the commit IDs, which can lead to duplicate commits
> ending up in mainline.  With other changes on top, this causes totally
> unnecessary conflicts.
> 

Well in that case, I thought it would be cleaner to just squash Arnd's
build fix since the commit had not been merged into arm-soc, but I will
keep in mind not to do that anymore.
-- 
Florian
