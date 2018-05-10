Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756412AbeEJCpF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 22:45:05 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36854 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756235AbeEJCpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 22:45:03 -0400
X-Google-Smtp-Source: AB8JxZqizOVrB9x7a1jRw4o8emqxtoNZOW8quPq/eBZmYVf9fatAIPUaKm7HywIbqOmrkVsNQWlXiA==
Subject: Re: [PATCH] PCI: Check whether bridges allow access to extended
 config space
To: Gilles Buloz <Gilles.Buloz@kontron.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Minghuan.Lian@nxp.com" <Minghuan.Lian@nxp.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sinan Kaya <okaya@codeaurora.org>
References: <20180504200600.GA9529@bhelgaas-glaptop.roam.corp.google.com>
 <20180507215619.GA161390@bhelgaas-glaptop.roam.corp.google.com>
 <5AF2E91E.3030804@kontron.com>
From: Frederick Lawler <fred@fredlawl.com>
Message-ID: <4d54d03c-e450-5ae2-853f-1d4fe4ed3b85@fredlawl.com>
Date: Wed, 9 May 2018 21:44:58 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 PostboxApp/6.0.7.1
MIME-Version: 1.0
In-Reply-To: <5AF2E91E.3030804@kontron.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Gilles Buloz wrote:
> Here are full dmesg + lspci -vv + ... for the following cases :
> - 4.17-rc1_probe_failed_without_pcieaspmoff.txt : I get a broken PCI config at most boots, without pcie_aspm=off
> - 4.17-rc1_probe_ok_without_pcieaspmoff.txt : I get a correct PCI config at some boots, even without pcie_aspm=off
> - 4.17-rc1_probe_always_ok_with_pcieaspmoff.txt : I get a correct PCI config at all boots when using pcie_aspm=off
> - 4.1.35_probe_always_ok_without_pcieaspmoff.txt : I get a correct PCI config at all boots when using kernel 4.1.35-rt41 (from NXP
> Yocto BSP), even without pcie_aspm=off
> 
> I noticed these strange things :
> - with 4.17-rc1, without pcie_aspm=off, the kernel is hanging during ~1 second :
>     - before line "ASPM: Could not configure common clock" when PCI config is OK
>     - or before line "bridge configuration invalid ([bus ff-ff]), reconfiguring" when PCI config is NOT OK
>       (the FFs in "[bus ff-ff]" seems side effects of read returning ~0 because device is off)
> - no such hang when pcie_aspm=off is used
> - applying reverse patch for "PCI/ASPM: Don't warn if already in common clock mode"
>     (commit 04875177dbe034055f23960981ecf6fb8ea1d638) does not give more message

I submitted this as a bug here:
https://bugzilla.kernel.org/show_bug.cgi?id=199671

Thanks,
Fred
