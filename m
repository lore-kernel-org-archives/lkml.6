Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59134C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1348C21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMi+dnjO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1348C21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeJIOo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:44:56 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38886 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbeJIOo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:44:56 -0400
Received: by mail-yb1-f194.google.com with SMTP id e190-v6so237195ybb.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 00:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eMboP3qqg8wZiO2Hx+zpgqD7sOTUSfP9r1JceuoXl58=;
        b=iMi+dnjOF6eDt+cTeddPjnvlobv1N148yXKgJgH9IJ38eyGMcT2hs3NK555F4gNSb4
         uxZ5TsVzuLSt8c5Sjc8MTQ3bjP2ufBmKiC6PbPW0UnJPQsfg+omk7uq1BrYnWfdnqOHn
         zekXfbAvRst1FEwOjoFeRQWuUDOiWRDPxQaYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eMboP3qqg8wZiO2Hx+zpgqD7sOTUSfP9r1JceuoXl58=;
        b=b9SjUYVkVf9K2Cwf/wWwPggwx9MqQR1/d9vgIgXFzkJQD4LT6tqSZiTsyakKlOPrkQ
         wW7RzK2p0WJ76pOohYDvn4gyZ0UU4J7z+sK5R0bBU/2WGfu6GzjXhNFwMxOEWnLTwl2S
         jJuDUsI0FQz36dyh8pkj+7XTI8Rc9mAapgq72kkxnExc7/pBzYehQhNrnEGlhRe8Le9L
         AiGrAWyJbVS9pldgbx0u2GEtU6rrij5h7fhnrJpNbjBTbQVD58dxlKuRamJ4rzd4ZW0X
         9dsnCAKwhdXJiJs5exUFnBjyusdyL6dhx3eEBwCxwyzPbXFbC6ch7LDreY3i4AQXzZ1u
         60aA==
X-Gm-Message-State: ABuFfojD0xFoMZfNc6KAAR8cHXYxXOo0jgwNk7dLDVorQfKk4Jqpd4F9
        ikFN0TvsGiyY2AaPhKgLsPj3IyR9sEmkfqA4JXtErN+Ien4=
X-Google-Smtp-Source: ACcGV60AgzoiZnVISUhohshZardFKLPk08Nxok4k+4KCNTxsEGnvrdD7Qea8dJESErjyWmxmz4kKkHM+OmImSUtMsCU=
X-Received: by 2002:a25:198a:: with SMTP id 132-v6mr14921038ybz.325.1539070161848;
 Tue, 09 Oct 2018 00:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <1536229374-25699-1-git-send-email-Lei.Yang@windriver.com>
