Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C2FC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 117BD20878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 117BD20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbeJHPvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:51:36 -0400
Received: from www62.your-server.de ([213.133.104.62]:35350 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbeJHPvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:51:36 -0400
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1g9R5v-0008UB-2p; Mon, 08 Oct 2018 10:40:51 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1g9R5u-0004sg-Pm; Mon, 08 Oct 2018 10:40:50 +0200
Subject: Re: [PATCH] bpf: fix building without CONFIG_INET
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     Song Liu <liu.song.a23@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        makita.toshiaki@lab.ntt.co.jp, Lawrence Brakmo <brakmo@fb.com>,
        Andrey Ignatov <rdna@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Mathieu Xhonneux <m.xhonneux@gmail.com>, dsahern@gmail.com,
        Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20181005161526.843924-1-arnd@arndb.de>
 <CAPhsuW7pg9Wp5am3Kc1t3UoAG1=EYzUeq8E2k7Pmv8yGu9JaEQ@mail.gmail.com>
 <c4b5f1af-075a-4166-4108-81acda663970@iogearbox.net>
Message-ID: <9330215e-27bf-9913-f7f9-6b5b83542a27@iogearbox.net>
Date:   Mon, 8 Oct 2018 10:40:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <c4b5f1af-075a-4166-4108-81acda663970@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.1/25017/Mon Oct  8 06:49:45 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2018 09:07 PM, Daniel Borkmann wrote:
> On 10/05/2018 09:02 PM, Song Liu wrote:
> [...]
>> BPF_CALL_x() has static already (before this patch). We should not
>> need change that
>> for all the BPF_CALL_?(). Joe's version looks better to me.
> 
> My preference as well, thanks!

ping, can someone send an updated patch?

Thanks,
Daniel
