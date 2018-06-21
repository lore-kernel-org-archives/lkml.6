Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAA7C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D8821C67
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atihoX9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D8821C67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933310AbeFUUlM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:41:12 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36010 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933051AbeFUUlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:41:10 -0400
Received: by mail-vk0-f67.google.com with SMTP id o138-v6so2684831vkd.3;
        Thu, 21 Jun 2018 13:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=eamZB/Nd8bIjCnz316e0++iDtDbNrYCI2AyO7joVkJI=;
        b=atihoX9kwB9jZNIWNNzyP8lUKWmvQIaTUwWBr9noShcuVHaH3xmGxZ/DZPmBpTC/xZ
         W6RU+pyiAVZmcgPlvkqLWzjOXIw6nqAfyLgy6KHPx3Hotu/b/kboKBOPDDhEXk6lDnFU
         oAWGsBbwvwDrx0SpYWDZGfApI1Vbf9X0XIK/ATnIBWXvfPg0GHyGBG2UmIUc4tAdCeNN
         Ag5mjNTWRpL8MTqNrsgeRbOfNw8nvjtaEhipznuf9TNc+j2rhIFzAHN9W1lb19/gEo5r
         Gm9ydCQj8GTB+U+FtBNOKNBiYgG8RttPYkIQzQmtS0IVCwzfrv6ybxZy3XrWbKykKK53
         RwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=eamZB/Nd8bIjCnz316e0++iDtDbNrYCI2AyO7joVkJI=;
        b=HTYb/1axgRtkoR+TZ9Uoum3+ucDUwUEtx9cIRa4f9+sa1ivaCmOHV1ieqH1xmWjBCu
         NuK/OZnR1srYNKQB9jm69Qavreg3WVLuKL41L9/hPWe6LNyZBgMTwLGN1j+oTlHaYBVV
         ild7n3Ap3bei29Qt5aYqpXy5rkFopE+pjZtt/DsUPWPxeiJriXN3LmmyIk4MIqCuwgja
         Mj4TNhs1Fzc+xGsCxaEWZQ2/278siMDK4ebVXzLtjAU1EHHMlmv5stPlF2XGZaYAhjta
         wspbkhxSFmCwiNgIASMGUEBxnKW95D4MVKWor63smLuOJ/R6aXFeDm0sbJ8llA61o/MJ
         4whA==
X-Gm-Message-State: APt69E2mtWiiUZDubE3CpbQteo5FzRzkdZXpQU+X6NItiCmcJL3wVpm/
        lp+lIUw8ohZiQw+/CcV1aHFXjKTa7as1kGLQ3kM=
X-Google-Smtp-Source: ADUXVKJJ1yhRTNklbxH2nUIDIQiZXh/ZWlBsskWzgF+40/77hZXBHd3TJbbF8w90kV2z6NMzFVHdO5UcDrnmLnbV1cU=
X-Received: by 2002:a1f:1d0f:: with SMTP id d15-v6mr16942106vkd.113.1529613669154;
 Thu, 21 Jun 2018 13:41:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:3593:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 13:41:08
 -0700 (PDT)
Reply-To: rajatxjain@gmail.com
In-Reply-To: <20180621131734.GA14136@bhelgaas-glaptop.roam.corp.google.com>
References: <20180522222805.80314-1-rajatja@google.com> <20180620234147.48438-1-rajatja@google.com>
 <20180621131734.GA14136@bhelgaas-glaptop.roam.corp.google.com>
From:   Rajat Jain <rajatxjain@gmail.com>
Date:   Thu, 21 Jun 2018 13:41:08 -0700
Message-ID: <CAA93t1o0EgL+wJ3tkE03iJSD=qc2zXQHXdNzUFg5K8awUoezNA@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] PCI/AER: Define and allocate aer_stats structure
 for AER capable devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jes Sorensen <jsorensen@fb.com>, Kyle McMartin <jkkm@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 6:17 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Wed, Jun 20, 2018 at 04:41:43PM -0700, Rajat Jain wrote:
