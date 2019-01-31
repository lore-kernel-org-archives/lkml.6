Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02417C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C95392086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PAP/0rOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfAaTHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:07:15 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42652 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfAaTHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:07:15 -0500
Received: by mail-yb1-f195.google.com with SMTP id l20so1747115ybl.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pS6q+Bhwt+X1yTD/cQHkERWtmyVyeezzzPlLtUGK/wo=;
        b=PAP/0rOjKRUTX/auNM+qLl3u8973sF87Q5booOwpCO3ilQ3nTI2D6TehlWFSkUmBAP
         Xb75VoK5+WZi6DTU7Og2/mWtNLdWF3jK9ub65ZhgmZYqFMTTsgmqV5IRMe7ZwcaTUBlj
         M/E4J3mLU0fmD/vBr55JudJqc76AJiFPqfF+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pS6q+Bhwt+X1yTD/cQHkERWtmyVyeezzzPlLtUGK/wo=;
        b=R9iWPbGovPOAapCTY1/Bjz3uHv3Pfoleh1LqvVqD4UuTNgT34SatPTXLKovlACLw2I
         M6OFhXnP7f1wOhVVnbfrbQq+BeXJ93Ax38wP6gLG6latx34mbyeL4nWZFmr0a3kQ5Ejj
         r7qBE8v12ISaqx9SbrYGrIkdzEywsAvyzYQfFFfXD0aIutBBfOJF1oITcY+6yp1p1gKm
         g2BETOUH2EoAoP+sDxiq4jNM/sfJWrW0XyjGbcn9GYp2YJ220lX/QbEs+AMXwsLupOgW
         otIcLkygVxitE6jMIfc7BVqz//mODUZaMbIS7Rwrhkh+Vq3rU6cIQnrkpSQ7S4vmrC9R
         4CfA==
X-Gm-Message-State: AJcUukcRNrfos2YPLKdhnPYfA7gnv+Qssv0YqRxR+fCGDwdVdzJ+Ph4F
        lAeimmRlH3jpAGUJQBtHSuTzghsDieYpzCqiu0WTPfQf
X-Google-Smtp-Source: ALg8bN5KyErXR3S5n9rA6c1giNo6gMse1D9QQLZZC1vNvDstCp/XEtAiOf1qU7tm8VXyULAgnuy+ZB1Ff9JReoQ5jD4=
X-Received: by 2002:a25:2f92:: with SMTP id v140mr34937032ybv.257.1548961633877;
 Thu, 31 Jan 2019 11:07:13 -0800 (PST)
MIME-Version: 1.0
References: <20190108092525.12817-1-anders.roxell@linaro.org>
In-Reply-To: <20190108092525.12817-1-anders.roxell@linaro.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 31 Jan 2019 20:07:02 +0100
Message-ID: <CADYN=9JAogKRqz7jwKgFZvEMqJNo8QT2aJVuJ0jqB+Ce_g6J1Q@mail.gmail.com>
Subject: Re: [PATCH] selftests/networking: remove timestamping clean target
To:     David Miller <davem@davemloft.net>, Shuah Khan <shuah@kernel.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2019 at 10:25, Anders Roxell <anders.roxell@linaro.org> wrote:
>
> Commit cda261f421ba ("selftests: add txtimestamp kselftest") introduced
> a warning:
>
> Makefile:14: warning: overriding recipe for target 'clean'
> ../../lib.mk:137: warning: ignoring old recipe for target 'clean'
>
> Theres no need for timestamping to have its own 'clean' target. The
> lib.mk file's 'clean' target gets included to the timestamping Makefile
> and that should be enough.
>
> Fixes: cda261f421ba ("selftests: add txtimestamp kselftest")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/testing/selftests/networking/timestamping/Makefile | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/tools/testing/selftests/networking/timestamping/Makefile b/tools/testing/selftests/networking/timestamping/Makefile
> index 9050eeea5f5f..1de8bd8ccf5d 100644
> --- a/tools/testing/selftests/networking/timestamping/Makefile
> +++ b/tools/testing/selftests/networking/timestamping/Makefile
> @@ -9,6 +9,3 @@ all: $(TEST_PROGS)
>  top_srcdir = ../../../../..
>  KSFT_KHDR_INSTALL := 1
>  include ../../lib.mk
> -
> -clean:
> -       rm -fr $(TEST_GEN_FILES)
> --
> 2.20.1
>

Does this make sense?

Cheers,
Anders
