Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-26780-1520586610-2-8449082271876754333
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520586609; b=aZWIGygg89HMK0tRvwGyPpNrh/y5XPhiKK4NhoR45MobXdc
    U64BZWTpXjfovwnSihS3tMAO20wgScGZrne8B4iJFXtpmeSWtq3Oj1j4IlcCWtIE
    rokWvL883ctyC/dFtsmlD2NV/AtdF26y6sZZirSqeld8MOCBYIPPsxPLhCCBgO2K
    6gR5K/VWIeqCvYHTtd3YLug1k0BC1RvSvDagCrQk8OXBUGTKzAfWQF+2MnPXOEmY
    I6GpeG1234VF8D8Z8nDynnLkRQQxm5WMIR1H4axOlh5g3bg7TfP4QBpNXuSijTjD
    QhnIbNu33P5j+Bs5oREpBcKz0reYC+KC/xIymzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520586609; bh=LZ74YE0yTluPQYMP+L4iKPHcV32C5cht2WsoQ3+V3No=; b=t
    fBytTPwVsPgV9NJDaZaB9c0/e9Z6GVLzZ9BC38gp1njPduckRKhHnutn8cuUKt7Q
    7NKS19oj1AblI2ct33eaKCEgNUYp6MOK45NriA+RHCVsvwEiO3kRHwMfJx69FWcg
    hi2JIN89MWDuDDoKETr5M90vAlTh+JMA7UTsX2+L3HBbIUWSCCcT/+kBmnJBG0uZ
    OiBJe6c46FVnL4LIthjOUxj5MhpcaCxGIQMW1/rkGlpBrv/DlEc3uyoL/IeW3mJA
    uFd6cGmrBPtP2uq5iTcUZyXKqZfJcjdNS2xZ+CgP3wVAPOox3QIBxJGy7R82BX0i
    qDx5j3pG64Npz5BhOAtlQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751147AbeCIJJr (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 04:09:47 -0500
Received: from mga01.intel.com ([192.55.52.88]:13306 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750996AbeCIJJp (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 9 Mar 2018 04:09:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,444,1515484800";
   d="scan'208";a="23791815"
Subject: Re: [PATCH 2/3] usb: xhci: tegra: Add runtime PM support
To: Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1518626085-29102-1-git-send-email-jonathanh@nvidia.com>
 <1518626085-29102-2-git-send-email-jonathanh@nvidia.com>
 <54bd00b7-2835-a253-0399-370e8c8203b8@linux.intel.com>
 <f1a1c300-a558-f31a-bcfa-c3eda697b0fd@nvidia.com>
 <20180309083629.GA13877@ulmo>
From: Mathias Nyman <mathias.nyman@intel.com>
Message-ID: <1fff9fc1-2ad2-dba1-cb1d-d531254984ce@intel.com>
Date: Fri, 9 Mar 2018 11:13:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309083629.GA13877@ulmo>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 09.03.2018 10:36, Thierry Reding wrote:
> On Thu, Mar 08, 2018 at 09:31:07PM +0000, Jon Hunter wrote:
>>
>> On 01/03/18 14:18, Mathias Nyman wrote:
>>> On 14.02.2018 18:34, Jon Hunter wrote:
>>>> Add runtime PM support to the Tegra XHCI driver and move the function
>>>> calls to enable/disable the clocks, regulators and PHY into the runtime
>>>> PM callbacks.
>>>>
>>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>>> ---
>>>>    drivers/usb/host/xhci-tegra.c | 80
>>>> ++++++++++++++++++++++++++++++-------------
>>>>    1 file changed, 56 insertions(+), 24 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/host/xhci-tegra.c
>>>> b/drivers/usb/host/xhci-tegra.c
>>>> index 02b0b24faa58..42aa67858b53 100644
>>>> --- a/drivers/usb/host/xhci-tegra.c
>>>> +++ b/drivers/usb/host/xhci-tegra.c
>>>> @@ -18,6 +18,7 @@
>>>>    #include <linux/phy/tegra/xusb.h>
>>>>    #include <linux/platform_device.h>
>>>>    #include <linux/pm.h>
>>>> +#include <linux/pm_runtime.h>
>>>>    #include <linux/regulator/consumer.h>
>>>>    #include <linux/reset.h>
>>>>    #include <linux/slab.h>
>>>> @@ -1067,22 +1068,12 @@ static int tegra_xusb_probe(struct
>>>> platform_device *pdev)
>>>>         */
>>>>        platform_set_drvdata(pdev, tegra);
>>>>    -    err = tegra_xusb_clk_enable(tegra);
>>>> -    if (err) {
>>>> -        dev_err(&pdev->dev, "failed to enable clocks: %d\n", err);
>>>> -        goto put_usb2;
>>>> -    }
>>>> -
>>>> -    err = regulator_bulk_enable(tegra->soc->num_supplies,
>>>> tegra->supplies);
>>>> -    if (err) {
>>>> -        dev_err(&pdev->dev, "failed to enable regulators: %d\n", err);
>>>> -        goto disable_clk;
>>>> -    }
>>>> +    pm_runtime_enable(&pdev->dev);
>>>>    -    err = tegra_xusb_phy_enable(tegra);
>>>> +    err = pm_runtime_get_sync(&pdev->dev);
>>>>        if (err < 0) {
>>>
>>> Does this mean that if runtime PM is disabled then clocks and regulator
>>> will never be enabled
>>> for Tegra xhci?
>>>
>>> How about keeping the clock and regualtor enabling in probe, and instead
>>> add something like:
>>>
>>> pm_runtime_set_active(&pdev->dev);
>>> pm_runtime_enable(&pdev->dev);
>>> pm_runtime_get_noresume(&pdev->dev);
>>
>> For 64-bit Tegra there is a dependency on CONFIG_PM, but for 32-bit
>> AFAIK there is not and so yes we should handle the case when PM_RUNTIME
>> is disabled.
>>
>> Typically we do something like ...
>>
>>      pm_runtime_enable(&pdev->dev);
>>      if (!pm_runtime_enabled(&pdev->dev))
>> 	ret = tegra_xusb_runtime_resume(&pdev->dev);
>>      else
>>          ret = pm_runtime_get_sync(&pdev->dev);
>>
>> That way we can keep the regulator and clock stuff in the handler. I
>> will update this series.
> 
> Is there any good reason why we don't depend on PM for 32-bit as well?
> I'm not aware of any differences in drivers that are 32-bit specific for
> Tegra, and I'm not even sure the !PM case gets any testing at all. And
> even if, do we really still want to support that?
> 
> I don't see any advantage these days for having it disabled.

I don't know much about Tegra, but I'd still like to turn this question around:

Is there any reason why clks and regulators can't initially be turned on in probe,
and then let runtime PM handle them later if PM is supported?

Shouldn't this work in all cases, and it avoids creating new dependencies?

Thanks
Mathias
