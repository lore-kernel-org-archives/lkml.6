Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC87DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE60C20817
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE60C20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeKGWEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:04:43 -0500
Received: from mga12.intel.com ([192.55.52.136]:37968 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbeKGWEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 17:04:43 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 04:34:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,475,1534834800"; 
   d="scan'208";a="106039719"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 07 Nov 2018 04:34:29 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 07 Nov 2018 14:34:28 +0200
Date:   Wed, 7 Nov 2018 14:34:28 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 6/6] device property: Remove struct property_set
Message-ID: <20181107123428.GG13048@kuha.fi.intel.com>
References: <20181105145928.46819-1-heikki.krogerus@linux.intel.com>
 <20181105145928.46819-7-heikki.krogerus@linux.intel.com>
 <20181106144641.GA10650@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106144641.GA10650@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 04:46:41PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 05, 2018 at 05:59:28PM +0300, Heikki Krogerus wrote:
> > Replacing struct property_set with the software nodes that
> > were just introduced.
> > 
> > The API and functionality for adding properties to devices
> > remains the same, however, the goal is to convert the
> > drivers to use the API for software nodes when the device
> > has no real firmware node, and use the old API only when
> > "extra" build-in properties are needed.
> 
> It might be slightly easier to review if you preserve the ordering of
> functions, i.e. device_add_properties() and device_remove_properties().

True, that change does not belong to this series.

thanks,

-- 
heikki
