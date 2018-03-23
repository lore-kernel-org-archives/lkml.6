Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751876AbeCWIoJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 04:44:09 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:37974 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751675AbeCWIoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 04:44:07 -0400
X-Google-Smtp-Source: AG47ELssZCO1hBDdhVbWExfDbhcY7W+4SOeHWHuVJ18Eh30xxHTMpIglWdrz2tKHrpq41YqQ5TR9dcURor30IrNqDFg=
From: Srinath Mannam <srinath.mannam@broadcom.com>
References: <744877924.5841545.1521630049567.JavaMail.zimbra@kalray.eu>
 <20180321115037.GA26083@ming.t460p> <464125757.5843583.1521634231341.JavaMail.zimbra@kalray.eu>
 <20180321154807.GD22254@ming.t460p> <20180321160238.GF12909@localhost.localdomain>
 <1220434088.5871933.1521648656789.JavaMail.zimbra@kalray.eu>
 <20180321215308.GH38649@bhelgaas-glaptop.roam.corp.google.com> <2116255963.5924726.1521790087788.JavaMail.zimbra@kalray.eu>
In-Reply-To: <2116255963.5924726.1521790087788.JavaMail.zimbra@kalray.eu>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQKUEOnFU2UVDrc3r39WZEWgKrnm8AKa1mcNAbL50P0Csp/JAgJw335UAsJU8eUBaw44cAHD2XPLoeHPMTA=
Date: Fri, 23 Mar 2018 14:14:05 +0530
Message-ID: <0b37cdbe43a350e46057efa197ba471a@mail.gmail.com>
Subject: RE: [RFC PATCH] nvme: avoid race-conditions when enabling devices
To: Marta Rybczynska <mrybczyn@kalray.eu>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <keith.busch@intel.com>, Ming Lei <ming.lei@redhat.com>,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marta,

I could not get time to work on this.
The present patch works for our platforms. so we continue with that.
I will update new changes little later.
If you have time, please try the same patch and let us know if any issue you
see.

Regards,
Srinath.

-----Original Message-----
From: Marta Rybczynska [mailto:mrybczyn@kalray.eu]
Sent: Friday, March 23, 2018 12:58 PM
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <keith.busch@intel.com>; Ming Lei <ming.lei@redhat.com>;
axboe@fb.com; hch@lst.de; sagi@grimberg.me; linux-nvme@lists.infradead.org;
linux-kernel@vger.kernel.org; bhelgaas@google.com;
linux-pci@vger.kernel.org; Pierre-Yves Kerbrat <pkerbrat@kalray.eu>; Srinath
Mannam <srinath.mannam@broadcom.com>
Subject: Re: [RFC PATCH] nvme: avoid race-conditions when enabling devices


> On Wed, Mar 21, 2018 at 05:10:56PM +0100, Marta Rybczynska wrote:
>>
>> The problem may happen also with other device doing its probe and
>> nvme running its workqueue (and we probably have seen it in practice
>> too). We were thinking about a lock in the pci generic code too,
>> that's why I've put the linux-pci@ list in copy.
>
> Yes, this is a generic problem in the PCI core.  We've tried to fix it
> in the past but haven't figured it out yet.
>
> See 40f11adc7cd9 ("PCI: Avoid race while enabling upstream bridges")
> and 0f50a49e3008 ("Revert "PCI: Avoid race while enabling upstream
> bridges"").
>
> It's not trivial, but if you figure out a good way to fix this, I'd be
> thrilled.
>

Bjorn, Srinath, are you aware of anyone working on an updated fix for this
one?

Marta
