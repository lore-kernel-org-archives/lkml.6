Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9CBC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905CE2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfAWOLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:11:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:20119 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbfAWOLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:11:10 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2019 06:11:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,511,1539673200"; 
   d="scan'208";a="109126992"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 23 Jan 2019 06:11:07 -0800
Received: from andy by smile with local (Exim 4.92-RC4)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gmJFC-0006Ha-Sw; Wed, 23 Jan 2019 16:11:06 +0200
Date:   Wed, 23 Jan 2019 16:11:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Guan Yung Tseng <guan.yung.tseng@ni.com>,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 8250_pci.c: Update NI specific devices class to multi
 serial
Message-ID: <20190123141106.GG9224@smile.fi.intel.com>
References: <1547475005-23435-1-git-send-email-guan.yung.tseng@ni.com>
 <20190122115508.GB22960@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122115508.GB22960@kuha.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 01:55:08PM +0200, Heikki Krogerus wrote:
> On Mon, Jan 14, 2019 at 10:10:05PM +0800, Guan Yung Tseng wrote:
> > Modified NI devices class to PCI_CLASS_COMMUNICATION_MULTISERIAL.
> > The reason of doing this is because all NI multi port serial cards
> > use PCI_CLASS_COMMUNICATION_OTHER class and thus fail the
> > serial_pci_is_class_communication test added in the commit 7d8905d06405
> > ("serial: 8250_pci: Enable device after we check black list").
> 
> OK, so commit 7d8905d06405 ("serial: 8250_pci: Enable device after we
> check black list") has created a regression. If the device does not
> use PCI_CLASS_COMMUNICATION*SERIAL class, probe will fail, and I
> don't think that is how the driver should function.
> 
> If the device id is listed in serial_pci_tbl, we need to probe the
> device, regardless of the class id.

I need to check what should be a better fix.

> This is only working around the regression that 7d8905d064058 created,
> and only with your UART. There may be others.
> 
> We need to fix the regression, not work around it. How about something
> like the attached diff?

-- 
With Best Regards,
Andy Shevchenko


