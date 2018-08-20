Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D62C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 05:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8AC208C1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 05:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQ3PF7vf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C8AC208C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbeHTJKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 05:10:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38102 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeHTJKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 05:10:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so6194872pfh.5;
        Sun, 19 Aug 2018 22:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IO8iMq5pAQcknnXfrey16qhncy+hqE4OtWI8oL64/D8=;
        b=cQ3PF7vfJC4F5Y1KVXAYOn/cSZfj4tf423ruSL5rYFMtCClKf9icfmzmWg4Jb67hVa
         087nEGqIvDYwh7MZkVzVIRovFKhNCKrImwmpbapGU9HNGHWEC4lmchiy+gbyb/TvOk00
         sRdSNm1o/UncbMTZX+xHkBP0RRSGR92NsOAKuSaU1xHsJnTwH87AJuwvQ48gq4axbYFX
         GcV9Hp4e0qWWj3EgQV67H3rKlDuHcO4lFIYpeR1c3Q83N2R3TSe76+THFlS9b/kmGpad
         7UGB1GeLBx94I77vi1bsSSBLJzaGW1oOqeW3bfPlLH4NhMj8sHB2GB7Zj8AR2gGouzTm
         4b1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IO8iMq5pAQcknnXfrey16qhncy+hqE4OtWI8oL64/D8=;
        b=Lw5tFquMdshmTnKdFDtfPsJqJgyXNFlv5qEIBg6dil7q7YwutbvcjIscW2xC+Luuq+
         VmsZ9AjN2yJix/lZgEiZispGu5VKLEPFHB8tyGJe3fXWzp18U7e3aKJTC/iAmCiH+4kp
         Fm1t99DDNl8u8jXuXtjdHorWXW6LXeZgzDzKArtZFI4hBT1qMZlcgOZSdtiwsErl0FzD
         Oq6MiDwjp3lkUx3rlFNo/bdK+IkruoJ8iEq5GQfUMbfdXj3PdHqLi5zdnRPXeP4m3DuU
         XVHrAil4TSLnR8/uh9HJwQiNc8B2E/Jx3NBfwhLgQDKgwprV12ZLCwSIDpfLxkTm9DCA
         cu3w==
X-Gm-Message-State: AOUpUlHwAq1eynZ3Qnyv3BZTqqNkXJ7PHYrKQQx4aBYmTY8aiJHliFa+
        t+1j2Zqk9DVJs5or3Ju4Od/Z67uB5hMK4rAzx9s=
X-Google-Smtp-Source: AA+uWPxMosrOYE+mFGjKy5s6TzhNvcVAlllYCUDVifYSNPZ9Tycio9QScl0hBYXKXREGpojr0lKolm+GCW8m72ItFH8=
X-Received: by 2002:a65:4d05:: with SMTP id i5-v6mr41189377pgt.58.1534744574280;
 Sun, 19 Aug 2018 22:56:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:6d90:0:0:0:0 with HTTP; Sun, 19 Aug 2018 22:55:53
 -0700 (PDT)
In-Reply-To: <CAAtXAHd0jmV32bSyxCyMSh9fcP63sM+6-SkTMS=gA1fJKGKtig@mail.gmail.com>
References: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
 <1534403190-28523-8-git-send-email-jliang@xilinx.com> <CAAtXAHd0jmV32bSyxCyMSh9fcP63sM+6-SkTMS=gA1fJKGKtig@mail.gmail.com>
From:   Wendy Liang <sunnyliangjy@gmail.com>
Date:   Sun, 19 Aug 2018 22:55:53 -0700
Message-ID: <CAA07jV8Bf5kxJPiPMGdpqs_6KhMnjnAC4=5GomJBKgTbVSXV4Q@mail.gmail.com>
Subject: Re: [PATCH 7/7] Documentation: devicetree: Add Xilinx R5 rproc binding
To:     Moritz Fischer <moritz.fischer@ettus.com>
Cc:     Wendy Liang <wendy.liang@xilinx.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, rajan.vaja@xilinx.com,
        jollys@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wendy Liang <jliang@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 9:31 AM, Moritz Fischer
