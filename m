Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-814531-1523400619-2-18006465526958749251
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enropt,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523400619; b=pFbpa/k1p77HOeq4XBSzE6VBi7brvhRMK/jlBg17pN3IZ5K1n1
    44yVsccCXfGmElKG2spii66e2OnhggGiTatl9lPxgGi4i7x159kk/mTMVdJl3tz9
    y8w3FbnjDlnZK+IZU2iMbiD7AJs46kU7V3ulAYW2+KNGmXx+tX2W/F4AjYNSody4
    1021Es5RhfNwmr2tWlSxpdPoD3p0QAHinTqIeeh3XqjLkzo8vpwHIMbguUJDsS9K
    zSHc2l+rH9K0HvOOIx9EWeLFSv9KmJ468LVnnGTbiabPV/nD1ho1wr+wLT327oXw
    MFj7WM0vyeTFxN+nMbwglQXpse2ckrTZuvVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523400619; bh=KFIaa
    RrSgt0L/krCjXxmdfMTMqhGB/KxhZws2mecYCU=; b=Wy9ELKtMFmZrQEZK0fqR9
    s/g8uBUHoTjn9GvG8IhERFlIS7ZeMuqgjEQOnEc25o+/Ek7raqvxs9AVptY0C9wd
    fTKMY8Mh6gP51WrYpveTRaUE2ElRYHd+jqucS9zJC6SDsneMrv0W+Bt833a88nXC
    xtd1NspgcizptDlfO1FffmACqss576a2uNchUFK5OmSgj6ceI5LRbodKMfxJoGtE
    924dWNgMcc7f235XQzbYH6hARhLY0i+f6CKzzX6nXCjw8gs/VHCGkzHcZfNQSlAK
    2IsUsjYvsnRjV51UH25iEV5oiAdcJ6yclWNq2j5l0AbO2vitLfA5CWmFLwZOkBPp
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=bgx++rbQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=H4vZwbjZ;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=bgx++rbQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=H4vZwbjZ;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJHZ2qpNgwZPY6ydEiOT/YxQDYXZTQ90ITAArLds0tC7a50aDeOmGCyh85Nzo+JsqWu8zernnwu5UbntK00ZDHbs7q0k2r7hNI6XiSqjH9isY1aFd6wL
    qfUMd+XoW+va3GcCRTV/eTb4op5vUUSsCqhSubTw89py57qTGWYP89yPf5B6AlwFadyokbAItcpD9BWtQUhnQsSbKAnaKRxFIvsmvYBbLC+qxERYcgJng7gJ
    tEw+zGQbSUruwEsvWtrI3g==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=BkPDqxY9XNgA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=2pe1fyuj_EwDJMY5u5IA:9
    a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx485yggr5FXzBhNv7TTrDg7MHH4V/2KXLAioTP1W/PUVhZxgVF5zXy+vHUCi3DfYOsPucPXjBg==
Date: Tue, 10 Apr 2018 19:50:07 -0300
From: Gabriel Francisco Mandaji <gfmandaji@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH] staging: comedi: cb_pcidas64: fix alignment of function
 parameters
Message-ID: <20180410225007.GA5050@gfm-note>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
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
Cc: devel@driverdev.osuosl.org, julia.lawall@lip6.fr,
 linux-kernel@vger.kernel.org, abbotti@mev.co.uk,
 lkcamp@lists.libreplanetbr.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix most checkpatch.pl issues of type:

CHECK: Alignment should match open parenthesis

Signed-off-by: Gabriel Francisco Mandaji <gfmandaji@gmail.com>
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/staging/comedi/drivers/cb_pcidas64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/comedi/drivers/cb_pcidas64.c b/drivers/staging/comedi/drivers/cb_pcidas64.c
index fdd81c3..631a703 100644
--- a/drivers/staging/comedi/drivers/cb_pcidas64.c
+++ b/drivers/staging/comedi/drivers/cb_pcidas64.c
@@ -2268,14 +2268,14 @@ static inline unsigned int dma_transfer_size(struct comedi_device *dev)
 }
 
 static u32 ai_convert_counter_6xxx(const struct comedi_device *dev,
-					const struct comedi_cmd *cmd)
+				   const struct comedi_cmd *cmd)
 {
 	/* supposed to load counter with desired divisor minus 3 */
 	return cmd->convert_arg / TIMER_BASE - 3;
 }
 
 static u32 ai_scan_counter_6xxx(struct comedi_device *dev,
-				     struct comedi_cmd *cmd)
+				struct comedi_cmd *cmd)
 {
 	u32 count;
 
@@ -2296,7 +2296,7 @@ static u32 ai_scan_counter_6xxx(struct comedi_device *dev,
 }
 
 static u32 ai_convert_counter_4020(struct comedi_device *dev,
-					struct comedi_cmd *cmd)
+				   struct comedi_cmd *cmd)
 {
 	struct pcidas64_private *devpriv = dev->private;
 	unsigned int divisor;
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
