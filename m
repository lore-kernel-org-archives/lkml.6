Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2070142-1519889045-2-14246471535280599123
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519889045; b=ONOkpYuwwfHmE6eLZL7zy+2iQw97QzfzWCXyDt7WHZShbb8
    8w7i8wzgPBTT8R2MGVwW97Jx803LzVH4fJHKXbfyQOdm+ViQA7rixYxuKd/NKreE
    jJloRJ7X0t3ED+bvICl4vdsZa1TN7ZN4o/QpJSQb1CSshITOvI3QmTP/TU1bihxv
    ok9Nm3NX31EQ1RHevM1rG7TZxAvjk0o+3aGj9su4hXAled8EhL8QWMtt8PgtS0/k
    4O5cMOCuXlEXoSi3XPuYizJJbbOHHbCgUlzMBGCQ1ppvjm9R9N+uC41qaf+Vviun
    pMsKPCDQ8hGr2R34bbj42ZBqws4/LF37xgnjraQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519889045; bh=PACJLTHAbyQGGndZUbC0yfWUp6
    xV8RT0knWidGfUsAU=; b=JLtRaZ2nC0/9RnmF84MQcsK53aLvFGz+6Xd3d3k99z
    fdHloAM9RvkihOoiPtEe2nL7/f4YJnUtacdLbhIWsDunPd6gEO1mzQDVf/lC+sxf
    YH1AmkjUnqb01Fv1Lxblq1o9x/I8C0k8KDJRPXucJr0kbBpzN/IavBRQZPX0KrlT
    rBY1rhmz0sr2Se+UlBXIzTVTO1pFKp036L/MhVnhHVhhS9H5ZYoHuQg/CoIrpc5/
    hdIwqQBpBk+zDfcMABQB+gjQ+bzB4t5ft22sjmD5V8liELhxejB1m4je9m7aYRfz
    PfRw9dmMaKyPFvuerhCn7WUhrVY2NCpcuZlgirPcqjUw==
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
        id S966460AbeCAHXt (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 02:23:49 -0500
Received: from mga12.intel.com ([192.55.52.136]:32993 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966417AbeCAHXs (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 1 Mar 2018 02:23:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,407,1515484800";
   d="scan'208";a="34584819"
Date: Thu, 1 Mar 2018 09:23:43 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 08/12] xhci: Add Intel extended cap / otg phy mux
 handling
Message-ID: <20180301072343.GB5335@kuha.fi.intel.com>
References: <20180228150749.26831-1-hdegoede@redhat.com>
 <20180228150749.26831-9-hdegoede@redhat.com>
 <20180228151552.GA5335@kuha.fi.intel.com>
 <070f5ccd-dfeb-1e47-681a-8e116472ef9f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <070f5ccd-dfeb-1e47-681a-8e116472ef9f@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 04:42:32PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 28-02-18 16:15, Heikki Krogerus wrote:
> > On Wed, Feb 28, 2018 at 04:07:45PM +0100, Hans de Goede wrote:
> > > diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> > > index 96099a245c69..5917e3095e2a 100644
> > > --- a/drivers/usb/host/xhci.h
> > > +++ b/drivers/usb/host/xhci.h
> > > @@ -1825,6 +1825,7 @@ struct xhci_hcd {
> > >   /* Reserved. It was XHCI_U2_DISABLE_WAKE */
> > >   #define XHCI_ASMEDIA_MODIFY_FLOWCONTROL	(1 << 28)
> > >   #define XHCI_HW_LPM_DISABLE	(1 << 29)
> > > +#define XHCI_INTEL_USB_ROLE_SW	(1 << 30)
> > 
> > Did you rebased these on tope of the latest usb-next?
> 
> No I did not expect that to be necessary, but I see now that it is.
> I've just done a rebase locally, any other remarks before I send
> out a v6?

Nothing from me.


Thanks,

-- 
heikki
