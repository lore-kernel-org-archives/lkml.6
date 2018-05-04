Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3658149-1525410065-2-6308628287241226710
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='name', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525410065; b=TSwmDSvjXvarc0fCrY9Wq2WkCWMRyv+ZbWGsdRHznLNam39gpu
    UtEaSQbxi/AAvaSKMV0+2rF0BamDwinEA3kDaD+NnSFnrlkZiFkEVIU0CsJKNwb2
    lc0OAPJa0btnn4x3ZuFW8WK6SdJsKpROU9XttIt3qC1n3r8Av1c8Gsfgx16cXzES
    A6bD2LvvWmDFbIkhJfyHprt+26EvLCGOGJTLfQwldZhYQBzzV23ocLkA7xK9coFf
    3OeuHu7zha2pYBocEOrCnTT3agBJ2vfgSeJYo/T/Vrn1Rw0OnLEi2xgk869hjn/V
    VZkYDQqLAhTKWhhrxVFLTyxwdNsjrF8xnyEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525410065; bh=rBlIy
    AwjrhaeT+PP3wLK21i2gmIiSyCVCVmZUmn8El4=; b=ashF1eW3v6iUYRylKaS/X
    vkAhq5gvunybs39EX//NIhXnv98aIpEAbB1aDw+h7F9hORuLfu+IBc9Hglz7sM79
    Z/V4dfwc/Tbi2FXPfcRqQusYb6SPgH26QX40o1rIZZSclQp4XT9pYokA/PALFRbt
    l1yLdbnKpLmOosi85dGW/g5qGgAsTVuEwLJiAxaWFrKz0FAG9XlaRUAy3Tntk35/
    rxj87MsxD3rw0YSZ/f3CQPW+V13w3UEGJtAqm/xN5zaaqm5ujp2+8nzcB6wdmZnV
    Z39u4ywBQyo+PL9tyb7hoXhTJbg8tsYFrnLtz9ImcmaCi4YpKLv0sJ99V8lE6RLx
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=brown.name header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=brown.name header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDu4RreNtYWnLAi4PjwpwDXJLT/Q6NNH2gx/avuMcxR+UGiFfb2U+TKJGeVLfZm9A73i24Jon6zyEsM6gcGRZFx/oeZSfLTpz83q7mZAR5444eiUD2Cg
    DYovfT+HxVIiRNxLN83kBdX7pJCUlM/jsvDmCMp9Y46FMj/TbvsB6ecMIdXTF4229gOnllR7LlhV0X+DRU7Jr8Oe3ghlVKPzWpwm6/0BEzKojUGcT8kmQ2Ec
    0+IOKC80a5zntlLe5ag6iw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10
    a=VUJBJC2UJ8kA:10 a=qEKT6kP3PEYA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=ZZnuYtJkoWoA:10 a=DDOyTI_5AAAA:8 a=t8BFDMFo6shNlZR3MjAA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neil@brown.name>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 04 May 2018 14:58:35 +1000
Subject: [PATCH 2/8] staging: mt7621-spi: remove unused lock.
Message-ID: <152540991592.12190.11665748499471801563.stgit@noble>
In-Reply-To: <152540982998.12190.15220622955317261586.stgit@noble>
References: <152540982998.12190.15220622955317261586.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This lock is never initialized, locked once, and never unlocked.
Clearly it is pointless - so remove it.

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/staging/mt7621-spi/spi-mt7621.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
index d9b55d2059b0..37f299080410 100644
--- a/drivers/staging/mt7621-spi/spi-mt7621.c
+++ b/drivers/staging/mt7621-spi/spi-mt7621.c
@@ -65,7 +65,6 @@ struct mt7621_spi {
 	unsigned int		sys_freq;
 	unsigned int		speed;
 	struct clk		*clk;
-	spinlock_t		lock;
 
 	struct mt7621_spi_ops	*ops;
 };
@@ -395,7 +394,6 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	struct spi_master *master;
 	struct mt7621_spi *rs;
-	unsigned long flags;
 	void __iomem *base;
 	struct resource *r;
 	int status = 0;
@@ -447,7 +445,6 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 	rs->sys_freq = clk_get_rate(rs->clk);
 	rs->ops = ops;
 	dev_info(&pdev->dev, "sys_freq: %u\n", rs->sys_freq);
-	spin_lock_irqsave(&rs->lock, flags);
 
 	device_reset(&pdev->dev);
 


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
