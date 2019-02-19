Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAA7C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7814720818
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfBSKfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:35:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:34856 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfBSKff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:35:35 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 02:35:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="123544961"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.132])
  by fmsmga007.fm.intel.com with ESMTP; 19 Feb 2019 02:35:31 -0800
Date:   Tue, 19 Feb 2019 12:35:32 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH -next] tpm: change the return type of
 calc_tpm2_event_size to size_t
Message-ID: <20190219103532.GA16707@linux.intel.com>
References: <20190219072618.23048-1-yuehaibing@huawei.com>
 <20190219085921.GA5609@linux.intel.com>
 <820d3cf7-03ab-5434-5306-292b41aed860@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <820d3cf7-03ab-5434-5306-292b41aed860@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 05:15:47PM +0800, YueHaibing wrote:
> On 2019/2/19 16:59, Jarkko Sakkinen wrote:
> > On Tue, Feb 19, 2019 at 03:26:18PM +0800, YueHaibing wrote:
> >> calc_tpm2_event_size return size of the event which type is
> >> size_t, If it is an invalid event, returns 0. And all the
> >> caller use a size_t variable to check the return value, so
> >> no need to convert to the return value type to int.
> >>
> >> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > 
> > I don't see this patch make any value.
> 
> calc_tpm2_event_size return size_t 'size' which derive from u32 'event_field->event_size',
> 
> convert it to int may result in truncation.

Two remarks:

- Your real name is formatted incorrectly. It should be like "Yue Haibig"
  as shown in [1].
- If there is no actual regression, this change is useless.

[1] https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html

/Jarkko
