Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-803568-1519459182-2-1535235255264142171
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519459181; b=v5ic17nS+Eb2fEL0AYWcAI7G0zV02n1qsCdkzPiiQNZ38u3
    LmgWkwbO7EWUsMEP54tjCNlJThYF8NLwnRby8VJsGHwMKdiGVIXQM6Wi6os9KZrY
    qgH7ArBCrmZGJT7Ty8/qR2I74zq6fxjTTnxtiV2SWz9bOeXuXX9mfxpDQYRzplkf
    bWCVhaVvepOeN8uaLCtd3oDwpckYOuUKL3GUA9klXWGm8V4QhyccJ/h1fBkhdK8s
    J3npi3A+CMFG5JjtHN0k5LA9t3wykKtfdEezBY6Evi98a0B2IyzKyhLxPnmi3agh
    Un9dovnBu37IwD3l391NkZIhVrYzX+zLIh4SLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519459181; bh=+
    qhNwyxKdeuE5V4zOqa9rAY7Dx8YI1NDqfxqbWcYAyY=; b=PMzxf4XAuoVMBH5hE
    KPu9xca28V3ZeEQw+GDuBqJ1Cw+xKbsSHTL7hAuM1q6RK1M2h//WyxsREN5p6e+Q
    eAvjBLPF8t0Vuy+Kj/BFjNFK1Kdl74Zo1RN/dojdQOKRHKecjW06RQKISFqjcja+
    Y7pLqL0XeaDGZ9su3yqEYr0te8JfUjCoDYfzoxbukWYBG0MFKTfJkIPCV9qWIRpa
    Zj+qOrv+OAR52tSVENKSEMM7LZyyEf0QXG+oiDHivmCuKQ+8Ec4UG3Bdkc2ft2a1
    PM1esMhQJFzT/olc/d5KyBdXfoM5bcceBP8NSVYUG/u1Bp5fHA+L7nAU6yOwlJMM
    9m8iQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	christian.gromm@microchip.com
Subject: [PATCH 4/4] staging: most: Fix missing identifier in function
 definition argument.
Date: Fri, 23 Feb 2018 23:58:35 -0800
Message-Id: <20180224075835.11618-4-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180224075835.11618-1-quytelda@tamalin.org>
References: <20180224075835.11618-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:OqhEMSidsDNupj3x4AamdBINqu2rPmdwjftL9WwboA40aLzutVr
 kelhqleWb4cYh3TEUDxx7eRYqPLoin3ppIdqTP7Gu3W+s9KKKCKJhqaK2DwguVnHrEcN1Ok
 pJ2I+C5zETqL4kP4sDXDDr45oXePvze5zZ3NB5KqnbxANPlXTIz9YPC2X4yDauQ4UgclJxY
 z1myecssKbMFEMkXslzjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dctYFMGikaI=:srfQwL0w+3cF87btNb2q+g
 rh1bhDA/XdoYCfMOMAIvgJypNoc6WqzKMkzlv95lsbX8GgmnVfDPEfXUX5KZaXpPHFY0NUp35
 W40bZOw2NRijSQ9z8fQLOnP9lgZ8LUmq7k7zTD8Kvbh/w5Vu+Dof8XWklC3yR75SMf/dauMq+
 wiS5xuxSUFAgwGuo1pqhmFJC1e1V8cSfeXxXJ+dXRNNZNRs5yJq54XL0pGYJlvjwUYuKaX1yO
 17BA1cu/QsfKEsPBgyzXC08JAyh2bJqQ4R8l+J4LVEQV19DF6LRuvXgWyMWW1ZjKOb7JkS+/o
 RBW5mgiz6avU80u9gw442IvkTYJX3QAaEbgvJlbGZC9Q1RKIFXwdRMNYBjeKcGbMzcf3VPgYE
 hOXdb5xNLofKHe+72vzg4j4A6pzEbmpDJ/QBuAFMPlQD0YQMJ6D6BrQwDfTZFLtoqLJffpcMr
 cduAEdVEYxRof2R75QYxiprqk52xNgMj/kri8J1gQJSeZG2xeimrhwEEis+qYn0zZLzVQdCT0
 XFOTGMyNR6wK3zf+0FSiKdfB8XWdYUbWbuJ0ouu1JniNTbJt3/5vG+TgSxLXPCG+i+WirqUqa
 nMzn0Mb688FKjhVqjLOTRXrKzIGOus0z0+ILBL1DLg31T22nf347/8D7U3ZitWyXX+PfjZIxu
 IgenQUqrgdtxwMSyshBXuscG+CrPXisJ6xWW9cVxuw0uHboMyU/UrP56m/0S1fn+yIhc2Q5UG
 M1KHv7FABOhzXwo4DaqxwFFXPdyQZjKaZEVb0w==
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
Cc: devel@driverdev.osuosl.org, Michael.Fabry@microchip.com,
 Quytelda Kahja <quytelda@tamalin.org>, chris@engineersdelight.de,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The function pointer 'complete' in 'struct mbo' should use an identifier
for its argument.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/most/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/most/core.h b/drivers/staging/most/core.h
index 74a29163b68a..884bd71fafce 100644
--- a/drivers/staging/most/core.h
+++ b/drivers/staging/most/core.h
@@ -184,7 +184,7 @@ struct mbo {
 	u16 buffer_length;
 	u16 processed_length;
 	enum mbo_status_flags status;
-	void (*complete)(struct mbo *);
+	void (*complete)(struct mbo *mbo);
 };
 
 /**
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
