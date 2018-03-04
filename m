Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2908601-1520178565-2-6858844526747585769
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520178565; b=BmF9XL+wjrhBQrGR1M26J0McCbd4ii0nMleCs/HoXCFv86Z
    7b5BSFCvDTUXWdboAeJbueMZIFYgWddLAezv+n0cHIhfIlIKPzsCsCXVP5jjqOoO
    4qRpVQ8x8R9SneadIdRI5YUg+VbMYkQk1g4ZifBhujirXn7GlHpYezYQoB6JsYb1
    3usDny94sYqiXL9QEgzr6eZVeDUNT295FbTuWr+v/KP1VAIumxaHTXq/XDdZZ98F
    DaXbW9hsAjSdJGa2CvIEsDPbf5fuKkvX1QT07Yv8Vb9skKO1H7ohG27vlzoXASCC
    KzyVw8iNmHGfYIl6CCPMBynMVGzju0sCO1r5vmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520178565; bh=A
    EOVNTScrZMFtnvjMFyDLhHhtg341zXhgCpRwdIbZ5Q=; b=POz2UMESxV4D8iWcz
    h2JPdR+hVjuT/DHU5oCsOHzKdfRXfbuCQUKjW16e6R7B83991qJ1foCgniUFjtsc
    hmhxyXSaB2or13JccaWlvjBAGwaGQcYlNnW9/27TnekDfIBUXKJg6zrnP/KYMghn
    TGelrSBs8VzGsDftwAlR5md9y9KsbSW1W22VB5K4bawEdyZaFCeXd3STHVqyCLzc
    pfsANnUGKuKKPAsfmdCUOsC9op8foEXJY/nhg0LPkdxlvG5JG+KDUx0YYrsSZKzg
    pj1xLkn0zfbm25tj6fIDL4n1adhlM4rBCZ+XXgIWD/vka4xaSI/WH5rl2Yg9HVNo
    Gcxxg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Oz3I3j9L x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bGgG2WqH;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Oz3I3j9L x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bGgG2WqH;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsPcjs+S7Wnfd013YvczFfUKt/4kr8kHoujUx28g+8YTXCFY6KMt5oVxargSnpw2XENvX2n1w==
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: alan@linux.intel.com
Subject: [PATCH 1/3] staging: media: Replace "be be" with "be"
Date: Sun,  4 Mar 2018 21:18:25 +0530
Message-Id: <1520178507-25141-2-git-send-email-arushisinghal19971997@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520178507-25141-1-git-send-email-arushisinghal19971997@gmail.com>
References: <1520178507-25141-1-git-send-email-arushisinghal19971997@gmail.com>
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
Cc: devel@driverdev.osuosl.org,
 Arushi Singhal <arushisinghal19971997@gmail.com>, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
 sakari.ailus@linux.intel.com, mchehab@kernel.org, linux-media@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch replace "be be" with "be".

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/staging/media/atomisp/pci/atomisp2/css2400/ia_css_pipe_public.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp2/css2400/ia_css_pipe_public.h b/drivers/staging/media/atomisp/pci/atomisp2/css2400/ia_css_pipe_public.h
index df0aad9..4057a5a 100644
--- a/drivers/staging/media/atomisp/pci/atomisp2/css2400/ia_css_pipe_public.h
+++ b/drivers/staging/media/atomisp/pci/atomisp2/css2400/ia_css_pipe_public.h
@@ -402,7 +402,7 @@ ia_css_pipe_set_isp_config(struct ia_css_pipe *pipe,
  exception holds for IA_CSS_EVENT_TYPE_PORT_EOF, for this event an IRQ is always
  raised.
  Note that events are still queued and the Host can poll for them. The
- or_mask and and_mask may be be active at the same time\n
+ or_mask and and_mask may be active at the same time\n
  \n
  Default values, for all pipe id's, after ia_css_init:\n
  or_mask = IA_CSS_EVENT_TYPE_ALL\n
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
