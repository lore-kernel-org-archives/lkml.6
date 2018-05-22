Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3017295-1527019539-2-2520043254750100429
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527019539; b=NGOi/SWJdAjJGqEpp1xDzb9LX9IfCcSpphekFCqeQ+p+wr0li/
    sOcfjywMoiffH6VJc9XJBfgzDF/Ofv3tPseVMSjZCF3UPGy1U9wsBIvCiOXj/MDI
    o2mQMcbdr53d3xIVG0kko2EKcpzWkeJE7W1Jw9Q2IBUcHQECCEPS6QN35yps9fEv
    /Khl6yZCgl1rAGFYbHnI/RoYyrgJgS5C8aSSL2jiPrpkJpOIiSqoX6heO1Ahzjkp
    btQ8p7sS6RVI7G16lmmriABzN/JxAneTjFiBc0MjD/mp9PDZdLYdMRvzyuVIEque
    DVRU/o1n16oOfUQYxhd6hepKLdOpeyLfFmtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527019539;
    bh=UBnGbUKJfQ1QsbeWNnwNLopHIjQKDRmmBIzGdctoCYM=; b=k/WwWOq6uJ8L
    O2Ukv3CT/UWJeGtUYIhXoQGwhMtfwR+J+/GH7zovv47URj0qWDfer2xyk4nEDVdV
    DPNA+C+2gLes2XksECVDoIevXZpj5wWHuPNREN20Eu3E9p8Oip2umsHw7+5I/yoZ
    BX2SSmGwCltyZQxHdMw3fySy8oT+HeKoH+RLush6L3lXmycTshZd+Fz1pXZNNWti
    Y0YwIZZlRn2fH3ZVznFDHjyAZXQ00drQ6TYIAQvG9XarMYdLWvHsFyeoatEo1KbX
    kpK/0w+/mo6Fj7upzDfqJYLaYGlL/fyLyhRWbMM8vmSvy+/wR5urMnzUbZlNoKxo
    oQcZ1MyKzA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=finnie.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=finnie.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=finnie.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=finnie.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFpe+9jHC1gdYXCccCiimVg86K/jAbxRBon1AsQ9AIJxIz7eDv2h2VzqlXp4VjWcrLno0RBwfHCrWwiH7t0TjnxFgAO4Xdo3j3C2ox2dxIC/03ZBAuzv
    wsXxp0ROq1jRq1noZ04BdvD9dr5uFqqBIaP27f5R0XwalVg6E4uHneuVzucjNCWE1gLiHk6q6608tUVehF+Qm+Fa8pv2++ol0rif3D5DwXEMw8DWm2LIriRO
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=LpQP-O61AAAA:8 a=VwQbUJbxAAAA:8 a=zVRjdazwAAAA:8
    a=iqEX8wNUWzg6sPBH7v8A:9 a=QEXdDO2ut3YA:10 a=pioyyrs4ZptJ924tMmac:22
    a=AjGcO6oz07-iQ99wixmX:22 a=000VuuKJPBW3DWPeRJJA:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbeEVUFg (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 16:05:36 -0400
Received: from feh.colobox.com ([209.177.154.210]:45318 "EHLO feh.colobox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751586AbeEVUFf (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 22 May 2018 16:05:35 -0400
Subject: Re: [PATCH] PCI/portdrv: do not disable device on remove()
To: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1527011883-21320-1-git-send-email-okaya@codeaurora.org>
From: Ryan Finnie <ryan@finnie.org>
Message-ID: <28781ad3-2105-8127-e385-6d42e3e75ae3@finnie.org>
Date: Tue, 22 May 2018 12:55:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527011883-21320-1-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/22/2018 10:58 AM, Sinan Kaya wrote:
> 'Commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during
> shutdown")' has been added to kernel to shutdown pending PCIe port
> service interrupts during reboot so that a newly started kexec kernel
> wouldn't observe pending interrupts.
> 
> pcie_port_device_remove() is disabling the root port and switches by
> calling pci_disable_device() after all PCIe service drivers are shutdown.
> 
> pci_disable_device() has a much wider impact then port service itself and
> it prevents all inbound transactions to reach to the system and impacts
> the entire PCI traffic behind the bridge.
> 
> Issue is that pcie_port_device_remove() doesn't maintain any coordination
> with the rest of the PCI device drivers in the system before clearing the
> bus master bit.
> 
> This has been found to cause crashes on HP DL360 Gen9 machines during
> reboot. Besides, kexec is already clearing the bus master bit in
> pci_device_shutdown() after all PCI drivers are removed.

FAOD, this problem has been observed on both DL360 Gen9 and DL380 Gen9,
in both EFI and legacy modes.  I suspect all Gen9 models with the P89
firmware base.

> Just remove the extra clear here.

Thank you!  Fix tested on:

- DL360 Gen9
- DL380 Gen9
- DL380 Gen10 (confirmed no regression)
- DL380 G7 (confirmed no regression)

> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=199779
> Fixes: cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during shutdown")
> Cc: stable@vger.kernel.org
> Reported-by: Ryan Finnie <ryan@finnie.org>

Tested-by: Ryan Finnie <ryan@finnie.org>
