Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECAEC46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559F121CBD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 05:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559F121CBD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbeHIH2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 03:28:41 -0400
Received: from mout.gmx.net ([212.227.15.15]:43467 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727724AbeHIH2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 03:28:41 -0400
Received: from homer.simpson.net ([185.221.149.218]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LtaDM-1fxMUx3u8i-010wAP; Thu, 09
 Aug 2018 07:05:16 +0200
Message-ID: <1533791114.5087.30.camel@gmx.de>
Subject: Re: [PATCH] x86, kdump: Fix efi=noruntime NULL pointer dereference
From:   Mike Galbraith <efault@gmx.de>
To:     Dave Young <dyoung@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org
Date:   Thu, 09 Aug 2018 07:05:14 +0200
In-Reply-To: <20180809042153.GA4377@dhcp-128-65.nay.redhat.com>
References: <1533737025.4936.3.camel@gmx.de>
         <20180809042153.GA4377@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1yp/ASSm6nTu2rWP629uGUQQFx4l1owWvoViAV30T98fpFXpnpd
 2tUuM9gbPkxbG1LU1fxTkGNX5Ho+eu6FZca5lY+Dtz/KxxEp56fP2VjiItstGeblMFLS2kC
 KSRv/SigpYquBg/zDETRwoUkIJQ7A7iKYJyRpuqEA53M1lImTK+Pf0hoiEmgl7BAfG2S3gU
 JgW7HDpNMOJjbQGFEyAiA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nDcStL7hP3Y=:pIf59da96Rgg+TL5b7Ly5U
 hnrLXz7O/jWJ4X57ZCaUt2pB13suk29L1b99d2vhyyBRcs8aQOvjOnnVqwTTZKfvtxnWdVotp
 ZRDCXA20A76zKlMrnPcq+mjE3Y1KYCTBMCwfTdy33ZEMqNY/4y7nIUT5QhcVrK11NGSmptJNS
 JuTOjNc9y3SWDWHtaqHIrcZ4MoFr3qJNbCfHqmYvFfA6vv8FrqFzxvj2kGx8SNmn43nKkcx6s
 FWLswjZLi3AsgXfIph4vjvXgk3v6SdoAQnCyKKlV+hWkez3FosvEk7mXp3kBrZMpIJBbDCi63
 PBqoT2TwtWVA7sEphB0Vu3QMg8rYVKNGFobSQqkPpjmCwPQpTa9uS5mdgcjyh1e/YSWMx3Vy3
 BMKB8c9ASDFys22sNVjoJb4RfF5K9zp94BEnrGCwCr8jlV+hGRI3Rs1M32U5E6Udg3Lgn/Z2W
 GXy7UCl/i925IE3Z5Jc/LkWrIrpxtizyssDBtsRLocRgq9fjlfz7mS8pddYJwVcpCdCXrUPxx
 2EbL0OT71+sSRdac8kbPCgHl2MYxnhCshQZ639fZq8eadR13TUhiER4KzvtNaslsPbmGw5WEN
 teU5RjnqBxKYDn0291XfalJRh2+ojZ0pQMO+nLITCn7EwtiIsZ9T4vMr0OUv3Jthio/23wm4v
 02n0nb0PueqzXt5z6x9bkTHeef7K4/awpLbnEAhLv9csz6hUaaOBhLWgdhyWfrQAmw7K/K93p
 bjF0daeKbOIiyQQ8HCVUPESAOWfxYvl8kxlSmfYgI/4LeiqQD7kz1vDLxZmaJsP6epeDaGSBL
 x6Ah4Bn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-09 at 12:21 +0800, Dave Young wrote:
> Hi Mike,
> 
> Thanks for the patch!
> On 08/08/18 at 04:03pm, Mike Galbraith wrote:
> > When booting with efi=noruntime, we call efi_runtime_map_copy() while
> > loading the kdump kernel, and trip over a NULL efi.memmap.map.  Avoid
> > that and a useless allocation when the only mapping we can use (1:1)
> > is not available.
> 
> At first glance, efi_get_runtime_map_size should return 0 in case
> noruntime.

I actually made it do that in a separate patch first, and keyed on that
in a second, but then decided to not notice anything odd in efi land
(run Forest run!), and just fix the bug that now bites latest RT due to
it turning efi runtime off by default.

> Also since we are here, would you mind to restructure the bzImage64_load
> function, and try to move all efi related code to setup_efi_state()?
> 
> 
> setup_boot_parameters(struct kimage *image, struct boot_params *params,
>                       unsigned long params_load_addr,
>                       unsigned int efi_map_offset, unsigned int efi_map_sz,
>                       unsigned int efi_setup_data_offset)
> {
> [snip]
> 
> #ifdef CONFIG_EFI
>         /* Setup EFI state */
>         setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
>                         efi_setup_data_offset);
> #endif
> 
> [snip]
> }
> 
> Currently bzImage64_load prepares the efi_map_offset, efi_map_sz,
>  and efi_setup_data_offset and then pass it to setup_boot_parameters and
> setup_efi_state.  It should be better to move those efi_* variables to
> setup_efi_state().
> 
> So we can call setup_efi_state only when efi runtime is enabled.

Yeah, I thought the same, but wanted to keep it dinky.

	-Mike
