Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9FCC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1724A2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 21:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1724A2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbeLLV0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:26:14 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:38981 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727131AbeLLV0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 16:26:13 -0500
Received: from [192.168.0.3] (ip5f5bd26f.dynamic.kabel-deutschland.de [95.91.210.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 36230201353427;
        Wed, 12 Dec 2018 22:26:11 +0100 (CET)
Subject: Re: [solved] *powersave* governor shown despite disabled in
 configuration
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <8786b234-eb4d-fb79-d6e0-e71f45ed3120@molgen.mpg.de>
 <20181211065152.t2anuhy6t4n2zjrd@isilmar-4.linta.de>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <f6bbee19-d5fd-4deb-03a7-488f40be5103@molgen.mpg.de>
Date:   Wed, 12 Dec 2018 22:26:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211065152.t2anuhy6t4n2zjrd@isilmar-4.linta.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Dominik,


Thank you for your quick response.


Am 11.12.18 um 07:51 schrieb Dominik Brodowski:
> On Mon, Dec 10, 2018 at 04:30:05PM +0100, Paul Menzel wrote:

>> With Linux 4.14.76, the scaling governor *powersave* is shown as
>> being available despite being disabled in the configuration.
> 
> Which cpufreq driver do you use? Presumably intel_pstate?

Yes, intel_pstate.

> That driver exposes internal policies / "governors" named 
> "performance" and "powersave", which are unrelated to
> CONFIG_CPU_FREQ_GOV_POWERSAVE.
Indeed, that confused me, and I didn’t read the documentation
carefully enough.

> They are not generic scaling governors, but their names are the same as the
> names of some of those governors.  Moreover, confusingly enough, they generally
> do not work in the same way as the generic governors they share the names with.
> For example, the ``powersave`` P-state selection algorithm provided by
> ``intel_pstate`` is not a counterpart of the generic ``powersave`` governor
> (roughly, it corresponds to the ``schedutil`` and ``ondemand`` governors).
> 
> There are two P-state selection algorithms provided by ``intel_pstate`` in the
> active mode: ``powersave`` and ``performance``.  The way they both operate
> depends on whether or not the hardware-managed P-states (HWP) feature has been
> enabled in the processor and possibly on the processor model.


Kind regards,

Paul


[1]: https://www.kernel.org/doc/html/latest/admin-guide/pm/intel_pstate.html
