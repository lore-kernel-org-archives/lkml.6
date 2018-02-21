Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933382AbeBUKze (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:55:34 -0500
Received: from mail-cys01nam02on0062.outbound.protection.outlook.com ([104.47.37.62]:35872
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752185AbeBUKzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:55:32 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com;
Subject: Re: [PATCH] PCI: Add quirk for Cavium Thunder-X2 PCIe erratum #173
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, Jayachandran.Nair@cavium.com,
        Robert.Richter@cavium.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Huang Ying <ying.huang@intel.com>
References: <1517554846-16703-1-git-send-email-george.cherian@cavium.com>
 <2323301.ORZpb3hFRe@aspire.rjw.lan>
 <20180216203434.GC11014@bhelgaas-glaptop.roam.corp.google.com>
 <2858019.9TUCWsDpTB@aspire.rjw.lan> <20180220015433.GA9656@wunner.de>
 <20180220190037.GB32228@bhelgaas-glaptop.roam.corp.google.com>
 <c8454323-06b2-e758-0d38-550c6b31b15e@caviumnetworks.com>
 <20180221095435.xe5lmes7mpxca3en@wunner.de>
From: George Cherian <gcherian@caviumnetworks.com>
Message-ID: <d0f6a588-23e7-123e-267c-5257c21bb38a@caviumnetworks.com>
Date: Wed, 21 Feb 2018 16:25:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180221095435.xe5lmes7mpxca3en@wunner.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: PN1PR0101CA0014.INDPRD01.PROD.OUTLOOK.COM (10.174.151.24)
 To BY2PR07MB2327.namprd07.prod.outlook.com (10.166.114.141)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ce6f214-1362-47ee-0023-08d579199faa
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BY2PR07MB2327;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2327;3:ztm3JqWDOE2n5/33YealaETbWkwwZJuE3Lu1gCQdP84VOz20NPaJN7buSNXPvZy9lja2hlHY3jQx+2ZMSO5wmjZvtA+g3LL/b3ZdUFoRQV7m21XAgpikHMy/i5KN9ghI0+e3QvqA+ZcDBV+I2jfPGi8PIEapXKvjbhn2wYB527CH38WQ6zz8vLavvcdtvEhPC/esEkbny0m33yWbOmpB9/l6lQesXqg3BV59+GD/4/UCX4ONWCDBdQFRp3nF+JOF;25:9hYBpRCQ6oSv2FHZK6jS8VFdw5vkMDF+Ph0OLVGnWpAt3sL6/TJM5+TdQ0BMqqQ+wYyRxA2jVBBSbLDLEH/Zem5W8Y1jow9yPZzRIsfWLrxpstCPktHasR91rp349yr5hDdwR1IzPhAy3X8E/qrP3lvsiVitvK+RoSdvnDS9KB4xD15XEqJmBG/2NzczHIWvyOTImxdKFAzJ9xbsH5NADrtjHd37rShKxUp4jNQhFx7NGk45Y1E2767H9tRAJawm42wwCDv8QkVZ9HaJaYFy3B3ceHbDsB84549wjuus2bZy+ggjkdVs2gkBkvAd2ghRzcSi+1sNlU2av762kIy5yg==;31:fF8xOxjc3cIjOU1Bq82ilr7WotMOF/L8X9zkInJR5wqUdycUabMTeHJe6MUr9EsS+XaQFIXVlF1OOnwK5KPvJljvWhAcBvuCYtsH/t/DH+jWEw5nz1AcLlAzhRL7Kdi4iBlaAyVtMoxRpZdD8zBYxeyCV7yetzc1BKNNF+Vwu2gAh4eZh9HLC7lqE5+EJ5SXv3TgWLgF4EED2Fo7D+AW9lNwqLogEkGqQmIxfxR4Qu0=
X-MS-TrafficTypeDiagnostic: BY2PR07MB2327:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2327;20:IJERgD81qCdHGAcP8BwZ6Q03SpszRvsnRr4OWc7vYklnkQ5iXtRg+M5G7cr90PPa8rmfq6YOqVO71CGXUTT+M+gMPIttG89fBoXZflJ8V10nvXwH/LoIs+gBrfwVNVC993Rf2xTyyjJRVUen50ESJ0wVK72H9idqfPwl3MYoUXVUSSTuqqnRSfxnFynf3Q1wWmZcd+0EJvLXIjAvuZhTFyDjYYyoEIT1fkngqaoj2jDbSyXZQJ1ESPFKkPMl6GQWo/UKtfMdSl6g2PQS2jaxpEXKnPR+YUDjbSfdqzOG5LaFxKERI2QyH5S3bpvIyrFoWAU+iH/Gfpum1sHwYztTfaW3lTTCDfUll+DqioZSL1HlzFOi+yuNxCrTONU0CvJjnB9CBKH60wg6HvtQNcy7k+oeYyC4MhzcKMnzAu374PaPv1eJFF4lNF0sabfgDcOrPPt+lH9XhwvJ9rJbrD6VxYEYHegsswySCV6poTB3OQbz6iBD6J85HeV39OK1dyz2Q2+1gnrkmDOdj8hScoTbzgxRY1hHK6ktzHwzYSpYHGmxrAsnX2tok81CM5hfhLg9FglaZC+STsawkIoio8TcJhgqrivqeY3R26MhMunCmZM=;4:4bW4KaODO2GfvGOI36zyLj9nja6BeDQvVzyvZbnv5wtEoye9U+0/Y5zIB2SiPPf1LjeDkauPVyUkKXvkacf7nKxNYwNIU8htjHg2CYpkJc7cZtL3w8ck6CXYKjlt5q9vOWTduAiwUv2PW3uT0i+B8frYslQuyP9mGC4Rvwylp6rUryBNvs7ylXlRTzXI1C4RfdpsxvLlJvhtS1zrj6yWCJNxKYatexHdZCb16Zw+bFGHll9YdjvJtVedug0ylWWi9ZmeEqrsVojzsaa22s8zQw==
X-Microsoft-Antispam-PRVS: <BY2PR07MB2327E7C14C54ADDC4D1EBBDAF9CE0@BY2PR07MB2327.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001066)(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3231101)(944501161)(3002001)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BY2PR07MB2327;BCL:0;PCL:0;RULEID:;SRVR:BY2PR07MB2327;
X-Forefront-PRVS: 0590BBCCBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39860400002)(39380400002)(376002)(346002)(396003)(199004)(189003)(6486002)(25786009)(16526019)(229853002)(50466002)(64126003)(97736004)(31696002)(59450400001)(386003)(53546011)(65826007)(36756003)(5009440100003)(6666003)(2950100002)(42882006)(90366009)(6916009)(4326008)(68736007)(93886005)(7736002)(305945005)(105586002)(54906003)(58126008)(5660300001)(478600001)(67846002)(316002)(2906002)(72206003)(16576012)(8936002)(3846002)(230700001)(6116002)(81156014)(31686004)(76176011)(8676002)(23676004)(81166006)(2486003)(77096007)(52116002)(65806001)(6246003)(52146003)(106356001)(53936002)(26005)(65956001)(186003)(66066001)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR07MB2327;H:[10.167.103.249];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjA3TUIyMzI3OzIzOkJsbzV4WStTWWJZSGJDdWxTYmU0UzdaV0t5?=
 =?utf-8?B?dCtQMWhRWjJnZmt4OWY4RHE5N3VHbXRNRHBIc2ZrRmt3azVLUHVqbHExV0FS?=
 =?utf-8?B?Z1AySTgrL0xnYWVqUTlNZnFiUHdraEdpTlB0Ym1KVkdiV29wQnJaM1JyZmxH?=
 =?utf-8?B?clNIZ1NHSE1tREFOZldycWNKWSs1M2Q2VHBxWjN0eDVNcnJNeVJvdXVmSFI5?=
 =?utf-8?B?TG9SaU56NForb2pTUEQ1UU1QV0pUMUFmMjRHSjFBenFNc0pVZy9ZRzhtQTcv?=
 =?utf-8?B?dmJBNXZvai9ack14VUdzMkJSMjI1NzlOZS9aam5hYUFNWEkveU8vMlNVOG4r?=
 =?utf-8?B?ZThQaHNFcUdvY1JMN3BzakdmblppYjgvcjdsNERlRjllWTdoUlpHc1NKd3RX?=
 =?utf-8?B?Z256VFFiVTBVWXFNWHlvdjljRjJrRzJDR093RHZnRjBOdEQ1d1pRQnNkTmgy?=
 =?utf-8?B?V2VpTWtnMWdITitFOUMwOGVBYW5ZTXBzbzhhek5NaDlYVTZxVjhGT1BWMHhj?=
 =?utf-8?B?TmZEdDlNaWpUQTJoQnU4Zlh5dmRNZW5nUTdMRkpTNzNrZjhOMDdLOUt3WlVN?=
 =?utf-8?B?cHdvUVI0Zm1MWWVaM3VDSmY1c3VuUjkwcXNKVisydlE0WUNrMlB4cXZxZmt3?=
 =?utf-8?B?R3RwcE1QeStqUTYrWkVNMm9lT243T0VRL0Noc0lTSGpISHpDaFN4aFFOSDZ4?=
 =?utf-8?B?RFFEZmhKbmROTWRBaEsyUXlrVGtKdnFFT2QrdjR4UnBDNlBJcTVyb0pGcDJh?=
 =?utf-8?B?YTRWRi9kUVpuM2xsWFMrTVU0S2xpUzNnREF4U2NWQk5HcVRXK0RQVjhSZ0VR?=
 =?utf-8?B?VGVzd3g4Q3Y3dllmOVN3dWNpZTZvczE3NTBkR2REd1Mva0RkNFR4NVFJdDBO?=
 =?utf-8?B?VWljMEk0M0lrcFE4RGxhMFljWmlGd01yODhUS3pqdTZLa2xLZU1BYjdoaTBQ?=
 =?utf-8?B?SkNuYmxjYmw2M2N2N0JWNUtEY2lvK2dwcUJxd1c2dFF3SWhsZlNFRkJUZVov?=
 =?utf-8?B?UXRmZFdPa0NmQWlGOWZPVkVhajhlNzBvZEdqOHNQVEJNTjhzQllPTnZ2QnBB?=
 =?utf-8?B?SWlTS0p2eG1UWU1sTE41TCtSOE40cThoRXdaZDVXRlppM1hLM01UaHpDckEy?=
 =?utf-8?B?U2NYUFdCbHZ5RlMrU1VhVS9yZW5HbkYzQVJDQmZWZEYxeG5Kakdzc0hwSzdh?=
 =?utf-8?B?UU5oL3FYRGlkeWM0cmJRdWNBL1Q2T0NIOVFqeG5BVFhxMmtpQjcwbDZyU1Rm?=
 =?utf-8?B?NzJEdVJXd0JjeklXek5EWE1IMGJDMzVzRXZDV3F6T3hrRmlwSjZtS3ZoSCs4?=
 =?utf-8?B?L2d2bXh5bVQwcEZiRmVWT2R6SVk4T3B1Q2Y0OCtOUVJRRHEvbzdsU3Zod20w?=
 =?utf-8?B?TnFxN3I4cERqdGZUeDhWKzlhRUlibVYwUFpyb2cwKzBjeEd5Y2xjSnJxY2xl?=
 =?utf-8?B?UjRIWVROcHdJVEs3NGZ2MGRjWWg4emI3b280OWp5UW9ydURrQmlkZ21LUTFD?=
 =?utf-8?B?N2t0ZnNEUTNRV1B6TUVscmFEenpDQmtYMll1TWxqZ0IwaFl2ekphSVZrV3I4?=
 =?utf-8?B?Q0R3L0x5ZGRINHd0VzFkd1FZb2dyV2pkZEJTL2QvR0V6MWRLWlIyNTRUM21n?=
 =?utf-8?B?NDFRV0hnYW1QbUpFQm1peHBQS1JPSk9za1cxYm5hdm82Y1F2RXRWOEtaMEsz?=
 =?utf-8?B?TXJFVnNkc0lGdG5nNnQ1SmtNWXNVYWpOR0hxMmpSSFVKdmxLNVZadUpnS3NE?=
 =?utf-8?B?d3pmcU9wTmZENS9jclRXUHBpVTJlZjVSMitGSW5uWTQ1SWpVSi8vV1BiWGI1?=
 =?utf-8?B?MldPQWhzSVRRWEVWMGxlRFBiUmU4WWFsNzFrNWpyeHhsSTg5NU9QbDlnMmYy?=
 =?utf-8?B?c3BTZGtQdVN1ZUIydXVBTDFXZHlyMlh1cXUvQmp1M1ZybXJvblJ0RDMyblNT?=
 =?utf-8?B?NjdaODRGQ3RJc0h3amdkZVp3b3RnL3AvR1NHa0F0dm1XSUl4K1NhWU1FS1Jn?=
 =?utf-8?B?OEJTbUxtcjJua1BXMUc2L3RsMlZvLzBtQnBvays2ZFRCcEs3ZVZ5eU11Nkcz?=
 =?utf-8?Q?nAtc=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2327;6:e334Da/9njIhr9YTZ13YBjmn+lCw1VVF11Pvg8tOlf45YbkZaNMGiUeE1zlbSxGAEv160HdN3h3Cyr2hH4Mu9LrgozeK33YAhuD+pFimbyCVY9oqothOAEw3iqUbSjGVWb/xJlLZseMrbvfyZn+q0XdUsuzrDSBwXyDe8/NDNYGLvImXemiLKTZytaYD7kJpr4xHjwtzMghpxdzllnZo4UVgW1yL+IwWpfrK8sqqkohnNTveNDRg6eH+dcpsGxLF3gSm0NrmwHWKVgKRcBInveZI13ytIcYaTerxfqaDARNX3u50uY/Ev7wok4Js4CHBY/D8R7YBNXtC/jUxeo25/Jb71BE4mYPvV6bp1eSnlRM=;5:3npW/7ni2EYrbjFp65r7oqJT2QxZA4W/EaqeMFgmtjFTqDpt+mvO/xFoYzX1rKwIw/q2QSq6581qbvOeSTxu46ucvwhcVbD9/BbyNvo1u1+Ut5dGW3gAvi4AsjbqULoeAiiMV4irbMSojVbjXnaxy+vYmB40Zy32OESIFHAYxxg=;24:Jrvzid2plAsbpcd30pUtZsxvEHbAPqkyWxSm4EqFC1xdXC1WRDjkIMwybXdurwl8+M8m73v4r3y2EyfWfsO14ZnKoL9UU2zbcfmlNWawBfI=;7:lVhoJ7Ejw64AKUMsoiv3+D3M58+jDyiCwCOlU2lgkGwvOOq7QQeBu9VAtVBAtnN4Cm07F7ibfP8ajdAm2jpyBncv1zdKCo99oFrm+O9IxodqnxyT7HlmOuvR0Gk5Pr2sAqIHN5/FWHQimQv9Jc+KVSPOKkDu3QyaBiIFNKC3Vf170R1M1C36teDuD0HOcdBuE8WFmKDDJ0LGv8CDO27dok2AE4wrKgidt45+Lcp9jucksBel9gANYsG8QnoX6v/K
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2018 10:55:26.8122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce6f214-1362-47ee-0023-08d579199faa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR07MB2327
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On 02/21/2018 03:24 PM, Lukas Wunner wrote:
> On Wed, Feb 21, 2018 at 02:58:13PM +0530, George Cherian wrote:
>> I will explain the setup used
>> To the Cavium ThunderX RC the following PLX device is connected.
>> PLX Technology, Inc. PEX 8747 48-Lane, 5-Port PCI Express Gen 3 (8.0 GT/s)
>> Switch
>> There is no device connected downstream to the PLX switch.
>>
>> AFAIU the pcie_port driver probes PLX and enters autosuspend after 100ms
>> since pci_bridge_d3_possible() returns true.
>>
>> And later pci_sysfs_init() ends up doing a config access of PLX which fails
>> with a "synchronous external abort"
> 
> Then you're missing a pci_config_pm_runtime_get() in pci_sysfs_init() or
> further down in the call stack, rather than a quirk which just papers
> over the issue.

I have found another configuration where this fails.
Following is the configuration
1) Connected a PCIe Intel i40 card under the root port.
2) unbind the i40 driver and bind with vfio-pci driver.
3) Run lspci in a loop. "lspci -s xx:xx.xx -vvv"

I get the same synchronous external abort.
In this case the vfio-pci driver probe it moves the device (i40) to
D3hot provided disable_idle_d3 is not set. lspci tries to do
the config_access which fails with synchronous external abort when
the root port transitions to D3hot.
> 
> Thanks,
> 
> Lukas
> 
Regards,
-George
