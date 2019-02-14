Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D590C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F17B222DE
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502723AbfBNQ0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:26:14 -0500
Received: from mga04.intel.com ([192.55.52.120]:2216 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388556AbfBNQ0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:26:14 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 08:26:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,369,1544515200"; 
   d="scan'208";a="124496687"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga008.fm.intel.com with ESMTP; 14 Feb 2019 08:26:13 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 7EFBB301247; Thu, 14 Feb 2019 08:26:13 -0800 (PST)
Date:   Thu, 14 Feb 2019 08:26:13 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, peterz@infradead.org, kan.liang@intel.com,
        mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        jannh@google.com, arei.gonglei@huawei.com, jmattson@google.com
Subject: Re: [PATCH v5 07/12] perf/x86: no counter allocation support
Message-ID: <20190214162613.GK16922@tassilo.jf.intel.com>
References: <1550135174-5423-1-git-send-email-wei.w.wang@intel.com>
 <1550135174-5423-8-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550135174-5423-8-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 9de8780..ec97a70 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -372,7 +372,8 @@ struct perf_event_attr {
>  				context_switch :  1, /* context switch data */
>  				write_backward :  1, /* Write ring buffer from end to beginning */
>  				namespaces     :  1, /* include namespaces data */
> -				__reserved_1   : 35;
> +				no_counter     :  1, /* no counter allocation */

Not sure we really want to expose this in the user ABI. Perhaps make
it a feature of the in kernel API only?

-Andi
