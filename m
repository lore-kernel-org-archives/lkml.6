Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D103C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC112086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC112086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbeJPTaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:30:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:39748 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726711AbeJPTaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:30:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 70AA1ACB7;
        Tue, 16 Oct 2018 11:39:58 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH] tools/power/cpupower: fix compilation with STATIC=true
Date:   Tue, 16 Oct 2018 13:39:57 +0200
Message-ID: <2028892.8FmI4CMcI5@house>
In-Reply-To: <153968018626.397151.17942194042449956995.stgit@buzz>
References: <153968018626.397151.17942194042449956995.stgit@buzz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, October 16, 2018 10:56:26 AM CEST Konstantin Khlebnikov wrote:
> Rename duplicate sysfs_read_file into cpupower_read_sysfs and fix linking.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Acked-by: Thomas Renninger <trenn@suse.de>

Thanks!

> -       $(OUTPUT)../lib/cpufreq.o $(OUTPUT)../lib/sysfs.o
> +       $(OUTPUT)../lib/cpufreq.o $(OUTPUT)../lib/cpupower.o

I also looked at this and would only have fixed half of it (overseeing above
old leftover from cpupower lib introduction).
I guess, this patch from Konstantin is better and the correct solution.
