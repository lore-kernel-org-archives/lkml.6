Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754695AbeEHHTd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 03:19:33 -0400
Received: from mail-co1nam03on0048.outbound.protection.outlook.com ([104.47.40.48]:27655
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754123AbeEHHTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 03:19:30 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Igor.Russkikh@aquantia.com;
Subject: Re: [PATCH] net: aquantia: Fix an error handling path in
 'aq_pci_probe()'
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        davem@davemloft.net, pavel.belous@aquantia.com, weiyongjun1@huawei.com,
        dan.carpenter@oracle.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20180508063947.11317-1-christophe.jaillet@wanadoo.fr>
From: Igor Russkikh <igor.russkikh@aquantia.com>
Message-ID: <a784ae7f-cd9c-4141-f862-0c01f61d0200@aquantia.com>
Date: Tue, 8 May 2018 10:19:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508063947.11317-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [95.79.108.179]
X-ClientProxiedBy: AM5PR0102CA0019.eurprd01.prod.exchangelabs.com
 (2603:10a6:206::32) To CY1PR0701MB1663.namprd07.prod.outlook.com
 (2a01:111:e400:5289::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR0701MB1663;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1663;3:848QoR4/9ms1cYN4D9tukMFA8NmHCNRtn4mjhlD4SDY0t5jwOeByppnuPS1xLZ7yjZghcZZjdZ4R+1aEe3br5OHtonr1HaIgJC1nQ8T60hzTWwrwoRxPPxnwEcEJ7XYlebLMfUu6iCI0BZI3kAH36x8YEtuGgEhHYKEhf/P6DXJOUK0UGy2uWll4ilmdya3vYxyQAt9FXSObtHbYo9jUaP4yfdcatCLh0OCemq02vWYi8Wf4IKtN3SNArs/nAYnj;25:yKpczoaOyBr84M4JUCjBDX/nP363WnTpHXcpVkHBN7K7hN/c4K4UfeZIyaNkFu0NyvnRJC9fsAm8ycvyXFf48M5JksDwpQnsO2itPzEO7nsMYpO+3TATJs+roF8b65Y6WLBqf+PJ0qqjdkP3ts44ENXXQcsJEvFivkeeJ/D5OiHVeKbsP6NronXiK9dB7lkj2UkcAV7JVBwT68CwV2/KxUK9Er2qNJZM4IkJSO0+wmSuJZA3PNqV4FAr66y0ascc+sEiQ+wzY7dv6wMFZMM6UCYI26faXTajotsvzk9YCjr4TGH36B3p0iZsv7/H6kT10wItXZLgh/wLsuVg4da1FQ==;31:TXZLlWpW1bMZRPcRmFWnyLAt85U/8lbFDYa0mI61kfPnKmOXkYwR6tKJ+GqIY53XFf7WdnNC8iOcYQKdJ5991NG8syrx5LNPPhPRVDSV/uHmh9I8S3vJPihy0WSqdv2YOHOMmHWhWKlAum69nedC3EQC5nLhw1lDaGsUmCciwSN6MXcWDqAfNHGoZmTMw0/vwHkh2sjg1F/pAGrdMTUMbLIeq/uKUB1v6TFWqr/EDns=
X-MS-TrafficTypeDiagnostic: CY1PR0701MB1663:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1663;20:1q9CBX4MvUzE+KC7dnLsyIeyUnCmk4sBBidQyW8DnRwVtS/iJNAK24PHf5N5GXt+Y4ES9JVBYMAOi9WGF8eZgk5jftmgbDFdVf+/3Qoa0mA7ZJXEAIw2G5uHDRhngsDz7UszonxgErgjhp9BkINsGivzHWrqCQWMkmW2Szau4B94ek6eSIz3ugwPoAxSYruZeedeiuEkpRrNeJAWApoRqvaqDmxMalJ8SeQ7wHgS8MAbnYFh78Bf64qBdNQuHNuAASBAAtGdKhGb0ICNwXgT/OBoSDMuRdKHgZXJ7/T1F5C4qWdB6sZLk7LB+Mm3D2G7ywDAh2c+i9u5Tdu/QN6nXIscTfs4gOF863YxepBUEx+hfXKnYL1EbgGVZbg2o6EJQ3b6zGlGELYWrLM0MwNR1ueRh6Yos+5sNj9DZgdo762imbkn1sR++JqMrE6XYMuP6Jq8XK2sEpJspguD2h9O9biDD1uUNfplsH8+xoFanWBLrgvQPbL5NcCrZnYan3wF;4:cOJcZKH9rKcgeKuFg63uQoo2hc1T4cO7wvFmxiNuHmeSAN9mpLhqvrHn6eNtu+lc1Snh8kkyRGuUXRqQ0jRGAvjFiOBZ2hzlFwsoZoChsNCQTt8IxjdQaF/Y5WKhZOpZ/qvWdojc+TKJNHsAMCFHSUU14gEA9PyyXxQY/RKtQPray3YSyDm1xxZf3l1oI+r0n+ngzRNvdzQBb2sl4LTP8nQn6Baj3KqdmJVc8UEsR8NxGDgb7cy4g4pZN+qMfKpz4df8TZv6hEzMstnhPHlF2A==
X-Microsoft-Antispam-PRVS: <CY1PR0701MB16632467C1717F51BDE1EB33989A0@CY1PR0701MB1663.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY1PR0701MB1663;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1663;
X-Forefront-PRVS: 0666E15D35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39840400004)(346002)(39380400002)(376002)(396003)(199004)(189003)(68736007)(23676004)(305945005)(2486003)(229853002)(65806001)(2906002)(65956001)(66066001)(186003)(4326008)(26005)(97736004)(47776003)(64126003)(77096007)(386003)(59450400001)(16526019)(76176011)(52116002)(53546011)(6306002)(31686004)(58126008)(6666003)(16576012)(6246003)(316002)(53936002)(52146003)(6486002)(36756003)(8676002)(478600001)(7736002)(65826007)(966005)(50466002)(105586002)(6116002)(31696002)(230700001)(44832011)(446003)(486006)(5660300001)(106356001)(25786009)(86362001)(11346002)(956004)(2616005)(81156014)(476003)(81166006)(72206003)(3846002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1663;H:[10.0.3.15];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjA3MDFNQjE2NjM7MjM6TGZnNnNWMy9kRzZVazB3MkVScys0Mk1j?=
 =?utf-8?B?UzA5ZitoWHdpS2pIaTA4NUJHQXIvWGpNU2xHTzlGd05XaUpPdENLcXcrRjQw?=
 =?utf-8?B?N1d6S29Za3hscm1GdU04alJTbWY4ZnJteit6WkJXVGQ2cVJ1Rkl1eG5FMWlI?=
 =?utf-8?B?b2w1dG5NUkpWKzkwdWlBaUlTbFJQdjJTaTgzOTUvNlA4YlYrZm5Gb1dGNUtp?=
 =?utf-8?B?S3Nyd1pBVzd1cEYvOGM1eHJLY3dYOHVJN3p1UmtKU0MxNHdnQ1orUXBFRndY?=
 =?utf-8?B?cytnQmtrSU0yR3hscXAzQmI4Um8wUnhkY3F4UWdrQU5Ec3lmTUZNRVI3d09R?=
 =?utf-8?B?TnFmQXk2SFo2TTdkRU8xVlpDL1daOEoyM0dLUEpMVGlxS2dWMXB6UklmUEoz?=
 =?utf-8?B?czc4S3ovNVpNOU5sNHQzNWdseUVGZnEyTkVuaFJ3a1JoQmM0VFBuYlY0NklE?=
 =?utf-8?B?ZmVmNmhLOW83RmErMnZHbnVQWDQwcHhSc1NWZml2K3lNWEQ4UEo0eXpXM2VN?=
 =?utf-8?B?U3o1NWJqdyt6UjdDcnpEY3l1dDd1ZGZDdWMvbllOVXBvNnpiVHlxOTZDUERM?=
 =?utf-8?B?b2ZzeFNrc3YrY01sZjJ0aEpPcGtOSWJTakloK3U5ZU4rNE5ncDhFQ3lIOGlS?=
 =?utf-8?B?Wmt1ZUlKeVBWOE5RbUhOR0VzMTl6QTVqS1VuQ01NSzl1VFhYWFJrMUNNYjJy?=
 =?utf-8?B?MW92aHhxSjhlbzRWMjlNeTdWdFBRdXJNa3FITVdOcGxQL2M4N1VIWExTUXhE?=
 =?utf-8?B?OTFSZTBHMmJtWTdFeC9ISmdOL0lRMk8vRm1IcDhiN3NuY2NONjhHZ3dxLzRB?=
 =?utf-8?B?ajBlOU5GZVJLZDBEY3R2N0hIMjl2OW40bVpvaDM5SDMrQTlHT0t0OVF0R2Zk?=
 =?utf-8?B?THVKcDZSdVAxTHU0cnRoK2pTV3Z4bUxoZUhiOFJvVU0vbmtyMVUvT2d5THVo?=
 =?utf-8?B?RWZRZTVGOUdJUWpkODJEY1Q4SFZWUHhnM3JIYUlJZ3BEd09sc0tOckltSm9q?=
 =?utf-8?B?V0VZTHNrTUF2RW8xVnE5bTA2Y2tSS0NwRUY2V1ZkQWU4aUhSa1NHenBaaHhl?=
 =?utf-8?B?RitYNFVUck9jVUpBamlhYmdacEVjK3JxdFdJSEYycXJybmJraHJ3STZiZWtw?=
 =?utf-8?B?MkgyU1dhUFpGSlNQcXQvV21xamhpYmpxQXloczc1Z25aL0tuaEFVc0ZQT0hy?=
 =?utf-8?B?RiszU0dZUEdROEdFQXpzZHR6Rkl5Vmk3TnZ4SE5yMmdhQkk4Y0pja3dUcFhS?=
 =?utf-8?B?WWdhOG8yK3Nva0E0VU00ZjZhK01IdjlEY2RZVnh3bkszR0V3NGNlc2tGS0hS?=
 =?utf-8?B?VDh5YW1GT09zK2JlcUxEMlpRMW9jVVNzZzl5eUp5RDB0ZTdyS3FCa3VCbTVv?=
 =?utf-8?B?NE4rVEVNZ283N09qTFhaVVVTMWJGeGFwRVkxREd4c1ErSzlIblliay9SNTJl?=
 =?utf-8?B?YmlQcVJ3RDkzeDhPeE9jeUtsb1gwUlg3cXYzTXZHWWdKYmU2TXZ3WWNNZEtF?=
 =?utf-8?B?TDlZSDRmcEU5TWpZQXRWcmVUL2R4amV3SEg2RVZzTDVTU0ozZ2tvNXh4Njl5?=
 =?utf-8?B?STJzL3Z1Sjc3WUE4TzBHeXhSUFBnQUpkOUVXeEg0ZUM2NGpVbFZndFdTWlNm?=
 =?utf-8?B?alJBQnk0eXhEYnNwTHl5QnRQQ2Z2VS93ZGFvY1FrYVVVM0VaajFaalQwQlJS?=
 =?utf-8?B?RTNQNE45TzhJUEZoOTVZNEJqa29HSWVuZHA3UHpieWQxa1dwNUVKajJHMWZt?=
 =?utf-8?B?VlhsZXRpYjd6MTE5UzJ6WnR0cWE5a1VpVUVWWU5wRHpNaXltOHphWlhqcUR2?=
 =?utf-8?B?RmpuY3hIeWwvRkRwNlk5VGhRcmJKNk1pU1hQVjlFUkdOS2JDVjZwZnoyL2xl?=
 =?utf-8?B?WEpXZ0pPcDdCQzFTNEI3ZVc0WFl0OUdXeXd5OTN3NVJtUHhIN3FmK3o2bS9X?=
 =?utf-8?B?VnJGQWVSZXg1SnJZMzlDYUQ1WHBYLzZMRVNVektuK0xRdEZLRnlaUmhwdG5p?=
 =?utf-8?B?RmQ4b2dtVjU1RGhwUEpVWEVHeldxMDU5Mm5RRWZDSjVDd0MwNG01TnZwUU52?=
 =?utf-8?Q?XSm4kU=3D?=
X-Microsoft-Antispam-Message-Info: 9nGvsejlQYm6vUcLtyaqoPtAQj9DOTSrt/HJA6VNqf+q7e/6r8t9FXc1vAY7dg3J7kRKRZc6vOno3ybVTPwJoh5u3DSTee1BRXGRLZPEZ6BkJY0gyyicPYTiRykq/+OUPBGbCCf725hUiIw5AIa0MacPsDwh/L6UgSpV6elTA681NmggZc9P8ZRltNn/S/YH
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1663;6:X8tESdFc6e6ssw6QOPXMASSGNefbEQ0VG3h83NmQHwSVdKv0z4cu1elG//vvREc+3JYWNQelWs1BluSnZ6Isbst+rzSxhbggMXwHoeYwiZwjbRFZ5mdNc5kG7VWN/I/wHENPCQb9QWhc8zsVoOHmb6dY0f/BkYFcv43WBF4Q0GBBUfVg1HK3cclRywc9k8ylw7kvqrixLe8GnvTChWzFGmae5JuGbYVRsbey8Tktx8+lyaAFmq5Gle0PlWq2EmXErBhR1ndVGzwFvjGtkI6EnqSB//zwmVyGRry7GJmq4e3uswTI2Xtn37IV1k2/qlUCtnuUmGo1UwST7c8DvqEN2fYe59pV85x0ZeukTnoMS42snH8Ie3hGcUodpWkeMFdxudILl6KSSMvIN0H0CC3TVTX92wfoZluLqVWlsx7TdhQy7bzO057WsQCs6+U7tGew12dvBVP9JUVczXcQJYiang==;5:s8s/c51sca9AXeyvK4Ag0vSSEA8c+yngscYhuIaM4Co37+Oe87Tz+KzakxIG5j3x+fTfo3XZ4jJPf466BroOAeLx9xNY6ORDsppXAzyEVOXRbSy4crRVAOgJzfP1NqCfnI8So4Vzpbn6xmp7Cn/T/4SUrixmu9TFbyPYee35Jos=;24:SoYKmTIUCYbahTpzQ7lHC/7PreeyJAxqe2J3AE4yYey4bLz8mCOiHMqBaapewmvoxiebh9Gdds/qLdfXEhHxzgCWFd6sw5YLeHywCxAtBv0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1663;7:Wg/LnQBu02B11Kjf2Jl5jcrE3E5rvpZ8VTAfWinAYwzLTSPNFERBF00vgWdlPfZ2n0fXizDSNYoCtHIVbO7vQjvyhWqEYFRs/b0mjqCurSPNyHEaycEMPo0n0Kjy8i03slHVByQNg9JiZFQKhJbTdKm6quo9oy7caegMReMghEdna95kHGg7GquGT877w7Pjum5trCaJ46V/UMKySUNKw8rzS7E0JjO38y90WbzfT9DKLVIVzl9AyvTFSxO42Owx
X-MS-Office365-Filtering-Correlation-Id: 0fe26878-6dfa-4f8a-bb1c-08d5b4b408c5
X-OriginatorOrg: aquantia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 07:19:25.7550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe26878-6dfa-4f8a-bb1c-08d5b4b408c5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 83e2e134-991c-4ede-8ced-34d47e38e6b1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1663
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On 08.05.2018 09:39, Christophe JAILLET wrote:
> The position of 2 labels should be swapped in order to release resources
> in the correct order and avoid leaks.
> 

>  	kfree(self->aq_hw);
>  err_ioremap:
>  	free_netdev(ndev);
> -err_pci_func:
> -	pci_release_regions(pdev);
>  err_ndev:
> +	pci_release_regions(pdev);
> +err_pci_func:
>  	pci_disable_device(pdev);
>  	return err;
>  }
> 

This was just submitted yesterday and is already accepted in netdev by David:

http://patchwork.ozlabs.org/patch/909746/

Thanks!

BR, Igor
