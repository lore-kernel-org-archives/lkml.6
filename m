Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752406AbeEOIhS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:37:18 -0400
Received: from david.siemens.de ([192.35.17.14]:60343 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752215AbeEOIhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:37:15 -0400
Subject: Re: [PATCH v3 6/8] PCI: Rework of_pci_get_host_bridge_resources() to
 devm_of_pci_get_host_bridge_resources()
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <cover.1526363896.git.jan.kiszka@siemens.com>
 <4ae78ed8c3d866446f8322c1df4a19c2ca4fef58.1526363896.git.jan.kiszka@siemens.com>
 <c4272d78-780b-ab9e-8ecb-0de4983bb757@mentor.com>
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
Message-ID: <b82f93d6-5e3b-865f-7fe9-a660fcf355b9@siemens.com>
Date: Tue, 15 May 2018 10:36:36 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <c4272d78-780b-ab9e-8ecb-0de4983bb757@mentor.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-15 09:54, Vladimir Zapolskiy wrote:
> Hi Jan,
> 
> On 05/15/2018 08:58 AM, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> of_pci_get_host_bridge_resources() allocates the resource structures it
>> fills dynamically, but none of its callers care to release them so far.
>> Rather than requiring everyone to do this explicitly, convert the
>> existing function to a managed version.
>>
>> CC: Jingoo Han <jingoohan1@gmail.com>
>> CC: Joao Pinto <Joao.Pinto@synopsys.com>
>> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> [snip]
> 
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 4f21514cb4e4..00f42389aa56 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -244,7 +244,8 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
>>  
>>  #if defined(CONFIG_OF_ADDRESS)
>>  /**
>> - * of_pci_get_host_bridge_resources - Parse PCI host bridge resources from DT
>> + * devm_of_pci_get_host_bridge_resources() - Resource-managed parsing of PCI
>> + *                                           host bridge resources from DT
>>   * @dev: host bridge device
>>   * @busno: bus number associated with the bridge root bus
>>   * @bus_max: maximum number of buses for this bridge
>> @@ -253,8 +254,6 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
>>   * address for the start of the I/O range. Can be NULL if the caller doesn't
>>   * expect I/O ranges to be present in the device tree.
>>   *
>> - * It is the caller's job to free the @resources list.
>> - *
>>   * This function will parse the "ranges" property of a PCI host bridge device
>>   * node and setup the resource mapping based on its content. It is expected
>>   * that the property conforms with the Power ePAPR document.
>> @@ -262,12 +261,11 @@ EXPORT_SYMBOL_GPL(of_pci_check_probe_only);
>>   * It returns zero if the range parsing has been successful or a standard error
>>   * value if it failed.
>>   */
>> -int of_pci_get_host_bridge_resources(struct device *dev,
>> +int devm_of_pci_get_host_bridge_resources(struct device *dev,
>>  			unsigned char busno, unsigned char bus_max,
>>  			struct list_head *resources, resource_size_t *io_base)
>>  {
>>  	struct device_node *dev_node = dev->of_node;
>> -	struct resource_entry *window;
>>  	struct resource *res;
>>  	struct resource *bus_range;
>>  	struct of_pci_range range;
>> @@ -278,7 +276,7 @@ int of_pci_get_host_bridge_resources(struct device *dev,
>>  	if (io_base)
>>  		*io_base = (resource_size_t)OF_BAD_ADDR;
>>  
>> -	bus_range = kzalloc(sizeof(*bus_range), GFP_KERNEL);
>> +	bus_range = devm_kzalloc(dev, sizeof(*bus_range), GFP_KERNEL);
>>  	if (!bus_range)
>>  		return -ENOMEM;
>>  
>> @@ -300,7 +298,7 @@ int of_pci_get_host_bridge_resources(struct device *dev,
>>  	/* Check for ranges property */
>>  	err = of_pci_range_parser_init(&parser, dev_node);
>>  	if (err)
>> -		goto parse_failed;
>> +		return err;
> 
> In my opinion allocated by pci_add_resource() and pci_add_resource_offset()
> resource entries are leaked on error paths, and pci_free_resource_list() should
> be called.

Indeed, I overshot with removing also pci_free_resource_list. v4 will
follow.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
