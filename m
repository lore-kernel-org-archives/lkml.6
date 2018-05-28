Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163355AbeE1Na1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:30:27 -0400
Received: from thoth.sbs.de ([192.35.17.2]:59690 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162641AbeE1KrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:47:04 -0400
Subject: Re: [PATCH v4 4/8] PCI: Replace dev_node parameter of
 of_pci_get_host_bridge_resources with device
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
 <5f2226585c6af9920b266d0503e32042d4c9e440.1526375226.git.jan.kiszka@siemens.com>
 <a74db976-d330-80b9-939e-dd164a20c8c3@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.kiszka@siemens.com; prefer-encrypt=mutual; keydata=
 xsDhBEq0i8QRBAD2wOxlC9m/8t/vqjm1U9yQCT6OJ2Wbv/qys9DYM0CvcOTDMWQwmV1/VsZj
 KR5YgB5NPt+To7X6x5cjz15AGnx5Fb8Wnrq8EF9ZfHMwb7YMx1LdPYPDnXr37wE3XupFmkHB
 Mes4htyX7Dz8LvKDLnli4IsAmWG+kV1JI6LWKXLpSwCg8JRq4SWoB4VCQxbH3GjntgvwNc8D
 /2q5Dj0urJ7s7sdXhrH0hcFkpSFRmU5Yd6MCwcbFHm2paL5gqVjNNUUwDBKAL9eZaQVIHKwC
 44BvNGO2gcQ26R3AuCHUQ+pZHg34tok1JCNZ6IEZccb+33Qq0qbcDMJJiDYp7ppp6ozifvc4
 YaqJECX48IydxfE9+41oV7T5vNAzA/QL/UMJyTnu5jiOXcyn5iFQw535lXkwKsqeXzCowLho
 HICZ2jITJPdTT/+9pGWwMQqST/SS35Tx4EnS3z2BWsNMCLuXCPkxF1elaMJqMfMJxFD8rAgS
 9GK6zP6fJlsA1wq/UvKSL8v4QPOnTNCVOsyqJVasGV0ZPcDfcj+ClNO4zR5KYW4gS2lzemth
 IDxqYW4ua2lzemthQHdlYi5kZT7CYwQTEQIAIwIbIwYLCQgHAwIEFQIIAwQWAgMBAh4BAheA
 BQJOpoNtAhkBAAoJEIrUrG965ecUOPUAoK+Rh12KgCjplHAS0AoiGKwGOuq7AKDEVnBtRAoy
 VRvp3lOlOx+P2Ay56M7BTQRKtIvEEAgA2/PlX6oyi7dToH0CJCHq0eKmZaa7CmGaVnxyeepK
 vIfiM8n8Td76AbG64fjREMwgSpb4F/UytF3z/03tj4e49W/zKjbBRB2/wmFRlZBC9crg22Q+
 bgvMOsxnC6uHXaWN8fL+jVei/5OoHOoFqaMsX8EvploitlI/BPj+VgW26jksf3YZyk1hncls
 Z/IYhXzgRmVJo4RiTW/YLQAkwndwc+fKPa/IYLEDW1Jc4kNLoK0P90b45zju0hpl0C00pVOR
 TOtzFK9G5Ha7qOAWJfAVJORHKAkkvwftf3hkpPdLyvZUWRHXvUexmA61fLvDBAFhRxYGD8t5
 gz88SF5Tzq+0ywADBQf/YSkaYrEslPWiCA2wU6EW0yaqBQAobFsOMvsufJ6o2ntq5Ncq37VI
 3KCT67eHPE9x+zPcENoZWsRrC9S9PCf1LOsi7ybZsR13AJqDFlRzJZ4klh9QwgwFZxUBzOdI
 vttwzG1QkzHx06RKZluFYpPF3DRduSMukdIJ2wmWCU+ohB+mYefe65JGjYQfHVs8mgYVFOPx
 bRea9VJACCMuspoZWpj43UdR1lLLyIUFYz+jqcPW7Hd/GTIw4N67pYl0dwPDmFd4ohJ5g4Zp
 q61toNysBGEuEm5GCcn0VmGtQpSYnR5cVm5b2yPz4bIuFOSuZUo/l7vitdY0iy0/wvKbBC+N
 K8JJBBgRAgAJBQJKtIvEAhsMAAoJEIrUrG965ecULvAAoKGvxs5T3IhyQT8I8sMsyAvCE4wH
 AJ46S16yab+OxNkvOeoOEX0EnHVHaA==
Message-ID: <eb9b477a-33c9-db45-9e62-101e3606e8ff@siemens.com>
Date: Mon, 28 May 2018 12:46:35 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <a74db976-d330-80b9-939e-dd164a20c8c3@mentor.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-28 12:00, Vladimir Zapolskiy wrote:
> Hi Jan, Bjorn,
> 
> On 05/15/2018 12:07 PM, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Another step towards a managed version of
>> of_pci_get_host_bridge_resources(): Feed in the underlying device,
>> rather than just the OF node. This will allow to use managed resource
>> allocation internally later on.
>>
>> CC: Jingoo Han <jingoohan1@gmail.com>
>> CC: Joao Pinto <Joao.Pinto@synopsys.com>
>> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> [snip]
> 
>> diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
>> index a6af62e0256d..61802e55a00c 100644
>> --- a/drivers/pci/host/pcie-altera.c
>> +++ b/drivers/pci/host/pcie-altera.c
>> @@ -488,11 +488,10 @@ static int altera_pcie_parse_request_of_pci_ranges(struct altera_pcie *pcie)
>>  {
>>  	int err, res_valid = 0;
>>  	struct device *dev = &pcie->pdev->dev;
>> -	struct device_node *np = dev->of_node;
>>  	struct resource_entry *win;
>>  
>> -	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pcie->resources,
>> -					       NULL);
>> +	err = of_pci_get_host_bridge_resources(dev, 0, 0xff
>> +						    &pcie->resources, NULL);
>>  	if (err)
>>  		return err;
>>  
> 
> In case if it is an undiscovered issue, a comma was mistakenly removed,
> which will result it compilation error.
> 
> The problem is also found in pci/next , see commit 88e3909aa125.

Yes, that's known. We have a bisection breakage: The issue was fixed
again by patch 6 in that series.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
