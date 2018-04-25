Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbeDYHLA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:11:00 -0400
Received: from mail-sn1nam01on0042.outbound.protection.outlook.com ([104.47.32.42]:25323
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750929AbeDYHK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:10:56 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [PATCH] can: xilinx: fix xcan_start_xmit()'s return type
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC: Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Michal Simek <michal.simek@xilinx.com>, <linux-can@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20180424131614.3357-1-luc.vanoostenryck@gmail.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <e55172a7-5003-e534-87ce-672291940114@xilinx.com>
Date: Wed, 25 Apr 2018 09:10:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424131614.3357-1-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39860400002)(39380400002)(2980300002)(438002)(199004)(189003)(110136005)(64126003)(81156014)(229853002)(2616005)(8936002)(8676002)(59450400001)(356003)(54906003)(5660300001)(58126008)(316002)(53546011)(2486003)(230700001)(31686004)(77096007)(446003)(76176011)(63266004)(65806001)(26005)(81166006)(476003)(4326008)(6246003)(23676004)(65826007)(106002)(36386004)(36756003)(186003)(50466002)(39060400002)(86362001)(106466001)(426003)(11346002)(9786002)(486006)(31696002)(44832011)(126002)(305945005)(47776003)(65956001)(336012)(2906002)(478600001)(107986001)(2101003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0201MB0681;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT007;1:GLaiDCmImxXgFT/ri0+Dylg5AXBbN2zjlyK/kYkcHGEDDcghjw3eqe4Bew6vYl/+f0E+LMIlww6UnNSY6ZQzsMM/+WKkpPgOQ7rza4AQ6XTx3UDSXaO55aa7cYRPKGBh
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY1PR0201MB0681;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB0681;3:cHyYmlgv6+CJGc9dUB3upcEKL93eL13Nq5zRxThObS08Aw9ODbOEdHdbHA4F6JkA/dyX9ZFHZkcpFNDVnnV+Z9uRUYUlViSgqDBpzbNb4A0vhh1a1Xj3tJ61HmNnZsSo2bpsrjRwXq2xFLje1mPoDhvnCMhhYrAXnnIPyYID9qYtBwRF62QDbFbrjjnDHLp+FVpPD66fqCmGyxp/KhZYnHtw0zWT27EAXT26jcrZ21UAxqAP9RAsM3hQEFKFJuHfju6hgncQEVHKh7jE2N2UBqKaVMEY2KvAHy1MOWZn6aoYVmM0SNaYKUuv0bMhRJRc6V0/kQXHerF4Z0Oj7/RMzpYRy5mVoinX4lVn/m4zqFA=;25:AB7Yjm2DFLgxgSUlCLyKsWsliqCPdFYy6vIdVhzxX7Gik/x5/AAmbAuBsqbRvzI0L1D45eZCp2NRjQjDB/dn+v32PiL5RLr3fGJeXQMAJQ3eNy3E1dVENYs3LT0AFcksvzK6uJssvINh+RkCyVHEqAaTucTdozykXpxcSwuRS2XY0gmlg5+0tVDVirTdjazQ8782w2RGJL7/IjY/xQDNGBtwRvftqAuTWAD/7/UNG7OeJDbBzIBPSZyc5g/hELHpqzsdNLmGFKbdV0B/i+DZP8Myjb38npQ+F3K1PajdmwnKzh1bSRgo3uyxiMui1rLiOYy9rgoFCN27p2abXuc6Wg==
X-MS-TrafficTypeDiagnostic: CY1PR0201MB0681:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB0681;31:UD14/fpLmWsk6gCMY9k2UxtgRWXbhOIYAf95KCziBaLu8xQZAw3ssZa6NdTbCyrdAPi/nOkHUkCtCYDuTqVkILNKv0Zu/lVXlnr/OJtRwUuSFUVu5RlMI2vsjTg/W7Xc1PXlskErkkIWf3KOLMM6xJu7ASt+7MHbwsyjJK1wa8qhPEJf6QYPOAzGAh63wN0fyWcDva2pyGQg8L8bd/X0ouYQulEcgRxq3G096YhowuA=;20:zwWfvutywmlDke4j5BiL/RMgMj4e/f5kpXJ+VmTI4zhNJhMhRyA0p9i0WMoVjIJIYCIlIfpcvvZLDBSeAF6VbP2dXUKZmams7i5JUGNj+g41mIJWIneXVESh1wflTPGas5LfafYHtksNyA4jX9Z6/o24VDTbpLDahPsALLUHDnLP7c0EWvNUK9RmLXlPEbc1hHNPR+vKe6RDIwuxgKu5MP3vnFu0/aLBbWHV+66rgPUxZzjPbjX1vLjZg3ybRrCRxVD0ImuWDHHKskYoYtBnTEbmBTHIOe0KxiPJ4XwlIeJy8Wd+mVYwKipzzWMz19goKeHuseHxD12XVxYLxLX5KTwBKKKptl79OW2t3KkQHvxqORt1ptyYTZy10vT+tGM/DEo7KN/xNbPalpMNbeQUz/eBSHs3eDf0KKJIAm2w+d4AhnhWc8XJWKUUO56rTjkWjj+4EedrGy0CiDhUs3cFPH6rdJB1p6L8advKiivoA5OaqCtEraHXbCMWFI6RXx+t
X-Microsoft-Antispam-PRVS: <CY1PR0201MB06815905D7467A0163BA1358E28F0@CY1PR0201MB0681.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(944501410)(52105095)(93006095)(93004095)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:CY1PR0201MB0681;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0201MB0681;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB0681;4:O1pDbJ5XE1bktzzGcZbrOhz8o/LtQQrOUHKUldmLkS1FGqEKzgRkPhG31ce532UcuZO7YW2/DW3w797cdN2cUJFpyGKyLDA2mAGq4RkPwL37ilObU+9+gorxtjLr2vH7GK4tNVrxvX0GDEMy4+XaB1FsE+ViVuKY9POAaXfhABbib+11YVgXJ6mm9Z9CkoeJmH39ERt2pbZaVii/lcVR2nPCpBLpzB6JpIGeqVRi+D9DgA/w17ORZYZisUv3aRMADyqqcovXIwP03j6Tk02sLcRHhGiaKzIVFKJqnsAMNLQSididHrkmPOfMjXiLFlKf
X-Forefront-PRVS: 06530126A4
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjAyMDFNQjA2ODE7MjM6YlpVako1ckV2VU1zOHROKy8rdUloUFRa?=
 =?utf-8?B?RjhSQkROdTRKSFZhbWcyNWt0TGs4NmJMdFVCazc5eGVhTWtFdm42UXlKRmVy?=
 =?utf-8?B?YVp5ckZuSlNqaWtxS2VIN1cvVzBsRitXMHhzWGNjYlY4YXpqS2llQ2NybVlF?=
 =?utf-8?B?enFpRlNvT012aGNrMlRqK3NKMDVyVkx0Z0o1WjBoQ0o5Uk52bDZhZHdqNU9p?=
 =?utf-8?B?cHlRRnpKSXFSb2RBMzV3K3oxREx1UXcvVUVYZklvRVcranRtUDVYK1FoYmhn?=
 =?utf-8?B?d2U0SUl1TFZNWXJuRUxwSWVHNi9zWHlIRHFZdlk0Rnh1UXh2cnU0d0ZVaUJS?=
 =?utf-8?B?OXdHQ2tRMjlDSDRGYnlZZVBXOUVGV3k1OE4zOXRsZ2JkM2t1MS8rRVNsRGY5?=
 =?utf-8?B?WFFQNHZiRWowbEc1Tmh5bndvTjU1RlVtaTdBbWFTVVp2Ulo5d3JabHI4cDZO?=
 =?utf-8?B?anVhZTJyQVc5dHk0N0Q3cVFjVlJqazNGTGtZSGdUclFDRGdIREhKL3BvbW1i?=
 =?utf-8?B?Vy80Zk95bEFJYkdlYTNWd2g0QTh0RTEyZ2lCYkZaVmE1NnRoZkg3UmlxRXdt?=
 =?utf-8?B?RHB5L0w3TjUwRHBsMkdtdWpBR2hnRnR3akxnU3g3UUViY2ZvQXJHd09sZi8y?=
 =?utf-8?B?SzFmNkZEK0JlMkRGOEtpMFFabUZ0ekZ4aDdqU1kvVWwyeG82WnpEZTc3RHp6?=
 =?utf-8?B?M2M5MzAvOVVFOTFLOEJRMGVuTXFoa0ptTWdWYThUSFlqUHFSUkhqYTVjWEJ2?=
 =?utf-8?B?RkJwUGpYYmpwNm5EaTJMYzFLN2xmeHh0WENHK0Z5LzBsNTNXSzBNS2pteWtM?=
 =?utf-8?B?MVBVbkdZeFhKVzBsWittbng1M3p3RitldWlpNlNWNnZoSitIRlFhSUlGYkpW?=
 =?utf-8?B?Q1B0SHJTV3BMUE9pSjJhRmIxTFQ2QzQ2M2FUcnBHZzVVOW1sdCszSzJCVWxm?=
 =?utf-8?B?SjljWlJiUFM4enU4aDZLbm1icW9HeGhRa1A3eDJBcUljaU0zSzJOSFRxQVp6?=
 =?utf-8?B?ak1Bc01sOGJqUnV5UjJzR3ZmVjlmU2tuSmpjb1NBVk5qMGZMd0tXUFBMRWlj?=
 =?utf-8?B?bmRJSHFMWjhwemJML3V1L1J0R1l3UEVGYXV0RjRTTm5pZnRNek9GWVJYQ2Zj?=
 =?utf-8?B?UW9TVFVWM0tRSUdsT05ndURDWDNkSmtiQk1yMGNZS0VTM1pHeHFZTWhPQXpN?=
 =?utf-8?B?RUQ0YVljc2dpenlZRWk1aG9IbklrRTI4L2lBVkhhQzFIbXM0bVZVZG1NK0px?=
 =?utf-8?B?cUVvK0UxMmN3VHFMdmxSaVhFK2kzUjJWaVhUWi82Uk9EZzJpUFgrdFJUSTlY?=
 =?utf-8?B?SWpWRlZwTlNrTkxjMlhRV2tWNE81QzFmY3lNSHl6WmdsME5scGFaRTIvTG94?=
 =?utf-8?B?emVBV3dFZlFidC9zbTZqTUxnaHRibFlWM05XWW5NYmtNUFNZNlVFcDZ1eHJz?=
 =?utf-8?B?NklNdW44YXREM0hQalVZbFhvK3BoOThFOUdDY2ovTXBZK09YZFJLRFFOYy9w?=
 =?utf-8?B?U091T0xNbHE2ODFyWEpYTi9XZ1NTK2dpSWZzL1ZUUjlKUzZRTGRNNHZtY2ZC?=
 =?utf-8?B?cURaVVkwdERIbzAyQWk3eEhwSEllNzZaTjFIUnFwMTdQUTVkNmdJSkRXd1JN?=
 =?utf-8?B?NFNHRExSdFE3QkxoMFhwbDREaUxNdzZJeDhVWUc3dUdneFp5TlRMdTU1M25p?=
 =?utf-8?B?V3Q4SjBIc21BRmZFdWFBRlA1dmZPN201MlFFYjNDMnBFekZSRFI1dWpwMjBn?=
 =?utf-8?B?WStIY0hQQ1UyclgzMUUwWnZ2YWVyS2ZtbWw1LzlpdGV5djYwaVdPTlZlUjZW?=
 =?utf-8?B?YTJ5RmpBM1NPMElDWnFwbWZrL25nL3lrMUU1VElxZld1SzlzUkx3QVV1RXZV?=
 =?utf-8?Q?1NrnRXOyKKhuys6OED5B8xsOqI7zEXcsiN?=
X-Microsoft-Antispam-Message-Info: 5LXMjlzZK46FvSEEg8q6dgCE59RxCtxTowAPjGXIf2BrDMEqdiNCbZ31tK4AjieMmzgrshyXz4FUzPvt8w1VV2pfB+1dRFSl3TxOAlDj47dFm3e+sKaJRAUy/aSRWIzSGC3hfVgWMFxcdh0rLTel4d2dEgWgAb0Yg3JJ1TNPDAiBcYxM4ziEJizaVANr17o9
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB0681;6:214EQ4BjSeRpECjJsXJGjAYt3rNpGq6ywwp38cyQt+cnyYL7/WnMfX5jzrbpaHEBZ5IjkY0ILHNj5SnyJpeK0vo7uO6SLJX42CWIM7uilrdSrNC8hGTD6dA0EbldA1axufNL1bOrjemTtmcF5fC2mL1rPSq5CjnnXVv7ehh821BiU7a+YMrCCs1Sj7b+mQZRJQSYjACCYza0Suaa0iz0M1RLyd+4EB2kvkmjkEQ4qNu8W7ZCBYL4D9VqgaimRRvC0KGYbuCOjYpscDuRzAI50WbobWz8cBsR8BUWbiQp79Zhanl0ztmBOgjQEnfQ6JZxaSbayZ4yiMzffUwCndQJbRcIwDQrBhjzzzJMibzZCZcTi+D6Py20VycXTakTIvy0bOBbZ/E/qxl6E5PS7idsC1/XJ4CK/mXfQAVyHBkaae9Lq1r6Ddh/6D/tLyGY6oIJEpwZjBENm5eNwpLs1nnAAg==;5:2eAqJl7fvnuU2K0oFGL2auFUA1+zi0IXZrFq1W5ZCj3Y/sqgpynUfNSjQQXi9WoO9pWwB9+JCgq4KRGwFVrfjhmIs2xn3AGCAL8pCxSLeohD+zRcwSdzaHXq+UXq1ay7E3qTmTfIR7OUOEXH9HTldBB1OnBwyEUsv0DIjZGma04=;24:dHxMAeOAOtHavVhEDDISqHuDKidnPBD0tMfo5wbM2F8MMZh/0+cFoYK0S0MVftUCJ08CeVOJmL/RE5N4dp/loa3Vjvq6gydm5risqy3V1jM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB0681;7:YBqLosNN7RzHnjZ79O4u682z6mRn5R0pBB/nTC0hO8RF8SvpDOmNlFy+3e9MEmWe1Z4N8uiF8vwGIp5RPsy14Elk2Hm/VWxpPmSNKN4bmAa/gzSAgVNPCOpIAMNjd4+Io4TlQcUROUqzKZDXX4kws1JoYarRGCN2TqRN24LoLnl6x2njcATamxXKVPb0rMFy0Gym+ge9GjR5u6HL1/UKlODOQyxNX9P5aeiyHNmKqrmpfDBZ0zRUnrzYFhZAhPus
X-MS-Office365-Filtering-Correlation-Id: 1cf382eb-e73d-4821-712c-08d5aa7bae6c
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 07:10:52.4022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf382eb-e73d-4821-712c-08d5aa7bae6c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0201MB0681
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.4.2018 15:16, Luc Van Oostenryck wrote:
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

Can you please also align kernel-doc format above?
I see that the whole function is already returning proper enum values.

Thanks,
Michal
