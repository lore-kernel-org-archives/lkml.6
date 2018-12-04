Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E72C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91880214C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hKoN2aik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91880214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbeLDUFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:05:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43835 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbeLDUFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:05:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so17267203wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 12:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=7WH9JoQsx+LrhFCXwbF/NWnFA3rwkd4OelYwW8l6xp0=;
        b=hKoN2aikVpRjyNb8oSh9ixndigMRZl11ufnqkBhIKtXGsPtQSh0U3b0wrni/fAD7tv
         VRrxL8Y+eudzYumkgwcrihWXC6ucmsHEiK76WZB6k6i59cu3JXMKFvnttOgC40fKbszZ
         lmIz+pHtX+cH9+4tHqU6a4+vDz1CgpCQcWKq/0uGqYTw8mvwMwPeP/Pxf71aXOY1wPUD
         ODnPOinYQwUuL1CblksbONRkNXYbsJv6VM4j5RuYNhor7LQj+Hg7LT0sNIw2B1McDblm
         E/KU+O7P4zWj+39GbV/Sp5ba0WmljrN8Wvb342HOo/WQZSnbbJr/TNivFWPHu0OrQjAL
         bRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=7WH9JoQsx+LrhFCXwbF/NWnFA3rwkd4OelYwW8l6xp0=;
        b=LaP3pPuvSKjmkUutf+AppiX1z4U3MD4hyxWxNhvECAojt91G31pjBelTFYES78H/Th
         d9nAKhZWWwG9/zFG5vbAOp3p7mHg2ALnqXrzAPzKbAOn3pg6CqBI4mx315PInkeoDMjH
         3DFnF7sfd5EiNCaY2jHgaPLMPrinMXxof/YYn/Z8xVYzdVfAAyBRxcB1Uy273ax9dELu
         18zvP/TSTLjqc1mlXDnM9Tz1HueW3eNlkC6DfkvLt04JQSxdBvCV+XYeumPEQDaQeUZN
         KZgQti2YegdADHBVNrLxyvZFqUeSaFMF1OaUYq+6BLFXBhKYJ0kqu3D8dJtyg9yXs/gO
         eQXw==
X-Gm-Message-State: AA+aEWYdXKhU2f1CIOVM3uf32nVo2sGskOYaxtqoABUUq38D7D8yZOmv
        uv3vGsqnjN8Ke04E60gA5CKNVA==
X-Google-Smtp-Source: AFSGD/WAu9R1GRTlJrL0Zb50WTZLNjbk8WFhs2XnaX/wrvCXD4dnHMBMkFJm2nZJOC0MlQf3y5LaBw==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr18768268wrs.290.1543953904416;
        Tue, 04 Dec 2018 12:05:04 -0800 (PST)
Received: from boomer.baylibre.com (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id c12sm12055655wrs.82.2018.12.04.12.05.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 12:05:03 -0800 (PST)
Message-ID: <2341ec89691f6221bab6a9696ed0c05c3d3de663.camel@baylibre.com>
Subject: Re: [PATCH] clk: meson-gxbb: switch video clocks mux tables to
 static
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 04 Dec 2018 21:05:02 +0100
In-Reply-To: <5C06D686.50108@baylibre.com>
References: <20181204125839.14505-1-narmstrong@baylibre.com>
         <154394543049.88331.11854270462393390489@swboyd.mtv.corp.google.com>
         <5C06D686.50108@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-04 at 20:33 +0100, Neil Armstrong wrote:
> Hi Stephen,
> 
> Le 04/12/2018 18:43, Stephen Boyd a écrit :
> > Quoting Neil Armstrong (2018-12-04 04:58:39)
> > > Makes the following sparse warnings silent:
> > > drivers/clk/meson/vid-pll-div.c:58:26: warning: symbol '_get_table_val'
> > > was not declared. Should it be static?
> > > drivers/clk/meson/gxbb.c:1585:12: warning: symbol
> > > 'gxbb_vid_pll_parent_names' was not declared. Should it be static?
> > > drivers/clk/meson/gxbb.c:1620:12: warning: symbol
> > > 'gxbb_vclk_parent_names' was not declared. Should it be static?
> > > drivers/clk/meson/gxbb.c:1980:12: warning: symbol
> > > 'gxbb_cts_parent_names' was not declared. Should it be static?
> > > drivers/clk/meson/gxbb.c:2036:12: warning: symbol
> > > 'gxbb_cts_hdmi_tx_parent_names' was not declared. Should it be static?
> > 
> > I fixed all of these already in the patch I sent you.
> 
> Sorry I misunderstood...
> 
> 
> > > @@ -1983,7 +1983,7 @@ static struct clk_fixed_factor gxbb_vclk2_div12 =
> > > {
> > >  };
> > >  
> > >  static u32 mux_table_cts_sel[] = { 0, 1, 2, 3, 4, 8, 9, 10, 11, 12 };
> > 
> > I was talking about this mux_table_cts_sel array. Can this be const?
> > 
> 
> Other mux tables aren't const, Jerome so you see a reason why they aren't
> const ?

I'm surpised we missed that. The PLL params tables of amlogic are all 'static
const' but all the mux tables are just 'static' , humm

[...] 5 min later [...]

Actually the table field of clk_mux is not const, so giving it a const table
would produce a warning about discarding const qualifier

I guess there should no problem adding const to the table field of struct
clk_mux. What do you think Stephen  ?

> 
> Neil


