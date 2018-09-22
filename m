Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5060AECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 01:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6152156F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 01:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6152156F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391709AbeIVG7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:59:44 -0400
Received: from www62.your-server.de ([213.133.104.62]:40561 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbeIVG7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:59:42 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1g3WP6-00025J-Jq; Sat, 22 Sep 2018 03:08:12 +0200
Received: from [178.197.248.13] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1g3WP6-0006J8-Db; Sat, 22 Sep 2018 03:08:12 +0200
Subject: Re: [PATCH] bpf: remove redundant null pointer check before
 consume_skb
To:     zhong jiang <zhongjiang@huawei.com>, ast@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1537436772-42545-1-git-send-email-zhongjiang@huawei.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <88373125-31a3-59ca-5bc7-72f6de0421ec@iogearbox.net>
Date:   Sat, 22 Sep 2018 03:08:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1537436772-42545-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.1/24968/Fri Sep 21 22:48:02 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/20/2018 11:46 AM, zhong jiang wrote:
> consume_skb has taken the null pointer into account. hence it is safe
> to remove the redundant null pointer check before consume_skb.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Applied to bpf-next, thanks Zhong!