<moritz.fischer@ettus.com> wrote:
> Hi Wendy,
>
> couple of minor stuff inline.
>
> On Thu, Aug 16, 2018 at 12:06 AM, Wendy Liang <wendy.liang@xilinx.com> wrote:
>> Add device tree binding for Xilinx Cortex-r5 remoteproc.
>>
>> Signed-off-by: Wendy Liang <jliang@xilinx.com>
>> ---
>>  .../remoteproc/xlnx,zynqmp-r5-remoteproc.txt       | 81 ++++++++++++++++++++++
>>  1 file changed, 81 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt
>> new file mode 100644
>> index 0000000..3940019
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt
>> @@ -0,0 +1,81 @@
>> +Xilinx ARM Cortex A53-R5 remoteproc driver
>> +==========================================
>> +
>> +ZynqMP family of devices use two Cortex R5 processors to help with various
>> +low power / real time tasks.
>
> The ZynqMP family [..] uses [..]
Will update in next version
>> +
>> +This driver requires specific ZynqMP hardware design.
>
> *a* specific ZynqMP hardware design. What does that mean?
>> +
>> +ZynqMP R5 RemoteProc Device Node:
>> +=================================
>> +A zynqmp_r5_remoteproc device node is used to represent a R5 IP instance
>> +within ZynqMP SoC.
>> +
>> +Required properties:
>> +--------------------
>> + - compatible : Should be "xlnx,zynqmp-r5-remoteproc-1.0"
>> + - reg : Address and length of the register set for the device. It
>> +        contains in the same order as described reg-names
>
> ?
>> + - reg-names: Contain the register set names.
>
> Contains
Will update in next version
>
>> +              "tcm_a" and "tcm_b" for TCM memories.
>> +              If the user uses the remoteproc driver with the RPMsg kernel
>> +              driver,"ipi" for the IPI register used to communicate with RPU
>> +              is also required.
>> +              Otherwise, if user only uses the remoteproc driver to boot RPU
>> +              firmware, "ipi" is not required.
>> + - tcm-pnode-id: TCM resources power nodes IDs which are used to request TCM
>> +                 resources for the remoteproc driver to access.
>> + - rpu-pnode-id : RPU power node id which is used by the remoteproc driver
>> +                  to start RPU or shut it down.
>> +
>> +Optional properties:
>> +--------------------
>> + - core_conf : R5 core configuration (valid string - split0 or split1 or
>> +               lock-step), default is lock-step.
>> + - memory-region: memories regions for RPU executable and DMA memory.
>> + - interrupts : Interrupt mapping for remoteproc IPI. It is required if the
>> +                user uses the remoteproc driver with the RPMsg kernel driver.
>> + - interrupt-parent : Phandle for the interrupt controller. It is required if
>> +                      the user uses the remoteproc driver with the RPMsg kernel
>> +                      kernel driver.
>> +
>> +Example:
>> +--------
>> +       reserved-memory {
>> +               #address-cells = <2>;
>> +               #size-cells = <2>;
>> +               ranges;
>> +               rproc_0_fw_reserved: rproc@3ed000000 {
>> +                       compatible = "rproc-prog-memory";
>> +                       no-map;
>> +                       reg = <0x0 0x3ed00000 0x0 0x40000>;
>> +               };
>> +               rproc_0_dma_reserved: rproc@3ed400000 {
>> +                       compatible = "shared-dma-pool";
>> +                       no-map;
>> +                       reg = <0x0 0x3ed40000 0x0 0x80000>;
>> +               };
>> +       };
>> +
>> +       firmware {
>> +               zynqmp_firmware: zynqmp-firmware {
>> +                       compatible = "xlnx,zynqmp-firmware";
>> +                       method = "smc";
>> +               };
>> +       };
>> +
>> +       zynqmp-r5-remoteproc@0 {
>> +               compatible = "xlnx,zynqmp-r5-remoteproc-1.0";
>> +               reg = <0x0 0xFFE00000 0x0 0x10000>,
>> +                       <0x0 0xFFE20000 0x0 0x10000>,
>> +                       <0x0 0xff340000 0x0 0x100>;
>> +               reg-names = "tcm_a", "tcm_b", "ipi";
>> +               dma-ranges;
>> +               core_conf = "split0";
>> +               memory-region = <&rproc_0_fw_reserved>,
>> +                               <&rproc_0_dma_reserved>;
>> +               tcm-pnode-id = <0xf>, <0x10>;
>> +               rpu-pnode-id = <0x7>;
>> +               interrupt-parent = <&gic>;
>> +               interrupts = <0 29 4>;
>> +       } ;
>> --
>> 2.7.4
>>
>
> Cheers,
> Moritz
