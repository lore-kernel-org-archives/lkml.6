Return-Path: <ahiliation@yahoo.co.in>
X-Google-Smtp-Source: AIpwx4/muxFJYq6zHTJp67zkQ/BCSSUii5dpdwBKmmLBwGFEIyICb73EpmQ/k6PkeHyXFEl0RV00
ARC-Seal: i=1; a=rsa-sha256; t=1524492693; cv=none;
        d=google.com; s=arc-20160816;
        b=xcGwWIM+44mA4QpxCNAijLxvgafRiXdFaSk9sn5OZgUU1/Xg3WkJ3C4/SozbYRaUuU
         FXy+5udRJq8/+8CE6zgCcOf2LsM+2PNoX7fLAEZx7CBZilrBc56VACK+CNir1DDvND2u
         OryTpTCIdz/+EUS6be+ySXqvNey4TDsBErO/SFK17m6mVWjm29xgnf87w0UiBv5CrTow
         qLUidjA9zR5ae99+FjLBEHZQSaPa0y4EmoVDWRk/teI0EPfD/NCUx9WYsTnLBJfdTv9K
         +UyPMaQr4vqf0+O9U7HGhSWKpKpSsCqr5LF2zOLR+ku9zL3BcLyN/d1w3D19Ev1jgad1
         C5dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=NKpojxSbyZCGAYHGmUngbSdg668xlQympIEXJxq4ULo=;
        b=Lkt85rMttYeqGOwVd3uzJSGV4Ktf8LdSjxVELLaj/sn5lx41I3jhI2SiguWp1b7xQb
         ShtECeCXLtD6WH8FpEnTdEWxTgSRYwaRRniG99My+Tn56NEwte2NiA8GcPoShT49WtJ6
         CehyVLOxWHLpQmw7XwLbmMIXGrNN7GYTQBaiusVIPi1qL3XLiEowi1/EU4IwKXHBpo+d
         IdqKJ5BBwvSHn7HFYnGTlFxm1gWzTF7zVFV2WX/V9klfN0hF3mwT71nupJE0+DQByAN4
         CdBAoMfB4LKhgG+56ThdvXD0KbssaMNCd0EPbig+KIDHIoXfk1+ioBXG8zO5d2COuEy3
         YmVw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@yahoo.co.in header.s=s2048 header.b=BpLXnUqG;
       spf=pass (google.com: domain of ahiliation@yahoo.co.in designates 106.10.244.39 as permitted sender) smtp.mailfrom=ahiliation@yahoo.co.in;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=yahoo.co.in
Authentication-Results: mx.google.com;
       dkim=pass header.i=@yahoo.co.in header.s=s2048 header.b=BpLXnUqG;
       spf=pass (google.com: domain of ahiliation@yahoo.co.in designates 106.10.244.39 as permitted sender) smtp.mailfrom=ahiliation@yahoo.co.in;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=yahoo.co.in
X-YMail-OSG: n7W2i48VM1kSertmiVoy9WmFDS7.8UHon5yLLSPgiJxgZDnAwQ3u8yQozN5S_Qp
 HzWefFSGBmDi2wTnMI77w2T923s4rsb2ljObicUZ0Ewnaal4CCCwh6sqejLAqkNwz.D3rZlT4VTL
 3mwSTV_oDvhZaeTPhAno4V3lLqg0_MCIJT17kvkohKeOSYuTvS0ZSnd.cnLFahbU2qeF4uwpLXqJ
 TyvXqwJUFJZWFobKt89PBEd3NHGgrjZoNj6OXyh2r1cZZUuB_K9C_jSAFwE0dBtocbnIW2PZ4MKs
 4Apl9uI_zJPBUK1QGBacs6z4t4W2VW.LctXAxqXphgrAXdq9Js5Oe8VFC2E__Hp4mOD0Wldf7Sok
 NKrnUBe9LAUg8LgX6ET17Turn3VK9AxPbOzCLRPAV1otvmwWkmjIcNFC7m8n0QqbAMQGh_uL9CJd
 pzejQCrEWiUgei21sh21WKEFHjtfjPJaSP8D2aBDicfcaNpBBqZsG207A_oT3whAouQi3ZamtMfh
 uwsmNuPM44mIk5Zek64FpOBCG_1_DLaJlirK4JXyIgJiZwfoDCUVObI4oXUn6Ee_s.Zg8eJIgWll
 lr_e26EryINkBVQ--
From: Jeffrin Jose T <ahiliation@yahoo.co.in>
To: shuah@kernel.org,
	gregkh@linuxfoundation.org,
	keescook@chromium.org,
	mcgrof@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeffrin Jose T <ahiliation@yahoo.co.in>,
	Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Subject: [PATCH] selftests:firmware: fixes a call to a wrong function name  
Date: Mon, 23 Apr 2018 19:40:22 +0530
Message-Id: <20180423141022.5019-1-ahiliation@yahoo.co.in>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598546450187595839?=
X-GMAIL-MSGID: =?utf-8?q?1598546450187595839?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

 This is a patch to the tools/testing/selftests/firmware/fw_run_tests.sh
 file which fixes a bug which calls to a wrong function name,which in turn
 blocks the execution of certain tests.
 
Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Acked-by: Kees Cook <keescook@chromium.org>

---
 tools/testing/selftests/firmware/fw_run_tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/firmware/fw_run_tests.sh b/tools/testing/selftests/firmware/fw_run_tests.sh
index 06d638e9dc62..cffdd4eb0a57 100755
--- a/tools/testing/selftests/firmware/fw_run_tests.sh
+++ b/tools/testing/selftests/firmware/fw_run_tests.sh
@@ -66,5 +66,5 @@ if [ -f $FW_FORCE_SYSFS_FALLBACK ]; then
 	run_test_config_0003
 else
 	echo "Running basic kernel configuration, working with your config"
-	run_test
+	run_tests
 fi
-- 
2.17.0
