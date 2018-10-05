Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB64C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42E42084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42E42084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbeJEWvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:51:23 -0400
Received: from www62.your-server.de ([213.133.104.62]:41268 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbeJEWvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:51:23 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1g8SOR-0002ub-I4; Fri, 05 Oct 2018 17:51:55 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1g8SOR-000HJa-Cy; Fri, 05 Oct 2018 17:51:55 +0200
Subject: Re: linux-next: Tree for Oct 5 (net/core/filter.c)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, joe@wand.net.nz
References: <20181005163943.3f8d4f32@canb.auug.org.au>
 <51ea61d3-032b-f316-4a61-b63ab208d8d4@infradead.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e5a04d2f-df44-4616-5621-23d7738353d6@iogearbox.net>
Date:   Fri, 5 Oct 2018 17:51:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <51ea61d3-032b-f316-4a61-b63ab208d8d4@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.1/25009/Fri Oct  5 14:48:12 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ +Joe ]

On 10/05/2018 05:42 PM, Randy Dunlap wrote:
> On 10/4/18 11:39 PM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20181004:
>>
> 
> on i386 or x86_64:
> 
> net/core/filter.o: In function `bpf_sk_release':
> filter.c:(.text+0x3c5c): undefined reference to `sock_gen_put'
> net/core/filter.o: In function `sk_lookup':
> filter.c:(.text+0x79a5): undefined reference to `tcp_hashinfo'
> filter.c:(.text+0x79bc): undefined reference to `__inet_lookup_established'
> filter.c:(.text+0x79eb): undefined reference to `tcp_hashinfo'
> filter.c:(.text+0x79f3): undefined reference to `__inet_lookup_listener'
> filter.c:(.text+0x7a14): undefined reference to `udp_table'
> filter.c:(.text+0x7a26): undefined reference to `__udp4_lib_lookup'
> 
> 
> Full randconfig file is attached.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> 

