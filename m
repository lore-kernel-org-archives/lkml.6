Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932278AbeD0HuD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 03:50:03 -0400
Received: from mail-sn1nam01on0081.outbound.protection.outlook.com ([104.47.32.81]:24096
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757444AbeD0HuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 03:50:01 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [PATCH 3/3] can: xilinx: fix xcan_start_xmit()'s return type
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC: Wolfgang Grandegger <wg@grandegger.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Michal Simek <michal.simek@xilinx.com>,
        "open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support"
        <linux-arm-kernel@lists.infradead.org>
References: <20180426211339.30821-1-luc.vanoostenryck@gmail.com>
 <20180426211339.30821-4-luc.vanoostenryck@gmail.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <79ea4ab6-a12a-21ad-b586-6a1dad176c0a@xilinx.com>
Date: Fri, 27 Apr 2018 09:49:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426211339.30821-4-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(39380400002)(376002)(2980300002)(438002)(199004)(189003)(230700001)(4326008)(336012)(58126008)(6666003)(54906003)(426003)(6246003)(110136005)(316002)(77096007)(478600001)(356003)(39060400002)(229853002)(36756003)(106002)(2906002)(9786002)(106466001)(31686004)(186003)(64126003)(63266004)(36386004)(50466002)(26005)(47776003)(5660300001)(44832011)(65956001)(65806001)(65826007)(476003)(86362001)(31696002)(11346002)(2616005)(446003)(486006)(126002)(8936002)(59450400001)(76176011)(53546011)(81166006)(81156014)(2486003)(23676004)(305945005)(8676002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN1PR0201MB0676;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT046;1:efbMhB0TPZNoge1rlDyu+hIu32sS5b/fI5YPQFjHHhvcl8tT4H3hE71ZawPvtgKa8coDia6GkPa94q79opjYzHoORjxBwprFS9bnkQELIhdR0Pbl8phy7Je+0sMgfBtl
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN1PR0201MB0676;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0201MB0676;3:bWmf4rzt6yfb/SlMbWJgrv2VyBAFcvjs2V0Itc447CEx931urdw7I0m54T1BaZU2KJvUvMGjlsDczVoso47pPG/4rUuy8vEJZ1zmADI2ZolNeAVpEs28UrnkJYyw4aY5+E6VFC5G4aFz2pU7Zq1/FHnAf4awBG7m/v35ZXTvLmJF3yqwg1QzEWn7UQVwxgeQ/iz3PiVM1zciJDhcYGvAodlMY2OmIKVoCmxXHEyFqDokt0qL0YgqxOztICcnGemAado6KSoF9imOgH3qwFk72CC6iopkiTKQA2NGeQhJ8hCVInORt9gryySU5qGfU/EqnexNbOF0/dWLL5nigzmQbpm4HWR41yIvAbJ8rqYHXJI=;25:09BHo/FVVC0mvgIiG08YtGSUcA+iFhr4fvr665/C/DM+ICL5xem0dHII3MrvL/ngJ32LDzUEIETvOLoTZagC+xpjD/IQ76+0eztkrBfRHcr+OyL2yk1a6tY6EUrDr6Cap71UBVuUpJ3L8m0H5qjK2ZnBhAIB+3R2v5GbX4PIgaulVALUyUI38J4Zd2tj1dvYIbmC+qCN5dNbha7YI6ln/a/1T2hU3uKohZ1vGc8purF8IF1zAH3J1ikgkZJtYIJxbIqQIjtGlYIgz7acr36GIu/cLP5UJW28SpYxlXa8zQ2dnLhTDZsNzYDYrRE0SmmjqhbLUdDnK5GMdBVgDV6Atg==
X-MS-TrafficTypeDiagnostic: BN1PR0201MB0676:
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0201MB0676;31:ecrY/rPgzLx964Wni15Sv7tDlvtQE6eaxq09luAODcErggWFXP2e6x0O2jtox9boe8cLkrnw0P68fO4IOLQ0pLDEnegv7WjCGGxaEYRD97OFveRD0yszJ2BvG71YdzPqTM97Ej+aILLE/tSOHtN0ruZd0uHfriYr4c9NHgWCfJ+2S/HPtshbyW3qUlRji2kTGXRjq6GH7cv6eLcP9hrK+TxHtWA9eH9B6ubcQeNfZ34=;20:RNF2YuKOtPziUNEJTY9iWo1triL3zw+LtCRv/ad6W9PyEIKOVqfcKEir0Kb0c5mxrTOpIYX1XQTxsjhI0lKK7/kAdaameZdbFbqLG7xuf+v0Q6KhBomVHf8W2fvbdgtx4JFoIrhv/17CkF3012tQGb0CStkMCktPGkjmrKD5E+S0k1wWxgIYbS8U6w3qhuuwfZschSehnKTRRgqlnH496j5FJnUwu+KWty3XNTXBwiZVACnD4ujEnqS12LO17PWyucUHHjibo85m4ZxKsfzMxQvQaSJj6WQDc4rILoh7LeIdIB9+FfakSlMGecrcF2f4r5vuUaTu0/qmYFOodiNLJtp1NyWaSYuOAHFokl4e8Vvpe7miIXHIsqFlq2YZvcGjqvR3GXTyzbgwyjWt5oITt2cMTUJIVH1SsirvDalvKEQPTjx1TLEOR3kwaf6RSrhyFtqTwtSv6h2a5qFGbM01z1c8R4QYIUrbMNrPBQI6JJcYocjr8PfRlUh5bVFsozO7
X-Microsoft-Antispam-PRVS: <BN1PR0201MB06766764A6B813E4E5F8D69BE28D0@BN1PR0201MB0676.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3002001)(10201501046)(3231232)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:BN1PR0201MB0676;BCL:0;PCL:0;RULEID:;SRVR:BN1PR0201MB0676;
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0201MB0676;4:nuIJFZm0JuntPE/qhrEXQWEPvMqnNRc2VYfdVoTNlYJDj5uwNomfimhJM6ipMbxOpNF/r/6CgFgyc5MZ5z+i+ltnzo0T0ghfYQBHqH3O+411sRrwfJw/MFKxfZc9zMxS2ahkoan0Vgq8+JV0Jrf6CPsa3g37JRzWlMaWSsVvvoWduy4bPGD2UNQM4dpYHyd+y1QAc2kLf7FgSpPwWLXnktC9Awhxnu4giPKbN1llSdZpkudScnDxxtlOEYIq9JucGReEH/8TQs4fGEzoQgKcpfjkN958ELzhg5SZxZ7IZVWhUX1wTst1/LD7P51+Qe8f
X-Forefront-PRVS: 0655F9F006
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjFQUjAyMDFNQjA2NzY7MjM6bGNpanNxbGZheERUV1FFdENBTG90WFNF?=
 =?utf-8?B?ZlgxdG1uM1hjaERVSU80bTc2OTBRUTlsTmQxRmFoTTd0cDRJbG1HbHF3YmFw?=
 =?utf-8?B?VnMrZE0wS3pOUDQ1Sk9SVmRGU24vZ2F6NWZJaHZhYnFSZHUwV2h3VmU0cXE4?=
 =?utf-8?B?c1hmL2ZMOWlPbXVxZGlsd3ErWnRVNXVwZDJ3bXdTSHhmcFFVdzczcWFTQ214?=
 =?utf-8?B?SWoyeFl0TGRRN0UwOFdjdlZtNHFyQ0xCTEhBNVpSSzV3V0JNZnNqTmh0RWNL?=
 =?utf-8?B?bStQSDRKRWhjUmN4YzFHWTNZVFB5YjJjL3VEaVRNc0hFNTAwc2ROWG1yMHdu?=
 =?utf-8?B?TndOWFRWVk00UmMrYXdvTTJST2ZPV0Zoc3cxV0JFZFNyTnZaa3FBT1V1WGIy?=
 =?utf-8?B?Z0pCVENteHNRZTdOU0JNdDNPSmdxdkxxYXZmVWNRT3Yrd2NRK2g3azZEQUVG?=
 =?utf-8?B?QkFNblJ2eDU5YmowbDdlMHBkdUFOS0pYbkVOeW5JaHQvcmQxRlpUREpEdTRt?=
 =?utf-8?B?MVRtMWFpaThySGhYQW9udDF0ZkZtUUpwY1Y0TGNpRUxVSnQvVEEvd1BtUVdw?=
 =?utf-8?B?R1RCTW43WUFtQ0pZWk5saWU3dVlkTlo1K3R0R2VmaGVQdEltU04vSUVSQ1Zx?=
 =?utf-8?B?Rk1CSkY1cVZGbWlmMWpGU3NOeHFTUUlvYTFOZk53VGxRR2pLL203WFJVSU5C?=
 =?utf-8?B?Y25pNTcrMy9IQi9raStGMFdDUTNWaXpXUytuYkdoUTBsb0FFTmFaNVlIOGtI?=
 =?utf-8?B?cWtFQS91ZHM1b1ZhNHN5ZXhPVnpUZmdjVWRpQytaaTFMRDQ5bUE5NzZueXln?=
 =?utf-8?B?M3JwWVppNEpnZVVoMXpvbU1MZ1hFWEQvblpkTDRsTGk4TEFoalZKWUxVZFZv?=
 =?utf-8?B?MmExVU9uZDR2dG9tUXJFQ0xJemlYWmlINk0wODZEK3IvRGthWXNFeHZCeFIr?=
 =?utf-8?B?Y3kvbklIczg4OUZzUHoxQlZYcDQ2VEdxZGhKZTlhdVBabVRjSTB0U20vR29Q?=
 =?utf-8?B?YUNENDFvVE8yV1N5M01Gb0ptRzVIVjhmNnE5V3dWY3Jma3JnejFmZHkxUHpx?=
 =?utf-8?B?NHNBdnlJUWJyWXVMRVk0UXplc0RRQXM3RHB1d2VGSjI5Unk2R29xM2tJbktw?=
 =?utf-8?B?aGZSd2paUUFuZDBqOXZWZHJDYnJjcUxjd3Y0ekg3VG8rUm9ndDZ4Nnlvd1Bq?=
 =?utf-8?B?ekpOam5weXdNZ2NTcmNLbGo0MUhlUHQrc1dxd1VXMkpUS1BLazc2aE1iUW1m?=
 =?utf-8?B?MnBaQ3Q1eERMSStCT0dsNmhuR2JDL2hPRGJ6ZVV5eFNNRlBaMGxpaEk1TWJN?=
 =?utf-8?B?b0V5SXFEempBY3JURHQ4MEdvdCtVRTNPMXIrZ0NMZUVZSFBGdTlhSVdqbmN5?=
 =?utf-8?B?cmVKWXRBQTNGMW1ncTIxRFkzMURzQUh6OXlCRGZzV2MzVVhiYm42WExvekx3?=
 =?utf-8?B?bTg4dlJhZzFaU2hTelUrLy9QRWkvcGwxRDAxZDNOYllwcUNJYWFtRDVjYzho?=
 =?utf-8?B?ZW56SENxbnhBOC9OTDN4OWpzZTFQaVZINFBCelVHNkVIaHNldG5rZTZ2Rmh5?=
 =?utf-8?B?bGlsK282cUgvbldhM2dvdC9CdDFjc251RldKeFZkSXBDeXZiZXp1d2dreFQw?=
 =?utf-8?B?Y2dUaVB2NlJ0WHp2SzRWK21vblNUd1E3Zmw5UERBK1lUVzhKVTg3WUlPWmts?=
 =?utf-8?B?SzBuUGxJSSthdlJQM0h3cTF3aE9XODYvU3kxSGU4empRVExsQmhxbmRVc0ZZ?=
 =?utf-8?B?ZGFXNVZubVl1QytzZndmUUJydUxLNEFyYW1vZWN2aHh1djNwc3VGQ0pIUHUv?=
 =?utf-8?B?YjZ6UVY0OUFnbXhlYllpNWQzR3NEaXJiM0Q0cndleEZXWE1SOUUzMVZwbktV?=
 =?utf-8?Q?12CZdjIpKcSlMi/YWufywe/UiMo2FG9cI5?=
X-Microsoft-Antispam-Message-Info: zS1FNG/aRnZfBtTuCYeq/sNL3uNOGKOQQTWQSrso06zmzG6Tmv8THaiIgv964c/SNKPHTMCytCmNego8wcTizVbet38goC6rIageYVBuIXb8k8eHcRlt8qQ68d3/mII1dOMVmuTLxlD6w/LMC6vUwN6hJJSllCquSL35be0lQg+YUlelDTFbpek6xPVG/Es0
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0201MB0676;6:WE4sQVyiont3xqO1CDeoy3SYHh3WnhEbywM5gzBhH8QW7aWyrwTPPLAXEXNPclGfOLy3dbi3fXY07rGy0A9gMUj9JYUznLEgVHRXA7/VplKdWah9KO28VyOgLsKz0BmeGw0yhrnOk7p1MF24k1VskOOqQXDegCB082PYr7k6Ga3iffPKeOININ0I6tOaIjqZhHp/9+t8u9qNmpHXTYIk6V8sUEVL/RbTCV+UyDZRqghD8tCCumpNfQnWpIo9ALgIc369uIF46HYal8TlIDXS3QVvahaaDxW64CUpgeh6Cx51rB0dAon6Yhyc0j/MREVtkxGAiY0sNaAv+1efkLlOtLDYxuvn6XhzlvWJo4e1TcieHV/KDQAjLFMSK7VdM2TcgpOV7+a4tScF+rAUda5yHehUOTUaDEo8KLJ2ls76fC//82IzaXA8PeVd/EA0wDKMeS15q9NYmLXs/e8xzFn2bQ==;5:e26dtjCpSaCq74DMKyaNQ/gfcO79Fp+MK2yAy0/l9EpNRO3ph1MhDWMDceMbsswIfE57wbSrMYz5ZEcZURvXu367IMJkRlVDO0CsWx7C26VLnsBqGQqOVnAhN8lzLWaarxoamLgdqWRI7931o/3A6AnlaRqVKGbS982JbyEqI0c=;24:jgR2SU/zCSHm7FracTrkanRKhqLlDNWMzEYHgEiJ6HCkEKSSCfdlYSnmV8/lA3xmssaawaojcVkbLGsi8UYIZfjrv9mqdovmAwcePp3M/I4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN1PR0201MB0676;7:iTl8iPM5vrzn9ZmZYpjdiEkPz+7Q2nFreJdL/LFbDTKcOSsygachg5RrDTfvaariiZNArOz/wD+BlbdrhaX9U+DudE5Xvn0U+Csl3nZtsiejUUolF8CJQWr3457DVB8DBPoIxj1fP86e4IeTmgkXRtMmFxDEIVYmPp04xv4ExLtoLvgZtOuIZQee+DovxvMGzZTbrxklbKlhGFxbGND6FPC1aeTaFozf9LURMcBOZi2Tv8NOdJszLsz3c4pwhi2y
X-MS-Office365-Filtering-Correlation-Id: 0686ed9d-2c0a-469c-3ed0-08d5ac1378d5
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 07:49:56.9234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0686ed9d-2c0a-469c-3ed0-08d5ac1378d5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN1PR0201MB0676
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.4.2018 23:13, Luc Van Oostenryck wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
> 
> Fix this by returning 'netdev_tx_t' in this driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/net/can/xilinx_can.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
> index 89aec07c2..a19648606 100644
> --- a/drivers/net/can/xilinx_can.c
> +++ b/drivers/net/can/xilinx_can.c
> @@ -386,7 +386,7 @@ static int xcan_do_set_mode(struct net_device *ndev, enum can_mode mode)
>   *
>   * Return: 0 on success and failure value on error
>   */
> -static int xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
> +static netdev_tx_t xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  {
>  	struct xcan_priv *priv = netdev_priv(ndev);
>  	struct net_device_stats *stats = &ndev->stats;
> 

It was applied already but there should be also kernel-doc update too to
use enum values instead of 0.

M
