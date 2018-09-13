Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F12C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED8120C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nnq7o8+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED8120C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeIMSNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:13:41 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55384 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbeIMSNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:13:41 -0400
Received: by mail-it0-f65.google.com with SMTP id d10-v6so7658228itj.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 06:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=un5Q6B4rTIBWuCG33+cww/M3jRnFkApD6POcM8IplRY=;
        b=Nnq7o8+2dq6LEKc3UuGzy0D4tqGBU/pzp7czGIrbphdR1o2IEgsZ4WXrBEW4Tn0slC
         YWmKqpPBweFk3V75OovbnCkEzSqVkXP5OwuZIMtqXW+Vuh/deS+7kulaKVsweeTL9Hsc
         26EvQPNRHIaBtEFc67n9bhhXihzYJGeV2j1adfIwSfvkuVkyxNVvtx1JgMiRnAxWh2ou
         DdFcjK7z9q7PT9UHHAqVkUOyfSqsd/ref9b93oCZkbOdPrRNZYunDa2yBSyUvOuMAALY
         NZq1AK01sCL9jf9nLTbfknOpIBhREAZm81/ht+Olv59ygm+tK8h1VcMIX5Brd2gh0USP
         huFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=un5Q6B4rTIBWuCG33+cww/M3jRnFkApD6POcM8IplRY=;
        b=ad2e7hvCuMlQYmbQg1zn3SbfKYy1BFX8FDOuRepELKL/WYB+fPiP8Hsmw7cadxEcPA
         ppc1+aaLCqwib0kA/gUkHoF8ykNTmyeHwd+aoV1NrSBn+ME8dDQYp5lph08T6Aa40KkY
         nHVNelPSJFBtKAmi7jNFSBag79fPl75hZPfYPK/CbhAuo8b0X5nUA9j1MIAUqloXrFnF
         i6iIClP9dpoVuWfwSutqzM6JPhqllP4dwAiEacuICgV1aS81o+Kok/gBfarhpBPTBAp6
         2CI9Sq5Hw8WRPQ96Px2YZQfxl8e7Rx4UL3XbYfcmFEiyHhEHrQzfSlCra+zO1ewjNIK+
         5Cig==
X-Gm-Message-State: APzg51DPDWlt7984JNeZ8pMhq+JuS+SCXNFFLJil2F0mO7g/mR7Le9XK
        7+0y1jq77SlglSAs696CZTtTNjDHC+YSkyOuL8ok/w==
X-Google-Smtp-Source: ANB0VdZ8a/ta16JjU+Oql/soO2+dA262qBR3RG7qKMW6p9FUP5U4STbxOIU8qV0phYrIsTAPlVSBAS6yuPnE3gEaEV0=
X-Received: by 2002:a24:140f:: with SMTP id 15-v6mr6321775itg.57.1536843857194;
 Thu, 13 Sep 2018 06:04:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:5942:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 06:03:56
 -0700 (PDT)
In-Reply-To: <ec6547f4-6240-d901-b2d2-b5103a10493f@sony.com>
References: <000000000000038dab0575476b73@google.com> <f3bcebc6-47a7-518e-70f7-c7e167621841@I-love.SAKURA.ne.jp>
 <CAHC9VhT-Thu6KppC-MWzqkB7R1CaQA9DWXOQnG0b2uS9+rvzoA@mail.gmail.com>
 <ea29a8bf-95b2-91d2-043b-ed73c9023166@i-love.sakura.ne.jp>
 <9d685700-bc5c-9c2f-7795-56f488d2ea38@sony.com> <20180913111135.GA21006@dhcp22.suse.cz>
 <ec6547f4-6240-d901-b2d2-b5103a10493f@sony.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 13 Sep 2018 15:03:56 +0200
Message-ID: <CACT4Y+aBefAOPmvd1RF_Vy8TBFUJM9ves2atyFfmBnZnH7Kxsw@mail.gmail.com>
Subject: Re: [PATCH] selinux: Add __GFP_NOWARN to allocation at str_read()
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        SELinux <selinux@tycho.nsa.gov>,
        syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com,
        Eric Paris <eparis@parisplace.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 2:55 PM, peter enderborg
<peter.enderborg@sony.com> wrote:
>>>>>> syzbot is hitting warning at str_read() [1] because len parameter can
>>>>>> become larger than KMALLOC_MAX_SIZE. We don't need to emit warning for
>>>>>> this case.
>>>>>>
>>>>>> [1] https://syzkaller.appspot.com/bug?id=7f2f5aad79ea8663c296a2eedb81978401a908f0
>>>>>>
>>>>>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>>>>>> Reported-by: syzbot <syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com>
>>>>>> ---
>>>>>>  security/selinux/ss/policydb.c | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
>>>>>> index e9394e7..f4eadd3 100644
>>>>>> --- a/security/selinux/ss/policydb.c
>>>>>> +++ b/security/selinux/ss/policydb.c
>>>>>> @@ -1101,7 +1101,7 @@ static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
>>>>>>         if ((len == 0) || (len == (u32)-1))
>>>>>>                 return -EINVAL;
>>>>>>
>>>>>> -       str = kmalloc(len + 1, flags);
>>>>>> +       str = kmalloc(len + 1, flags | __GFP_NOWARN);
>>>>>>         if (!str)
>>>>>>                 return -ENOMEM;
>>>>> Thanks for the patch.
>>>>>
>>>>> My eyes are starting to glaze over a bit chasing down all of the
>>>>> different kmalloc() code paths trying to ensure that this always does
>>>>> the right thing based on size of the allocation and the different slab
>>>>> allocators ... are we sure that this will always return NULL when (len
>>>>> + 1) is greater than KMALLOC_MAX_SIZE for the different slab allocator
>>>>> configurations?
>>>>>
>>>> Yes, for (len + 1) cannot become 0 (which causes kmalloc() to return
>>>> ZERO_SIZE_PTR) due to (len == (u32)-1) check above.
>>>>
>>>> The only concern would be whether you want allocation failure messages.
>>>> I assumed you don't need it because we are returning -ENOMEM to the caller.
>>>>
>>> Would it not be better with
>>>
>>>     char *str;
>>>
>>>     if ((len == 0) || (len == (u32)-1) || (len >= KMALLOC_MAX_SIZE))
>>>         return -EINVAL;
>>>
>>>     str = kmalloc(len + 1, flags);
>>>     if (!str)
>>>         return -ENOMEM;
>> I strongly suspect that you want kvmalloc rather than kmalloc here. The
>> larger the request the more likely is the allocation to fail.
>>
>> I am not familiar with the code but I assume this is a root only
>> interface so we don't have to worry about nasty users scenario.
>>
> I don't think we get any big data there at all. Usually less than 32 bytes. However this data can be in fast path so a vmalloc is not an option.
>
> And some of the calls are GFP_ATOMC.

Then another option is to introduce reasonable application-specific
limit and not rely on kmalloc-anything at all. We did this for some
instances of this warning too. One advantage of it is that it prevents
users from doing silly things (or maybe will discover bugs in
user-space code better, why are they asking for megs here?). Another
advantage is that what works on one version of kernel will continue to
work on another version of kernel. Today it's possible that a policy
works on one kernel with 4MB kmalloc limit, but breaks on another with
2MB limit. Ideally exact value of KMALLOC_MAX_SIZE does not affect
anything in user-space.
