Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F97C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD4620870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548186239;
	bh=ny44NMaG7VnW6FhpikVdpDqlUfJ1Au5HIN4jro8vDhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xlHWqJUq9MFHvIG77mG1CSIsPf4SoQAweHvNxW00YsmYj4zL6td8v26G78Xekqczh
	 RfATF7y2tn7biKdnZO3tMrvlBygPshk6tFCJz83QNUYSZr80fSvPlNAjOjSAy3LKCR
	 xekQwJYVQaHXgG+cHko88vVbfOBbnKreEeq/6TSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfAVTn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:43:57 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39510 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfAVTn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:43:56 -0500
Received: by mail-pg1-f194.google.com with SMTP id w6so11520260pgl.6;
        Tue, 22 Jan 2019 11:43:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x5FSLqLc3BtCDdLtY785HrZaNfGzbeY41bTDjhiWvyw=;
        b=mG+QtpSJvFhtKCVgY9fwpij4HKuI4l9yTaXA9yjstStW7vBK8RbXSsuaJ2EcuYjdzv
         srk6IelXHoDM+l0Z2SVjWeN1mDHBV38JwgZIyc/cmiov/NLFWxyVrmaJQQOvXHK96Vxc
         GFdoxxYVLlkVqu3HhlWelVUu6C9U3a2G1//D7gNRSSQ8tSrN9Ha5i5LF8g7Q/a9d+SNV
         mPqvBRFeBzbN5xu5nZPdNedG++VrzsrdsWg0rNzVQ26zCIp2U/iPwLZv6zcDOp+Qv/Vg
         4sncz2Mx3Wwu/qZtjNC5uFH64ijmn9/x14nZ37lN2y0D+s1rmlxk6vGm8eDtRspin4eM
         6gIw==
X-Gm-Message-State: AJcUukfGnBbWBinCocmfJmA00MXzsDDA8pqlp9fWon8pyu8QHkq7SIHa
        BmQEPLD11cFmzL7KcaH3GeY=
X-Google-Smtp-Source: ALg8bN7jdAq7BtZsLfZ6Mh8Ei5UO1/YfP+qmndO41zV/8DxNCp8FBgGAIeHXemgD/DvhJypyghFj2w==
X-Received: by 2002:a65:6215:: with SMTP id d21mr2071824pgv.289.1548186236009;
        Tue, 22 Jan 2019 11:43:56 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id i62sm19526835pge.44.2019.01.22.11.43.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 11:43:54 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Tue, 22 Jan 2019 11:43:52 -0800
Date:   Tue, 22 Jan 2019 11:43:52 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Cc:     shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] selftests: kmod: worked on errors which breaks the
 overall execution of the test script
Message-ID: <20190122194352.GA11489@garbanzo.do-not-panic.com>
References: <20190117210258.7871-1-jeffrin@rajagiritech.edu.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117210258.7871-1-jeffrin@rajagiritech.edu.in>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 02:32:58AM +0530, Jeffrin Jose T wrote:
> The kmod.sh script breaks

First thanks for the patch! But now let's get to it: on what
distribution and version of bash does this break? The commit log should
refer to this and it would help me confirm the issue.

> because an array is passed

Which is the array?

> as input
> instead of a single element input.This patch takes elements
> one at a time and passed as input to the condition statement
> which in turn fixes the error.There was an issue which had
> the need for passing a single digit to the condition statement
> which is fixed using regular expression.
> 
> Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
> ---
>  tools/testing/selftests/kmod/kmod.sh | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kmod/kmod.sh b/tools/testing/selftests/kmod/kmod.sh
> index 0a76314b4414..49b273c3646e 100755
> --- a/tools/testing/selftests/kmod/kmod.sh
> +++ b/tools/testing/selftests/kmod/kmod.sh
> @@ -526,9 +526,12 @@ function run_all_tests()
>  		TEST_ID=${i%:*:*}
>  		ENABLED=$(get_test_enabled $TEST_ID)
>  		TEST_COUNT=$(get_test_count $TEST_ID)
> -		if [[ $ENABLED -eq "1" ]]; then
> -			test_case $TEST_ID $TEST_COUNT
> -		fi

get_test_enabled() is supposed to do what you do open-handed here.
So the better question is why are you getting an array returned
for your version of bash.

> +		for j in $ENABLED ; do
> +		         CHECK=${j#*:*:}
> +			 if [[ $CHECK -eq "1" ]]; then
> +			     test_case $TEST_ID $TEST_COUNT
> +			 fi
> +		done
>  	done
>  }
>  
> -- 
> 2.20.1

  Luis
