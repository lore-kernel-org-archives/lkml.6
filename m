Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752390AbeDBOej (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 10:34:39 -0400
Received: from mail-he1eur01on0042.outbound.protection.outlook.com ([104.47.0.42]:65195
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751935AbeDBOeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 10:34:22 -0400
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
 <31e66048-e8b8-47ba-baf5-023560b4c124@mellanox.com>
 <20180402004049.GA131023@bhelgaas-glaptop.roam.corp.google.com>
 <50346f44-de3f-b226-69ad-6de45e94e261@mellanox.com>
 <20180402140501.GA244675@bhelgaas-glaptop.roam.corp.google.com>
From: Tal Gilboa <talgi@mellanox.com>
Message-ID: <3decbba0-74a2-c906-b5b4-a04f261860eb@mellanox.com>
Date: Mon, 2 Apr 2018 17:34:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180402140501.GA244675@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: PR0P264CA0019.FRAP264.PROD.OUTLOOK.COM (52.133.64.31) To
 AM5PR0501MB2595.eurprd05.prod.outlook.com (10.169.152.10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 073aeb36-a4ac-4d54-895c-08d598a6d17f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0501MB2595;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0501MB2595;3:2s4an7JkNp9HB90ImETxXUZiL9/2yGJ2pm1NoDOBgCUhSYwBiabMbPDnX09QQbNbQNFpoRhts4AYDHQQFnBBZXIre1nj+krKofhIRY5/B/Wg7CAxv/cT61x4Ls0G8v2YOugIAWY1a+CnIp9GQYCDNk5gj2ww1B67bxhPjV0J0ZnYo2dvWdgBEc0zDcBj0Q5kPJwWz/ef2hHZc1hLIyvHQvQI6sktgElvKDu+KP3ox4PqVHoA8J0EtqvM4mwg7MVW;25:y1RVcl9AoCJTRy7F83HJ9Y+4i4LDTG3htsd7IPJAiDv7wo42BpYBs/XiXtkQepww9dNpCOO1yKxKvtqGveJi0Mu9fwUiBWqeYp3dXozVu187NaMUB6a8pMPbo/Tq0EZH0oROVhqAIQILUHNs5Q3wHML60u9PFxfaKWx+R6uFvazD7cXxnBh5kMANCq2CawDwgl0B1dOMI3afPpCsXVTYFCOV7a7YtghiD91zeDY0iFFYDZ9hT70ahkjuG6fz37xafqUAJn2UmPWp4FElCZsYWiy2RExpLkFQ+ixyPXt2phtZliQVznbneXsB/YiBNbSwwTfPrxEJQ8AkPHw09XpdUA==;31:5tJTB8tBOPV35OJZ8ZX+peTIQ3+HSK0DSIQB7vjaweAHLByCAE4sEOMvnSLJJ5Tg81kNOGSz9IjsNd76MTLARZZ799ns6G8vp/D0jADfYJ2ujb6GEKG4g/iSBtUc/0pqEs8/PtYCHAp5hLcLabDnLDy6w9yLKsHuibeCT9JT2O10dsM+AqmfGYXIZWhnkzBI76SqPd1l4MzY5uT6Z4pBf4imNq0Jnf/OicOh76LAyfQ=
X-MS-TrafficTypeDiagnostic: AM5PR0501MB2595:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0501MB2595;20:EZISfcx1vxcalPHtSCFIlPnMCj07vRyUVF8YWx4OhEzjOf77TFMetn6byrFM32L61QOrl2fnhmbPmJA43M5n12v3si2foK2j/ZjSddfZkfoHbWKjLIxx7sOOv/Pf7UNaAxe7vUsNLMy2XDWdjKx/eEfWBtX0s4geD9dVZuT1jwHoig7stU/nsrgW/6IApl6yxWmUNHm949a8qOpqDHqbyLZHuKQlEBy5BM7bBDiGdocsX6iK8dmuxfWhr/41Zev/gJyGX6v5xHcq9H8WKVjz2fGEgAllqCfKOV1wbQAQD24ET/KWY8a1iXkKvxpIxIkm3cS4IPBIeoJY5oiZy7CANQbZfeWRH3QSS+FVgVLodsyL72rYFDnCNfifbH16qwmnaeVYi6lHrLZBDYFP0MsURZok22AmaUeuhDVnUcSUz885pVTg4BWTfaQE3o7FcVAp29DoJ0bM/rgupH77DDU9/5OEfZ/vR4BT2383Boi62/S/eWGJQilg4v+E+HNxQ/8S;4:aG2yE3H3RDtOoAJLmNo+ed/0WKuYJRuUWOLX+L4FuoWeU3+BwG1V9g5Vs/dmQZIQOt7q+h+ZJR2Nfok3NFjebQnbXCi4FOiBDcQkjwU8zQj3+dIZEQ9TGRbjipL/gRfwJ6wCcioII/hdun3PW5sRVpdGRCdRih7YGx8Jakbd5mu8C/5MII3r0tqqAR4kkeyUufjigiPtifGMJwh7et4PP7GoEaf6N9RwDTCiaYL7GU8p+p/iNu/cJ3Q3NpYczkaHJd26g4N+ZwVxZukXMd8gavOoExZrDksJA1BnapfV45ckJ+pMDKSH84txeZT0TVn+ybwoo4gtaJvdOmfsXngaTw8YHhUfbKc9uTVcsait0pU=
X-Microsoft-Antispam-PRVS: <AM5PR0501MB2595925B685D3C8BA4298F3FD2A60@AM5PR0501MB2595.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:AM5PR0501MB2595;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0501MB2595;
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(346002)(39380400002)(366004)(39860400002)(396003)(189003)(199004)(51444003)(66066001)(4326008)(16526019)(65806001)(3260700006)(25786009)(106356001)(31696002)(67846002)(53936002)(478600001)(230700001)(105586002)(6246003)(77096007)(65956001)(966005)(53546011)(97736004)(6666003)(6916009)(229853002)(47776003)(26005)(186003)(36756003)(31686004)(52146003)(23676004)(52116002)(8936002)(386003)(68736007)(65826007)(2486003)(50466002)(86362001)(2906002)(76176011)(5660300001)(6306002)(16576012)(7416002)(3846002)(6116002)(2616005)(64126003)(956004)(93886005)(81166006)(81156014)(8676002)(7736002)(11346002)(446003)(305945005)(6486002)(486005)(54906003)(90366009)(58126008)(316002)(486005)(476003)(59450400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0501MB2595;H:[10.207.0.54];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA1MDFNQjI1OTU7MjM6RmZqeFVTdmZZb3FCbzB2RU9zS0V4cDYv?=
 =?utf-8?B?WDcrcGk3aFQwRHlSWHN4MEJCV3dmTEtQb3IyTnJtUFFFYjZiMHFmSWVIN3dl?=
 =?utf-8?B?bnVLUUx3RVp6d1Y4VVRXZTNjbTBrYk5wakk3ckpFSWpyL3BZS1AxUzFyRk9l?=
 =?utf-8?B?NmYwbThDTkVsbUE2MitNMUFMOW1uOFFMSXBGaE9oOS8wK2d6NWFYTFJTUHJ0?=
 =?utf-8?B?QzF4SWl0QlFHb0Npc3BsbEhlaVAvQzcvRXh5cFhBSis1NGN2ajFFMWlseEoz?=
 =?utf-8?B?ak1EVUtYbXBsWVRqN2d6NDdabGxFd1JxTHZUZ2V4U1JobU9hQ0pyUG52eUtt?=
 =?utf-8?B?UXJxL0ptNUNrSHFRMS82QW9ySEtYOW9oc2M2NGlXeE92MlFkSXRQN3RPMS8z?=
 =?utf-8?B?R2szbDhZVk9DZVpHWnhFQmlLbHpIOTc5Y1diUysyOW1tcXlZZ2kwUisyakxL?=
 =?utf-8?B?c3ZRNjlyTi93V3FvS0txNXp3Q2JSOW5ZMWU3SzVISlZYWWhmOG01ZGhhSThK?=
 =?utf-8?B?a25CTVhWaXAramlSdGRPUzV1M1RFd1F0SDRpbWZqSUROTUUrbFRVT0thd2Nz?=
 =?utf-8?B?Rk5pOTc2UjNRdEJkb2ZWY0x4cVBUdS9XUEpkS1BsTjZYL1ZnSWszdi93ZnNm?=
 =?utf-8?B?b3pOWVpwd1NpUkh3YkJUK01ZbnZuNS80Zm1xZTBYeElSWEJIZEZJUWV1dUdj?=
 =?utf-8?B?Yk04TXYvTk1oQkFoUUxjRjlXVU53U2NCMmRsUFVzZ2xTRlo1V0NVTko2bCs4?=
 =?utf-8?B?clRXZzBGekZsK21jVnVGUXYxQU1kYjcyQ2VZZzB3ZyswdWh5UW92Z3JvWitU?=
 =?utf-8?B?Z1Y4UlhxM0I1RWl2VHIvQ3NBc29lWHZuMjZyN203OUI3eDNWVVAzcW9EbVd2?=
 =?utf-8?B?dHRMVWQ5NXp6YkQvSXkrSEZjVmJrU3g2WllOd2kyZi9jNzFrT2Irck5HeVdp?=
 =?utf-8?B?RUVQWDNNclZTd25CZ3RidTVRRzlCL3FZSzgrblF6WC8yK1IxeXlWUS9rWUdE?=
 =?utf-8?B?RmVKaVZqMi9jaUpuTDRkZ3lOZ2ZpMndUV3Q1T2JFbEt1eE51ckdJSndrWTZD?=
 =?utf-8?B?Szh5ejVkNWV0bGdJMjVSbHR4YlF4bW1VTXVpOXpTeFAxempEb1ZuUk50T1dD?=
 =?utf-8?B?bnRROHd4dUZjRUszK2VMSTVxQnQwdTlNR0k3TjNEZm5hZzA0cWpQZjhkZ2Jo?=
 =?utf-8?B?a3NxOXFyQWVMOVBHOTVtck5ZcjRCeG51ZTdLMDgwZ0VIWHI3YjYxdmhOZ0dS?=
 =?utf-8?B?QlViRlYyanIzcEFCUmtNWjlMRUV3YmlFaGQ1Zk9FYnA1UGRkTGl6QVZGR3FX?=
 =?utf-8?B?ckNSVVhYRnphRVpEWUdDZVRDWGFobTAyVXZ4eWk4akQzUmRDMlJONVlwaWRn?=
 =?utf-8?B?ODVGYjdXTEJXQ280bkZtT0Flc0F3WWJPRFl2dkl4SGY5dW5CbUxsZFQ0OGtn?=
 =?utf-8?B?RURwYW1qem1jZkNKVzVsMWsrMVVRYVB6aHVWelJEektPWTJSRXkxZlE3OHVF?=
 =?utf-8?B?QkNhVkJ4aENCTzZWU2YyZEVTL3ViTlE1Y0J1WDRpTDlCcnp3RWlrcitBZkVh?=
 =?utf-8?B?THlCcy9lRDNqSFRmR2tGNmhYTnM4NlVscGdJMkdEdCtJOFpRWmRZSytRWE9I?=
 =?utf-8?B?bktSOFlRMkxraVdpS1lScUxrenpXcyswMWhGdGg4K3dvSDVqdnNjaWE0T2VU?=
 =?utf-8?B?TnQybGYzamJFUnIrOUNDVEVSWFZIQ2NaL1BzNUVsUVpNS1Z0TGFaZXVqN2FP?=
 =?utf-8?B?clFRT3BZdG9KNDIxMzMxQ2ZuTkpDTGFkQVdWckVnWDVyVktrdjQ1aENLazQz?=
 =?utf-8?B?eTVsNE9nWVJkazhIbGk5UHBuSThlZjFUaDNUQnZvbTh0RG1Ybi9LZk94Wk5j?=
 =?utf-8?B?WGRoS1dSelFHc1YxYXZjMWJwV3BSMjlpa1d3czVNRmhIOFdoM3A0aytndk9t?=
 =?utf-8?B?K0FxQ0JsQWowS0h2UmQyWFRBNDJWaEhhUnRVVlRjcmxLaExKUjhaaXFLUXNE?=
 =?utf-8?B?WWdxZkJnUjQzbnhTY2NlV0YveXV2di9FaWtPQURTS0M4NDIzc1BrNEpNTWF4?=
 =?utf-8?B?ZmVWdUlEMm11WG9QdngrWTFXd3J5aUwvcjdodnMrUWVuVXRYV2U5U3hXT3VM?=
 =?utf-8?B?dEE2M09oa3ZMSnNIaVV5OXhRTGdlUVRsdVVuVUYza1R2NEZ5YTVPRzNSdVd5?=
 =?utf-8?Q?qw8UssAA+2IV4T7xuPLvwpSpGfs8bkFaSTCZ5UmfskbE=3D?=
X-Microsoft-Antispam-Message-Info: i9QCIbk8Mm3Ti+qkdSNu7kQign7H9JQtzB6+x1ipWF5eczAFvj93HCv8ZEfiB7CZazvzgv8hydT+IHgQq66O76U+iemzFhjW0VcAAUTOZeqnUArGK8xmkgJLqWXMOxP7WOcEiCHQeO0RdRdYsf08aG423uRJiRgLXML31sY/F8DSp6jgARtI9Zp40tiGC1we
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0501MB2595;6:QgYwN7vqufs3nSXKRv9ESen7WBYIo5DJPCmO0pA4uEP1xX0aR0wreKkqgwyK8tOIUlmKHwecJreaHpSm1xkW2jw9HmFl4hxffiGdyKRV5kpvlNPj8L2QDBBwoNpEMrebZnJJVnEoJwYliYveoUyRNJD1DZVXz0rEyFZ+UG61Gms1PAeME6PmqIgGx8UyFBLkeEoEUooMkdomAms2tfUP68OuR/mgSf4oRH7k308MdNbdNPHVbJoBk7CL66GsR7ta9n1IS9aGu+kZA2JLbXKn78LQluNOpqChIXvjfjtICjgssDMXDTSn5LEYSG1A+Ls9Bm6XdUl6apwLpu5DeZC51vN7I1aFcg/7+4q/JtVDUMlIblHbW+UeOmtHPtz0jOqsrX7fTkdygOHthcu+mr1tTprdmUvr2Z8Z+NaRItlrH4X9o6YV//uG6lQPgHkK43SDgrixEy7bsTwsoMq+IZWyww==;5:NTqnXEc+o2USLk3znV8t7ccpjYoykfmksmGuOK/lqNyeDQZ5f0oFnzkdZJNY0xm4+keplK//n52uQPqw8LDd0630wUpCAnqrEiu0otXsv0CXzqFQjnD08ZOjdmbMOLz950iDuCIiDfpDXdM+IXzETlIyBPHprwnIiTBZ3wgP92g=;24:SIa4TmpIySa8emHRaW/IDdygx9KKWmPt6sHsFNY6QAgSsF273M2a//erSSG98oXk7KSsD+55GbIcgMXhhI58fY2ca1pscpJNNk8cyMgQVQU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0501MB2595;7:Clj13eoiETRppeB5zBA+DwkEnv55CXHlPnzkrLxv4geZ+ZMVY+MERO0WZ5EOV1XruNSN4xCvN/N7CDfN9NoEQs0HImxBNJbaduJuQtDb0L3S+JHIo6M5UFIbf18lRwwPazOGnFnFl8eHKs6RyfXUJ7qQvWSNju4ElLydB0zTEncG0LDKVeD3Ymq2D8y+dSO8C5lddTfFEBzNtCF7O2qCPQ1f6wlA76kN6yFivPPgyEf5sR+A6Sq0OO0FwcUZRrea
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 14:34:17.8903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 073aeb36-a4ac-4d54-895c-08d598a6d17f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0501MB2595
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/2018 5:05 PM, Bjorn Helgaas wrote:
> On Mon, Apr 02, 2018 at 10:34:58AM +0300, Tal Gilboa wrote:
>> On 4/2/2018 3:40 AM, Bjorn Helgaas wrote:
>>> On Sun, Apr 01, 2018 at 11:38:53PM +0300, Tal Gilboa wrote:
>>>> On 3/31/2018 12:05 AM, Bjorn Helgaas wrote:
>>>>> From: Tal Gilboa <talgi@mellanox.com>
>>>>>
>>>>> Add pcie_bandwidth_capable() to compute the max link bandwidth supported by
>>>>> a device, based on the max link speed and width, adjusted by the encoding
>>>>> overhead.
>>>>>
>>>>> The maximum bandwidth of the link is computed as:
>>>>>
>>>>>      max_link_speed * max_link_width * (1 - encoding_overhead)
>>>>>
>>>>> The encoding overhead is about 20% for 2.5 and 5.0 GT/s links using 8b/10b
>>>>> encoding, and about 1.5% for 8 GT/s or higher speed links using 128b/130b
>>>>> encoding.
>>>>>
>>>>> Signed-off-by: Tal Gilboa <talgi@mellanox.com>
>>>>> [bhelgaas: adjust for pcie_get_speed_cap() and pcie_get_width_cap()
>>>>> signatures, don't export outside drivers/pci]
>>>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>>>> Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
>>>>> ---
>>>>>     drivers/pci/pci.c |   21 +++++++++++++++++++++
>>>>>     drivers/pci/pci.h |    9 +++++++++
>>>>>     2 files changed, 30 insertions(+)
>>>>>
>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>>> index 43075be79388..9ce89e254197 100644
>>>>> --- a/drivers/pci/pci.c
>>>>> +++ b/drivers/pci/pci.c
>>>>> @@ -5208,6 +5208,27 @@ enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev)
>>>>>     	return PCIE_LNK_WIDTH_UNKNOWN;
>>>>>     }
>>>>> +/**
>>>>> + * pcie_bandwidth_capable - calculates a PCI device's link bandwidth capability
>>>>> + * @dev: PCI device
>>>>> + * @speed: storage for link speed
>>>>> + * @width: storage for link width
>>>>> + *
>>>>> + * Calculate a PCI device's link bandwidth by querying for its link speed
>>>>> + * and width, multiplying them, and applying encoding overhead.
>>>>> + */
>>>>> +u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
>>>>> +			   enum pcie_link_width *width)
>>>>> +{
>>>>> +	*speed = pcie_get_speed_cap(dev);
>>>>> +	*width = pcie_get_width_cap(dev);
>>>>> +
>>>>> +	if (*speed == PCI_SPEED_UNKNOWN || *width == PCIE_LNK_WIDTH_UNKNOWN)
>>>>> +		return 0;
>>>>> +
>>>>> +	return *width * PCIE_SPEED2MBS_ENC(*speed);
>>>>> +}
>>>>> +
>>>>>     /**
>>>>>      * pci_select_bars - Make BAR mask from the type of resource
>>>>>      * @dev: the PCI device for which BAR mask is made
>>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>>>> index 66738f1050c0..2a50172b9803 100644
>>>>> --- a/drivers/pci/pci.h
>>>>> +++ b/drivers/pci/pci.h
>>>>> @@ -261,8 +261,17 @@ void pci_disable_bridge_window(struct pci_dev *dev);
>>>>>     	 (speed) == PCIE_SPEED_2_5GT ? "2.5 GT/s" : \
>>>>>     	 "Unknown speed")
>>>>> +/* PCIe speed to Mb/s with encoding overhead: 20% for gen2, ~1.5% for gen3 */
>>>>> +#define PCIE_SPEED2MBS_ENC(speed) \
>>>>
>>>> Missing gen4.
>>>
>>> I made it "gen3+".  I think that's accurate, isn't it?  The spec
>>> doesn't seem to actually use "gen3" as a specific term, but sec 4.2.2
>>> says rates of 8 GT/s or higher (which I think includes gen3 and gen4)
>>> use 128b/130b encoding.
>>>
>>
>> I meant that PCIE_SPEED_16_0GT will return 0 from this macro since it wasn't
>> added. Need to return 15754.
> 
> Oh, duh, of course!  Sorry for being dense.  What about the following?
> I included the calculation as opposed to just the magic numbers to try
> to make it clear how they're derived.  This has the disadvantage of
> truncating the result instead of rounding, but I doubt that's
> significant in this context.  If it is, we could use the magic numbers
> and put the computation in a comment.

We can always use DIV_ROUND_UP((speed * enc_nominator), 
enc_denominator). I think this is confusing and since this introduces a 
bandwidth limit I would prefer to give a wider limit than a wrong one, 
even it is by less than 1Mb/s. My vote is for leaving it as you wrote below.

> 
> Another question: we currently deal in Mb/s, not MB/s.  Mb/s has the
> advantage of sort of corresponding to the GT/s numbers, but using MB/s
> would have the advantage of smaller numbers that match the table here:
> https://en.wikipedia.org/wiki/PCI_Express#History_and_revisions,
> but I don't know what's most typical in user-facing situations.
> What's better?

I don't know what's better but for network devices we measure bandwidth 
in Gb/s, so presenting bandwidth in MB/s would mean additional 
calculations. The truth is I would have prefer to use Gb/s instead of 
Mb/s, but again, don't want to loss up to 1Gb/s.

> 
> 
> commit 946435491b35b7782157e9a4d1bd73071fba7709
> Author: Tal Gilboa <talgi@mellanox.com>
> Date:   Fri Mar 30 08:32:03 2018 -0500
> 
>      PCI: Add pcie_bandwidth_capable() to compute max supported link bandwidth
>      
>      Add pcie_bandwidth_capable() to compute the max link bandwidth supported by
>      a device, based on the max link speed and width, adjusted by the encoding
>      overhead.
>      
>      The maximum bandwidth of the link is computed as:
>      
>        max_link_width * max_link_speed * (1 - encoding_overhead)
>      
>      2.5 and 5.0 GT/s links use 8b/10b encoding, which reduces the raw bandwidth
>      available by 20%; 8.0 GT/s and faster links use 128b/130b encoding, which
>      reduces it by about 1.5%.
>      
>      The result is in Mb/s, i.e., megabits/second, of raw bandwidth.
>      
>      Signed-off-by: Tal Gilboa <talgi@mellanox.com>
>      [bhelgaas: add 16 GT/s, adjust for pcie_get_speed_cap() and
>      pcie_get_width_cap() signatures, don't export outside drivers/pci]
>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>      Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 43075be79388..ff1e72060952 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5208,6 +5208,28 @@ enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev)
>   	return PCIE_LNK_WIDTH_UNKNOWN;
>   }
>   
> +/**
> + * pcie_bandwidth_capable - calculate a PCI device's link bandwidth capability
> + * @dev: PCI device
> + * @speed: storage for link speed
> + * @width: storage for link width
> + *
> + * Calculate a PCI device's link bandwidth by querying for its link speed
> + * and width, multiplying them, and applying encoding overhead.  The result
> + * is in Mb/s, i.e., megabits/second of raw bandwidth.
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
> index 66738f1050c0..37f9299ed623 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -261,8 +261,18 @@ void pci_disable_bridge_window(struct pci_dev *dev);
>   	 (speed) == PCIE_SPEED_2_5GT ? "2.5 GT/s" : \
>   	 "Unknown speed")
>   
> +/* PCIe speed to Mb/s reduced by encoding overhead */
> +#define PCIE_SPEED2MBS_ENC(speed) \
> +	((speed) == PCIE_SPEED_16_0GT ? (16000*(128/130)) : \
> +	 (speed) == PCIE_SPEED_8_0GT  ?  (8000*(128/130)) : \
> +	 (speed) == PCIE_SPEED_5_0GT  ?  (5000*(8/10)) : \
> +	 (speed) == PCIE_SPEED_2_5GT  ?  (2500*(8/10)) : \
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
