Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E08C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C498720855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C498720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbeK0Aem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 19:34:42 -0500
Received: from mga09.intel.com ([134.134.136.24]:49212 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbeK0Aem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 19:34:42 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 05:40:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,282,1539673200"; 
   d="scan'208";a="111569369"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 26 Nov 2018 05:40:28 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 26 Nov 2018 15:40:26 +0200
Date:   Mon, 26 Nov 2018 15:40:26 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] of/property: Add of_fwnode_name()
Message-ID: <20181126134026.GA26964@kuha.fi.intel.com>
References: <20181126114752.69597-1-heikki.krogerus@linux.intel.com>
 <20181126114752.69597-4-heikki.krogerus@linux.intel.com>
 <20181126130532.GH10650@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126130532.GH10650@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 03:05:32PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 26, 2018 at 02:47:52PM +0300, Heikki Krogerus wrote:
> > This implements get_name fwnode op for DT.
> 
> > +static int of_fwnode_get_name(const struct fwnode_handle *fwnode, char *buf,
> > +			      size_t len)
> > +{
> > +	snprintf(buf, len, "%pOFn", to_of_node(fwnode));
> 
> Same concerns.

OK, I'll fix all of these.

thanks,

-- 
heikki
