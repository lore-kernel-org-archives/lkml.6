Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A838C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D6E218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbfAaJhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:37:34 -0500
Received: from mga02.intel.com ([134.134.136.20]:8097 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbfAaJhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:37:32 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 01:37:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,543,1539673200"; 
   d="scan'208";a="130003963"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by FMSMGA003.fm.intel.com with SMTP; 31 Jan 2019 01:37:28 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 31 Jan 2019 11:37:27 +0200
Date:   Thu, 31 Jan 2019 11:37:27 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        netdev@vger.kernel.org
Subject: Re: [PATCH 09/28] thunderbolt: Cache adapter specific capability
 offset into struct port
Message-ID: <20190131093727.GX7875@lahna.fi.intel.com>
References: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
 <20190129150143.12681-10-mika.westerberg@linux.intel.com>
 <20190131092309.5jfyvo7hgq2ui3ok@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131092309.5jfyvo7hgq2ui3ok@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 10:23:09AM +0100, Lukas Wunner wrote:
> On Tue, Jan 29, 2019 at 06:01:24PM +0300, Mika Westerberg wrote:
> > --- a/drivers/thunderbolt/tb.h
> > +++ b/drivers/thunderbolt/tb.h
> > @@ -124,6 +124,8 @@ struct tb_switch {
> >   * @remote: Remote port (%NULL if not connected)
> >   * @xdomain: Remote host (%NULL if not connected)
> >   * @cap_phy: Offset, zero if not found
> > + * @cap_adap: Offset of the adapter specific capability. Negative if not
> > + *	      present.
> 
> Hm, could cap_adap be made zero in the non-presence case for consistency
> with cap_phy?

Sure.
