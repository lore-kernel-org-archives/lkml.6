Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD85C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280C4214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280C4214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbeIRVOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 17:14:21 -0400
Received: from www62.your-server.de ([213.133.104.62]:40981 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbeIRVOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 17:14:21 -0400
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1g2I7d-0007Oz-Dc; Tue, 18 Sep 2018 17:41:05 +0200
Received: from [178.197.249.15] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1g2I7d-0007Bm-59; Tue, 18 Sep 2018 17:41:05 +0200
Subject: Re: linux-next: Tree for Sep 18 (kernel/bpf/syscall)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, ppenkov@google.com,
        willemb@google.com
References: <20180918151235.4284275f@canb.auug.org.au>
 <0dc91212-54e8-d2f0-a4e3-30a468c20b8d@infradead.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a1129d67-97e3-8f10-c938-0de72fee9377@iogearbox.net>
Date:   Tue, 18 Sep 2018 17:41:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <0dc91212-54e8-d2f0-a4e3-30a468c20b8d@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.1/24952/Tue Sep 18 15:13:17 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Cc Petar and Willem ]

On 09/18/2018 05:37 PM, Randy Dunlap wrote:
> On 9/17/18 10:12 PM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20180913:
> 
> on i386 or x86_64: (in 6 of 20 randconfigs)
> 
> kernel/bpf/syscall.o: In function `__x64_sys_bpf':
> syscall.c:(.text+0x3278): undefined reference to `skb_flow_dissector_bpf_prog_attach'
> syscall.c:(.text+0x3310): undefined reference to `skb_flow_dissector_bpf_prog_detach'
> kernel/bpf/syscall.o:(.rodata+0x3f0): undefined reference to `flow_dissector_prog_ops'
> kernel/bpf/verifier.o:(.rodata+0x250): undefined reference to `flow_dissector_verifier_ops'
> 
> Full randconfig file is attached.

Looks like we need a wrapper for these, config had:

# CONFIG_NET is not set
