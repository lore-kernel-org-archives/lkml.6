Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvSyVtGIQfCIIfPTXHlc9iEZzgHO+61soHft1ebiElti6FYAA2jCYy8TI/Ur1CQ8Y7FBSLn
ARC-Seal: i=1; a=rsa-sha256; t=1520269877; cv=none;
        d=google.com; s=arc-20160816;
        b=afzBAWKkm+n07VV7k4Rn0MuL8PIV292hJI5kq31lUMyI8EiYHFy6ET7DYGDycuj/If
         1YTc+YvON/NqW3sgINJvgmZt6gbXrRu4Ry8NG8D9SFfRd9XSrkGtkPPDw3k5FAXH6eNG
         mLbGQ3Sdcfiq8DDZ2sKYaEMcI5zcF2tcIctG2f+IHRSCmT1/Xg8VwoHNeKJKplZO5kOM
         YFXuVq9Fa8pHV0Uq5XL0Fyk7V/khCkkpXjZkQ0LGeHxiyWTV6KKQteC5tqfiTJJ20ZgT
         AjWCFbOPDSAeUxBChYTm9QynMhwMmkPRANnre6t7p8dv2IVW8P74tiIZDyfEb2xqPDaT
         9L3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:arc-authentication-results;
        bh=dUxFEF+Rgcq4ipr6oTTjgPkrpQYwvQ2ldBcER5KOSQg=;
        b=RYfTEm3n84x9It55A9hjEn9C+85h1IpvtmRK5GQ8j8g/Q7SVhbjBY25NXhRyCf+0tO
         vLjCK1dk6n/9SqmVxIsNJWuughx2FclJB9o2ytNZkDbB8yv7ACdzR7wuwkFUV5CQ+nz6
         LKYxQPaYrjNBs4aR/M3HqZi3llj9KfTf7fYeJoxxIXstIb7AEQ6rFTQmhLG62PpMF61S
         8y1qIOk+rj1qy83RksZ9//ETNZBDqDhpNhVWOqwCX1Zd3IURoL8mYpg2thrGX7+AYgoP
         8np9XFIZHUngnF9EM6XCFnTESKc3MKBflBm1yxnotq4KybL6KMT4hNjnW/P3rA0ipkCW
         rskw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeCERLQ (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 5 Mar 2018 12:11:16 -0500
Received: from osg.samsung.com ([64.30.133.232]:44637 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751275AbeCERLP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Mar 2018 12:11:15 -0500
To: torvalds@linux-foundation.org
Cc: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Shuah Khan <shuah@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [GIT PULL] kselftest fixes update for 4.16-5
Message-ID: <9a30baa5-bcbb-8f47-d74d-034754fc5a98@osg.samsung.com>
Date: Mon, 5 Mar 2018 10:11:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------7ADE07706429B842E07699DB"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594118507230178100?=
X-GMAIL-MSGID: =?utf-8?q?1594118507230178100?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a multi-part message in MIME format.
--------------7ADE07706429B842E07699DB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull the following Kselftest update for 4.16-rc5.

This kselftest fixes update has a fix for regression in memory-hotplug
install script that prevents the test from running on the target.

Diff for the update is attached.

thanks,
-- Shuah

-----------------------------------------------------------------------------------

The following changes since commit f6869826de700bce59e2cef14974f99836e34e4f:

  selftests: vm: update .gitignore with new test (2018-02-26 16:09:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-4.16-rc5

for you to fetch changes up to ba004a2955f759946d8c98ca1a9c8d09818b1223:

  selftests: memory-hotplug: fix emit_tests regression (2018-03-02 10:12:59 -0700)

----------------------------------------------------------------
linux-kselftest-4.16-rc5

This kselftest fixes update has a fix for regression in memory-hotplug
install script that prevents the test from running on the target.

----------------------------------------------------------------
Shuah Khan (1):
      selftests: memory-hotplug: fix emit_tests regression

 tools/testing/selftests/memory-hotplug/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


-----------------------------------------------------------------------------------

--------------7ADE07706429B842E07699DB
Content-Type: text/x-patch;
 name="linux-kselftest-4.16-rc5.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="linux-kselftest-4.16-rc5.diff"

diff --git a/tools/testing/selftests/memory-hotplug/Makefile b/tools/test=
ing/selftests/memory-hotplug/Makefile
index 183b46883875..686da510f989 100644
--- a/tools/testing/selftests/memory-hotplug/Makefile
+++ b/tools/testing/selftests/memory-hotplug/Makefile
@@ -5,7 +5,8 @@ include ../lib.mk
=20
 TEST_PROGS :=3D mem-on-off-test.sh
 override RUN_TESTS :=3D @./mem-on-off-test.sh -r 2 && echo "selftests: m=
emory-hotplug [PASS]" || echo "selftests: memory-hotplug [FAIL]"
-override EMIT_TESTS :=3D echo "$(RUN_TESTS)"
+
+override EMIT_TESTS :=3D echo "$(subst @,,$(RUN_TESTS))"
=20
 run_full_test:
 	@/bin/bash ./mem-on-off-test.sh && echo "memory-hotplug selftests: [PAS=
S]" || echo "memory-hotplug selftests: [FAIL]"

--------------7ADE07706429B842E07699DB--
