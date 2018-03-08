Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2969271-1520545232-2-15264430878739958525
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520545232; b=YKODznTxn190ZX3sqFSxhQZDJG6TCmva7UC6n/HdyvvnQZt
    qY33S5xNV7pOQe93d0U1+RptJ6GFAup5sIIY8O0mzPqnXi23E/BFDecFh+iqrafD
    AztDmx+dnprav96pq4saxqkdN7CVLzBFsumCFdmCIT4ktfIeL2dAglZhBowqQKA6
    +e2HEfMRKhPfWNyIKbOSwjzSethp+mKflbl3KuSIE1ZzTpBNoOP3fportMm3bAwe
    /Aqujtd78C+MtshfMa6VqeMkU6LxAsEVcOanEoAF4PJJZMnIjro0eGa0M9F7Gr2O
    S7iCDUh6HoUb8OhMx6+bYFg1E4Qx/0uPM1axIUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520545232; bh=/
    DKw7TxSa+bUcqsQvJMNTKFDSFV8ksPoRLVHicse8wA=; b=n3hwEeaax4gmClFaB
    0gCT6ZzsSN3bRWGhPkKzua2Jk4BC+lBwyk0PkHXfSoCbWCKVG5RH30DhtylV50/J
    NZNkRNmCIjzI3gJdnLdyaTZgVyMmNKUH7cX3YWBnU3uTn7LvyISYS5s6POQSoIXS
    PnG2jJeRbgk2dYoOcaIzVJP4z6Kv7mDN3CSHZr/v9Q/8XbGFLyZY57ezaTXqqEJS
    iQn6HzzX1rXvIY1mDEOD9Zmn/D7iY+c5Ua09SMEw/GISjyD0eNCsYLi5inSSCiVg
    Inj1mv2OmgqZ9dBhDrqYw+bq1S0J+S6ohGU6qn+nncyAh2I7D4FD11329jjnAjMr
    gvMaQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=sN9UW2xw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ibibC/np;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=sN9UW2xw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ibibC/np;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvGJnQm1EA/in1qQJPsy7tlBIK4uHASXUQQOPO8PP4BLTpnPinLmkbYn2oRk6fTYxnDTuZD4WeW3DK3FR81LNs=
MIME-Version: 1.0
In-Reply-To: <DM5PR21MB0826C68DB09C3856F9078931F6DF0@DM5PR21MB0826.namprd21.prod.outlook.com>
References: <DM5PR21MB0826CE724BFB0C2A9AB96014F6DF0@DM5PR21MB0826.namprd21.prod.outlook.com>
 <DM5PR21MB0826C68DB09C3856F9078931F6DF0@DM5PR21MB0826.namprd21.prod.outlook.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 8 Mar 2018 13:40:04 -0800
Message-ID: <CAErSpo4RTtp8x6zrSSyJ1ft1aoX6Y2BThoeB7NVcF6Mn1Q8WHQ@mail.gmail.com>
Subject: Re: [PATCH] PCI BUS domain ID corruption
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: David Davis <David.Davis@microsoft.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jake Oshins <jakeo@microsoft.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[+cc Lorenzo]

On Thu, Mar 8, 2018 at 12:55 PM, Sridhar Pitchai
<Sridhar.Pitchai@microsoft.com> wrote:
> Hi,
>
> I would like to submit the following patch. This patch addresses the issue
> when we try to add a VMBUS, the domain ID for the PCI bus is overwritten.

Hi Sridhar,

Thanks for the patch!

This area is maintained by Lorenzo now (cc'd), so please copy him on
the next round.

We can't apply it as-is because it contains no Signed-off-by (see
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst).

This email is also too fancy (HTML, etc) and I think will be rejected
by the mailing lists (see
http://vger.kernel.org/majordomo-info.html#taboo).  What you want is a
plain-text email.

Please also run "git log drivers/pci/host/pci-hyperv.c" and make your
subject and changelog match the format and style of previous patches.

It looks like this basically reverts 4a9b0933bdfc ("PCI: hv: Use
device serial number as PCI domain"), so you should explain what was
wrong with that commit.

Also, it doesn't look like this would apply cleanly to v4.16-rc1.
Your patch shows this:

 -               hbus->sysdata.domain = desc->ser & 0xFFFF;

but v4.16-rc1 has this:

                hbus->sysdata.domain = desc->ser;

Bjorn

> srpitcha@ linux srpitcha/patch >cat 0001-PCI-BUS-domain-ID-curruption.patch
>
> From a0c407f3e2d57c84ac349f064dcee1d2961e5ca3 Mon Sep 17 00:00:00 2001
>
> From: Sridhar Pitchai <sridhar.pitchai@gmail.com>
>
> Date: Thu, 8 Mar 2018 12:33:50 -0800
>
> Subject: [PATCH] PCI BUS domain ID corruption
>
>
>
>     When PCI BUS is added, PCI_BUS domain ID is set. When PCI_BUS and device
> to
>
>     the bus is racing against each other, the first device tends to
> overwrite
>
>     the domain ID. In order to avoid the race, this patch make sure when a
>
>     device is added to a bus it never updates the bus domain ID. Since we
> have
>
>     the transparent SRIOV mode now, the short VF device name is no longer
>
>     needed.
>
>
>
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
>
> index 1713bfc..6d43f81 100644
>
> --- a/drivers/pci/host/pci-hyperv.c
>
> +++ b/drivers/pci/host/pci-hyperv.c
>
> @@ -1321,19 +1321,6 @@ static struct hv_pci_dev *new_pcichild_device(struct
> hv_pcibus_device *hbus,
>
>         get_pcichild(hpdev, hv_pcidev_ref_childlist);
>
>         spin_lock_irqsave(&hbus->device_list_lock, flags);
>
>
>
> -       /*
>
> -        * When a device is being added to the bus, we set the PCI domain
>
> -        * number to be the device serial number, which is non-zero and
>
> -        * unique on the same VM.  The serial numbers start with 1, and
>
> -        * increase by 1 for each device.  So device names including this
>
> -        * can have shorter names than based on the bus instance UUID.
>
> -        * Only the first device serial number is used for domain, so the
>
> -        * domain number will not change after the first device is added.
>
> -        * The lower 16 bits of the serial number is used, otherwise some
>
> -        * drivers may not be able to handle it.
>
> -        */
>
> -       if (list_empty(&hbus->children))
>
> -               hbus->sysdata.domain = desc->ser & 0xFFFF;
>
>         list_add_tail(&hpdev->list_entry, &hbus->children);
>
>         spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>
>         return hpdev;
>
> --
>
> 2.7.4
>
>
>
> srpitcha@ linux srpitcha/patch >
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
