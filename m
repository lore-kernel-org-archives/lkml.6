Return-Path: <Jisheng.Zhang@synaptics.com>
X-Google-Smtp-Source: AIpwx49rYFRwuYpW407+QnctBQU43/ZA9Xv6E/fvU+QAeg2xS+eLq0ynkGvFL7/yXnmD7P9R3GqJ
ARC-Seal: i=1; a=rsa-sha256; t=1524124926; cv=none;
        d=google.com; s=arc-20160816;
        b=zwqWea4rOcGjOv68OQK3y1bycEmmEfLbOJkePyHmQWxz88B3qnvZqGOoa+kTC/RjEY
         WV8FVzSw8sVeo/2vlMUdvX+LIGxyDPM+qXAVFAUgKm7B0LScJt0VgcjOAkk9Oqs7C1SN
         Qj0tuKHxGaESq4qK2Q4Vovr3MCVn1i5/6mp1etFH+29BfnIMwc3DlxQpYjBzOgJu/MZT
         OA+4F796hEhTaPeAczBdpyFuokjrasGyN+Tt12k5ZVy7O5iDDgxexzX3QIKWbeCOBWJz
         j0tE54p/AIIm4UnUCr6H3H8zw/fG9AKI9WnHlwpF0ivw6yL2GgtGrEiw1piftpy9jMqC
         UBIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:dkim-signature:arc-authentication-results;
        bh=PNo+CgJmYsiMetxsYwMg1H0UUnbq1n7PsQLS/Skxuow=;
        b=XkTtl2UV8OLv2rQsYm6mt0S9TMRECdDzmkbZnw10/OIEyAEkiBrq6z6Xdr8yjtlTM6
         EUggcJByEzEY3pAkP/R7BJFx5mmVYKvaNdwmC2E9pNuZaRQKKz5FHlcA3WKPQxgue11Q
         ZTdf6cpSMGowdU7Mbio7XQra4BPzSR1j+twue9iuAd1rtu+9M9rAvvuO4XwEuG4w1hyB
         meJzNRn48A2ITQJeTv9zfWiyoL/ZWL4J6IXIxHVZE/LJuWDvM6MiaJ1DbYcP7x01TSrk
         45Dh/UPE5LQ2cYgG1HipYGcSL4pPeTBOH4om81hGIa64nPSIAzrEU2dIGffyC+/qXjz9
         FhMg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@Synaptics.onmicrosoft.com header.s=selector1-synaptics-com header.b=K+omrn1p;
       spf=neutral (google.com: 104.47.42.51 is neither permitted nor denied by best guess record for domain of jisheng.zhang@synaptics.com) smtp.mailfrom=Jisheng.Zhang@synaptics.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@Synaptics.onmicrosoft.com header.s=selector1-synaptics-com header.b=K+omrn1p;
       spf=neutral (google.com: 104.47.42.51 is neither permitted nor denied by best guess record for domain of jisheng.zhang@synaptics.com) smtp.mailfrom=Jisheng.Zhang@synaptics.com
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=synaptics.com;
Date: Thu, 19 Apr 2018 16:01:44 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Peter Chen <Peter.Chen@nxp.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH resend] usb: chipidea: Don't select EXTCON
Message-ID: <20180419160144.0412a510@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: KAWPR01CA0067.jpnprd01.prod.outlook.com
 (2603:1096:402:b::27) To BN6PR03MB2626.namprd03.prod.outlook.com
 (2603:10b6:404:59::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB2626;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;3:vQEq0f3Ey2T7ZFNdWBIWuvyg9k55EeMu733xotv/bXmriaQZC9TXnVPB3IlSPbIPlsAEHXOpRia5km1EtQIsxYyBh6UYNQsvN9yQLaUd4N9gNf5m0XxSBommTdA3SkI02OIkQpnUWveuoDbfReYJTUNaRP5A9+ennHxjrOGLr15E4JWbVPBy+loMdsxWW55eCegnqtAncDL6GeyBA6bs96vCy/rCRrFSBEZDDdP/eQ0T0AIxHymPHJ1lklG+zRNv;25:mlYowRF6pVPjmPb2QgvE5we/LuwZoP6/3la+F93gMXxbqVL/1BN9DT/D1AN+1A7fXtVq30uzm8c8uGf0T3QTPvxR7VmM1bHCsXQewMKzIC2f5srEmclukHdVsFEGqXWpb8jGvhZi9dsPhx8bvWUmeeW4bON/82tp/hH91fzy91wFpECHyRmEOJbbjJaM+0OBKl/QdGNvhEHwEIWeCs4RcsqFw/+yjkG9T5Igjljq64P1qmALKXOcOOrPFU9wlV4hVgHdgWZoVVYV0PZAXXI2jKga3Cm8bubYwH/Sas40VIfgP36MN0H0SzI2o5K8WHHToat2K7qXXgBrzkDdpJDEIw==;31:4i9kkU/0/76cEyTFed9fOqSDM66NhWGYYnMwqy+WeuEdTcM4M9uwXMKa3ubyNCHErs743QtsFg/cyt88SNd4FDoGm6035oWBRM43DFSaWAl7WjesJIu38mm4mp+BvyF8TFhEMHj8AXnAE9Vtb4YVx6OyKWPZF3sTNk5v+MkHDJGSiq4HLu9qUAqkl1Hn8cDd/DsnU6DR6raXmvR0b91zCYUfLqXbTi3AD077ytqV6jI=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2626:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;20:MeJzAzs3YT+9eoKJki2kAUFRHsmy2oA5ag7iD8BIFI+Q8biksB5ptmiDotcQbL3jnkLE+0MW9TCaDt+Cwni3uzzm+nvgskXtaHmJNHkogd33xHpBt1p4VHL6lPuVrx9FtfvDhSLFFFdSoD8DGJlhfyXPwPcgqJcSo4iewjhvfLy4pv03EhKSLuhGyoqUGuDawHadiC/TivobTiEBWSwBn3bZEopdcx9PgrJ3vytrCvREmTdv8idiSW0AGjefBauKMGDHDeKoXJCqqBslaqTAFhIhW45cAf/Ntl1QMdZ5N/V3YpQzTt/n96o931PviIPanz4a8zl4+vI3aX6688OA6e8GZw3aW+wHAe7QeAnnMHam88BYr2+GXPkrZUySfsPdgdZ9gnimVPHvROnvNFqB6ywsKE6N1tTYATqo7TwZR+miwEzOVQHgpYIGpto+FjcQ31/UWHu/MCNK7Vet3A5W1KoKJAwWAj2wK5zcMnGEBnVMQq2S5Ks1iBAMAFi7X16p;4:5XQcN3CokuLou6fbpV9nz9AntB7YK6VU7vJfeFFI3VXBEvDGvfiUPbBxCi7eCK3/kiiejdmQElx6Y91izsHRRQWv4v9PjhreimqZ18B+zI54iN7vmXgN7x3OD3S62UBSaA425Td5/+q+49RKB2SmdNwtx4q3xe19BoStE7D6nnhinTSavr0WmbukTFNcrtPe5MTYdFN7l/ajE3kqXTlL1RRFXw5zJhg/JFoscSWRak9c7mAiEkk4kn4JZ5Vz/ehTgwEg9SHpjL5xmMR1KDvQxg==
X-Microsoft-Antispam-PRVS: <BN6PR03MB262609F24C056419683E93A4EDB50@BN6PR03MB2626.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR03MB2626;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2626;
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(366004)(396003)(39860400002)(346002)(25786009)(4326008)(86362001)(8936002)(6506007)(52116002)(5660300001)(26005)(7696005)(81166006)(50226002)(8656006)(386003)(59450400001)(316002)(575784001)(33896004)(50466002)(110136005)(53936002)(55016002)(16526019)(478600001)(186003)(6116002)(305945005)(230700001)(8676002)(66066001)(9686003)(1076002)(476003)(2906002)(72206003)(7736002)(3846002)(23726003)(956004)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2626;H:xhacker.debian;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2626;23:9FzIw3n6K4fk2HDUmdBw+Xe07itED0ti7zmUovbwu?=
 =?us-ascii?Q?DUE/BcOAvxB9Yxy1FOwJ0OiFfxeuqvZ4gtJzWsIUSwr/6yJ8a9bPLNZXTLnH?=
 =?us-ascii?Q?9iEbnl/UnzXYx/Ye9jmAcAznadXhqRwnUt6NKZ47jO/yZejn/Yq+k0yfLZa/?=
 =?us-ascii?Q?k8aDC6SHtUWDThSD8EciPBi8woYYH63fPvpmaumBv3gLJzLX1Mp55hPDOCzu?=
 =?us-ascii?Q?5geV2bT2HHiQEP4gA/WIMd+ewnRqbbq9BtN2m8nSFnYNZtawA0Zir5tL6U1D?=
 =?us-ascii?Q?iyzNUOVOLpxaZJ5YVUro4Cu6sExVj07g2uK0Q0KANStKR09aMU3eHrgTbSq6?=
 =?us-ascii?Q?onKViMktd0LvztseY3i5ogXN3H+KcFmpghWnRM6ZH0daFL6N4cwIHzeqS9Qe?=
 =?us-ascii?Q?XJLPV7fO631YOdIPvnHZIwJs0aK+wgeQPxH8cmCcqPdpca1EfUxVWou4DENr?=
 =?us-ascii?Q?Y2/F4bYaDaxfVgDtKucNN1j+AIOE5yro54So6vVWild7BI46XsMPf/OQJq61?=
 =?us-ascii?Q?uDjwkzUrPc8EHMCO5heVcfspogDxSEKAoIITi9SOUYQhrih+KIlBl36vczhE?=
 =?us-ascii?Q?wJEg9EYdFSUZjt/Ppto574CbLDPz3M0CEW9OV0j60XUEL0CVVkdjJMLsnyN9?=
 =?us-ascii?Q?y2TKd9Mdp3Z0AKGk/pzoZyxv55L+AKtsHTG0K61a85qAs/1KzmXV7VYdWp4K?=
 =?us-ascii?Q?6KN4drDViPfWyecRgR9r/LZcvhhjnT801L139niFG7VCCJ6fDwu4ioHYQQrV?=
 =?us-ascii?Q?7cPNt75hNSDff7ig8ntSXHIpDuSMwkvPcUM0+pyt7wa1v3R41b5RZHTngDme?=
 =?us-ascii?Q?2GODpHXvXTqVUrBvoS5K1O8Bpt/G5jDKjaPeWSxaHK/KzXxNtr9ENvAVXdL5?=
 =?us-ascii?Q?hn88Y2FHobda4rRtnOlluoA0pUY0wDBTt72GzdBvuPdnI9I08U3sjoqTUbTz?=
 =?us-ascii?Q?Ie2B1H8SxP6N0nxI7q4HvArumjb31UQVhKDqSjSbEE8rBcGbeo+TvPpd+DBh?=
 =?us-ascii?Q?+1/w+NDzTBnaZ0GALmObG59KjJro6bXrMgXMwBDEtNgfx/NXjoUJhwES6NiX?=
 =?us-ascii?Q?gGqq1M=3D?=
X-Microsoft-Antispam-Message-Info: r/WxOADE/SCgVADqgo0fgY4KRPHFjJfOJR2hpVr7Hf3TFa9LMti5BNqHlclC12jscX3uhau6HjkwiKOVG19UfO2HNeGsMOfXBTIM6qrp9ROK0lSlMzOsvnCd9cbSySRQQ8+FIAZFEK42+6NJKGLRLO4jFUJgmfgPmqI4d2bXBkzyYMVH/S5QhalcaGwcjjfi
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;6:oEzCMRaSkyAo8LNqVKpvUEgRGKWXNpf0J1TIVuqQkpxShXZCPLiqMYkVYTBsSQ910K5KG7GbQwgQBxqC7FG5ds2fnZ1k5ht9I1V624ZThKhXfWYQqWEoLDzOayExDpSpJ8BBvAtPYe0ipORsj4oOItlgGvT8dzFjTR7csbdxSzVEqWnwtMbH+NnDg47hbrICILKu7I/uclZ5FGGqptkTeiYSDn3Bu4uDtyAF/q8jEDPxxDT6rSyb7hVt75+Pej1YgXvwbTHrvJn6YDD9lY87ny4AsaJQ1XvErS9+CGG0QvWolJdwG+tDMqLtyqHvtgS+2ZjSj0DPXq5s3g9gJMbTgN2gFoTYxbT615z/lv8T9ry79kSaR6K6IhDa/YjGtkejldNNxQ2B5+jy6irLEoTHMt38RDA933szBFHYAbjvP95pPwLasssB59tCnx6mFine7jIvISDMnaO/GGshPMT89g==;5:yKqfeW73PSy//iwifuWoJraYYHbMscmhqawNglgScnqWoto2aGc1v93bFfct9eEIaWRueX85re8MZvAqVZKIJB0A+2BZ8P9glJnjeIyUjTKbzrra3F9KfZ1bT8YGApJB0CIRBV3AdWkJYDle3HRgux22/hrK4ho6KnjqKsdwAvc=;24:dYRK0xKo05yuXFH4t/PjpUWLe4yI9DFvEECqTtincN0fclu/e0dNxgT+8uYLBb8lCrJVSURejDhq+B5GDRVKVOgn1cF85XhqkZnxZ+spHaI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;7:2aUqeZznmgLVYBqbr6/xtvfLJ2eOYt8bHviW8u9QRwu6kkTcawGGChUR/Zover5FCvWUE8nh2DnvDrPSGgOjPfOA9JE9BOGHLcyySHDwBE1NsRziOqMyyj5uRIxKUDdG/Ryff/ELKDMpW8mrnfzl3zx9HLpOyf1do4N3YBRlaE4inTgIQqKQj+PbbGNMxrqb8Wd/x7BMHP1jtgZsUJhVFd8kTXLSC09EGCr7kC0CIEnSgbB9Tqtwb59WbGN+IMb5
X-MS-Office365-Filtering-Correlation-Id: d1718d56-873d-4175-8665-08d5a5cbd5d4
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 08:02:01.1049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1718d56-873d-4175-8665-08d5a5cbd5d4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2626
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598160818710659983?=
X-GMAIL-MSGID: =?utf-8?q?1598160818710659983?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Not all chipidea users need EXTCON, so it's better to avoid
unconditionally select EXTCON, this could save us 2KB kernel Image size.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/usb/chipidea/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig
index 785f0ed037f7..97509172d536 100644
--- a/drivers/usb/chipidea/Kconfig
+++ b/drivers/usb/chipidea/Kconfig
@@ -1,7 +1,6 @@
 config USB_CHIPIDEA
 	tristate "ChipIdea Highspeed Dual Role Controller"
 	depends on ((USB_EHCI_HCD && USB_GADGET) || (USB_EHCI_HCD && !USB_GADGET) || (!USB_EHCI_HCD && USB_GADGET)) && HAS_DMA
-	select EXTCON
 	select RESET_CONTROLLER
 	help
 	  Say Y here if your system has a dual role high speed USB
-- 
2.17.0
