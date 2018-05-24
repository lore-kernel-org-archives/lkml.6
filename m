Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527156511-2-14235925144534217433
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
    1527156510; b=BOKKtqNRaE2OWmsOHex5qHsCi4d8KLDpSgZL5xO2XkOPomUizA
    XrLHo5Nps9lawv3k+u/q+MIK6uuWubRa4e6peZ8v7zOwsR/O5OGnEDkGoULZ9laM
    SDlh0//xhrmx+9kqh5slZ0p+JTTwtnoB7vas3HhrQfavBExQN2cf93DVzABAfHen
    npFpanKnAD8dFY6bNb0LRuYS6+jKhvduZXG223F1fO917LZXIbK+dgJEU4/9ZmtR
    //C18ZL00K6/WYZvVR5mLSrmnMS5Odoe/bdZEC6yPj2dZYfMTaWrOlVL+G2SZjXn
    B1TobDhYR9BMncvDTQN73BEyHiNs+/ZKCArQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156510; bh=Js7B6BaTtD/N1W1o+wMVSR6lIw4lov
    IpZtuSq+X75Bc=; b=AqVWPPIGl/XerSfM0pZjiPa5RwJmaQ+DWI/1vLB+VxHQCc
    ShE5Fw7s6MkZhilYbawXWmEODkzmf1j7zutIBCaqXpv7dRNlw6d3P+/oTLl/9vcD
    tH3nITZ7Ty0FQzgA612A0/H6myFo5sO4Nqk+Ivbwc6HSNCNGzpW/mTtBOcPhprfQ
    JsEi3zf75N16iu8l8yn8g1axbJpP2HW9Z0CDQ/YB06lAEWVy0UoE3yNLXVm0YTBs
    +B2TOguLov1YhLtQhE/1VYYRjKXBc4OdvjFBZOUTH1Jnwm46zXGgeWcKn/MysWJu
    j4UYbREDBWStrwpfOtqHeVDQEhAAB74KODEk3ehQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=RhsCgXwJ x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=RhsCgXwJ x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfDELx6lopBVDJ3AyhW1IwMhRcUkGAZadzsMC1j73gATlsHKPKJKc2eTjLhge8xUFM/bba6cA+esSRhZxvrKNNRzfhQC2x2hLm6yrcCtH8y/6VmpBcVEu
    KqU1TWri5kMXRhoLrV1YRbS9gbbvQ6uhn1RXQEPaWv8VcwHmzfTgqqjV5truiRgTU5ZkfhivxpRZc5O5r1CzKEb2c/gyAs4HgpNvmdGnc2nt4eD07lne2qNN
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=DfNHnWVPAAAA:8 a=P-IC7800AAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=XKFMr7Rr4EnbyFWnoYMA:9 a=QEXdDO2ut3YA:10 a=rjTVMONInIDnV1a_A2c_:22
    a=d3PnA9EDa4IxuAV0gXij:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031672AbeEXKGF (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:06:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031659AbeEXKGC (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:06:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 159/161] rtc: tx4939: avoid unintended sign extension on a 24 bit shift
Date: Thu, 24 May 2018 11:39:44 +0200
Message-Id: <20180524093037.282773399@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 347876ad47b9923ce26e686173bbf46581802ffa ]

The shifting of buf[5] by 24 bits to the left will be promoted to
a 32 bit signed int and then sign-extended to an unsigned long. If
the top bit of buf[5] is set then all then all the upper bits sec
end up as also being set because of the sign-extension. Fix this by
casting buf[5] to an unsigned long before the shift.

Detected by CoverityScan, CID#1465292 ("Unintended sign extension")

Fixes: 0e1492330cd2 ("rtc: add rtc-tx4939 driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-tx4939.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/rtc/rtc-tx4939.c
+++ b/drivers/rtc/rtc-tx4939.c
@@ -86,7 +86,8 @@ static int tx4939_rtc_read_time(struct d
 	for (i = 2; i < 6; i++)
 		buf[i] = __raw_readl(&rtcreg->dat);
 	spin_unlock_irq(&pdata->lock);
-	sec = (buf[5] << 24) | (buf[4] << 16) | (buf[3] << 8) | buf[2];
+	sec = ((unsigned long)buf[5] << 24) | (buf[4] << 16) |
+		(buf[3] << 8) | buf[2];
 	rtc_time_to_tm(sec, tm);
 	return rtc_valid_tm(tm);
 }
@@ -147,7 +148,8 @@ static int tx4939_rtc_read_alarm(struct
 	alrm->enabled = (ctl & TX4939_RTCCTL_ALME) ? 1 : 0;
 	alrm->pending = (ctl & TX4939_RTCCTL_ALMD) ? 1 : 0;
 	spin_unlock_irq(&pdata->lock);
-	sec = (buf[5] << 24) | (buf[4] << 16) | (buf[3] << 8) | buf[2];
+	sec = ((unsigned long)buf[5] << 24) | (buf[4] << 16) |
+		(buf[3] << 8) | buf[2];
 	rtc_time_to_tm(sec, &alrm->time);
 	return rtc_valid_tm(&alrm->time);
 }
