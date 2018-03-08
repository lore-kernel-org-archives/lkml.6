Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934475AbeCHBcx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 20:32:53 -0500
Received: from mail-pl0-f46.google.com ([209.85.160.46]:33316 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934175AbeCHBcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 20:32:51 -0500
X-Google-Smtp-Source: AG47ELsHiVeiwI7UWFpAlLqs59RGEeJ5YpUB4bV31mGckJTy0B/w0RLNv+qJwj0P8DvCLMB5EfPmSg==
Date: Thu, 8 Mar 2018 09:32:11 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pengcheng Li <lpc.li@hisilicon.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: add bindings doc for HiSilicon INNO
 USB2 PHY
Message-ID: <20180308013208.GJ28619@dragon>
References: <1520217605-9312-1-git-send-email-shawn.guo@linaro.org>
 <1520217605-9312-2-git-send-email-shawn.guo@linaro.org>
 <20180307211118.su2vyfa4zyfh4w2t@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307211118.su2vyfa4zyfh4w2t@rob-hp-laptop>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 03:11:18PM -0600, Rob Herring wrote:
> > +Example:
> > +
> > +perictrl: peripheral-controller@8a20000 {
> > +	compatible = "hisilicon,hi3798cv200-perictrl", "syscon",
> > +		     "simple-mfd";
> 
> Is syscon needed here? Doesn't look like the phys need it.

For phys, "syscon" is not needed, but there are other devices to be
added which will need to access perictrl as syscon.  Anyway, I can drop
"syscon" from the example in this bindings doc to avoid the confusion.

> Is there no dependency on the peri ctrl probing first for the phys to 
> probe successfully? If there is some dependency, simple-mfd should not 
> be used.

No, there is no such dependency.  Right now the perictrl is there only
for populating the phy devcies.

> As for the phy binding,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks.

Shawn
