Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82E1C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B8E2098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B8E2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbeHWUgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:36:01 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:33889 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeHWUgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:36:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 2C01F41481;
        Thu, 23 Aug 2018 17:05:22 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo03-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uNscSbXlAe61; Thu, 23 Aug 2018 17:05:22 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 6C2D240DA8;
        Thu, 23 Aug 2018 17:05:13 +0000 (UTC)
Subject: Re: [PATCH] selftests: android: move config up a level
To:     Anders Roxell <anders.roxell@linaro.org>, corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20180821161003.16737-1-anders.roxell@linaro.org>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <11b89e1a-1543-5774-13f8-e004c8fc46ef@kernel.org>
Date:   Thu, 23 Aug 2018 11:05:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180821161003.16737-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anders,

On 08/21/2018 10:10 AM, Anders Roxell wrote:
> 'make kselftest-merge' assumes that the config files for the tests are
> located under the 'main' test dir, like tools/testing/selftests/android/
> and not in a subdir to android.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  Documentation/dev-tools/kselftest.rst            | 2 +-
>  tools/testing/selftests/android/{ion => }/config | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename tools/testing/selftests/android/{ion => }/config (100%)

Please split this patch into two with the Doc change into as a separate
patch.

> 
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index 6f653acea248..dad1bb8711e2 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -159,7 +159,7 @@ Contributing new tests (details)
>   * If a test needs specific kernel config options enabled, add a config file in
>     the test directory to enable them.
>  
> -   e.g: tools/testing/selftests/android/ion/config
> +   e.g: tools/testing/selftests/android/config
>  
>  Test Harness
>  ============
> diff --git a/tools/testing/selftests/android/ion/config b/tools/testing/selftests/android/config
> similarity index 100%
> rename from tools/testing/selftests/android/ion/config
> rename to tools/testing/selftests/android/config
> 

thanks,
-- Shuah
