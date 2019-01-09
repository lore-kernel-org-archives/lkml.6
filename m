Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAD4C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E6720665
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547039090;
	bh=1+H36IIYMixqsPXy/rWNU9rmm+yanPUpXeRuHfMkJh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rZO7tDK03mQXy3IEIZZs1H6XqXdkauusjrcFZ8JvAeLZ2FKCdWGRhIL5ehssl2wCf
	 n8SCi17OKcrUd8HMXZbWv+3fX9eEMUN46v8wpgQxdm/IyUIY1jcGQRQx//0Nsh5wtz
	 yUjgoZrg0EpFPUWSC/li7MzwgPZ4jxG4lBk/GYgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbfAINEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 08:04:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:48788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729721AbfAINEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 08:04:49 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C105206B6;
        Wed,  9 Jan 2019 13:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547039088;
        bh=1+H36IIYMixqsPXy/rWNU9rmm+yanPUpXeRuHfMkJh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I6WnVoeNASfj0zKOvP4KN8U0agNR4ntOvqqM2BRshZbsqPo/iH4rWp9bPlfyvQfoK
         0IXHj7MQ/teUWaMuftzU4TVogb9Mp0y5LQYK4F4pQWmByolYzl50T5W7OJDTlcxwgu
         3Y0Hl1VGPCrYSp4oshKBX0IWWQR5hiJ0OVSxKbGc=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D19D340355; Wed,  9 Jan 2019 10:04:44 -0300 (-03)
Date:   Wed, 9 Jan 2019 10:04:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 00/16] perf/core fixes and improvements
Message-ID: <20190109130444.GA25192@kernel.org>
References: <20190108195910.17726-1-acme@kernel.org>
 <20190109070528.GB29753@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109070528.GB29753@gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 09, 2019 at 08:05:28AM +0100, Ingo Molnar escreveu:
> * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >   . Update linux/{fs,vhost}.h, grab a copy o linux/mount.h, where the
> >     MS_ mount flags were moved.
 
> We still have two UAPI warnings in the latest tip:perf/urgent - the patch 
> below fixes them, at least on x86.
 
> The if_link.h looks trivial enough - but I'm unsure about the powerpc one 
> and didn't test it on PowerPC.

The PPC one I already pinged Ravi Bangoria, as it is used to generate
the syscall table for 'perf trace', now it works like x86 and s390, he
said he was a bit busy but will tackle this.

The if_link one I just updated in my local branch, will go in the next
round.

Thanks,

- Arnaldo
