Return-Path: <kernel-hardening-return-12957-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+cETZ5GwykV5bQUvXe5kR7Rz7g9FhV/jraYcBqc/DyhRo8PxVAduWpkokNGFAuTlvSad7w
ARC-Seal: i=1; a=rsa-sha256; t=1523374742; cv=none;
        d=google.com; s=arc-20160816;
        b=vKdYivV3wpE38hzN9gxLp8EKr7Zgs58ZJxwOpwJKPhRBEyG8n79aDWJNhKbBgYuYsI
         sqTdZa+91MNblp/dwx9e1zYNtu0OUNVYeD+Gk70k7+fl2h2F8yg1jvyvgH4DQCNet5Dd
         6iOu6WqiHRpp7IlKkvfOi9DCs6UEUViw6A7foq9b5JKC22qh7miGwn0JCz9BSVZfN0tS
         gqbudt1WXK2RahYrO9jpvfUqO4+7FdAhM4xr+buorRGnw9y/He14sMne86eKU3nDdoYb
         IJXhxvA5zUP7nykViGVmgXCEP5r/FX86jNsjXrHeWpFzTr1XnfIHgWOouYafFeeCGiSq
         yGKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=73ZT9MgX2oN9e8EMvDg7YjFk/uA2pDzUy4GMWy+bUSg=;
        b=mCXTEb99qFiquD+xpfC/hBuB0nZU8r5j0JDQuM/41fog+p8gjwCITI29PDfVUCuPLj
         1vnuy114qjnmXKfCzBDuJMgBqk64Ahv2a1IW2cy1bC6vK7BC8svClNIXjBFPv4AKBLcG
         4wiABzt5sjSeffDxVA7wf3HdLtEkoEmYglTpC8et7DvaJIqIwX/Xp6jjzLILASVxt8nZ
         0cxEdqEfWqSbScCy2W5VNkTMmvJczBORHR+fHSaPLsAdXgCiaqrE3Qs10/315IW30SmW
         geVIZP0fROjWGMBcUi5X0aDfdx9YR5y2WbBUeATbXlZzyrQcUJ+Bc6XnnH/AKOmPp5hw
         RTMw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12957-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12957-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12957-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12957-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,432,1517904000";
   d="scan'208";a="45753809"
Date: Tue, 10 Apr 2018 21:08:55 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Laura Abbott <labbott@redhat.com>
Cc: Sinan Kaya <okaya@codeaurora.org>,
	Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] dmaengine: dmatest: Remove use of VLAs
Message-ID: <20180410153854.GT6014@localhost>
References: <20180409210603.3575-1-labbott@redhat.com>
 <4491bde2-cf38-5103-0634-1986ecd32a7c@codeaurora.org>
 <9bdd8bb4-b6d9-e170-b585-b2dc3b8f0d67@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bdd8bb4-b6d9-e170-b585-b2dc3b8f0d67@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597304199213101990?=
X-GMAIL-MSGID: =?utf-8?q?1597374194410728929?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 04:14:20PM -0700, Laura Abbott wrote:
> On 04/09/2018 03:48 PM, Sinan Kaya wrote:
> >On 4/9/2018 5:06 PM, Laura Abbott wrote:
> >>+			/* dst_cnt can't be more than u8 */
> >>+			dma_addr_t dma_pq[255];
> >
> >This is 2k stack space on 64 bit architectures. Isn't that a lot?
> >
> 
> Depends on your definition of 'a lot'. My assumption was that
> since this was a test module there would be some willingness
> to be a bit more generous. The problem is the array size is
> based off of the parameters passed in, although oddly enough
> it's based off of the minimum of two variables. If you have
> a suggestion for a tighter bound we can use that. Another
> option is to just switch to allocating the array with kmalloc.
> That might be reasonable here since there's other setup
> that happens before the test starts.

Being a test module I don't think I would have too many qualms with current
approach :) said that kmalloc approach seems reasonable too..

Thanks
-- 
~Vinod
