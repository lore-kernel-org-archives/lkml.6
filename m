Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3044CC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24C526883
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24C526883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934354AbeFZKHr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:07:47 -0400
Received: from www62.your-server.de ([213.133.104.62]:45759 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932189AbeFZKHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:07:44 -0400
Received: from [62.203.87.61] (helo=linux.home)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fXksw-0008Tt-Dz; Tue, 26 Jun 2018 12:07:42 +0200
Subject: Re: [PATCH] selftests: bpf: enable NET_SCHED
To:     Anders Roxell <anders.roxell@linaro.org>, ast@kernel.org,
        shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20180625145605.13726-1-anders.roxell@linaro.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <76182da2-d261-8747-610f-8506e3d96daf@iogearbox.net>
Date:   Tue, 26 Jun 2018 12:07:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180625145605.13726-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24697/Tue Jun 26 06:38:09 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/2018 04:56 PM, Anders Roxell wrote:
> CONFIG_NET_SCHED wasn't enabled in arm64's defconfig only for x86.
> So bpf/test_tunnel.sh tests fails with:
> RTNETLINK answers: Operation not supported
> RTNETLINK answers: Operation not supported
> We have an error talking to the kernel, -1
> Enable NET_SCHED and more tests passes.
> 
> Fixes: 3bce593ac06b ("selftests: bpf: config: add config fragments")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Applied to bpf, thanks Anders!
