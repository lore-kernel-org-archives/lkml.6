Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BD1ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A3520652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A3520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbeGTJLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:11:10 -0400
Received: from www62.your-server.de ([213.133.104.62]:32904 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbeGTJLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:11:10 -0400
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fgQhj-0002Xc-He; Fri, 20 Jul 2018 10:23:59 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fgQhj-0002QW-9c; Fri, 20 Jul 2018 10:23:59 +0200
Subject: Re: [PATCH v3 1/2] tools/bpftool: ignore build products
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Taeung Song <treeze.taeung@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180719121005.12018-1-treeze.taeung@gmail.com>
 <20180719112357.4fd6c6ce@cakuba.netronome.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d6234684-03ff-ca7e-589f-458bf3b098b9@iogearbox.net>
Date:   Fri, 20 Jul 2018 10:23:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180719112357.4fd6c6ce@cakuba.netronome.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24765/Fri Jul 20 02:42:13 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19/2018 08:23 PM, Jakub Kicinski wrote:
> On Thu, 19 Jul 2018 21:10:04 +0900, Taeung Song wrote:
>> For untracked things of tools/bpf, add this.
>>
>> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
>> ---
>>  tools/bpf/.gitignore         | 5 +++++
>>  tools/bpf/bpftool/.gitignore | 1 +
>>  2 files changed, 6 insertions(+)
>>  create mode 100644 tools/bpf/.gitignore
>>
>> diff --git a/tools/bpf/.gitignore b/tools/bpf/.gitignore
>> new file mode 100644
>> index 000000000000..dfe2bd5a4b95
>> --- /dev/null
>> +++ b/tools/bpf/.gitignore
>> @@ -0,0 +1,5 @@
>> +FEATURE-DUMP.bpf
>> +bpf_asm
>> +bpf_dbg
>> +bpf_exp.yacc.*
>> +bpf_jit_disasm
>> diff --git a/tools/bpf/bpftool/.gitignore b/tools/bpf/bpftool/.gitignore
>> index d7e678c2d396..103cc5b5b446 100644
>> --- a/tools/bpf/bpftool/.gitignore
>> +++ b/tools/bpf/bpftool/.gitignore
>> @@ -1,3 +1,4 @@
>>  *.d
>>  bpftool
>> +bpftool*.8
>>  FEATURE-DUMP.bpftool
> 
> This patch is going to be merged to the bpf-next tree, I presume, and
> there is more man pages there:
> 
> $ make -C tools/bpf/bpftool/ doc 
> make: Entering directory 'linux/tools/bpf/bpftool'
>   DESCEND  Documentation
> make[1]: Entering directory '/linux/tools/bpf/bpftool/Documentation'
>   GEN      bpftool-perf.8
>   GEN      bpftool-map.8
>   GEN      bpftool.8
>   GEN      bpftool-prog.8
>   GEN      bpftool-cgroup.8
>   GEN      bpf-helpers.rst
> Parsed description of 80 helper function(s)
>   GEN      bpf-helpers.7
> make[1]: Leaving directory 'linux/tools/bpf/bpftool/Documentation'
> make: Leaving directory 'linux/tools/bpf/bpftool'
> $ git status 
> On branch work
> Your branch is ahead of 'pending' by 10 commits.
>   (use "git push" to publish your local commits)
> 
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
> 
> 	tools/bpf/bpftool/Documentation/bpf-helpers.7
> 	tools/bpf/bpftool/Documentation/bpf-helpers.rst
> 	tools/bpf/bpftool/Documentation/bpftool-cgroup.8
> 	tools/bpf/bpftool/Documentation/bpftool-map.8
> 	tools/bpf/bpftool/Documentation/bpftool-perf.8
> 	tools/bpf/bpftool/Documentation/bpftool-prog.8
> 	tools/bpf/bpftool/Documentation/bpftool.8
> 
> nothing added to commit but untracked files present (use "git add" to track)
> 
> See the bpf-helpers.* files?  Those are all auto-generated.
> 
> If you respin for -next please split the series and put [PATCH bpf-next
> v4] as prefix of first patch, and [PATCH bpf v4] as prefix for the
> second, as one of them is an improvement, and second a bug fix.

I've just applied patch 2/2 to bpf tree, thanks Taeung! I think best for
patch 1/2 would be if you rebase this against bpf-next tree as Jakub
mentioned so wouldn't need an immediate follow-up due to incomplete
.gitignore then.

Thanks,
Daniel
