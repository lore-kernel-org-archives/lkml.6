Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D2EC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FBC20BF3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9FBC20BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeHTOjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 10:39:46 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34200 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeHTOjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 10:39:46 -0400
Received: by mail-oi0-f67.google.com with SMTP id 13-v6so25139653ois.1;
        Mon, 20 Aug 2018 04:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rs+d9IJsmy+/lM6N8uTP1eL0XxsVtMeuH7FzaQKP2oc=;
        b=act0JfkMs8Gt61FN5qy15UdA2rwGJ1GxSnXXMWFi66GzvRKSqiAvM3GCMgYm77Ji+L
         Dtl/gfkPD7yE2DgT5a+XCR2MRGi4zeQJKO2M+U1+4Hshh6RM9+MJhD4fcKNmN0QAQnvF
         2hPZV+38RrLv7jOUIlljCXLsasbt5LMHVE9OJ3YCVXLGdPaUJ74Zp5ZjXmKTM6cIeopd
         57DesM+UOTH+diqQMOvlCRayDnTJ1d0dMd7KYF3nWtyx+Fxq5TBIM5oTB20Xm0279E8C
         24lFZ1wwdv5i6teodPn8GMOV09glamI1wRW4JylTX5pZMnwDB/6+vNHpoadjNSOisDT9
         cr0Q==
X-Gm-Message-State: AOUpUlGsNZKbbICyVeybkQZg8XIiETDiF1oayf4TPtVfVmP59Nm7l5R+
        5JKpHadSUwFY33GRvViUXE5+rPsszg5O3wlhXk0XlA==
X-Google-Smtp-Source: AA+uWPzH3MouF8HwYhWDoigF9pVRXpuMFym1x1Uy75GQd6fHqqigIcJoCZMGa59enccLnAvULmUQ1tFhk8e5o3//glU=
X-Received: by 2002:aca:b885:: with SMTP id i127-v6mr13722061oif.180.1534764272015;
 Mon, 20 Aug 2018 04:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180817102645.3839621-1-arnd@arndb.de> <20180817102645.3839621-8-arnd@arndb.de>
 <CAJZ5v0iCgQxxuoCB9B4-Ho3xeLwb4v99Xyw-9e-tT53mRD+YVQ@mail.gmail.com> <CAK8P3a31Ds14Ke1qLoMapK1Wq1M4tR6n+nL1VOKzR8+oN0eOBw@mail.gmail.com>
In-Reply-To: <CAK8P3a31Ds14Ke1qLoMapK1Wq1M4tR6n+nL1VOKzR8+oN0eOBw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Aug 2018 13:24:20 +0200
Message-ID: <CAJZ5v0gu_agFQBS7UjTMY3FR7woPPN-riJ6frwk1QoetGoVjfA@mail.gmail.com>
Subject: Re: [RFC 07/15] PCI/ACPI: clean up acpi_pci_root_create()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 1:20 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Aug 20, 2018 at 10:23 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Fri, Aug 17, 2018 at 12:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > @@ -909,8 +881,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
> > >         int ret, busnum = root->secondary.start;
> > >         struct acpi_device *device = root->device;
> > >         int node = acpi_get_node(device->handle);
> > > -       struct pci_bus *bus;
> > > -       struct pci_host_bridge *host_bridge;
> > > +       struct pci_host_bridge *bridge;
> >
> > Why "bridge" and not "host" or even something to stand for "root complex"?
> >
> > Or maybe it can still be "host_bridge"?
>
> I did this for consistency with the naming in drivers/pci/probe.c,
> which always declares the local variable as 'struct pci_host_bridge *bridge'.
> It's easy to change here if you feel strongly about it (I don't).

I would leave host_bridge here.  It would make the patch smaller too I think.
