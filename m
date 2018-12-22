Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9D0C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB3121939
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545498357;
	bh=AVZ+Yv1ttadzNqZY9GeyBtDWoOCKumqMwA+AnC0lwHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WlyiQdMOBpbcB+BdqdiX03DpVjoyktQ/YcduK35wTNBYpQQaj1tGn/kQW6AqL06uo
	 tHZ8nRQmSpABPNeWrqDitqKDW9JVdbO24cPGpW1SaVr/AGhORIlSl9N0g4qq6SA2O+
	 A6vyiwn/PyxcQ9JO80kR/X7nNpGKWv9Al2aVUODo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390062AbeLVRF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:05:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbeLVRFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:05:55 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 683E121917;
        Sat, 22 Dec 2018 17:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545498354;
        bh=AVZ+Yv1ttadzNqZY9GeyBtDWoOCKumqMwA+AnC0lwHo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YG0dDCR5OhCFNMjYImWJacfFk5zy8Epms8sAy896/8US851wVaCoAOo8iViOFTpwM
         YPs1b7AOtzycoZjGy8L+h/OwnNzkd+xCBx/Pvw7UVWO4b2z1lrpeB2TOugpSBHubcW
         cz+zVxkElH2fyzwn2CR2Ld0LYy3u6ngmAsfUQ69U=
Date:   Sat, 22 Dec 2018 17:05:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Anson Huang <anson.huang@nxp.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        olivier moysan <olivier.moysan@st.com>,
        Brian Masney <masneyb@onstation.org>,
        Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>,
        rtresidd@electromag.com.au, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Phil Reid <preid@electromag.com.au>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH V5 1/2] dt-bindings: iio: magnetometer: add dt-bindings
 for freescale mag3110
Message-ID: <20181222170545.4aed8c61@archlinux>
In-Reply-To: <CAL_Jsq+NKtKcV9xzSd11vZPfQWUVJMSQx8BB-5UX6O_4ptV44A@mail.gmail.com>
References: <1545021679-4025-1-git-send-email-Anson.Huang@nxp.com>
        <CAL_Jsq+NKtKcV9xzSd11vZPfQWUVJMSQx8BB-5UX6O_4ptV44A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 08:55:53 -0600
Rob Herring <robh+dt@kernel.org> wrote:

> On Sun, Dec 16, 2018 at 10:47 PM Anson Huang <anson.huang@nxp.com> wrote:
> >
> > Add Freescale MAG3110 dt-bindings and remove it from trivial-devices
> > dt-bingding doc.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  .../bindings/iio/magnetometer/mag3110.txt          | 27 ++++++++++++++++++++++
> >  .../devicetree/bindings/trivial-devices.txt        |  1 -
> >  2 files changed, 27 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/mag3110.txt  
> 
> trivial-devices.txt is gone now as it's converted to json-schema. I
> can take this patch thru my tree and fix it up.
> 
> Rob

That would be great. Thanks. I'll pick up patch 2.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
