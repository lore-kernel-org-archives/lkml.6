Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq1ty7+xn3m3RpSOanr7UtkPVZ6LAKWojI4rWSSI47vPCMQCHcGZRVrXYUzPbwx5cJWh9db
ARC-Seal: i=1; a=rsa-sha256; t=1524838369; cv=none;
        d=google.com; s=arc-20160816;
        b=Fq7pam76R4m4S+trxW6+zG/SXjbvFBjPFtgo7mBXwUgOv2weBtevSVIFK3narB3Y4i
         r0MllfKT+xNKMS2vp+H6M0V+HevP04YW1hDFckaehbS8vjtFaR6PbqZcNa/7oTTBQQdc
         zdAubSELIPPOgrWj/SrrboRhhWmEfufHrZN0w2cN9+tM6UIPhflY54DBzyPL/Rx88txF
         0KbQq49+wULoSoAN7gh7K2MnFqFiYqW298s8CcL6LkFEvQGj4JAAtMpNLWDHvicQZjeg
         ArrE7HUXJCEDKtwCWe13L+d9nztXlMztzj/pztkGz2utg2COhGBaqZVjFDnAynATEuNl
         4q5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=hEzUjIRWtTsmHntyaYFtcpn64LVlKdmyqBLm+/YeNKc=;
        b=R/2kF6HQo0bPUYZub8j1D9aDAhrXBI1QjlCKOVbWsD8/G8dNNa3NBeUIp3lfV58+lm
         oLe5BdeDkvZHtThZAmQ+dKvzksdiQYnPLvkP83Auj2uldkKixPfKjPg/3RXZi74/Q88t
         ObSR81oI5KDUdsqOBh4KjoUYnXIyAF9inxorzI4nBy8XhjS1VldmaCUDwBYvHEAlmtdk
         aSRMJK049fVaBbqTJvh4tW/H4FWAgONK/IB6LuMgGEiH+L9SWzLugBtDsVokW+fPqS7N
         s0mEVoeCeLN270koC7vM5qHA9Vx3upwdUMVo3WJb7gD2EDbkj2EQvsCaIghyXVN/JdhS
         EluQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA36E21897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Wild?= <wild@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.16 79/81] s390/cpum_cf: rename IBM z13/z14 counter names
Date: Fri, 27 Apr 2018 15:59:21 +0200
Message-Id: <20180427135747.819250603@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908918720075065?=
X-GMAIL-MSGID: =?utf-8?q?1598908918720075065?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: André Wild <wild@linux.ibm.com>

commit 5f3ba878e7a2ffef82fb0882c0dd2c3507d734bc upstream.

Change the IBM z13/z14 counter names to be in sync with all other models.

Cc: stable@vger.kernel.org # v4.12+
Fixes: 3593eb944c ("s390/cpum_cf: add hardware counter support for IBM z14")
Fixes: 3fc7acebae ("s390/cpum_cf: add IBM z13 counter event names")
Signed-off-by: André Wild <wild@linux.ibm.com>
Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/perf_cpum_cf_events.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/s390/kernel/perf_cpum_cf_events.c
+++ b/arch/s390/kernel/perf_cpum_cf_events.c
@@ -123,7 +123,7 @@ CPUMF_EVENT_ATTR(cf_zec12, L1I_OFFBOOK_L
 CPUMF_EVENT_ATTR(cf_zec12, TX_NC_TABORT, 0x00b1);
 CPUMF_EVENT_ATTR(cf_zec12, TX_C_TABORT_NO_SPECIAL, 0x00b2);
 CPUMF_EVENT_ATTR(cf_zec12, TX_C_TABORT_SPECIAL, 0x00b3);
-CPUMF_EVENT_ATTR(cf_z13, L1D_WRITES_RO_EXCL, 0x0080);
+CPUMF_EVENT_ATTR(cf_z13, L1D_RO_EXCL_WRITES, 0x0080);
 CPUMF_EVENT_ATTR(cf_z13, DTLB1_WRITES, 0x0081);
 CPUMF_EVENT_ATTR(cf_z13, DTLB1_MISSES, 0x0082);
 CPUMF_EVENT_ATTR(cf_z13, DTLB1_HPAGE_WRITES, 0x0083);
@@ -179,7 +179,7 @@ CPUMF_EVENT_ATTR(cf_z13, TX_C_TABORT_NO_
 CPUMF_EVENT_ATTR(cf_z13, TX_C_TABORT_SPECIAL, 0x00dc);
 CPUMF_EVENT_ATTR(cf_z13, MT_DIAG_CYCLES_ONE_THR_ACTIVE, 0x01c0);
 CPUMF_EVENT_ATTR(cf_z13, MT_DIAG_CYCLES_TWO_THR_ACTIVE, 0x01c1);
-CPUMF_EVENT_ATTR(cf_z14, L1D_WRITES_RO_EXCL, 0x0080);
+CPUMF_EVENT_ATTR(cf_z14, L1D_RO_EXCL_WRITES, 0x0080);
 CPUMF_EVENT_ATTR(cf_z14, DTLB2_WRITES, 0x0081);
 CPUMF_EVENT_ATTR(cf_z14, DTLB2_MISSES, 0x0082);
 CPUMF_EVENT_ATTR(cf_z14, DTLB2_HPAGE_WRITES, 0x0083);
@@ -371,7 +371,7 @@ static struct attribute *cpumcf_zec12_pm
 };
 
 static struct attribute *cpumcf_z13_pmu_event_attr[] __initdata = {
-	CPUMF_EVENT_PTR(cf_z13, L1D_WRITES_RO_EXCL),
+	CPUMF_EVENT_PTR(cf_z13, L1D_RO_EXCL_WRITES),
 	CPUMF_EVENT_PTR(cf_z13, DTLB1_WRITES),
 	CPUMF_EVENT_PTR(cf_z13, DTLB1_MISSES),
 	CPUMF_EVENT_PTR(cf_z13, DTLB1_HPAGE_WRITES),
@@ -431,7 +431,7 @@ static struct attribute *cpumcf_z13_pmu_
 };
 
 static struct attribute *cpumcf_z14_pmu_event_attr[] __initdata = {
-	CPUMF_EVENT_PTR(cf_z14, L1D_WRITES_RO_EXCL),
+	CPUMF_EVENT_PTR(cf_z14, L1D_RO_EXCL_WRITES),
 	CPUMF_EVENT_PTR(cf_z14, DTLB2_WRITES),
 	CPUMF_EVENT_PTR(cf_z14, DTLB2_MISSES),
 	CPUMF_EVENT_PTR(cf_z14, DTLB2_HPAGE_WRITES),
