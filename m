Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95092C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573282082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="nVJ1o/DX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573282082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbeK0IYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:24:49 -0500
Received: from vern.gendns.com ([98.142.107.122]:45850 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbeK0IYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RvR6pAArK8NvftxKodtKo1/o51yA7eQ0VTz739e6vKA=; b=nVJ1o/DXJDccdVqqD1iIdXfdOh
        AdW8wZIad9PUc/pFC74D31KUgb9AM2cCF9IUrSZd9S5YUJHvOr4tJLT2XJ4dTDSYak2XoIZ9qUz9X
        3vSbuLzPsoefJOm3eEFh02bVyeRr0SkUrpGpWvK8xS1lSJT9n7JH/nFruVhRsC1J2CJUgmjSXCSJQ
        EmjJ0nEqaLZee9Ru8sXwLHK+99Atf9ym4DNxbuY7d6eAAlBjRmeiWYcopeqVhEOGP7JAspqtDXEHg
        EPqyBhoQkIbMpVLOB9dVppRkF7sywp3feY72wYVzQFzBVM0moPuM6mPXrEZ5RDvoB9Jm3QtB+Jrke
        rDtmqYVw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:44928 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gROQd-0003mz-N2; Mon, 26 Nov 2018 16:28:27 -0500
Subject: Re: [PATCH 01/16] remoteproc: Extend rproc_da_to_va() API with a
 flags parameter
To:     Roger Quadros <rogerq@ti.com>, ohad@wizery.com,
        bjorn.andersson@linaro.org
Cc:     tony@atomide.com, robh+dt@kernel.org, bcousson@baylibre.com,
        ssantosh@kernel.org, s-anna@ti.com, nsekhar@ti.com,
        t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-2-git-send-email-rogerq@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <d93c4c96-e0b9-59cd-6098-92684bc2360b@lechnology.com>
Date:   Mon, 26 Nov 2018 15:29:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543218769-5507-2-git-send-email-rogerq@ti.com>
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

On 11/26/18 1:52 AM, Roger Quadros wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> The rproc_da_to_va() API is currently used to perform any device
> to kernel address translations to meet the different needs of the
> remoteproc core/platform drivers (eg: loading). The function also
> invokes the da_to_va ops, if present, to allow the remoteproc
> platform drivers to provide address translation. However, not all
> platform implementations have linear address spaces, and may need
> an additional parameter to be able to perform proper translations.
> 
> The rproc_da_to_va() API and the rproc .da_to_va ops have therefore
> been expanded to take in an additional flags field enabling some
> remoteproc implementations (like the TI PRUSS remoteproc driver)
> to use these flags. Also, define some semantics for this flags
> argument as this can vary from one implementation to another. A
> new flags type is encoded into the upper 16 bits along side the
> actual value in the lower 16-bits for the flags argument, to
> allow different individual implementations to have better
> flexibility in interpreting the flags as per their needs.

This seems like an overly complex solution for a rather simple
problem. Instead of passing all sorts of flags, could we just add
a parameter named "page" to da_to_va() that indicates the memory
page of the address in the remote processor?

Or perhaps there is some other use for all of these flags that I
am not aware of?
