Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2668558-1519125230-2-6081385358519646001
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519125229; b=M6V427guCa8+7sKrLDhBis9cwrgsvVhnjrzCpzPGQ5i51Fe
    nBcbAxqrsDHlkbwfgdSkX3CC70kZxFS27OoH7l64XS8dth863hge1/TR2jJAkBuz
    q5IoheONfSzELCT6L0sEFDZO+IEujfxtQbHoA6h8ZjAKvlHE1GhtqwVPGzUkyruk
    iKNOSz+DrmjftX9eglpIxWI71lr8jBIw71I/24g8RFiD9cMg5Wr8Hsr9yOJu23ue
    kZNoglKp4cWaxERkhZoALSacvbODP5fa28GUFLz1C7mwNYL0oPZ0xXB9fQUXYVLB
    7K9pXOTOJlTo9RNtZC+LH4AAh6rvfKeK12Yyaqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=arctest; t=1519125229; bh=W7JR9
    DGFEdf8H7nvWZ8xpPEQjX/8Sd+r8fclFBDnVEw=; b=DRAkiGSyh8K9v9zQ7f5dW
    0llLjEsDNqhkHxojsu8OOUie6pbhfBHVB/tZw3sm/ZVxCRAiqsrwRAFDZU2kHR5v
    AQj1vCGgoXFrwdvbfxy2mw/CgpSVKCYrLBf688pdyvKKZjRE+hLlZxylK775Thyv
    GaLnycYTJhbNrWdE6suktINnz55HysUYoiwA4xYXRX4jTXI3ZV6D43atr1HGyHi6
    48oXDtWBwoDfuKJvQwJPuu9Xm/DvnkWfT9oQv1Hv0Xn/5wXrkuvT4omrqvXNxbDO
    FPMDc+Cv4tcmcAimL2/VrCP9vIbIGmNTuvEzGnMaC7E1mkVSvAtusClfDgYS+aBp
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=URZFSgWM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=URZFSgWM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751681AbeBTLNq convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Tue, 20 Feb 2018 06:13:46 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54744 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751511AbeBTLNp (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 20 Feb 2018 06:13:45 -0500
X-Google-Smtp-Source: AH8x224lbiLeOkdUD9zZMWYFjEQBFRmzRI0Lywgf1U2+4XKQ4iEjM2hSqG8wdkXBboHpnSDVnItseg==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH v2] xhci: Fix front USB ports on ASUS PRIME B350M-A
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <c32af5ea-c8ca-b68b-790e-102c7a8f89f6@linux.intel.com>
Date: Tue, 20 Feb 2018 19:13:37 +0800
Cc: mathias.nyman@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <8579E16A-AA34-4876-9B62-D023B8FC2212@canonical.com>
References: <20180219190621.6632-1-kai.heng.feng@canonical.com>
 <c32af5ea-c8ca-b68b-790e-102c7a8f89f6@linux.intel.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> On 20 Feb 2018, at 4:24 PM, Mathias Nyman <mathias.nyman@linux.intel.com> wrote:
> 
> Hi
> 
> On 19.02.2018 21:06, Kai-Heng Feng wrote:
>> When a USB device gets plugged on ASUS PRIME B350M-A's front ports, the
>> xHC stops working:
>> [  549.114587] xhci_hcd 0000:02:00.0: WARN: xHC CMD_RUN timeout
>> [  549.114608] suspend_common(): xhci_pci_suspend+0x0/0xc0 returns -110
>> [  549.114638] xhci_hcd 0000:02:00.0: can't suspend (hcd_pci_runtime_suspend returned -110)
> 
> Is the xhci runtime suspend something that you expected here?
> I mean was the plugged device first enumerated normally, driver bound, inactive and runtime suspended
> first?

I guess this is how it behaves, here’s the log after a device gets plugged:

[ 7535.716578] xhci_hcd 0000:02:00.0: // Setting command ring address to 0xff86c001
[ 7535.720107] xhci_hcd 0000:02:00.0: xhci_resume: starting port polling.
[ 7535.720114] xhci_hcd 0000:02:00.0: xhci_hub_status_data: stopping port polling.
[ 7535.720134] xhci_hcd 0000:02:00.0: xhci_suspend: stopping port polling.
[ 7535.720190] xhci_hcd 0000:02:00.0: Port Status Change Event for port 8
[ 7535.720194] xhci_hcd 0000:02:00.0: resume root hub
[ 7535.720201] xhci_hcd 0000:02:00.0: handle_port_status: starting port polling.
[ 7535.721675] xhci_hcd 0000:02:00.0: // Setting command ring address to 0xff86c001
[ 7535.722106] xhci_hcd 0000:02:00.0: // Setting command ring address to 0xff86c001
[ 7535.725538] xhci_hcd 0000:02:00.0: xhci_resume: starting port polling.

