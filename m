Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EF4C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E6D27021
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E6D27021
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933995AbeF1HPu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:15:50 -0400
Received: from shards.monkeyblae.net ([23.128.96.9]:46968 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S933521AbeF1HPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:15:48 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5FE62125A7A1A;
        Thu, 28 Jun 2018 00:15:44 -0700 (PDT)
Date:   Thu, 28 Jun 2018 16:15:42 +0900 (KST)
Message-Id: <20180628.161542.1549781477221134232.davem@davemloft.net>
To:     shuah@kernel.org
Cc:     daniel.diaz@linaro.org, shuahkh@osg.samsung.com,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/net: Fix permissions for fib_tests.sh
From:   David Miller <davem@davemloft.net>
In-Reply-To: <8f5b0575-2213-5f7a-5b08-7502f65a1d16@kernel.org>
References: <1529425232-25242-1-git-send-email-daniel.diaz@linaro.org>
        <8f5b0575-2213-5f7a-5b08-7502f65a1d16@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 28 Jun 2018 00:15:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuah Khan <shuah@kernel.org>
Date: Tue, 26 Jun 2018 12:22:28 -0600

> On 06/19/2018 10:20 AM, Daniel Díaz wrote:
>> fib_tests.sh became non-executable at some point. This is
>> what happens:
>>   selftests: net: fib_tests.sh: Warning: file fib_tests.sh is
>>   not executable, correct this.
>>   not ok 1..11 selftests: net: fib_tests.sh [FAIL]
>> 
>> Fixes: d69faad76584 ("selftests: fib_tests: Add prefix route tests with metric")
>> 
>> Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
>> ---
>>  tools/testing/selftests/net/fib_tests.sh | 0
>>  1 file changed, 0 insertions(+), 0 deletions(-)
>>  mode change 100644 => 100755 tools/testing/selftests/net/fib_tests.sh
>> 
>> diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
>> old mode 100644
>> new mode 100755
>> 
> 
> Hi David,
> 
> Are you planning to pick this up for 4.18-rc3 or later?

Applied, thanks.
