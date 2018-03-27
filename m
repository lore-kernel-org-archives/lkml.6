Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbeC0Vmf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 17:42:35 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:36512 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbeC0Vmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 17:42:32 -0400
X-Google-Smtp-Source: AIpwx4/ZweIQArytS2TzQvAiq+jVN9m1jeKXUDLmdRjHamaCWgR16sflAiZNM8gNEqkDnaM/w64wbTyfbQdS4t5/gH4=
MIME-Version: 1.0
In-Reply-To: <1521785487-29866-5-git-send-email-mgautam@codeaurora.org>
References: <1521785487-29866-1-git-send-email-mgautam@codeaurora.org> <1521785487-29866-5-git-send-email-mgautam@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 27 Mar 2018 14:42:31 -0700
X-Google-Sender-Auth: KH19lrEJ0bIoN0fGuHGUr5uIgeg
Message-ID: <CAD=FV=WoA+jGnrDBJ_wucFRfLC_NqdQTZtZnG96WxNBWaOP+wg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] phy: qcom-qmp: Add QMP V3 USB3 UNI PHY support for sdm845
To: Manu Gautam <mgautam@codeaurora.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Varadarajan Narayanan <varada@codeaurora.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Evan Green <evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 22, 2018 at 11:11 PM, Manu Gautam <mgautam@codeaurora.org> wrote:
> @@ -1414,6 +1556,12 @@ int qcom_qmp_phy_create(struct device *dev, struct device_node *np, int id)
>         }, {
>                 .compatible = "qcom,qmp-v3-usb3-phy",
>                 .data = &qmp_v3_usb3phy_cfg,
> +       }, {
> +               .compatible = "qcom,sdm845-qmp-usb3-phy",
> +               .data = &qmp_v3_usb3phy_cfg,
> +       }, {
> +               .compatible = "qcom,sdm845-qmp-usb3-uni-phy",
> +               .data = &qmp_v3_usb3_uniphy_cfg,

As per my comments on the bindings patch, having two compatible
strings that both map to "qmp_v3_usb3phy_cfg" smells a little wrong.


* If the agreement in the bindings patch is that we somehow need to
keep "qcom,qmp-v3-usb3-phy" around then the sdm845 device tree file
should list:

  compatible = "qcom,sdm845-qmp-usb3-phy", "qcom,qmp-v3-usb3-phy";

...and then you can get rid of the "qcom,sdm845-qmp-usb3-phy" in this
table (it will use the secondary compatible string to pick the right
entry).


* If the agreement is to get rid of "qcom,qmp-v3-usb3-phy" then it
should go away from the table.


-Doug
