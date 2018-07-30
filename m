Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECACC46461
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDF220873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 06:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gmbf5nup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BDF220873
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbeG3Hq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 03:46:59 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39650 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeG3Hq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 03:46:59 -0400
Received: by mail-oi0-f66.google.com with SMTP id d189-v6so19148755oib.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 23:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c6j8yCR2N6uEggzQr7SQCzZD+jwZGoNGikiZ3VoNnfg=;
        b=gmbf5nupVR0I60lI+LtA5+6KUJsi2kwuSzhNnulEPr6bjXmTRw1k+ip+exzrtcikgG
         /eusNl+VedzhOIa8QhOlBz1XS/nYj8nJKKxsRWSXxi1xQj+rN6ozFDurmF0lBBChfEcp
         ujJBLnSnNygDxau5YwevqUY+NE07PLB5eO2TA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c6j8yCR2N6uEggzQr7SQCzZD+jwZGoNGikiZ3VoNnfg=;
        b=IaKtpwcNLWX/vx8ylzO+VCNuQhhEia1MfKdi4Rfs8ueXnFjCXrcftqXH2UL4apbt3I
         OKVS8d+PlTjymqUM38i/pFk41zTlp774gM8zRzEuA0aQSzaIZ2pl2665n5D5S/0c1B3R
         Qup60x87vkgbmDtXuH9JFg4n6T9uW2y2Bg8EZwMFY8RzMdvBUdI/XE9IwLI9/Mj2HmBU
         9uNcJdo7fSjZBHlpq41kv10Gf0DepTPMC1Pr0MjVGGaCWfnkGYOficTb8Wk5XAWh2NC2
         9acWDVaPTv714PoQhjnY1axI8If0rAv+FniGr44zjscOp421rKHX6dc3xDYvCS8AsVsp
         g+vQ==
X-Gm-Message-State: AOUpUlH/wsNpqvNTaKuSh7Wd8E5CBcGfsc5LB9ahQVh0NwOijuEE89Vv
        6DK1j5jrlDcjCWlXFfP7k7aCoO5sWD+QCNqhMQdVsQ==
X-Google-Smtp-Source: AAOMgpcr/6Snp/LNkbsJ9MYM+wuremVEfj5sqLqSkADh31/BgTw3CYzF4/VRWIhfUd1gVzOk7wVGzbMAAqgvjPju8Bo=
X-Received: by 2002:aca:42:: with SMTP id 63-v6mr15158470oia.154.1532931215716;
 Sun, 29 Jul 2018 23:13:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6043:0:0:0:0:0 with HTTP; Sun, 29 Jul 2018 23:13:34
 -0700 (PDT)
In-Reply-To: <0c1215a2-b8b3-e315-71e1-04501d02ba42@intel.com>
References: <1532794529-30137-1-git-send-email-srinath.mannam@broadcom.com>
 <201807290127.DcHKtABy%fengguang.wu@intel.com> <CABe79T5o431_XkKzh=zEfoPzs6pfMHrrTZGPW7218tekLkk=vw@mail.gmail.com>
 <0c1215a2-b8b3-e315-71e1-04501d02ba42@intel.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Mon, 30 Jul 2018 11:43:34 +0530
Message-ID: <CABe79T59J0sSyFqbrPoD0vK03HXO9_3XcByLK5DXe2RGxN8nCA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: host: iproc: Add ACPI support to IPROC SDHCI
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian Hunter,

Thank you for the confirmation.

I will send patch series now.

Regards,
Srinath.

