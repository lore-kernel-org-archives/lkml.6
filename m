Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F05C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1AE20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1AE20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbeLKGvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 01:51:54 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:42480 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbeLKGvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 01:51:54 -0500
Received: by isilmar-4.linta.de (Postfix, from userid 1000)
        id 1FF66200939; Tue, 11 Dec 2018 06:51:53 +0000 (UTC)
Date:   Tue, 11 Dec 2018 07:51:53 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: *powersave* governor shown despite disabled in configuration
Message-ID: <20181211065152.t2anuhy6t4n2zjrd@isilmar-4.linta.de>
References: <8786b234-eb4d-fb79-d6e0-e71f45ed3120@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8786b234-eb4d-fb79-d6e0-e71f45ed3120@molgen.mpg.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 04:30:05PM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> With Linux 4.14.76, the scaling governor *powersave* is shown as
> being available despite being disabled in the configuration.

Which cpufreq driver do you use? Presumably intel_pstate? That driver
exposes internal policies / "governors" named "performance" and "powersave",
which are unrelated to CONFIG_CPU_FREQ_GOV_POWERSAVE.

Thanks,
	Dominik
