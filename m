Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34776C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38AC214C6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PvDJ+4Y3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfAZVSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 16:18:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42696 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfAZVSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 16:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=596uISJCf4W9Y224ZiSMo1Mmi9I+MiGvXPRK3IoSN20=; b=PvDJ+4Y3woJ3eSRmnrRtqE+G8
        ys/RVDdGbCZoL+DhppcpWt7mjgimhgthUxWRzBR0Pt6lDfwXnB0ue+La200wajpSG2ZFA0qr05IWV
        korhhTfiHzse5WBfz3sSB+/A6keN7mH7lDyPa3Og1OQe7R4KGhYIjHkS+QyBY3TEiPiN9TfLKshtT
        tV1KmqwwtSyxwHZPk6MyNzlXtzjfrogxyxUMBGiVY3yjYWIam7bihXeSkOsbygTJVoHXfCgpW0mpc
        ODRabuAL6BH30FHkeKrbmv3rDh/EbFsRuzmMLnLzoIlCBwZikmNKdfCURXfZciIfRpzkxXEClYtYV
        9jw+QQsbQ==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gnVLl-0004sb-IW; Sat, 26 Jan 2019 21:18:49 +0000
Date:   Sat, 26 Jan 2019 13:18:46 -0800
From:   Darren Hart <dvhart@infradead.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: asus-wmi: Allow loading on systems without
 the Asus Management GUID
Message-ID: <20190126211846.GC13882@wrath>
References: <20190121132436.31825-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121132436.31825-1-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 02:24:36PM +0100, Hans de Goede wrote:
> hid-asus depends on asus-wmi through the asus_wmi_evaluate_method. Before
> this commit asus-wmi and thus hid-asus could not be loaded on non Asus
> systems. This breaks using Asus bluetooth keyboards such as the Asus
> T100CHI keyboard with non Asus systems.
> 
> This commit fixes this by allowing asus-wmi to load on systems without the
> Asus Management GUID.
> 
> This is save to do since all asus-wmi sub drivers use
> asus_wmi_register_driver which also checks for the GUID.
> 
> This commit also improves the error messages in asus_wmi_register_driver
> to include "ASUS" in their description tom make them more clear. This is
> important since we now rely on those errors when loaded on systems without
> the Asus Management GUID.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Hi Hans,

A few typos above, please consider adding a spellchecker to your editor for
commit message authoring... I've taken care of them and queued this patch for
testing.

Thanks!

-- 
Darren Hart
VMware Open Source Technology Center
