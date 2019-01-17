Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D8BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48ACC205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfAQP47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:56:59 -0500
Received: from www62.your-server.de ([213.133.104.62]:36176 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbfAQP47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:56:59 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gkA2I-0003ur-5B; Thu, 17 Jan 2019 16:56:54 +0100
Received: from [178.197.248.17] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gkA2H-000W2x-VN; Thu, 17 Jan 2019 16:56:54 +0100
Subject: Re: [PATCH] bpf: Make function btf_name_offset_valid static
To:     Martin Lau <kafai@fb.com>, Mathieu Malaterre <malat@debian.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190116192940.32104-1-malat@debian.org>
 <20190116211627.bs3rrolbjdsxkyvp@kafai-mbp.dhcp.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <06e9a2f2-50f9-99af-9fe8-51dd5425fbb7@iogearbox.net>
Date:   Thu, 17 Jan 2019 16:56:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190116211627.bs3rrolbjdsxkyvp@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25306/Thu Jan 17 11:24:24 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/16/2019 10:16 PM, Martin Lau wrote:
> On Wed, Jan 16, 2019 at 08:29:40PM +0100, Mathieu Malaterre wrote:
>> Initially in commit 69b693f0aefa ("bpf: btf: Introduce BPF Type Format
>> (BTF)") the function 'btf_name_offset_valid' was introduced as static
>> function it was later on changed to a non-static one, and then finally
>> in commit c454a46b5efd ("bpf: Add bpf_line_info support") the function
>> prototype was removed.
> Instead of c454a46b5efd, it was removed from btf.h in
> commit 23127b33ec80 ("bpf: Create a new btf_name_by_offset() for non type name use case")
> 
>>
>> Revert back to original implementation and make the function static.
>> Remove warning triggered with W=1:
>>
>>   kernel/bpf/btf.c:470:6: warning: no previous prototype for 'btf_name_offset_valid' [-Wmissing-prototypes]
>>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> Fixes: 23127b33ec80 ("bpf: Create a new btf_name_by_offset() for non type name use case")
> 
> Thanks for the fix!
> 
> Other than the above,
> 
> Acked-by: Martin KaFai Lau <kafai@fb.com>

Applied to bpf and fixed up commit reference. Thanks!
