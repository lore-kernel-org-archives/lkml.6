Return-Path: <ahiliation@yahoo.co.in>
X-Google-Smtp-Source: AB8JxZrVdjgw3tvqA1VAVseze/LTRa7D6kQBP9NdSsQYLVWO30v1LFJ1q42R61mQv/xJgp7SDO5d
ARC-Seal: i=1; a=rsa-sha256; t=1525887573; cv=none;
        d=google.com; s=arc-20160816;
        b=BOsGGwXmtG+Lo9MwF48ljmlaw92WutD7JuTSOmyOuWfvd218Nx5UPYEWp7Ps04FK68
         KmUxH7btbDgHAOvjscwZw4zoStTlz9nFFl4fHbEocgfm+sH089S5NDmIg6sCJLFy7FL4
         pg9DdAp+2qk6kjUu3Hdk7CVBCWGDNkXa5FKqepnlpeQqB3VnO8bqDY8TJ1/y6fKU0jgE
         lu5Gao8SqFelz3TSes1FaJmggcGjsGWn87us+/ZLDK6aD6sDlfrcWGB6Rbk7hRxHtwNH
         z1ndlTK/bTUSUkx+Ep83myauu0GZPaOQWReB4rOdVllm6kY2p/dG4gECF63ZUvHJ2nPC
         2u5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=bZg/5MOTDXagudm5/+mvDnjQxBN5kF221BkU6UFHmJg=;
        b=itvvdxhv7UbXn21xd7NHKSVQhdM5pVLGftvvMFFfmGOvOCrWZxnIVftU2YBTFAZ+sq
         RsB1ZpjIxGwFxrvAVS5yNbbVzT0bkjJDyiIvANb7KJ/uKiFhl9FwDHEH5lXQmzydPWCj
         /ZjLHRZF8wXUhpFeesTCXBbPCFeS7Cu1OnJenIQuu09RvnZpMKIQ+oQmHQCkJCNcj9hq
         czvCU9QQNe9CM7y12Mqg49K/XQkRxXoOqtySRjzCCeWH9n5Fc6ckHDt/i5AeTVAq+Wgh
         oH1YbAn4utgq6ksu5QyF3VIEbxlr8PfhpwM9iL5Wn/ASbwHhmNTLJNw3LuwNuUVu5Fwt
         Nv1g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@yahoo.co.in header.s=s2048 header.b=LOk1dd3z;
       spf=pass (google.com: domain of ahiliation@yahoo.co.in designates 106.10.242.40 as permitted sender) smtp.mailfrom=ahiliation@yahoo.co.in;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=yahoo.co.in
Authentication-Results: mx.google.com;
       dkim=pass header.i=@yahoo.co.in header.s=s2048 header.b=LOk1dd3z;
       spf=pass (google.com: domain of ahiliation@yahoo.co.in designates 106.10.242.40 as permitted sender) smtp.mailfrom=ahiliation@yahoo.co.in;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=yahoo.co.in
X-YMail-OSG: fZezlwYVM1nDXe1pn6a98D_wNV6f7mISLOSeK6wTnQGqq4DS6zDw7IhE1gRFk9T
 ik6I1gqk2Jk_nKGTZrz_Bhs_oJRvFzTB1STfm3_gDyCvmb4tud18z8iPm8HIdrr_rXUFtRZcadSs
 mwPaSWgovQHi4sRVrkXb8Nyl2kfiqqeZnWTUqNklcVVUHvjzjT0kKVuVVV8ENZLoFnbN_kPw_GNY
 oBJXRhfhyX5lfKy6qFIFk3YacGH_2o6orq2GUxgAoZqXeE0Uz5opWTsWzFC5bYlxkkrtTNG8oKf9
 sMsxQKFZt0hduhGbrn6UbBf0AifpDOQ7l7cZcuIBPAeED8S33UgIRjaZcXbxI5W.Dp..GP9YC7f_
 eXDRa34uapJBVZqnLwUHz54sg.OjJCrHA2OPywgoJ_Mk8MDiWt9wAQ71hUN4bRmXeCbfNfusqtSv
 Gi94MVg8.nL3E3es4BbkxUNaM777srqfdxx9VXafaAiUb11ERwid1hl4gjH19sHjcJxtwlMLSeML
 HAhpPE.bjg0HeNMdsZmRgm2PoUSahNmD1_lJPS_fp_6jiqcfsyi5BD_2r7VRfeaqpduCZ8KgVDmh
 4vRi2TjyFUsKLJ_U2kbryGw9CfM62PfqK17oy6FP0FJsSrH2_Z8Qwj_CBsldQ7mluCMGN.fjxO4x
 JHjZ3W6MFSmK0y4iIcX2RiOo5I_4VUQK4
From: Jeffrin Jose T <ahiliation@yahoo.co.in>
To: shuah@kernel.org,
	kstewart@linuxfoundation.org,
	daniel.diaz@linaro.org,
	pombredanne@nexb.com,
	gregkh@linuxfoundation.org,
	thomas@m3y3r.de
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeffrin Jose T <ahiliation@yahoo.co.in>,
	Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Subject: [PATCH] selftests: intel_pstate: Fix a condition which does not notify user that root permission is useful
Date: Wed,  9 May 2018 23:08:19 +0530
Message-Id: <20180509173819.8017-1-ahiliation@yahoo.co.in>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600009088111663295?=
X-GMAIL-MSGID: =?utf-8?q?1600009088111663295?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

aperf program uses /dev/cpu which is normally a root only
access area. so in that case to successfully run thet test,
root permissions are required.This patch is in the file run.sh.

Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
---
 tools/testing/selftests/intel_pstate/run.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
index 23a2e4e9880e..05d35392dcfd 100755
--- a/tools/testing/selftests/intel_pstate/run.sh
+++ b/tools/testing/selftests/intel_pstate/run.sh
@@ -31,6 +31,14 @@
 
 EVALUATE_ONLY=0
 
+uid=$(id -u)
+if [ $uid -ne 0 ]; then
+    echo     "-----------------------"
+    echo $msg please run this as root >&2
+    echo     "-----------------------"
+    exit 0
+fi
+
 if ! uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ | grep -q x86; then
 	echo "$0 # Skipped: Test can only run on x86 architectures."
 	exit 0
-- 
2.17.0
