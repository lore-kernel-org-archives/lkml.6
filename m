Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF4FC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7923020849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="bcmhosoo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7923020849
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbeLKU6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:58:32 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33382 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbeLKU6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:58:32 -0500
Received: from zn.tnic (p200300EC2BCD2B0010F6E1EC68D6BA6C.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:2b00:10f6:e1ec:68d6:ba6c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 13E4A1EC028C;
        Tue, 11 Dec 2018 21:58:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544561911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RzUk49DNv6rYp/wpFfNFcf/jkU3MV5R0WweSDvZ6dvY=;
        b=bcmhosoofHXkgZyBr6enp6sUr0fRoqLEbkxBHa5ksjbD34xJO2tvsdY/QG6FCnRfqOWJfn
        3H2ElVZWLYDAonJxQpSvYnz+FI62DjAbOHR9VEe0mMX6tHZDHuufw+DPNwoJkrxKPwx9Sq
        rB89djfSvkGWHGF/3dCyesUKRGk3qbU=
Date:   Tue, 11 Dec 2018 21:58:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        gavin.hindman@intel.com, jithu.joseph@intel.com, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH V2] x86/intel_rdt: Ensure usage of CPUs are locked while
 needed
Message-ID: <20181211205828.GS27375@zn.tnic>
References: <b7b17432a80f95a1fa21a1698ba643014f58ad31.1544476425.git.reinette.chatre@intel.com>
 <20181211123404.GC27375@zn.tnic>
 <ece2581e-d5e5-c26c-53e5-0cef8b37e59f@intel.com>
 <20181211185059.GP27375@zn.tnic>
 <e4ef2e81-defd-c5ca-4892-a0361a4528ba@intel.com>
 <20181211204310.GQ27375@zn.tnic>
 <10fef6af-785e-c76f-d89b-ec115dcf460a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10fef6af-785e-c76f-d89b-ec115dcf460a@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 12:51:12PM -0800, Reinette Chatre wrote:
> I really appreciate your patience.

That goes both ways. Thx. :-)

> That subject line matches exactly the goal of this patch. Thank you very
> much. Would you prefer that I send a new version with this subject line
> or would you rather make the change yourself while applying this patch?

Nah, no need. I'll fix them up.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
