Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4009664-1520842454-2-6963198464959068315
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
    t=1520842453; b=VRmLR9c5s8mEfFRGqC1AsuVi5Kf2jtcN+6KQUZ4jiSpDPYd
    JmjUSBwhL0DI7DBmpxsNTSmsKNk0vw2lLTTDqaYiRc81/UeLg9I4A5jz0tSQw/Xp
    fjEnIubn0rbn8D4jP5S4x9Opga3H0RX0xqbZ+Cx2i4kl0g+H5ZIiVpTZInjdhRMW
    dnzw7IJJ7KYVS165VywDQ7udQROvqIif77QkTUQlEHAbKWvwgqBPTPVaUHD3Oh1n
    bs+MA6cdT0GRxm0ZXBOUCrwn/D+69sxyTKNR5SfEvhLdoCU9SrR8ljBEkaWkc4cY
    Af1FLJmHRB9QI0Pybv5oJYWBfFc2Q/YejI/wtOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520842453; bh=5WQW9AXP0BPzZATPxB7V2lCau0
    FB8S+1y+J2LfQXi4o=; b=Eg6hDoTUn8627SXqO9r3CbEvVwV4O3jsbi1FjUYDdK
    L3xQdS5yCBF+7u1jdKQjrkqSIZhv183JQBf5oVoeUFVPHXEoXPftVYKjb/RU/9iW
    K9b87wBDWa26XWTI2HCMsvlhUEQtIAHRuz3ffiu0Tnrh8BADTw/CJZcsx1eU8w8J
    BlvrbQoJLDHod0sZmIHXrhbGLkHeZjuDSmj8+At+Z8mNqiTKFzCCNNTE0pHFgDMd
    +E2PRET3mUSiqF5Zs9E4gGc1sTM/7nuNgfZIpQ0NvFOzkCArEbdaNh22jqJjMSvr
    jgNMx8QyYTK50jWNMgkr4eZVI+y/WkS5jAxZ8I/QJBxQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx2.messagingengine.com;
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
        id S932619AbeCLINx (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 04:13:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:14596 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750752AbeCLINt (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 12 Mar 2018 04:13:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,460,1515484800";
   d="scan'208";a="37390465"
Date: Mon, 12 Mar 2018 10:13:45 +0200
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
Message-ID: <20180312081345.GH21904@kuha.fi.intel.com>
References: <20180302102057.8917-1-hdegoede@redhat.com>
 <20180302102057.8917-2-hdegoede@redhat.com>
 <20180309175347.GA12150@kroah.com>
 <bddcf7ea-e58c-637a-e546-9978fd2cb540@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bddcf7ea-e58c-637a-e546-9978fd2cb540@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 11, 2018 at 07:24:18PM +0100, Hans de Goede wrote:
> Hi all,
> 
> On 09-03-18 18:53, Greg Kroah-Hartman wrote:
> > On Fri, Mar 02, 2018 at 11:20:46AM +0100, Hans de Goede wrote:
> > > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > 
> > > Several frameworks - clk, gpio, phy, pmw, etc. - maintain
> > > lookup tables for describing connections and provide custom
> > > API for handling them. This introduces a single generic
> > > lookup table and API for the connections.
> > > 
> > > The motivation for this commit is centralizing the
> > > connection lookup, but the goal is to ultimately extract the
> > > connection descriptions also from firmware by using the
> > > fwnode_graph_* functions and other mechanisms that are
> > > available.
> > > 
> > > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > 
> > Sorry for the delay, just now reviewing this patch...
> > 
> > The content is fine (if not scary for the obvious reason of passing
> > around 'struct device' of different bus types, but ok...), but the api
> > naming is "rough":
> 
> Heikki, I think it is best if you answer Greg's remarks. FWIW I'm
> fine with the changes Greg proposes.

Me too.

> I currently have significantly less bandwidth for this due to
> personal circumstances, so if a new version of this patch-set
> is necessary it would be great if you (Heikki) can do a v7.

Sure thing. I'll prepare the v7.


Thanks,

-- 
heikki