On Mon, Jul 30, 2018 at 11:40 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 30/07/18 09:02, Srinath Mannam wrote:
>> Hi Adrian Hunter,
>>
>> Auto build error came to this patch, because it is depend on the
>> patch "mmc: sdhci-pltfm: Convert DT properties to generic device properties"
>> you have given to me.
>>
>> Can I send my patch along with your patch in a single patch series?
>
> Yes, that is normally how it is done.
>
>> Please advice.
>>
>> Regards,
>> Srinath.
>>
>>
>> On Sat, Jul 28, 2018 at 11:02 PM, kbuild test robot <lkp@intel.com> wrote:
>>> Hi Srinath,
>>>
>>> Thank you for the patch! Yet something to improve:
>>>
>>> [auto build test ERROR on ulf.hansson-mmc/next]
>>> [also build test ERROR on v4.18-rc6 next-20180727]
>>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>>
>>> url:    https://github.com/0day-ci/linux/commits/Srinath-Mannam/mmc-host-iproc-Add-ACPI-support-to-IPROC-SDHCI/20180729-003026
>>> base:   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
>>> config: ia64-allmodconfig (attached as .config)
>>> compiler: ia64-linux-gcc (GCC) 8.1.0
>>> reproduce:
>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>         chmod +x ~/bin/make.cross
>>>         # save the attached .config to linux build tree
>>>         GCC_VERSION=8.1.0 make.cross ARCH=ia64
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>    drivers/mmc/host/sdhci-iproc.c: In function 'sdhci_iproc_probe':
>>>>> drivers/mmc/host/sdhci-iproc.c:304:2: error: implicit declaration of function 'sdhci_get_property'; did you mean 'sdhci_get_of_property'? [-Werror=implicit-function-declaration]
>>>      sdhci_get_property(pdev);
>>>      ^~~~~~~~~~~~~~~~~~
>>>      sdhci_get_of_property
>>>    cc1: some warnings being treated as errors
>>>
>>> vim +304 drivers/mmc/host/sdhci-iproc.c
>>>
>>>    276
>>>    277  static int sdhci_iproc_probe(struct platform_device *pdev)
>>>    278  {
>>>    279          struct device *dev = &pdev->dev;
>>>    280          const struct sdhci_iproc_data *iproc_data = NULL;
>>>    281          struct sdhci_host *host;
>>>    282          struct sdhci_iproc_host *iproc_host;
>>>    283          struct sdhci_pltfm_host *pltfm_host;
>>>    284          int ret;
>>>    285
>>>    286          if (dev->of_node)
>>>    287                  iproc_data = of_device_get_match_data(dev);
>>>    288          else if (has_acpi_companion(dev))
>>>    289                  iproc_data = acpi_device_get_match_data(dev);
>>>    290
>>>    291          if (!iproc_data)
>>>    292                  return -ENODEV;
>>>    293
>>>    294          host = sdhci_pltfm_init(pdev, iproc_data->pdata, sizeof(*iproc_host));
>>>    295          if (IS_ERR(host))
>>>    296                  return PTR_ERR(host);
>>>    297
>>>    298          pltfm_host = sdhci_priv(host);
>>>    299          iproc_host = sdhci_pltfm_priv(pltfm_host);
>>>    300
>>>    301          iproc_host->data = iproc_data;
>>>    302
>>>    303          mmc_of_parse(host->mmc);
>>>  > 304          sdhci_get_property(pdev);
>>>    305
>>>    306          host->mmc->caps |= iproc_host->data->mmc_caps;
>>>    307
>>>    308          if (dev->of_node) {
>>>    309                  pltfm_host->clk = devm_clk_get(dev, NULL);
>>>    310                  if (IS_ERR(pltfm_host->clk)) {
>>>    311                          ret = PTR_ERR(pltfm_host->clk);
>>>    312                          goto err;
>>>    313                  }
>>>    314                  ret = clk_prepare_enable(pltfm_host->clk);
>>>    315                  if (ret) {
>>>    316                          dev_err(dev, "failed to enable host clk\n");
>>>    317                          goto err;
>>>    318                  }
>>>    319          }
>>>    320
>>>    321          if (iproc_host->data->pdata->quirks & SDHCI_QUIRK_MISSING_CAPS) {
>>>    322                  host->caps = iproc_host->data->caps;
>>>    323                  host->caps1 = iproc_host->data->caps1;
>>>    324          }
>>>    325
>>>    326          ret = sdhci_add_host(host);
>>>    327          if (ret)
>>>    328                  goto err_clk;
>>>    329
>>>    330          return 0;
>>>    331
>>>    332  err_clk:
>>>    333          if (dev->of_node)
>>>    334                  clk_disable_unprepare(pltfm_host->clk);
>>>    335  err:
>>>    336          sdhci_pltfm_free(pdev);
>>>    337          return ret;
>>>    338  }
>>>    339
>>>
>>> ---
>>> 0-DAY kernel test infrastructure                Open Source Technology Center
>>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>>
>
