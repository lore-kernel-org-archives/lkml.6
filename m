Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960CDC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B46C216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="af1BrsZk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B46C216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbeI1DET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:04:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45666 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbeI1DET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:04:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id t70-v6so2764787pgd.12;
        Thu, 27 Sep 2018 13:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HStFA5SnE7vrI0jwGOVUVgwG0dcEQ0TIBR37yh7VvxI=;
        b=af1BrsZkEC1AfyWWuuukSfumJwpYMdUdE03Qofgruaeouh9JIFnQ41jjCfY14zwasm
         NImYeEPqvt8MDCmmpwH4l4hF0VvK7cXMDVMfiuxCqgeHRka7j1nmufBLSXM6yibSGel2
         XO2UnxnoUZupilfp73U197DA8yhiNOxaBE5jVJedW1VmH9hOHGWxxRerxxyOTPRt8q/5
         vnb/z0DNsSHF+rY9ssXPBw8RrQSJKRQEto2uNiWvvtAvzU2DW7BA37HEYmer0aj7Igvz
         Bq26B+LM1AmVNe3sr1Tzt8ISqSnt3hl4xcLwJOwdoQL8Dn16mL2K101fP+1a8NmhoZNe
         k3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HStFA5SnE7vrI0jwGOVUVgwG0dcEQ0TIBR37yh7VvxI=;
        b=D8iQMBuBAQYHmbpr78kS/8YkF25fTDRW7f9z/TuWHoP+tQp8vSaJ7Zha/bBwbCOiXg
         r4laAfFCoZpYkKRE8QGVe7CgyRJz2G+96sMQ8fpzmK2CtvjVDBrNbjeYYpr4oMWnBlB7
         lv++ixenq+dTim1+In2CmzVmsPB2VkM65SOEuK8VdfgbkmZNPZHLvtfZOThYhMBvM4t1
         5shxAE8u9cW1Pg2z2FaKlQ+V9ivQfK4lUCS9Q2wML+hVs3D+GJRh+lZ5m5+eu6x7726c
         4PXtxkrsxnCefIKZQltpR6c3NwF3whIGctQLE4IRK1exo8Fl8zDiDgqnV0h2itZdaq0s
         6qQg==
X-Gm-Message-State: ABuFfoiKRNyGVw2tzWk8GsL4XgOjejnxs7wDsX+jpq53Brr8aMHBLy/M
        Hb96zhXdgSI8IwAQm1dl9ExKfQ/I
X-Google-Smtp-Source: ACcGV639FKn4NkY+XTcGyYrkitd439MGQToJ+MxE15w/WEu+CE/AySbnpsf6ytcIwt4c8z644+96zg==
X-Received: by 2002:a62:5950:: with SMTP id n77-v6mr8805305pfb.0.1538081051668;
        Thu, 27 Sep 2018 13:44:11 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id u79-v6sm6242792pfd.117.2018.09.27.13.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 13:44:11 -0700 (PDT)
Date:   Thu, 27 Sep 2018 13:44:07 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Andrew F. Davis" <afd@ti.com>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: hwmon: Add ina3221 documentation
Message-ID: <20180927204407.GB20923@Asurada-Nvidia.nvidia.com>
References: <20180927194910.18464-1-nicoleotsuka@gmail.com>
 <20180927194910.18464-2-nicoleotsuka@gmail.com>
 <CAL_JsqLcuJyjHFzW7-p4HAZq3g5tGAo0wT8f5ZT_KYWV5X5+5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLcuJyjHFzW7-p4HAZq3g5tGAo0wT8f5ZT_KYWV5X5+5A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 03:38:44PM -0500, Rob Herring wrote:
> On Thu, Sep 27, 2018 at 2:49 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > Texas Instruments INA3221 is a triple-channel shunt and bus
> > voltage monitor. This patch adds a DT binding doc for it.
> >
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> > Changelog
> > v5->v6:
> >  * Removed status property as no need to explicitly list it.
> >  * Combined all examples into a complete one.
> 
> Sorry, I meant combine the parent and child nodes into one. Showing 3
> children is perfectly fine as the device has 3 channels.

Sending v7.

Thanks
Nicolin
