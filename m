Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797295-1527158603-5-9951572255685421789
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
    1527158602; b=R7EcaP/gj9FrvPLObWZNrjL+H7UsUdhTpeFo9OnHtWzNHvRhgf
    jOzLFHN3Z6StOZI40S8tH+jIzemWC10qFewoV81zXOD2lIfAsfR/mHYPRKZz2KRL
    r1ZLY4mst0UwuzxAFobFK8ltORWrVqVqgO2XGCL5iVdjaNyvU94FKlEEb/94T6lV
    pFYUHYRfAAf12uVuFbJfb9W2Qm2M3PB4HSOfsKXkuQjsefXdHUEzyWNdugwT6kXW
    yNAWhvfvaRRKYmO8kLnUpsdt0497O3MUIH8SgNMN6wf9S5G54+E+7XwCvw1oafDF
    AtXq/4YAl3SkYsilsMyDQYtA7Sz5XUNqHGpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527158602; bh=68Uo/tV3JVn6AWrQShUV2o5MIfYv5K
    TEowk7aeNPzOc=; b=WtTc+zaYnk+rTgtHw6+TkUWKtUyU7MuPoNPzRcsLle2YfV
    LZZcN3695mxNt+z299N2FtuPecqFsD3yAqbgWF4hh3+l2Y4ueOQdSUU0+nrb1EOM
    RTNkag4jtQ98X5YdO8n3FjYFiB1ZmtRdmbWsZmVckeDWPwMZcT6s121ibJoxAe89
    ufJwRVO4eSQAm/RP6IQT/EvTvwH3sVjliBtIa3ZPAohcM4cOwOPG64UA9UaCqKDw
    cUs6zFPK1cEaESavoZtrLpw8fMP5Zwq00EGQgRqPr1xCUmsXOnGmhiyUC/jv2SIy
    3PdTU5oDNTE4WTwbcu/hNgUYaswDnlqYWqP/Xa1g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=145ze/hG x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=145ze/hG x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfKpJWHsU7HJRcCieDFF/YWgul6KIv/P38Og9dGFFdpt3UglkThi/p6s0k3KMkjKCtIv+TELdMgBSYhgkifxI4hUSA1k1wkz3XahLZXpdPy+1LfHuBLsK
    2vTldWJn1oGxvsHSjvNpPpp4x8yBGiuQJ8GfGUDKkEtEi8PrjwS1rNr9PxNzC64A3u7/sEO0Gh4/UUHjRDlbgSO034izNQ0MI6oamA+J5EIdkXJ83nTwplR6
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=P-IC7800AAAA:8 a=NEAV23lmAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=iP_NRmkEyFTJfnVRG-QA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030521AbeEXKnG (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:43:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030238AbeEXJ6Y (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:58:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 160/165] rtc: hctosys: Ensure system time doesnt overflow time_t
Date: Thu, 24 May 2018 11:39:26 +0200
Message-Id: <20180524093628.562607570@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit b3a5ac42ab18b7d1a8f2f072ca0ee76a3b754a43 ]

On 32bit platforms, time_t is still a signed 32bit long. If it is
overflowed, userspace and the kernel cant agree on the current system time.
This causes multiple issues, in particular with systemd:
https://github.com/systemd/systemd/issues/1143

A good workaround is to simply avoid using hctosys which is something I
greatly encourage as the time is better set by userspace.

However, many distribution enable it and use systemd which is rendering the
system unusable in case the RTC holds a date after 2038 (and more so after
2106). Many drivers have workaround for this case and they should be
eliminated so there is only one place left to fix when userspace is able to
cope with dates after the 31bit overflow.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/hctosys.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/rtc/hctosys.c
+++ b/drivers/rtc/hctosys.c
@@ -49,6 +49,11 @@ static int __init rtc_hctosys(void)
 
 	tv64.tv_sec = rtc_tm_to_time64(&tm);
 
+#if BITS_PER_LONG == 32
+	if (tv64.tv_sec > INT_MAX)
+		goto err_read;
+#endif
+
 	err = do_settimeofday64(&tv64);
 
 	dev_info(rtc->dev.parent,
