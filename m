Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-568472-1520224128-2-9597413320004036888
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520224127; b=ccR2Z5CKuZhQS1dygmdU8aHapjURdIpD4zvJTNGKNcl8Vrj
    bTQbsANw0a4wtv+RxByf6KN2WjG4P0PzyLQkZdb073CoDO5ElqjjNjWD/wh6sLjj
    kVBH7NWiQ3clBD2LI0YHeqqw3w48nRVCu6x1jnMJOXKBIcxfFo3VBBNYHhnZKC39
    NWjjMiiZc4hUppm/R47KOxEf+2apfn1PWpqTKEeNFTWQPzWe6LgTqipvF2ZEOt0F
    B8rkNbMiqetjzGBQpqy+3SU+5BI9S/nD6m3N1I14DOTfs3kvn4ub+w7q+caUs9Jc
    vnsE27SyT3u2EpvSAA3ekAser9evybaq3suRNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520224127; bh=E
    oCA+JEAeAw9yG+uU5XXrjUx0kCHHYSDpZnQ0CaJUIw=; b=kE9EGwdc+6FTrEf9c
    MJglvakRIKUSszmScNy3vu5sMMJLoKDotQn2uHJhHHj1LuG04ej/dmc7b2K7jgKD
    zZZCBaLOcCOn90mHQQE4A9CdfNfLz2/vg76nrfbKM8YUa8gnFlb8LzuDyZGRPLtT
    8P+vs9G+EtwlMSVaDuSx4xnLh9i05dcFscL6tq9yKaXNvoafkwRG7yjrrS+HI2cc
    gsKRJuI8ZK87VQYMdaA376hKo1dqe7VRz9cNy/ndOrXGAki5RTSeAOve30JEW3YL
    FcMLQfwSPGBEYY25Msvsm2Dt1EvqOl79TuYe8Mc2VtWV3nbATFlqmI7vSSnW5E8e
    mcBhA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=dhqx0Ixj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WLHJK1zi;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=dhqx0Ixj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WLHJK1zi;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELshJFyU7SB7EWRkMJmrMMzRK+Z5Kl9ZEO7562mjR78KPpzNWpqu4XQU5w/2BFK7a802tecIZQ==
Date: Mon, 5 Mar 2018 09:58:08 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: abbotti@mev.co.uk
Subject: [PATCH v2] staging: comedi:  Replace "dont" with "don't
Message-ID: <20180305042808.GA24032@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Replace "dont" with "don't".
"Dont" is not same as "Do not" or "Don't".

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
changes in v2
*Commit log is rewrite in the imperative.

 drivers/staging/comedi/drivers/cb_pcidas64.c | 2 +-
 drivers/staging/comedi/drivers/das16.c       | 2 +-
 drivers/staging/comedi/drivers/das16m1.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/comedi/drivers/cb_pcidas64.c b/drivers/staging/comedi/drivers/cb_pcidas64.c
index c007500..ceef905 100644
--- a/drivers/staging/comedi/drivers/cb_pcidas64.c
+++ b/drivers/staging/comedi/drivers/cb_pcidas64.c
@@ -1700,7 +1700,7 @@ static void i2c_write(struct comedi_device *dev, unsigned int address,
 	 * eeprom and i2c bus
 	 */
 
-	/* make sure we dont send anything to eeprom */
+	/* make sure we don't send anything to eeprom */
 	devpriv->plx_control_bits &= ~PLX_CNTRL_EECS;
 
 	i2c_stop(dev);
diff --git a/drivers/staging/comedi/drivers/das16.c b/drivers/staging/comedi/drivers/das16.c
index 74ff204..81eb51b 100644
--- a/drivers/staging/comedi/drivers/das16.c
+++ b/drivers/staging/comedi/drivers/das16.c
@@ -619,7 +619,7 @@ static int das16_cmd_test(struct comedi_device *dev, struct comedi_subdevice *s,
 
 	/* Step 2b : and mutually compatible */
 
-	/*  make sure scan_begin_src and convert_src dont conflict */
+	/*  make sure scan_begin_src and convert_src don't conflict */
 	if (cmd->scan_begin_src == TRIG_FOLLOW && cmd->convert_src == TRIG_NOW)
 		err |= -EINVAL;
 	if (cmd->scan_begin_src != TRIG_FOLLOW && cmd->convert_src != TRIG_NOW)
diff --git a/drivers/staging/comedi/drivers/das16m1.c b/drivers/staging/comedi/drivers/das16m1.c
index 72f8ed2..4e36377 100644
--- a/drivers/staging/comedi/drivers/das16m1.c
+++ b/drivers/staging/comedi/drivers/das16m1.c
@@ -407,7 +407,7 @@ static void das16m1_handler(struct comedi_device *dev, unsigned int status)
 		if (num_samples > cmd->stop_arg * cmd->chanlist_len)
 			num_samples = cmd->stop_arg * cmd->chanlist_len;
 	}
-	/*  make sure we dont try to get too many points if fifo has overrun */
+	/*  make sure we don't try to get too many points if fifo has overrun */
 	if (num_samples > DAS16M1_AI_FIFO_SZ)
 		num_samples = DAS16M1_AI_FIFO_SZ;
 	insw(dev->iobase, devpriv->ai_buffer, num_samples);
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
