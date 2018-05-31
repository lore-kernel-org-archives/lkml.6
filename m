Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932731AbeEaPkn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 11:40:43 -0400
Received: from esa5.dell-outbound.iphmx.com ([68.232.153.95]:46056 "EHLO
        esa5.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932703AbeEaPkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 11:40:42 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GyAAAqFBBbmMmZ6ERcGgEBAQEBAgEBA?=
 =?us-ascii?q?QEIAQEBAYQYgQ0ymFWBeYEPkzyBeAuEbIIHITUXAQIBAQEBAQECAQECEAEBAQE?=
 =?us-ascii?q?BBg0LBigvgjUiglQBBTo/EAIBCBgeEFcCBAEagxqCAaoCiEOBaIhBghOEHIRzh?=
 =?us-ascii?q?VQCmGkJBY5UjRuRFYFDAYIIcIMUgh8OCY4XjzeBGQEB?=
X-IPAS-Result: =?us-ascii?q?A2GyAAAqFBBbmMmZ6ERcGgEBAQEBAgEBAQEIAQEBAYQYgQ0?=
 =?us-ascii?q?ymFWBeYEPkzyBeAuEbIIHITUXAQIBAQEBAQECAQECEAEBAQEBBg0LBigvgjUig?=
 =?us-ascii?q?lQBBTo/EAIBCBgeEFcCBAEagxqCAaoCiEOBaIhBghOEHIRzhVQCmGkJBY5UjRu?=
 =?us-ascii?q?RFYFDAYIIcIMUgh8OCY4XjzeBGQEB?=
Cc: <Austin.Bolen@dell.com>, <Shyam.Iyer@dell.com>,
        <keith.busch@intel.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-LoopCount0: from 10.166.134.83
X-IronPort-AV: E=Sophos;i="5.49,463,1520917200";
   d="scan'208";a="1092923899"
X-DLP: DLP_GlobalPCIDSS
From: <Alex_Gagniuc@Dellteam.com>
To: <okaya@codeaurora.org>, <mr.nuke.me@gmail.com>, <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: Check for PCIe downtraining conditions
Thread-Topic: [PATCH] PCI: Check for PCIe downtraining conditions
Thread-Index: AQHT+PFV3WgrlSaJlEW4KNPXuIvKGw==
Date: Thu, 31 May 2018 15:29:23 +0000
Message-ID: <4e0611c872054e768daa96b302651db3@ausx13mps321.AMER.DELL.COM>
References: <20180531150535.9684-1-mr.nuke.me@gmail.com>
 <28004506-24f0-6d10-2d1e-074e0483d2f9@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.178.128.191]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4VFemFe020145

On 5/31/2018 10:28 AM, Sinan Kaya wrote:
> On 5/31/2018 11:05 AM, Alexandru Gagniuc wrote:
>> +static void pcie_max_link_cap(struct pci_dev *dev, enum pci_bus_speed *speed,
>> +				enum pcie_link_width *width)
>> +{
>> +	uint32_t lnkcap;
>> +
>> +	pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnkcap);
>> +
>> +	*speed = pcie_link_speed[lnkcap & PCI_EXP_LNKCAP_SLS];
>> +	*width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> PCI_EXP_LNKCAP_MLW_SHIFT;
>> +}
>> +
>> +static void pcie_cur_link_sta(struct pci_dev *dev, enum pci_bus_speed *speed,
>> +				enum pcie_link_width *width)
>> +{
>> +	uint16_t lnksta;
>> +
>> +	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
>> +	*speed = pcie_link_speed[lnksta & PCI_EXP_LNKSTA_CLS];
>> +	*width = (lnksta & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT;
>> +}
>> +
>> +static const char *pcie_bus_speed_name(enum pci_bus_speed speed)
>> +{
>> +	switch (speed) {
>> +	case PCIE_SPEED_2_5GT:
>> +		return "2.5 GT/s";
>> +	case PCIE_SPEED_5_0GT:
>> +		return "5.0 GT/s";
>> +	case PCIE_SPEED_8_0GT:
>> +		return "8.0 GT/s";
>> +	default:
>> +		return "unknown";
>> +	}
>> +}
> 
> I thought Bjorn added some functions to retrieve this now.

Hmm. I couldn't find them.

Alex
