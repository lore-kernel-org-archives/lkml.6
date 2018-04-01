Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753938AbeDAUjI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:39:08 -0400
Received: from mail-eopbgr00065.outbound.protection.outlook.com ([40.107.0.65]:16410
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753901AbeDAUjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:39:05 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=talgi@mellanox.com;
Subject: Re: [PATCH v5 03/14] PCI: Add pcie_bandwidth_capable() to compute max
 supported link bandwidth
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Tariq Toukan <tariqt@mellanox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        everest-linux-l2@cavium.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152244390359.135666.14890735614456271032.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Tal Gilboa <talgi@mellanox.com>
Message-ID: <31e66048-e8b8-47ba-baf5-023560b4c124@mellanox.com>
Date: Sun, 1 Apr 2018 23:38:53 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <152244390359.135666.14890735614456271032.stgit@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [79.177.226.85]
X-ClientProxiedBy: VI1P18901CA0012.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::22) To HE1PR0501MB2602.eurprd05.prod.outlook.com
 (2603:10a6:3:6e::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e284e048-1939-43fb-fbcc-08d598109ae0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0501MB2602;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0501MB2602;3:J0GISjxtY2ZwQoTBJ+sRXsRGj+9fF0y+18txxyx0cC/Osi3oW37wPLqsErPqbOcicdhTsUV4IelDFAwnW8S5QwELmEplTuCjLwLFG68dGZ729dRLxaML7M8UCq6KguK8jSjdtPalE2xRvqTIh23uPDbulAik8yIdepET7dBWNbhKcuOOdWZnShNUL6D4vu++iXCLF1ul7gn+Yfqq2Pp8ddbiUObDgWm44AJvC7wXzOQkSlW4Pi0eVk/MGPjTVk4b;25:I5LJrbZB8rnrUP4m3Wo0h4qPmfQ+QZQLNnv7bqSkPervnK7jwKgM3Dya4Dmqo343ADQ/u7ZHEc4uLxOQciuCZZQELLab4iM/CZm7uAmqr0GgR8mVVdS7fTN4pgdNaqWEm4umKJuCn33OVEj4Sdi5VCyqo+P5o08tBkubytx7m5+xQ51/RH03JbkNE/b5KjJq4jtkXGv7ezt7L74dBAw2TjlXeee95On3Q76mQW6+7C/2ksTA5irr8sht69m4QEewLvZTaXIMHe59QEAsKkdxuYV1DeSjzocKR6RqkxOZdOiCJ2MIurL223b+u7Rw4X8lh3F/osOVEgsSwCe5vnFJww==;31:IbOaqQqfMQ0kKoPiOZe9lT57zx3FQvhrJsCuAvWDmZtmBk7kB/kDUV9kfJIP40U5u4Uq64LEfZc1SdqVdtbn+Jz2fBDZj6/tXORCyAJ1IP2069tgMR8IZEECu9VhX2rR7AcKk0W++PdkMIoMXF5clMbUIfchAnjL7GnEwpJUiXudhIdXS4kJiCkEQSm/H/7uCQXUOUAaTXGR+w7JUpjR1yZbxYDCDUcZpJpozWuDv64=
X-MS-TrafficTypeDiagnostic: HE1PR0501MB2602:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0501MB2602;20:QHueFkE3dVgk1mfckFCL8JgaiikbL8NzqEf4zr4bQ8OnDX6C63TLan/GXJ3dk6Hrv7Hf2EwvcTJGN0hDip4oM+k2o9BXZuMdMiuSs+3wgNxlpg+4sY91J+/YD7Yy0wt10/m9TEi8Lobq5oTU0VJPZGGApfS/bWt42lIRy5wk33iZ6gI5uldkXqHYX4FZWjAWfm/n0UsMLfiWlSUMY48KW6rlaMOGYlpDxWMeuvXYoxX9r0E1o/Nfr68xwm+Ii0jkQLRft0V0Zc+htsfXvl9sMgjZz+oC/+jy8qCi0AXgBh7Byv3ProU9nj4aZL9dMeMetIjbvtRPs0n1C9moa9IeBpZ5uvwhhkjk6rRkM7I/YWLfyg+OqNRad3qheXrk55PDKRetC7i3FT2JUXuYWuzdvfQ1O57XoqzNLfPxVcORvrpoqZ2dfA/Od1gaM+E1vrJUgBe2DvPDh67Zj+Lju87+H343Iq/r1POVojTI9AIztvETZgbOyiQN1qs7O47PIBCe;4:bn7TLgMLB+dsOy+1gEQiLv3m47tjsMKPNGGjRA4OiIvOVOOVQwWwNTXYT9hVt/M9ocVxzqogSUeJDAw0pjXB7INb5vN061QY/9lA0Z8B/Sx4z0BDCXXN1t1fuQh2iQCfCip23jew7CvuXK0YuCQGN1D3E7Aei/RVSz9kQtm5dB3rBkVd6y3xZaovDzBRrBdISqvJ/ihMOmTJlqTjj1q4tNV30GTNPzHZw6KsD9KsMi3XcByGkAxSpML29uaR1FGDD0MwQB6yfKRLT3dEwcRNk6moNh0/s5pGsU7/64wCFoR7XXWOjByEWzFEZuFgX9ivnQZFBmnkh2+0fEJmoO9s1MFMofiGvoRd699rMhijldo=
X-Microsoft-Antispam-PRVS: <HE1PR0501MB26026423EEA2376242066AC3D2A70@HE1PR0501MB2602.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR0501MB2602;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0501MB2602;
X-Forefront-PRVS: 06290ECA9D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(39380400002)(346002)(396003)(376002)(366004)(199004)(189003)(229853002)(6246003)(8676002)(81156014)(8936002)(16576012)(81166006)(58126008)(53936002)(31686004)(6486002)(67846002)(76176011)(2486003)(97736004)(52116002)(2906002)(316002)(23676004)(52146003)(66066001)(65956001)(65806001)(50466002)(956004)(11346002)(26005)(2616005)(53546011)(486005)(65826007)(16526019)(186003)(36756003)(47776003)(386003)(77096007)(476003)(486005)(305945005)(117156002)(7416002)(68736007)(478600001)(7736002)(5660300001)(3260700006)(25786009)(230700001)(105586002)(6666003)(54906003)(64126003)(59450400001)(86362001)(106356001)(6916009)(6116002)(4326008)(3846002)(31696002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0501MB2602;H:[192.168.14.130];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA1MDFNQjI2MDI7MjM6Z1pNOWF0ZGV4cVFsb1p5QlFRcTFpbTF1?=
 =?utf-8?B?aWpnaXBRSFJnV0IzMVVibnBJUU1uc1FKY3h0QUVrWXpheW5LYVV3RXBIU1RB?=
 =?utf-8?B?YXB1SjIyUndtVDhnak5Hc2tYOCttdno1WERXU2p3aHE5Skx3NitNTkRrR080?=
 =?utf-8?B?OGpWYVVwdHltSFVWaFlSakwxWTNqT3ZFYXBTeE9DTEdUQ1BqUlNhUndtMmlt?=
 =?utf-8?B?ejZYa0tpM0QzT3o4M2R1U2JyWllnVVlDVzl4Tnl5WVBjYmxtVmp3R2tyTVF2?=
 =?utf-8?B?cElRUGpod21wazdxMmIwVFJpT1o3Ukd3Y3ZSOFV6ZmpKWG05c3FLd1QybWdG?=
 =?utf-8?B?WU1tVGFPZnNQOVpPQWg3bWs2b1VJV3FqcGhSMkpPZDk2ZkxpZm9pVTRzTGNR?=
 =?utf-8?B?YXdkTGlDcUNYVFVJdTdLaG5HU3pWNlJkTVY1ZmVvbW83SnJ6RTFBSUpHaDgv?=
 =?utf-8?B?ZnNnOW9ybjZaYTYyN01TMmFZNEczTTdtREpOeThMcDBEVVUwMk9RbnBzUSs0?=
 =?utf-8?B?cTM2SDZ0aFRBMU0xN01KTUVYS2YxS09Ud21rY0U5b1N5bWQrdEplMnBXWXZp?=
 =?utf-8?B?NE1TTDlDcms5OTlpZWNhWHlFa2Jpci9Nc0trTkp0V1V3SEo0YjN4NzZMRys1?=
 =?utf-8?B?SGMwMDQ2TkVPckZXTzFNbCtJMC9ZTWpoUWU0K0U2dm1mTEVmemRrN0V4RVBy?=
 =?utf-8?B?bkhqTUZmSU5SdXV4Q3dCY21kRGRtTWZ0M1dtUTRpOW5Tdlg1OUF6c1NjbGh3?=
 =?utf-8?B?S1ZDaDhKcTZtR0dQMjB4R1VQdEdJT2w3OGRaRVVNeWNmcmlDUE5UUWRYMzJm?=
 =?utf-8?B?Wm5QYWxYK3BQVE5ZRmhYVDVxRW9NWWNoejd3L1ZzeGhQSzNqSE5WN253Z05y?=
 =?utf-8?B?Z21oOXZTam8xU0xKMlVjcDdXQ2ExdWpiUXZyMUFhNDlBcHRVVWpuelNmODdr?=
 =?utf-8?B?clZqMjU5SHJiTXBVVE1HRkh4a3luVTlqMWYyK0hzQ1JrN09Zak9BZzhGbE9l?=
 =?utf-8?B?WWl6SXNsaUpHd2x6RHhReFJwWW9VWSszZW9YSnRldnhHZzBrL01zMUQwbXV5?=
 =?utf-8?B?aWE5VGpKcSthQitpQXY4eHpSZHE2OVpWTlc4bFRIcVhXWlZGT1M5dGN5YjdL?=
 =?utf-8?B?THlrRWRRV3BzdXdZN2hHTXhlOHF2OFJjd3R1T2NuRWlUelUra3VwNWhFUjhv?=
 =?utf-8?B?WnZGR0MyVUtUY2tKcmt2ZGdhWkV6aWpWSHF0V1FlQU85U203WGpPYWkrOGVp?=
 =?utf-8?B?S2pkdXhLcDA5VFovUStMNExLM0FCVERLRGdyNmkvM2tZNG4rU0hrVkY1Q2dM?=
 =?utf-8?B?Qzh0TGNqaEF5SzB2dWtZYkxtZy9XMHdvcFlTV2M2cnBDL1FkRFdhQWFMR3Uv?=
 =?utf-8?B?YUNZYmZBTkE4NlBDcjdWSlRrZXZldUpjRld0eTBnTlFvWVhYSUorNFFmYW1l?=
 =?utf-8?B?bk4vYmFHTXorRUptTU1uTHFXOUpsTk1VYVlCWEsvcUNPTFFOdUMvWUZrYmlQ?=
 =?utf-8?B?SGE5TkhYNnFKeWFvSE5aQVhCVFJuUnZORDBicVBjYkNvS3V0bTg5Q0RjOG5X?=
 =?utf-8?B?YzJTTHIvWmhxalRJWjQ1STEvd3dmMHFkQ1hYSWJFdE5hbENySTNNNlNFN1VZ?=
 =?utf-8?B?cjdBOFFoRVFBTDBqM3RYdXJtZGc1Y2FqZHFzUGZrc3pQWHVaeGh2bGcvR3Az?=
 =?utf-8?B?Qi9EWmtJR05FSHJOd294Qm5nTkZPbll2QSsrUXNSdUh1RnBvODFZVSthRWR4?=
 =?utf-8?B?NTZqSmFLTXA1T01kRHdxTHRkZlNzT2p5VnJERS9KNGlFeTQ3VS9GRTRzNzJD?=
 =?utf-8?B?VnZIRHR4VVN1VzJsc2hYQ2g0TU9FaTBoMWt4TXlycmFJbnJVMmtWeSttSFY0?=
 =?utf-8?B?eFRKT1g1TUNhcGd3ZTdvYkdndVNKY2lINEwwN1hxSWRzRGcxcUVMalh4UllZ?=
 =?utf-8?B?MEdFdVNQclVzMXFqNUhZWmxqNlhZcWR4cm9HQmxNMExaQWZTK3l6bExFcWps?=
 =?utf-8?B?WFlXYWRGeU9XT2xIV1hwNVVtU3hpaDFBdjBLZERqbEJhWDBrMEUwbUNGN2Qw?=
 =?utf-8?B?NmlpZFg4cjJ1Y3RrZzRRbmNGOXl4a2kyVWpLTzZOYkZlU3gxWWN3eUdQaGVI?=
 =?utf-8?Q?NTPYAACub/Qqc3hVYYc9va/e4=3D?=
X-Microsoft-Antispam-Message-Info: InRibKwc/4ScvmWuPgD/n//NSKklsww/PtuNIKZDM+Fqn16kmjc80sT7rOKFzEJnyDOPU15Ti/MummoZtkUBwkDnCFXb6mubbZ1Vf9nOCImmExg2vbG2Ppx9eB2it6jJ5ZNSieKNUHRwo9EsKeHd3w9NwHj7LoWldi15jv2034tL+pu/EgwUY7WkuLcqahaS
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0501MB2602;6:iefKBcxqTn4By7ScTI1M0HAQv02iCFGgqSCqhnmqayRYL52GhPip3awqgpMCyvDbq9OwfnLych2BIev3r1gSxJxzOXZQciVablyE9rVNLKr9QQ+/cOsjQ7UGdoIC9AtDlTFYwO+3jmwCno8YiTFRrFadhZizSQ/atibrxRxaqaLm6uDp8X5Ua9Pcat+Ii8VoHMeByE/SPbOc8Qwfej5fr5gg0DULOSxyBBMIramoj4fm6fKfJhwKhsLIhHJClw+QYCDMfwMa8wS7TK4DadRF111ySOnYGakLbz9ht5xKKPg2KcDdqxqW6It0Wi/KJmGSWkz5WQcj8mSzSqj7WO9kJD7AI4vvMkW7KXmz/sBZLu4kPwo6n0cidnWzuNq+ku5ugMCilq/e2HGDUkY8C90RR+Nt/tiPxlub/HDyTQW/xaxBp22JWhAFNCUki14sMuHHyTq7J/ZsmZA5zvSubgdMHg==;5:RQB52S9Qmfpye8v/90adfJW55Sk3toULwBcE0S3tcJ6thudbPxoa35DCbdrfHiIAyl+b9oMc21HHSY/iWkdhkkUAGUd/AVZJ/muBLq98/nYGnA6hEPCnoUg3w5sMA7kRKDS54LiiI9IOe6EwusVaWgvoaLJjYz17anWm8Exe320=;24:16jz74sdJbsRtiEN6vvG0FSFzMmBJzzpvQGhZHaHr9wKkP4aC/SxXNQEspkqSGWp4P7M8LeFcQ+0ZKX9zhEyArdfgAE/OmWB/ecoWjC3gW8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0501MB2602;7:v1GuxNCwT/Mhl3Mw9szwKuop/tt21zQRTpYIWvK2rHbZWdqTNrhQMW60IV/wRdD58u8fJo6Kis5r7MRAfAFxV5Or4Y6dD0XRUVdx0db84u1eF/3UTwUULiQnrwn5Q6UaDilFN0z+48bkQlJk4XV+qi1KMPh/vIg6gbXGhc2Etum4wPOGFkzZSMYKQOYrus8B5CUhU1KOP0kd5UEhhVLq9RtlABSXBQ2zenqrfco9PwpCKrIPRSBb3u/YezICBtig
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2018 20:39:01.1096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e284e048-1939-43fb-fbcc-08d598109ae0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0501MB2602
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/2018 12:05 AM, Bjorn Helgaas wrote:
> From: Tal Gilboa <talgi@mellanox.com>
> 
> Add pcie_bandwidth_capable() to compute the max link bandwidth supported by
> a device, based on the max link speed and width, adjusted by the encoding
> overhead.
> 
> The maximum bandwidth of the link is computed as:
> 
>    max_link_speed * max_link_width * (1 - encoding_overhead)
> 
> The encoding overhead is about 20% for 2.5 and 5.0 GT/s links using 8b/10b
> encoding, and about 1.5% for 8 GT/s or higher speed links using 128b/130b
> encoding.
> 
> Signed-off-by: Tal Gilboa <talgi@mellanox.com>
> [bhelgaas: adjust for pcie_get_speed_cap() and pcie_get_width_cap()
> signatures, don't export outside drivers/pci]
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
> ---
>   drivers/pci/pci.c |   21 +++++++++++++++++++++
>   drivers/pci/pci.h |    9 +++++++++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 43075be79388..9ce89e254197 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5208,6 +5208,27 @@ enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev)
>   	return PCIE_LNK_WIDTH_UNKNOWN;
>   }
>   
> +/**
> + * pcie_bandwidth_capable - calculates a PCI device's link bandwidth capability
> + * @dev: PCI device
> + * @speed: storage for link speed
> + * @width: storage for link width
> + *
> + * Calculate a PCI device's link bandwidth by querying for its link speed
> + * and width, multiplying them, and applying encoding overhead.
> + */
> +u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
> +			   enum pcie_link_width *width)
> +{
> +	*speed = pcie_get_speed_cap(dev);
> +	*width = pcie_get_width_cap(dev);
> +
> +	if (*speed == PCI_SPEED_UNKNOWN || *width == PCIE_LNK_WIDTH_UNKNOWN)
> +		return 0;
> +
> +	return *width * PCIE_SPEED2MBS_ENC(*speed);
> +}
> +
>   /**
>    * pci_select_bars - Make BAR mask from the type of resource
>    * @dev: the PCI device for which BAR mask is made
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 66738f1050c0..2a50172b9803 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -261,8 +261,17 @@ void pci_disable_bridge_window(struct pci_dev *dev);
>   	 (speed) == PCIE_SPEED_2_5GT ? "2.5 GT/s" : \
>   	 "Unknown speed")
>   
> +/* PCIe speed to Mb/s with encoding overhead: 20% for gen2, ~1.5% for gen3 */
> +#define PCIE_SPEED2MBS_ENC(speed) \

Missing gen4.

> +	((speed) == PCIE_SPEED_8_0GT ? 7877 : \
> +	 (speed) == PCIE_SPEED_5_0GT ? 4000 : \
> +	 (speed) == PCIE_SPEED_2_5GT ? 2000 : \
> +	 0)
> +
>   enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
>   enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
> +u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
> +			   enum pcie_link_width *width);
>   
>   /* Single Root I/O Virtualization */
>   struct pci_sriov {
> 
