Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92404C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 22:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59313218A1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 22:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545603810;
	bh=Bw+4XqmcZI34RSHvG937vqulowUsXjoOL6cXrY/mlcc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=1jjsakmbI8e2Yn8GmF6sk3P2Fh+vXMe2sf6ka0KnALbEO4Qd4zHbCb9+0/KOltP1A
	 8VUWhcoWCpTC9EYlagQaTKPXD0w0XBgdp75dBUSgoeEGnvEuwWa3xqpG5aVm5XRuuA
	 eLryufWhfEkWmPohF5KVQpHUNcbg8C1jvV+m3jTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbeLWWX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 17:23:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbeLWWX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 17:23:28 -0500
Received: from [192.168.1.25] (unknown [195.142.208.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FB78217FA;
        Sun, 23 Dec 2018 22:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545603808;
        bh=Bw+4XqmcZI34RSHvG937vqulowUsXjoOL6cXrY/mlcc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=on7Votx8UjM24Y5kGJ5Qo6sktVgiFoWeRwWxNK3xrwV+z0BgCzV5oi+AGNYeAfQcq
         k1JIyTuoyJy/a4QNotzROphmP/RML2MYL4hNW6c4huS5JPeGYnrh8RJMfddCTw5k6F
         LOEdeMkjO9lYKMGFoxkWDgnSd9B0BhfTtkKSEApo=
Subject: Re: [PATCH v2 07/11] drivers: thermal: Hide PCI driver when
 CONFIG_PCI is unset
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        sumeet.r.pawnikar@intel.com, Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181222090720.19234-1-okaya@kernel.org>
 <20181222090720.19234-8-okaya@kernel.org>
 <CAJZ5v0j6Z42pk16fFGpQz+xvU-gVnarkoafcWJuQPWY=X532YQ@mail.gmail.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <e695ac50-0e7c-6cc4-5f63-42c842787fd7@kernel.org>
Date:   Sun, 23 Dec 2018 23:23:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0j6Z42pk16fFGpQz+xvU-gVnarkoafcWJuQPWY=X532YQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/2018 10:48 PM, Rafael J. Wysocki wrote:
> Can you actually test this driver with your new #ifdef stuff and with
> CONFIG_PCI unset?
> 
> Have you really test it in that configuration?
> 

No, I haven't. Code was compile tested only.

> If not, you shouldn't even post this patch.
> 

I was hoping the maintainer to chime in. By looking at the code, it was
registering a platform and PCI driver. I assumed that it was generic code
that can be used with and without PCI.

> Please make the driver depend on PCI.

I can do that.
