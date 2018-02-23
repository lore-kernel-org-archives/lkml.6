Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226MQD14n1lBrcSpGWuNJvasOX14B6uoWBarVklqB5C5YpemhyKWR5Zke0r4KKRX84XOFG+f
ARC-Seal: i=1; a=rsa-sha256; t=1519411605; cv=none;
        d=google.com; s=arc-20160816;
        b=E/gB0gwEmHtFrl6WAAXyLayGlptjMlPP9dIO+6wIwOx9Sr1nFq6loiE9nbs5A/crWW
         dZRh1EthhJlEKYj6p7HF2Z/MIHiLiBiTrTzJqN28ncYy1sRSY7OHa6onsBkH27SLEueO
         MOXkx60ynwOBCDKERLVXOhCpU+/FnHh69SEEmKIzhqbL3w72wVsyaskkuVzdWlti/9SF
         Ecbf/8IGw09c10OqqungoZKLNx2A15QLOelhVYDt6buqIpQp5bzX2myPUG2oSYmc/sHB
         SMYdC2RfyvGghcn31qMrGfe1Q91wu+yiuPXPqC2zefwWcdUZQSgv8tWiwbaW9PF0/TmG
         KJWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3ojkqMIqU81gztgUwCHGxx549RIKSe9WEpDLK8A5z14=;
        b=JwNQnicoHL25mSEkqBO3e/21JgewSMScm+3zFCwwW8AcrDwPId9lj3m3gLtREarziI
         DDpy1dudgfBAXMRlcIouR4FHgKIWtA/5idKVM0T0b4/5v74o+RPLVzlhX29/wEQzG67L
         h/dDHT8CVFUV7p/ls3xtRRtTtmZ+Tg8Rn+9bPKpiiqFa4YItAgKIbAe17ff/kEcddIvJ
         yvl4rjX84c+i93RdA/uWJEwwld0xBYWC53wwN596BoLJTe8hR3zzPcCrXUQ97NNKwebq
         mT/+dQfeTyD/szDzJ55bXKnPyeIaJJyCP64lmTnDbUIIQM8sbrON3Br/4Sifgv6Jupts
         sLkw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tai Nguyen <ttnguyen@apm.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.9 101/145] perf: xgene: Include module.h
Date: Fri, 23 Feb 2018 19:26:47 +0100
Message-Id: <20180223170737.860877648@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218544123147402?=
X-GMAIL-MSGID: =?utf-8?q?1593218544123147402?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Boyd <sboyd@codeaurora.org>

commit c0bfc549e96231e0ead4424de6e4933fde819d70 upstream.

I ran into a build error when I disabled CONFIG_ACPI and tried to
compile this driver:

drivers/perf/xgene_pmu.c:1242:1: warning: data definition has no type or storage class
 MODULE_DEVICE_TABLE(of, xgene_pmu_of_match);
 ^
drivers/perf/xgene_pmu.c:1242:1: error: type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE' [-Werror=implicit-int]

Include module.h for the MODULE_DEVICE_TABLE macro that's
implicitly included through ACPI.

Tested-by: Tai Nguyen <ttnguyen@apm.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/perf/xgene_pmu.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_fdt.h>
 #include <linux/of_irq.h>
