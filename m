Return-Path: <sdias@codeaurora.org>
X-Google-Smtp-Source: AB8JxZp7KoRo3fbncxQHNKJ4oShUVwSnoejsJJk0P0c1ZefaFLGAIfg9C0XpD/CjYoGEJ+n7QwnF
ARC-Seal: i=1; a=rsa-sha256; t=1524930039; cv=none;
        d=google.com; s=arc-20160816;
        b=USyMoraRunbLq0ThjC0wPp2fxYt6o1ElxBw5Y+c58huG0xt23StVS6Lva3S+aR0o1R
         A3G5WdVAXZ9AHM+0hbf6FGeSZIANeso6xaxQUaIvg6F37qDQS5/1K7hO29NyMi+uaeOE
         hBCnbPwVZ+C7kJp2shruF7XIeU1CR3Tq+uJJeCJbet3J2TJ/dh6B6txwgKiOJbM1G9yf
         UiTbgVeuSQ/0uGFOoqB0bDFm5fypxR/nJhtTD9gaum+jLfP0rFJeq7xdgzfr6FCSG48J
         z5zzOnlBQkHNU1C8V9eL/yTWUQUB9ZUZT1Nzrh8/H/Td8+2MI2KWDnX1lkw42TNG4vf6
         xVaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=79U4V/sXad+WjH5lEM4zdBcvDvzdZQbbHRavlIJRG8Q=;
        b=Mzxw0gvL4AemeCiY8M/RHxk9XBT/t8sjXudcmAE3dwLHqlt6H8MlhLcoiIGZr+syqi
         pxinVwkwvchoEB3mWoIfbTjiF1A4aJ/uzdr3CvujEaQSDHMwNx7qfXjNvjDtSFYtfdMN
         N+o7D3+mDSZ0fn/WPeZwSP7OkqQC2Ij+8ygb3Vz83qEvO+7JNsvMn6KuQtgHHT1T/9DW
         rvRUVN9XLBiX3Vt17tobbnkBN+uVmJla4V6h1y0GjPJanS3oiI4UpKDWsmpKrojm1F4D
         yEBXvX/G6pV3OMB5jXR9809vc2Q8XYDw02bAAiCgz9K2BOuj7C3zFuZ/a32GKGqTFfmM
         DlQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Mwblc7R+;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DUBDranB;
       spf=pass (google.com: domain of sdias@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=sdias@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Mwblc7R+;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DUBDranB;
       spf=pass (google.com: domain of sdias@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=sdias@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 51AB9600C9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sdias@codeaurora.org
Subject: Re: [PATCH v1 2/4] mhi_bus: controller: MHI support for QCOM modems
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-msm@vger.kernel.org, Tony Truong <truong@codeaurora.org>
References: <1524795811-21399-1-git-send-email-sdias@codeaurora.org>
 <1524795811-21399-3-git-send-email-sdias@codeaurora.org>
 <CAK8P3a3UhuFYDfNeQTba-E50yNyyjj9-1c03YhDVnYQ1DvNd1g@mail.gmail.com>
From: Sujeev Dias <sdias@codeaurora.org>
Message-ID: <c6415ef5-7317-e0b3-2029-8bdae053c665@codeaurora.org>
Date: Sat, 28 Apr 2018 08:40:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3UhuFYDfNeQTba-E50yNyyjj9-1c03YhDVnYQ1DvNd1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598864307361957466?=
X-GMAIL-MSGID: =?utf-8?q?1599005041653049111?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/27/2018 04:32 AM, Arnd Bergmann wrote:
> On Fri, Apr 27, 2018 at 4:23 AM, Sujeev Dias <sdias@codeaurora.org> wrote:
>> QCOM PCIe based modems uses MHI as the communication protocol.
>> MHI control driver is the bus master for such modems. As the bus
>> master driver, it oversees power management operations
>> such as suspend, resume, powering on and off the device.
>>
>> +- compatible
>> +  Usage: required
>> +  Value type: <string>
>> +  Definition: "qcom,mhi"
>> +
>> +- qcom,pci-dev-id
>> +  Usage: optional
>> +  Value type: <u32>
>> +  Definition: PCIe device id of external modem to bind. If not set, any
>> +       device is compatible with this node.
>> +
>> +- qcom,pci-domain
>> +  Usage: required
>> +  Value type: <u32>
>> +  Definition: PCIe root complex external modem connected to
>> +
>> +- qcom,pci-bus
>> +  Usage: required
>> +  Value type: <u32>
>> +  Definition: PCIe bus external modem connected to
>> +
>> +- qcom,pci-slot
>> +  Usage: required
>> +  Value type: <u32>
>> +  Definition: PCIe slot as assigned by pci framework to external modem
> These don't seem to make any sense: You seem to have access to
> a regular pci_device already, so why do you need to duplicate the
> information about it in DT?
>
I will remove the platform device, original hardware design we had a 
complicated power on
sequence that require platform device to come up first and follow a 
strict power on sequence to power on modem
before pci device can enumerate.  I stored the BDF in DT to correlate 
the platform device with pci device. platform device
is no longer needed so I can remove it.
>> +- qcom,smmu-cfg
>> +  Usage: required
>> +  Value type: <u32>
>> +  Definition: Required SMMU configuration bitmask for PCIe bus.
>> +       BIT mask:
>> +       BIT(0) : Attach address mapping to endpoint device
>> +       BIT(1) : Set attribute S1_BYPASS
>> +       BIT(2) : Set attribute FAST
>> +       BIT(3) : Set attribute ATOMIC
>> +       BIT(4) : Set attribute FORCE_COHERENT
>> +
>> +- qcom,addr-win
>> +  Usage: required if SMMU S1 translation is enabled
>> +  Value type: Array of <u64>
>> +  Definition: Pair of values describing iova start and stop address
> Why do you need these? Can't that be handled by the PCI
> layer?
I will move this to end point DT.  PCIe end point driver does the iommu 
configuration
>> +- qcom,msm-bus,name
>> +  Usage: required
>> +  Value type: <string>
>> +  Definition: string representing the bus scale client name to register
> This probably belongs into a separate binding for the bus
> scale driver, right?
Yes, this is for qcom bus scale driver which I don't think is upstreamed 
yet. Will confirm.
>> +static struct pci_driver mhi_pcie_driver;
> Please try to reorder the symbols to avoid forward declarations.
>
>> +static int mhi_platform_probe(struct platform_device *pdev)
>> +{
>> +       struct mhi_controller *mhi_cntrl;
>> +       struct mhi_dev *mhi_dev;
>> +       struct device_node *of_node = pdev->dev.of_node;
>> +       u64 addr_win[2];
>> +       int ret;
>> +
>> +       if (!of_node)
>> +               return -ENODEV;
>> +
>> +       mhi_cntrl = mhi_alloc_controller(sizeof(*mhi_dev));
>> +       if (!mhi_cntrl)
>> +               return -ENOMEM;
>> +
>> +       mhi_dev = mhi_controller_get_devdata(mhi_cntrl);
>> +
>> +       /* get pci bus topology for this node */
>> +       ret = of_property_read_u32(of_node, "qcom,pci-dev-id",
>> +                                  &mhi_cntrl->dev_id);
>> +       if (ret)
>> +               mhi_cntrl->dev_id = PCI_ANY_ID;
>> +
>> +       ret = of_property_read_u32(of_node, "qcom,pci-domain",
>> +                                  &mhi_cntrl->domain);
>> +       if (ret)
>> +               goto error_probe;
>> +
>> +       ret = of_property_read_u32(of_node, "qcom,pci-bus", &mhi_cntrl->bus);
>> +       if (ret)
>> +               goto error_probe;
>> +
>> +       ret = of_property_read_u32(of_node, "qcom,pci-slot", &mhi_cntrl->slot);
>> +       if (ret)
>> +               goto error_probe;
> Please explain what you are trying to do here, why do you register
> two device drivers? It looks like they both refer to the same
> hardware, so why isn't it sufficient to have the pci_driver?
As I explained earlier, it's now. Original hardware design we had 
chicken egg situation where
some driver has to come up and power on device before pcie enumeration 
can take place.

>
>         Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Thanks again
Sujeev

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
