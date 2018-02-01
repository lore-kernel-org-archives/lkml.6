Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2638020-1517462067-2-7105688496132597179
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
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517462066; b=kpjNxlhQ+tykqpJGyF6Z1lfVH3lK5dc9MrXSUyIWsh0kgsP
    0f+aKdvg+oSzzoRTlU8AAFUJp5OEOmyheNoV1OmBfLULrF7v1JziWvtr2nlLooDH
    uwvM9C38Fj+BUC/lNHd6EIF+WzklGnIkBUrVugUYHP0n2+73LIN7EI3MG6tUf/iZ
    fvS5in42Z8qo4fbEAcMzEqbXkMQ332hp8raxFEfQFaBs/qddJEr66dBow0L+y16u
    aQJrnMmeu15ed+TIO56ViVDL6LK6ddlHUJ7AJeiIdEbowaYtJjnzMGfJHIQxPrlt
    D10FLNgOb+/9CzguJ4Ox+ATslIV1WYK4prA77iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517462066; bh=of5dU/MeqLqucIs2v7Zm1MtjiA
    rfALGOf86i5t98qio=; b=wgLmY60PsH8Q7T/PolEnO5kxrYZIpuQsFOMFTkIKb/
    46uDixiklLW/Zahp6MXBwQ1tg7kHnZDunTtftGDUUHvWkrB7K1R27x3suEiEqVzH
    Kt2g6QuzeSV+TWjGOOJhFnCgUeAKRzCS5ScU3H6ROggLmZ85IJA66MAYYGEXhgcA
    aDviVPAJyQXNvReNQJW3fr1A6psJEop9Rf3jhGfKaXyxuYhkt9aNIvCw8lebSNQF
    /zBwB7NhoZc/5ij3XIYkYyJ/BX5XgmmK/rnGf1GpL9G4QCmitTOuKUEWP7+itJxb
    yWDyxcS9KIY633x04/Azysfo8EOaXN5HoaNsX6v69GQQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751172AbeBAFOX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 00:14:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:58294 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750979AbeBAFOW (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Feb 2018 00:14:22 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,443,1511856000";
   d="scan'208";a="197784975"
Date: Thu, 1 Feb 2018 13:05:02 +0800
From: Wu Hao <hao.wu@intel.com>
To: Alan Tull <atull@kernel.org>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Subject: Re: [PATCH v3 02/21] fpga: mgr: add region_id to fpga_image_info
Message-ID: <20180201050502.GA10273@hao-dev>
References: <1511764948-20972-1-git-send-email-hao.wu@intel.com>
 <1511764948-20972-3-git-send-email-hao.wu@intel.com>
 <20171129061107.w62q5tk5dplq2zmr@us-aus-ras-130-164-29-6.amer.corp.natinst.com>
 <CANk1AXTbrD3w=VEzXqTRfebgTYSRNGANthwN_PLVz8WWtxb7CA@mail.gmail.com>
 <20171205033611.GB19730@hao-dev>
 <CANk1AXT=6yNsMs4jDhwYonJ0FoLQjbTSWEjsa8Sjw+qOLXVCtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXT=6yNsMs4jDhwYonJ0FoLQjbTSWEjsa8Sjw+qOLXVCtw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Jan 31, 2018 at 09:35:20AM -0600, Alan Tull wrote:
> On Mon, Dec 4, 2017 at 9:36 PM, Wu Hao <hao.wu@intel.com> wrote:
> > On Mon, Dec 04, 2017 at 02:26:14PM -0600, Alan Tull wrote:
> >> On Wed, Nov 29, 2017 at 12:11 AM, Moritz Fischer <mdf@kernel.org> wrote:
> >> > Hi Hao,
> >> >
> >> > On Mon, Nov 27, 2017 at 02:42:09PM +0800, Wu Hao wrote:
> >> >> This patch adds region_id to fpga_image_info data structure, it
> >> >> allows driver to pass region id information to fpga-mgr via
> >> >> fpga_image_info for fpga reconfiguration function.
> >> >>
> >> >> Signed-off-by: Wu Hao <hao.wu@intel.com>
> >> > Acked-by: Moritz Fischer <mdf@kernel.org>
> >>
> >> Acked-by: Alan Tull <atull@kernel.org>
> >
> > Hi Alan / Moritz
> >
> > Thanks for the review. :)
> 
> Just to be clear, when you post the next version, keep the Acks that
> have been added.

Sure, I will keep the Acks in the next version.

Thanks
Hao
