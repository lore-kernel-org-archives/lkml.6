Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82896C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E5821871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 15:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546614442;
	bh=7+vjsOS4NLP9skikPE0H3eAPsf4RRRWxUTqSXzNa4xg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=UhH2sb5yB3A0ZTjt5xbJoxnoSJNWV/CHkQ6k39oLdoJeqAWqMhDaufuOKAaiL+iE9
	 7B1PzgsLtt26//hHbjD/hPOuptqGQxD4xRA0VL3Yni1PBQif38Qid7RHXTIuWYgzwU
	 dzNgOyCs+diYeEa7JTDP8aS4t+JhNGrq0QLcwk88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfADPHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:07:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:36468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbfADPHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 10:07:21 -0500
Received: from [192.168.0.109] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9D7C2087F;
        Fri,  4 Jan 2019 15:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546614440;
        bh=7+vjsOS4NLP9skikPE0H3eAPsf4RRRWxUTqSXzNa4xg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=K3zpKRJ2j0+Y7CGkUXXkyDSiebVp76fbapcyQbghIREnkZo56G7S5GHphVKMiOxgu
         ra+aEGw6BTSWgbrVJc4Iz//wHZEGtClbFoYS/jpFe6S/BY6ewCq4QBKbfBrLFYnwR3
         j4CY4RHzoWsy4Y70HSG9UnS8LUObGeykGIO1zqwY=
Subject: Re: [PATCH v5 05/11] platform/x86: intel_pmc: Make PCI dependency
 explicit
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kupuswamy@linux.intel.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Cc:     linux-next <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190102181038.4418-1-okaya@kernel.org>
 <20190102181038.4418-6-okaya@kernel.org>
 <CAHp75VfGe=rdN0JeLoHnPM0XuVunH5RvAmMEqbxFPWA7BmkzEw@mail.gmail.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <3d6835d2-5064-630f-4e54-49a64bffc58b@kernel.org>
Date:   Fri, 4 Jan 2019 10:07:18 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAHp75VfGe=rdN0JeLoHnPM0XuVunH5RvAmMEqbxFPWA7BmkzEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/2019 9:20 AM, Andy Shevchenko wrote:
> Unfortunately, this is not how it should be fixed.
> 
> First of all, we (Heikki, Sathya, me —  all in Cc list) that this
> driver should be refactored and unified with intel_scu_ipc.
> Then, it has two drivers inside and PCI is just a glue for it which is
> optional. Thus, needs to be split accordingly.

OK. Two questions:

1. How should I change this now?
2. Can you change the Kconfig accordingly after you merge the two drivers?

I'm focused on the build failure at this moment.


