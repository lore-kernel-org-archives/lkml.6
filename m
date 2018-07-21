Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA88ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 23:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A52C2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 23:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A52C2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbeGVAQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 20:16:20 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46444 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbeGVAQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 20:16:20 -0400
Received: from localhost (unknown [172.58.43.158])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 20821121675D1;
        Sat, 21 Jul 2018 16:21:52 -0700 (PDT)
Date:   Sat, 21 Jul 2018 16:21:51 -0700 (PDT)
Message-Id: <20180721.162151.2056706808480433302.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     kafai@fb.com, yuehaibing@huawei.com, ast@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next] bpfilter: Fix mismatch in function
 argument types
From:   David Miller <davem@davemloft.net>
In-Reply-To: <9c9f981b-7d1e-1bb2-6771-727fc762c7c5@iogearbox.net>
References: <20180719075659.9800-1-yuehaibing@huawei.com>
        <20180719154817.ycwupljsx4ghkhom@kafai-mbp.dhcp.thefacebook.com>
        <9c9f981b-7d1e-1bb2-6771-727fc762c7c5@iogearbox.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 21 Jul 2018 16:21:52 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Thu, 19 Jul 2018 17:51:41 +0200

> On 07/19/2018 05:48 PM, Martin KaFai Lau wrote:
>> On Thu, Jul 19, 2018 at 03:56:59PM +0800, YueHaibing wrote:
>>> Fix following warning:
>>> net/ipv4/bpfilter/sockopt.c:28:5: error: symbol 'bpfilter_ip_set_sockopt' redeclared with different type
>>> net/ipv4/bpfilter/sockopt.c:34:5: error: symbol 'bpfilter_ip_get_sockopt' redeclared with different type
>>>
>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> LGTM.  Missing a Fixes tag though.
>> 
>> Fixes: d2ba09c17a06 ("net: add skeleton of bpfilter kernel module")
>> Acked-by: Martin KaFai Lau <kafai@fb.com>
> 
> (Should go to -net tree.)
> 
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>

Applied.
