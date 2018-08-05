Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C8CC46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 11:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1383B21782
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 11:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyndC4oj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1383B21782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbeHENXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 09:23:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44257 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbeHENXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 09:23:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so9576195wrt.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 04:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KgPmHbWJpelEAwzMtWCdVZJEnLz5nE8BPOxlpN7Ji40=;
        b=QyndC4ojqwnZGTpQItT95BwI9wvYwAqXa5oposb91ifDVMRj1t/3IdRCKC2/lht2Zv
         CKAPFxu3fvLVibLpag/2b2yfLRgIK/4BETcHNQvV5Pl55wUkI4REcxSjmM0eh+i+joIm
         6BnU0J2VDiZ807PM2HjQl6Qmd+QQVqO6ol4ppq3tV4Ek4g4u6oOgVH9XlyqK3vNA4db/
         CxA6E3OHr/wz0mO2UIa0x0Qe5Zxg1L0CCarSY872NPysT4D43sx6z+U120vGzqN3OeQR
         W9tHNioDx0Ck3uDc+Wm+xai0G2yMhXv3vEqYFTnzM3FlBVUpmMkFDdscwiQpzR25d8g3
         yeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KgPmHbWJpelEAwzMtWCdVZJEnLz5nE8BPOxlpN7Ji40=;
        b=rkrkkfAeycOm2RosP1DaT5BbHlpZxTfhubfqprdh/Ekkha+2gVQ6h9OPGn5dLoaCC1
         gXH3Vio4cxaG6k6qUfUcl4nzcQrobW9Z8gzdOgS7ZygsqXiunfe+foE4IMSNwoOzwgsn
         FkGB6mr5TyRmkUWdAZk3gNWMnti/9xV3q4M2IH36OxNBzLZMZj72Fhh0dzYpPvUt2h8P
         V3kTD/bpJJhZemYDd08W/j+81e1aR5JYuM2St3+yYmaryVTJaLjzqWTjYHrkfqKyDI9d
         0JY5G7LBVi1KyhxIU9A97nF/bXJrs4DeKZRVGvixla6EdRodZKQ1qIuq5sTDfisIC6yh
         ptgg==
X-Gm-Message-State: AOUpUlEvDeGU6srw4ZANT+m9C6PdAF6YMifnolhEjRUEU3KhUGqv2O9P
        tnAIQ17yt7L5nZM5zHY6fFT6qd1Y
X-Google-Smtp-Source: AAOMgpfXBQ0IUtqBlgfB/WhQiwDky5Hk0D3Q4WlU1d27QmBRFAZyM5ZPaPR0y3NUIZ3iv8PnEcsudQ==
X-Received: by 2002:adf:e687:: with SMTP id r7-v6mr7439613wrm.35.1533467943661;
        Sun, 05 Aug 2018 04:19:03 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:d600:5ce1:7729:7f46:df77? (p200300EA8BD4D6005CE177297F46DF77.dip0.t-ipconnect.de. [2003:ea:8bd4:d600:5ce1:7729:7f46:df77])
        by smtp.googlemail.com with ESMTPSA id e133-v6sm7849879wma.33.2018.08.05.04.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 04:19:03 -0700 (PDT)
Subject: Re: [PATCH 2/3] mei: Migrate to pci_alloc_irq_vectors API
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5e0250ff-2470-1128-d8eb-b36e3ca04417@gmail.com>
 <c6426b7f-8fee-77ad-56be-00a0d5d04fa6@gmail.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9D97F6B4@hasmsx108.ger.corp.intel.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <d6a3e94c-2b05-f9d4-2522-37153e45c1d8@gmail.com>
Date:   Sun, 5 Aug 2018 13:18:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D97F6B4@hasmsx108.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.08.2018 13:02, Winkler, Tomas wrote:
>>
>> Update the driver to the pci_alloc_irq_vectors API, this allows to get rid of
>> legacy calls like pci_enable_msi(). Another benefit is that no driver change
>> would be needed in case the hardware starts supporting MSI-X.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> Sorry, we are losing the ONE_SHOT flag here,  In spite that pci_enable_msi is marked as deprecated,  
ONE_SHOT flag isn't needed here. See commit f7368a550275 ("PCI: Use IRQF_ONESHOT if
pci_request_irq() called with no handler") and also following comment in __setup_irq():

