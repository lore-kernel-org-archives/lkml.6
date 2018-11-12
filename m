Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D08C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8687C224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8687C224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbeKMA73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 19:59:29 -0500
Received: from mga18.intel.com ([134.134.136.126]:33864 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbeKMA72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 19:59:28 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2018 07:05:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,495,1534834800"; 
   d="scan'208";a="107406741"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 12 Nov 2018 07:05:47 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 12 Nov 2018 17:05:46 +0200
Date:   Mon, 12 Nov 2018 17:05:46 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     andriy.shevchenko@linux.intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        mika.westerberg@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/4] of/property: Add of_fwnode_name()
Message-ID: <20181112150546.GC1677@kuha.fi.intel.com>
References: <20181108165156.60073-1-heikki.krogerus@linux.intel.com>
 <20181108165156.60073-4-heikki.krogerus@linux.intel.com>
 <CAL_Jsq+4momJb6EoXrAg2LRKzpXMFB30yhBigOiEJ16EjZ05pg@mail.gmail.com>
 <20181108192509.GW10650@smile.fi.intel.com>
 <CAL_JsqLMuiUc8FW=X_OAd5P_tcfPSTOox9Vh6faEwK+Z=S2mjw@mail.gmail.com>
 <20181109133442.GA28183@kuha.fi.intel.com>
 <CABGGiswFe92TLtU6YH3UsQJBbACbHu2w0rmc7FvwURqi_PU+7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABGGiswFe92TLtU6YH3UsQJBbACbHu2w0rmc7FvwURqi_PU+7w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 09, 2018 at 10:14:49AM -0600, Rob Herring wrote:
> > I would prefer that we had something like of_node_name_get() function
> > that of_fwnode_get_name() could simply call. I don't know how you want
> > that implemented, but I'm expecting you will implement something like
> > that in any case once you start removing that ->name member. I figured
> > that at that point we can update of_fwnode_get_name() as well.
> 
> I don't plan to implement anything like that. Here's what I'm planning:
> https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/log/?h=dt/testing
> 
> Which is eliminating the need to access .name by: using %pOFn (mostly
> in 4.20), using of_node_name_eq() wrapper, or using full_name instead.
> The last case generally is cases where the name is not important such
> as request_irq() or irq_chip.name.

OK. Thanks for the explanation.


thanks,

-- 
heikki
