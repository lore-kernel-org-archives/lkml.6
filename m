Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68376ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B79920874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B79920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388286AbeGWXjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:39:32 -0400
Received: from www62.your-server.de ([213.133.104.62]:36471 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388088AbeGWXjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:39:32 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fhjQz-0002Yv-Rj; Tue, 24 Jul 2018 00:36:05 +0200
Received: from [99.0.85.34] (helo=localhost.localdomain)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fhjQz-000Aib-Ib; Tue, 24 Jul 2018 00:36:05 +0200
Subject: Re: [PATCH] bpf: Add Python 3 support to selftests scripts for bpf
To:     Dan Rue <dan.rue@linaro.org>, Jeremy Cline <jcline@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Lawrence Brakmo <brakmo@fb.com>,
        jakub.kicinski@netronome.com
References: <20180718213610.19618-1-jcline@redhat.com>
 <1aa3dc98-2ab1-7386-d5d9-afd3dbb3fde9@iogearbox.net>
 <dd971e43-3148-5a54-788e-d89835d3638a@redhat.com>
 <20180723173313.ri2uz7srtdtno2hl@linode.therub.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f26dda36-cbfe-00ec-6a17-b18487a856af@iogearbox.net>
Date:   Tue, 24 Jul 2018 00:36:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180723173313.ri2uz7srtdtno2hl@linode.therub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24776/Mon Jul 23 18:44:17 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 07:33 PM, Dan Rue wrote:
> On Mon, Jul 23, 2018 at 10:08:57AM -0400, Jeremy Cline wrote:
>> On 07/20/2018 04:45 PM, Daniel Borkmann wrote:
>>> On 07/18/2018 11:36 PM, Jeremy Cline wrote:
>>>> Adjust tcp_client.py and tcp_server.py to work with Python 3 by using
>>>> the print function, marking string literals as bytes, and using the
>>>> newer exception syntax. This should be functionally equivalent and
>>>> support Python 2.6 through Python 3.7.
>>>>
>>>> Signed-off-by: Jeremy Cline <jcline@redhat.com>
>>>
>>> Thanks for the patch, Jeremy! Given we also have test_offload.py in BPF
>>> kselftests and it is written for python 3 only, it would probably make
>>> sense to adapt the tcp_{client,server}.py towards python 3 as well, so
>>> we wouldn't need to keep extra compat for 2 and have a consistent version
>>> dependency. Lawrence / Jeremy, any objections?
>>
>> I certainly don't object to Python 3 only and I'm happy to drop the
>> Python 2 compatibility from this patch if that's okay.

Sounds good, lets do it, please respin with that.

> This (well, along with introducing python in the first place, which took
> me by surprise), sounds like a policy decision that should be made clear
> in the kselftest documentation (Documentation/dev-tools/kselftest.rst).
> Currently, that file does not mention any python requirement.

Right now each selftest subdir has a config file which lists dependencies,
perhaps it makes sense to have another standardized file there (e.g. 'deps')
which lists user space dependencies, so it's immediately visible what is
needed to run all tests from there. Thoughts?

> That said, I agree that python2 support is no longer necessary.
> 
> My use-case (which may be unusual?): We try to run all of kselftest
> against a variety of kernels and architectures for every push to next,
> mainline, and stable/lts branches. It seems that this is not a common
> usecase, but shouldn't it be?

As far as I'm aware the intel lkp-tests bot seems also to regularly run
the kselftests for x86, if also done from arm side e.g. on latest mainline,
even better.

Thanks,
Daniel
