Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FBFC04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6400D214D9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6400D214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeK3NjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 08:39:00 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37376 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbeK3NjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 08:39:00 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so2019679plr.4;
        Thu, 29 Nov 2018 18:31:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qjqVkSEVhRY/EgI2bYPITqdHL/5CmZWka4mRMMCeiRw=;
        b=UBqy9jjVtvu2UhCvU5IDJUtMsAAAQ0e7pLXbM7F+oFMS7EAKrfzd5Rb94V8bBMus4B
         I7HxhxTRI0I6tb9FTodcKZLFwng8NYELUwwzW0bSYd3qzMK7J58FpZBPVVBFU+04DyH1
         0JEPQSuY+2vADX378PPUMjBduquZawAOz8fILw/N38DK4jnyshO/lVVWP0yZP/o6fy/K
         pD7qorL4clKPZkgX8EzuiNCqy3Ater60aCT7Ik6mMGTGEJ6fodc5VeEZCUU0fIfZDwgs
         NI1+pvS1Oxa5OyJUz/4lFtM+zlXv0qlNu8cRV9g/dP9NbOYwrgKrfXnEyfeNq5hDV4C1
         D0xA==
X-Gm-Message-State: AA+aEWZynyPRsagCI/lA3L74U60zAxzrVqNWZKSjW67nYZqyF97maozN
        o8YqVPbaXeuzmZf79SJbYVk=
X-Google-Smtp-Source: AFSGD/XsUJl8TLeRuv7vIHmbYAt9ouM4N9c5Vbcu7NHPY81zB75/XvGdnXtFYWqkQhgL6lcnPo3hIw==
X-Received: by 2002:a17:902:34a:: with SMTP id 68mr4014150pld.268.1543545079384;
        Thu, 29 Nov 2018 18:31:19 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id 78sm4394395pft.184.2018.11.29.18.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 18:31:17 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 29 Nov 2018 18:31:15 -0800
Date:   Thu, 29 Nov 2018 18:31:15 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dan Rue <dan.rue@linaro.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH 2/2] selftests: firmware: add
 CONFIG_FW_LOADER_USER_HELPER_FALLBACK to config
Message-ID: <20181130023115.GN4922@garbanzo.do-not-panic.com>
References: <20181127031218.24419-1-dan.rue@linaro.org>
 <20181127031218.24419-3-dan.rue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127031218.24419-3-dan.rue@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 09:12:16PM -0600, Dan Rue wrote:
> CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y is required for fw_fallback.sh.
> Without it, fw_fallback.sh fails with 'usermode helper disabled so
> ignoring test'. Enable the config in selftest so that it gets built by
> default.
> 
> Signed-off-by: Dan Rue <dan.rue@linaro.org>
> ---
>  tools/testing/selftests/firmware/config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/firmware/config b/tools/testing/selftests/firmware/config
> index bf634dda0720..913a25a4a32b 100644
> --- a/tools/testing/selftests/firmware/config
> +++ b/tools/testing/selftests/firmware/config
> @@ -1,5 +1,6 @@
>  CONFIG_TEST_FIRMWARE=y
>  CONFIG_FW_LOADER=y
>  CONFIG_FW_LOADER_USER_HELPER=y
> +CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
>  CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y

NACK -- the point of the changes was to *allow* us to mimic such
configuration through a proc sysctl knob.

You aren forcing CONFIG_FW_LOADER_USER_HELPER_FALLBACK but just having
CONFIG_FW_LOADER_USER_HELPER suffices to emulate the_FALLBACK
functionality.

The issue here seems to be that *all* tests fail once a configuration is
found which is not suitable a tests. With the shiny new proc sysctls we
can test all 3 kernel configurations in one shot. Since we test 3
different kernel configurations naturally some of these won't have the
features needed, so that failure should be treated as non-fatal to allow
the chain of other tests to continue.

This issue was a regression due to commit a6a9be9270c87 ("selftests:
firmware: return Kselftest Skip code for skipped tests") by Shuah for
the verify_reqs(). We need to treat this as a non-fatal / don't skip
return value.

The following would fix this chaining issue:

diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
index 6c5f1b2ffb74..1cbb12e284a6 100755
--- a/tools/testing/selftests/firmware/fw_lib.sh
+++ b/tools/testing/selftests/firmware/fw_lib.sh
@@ -91,7 +91,7 @@ verify_reqs()
 	if [ "$TEST_REQS_FW_SYSFS_FALLBACK" = "yes" ]; then
 		if [ ! "$HAS_FW_LOADER_USER_HELPER" = "yes" ]; then
 			echo "usermode helper disabled so ignoring test"
-			exit $ksft_skip
+			exit 0
 		fi
 	fi
 }

However its not clear to me if instead we want some new special return
value for selftests so that the framework can detect an that an error
is non-fatal, and can continue. This is a tricky situation given the
script, existing upstream kernel module, are aware of such emulation
hacks via sysctl, but knowledge of this is not obvious to selftests.

Shuah, how do you suggest we handle this corner case? If you are OK
with the above hunk for now I can send a fix for it. In either case
this commit was added on v4.18, so the fix would be a stable fix.

  Luis
