Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20C8C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8F820989
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZFE/gKuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8F820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbeKUGAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 01:00:30 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59756 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbeKUGAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 01:00:30 -0500
Received: from zn.tnic (p200300EC2BD1FF00883B4D3E2A7F8FA4.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:ff00:883b:4d3e:2a7f:8fa4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7E01C1EC0725;
        Tue, 20 Nov 2018 20:29:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542742184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Em/CJpRlqp1QVgNc3ZOgVTSUYmuIU8UpC5I+oNQ+QrA=;
        b=ZFE/gKuHracTp3n9l9RXPbpQJNuxmP0r3auloiqwhFq05QZAnkLROoZ3bkwhsZhFgpoxhn
        0SGUVVx3FO+/W2K80wDiyouCPebaVbpxv3EeryT57aJ5jKUQfoVUsZI01v4wBa1g60Uh8+
        by5zxGHQ7yvdrP1fYiL7XehoXh/ZRHM=
Date:   Tue, 20 Nov 2018 20:29:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     lijiang <lijiang@redhat.com>
Cc:     Dave Young <dyoung@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        akpm@linux-foundation.org, bhe@redhat.com
Subject: Re: [PATCH 1/2 v6] x86/kexec_file: add e820 entry in case e820 type
 string matches to io resource name
Message-ID: <20181120192935.GK2527@zn.tnic>
References: <20181114072926.13312-1-lijiang@redhat.com>
 <20181114072926.13312-2-lijiang@redhat.com>
 <20181114112600.GD13926@zn.tnic>
 <9eb61523-7a08-24c4-ac15-050537bd9203@redhat.com>
 <20181115103959.GB26448@zn.tnic>
 <20181119095515.GC14045@dhcp-128-65.nay.redhat.com>
 <20181119102812.GA14688@zn.tnic>
 <a1c58bb8-390b-e249-599f-c973d575e1ca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1c58bb8-390b-e249-599f-c973d575e1ca@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 11:37:26AM +0800, lijiang wrote:
> BTW: Boris has mentioned the solution which adds the new descriptor 'IORES_DESC_RESERVED'.
> 
> Which solution do you prefer? Add the new I/O resource descriptor 'IORES_DESC_RESERVED'(patch v7)
> or exactly comparing a string(patch v6)?

The new I/O descriptor of course - the string comparison thing is
fragile and error-prone.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
