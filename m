Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeBEWfu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 17:35:50 -0500
Received: from mail-by2nam01on0078.outbound.protection.outlook.com ([104.47.34.78]:42836
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750796AbeBEWfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 17:35:41 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH 4/4] net: amd-xgbe: fix comparison to bitshift when
 dealing with a mask
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
        linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
        David Miller <davem@davemloft.net>
References: <20180205201002.23621-1-wsa+renesas@sang-engineering.com>
 <20180205201002.23621-5-wsa+renesas@sang-engineering.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <048aded0-9b5e-60f5-ec67-a00a4858ffac@amd.com>
Date: Mon, 5 Feb 2018 16:35:34 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180205201002.23621-5-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR18CA0047.namprd18.prod.outlook.com
 (2603:10b6:320:31::33) To CY4PR12MB1141.namprd12.prod.outlook.com
 (2603:10b6:903:36::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d059487b-ee52-44ab-4edc-08d56ce8c89b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR12MB1141;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;3:xyYB9l5sg8j8GtWdCI1SYeIMBm/TRLkYt7saeI6ViZQGCfOfbd9kwjQN/e4QyaS6x6vS/LorJ7w/PtHvgXzhP9eKncIemj99ihA6zltUMU7hyTNfFF+ozJTAEllhWBC0vLekHCr/fW88c/RavspOutchy31nR4aDm+ehyYQbEEj9jSAIXdIdtgEuCP7u3mFqPUgVl20XXVjdjs10+WGXBariXorXa+M3CTEJ5Hyg0SDefmFjkY5xOr1SVQzh5ZyH;25:sTPqkGGuuUMogT+80nNI0o/e2/ig02EzD4QF3ezy5E6T3IdRxVggC+6BnNWZWGDrhKopOEV962FC6a2of7VX0gnsiH+BhhSEoW6l5EhacbpRdRMV1lVZLbZE6zNM4/mAezTr+aY8SR27whvvjOUmb+A1yFutSYk9l0BCy2ANarTmGsUh1skvXnNY65Q/0D4DTAbKTRaNHiLAmsHo6kwfooaO7ciiQh3CRx3NuMT60PDAwJPaB7ACDfCfnF4dr6muOzmKaj9oQ5Cr1XPpVPpdQqx7UgPtV85zolpWJq+udrpvsEKGkkmpokCQssK1Y/0no49ZRi5xsKTnZ5JYdNrcmw==;31:GYQ8x4v7Bq5/Y9tE6ZMBsp2BVC8EJSgMKmBDYiP+5zU2dFeEeLETvJBXRy00fQwIfxDsyQ2GIVjwoIS6Y9JYtgksPuntbdbOGFpcAnHp/fj9JXuUSHuMynzOOISGdncXky2s3xFXqHuAmmaX/xKM+1VGwk9N7hS1efYrJ0hKtRCEXzdGN2YVJQR34SHIRfWgaYlBLtuCoEnEA17yPKXLVvcj7Sb3qeuuMxeKsgrlJGw=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1141:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:hOBgEcuK8qJHbNqFj/GciDbptBgmYHRCakBvxycaQ+8ElHdSlH5uswkvopJMIpJVsnrJ1VlcCzz7A1c+mn6kEznNF71S7509ewZ72+Efqak0g6VMWkGgYW9nFrSL2902cMPC+CGYoc4J96loR+5/qb7D6XYU0E5kLpC9IdXf3l1cTXy1WRNaM/FSYu+WfN+vAHh9G5ZLs8jCOdGuPTg+0srzzcQnk8Sh3Mh74PTjBzGeL5cHlvce3PYO1ziLf+8QpMzk7sbQ4jCSopA3vgXUm4sj2f5qZLyxqX1qG3r7+pyZIs/MS5n6rzQrb8i+PsHW/Q07tiFEuhRgpKSmm+R7We1lBg53Ob0b13hCuFurT7+s+TeNE8wFl61Bt8OMgbY1FlVz4cRRwIr5Gpw89NEZqUUPLvIwlDs3MYhZSulQHLP4qeMGFeS87FQ0y0DnJQux0at/4I3MMT8+9h/kDAhgFcWyhVk4gFZ3EzFLrOLFherzKtXeGbw/ubKFsF5RPQ79;4:E9J7vDSGPaox1iysTg1/ZzTpZZ2ed2HzUZ9+Ir4/jNpSsB4YyQdCA0LNcaMjTYj1v+JjyYA1ojTdQpQe4fwXIXZoofVsMbGy0ph2n1skhhxvxk0Xej3FQKBdxjZ8yETK5nBd1Grlrp+ZqywUdCodbuBawXbKg5cddvsafrwWXoKX6jS82BYMBSz4Jckxu0MLOx6FkFxOyDR/lpeb+iLaFpSdz0FT7+9G/ug0Gg7jcyUrML/orgjGqjDMyhnR70fq1bmT7QkSbRODFzWSwE5VO4hX+ohAKxvWKaC7Y8JIqNu4bpIj/amrKJ2lC+DfXmCU
X-Microsoft-Antispam-PRVS: <CY4PR12MB11418C80E31DB5BEAB93CD0AECFE0@CY4PR12MB1141.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(3231101)(2400082)(944501161)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR12MB1141;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1141;
X-Forefront-PRVS: 0574D4712B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(376002)(39860400002)(396003)(39380400002)(366004)(189003)(199004)(36756003)(6116002)(77096007)(31686004)(68736007)(106356001)(52146003)(23676004)(6666003)(2486003)(186003)(105586002)(83506002)(66066001)(65826007)(2950100002)(6246003)(5660300001)(65956001)(65806001)(305945005)(97736004)(47776003)(53936002)(16526019)(64126003)(3260700006)(386003)(59450400001)(53546011)(2906002)(52116002)(229853002)(25786009)(54906003)(16576012)(316002)(50466002)(58126008)(76176011)(86362001)(31696002)(478600001)(230700001)(6486002)(81156014)(72206003)(26005)(81166006)(8936002)(8676002)(4326008)(7736002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1141;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxMTQxOzIzOkhzcXppRlJ6QVpEWitNZnlpWFdDVTRzeURL?=
 =?utf-8?B?aXg2MEhwNE5rZnJFb0lNVWxRM1dJOUVDdGRLU2RSWnZ5N1dOSVpVYktJUTRZ?=
 =?utf-8?B?KzRMREJhTE1xVDQzRkZ4WUhCMjRFM1k4RGRIdUU1dkxrcG9naVQ1WkhiTEU4?=
 =?utf-8?B?YitXei9Bd2t5NUFqZVRZTlRxZmlCWGFuellKa2RXdmVmUjhIRFNYNmpxU0NR?=
 =?utf-8?B?ZTF2ejRZcGY3S29Hajd4YUJTK24vY1piN09pUDVXYXhwQVk2OU53dGhUcWRX?=
 =?utf-8?B?bUtYNXlsS3hNTlhmSDdKdm9jREg0Rnp5dDc5VDQzb3dtS2FxYndWOG9WaWtQ?=
 =?utf-8?B?RFIrbmJTc282bDhmeDF6djEwYW1Pc2h0K3pxQmdzRk9TbVVUODJXZmE1N083?=
 =?utf-8?B?eE9ZZEtXM0tRU3JUOWl0amR2ZEpERzhOdE5PY2Jhc0pBUG9XOG5EdEI3K3hB?=
 =?utf-8?B?UUFJWWNGT1BqbnhuelBiQlZzTzY3MHkvVXNkUWx1SXlDdTVWbndnK2NnMkV2?=
 =?utf-8?B?QlRnZEJYeENKOHdDb0ZlNVYwTEZOejRVc0lJdWhoRFJaNmdwQkVjMUQ1bDBs?=
 =?utf-8?B?UVZjMk94TVNRTzZyS3dHdXJ6UXVKWWtqejIxcHlBbEtlbGJEUDFJM284MU1Q?=
 =?utf-8?B?UGFjUjg0UldmMDgwQThvUjQvaTdIT0ZSYXV1N2NzdmM0cEF4Ymk1K0hxajJu?=
 =?utf-8?B?bXNvd01IcHd3NXUycnoxUDNDK2RpMFRIV0dJcVNFTzAzbUx4SWxVK0JKbzNN?=
 =?utf-8?B?NGplQ1d1Sk03OHZGaDJlcmp2R2N4OXl4b1dMZm03RmlleS83MkRzMDlMV2hK?=
 =?utf-8?B?TExFNHJmYmw2bHdwMUFOTkNaLytYaG5iRnRCQlFMVnRJTGRvVEhyLy82VEpz?=
 =?utf-8?B?dUk1cVY3V2RvY0dCM1lUT2RRdFhqSVgwLzk4ZmU0ZVMvY0JCK1laN3hid05I?=
 =?utf-8?B?cEw3eTBKSGZxbE5ZS2tVOFVHb0VoanFmRlJKeG1wR280M0tjWk5vV1lsbDlF?=
 =?utf-8?B?VGY0c3RHUkV2SXg0Zy9mSUNBL0FwM1QwdjVXWjNtOG14U3l4Mk9qMTdxemwv?=
 =?utf-8?B?RWllYXg2ZDdBaEhNSS8zbFI1ekwzWHB1WldDNE15NW8zM21MTU9jNjEvUUZh?=
 =?utf-8?B?dmdjSnVCSlhpNlJGQlRiSU42RHVsbU8zc3BOWEdNbDVnL1p6Q1VRTEduY3BE?=
 =?utf-8?B?TTFvK0hzRzFVN2Y4QkkxbTRkMjcvbGpoVGV1ZVZwSWhIWkxaTG5ibFQzRUFm?=
 =?utf-8?B?b0hYMWdEOGVCNXZ6WkRvajhURlFhYlRFbzJRWVNtajlzSWdIR2FBeTYzbm9F?=
 =?utf-8?B?TldqMHErVDhJRGorWktZRFFTQlJWK2JjMlR6TEVHMGEzVlJ6UkhWb2xEWGNy?=
 =?utf-8?B?ZjBFUlJiRjZXemZLL3RZeldYb1dqdTU1cmZkQWEwRnJQa1Bhd1FtSmlidWFt?=
 =?utf-8?B?K3ZOMGEvUjVwbWp3eXprKzhRUnovTjV3OE1xNm5SSGJCOXNnaTNMT0dma0JX?=
 =?utf-8?B?Q05zRVZxSVhTUVFUWDB2Z2xjRi9WT3AwaENzOEtrSEorQnQvbXdQZ2NtU296?=
 =?utf-8?B?NS90d2oyZlpEQmt5UFh1RktKV2RLZFJRaitkQngvVGcrM2ZqeGQrcHh0NnRv?=
 =?utf-8?B?cXgvNlN4OVkyK0c1THJkY2N1VGlMd0JsaVJtdHJiWm9KMTMvUmZRMFo2dGRW?=
 =?utf-8?B?eGtTWWpqZitLdFhPNldSSVYxbTd4SjFIWVhxcStLY0NpLzhreXNuNWIyTGpT?=
 =?utf-8?B?amU4eXYxVjNLRFA2bTMzdHQ3OC9UOTA2SCtMaThJVlhna3Z5MlExdVJoU3l2?=
 =?utf-8?B?Sjd3QzlWZ2lmeE15VDVHRnM1SU95T1dKdVF2UndXeHlncHVRSHdNbDJ6V2J0?=
 =?utf-8?B?U0cxeE9XOU12dytvN0pyR041RC9tazkyUVpIdE42SVhWbEpIR1JZRysySW53?=
 =?utf-8?B?U3lwbTRoelBRPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;6:4VOJ5qkCa43rPKK8MjG7T3BurpLD9RrESkThPPk91L0k0oP3l/9P8fcRZMT1vfR3lY/SSG23nddcn1vS4jgfNWML536+ZadbzvFBGWvoQUwdqWJq24/9ZI1QmP2dpQ+N7fgbV4WYgL7fWU+f9PhuBI8R0186pvN2RHvOOqo5qT38WOlx4i0rYTnp8TcjM6QrDGPhuSX8Q1zC1WVUdFS1/P2h9kMOmAk6+0QkqzEc+mSiU3KRujVe0FB0PTx1DkVYvrGpWLA0HmfrsrLjzufnzRVHc5mzpGIVMPBbWh9bgXIHaHC+rbGNHrKWCeyBEv/2LVkf98ScuzRXp5BoAwyRJ3VSU6GUjSQy4yXcBOIGGos=;5:5EerjvZGUao4HupXK+dhDSpXUXRLfepNKHqAHR5AvRth0YsGvwJyffsQ3CNPpwJnAEppARXVqy1NhzKtAIH0SZdI8A9I7O/K8qc32+S/jlWkjQh7IkVKrOtsx4wcPVK2wh6bZq30vDQ4J8a1kELINnLoYfXkD0UbY5fEUvE+eg4=;24:YsXRREvbXPhUzdRrHHokCmb49F65gdZr4VKImyY+//V4OVMKnEJcGB3Huaf4Aw/dAnQ/6LpX4hTcuXJEzxeZ75gh5H4069HMeZb1CHG1kR8=;7:YmGQt9BdcU+vqIItoP+GHBjdpVZqff0aq+vNKlkndemx6fDMt5VUemkdKJXVMxnNSRaeYjvTtbf09xI5BS5NRdQGJEig/aCf/ZyMUrfzaF/x4B7F+X231sBtPYE3oC9qOwtAbvDSSOudLZuIC6XZMXmqaVclS86e2JIJewyiIwcKGcNzOUHaaZKN5w9QBuLFTX/o+xRimzbugHHRi7miJqHYyXdTHumWPQtikk1LF3an6zLJzZN8NZHpEgXpCycw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1141;20:lKzfjM22DXPs6Wp/MHwvDDyNckgHJl2lGru8O4ItCjMKTfx2h56Cqn8xAJQqoQxToxVFLy+nxQePzW1G6Xa+9tvBE8k7MaazhvBfiSedd20BM8b8N3wVRAJ25dGCPh/zUnaBJ3bkRBHBNYbwG1lNV7o14NMzhMF1WHeiDnmvJM/Hmz5/lWKAnBgSp1I8v/QmUHFRLQSg503XFICOI1ZNuVYTpV6b6DnQh6Zi2mKXr70J1jCkjAlOW7XkIrk75jAw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2018 22:35:38.9127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d059487b-ee52-44ab-4edc-08d56ce8c89b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/2018 2:10 PM, Wolfram Sang wrote:
> Due to a typo, the mask was destroyed by a comparison instead of a bit
> shift.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Excellent find.

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

David, this should also be applied to the 4.14 and 4.15 stable releases.

Thanks,
Tom

> ---
> Only build tested. To be applied individually per subsystem.
> 
>  drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> index 7a3ebfd236f5eb..100adee778dfd6 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> @@ -595,7 +595,7 @@ static void xgbe_isr_task(unsigned long data)
>  
>  		reissue_mask = 1 << 0;
>  		if (!pdata->per_channel_irq)
> -			reissue_mask |= 0xffff < 4;
> +			reissue_mask |= 0xffff << 4;
>  
>  		XP_IOWRITE(pdata, XP_INT_REISSUE_EN, reissue_mask);
>  	}
> 
