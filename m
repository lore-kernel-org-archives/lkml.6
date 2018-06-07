Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IhCkNIY/GVu7WwAAmS7hNA
	; Thu, 07 Jun 2018 14:22:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 58730608CE; Thu,  7 Jun 2018 14:22:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B5E3D608CA;
	Thu,  7 Jun 2018 14:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B5E3D608CA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933641AbeFGOWP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:22:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:16055 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933625AbeFGOWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:22:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 07:22:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="235227181"
Received: from um.fi.intel.com (HELO um) ([10.237.72.212])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jun 2018 07:22:04 -0700
Received: from ash by um with local (Exim 4.91)
        (envelope-from <alexander.shishkin@linux.intel.com>)
        id 1fQvnd-0005Yf-Mp; Thu, 07 Jun 2018 17:22:01 +0300
Date: Thu, 7 Jun 2018 17:22:01 +0300
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Luwei Kang <luwei.kang@intel.com>
Cc: kvm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, chao.p.peng@linux.intel.com,
        thomas.lendacky@amd.com, bp@suse.de, Kan.liang@intel.com,
        Janakarajan.Natarajan@amd.com, dwmw@amazon.co.uk,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, mathieu.poirier@linaro.org,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, david@redhat.com,
        bsd@redhat.com, yu.c.zhang@linux.intel.com, joro@8bytes.org
Subject: Re: [PATCH v9 11/12] KVM: x86: Set intercept for Intel PT MSRs
 read/write
Message-ID: <20180607142201.btdz57ufzlogf25r@um.fi.intel.com>
References: <1526964735-16566-1-git-send-email-luwei.kang@intel.com>
 <1526964735-16566-12-git-send-email-luwei.kang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526964735-16566-12-git-send-email-luwei.kang@intel.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 12:52:14PM +0800, Luwei Kang wrote:
> From: Chao Peng <chao.p.peng@linux.intel.com>
> 
> Disable intercept Intel PT MSRs only when Intel PT is
> enabled in guest. But MSR_IA32_RTIT_CTL will alway be
> intercept.

"I'd like to offer some suggestions as to how to make the commit message
friendlier for reviewing.

Generally, for every patch, we want to explain the following: what we want,
why we want it and how we want to go about getting it. We also would prefer
to do it in english rather than in C, because for the latter we can just
look at the code." [1]

I apologize for quoting myself or if I'm stating the obvious, but it looks
appropriate here.

[1] https://marc.info/?l=linux-kernel&m=152233031020263

Regards,
--
Alex
