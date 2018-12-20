Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE423C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 00:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80E620874
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 00:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eqx/bepx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbeLTAs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 19:48:56 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45327 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbeLTAsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 19:48:55 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so10209041pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 16:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bpgh3LaIIZqSN2FtW8zilyBX+L2ZBtDNpSUHI8eX3Zg=;
        b=eqx/bepxodo/LAMyPE2OsddNcdOV+tZsD2ZDQCTdEgHLAYjeFDCRS5wrIQAqepJAnu
         THMZiCgsxTKWC4UQprawn/i7QLAw0jxuczH0b6HSAT1ZLZnxaj/VuZ0vlSRJcBX9zfTj
         H/4Y559pKw0s8d6h43FzMIzXcbO6iN5V+JI1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bpgh3LaIIZqSN2FtW8zilyBX+L2ZBtDNpSUHI8eX3Zg=;
        b=NyxDK/OJd2zvVvU70YIqj/fkKZPv7mBkz+rpO4pNHBxWu947k3PKuc6g8Tw8+il9e6
         eEd7Xe5jbNJpNztibyL6GHAkC5PyzfvgZ6as4syOrxoWlnxBEEmO8/oFZecDnQR96qwT
         pWGahALPzmAQ4/XdmHhE3US7CBmI9i/BlT7fS7+i/pw11Gl56jWo0fV9odxU1kL5wX6U
         sg6jkqDS70uKcKJ0oKLi6QfdecFe2Eaw860ZFPluOgyZ159mR4nM8Ho2HoBHuDbnf8iE
         MxWtN6AFbgzi5QQoKHuQZXStlSvbsiZlZo7ELDnEavowP1EG+smxwPr20kaz9dxembUB
         T7Ow==
X-Gm-Message-State: AA+aEWYHtkfseKjASyg4/ZWGpoNEak7WnATS/DGw4q9/1lpNWpgv/UEv
        LytmLhR/EI5ljRNjg1ax2kecGg==
X-Google-Smtp-Source: AFSGD/U7dGvauQ2MkLBfrVthWp6YEQfAyac+NqkDTTYgdcLukoeukvXa5YLt6XTzekaBrPSvqKSBqA==
X-Received: by 2002:a63:981:: with SMTP id 123mr4834854pgj.444.1545266934422;
        Wed, 19 Dec 2018 16:48:54 -0800 (PST)
Received: from dragon (61-216-91-114.HINET-IP.hinet.net. [61.216.91.114])
        by smtp.gmail.com with ESMTPSA id h128sm29569468pgc.15.2018.12.19.16.48.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 19 Dec 2018 16:48:53 -0800 (PST)
Date:   Thu, 20 Dec 2018 08:47:40 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Jack Pham <jackp@codeaurora.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] phy: qualcomm: Add Synopsys High-Speed USB PHY
 driver
Message-ID: <20181220004737.GA16635@dragon>
References: <20181127100722.9993-1-shawn.guo@linaro.org>
 <20181127100722.9993-3-shawn.guo@linaro.org>
 <b0d02b1c-cc44-69fe-0765-84caf76eaea1@ti.com>
 <20181204060104.GA11391@dragon>
 <20181217003434.GA7208@dragon>
 <c5ccf173-d0f3-70f4-f8e3-777fd3339b68@ti.com>
 <20181219010733.GA13489@dragon>
 <20181219184938.GC1997@jackp-linux.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219184938.GC1997@jackp-linux.qualcomm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 10:49:38AM -0800, Jack Pham wrote:
> Hi Shawn, Kishon,
> 
> On Wed, Dec 19, 2018 at 09:07:36AM +0800, Shawn Guo wrote:
> > On Tue, Dec 18, 2018 at 07:46:13PM +0530, Kishon Vijay Abraham I wrote:
> > > 
> > > 
> > > On 17/12/18 6:04 AM, Shawn Guo wrote:
> > > > On Tue, Dec 04, 2018 at 02:01:07PM +0800, Shawn Guo wrote:
> > > >> Hi Kishon,
> > > >>
> > > >> On Tue, Dec 04, 2018 at 10:38:19AM +0530, Kishon Vijay Abraham I wrote:
> > > >>> Hi,
> > > >>>
> > > >>> On 27/11/18 3:37 PM, Shawn Guo wrote:
> > > >>>> It adds Synopsys 28nm Femto High-Speed USB PHY driver support, which
> > > >>>> is usually paired with Synopsys DWC3 USB controllers on Qualcomm SoCs.
> > > >>>
> > > >>> Is this Synopsys PHY specific to Qualcomm or could it be used by other vendors
> > > >>> (with just changing tuning parameters)? If it could be used by other vendors
> > > >>> then it would make sense to add this PHY driver in synopsys directory.
> > > >>
> > > >> My knowledge is that this Synopsys PHY is specific to Qualcomm SoCs.
> > > >> @Sriharsha, correct me if I'm wrong.
> > > > 
> > > > Kishon,
> > > > 
> > > > Do you have any further comments on the patches?  We are close the 4.21
> > > > merge window, and I really hope they can hit mainline with 4.21 release.
> > > > Thanks.
> > > 
> > > Aren't we waiting for feedback from Sriharsha?
> > 
> > I think no correction means that I'm right :)
> 
> I'm sorry Sriharsha has not yet responded but I can confirm that this
> PHY driver would only be specific to Qualcomm SoCs simply because of our
> custom register mapping used to control and initialize it. These are
> only defined as as HW signals by the Synopsys IP, which have been
> synthesized to map to our own IO register space. So really it can be
> treated as just a "Qualcomm USB PHY" with acknowledgement that the core
> design is licensed from SNPS.

Thanks much for confirming, Jack.

Shawn
