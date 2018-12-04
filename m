Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CF0C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1442146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 06:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MfxZZhdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1442146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbeLDGBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 01:01:46 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43434 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbeLDGBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 01:01:45 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so7657677pfk.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 22:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e0bNoJsWocsWkMLsan8gni19LGgZzxRmL3EJnTyZsCA=;
        b=MfxZZhdI+Iw3hswSDbKjkGjZzR2s9bCYCCNa9aw2gR3h+68+7riVcQ4y6GjZAUawKs
         a3sVm7P6ECfVQN9SrZy07NlDAWeSw9hOJ9eyXhv97rI7SbpqiRYo54mcKO4MjuEeyqr9
         yk4jYHXoae5oGzLIvD7sx3RKKF0dNnyl0SUEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e0bNoJsWocsWkMLsan8gni19LGgZzxRmL3EJnTyZsCA=;
        b=LTEwrtxKPbqlyeIEIDyt506r0v0ctTj/NBN5YAS+5DaTi2aoktN8JPNeqvz33DEhqW
         yEWn8JTYVzNa9gzY7hjwyHif4iaRCd/UtnVt9he+acJu1wzpZeggunaLBBEm4RzgENkg
         wIO72ZsuosTCQksDcqJU/03uKgwlFOtTtKKRnIXLPYUUoUvvUAukbp7uaDVaXrkJNbtz
         iusv2vd0G95tTTVrxrY4JzFt4olbMYeTSWRffsbQuxWpKk27Xwgd0vKE/Bx7PRtAJw36
         PqzINfu2Pt4ZWanEW5ga4yV9Jb7e3CPRqx/cpwz9paB3NRxPp/obYZq5MUzTGI5kUru/
         071g==
X-Gm-Message-State: AA+aEWbwp8Vs/azVL3mjASUhfjJiyJjqGLA3V6JlT8vZTpa5/CWSkxsY
        0DZIshmR8eRWTlsGgoMt4WBi2KQB8co=
X-Google-Smtp-Source: AFSGD/XdhtzidtKWS+T9qXLJNBodD2qO/GQrtwn8Vj/NnyEVH3rcihKaGsSU34Yb26QDzSh/ZL5yBg==
X-Received: by 2002:a62:c28e:: with SMTP id w14mr18770850pfk.115.1543903304637;
        Mon, 03 Dec 2018 22:01:44 -0800 (PST)
Received: from dragon (61-216-91-114.HINET-IP.hinet.net. [61.216.91.114])
        by smtp.gmail.com with ESMTPSA id 4sm26061425pfq.10.2018.12.03.22.01.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Dec 2018 22:01:43 -0800 (PST)
Date:   Tue, 4 Dec 2018 14:01:07 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] phy: qualcomm: Add Synopsys High-Speed USB PHY
 driver
Message-ID: <20181204060104.GA11391@dragon>
References: <20181127100722.9993-1-shawn.guo@linaro.org>
 <20181127100722.9993-3-shawn.guo@linaro.org>
 <b0d02b1c-cc44-69fe-0765-84caf76eaea1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0d02b1c-cc44-69fe-0765-84caf76eaea1@ti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

On Tue, Dec 04, 2018 at 10:38:19AM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On 27/11/18 3:37 PM, Shawn Guo wrote:
> > It adds Synopsys 28nm Femto High-Speed USB PHY driver support, which
> > is usually paired with Synopsys DWC3 USB controllers on Qualcomm SoCs.
> 
> Is this Synopsys PHY specific to Qualcomm or could it be used by other vendors
> (with just changing tuning parameters)? If it could be used by other vendors
> then it would make sense to add this PHY driver in synopsys directory.

My knowledge is that this Synopsys PHY is specific to Qualcomm SoCs.
@Sriharsha, correct me if I'm wrong.

Shawn
