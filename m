Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C28C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 04:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADD6216FA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 04:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BADD6216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbeI1LOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 07:14:20 -0400
Received: from ozlabs.org ([203.11.71.1]:56037 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbeI1LOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 07:14:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42Lzn31BLwz9s3Z;
        Fri, 28 Sep 2018 14:52:22 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Anders Roxell <anders.roxell@linaro.org>,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        shuah@kernel.org, bamv2005@gmail.com, brgl@bgdev.pl,
        pbonzini@redhat.com, akpm@linux-foundation.org,
        rppt@linux.vnet.ibm.com, aarcange@redhat.com
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6] selftests: add headers_install to lib.mk
In-Reply-To: <20180904104721.27535-1-anders.roxell@linaro.org>
References: <20180809080402.24469-1-anders.roxell@linaro.org> <20180904104721.27535-1-anders.roxell@linaro.org>
Date:   Fri, 28 Sep 2018 14:52:22 +1000
Message-ID: <87y3bmte9l.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ + linuxppc-dev ]

Anders Roxell <anders.roxell@linaro.org> writes:
> If the kernel headers aren't installed we can't build all the tests.
> Add a new make target rule 'khdr' in the file lib.mk to generate the
> kernel headers and that gets include for every test-dir Makefile that
> includes lib.mk If the testdir in turn have its own sub-dirs the
> top_srcdir needs to be set to the linux-rootdir to be able to generate
> the kernel headers.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> Reviewed-by: Fathi Boudra <fathi.boudra@linaro.org>
> ---
>
> I sent this (v5) a month ago and wondered if it got lost. Resending
> unchanged.
>
> Cheers,
> Anders
>
>  Makefile                                           | 14 +-------------
>  scripts/subarch.include                            | 13 +++++++++++++
>  tools/testing/selftests/android/Makefile           |  2 +-
>  tools/testing/selftests/android/ion/Makefile       |  2 ++
>  tools/testing/selftests/futex/functional/Makefile  |  1 +
>  tools/testing/selftests/gpio/Makefile              |  7 ++-----
>  tools/testing/selftests/kvm/Makefile               |  7 ++-----
>  tools/testing/selftests/lib.mk                     | 12 ++++++++++++
>  tools/testing/selftests/net/Makefile               |  1 +
>  .../selftests/networking/timestamping/Makefile     |  1 +
>  tools/testing/selftests/vm/Makefile                |  4 ----
>  11 files changed, 36 insertions(+), 28 deletions(-)
>  create mode 100644 scripts/subarch.include

This broke all the powerpc selftests :(

Why did it go in at rc5?

cheers
