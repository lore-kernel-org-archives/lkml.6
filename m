Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A23CC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF3F206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF3F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbeG0DIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 23:08:20 -0400
Received: from www62.your-server.de ([213.133.104.62]:59667 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731974AbeG0DIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 23:08:20 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1firs9-0005Uh-TU; Fri, 27 Jul 2018 03:48:49 +0200
Received: from [99.0.85.34] (helo=localhost.localdomain)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1firs9-000VOe-Ii; Fri, 27 Jul 2018 03:48:49 +0200
Subject: Re: [PATCH v2 bpf-next] samples/bpf: xdpsock: order memory on AArch64
To:     Brian Brooks <brian.brooks@linaro.org>, ast@kernel.org,
        bjorn.topel@intel.com, magnus.karlsson@intel.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180725210819.1458-1-brian.brooks@linaro.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ba54c52a-ed99-3eee-2753-15c5b6fc5cb5@iogearbox.net>
Date:   Fri, 27 Jul 2018 03:48:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180725210819.1458-1-brian.brooks@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24786/Fri Jul 27 02:41:39 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/25/2018 11:08 PM, Brian Brooks wrote:
> Define u_smp_rmb() and u_smp_wmb() to respective barrier instructions.
> This ensures the processor will order accesses to queue indices against
> accesses to queue ring entries.
> 
> Signed-off-by: Brian Brooks <brian.brooks@linaro.org>

Applied to bpf-next, thanks Brian!
