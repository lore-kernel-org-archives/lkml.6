Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934209AbeEIKQW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 06:16:22 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46703 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934126AbeEIKQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 06:16:18 -0400
X-Google-Smtp-Source: AB8JxZo1KPQLzj7ejVLVxA58sJWLa1txu9eEQoXd7W9esRHbBJUbhnTtn47UTsP4q8m0GojgqDHfnA==
Date: Wed, 9 May 2018 11:46:09 +0200
From: Anders Roxell <anders.roxell@linaro.org>
To: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Cc: dvhart@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: futex: delete RUN_TESTS and EMIT_TESTS
 overrides
Message-ID: <20180509094609.GA10043@localhost.localdomain>
References: <20180502211848.22404-1-shuah@kernel.org>
 <20180502211848.22404-2-shuah@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180502211848.22404-2-shuah@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-02 15:18, Shuah Khan (Samsung OSG) wrote:
> Delete RUN_TESTS and EMIT_TESTS overrides and use common defines in
> lib.mk. Common defines work just fine and there is no need to define
> custom overrides.
> 
> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>

Reviewed-by: Anders Roxell <anders.roxell@linaro.org>

> ---
>  tools/testing/selftests/futex/Makefile | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/futex/Makefile b/tools/testing/selftests/futex/Makefile
> index 8497a376ef9d..12631f0076a1 100644
> --- a/tools/testing/selftests/futex/Makefile
> +++ b/tools/testing/selftests/futex/Makefile
> @@ -17,14 +17,6 @@ all:
>  		fi \
>  	done
>  
> -override define RUN_TESTS
> -	@export KSFT_TAP_LEVEL=`echo 1`;
> -	@echo "TAP version 13";
> -	@echo "selftests: futex";
> -	@echo "========================================";
> -	@cd $(OUTPUT); ./run.sh
> -endef
> -
>  override define INSTALL_RULE
>  	mkdir -p $(INSTALL_PATH)
>  	install -t $(INSTALL_PATH) $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES)
> @@ -36,10 +28,6 @@ override define INSTALL_RULE
>  	done;
>  endef
>  
> -override define EMIT_TESTS
> -	echo "./run.sh"
> -endef
> -
>  override define CLEAN
>  	@for DIR in $(SUBDIRS); do		\
>  		BUILD_TARGET=$(OUTPUT)/$$DIR;	\
> -- 
> 2.14.1
> 
