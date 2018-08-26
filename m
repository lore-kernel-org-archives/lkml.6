Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1116C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 05:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5352147D
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 05:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B5352147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbeHZIsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 04:48:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:43725 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbeHZIsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 04:48:25 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Aug 2018 22:07:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,289,1531810800"; 
   d="scan'208";a="69162735"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga006.jf.intel.com with ESMTP; 25 Aug 2018 22:06:41 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 4E43630105D; Sat, 25 Aug 2018 22:06:41 -0700 (PDT)
Date:   Sat, 25 Aug 2018 22:06:41 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andi Kleen <andi@firstfloor.org>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        bernhard.kaindl@thalesgroup.com, greg@kroah.com
Subject: Re: [PATCH] x86/mm/pat: Fix L1TF stable backport for CPA
Message-ID: <20180826050641.GT12066@tassilo.jf.intel.com>
References: <20180825135015.33547-1-andi@firstfloor.org>
 <20180826044646.GA24782@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180826044646.GA24782@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Cc: stable@vger.kernel.org # 4.4 and 4.9
> 
> LGTM for v4.4.y but ... are you sure that this patch applies to v4.9.y ?
> Commit edc3b9129cec is 'native' in v4.9.y and has not been reverted there.

You're right. I thought it was needed for 4.9 too, but yes it has the CPA pfn
patch. So for 4.9 the patch is not needed and in fact incorrect.

The original report was for 4.4.

Greg can you please revert/remove it again for 4.9?

-Andi
