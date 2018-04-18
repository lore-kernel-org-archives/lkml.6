Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4/qoeMh1VeuVflUEAqDhpBCCTf1jIdw8qUk8I59TAye2ujGJKXWEt38vapa97w5jj9IyCV+
ARC-Seal: i=1; a=rsa-sha256; t=1524063287; cv=none;
        d=google.com; s=arc-20160816;
        b=uZ7ff0kpYuExmBWL23jac4UTov/03Y1Dqld9byNi6LKvHEfMsm1eh5xnS9TbIsS9iV
         EC3v9UphediTnmPUl5QeB2KpAZxYRMEJT6/Yvu1AXajj8jLBwiZ2fQ0H5oZKpfSY7JkY
         KGBWLgHxlH8b9fPQ3ONaOrUskVGZSIFBIxVubFOyLkEnKz52aeyuIwaC9k9ufA+AzeB5
         SgowG9H3m1K4YD13I2vAOzNzMbSz1pbZ/R6BK7DKCztwya1qUSJOyEhlTGVFtFR4T+YU
         NdoW5EtKshNm1LabvRuE0JvCR4j9ywUJ2MPpCxE2QJzVzc8lvhxzBhkaMiOyL4lWEW0F
         1CBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=1+sh+4mBgmiexqhkD8+90J1hVAqNX1PR0zZByawoT7I=;
        b=QzG3szrjhdlQLCvpYwvxdu0dkQhjtcvCt6AW58jfFuF+/WlOBjZ6ETxs/Rs5Ba+xEL
         n0Nyc6R2nm1Vm2oBcmOQMlUNj7Z91G9ChPdNF3CT5yd81TYEXkwhxVwjcC1ZvztM0u8X
         /xT61MfGVKfOwqXJwpltqq/1UZOC+KNfYU0aaYPDcsFOtCQUQ6Eu/KtoFwb8uAMfKwSq
         zPp2v+80qQhNPBWZycgrQv7BnlnIuALblduwZkhSIlOcJtIID0vcC/6XUshTMRMjUVzI
         +VthV1yf1XX7mkRXZg+zRa0kykUV0e8s/F2P57BabNcPo3Y6sFIIrAC4tmGrb9Cpv2NV
         eMJg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeDROyr (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 18 Apr 2018 10:54:47 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:37717 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbeDROyq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Apr 2018 10:54:46 -0400
Subject: Re: [PATCH 2/2] selftests/filesystems: remove Makefile warning
To: Anders Roxell <anders.roxell@linaro.org>,
        christian.brauner@ubuntu.com
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>
References: <20180418075256.300-1-anders.roxell@linaro.org>
 <20180418075256.300-2-anders.roxell@linaro.org>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <21de28f0-41c2-feac-1fec-63a2d76a2398@kernel.org>
Date: Wed, 18 Apr 2018 08:54:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418075256.300-2-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598069678446839048?=
X-GMAIL-MSGID: =?utf-8?q?1598096186553274449?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/18/2018 01:52 AM, Anders Roxell wrote:
> When overriding the 'clean' target make throws up warnings:
> Makefile:9: warning: overriding recipe for target 'clean'
> ../lib.mk:98: warning: ignoring old recipe for target 'clean'
> 
> In current code we change from TEST_PROGS to TEST_GEN_PROGS and that
> does that we can remove the target 'clean' and 'all'.
> 
> Fixes: 10924bc64487 ("selftests: move dnotify_test from Documentation/filesystems")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/testing/selftests/filesystems/Makefile | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
> index 427a401aae5c..a55ac3ac09ad 100644
> --- a/tools/testing/selftests/filesystems/Makefile
> +++ b/tools/testing/selftests/filesystems/Makefile
> @@ -1,9 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -TEST_PROGS := dnotify_test devpts_pts
> +TEST_GEN_PROGS := dnotify_test devpts_pts
>  CFLAGS += -I../../../../usr/include/
> -all: $(TEST_PROGS)
>  
>  include ../lib.mk
> -
> -clean:
> -	rm -fr $(TEST_PROGS)
> 

Hi Anders,

Michael sent in a patch to fix the problem already. It is in linux-kselftest fixes
branch for 4.17-rc2

Classifying dnotify_test to TEST_GEN_PROGS_EXTENDED as Michael is the correct way
to handle this problem. It allows the test to be built and installed and it won't
be run in the main kselftest run.

thanks,
-- Shuah
