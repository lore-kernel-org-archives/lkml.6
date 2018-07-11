Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34A2C43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 22:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5E920C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 22:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5E920C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389564AbeGKWTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 18:19:12 -0400
Received: from www62.your-server.de ([213.133.104.62]:47456 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732561AbeGKWTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 18:19:12 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fdNLk-00062P-5u; Thu, 12 Jul 2018 00:12:40 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fdNLk-000Xv3-1l; Thu, 12 Jul 2018 00:12:40 +0200
Subject: Re: [PATCH bpf v2 1/1] bpf: btf: Fix bitfield extraction for big
 endian
To:     Martin KaFai Lau <kafai@fb.com>, Okash Khawaja <osk@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20180710213306.646146378@fb.com>
 <20180710214522.339195416@fb.com>
 <20180710234528.2kj2kv7gjmigvvgp@kafai-mbp.dhcp.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c412920a-d69f-5202-bb1a-21c717f9236c@iogearbox.net>
Date:   Thu, 12 Jul 2018 00:12:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180710234528.2kj2kv7gjmigvvgp@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24744/Wed Jul 11 22:56:24 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 01:46 AM, Martin KaFai Lau wrote:
> On Tue, Jul 10, 2018 at 02:33:07PM -0700, Okash Khawaja wrote:
>> When extracting bitfield from a number, btf_int_bits_seq_show() builds
>> a mask and accesses least significant byte of the number in a way
>> specific to little-endian. This patch fixes that by checking endianness
>> of the machine and then shifting left and right the unneeded bits.
>>
>> Thanks to Martin Lau for the help in navigating potential pitfalls when
>> dealing with endianess and for the final solution.
>>
>> Fixes: b00b8daec828 ("bpf: btf: Add pretty print capability for data with BTF type info")
>> Signed-off-by: Okash Khawaja <osk@fb.com>
> Acked-by: Martin KaFai Lau <kafai@fb.com>

Applied to bpf, thanks Okash!
