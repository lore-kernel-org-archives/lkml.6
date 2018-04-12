Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-382606-1523520014-2-3835140172253388088
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523520013; b=XXTBkV/NjumXhp3WjZvqFq54sVkoFJ4E5TdJ09KPZiKmaWntq/
    7T64gKwto8X4ar4JMS1AwiZ5LR50GlpSM7WO9xRq6AtvCiir64zZu6kTzF51uiFl
    PrFn50FCPyka8cnQvWR62XR0K4jG5AesLPx8rMcV/RGfumrBfVfi/wmCGXM8lE/b
    iLwDTbIfDjnmZXODu9FSGfhQhU1L2NbZMAsVAh/4V8z+cUst0cPOhLmIlcz76i6p
    7NdI1ybP2d/cJM8w2nvkt1+nXxnSA4zMxlLMny6ol+iwMxg0jKQVOp2sCSMiM2QF
    OfXaCeGYnbAJ3iDS1QAJLvc66lKzBzVJh4PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523520013; bh=3T0U8
    skWMKFb62nPBhZcx1abnEPd8RjzFzlful/7A+w=; b=MFzz1OL68vzYt9tX/KNC4
    zaeiL4otYrT1qQv6zMjHVsjS610MGIKekBjvVEiXPdyXUAoWOnhZEcJ5i/DuKy0m
    3CpLaT9UiyOqcDRiYt/BpgZbEW3xCho1TB3iRTw9JxCwz3O0+3y0+xurn/hbgBGr
    QGNeoQIID5b4h/A1q9IZxjCoQaetYs+deWZ2wSKIBBL7YF8sxEPwHa2znzANK9cM
    PA3XUTFydo8Taj4iBCOnudSnx45lhERxCD98y9f3qtigDp1xXyOb5ikzcJ/cM+jq
    rZaOrqhuQxAD8ufz9jCiO6HoSkdLmgpy0raneqxUrTjNfbudvw7cqffu9xAGaJ9d
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=jZoX7zN9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WGW/k44V;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=jZoX7zN9 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WGW/k44V;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPlQA2aqn6i+D0nYu2VLMAjBR0bQgU6JaLMs9RY4Cc4Jc7cXcjelSKAbjZkEVeO1SHBx/OgxUIz3OXm+aKjhKPccEFF6IkXl7euENUEG0CGvlNfLKFHQ
    3BHOkngohvkxk8rNWXLMZoYQrMa6gfF654qh/7hrBdYNHvvqXjEhUUQRhK/0fxnxWAPwfX4znt8xCUV2L77oHKo9lxyfV+n1D3HFCOzZXJdq1YxLbMOZ2FmP
    qLPyjxIUbr4ng4xhMxEkpg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=8JIjIOzEf4AA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=M0ud_3F98hEB2rtAdiIA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4/s7/d8359C+A7WwWD+SCAOxKeWtiweK2eCPjiClwhoGaZGEL07+9e2KnDurYK+JWRiIkqOrg==
From: Eyal Ilsar <edilsar@gmail.com>
To: aditya.shankar@microchip.com, ganesh.krishna@microchip.com,
 gregkh@linuxfoundation.org
Subject: [PATCH v2] staging: wilc1000: Remove unnecessary braces {} around
 single statement block
Date: Thu, 12 Apr 2018 17:59:32 +1000
Message-Id: <1523519972-21017-1-git-send-email-edilsar@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523371795-5090-1-git-send-email-edilsar@gmail.com>
References: <1523371795-5090-1-git-send-email-edilsar@gmail.com>
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
Cc: devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove unnecessary braces {} around an 'if' statement block with a single 
statement. Issue found by checkpatch.

Signed-off-by: Eyal Ilsar <edilsar@gmail.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
Added an empty line before the 'Signed-off-by' line and a space between the
name and e-mail address within that line.

 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
index 205304c..325afe1 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
+++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
@@ -284,9 +284,8 @@ static void remove_network_from_shadow(struct timer_list *unused)
 		}
 	}
 
-	if (last_scanned_cnt != 0) {
+	if (last_scanned_cnt != 0)
 		mod_timer(&hAgingTimer, jiffies + msecs_to_jiffies(AGING_TIME));
-	}
 }
 
 static void clear_duringIP(struct timer_list *unused)
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
