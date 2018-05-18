Return-Path: <ahiliation@yahoo.co.in>
X-Google-Smtp-Source: AB8JxZpvXmLXbZhwPIPPcJNuBKucfCmmQYkli1NDXpdzv190HaB1ikkzjOBu4hhg7H0fnzWV4pcn
ARC-Seal: i=1; a=rsa-sha256; t=1526652403; cv=none;
        d=google.com; s=arc-20160816;
        b=RL99Msm8foPloL2mkrFpICYc0xLz5smMs4Y1GosQjyRWr3aOPW5mYNqEKIrvCyf2a2
         le4NL5pLuSclU/j5IXTL5a0MHlCy3yD8B1juS6aqA+ZOCdLGNrI8RkuIxwrqSEtgVqqb
         LhZLNtCp8/YE6IyEgMN/Guhl3kBWpa1GKuBHmGBzJ8GV0wqFW2LEFUxXb5Dt4PgyN4r2
         g3/C5421C/6P6J6hh3P08TwpWjPIQe9YHFJ4UOzPBDx7wwk4Cmgorkkr6dIxQDBeR0H0
         hxUWk+Dp7CPESErQqlgjOc0dzkwZT0F6/Up/bZC9zpJhWHNYX9jnrJYvZOqnE+pU7gez
         Cgbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=DUebm5HfBfe5KwmLL5GfMoAmHKfUgYdFvcMppTvXwGY=;
        b=03x+OpFS1J1GnHqAJNbYx+paqMbzY+Wm0DvgRYZRFLHT7wUgFsC4uLSNFl8ZOlQMLS
         39dkGrGyAevdRq+MDzAg0Evi6CcTY82pA06Y7Xm5viM5qNg34DMBGXxKKGruXx0Kt9dT
         5JYCHqgE749JJJLKwjD//0dsafX6hH9bEZ1/KrIl8rPE1JxEd4P8jpameh3gmL0aXhsK
         CgvadWKLOs8AsvVZ//nG+bl3MFz9J26QF6BREzKXA044LB8d9hqFpkxAgI4UN6iLiRUp
         n551h4e/rponVXBv69sQsbHlLtBQeis9lSpZi7NW6zHqTPv9Jfi5PGC7Wi93YKLNIFH7
         Ry1g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@yahoo.co.in header.s=s2048 header.b=s5t5ZqEv;
       spf=pass (google.com: domain of ahiliation@yahoo.co.in designates 106.10.242.83 as permitted sender) smtp.mailfrom=ahiliation@yahoo.co.in;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=yahoo.co.in
Authentication-Results: mx.google.com;
       dkim=pass header.i=@yahoo.co.in header.s=s2048 header.b=s5t5ZqEv;
       spf=pass (google.com: domain of ahiliation@yahoo.co.in designates 106.10.242.83 as permitted sender) smtp.mailfrom=ahiliation@yahoo.co.in;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=yahoo.co.in
X-YMail-OSG: xUBOBkQVM1kFqkJOsBEW_QNex0L7CTPg2AlJ4CSm7X8srFXw_jwOb.2luz5RNE9
 aDA0y5g5n4a8IqLVaRzmOiVI5vQO577AHWCXO_DuH3LHZ.7x7eeuKmfEsQHIjLdRzAPKk6yHmyiF
 ncDRWRXRzDyGDcIMowTh5o5Xi9Jtqg16tcvm4e7A3p2tN3W7KJfT5CzBgUANYLPU1y3fgEihIbam
 hjoyr3N9Yfm_7ckDViYXHW._9q6bhfGPfLBTTCBYHrLrOGEKqLg3hXekSSMNNn0AWpL2JwfLAWY7
 1ujVFJat4KXDEAXFgWW_YAmFFMQL3hK2vZKfQaCv9lr438AfbV.8ETz1RVKfbw_0n0FRbSxSqxpV
 bivv5SAahdgbXQJYUptUnvLJIE7MlMRvUKgw2gILQTi2vVeJUz5CXMwMbUOQWZqkNuSiKJ_qAYW4
 f7UJH4ckozA2RDhsg.AYdHkhZ6zvCBaUYW1yVJZ6R0dAnV6aMveK.4XsIf.IvFxe72C8l7KUYxLy
 8BKBR4UlpTk5hFaAemeoUbV9GBaxGdqV.6IAicN5uz19LZgiWbZ1aX6yGk4ir4ZYuQYdvZspvqYV
 G2rf4rEo2wfBETrNKvQUfkFsm19iJZ1Cq7bK_i1Gra768NA6h.i3tG14I5NtsD_N_nikamV11cCt
 8_maUAjMTqkDPuPc_DducoDzyauTnsly.
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
Subject: [PATCH] selftest: intel_pstate: debug support message from aperf.c and return value fix.
Date: Fri, 18 May 2018 19:35:50 +0530
Message-Id: <20180518140550.2280-1-ahiliation@yahoo.co.in>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600811069911886051?=
X-GMAIL-MSGID: =?utf-8?q?1600811069911886051?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Additional message along with an error message which is more
verbose for debug support from aperf.c and updated with the
new return value "KSFT_SKIP".

Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
---
 tools/testing/selftests/intel_pstate/aperf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/intel_pstate/aperf.c b/tools/testing/selftests/intel_pstate/aperf.c
index d21edea9c560..f6cd03a87493 100644
--- a/tools/testing/selftests/intel_pstate/aperf.c
+++ b/tools/testing/selftests/intel_pstate/aperf.c
@@ -9,6 +9,8 @@
 #include <sys/timeb.h>
 #include <sched.h>
 #include <errno.h>
+#include <string.h>
+#include "../kselftest.h"
 
 void usage(char *name) {
 	printf ("Usage: %s cpunum\n", name);
@@ -41,8 +43,8 @@ int main(int argc, char **argv) {
 	fd = open(msr_file_name, O_RDONLY);
 
 	if (fd == -1) {
-		perror("Failed to open");
-		return 1;
+		printf("/dev/cpu/%d/msr: %s\n", cpu, strerror(errno));
+		return KSFT_SKIP;
 	}
 
 	CPU_ZERO(&cpuset);
-- 
2.17.0
