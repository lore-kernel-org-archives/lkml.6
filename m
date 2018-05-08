Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2483311-1525767574-2-622253880715964348
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
    1525767574; b=ib/Ub3MKAV+cGoL6nvuUiaHgIoYJOZauH2hMRwczXH6lQJQ+nM
    EVrl+fH6e5PR25fQWbUXHGK09RsRzIoNR8k1IuNiETlDYfZRg0h/E27Itz9ruNC5
    H36ia6QRODSdshUMeGNkru5at4Kw/ZWKmmHkCmjwEsHqdAmGqxV6FEIknmQB9mT6
    V5NEVq0DHy1YuSA4Omq2EAa59rB6uGqp+jpV3oIKMdopP7xFIKMKCq7so085yYod
    TW/2lgUO84u2sF2m5tp11AwwKQUvnNkSYcViGO7sFAM+juzWnEGrJBA1GxsBWkMh
    mFqNTF7tyzCtBfFSPW8sWhZnOkxDHP8E75PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525767574; bh=lFJVJC3zwsPEoTRAUEbqc4UJG+SThG
    ZCw+TqzahzPbk=; b=Nc/oBisp8MiUqYuIs1NBiXiJ8rMzNceEGjcQm5kSEMzqsZ
    fV1DLNBdfMWuNrykVsIqJvKdlgCOzjk++ccl3rgodhRxqvd6Ni0v1oerhlhVXRtr
    VAsNtWXOhtnXIwPQhqmKDAFCmMB+wMyU86LQZa+xzhHnQZFR4FRS5xjIffJxswuQ
    YbIY+Chmi6x6sSw0M6rRjfcMlt8vZCeVNMzsTgEXQaCYMLkufBdBlaSQ941Saf8/
    3MV6/kwhYYNsTQeZVLMrW2AkLcZHek3DzY31D23JHK5uMSVa3S3ScWLsNtiSV6Vy
    DpFrlOCQOkRXafUTgZRojyqxjTuovsy26tSBvQZA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=GZAKyKoY x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=GZAKyKoY x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfKAAi00OnY0h8R6HNvlfgUCkmKib65UtEy9LJV7YphF+x54giBqMlPQN5kITRDC3CJEVZLq0dS55/3hmflQSDBHRZUhMR1lrRpUYV9lMA8GRK0piVRHn
    bX3IKWikjEqUMCKK86Iymbh4ihYaGjJiiitAx2365QEKc3iBxA9atNLsFMpEAnLPsvV+358IeUfjQc/pBzg6rRfuE3wBxqZrwXbY176QpZ6WgG/ebHaIQKlr
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=qJmR7GpmW-rew7waPYMA:9
    a=QEXdDO2ut3YA:10 a=aeg5Gbbo78KNqacMgKqU:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933018AbeEHIRz (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 04:17:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932999AbeEHIRx (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 8 May 2018 04:17:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.9 29/32] usb: musb: host: fix potential NULL pointer dereference
Date: Tue,  8 May 2018 10:11:09 +0200
Message-Id: <20180508074013.359992903@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
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

From: Bin Liu <b-liu@ti.com>

commit 2b63f1329df2cd814c1f8353fae4853ace6521d1 upstream.

musb_start_urb() doesn't check the pass-in parameter if it is NULL.  But
in musb_bulk_nak_timeout() the parameter passed to musb_start_urb() is
returned from first_qh(), which could be NULL.

So wrap the musb_start_urb() call here with a if condition check to
avoid the potential NULL pointer dereference.

Fixes: f283862f3b5c ("usb: musb: NAK timeout scheme on bulk TX endpoint")
Cc: stable@vger.kernel.org # v3.7+
Signed-off-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/musb_host.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -1023,7 +1023,9 @@ static void musb_bulk_nak_timeout(struct
 			/* set tx_reinit and schedule the next qh */
 			ep->tx_reinit = 1;
 		}
-		musb_start_urb(musb, is_in, next_qh);
+
+		if (next_qh)
+			musb_start_urb(musb, is_in, next_qh);
 	}
 }
 
