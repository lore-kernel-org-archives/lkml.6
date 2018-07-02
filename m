Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0349C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7451025C20
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7451025C20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965405AbeGBKPW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:15:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:6699 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965121AbeGBKPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:15:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 03:15:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,298,1526367600"; 
   d="scan'208";a="63396972"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga002.fm.intel.com with ESMTP; 02 Jul 2018 03:15:10 -0700
Message-ID: <cc1b6c9efa197d7dcf3ebec69eebdb4c3ca90eef.camel@linux.intel.com>
Subject: Re: [PATCH] fbcon: introduce for_each_registered_fb() helper
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        Yisheng Xie <ysxie@foxmail.com>, b.zolnierkie@samsung.com,
        keescook@chromium.org, j.w.r.degoede@gmail.com,
        david@lechnology.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 02 Jul 2018 13:15:09 +0300
In-Reply-To: <00590669b886b4cc54548e6101912c3d4d1752f2.camel@petrovitsch.priv.at>
References: <1530202809-24105-1-git-send-email-ysxie@foxmail.com>
         <00590669b886b4cc54548e6101912c3d4d1752f2.camel@petrovitsch.priv.at>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 09:36 +0200, Bernd Petrovitsch wrote:


> > +#define for_each_registered_fb(i)		\
> > +	for (i = 0; i < FB_MAX; i++)		\
> > +		if (registered_fb[i])
> > +
> 
> That leaves the possibility of a dangling-else.
> ----  snip  ----
> #define for_each_registered_fb(i)		\
> 	for (i = 0; i < FB_MAX; i++)		\
> 		if (!registered_fb[i])		\
> 			continue;		\
> 		else
> ----  snip  ----
> avoids that.

Yes, you not alone :-)

AFAIU there is a v2 which fixes that, though Daniel pointed out that DRM
has a specific macro to make life easier.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
