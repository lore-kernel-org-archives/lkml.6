Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339499-1523480446-2-3434820961700947321
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, URIBL_SBL 1.623, URIBL_SBL_A 0.1,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523480445; b=PAuPxzm9IW4NE2vqwJRjXfxHDscD/VsB/JrDeSkYE2c9DD/dD2
    yQ7HFvjIuh24dABXCDrhaNtr2f43SXX2r1s/2VFhwkbJQsyj1jnTFDwAK7ICHbd1
    RJZ9w7Zr1V7NdsXvsgqnf8JAK0qDfVKIrm6ZTcNzlWONTGEBL5oyLp8A2QELZIkD
    Wo5QP4VqfEEDnZu/dqmgc0LihMsMX/j+0UFQdnr92rBdSgs5MnZBeeISgydHxrfn
    s99mPbXGvaugX45Ce76V9VZ+nGLjgAMaYLuuy+sDICPdB9J1ZRTOSEmUcL6l6hHJ
    LZcluF4t67a08zJFQPzI4nulet/qQ7DAt1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523480445; bh=fsrR7Z6XvXtj/AonSE2DJeLj6rEsNG
    yuAblTY7TehZA=; b=USOsIBkYpyvJzvTVrly7+0S0W1r6LmJIgnBCXvT5E8lQnq
    xzZ4fJgyqyIP+rME6/v3eUC6uIXdphavbTXmm8O074LP+VQ/h8ZaiFSFGBcscXYi
    vXoo5tj6kG/9kEPCTbQnmcpRXyGK1txEo3CbcubxpiD6v2Tw2aNxyck1agCVo6do
    uDh0Tj501ttovzFXUGOXTcZvVPh7lX7dIbARp1UWVtWtA8WY1w/aIDiZJJo4UtZn
    yI5AKu1bFz+ReC4IFBtNeNtYQ8grcGNXveDx2yFYZCNcoUHxlqexo1d6X1UFh1T5
    IIKPXSBIk6crSRAgfC4nrSucHCaVnvYoum9AjQPg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfPC687AlVI9yWzWmtJirUn9eAFNjxWhbLUYxfy/mAXzzfT6nMdEoq+fIl5+wowojgmfIMo4Zqo9HnqkqlOd8HPJQp1BNqYRPiZGH0GFF+nlCrHpOGsWW
    77TxRfdpAbOj407/cyM2GjMTnQMZdFAa9nVefoUugdMR1XNhrkuk81nL9hdz+QQnh+WVj0lyXGZ1BP5X9JBrX2isGDJcEhaAqqkIXShs+hJQk5AQxfQHnP28
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=Z4Rwk6OoAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=UvTXxvC9t4DYxCbIZOkA:9 a=QEXdDO2ut3YA:10
    a=HkZW87K1Qel5hWWM3VKY:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932070AbeDKSnm (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:43:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57652 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932069AbeDKSnk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:43:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes.berg@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 001/190] cfg80211: make RATE_INFO_BW_20 the default
Date: Wed, 11 Apr 2018 20:34:07 +0200
Message-Id: <20180411183550.184496168@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>


[ Upstream commit 842be75c77cb72ee546a2b19da9c285fb3ded660 ]

Due to the way I did the RX bitrate conversions in mac80211 with
spatch, going setting flags to setting the value, many drivers now
don't set the bandwidth value for 20 MHz, since with the flags it
wasn't necessary to (there was no 20 MHz flag, only the others.)

Rather than go through and try to fix up all the drivers, instead
renumber the enum so that 20 MHz, which is the typical bandwidth,
actually has the value 0, making those drivers all work again.

If VHT was hit used with a driver not reporting it, e.g. iwlmvm,
this manifested in hitting the bandwidth warning in
cfg80211_calculate_bitrate_vht().

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Tested-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/cfg80211.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -933,9 +933,9 @@ enum rate_info_flags {
  * @RATE_INFO_BW_160: 160 MHz bandwidth
  */
 enum rate_info_bw {
+	RATE_INFO_BW_20 = 0,
 	RATE_INFO_BW_5,
 	RATE_INFO_BW_10,
-	RATE_INFO_BW_20,
 	RATE_INFO_BW_40,
 	RATE_INFO_BW_80,
 	RATE_INFO_BW_160,
