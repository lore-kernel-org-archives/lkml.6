Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D86C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B539222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438560AbfBNMxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:53:53 -0500
Received: from mga17.intel.com ([192.55.52.151]:54566 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388534AbfBNMxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 07:53:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 04:53:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,368,1544515200"; 
   d="scan'208";a="275034467"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga004.jf.intel.com with ESMTP; 14 Feb 2019 04:53:48 -0800
Received: from andy by smile with local (Exim 4.92-RC6)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1guGWR-0003K3-3S; Thu, 14 Feb 2019 14:53:47 +0200
Date:   Thu, 14 Feb 2019 14:53:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Xiang Xiao <xiaoxiang781216@gmail.com>
Cc:     rdunlap@infradead.org, gregkh@linuxfoundation.org,
        alexander.shishkin@linux.intel.com, ohad@wizery.com,
        bjorn.andersson@linaro.org, wendy.liang@xilinx.com,
        arnaud.pouliquen@st.com, kumar.gala@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: Re: [PATCH V2 1/2] lib/string: add memrchr function
Message-ID: <20190214125347.GU9224@smile.fi.intel.com>
References: <1550124158-1111-1-git-send-email-xiaoxiang@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550124158-1111-1-git-send-email-xiaoxiang@xiaomi.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 02:02:37PM +0800, Xiang Xiao wrote:
> Here is the detailed description for memrchr:
> 
> void *memrchr(const void *s, int c, size_t n);
> 
> The memrchr() function is like the memchr() function, except
> that it searches backward from the end of the n bytes pointed
> to by s instead of forward from the beginning.
> 
> The memrchr() functions return a pointer to the matching byte
> or NULL if the character does not occur in the given memory
> area.

> +void *memrchr(const void *s, int c, size_t n)
> +{
> +	const unsigned char *p = s + n;
> +
> +	while (n-- != 0) {

Simple:

	while (n--) {

> +		if ((unsigned char)c == *--p)
> +			return (void *)p;
> +	}
> +	return NULL;
> +}

-- 
With Best Regards,
Andy Shevchenko


