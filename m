Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A305C282DB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 20:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA06218A6
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 20:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfBCUxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 15:53:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:55872 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726820AbfBCUw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 15:52:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05310AE7F;
        Sun,  3 Feb 2019 20:52:58 +0000 (UTC)
Date:   Sun, 3 Feb 2019 21:52:52 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        David Howells <dhowells@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 1/3] selftest/ima: cleanup the kexec selftest
Message-ID: <20190203205252.GA4022@x230>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1548960936-7800-1-git-send-email-zohar@linux.ibm.com>
 <1548960936-7800-2-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548960936-7800-2-git-send-email-zohar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

> Remove the few bashisms in the script and use the complete option name
> for clarity.

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>  tools/testing/selftests/ima/test_kexec_load.sh | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

> diff --git a/tools/testing/selftests/ima/test_kexec_load.sh b/tools/testing/selftests/ima/test_kexec_load.sh
> index 1c10093fb526..74423c4229e2 100755
> --- a/tools/testing/selftests/ima/test_kexec_load.sh
> +++ b/tools/testing/selftests/ima/test_kexec_load.sh
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0+
# SPDX-License-Identifier: GPL-2.0-or-later
According to [1] GPL-2.0+ has been deprecated (but who cares).

...
> -	if [ "$secureboot" == "1" ]; then
> +kexec --load $KERNEL_IMAGE 2>&1 /dev/null
kexec --load $KERNEL_IMAGE 2>&1 >/dev/null
missing redirection.

> +if [ $? -eq 0 ]; then
> +	kexec --unload
> +	if [ $secureboot -eq 1 ]; then
>  		echo "$TEST: kexec_load succeeded [FAIL]"
>  		rc=1
>  	else
>  		echo "$TEST: kexec_load succeeded [PASS]"
>  	fi
It'd be nice, if selftest has some main library with helpers (like LTP has [2]),
to have unified output and reduce duplicity.


Kind regards,
Petr

[1] https://spdx.org/licenses/
[2] https://github.com/linux-test-project/ltp/blob/master/testcases/lib/tst_test.sh
