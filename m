Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653F0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C2D921A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="LpePVz67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394793AbfBONAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:00:20 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42190 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfBONAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:00:20 -0500
Received: from zn.tnic (p200300EC2BCDA5002DB5FFAD614FBD15.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:a500:2db5:ffad:614f:bd15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E12C01EC059E;
        Fri, 15 Feb 2019 14:00:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1550235619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nF6FFvrBfryMfOu713CqUVZgZPF8vtNqc/VXVz5noqA=;
        b=LpePVz67EroO1YPK4LReGX74Kx+BnqVqxFkPHS6p6wfnlPk9rlqFRx9C3jwXZoQhVy/8UL
        I5g376VGVEqYn/M15txL9hq2QlslRqzgMKSx1YwWJZkMzsMe8IK+6Dk6FK95CmpfpeNaW+
        kWtRpN23uvwbc02zb9aHJ759DxXgL6M=
Date:   Fri, 15 Feb 2019 14:00:16 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thor Thayer <thor.thayer@linux.intel.com>,
        Huang Zijiang <huang.zijiang@zte.com.cn>
Cc:     mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn
Subject: Re: [PATCH] EDAC, altera: Add missing of_node_put()
Message-ID: <20190215130016.GG10433@zn.tnic>
References: <1550126347-27984-1-git-send-email-huang.zijiang@zte.com.cn>
 <64c210a5-41d2-2f62-e3d5-ac9c14841858@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64c210a5-41d2-2f62-e3d5-ac9c14841858@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 10:15:20AM -0600, Thor Thayer wrote:
> Yes, I missed the error path. I mistakingly thought of_node_put(np_eccmgr)
> would catch the exit of both branches but I declared sysmgr_np instead of
> re-using np_eccmgr. I'll clean that up in a separate patch (actually this
> code will disappear when my combined sysmgr patchset is accepted upstream).
> 
> Thanks!
> 
> Reviewed-by: Thor Thayer <thor.thayer@linux.intel.com>

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
