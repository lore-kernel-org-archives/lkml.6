Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4134551-1520846666-2-17010171164368490552
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520846665; b=PX04KT5HKLigt4duUFGw4KXrwYun+PdlxeehrozSpZHRZ3U
    U+k+7wzF1WvM5HRU68tTL9FQb+f7ErpzTY3pu0CIo+zJe5YomVOcvA14REQieQJn
    mn0MiI0no9UpNk2vZTqTeVi6xZ1YK4cE6DRElWqNip0CEVjCFRTgXEj+AEwXTRzi
    ZnRjqbP0YsMRKmaxQ6iM1l+t1jPyrYArxdVxOc4awXR77niI1kxRC6dPWMYMiFlR
    e8XaR1+0V6mvQM3DrAKjG7XbKB2Jy39oAtMXYYd6K32d0YY2iVzUfRU2JPEbklG/
    Po/ma3z/6LQeI2t5NcAtZ3X4CibngT9cQ2JUu3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520846665; bh=R/KfFL6TSGESPmxEqX8Xv4QMgb
    a/GSMiTi8FggpNb/Y=; b=S0616g3BbS5tbAvR8m++gGCSprjaxIJtrbYbW5hTgn
    9GVPNfItQXvy6B12s5BquZMn79fNzrpZKHoiPFowh1fDBJmJOvrJqkMpZNcZdtxf
    NeFwt30rjYqKwjc8Lud4fzwLH1whE4HoOoDAMc+EJ/oXlshgzHTZbO9dEe9GRiNQ
    z0sVDFyIHxSpm5H6IQqUzg3vrED7iPjP9K7W89SHbev8rRg1fdIqxfQp9ygVLZTu
    NMxXUpoZUnFYd8gRJoQEyQ4C+yx1RDaCaxWiWfBzauLZAcrMsT9d+78CTUhDhry2
    7F9HQim/YfKPRWP3USMC+D2DAT5k5h90DOnUK6iWeLlA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeCLJYL (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 05:24:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:37841 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751259AbeCLJYK (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 12 Mar 2018 05:24:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,460,1515484800";
   d="scan'208";a="37403242"
Date: Mon, 12 Mar 2018 11:24:05 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v6 01/12] drivers: base: Unified device connection lookup
Message-ID: <20180312092405.GA30868@kuha.fi.intel.com>
References: <20180302102057.8917-1-hdegoede@redhat.com>
 <20180302102057.8917-2-hdegoede@redhat.com>
 <20180309175347.GA12150@kroah.com>
 <bddcf7ea-e58c-637a-e546-9978fd2cb540@redhat.com>
 <20180312081345.GH21904@kuha.fi.intel.com>
 <212ceba2-2f13-0501-c59e-612b72989cb3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <212ceba2-2f13-0501-c59e-612b72989cb3@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 10:19:34AM +0100, Hans de Goede wrote:
> > > I currently have significantly less bandwidth for this due to
> > > personal circumstances, so if a new version of this patch-set
> > > is necessary it would be great if you (Heikki) can do a v7.
> > 
> > Sure thing. I'll prepare the v7.
> 
> Great, thank you. Don't forget to squash in the 2 fixes from
> fengguang.wu@intel.com .

Ah, from build-bot!

Good that you reminded, I would not have remembered those :-)


Thanks,

-- 
heikki
