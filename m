Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1368942-1526331460-2-2877695070064600290
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526331459; b=gmxcxci7IIK1F8BoXaA9XfPIm2kjpNzO2lGyxd9Gb+1eRD8Esf
    cEOYDAEYRWemNKrbqnxII70l9aXEUlhdA5em5zvEbBTOv05SV5j6m4V4aXxXkfwE
    LjzUsWb3h7w0b5s1fqg75WE0Ya7UhHGR7v4KoQqwKM/SctaCSEpGAOaHIpxUSrT9
    tIDyGmaiwPTo5xVn6Ep5ckGIM668wHiyM1uoK7aa7tB1RRhbxxlbXZA3IS9BR/pX
    TlspN8XvF1Zx16cAqOCwBoz3pj1Arn9vIuWokL6g+RgnpCYe2HQeTRbTYt/Ukn3w
    rVWOJQktP1ucCHV6yw7lcu65aTZj79QOHoGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526331459; bh=NlUqP
    8gj6ArVovuOvh/0Wm1keWbOl/oVd4y2fw8DJ6E=; b=g1KVVdiNG0dqTC8AOa/su
    TVeLM6vxkC1bTss453j0CqaGR2OTpooYE3GPl3WMezR8Bbf4fQcxnHRklT2bT+2a
    pj7EV14acFx9J/Anu6pRmO/zRYwryy5lPDVxBMMxdOV8kDHGmOpJKnEcQU1DhVBY
    WynqvaBg5/dXRc0dqCb6wOsj9Bq4JOVYfwtJibVFJPEdo9+31IDvB+bMXELJ4r1H
    klGfLJ/rbkhCNzTKQ9xcTLnC/h8VGTeFd/apXOdJ+JSOWzuDSX2ZYN/GLk22tVvo
    Rh73357zhPJL69tZKv0CPUIZIQpUJhUaC1qtaiGlKwMEAMG1hmIe6YEgEOL9R0JS
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ens-lyon.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=ens-lyon.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ens-lyon.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=ens-lyon.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAq7y/yFP/SwnS+jdtiEoKkXRimpEc42soqZL4p2sQuTMcV87WUPxnoUihjNoL6D/p17NvoEpW7cjxKggjplYSteaXts/5nlFrOFY7LKyProptS+Bmsg
    0NdCbYAxXptbiXWsmf+RZl74FjyiG4aupYdL+0GJh9rGW7kFCnvBDBWpjeTTRo9oMtj/KYl0jSVh3yrH5EISRJ4/GiiJYTLpveZvbZzlGwnwWqlCHPnjaPcf
    ZR8z1kiCSzsttYFyJ86T/w==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=m8YGQp87AAAA:8 a=DDOyTI_5AAAA:8
    a=ko7bABkJPcNcaCC6ki0A:9 a=CjuIK1q_8ugA:10 a=sQmdjVoOy41DRvcrsFdt:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 14 May 2018 22:57:25 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH] staging: speakup: use true/false instead of 1/0
Message-ID: <20180514205725.hamsvxkhic2gvnfn@var.youpi.perso.aquilenet.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Greg KH <gregkh@linuxfoundation.org>, w.d.hubbs@gmail.com,
 chris@the-brannons.com, kirk@reisers.ca, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, speakup@linux-speakup.org
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
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
Cc: devel@driverdev.osuosl.org, kirk@reisers.ca, speakup@linux-speakup.org,
 linux-kernel@vger.kernel.org, chris@the-brannons.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 drivers/staging/speakup/buffers.c |    2 +-
 drivers/staging/speakup/main.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/staging/speakup/buffers.c
+++ b/drivers/staging/speakup/buffers.c
@@ -80,7 +80,7 @@ void synth_buffer_add(u16 ch)
 	/* We have written something to the speech synthesis, so we are not
 	 * paused any more.
 	 */
-	spk_paused = 0;
+	spk_paused = false;
 }
 
 u16 synth_buffer_getc(void)
--- a/drivers/staging/speakup/main.c
+++ b/drivers/staging/speakup/main.c
@@ -1784,7 +1784,7 @@ static void speakup_con_update(struct vc
 	speakup_date(vc);
 	if (vc->vc_mode == KD_GRAPHICS && !spk_paused && spk_str_pause[0]) {
 		synth_printf("%s", spk_str_pause);
-		spk_paused = 1;
+		spk_paused = true;
 	}
 	spin_unlock_irqrestore(&speakup_info.spinlock, flags);
 }
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
