Return-Path: <linux-pci-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2509881-1528203863-2-9199462510857484281
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-pci-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528203863; b=mhX4f8In7tMXNa1GUzesHCVlOaPPP+n8mXLUGCzW6cHdymvkZc
    u3rgVZqtSWed4asrrbtTVDPlgyodF5u5dCi+k3j7kiBiRBW7dg2wi+9fuZ4mxFca
    qeANqf1/RQtlTf7I8StWePXB5Hy+GPkuimzFfQJPXVvAIG3la4/QpC/o5J19O/tc
    DZebc+FK31NUxdtvhKidxSV7qIL0Vz8IOezpILdUoTcDuso6n+kPNsgvaO/VluNi
    FbmFPe2uTMKeR1bhuq73kR1B5Fp0oBRxqVMlvUZDD1av5OSPegew8h4rlC3gaPbt
    nlCFs/i/XmqfSonKCpfbeaA8MkbTUxVBG0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1528203863; bh=ElcYD9yFnJ7UsEG4K5jQPMQq5zs7p2KheILJviVACn
    U=; b=FtPR+85OrtiWP8WrovK/5O/HsdDKFtex9sJ7BVjCSjipg8xOQzUBnACuNU
    EGVUXHUnv/5r/6vmxd0OSCg1U3w8PxcqtREPFV+94h2P1KJ5fdZV1FJ2cEsM2LE4
    r18Y0W5BAUuC/S92seNreG9MxNTT3st9oadYHk8Bbynw0K+3i6kJ6P8PJnpopnPP
    Qaiy4bPAm0Eco3nJPPXymNb1y9OhxKvtW9h+xD6VtXw7RY/ZJ4dRE4g4ht47hCQ1
    t8gO6BQZSOLjJSou7jWhnSDjvWBYNRcFDOz5c2MVOHDPEJMyDo2xAf5iYtq0Mu5C
    AD9jDBRRIllZF37mYskI9cf4BcBQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
    header.i=@gmail.com header.b=ern5r5bi header.a=rsa-sha256
    header.s=20161025 x-bits=2048;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=stjOIWSe;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com
      header.i=@gmail.com header.b=ern5r5bi header.a=rsa-sha256
      header.s=20161025 x-bits=2048;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=stjOIWSe;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC3zFqY53/k2nZjO/NnC0/MqY7h8VaQYhJsiN7704XIQWri4XMXQrq8lmAVeqnpcMrc5Iy3xxtjaEuWZrvXy6jBlhnLl8oq9vpZRe0b9imMz1TZBhCt9
    zUeV1DfXboONQHHnN8dEiz1nargdXwIrfBg0d577X9p02yGCS4cFonea5a/FgoujDpjhbwZUSrcBMLA+SNbHxOWbgW9xQauF868gvSS0w6YISKDNQDhM2mU9
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=fbV3Th2LUxsA:10 a=7mUfYlMuFuIA:10 a=pGLkceISAAAA:8 a=sHjMbqFaTUBLyNnTYacA:9
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751808AbeFENEV (ORCPT <rfc822;linux@kroah.com>);
        Tue, 5 Jun 2018 09:04:21 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:46642 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbeFENEU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jun 2018 09:04:20 -0400
X-Google-Smtp-Source: ADUXVKIi2uTkSh0BDmU4ippgc+wDaVpIjGWvQUbIu9q/QJIh7s0gc+b2R2eJOQEAaLYIR/3iDH9YWDoGRb0vVbp2UcM=
MIME-Version: 1.0
In-Reply-To: <CAHp75VciAimPhuMDOzYdMP=S1OWGyOUh4dN4BqfsLVOpTnRBRQ@mail.gmail.com>
References: <20180604155523.14906-1-mr.nuke.me@gmail.com> <CAHp75VciAimPhuMDOzYdMP=S1OWGyOUh4dN4BqfsLVOpTnRBRQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Jun 2018 16:04:19 +0300
Message-ID: <CAHp75VdmHvfXvLDUpyVb9QiWCG0YSPErQ+O=Lvdj2NS6WrcdZQ@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: Check for PCIe downtraining conditions
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
X-Mailing-List: linux-pci@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Jun 5, 2018 at 3:27 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Jun 4, 2018 at 6:55 PM, Alexandru Gagniuc <mr.nuke.me@gmail.com> wrote:
>> PCIe downtraining happens when both the device and PCIe port are
>> capable of a larger bus width or higher speed than negotiated.
>> Downtraining might be indicative of other problems in the system, and
>> identifying this from userspace is neither intuitive, nor straigh
>> forward.
>>
>> The easiest way to detect this is with pcie_print_link_status(),
>> since the bottleneck is usually the link that is downtrained. It's not
>> a perfect solution, but it works extremely well in most cases.
>
> Have you seen any of my comments?
> For your convenience repeating below.

Ah, found the answer in a pile of emails. OK, I see your point about
helper, though the rest is still applicable here.

-- 
With Best Regards,
Andy Shevchenko
