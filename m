Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-176773-1518788608-2-17313910863148408402
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
    t=1518788607; b=rVDMA9g2oZsThc4NJOXDCT3LcaKB20qxR6eVoLs4xez98P0
    Cei2GbxYPzGkpSZsxxnTWyj+Gp1/+9QSIghS06rd0yZmN8tQkEmPXJ4DFZ1Gu7pL
    MZGgUU5xqnU9jbxlMtGJa5m7XMUAJL1kVa6hrjPKgtxz0+5O3A+Ne2cPsnvVyYGt
    pXyAyRydj+n4Qd6lr8wwhLt4PCxWb27DEj4xcJycJybSAbJvXfuDh9h4Wlr9i+Jn
    BVIH+H/PtrJzLyw9/39neCx0UqZAu4IFTup9Q9Xug8vhCedevWGXYM2e7WwhsYwt
    mFcpq4es1EYURtxG7K835Dh6rGPm/BYJk3lxjwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518788607; bh=ri79kwyHq34paHtocbRj0Kgave
    ncHcu08MueSAN9fXE=; b=lH4vNJLsntXDp2tRdDuxqoYRL/xySsUJdiugdNwe6F
    joRS4RWeIIXDOG5nSIt4WbodhbhCwbxbPCp5HgOI3NoIYkwnoM2NQPZDBhDSWvAd
    Xi9XorDMSqoFso0V7UJqUCp5yKP5p8qW+IUaP55m4v/+L93m8RJf+X3hrzGeEViq
    xtseL47F60G4u1lhVCE8atK0xy1EDfvXNUdgu15rOB7n6hY9H3gTTHv0K/iyHwPQ
    fNjgMhJmpWRqaQvKzFvEeHa6WlMyBDYVMofsMZsRWk6PgV/juNsmfUsQ9KQo1zI3
    Zg9BLI93MMNZgA6vd7rdjw4TvhXc1pyTCc3HpqCl7C2w==
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
        id S1031794AbeBPNnO (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 08:43:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:9787 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031757AbeBPNnN (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 16 Feb 2018 08:43:13 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="31368345"
Date: Fri, 16 Feb 2018 15:43:07 +0200
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
Subject: Re: [PATCH 10/12] usb: typec: driver for Pericom PI3USB30532 Type-C
 cross switch
Message-ID: <20180216134307.GP1480@kuha.fi.intel.com>
References: <20180216104751.8371-1-hdegoede@redhat.com>
 <20180216104751.8371-11-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216104751.8371-11-hdegoede@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 11:47:49AM +0100, Hans de Goede wrote:
> Add a driver for the Pericom PI3USB30532 Type-C cross switch /
> mux chip found on some devices with a Type-C port.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>


Thanks,

-- 
heikki
