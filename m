Return-Path: <ahiliation@yahoo.co.in>
X-Google-Smtp-Source: AB8JxZreMlO5CFv2ruFGRCTnjbp+XXE3ciOLVIFT4+oKUyq8GA1sr2yw8oPj4Q9SmI+aNDGcI+0C
ARC-Seal: i=1; a=rsa-sha256; t=1525366710; cv=none;
        d=google.com; s=arc-20160816;
        b=dcCUz8xsyOZwrDMIVxprWMAH0wH2tC3f42534CyWpIVaGRm3B4JPsAoyISe9mmJOlC
         eUJbrFS9Yq1xMDXYK2mzcGcO9OqEojIbo3Ts6UjeFfEGxmQ6kA9vrwd/QaS/jfGIsk0X
         hmJx8QGcbeqHKRVweXgTAp/HB84k2Wn/QjzMwqy5L244ptGOtE7BE/elmqfmaPm9YQOq
         cuHQUNOjjJ1T/8Pz90xYqNFACPpR/rHLTkzuKyGe+DF12dzglFDQgiD2beyVIvBtaF5h
         I9GnE5zd0b4sZ8Tvcp5uyn5cSLbyhzMt1065ixwDMtpU7pUWRw3I8g7CpzfxQbK1p1SK
         clow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=1XfTmu0K2hmWdA4xG6yGFXcK+ybhhZNVFKbtZjeVvAM=;
        b=PqiA4I5Abrdmuu429/9m0cLqN0eOC4MQIwVfqu0OrfANOEXLtDubgdnR835wscV944
         nBebImPILA/f/qBJcFpJKj1oG/qNfCJNwbOntp+DUqo1G/vmJPlPg0Z4yEJyRY74T2To
         IQ9quVyVqJODsMWQZEs2I4/uR7w8WYnxo6bPOuNCGTeEXAB62ss54qL5YWFPdhHq79EQ
         EN9tQ+fpWX5NEWmcuAEukSKYAwwi0NJsXqXDcOIKVBiIllmOmdhgavnCk0m5c9NHh1Rc
         zR4xEdUhzpYYKqd19No398EQ2HDF5f4cg9kw+hQIncj/7FqCh9jxCru3hZJaofAbRvrC
         ZeVA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@yahoo.co.in header.s=s2048 header.b=KstmewlN;
       spf=pass (google.com: domain of ahiliation@yahoo.co.in designates 106.10.241.83 as permitted sender) smtp.mailfrom=ahiliation@yahoo.co.in;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=yahoo.co.in
Authentication-Results: mx.google.com;
       dkim=pass header.i=@yahoo.co.in header.s=s2048 header.b=KstmewlN;
       spf=pass (google.com: domain of ahiliation@yahoo.co.in designates 106.10.241.83 as permitted sender) smtp.mailfrom=ahiliation@yahoo.co.in;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=yahoo.co.in
X-YMail-OSG: XHNojqIVM1kAhG9w3gzIBw6dSETFYJ2y3PuEjrdJaqe1Wr1wLvGhbe3VmlwGJHn
 JRYniAUuaFm9_yRt7NUsDg8MCD3NLVf1mHAJOqFlA5a.fw6liWF0He7Tnc6HrlYIED1PbP34J27D
 3FvexN8EK71AjiCa4eSU6QKUd3vYHz9O6uirnRYEXN2_2eI2FLtnxVNUtp5OkAEZ38ayKf58aLAN
 aDB.7s03EnPPPyJhhYfZFdm1f4I8XHpJgtDFEZxhjYVq0Y0H7wN7vP_IKugJ8sSoxmMist_uJ8n1
 G0ZQgw0RPHFLwJjolTkaJpjviC28rQNH.ynmlXDjbPWZD6mY6.z2d4nUFGa1onrhJAxtdIVIOUJW
 CneDnBuQ5oI0rois5060sdOXT0KiCjQj_CR9xdQwGMXdMkuNGH2H50x3z6SCG_frdnxC37FKVKvU
 S_mnIEGiJrV48N0l_gSlPSvH2Oo4Wrxcvhag7OTeHa8RYQ0yrgUGt2qHvImuiNUxcPm87FLIeJ6W
 XzHNh_AeDtLKA2YkimOAw1fmJwcTRG.0o577yL_9esg2sdFbelkAVrQlsj9MUEtMZBwq.kOzc7oK
 vqv1wFGtfiap5JvRDOZIVf5f7n1Pibj75VO3bFpwjqb_bvaRKM57pUwMcOIpUB5piob85ap09lwc
 TliGkRpmX8krG5QePnFMBwXFTqdgYKJY-
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
Subject: [PATCH] selftests:intel_pstate: fixes typical crash of a testing script for Intel P-State driver [New and correct] [ignore previous mail]
Date: Thu,  3 May 2018 22:28:11 +0530
Message-Id: <20180503165811.5906-1-ahiliation@yahoo.co.in>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599462923746191261?=
X-GMAIL-MSGID: =?utf-8?q?1599462923746191261?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

 Testing script for Intel P-State driver crashes during the run.
 this patch fixes that crash and produce typical results.

Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

---
 tools/testing/selftests/intel_pstate/run.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
index c670359becc6..1c2c87b02429 100755
--- a/tools/testing/selftests/intel_pstate/run.sh
+++ b/tools/testing/selftests/intel_pstate/run.sh
@@ -27,7 +27,7 @@
 # and the test will error out in those cases.  The result.X file can be checked
 # for consistency and modified to remove the extra MHz values.  The result.X
 # files can be re-evaluated by setting EVALUATE_ONLY to 1 below.
-
+#set -xv
 EVALUATE_ONLY=0
 
 if ! uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ | grep -q x86; then
@@ -101,10 +101,13 @@ cpupower frequency-set -g powersave --max=${max_freq}MHz >& /dev/null
 echo "Target      Actual      Difference     MSR(0x199)     max_perf_pct"
 for freq in `seq $max_freq -100 $min_freq`
 do
-	result_freq=$(cat /tmp/result.${freq} | grep "cpu MHz" | awk ' { print $4 } ' | awk -F "." ' { print $1 } ')
+        result_freq=$(cat /tmp/result.${freq} | grep "cpu MHz" \
+	| awk ' { print $4 } ' | awk -F "." ' { print $1 } ')
+	result_freq=$(echo $result_freq | head -n1 | cut -d " " -f1)
 	msr=$(cat /tmp/result.${freq} | grep "msr" | awk ' { print $3 } ')
 	max_perf_pct=$(cat /tmp/result.${freq} | grep "max_perf_pct" | awk ' { print $2 } ' )
-	if [ $result_freq -eq $freq ]; then
+	if (( "$result_freq" == "$freq" ))
+	   then
 		echo " $freq        $result_freq             0          $msr         $(($max_perf_pct*3300))"
 	else
 		echo " $freq        $result_freq          $(($result_freq-$freq))          $msr          $(($max_perf_pct*$max_freq))"
-- 
2.17.0
