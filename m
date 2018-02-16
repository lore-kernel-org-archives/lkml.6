Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-176773-1518788654-2-15906375063746674689
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
    t=1518788653; b=O/neBtEmlPTT2E8s9sn83ysKAH93nEg6v9nTUBycpikGbnK
    HkChMihQiK4n6oLYZHC0AtJt8h3bZigbRU8val/+idwCF9urBRiuVR2DlO2+b+jM
    6YBJGW4VZaVeW4ION9IK3bUS94L1t0SJTQ6KlK3dDp6M4CmkF4maTrv+TI1QiG1j
    EnXwdBlzwXoHADwBoTptCpifhhsbwO8b/Opecz0+oaDC48ckMUeyx6IrWDau7Vpe
    4holtluKJfD6kKbcFthuECPuaQwHyZnrmm/+LP7oT8i+Aq2U7vmRlBCnSLyLNJ3b
    61pnITD8SjsWktLDCe7uBjjlbt8d2v+xxQ3zaQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518788653; bh=mBwBjll0TmnjV4/6b9vjdjdurh
    I7d4BGC4cCO/rsmEs=; b=MT+qqVEw6K41i9ciVbJhdWEt7xJZM8hZDdhUmwjDSG
    JMLBnkS/e4hs1lXd7g3wCcyYmInTgiP897DyIyCjLV3huAGdkir0C6TOrNFVLERP
    u+Pal4xw56qTTT1xYUfLP9wo4EpSkPEL55rQ3hZScdxY1yn06Fv8y8NlFqk3HRb/
    g+HIVzhK4+V2RkowG4+QmPEpR6lg5tvnDMH+3zJ6qZth2WZkfvmrFIOQJoA359UN
    7ms3+mKGxv7zKC4Yfv3HZ1Gddwenyyjv8TQ2+mA11lf3kxfdu3vytapRJKnbZTbz
    jfZn8ykCmo8Y07wyMZkgoSxzCHmCglf+VUgTx+rIEiuw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031833AbeBPNn6 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 08:43:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:6725 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031757AbeBPNn5 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 16 Feb 2018 08:43:57 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="31368475"
Date: Fri, 16 Feb 2018 15:43:52 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 11/12] platform/x86: intel_cht_int33fe: Add device
 connections for the Type-C port
Message-ID: <20180216134352.GQ1480@kuha.fi.intel.com>
References: <20180216104751.8371-1-hdegoede@redhat.com>
 <20180216104751.8371-12-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216104751.8371-12-hdegoede@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 11:47:50AM +0100, Hans de Goede wrote:
> We need to add device-connections for the TYPE-C mux/switch and usb-role
> code to be able to find the PI3USB30532 Type-C cross-switch and the
> device/host switch integrated in the CHT SoC.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>


Thanks,

-- 
heikki
