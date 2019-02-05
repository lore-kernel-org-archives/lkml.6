Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FBAC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7F62073D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLdED7jd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfBEX6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:58:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34175 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfBEX6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:58:17 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so2267882pfg.1;
        Tue, 05 Feb 2019 15:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9f+k7BhPn2vKcdN3lsnEUTRmVrrN+c0fUwov5qTPqb0=;
        b=HLdED7jdHRApo+xi/pvKqgYk+FPqRcOt8vrfVuLduv+hUuYQn2NbbAV8pEXTgGGg8N
         tPi2RD7kmv8HyXv5vzQcZOjohvGKH03qfZe0cCt/w84xXmhRNbDxmiv5NRCztqbB4M+7
         PY0bSNhLIbCTMd8sBW8x5TYkJDY136sWu1doNZWMW3BeMtgN6VvLS8pqjDf8v6h1tede
         SkT5CKejnPzZwUTdHSgqNghTbt/I6vhOzx2AzsaT/nwiqo7nQa9qAfBcvy6hS+Z86+IH
         tmTtB4jOGBRDg05yAet/wOdUBdgzHKM0p3+fnpNRNLTRugob6sv3H+OGcQYsJep37Clt
         Qr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9f+k7BhPn2vKcdN3lsnEUTRmVrrN+c0fUwov5qTPqb0=;
        b=hClbM+Y42pu5ZH2jsuIxz5rk0P349NMZNp5v6jWqQAoffqURUpnR3TR7lYTY0qtaFG
         3UaCGSY06u5H1x8RbqywQThhh+q6K428rcGY49nxipCwDX8SAWvTUkQXlW6lzbuA2Wyq
         xlhBlUEFMpJ1HNqqlGWoKQC+pxw0SxFZoiX7wITHlyggg3zU4ShpR4mt7eoexHjO9uWv
         XudMMpwNkYBiSw8+GNUSQ86xVAkEuARN/XkR6A+TUR6/bdBo8/iIfBkRyr8F4Ge515Us
         5dbY7R2gdACjQaft/vcmAMcMQd3qmbBiL+y2NVwIVm1T/bYHcEoGe9Se+s2hXuyk3mlD
         I+Lw==
X-Gm-Message-State: AHQUAuaWqP2PDbgR6UkZp7TeKZy90itRB389JizMayFPN6yDs+i4oLYY
        NCM5kZgKTQXCLfI4nxgMe2E=
X-Google-Smtp-Source: AHgI3Ib4dqtKsI1s4Y9qjHXWmwWq/ODthcRXI4TNzdgf/2euuPbEhVDEmEdZcyVKE+eCWCOGtxBxzQ==
X-Received: by 2002:a63:4105:: with SMTP id o5mr961840pga.396.1549411096614;
        Tue, 05 Feb 2019 15:58:16 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id h19sm5190647pfn.114.2019.02.05.15.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 15:58:15 -0800 (PST)
Date:   Tue, 5 Feb 2019 15:58:13 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Srinath Mannam <srinath.mannam@broadcom.com>,
        daniel.lezcano@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v6 0/3] Stingray thermal driver support
Message-ID: <20190205235811.GA19687@localhost.localdomain>
References: <1546505734-24527-1-git-send-email-srinath.mannam@broadcom.com>
 <a6113115-453c-4606-f99d-c79263d8f4bb@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6113115-453c-4606-f99d-c79263d8f4bb@broadcom.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Feb 04, 2019 at 04:16:19PM -0800, Ray Jui wrote:
> Hi Zhang/Eduardo,
> 
> Can this patch series be merged? It looks like Srinath has addressed all
> review comments?

I will take a look. Side note, thermal patches are reviewed on
linux-pm@vger.kernel.org. Copying that list it does help because that
is how the patches get assigned in patchwork.kernel.org.

> 
> The following tag should be added to the binding document patch:
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Thanks,
> 
> Ray
> 
> On 1/3/2019 12:55 AM, Srinath Mannam wrote:
> > These patches adds the stingray thermal driver and its
> > corresponding DT nodes with documentation.
> > 
> > Changes from v5
> >   - Addressed Eduardo Valentin comments.
> > 
> > Changes from v4
> >   - Addressed Rob Herring comments on DT parameters and
> >     thermal driver architecture.
> >   - Removed brcm,max-crit-temp DT parameter
> >   - Changed driver to thermal sensor registration model.
> >   - Added trip DT properties.
> > 
> > Changes from v3
> >   - Addressed Daniel lezcano comments.
> >   - Elaborated commit description of thermal driver patch.
> >   - Added brcm,max-crit-temp DT parameter.
> > 
> > Changes from v2:
> >   - All stingray TMON DT nodes are combine together into single.
> >     Temperature registers are combined into one mem resource.
> >     brcm,tmon-mask parameter has available TMONs mask value.
> >   - All available TMONs are initialized together in single
> >     instance of driver probe call.
> > 
> > Changes from v1:
> >   - Fixed auto build sparce warning.
> > 
> > Pramod Kumar (3):
> >   dt-bindings: thermal: Add binding document for SR thermal
> >   thermal: broadcom: Add Stingray thermal driver
> >   arm64: dts: stingray: Add Stingray Thermal DT support.
> > 
> >  .../bindings/thermal/brcm,sr-thermal.txt           | 105 ++++++++++++++++++
> >  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  89 +++++++++++++++
> >  drivers/thermal/Kconfig                            |   3 +-
> >  drivers/thermal/broadcom/Kconfig                   |   9 ++
> >  drivers/thermal/broadcom/Makefile                  |   1 +
> >  drivers/thermal/broadcom/sr-thermal.c              | 122 +++++++++++++++++++++
> >  6 files changed, 328 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
> >  create mode 100644 drivers/thermal/broadcom/sr-thermal.c
> > 
