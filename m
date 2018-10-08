Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BDAC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013332087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IheGDIr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013332087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeJHOHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:07:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33976 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbeJHOHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:07:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so7911480pfi.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 23:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j9nVHROjuNORktCwtIAwQgdXuVLTmNQRZZ82/HFOBXY=;
        b=IheGDIr8tzRwSgI3Ee+0dc1rYUN2pTtMJRPUVR8MGAmgsnewZSSQjL6wlI35kH5CjN
         aBZHRnvR7mf06X7VMOu95Yh0HkqT/0QCX/MUhHi5llit0HgGamAIxWITAl1mohAz7R/3
         7+McZSKI8J7h5khrOUxMqagfhogQjIGH3I35s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j9nVHROjuNORktCwtIAwQgdXuVLTmNQRZZ82/HFOBXY=;
        b=qloQ1yC6PLLtymptnn40M+9I8MaGjKqL8i+Kk+iVVtUlZ2wzOKb2lN+85iCdwBKJT4
         V/Z1M/a3lSvYrWJZ17zHd01lT6mXGVua7YURqkWZ8a4u/lo0XxU/34qOsdmZhvG8QW59
         sfJmyU2vsE3PESsf5aiV6L+Zlo1aIxmXZeUNdR6R3p+w/FrfuelCH3f5cAztG8CZ/z0m
         2bvMMDU+Y7yve8Q1osJjAwxnxOF6EtyqWupyKMOnCr41/HRvqDAspGAkmeAHb8OgpK38
         OJJK+c8W06feT+mEQFu3BHcevK9h6PdTwnKr6O5Nbvb5XAWLTMTKAk7r9EMsddaqAG75
         yV6g==
X-Gm-Message-State: ABuFfoj2KuhptkHyTgMDQHwqZWUc6nrfsgCnu5oIm9VgejBRYD57HGWe
        Lx4HnuoEvwvfDaE3bvoo8XFHtw==
X-Google-Smtp-Source: ACcGV63SBc0a/7ng6wNs2hYRKooE4A91bfuejODVmeELPS11LfERk+L8TxsEfJQ0bpJwPa6wUygj2g==
X-Received: by 2002:a62:a0e:: with SMTP id s14-v6mr23623652pfi.153.1538981817614;
        Sun, 07 Oct 2018 23:56:57 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s85-v6sm26277949pfi.15.2018.10.07.23.56.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 23:56:56 -0700 (PDT)
Date:   Sun, 7 Oct 2018 23:56:53 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Craig <ctatlor97@gmail.com>
Cc:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Vijay Viswanath <vviswana@codeaurora.org>,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org,
        georgi.djakov@linaro.org, devicetree@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        venkatg@codeaurora.org, jeremymc@redhat.com,
        riteshh@codeaurora.org, dianders@google.com, sayalil@codeaurora.org
Subject: Re: [PATCH V3 0/4] Changes for SDCC5 version
Message-ID: <20181008065653.GB2550@tuxbook-pro>
References: <1529386761-4923-1-git-send-email-vviswana@codeaurora.org>
 <20180924194412.GA27477@arch>
 <bcdeaf0c-fb04-67f5-8580-a3f5110bcba5@codeaurora.org>
 <C01C1C07-13FA-4693-9493-2FAEE9153577@gmail.com>
 <74ABB71C-6B0C-44AE-BC30-1F385ADC3E42@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74ABB71C-6B0C-44AE-BC30-1F385ADC3E42@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 07 Oct 01:07 PDT 2018, Craig wrote:

> Any updates on this?
> 

FWIW I used qcom,sdhci-msm-v5 on QCS404 successfully.

Regards,
Bjorn

