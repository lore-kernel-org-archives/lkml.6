Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A88C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E2121773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbfBTBH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:07:56 -0500
Received: from www62.your-server.de ([213.133.104.62]:33972 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfBTBH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 20:07:56 -0500
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gwG4I-0002BX-Ma; Wed, 20 Feb 2019 01:48:58 +0100
Received: from [178.197.248.36] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gwG4I-0003Dm-Er; Wed, 20 Feb 2019 01:48:58 +0100
Subject: Re: linux-next: manual merge of the net-next tree with the bpf tree
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>
References: <20190220113729.49f28f73@canb.auug.org.au>
 <CAADnVQK3qg2k67LRiOqDmFnELrFOD1dLkrNbAvbMyu6xGpjBLw@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <791e9e85-411e-385b-302f-4a4224f76286@iogearbox.net>
Date:   Wed, 20 Feb 2019 01:48:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQK3qg2k67LRiOqDmFnELrFOD1dLkrNbAvbMyu6xGpjBLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25365/Tue Feb 19 11:36:48 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20/2019 01:41 AM, Alexei Starovoitov wrote:
> On Tue, Feb 19, 2019 at 4:37 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi all,
>>
>> Today's linux-next merge of the net-next tree got a conflict in:
>>
>>   tools/testing/selftests/bpf/test_progs.c
>>
>> between commit:
>>
>>   f6be4d16039b ("selftests/bpf: make sure signal interrupts BPF_PROG_TEST_RUN")
> 
> Ouch. Thanks for the heads up.
> 
> Daniel,
> should we drop this one from bpf tree ?
> I don't think it's strictly necessary.

Yeah no objections, lets move the selftest one over to bpf-next and
have it properly integrated. I think test_progs might potentially need
further topic-split aside from kernel progs like we did in test_verifier.

>> from the bpf tree and commits:
>>
>>   bf0f0fd93945 ("selftests/bpf: add simple BPF_PROG_TEST_RUN examples for flow dissector")
>>   ab963beb9f5d ("selftests/bpf: add bpf_spin_lock C test")
>>   ba72a7b4badb ("selftests/bpf: test for BPF_F_LOCK")
