Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED64BC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05D72083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05D72083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbeJBXKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 19:10:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34116 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727351AbeJBXKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 19:10:18 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WH81rJTfyuF4; Tue,  2 Oct 2018 18:26:06 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC64F00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:4f00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 94CAB1EC02D1;
        Tue,  2 Oct 2018 18:26:06 +0200 (CEST)
Date:   Tue, 2 Oct 2018 18:26:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ernst, Justin" <justin.ernst@hpe.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aristeu Rozanski Filho <arozansk@redhat.com>
Subject: Re: [PATCH] EDAC: Don't add devices under /sys/bus/edac
Message-ID: <20181002162608.GC29601@zn.tnic>
References: <20180926182317.patqjso7nzw2oxiz@hpe.com>
 <20180926230257.GA5666@agluck-desk>
 <20180927045244.GA30912@zn.tnic>
 <20180927214400.GA2249@agluck-desk>
 <20180927220355.GF19687@zn.tnic>
 <20180927221054.580220e5@coco.lan>
 <20181001124754.GD7269@zn.tnic>
 <20181001224313.GA9487@agluck-desk>
 <20181001222257.45e4fd59@coco.lan>
 <AT5PR8401MB037188B39CB70EB18ADAC11987E80@AT5PR8401MB0371.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AT5PR8401MB037188B39CB70EB18ADAC11987E80@AT5PR8401MB0371.NAMPRD84.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 03:51:41PM +0000, Ernst, Justin wrote:
> The combined patches work on a 20 socket system. 
> Thanks!

Cool, thanks for testing.

Nevertheless, I'll queue them for 4.21 so that we have a full cycle of
testing before we really kill the bus thing.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
