Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-609334-1523265207-2-15732697072478451424
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523265207; b=NJIrfsBUf7InkCvxpKHPkACttWk1L8FUVlVu2KZIpfeulK4Aeu
    BMcv9eVjKwTN5KvxCCT4hB72EAjFNBKBAyuC4Lk0jLuJ0tnYod1aHqyvRQu2e2KT
    /ipV5jmWZYXlhrn0ejLabsbvPzwQKEKP6rdQnHIqyFz75ZZHFLmwbD93i9M21y+R
    XXTHAJWymQnUy5BYgT8TBVMdVDAj98N5rznlYCKP7FR58DudY2TW2em8KRrVnX8h
    CjbMUvdm9raIqhSXw+qgoDuVhmCFwB6MmBEZgf2Xv9XjhiM4kts2MJhsZ5Yo50z7
    zmSQR507QXksyPN55Me89nNR/OHdHu5qZNkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523265207; bh=
    Hw3ak1MIUHFGGWuD0JlDEEVahOl7T42r8dkju8rh1n0=; b=I4tuOKIJYbQapR/Q
    Vf28FuJuFnJKqYAlCHZ077aPwb5b3pQvGbVCCFi2UKfA+MFtuhEdP0judtyuO864
    TP3PsE+YQEJcpluITOASZ8AG4GBBD6t2zVImfhn0O3YFqg4Gux1M8JczJw4Akmi4
    odSInbEs0hYUjQl28uyiMHszNerVYS9A8GrmGAiYojuQsQkj2/Zk4dJRtNm4iJ/p
    EXK1fAP2KrrhwI+Ei/OM1BZ31GuIOH3XWxvtcc/496eGRBoj5Ddizbz6JS+ReUcL
    y8t0V7qK3qCCbfPr+5Lh/LCrUbFA4TY0yfy5mqQjRHzIH+GZQNpo8D/R2hoEHAR2
    +ndnRg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLQLEpp1LmnLz4uImHnqh7lIEYLzg1lLSRKcJyiZApcMjwGxImDr9wernLLqhsRxCHS74PV6OYIAzWzdXR3hAHEPO8Lrtn7eZtWpGeIDV4R1QK+EO+YP
    IUQnLywfdCGi5Q56rFh1scAa9/4CdEdBcUuzEX3J88eSXMc//vnpBA9jLNIQVLskvfXfMCgNuv+VSb/F1zr8CLVk70gZdIZMTFJ4zbn2/VQn/MBTB/yhMTq2
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=20KFwNOVAAAA:8 a=PbzGHTm5OpbTGkgR0Z8A:9 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeDIJLG (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 05:11:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751348AbeDIJLE (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 9 Apr 2018 05:11:04 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kt.liao@emc.com.tw, Oliver Haessler <oliver@redhat.com>,
        Benjamin Berg <bberg@redhat.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 1/9] Input: synaptics - add Lenovo 80 series ids to SMBus
Date: Mon,  9 Apr 2018 11:10:43 +0200
Message-Id: <20180409091051.2944-2-benjamin.tissoires@redhat.com>
In-Reply-To: <20180409091051.2944-1-benjamin.tissoires@redhat.com>
References: <20180409091051.2944-1-benjamin.tissoires@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This time, Lenovo decided to go with different pieces in its latest series
of Thinkpads.

For those we have been able to test:
- the T480 is using Synaptics with an IBM trackpoint
   -> it behaves properly with or without intertouch, there is no point
      not using RMI4
- the X1 Carbon 6th gen is using Synaptics with an IBM trackpoint
   -> the touchpad doesn't behave properly under PS/2 so we have to
      switch it to RMI4 if we do not want to have disappointed users
- the X280 is using Synaptics with an ALPS trackpoint
   -> the recent fixes in the trackpoint handling fixed it so upstream
      now works fine with or without RMI4, and there is no point not
      using RMI4
- the T480s is using an Elan touchpad, so that's a different story

Cc: <stable@vger.kernel.org> # v4.14.x, v4.15.x, v4.16.x
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
no changes in v2

 drivers/input/mouse/synaptics.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 60f2c463d1cc..14a1188561aa 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -173,6 +173,9 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN0046", /* X250 */
 	"LEN004a", /* W541 */
 	"LEN200f", /* T450s */
+	"LEN0071", /* T480 */
+	"LEN0092", /* X1 Carbon 6th gen */
+	"LEN0097", /* X280 -> ALPS trackpoint */
 	NULL
 };
 
-- 
2.14.3
