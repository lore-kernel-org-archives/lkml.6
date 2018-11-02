Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAA2C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 07:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5B02081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 07:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5B02081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbeKBQqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 12:46:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:58210 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbeKBQqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 12:46:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AD9C8ADF4;
        Fri,  2 Nov 2018 07:40:05 +0000 (UTC)
Subject: Re: [PATCH 0/2] i8253: Fix PIT shutdown quirk on Hyper-V
To:     Michael Kelley <mikelley@microsoft.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "akataria@vmware.com" <akataria@vmware.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        KY Srinivasan <kys@microsoft.com>
References: <1541093374-10496-1-git-send-email-mikelley@microsoft.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <11f82d95-539c-b680-183b-b6c5c60468a8@suse.com>
Date:   Fri, 2 Nov 2018 08:40:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541093374-10496-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2018 18:30, Michael Kelley wrote:
> pit_shutdown() doesn't work on Hyper-V because of a quirk in the
> PIT emulation. This problem exists in all versions of Hyper-V and
> had not been noticed previously. When the counter register is set
> to zero, the emulated PIT continues to interrupt @18.2 HZ.
> 
> So add a test for running on Hyper-V, and use that test to skip
> setting the counter register when running on Hyper-V.
> 
> This patch replaces a previously proposed patch with a different
> approach. This new approach follows comments from Thomas Gleixner.

Did you consider using a static_key instead? You could set it in
ms_hyperv_init_platform(). This would enable you to support future
Hyper-V versions which don't require avoiding to set the count to zero.


Juergen

