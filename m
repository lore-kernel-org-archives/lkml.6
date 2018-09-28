Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CB6C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E27C2170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 12:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E27C2170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbeI1S1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 14:27:01 -0400
Received: from www62.your-server.de ([213.133.104.62]:39031 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeI1S1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 14:27:00 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1g5rUZ-0001EL-DM; Fri, 28 Sep 2018 14:03:31 +0200
Received: from [178.197.248.15] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1g5rUZ-00011b-82; Fri, 28 Sep 2018 14:03:31 +0200
Subject: Re: [PATCH v3 bpf-next 03/10] bpf: introduce per-cpu cgroup local
 storage
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Roman Gushchin <guro@fb.com>
Cc:     netdev@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Alexei Starovoitov <ast@kernel.org>
References: <20180926113326.29069-1-guro@fb.com>
 <20180926113326.29069-4-guro@fb.com>
 <20180928084528.i5txkac34pmqvs3p@ast-mbp.dhcp.thefacebook.com>
 <20180928100302.GB9018@castle.DHCP.thefacebook.com>
 <20180928102458.dbia6xnxkijvkld6@ast-mbp.dhcp.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <21a7ecfb-c7cd-d7aa-01d1-4e055e410817@iogearbox.net>
Date:   Fri, 28 Sep 2018 14:03:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180928102458.dbia6xnxkijvkld6@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.1/24989/Fri Sep 28 10:53:45 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/2018 12:25 PM, Alexei Starovoitov wrote:
> On Fri, Sep 28, 2018 at 11:03:03AM +0100, Roman Gushchin wrote:
>>>> +
>>>> +	if (unlikely(map_flags & BPF_EXIST))
>>>> +		return -EINVAL;
>>>
>>> that should have been BPF_NOEXIST ?
>>
>> Yeah, or maybe even better s/&/!= ?
>> It's probably better to require BPF_EXIST flag to update a cgroup storage?
>> Agree? If so, let me fix this for both shared and per-cpu versions in
>> a follow-up patch.
> 
> I think BPF_ANY is technically valid too.
> If we were to require strict BPF_EXIST only, we'd need to fix stable too.
> I'm fine with both (BPF_EXIST only and BPF_ANY|BPF_EXIST).
> Daniel, what do you think?

I'm okay with either option, both seem plausible.
