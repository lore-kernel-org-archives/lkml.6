Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E87FC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72792148E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2Z3HK8c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72792148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbeKUSlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:41:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:33570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbeKUSlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:41:13 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B14092146F;
        Wed, 21 Nov 2018 08:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542787662;
        bh=USVvKgZbS10WZofvA3QLCXxaTVBbGLuqlDdu1TlD1rk=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=U2Z3HK8cpn66suW4Vgzk+9lZiaHA8keeD7j+1LAVPwGCDY8gr/ll7WsRj5OVjXWWp
         p/KpU2+olg7g2tYEVD1TYmtiwEppQOuNhp4Q1yv0RYtEobB5J/xSMaFv107YY0kM0v
         FcwKSiPqbHicxtGGJds88smVf3KPI9MBZvJRbyNU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542681454.5132.9.camel@mtksdaap41>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, sboyd@codeaurora.org,
        Rob Herring <robh@kernel.org>, jamesjj.liao@mediatek.com,
        fan.chen@mediatek.com,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, owen.chen@mediatek.com,
        mars.cheng@mediatek.com
References: <20181106064206.17535-1-weiyi.lu@mediatek.com>
 <20181106064206.17535-6-weiyi.lu@mediatek.com>
 <CANMq1KDbauouMDvsZS3KsNJrNs1gGg7mDjsKRw=zTcuQXSTa0Q@mail.gmail.com>
 <1542681454.5132.9.camel@mtksdaap41>
Message-ID: <154278766192.88331.16232130563413450456@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1 04/11] soc: mediatek: add new flow for mtcmos power.
Date:   Wed, 21 Nov 2018 00:07:41 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2018-11-19 18:37:34)
> On Tue, 2018-11-13 at 11:31 -0800, Nicolas Boichat wrote:
> > On Mon, Nov 5, 2018 at 10:42 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:

> > > @@ -226,6 +397,7 @@ static int scpsys_power_on(struct generic_pm_doma=
in *genpd)
> > >         if (ret < 0)
> > >                 goto err_pwr_ack;
> > >
> > > +
> > =

> > Drop this.
> Why do we try to drop this? Once the power-on step fail, the following
> steps should not be permitted.

I just see a whitespace addition that doesn't do anything. I suspect
it's a style nitpick and common practice to not include spurious diffs
in the patch. So remove this hunk?

