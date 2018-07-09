Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE921C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D3620878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D3620878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754564AbeGINes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:34:48 -0400
Received: from www62.your-server.de ([213.133.104.62]:57143 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754437AbeGINer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:34:47 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fcWJP-0001mi-Q3; Mon, 09 Jul 2018 15:34:43 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fcWJP-000Tq2-LU; Mon, 09 Jul 2018 15:34:43 +0200
Subject: Re: v4.18-rc4: slab-out-of-bounds in ___bpf_prog_run
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
References: <20180709123517.daw7bx3gvhnu5jqm@lakrids.cambridge.arm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ab5caede-dc95-8417-551e-fedf0b7da4a7@iogearbox.net>
Date:   Mon, 9 Jul 2018 15:34:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180709123517.daw7bx3gvhnu5jqm@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24736/Mon Jul  9 06:41:36 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2018 02:35 PM, Mark Rutland wrote:
> Hi,
> 
> While fuzzing v4.18-rc4 with Syzkaller, I hit a KASAN slab-out-of-bounds
> warning at ___bpf_prog_run+0x1f20 (splat at the end of this mail), which
> faddr2line tells me is kernel/bpf/core.c:1303.
> 
> I can reliably trigger this with the below C program, which I minimized from
> Syzkaller's auto-generated C reproducer.

Thanks Mark! Looking into it.
