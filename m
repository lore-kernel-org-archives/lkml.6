Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752755AbeEPMfO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:35:14 -0400
Received: from goliath.siemens.de ([192.35.17.28]:36492 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752417AbeEPMfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:35:09 -0400
Subject: [PATCH] PCI: Clean up resource allocation in
 devm_of_pci_get_host_bridge_resources()
To: Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, linux-pci@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
 <3aeb2ed038cbce8fe744b614dc19d414555a7e8f.1526375226.git.jan.kiszka@siemens.com>
 <CAHp75VeUbjobse6uLeM4h_xXRUw+YUQUN+EOye67AJy77a5euQ@mail.gmail.com>
 <CAHp75VeM7_8+9QJjOypXaiBhpWP4B5KACdUQ-p3frbS3jPh=OQ@mail.gmail.com>
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
Message-ID: <f35b2972-aa40-5397-facb-765cafe7c315@siemens.com>
Date: Wed, 16 May 2018 14:31:44 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <CAHp75VeM7_8+9QJjOypXaiBhpWP4B5KACdUQ-p3frbS3jPh=OQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of first allocating and then freeing memory for struct resource
in case we cannot parse a PCI resource from the device tree, work
against a local struct and kmemdup it when we decide to go with it.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/pci/of.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index b06585a1da75..fc0f906c5c25 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -266,7 +266,7 @@ int devm_of_pci_get_host_bridge_resources(struct device *dev,
 			struct list_head *resources, resource_size_t *io_base)
 {
 	struct device_node *dev_node = dev->of_node;
-	struct resource *res;
+	struct resource *res, tmp_res;
 	struct resource *bus_range;
 	struct of_pci_range range;
 	struct of_pci_range_parser parser;
@@ -320,18 +320,16 @@ int devm_of_pci_get_host_bridge_resources(struct device *dev,
 		if (range.cpu_addr == OF_BAD_ADDR || range.size == 0)
 			continue;
 
-		res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
+		err = of_pci_range_to_resource(&range, dev_node, &tmp_res);
+		if (err)
+			continue;
+
+		res = devm_kmemdup(dev, &tmp_res, sizeof(tmp_res), GFP_KERNEL);
 		if (!res) {
 			err = -ENOMEM;
 			goto failed;
 		}
 
-		err = of_pci_range_to_resource(&range, dev_node, res);
-		if (err) {
-			devm_kfree(dev, res);
-			continue;
-		}
-
 		if (resource_type(res) == IORESOURCE_IO) {
 			if (!io_base) {
 				dev_err(dev,
-- 
2.13.6
