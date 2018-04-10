Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753864AbeDJNPO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:15:14 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:43109 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753826AbeDJNPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:15:11 -0400
X-Google-Smtp-Source: AIpwx4/tCV4C12e7rfm9rM+nc5gLAlpygwKntUX+irFkqXn/QowRUs5ydG+OHQZYg+gl7deOsyvs5A==
MIME-Version: 1.0
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
 <20180313085534.11650-6-vivek.gautam@codeaurora.org> <61d30fff-1bf8-d2c1-bbe9-f93de836ae77@huawei.com>
 <7d5af071-ef98-8461-3ce9-e84fc0b3956a@codeaurora.org> <d97872fe-5e8e-cc27-e385-64cea8ea2458@huawei.com>
In-Reply-To: <d97872fe-5e8e-cc27-e385-64cea8ea2458@huawei.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 10 Apr 2018 13:14:57 +0000
X-Gmail-Original-Message-ID: <CAAFQd5Cj3qaqt8ACabZwN4ZKaNbF9N9suGVaOKD8-kNxgfeeVA@mail.gmail.com>
Message-ID: <CAAFQd5Cj3qaqt8ACabZwN4ZKaNbF9N9suGVaOKD8-kNxgfeeVA@mail.gmail.com>
Subject: Re: [PATCH v9 5/5] iommu/arm-smmu: Add support for qcom,smmu-v2 variant
To: xieyisheng1@huawei.com
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        gaojianbo@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yisheng,

Sorry, I think we missed your question here.

On Wed, Mar 28, 2018 at 3:12 PM Yisheng Xie <xieyisheng1@huawei.com> wrote:

> Hi Vivek,

> On 2018/3/28 12:37, Vivek Gautam wrote:
> > Hi Yisheng
> >
> >
> > On 3/28/2018 6:54 AM, Yisheng Xie wrote:
> >> Hi Vivek,
> >>
> >> On 2018/3/13 16:55, Vivek Gautam wrote:
> >>> +- power-domains:  Specifiers for power domains required to be
powered on for
> >>> +                  the SMMU to operate, as per generic power domain
bindings.
> >>> +
> >> In this patchset, power-domains is not used right? And you just do the
clock gating,
> >> but not power gating, right?
> >
> > We are handling the power-domains too. Please see the example in this
binding doc.

> I see, but I do not find the point in code of these patchset, do you mean
PMIC(e.g mmcc)
> will gate the power domain of SMMU(e.g. MDSS_GDSC of mmcc) when PMIC
suspend?


If respective SoC power domains is registered as a standard genpd PM
domain, then the runtime PM subsystem will take care of power domain
control at runtime suspend and resume.

Best regards,
Tomasz
