Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-176773-1518787306-2-7618777648452431529
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518787306; b=mbAxvgZNP5E2q4Nuv6ZcNnrD/FPwl30mff+aOYOla5mPhYG
    pviNpNLeIF0/9ORHRgjiSHFSg0I1ISfYwrl5mdRARgzdgyfBBTrRDji3UGO6ywL2
    lFAXtbQp2qF1Fv5n/04uckFMH7B5DrFNNevYNhx9JdHVDyYRryFpKbTqumxeQ/dq
    GnPPrRKmuD0u/nTojFUBLk/k7EiAWxYUdt3ZmUcwGeN4geyhk4G7zvAEGpDjw9Ef
    FFe00QEcOuxBiN23ZB/EDcj/NQhMsjfDoFirnjdp6OiARINIx2GbDzEDmAffNtx3
    addbYuGAgVG9zXB/8ThWYGgIVkqp/njMJbFAaLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518787306; bh=+kWZ1ECmNBwdeX7QJkhmR8hemI
    opEUOpJMTeMKOlp9E=; b=JqgqOtEegpetxZJHBugAUVMWuSFInYJ2m3uL0wfrWO
    lAswgTfDv4X1l1j/fcJV89Jhl4pSFmS5q7V0KlOFvAA07bQv+9O+54887lO5ZzSV
    D10vTSREOYrezV039O2+vQfzMgs7gElTt0hXuwktS/B1rEpiMtOE08HvVguGGia7
    wZg4udWqLgLr6Oc5MTFJsQH2MWpaiT75duOmBi6brv52T7If/ZBmn0yMQtjW02Lo
    do6s4y0Ojh11aIA5Bjw+STaI06e/C+54qV040cma3tCkDHVLlTM/vV/wj3ZaieLj
    uHPdHLcFl8hdJnNIt2TYsz6U2hFW9kK6Ax7aZ9fu8nrQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030770AbeBPNVm (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 08:21:42 -0500
Received: from mga06.intel.com ([134.134.136.31]:3070 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030766AbeBPNVl (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 16 Feb 2018 08:21:41 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="31364123"
Date: Fri, 16 Feb 2018 15:21:36 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH 07/12] xhci: Add option to get next extended capability
 in list by passing id = 0
Message-ID: <20180216132136.GM1480@kuha.fi.intel.com>
References: <20180216104751.8371-1-hdegoede@redhat.com>
 <20180216104751.8371-8-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216104751.8371-8-hdegoede@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 11:47:46AM +0100, Hans de Goede wrote:
> From: Mathias Nyman <mathias.nyman@linux.intel.com>
> 
> Modify xhci_find_next_ext_cap(base, offset, id) to return the next
> capability offset if 0 is passed for id. Otherwise it will behave as
> previously and return the offset of the next capability with matching id
> 
> capability id 0 is not used by xhci (reserved)
> 
> This is useful when we want to loop through all capabilities.
> 
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>


Br,

-- 
heikki
