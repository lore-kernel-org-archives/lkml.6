Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68324C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3186320850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D36KZ2/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3186320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937214AbeFSCRv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 22:17:51 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33012 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937186AbeFSCRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 22:17:48 -0400
Received: by mail-pl0-f68.google.com with SMTP id 6-v6so9525299plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 19:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nr4k1zPfTqbOioUwGYOPQNwHBYF9KaDEilQszAqDKIU=;
        b=D36KZ2/Fwzbmm2T7oeaOS/X1fvjEAbCPCh7UvzHMYXhKZaC4CZxgEwD9fThgNppZj5
         SpnhSEGYtdurXh+9bAVGeFW5Pn6j6bd9W0ByOcUyArUPaurPxnEVYbszOMHlecbZB8Qa
         dkb/fvleAh5TIV1rrLay9Jqvd4Hlpc0+TjPxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nr4k1zPfTqbOioUwGYOPQNwHBYF9KaDEilQszAqDKIU=;
        b=YEdbc7VQ49PXsomeSLRCRYRljabZxpUIFNTa+Lfi+ukoIjikZiv9sASuZw15VPbDAj
         omzEmILrN5L4Py5D0fZgERFpCvssJ8X1H9lpZEzV39kEYDBe6kN6OHEE7ETW8D6KeS7r
         dXdFCi8/GP7GOlRfYpHARwoeQ/xmwP1sufllfg2O3pAFm2/8B0zASj0M8ieOo/G0Z21U
         nyqe0dhy2PbnMiYXc2nfe7oTy1CmxbF2zHGKTMMSmIOD0FmjRBfMwcPviakQ01NIUQaq
         I/ptm6HVXMRJBmHtHTOwJAudvLy5HWOBkWMC/0lJVRXPBgyjIvxG6nRQ0TNGE04lXjjt
         JX+A==
X-Gm-Message-State: APt69E3Smi8S/YuE1YahQIf7nOjX7NOoorXVhf1KjKIoRx+6UYeX9EY0
        LgEadteWHaAEva5dzIX9xVZheQ==
X-Google-Smtp-Source: ADUXVKIcd6aCdv2MuWeTQAWqHsbir+koejky4i9ZOXcWQXdiqdNVpqlt/JXSo98TY1E0zL97VM503g==
X-Received: by 2002:a17:902:3041:: with SMTP id u59-v6mr16711387plb.208.1529374668244;
        Mon, 18 Jun 2018 19:17:48 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id z74-v6sm31445719pff.54.2018.06.18.19.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 19:17:46 -0700 (PDT)
Date:   Mon, 18 Jun 2018 19:17:44 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Govind Singh <govinds@codeaurora.org>
Cc:     andy.gross@linaro.org, bjorn.andersson@linaro.org,
        david.brown@linaro.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6]  *** Add support for wifi QMI client driver ***
Message-ID: <20180619021742.GA17220@rodete-desktop-imager.corp.google.com>
References: <20180605123304.31969-1-govinds@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605123304.31969-1-govinds@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Govind,

One more side note: this series is called v2, but I see an older v3.
What's up with that?

On Tue, Jun 05, 2018 at 06:03:04PM +0530, Govind Singh wrote:
> Add QMI client driver for Q6 integrated WLAN connectivity subsystem.
> This module is responsible for communicating WLAN control messages to FW
> over QMI interface.
> 
> QUALCOMM MSM Interface(QMI) provides the control interface between
> components running b/w remote processors with underlying transport layer
> based on integrated chipset(shared memory) or discrete chipset(PCI/USB/SDIO/UART).

So this seems to imply QMI would work with transports that are not
integrated. Except, your code is directly calling SNOC (one of your
integrated chipset interfaces) code from the QMI driver. Correct? I
suppose that's OK for now, but it's a little misleading. If you actually
intend this to support multiple transports, then you might instead want
a callback interface for this.

> QMI client driver implementation is based on qmi frmework https://lwn.net/Articles/729924/.
> 
> Below is the sequence of qmi handshake.
> 
>        QMI CLIENT(APPS)                                         QMI SERVER(FW in Q6)
> 
>                          <------wlan service discoverd----
> 
>                        -----connect to wlam qmi service----->
> 
>                        ------------wlan info request----->
> 
>                        <------------wlan info resp------------
> 
>                        ------------msa info req-------->
> 
>                      <------------msa info resp------------
> 
>                      ------------msa ready req-------->
> 
>                      <------------msa ready resp------------
> 
>                      <------------msa ready indication-------
> 
>                      ------------capability req------->
> 
>                     <------------capability resp------------
> 
>                     ------------qmi bdf req--------->
> 
>                      <------------qmi bdf resp------------
> 
>                       ------------qmi cal trigger------->
> 
>                   <------------ QMI FW ready indication-------

