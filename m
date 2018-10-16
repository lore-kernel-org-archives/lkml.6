Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858ADC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443412083C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443412083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbeJPWlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:41:24 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:60389 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeJPWlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:41:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id F35924121C;
        Tue, 16 Oct 2018 14:50:35 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YsV3qY11owGr; Tue, 16 Oct 2018 14:50:35 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id B670240C39;
        Tue, 16 Oct 2018 14:50:29 +0000 (UTC)
Subject: Re: [PATCH] selftests: kvm: Fix -Wformat warnings
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20181016141346.19922-1-andrea.parri@amarulasolutions.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <2af4a102-f7ef-29bf-15a5-4b355e6d9be0@kernel.org>
Date:   Tue, 16 Oct 2018 08:50:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181016141346.19922-1-andrea.parri@amarulasolutions.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/2018 08:13 AM, Andrea Parri wrote:
> Fixes the following warnings:
> 
> dirty_log_test.c: In function ‘help’:
> dirty_log_test.c:216:9: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘int’ [-Wformat=]
>   printf(" -i: specify iteration counts (default: %"PRIu64")\n",
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from include/test_util.h:18:0,
>                  from dirty_log_test.c:16:
> /usr/include/inttypes.h:105:34: note: format string is defined here
>  # define PRIu64  __PRI64_PREFIX "u"
> dirty_log_test.c:218:9: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘int’ [-Wformat=]
>   printf(" -I: specify interval in ms (default: %"PRIu64" ms)\n",
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from include/test_util.h:18:0,
>                  from dirty_log_test.c:16:
> /usr/include/inttypes.h:105:34: note: format string is defined here
>  # define PRIu64  __PRI64_PREFIX "u"
> 
> Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> ---
>  tools/testing/selftests/kvm/dirty_log_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
> index 0c2cdc105f968..a9c4b5e21d7e7 100644
> --- a/tools/testing/selftests/kvm/dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
> @@ -31,9 +31,9 @@
>  /* How many pages to dirty for each guest loop */
>  #define  TEST_PAGES_PER_LOOP            1024
>  /* How many host loops to run (one KVM_GET_DIRTY_LOG for each loop) */
> -#define  TEST_HOST_LOOP_N               32
> +#define  TEST_HOST_LOOP_N               32UL
>  /* Interval for each host loop (ms) */
> -#define  TEST_HOST_LOOP_INTERVAL        10
> +#define  TEST_HOST_LOOP_INTERVAL        10UL
>  
>  /*
>   * Guest variables.  We use these variables to share data between host
> 

Thanks for the patch. Applied to linux-kselftest next for 4.20-rc1

thanks,
-- Shuah
