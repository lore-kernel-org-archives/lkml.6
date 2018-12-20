Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDD5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D642176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="LUMfaB8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387444AbeLTJnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:43:47 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36533 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730083AbeLTJnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:43:43 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so1166487edb.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 01:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AuYWKtB3AedCsr7ZStOSV6z1TUK2bg1O2ykh2VBAAxg=;
        b=LUMfaB8AnZg7SdYMjLO78foOWXmiKeiLzpWQP+DKF/EeZL3V9VJP69xY5vlbXJv1X9
         XMSYafHHg3v/PnpOwsJ/O30jsWWXYGFTls7pjDpNf/FWEJOWF75odoypdl58pVobit/b
         whNAhOE7rJPWdgP06FTQMmeEeXfiBhTRJGZFlxo7CE/W4whOiUc1xOLbmvpB2/371j2T
         C5X4vGI2VaZMT4i78iZDSXh32izaf3fFjr/7c9viDgaelprxsUso6FviQtyrI3q4ueZQ
         4K4rNAujbfPmlQqc+ISmfzt+QMEEAvsk0+8OGwILFsYcUgWmWw34Vs6KJ/dskdcpCYt+
         HkRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AuYWKtB3AedCsr7ZStOSV6z1TUK2bg1O2ykh2VBAAxg=;
        b=TJQAdPbktPEmrwbKgg4n+S7uOFsHkp8Lb9OIbDlgmZSI3DzeMHkigKJ91ACrsZS1ik
         oDSnRARti2UJC+ID7gwojVOm9y8/qtBpXyDzdRBIq+FZClGofU8X6+ExeWhXxfwDFIVh
         IGRLvFvscZqEc3IjsxNqbKbCcQjVrlMQb7vk9lS66N1mxgTORdOfZQPyRm6dge2yxRpj
         OuCoFILEM/Ote32ZGqJ/ou9EjkPmELUhK1Ro1cBosEUWk/X2NJ7pCZdf3JHplWpvb1nE
         NTlOVECOzIyC6cWcX5VycQYDUf9cGSy1Bp/2vnXMGJTpitbTHWM25aGK+dh3v4aLmLVN
         3XdA==
X-Gm-Message-State: AA+aEWaOPIewQO7YfHnUUhK0+9fZlrv0b4V9wrqG6UoVj3my8ZLeJ1Lr
        jp8ZLemtaDzOVWbGJvTzE17RqtOcoBxoGKZ3+/PWMA==
X-Google-Smtp-Source: AFSGD/WNwkbN2sGR8V3ghriZdj/5EoXjoX4uqIFM+Lx/FpNxbgJV5tmTc8uncvH54mYLS72WoC+iZRyuA8GswJWu/lY=
X-Received: by 2002:a50:c31a:: with SMTP id a26mr18218127edb.160.1545299020882;
 Thu, 20 Dec 2018 01:43:40 -0800 (PST)
MIME-Version: 1.0
References: <CAB4CAwfH156yEd-XAkt==u+S8bO0U2=sg8nVr4o57C1q3K97Kw@mail.gmail.com>
 <CAB4CAwc4ubdXn7kzPeu2L--ciATgZWYkO350fvFF43-jj180xw@mail.gmail.com>
 <59069da6-befc-2ebe-f2e2-e95a6a714013@gmail.com> <CAB4CAweArBEDWBvJwcnME6TBRUHYmOboKDf_4dDMvs81yZU3hw@mail.gmail.com>
 <d217e5b0-6008-c1f2-38fd-a41a7757e047@gmail.com> <CAB4CAwcr+V+7b2uuaFtkOHNKP3Xep5dNkZQBrVQiEq_eg5PpAw@mail.gmail.com>
 <7c245fa2-75bb-8ff9-5ffa-83262e3470fe@gmail.com> <CAB4CAwepsfaDm6rdxy=RZGuTxjtfsK7yoD5Jkker1AfS7vrZxg@mail.gmail.com>
 <38e4563f-99ae-d5ee-782d-1c309599cfbf@gmail.com>
In-Reply-To: <38e4563f-99ae-d5ee-782d-1c309599cfbf@gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 20 Dec 2018 17:43:29 +0800
Message-ID: <CAB4CAwcBqDDUkwOZLHd5_MbWFKj3QHQa9Yq24LE+V+BeGS486g@mail.gmail.com>
Subject: Re: A weird problem of Realtek r8168 after resume from S3
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     nic_swsd <nic_swsd@realtek.com>, davem@davemloft.net,
        netdev@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 3:41 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 19.12.2018 16:32, Chris Chiu wrote:
