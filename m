Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752996AbeDLUit convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 16:38:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751624AbeDLUir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 16:38:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08770208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Doug Anderson <dianders@chromium.org>,
        Manu Gautam <mgautam@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <f8f47dc2-74ab-96c6-b3bd-a476bd19514d@codeaurora.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, linux-arm-msm@vger.kernel.org,
        Varadarajan Narayanan <varada@codeaurora.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Fengguang Wu <fengguang.wu@intel.com>
References: <1522321466-21755-1-git-send-email-mgautam@codeaurora.org>
 <1522321466-21755-3-git-send-email-mgautam@codeaurora.org>
 <CAD=FV=XtviSYq=2w=Ld1xq5U2VPy=u=q6a3+4qd2zVGB+f9P8A@mail.gmail.com>
 <CAD=FV=WGEKy98De_zH9rp+g-tE2YuVK2vRxLJrjeeSx=ijBAww@mail.gmail.com>
 <19c66b02-4f8e-902a-9397-21e7690db7b8@codeaurora.org>
 <CAD=FV=XqH69_LXcCyTS1nF5fHpen=PnRxd-WTz=y3dKvMsRtuw@mail.gmail.com>
 <152338515540.180276.4273344163431724770@swboyd.mtv.corp.google.com>
 <f8f47dc2-74ab-96c6-b3bd-a476bd19514d@codeaurora.org>
Message-ID: <152356552631.37499.9860530043266211290@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 2/7] phy: qcom-qmp: Enable pipe_clk before PHY initialization
Date: Thu, 12 Apr 2018 13:38:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manu Gautam (2018-04-11 08:37:38)
> >
> > I ask because it may be easier to never expose these clks in Linux, hit
> > the enable bits in the branches during clk driver probe, and then act
> > like they never exist because we don't really use them.
> This sounds better idea. Let me check if I can get a patch for same in msm8996
> and sdm845 clock drivers.
> 

Ok! Presumably the PHY has a way to tell if it failed to turn on right?
Put another way, I'm hoping these branch bits aren't there to help us
debug and figure out when the PHY PLL fails to lock.
