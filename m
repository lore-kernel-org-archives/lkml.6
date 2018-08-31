Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D524C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A8C2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A8C2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbeHaTtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:49:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:41399 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727687AbeHaTtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:49:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2018 08:41:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,312,1531810800"; 
   d="scan'208";a="87933045"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga002.jf.intel.com with ESMTP; 31 Aug 2018 08:41:28 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 6AE73301BFA; Fri, 31 Aug 2018 08:41:28 -0700 (PDT)
From:   Andi Kleen <ak@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] x86/cpu: Introduce INTEL_CPU_FAM*_NODATA() helper macros
References: <20180831091018.17543-1-andriy.shevchenko@linux.intel.com>
Date:   Fri, 31 Aug 2018 08:41:28 -0700
In-Reply-To: <20180831091018.17543-1-andriy.shevchenko@linux.intel.com> (Andy
        Shevchenko's message of "Fri, 31 Aug 2018 12:10:15 +0300")
Message-ID: <87mut2pmqf.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> +
> +#define INTEL_CPU_FAM_ANY_NODATA(_family, _model)		\
> +	INTEL_CPU_FAM_ANY(_family, _model, NULL)
> +
> +#define INTEL_CPU_FAM6_NODATA(_model)				\
> +	INTEL_CPU_FAM_ANY_NODATA(6, INTEL_FAM6_##_model)

_NODATA is actually longer than passing NULL ?

Seems unnecessary

-Andi
