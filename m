Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-628284-1522188137-2-2596782887645577501
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES daensv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='comi', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522188136; b=rg7HeAFlewwgf8wBtug87b0QJ0MJxwu8m4NH+d8rla7RK2J
    Brt9iZv9qYuy+UgzVkJru2rJA10Pr7vUVVw5dwi3sDGygImR8ukxr8uasjqHHngA
    UtknOku5Vlw7tXBHRs4cfC35D89naR8dSrl1RjynwA0vsTyrZtl7VOj7wG0mMCvX
    aSEaDcCkDLq0mdqgJX1DDwm4WiSsIeeIho9tuqwKm3nvp545RRD4j62z3Nrqqu++
    eMa67oF6MraaibbhlE1A3vKKYD4DnWXSOrYOkCRN9fUB7dv7ulnmJk0CobCSE3b/
    59n8cEy0piPreMDVecx0Mns39X8hWi206EC7RbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:mime-version
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1522188136; bh=JWonYCpFIy2AAvF6g10buCLA514Q/0B234Ob3YvooBs=; b=F
    WrJiMCw5rHeO+RCbpWTGcq2T/ChqybDPGBaeO4Nn7YKvxjj+3Pux68fnBc5V7s4v
    8kYKC1H72WbRDX0bEgsLY3l4ptUk/A9Vb3KeWka3AGAYkftAamcdQtK1xX5ymA67
    vAyCMK7YiUqIULW4q6Jn24he3LTHROyoX/PEogyGKMq1wP9msq0j2f4O63x6loU+
    zA2+3vuZQfczlojXKseMu0TeHAQgT6LUPn7qnwsG5SzZJcUpuIm2AROzwh+7mTeV
    UDBqyLSTrLkrxCqJS5IMY+7um1lz8di/g8tdjeYNcHxcKcphu+C3CelpRYzK8Z/O
    MR5q227x4VD2ta8sN0+JQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=permerror (from header invalid) header.from=linuxonhyperv.comi;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.comi header.mx.error=NXDOMAIN header.a.error=NXDOMAIN header.aaaa.error=NXDOMAIN header.result=fail header_org.domain=comi header_org.mx.error=NXDOMAIN header_org.a.error=NXDOMAIN header_org.aaaa.error=NXDOMAIN header_org.result=fail header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=permerror (from header invalid) header.from=linuxonhyperv.comi;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.comi header.mx.error=NXDOMAIN header.a.error=NXDOMAIN header.aaaa.error=NXDOMAIN header.result=fail header_org.domain=comi header_org.mx.error=NXDOMAIN header_org.a.error=NXDOMAIN header_org.aaaa.error=NXDOMAIN header_org.result=fail header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGRzWfnv/inaQIWjA5JfaiRvOrusxfCcrOCd/i5LCqXEIysPJqWMYDo2PZkbl1s6i5tRnpPrUOK22IMrw5oQzhMvvecYS3aRd0wC4H1dbtuSjVGr2pKv
    8Wz8s950pYX7efgpwPlMTC9sJzryzR9Axe9eCXw9nuHoAY7RE6NfxPglJRDEQ2UJONdWtor1lZFQRN++U8hD98fjdF7VtOCsyOESm9mybM4n760qnTqIdVYp
    8OpuQZz/hM2f2YhYBFXlHg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=wmH2h71lHiwA:10 a=kj9zAlcOel0A:10
    a=v2DPQv5-lfwA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=jZVsG21pAAAA:8
    a=yMhMjlubAAAA:8 a=DDOyTI_5AAAA:8 a=vA5LkutvRwjHKDT1gH8A:9 a=CjuIK1q_8ugA:10
    a=3Sh2lD0sZASs_lUdrUhf:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: kys@linuxonhyperv.comi
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 vkuznets@redhat.com, jasowang@redhat.com, leann.ogasawara@canonical.com,
 marcelo.cerri@canonical.com, sthemmin@microsoft.com
Subject: [PATCH 3/4] hv: add SPDX license to trace
Date: Tue, 27 Mar 2018 15:01:03 -0700
Message-Id: <20180327220104.19700-3-kys@linuxonhyperv.comi>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180327220104.19700-1-kys@linuxonhyperv.comi>
References: <20180327215859.19624-1-kys@linuxonhyperv.com>
 <20180327220104.19700-1-kys@linuxonhyperv.comi>
X-CMAE-Envelope: MS4wfDFCzh3CnZz19vCFI5bwM0LgpYHTGaETm+8mz4V+JBEA0KRH95WQEnHKjtGBaxkBcs8K0TeqNuKX3tj0WXEPJvBzzG0Mw2aZn/1RSs+ZBiSC8b9UzoWH
 TkdC3PNdmXULQ34hzcHHTB0+d8nKluIExZtPz3QYfZFEP83OKCNGw7XP1iws1QNeaVw4L0zlfSbAwedtLOwMekELJjUXkcEXnYfpfA+EJfV0hgzBAfSHm7y8
 wxLXMlR/H5DE8AVpO+UwqM5kkE+o3V4bPc5lDGYYsXxoO5HCgqDUp6c9VF/wRL9G6Ple4NC53R/XT9o4YA/9+dzCvyzVD7d0x0XvdzQ10P2oi+7otrlutslB
 uYWGvF6EfVOaDxqV8zcHabFwcE+nx2NmEnRLpV8Aixb8O2t7YDUlE7DE4J/D4pwUpPzO2bet7xk0q53qTHq367hQKtOQ0oiP180ODh0bimRTtxJ9LbuK4gGo
 NJUlooyZ8d8aXPCOPeOPs1MZBIexr/bi7g1lybIi+QsJP7mEVe2yXk00bQidjkPNWWJAMX8RWx6i7mW1e9F0UAFpW+hQmkVx8bomJF1ha2iXAsG3VeLfX39j
 Dys3dgT9Di4W99zPNibrDbvz
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Reply-To: kys@microsoft.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Stephen Hemminger <stephen@networkplumber.org>

Missing license on Hyper-V VMBUS tracing files.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/hv_trace.c | 2 ++
 drivers/hv/hv_trace.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/hv/hv_trace.c b/drivers/hv/hv_trace.c
index df47acd01a81..38d359cf1e70 100644
--- a/drivers/hv/hv_trace.c
+++ b/drivers/hv/hv_trace.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 #include "hyperv_vmbus.h"
 
 #define CREATE_TRACE_POINTS
diff --git a/drivers/hv/hv_trace.h b/drivers/hv/hv_trace.h
index d635ee95b20d..999f80a63bff 100644
--- a/drivers/hv/hv_trace.h
+++ b/drivers/hv/hv_trace.h
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM hyperv
 
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