> On 25 September 2018 16:39:33 BST, Craig <ctatlor97@gmail.com> wrote:
> >
> >
> >On 25 September 2018 12:17:26 BST, Veerabhadrarao Badiganti
> ><vbadigan@codeaurora.org> wrote:
> >>
> >>On 9/25/2018 1:18 AM, Craig Tatlor wrote:
> >>> What socs have you tested this on?
> >>> On sdm660 it seems to crash device
> >>> when writing pwr ctl.
> >>
> >>Hi
> >>We have tested this on SDM845.
> >>SDM660 also has SDCC5 controller, so you would need to define
> >>"qcom,sdhci-msm-v5" in your platform dt.
> >>Can you confirm if you have defined this?
> >>
> >Hi,
> >Yes my DT entry is as follows
> >
> >sdhc_1: sdhci@f9824900 {                                               
> >                  
> >compatible = "qcom,sdhci-msm-v5";                                      
> >          
> >reg = <0xc0c4000 0x1000>, <0xc0c5000 0x1000>;                          
> >          
> >interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;                        
> >          
> >interrupt-names = "pwr_irq";                                           
> >          
> >                                                                       
> >bus-width = <8>;                                                       
> >          
> >non-removable;                                                         
> >          
> >                                                                       
> >vmmc-supply = <&pm660l_l4>;                                            
> >          
> >vqmmc-supply = <&pm660_l8>;                                            
> >          
> >                                                                       
> >pinctrl-names = "default";                                             
> >          
> >pinctrl-0 = <&sdc1_clk &sdc1_cmd &sdc1_data &sdc1_rclk>;               
> >          
> >                                                                       
> >clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;          
> >          
> >clock-names = "core", "iface";                                         
> >          
> >        };          
> >
> >>BTW, can you please share few details of the platform that you are
> >>checking?
> >>We are not aware of any dev platform based on SDM660. This is just for
> >
> >>my info
> >
> >I'm checking on the sony xperia xa2 (pioneer) smartphone.
> >>
> >>> On Tue, Jun 19, 2018 at 11:09:17AM +0530, Vijay Viswanath wrote:
> >>>> With SDCC5, the MCI register space got removed and the offset/order
> >>of
> >>>> several registers have changed. Based on SDCC version used and the
> >>register,
> >>>> we need to pick the base address and offset.
> >>>>
> >>>> Depends on patch series: "[PATCH V5 0/2] mmc: sdhci-msm:
> >Configuring
> >>IO_PAD support for sdhci-msm"
> >>>>
> >>>> Changes since RFC:
> >>>> 	Dropped voltage regulator changes in sdhci-msm
> >>>> 	Split the "Register changes for sdcc V5" patch
> >>>> 	Instead of checking mci removal for deciding which base addr to
> >>use,
> >>>> 	new function pointers are defined for the 2 variants of sdcc:
> >>>> 		1) MCI present
> >>>> 		2) V5 (mci removed)
> >>>> 	Instead of string comparing with the compatible string from DT
> >>file,
> >>>> 	the sdhci_msm_probe will now pick the data associated with the
> >>>> 	compatible entry and use it to load variant specific address
> >>offsets
> >>>> 	and msm variant specific read/write ops.
> >>>>
> >>>> Changes since V1:
> >>>> 	Removed unused msm_reab & msm_writeb APIs
> >>>> 	Changed certain register addresses from uppercase to lowercase hex
> >>>> 	letters
> >>>> 	Removed extra lines and spaces
> >>>> 	Split "[PATCH V1 0/3] Changes for SDCC5 version" patch into two,
> >>>> 	one for Documentation and other for the driver changes.
> >>>>
> >>>> Changes since V2:
> >>>> 	Used lower case for macro function defenitions
> >>>> 	Removed unused function pointers for msm_readb & msm_writeb
> >>>>
> >>>>
> >>>> Sayali Lokhande (3):
> >>>>    mmc: sdhci-msm: Define new Register address map
> >>>>    Documentation: sdhci-msm: Add new compatible string for SDCC v5
> >>>>    mmc: host: Register changes for sdcc V5
> >>>>
> >>>> Vijay Viswanath (1):
> >>>>    mmc: sdhci-msm: Add msm version specific ops and data structures
> >>>>
> >>>>   .../devicetree/bindings/mmc/sdhci-msm.txt          |   7 +-
> >>>>   drivers/mmc/host/sdhci-msm.c                       | 511
> >>++++++++++++++++-----
> >>>>   2 files changed, 391 insertions(+), 127 deletions(-)
> >>>>
> >>>> -- 
> >>>>   Qualcomm India Private Limited, on behalf of Qualcomm Innovation
> >>Center, Inc.
> >>>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> >a
> >>Linux Foundation Collaborative Project.
> >>>>
> >>>> --
> >>>> To unsubscribe from this list: send the line "unsubscribe
> >>linux-arm-msm" in
> >>>> the body of a message to majordomo@vger.kernel.org
> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>Thanks,
> >>Veera
> 
> -- 
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
