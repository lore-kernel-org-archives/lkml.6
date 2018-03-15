Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-124355-1521114182-2-4089801911917917406
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521114182; b=kU+tKZ118hC8wX/e1bLjaAGJS8gNwnYGbWWvJQYNQARcfN8
    1ysesOjL03S8hpuUEPULcvBAn6eNi2ukYE4GDqO4E79nFEX0bJv6QvFhtA6Qsc9v
    /y5bLAr6M461kS8O+D/hl30GKWj6nXLF9OpmNyPBLui0zDlEJkZUJ1iQfwcNm5zJ
    gWVhqT6e/+xI2SeBkdbAYv8ejN+3gIdjPalhkNkyNITDtV+PW+G6ZIwuywWIpJ1b
    NFEw+h3KJScz3awoAa0xsuQddEJM4afkjsZh0yoIwjFGQFT7VZ3qhdRbERdMbQKo
    eRG1D+3DsOx6SCGf7CwoGaQSLCnTaEvMR8pt5pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521114182; bh=e5q0ZPTuXiPWnYxGyfH+d4Z6Hq5a2gacAbOH+x3oAkk=; b=R
    IJXWEee5fObeXw08BmWcJoGe1xhkXbRcvuSQGhrv98tpOXwGcF/HPfflWumV3cWM
    2MrbBMPHCgW3H7YJt2yhjpEx1NZ7sg6MkQVqB3l8qu3ZT5Qkp404Le0yjIXo6fMe
    qIntg9KiNXoqQl107IBnKgJ0SkcIM0tWhEVcKcm0LghDw5f1HKPJZ+0bNhyDVbow
    fGrzuBS4fkAqOynDK7FDwQnQnhAwO7P40MJxhl5ALcyQJoUIeeEJfJR/7ld0se3/
    MOthaHqkNNqziwdbc3GK7J3TfliJ6fwjaJFTkTP6qVuUSY/7aFwqveUFEQ7Ywixv
    LVbjhcMrIAvi6tBfpqnPQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeCOLmo (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 07:42:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:38144 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751481AbeCOLmm (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 15 Mar 2018 07:42:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,310,1517904000";
   d="scan'208";a="38211924"
Subject: Re: Intel GemniLake xHCI connected devices can never wake up the
 system from suspend
To: Chris Chiu <chiu@endlessm.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
References: <CAB4CAwf_k-WsF3zL4epm9TKAOu0h=Bv1XhXV_gY3bziOo_NPKA@mail.gmail.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <6c8df688-b456-6f07-9325-6f4dfd8f0883@linux.intel.com>
Date: Thu, 15 Mar 2018 13:46:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAB4CAwf_k-WsF3zL4epm9TKAOu0h=Bv1XhXV_gY3bziOo_NPKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 15.03.2018 06:40, Chris Chiu wrote:
> Hi,
>      I  have a ASUS AIO V222GA and another Acer Desktop XC-830 both
> have Intel CPU J5005 and they both hit the same problem. The XHCI
> connected USB keyboard/mouse can never wakeup the system from suspend.
> It reminds me that similiar thing happens on ApolloLake too which
> needs the XHCI_PME_STUCK_QUIRK to get it work. It's also mentioned in
> https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/pentium-celeron-n-series-spec-update.pdf
> page #14 for N-seris intel CPU. And I also find the same problem
> description in https://www.intel.com/content/dam/www/public/us/en/documents/product-briefs/silver-celeron-spec-update.pdf
> page #16 for J-series Intel CPU. Seems that they have different
> workaround so I can not simply apply XHCI_PME_STUCK_QUIRK to make it
> work.
> 
>      Anyone can help here?
> 

N-Series
CHP8: USB xHCI Controller May Not Re-Enter D3 State After a USB Wake Event
- needs XHCI_PME_STUCK_QUIRK in driver (sets bit 28 at offset 80a4)

Intel® Pentium® Silver N5000
Intel® Pentium® Silver J5005
Intel® Celeron® N4000 and N4100
Intel® Celeron® J4105 and J4005

USB xHCI Controller May Not Re-enter a D3 State After a USB Wake Even
Need to clear PME_EN bit of of the standard PCI PM_CSR register.
I think Linux does this anyway (clears enabling PME when reaching D0)
So if I remember correct there was no specific workaround needed for this.

what is the PCI ID of your xhci controller? (lspci -nn)

One other possible cause is that xHCI never reaches PCI device D3 suspend state during system suspend.
xHC can't generate PME# wake event from normal running PCI device D0 state.

PCI code in Linux will check with ACPI about the lowest possible D state when suspending,
If there is something missing from the xHCI entry in ACPI DSDT table it might select D0.
as the suspend state, causing wake failure.

Is there a BIOS update available for your ASUS and Acer?

-Mathias

  
  
