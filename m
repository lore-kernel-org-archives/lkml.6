Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459510-1523022410-3-1441447087076726721
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523022410; b=tfKbXxCingeDKukdzJBnz1gQm6tGTnFaAwsi3UvU3AOJvm/4R6
    P/LbZ2hagKAi5gh0WHmuAF448PY9Yz/bro6W+oOFFdPUcQbxwqC7YFvvIBM608j+
    M9qDwWXJTxWA3NA8Ybwsy2WgT8q4uR+D4TPMmWACJzoTye5p0eHXkUdLZ+cbdhqa
    vaM6P/ylnfkSfJcTOoCtlP5QINaOVhwpb7jDbwlMM8B6Z0EzUWoKArIfodRmCOl3
    Y1GxND4xjxMg9Cox0xl2oc5fbSvgSCURCAkTeLg0kugRn2YcNvdhAsOS0/3tuG6S
    Ppi7Jczk/7V5q+WrirmMwG0mcqpDm2iMvoew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523022410; bh=M3s/wJ8NI5pfuhbFhm5QwzMVAogIcz
    vrh4B3WqOy4N0=; b=musaABE9MGL4cG0CvjskJmJ4os/c/6oGRZ4k2rWiZiY4tk
    qV0Act3GU8bpLnGW7bXvxLWC2QDW1lqWfCMIRjk6BRr29wvDDEwfgH8nu0t0OtfY
    uws3nSPpqu146oaaGhDJm6/aeWt1B5mQtJyyKsud4vuqcgtdri25+uwvxwRb7uv2
    KRLEi/dxQmgCengKghBd+elzdfPTGBlQ3DF4+mnfa8McJ/IRVZucSe2+ezYsfIlN
    W0qxa47Qfulw3Bxoobr6DmL+zEt1Bjk0vrpiYHbWvX31pjDf3erzRIoV60Iv3Tju
    NlAOX++FElY1NmTQcMAPcf7BHCQgE79jNyKcpe0w==
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
X-CM-Envelope: MS4wfNuI2T/MYyX1UyRnwh1Os7JTzAOglNM0IunjixwvzU70m/IBf6cruwnaP/Eg6sHcU7T67Jr4RASzKVWrOLFjT4pjoY55UbEqPraeVZFnbRR4iSadIe3O
    ptPrmPOQbRJ5YcAXuJrDHDo6onXGhk8ppBsozvi6KQACxdC20yAv20W0If1BJ6Ag4UqspVy/XPdgMmQ5ZSMTtvHqMq5S3PJKZhDTFMTmLOp+nsgt0yDxHU8u
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=DfNHnWVPAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=KUxnxfl8UcLBcMteF0IA:9
    a=QEXdDO2ut3YA:10 a=rjTVMONInIDnV1a_A2c_:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756984AbeDFNqe (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:46:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38120 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933070AbeDFNp3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:45:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>
Subject: [PATCH 4.16 06/31] mei: remove dev_err message on an unsupported ioctl
Date: Fri,  6 Apr 2018 15:24:31 +0200
Message-Id: <20180406084341.906336344@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084340.999820380@linuxfoundation.org>
References: <20180406084340.999820380@linuxfoundation.org>
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

commit bb0829a741792b56c908d7745bc0b2b540293bcc upstream.

Currently the driver spams the kernel log on unsupported ioctls which is
unnecessary as the ioctl returns -ENOIOCTLCMD to indicate this anyway.
I suspect this was originally for debugging purposes but it really is not
required so remove it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/mei/main.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -507,7 +507,6 @@ static long mei_ioctl(struct file *file,
 		break;
 
 	default:
-		dev_err(dev->dev, ": unsupported ioctl %d.\n", cmd);
 		rets = -ENOIOCTLCMD;
 	}
 
