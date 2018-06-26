Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70557C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2641926EF5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 18:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2641926EF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753121AbeFZSWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 14:22:46 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:37935 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752656AbeFZSWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 14:22:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 3AE042177D;
        Tue, 26 Jun 2018 18:22:44 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QNKPiyWo7RcE; Tue, 26 Jun 2018 18:22:44 +0000 (UTC)
Received: from [172.20.4.200] (unknown [50.236.218.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id B824221412;
        Tue, 26 Jun 2018 18:22:35 +0000 (UTC)
Subject: Re: [PATCH] selftests/net: Fix permissions for fib_tests.sh
To:     =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>,
        shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Cc:     "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
References: <1529425232-25242-1-git-send-email-daniel.diaz@linaro.org>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <8f5b0575-2213-5f7a-5b08-7502f65a1d16@kernel.org>
Date:   Tue, 26 Jun 2018 12:22:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529425232-25242-1-git-send-email-daniel.diaz@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/2018 10:20 AM, Daniel Díaz wrote:
> fib_tests.sh became non-executable at some point. This is
> what happens:
>   selftests: net: fib_tests.sh: Warning: file fib_tests.sh is
>   not executable, correct this.
>   not ok 1..11 selftests: net: fib_tests.sh [FAIL]
> 
> Fixes: d69faad76584 ("selftests: fib_tests: Add prefix route tests with metric")
> 
> Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
> ---
>  tools/testing/selftests/net/fib_tests.sh | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 tools/testing/selftests/net/fib_tests.sh
> 
> diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
> old mode 100644
> new mode 100755
> 

Hi David,

Are you planning to pick this up for 4.18-rc3 or later?

Acked-by: Shuah Khan <shuah@kernel.org>

thanks,
-- Shuah
