Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-703119-1520227146-2-8497608201486503120
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520227145; b=AcsYMFI+zBtPoxRrYkxfzJbhjnC/8b5W6gehM6xhiRzSuzN
    /F2+rlmSlQC+TqWJATnNwj4hIh0RB2ogndeRDo5B2O5cE8eW2gvR/vpb3k9/KPll
    nlIHkhWYtncg+7QZSGFmkIWe+A3xLK6qulnNV10ZQBym/a56y8kxe7We46uTRLhd
    zaModbn1ZR3p5ZZieGYTckpCuOq8NOfPTehofzbjO5CDQQP4FasqaUzRMEDchHdA
    gLOTC5iYWVFpNjPqbyFnrI254+M2Xk1lcmqMz51GNAJ/oCO7f0lOt1P11/MGhT/A
    jRoEcRExw4drH6Y+F+dZGDsiwIxW7Q9WirHZ/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:cc:mime-version
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1520227145; bh=ZPnMqX1eLqpfpFYNdIcfcV7UgwRHSeMGh3e/TdAJuZA=; b=B
    XXnDrVSpF0QoFcmto9MVTUPjoU8xIzi1rICqouWQL1Cbivnk23wRvfsa0+LanzYi
    965dhMYbkWCOAbDoMCTTcd9eTUDfw9EzP2JwlYCmRMoybZM/JTO52ITnvgS+4ZJc
    0PQZNHP7X0DuULywZhv7T8BgKLEyz2QKO8WRzSUPj1gFhrqhhUFxI4gkc8XCyOxo
    lGrXVBVtkhj/dTVfB7u+3tHj04rBYp4m46tAKNZkhtY1qSRdeohElU6552K2Yx+m
    lltHoyAVqXjJ5jZqJoh/MGdpR2XX97WuL64QCtoQT55U1VhyG3vhs6Zh6o4yRPVb
    6JhzJp3b4rETZGYixR3YA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=exchange.microsoft.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=exchange.microsoft.com header.result=pass header_org.domain=microsoft.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: kys@exchange.microsoft.com
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 vkuznets@redhat.com, jasowang@redhat.com, leann.ogasawara@canonical.com,
 marcelo.cerri@canonical.com, sthemmin@microsoft.com
Subject: [PATCH V2 03/12] hv: Synthetic typo correction
Date: Sun,  4 Mar 2018 22:17:13 -0700
Message-Id: <20180305051722.19157-3-kys@exchange.microsoft.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180305051722.19157-1-kys@exchange.microsoft.com>
References: <20180305051539.19079-1-kys@exchange.microsoft.com>
 <20180305051722.19157-1-kys@exchange.microsoft.com>
X-CMAE-Envelope: MS4wfO3FmTSGDr+t1J2VpC6dCIL02eaZf0GUknKOk79IuzofJAxlSZ8x1gdyY9DxeXTIbeFY9CYZSt2hYaNqcAm2MYNYiaW1RdDgOZLqbXf9llZEKVRJAe6W
 +BCV7ExcHDOTn/qi6fLa60yqntcP4MwXB4Ao6GAgzylHDf3ZMXyZQMQG5fFhrhy2n1mItxCh9Uy91f55os9dkQnS1mvbVIiZxnJS8sWIMY0X4f2vyYW/kwbd
 651Bv2KZwOuhE/tvPRgm1wwyhUZ7NtQ+rbU1AqM+9quTU0Vwt5UAbnsdxelYTuZcenypaC4rXapMTLjXuIaWVtHH0HTVrE1Wscl4dqF/rgr85j6VDea+L1WD
 orNDv69kFf1vTdh2yQ5aZ96LkSqD36qQ/XWyEZqNoq2e5c8nuyRcnmeePRf9nudZpI2jiVBjqvjzP0SaKSHM2GvLAVj5FKhC2UEBRgH55+jA+d5DA1PPGbpM
 YUa2HmaSjsIWSPxocnN4hv6ZwNN5/VKdaUEhUZydQwz/x69wEVGhFwcgC4TyyJLtiK4e1VAkCYvPWSsl1+vZ4cQbrQMEhPlw8PvsXRlVzQPyGa9F6WovqQ77
 XqJKbYLzmzbYeMLkhcOOoxVy
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
Cc: Joe Perches <joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joe Perches <joe@perches.com>

Just a trivial tyop fix.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index b6cacc4cccf2..31142b72f1b9 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -217,7 +217,7 @@ void hv_synic_free(void)
 }
 
 /*
- * hv_synic_init - Initialize the Synthethic Interrupt Controller.
+ * hv_synic_init - Initialize the Synthetic Interrupt Controller.
  *
  * If it is already initialized by another entity (ie x2v shim), we need to
  * retrieve the initialized message and event pages.  Otherwise, we create and
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
