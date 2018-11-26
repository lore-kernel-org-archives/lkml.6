Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7197C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3D620873
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 22:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="FmD6z9ea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3D620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbeK0Jd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 04:33:29 -0500
Received: from vern.gendns.com ([98.142.107.122]:52310 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbeK0Jd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 04:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=p9o5P6NpKsc0bIkU3lxV30Qxaxzz60I3PzF7g3Arzvo=; b=FmD6z9eaDpWbkw1lbLTO4PTR+r
        EvK7cjPJ10SeaGUHgDZVwB3zi4H8A+ycao7j3tmspa6wsYzKQu6AbxCghskaPRpPVTVj/yLqMef09
        AJeuVU+UW/AzKenm8Oq1H0J4dW/rHaEWo5bCa1iKm8jhwp0yfywFgVWPo+uSI4iT3E66TjTksyqL2
        QM5Fks3pK85RbWmKqR+wjzZLdSbWKRBQquQhjwtBrz7lQawLJgvI3CWY2nPBGubjxUQwKNuVLNWTR
        rm37YW+k3Pqwq0ag/zvXQlj2sNw0pqDHbATvQF8JdAcrY5eE/OU0AXcmVOAzasI1QmtcOswDzNLag
        Pb6IqRfw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:45592 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gRPUv-00042C-6M; Mon, 26 Nov 2018 17:36:57 -0500
Subject: Re: [PATCH 05/16] remoteproc/pru: Add pru-specific debugfs support
To:     Roger Quadros <rogerq@ti.com>, ohad@wizery.com,
        bjorn.andersson@linaro.org
Cc:     tony@atomide.com, robh+dt@kernel.org, bcousson@baylibre.com,
        ssantosh@kernel.org, s-anna@ti.com, nsekhar@ti.com,
        t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-6-git-send-email-rogerq@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <d0e227e3-39dc-dfc8-b94c-3d9d072f6562@lechnology.com>
Date:   Mon, 26 Nov 2018 16:37:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543218769-5507-6-git-send-email-rogerq@ti.com>
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
> The remoteproc core creates certain standard debugfs entries,
> that does not give a whole lot of useful information for the
> PRUs. The PRU remoteproc driver is enhanced to add additional
> debugfs entries for PRU. These will be auto-cleaned up when
> the parent rproc debug directory is removed.
> 
> The enhanced debugfs support adds two new entries: 'regs' and
> 'single_step'. The 'regs' dumps out the useful CTRL sub-module
> registers as well as each of the 32 GPREGs and CT_REGs registers.
> The GPREGs and CT_REGs though are printed only when the PRU is
> halted and accessible as per the IP design.
> 

If the driver used regmap to access the CTRL I/O memory, then
'regs' wouldn't be needed since regmap already does debugfs.

