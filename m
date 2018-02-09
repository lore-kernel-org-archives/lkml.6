Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-806989-1518163284-2-15141608711529470161
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518163284; b=NETrWEf/P1muldyi+huI4weF2GltWVwrLICxMy+0abkPEe6
    CrL9CwYsYcf3txQI2OkG+EsvqGvDlOzhTh7oCA1sniJgSjot764Bjr+/mpC3Tw+G
    w93BvbzDVjNvvj597NBLI5zkY+KoDvvcIGX076VgQMLlPqlg6Th0tDwhaWP4N4JO
    kJwM8IQQRuv5mNYwULngBwRW5X618kHlRTlNRIcVHT+63UFHJ0zarraRxCvFidr0
    sDWYAFVZNt55damFClpFiLdQ/TNtZcHTy4hvRjxqbT8QSCJ3xWdf6ccUVIhNMuY5
    OEW9W4KcBaSeXPtx4cHflxzmjZvloKuTz6eIN5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518163284; bh=5wTcAxPHL2GroM96b+BC9KzFoi
    1sTyFQTyukboSH9YI=; b=dREV0D5GXdiDDMpHdKYNMebjrOJ3Xqnj9b/xSi8fxI
    xrYH9BELoXFPOCJ3UN1aME4M1Pbfxzq9VUSu/njX2eR/8NfJqRL9qK42Q+VQrj/I
    zmQMd/dYxXWiscuGUDf4rFCPE6/SjM1CTnvlYnFlpr7KPAWMHq8vZSfIvA4RNCEV
    2wWua1bT7j83CEdibDe5ejwW2jsSLiefbe3OhGOzOjhCyZqNb/uvDsfIa3wTAR3w
    zPV2eVXyIO6OqBbIZgg1mYZiozCQv2IgyiukGGf9xcKpuZuJaXSrQeO9zsXq9D9B
    5Z14yWmRqlRc6ZN6Ee5wZJYDZzBy56/ULk7r653pECVg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750981AbeBIIBV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 03:01:21 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:60910 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbeBIIBU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 03:01:20 -0500
Date: Fri, 9 Feb 2018 09:01:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Long Li <longli@exchange.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "James E . J . Bottomley" <JBottomley@odin.com>,
        devel@linuxdriverproject.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] scsi: storvsc: missing error code in storvsc_probe()
Message-ID: <20180209080118.GA19045@kroah.com>
References: <20180208235040.5803-1-longli@exchange.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208235040.5803-1-longli@exchange.microsoft.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 08, 2018 at 04:50:40PM -0700, Long Li wrote:
> From: Long Li <longli@microsoft.com>

No, Dan wrote the first patch here, don't change the authorship of a
patch :(

Now fixed up by hand...
