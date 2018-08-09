Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6946AC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1499E21A38
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1499E21A38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbeHIKAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:00:33 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:33393 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeHIKAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:00:33 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 41mKp20htkz1qwdS;
        Thu,  9 Aug 2018 09:36:58 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 41mKp200t4z1tLNV;
        Thu,  9 Aug 2018 09:36:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id fIeJd_HmznQ9; Thu,  9 Aug 2018 09:36:57 +0200 (CEST)
X-Auth-Info: BPco5M4vGfqX9Mz7JkJL7ADqs6SJJJQYa6MeHet7FtoncPPbFNV6bPWivpHSYAcC
Received: from hawking (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu,  9 Aug 2018 09:36:57 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH 3/4] m68k: Added system call table generation support
References: <1533791723-3882-1-git-send-email-firoz.khan@linaro.org>
        <1533791723-3882-4-git-send-email-firoz.khan@linaro.org>
X-Yow:  Uh-oh!!  I'm having TOO MUCH FUN!!
Date:   Thu, 09 Aug 2018 09:36:56 +0200
In-Reply-To: <1533791723-3882-4-git-send-email-firoz.khan@linaro.org> (Firoz
        Khan's message of "Thu, 9 Aug 2018 10:45:22 +0530")
Message-ID: <mvmftzoq9d3.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 09 2018, Firoz Khan <firoz.khan@linaro.org> wrote:

> +_dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)') \
> +	  $(shell [ -d '$(out)' ] || mkdir -p '$(out)')

mkdir -p is a no-op if the directory exits.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
