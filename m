Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2326222-1519114909-2-7292921760626077558
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519114908; b=oIJcfRrKFQiCR1LID1gLfhdoVRbWP2YDaIjeUnjWEAlvQXZ
    fqDEN+aN9caoBMecbw39oGfz+PIWB6fu+pJTUzFpnChus65DRCqMZMhd0mrw8htO
    EyNGXUyiVyfnLe4VJwvlFUDNCJYnvjpZVxqN7z3Bo+0+ujypxJ7ldP0ucuq2sMXG
    hnXDauoMkiRMjBAhDL3iNIrVW7nLTw/S/52g1BDN+oHp7MTp1Yg2hneAsKWZTwE0
    lNtBWcSXS0wyGKJS8GBZ1+rE7lk27n5N6OZLXyjESNjNd9FJSprKEmjBux/E7dTo
    RqErpfoaDy5htxUVd07lFhckm9XMzLMZlXquPmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519114908; bh=qV+VaJE3OI+hXSYHZheDz92+ERRkLMFA/d4hGV4cIXU=; b=E
    1P6HM1PHL4N4zTJxbQ7Pw6QaA2GRvktjw6K6K8aWzJFtlJWKjqpPAKYhYqR2qkBg
    UFWtg0xBpBZCYVl6TgRh6b95q6b691LrKPIXRtblRXF5qjy8c4jV0v+Cm95vwMtl
    MNhzBJOQlzAoN8OrrLXx1mMs1bwdFOEF+/6GjjjalDSk8ioXxbwGofrmh4Xaz2wt
    9EQS6fm2pyt5H8CCGTlwV7YGlNgbPM/BBrSZMcFozua3dwQIRPhAC56GM66wcgcX
    c8y65aFNKZv9k1VUj4UUJLdSs8IXxaAHzrsh7cs7NE8WNLhqdo85Y0xcVuwIE6Qe
    IV3IxUqwSNug8ar8CxEfw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbeBTIVe (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 03:21:34 -0500
Received: from mga18.intel.com ([134.134.136.126]:17797 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbeBTIVe (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 20 Feb 2018 03:21:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,538,1511856000";
   d="scan'208";a="19670263"
Subject: Re: [PATCH v2] xhci: Fix front USB ports on ASUS PRIME B350M-A
To: Kai-Heng Feng <kai.heng.feng@canonical.com>,
        mathias.nyman@intel.com
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180219190621.6632-1-kai.heng.feng@canonical.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <c32af5ea-c8ca-b68b-790e-102c7a8f89f6@linux.intel.com>
Date: Tue, 20 Feb 2018 10:24:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180219190621.6632-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi

On 19.02.2018 21:06, Kai-Heng Feng wrote:
> When a USB device gets plugged on ASUS PRIME B350M-A's front ports, the
> xHC stops working:
> [  549.114587] xhci_hcd 0000:02:00.0: WARN: xHC CMD_RUN timeout
> [  549.114608] suspend_common(): xhci_pci_suspend+0x0/0xc0 returns -110
> [  549.114638] xhci_hcd 0000:02:00.0: can't suspend (hcd_pci_runtime_suspend returned -110)

Is the xhci runtime suspend something that you expected here?
I mean was the plugged device first enumerated normally, driver bound, inactive and runtime suspended
first?

> 
> Delay before running xHC command CMD_RUN can workaround the issue.
> 
> Use a new quirk to make the delay only targets to the affected xHC.

Is this some known issue with this chip, or something figured out by trial and error?

> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Thanks, otherwise workaround seems fine, just curious about the two details above

-Mathias
  
