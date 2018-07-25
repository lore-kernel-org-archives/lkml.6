Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44451C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7C820852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7C820852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbeGYG4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 02:56:04 -0400
Received: from www62.your-server.de ([213.133.104.62]:43585 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbeGYG4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 02:56:04 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fiCcT-0007a1-DD; Wed, 25 Jul 2018 07:45:53 +0200
Received: from [2601:647:4601:b6c5::9c2f] (helo=localhost.localdomain)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fiCcT-000BbA-3f; Wed, 25 Jul 2018 07:45:53 +0200
Subject: Re: [PATCH bpf-next] bpf: btf: fix inconsistent IS_ERR and PTR_ERR
To:     YueHaibing <yuehaibing@huawei.com>, ast@kernel.org,
        quentin.monnet@netronome.com, jakub.kicinski@netronome.com,
        bhole_prashant_q7@lab.ntt.co.jp, osk@fb.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net
References: <20180724025524.22012-1-yuehaibing@huawei.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6c0b807c-56b8-7ac7-bd5c-49f438e2e10d@iogearbox.net>
Date:   Wed, 25 Jul 2018 07:45:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180724025524.22012-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24780/Wed Jul 25 02:42:30 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2018 04:55 AM, YueHaibing wrote:
> Fix inconsistent IS_ERR and PTR_ERR in get_btf,
> the proper pointer to be passed as argument is '*btf'
> 
> This issue was detected with the help of Coccinelle.
> 
> Fixes: 2d3feca8c44f ("bpf: btf: print map dump and lookup with btf info")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to bpf-next, thanks Yue!
