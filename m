Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41C9C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E1D21527
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E1D21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbeIZWb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:31:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33152 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727782AbeIZWb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:31:28 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id h64KTM2ht_5m; Wed, 26 Sep 2018 18:17:46 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCA1F00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:1f00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 304E81EC04FB;
        Wed, 26 Sep 2018 18:17:46 +0200 (CEST)
Date:   Wed, 26 Sep 2018 18:17:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Justin Ernst <justin.ernst@hpe.com>, russ.anderson@hpe.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aristeu Rozanski Filho <arozansk@redhat.com>
Subject: Re: [PATCH] Raise maximum number of memory controllers
Message-ID: <20180926161749.GI5584@zn.tnic>
References: <20180925143449.284634-1-justin.ernst@hpe.com>
 <20180925152659.GE23986@zn.tnic>
 <20180925175023.GA16725@agluck-desk>
 <20180925180458.GG23986@zn.tnic>
 <20180926093510.GA5584@zn.tnic>
 <20180926152752.GG5584@zn.tnic>
 <20180926130340.6b22918b@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180926130340.6b22918b@coco.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 01:03:40PM -0300, Mauro Carvalho Chehab wrote:
> I guess this is/was needed to create things like this:
> 
> 	lrwxrwxrwx 1 root root 0 set 26 05:24 /sys/bus/edac/devices/mc -> ../../../devices/system/edac/mc

They're still there:

$ ls -l /sys/bus/edac/devices/
total 0
lrwxrwxrwx 1 root root 0 Sep 26 18:15 csrow0 -> ../../../devices/system/edac/mc/mc0/csrow0
lrwxrwxrwx 1 root root 0 Sep 26 18:15 dimm0 -> ../../../devices/system/edac/mc/mc0/dimm0
lrwxrwxrwx 1 root root 0 Sep 26 18:15 dimm3 -> ../../../devices/system/edac/mc/mc0/dimm3
lrwxrwxrwx 1 root root 0 Sep 26 18:15 dimm6 -> ../../../devices/system/edac/mc/mc0/dimm6
lrwxrwxrwx 1 root root 0 Sep 26 18:15 dimm9 -> ../../../devices/system/edac/mc/mc0/dimm9
lrwxrwxrwx 1 root root 0 Sep 26 18:15 mc -> ../../../devices/system/edac/mc
lrwxrwxrwx 1 root root 0 Sep 26 18:15 mc0 -> ../../../devices/system/edac/mc/mc0

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
