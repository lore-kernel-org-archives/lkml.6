Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D81ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 06:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7380020779
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 06:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7380020779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeJVOXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 10:23:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbeJVOXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 10:23:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E868307D846;
        Mon, 22 Oct 2018 06:06:20 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E24F5D73F;
        Mon, 22 Oct 2018 06:06:16 +0000 (UTC)
Date:   Mon, 22 Oct 2018 14:06:13 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Fan, Chao" <fanc.fnst@cn.fujitsu.com>, dyoung@redhat.com
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "msys.mizuma@gmail.com" <msys.mizuma@gmail.com>,
        "Indoh, Takao" <indou.takao@fujitsu.com>,
        "Cao, Jin" <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v9 5/8] x86/boot: Add get_acpi_rsdp() to parse RSDP in
 cmdlien from kexec
Message-ID: <20181022060613.GK1885@192.168.1.4>
References: <20181017102012.872-1-fanc.fnst@cn.fujitsu.com>
 <20181017102012.872-6-fanc.fnst@cn.fujitsu.com>
 <20181021022650.GI1885@192.168.1.4>
 <B74D54765E346E448CD6C7B7B0334C258D955469@G08CNEXMBSHAD01.g08.fujitsu.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B74D54765E346E448CD6C7B7B0334C258D955469@G08CNEXMBSHAD01.g08.fujitsu.local>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 22 Oct 2018 06:06:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/18 at 05:30am, Fan, Chao wrote:
> >> +static void get_acpi_rsdp(acpi_physical_address *rsdp_addr)
> >> +{
> >> +#ifdef CONFIG_KEXEC
> >> +	unsigned long long res;
> >> +	int len = 0;
> >> +	char *val;
> >> +
> >> +	val = malloc(20);
> >
> >Why is the length 20? Defined a macro?
> >
> 
> Not a calculation, if it's enough to store the address, that will be OK.

Sorry, I didn't catch. It's 16 in setup_acpi_rsdp() of
drivers/acpi/osl.c . What does 'that' mean?

Wondering why not making it 200, it's also enough to store the address.