In-Reply-To: <1536229374-25699-1-git-send-email-Lei.Yang@windriver.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 9 Oct 2018 09:29:10 +0200
Message-ID: <CADYN=9+0RxfJRHhTM5GLMOi-EsOfe3tv+jvSfyQLLcSQB5FzHw@mail.gmail.com>
Subject: Re: [PATCH v2] sysctl: kselftests: fix test_modprobe issue
To:     Lei.Yang@windriver.com
Cc:     mcgrof@kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2018 at 12:20, Lei Yang <Lei.Yang@windriver.com> wrote:
>
> when CONFIG_TEST_SYSCTL=y, there is no "/sys/module/test_sysctl/"
> when CONFIG_TEST_SYSCTL=m, checking /sys/module/test_sysctl/ is
> before kernel module loading
>
> you'll get below error message
> root@intel-x86-64:/tmp/sysctl# ./sysctl.sh
> Checking production write strict setting ... ok
> ./sysctl.sh: /sys/module/test_sysctl/ not present
> You must have the following enabled in your kernel:
>
> This patch will fix this issue.
> when CONFIG_TEST_SYSCTL=y, it has no chance to check "/sys/module/test_sysctl/"
> when CONFIG_TEST_SYSCTL=m, it will load kernel module first before checking sys
> interface.
>
> Signed-off-by: Lei Yang <Lei.Yang@windriver.com>
> ---
>  tools/testing/selftests/sysctl/sysctl.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
> index 584eb8e..08dc995 100755
> --- a/tools/testing/selftests/sysctl/sysctl.sh
> +++ b/tools/testing/selftests/sysctl/sysctl.sh
> @@ -120,6 +120,7 @@ test_reqs()
>
>  function load_req_mod()
>  {
> +        trap "test_modprobe" EXIT
>         if [ ! -d $DIR ]; then
>                 if ! modprobe -q -n $TEST_DRIVER; then
>                         echo "$0: module $TEST_DRIVER not found [SKIP]"
> @@ -770,7 +771,6 @@ function parse_args()
>  test_reqs
>  allow_user_defaults
>  check_production_sysctl_writes_strict
> -test_modprobe
>  load_req_mod
>
>  trap "test_finish" EXIT
> --
> 1.9.1
>

do we really nead the test_modprobe function?
I think we can just remove that completely.
Also remove a lot in load_req_mod and only do: modprobe $TEST_DRIVER
if it fails its a non fatal error and we can go on and have a new
function in all
the tests sysctl_test_000(1|2|3|4|5) that checks for the files.
Maybe do something like this:

diff --git a/tools/testing/selftests/sysctl/sysctl.sh
b/tools/testing/selftests/sysctl/sysctl.sh
index 584eb8ea780a..a925d040dfe0 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -19,7 +19,6 @@ ksft_skip=4

 TEST_NAME="sysctl"
 TEST_DRIVER="test_${TEST_NAME}"
-TEST_DIR=$(dirname $0)
 TEST_FILE=$(mktemp)

 # This represents
@@ -38,21 +37,8 @@ ALL_TESTS="$ALL_TESTS 0003:1:1"
 ALL_TESTS="$ALL_TESTS 0004:1:1"
 ALL_TESTS="$ALL_TESTS 0005:3:1"

-test_modprobe()
-{
-       if [ ! -d $DIR ]; then
-               echo "$0: $DIR not present" >&2
-               echo "You must have the following enabled in your kernel:" >&2
-               cat $TEST_DIR/config >&2
-               exit $ksft_skip
-       fi
-}
-
 function allow_user_defaults()
 {
-       if [ -z $DIR ]; then
-               DIR="/sys/module/test_sysctl/"
-       fi
        if [ -z $DEFAULT_NUM_TESTS ]; then
                DEFAULT_NUM_TESTS=50
        fi
@@ -120,16 +106,7 @@ test_reqs()

 function load_req_mod()
 {
-       if [ ! -d $DIR ]; then
-               if ! modprobe -q -n $TEST_DRIVER; then
-                       echo "$0: module $TEST_DRIVER not found [SKIP]"
-                       exit $ksft_skip
-               fi
-               modprobe $TEST_DRIVER
-               if [ $? -ne 0 ]; then
-                       exit
-               fi
-       fi
+       modprobe $TEST_DRIVER
 }

 reset_vals()
@@ -548,9 +525,18 @@ run_stringtests()
        test_rc
 }

+check_sysctl_file()
+{
+       if [ ! -f ${1} ]; then
+               echo "$0: ${1} not present" >&2
+               exit $ksft_skip
+       fi
+}
+
 sysctl_test_0001()
 {
        TARGET="${SYSCTL}/int_0001"
+       check_sysctl_file ${TARGET}
        reset_vals
        ORIG=$(cat "${TARGET}")
        TEST_STR=$(( $ORIG + 1 ))
@@ -562,6 +548,7 @@ sysctl_test_0001()
 sysctl_test_0002()
 {
        TARGET="${SYSCTL}/string_0001"
+       check_sysctl_file ${TARGET}
        reset_vals
        ORIG=$(cat "${TARGET}")
        TEST_STR="Testing sysctl"
@@ -575,6 +562,7 @@ sysctl_test_0002()
 sysctl_test_0003()
 {
        TARGET="${SYSCTL}/int_0002"
+       check_sysctl_file ${TARGET}
        reset_vals
        ORIG=$(cat "${TARGET}")
        TEST_STR=$(( $ORIG + 1 ))
@@ -587,6 +575,7 @@ sysctl_test_0003()
 sysctl_test_0004()
 {
        TARGET="${SYSCTL}/uint_0001"
+       check_sysctl_file ${TARGET}
        reset_vals
        ORIG=$(cat "${TARGET}")
        TEST_STR=$(( $ORIG + 1 ))
@@ -599,6 +588,7 @@ sysctl_test_0004()
 sysctl_test_0005()
 {
        TARGET="${SYSCTL}/int_0003"
+       check_sysctl_file ${TARGET}
        reset_vals
        ORIG=$(cat "${TARGET}")

@@ -620,8 +610,6 @@ list_tests()
        echo "0005 x $(get_test_count 0005) - tests proc_douintvec() array"
 }

-test_reqs
-
 usage()
 {
        NUM_TESTS=$(grep -o ' ' <<<"$ALL_TESTS" | grep -c .)
@@ -770,7 +758,6 @@ function parse_args()
 test_reqs
 allow_user_defaults
 check_production_sysctl_writes_strict
-test_modprobe
 load_req_mod

 trap "test_finish" EXIT


Cheers,
Anders
