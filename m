Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Uk26IE4yGVsaRAAAmS7hNA
	; Thu, 07 Jun 2018 13:26:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 16C29608B8; Thu,  7 Jun 2018 13:26:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7BE84606DD;
	Thu,  7 Jun 2018 13:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7BE84606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932717AbeFGN0s (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:26:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:60953 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932503AbeFGN0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:26:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 06:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="235487019"
Received: from um.fi.intel.com (HELO um) ([10.237.72.212])
  by fmsmga006.fm.intel.com with ESMTP; 07 Jun 2018 06:26:41 -0700
Received: from ash by um with local (Exim 4.91)
        (envelope-from <alexander.shishkin@linux.intel.com>)
        id 1fQuw2-00045O-RR; Thu, 07 Jun 2018 16:26:38 +0300
Date: Thu, 7 Jun 2018 16:26:38 +0300
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
Subject: Re: [PATCH v9 06/12] KVM: x86: Add Intel Processor Trace
 virtualization mode
Message-ID: <20180607132638.snnnt5ecwisfgkmy@um.fi.intel.com>
References: <1526964735-16566-1-git-send-email-luwei.kang@intel.com>
 <1526964735-16566-7-git-send-email-luwei.kang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526964735-16566-7-git-send-email-luwei.kang@intel.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 12:52:09PM +0800, Luwei Kang wrote:
> From: Chao Peng <chao.p.peng@linux.intel.com>
> 
> Intel PT virtualization can be work in one of 2 possible modes:
> a. system-wide: trace both host and guest and output to host buffer;
> b. host-guest: trace host/guest simultaneous and output to their
>    respective buffer.

I think we discussed this before. That's not the choice that the user
needs to make. The only choice that I see is what happens if the guest
wants to use PT while it's already in use by the host. Otherwise, each
of them gets to use PT as they would.

Regards,
--
Alex