Let's see if I'm interpreting this right:

 * The above process is just initiating a handshake with the QMI
   service and doesn't actually do any loading of firmware on its own;
   it just hands things off to the SNOC client driver (and ath10k core)
   once the firmware is magically ready (??)
 * The ATH10K_FW_FEATURE_NON_BMI flag you added previously basically
   provides a way for a driver (and now we see which driver; it's this
   QMI / SNOC driver) to completely sidestep the typicaly in-kernel
   firmware load implementation; in fact, the kernel only reads the
   WLAN firmware just to parse some feature flags, not to actually
   program it to the device
 * Some yet-unmentioned proprietary app is involved to handle
   sideloading the actual firmware from user space

Is this correct? If not, please correct me. But if it is:

 * When does the user space app actually load the WLAN firmware? I'm not
   sure I can place it in the above diagram.
 * Is there any open source implementation of this? How am I supposed to
   actually use this driver, if it relies on proprietary components that
   I can't review and aren't really even mentioned?

I hope I'm sorely wrong on this. But if I'm not, I don't see why this
driver should be merged at all. Linux drivers should be self-sufficient
wherever possible, and I don't see a good reason why this driver can't
manage actually loading the WLAN firmware on its own, similar to how the
BMI component of the ath10k driver loads firmware for other ath10k
transports. But even more importantly: I believe this driver is hiding
the fact that it relies on undocumented proprietary components to run on
the CPU [1] just to make use of it at all.

Brian

[1] It's an unfortunate fact of life that Wifi (and in this case,
modem+Wifi) processors will run proprietary firmware, but it's not
accepted that Linux relies on proprietary user space.

> Changes in V2:
> 	Removed qmi client driver and integrated qmi client handshakes in snoc platform driver.
> 	Addressed comments v1 version.
> 	Switched to ath10k bdf download infra(board-2.bin)
> 	Added MSA fixed region support to support unload use-case.
> 	Unified logging.
> 
> Testing:
> 	Tested all qmi handshakes, driver load/unload and STA/SAP sanity testing.
> 	Tested HW: SDM845(WCN3990)
> 	Tested FW: WLAN.HL.2.0-01192-QCAHLSWMTPLZ-1
> 
> 
> 
> Govind Singh (5):
>   ath10k: Add qmi service helpers for wcn3990 qmi client
>   dt: bindings: add bindings for msa memory region
>   ath10k: Add debug mask for QMI layer
>   firmware: qcom: scm: Add WLAN VMID for Qualcomm SCM interface
>   ath10k: Add QMI message handshake for wcn3990 client
> 
> Rakesh Pillai (1):
>   ath10k: Add support to create boardname for non-bmi target
> 
>  .../bindings/net/wireless/qcom,ath10k.txt     |    4 +
>  drivers/net/wireless/ath/ath10k/Kconfig       |   13 +-
>  drivers/net/wireless/ath/ath10k/Makefile      |    4 +-
>  drivers/net/wireless/ath/ath10k/core.c        |   20 +-
>  drivers/net/wireless/ath/ath10k/core.h        |    4 +
>  drivers/net/wireless/ath/ath10k/debug.h       |    1 +
>  drivers/net/wireless/ath/ath10k/qmi.c         | 1030 ++++++++
>  drivers/net/wireless/ath/ath10k/qmi.h         |  136 ++
>  .../net/wireless/ath/ath10k/qmi_wlfw_v01.c    | 2072 +++++++++++++++++
>  .../net/wireless/ath/ath10k/qmi_wlfw_v01.h    |  677 ++++++
>  drivers/net/wireless/ath/ath10k/snoc.c        |  209 +-
>  drivers/net/wireless/ath/ath10k/snoc.h        |    3 +
>  include/linux/qcom_scm.h                      |    4 +-
>  13 files changed, 4160 insertions(+), 17 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath10k/qmi.c
>  create mode 100644 drivers/net/wireless/ath/ath10k/qmi.h
>  create mode 100644 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.c
>  create mode 100644 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h
> 
> -- 
> 2.17.0
> 
