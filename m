Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932120AbeBSUlk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 15:41:40 -0500
Received: from mail-by2nam03on0072.outbound.protection.outlook.com ([104.47.42.72]:61120
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753940AbeBSUlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 15:41:35 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrew.cooks@opengear.com;
Subject: Re: [PATCH v4 1/3] i2c: piix4: Fix port selection for AMD Family 16h
 Model 30h
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
        "open list:I2C/SMBUS CONTROLLER DRIVERS FOR PC"
        <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1517285239.git.andrew.cooks@opengear.com>
 <be68c29f603153cf047cd893c6b9d6423073632d.1517285239.git.andrew.cooks@opengear.com>
From: Andrew Cooks <andrew.cooks@opengear.com>
Message-ID: <55cac7ea-8f84-15b7-42dc-8424073789e1@opengear.com>
Date: Tue, 20 Feb 2018 06:41:18 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <be68c29f603153cf047cd893c6b9d6423073632d.1517285239.git.andrew.cooks@opengear.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [59.167.150.161]
X-ClientProxiedBy: ME1PR01CA0115.ausprd01.prod.outlook.com
 (2603:10c6:200:19::24) To MWHPR15MB1213.namprd15.prod.outlook.com
 (2603:10b6:320:23::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e94b0ec-19b7-4991-6ef8-08d577d92a01
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR15MB1213;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1213;3:5EP8MFZeDC8hgz8+QYBeSKjQypIxJtbMZotySKiulw/fiWHIoZC71kI4Y/QTA4UVXwV4Gb/qnegQcLhx/Xr32Uz817T5ym5JLkSBY24RzW1BOBmmv6CXCT9gbdvZawCH65AASNsorSLjrilTENdkRA6Qpr27K2jKoLb2CtvzI5tiFZxOtEZ0iMkxJ93JVODC3MPNAEWOorydM06avwg3e6YkbS3BLRLSTREjZIrPq0pna8xKalLH3e5ixxyNt3OT;25:u5ufQnEy2x+Kq6H2ffhWzk/vLJaooozmlVyzhC8DBkTACCNmmVjPwByC9Tp+CPv3HVEjsBRcnDXASG8PxaOe25m66Y0HjbqjTAWiApUabhh4GCvVvMqjuVT6yi76eBkbtQ4Ufc77lQ8TMbaqHNXYMZBpnGNN8xCqv5cZ1Ej3TV+prfsLYFpZxQ2SyfxUMv1wZgjB62AYqAierhJEx8s8M5zRqP8gzVw1Y9sCRaQbpNvyJpbNfyXaMZHTpqOL+c2LUcQ0dW2jXRsobLCDJAgE7FmqfpBolZ+6cmADlnKQcYHPqApim23VPhoiTmn26FBrZmfwUjGVGDv8kLh8niUHJg==;31:5Hdi4oQjOvIUp/EvDQe0OteTvzr7fHI8sFVyvsZqcinvB10loy2shc1bTyd1ukceGG6rAi9CPp+4tj2txx3cqUmmtMFPgwGpKsDbJJM7DRJCu3yYHzR2XogSc/TbJS7zO6LlziT6k7+bzp8Vv5G+RU3u+M0tXQtDbybei0Fg6y0WJUO0k+PuSwwohomXTJtKO1hw2lsjBGICFk3zQyUd8mwxrJC9z3AWWVorrfchXZ4=
X-MS-TrafficTypeDiagnostic: MWHPR15MB1213:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1213;20:7Mls19JyGOHBhb/DBX5cfVInP/ztVzE61LxLWUCrdkBKYyB4BXSstaGHUfxm0TvcxwnJYx5RFcwD88sLLWURrGGZD/+w7YJEvNBW0Pq33ecN9w9M/0EllMKA4cJoObBoCbJLsicoNyVGFcsTQ0aZuzdwZaYrx4mgw+syKsulpqs=;4:erE1K77sPkA54tq3NRJKyoimXImrK3SfjarnsYdDWvHu4n0PR3B2X1gUJRZcb94f/ZKuWs4toSKDqDAi1Uni6HeWEWSqkCl0M4KEq+mWxqJhgeJvst6ovdxYS7AG/pbkBVFUl9gDbmBhWkFm2Cx8RzeOiXDFM0+3Y1NIHI6T//dQavsAPjNx28WU3NNh5Dv5xGlRkPED4FvPWVa6FrxPJtp2KI1ms7L++O/EbEGZZOFa5QROUUsfhmDp8V8q30jpvn8vDSJgd4UqlUjS8aZMtw==
X-Microsoft-Antispam-PRVS: <MWHPR15MB12135159172264BCAC078ACEEEC80@MWHPR15MB1213.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001056)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(944501161)(10201501046)(3002001)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR15MB1213;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1213;
X-Forefront-PRVS: 0588B2BD96
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(346002)(366004)(39380400002)(39830400003)(396003)(189003)(199004)(105586002)(110136005)(7736002)(2906002)(50466002)(36756003)(31686004)(58126008)(6486002)(97736004)(81166006)(16576012)(8676002)(81156014)(316002)(575784001)(305945005)(65826007)(6116002)(3846002)(31696002)(83506002)(86362001)(6246003)(64126003)(230700001)(8936002)(68736007)(16526019)(26005)(77096007)(2950100002)(6666003)(25786009)(117156002)(53936002)(5660300001)(478600001)(59450400001)(53546011)(386003)(66066001)(65956001)(65806001)(23676004)(52146003)(47776003)(2486003)(106356001)(76176011)(52116002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR15MB1213;H:[192.168.254.67];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjE1TUIxMjEzOzIzOnQwSkdyZldGVlBKemQ1NmpEdWxTdkVGcWRZ?=
 =?utf-8?B?S2lzSFBpRnEzZUhFUGlMekNpWG5ZU25ibklFMnM5UE1HT1Z5Wlg2VmFTSjM5?=
 =?utf-8?B?dHB1T3FvVHB3THA3eDlQOU15Q0dhbks0b2tiaEFYVzFRRDRZaDZNT1doMXEr?=
 =?utf-8?B?UnhJUXBRc2puODlhZEtDUTdRM3lvYU83SmUrYmVhM1RjaVNYU2ZFb3RBdzJQ?=
 =?utf-8?B?dHBkanNHblY3ZGlua2Nsek05eXkyYkFrUmI1SUtON2xkZkZyVFg1aUdMS1lU?=
 =?utf-8?B?SHFjRWN5MTJsbmJpVDduQ1JXZlBQL2tJbFdVbVZYZXRoMkhTelZzaXRrWmUv?=
 =?utf-8?B?L3FNZnJQNXU2djNQUUNsTjd3Slp4TTV2bnNPV1NMREJsd2lXc1FQUkZ2MXQ1?=
 =?utf-8?B?Zmxsb01iSmt4aSsvVVpvRWVBOUpuTUc5amxTTk9KWW9rdDB4QW04Qk55b1V4?=
 =?utf-8?B?UEVmYWd3b2dVQTZMN2R6V2dRZy93UVlpdzhHenVjaXJOczdmbmxML24vVUt2?=
 =?utf-8?B?Znk2KzN2cFRJZndWTWplRGI0ZXNISUNxNDhtUUsrNzVHc3lZNUUrNStoVzg4?=
 =?utf-8?B?T1FiMC94ZDlHM21vR2kvbG4rWkx5MWJJUnZPTE5oREJKMzNSUlFxY25rWmFP?=
 =?utf-8?B?bkVMblN4SnlOeStPckhpUFI2M3M4ZXJJV1BQZ09HVDJtd1JYOFNaZHZBZkd1?=
 =?utf-8?B?WWxMT0NLV1k4LzRTcGZFbDU3TUhkTlJoek1tcC94MUxrbGphYytyc2JHVDVK?=
 =?utf-8?B?Qm1OSWdNd0gwUlZNRkFsai9aRGlmNXNsUGJOaE5nZVB4MUZLY2wxd0tjSllt?=
 =?utf-8?B?aDVXQ1RTMFZjWks4WXJpZ2F6a3pSSllNRmNuMVdVT0tObFRudXVVVHdjcjVQ?=
 =?utf-8?B?Umo4VHMzOFVWZ29vSVpNSXlzRSsxVGlzdjM1TytaU2tPeldaS29LQzY2a043?=
 =?utf-8?B?cFkwbmliUUNSUEhGTjB5VHVmMXFtMGVFOUIrL0xEVXdjZEZETFBwcHo1SE5p?=
 =?utf-8?B?R1U2MDZCNG5walhPTkJtdmdGbDgzRXlQRmlRdndDbjBiLzhIMWtPMEFGSXVy?=
 =?utf-8?B?MDZXUVlNUVdrZUNZYlN2czVCekhPRFlSSGFqc0pUeGFPNElRemlvQWQrZG9s?=
 =?utf-8?B?WEZ4eDdpbDhBWU4xN1Z3TkZsQ2JuM2VlTTNwL2ppbXdNNXMvVURiaitCQ3Zt?=
 =?utf-8?B?enJyUE1IS1JFbDlMQ2k3ejVTY0MxbFBUWWVYV0xZcHdaTm1HdUN3c0Zzd2Nh?=
 =?utf-8?B?N3FEK1p0VUl4SXZlWjFMU3ZNWlJhNFI2OW9UcWNiMVJPVVpqaG1BUnNONUk4?=
 =?utf-8?B?T1hjbXdGUitkYlhXbmppUDJLZmppSmVhaVZDbExHaVROZ2NPS2k3RnlaTk5x?=
 =?utf-8?B?djVNQ0JLYkt1UnFYV1B1R3FSeWpSRnRWY1MvRHlDdkNhclc2bnFNN20wd0hO?=
 =?utf-8?B?ZDVVbEZMdkR5MHRYb2g4RmZLd3ZyTTFxM0J1QWh2cXZ0UkJhS1pMRnJBdElU?=
 =?utf-8?B?dkM1SENYK0pyQUpKL1pyakZkUWh5M1pLc3lLWVRMT3RlQ2lCczRKcTZ4VXov?=
 =?utf-8?B?c1NOL0ZDTE9WR1QwNGgva29UMDdZcldPTEtDTUNndXFDMDNZR0F0SGFzdkVV?=
 =?utf-8?B?QUZkR1orUzl5V0lSaHBKamdEMkJZbE1QRFV2NGNXLyt6ek1MNDR1aWZpZm9H?=
 =?utf-8?B?azU1TkVMdStPT1RrYTk0TFg3b3J1QWxkL3lab0xCd2NWb29NOWQ2bUN4TGhC?=
 =?utf-8?B?elRBVGFxVzhYeWJ6cmttekhiRUI0MDcxdlpVRFE0eTZRSDYwVkl1Yk5MNzZq?=
 =?utf-8?B?djZvQzJ3OUVtNkpld3MyeUx1ZURlRFlLSitGNzNJb1JJVi9ONDNLb2JhcnBY?=
 =?utf-8?Q?Q/wQwmd8nkuM4E6EqDST4LjtI8Effq3H?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1213;6:7OOCsWlIqvUJJMCFluSJjPsQ4V0Paay2urRTua3L8m5NPj58TAqKZs5vihUyMjE2ErnygwZnJzqEd2egtB3zsQu9QT01+vxfGWpdZ2rEH/koZHPzQm8rJ2mk7UajLOSgaStcucLQjJQUdyGH2NbMg7HyEtNNIRAFThQP3Rq1F7VMaIRaOVeli6ZbJUBcO+kZPwkc3sCoHygi0/mcLcoOpIKpmwnO6Hmn0ovqeTsSnoFdI8Pki37qFahU4AdZ+lFH6bIusDgVcywPN0SBcpWaF0wnSf/JE2Z3MS8xxHAlwW5km4EKt2upq0dowNJ0M7ndueIaYsi/IvGAX6GtbT2hMKluzvJ5oyV0pDmyr5NOs1k=;5:U4o3PruO8g9kLuD+sM6MBBXqd/7o872T+nGtCMkcR4cqQkIRmaZyy+KhLS22LiNCLDDkjUk7RGRtzY3UwFsgIOKarGJsFZYcdveT8U7MABi0oKQ8De3s9FhHfy84wqR+g+KdC0MkFTXGyBCiMQGrfvsQ3fqfgzqEQwBCeqrtexg=;24:ZjlCIZAwikkg53Bto16d5whe9vLBQ4rRVrT0opkYQfKy+n586YkiXhZyO10muq+7H9F53X/MmJwRUPH5dhNmrCt/KZipmbp+ELTr7TwSCJ4=;7:NODj8sOl8F1eJbbDBzSwUSk4guSJ57d+vtbZ5m9kuvU9la6JASE1KziWJw3n+9wfXGAIiGmUqiK4jQiC48efABLneuZ0FAWqg1blAbp/BvFkGmnzWP4UOd9AUR6nEiaVu6/ch8oEtAiqCs+ljiMLg3n/n84ONptSceqVkYeUMBsXY4aeicw+vQXU7N5v53q2vOpfB5sNPn8ObKJ4P+R1Lrstbiib0AhEzrS+mg7qZN5YfhhvxG3TbzGgMYEpwm2Y
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2018 20:41:32.1951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e94b0ec-19b7-4991-6ef8-08d577d92a01
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a6251c26-d21f-4164-a225-1f4eaebf5f9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1213
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Any comments?

On 31/01/18 07:40, Andrew Cooks wrote:
> Family 16h Model 30h SMBus controller has the same port selection
> register as described and fixed in commit 0fe16195f891
> ("i2c: piix4: Fix SMBus port selection for AMD Family 17h chips")
> 
> commit 6befa3fde65fe ("i2c: piix4: Support alternative port selection
> register") also fixed the port selection for Hudson2. Unfortunately the
> AMD naming and PCI Device IDs aren't particularly helpful here.
> 
> The SMBus port selection register is common to the following Families
> and models, as documented in AMD's publicly available BIOS and Kernel
> Developer Guides:
> 
>  50742 - Family 15h Model 60h-6Fh (PCI_DEVICE_ID_AMD_KERNCZ_SMBUS)
>  55072 - Family 15h Model 70h-7Fh (PCI_DEVICE_ID_AMD_KERNCZ_SMBUS)
>  52740 - Family 16h Model 30h-3Fh (PCI_DEVICE_ID_AMD_HUDSON2_SMBUS)
> 
> The Hudson2 PCI Device ID (PCI_DEVICE_ID_AMD_HUDSON2_SMBUS) is shared
> between Bolton FCH and Family 16h Model 30h, but the location of the
> SmBus0Sel port selection bits are different:
> 
>  51192 - Bolton Register Reference Guide
> 
> We distinguish between Bolton and Family 16h Model 30h using the PCI
> Revision ID:
> 
>   Bolton is device 0x780b, revision 0x15
>   Family 16h Model 30h is device 0x780b, revision 0x1F
>   Family 15h Model 60h and 70h are both device 0x790b, revision 0x4A.
> 
> The following additional public AMD BKDG documents were checked and do
> not share the same port selection register:
> 
>  42301 - Family 15h Model 00h-0Fh doesn't mention any
>  42300 - Family 15h Model 10h-1Fh doesn't mention any
>  49125 - Family 15h Model 30h-3Fh doesn't mention any
> 
>  48751 - Family 16h Model 00h-0Fh uses the previously supported
>          index register SB800_PIIX4_PORT_IDX_ALT at 0x2e
> 
> Signed-off-by: Andrew Cooks <andrew.cooks@opengear.com>
> ---
>  drivers/i2c/busses/i2c-piix4.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index 174579d..5c90a44 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -99,7 +99,7 @@
>  #define SB800_PIIX4_PORT_IDX_MASK	0x06
>  #define SB800_PIIX4_PORT_IDX_SHIFT	1
>  
> -/* On kerncz, SmBus0Sel is at bit 20:19 of PMx00 DecodeEn */
> +/* On kerncz and Hudson2, SmBus0Sel is at bit 20:19 of PMx00 DecodeEn */
>  #define SB800_PIIX4_PORT_IDX_KERNCZ		0x02
>  #define SB800_PIIX4_PORT_IDX_MASK_KERNCZ	0x18
>  #define SB800_PIIX4_PORT_IDX_SHIFT_KERNCZ	3
> @@ -359,18 +359,16 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
>  
>  	/* Find which register is used for port selection */
>  	if (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD) {
> -		switch (PIIX4_dev->device) {
> -		case PCI_DEVICE_ID_AMD_KERNCZ_SMBUS:
> +		if ((PIIX4_dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) ||
> +		    (PIIX4_dev->device == PCI_DEVICE_ID_AMD_HUDSON2_SMBUS &&
> +			   PIIX4_dev->revision >= 0x1F)) {
>  			piix4_port_sel_sb800 = SB800_PIIX4_PORT_IDX_KERNCZ;
>  			piix4_port_mask_sb800 = SB800_PIIX4_PORT_IDX_MASK_KERNCZ;
>  			piix4_port_shift_sb800 = SB800_PIIX4_PORT_IDX_SHIFT_KERNCZ;
> -			break;
> -		case PCI_DEVICE_ID_AMD_HUDSON2_SMBUS:
> -		default:
> +		} else {
>  			piix4_port_sel_sb800 = SB800_PIIX4_PORT_IDX_ALT;
>  			piix4_port_mask_sb800 = SB800_PIIX4_PORT_IDX_MASK;
>  			piix4_port_shift_sb800 = SB800_PIIX4_PORT_IDX_SHIFT;
> -			break;
>  		}
>  	} else {
>  		mutex_lock(&piix4_mutex_sb800);
> 
