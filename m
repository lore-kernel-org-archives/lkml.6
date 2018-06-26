Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E741CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668DF223C9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 21:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qvLw38Za"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 668DF223C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932838AbeFZVe7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 17:34:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53960 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752258AbeFZVe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 17:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OgSwYmnGww2ElL7BKZyxeu0ytNz07pvRvAYnrB0tfuU=; b=qvLw38ZaMlHMRgKPU9gbjtcmH
        rz+oD6uHpfArtS8X3UgUJ9fv8Irr3zNmXfTnbj1kY5V0KloZ9SgsFj2snrmmqt402KJz4GahX7sXd
        /CgB7r/KsojpvsE98DfM2JYpTy4FLGt8FCS1MUMCw6WA12/JsfnCnQPtBwG/i0iEOHriuxh9DcdCq
        ToeHS0Dr69nG7ugLhunnHt99EeVR7rtlXf2VwtkzFiSR4IO+J6leYrJDcE/BULxS9KWMcBwrZiNd4
        o8fKaL8KfrKV3rVt58rkLRJ2RQLoiHFr2dNbjetxW7757JRiGR7KJJgFuDYqvB5ZOeB44hkd8orUy
        UmJ/guvVA==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXvbv-0004t1-Q6; Tue, 26 Jun 2018 21:34:51 +0000
Date:   Tue, 26 Jun 2018 14:34:50 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Colin King <colin.king@canonical.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: dell-smbios: make a function and a pointer
 static
Message-ID: <20180626213450.GB4945@fury>
References: <20180621181524.30550-1-colin.king@canonical.com>
 <20180623002237.GG27466@fury>
 <alpine.DEB.2.20.1806230823500.2696@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1806230823500.2696@hadrien>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 08:24:26AM +0200, Julia Lawall wrote:
> 
> 
> On Fri, 22 Jun 2018, Darren Hart wrote:
> 
> > On Thu, Jun 21, 2018 at 07:15:24PM +0100, Colin King wrote:
> > > From: Colin Ian King <colin.king@canonical.com>
> > >
> > > The function dell_smbios_smm_call and pointer platform_device are
> > > local to the source and do not need to be in global scope, so make
> > > them static.
> > >
> > > Cleans up sparse warnings:
> > > warning: symbol 'platform_device' was not declared. Should it be static?
> > > warning: symbol 'dell_smbios_smm_call' was not declared. Should it be
> > > static?
> > >
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > ---
> > >  drivers/platform/x86/dell-smbios-smm.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/platform/x86/dell-smbios-smm.c b/drivers/platform/x86/dell-smbios-smm.c
> > > index e9e9da556318..97a90bebc360 100644
> > > --- a/drivers/platform/x86/dell-smbios-smm.c
> > > +++ b/drivers/platform/x86/dell-smbios-smm.c
> > > @@ -24,7 +24,7 @@
> > >  static int da_command_address;
> > >  static int da_command_code;
> > >  static struct calling_interface_buffer *buffer;
> > > -struct platform_device *platform_device;
> > > +static struct platform_device *platform_device;
> > >  static DEFINE_MUTEX(smm_mutex);
> > >
> > >  static const struct dmi_system_id dell_device_table[] __initconst = {
> > > @@ -82,7 +82,7 @@ static void find_cmd_address(const struct dmi_header *dm, void *dummy)
> > >  	}
> > >  }
> > >
> > > -int dell_smbios_smm_call(struct calling_interface_buffer *input)
> > > +static int dell_smbios_smm_call(struct calling_interface_buffer *input)
> >
> > Hrm. So these are passed by pointer to dell_smbios_register_device(), which is in
> > turn called by dell_smbios_call() from dell-smbios-base.c.
> >
> > So while it is valid to make these static, since we're not referencing the
> > symbol, but the pointer value instead - I do worry about the "static" suggesting
> > to someone reading the code that this data is not used outside of this file,
> > when it is.
> 
> Static protects the name.  The name in this case is very generic.

Indeed "platform_device" is even more generic than I'd like for a static ;-)

-- 
Darren Hart
VMware Open Source Technology Center
