Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527163166-2-6694514580174237755
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163166; b=Z78nPA2wXMgJJttkTGvS+EMpXx1WbJyUS0549D1nGJKGFEy0Bn
    TuQrc8P/T+WO/dCpZ7TDZGR3CroRqixIXTrhJBBKaWIAEOSQhrRuBf6vEgflgZAK
    EhhvPiUlqlm89/hSExb8BkH+mJgzCLrrGNfHjMK2NR8+1h9ERhmh1he6vlfrzvqD
    JB15KR1xclx2agAFcE3h62lS6jNlbeNkMt17iu5vR53B14Jtc0m+vKFQWWaQFNBx
    71Flhlt5BfxNm31j2+OrfFipFon7NhHo3ckXQ8Cb1opipu+KZi8r98haJ8WvP2P3
    Y1x3W70X/7Z7YHuCo8OaMAVUitSKhmFAB9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163166; bh=uBbtckGVBDkV+yKpcbPuuRxAD+3hpJ
    Am+GlP/eCckxk=; b=YknkyuMgwRRycDQl5je9no39vWBFAJAPZ91VGNUhQXk7x9
    mgQPbmkmwhuVHcEZRVAJbkKWdOBPgM637oJa+BG+VL2Vk4jrUhJh4DEpFTZHCju6
    6WqjIxDPiBbyI5crlhonshCOvntoHiqEXRN7Q5LN9oSgH9uGOzhgGq8MQEdVIXHb
    9hiw86mKviJMSL/EualWu8PZBs+lprFd3v27wt/GU707sf9tCLvtvagvLuxs5yTw
    4SDbU5sx/jSQPfTgM22VkQ8IAy+hgZREnM7M57r4a5iLDeD9JdxfSnIS5tX1d485
    V36u5dstUvy99SujRfNgIBSSxF/l7pa8Dmn+Vdqw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=NkG2/em4 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=NkG2/em4 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNlQ1c+s10D37rSN2z3EUk3bsXSUK3QzU79Ytk6EfgNXvwKU24VGe5zehYFRZMwOBaPtjdJf40PvQmErvXlbxwodItNiC8BoW9fF9F6fihxrxOpgbcG+
    KqmbxNFTiYd5RCet1UHrPfhGhrn2l5iBxmG3Z50LvhFAFHnChOiNN7B+ksmgqj7L7HYhIVGG5y3VWMX1uniy/3xVeUmj+pk6AC6ewu189njx3FVPCRixERcF
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=lwQ16D-4d2GxOm33qPoA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966759AbeEXJpR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:45:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966749AbeEXJpK (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:45:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.4 59/92] s390/cpum_sf: ensure sample frequency of perf event attributes is non-zero
Date: Thu, 24 May 2018 11:38:36 +0200
Message-Id: <20180524093204.984626877@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hendrik Brueckner <brueckner@linux.ibm.com>

commit 4bbaf2584b86b0772413edeac22ff448f36351b1 upstream.

Correct a trinity finding for the perf_event_open() system call with
a perf event attribute structure that uses a frequency but has the
sampling frequency set to zero.  This causes a FP divide exception during
the sample rate initialization for the hardware sampling facility.

Fixes: 8c069ff4bd606 ("s390/perf: add support for the CPU-Measurement Sampling Facility")
Cc: stable@vger.kernel.org # 3.14+
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/perf_cpum_sf.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -744,6 +744,10 @@ static int __hw_perf_event_init(struct p
 	 */
 	rate = 0;
 	if (attr->freq) {
+		if (!attr->sample_freq) {
+			err = -EINVAL;
+			goto out;
+		}
 		rate = freq_to_sample_rate(&si, attr->sample_freq);
 		rate = hw_limit_rate(&si, rate);
 		attr->freq = 0;
