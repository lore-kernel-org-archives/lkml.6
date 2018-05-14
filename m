Return-Path: <ahiliation@yahoo.co.in>
X-Google-Smtp-Source: AB8JxZrt12UOX9cTdp/auJNVUYPtXvtjKM5yXa0wrN+0BDur0uFcbeUL+fi4l9Y1NgTmk1LrnKTm
ARC-Seal: i=1; a=rsa-sha256; t=1526335325; cv=none;
        d=google.com; s=arc-20160816;
        b=QU1hKZqZ+zdNbdPiMyGzFAzMcZdM/19Pa5kZrhVgyjqE73eYN0ropLx3/qUHPJRPQw
         Zf6M2NNkaEXg1xT7h7BVDTRXCE/2+1bZOMqKFo1UdtrviVlomy05lLAYiq91buWQ8DxR
         9wNio83DfE6d40KfqiicpTghmRl/MENmXfGkCi6zyBkdq2QCR3g9eICBa2wuJtUmYwPs
         ARMEeTumrVg8SjBFAG2fkYNVJWLmB00fG+CC6m7dayCi2xXSivfZq0bHtiBKMHeODsik
         W0EwaR2mSucxixSBD+Z+prMyTXkbpndZm6Vy3bvZ48Ts8jioQSqx5jf/3w0n295WuPNI
         z+Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=4Ugpn4mrtJm7ENiNBt+Bnq8KamOJl5RnkThZJENqjVQ=;
        b=rs4B6/psNDkdyb33ouaVEs7MY0aoDDbLBm4MrTatyqssYpFFKTTr8ZTAHSNJBG1Boo
         Tyd7OVDtt1kejGSC51+9hPD9b9cgIX51U18+86/h3XxGttfKbI0giwWmAh20UBnOgaeG
         FthdFZDjIaCBKuN2SvRFWCDtzcbwHqPwyz/d3GqZ+YS7kVF5etJcFk6qnbNyD9qduSn3
         lLdIaa7VRtg9goF1gQVSOqWnAyO96+L23bemH6WnDezBibuloZnj9hhchRGcYNAGeJYV
         rTFdCWl1PAtI22eg5wnYW1xar3sXPn/7RL9GroZSOCDnroGJ0WlwJ5afhSsbET6H8n2w
         zCFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@yahoo.co.in header.s=s2048 header.b=s30N/frZ;
       spf=pass (google.com: domain of ahiliation@yahoo.co.in designates 106.10.244.83 as permitted sender) smtp.mailfrom=ahiliation@yahoo.co.in;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=yahoo.co.in
Authentication-Results: mx.google.com;
       dkim=pass header.i=@yahoo.co.in header.s=s2048 header.b=s30N/frZ;
       spf=pass (google.com: domain of ahiliation@yahoo.co.in designates 106.10.244.83 as permitted sender) smtp.mailfrom=ahiliation@yahoo.co.in;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=yahoo.co.in
X-YMail-OSG: ZYg7_I4VM1lFjXtpTmGv23XZb9FAzXDmXHcJ941zD1SEzTV9SC4kMBBKEkg1d8X
 a6JArHhd7BklB3_50JeXqu9X7TrD57.6urzwFu3dvzI8.UBOZWm3QXOR2KwwmIV7tDHCA_RsxVOD
 uj_gEp1Etm8DaoPVknw5jY7VT.g78gdmpKwoDziTlHe58jdciuqvwX9vS8dtOalVVR7s7emNZ.4j
 M5WCyZj7QSazeTa6oUKsoYlYEP6HDuuxnEk75VzFnC3PFheo2uWnR0Ixq9SliewRhFt9qQfEdD5L
 WjqwCuKKmU3BtfaKFOHqfX0oWVMbrxsAOB4L5Hoa3adsA_QHJh.W5pZ5MscW_YwfRu1Epuut4cn9
 d.rTpzQoDoVj02E4YeidAmjIJZ53fU3isceUuMHt3kx_kfm4ucl3j2DWZtZcsBqBXa7YAAbqD_wM
 jZREJc_r3wQEpIcljsscyj2kO2eE3R.W5lmwbzoAw_KAUwkBkFN5YAccSQH94K0GozuyA079HByQ
 AVIuMXOD0e.WN6e.RzrkMZzWN9X8bJnp3onMhtUPUhBehnc.9PPSM5rA_Y0w7aR9S4BLhOpPZ0Vr
 XtPcqHYtrgAVXbnKXJ9iyNox4JokwWleefNIUjV9Mrl0dhQt75bEnkp9sUnWReVshChe.bC3WAs_
 tuh_QNODqebc2yVQE5U11YA_vW7wOqsUd
From: Jeffrin Jose T <ahiliation@yahoo.co.in>
To: shuah@kernel.org,
	kstewart@linuxfoundation.org,
	tglx@linutronix.de,
	pombredanne@nexb.com,
	gregkh@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeffrin Jose T <ahiliation@yahoo.co.in>,
	Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Subject: [PATCH] selftest: intel_pstate: More accurate error message and also a debug support message from aperf.c
Date: Tue, 15 May 2018 03:31:54 +0530
Message-Id: <20180514220154.9507-1-ahiliation@yahoo.co.in>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600478158436689024?=
X-GMAIL-MSGID: =?utf-8?q?1600478590126238447?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix for  aperf.c to produce the path of the file which is in mention
during error report.CONFIG_X86_MSR=m support requirement is also mentioned.

Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
---
 tools/testing/selftests/intel_pstate/aperf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/intel_pstate/aperf.c b/tools/testing/selftests/intel_pstate/aperf.c
index d21edea9c560..da98c1673f08 100644
--- a/tools/testing/selftests/intel_pstate/aperf.c
+++ b/tools/testing/selftests/intel_pstate/aperf.c
@@ -41,7 +41,9 @@ int main(int argc, char **argv) {
 	fd = open(msr_file_name, O_RDONLY);
 
 	if (fd == -1) {
-		perror("Failed to open");
+		printf("Failed to open /dev/cpu/%d/msr:", cpu);
+		printf(" No such file or directory:");
+		printf(" Make sure CONFIG_X86_MSR=m support is Enabled\n");
 		return 1;
 	}
 
-- 
2.17.0
