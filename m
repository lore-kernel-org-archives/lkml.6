Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-628284-1522188139-2-2260183442670088854
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES daensv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='comi', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522188138; b=YxaC/xJ9qYoc3TSmNyL1HZNwtUDQGEQY61iNJfmYsxgn2rD
    KVVBd3TnpxvF7ljlS8DPc60AkCB6/AO3wqk/irFcm0rqMM5kDu3yIZA+9gdsAlir
    trdkGadlu8kuj90QlA0lNq9Q4CjHUVQXUfnuClQMiQHaOauaIa2MYqVuhQRTszGk
    WkZnMpFnjmlTBFMZa3IIGZs1zC8qX2hOWJrT/dCaxyn5f5RInADNtkoocXncBtLN
    +/WUjHJaXIPT+T1pCSqQpAR3a4I9fUdJHtwd4VlM6iVBI2Br0QX3PNoxXd/jgvBn
    IT2NyJjjRrC7B6mj83i0fEaJJNNoALoCXIXpV0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:mime-version
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1522188138; bh=bz+ccXEtYkGB7grR5rSh5Ilc80tEsUrWOw7nZPTbMO4=; b=J
    veoONO64Ja7c1odNA+UEvGteWqUnrIsqtOvqA+jGePn6bsImIVPkpsroinUdiQCx
    8qOEitfahKH8mECSftbbGJFd1BzFytHhLo13C6XG3b7bwu2dRu+aDzBI5hzxV57s
    HR5tHvWWWXBkCLotDrSw9zrMiiJ2F/WbHWwPiM1V8hvtB59mFAWed4KpZpA7rR2r
    Pcd2nb8jkHa5YA6S4l0wjmwaAcoonnpMtmysmOLJIWUU1/wtfpf9AYrxJsQdZ3cs
    pu7GxjCm3RBsWmah4CEBeTNX4Vlc/PLc/tHwOEN009J2nN5jWASN6y3fqoub2DDA
    uBNa8rjcFj2jqaLzAKsBA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=permerror (from header invalid) header.from=linuxonhyperv.comi;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.comi header.mx.error=NXDOMAIN header.a.error=NXDOMAIN header.aaaa.error=NXDOMAIN header.result=fail header_org.domain=comi header_org.mx.error=NXDOMAIN header_org.a.error=NXDOMAIN header_org.aaaa.error=NXDOMAIN header_org.result=fail header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=permerror (from header invalid) header.from=linuxonhyperv.comi;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.comi header.mx.error=NXDOMAIN header.a.error=NXDOMAIN header.aaaa.error=NXDOMAIN header.result=fail header_org.domain=comi header_org.mx.error=NXDOMAIN header_org.a.error=NXDOMAIN header_org.aaaa.error=NXDOMAIN header_org.result=fail header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBOCbJI8uOsZ7QYqNSws5apHD/ttS1jSWS7+VxiFXeGFW+PHM8VjVzcT5Z8l3UchW9g8/FlES4KHKD7l4XJw5N475o6xVKR7A76q882Kbm+NlPdP5J4C
    NZ6KM6Y34ip3Tiy6FkuPhPYbSA20C+rM6CBZjFEVfEn185lslj8rz1OORLle1mkW6TO6Op8LHv4LhXpe9B/toGyOd62nhF6u/MGeDBv9V+bCkY1VlinRXqf/
    oMIOabyVf+1WILewvXjEzw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=wmH2h71lHiwA:10 a=kj9zAlcOel0A:10
    a=v2DPQv5-lfwA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=jZVsG21pAAAA:8
    a=yMhMjlubAAAA:8 a=DDOyTI_5AAAA:8 a=QDM3AfRHfiM7u64taggA:9 a=CjuIK1q_8ugA:10
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
Subject: [PATCH 4/4] hv: add SPDX license id to Kconfig
Date: Tue, 27 Mar 2018 15:01:04 -0700
Message-Id: <20180327220104.19700-4-kys@linuxonhyperv.comi>
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

Missing license on Kconfig file.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 50b89ea0e60f..97954f575c3f 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
 menu "Microsoft Hyper-V guest support"
 
 config HYPERV
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
