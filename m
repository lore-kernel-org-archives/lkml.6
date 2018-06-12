Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2C4C8C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D559C2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="s9XQjaxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D559C2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934827AbeFLWMW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:12:22 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:58359 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933727AbeFLWMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JcfBnSgjyYlg7313iGYMt/XMTJkMS0molSMZ4Z10vgc=; b=s9XQjaxovX53ryq3DCTn9EaNb/
        04wWgHTfWVCYHg10AcqgQ/hVMY3A8pEJW9r+B0nFpS8hTT4r5iHDnIX3R2X8msSkkRMjvx45hVaKU
        aC93Oy6JoIHsCAwdtrmj+ZlnnLrAUhVr5Oam962DPprZ6TwSn8UzLrPllIJb88sWVDdVSafLABnMU
        Ygp81URM9+gPdc9bxPamU0rGMJWHvTstUN85lbSQAdS3JhsNRYAYLFM715GIGkjjAWqr2dOlfIsJg
        L+gQNE2YaDzKht5OcngsjUyYFdLP5A8touOUODFO2SsV1OOGdn97OA0nZlqM1YovjoW9CeWvPp4gZ
        Y8qL5pCg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:48156 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fSrWV-005ViV-Pe; Tue, 12 Jun 2018 22:12:20 +0000
Date:   Tue, 12 Jun 2018 15:12:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Menzel <pmenzel+linux-hwmon@molgen.mpg.de>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: nct6775: UBSAN: shift exponent 32 is too large for 32-bit type
 'long unsigned int'
Message-ID: <20180612221218.GA15406@roeck-us.net>
References: <d02001e2-fa4c-6a2e-cc50-a8d9a8146d57@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d02001e2-fa4c-6a2e-cc50-a8d9a8146d57@molgen.mpg.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, Jun 12, 2018 at 11:50:45PM +0200, Paul Menzel wrote:
> Dear Guenther, dear Jean,
> 
> 
> Building Linux with the undefined behavior sanitizer (UBSAN), loading the
> module *nct6775* on the ASRock E350M1 shows the error below.
> 
> ```
> [   28.322775] UBSAN: Undefined behaviour in drivers/hwmon/nct6775.c:4179:27
> [   28.322833] shift exponent 32 is too large for 32-bit type 'long unsigned
> int'
> ```
> 
> I believe this was introduced by commit cc66b3038254 (hwmon: (nct6775)
> Rework temperature source and label handling), but the same issue was
> already present before.
> 

I don't think so. The code used to be
	for (i = 0; i < data->temp_label_num - 1; i++) {
Notice the "- 1". So it should be
	for (i = 0; i < 31; i++) {

In practice it doesn't matter because "data->temp_mask & BIT(31 + 1)"
will always be false, causing the last loop iteration to abort, but
it is nevertheless wrong.

Thanks a lot for the report. I'll prepare a patch.

Guenter

> ```
> -       for (i = 0; i < data->temp_label_num - 1; i++) {
> +       for (i = 0; i < 32; i++) {
> +               if (!(data->temp_mask & BIT(i + 1)))
> +                       continue;
> ```
> 
> `include/linux/bitops.h` has the macros below.
> 
> ```
> #define BIT(nr)                 (1UL << (nr))
> #define BIT_ULL(nr)             (1ULL << (nr))
> ```
> 
> Maybe `BIT_ULL` should be used, but I do not know, if that’d would work with
> `data->temp_mask`, which has type `u32`.
> 
> 
> Kind regards,
> 
> Paul
