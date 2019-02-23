Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D866DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84A6205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfBWArL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:47:11 -0500
Received: from www62.your-server.de ([213.133.104.62]:34430 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBWArK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 19:47:10 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gxLT3-0003zb-H9; Sat, 23 Feb 2019 01:47:01 +0100
Received: from [178.197.248.36] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gxLT3-000FP5-7S; Sat, 23 Feb 2019 01:47:01 +0100
Subject: Re: INFO: task hung in rtnetlink_rcv_msg
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Joe Perches <joe@perches.com>
Cc:     syzbot <syzbot+8218a8a0ff60c19b8eae@syzkaller.appspotmail.com>,
        ast@kernel.org, christian@brauner.io, davem@davemloft.net,
        dsahern@gmail.com, hawk@kernel.org, idosch@mellanox.com,
        john.fastabend@gmail.com, kafai@fb.com, ktkhai@virtuozzo.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        petrm@mellanox.com, roopa@cumulusnetworks.com,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        xdp-newbies@vger.kernel.org, yhs@fb.com
References: <000000000000c07a5805827e85d5@google.com>
 <20190222120129.1f2f1c17@cakuba.netronome.com>
 <e049375f676938b5ad64898ac928b27cd783dc2a.camel@perches.com>
 <20190222134511.13eb7a82@cakuba.netronome.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <279c5bae-0b18-b03a-2858-4749e18afa26@iogearbox.net>
Date:   Sat, 23 Feb 2019 01:47:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190222134511.13eb7a82@cakuba.netronome.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25368/Fri Feb 22 11:32:58 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2019 10:45 PM, Jakub Kicinski wrote:
> On Fri, 22 Feb 2019 12:14:57 -0800, Joe Perches wrote:
>> On Fri, 2019-02-22 at 12:01 -0800, Jakub Kicinski wrote:
>>> Hi!
>>>
>>> Seems like something funny is going on with get_maintainer.pl since XDP
>>> entry got added.  We seem to have been CCed on:  
>>
>> I suggest removing the MAINTAINERS line with
>>
>> 	K:	xdp
>>
>> as xdp is a pretty generic file/patch content
>> regex match for the K: type
>>
>> $ git grep --name-only xdp | wc -l
>> 236
>>
>> Rather more files than desired.
>>
>> The N: match is dubious too.
>>
>> It's generally better to have specific lists of
>> maintained file patterns rather than using the
>> K: and N: pattern matches.
>>
>> ---
>>  MAINTAINERS | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d7ad97b235ec..aa703e2cb882 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -16970,7 +16970,6 @@ F:	include/net/xdp.h
>>  F:	kernel/bpf/devmap.c
>>  F:	kernel/bpf/cpumap.c
>>  F:	include/trace/events/xdp.h
>> -K:	xdp
>>  N:	xdp
>>  
>>  XDP SOCKETS (AF_XDP)
> 
> Thanks for the explanation, at least now I know why it happens! :)
> I'll leave it to Daniel to decide if we really need it removed, 
> so far the false positives weren't overwhelming, just surprising.

No strong opinion. I've seen this K+N pattern in a number of places
in the maintainers file. I'm fine either way if it gets too noisy. :)
