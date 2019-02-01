Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EA5C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AEF821872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfBAMOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:14:51 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58946 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbfBAMOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:14:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C522980D;
        Fri,  1 Feb 2019 04:14:50 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47E523F59C;
        Fri,  1 Feb 2019 04:14:48 -0800 (PST)
Date:   Fri, 1 Feb 2019 12:14:45 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jolly Shah <JOLLYS@xilinx.com>
Cc:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andy.gross@linaro.org" <andy.gross@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        Michal Simek <michals@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/3] drivers: soc: xilinx: Add ZynqMP PM driver
Message-ID: <20190201121445.GD10042@e107155-lin>
References: <1548794301-30483-1-git-send-email-jollys@xilinx.com>
 <1548794301-30483-4-git-send-email-jollys@xilinx.com>
 <20190130101236.GA27201@e107155-lin>
 <BYAPR02MB59926CC0829613B4B52A7D3EB8910@BYAPR02MB5992.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR02MB59926CC0829613B4B52A7D3EB8910@BYAPR02MB5992.namprd02.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 07:01:05PM +0000, Jolly Shah wrote:
> >
> > NACK, if this is for system suspend/reset ? You can just use exiting
> > sysfs, no need to create Xilinx specific new ones. Moreover you need to
> > use PSCI to make sure higher ELs can do orderly suspend/shutdown.
> >
>
> We have power off suspend mode which is not supported by existing sysfs and
> hence new one is needed. Suspend is handled through PSCI interface only.
>

I see only 2 cases supported SUSPEND_SYSTEM_SHUTDOWN and
SUSPEND_POWER_REQUEST. Both are already support so my NACK still stands.

--
Regards,
Sudeep
