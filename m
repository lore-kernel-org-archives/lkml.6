Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2691517-1519646211-2-5517242100875442552
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519646210; b=Wnk0LWIP93GCwko2P4wos6hxXC4zEDv9Shq36JdyEgtD3IA
    H2d50FknISCH0vkygVKEm3yraCX/2yFBg6//tluUf6rdU1iEsrLLjF5hYnYDe3GB
    wtSaZ4dAztu0ihhBr9T3mSxC81owNfEDGPuuz8+vtXsqNZigtqiSPHXUyRvffoMJ
    vlakskaIY52iaVM12f4FWdZsI4Fs/iBWfCFDYNpH4tbio83rqbmmgcR9sSkaQ9+k
    x7uFn/J1y2ffAJIG+sNFYBTGglkfNIIzFI/IkLxLkDUZurJBEYsFJ7Bf9ASUGpIk
    j31vKDM8hEGM3fG40yTGGiWcxnjwvNIMkfjzlsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519646210; bh=cahs0+gmdNJHC187Qb21OkVC4N+Ovr/xPwTJlmSrSls=; b=F
    q49zfFbPQ7X0NhHkMkzfV4kRgNXQsPTm1mQZXcBudwyfh2q+Azgw+FbweOeU75xL
    OzM7Wa8kHmg5aODtPYSUJlT+xMmqRnzmokUOe7rkayJydPbVynwQE8Os24sTZNPs
    TJ3DDATk1d7Pi+TYt3alvRXLRWlLk/oub0la6xwxdoL8VU43Aquhw7bvEUKzCB0I
    0EDE7NpUeeKYosvrSJr8abD2FJBFVWW21jKvtbONrGiOW0WZemhVXuf9+cDMuHnM
    BI5uTYaMwrWN4LijvZQtKof8Ddr3XZ5uHu1STOJf6wc3eLfZcal22NE4yhy95jJv
    bIeCcqSYPXn9VszYYu7vw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbeBZL4r (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 06:56:47 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5709 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752157AbeBZL4r (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Feb 2018 06:56:47 -0500
Subject: Re: [RFC PATCH 0/2] serial: 8250_dw: IO space + polling mode support
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <p.zabel@pengutronix.de>, <heiko@sntech.de>,
        <ed.blake@sondrel.com>, <jhogan@kernel.org>
References: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
 <1519381801.10722.103.camel@linux.intel.com>
 <3c4c5f58-a661-13c8-cc1c-8d43828982cb@huawei.com>
 <1519407117.10722.124.camel@linux.intel.com>
 <88214a3e-82cc-c931-804c-7dc90fb8721f@huawei.com>
 <1519638828.10722.153.camel@linux.intel.com>
 <7221877b-a84a-63a1-ef86-1991f358df72@huawei.com>
 <1519644517.10722.179.camel@linux.intel.com>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <b5904a5a-66d8-4385-cc5b-a52529e9d28f@huawei.com>
Date: Mon, 26 Feb 2018 11:56:15 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1519644517.10722.179.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>>>>> Why you can't do properly in ACPI?
>>>
>>> No answer here either.
>>>
>>> Sorry, but with this level of communication it's no go for the
>>> series.
>>>
>>
>> Sorry if my answers did not tell you want you want to know.
>>
>> My point was that the 8250_pnp driver would be used for a pnp_device,
>> but we are creating a platform device for this UART slave so would
>> require a platform device driver, that which 8250_dw.c is. But I will
>> check on pnp device support.
>

Hi Andy,

> Perhaps it's not visible, though below is a description of the drivers
> we have:
>
> 8250_dw - OF/ACPI driver for Synopsys DW (+ DW DMA)
> 8250_lpss - PCI driver for Synopsys DW (+ DW DMA)
> 8250_of -  generic 8250 compatible driver for OF
> 8250_pci - generic 8250 compatible driver for PCI
> 8250_pnp - generic 8250 compatible driver for ACPI
>
> 8250_* (except core parts) - custom glue drivers per some IPs
>
> By description you gave your driver fits 8250_pnp if ACPI tables crafted
> properly.
>
> Share the ACPI excerpt and we can discuss further how to improve them.
>

For a bit of background, MFD support was discussed here initially:
https://lkml.org/lkml/2017/6/13/796

Here is the ACPI table:
Scope(_SB) {
   Device (LPC0) {
     Name (_HID, "HISI0191")  // HiSi LPC
     Name (_CRS, ResourceTemplate () {
       Memory32Fixed (ReadWrite, 0xa01b0000, 0x1000)
     })
   }

   Device (LPC0.CON0) {
     Name (_HID, "HISI1031")
     // Name (_CID, "PNP0501") // cannot support PNP
     Name (LORS, ResourceTemplate() {
       QWordIO (
         ResourceConsumer,
     MinNotFixed,     // _MIF
     MaxNotFixed,     // _MAF
     PosDecode,
     EntireRange,
     0x0,             // _GRA
     0x2F8,           // _MIN
     0x3fff,          // _MAX
     0x0,             // _TRA
     0x08,            // _LEN
     , ,
     IO02


The latest framework changes and host driver patchset are here:
https://lkml.org/lkml/2018/2/19/465

Here is how we probe the children:
static int hisi_lpc_acpi_set_io_res(struct device *child,
                     struct device *hostdev,
                     const struct resource **res,
                     int *num_res)
{

     [ ... In this part we just get the child resources ]


     /* translate the I/O resources */
     for (i = 0; i < count; i++) {
         int ret;

         if (!(resources[i].flags & IORESOURCE_IO))
             continue;
         ret = hisi_lpc_acpi_xlat_io_res(adev, host, &resources[i]);
         if (ret) {
             dev_err(child, "translate IO range failed(%d)\n", ret);
             return ret;
         }
     }
     *res = resources;
     *num_res = count;

     return 0;
}

static int hisi_lpc_acpi_probe(struct device *hostdev)
{
     struct acpi_device *adev = ACPI_COMPANION(hostdev);
     struct hisi_lpc_mfd_cell *hisi_lpc_mfd_cells;
     struct mfd_cell *mfd_cells;
     struct acpi_device *child;
     int size, ret, count = 0, cell_num = 0;

     list_for_each_entry(child, &adev->children, node)
         cell_num++;

     /* allocate the mfd cell and companion acpi info, one per child */
     size = sizeof(*mfd_cells) + sizeof(*hisi_lpc_mfd_cells);
     mfd_cells = devm_kcalloc(hostdev, cell_num, size, GFP_KERNEL);
     if (!mfd_cells)
         return -ENOMEM;

     hisi_lpc_mfd_cells = (struct hisi_lpc_mfd_cell *)
                     &mfd_cells[cell_num];
     /* Only consider the children of the host */
     list_for_each_entry(child, &adev->children, node) {
         struct mfd_cell *mfd_cell = &mfd_cells[count];
         struct hisi_lpc_mfd_cell *hisi_lpc_mfd_cell =
                     &hisi_lpc_mfd_cells[count];
         struct mfd_cell_acpi_match *acpi_match =
                     &hisi_lpc_mfd_cell->acpi_match;
         char *name = hisi_lpc_mfd_cell[count].name;
         char *pnpid = hisi_lpc_mfd_cell[count].pnpid;
         struct mfd_cell_acpi_match match = {
             .pnpid = pnpid,
         };

         snprintf(name, MFD_CHILD_NAME_LEN, MFD_CHILD_NAME_PREFIX"%s",
              acpi_device_hid(child));
         snprintf(pnpid, ACPI_ID_LEN, "%s", acpi_device_hid(child));

         memcpy(acpi_match, &match, sizeof(*acpi_match));
         mfd_cell->name = name;
         mfd_cell->acpi_match = acpi_match;

         ret = hisi_lpc_acpi_set_io_res(&child->dev, &adev->dev,
                            &mfd_cell->resources,
                            &mfd_cell->num_resources);
         if (ret) {
             dev_warn(&child->dev, "set resource fail(%d)\n", ret);
             return ret;
         }
         count++;
     }

     ret = mfd_add_devices(hostdev, PLATFORM_DEVID_NONE,
                   mfd_cells, cell_num, NULL, 0, NULL);
     if (ret) {
         dev_err(hostdev, "failed to add mfd cells (%d)\n", ret);
         return ret;
     }

     return 0;
}

As you know, this is not accepted upstream yet, but I really hope I'm 
close. Hence the RFC tag for the UART patchset.

Please let me know if you require more details.

Thanks,
John


