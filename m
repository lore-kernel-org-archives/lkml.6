Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-488755-1524652537-2-10484526940883860637
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
    1524652537; b=QhMZuYK0YtEtAK8oBIFuIqPG7a0tNyPLex25aj4ywg7xn01U9j
    Bk2rWVbMAWiWvT1wwGzyDDvW0vR2daPeA1CDmwfmH8qCdq13TQYuxI5/3o+niKEL
    VmpugxqqapSACnN7nnXf/LVfc2kpWnduQAviX4qGf0C9Ax24K3mPdJXY5cXXiPhr
    EePyxrblfoF8luSM0QzMVwyWPCS9Ry0bvJquM4V/QZuIkIlnwFvEEaiRLJxfri3v
    J2Ybc60c+Oxk5rYKmouuducZO7NYrvLML/sFKSBaqPy5bqDA4sySvWwfbdj39PBx
    cQ9QZdXu+1zGxVfIgmMLDusC3sWmfAiF0pug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652537; bh=bl4gRxZaqYpTzTDZYjo1LPSTI5LI88
    ttKK8EaJNO9EI=; b=PKdff/PXFGLswMUVQopci5tO7UScl56KnR47egPOtTkjbO
    81qeVmuPW6G7lBm6fUJheEt67wvA5DY2AErg+wczVDkXtc5ad7pPqJPDah2vjv7d
    WGhheirgsnKLcm6U3rfCGZ25cYYHzXYhMCSbLNXO2ADU3DDsB2IS1YJh85KFI8iq
    /Q3ue8EowigH2KqXsRG5v/gW7ItwBwP18zHFGMKu4+ekjLAAxcuufrPe+dLwhrDz
    Xs0rPbSCdXSdtTgdpK1UBqXW/dWXUmAFDK1Sc792tCwUYG/uv4+31jpy3ShLqua+
    0msbdN1kXXvPPVGNaxIBecTkueoVbtgfuguftE3w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfH838jIWr0nLvnl6JlRq28sK7SrG1s6ooMbcd+hh3HSY7R816Slsh4ungFkUDr6s/ZK+Qq7NrlHV2jrW3Mv3gnDZsabdyUzcou7WhHtsuUJaMM759USN
    wfSavfCCdQWU2UqlJZ6Etz5RwSOEK9Mj141ovXLtv2txgd5s9Mmuww0xHCkgABfhXibl0KPA2UPyq+nAtr//QfeslVAoC2UxuOj5VxXCryEW7yXHcv9cqV2T
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=ag1SF4gXAAAA:8
    a=rePIPyD2CXqVu-yP4rIA:9 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752898AbeDYKe4 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:34:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50966 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752700AbeDYKew (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:34:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dong Aisheng <Aisheng.dong@nxp.com>, daniel.lezcano@linaro.org,
        Linux-imx@nxp.com
Subject: [PATCH 4.16 06/26] clocksource/imx-tpm: Correct -ETIME return condition check
Date: Wed, 25 Apr 2018 12:33:15 +0200
Message-Id: <20180425103315.108418382@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103314.842517924@linuxfoundation.org>
References: <20180425103314.842517924@linuxfoundation.org>
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

From: Anson Huang <Anson.Huang@nxp.com>

commit 7407188489c62a7b5694bc75a6db2b82af94c9a5 upstream.

The additional brakects added to tpm_set_next_event's return value
computation causes (int) forced type conversion NOT taking effect, and the
incorrect value return will cause various system timer issue, like RCU
stall etc..

Remove the additional brackets to make sure tpm_set_next_event always
returns correct value.

Fixes: 059ab7b82eec ("clocksource/drivers/imx-tpm: Add imx tpm timer support")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Dong Aisheng <Aisheng.dong@nxp.com>
Cc: stable@vger.kernel.org
Cc: daniel.lezcano@linaro.org
Cc: Linux-imx@nxp.com
Link: https://lkml.kernel.org/r/1524117883-2484-1-git-send-email-Anson.Huang@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clocksource/timer-imx-tpm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -105,7 +105,7 @@ static int tpm_set_next_event(unsigned l
 	 * of writing CNT registers which may cause the min_delta event got
 	 * missed, so we need add a ETIME check here in case it happened.
 	 */
-	return (int)((next - now) <= 0) ? -ETIME : 0;
+	return (int)(next - now) <= 0 ? -ETIME : 0;
 }
 
 static int tpm_set_state_oneshot(struct clock_event_device *evt)
