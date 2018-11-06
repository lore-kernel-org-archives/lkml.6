Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE025C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0DF220869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0DF220869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388881AbeKGALV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:11:21 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49612 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388797AbeKGALV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:11:21 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fFdOC1UdvOhW; Tue,  6 Nov 2018 15:45:48 +0100 (CET)
Received: from zn.tnic (p200300EC2BD1C800329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:c800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D3F2A1EC02A3;
        Tue,  6 Nov 2018 15:45:47 +0100 (CET)
Date:   Tue, 6 Nov 2018 15:45:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ernst, Justin" <justin.ernst@hpe.com>,
        "Luck, Tony" <tony.luck@intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aristeu Rozanski Filho <arozansk@redhat.com>
Subject: Re: [PATCH] EDAC: Don't add devices under /sys/bus/edac
Message-ID: <20181106144535.GI13712@zn.tnic>
References: <20180926230257.GA5666@agluck-desk>
 <20180927045244.GA30912@zn.tnic>
 <20180927214400.GA2249@agluck-desk>
 <20180927220355.GF19687@zn.tnic>
 <20180927221054.580220e5@coco.lan>
 <20181001124754.GD7269@zn.tnic>
 <20181001224313.GA9487@agluck-desk>
 <20181001222257.45e4fd59@coco.lan>
 <AT5PR8401MB037188B39CB70EB18ADAC11987E80@AT5PR8401MB0371.NAMPRD84.PROD.OUTLOOK.COM>
 <20181002162608.GC29601@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181002162608.GC29601@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 06:26:08PM +0200, Borislav Petkov wrote:
> On Tue, Oct 02, 2018 at 03:51:41PM +0000, Ernst, Justin wrote:
> > The combined patches work on a 20 socket system. 
> > Thanks!
> 
> Cool, thanks for testing.
> 
> Nevertheless, I'll queue them for 4.21 so that we have a full cycle of
> testing before we really kill the bus thing.

Ok, I've pushed the two patches ontop of EDAC's for-next branch, here:

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=edac-for-4.21-bus

and I'd appreciate testing them one more time on the big boxes you guys have.

Diffing sysfs here shows this:

--- edac.before	2018-11-06 13:37:37.925448609 +0100
+++ edac.after	2018-11-06 15:36:11.229497795 +0100
@@ -37,7 +37,6 @@
 /sys/devices/system/edac/mc/mc0/dimm3/power/control
 /sys/devices/system/edac/mc/mc0/dimm3/dimm_dev_type
 /sys/devices/system/edac/mc/mc0/dimm3/size
-/sys/devices/system/edac/mc/mc0/dimm3/subsystem
 /sys/devices/system/edac/mc/mc0/dimm3/dimm_ce_count
 /sys/devices/system/edac/mc/mc0/dimm3/dimm_label
 /sys/devices/system/edac/mc/mc0/dimm3/dimm_location

which is the bus symlink:

subsystem -> ../../../../../../bus/mc0

and I think that's ok as nothing should be using it.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