So the xHC resumes and suspends, then resume again. 

[ 7535.725543] xhci_hcd 0000:02:00.0: xhci_hub_status_data: stopping port polling.
[ 7535.725587] xhci_hcd 0000:02:00.0: get port status, actual port 0 status  = 0x2a0
[ 7535.725590] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[ 7535.725606] xhci_hcd 0000:02:00.0: get port status, actual port 1 status  = 0x2a0
[ 7535.725608] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[ 7535.725616] xhci_hcd 0000:02:00.0: get port status, actual port 2 status  = 0x2a0
[ 7535.725618] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[ 7535.725625] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x202e1
[ 7535.725627] xhci_hcd 0000:02:00.0: Get port status returned 0x10101
[ 7535.725632] xhci_hcd 0000:02:00.0: Port Status Change Event for port 8
[ 7535.725636] xhci_hcd 0000:02:00.0: handle_port_status: starting port polling.
[ 7535.725656] xhci_hcd 0000:02:00.0: clear port connect change, actual port 3 status  = 0x2e1
[ 7535.725663] xhci_hcd 0000:02:00.0: get port status, actual port 4 status  = 0x2a0
[ 7535.725665] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[ 7535.725672] xhci_hcd 0000:02:00.0: get port status, actual port 5 status  = 0x2a0
[ 7535.725674] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[ 7535.725680] xhci_hcd 0000:02:00.0: get port status, actual port 6 status  = 0x2a0
[ 7535.725682] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[ 7535.725689] xhci_hcd 0000:02:00.0: get port status, actual port 7 status  = 0x2a0
[ 7535.725691] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[ 7535.725698] xhci_hcd 0000:02:00.0: get port status, actual port 8 status  = 0x2a0
[ 7535.725699] xhci_hcd 0000:02:00.0: Get port status returned 0x100
[ 7535.725706] xhci_hcd 0000:02:00.0: get port status, actual port 9 status  = 0x2a0
[ 7535.725708] xhci_hcd 0000:02:00.0: Get port status returned 0x100

[ 7535.736165] xhci_hcd 0000:04:00.0: // Setting command ring address to 0xfff58001
[ 7535.740033] xhci_hcd 0000:04:00.0: xhci_resume: starting port polling.
[ 7535.740040] xhci_hcd 0000:04:00.0: xhci_hub_status_data: stopping port polling.
[ 7535.740047] xhci_hcd 0000:04:00.0: xhci_hub_status_data: stopping port polling.
[ 7535.740133] xhci_hcd 0000:04:00.0: xhci_suspend: stopping port polling.
[ 7535.740161] xhci_hcd 0000:04:00.0: // Setting command ring address to 0xfff58001

This is the “other” xHC that I mentioned in patch v1. It provides USB 3.1 capabilities to front USB port.

[ 7535.776003] xhci_hcd 0000:02:00.0: xhci_hub_status_data: stopping port polling.
[ 7535.832028] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x2e1
[ 7535.832031] xhci_hcd 0000:02:00.0: Get port status returned 0x101
[ 7535.832051] xhci_hcd 0000:02:00.0: // Ding dong!
[ 7535.832150] xhci_hcd 0000:02:00.0: Slot 3 output ctx = 0xff125000 (dma)
[ 7535.832153] xhci_hcd 0000:02:00.0: Slot 3 input ctx = 0xff16c000 (dma)
[ 7535.832160] xhci_hcd 0000:02:00.0: Set slot id 3 dcbaa entry 000000000bd2158a to 0xff125000
[ 7535.832189] xhci_hcd 0000:02:00.0: set port reset, actual port 3 status  = 0x2e1
[ 7535.835982] xhci_hcd 0000:02:00.0: xhci_hub_status_data: stopping port polling.
[ 7535.892049] xhci_hcd 0000:02:00.0: Port Status Change Event for port 8
[ 7535.892056] xhci_hcd 0000:02:00.0: handle_port_status: starting port polling.
[ 7535.900058] xhci_hcd 0000:02:00.0: get port status, actual port 3 status  = 0x200e03
[ 7535.900061] xhci_hcd 0000:02:00.0: Get port status returned 0x100503
[ 7535.900079] xhci_hcd 0000:02:00.0: clear port reset change, actual port 3 status  = 0xe03
[ 7535.959990] usb 1-4: new high-speed USB device number 4 using xhci_hcd

> 
>> Delay before running xHC command CMD_RUN can workaround the issue.
>> Use a new quirk to make the delay only targets to the affected xHC.
> 
> Is this some known issue with this chip, or something figured out by trial and error?

By trial and error.
This might be a more pervasive issue, but I don’t see other bug reports though.

> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> Thanks, otherwise workaround seems fine, just curious about the two details above

Thank you.

Kai-Heng

> 
> -Mathias
> 