>> Define a structure to hold the AER statistics. There are 2 groups
>> of statistics: dev_* counters that are to be collected for all AER
>> capable devices and rootport_* counters that are collected for all
>> (AER capable) rootports only. Allocate and free this structure when
>> device is added or released (thus counters survive the lifetime of the
>> device).
>>
>> Signed-off-by: Rajat Jain <rajatja@google.com>
>> ---
>> v5: Same as v4
>> v4: Same as v3
>> v3: Merge everything in aer.c
>>
>>  drivers/pci/pcie/aer.c | 60 ++++++++++++++++++++++++++++++++++++++++++
>>  drivers/pci/probe.c    |  1 +
>>  include/linux/pci.h    |  3 +++
>>  3 files changed, 64 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index a2e88386af28..f9fa994b6c33 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -33,6 +33,9 @@
>>  #define AER_ERROR_SOURCES_MAX                100
>>  #define AER_MAX_MULTI_ERR_DEVICES    5       /* Not likely to have more */
>>
>> +#define AER_MAX_TYPEOF_CORRECTABLE_ERRS 16   /* as per PCI_ERR_COR_STATUS */
>> +#define AER_MAX_TYPEOF_UNCORRECTABLE_ERRS 26 /* as per PCI_ERR_UNCOR_STATUS*/
>> +
>>  struct aer_err_info {
>>       struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
>>       int error_dev_num;
>> @@ -76,6 +79,40 @@ struct aer_rpc {
>>                                        */
>>  };
>>
>> +/* AER stats for the device */
>> +struct aer_stats {
>> +
>> +     /*
>> +      * Fields for all AER capable devices. They indicate the errors
>> +      * "as seen by this device". Note that this may mean that if an
>> +      * end point is causing problems, the AER counters may increment
>> +      * at its link partner (e.g. root port) because the errors will be
>> +      * "seen" by the link partner and not the the problematic end point
>> +      * itself (which may report all counters as 0 as it never saw any
>> +      * problems).
>> +      */
>> +     /* Individual counters for different type of correctable errors */
>> +     u64 dev_cor_errs[AER_MAX_TYPEOF_CORRECTABLE_ERRS];
>> +     /* Individual counters for different type of uncorrectable errors */
>> +     u64 dev_uncor_errs[AER_MAX_TYPEOF_UNCORRECTABLE_ERRS];
>> +     /* Total number of correctable errors seen by this device */
>> +     u64 dev_total_cor_errs;
>> +     /* Total number of fatal uncorrectable errors seen by this device */
>> +     u64 dev_total_fatal_errs;
>> +     /* Total number of fatal uncorrectable errors seen by this device */
>> +     u64 dev_total_nonfatal_errs;
>> +
>> +     /*
>> +      * Fields for Root ports only, these indicate the total number of
>> +      * ERR_COR, ERR_FATAL, and ERR_NONFATAL messages received by the
>> +      * rootport, INCLUDING the ones that are generated internally (by
>> +      * the rootport itself)
>
> Strictly speaking, I think these are applicable for both root ports
> and root complex event collectors, right?

Correct, I will reword this comment to state this.

>
>> +      */
>> +     u64 rootport_total_cor_errs;
>> +     u64 rootport_total_fatal_errs;
>> +     u64 rootport_total_nonfatal_errs;
>> +};
>> +
>>  #define AER_LOG_TLP_MASKS            (PCI_ERR_UNC_POISON_TLP|        \
>>                                       PCI_ERR_UNC_ECRC|               \
>>                                       PCI_ERR_UNC_UNSUP|              \
>> @@ -402,12 +439,35 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>>       return 0;
>>  }
>>
>> +static int pci_aer_stats_init(struct pci_dev *pdev)
>> +{
>> +     pdev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
>> +     if (!pdev->aer_stats) {
>> +             dev_err(&pdev->dev, "No memory for aer_stats\n");
>
> pci_err(), if we need the message at all.
>
> Based on c7abb2352c29 ("PCI: Remove unnecessary messages for memory
> allocation failures"), I'd be inclined to drop the message completely.

Will do.

>
>> +             return -ENOMEM;
>> +     }
>> +     return 0;
>> +}
>> +
>> +static void pci_aer_stats_exit(struct pci_dev *pdev)
>> +{
>> +     kfree(pdev->aer_stats);
>> +     pdev->aer_stats = NULL;
>> +}
>> +
>>  int pci_aer_init(struct pci_dev *dev)
>>  {
>>       dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
>> +     if (!dev->aer_cap || pci_aer_stats_init(dev))
>> +             return -EIO;
>
> This skips pci_cleanup_aer_error_status_regs() if the kzalloc() fails.
> I think we should still do pci_cleanup_aer_error_status_regs(), even
> if the alloc fails.

Will do.

>
> Nobody checks the return value of pci_aer_init(), so I think you can
> simplify this by making these functions void.

Will do.

>
> Maybe even squash them together, i.e., do the kzalloc() directly in
> pci_aer_init() and the kfree() directly in pci_aer_exit()?

Will do.

>
>>       return pci_cleanup_aer_error_status_regs(dev);
>>  }
>>
>> +void pci_aer_exit(struct pci_dev *dev)
>> +{
>> +     pci_aer_stats_exit(dev);
>> +}
>> +
>>  #define AER_AGENT_RECEIVER           0
>>  #define AER_AGENT_REQUESTER          1
>>  #define AER_AGENT_COMPLETER          2
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index ac876e32de4b..48edd0c9e4bc 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -2064,6 +2064,7 @@ static void pci_configure_device(struct pci_dev *dev)
>>
>>  static void pci_release_capabilities(struct pci_dev *dev)
>>  {
>> +     pci_aer_exit(dev);
>>       pci_vpd_release(dev);
>>       pci_iov_release(dev);
>>       pci_free_cap_save_buffers(dev);
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 340029b2fb38..8d59c6c19a19 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -299,6 +299,7 @@ struct pci_dev {
>>       u8              hdr_type;       /* PCI header type (`multi' flag masked out) */
>>  #ifdef CONFIG_PCIEAER
>>       u16             aer_cap;        /* AER capability offset */
>> +     struct aer_stats *aer_stats;    /* AER stats for this device */
>>  #endif
>>       u8              pcie_cap;       /* PCIe capability offset */
>>       u8              msi_cap;        /* MSI capability offset */
>> @@ -1471,10 +1472,12 @@ static inline bool pcie_aspm_support_enabled(void) { return false; }
>>  void pci_no_aer(void);
>>  bool pci_aer_available(void);
>>  int pci_aer_init(struct pci_dev *dev);
>> +void pci_aer_exit(struct pci_dev *dev);
>
> With the exception of pci_aer_available(), these are only used inside
> drivers/pci.  This might be a good opportunity to move those private
> things to drivers/pci/pci.h (in a separate patch, of course).


Will do.

>
>>  #else
>>  static inline void pci_no_aer(void) { }
>>  static inline bool pci_aer_available(void) { return false; }
>>  static inline int pci_aer_init(struct pci_dev *d) { return -ENODEV; }
>> +static inline void pci_aer_exit(struct pci_dev *d) { }
>>  #endif
>>
>>  #ifdef CONFIG_PCIE_ECRC
>> --
>> 2.18.0.rc1.244.gcf134e6275-goog
>>
