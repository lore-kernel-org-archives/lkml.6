Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3253174-1523477498-2-8890412417302965188
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523477497; b=Zh5OLNCCYTTICGGrm2/RqOZSuFyhXl1nbnLcgbOoMP3QLc5PSS
    mYXfp1/waSjFlnTuYe5460+IKyeIsoxisyA2Iv4RETxTmHAX6hGhhGz3p835nYei
    YA1bHXhtRd0aARjHjW7n4zX3NdIjFWyUNPs9GJ3RsJLhvPoRqKvPq+5IP2TXhEz5
    1NjSufsYyd9VofJhQhDmAC/rMh20XZL5BqBsLK+83oC83gqmm0JLH+vYb2iTvDAE
    jrxpPLJHjoHcC3uBBAF+tQt4h/7FcMieE0kOSPz/PXXBY8B2ORujfYoNe7Ij+fc9
    RE6qMuukJbnoB9vAPxVAmTPTaxKJaNDcCCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477497; bh=GkaZCYiRd2aFzuif4Pl0TfNa9+G/4e
    SQC0w98tNtmhg=; b=vD/QP8rW9gA2CSxm4rGybFW3I6Hafkrp74EjcenEYJl5rP
    OrMOwvXMPZgEFlZhZ3JOO249fVjYQ1lGjXZl2wSOgyGXDq+cLWZ/jdgVZykx5oCt
    whctjDRL4zbaTsMvJplaepBC9ve8bcIWNFf41pYXrmfp9E3vabSOS5W5brr5qkKH
    BGKHc1s7Zm+jio6ui/+KoCP22T8DEK8bI9g1LzCWiVTpr/AM1/eGOx2+c6nmrXcm
    5SeA5pAZrv6trJhmeUBpQECkLaDhZiqMSsfyu1IVcncRv4dInTFb24DSTJa+wRVK
    djr6dmkeandm8TPNLYVgbftqmn5yzANVRQjt8UYA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJVcDHgGau52v6B0IbfWir9gz/+PABzGVMuqnAOlZkINlZVrrI9n6xq3u3uKlCZzJmpD0Zl4GXKPq+rrxp1UhoroL59XAWFeQWUtR2iTITXoNPF9bpEJ
    w7mT0JpuHEbNP0F3xwcemMdGmUKupShy6hN7UDrKBMOj+T775b8cOwPcd/JyRDGoYhBFRqe/xy4CucrBTRxwG8cnAFtdT+REsbYlvn/5yQpSV4Lt2QUMi+te
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=nYFOPK3GkPJHXbxUH98A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933461AbeDKSyW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:54:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34444 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933458AbeDKSyU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:54:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Mc Guire <der.herr@hofr.at>,
        Jonathan Cameron <jic23@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 043/310] iio: pressure: zpa2326: report interrupted case as failure
Date: Wed, 11 Apr 2018 20:33:02 +0200
Message-Id: <20180411183624.119278368@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Mc Guire <der.herr@hofr.at>


[ Upstream commit e7215fe4d51e69c9d2608ad0c409d48e844d0adc ]

If the timeout-case prints a warning message then probably the interrupted
case should also. Further, wait_for_completion_interruptible_timeout()
returns long not int.

Fixes: commit 03b262f2bbf4 ("iio:pressure: initial zpa2326 barometer support")
Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/pressure/zpa2326.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -871,12 +871,13 @@ static int zpa2326_wait_oneshot_completi
 {
 	int          ret;
 	unsigned int val;
+	long     timeout;
 
 	zpa2326_dbg(indio_dev, "waiting for one shot completion interrupt");
 
-	ret = wait_for_completion_interruptible_timeout(
+	timeout = wait_for_completion_interruptible_timeout(
 		&private->data_ready, ZPA2326_CONVERSION_JIFFIES);
-	if (ret > 0)
+	if (timeout > 0)
 		/*
 		 * Interrupt handler completed before timeout: return operation
 		 * status.
@@ -886,13 +887,16 @@ static int zpa2326_wait_oneshot_completi
 	/* Clear all interrupts just to be sure. */
 	regmap_read(private->regmap, ZPA2326_INT_SOURCE_REG, &val);
 
-	if (!ret)
+	if (!timeout) {
 		/* Timed out. */
+		zpa2326_warn(indio_dev, "no one shot interrupt occurred (%ld)",
+			     timeout);
 		ret = -ETIME;
-
-	if (ret != -ERESTARTSYS)
-		zpa2326_warn(indio_dev, "no one shot interrupt occurred (%d)",
-			     ret);
+	} else if (timeout < 0) {
+		zpa2326_warn(indio_dev,
+			     "wait for one shot interrupt cancelled");
+		ret = -ERESTARTSYS;
+	}
 
 	return ret;
 }
