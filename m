Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755866AbeEaRG0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:06:26 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33961 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755838AbeEaRGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:06:22 -0400
X-Google-Smtp-Source: ADUXVKLgFx56XuBA0TKCAfsV4dE91nyhLVwfArEdBatcimHoWdryjJWFV8DRuC558COupUfv220pxA==
Date: Thu, 31 May 2018 18:06:02 +0100
From: Craig Tatlor <ctatlor97@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
        kramasub@codeaurora.org, sdharia@quicinc.com, girishm@quicinc.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        bgoswami@codeaurora.org, devicetree@vger.kernel.org,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 0/2] slimbus: Add QCOM SLIMBus NGD driver
Message-ID: <20180531170222.GA9629@arch>
References: <20180525111547.18556-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525111547.18556-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on msm8974 with wcd9320 codec.

Tested-by: Craig Tatlor <ctatlor97@gmail.com>

On Fri, May 25, 2018 at 12:15:45PM +0100, Srinivas Kandagatla wrote:
> This patchset adds support to basic version of Qualcomm NGD SLIMBus
> controller driver found SoCs from B family.
> 
> This controller is light-weight SLIMBus controller driver responsible for
> communicating with slave HW directly over the bus using messaging
> interface, and communicating with master component residing on ADSP
> for bandwidth and data-channel management.
> 
> Tested this patchset on DB820c with WCD9335 codec.
> I have pushed my working branch to [1] incase someone want to try.
> 
> This patch has dependency on https://lkml.org/lkml/2018/5/17/251
> 
> Changes sinc v1 (https://lwn.net/Articles/754679):
> - Fixed DT binding making NGD slave of the slim controller.
> - Fixed few typos spotted by Vinod.
> - Removed unnessary dmaengine_slave_config suggested by Vinod
> - Removed few unnessary initializations.
> - fixed commit log to remove reference to B family suggested by Trilok
> 
> Thanks,
> srini
> 
> [1] https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=slimbus-ngd
> 
> Srinivas Kandagatla (2):
>   slimbus: ngd: dt-bindings: Add slim ngd dt bindings
>   slimbus: ngd: Add qcom SLIMBus NGD driver
> 
>  .../bindings/slimbus/slim-ngd-qcom-ctrl.txt        |   84 ++
>  drivers/slimbus/Kconfig                            |   11 +
>  drivers/slimbus/Makefile                           |    3 +
>  drivers/slimbus/qcom-ngd-ctrl.c                    | 1342 ++++++++++++++++++++
>  drivers/slimbus/slimbus.h                          |    8 +
>  5 files changed, 1448 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
>  create mode 100644 drivers/slimbus/qcom-ngd-ctrl.c
> 
> -- 
> 2.16.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