* Drivers are often written to work w/o knowledge about the
* underlying irq chip implementation, so a request for a
* threaded irq without a primary hard irq context handler
* requires the ONESHOT flag to be set. Some irq chips like
* MSI based interrupts are per se one shot safe. Check the
* chip flags, so we can avoid the unmask dance at the end of
* the threaded handler for those.

> I don't see overall action on LKML to actually  deprecate it.
> For this change I would need to extensice testing on future and legacy devices, frankly  I prefer not to dig into it right now.

Sure, up to you.

> Thanks
> Tomas
> 
Rgds, Heiner

>> ---
>>  drivers/misc/mei/pci-me.c  | 25 +++++++++++--------------
>> drivers/misc/mei/pci-txe.c | 30 ++++++++++++++----------------
>>  2 files changed, 25 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c index
>> 55ba1c41..a60376f0 100644
>> --- a/drivers/misc/mei/pci-me.c
>> +++ b/drivers/misc/mei/pci-me.c
>> @@ -149,7 +149,6 @@ static int mei_me_probe(struct pci_dev *pdev, const
>> struct pci_device_id *ent)
>>  	const struct mei_cfg *cfg;
>>  	struct mei_device *dev;
>>  	struct mei_me_hw *hw;
>> -	unsigned int irqflags;
>>  	int err;
>>
>>  	cfg = mei_me_get_cfg(ent->driver_data); @@ -196,18 +195,16 @@
>> static int mei_me_probe(struct pci_dev *pdev, const struct pci_device_id
>> *ent)
>>  	hw = to_me_hw(dev);
>>  	hw->mem_addr = pcim_iomap_table(pdev)[0];
>>
>> -	pci_enable_msi(pdev);
>> -
>> -	 /* request and enable interrupt */
>> -	irqflags = pci_dev_msi_enabled(pdev) ? IRQF_ONESHOT :
>> IRQF_SHARED;
>> +	err = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
>> +	if (err < 0)
>> +		goto end;
>>
>> -	err = request_threaded_irq(pdev->irq,
>> -			mei_me_irq_quick_handler,
>> -			mei_me_irq_thread_handler,
>> -			irqflags, KBUILD_MODNAME, dev);
>> +	/* request and enable interrupt */
>> +	err = pci_request_irq(pdev, 0, mei_me_irq_quick_handler,
>> +			      mei_me_irq_thread_handler, dev,
>> KBUILD_MODNAME);
>>  	if (err) {
>> -		dev_err(&pdev->dev, "request_threaded_irq failure. irq =
>> %d\n",
>> -		       pdev->irq);
>> +		pci_err(pdev, "pci_request_irq failure. irq = %d\n",
>> +			pci_irq_vector(pdev, 0));
>>  		goto end;
>>  	}
>>
>> @@ -258,7 +255,7 @@ static int mei_me_probe(struct pci_dev *pdev, const
>> struct pci_device_id *ent)
>>  release_irq:
>>  	mei_cancel_work(dev);
>>  	mei_disable_interrupts(dev);
>> -	free_irq(pdev->irq, dev);
>> +	pci_free_irq(pdev, 0, dev);
>>  end:
>>  	dev_err(&pdev->dev, "initialization failed.\n");
>>  	return err;
>> @@ -287,7 +284,7 @@ static void mei_me_shutdown(struct pci_dev *pdev)
>>  	mei_me_unset_pm_domain(dev);
>>
>>  	mei_disable_interrupts(dev);
>> -	free_irq(pdev->irq, dev);
>> +	pci_free_irq(pdev, 0, dev);
>>  }
>>
>>  /**
>> @@ -316,7 +313,7 @@ static void mei_me_remove(struct pci_dev *pdev)
>>
>>  	mei_disable_interrupts(dev);
>>
>> -	free_irq(pdev->irq, dev);
>> +	pci_free_irq(pdev, 0, dev);
>>
>>  	mei_deregister(dev);
>>  }
>> diff --git a/drivers/misc/mei/pci-txe.c b/drivers/misc/mei/pci-txe.c index
>> b8a49581..3ea2b8f6 100644
>> --- a/drivers/misc/mei/pci-txe.c
>> +++ b/drivers/misc/mei/pci-txe.c
>> @@ -64,6 +64,7 @@ static int mei_txe_probe(struct pci_dev *pdev, const
>> struct pci_device_id *ent)  {
>>  	struct mei_device *dev;
>>  	struct mei_txe_hw *hw;
>> +	irq_handler_t qh = NULL;
>>  	const int mask = BIT(SEC_BAR) | BIT(BRIDGE_BAR);
>>  	int err;
>>
>> @@ -100,25 +101,22 @@ static int mei_txe_probe(struct pci_dev *pdev,
>> const struct pci_device_id *ent)
>>  	hw = to_txe_hw(dev);
>>  	hw->mem_addr = pcim_iomap_table(pdev);
>>
>> -	pci_enable_msi(pdev);
>> +	err = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
>> +	if (err < 0)
>> +		goto end;
>>
>>  	/* clear spurious interrupts */
>>  	mei_clear_interrupts(dev);
>>
>> +	if (!pci_dev_msi_enabled(pdev))
>> +		qh = mei_txe_irq_quick_handler;
>> +
>>  	/* request and enable interrupt  */
>> -	if (pci_dev_msi_enabled(pdev))
>> -		err = request_threaded_irq(pdev->irq,
>> -			NULL,
>> -			mei_txe_irq_thread_handler,
>> -			IRQF_ONESHOT, KBUILD_MODNAME, dev);
>> -	else
>> -		err = request_threaded_irq(pdev->irq,
>> -			mei_txe_irq_quick_handler,
>> -			mei_txe_irq_thread_handler,
>> -			IRQF_SHARED, KBUILD_MODNAME, dev);
>> +	err = pci_request_irq(pdev, 0, qh, mei_txe_irq_thread_handler,
>> +			      dev, KBUILD_MODNAME);
>>  	if (err) {
>> -		dev_err(&pdev->dev, "mei: request_threaded_irq failure. irq
>> = %d\n",
>> -			pdev->irq);
>> +		pci_err(pdev, "mei: pci_request_irq failure. irq = %d\n",
>> +			pci_irq_vector(pdev, 0));
>>  		goto end;
>>  	}
>>
>> @@ -162,7 +160,7 @@ static int mei_txe_probe(struct pci_dev *pdev, const
>> struct pci_device_id *ent)
>>  release_irq:
>>  	mei_cancel_work(dev);
>>  	mei_disable_interrupts(dev);
>> -	free_irq(pdev->irq, dev);
>> +	pci_free_irq(pdev, 0, dev);
>>  end:
>>  	dev_err(&pdev->dev, "initialization failed.\n");
>>  	return err;
>> @@ -191,7 +189,7 @@ static void mei_txe_shutdown(struct pci_dev *pdev)
>>  	mei_txe_unset_pm_domain(dev);
>>
>>  	mei_disable_interrupts(dev);
>> -	free_irq(pdev->irq, dev);
>> +	pci_free_irq(pdev, 0, dev);
>>  }
>>
>>  /**
>> @@ -219,7 +217,7 @@ static void mei_txe_remove(struct pci_dev *pdev)
>>  	mei_txe_unset_pm_domain(dev);
>>
>>  	mei_disable_interrupts(dev);
>> -	free_irq(pdev->irq, dev);
>> +	pci_free_irq(pdev, 0, dev);
>>
>>  	mei_deregister(dev);
>>  }
>> --
>> 2.18.0
>>
> 

