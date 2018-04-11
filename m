Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3118118-1523473211-2-11078861401337781341
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
    1523473210; b=JX9djXxXsg5miwIL5qIYYafw5UVdBKp1s/BEVOJlWON32J75GG
    vOJhW9+hq62d8GTFDXyUhFCbxCJCYTg4cmHRtJM4MxL9uIq6jAVa/XaOstoDa3EH
    h5UN9mUOyhmOY8l7V8qoNbLgsLfSavLAUMZ20vwswaBo5vdz28uRkEYrlnzLqCPY
    W4P/d0jIqEG1aMGZCOFPcoIe5PqTq6CBNn6yW6CAPND2mnVgujQ3y79EFL9cWWaR
    +7xf9VkMXI5FipMCddj+D1O0bwK12j+NjcFu+R2QvPAGdgh/jXOBVM6pYNrsDck5
    QtMInRoZJEuo0BOFYFYv1C6XaL8+Nm62TfXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473210; bh=gSjMIbevDXclMZYH0euX3yrZgBbWTR
    vqrUPvTfxB7VQ=; b=GqIQcc/oG6EeuuIfaIi5yJ80qxqLZLb939CYvZr8I19Ybj
    OmjsXhjq9CyaHrYrQDMi+lidqBi9niDq60n5ILfU3FYpql2lirYYxEt0UQwZBfEh
    Zo53uq4KTSDVidX8C1d98MuTfQXmb1l7ngJDn7M/fL8xsd+caOPutIIP5Q7o7Gbz
    uEoiiSWxHzBXCMjk2P/+x5kYAoc0lpHCeM8GMed9CztXFS4CJRkrUpDhZ6Lt0mPt
    QANe9Bm5W7bnnZBLegUsGoyMvWmvzShJhQiAI6Iowrrcmp1vHgr80xSyoHESgdQ7
    g/4/0kygK8Ojr+Ei5tELv6Ho9OTxhPKXu97HNDug==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfCtUGLvPm5fk9jbKHAQ3h5S9Iw/V9wAwLnMkFJ16WZSNroiWEfD+uGW8zKmGC3Urv1rP1frclYF1opRritWL+nyzy2wYY/zhYjw2bjDPNgYuSY4X+h2S
    BesVczqazSxK8tHXPk4wtpiCgfGF0/lIokdFC3jkAOxsSsnrJOu8Fd9e36edolVzqgzuXiGVLuh4T85bshS1gRBq3wm5WdSPJ5eXaCsD07t/YrXLWJQelzym
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=uP1ucDPQAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=9e8tbnBK3g4TT4MJ-ioA:9 a=QEXdDO2ut3YA:10
    a=9a9ggB8z3XFZH39hjkD6:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756630AbeDKTAH (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:00:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37606 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752973AbeDKTAG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:00:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Best <sbest@redhat.com>,
        Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 163/310] rtc: interface: Validate alarm-time before handling rollover
Date: Wed, 11 Apr 2018 20:35:02 +0200
Message-Id: <20180411183629.399649660@linuxfoundation.org>
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
@@ -227,6 +227,13 @@ int __rtc_read_alarm(struct rtc_device *
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
 	t_now = rtc_tm_to_time64(&now);
 	t_alm = rtc_tm_to_time64(&alarm->time);
@@ -278,9 +285,9 @@ int __rtc_read_alarm(struct rtc_device *
 		dev_warn(&rtc->dev, "alarm rollover not handled\n");
 	}
 
-done:
 	err = rtc_valid_tm(&alarm->time);
 
+done:
 	if (err) {
 		dev_warn(&rtc->dev, "invalid alarm value: %d-%d-%d %d:%d:%d\n",
 			alarm->time.tm_year + 1900, alarm->time.tm_mon + 1,
