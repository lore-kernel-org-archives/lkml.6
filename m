Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADCFC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EA42147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Dn8IcVmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5EA42147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732497AbeGLN4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:56:46 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:58678 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732347AbeGLN4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:56:45 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 5C3C85C21BE;
        Thu, 12 Jul 2018 15:46:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1531403202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iUIorg6jie9sK1DLkr/h7I77azMX5qAVfUzsG9fcAzo=;
        b=Dn8IcVmTVMEmPVr4qpdsj7h2r5rFr1qwr7cjuX+JO38xsbQAPMvbyafErSbKn0OBnsGUc1
        kqtHaF81EoexeBWMaS6OcWfRLsvAFjpOprb2W/nXlR0ulhpVi3hnaPZAw5nbkamGpW7ZYF
        /S5Jf7d3IYU4JNYY5lyzsbyuf7tXNnM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 12 Jul 2018 15:46:33 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     marex@denx.de, dl-linux-imx <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        festevam@gmail.com, linux-fbdev@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>, marcofrk@gmail.com,
        dri-devel@lists.freedesktop.org, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de,
        kernel@pengutronix.de, marek.vasut@gmail.com
Subject: Re: [PATCH 1/3] drm: mxsfb: Change driver.name to mxsfb-drm
In-Reply-To: <7f40f34a401ced78703b1a151d9f5fe4ed8c209f.camel@nxp.com>
References: <cover.1529091248.git.leonard.crestez@nxp.com>
 <47ea7572011735b68a8a70f0e11bdf00cb2fd86a.1529091248.git.leonard.crestez@nxp.com>
 <CAOMZO5B8i0gN+rCq-yPrd112NkwJWTxYCtsLVeLhD1JLRuX6EQ@mail.gmail.com>
 <07be6d9a85b6be655fc2b084be81d8bf9715b57a.camel@nxp.com>
 <638457fd-85da-8fec-d146-517c43f71813@denx.de>
 <b3fa74c5110b45e5992920485749869ab1f7ebce.camel@nxp.com>
 <6995fa4b-47a9-887b-5e4f-4284ca6a2c79@gmail.com>
 <fd22085f646d97f66cff5b7f22785500@agner.ch>
 <6fdba55b-0be6-9e28-d87a-43d876a1fd09@denx.de>
 <617c0a7e9132b929877b8cbcf116b1ea@agner.ch>
 <7f40f34a401ced78703b1a151d9f5fe4ed8c209f.camel@nxp.com>
Message-ID: <ce461f1f192de0648feb2db148edf60b@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-0.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[15];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[13.59%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.2018 15:03, Leonard Crestez wrote:
> On Thu, 2018-07-12 at 11:21 +0200, Stefan Agner wrote:
>> On 10.07.2018 11:11, Marek Vasut wrote:
>> > On 07/10/2018 11:06 AM, Stefan Agner wrote:
>> > > This is one of the situation where states quo is kinda the worst
>> > > situation.
>> > >
>> > > Currently imx_v6_v7_defconfig and mxs_defconfig actually still uses
>> > > CONFIG_FB_MXS.
>> > >
>> > > I understand that you'd rather prefer to move forward. I suggest we do
>> > > it in steps.
>> > >
>> > > In 4.19:
>> > >
>> > > - Change DRM driver.name to mxsfb-drm so we avoid conflicts for now
>> >
>> > But this will break mesa if it depends on mxsfb name for ie. etnaviv
>> > binding.
>>
>> Does it? grep -r -e mxsfb in libdrm and mesa master returns nothing.
>>
>> There is also .name in struct drm_driver, which is already set to
>> mxsfb-drm... Is that the one exposed to user space?
> 
> Running etnaviv+x11 with a renamed mxsfb driver works fine on imx6sx-
> sdb.
> 
> Tools like modetest already need -M mxsfb-drm, the drm_driver.name
> seems to be what matters.

Ok, almost thought so, thanks for the confirmation! So we should be
good.

> 
>> - Remove CONFIG_FB_MXS from imx_v6_v7_defconfig/mxs_defconfig now, and
>> only enable CONFIG_DRM_MXSFB=y
> 
> If one of the drivers is renamed then they can coexist: since the
> bindings are distinct one driver will return a probe error and the
> other will bind successfully. This can even be adjusted so that it
> doesn't even print ugly scary errors.
> 
> This can last until somebody implements support for old bindings in the
> drm driver and then FB_MXS can just be deleted.

Yeah I guess that is what Marek don't want because it promotes using
FB_MXS for longer than needed.

I don't care as much since we anyway use the MXSFB DRM driver. However,
what I really dislike is that a kernel compiled with both drivers
currently leads to MXSFB DRM being unusable (because fbdev gets probed
first). I feel removing the MXS_FB is rather harsh, so I *really* would
love to see the MXSFB DRM driver renamed.

--
Stefan
