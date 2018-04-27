Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757632AbeD0IDv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 04:03:51 -0400
Received: from mail-bl2nam02on0075.outbound.protection.outlook.com ([104.47.38.75]:61808
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757538AbeD0IDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 04:03:45 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [PATCH 3/3] can: xilinx: fix xcan_start_xmit()'s return type
To: Marc Kleine-Budde <mkl@pengutronix.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
CC: Wolfgang Grandegger <wg@grandegger.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support"
        <linux-arm-kernel@lists.infradead.org>
References: <20180426211339.30821-1-luc.vanoostenryck@gmail.com>
 <20180426211339.30821-4-luc.vanoostenryck@gmail.com>
 <79ea4ab6-a12a-21ad-b586-6a1dad176c0a@xilinx.com>
 <02e9be66-1345-2af7-c343-9f94d71e1d10@pengutronix.de>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <2026db65-01e5-1cd3-0c11-144ae2ae3d97@xilinx.com>
Date: Fri, 27 Apr 2018 10:03:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <02e9be66-1345-2af7-c343-9f94d71e1d10@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(39380400002)(376002)(396003)(2980300002)(438002)(189003)(199004)(8936002)(39060400002)(6246003)(316002)(8676002)(2486003)(54906003)(23676004)(110136005)(106002)(186003)(426003)(76176011)(229853002)(446003)(11346002)(2616005)(36386004)(2906002)(86362001)(26005)(31686004)(478600001)(575784001)(81156014)(63266004)(58126008)(81166006)(356003)(50466002)(59450400001)(44832011)(53546011)(64126003)(31696002)(65826007)(126002)(476003)(486006)(77096007)(93886005)(36756003)(305945005)(5660300001)(230700001)(4326008)(336012)(9786002)(6666003)(106466001)(47776003)(65806001)(65956001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB1668;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT039;1:qqThlRTEsCIIojFAF1c3Z1yav6TREUQMiSlIRdjeJTBE3wlXUsqmfRsH312IdVA4ZofEXqQcnWk9ZaReS4nybpMiw0u/uAHxwYYV6ESISo+9XjqPWO5FOXtEBG7oDzxc
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BLUPR02MB1668;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB1668;3:zxQ/4rfyIAk5CEk93hSzMBw9wlFo9pOhKrYP9w3VXhTg/XnddwfMqKJHKif84EpsPVK3kmCiDmZo80IiQqgRtB/QQHgT6w0rfFpeLyA2xCV2g9YLrMmeJXtLx0QdyPrArK0rQAQrI7mERfkXL4vwrZyUsGC5VwDlgUH26quXIXCnWepWwsq6QvAOiMdyxlkV25xtZk/G+/R3PgWJz6lVJIdgqRWfkU4o6kiQhugQBmQXVzjyjA2l6S79ZFHl553VtK41IOSE3yckKUXUXoWHiwu/mUa0lDrkAnzU9WEOa8fMDXdXwtdqat3EJR8ezvVxmis4w2w8EmXv1Q4xXAW689YYygqVt8CKaV9oyCzibTo=;25:gevhD29ATfryqXFr0c7Qsbf3ftzAm4bxrmNoJCJ4PRKSmH/ZEOcwDISI7vP9zirnXe+StI2QDFeC8QlRhHAkZmLteQn+k8P34lya1BfcFg7qXMA1FgtI8lL1fKE7efg3aBbKjfg3/9NWtSOOOzaAyqUR0FQP4KjuWnF6dXmji38Lu7HbUhEYNANwq3+N+2FaExwDxh0NBlq5YsFFULPHvZ4gYqB83gN3YeGN4avSsB/D/cDefDbhz0PTjJlM2C735oFOPOsQwpgrSgw1RfQFtTMoVPyTT8Jcs6UAnelF90aEegeWrP8IRuxc3JzCe6uatnnJfMY4eiypLs1RoNWQng==
X-MS-TrafficTypeDiagnostic: BLUPR02MB1668:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB1668;31:uv2yJ1yMoE2oN87/Hn+ccxLuJq1TK4zXkjGffxVHzyf/rH7RSO30mLLRpGf1Ap1WusfujoOEuQZVOt6Iw7nXUKG18MhmCRGTHWf4CK/+z7MB3qetrpHwbnKUyYxgSxkS/VH7G1xRFOTp1GMTjeK2Em8VfUZxmKsh9ZUJuihrFvTXLp+Q2qPgKr3s/lbU0abKBPfNuBi2AwqIzVUZJLUh+gY9jV6eiCFGCnRmYVSh/G0=;20:CIIoJKPcY8/BTPUGmzTZcaoio8UbHQAhKBiylS3at2mT/pDxljmRM+MaDQKSML6eK4sOylAJy6YkcxAZ5QlZKH8sNePb6UhYn5apnTy3hzxqyx+dHVNC/fjX0nhf0nXTbgMznQHxiRB0v59xGJg4YBxXoW0sHnMzzoDpoGeXej466EFsa09w02DhPY/4gG/44ODf8sdQB0LdLZBfzzl/EixK5cPU+6gFfa76CzsF6N9h7DxZV1DjG/tjc+GK4BrfWzxazBMZPkQPN2eXCOIpIEpjf5n1IS4fHbtNHYJ9YUNgorPRQ7RvV6ktEi5weKqv+mtE0cziZhJ5en+QC1D0rSb2ecOSRa+AsOSoxNY7p6QvCTd0QGi86uq2Bl9y0Apn+zpxUqaiDEtFmY9v9LhvFswYt51Jwo5sOsk7htjIr1COdjgb0oZ+uYA3Z+yWuiVwtwhl/AtxwhaZuy+akJGabQDLrI00y6z6mYXjvCSzKBzEJEYr2bjHWRuN/Qgjw/Xc
X-Microsoft-Antispam-PRVS: <BLUPR02MB1668775AE95C7A58E4500C97E28D0@BLUPR02MB1668.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3231232)(944501410)(52105095)(3002001)(6055026)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BLUPR02MB1668;BCL:0;PCL:0;RULEID:;SRVR:BLUPR02MB1668;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB1668;4:okjOUShn+MLupZbMXdncEsKuLjoVHl3s/xiKspDau/kD6ngXVJ1sgOMh5JFeGjNs70/dQksdmSQuzpfzXsDM5p1ceEcsVOQBQhrvrMdQJlUJhoZ8ugk+nDuIWFbLrlmnnxcgNDxVoDZcnL5O4XMvxr4vJ45HxIoNHMsMX5zXo8exaqVyExwmsSAyUTEzdU6dy1drs231pk3YF5dpAwgQUx4uEnAXyhnj7w2SnEvWt4R8rNpvit/JxkqLVu/3LoLHrOmFBUc/gNG0tRf7r3dyT40G648sVZ+4utlSSxLablePcUbcTwDPfUHB8mLn8ENtGeSPXNuGicRFdTmh9hhSuziTCq2o0epKRo2nNWNYw0Y=
X-Forefront-PRVS: 0655F9F006
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjAyTUIxNjY4OzIzOm8zdkZpNHB3MFlLd1RWYkpEc1h0ZzJtSjMz?=
 =?utf-8?B?K0pYTjBOTzZqdEpjeHJSdGJHdy9ja0dpdDlnZ213TzZiRzB4SlQwYXBVVFJh?=
 =?utf-8?B?SSs4OTk1UWx5NzhyZXhUT1pya2g3blovVm9YTXBQNkx5YU9RNG1TMVBNK245?=
 =?utf-8?B?WkNJNTVHK2NJMmZ2WlRCVXRITWphNTJLeDJJcHJXQ0d0bm41OXUvSU5oNjZq?=
 =?utf-8?B?Tk1sT1lRaGw3UExRSVNSUFZwZzU0TzJLdWk5Z3lxMjdiRkFaa0J0RlgrbVFt?=
 =?utf-8?B?SW5vMmFBS2t1TXpxa3NKek9Ed0ZMdytPZHFBaDhPdFVHbndqTjh2M0lKQ3J1?=
 =?utf-8?B?czFyQWMxYXNnWWxYaFVrLzZHWjhkVFh0VmMxY1k1VmI1ZFNmRGM3ZHNjZG02?=
 =?utf-8?B?QkZuVkUwUXIzMXZvZ001UUJkWEN2Y2VNNDI1dVRlRk1QR2FJTVdCRUlBR0JV?=
 =?utf-8?B?b2JIbFk3eWUvK0diRXBpMzh0VHN5UDlOSkNUd2JlV2V5L21ISGF6eGVRcXJX?=
 =?utf-8?B?SnFzWHIwNFczRWN0MGVaK1VOUFJXTU0xcFMwbG54MEtyZnYyWGZRaVFqTnFW?=
 =?utf-8?B?TjZpM0IyWkFVTkRnd2N0Q24wNTJ2emhka1F4ZWY0NjJ2RVlsSXN1Q25Ma0lY?=
 =?utf-8?B?S3EybmgxczBETUpjaEJKeGJDQ3haMVZNK3A0MjE3cWlDYXFZUm1mYXoyVkN3?=
 =?utf-8?B?YzVxZlBmVjh0ZUluNFpyR1UzN0M3V05MZUxQWHJvMEFWc0puY3Y0ZEl0V1JS?=
 =?utf-8?B?VWJEWEw1OWhIWEdKLzZZWHU2VDVzN1RrNGtXR3pnQ3YzOVZMQkZoZzB5dFFu?=
 =?utf-8?B?YU83bFZsSDZrR1NvS1hJNlpWS25TWGFKcHV6d1VlNk1ZcTNBVVBGcnBwRlhi?=
 =?utf-8?B?MWdmYWNwbEpQYmltK3lySGZCZXVlL3lGM2JBRmFQWTRXOWptTHcvSFhtRHZR?=
 =?utf-8?B?SWJsOFFLanh1c245WjJBeFh5NldqbzdBWVV0Rld1cHNreW5Kb1ltNTcxZm9u?=
 =?utf-8?B?ejlnSjI0OGhmK1pWc29XZ1VVTUtSU0lsSDI0QWNCU200b3Z6SGlnd1BQNG9K?=
 =?utf-8?B?eFphR09URlJYbGVNVkVjSWVTSjIySVV4blh1bFhDMWJieHF2Mmc5dDEwalo1?=
 =?utf-8?B?UE44ZU4yY2ExZ2VOZG1wV3lHTUdHbDQraUUzeS9vRUxJNnRiZXRkOWZ0T3hG?=
 =?utf-8?B?TUR4RlVhTjJHbEJ1aTMzdjJMZjBvODZHYlBBL1MrNnV6UlZtQWNZYkR3MTdV?=
 =?utf-8?B?NHRhaVFtUVdlUUpNa1dYd25GUUVmcGJadldVSDVPM25BK093aHBQcmZoeTd6?=
 =?utf-8?B?Z0g0MTJtS21NMTFlTmxDU0c3MXpwbU9KTmgvZ2JERnlQMy9XUVlIc3plb080?=
 =?utf-8?B?c0x5bFNUR0hlSHpxZ2N2T1FoWnNpZWVMNmF5SU8xdm1CL3Y2WG42OGkyV2w1?=
 =?utf-8?B?ekhFLzlvUVJBSkhiUWZFMThia1NKU2N4ODI2ODRYdVVlNTZ1b0xFUk84OWFQ?=
 =?utf-8?B?Q21FUlh2Z2lYTnpuN2RITkNJeDRrK0NvMEdMYVVYOXRPNEQvSDg3MzNqaTlF?=
 =?utf-8?B?dnhqT0xBQStnWDY5SmtpL0FtazluUzZnWm9ZaXdtQ1hVS2IxcTBYRU54WWI5?=
 =?utf-8?B?Z0RFMS9kWi9EdzAzVllTVzdlNWg4UTFBTmZjcVIzTCt6OG9iYitZeW1wOCtx?=
 =?utf-8?B?MEE3Y3ZpTEJyWXo1OWdwa0FFMGM5Z3NPbS9aOEJJSmxUQXd1MTZHMjNRUHhL?=
 =?utf-8?B?dTR3Z1BRcjZXeGl5WitTdGtwandwRndERlhwU284RlV2M1QzRTl2eUJpazVz?=
 =?utf-8?B?ZWl3aXhIa0g2UisvUWxqRFk1T3hUZ1JYRUN5NjhrR0tyazFkOE1uWGxaTjJx?=
 =?utf-8?Q?a5hi2jwyE1sWK9booF/KBDp5ZavfLVJj?=
X-Microsoft-Antispam-Message-Info: DmIG4gO5W9GHWXQHJ0FCdZw1BTXE5mUuLpr1dF05XvmxN8ba7mHgMQf2w5jT/Qj7TBC7VzoPo3kJ3HHF0G7sjNeViO/qy9Bm5STT8k9hLu7r/3CFJs2K1Hg6hPasJnBQ9rbhOWg+HVvUi7xACyi5J8phBCaXIhLx+tptuERDQnRHzM+AUo6KksRMdT4k12Rr
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB1668;6:0bFI9t3zPQAla0Zn9pQ7uiyzUVDhFGb3WJmpCJcflpZQ8j+GypSuNPl73orBXuRVics1nhnhffSnXoHUc2yxxZUz1J4IlFtPeTlucqf3ktyejjeHiidPpxMrtus5FJUDEVlLuMn45GuNKF65bzgZChfWhXhYhHjaUgUyA/b6KXnSjgOCvYnhPtVSLVvWWVmLLJfHpeUiwpAkQCVfNdVv2rRIUdJkG5bptPeygEuVZZv2O6fpKCtmYzIJIxojTPVf2T13vosZccqDpJIXjIGPIsvHONT+2h1wrDBCsKGSLQGNCfYFqP74OLEtk4Ps3BdFFA0aphzK6tb5mQOx/4Reu9eqOnEWa25vjtME5sIAr/uVJTsnAmO+KvkxppZ7hoPcdGOoLjm4e8Ts17YIQWkiqHIojyVkuJLEdHbMpsMxttDNttxG+yYoybCOMN34d79296FBFpkUvoCI8+FIOch4XQ==;5:8kDiWaqU6lkgKAmJR39wX9X9XRWg5gbEZUBjub/q/2r28TeGAJ9HTINSQPw0IOoAoKzKdMa3nulJXzw9zdOGyKnkj1HlapE7K6sJzFRWelfHPBJsySVo4a9BoNl9wNDUmJvh/D9MwYeUhdX1NUjhG5MvSBeSi1uilxEjd7IF5/Y=;24:Ptl9BcLKrgnC89TikodmYzF+zFClCcEDe9nIzsILM7B4k/KzSi6/PmRuYUeQJzGHpnTznWF/tf03anqdzFsDVYZENxuPgreAvTtpSS4l3S4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR02MB1668;7:DD4zjZVp6dJVQCxGY5FgIzsLwPDzJGK4E9uGoW4/IEScP2ghkQJfNz34AX0W8e4tfwbeXmNvTMh17G8fjgl94T1b9fyW2YUEHmSgTBwpHO7bdSrIi/fycXb+1sU6sGmemNJfNjJam+HdPb9bw8vQaOCdFAe3wM3V+ddPkmsjTO3Z44cyjaEHKx06OyjZUnrTjYMDkT1HtSZvqBLAwEiYLZjHOo3NEK6lTHDkyZpfTGaNnQ3uJn2Gl4biHIHYqLe7
X-MS-Office365-Filtering-Correlation-Id: dd90e723-aba6-481d-37f4-08d5ac155881
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 08:03:21.9291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd90e723-aba6-481d-37f4-08d5ac155881
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB1668
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.4.2018 09:55, Marc Kleine-Budde wrote:
> On 04/27/2018 09:49 AM, Michal Simek wrote:
>> On 26.4.2018 23:13, Luc Van Oostenryck wrote:
>>> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
>>> which is a typedef for an enum type, but the implementation in this
>>> driver returns an 'int'.
>>>
>>> Fix this by returning 'netdev_tx_t' in this driver too.
>>>
>>> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>>> ---
>>>  drivers/net/can/xilinx_can.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
>>> index 89aec07c2..a19648606 100644
>>> --- a/drivers/net/can/xilinx_can.c
>>> +++ b/drivers/net/can/xilinx_can.c
>>> @@ -386,7 +386,7 @@ static int xcan_do_set_mode(struct net_device *ndev, enum can_mode mode)
>>>   *
>>>   * Return: 0 on success and failure value on error
>>>   */
>>> -static int xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>> +static netdev_tx_t xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>>  {
>>>  	struct xcan_priv *priv = netdev_priv(ndev);
>>>  	struct net_device_stats *stats = &ndev->stats;
>>>
>>
>> It was applied already but there should be also kernel-doc update too to
>> use enum values instead of 0.
> 
> Like this:
> 
>> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
>> index f07ce4945356..d0ad1473f689 100644
>> --- a/drivers/net/can/xilinx_can.c
>> +++ b/drivers/net/can/xilinx_can.c
>> @@ -398,7 +398,7 @@ static int xcan_do_set_mode(struct net_device *ndev, enum can_mode mode)
>>   * function uses the next available free txbuff and populates their fields to
>>   * start the transmission.
>>   *
>> - * Return: 0 on success and failure value on error
>> + * Return: NETDEV_TX_OK on success and NETDEV_TX_BUSY when the tx queue is full
>>   */
>>  static netdev_tx_t xcan_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>>  {
> 
> I can squash in that change.

looks good to me.
Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
