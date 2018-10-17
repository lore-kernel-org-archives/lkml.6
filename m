Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F60ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAEB214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAAEB214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeJQWEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:04:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:57392 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbeJQWEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:04:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 07:08:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,392,1534834800"; 
   d="scan'208";a="100009558"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga001.fm.intel.com with ESMTP; 17 Oct 2018 07:08:46 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 0E7F3300FA1; Wed, 17 Oct 2018 07:08:46 -0700 (PDT)
Date:   Wed, 17 Oct 2018 07:08:46 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     vbabka@suse.cz, mhocko@suse.com, hpa@zytor.com,
        torvalds@linux-foundation.org, dave.hansen@intel.com,
        kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
Subject: Re: l1tf: Kernel suggests I throw away third of my memory. I'd
 rather not
Message-ID: <20181017140846.GB23838@tassilo.jf.intel.com>
References: <20181017105610.GA4260@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017105610.GA4260@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 12:56:10PM +0200, Pavel Machek wrote:
> Hi!
> 
> 6a012288 suggests I throw away 1GB on RAM. On 3GB system.. that is not
> going to be pleasant.

Just rebuild your kernel with PAE? I assume your CPU supports it.

This will also give you NX, which if you're really worried
about security is far more important than L1TF.

If you don't worry about security just ignore.

-Andi
