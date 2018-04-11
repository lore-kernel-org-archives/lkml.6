Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3397032-1523481479-2-16067826846680989538
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
    1523481479; b=JN/eCOGvQ7Oz+N8ycUrEZodHDJHpH9VOYXWodAohx+tIikrg65
    YjIQldTFC0DbyGf6xSR6fRQ5wI5HChHvCf/5ms8+OGa5IqIH4mO1mizQrdrUxm/w
    zuMs8uJHqpaAVCw7e+OpKMycjWjSm946hQ5z2wXwspNAbaDxIvFTo8/fxW7TmsdG
    fYZK4hLGYAAAsYI20tRAiejMxSBP8h8gA7ouvou/aUioku5ZrA9dk35/wrmIFVra
    y7aeegOfYzvbRQB7HUtBkCS5qMECN6pHcKQAIe4Fger74BsuX1BLAZqFwJV2yLyf
    nh6lPKRVcHGhcIEDHpAw8DHjoWsSVPA8IZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481479; bh=Bd1X1BpQJRprx31YB8LPX6phaXNdn+
    PqVw+IN3rmnxo=; b=HU0A1bu3eugNKsD3I/LAwmFj2MnHt8WTZVWksJppk8y00T
    pkGnsPHRH4vi2NrQK2GWb4eEw/HJqXPUi7RxZ22Fsl/9TasSvORt3dkvvLG81RMV
    9fATrnTmt8h85k+0+a/siNVxEq1VJj4lgsUfWHD0NZZ24frMUY8dx+5xeXsdhlIZ
    U1tAXkRrZ8q7HlS3/T4nzXhwIq/KUcy45eIYLXw4ytFZgkrzg8LtM0mANS79vhSP
    oqSpKLaDf4CH7v666XJFd9Yb+RBjAdmJA29sMp41ueEg6jgVBjz/gFOr0abD6Kqu
    cscGx7g+w1aCwh/7grsBZQVALVjftxuXNBycwTfw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfAtNJejkZ2yx+hlh4TRbv9mgJyd5BuKIROO7w3h++RB/tiFw/NAQlZNsa8uNbjOepbRs9UXPKgSLs4gqCHA/q/h+YDFDKrKa/PeAG8xWOuWNVzZbFict
    hxWey7yGRJJp1090C4+jVOFLGhNMhDxuMgK+YvliHf/YLpYw+ANrc6+Qxtyy4e6xP32dYQaLs0jiWge2RCmGbR71Q4fZ4UddAGl5hsWfP2kaKOOp6f0chIjz
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=uP1ucDPQAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=9e8tbnBK3g4TT4MJ-ioA:9 a=QEXdDO2ut3YA:10
    a=9a9ggB8z3XFZH39hjkD6:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754571AbeDKSkO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:40:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56350 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753241AbeDKSkM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:40:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Best <sbest@redhat.com>,
        Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 057/121] rtc: interface: Validate alarm-time before handling rollover
Date: Wed, 11 Apr 2018 20:36:00 +0200
Message-Id: <20180411183459.752762871@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>


[ Upstream commit da96aea0ed177105cb13ee83b328f6c61e061d3f ]

In function __rtc_read_alarm() its possible for an alarm time-stamp to
be invalid even after replacing missing components with current
time-stamp. The condition 'alarm->time.tm_year < 70' will trigger this
case and will cause the call to 'rtc_tm_to_time64(&alarm->time)'
return a negative value for variable t_alm.

While handling alarm rollover this negative t_alm (assumed to seconds
offset from '1970-01-01 00:00:00') is converted back to rtc_time via
rtc_time64_to_tm() which results in this error log with seemingly
garbage values:

"rtc rtc0: invalid alarm value: -2-1--1041528741
2005511117:71582844:32"

This error was generated when the rtc driver (rtc-opal in this case)
returned an alarm time-stamp of '00-00-00 00:00:00' to indicate that
the alarm is disabled. Though I have submitted a separate fix for the
rtc-opal driver, this issue may potentially impact other
existing/future rtc drivers.

To fix this issue the patch validates the alarm time-stamp just after
filling up the missing datetime components and if rtc_valid_tm() still
reports it to be invalid then bails out of the function without
handling the rollover.

Reported-by: Steve Best <sbest@redhat.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/interface.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -249,6 +249,13 @@ int __rtc_read_alarm(struct rtc_device *
 			missing = year;
 	}
 
+	/* Can't proceed if alarm is still invalid after replacing
+	 * missing fields.
+	 */
+	err = rtc_valid_tm(&alarm->time);
+	if (err)
+		goto done;
+
 	/* with luck, no rollover is needed */
 	rtc_tm_to_time(&now, &t_now);
 	rtc_tm_to_time(&alarm->time, &t_alm);
@@ -300,9 +307,9 @@ int __rtc_read_alarm(struct rtc_device *
 		dev_warn(&rtc->dev, "alarm rollover not handled\n");
 	}
 
-done:
 	err = rtc_valid_tm(&alarm->time);
 
+done:
 	if (err) {
 		dev_warn(&rtc->dev, "invalid alarm value: %d-%d-%d %d:%d:%d\n",
 			alarm->time.tm_year + 1900, alarm->time.tm_mon + 1,
