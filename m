Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B027AC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771F820881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771F820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbeJPWn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:43:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:55360 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeJPWnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:43:55 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2018 07:53:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,388,1534834800"; 
   d="scan'208";a="99675388"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 16 Oct 2018 07:53:04 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 16 Oct 2018 17:53:03 +0300
Date:   Tue, 16 Oct 2018 17:53:03 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [RFC PATCH 3/5] drivers: base: Introducing software nodes to the
 firmware node framework
Message-ID: <20181016145303.GH24771@kuha.fi.intel.com>
References: <20181012113934.29942-1-heikki.krogerus@linux.intel.com>
 <20181012113934.29942-4-heikki.krogerus@linux.intel.com>
 <20181016125743.GX15943@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016125743.GX15943@smile.fi.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 03:57:43PM +0300, Andy Shevchenko wrote:
> > +static int property_entry_read_string_array(const struct property_entry *props,
> > +					    const char *propname,
> > +					    const char **strings, size_t nval)
> > +{
> > +	const struct property_entry *prop;
> > +	const void *pointer;
> > +	size_t array_len, length;
> > +
> > +	/* Find out the array length. */
> > +	prop = property_entry_get(props, propname);
> > +	if (!prop)
> > +		return -EINVAL;
> > +
> 
> > +	if (!prop->is_array)
> > +		/* The array length for a non-array string property is 1. */
> > +		array_len = 1;
> > +	else
> > +		/* Find the length of an array. */
> > +		array_len = property_entry_count_elems_of_size(props, propname,
> > +							  sizeof(const char *));
> 
> I understand where it comes from, but here we may use positive condition.

OK.

> > +#define NODE_NAME_MAXSIZE	11
> 
> sizeof(int) = 4 (32 bits), so, 32 * 3 / 10 ~= 10. On top are "node" and '\0'.
> Thus, I would rather put 16 here. Or limit the maximum for ida_simple_get().

Let's make it 16.


thanks,

-- 
heikki
