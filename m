Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91420ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7BD2064D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sknKK5oS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7BD2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbeGTKmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 06:42:07 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33958 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbeGTKmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 06:42:06 -0400
Received: by mail-pl0-f68.google.com with SMTP id f6-v6so4982453plo.1;
        Fri, 20 Jul 2018 02:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+kw2o3TtUZ4pTyK1c14HLJUY9HOlUot5DaeNXQd7tIo=;
        b=sknKK5oSXoCoUBwFYjgNC/YkVAVGUNgcDwWlxBDrhuSL3bUZYeA76dTrGI7K6dCznH
         IZ6LNGIzdiacma6UZCoQ+67UIJ6XL0DruYNB2pHxh4Gor20mJhkoRQJ9wvpI3eWrS2pa
         /qGSD7wOngnbXRZ4DUGOia6Qr2ClhvXJ9ARw44d9KGuvAPEhZgEUiTZh/zGc/4Osz8PD
         XlZfPXcCJwdfUKh8eMIFwDCxuwtqI2R3iNVe9Tu0JkMvzyym9H/w53VeJ4ZmCsmUASVT
         JcdSnNFV66ZYShpfsmDR8ELOCGOhJHO4xNMS2SpHmGrjWhj+VnMGhyhhIjRnhAferRH6
         itXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+kw2o3TtUZ4pTyK1c14HLJUY9HOlUot5DaeNXQd7tIo=;
        b=SOUUmsVo0ETQPxLKUEWSC51zMX/4JCdDG4fmLbP1f+tACKArBwLkHzNpHrArMkSIu/
         1Lv590d9VR1acVqvtG746nRmFdlaSWY3wOa5eS21BXsCNNnLVAP/MXFX/ub1qpx1o78I
         KmXCKqXzH4vFyqB96iKypbRbm+aUfgeUqgWxQZ8vvCyONblgWk1cgb36ggUWzwg3iMSa
         2Hlt6GRjYew0QKAK3mCfOqWl+io/K8JNtQoidhwGvxZ8aSaFYdrAtKKvpXZgdU4CfKzH
         NHEalOwuqxBT+vpY9zMHypofCTlECJjV2f9kvrXcJjSR3djD6OEcrncpcReOscuKjyWS
         tBBA==
X-Gm-Message-State: AOUpUlEubl2K2SO6QdS2vL3xtbkQLeLmQtaXj27uIFNnQAy7lseKo0Sp
        mMckcCvUi+mxOLC9p8fYM4+IdbeD
X-Google-Smtp-Source: AAOMgpcpdMrvs5WPd0Q6J8RFlYpi+n4DpTg07LLwRsxb/dTfO53MFrg8lfl6n6WhsO6NAckSP90rLw==
X-Received: by 2002:a17:902:5a08:: with SMTP id q8-v6mr1420509pli.300.1532080477987;
        Fri, 20 Jul 2018 02:54:37 -0700 (PDT)
Received: from [192.168.0.77] ([211.196.191.92])
        by smtp.gmail.com with ESMTPSA id j71-v6sm2179481pgd.23.2018.07.20.02.54.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 02:54:36 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] tools/bpftool: ignore build products
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180719121005.12018-1-treeze.taeung@gmail.com>
 <20180719112357.4fd6c6ce@cakuba.netronome.com>
 <d6234684-03ff-ca7e-589f-458bf3b098b9@iogearbox.net>
From:   Taeung Song <treeze.taeung@gmail.com>
Message-ID: <1d3a44f8-f2e3-b2fa-0b41-29f62af506f3@gmail.com>
Date:   Fri, 20 Jul 2018 18:54:33 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <d6234684-03ff-ca7e-589f-458bf3b098b9@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/20/2018 05:23 PM, Daniel Borkmann wrote:
> On 07/19/2018 08:23 PM, Jakub Kicinski wrote:
>> On Thu, 19 Jul 2018 21:10:04 +0900, Taeung Song wrote:
>>> For untracked things of tools/bpf, add this.
>>>
>>> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
>>> ---
>>>   tools/bpf/.gitignore         | 5 +++++
>>>   tools/bpf/bpftool/.gitignore | 1 +
>>>   2 files changed, 6 insertions(+)
>>>   create mode 100644 tools/bpf/.gitignore
>>>
>>> diff --git a/tools/bpf/.gitignore b/tools/bpf/.gitignore
>>> new file mode 100644
>>> index 000000000000..dfe2bd5a4b95
>>> --- /dev/null
>>> +++ b/tools/bpf/.gitignore
>>> @@ -0,0 +1,5 @@
>>> +FEATURE-DUMP.bpf
>>> +bpf_asm
>>> +bpf_dbg
>>> +bpf_exp.yacc.*
>>> +bpf_jit_disasm
>>> diff --git a/tools/bpf/bpftool/.gitignore b/tools/bpf/bpftool/.gitignore
>>> index d7e678c2d396..103cc5b5b446 100644
>>> --- a/tools/bpf/bpftool/.gitignore
>>> +++ b/tools/bpf/bpftool/.gitignore
>>> @@ -1,3 +1,4 @@
>>>   *.d
>>>   bpftool
>>> +bpftool*.8
>>>   FEATURE-DUMP.bpftool
>>
>> This patch is going to be merged to the bpf-next tree, I presume, and
>> there is more man pages there:
>>
>> $ make -C tools/bpf/bpftool/ doc
>> make: Entering directory 'linux/tools/bpf/bpftool'
>>    DESCEND  Documentation
>> make[1]: Entering directory '/linux/tools/bpf/bpftool/Documentation'
>>    GEN      bpftool-perf.8
>>    GEN      bpftool-map.8
>>    GEN      bpftool.8
>>    GEN      bpftool-prog.8
>>    GEN      bpftool-cgroup.8
>>    GEN      bpf-helpers.rst
>> Parsed description of 80 helper function(s)
>>    GEN      bpf-helpers.7
>> make[1]: Leaving directory 'linux/tools/bpf/bpftool/Documentation'
>> make: Leaving directory 'linux/tools/bpf/bpftool'
>> $ git status
>> On branch work
>> Your branch is ahead of 'pending' by 10 commits.
>>    (use "git push" to publish your local commits)
>>
>> Untracked files:
>>    (use "git add <file>..." to include in what will be committed)
>>
>> 	tools/bpf/bpftool/Documentation/bpf-helpers.7
>> 	tools/bpf/bpftool/Documentation/bpf-helpers.rst
>> 	tools/bpf/bpftool/Documentation/bpftool-cgroup.8
>> 	tools/bpf/bpftool/Documentation/bpftool-map.8
>> 	tools/bpf/bpftool/Documentation/bpftool-perf.8
>> 	tools/bpf/bpftool/Documentation/bpftool-prog.8
>> 	tools/bpf/bpftool/Documentation/bpftool.8
>>
>> nothing added to commit but untracked files present (use "git add" to track)
>>
>> See the bpf-helpers.* files?  Those are all auto-generated.
>>
>> If you respin for -next please split the series and put [PATCH bpf-next
>> v4] as prefix of first patch, and [PATCH bpf v4] as prefix for the
>> second, as one of them is an improvement, and second a bug fix.
> 
> I've just applied patch 2/2 to bpf tree, thanks Taeung! I think best for
> patch 1/2 would be if you rebase this against bpf-next tree as Jakub
> mentioned so wouldn't need an immediate follow-up due to incomplete
> .gitignore then.
> 
> Thanks,
> Daniel
> 

OK, I'll follow-up it later!
--
Thanks,
Taeung
