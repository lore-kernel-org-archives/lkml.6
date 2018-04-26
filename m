Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754228AbeDZHxg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:53:36 -0400
Received: from www62.your-server.de ([213.133.104.62]:49278 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752962AbeDZHxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:53:32 -0400
Subject: Re: [PATCH 3/3] tools bpftool: Display license GPL compatible in prog
 show/list
To: Jiri Olsa <jolsa@redhat.com>
Cc: Jakub Kicinski <kubakici@wp.pl>, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>
References: <20180425174108.6586-1-jolsa@kernel.org>
 <20180425174108.6586-4-jolsa@kernel.org>
 <20180425140346.3e0f3ba7@cakuba.netronome.com>
 <0e84fe67-59c9-a419-5ff7-05be2aa1991e@iogearbox.net>
 <20180426073905.GI3396@krava>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <639b2b78-af9e-4605-2b33-9bd1af8e760a@iogearbox.net>
Date: Thu, 26 Apr 2018 09:53:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180426073905.GI3396@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26/2018 09:39 AM, Jiri Olsa wrote:
> On Wed, Apr 25, 2018 at 11:14:30PM +0200, Daniel Borkmann wrote:
>> On 04/25/2018 11:03 PM, Jakub Kicinski wrote:
>>> On Wed, 25 Apr 2018 19:41:08 +0200, Jiri Olsa wrote:
>>>> @@ -295,6 +297,7 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd)
>>>>  	printf("tag ");
>>>>  	fprint_hex(stdout, info->tag, BPF_TAG_SIZE, "");
>>>>  	print_dev_plain(info->ifindex, info->netns_dev, info->netns_ino);
>>>> +	printf(" license GPL %scompatible", info->gpl_compatible ? "" : "NON ");
>>>
>>> 3 nit picks:
>>>
>>> Other "fields" are separated by two spaces between each other:
>>>
>>>   4: kprobe  name func_begin  tag 57cd311f2e27366b license GPL compatible
>>>            ^^               ^^                    X
>>>           loaded_at Apr 25/11:20  uid 0
>>>                                 ^^
>>>           xlated 16B  not jited  memlock 4096B
>>>                     ^^         ^^
>>>
>>> Could you also update the example outputs in the man page:
>>>
>>> tools/bpf/bpftool/Documentation/bpftool-prog.rst
>>>
>>> Sorry about the bike shedding but I would also vote for:
>>>
>>> "[not] GPL compatible"
>>>
>>> rather than
>>>
>>> "license GPL [NON] compatible"
>>>
>>> for brevity..
>>
>> While we're at it, can we also squeeze this whole thing a bit? Feels like
>> huge string wasted for very little information compared to the rest of the
>> dump. Just append the string "gpl" at the end of the line if info->gpl_compatible
>> is set, otherwise just add nothing. This also allows to naturally grep
>> for it e.g. `bpftool p | grep gpl` if you need a quick summary.
> 
> that's fine with me.. so 'gpl' in here:
> 
> 5: tracepoint  name func  tag 57cd311f2e27366b  gpl
>         loaded_at Apr 26/09:37  uid 0
>         xlated 16B  not jited  memlock 4096B
> 
> and keeping tyhe whole name in json output:
> 
> [{
>         "id": 5,
>         "type": "tracepoint",
>         "name": "func",
>         "tag": "57cd311f2e27366b",
>         "gpl_compatible": true,
>         "loaded_at": "Apr 26/09:37",
>         "uid": 0,
>         "bytes_xlated": 16,
>         "jited": false,
>         "bytes_memlock": 4096
>     }
> ]
> 
> how about that?

Sounds good, thanks Jiri!
