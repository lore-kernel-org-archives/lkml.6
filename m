Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5619EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FCC2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390454AbeLUUjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:39:13 -0500
Received: from mga18.intel.com ([134.134.136.126]:13640 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730319AbeLUUjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 15:39:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2018 12:39:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,382,1539673200"; 
   d="scan'208";a="261396455"
Received: from kmorgan8-mobl3.amr.corp.intel.com (HELO [10.252.128.152]) ([10.252.128.152])
  by orsmga004.jf.intel.com with ESMTP; 21 Dec 2018 12:39:11 -0800
Subject: Re: [alsa-devel] linux-next: Tree for Dec 21
 (SND_HDA_INTEL_DSP_DETECTION)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181221193244.3a6ed685@canb.auug.org.au>
 <4d04710b-d661-fea7-2542-8e9c46f59173@infradead.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ff6289e5-64c8-5787-0556-4e339205b5f6@linux.intel.com>
Date:   Fri, 21 Dec 2018 14:39:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <4d04710b-d661-fea7-2542-8e9c46f59173@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/21/18 12:02 PM, Randy Dunlap wrote:
> On 12/21/18 12:32 AM, Stephen Rothwell wrote:
>> Hi all,
>>
>> News: there will be no linux-next release until Jan 2.  Have a good break.
>>
>> Changes since 20181220:
>>
> on x86_64:
>
> A new group of Kconfig "select"s is causing kconfig warnings:
>
> WARNING: unmet direct dependencies detected for SND_HDA_INTEL_DSP_DETECTION_CFL
>    Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_HDA [=n] && SND_HDA_INTEL [=n]
>    Selected by [y]:
>    - SND_SOC_INTEL_SKYLAKE_COMMON [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_INTEL_SST_TOPLEVEL [=y] && SND_SOC_INTEL_SKYLAKE_FAMILY [=y] && SND_SOC_INTEL_CFL [=y]

Ack, thanks for the report. This shouldn't have any functional impact 
but we can easily remove the warnings. will send a patch shortly.

-Pierre

