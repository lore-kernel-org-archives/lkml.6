Return-Path: <ben.hutchings@codethink.co.uk>
X-Google-Smtp-Source: AIpwx4+s8OH/QwUtFEpt5IxIRlM+PobHsRxNNknJWuCymvkkL72A2Tk2VeHcid+dgb7lXBMf2/KA
ARC-Seal: i=1; a=rsa-sha256; t=1522874237; cv=none;
        d=google.com; s=arc-20160816;
        b=mpGdiqPysZInxhUCIiNElPq0ysBhwDqi/ar/vuF2H4Hoat4cICsXVtGGN6EENGyMw9
         X7e83urJbOAyZd3vQdyfV9/mTN7ttKcggFpVxvVVFrgMd+wjYzdomRIRbw4Abo2/96em
         knHzRMRWMCYSqTAE7D5v9+0wdLJgYRn+1h3w6R4H2uZOT4WyCXCfqZsrDChGZ3J17cAa
         10ICVGszyUMc/KR/P1d9MRdKJuhkB74cHf1VL6N3nE0fXXM11v+qLaUkboHVFiVSmIXs
         FbRL6nUfWeEJSs9v07HF5cUmaHGdstWcmoMqmkUwLewC3PlZUpzygOvOOFoP5bd/Wfnp
         Ry7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=t9vmXyIVtU79O1HCkSs2hokbMkigHmY3RjYXT27mpjE=;
        b=PC2XeRcWKaPmmHsGEViLKv5p3YILb51vQUcoEvjYd7Xo/xL3+l77ni+vuKWASK5yzT
         +aPqrzgClLECcujZQlwmKoVbtXK+wGaFi7shn4WXS/wVhUgA7Vi1Li5gaUtAXPBMCvQ/
         Ms/HLhRnlt5Fx8WccNX7Mv5P1zs69RmHXi90XB2v97Hit+Qo6aLGo5U3+SMm3oFDIOib
         E4EctDWtMnWjV1/SzBnhTBVQPZDHu0l08rFCKW8u8yZVtBVY/M/AOrjzns5bu0+tDq6Q
         Y68vTOv7BPScIKyVVkfxpGzJpp8tewzDAYwVhqyub4ooRWgtkpiZTNvdTujXDxO/UfFB
         z8Kw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben.hutchings@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=ben.hutchings@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben.hutchings@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=ben.hutchings@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Date: Wed, 4 Apr 2018 22:37:13 +0200
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH driver-core 1/2] test_firmware: Install all scripts
Message-ID: <20180404203712.zecit6po44qsde4c@xylophone.i.decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596849376689365060?=
X-GMAIL-MSGID: =?utf-8?q?1596849376689365060?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

List all the scripts invoked by fw_run_tests.sh, so that
"make TARGETS=firmware install" keeps working.

Fixes: 29a1c00ce1df8 ("test_firmware: add simple firmware firmware test ...")
Fixes: b3cf21fae1fe0 ("test_firmware: test three firmware kernel configs ...")
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 tools/testing/selftests/firmware/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/firmware/Makefile b/tools/testing/selftests/firmware/Makefile
index 826f38d5dd19..261c81f08606 100644
--- a/tools/testing/selftests/firmware/Makefile
+++ b/tools/testing/selftests/firmware/Makefile
@@ -4,6 +4,7 @@
 all:
 
 TEST_PROGS := fw_run_tests.sh
+TEST_FILES := fw_fallback.sh fw_filesystem.sh fw_lib.sh
 
 include ../lib.mk
 
-- 
2.16.2
