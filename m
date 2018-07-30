Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76FFFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FE120894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="cv7t43ZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88FE120894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbeG3Rtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:49:39 -0400
Received: from mail.efficios.com ([167.114.142.138]:47948 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbeG3Rtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:49:39 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B2DED2221FD;
        Mon, 30 Jul 2018 12:13:56 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id yNYWb3vVeXas; Mon, 30 Jul 2018 12:13:56 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0E3C32221FA;
        Mon, 30 Jul 2018 12:13:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0E3C32221FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1532967236;
        bh=kL7G+pmB51YL4B4F+wsZxrlskg3NrA8X+12wToJc4XA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=cv7t43ZDF8159pfr/q5mZU5XD1uH+neJFaBI6Sg70O+tFN6HWYpS0BfdjFwby6F9y
         cpiystyaA8bH8/RZ0YXIE3w7eG4FykkxEaNmHLteCiVmVisOrPueq2hQagL2IlPGgx
         obWAHNTjmnlAGmr1USHEnqp09KZscl2ffCBTkw0Ako+1jzX1+h779Q+ClFZ5IuAmie
         JQwTPJPX1AaLWn5ob7q123b/ero1LEWAt0vNw81Hb738HVQ2qL+S1ZoQJhq1A5K7BU
         ZpRMAgwD0v/y+31ZM+voChk6/03gd/cstbmBBPKtPQBy+QLftWzwQ2QP6wcHz46it5
         tMcLtEIbNbB+g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id Xfj5S5GxdmyI; Mon, 30 Jul 2018 12:13:55 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id EC8792221F4;
        Mon, 30 Jul 2018 12:13:55 -0400 (EDT)
Date:   Mon, 30 Jul 2018 12:13:55 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, shuah <shuah@kernel.org>
Message-ID: <1707195302.6878.1532967235729.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180730160543.19056-1-rafael.tinoco@linaro.org>
References: <20180730160543.19056-1-rafael.tinoco@linaro.org>
Subject: Re: [PATCH] selftests: membarrier: fix test by checking supported
 commands
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.9_GA_2055 (ZimbraWebClient - FF52 (Linux)/8.8.9_GA_2055)
Thread-Topic: selftests: membarrier: fix test by checking supported commands
Thread-Index: gC7rtGZRI892WrK54MrCEBd66MtWAw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 30, 2018, at 12:05 PM, Rafael David Tinoco rafael.tinoco@linaro.org wrote:

> Makes membarrier_test compatible with older kernels (LTS) by checking if
> the membarrier features exist before running the tests.
> 
> Link: https://bugs.linaro.org/show_bug.cgi?id=3771
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
> Cc: <stable@vger.kernel.org> #v4.17

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks!

Mathieu

> ---
> .../selftests/membarrier/membarrier_test.c    | 69 +++++++++++--------
> 1 file changed, 41 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/testing/selftests/membarrier/membarrier_test.c
> b/tools/testing/selftests/membarrier/membarrier_test.c
> index 6793f8ecc8e7..b96caa096e2f 100644
> --- a/tools/testing/selftests/membarrier/membarrier_test.c
> +++ b/tools/testing/selftests/membarrier/membarrier_test.c
> @@ -225,7 +225,14 @@ static int test_membarrier_global_expedited_success(void)
> 
> static int test_membarrier(void)
> {
> -	int status;
> +	int supported, status;
> +
> +	supported = sys_membarrier(MEMBARRIER_CMD_QUERY, 0);
> +	if (supported < 0) {
> +		ksft_test_result_fail(
> +			"sys_membarrier() failed to query supported cmds\n");
> +		return supported;
> +	}
> 
> 	status = test_membarrier_cmd_fail();
> 	if (status)
> @@ -236,21 +243,22 @@ static int test_membarrier(void)
> 	status = test_membarrier_global_success();
> 	if (status)
> 		return status;
> -	status = test_membarrier_private_expedited_fail();
> -	if (status)
> -		return status;
> -	status = test_membarrier_register_private_expedited_success();
> -	if (status)
> -		return status;
> -	status = test_membarrier_private_expedited_success();
> -	if (status)
> -		return status;
> -	status = sys_membarrier(MEMBARRIER_CMD_QUERY, 0);
> -	if (status < 0) {
> -		ksft_test_result_fail("sys_membarrier() failed\n");
> -		return status;
> +
> +	/* commit 22e4ebb975822833b083533035233d128b30e98f added this feature */
> +	if (supported & MEMBARRIER_CMD_PRIVATE_EXPEDITED) {
> +		status = test_membarrier_private_expedited_fail();
> +		if (status)
> +			return status;
> +		status = test_membarrier_register_private_expedited_success();
> +		if (status)
> +			return status;
> +		status = test_membarrier_private_expedited_success();
> +		if (status)
> +			return status;
> 	}
> -	if (status & MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE) {
> +
> +	/* commit 70216e18e519a54a2f13569e8caff99a092a92d6 added this feature */
> +	if (supported & MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE) {
> 		status = test_membarrier_private_expedited_sync_core_fail();
> 		if (status)
> 			return status;
> @@ -261,19 +269,24 @@ static int test_membarrier(void)
> 		if (status)
> 			return status;
> 	}
> -	/*
> -	 * It is valid to send a global membarrier from a non-registered
> -	 * process.
> -	 */
> -	status = test_membarrier_global_expedited_success();
> -	if (status)
> -		return status;
> -	status = test_membarrier_register_global_expedited_success();
> -	if (status)
> -		return status;
> -	status = test_membarrier_global_expedited_success();
> -	if (status)
> -		return status;
> +
> +	/* commit c5f58bd58f432be5d92df33c5458e0bcbee3aadf added this feature */
> +	if (supported & MEMBARRIER_CMD_GLOBAL_EXPEDITED) {
> +		/*
> +		 * It is valid to send a global membarrier from a non-registered
> +		 * process.
> +		 */
> +		status = test_membarrier_global_expedited_success();
> +		if (status)
> +			return status;
> +		status = test_membarrier_register_global_expedited_success();
> +		if (status)
> +			return status;
> +		status = test_membarrier_global_expedited_success();
> +		if (status)
> +			return status;
> +	}
> +
> 	return 0;
> }
> 
> --
> 2.18.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
