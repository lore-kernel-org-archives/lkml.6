Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF29C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC06208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaKmDI0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC06208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbeGaJw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 05:52:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34088 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeGaJw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 05:52:56 -0400
Received: by mail-wm0-f65.google.com with SMTP id l2-v6so10359413wme.1;
        Tue, 31 Jul 2018 01:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/1vJWqKcPnI6xic6IfCiyKR7Y9Vabo63VRGWMa9bIak=;
        b=VaKmDI0gp3pSBeYWjRnFckwGT4AUe1efHyBGn7LFj+/USSdZ1dZA6XpjB4weWrD0By
         ZbS/aGbP0Sgy2a3O9xBPdRtIA+cdl4P0z11KYFzV6MjeILw1TJaTf6bd7NZjEi/rQzSu
         TH5bDAQfW5zZgujgS1rADNVQXrB1wBEpZR3VFIAFsWQqfOSggCWsjxTup5FdPculh5oQ
         yB/Gk20PXUVaPPIp35LITyvcTtYVxn06AtVLSJv3A2rdIdnQAxZRYE9oRoNN61W1O4/m
         LNn5XgfiPlSh4K/axesuxQUArWRG4pptqaz4LvOkD1+4No+6UXTjDNsc2j0koGG+ubzF
         x5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/1vJWqKcPnI6xic6IfCiyKR7Y9Vabo63VRGWMa9bIak=;
        b=TvOA+yTR56AEtAnt4uURNw7WbcSB0fWNXxDEdtxgDp8HkdgQTP4HV+fVwovvQr+qUC
         QX0l4JPLyS2v2Jr3c19B5Fvi5O++QnRThncWrC6g5cfICmS71MnKXEbRiPyPHp33fH7s
         l1+MrUgQbFj/c/bQSKEp0L6NTJLzaQ+TQAi7uUf/E54PPTQq/PScwCCx0VjBA5fFW7EU
         BbEUW9fAF+/q29z4UEbo1+1EgecztkSaSm6/MXutxmEkQ1KfgBIGZpkPe/JuomYG5mbQ
         OEhFcypPcSumeXdTf0iYZEpok36+8rZ7AjbShDTXeZkLbegwiCmU0d8PHsxZpkNos2IM
         wylA==
X-Gm-Message-State: AOUpUlECuXXrAlKPHjeUbKXaFHE40ZJYBFYAxoyHbeHKJQP2pT1LneC7
        PnZ3HDv3nn9xn5UBRdSxbxQ=
X-Google-Smtp-Source: AAOMgpeyUs6AcQld0ATrktxJnWcb7PqTJUcU5eq60Jmib7k6J5K2bMuh4cqzovHTOBuxWfpCm7FIGg==
X-Received: by 2002:a1c:b143:: with SMTP id a64-v6mr1675864wmf.114.1533024825401;
        Tue, 31 Jul 2018 01:13:45 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id j8-v6sm21177392wrn.50.2018.07.31.01.13.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 01:13:44 -0700 (PDT)
Date:   Tue, 31 Jul 2018 10:13:42 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Frederick Lawler <fred@fredlawl.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mayurkumar.patel@intel.com, rajatxjain@gmail.com,
        Richard Hughes <rhughes@redhat.com>,
        Carlos Garnacho <cgarnach@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Takashi Iwai <tiwai@suse.de>,
        Andy Whitcroft <apw@canonical.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH v2] pci/aspm: Remove CONFIG_PCIEASPM_DEBUG
Message-ID: <20180731081342.4m3wckxdbgtdyeyo@pali>
References: <20180508230148.121852-1-rajatja@google.com>
 <20180510233912.96454-1-rajatja@google.com>
 <20180727202619.GD173328@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180727202619.GD173328@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 July 2018 15:26:19 Bjorn Helgaas wrote:
