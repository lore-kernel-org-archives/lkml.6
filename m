Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E16EC6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 16:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2AEA20862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 16:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="flS0zlNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2AEA20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbeG1S0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 14:26:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58950 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729455AbeG1S0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 14:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=70zN1QtxhXPUEx/YJ6xNeKHjE0/0neGv2pYRMSgXwEw=; b=flS0zlNgy6Y9fne5cNCW4RFk82
        JGygpk/cYpOdxmpwqECANSKoheK3vkEThyLSCmGOL7CcT3tuPS8eUwN51/svZxUzekwjgNxRpSjnE
        mIUMwB0C7w+Xb9QR03kWPQJARFha3FOrVI+sgQ2iJNOkVJtCt/iJGAog/to4zAmvous9YjcHhR//+
        Qq97wzOdEm3g0SlpHEbEShM9v8JqvfM4jheIPDGyaBE0Gcd0WRrxj9TFheoODKqeWwl2HWe9UNKE4
        dQrXR1j0oBLBo1yuIWhAquNiJk2i7XVG+gEzKLaPT2ba+/oy0OdNpFtclhSyRYwWPV0hzdqdif1QV
        BeXsp0Qg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fjSZ1-0000FM-35; Sat, 28 Jul 2018 16:59:31 +0000
Subject: Re: Linux 4.17.11
To:     "rwarsow@gmx.de" <rwarsow@gmx.de>, linux-kernel@vger.kernel.org
References: <3a976c32-555b-ab68-3e2d-d5fbe7743d58@gmx.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1f5cc630-9390-7392-f2dc-fb9d84937179@infradead.org>
Date:   Sat, 28 Jul 2018 09:59:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3a976c32-555b-ab68-3e2d-d5fbe7743d58@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/28/2018 09:50 AM, rwarsow@gmx.de wrote:
> Hallo
> 
> I see this since 4.17.11:
> 
> 
> [    0.282161] ACPI Error: Result stack is empty! State=        (ptrval) (20180313/dswstate-65)
> [    0.282269] ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand (20180313/dsutils-612)
> [    0.282375] ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0 (20180313/dsutils-727)
> [    0.282657] ACPI Error: Result stack is empty! State=        (ptrval) (20180313/dswstate-65)
> [    0.282762] ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand (20180313/dsutils-612)
> [    0.282868] ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0 (20180313/dsutils-727)
> [    0.282973] ACPI Error: Result stack is empty! State=        (ptrval) (20180313/dswstate-65)
> [    0.284001] ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand (20180313/dsutils-612)
> [    0.284106] ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0 (20180313/dsutils-727)
> [    0.284254] ACPI Error: Result stack is empty! State=        (ptrval) (20180313/dswstate-65)
> [    0.284359] ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand (20180313/dsutils-612)
> [    0.284464] ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0 (20180313/dsutils-727)
> [    0.285235] ACPI Error: Result stack is empty! State=        (ptrval) (20180313/dswstate-65)
> [    0.285473] ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand (20180313/dsutils-612)
> [    0.285709] ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0 (20180313/dsutils-727)
> [    0.286190] ACPI Error: Result stack is empty! State=        (ptrval) (20180313/dswstate-65)
> [    0.286425] ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand (20180313/dsutils-612)
> [    0.286661] ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0 (20180313/dsutils-727)
> [    0.286897] ACPI Error: Result stack is empty! State=        (ptrval) (20180313/dswstate-65)
> [    0.287000] ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand (20180313/dsutils-612)
> [    0.287237] ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0 (20180313/dsutils-727)
> [    0.287988] ACPI Error: Result stack is empty! State=        (ptrval) (20180313/dswstate-65)
> [    0.288001] ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand (20180313/dsutils-612)
> [    0.288237] ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0 (20180313/dsutils-727)
> [    0.288482] ACPI Error: Unimplemented data type: 0x0 (20180313/dsobject-549)
> [    0.299831] ACPI Error: Result stack is empty! State=        (ptrval) (20180313/dswstate-65)
> [    0.300001] ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand (20180313/dsutils-612)
> [    0.300236] ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0 (20180313/dsutils-727)
> [    0.300513] ACPI Error: Result stack is empty! State=        (ptrval) (20180313/dswstate-65)
> [    0.300749] ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand (20180313/dsutils-612)
> [    0.300984] ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0 (20180313/dsutils-727)
> 
> 
> 
> do I need to worry about  - box runs as usual - ?
> 
> 

Looks like the same problem that Linus reported.
A patch has already been posted for it here:
https://lore.kernel.org/lkml/CF6A88132359CE47947DB4C6E1709ED53BB4FB62@ORSMSX110.amr.corp.intel.com/

It seems to just be noise.

-- 
~Randy
