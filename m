Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAD3C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FBE120856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FBE120856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbeGSQfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:35:36 -0400
Received: from www62.your-server.de ([213.133.104.62]:50218 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730899AbeGSQfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:35:36 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fgBDS-0003Qn-F3; Thu, 19 Jul 2018 17:51:42 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fgBDS-000PpR-9u; Thu, 19 Jul 2018 17:51:42 +0200
Subject: Re: [PATCH v2 bpf-next] bpfilter: Fix mismatch in function argument
 types
To:     Martin KaFai Lau <kafai@fb.com>, YueHaibing <yuehaibing@huawei.com>
Cc:     ast@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20180719075659.9800-1-yuehaibing@huawei.com>
 <20180719154817.ycwupljsx4ghkhom@kafai-mbp.dhcp.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9c9f981b-7d1e-1bb2-6771-727fc762c7c5@iogearbox.net>
Date:   Thu, 19 Jul 2018 17:51:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180719154817.ycwupljsx4ghkhom@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24763/Thu Jul 19 10:39:52 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19/2018 05:48 PM, Martin KaFai Lau wrote:
> On Thu, Jul 19, 2018 at 03:56:59PM +0800, YueHaibing wrote:
>> Fix following warning:
>> net/ipv4/bpfilter/sockopt.c:28:5: error: symbol 'bpfilter_ip_set_sockopt' redeclared with different type
>> net/ipv4/bpfilter/sockopt.c:34:5: error: symbol 'bpfilter_ip_get_sockopt' redeclared with different type
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> LGTM.  Missing a Fixes tag though.
> 
> Fixes: d2ba09c17a06 ("net: add skeleton of bpfilter kernel module")
> Acked-by: Martin KaFai Lau <kafai@fb.com>

(Should go to -net tree.)

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
