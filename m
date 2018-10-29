Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6EEC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7376204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7376204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeJ3ClM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:41:12 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38726 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbeJ3ClL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:41:11 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Khj9w4h30Il4; Mon, 29 Oct 2018 18:51:31 +0100 (CET)
Received: from zn.tnic (p200300EC2BC61800329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:1800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6060E1EC00E8;
        Mon, 29 Oct 2018 18:51:31 +0100 (CET)
Date:   Mon, 29 Oct 2018 18:51:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Daniel Aberger - Profihost AG <d.aberger@profihost.ag>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "s.priebe@profihost.ag" <s.priebe@profihost.ag>,
        "n.fahldieck@profihost.ag" <n.fahldieck@profihost.ag>,
        "p.kramme@profihost.ag" <p.kramme@profihost.ag>
Subject: Re: MCE reports errors that can't be verified
Message-ID: <20181029175129.GL32150@zn.tnic>
References: <6ccf5413-ce2a-bbb9-0203-b0cc9fe2e641@profihost.ag>
 <20181029161525.GI32150@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7D43AA76@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7D43AA76@ORSMSX110.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 04:59:44PM +0000, Luck, Tony wrote:
> The EDAC driver printed out those messages,

I don't think so - that's __print_mce() in mce.c which dumps the three
lines under "... events logged". Which means, that's the lowest prio,
fallback notifier which runs when nothing else before it has done any
logging.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
