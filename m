Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3269524-1523477746-2-14652919031986990143
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
    1523477745; b=wKOI5Wk7pUJUKI2sMS+M3baByNxWtoAKm//3N72sKc6n+cUuCg
    +lzHeExaLS3Me/+tGKsHyYRs23kR+Y4DUP5M0JyqTKxkJtsV0TVcwculaxPwpmHu
    FgQfG2zNQSAlZITPMprMjKdN96BluQM2uUTCLZLtZ7rUVThWZ6QltHv8+MHsH70G
    z7bPmRL4khko0osKmIk4+mAZ3gVf25MvQUUQsQhkGdSIvlQDv3sxF9ipNfQEgKRb
    WdmCrH5r2CN1x9C34+SS3fHwU9EoGP/LcgufNBYTngoRN+7IxXP5btJSdJUFaOB1
    YGuwsRrU0p4f8t5XLWZYkjluixa0MEln/mXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477745; bh=FbV8hRoqyigcRCPch5I3bWiJ8d/9H4
    24xfPb2MgfYyI=; b=tIvaPoW8HH03LE5jyoEuN6AV6n1ooZb1VdseSyFDyg6/Hh
    Js2MX3FlcgfU0WK5Ttn8+uI+LMmY/jiYfw9C9lCp0vtB/YWTLEnEhajOwEF0ZLD5
    UZaB5u15wjDiqcShs+9sxY8S3iMUpqYD/ULLClYGvkAMWuBOLFDBNTHA9gaHG/N5
    /3tYq3aUzJh8UpyUM0vTfU0SXSPOP3usF5Jbo3EiEIcWvObBluMRHFt4OkWjkAbf
    GFj/QIOXIYtwLFqaBKVeZzsdSpPOyGgZUfUguYjIgh5o38mTTHl53YPrGTzDJS84
    9xSWsLe2YfBqbmBEJ4alQZgq8gOXB/cfo2rT+Dgw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfCRkaC6cuqfBDnPzWsjEiFLXLSFTW3XRzT1nAeFmFm3zzmiJYai6nt9cHTEO4ciyuhlXIhICQ8IOgrhy1b9x1RSViuDBdGGMt7+Rn4HIk6kJK+hG7r6R
    Tg6Iqsh/Xd86JWbtgZabkFQ+EYli0S/sk+0rcy3oTOmPVjJzsdI/RvKgc/EEM5nK9KZI6Ts9PWS7O+sS0w7o3KGaGcdQHKGXz5A92KA3KM+bytcqnfNLFsMX
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=Z4Rwk6OoAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=UvTXxvC9t4DYxCbIZOkA:9 a=QEXdDO2ut3YA:10
    a=HkZW87K1Qel5hWWM3VKY:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933226AbeDKSxQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:53:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33680 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932401AbeDKSxP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:53:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes.berg@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 002/310] cfg80211: make RATE_INFO_BW_20 the default
Date: Wed, 11 Apr 2018 20:32:21 +0200
Message-Id: <20180411183622.404557037@linuxfoundation.org>
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
@@ -947,9 +947,9 @@ enum rate_info_flags {
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