> [+cc Rafael, Richard, Carlos, Pali, Takashi, Andy, Colin for question
> about how to expose ASPM power management in sysfs]
> 
> On Thu, May 10, 2018 at 04:39:12PM -0700, Rajat Jain wrote:
> > ...
> > And some suggestions from Bjorn here:
> > https://www.spinics.net/lists/linux-pci/msg60541.html
> > 
> > This patch picks up one of the suggestion, to remove the
> > CONFIG_PCIEASPM_DEBUG and thus make the code always
> > avilable. This provides control to userspace to control
> > ASPM on a per slot / device basis using sysfs interface.
> 
> TL;DR: When CONFIG_PCIEASPM_DEBUG=y, Linux makes ASPM control files
>        visible in sysfs, associated with the upstream end (e.g., Root
>        Port) of a link.  Should these files be associated with the
>        downstream end (e.g., NIC, GPU, etc) instead?
> 
> I think we do need to make ASPM control files visible in sysfs, as
> this patch does.  But I have a question about exactly *how* we want to
> do this.  I had planned to merge this patch for v4.19, but I think
> I'll postpone it until we figure this out.
> 
> ASPM is a power management feature of a PCIe link, and it affects the
> devices on both ends of that link.  The upstream end (closest to the
> CPU) is typically a Root Port, and the downstream end is typically an
> Endpoint (e.g., a GPU, NIC, or NVMe device).  For example, my laptop
> has these devices:
> 
>   00:1c.2 Intel Root Port to [bus 04]
>   04:00.0 Intel 8260 Wireless NIC
> 
> There's a PCIe link between these two devices, and if both ends
> support it, ASPM reduces power usage when the NIC is idle.  The
> hardware reduces power usage automatically; the kernel only needs to
> configure ASPM.
> 
> ASPM affects performance as well as power, so we have knobs to control
> the tradeoff.  Starting with the big hammers, we currently have:
> 
>   - Kernel build-time setting (CONFIG_PCIEASPM_PERFORMANCE, etc).
>     Requires kernel rebuild and reboot.
> 
>   - "pcie_aspm=X" kernel boot parameter.  Can only enable/disable and
>     requires a reboot.
> 
>   - /sys/module/pcie_aspm/parameters/policy file.  At any time, root
>     can set the system-wide ASPM policy to one of these settings:
> 
>       + highest performance, highest power consumption
>       + moderate power saving at cost of some performance
>       + aggressive power saving at cost of more performance
>       + use whatever setting BIOS configured
> 
>   - Many /sys/devices/pci0000:00/0000:00:1c.2/power/link_state files.
>     At any time, root can set the ASPM policy to one of the above
>     settings, but for individual devices.  Currently these files are
>     only available when CONFIG_PCIEASPM_DEBUG=y (Red Hat does not
>     enable this, but Ubuntu does).
> 
> The patch below changes it so these /sys/devices/.../link_state files
> *always* exist, regardless of CONFIG_PCIEASPM_DEBUG.
> 
> The question is where those sysfs files should be.  Currently they are
> associated with the device at the *upstream* end of the link.  In the
> example above, they're associated with the Root Port:
> 
>   /sys/devices/pci0000:00/0000:00:1c.2/power/link_state
> 
> I don't know if that's the right place, or if they should be
> associated with the device at the *downstream* end of the link, i.e.,
> 04:00.0.  The downstream end might be better because:
> 
>   - It's easier to associate the downstream end with a device the user
>     cares about, e.g., a NIC, GPU, etc.  This is mostly a user-
>     interface issue.
> 
>   - A link can lead to a multi-function device, and the spec allows
>     those functions to have different ASPM settings (see PCIe r4.0,
>     sec 5.4.1).  With the sysfs files at the upstream end of the link,
>     we have no way to configure those functions individually.
> 
> Any thoughts?

Hi Bjorn, in my opinion sysfs entries should at the downstream end. As I
think primary usage is to put "end" downstream device (e.g. wifi card)
into lower power mode to increase battery runtime on laptop.

Anyway, if sysfs entry is going to be moved from one place to another
maybe it would be better to give it a new name. Because currently it
sysfs entry is bound to the upstream device and if you change location,
then sysfs entry would change it logic.

-- 
Pali Rohár
pali.rohar@gmail.com
