Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8807BC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D40F25DCC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="za6QnfDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D40F25DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755012AbeFYQGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:06:51 -0400
Received: from vern.gendns.com ([206.190.152.46]:48062 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752203AbeFYQGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=W+pJgjASrX8B7PMWdBZ9pssXlzXJmLopArYz2cK2v1c=; b=za6QnfDbLXfdduV7Uhh8jR4TkL
        Ui2qrGicEECymD1qkFI5umlImxBZTBkqB1kgDgDN31zFqlQooIx+SMxtaoBRguNoeEgFJnpjDypIZ
        Vyc19TzCIRP5k3bK77Yq9ex3lWqsQ0nPURl9AKZMlQRX8zDCCZuf634rtUcJCPbJ3NOLBenM3yHBR
        HYnTz60NA2aj4x/V1ML+IgiEmpxfa9tADEEdtwnHKrpwLRsek3PXtegmhg5f+0h3zLMwZxrw+d9rW
        j19Js4C4Ft+dNj7O2OcE0rBrYXRZrVltS6Qp8LSxmPOBD30kgdFLvxk7jTTnuSXVg7x+G+xb+tnJ+
        6gMb/LjQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:54150 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fXU0u-001Bl4-6R; Mon, 25 Jun 2018 12:06:48 -0400
Subject: Re: [PATCH 1/9] clk: davinci: psc-dm365: use two lookup entries for
 the aemif clock
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180625152920.11549-1-brgl@bgdev.pl>
 <20180625152920.11549-2-brgl@bgdev.pl>
 <241fed6e-b414-feac-8e6c-39713c5e665e@lechnology.com>
 <CAMRc=MdTdoL9qsrMAxhCTaQM7HGrAPpTVjDuHQ81Q5O-QMNcYQ@mail.gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <c8d28664-e0fb-5a02-3c5b-b78684f87648@lechnology.com>
Date:   Mon, 25 Jun 2018 11:06:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAMRc=MdTdoL9qsrMAxhCTaQM7HGrAPpTVjDuHQ81Q5O-QMNcYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/2018 11:01 AM, Bartosz Golaszewski wrote:
> 2018-06-25 17:53 GMT+02:00 David Lechner <david@lechnology.com>:
>> On 06/25/2018 10:29 AM, Bartosz Golaszewski wrote:
>>>
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> We want to be able to get the clock both from the board file by its
>>> con_id and from the aemif driver by dev_id.
>>
>>
>> What about the other SoCs? Don't they need this change as well?
>>
> 
> So I double checked and turns out I missed one other board that's
> affected by this series and calls clk_get() from machine code:
> dm644x-evm.
> 
> I'll fix it in v2.

The ti-aemif platform driver also does clk_get(). Don't you need
lookups to make that work as well? For example, DA830 doesn't have
a clock lookup for aemif at all.

