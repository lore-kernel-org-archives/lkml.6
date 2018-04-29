Return-Path: <ahiliation@yahoo.co.in>
X-Google-Smtp-Source: AB8JxZruZq1iPmn9I0qz9DV0+6zEC7833WvS4AE/etoywrpnz5MqCJA7tQvsTxUWmyan0lq+flq2
ARC-Seal: i=1; a=rsa-sha256; t=1525029212; cv=none;
        d=google.com; s=arc-20160816;
        b=dVYEwcXldhYyXfVXTBiJGoKNTKlx+W34IKJ5Wd3/rDLf1P2LQr9OMGfUWKog6OPz1B
         35HOhLPhnuHX3k4HnHzNdW/eS7WngRJkDtUgqX0gmKXUbm0usKrDoLWeL/EYdiCLBVYd
         yONJO/h1QZlqseYYZ/JmSHmW5VASWCFnBpXdhMuCJjyRLC3S0D7oahqd3rQr01AcYj1J
         SMni/J6ucviAEGMjNVr3GzGw2oKVEJEss56ujqhoniKStd7I1PZi0BhGXLNTdK0+l5qu
         aKt3+8ONV9XpDtaxLhelUSe1SdMbvmVzdxtp+PSmXVvrq7eT/1VmGU8qWM5z8QLoMcbT
         7jlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=C8iMnQMkQ8EJpJt651AkrZxjWIN53YQ2hbzFZSOm1Q8=;
        b=hC4CiircJCJCTQaTZQ8hnagIckHHGP42FXFJh74bAFVDLK5tsx1Ue8eXJm8IbmoN8r
         iqxYx9ClWfRnAVYs5c4eGAh9flK3FQBnbKWPeTmdJESWXTPzeibvfzBlGF/xyh42lXBD
         sfGTyBot22glpGg1z4fzni+fUMDzcwW97+sDIDivN7KrQHLpfbUoP/7pQ1BHjtrywHRu
         Q1/jbjnSwQ8Zbrt00tXb46tKRotQXz44yY7MLoCIunMLHFY6KNOLCmGN7Ai56MyUF73v
         FX+u3H2BSqKlcEvAxU75h6v0A6MaZFq9A4TCtG2jqvrE1j+apcOTJohEcUGVS0ETpD5d
         iGEg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@yahoo.co.in header.s=s2048 header.b=njxrGFru;
       spf=pass (google.com: domain of ahiliation@yahoo.co.in designates 106.10.242.84 as permitted sender) smtp.mailfrom=ahiliation@yahoo.co.in;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=yahoo.co.in
Authentication-Results: mx.google.com;
       dkim=pass header.i=@yahoo.co.in header.s=s2048 header.b=njxrGFru;
       spf=pass (google.com: domain of ahiliation@yahoo.co.in designates 106.10.242.84 as permitted sender) smtp.mailfrom=ahiliation@yahoo.co.in;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=yahoo.co.in
X-YMail-OSG: HUQqXZoVM1mGV2uRsAzYdWXGGlAHWCT2GHPlwnLBNO11oCP_jIi5vYhtkCeytfV
 PJ_ESign9Bjx55JuGz1TcHIahDxtdomFfDziRTpVryFHsQ2gq27w.9i8asJG_LWQHY4LORsbK0Vg
 8EDyUEtuifYJJgRrYQlD7qhWFvxsXMnhE6kczcsUqvYotagKbqJtZeAeE05MIztrmuCHQ9Wx5RWJ
 6cYx.TvkzLi64sAGeh45yLv5867yzzHbKcbsGi1iYWvoXMLrItkptdjXZqFj7jfCSiZZqDq8drAX
 HywInGZkT96buEYuBiDk1yWdUqGy3BQWnhSS7h1gy6TLa432vilTk0pwadsFcnFhIW.U1eBSW5Hh
 O9NxVNuSt5hBkjt_gj.0MzFZ1js9zUIOcVGOB5x48pzCMkfE5oVNOaV4erwJhM5dymrc5BZQAFX0
 6zHoTU1zyKw_Io3gxdg1I7c1vLbdOv7coCd_31E_4vSs9q_Zfi42qvUUOmIJGMAPx4xkvUWH2qsk
 e58UVJ_fK92NFZVZ_PeQXBx3AHhtvndHEpShRr_WtnqKsLjsVpTy.pSYYVxm1wG2bkZx2rUitpon
 GEEM51we_cFJJy_OWo9.QqY7WUDl1pypdNlaGPaxB.nxDeUuMQNQzuA0n6gAxgUiYVoYwWhrzhNQ
 Pi58xtSLAyi4TO981m2oc04HueffsA1XMSew-
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
Subject: [PATCH] selftests:intel_pstate: fixes typical crash of a testing script for Intel P-State driver
Date: Mon, 30 Apr 2018 00:42:26 +0530
Message-Id: <20180429191226.14242-1-ahiliation@yahoo.co.in>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599109031684062016?=
X-GMAIL-MSGID: =?utf-8?q?1599109031684062016?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

 Testing script for Intel P-State driver crashes during
 the run.  this patch fixes that crash and produce typical results.

Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

---
 tools/testing/selftests/intel_pstate/run.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/intel_pstate/run.sh b/tools/testing/selftests/intel_pstate/run.sh
index c670359becc6..cd32aca8806f 100755
--- a/tools/testing/selftests/intel_pstate/run.sh
+++ b/tools/testing/selftests/intel_pstate/run.sh
@@ -27,6 +27,7 @@
 # and the test will error out in those cases.  The result.X file can be checked
 # for consistency and modified to remove the extra MHz values.  The result.X
 # files can be re-evaluated by setting EVALUATE_ONLY to 1 below.
+#set -xv
 
 EVALUATE_ONLY=0
 
@@ -101,12 +102,13 @@ cpupower frequency-set -g powersave --max=${max_freq}MHz >& /dev/null
 echo "Target      Actual      Difference     MSR(0x199)     max_perf_pct"
 for freq in `seq $max_freq -100 $min_freq`
 do
-	result_freq=$(cat /tmp/result.${freq} | grep "cpu MHz" | awk ' { print $4 } ' | awk -F "." ' { print $1 } ')
+       result_freq=$(cat /tmp/result.${freq} | grep "cpu MHz" \
        | awk '{print $4}' | awk -F "." '{print $1}')
+	result_freq=$(echo $result_freq | head -n1 | cut -d " " -f1)
 	msr=$(cat /tmp/result.${freq} | grep "msr" | awk ' { print $3 } ')
 	max_perf_pct=$(cat /tmp/result.${freq} | grep "max_perf_pct" | awk ' { print $2 } ' )
-	if [ $result_freq -eq $freq ]; then
+	if (( "$result_freq" == "$freq" ))
+	then
 		echo " $freq        $result_freq             0          $msr         $(($max_perf_pct*3300))"
 	else
 		echo " $freq        $result_freq          $(($result_freq-$freq))          $msr          $(($max_perf_pct*$max_freq))"
-- 
2.17.0