> > On Wed, Dec 19, 2018 at 4:28 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >>
> >> On 18.12.2018 14:25, Chris Chiu wrote:
> >>> On Tue, Dec 18, 2018 at 3:08 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >>>>
> >>>> On 17.12.2018 14:25, Chris Chiu wrote:
> >>>>> On Fri, Dec 14, 2018 at 3:37 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >>>>>>
> >>>>>> On 14.12.2018 04:33, Chris Chiu wrote:
> >>>>>>> On Thu, Dec 13, 2018 at 10:20 AM Chris Chiu <chiu@endlessm.com> wrote:
> >>>>>>>>
> >>>>>>>> Hi,
> >>>>>>>>     We got an acer laptop which has a problem with ethernet networking after
> >>>>>>>> resuming from S3. The ethernet is popular realtek r8168. The lspci shows as
> >>>>>>>> follows.
> >>>>>>>> 02:00.1 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
> >>>>>>>> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 12)
> >>>>>>>>
> >>>>>> Helpful would be a "dmesg | grep r8169", especially chip name + XID.
> >>>>>>
> >>>>> [   22.362774] r8169 0000:02:00.1 (unnamed net_device)
> >>>>> (uninitialized): mac_version = 0x2b
> >>>>> [   22.365580] libphy: r8169: probed
> >>>>> [   22.365958] r8169 0000:02:00.1 eth0: RTL8411, 00:e0:b8:1f:cb:83,
> >>>>> XID 5c800800, IRQ 38
> >>>>> [   22.365961] r8169 0000:02:00.1 eth0: jumbo features [frames: 9200
> >>>>> bytes, tx checksumming: ko]
> >>>>>
> >>>> Thanks for the info.
> >>>>
> >>>>>>>>     The problem is the ethernet is not accessible after resume. Pinging via
> >>>>>>>> ethernet always shows the response `Destination Host Unreachable`. However,
> >>>>>>>> the interesting part is, when I run tcpdump to monitor the problematic ethernet
> >>>>>>>> interface, the networking is back to alive. But it's dead again after
> >>>>>>>> I stop tcpdump.
> >>>>>>>> One more thing, if I ping the problematic machine from others, it achieves the
> >>>>>>>> same effect as above tcpdump. Maybe it's about the register setting for RX path?
> >>>>>>>>
> >>>>>> You could compare the register dumps (ethtool -d) before and after S3 sleep
> >>>>>> to find out whether there's a difference.
> >>>>>>
> >>>>>
> >>>>> Actually, I just found I lead the wrong direction. The S3 suspend does
> >>>>> help to reproduce,
> >>>>> but it's not necessary. All I need to do is ping around 5 mins and the
> >>>>> network connection
> >>>>> fails.  And I also find one thing interesting, disabling the  MSI-X
> >>>>> interrupt like commit
> >>>>> [d49c88d7677ba737e9d2759a87db0402d5ab2607] can fix this problem.
> >>>>> Although I don't
> >>>>> understand the root cause. Anything I can do to help?
> >>>>>
> >>>> This is indeed very, very weird. You say switching from MSI-X to MSI fixes
> >>>> the issue, but also pinging the machine from outside brings back the network.
> >>>> Both actions affect totally different corners.
> >>>>
> >>>> The commit and related issue you mention was a workaround in the driver,
> >>>> the root cause was a MSI-X-related  issue with certain Intel chipsets deep
> >>>> in the PCI core. After this was fixed we removed the workaround again.
> >>>> This shouldn't be related to your issue.
> >>>>
> >>>> Hard to say for now is whether the issue is:
> >>>> - a driver issue
> >>>> - a hardware issue in the RTL8411
> >>>> - an issue with the chipset on your mainboard
> >>>>
> >>>> According to your description it doesn't take a special scenario to trigger
> >>>> the issue, so most likely also other users of Acer notebooks with RTL8411
> >>>> should be affected (after briefly checking this should be at least Aspire
> >>>> F15, V15, V7). Therefore I wonder why there aren't more reports.
> >>>>
> >>>> This commit added MSI-X support: 6c6aa15fdea5 ("r8169: improve interrupt handling")
> >>>> So you could test this revision and the one before.
> >>>>
> >>>> Eventually, if the issue really should be caused by a side effect of using
> >>>> MSI-X, then the question is whether we need to disable MSI-X for RTL8411
> >>>> in general or just for RTL8411 and a certain subsystem id.
> >>>>
> >>>
> >>> I tried the kernel with the head on 6c6aa15fdea5 ("r8169: improve
> >>> interrupt handling"),
> >>> the problem still there. Then I revert to the previous revision, the
> >>> problem goes away.
> >>> So I think it's pretty much the side effect of MSI-X. However, as you
> >>> mentioned that
> >>> you didn't hit this problem, I'll ask the vendor to verify if this
> >>> problem also happens on
> >>> other machines with the same chip. Then we can determine to disable for specific
> >>> mac version or just a certain subsystem id.
> >>>
> >>>>>>>>     I tried the latest 4.20 rc version but the problem still there. I
> >>>>>>>> also tried some
> >>>>>>>> hw_reset or init thing in the resume path but no effect. Any
> >>>>>>>> suggestion for this?
> >>>>>>>> Thanks
> >>>>>>>>
> >>>>>> Did previous kernel versions work? If it's a regression, a bisect would be
> >>>>>> appreciated, because with the chip versions I've got I can't reproduce the issue.
> >>>>>>
> >>>>>>>> Chris
> >>>>>>>
> >>>>>>> Gentle ping. Any additional information required?
> >>>>>>>
> >>>>>>> Chris
> >>>>>>>
> >>>>>> Heiner
> >>>>>
> >>>>
> >>>
> >>
> >> As an additional note:
> >> I found that the rtsx_pci driver doesn't support MSI-X currently.
> >> The following patch adds MSI-X support (it's compile-tested only
> >> because I don't have a system with RTL8411).
> >> Would be interesting to see whether it makes a difference if both
> >> components on this combo chip use MSI-X.
> >>
> >> ---
> >>  drivers/misc/cardreader/rtsx_pcr.c | 51 ++++++++++--------------------
> >>  include/linux/rtsx_pci.h           |  1 -
> >>  2 files changed, 16 insertions(+), 36 deletions(-)
> >>
> >> diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
> >> index da445223f..d1349c248 100644
> >> --- a/drivers/misc/cardreader/rtsx_pcr.c
> >> +++ b/drivers/misc/cardreader/rtsx_pcr.c
> >> @@ -35,10 +35,6 @@
> >>
> >>  #include "rtsx_pcr.h"
> >>
> >> -static bool msi_en = true;
> >> -module_param(msi_en, bool, S_IRUGO | S_IWUSR);
> >> -MODULE_PARM_DESC(msi_en, "Enable MSI");
> >> -
> >>  static DEFINE_IDR(rtsx_pci_idr);
> >>  static DEFINE_SPINLOCK(rtsx_pci_lock);
> >>
> >> @@ -1049,22 +1045,21 @@ static irqreturn_t rtsx_pci_isr(int irq, void *dev_id)
> >>
> >>  static int rtsx_pci_acquire_irq(struct rtsx_pcr *pcr)
> >>  {
> >> -       pcr_dbg(pcr, "%s: pcr->msi_en = %d, pci->irq = %d\n",
> >> -                       __func__, pcr->msi_en, pcr->pci->irq);
> >> +       int ret;
> >>
> >> -       if (request_irq(pcr->pci->irq, rtsx_pci_isr,
> >> -                       pcr->msi_en ? 0 : IRQF_SHARED,
> >> -                       DRV_NAME_RTSX_PCI, pcr)) {
> >> -               dev_err(&(pcr->pci->dev),
> >> -                       "rtsx_sdmmc: unable to grab IRQ %d, disabling device\n",
> >> -                       pcr->pci->irq);
> >> -               return -1;
> >> -       }
> >> +       ret = pci_alloc_irq_vectors(pcr->pci, 1, 1, PCI_IRQ_ALL_TYPES);
> >> +       if (ret < 0)
> >> +               goto err;
> >>
> >> -       pcr->irq = pcr->pci->irq;
> >> -       pci_intx(pcr->pci, !pcr->msi_en);
> >> +       ret = pci_request_irq(pcr->pci, 0, rtsx_pci_isr, NULL, pcr,
> >> +                             DRV_NAME_RTSX_PCI);
> >> +       if (ret)
> >> +               goto err;
> >>
> >>         return 0;
> >> +err:
> >> +       pci_err(pcr->pci, "rtsx_sdmmc: unable to grab interrupt\n");
> >> +       return ret;
> >>  }
> >>
> >>  static void rtsx_enable_aspm(struct rtsx_pcr *pcr)
> >> @@ -1496,19 +1491,11 @@ static int rtsx_pci_probe(struct pci_dev *pcidev,
> >>         INIT_DELAYED_WORK(&pcr->carddet_work, rtsx_pci_card_detect);
> >>         INIT_DELAYED_WORK(&pcr->idle_work, rtsx_pci_idle_work);
> >>
> >> -       pcr->msi_en = msi_en;
> >> -       if (pcr->msi_en) {
> >> -               ret = pci_enable_msi(pcidev);
> >> -               if (ret)
> >> -                       pcr->msi_en = false;
> >> -       }
> >> -
> >>         ret = rtsx_pci_acquire_irq(pcr);
> >>         if (ret < 0)
> >> -               goto disable_msi;
> >> +               goto free_dma;
> >>
> >>         pci_set_master(pcidev);
> >> -       synchronize_irq(pcr->irq);
> >>
> >>         ret = rtsx_pci_init_chip(pcr);
> >>         if (ret < 0)
> >> @@ -1528,10 +1515,8 @@ static int rtsx_pci_probe(struct pci_dev *pcidev,
> >>         return 0;
> >>
> >>  disable_irq:
> >> -       free_irq(pcr->irq, (void *)pcr);
> >> -disable_msi:
> >> -       if (pcr->msi_en)
> >> -               pci_disable_msi(pcr->pci);
> >> +       pci_free_irq(pcr->pci, 0, pcr);
> >> +free_dma:
> >>         dma_free_coherent(&(pcr->pci->dev), RTSX_RESV_BUF_LEN,
> >>                         pcr->rtsx_resv_buf, pcr->rtsx_resv_buf_addr);
> >>  unmap:
> >> @@ -1568,9 +1553,7 @@ static void rtsx_pci_remove(struct pci_dev *pcidev)
> >>
> >>         dma_free_coherent(&(pcr->pci->dev), RTSX_RESV_BUF_LEN,
> >>                         pcr->rtsx_resv_buf, pcr->rtsx_resv_buf_addr);
> >> -       free_irq(pcr->irq, (void *)pcr);
> >> -       if (pcr->msi_en)
> >> -               pci_disable_msi(pcr->pci);
> >> +       pci_free_irq(pcr->pci, 0, pcr);
> >>         iounmap(pcr->remap_addr);
> >>
> >>         pci_release_regions(pcidev);
> >> @@ -1664,9 +1647,7 @@ static void rtsx_pci_shutdown(struct pci_dev *pcidev)
> >>         rtsx_pci_power_off(pcr, HOST_ENTER_S1);
> >>
> >>         pci_disable_device(pcidev);
> >> -       free_irq(pcr->irq, (void *)pcr);
> >> -       if (pcr->msi_en)
> >> -               pci_disable_msi(pcr->pci);
> >> +       pci_free_irq(pcr->pci, 0, pcr);
> >>  }
> >>
> >>  #else /* CONFIG_PM */
> >> diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
> >> index e964bbd03..10abfe7f2 100644
> >> --- a/include/linux/rtsx_pci.h
> >> +++ b/include/linux/rtsx_pci.h
> >> @@ -1190,7 +1190,6 @@ struct rtsx_pcr {
> >>         /* pci resources */
> >>         unsigned long                   addr;
> >>         void __iomem                    *remap_addr;
> >> -       int                             irq;
> >>
> >>         /* host reserved buffer */
> >>         void                            *rtsx_resv_buf;
> >> --
> >> 2.20.0
> >>
> >
> > As mentioned in the last email, the rtsx_pci seems to make no
> > difference. I still tried the kernel with this patch applied, the
> > problem still persists. I also tried the vendor driver and it works
> > without any problem. I'd rather like to find out the root cause
> > instead of a workaround. Any better idea?
> >
> Thanks for your efforts! The vendor driver doesn't support MSI-X,
> therefore the issue doesn't occur. I'm running out of ideas, so
> I will write to a contact in Realtek who few times provided helpful
> information already.
>

Hi Heiner,
    After lots of repeating tests, I have to correct my previous finding
to prevent from leading the wrong way. Sometimes the network also
fails with unknown reason. Here's the summarize.
1. The S3 suspend resume can reproduce it 100%. However, echo
different types (core, devices...) in /sys/power/pm_test is not able
to achieve the same thing.
2. The network could randomly fail at any time. Maybe during boot,
sometimes fail after few minutes web surfing.
3. After many times of verifications, it's not about MSI-X. I repeatedly
boot from my own build kernel (w/ MSI-X workaround, w/ pci_alloc_irq,
w/o pci_alloc_irq), even the revision before 6c6aa15fdea5 ("r8169:
improve interrupt handling")
still fails after S3, but I get the wrong impression because I access the
internet w/o problem for quite a long time.
4. When it happens, executing tcpdump on this NIC can always get
network access back. But fails again after stop tcpdump.
5. Vendor driver works w/o any problem. I'm still trying to find the difference.

Sorry that if I caused any confusion. I'll appreciate if there's any kind of
useful information. Thanks.

> > Chris
> >
> Heiner
