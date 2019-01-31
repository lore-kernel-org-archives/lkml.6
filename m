Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4C1C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADB0218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="fKFhUA31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733261AbfAaNAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:00:10 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53116 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfAaNAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:00:09 -0500
Received: from zn.tnic (p200300EC2BCC5900651C63FB93E4C575.dip0.t-ipconnect.de [IPv6:2003:ec:2bcc:5900:651c:63fb:93e4:c575])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 57C011EC04F3;
        Thu, 31 Jan 2019 14:00:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548939607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YvklMVJmvBjkkIG9cB1ftlfEak02xHTULTEeBqWxq3Y=;
        b=fKFhUA31alKUBdDtvrcJTsfFyEx4+DVcYAigfHK6qVoeAS3odHVsQgsmqP4C1StdhSxvLY
        wWrlKjipobRBhr9yD0uvZlNVwNhwi7YU62Tkp8tQN0jJvNBA8n29p7VRI9oKNKHLlydxeE
        tPL2rQz+qbE/i60brqpoz/qQK1dbq2I=
Date:   Thu, 31 Jan 2019 13:59:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 2/7] x86, olpc: Use a correct version when making up a
 battery node
Message-ID: <20190131125955.GI6749@zn.tnic>
References: <20190110174005.1202564-1-lkundrak@v3.sk>
 <20190110174005.1202564-3-lkundrak@v3.sk>
 <20190123205627.nbddtfuy6qdo2bgb@earth.universe>
 <0adff00d4c4797fe1f9d593a7ba7c772ac3312c4.camel@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0adff00d4c4797fe1f9d593a7ba7c772ac3312c4.camel@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ the platform maintainers.

On Thu, Jan 31, 2019 at 01:26:16PM +0100, Lubomir Rintel wrote:
> Hi,
> 
> On Wed, 2019-01-23 at 21:56 +0100, Sebastian Reichel wrote:
> > Hi,
> > 
> > On Thu, Jan 10, 2019 at 06:40:00PM +0100, Lubomir Rintel wrote:
> > > The XO-1 and XO-1.5 batteries apparently differ in an ability to report
> > > ambient temperature. Add a different compatible string to the 1.5
> > > battery.
> > > 
> > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > > 
> > > ---
> > 
> > I either need an Acked-by from the x86 platform maintainers, that I
> > can queue this through power-supply or a pull request for an immutable
> > branch (probably the better idea).
> 
> I'm happy to prepare a branch that could be pulled from. In fact,
> here's a branch with fixes for issues pointed out by the review that
> could be pulled from:
> 
>   git pull https://github.com/hackerspace/olpc-xo175-linux lr/olpc-xo175-battery-for-v5.1
> 
> What do really not understand is how does this help. This is probably
> just my unfamiliarity with the process; but perhaps you could help me
> get less unfamiliar. Would it somehow help with a potential (though
> unlikely) conflict resolution? Would an Ack from x86 crowd serve as an
> altenative way off making sure things in their tree won't conflict with
> this one?
> 
> > -- Sebastian
> 
> Thank you
> Lubo
> 

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
