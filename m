Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753773AbeDJNDJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:03:09 -0400
Received: from mail-cys01nam02on0042.outbound.protection.outlook.com ([104.47.37.42]:2462
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752752AbeDJNDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:03:07 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [RFC PATCH] sdhci: arasan: Add runtime PM support
To: Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>, <naranimanish@gmail.com>,
        <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Manish Narani <mnarani@xilinx.com>
References: <1522302530-27550-1-git-send-email-naranimanish@gmail.com>
 <29f0aae5-3cee-8a37-f5aa-3830f466a759@intel.com>
 <b02c6970-f4f5-53af-2834-710ff3b7cbaa@xilinx.com>
 <c8a29949-c220-1319-02f4-c5b0b9601dc8@intel.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <98f0c8c1-3f85-8775-f6cd-9097fb254446@xilinx.com>
Date: Tue, 10 Apr 2018 15:02:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c8a29949-c220-1319-02f4-c5b0b9601dc8@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(396003)(39860400002)(346002)(376002)(2970300002)(438002)(3190300001)(189003)(199004)(36386004)(6246003)(50466002)(39060400002)(107886003)(36756003)(4326008)(31696002)(106466001)(31686004)(63266004)(65826007)(5660300001)(305945005)(6666003)(64126003)(47776003)(65806001)(65956001)(229853002)(478600001)(76176011)(106002)(230700001)(8676002)(2486003)(9786002)(23676004)(486006)(356003)(186003)(446003)(336012)(2906002)(2616005)(476003)(426003)(81166006)(81156014)(59450400001)(126002)(53546011)(2201001)(26005)(93886005)(8936002)(11346002)(110136005)(58126008)(316002)(86362001)(77096007)(107986001)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR02MB1404;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:3;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT043;1:cPB4WugHbaLWf4VVAqiaFM9XNxWXTRqnGdoiLVuVC+ELrUa8qeEYD9I5QEJTaWM2qpeeajDl4J9O2C/3DzazeFWNltK944IXq72q7uHtbQ5p9n3prpmphslRVh/SNlZ1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3e1b951-fb66-4d62-ee36-08d59ee362a9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM2PR02MB1404;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB1404;3:NNjo++T+R+FQ6LpwWF8aXicAWwmHIIZBGt23zkembcjiAhFzIrZDh7NWmTjx9OELg0p/WShrMJZlAWaCQS6O9kEOCCOrkRDLxFmMcYHtp8yM3jdUjOKKz5c/SxRovr6qZ2Hu+gn6StvHQiIKNByX/MpA3YRLvYUFD0BKjH4/pv4l0AEn0GLADlZ/FBEfwAhZOdxlYSKH5IkxLMisqCn5ztY2trZmzCadMXUgm2ebbM05LoNvtewcPAzyZ4vPFQJlVsYmHqmeAN6KjtuyaF/2C954Bj8q3WOsZPYDcDm1Rk5vKcNSLBprt9Z38vHLmFhZrgjlHfltxKgknOCQM6mNtYiSDvqGKo68WqMDOa5fY+w=;25:8dOJoPqA640lsgupiCRAiA6ENGs1SGhiD//B6HpCLVLS44NSXfBoHrd2r3L2LcHr/8gsVGqjEut/kv3dAEOzqENABcrPDC82ixd6JIKHbeTvDsLnlfXBIHkzFRdylUREBBOMNat7xt/g2odDIHYVIBPo/ycz3PoiU/8pZwQpjB+4PqwrurqNh985xRhhJ5w2ImEh/4sBFn9pTXIi5Y9ZIRZ8mThBluCH5h84oMDerrLe8frg3nGH6LWQ7/gMDMk0n8tUkmPjPbAU6WKPyyWPCNDVgy2OxIG9fVFyxZdv8KYABK87Djsm01RPd2ifBsWsXeaFFWdp5nQHkIxAG0CyuA==
X-MS-TrafficTypeDiagnostic: DM2PR02MB1404:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB1404;31:GzIKsN8B1UcThC8vE9Vq5tCBYg6MzTnNVoibKPAoiK1jK3GGqeyq7WenS+VC8Bu1klZQlsgOlF53y+AA8jDHVXp/qTjtaWyt731qThoimB/LOeMNSm1/e9Lalya9FnhsvS+DmWQPMyWEItQkZEYrItWG371AG1YCWo4+2PEIsALyETgRNUi1YQD4XaxG2t6j8rMIRceJIDEco3IHvMephsoKP1Af7kIp4a9pFZse4xk=;20:41HUqvgy3UQfQqGPQbeLNOicyZRyzsCFsfX3R+Yq8Zi83dxsdtxYVrmNkei6T/oUwS3hwWE9cYc9YT98bRLbDc1Os2jUC0c4gObPefknMepTRifdtKNJ3OWjE1GdMjd/9lAs31vF02slOyzkMAd5F3GaF4ee3ml03l7fDNCYGRt8eJ00jyhUpYqwhfzp3tb/IiDL/7MOtn6s07+qtEzDn5Pg7NP8in2srBpoMvPPRv8G+7LuVv9yES+k2tx7M/dIKDpj83NaM5jVJgd1La2Ju1jwD84gXc30MeRwSZXWCTGFcDd0pnXx71cveJTKvFTt0aeZdJkfnv2LpL6jcIK8+QHCQosRq2XJ7dCczRUCeAqvGbc8df8LXe9fIFqVwR4CE6ZsbwSgQO3q9uKngDOcoQVhqr7OZROb9XJr1Yv68rDcTLOcsykuEA+Wn0fU5WmWTQ2ImqAFoVvVTOzsre05fl/Vc79LmcFcDZR+20KtT+Z8lUkIamSTforZEUauOWv9
X-Microsoft-Antispam-PRVS: <DM2PR02MB1404ECE7363EB012FDEC3AF7E2BE0@DM2PR02MB1404.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93004095)(6055026)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM2PR02MB1404;BCL:0;PCL:0;RULEID:;SRVR:DM2PR02MB1404;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB1404;4:xBP3AGsnGXGw+T5LNR/8oG8q1AU58TyIL1aEGl59GXscPjjviijuAYFiSy7BLINTPNBsYG45myVi5dH8TjGWbtLpJg6MN6OZzACXwTY7jkdaO9veKsvK9zGdhMaL9lycn7INkpLbCdjssrXh8qy9W6i9jKu4akE9V7x2PcDLGXAKrN3Jf5aVVpycSFf/9wE5YOCfTgF8Ldbaiu71ujCqQFa8xoplsYeSzf73jt64uZu1buS79adnn+T3TiJYjeRXc3d1ca/6JGmWTkOMVahedtnJ+581qzuchtjFkU7rHTB1ygiqF6WkmNzJ50j4i7Sqx9eo8uHtOf0+VAT36UYI7Cjaqdgf0HwRB0MYNfAF7+M=
X-Forefront-PRVS: 0638FD5066
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjAyTUIxNDA0OzIzOmJOQVc4SU9NWlEvaU14L0RPL3Y5T0NQNDNU?=
 =?utf-8?B?UVE3cS9hZjFYT3dHZWpUakJyNnlMZVVoSVVnQUZ2WGRqWDR0TE42RTJiY203?=
 =?utf-8?B?RzluUDJHQW5EQXZVeWRrMGFwOW9FWU15TWhDWEFnVDE2emF3QmdSNGJCakJM?=
 =?utf-8?B?bmJsK0hRQURJYjJuMlBmQTYxRnZnd3JVa3lzd0sxUnB6d3oza2dUQlBVZktU?=
 =?utf-8?B?RnF6R1FWaVJZei9CaW1KNkprSjBwYmtJclhjR2pKTHpjSWdRVDJzR0swUEU3?=
 =?utf-8?B?ajh3WHY2ZnRvRm9GNHY3ZXlIYWMyQzJYSzhHSE9OOFd3NW5MbVdPNU1xL2lw?=
 =?utf-8?B?NGhHcnhsUmVtNHpFMGFhWldud2RBbGl5Y2I1QzJKQ3luTEdjWGgrRkF0YURv?=
 =?utf-8?B?b1V0NmtsL1VBUnF2RGxXVjFqRW1ySWFrK0JOTzAzTjVZQnlTejVtZGY1RytN?=
 =?utf-8?B?TS9vOXJNMWpONFV6VUphUnJsYVNscCtEK0NER3pnU2h5V21qby9RV2RhU2FL?=
 =?utf-8?B?VENUa0VkR1BXSUFkUWV6TlNGMVhyTDBSSk0rQ3BsUmFFMUYvYXhHVVlCZ1I3?=
 =?utf-8?B?RTh5NmZuRHVna3ZPelBCbSs3Nk12R1ltazNweXZ1NFZydTczRHZoZEdQUGhM?=
 =?utf-8?B?Vi9OYWpxSGh6WjZ2MWVnczBZN0t2ckg4NkU2VTd3RFNhUUJaMGdqU1NDTkRn?=
 =?utf-8?B?Y0VoQkxuYTFYbGVCY01CNHUzdFJKZkd4Z2Jhc0JRRkFLNkU5cG9WbGJ1QzlJ?=
 =?utf-8?B?SzB1d0MyUVJqSkh4MmQ1SythZTFVcWpxeEdMMVNQdm9KcTZ6d3BhM1VpaE9m?=
 =?utf-8?B?Y29VdkdyS0FNdTJHblhlZDZUOXd0a1d2U3JXaUZGZXA0bW1hZitzazN4MGxk?=
 =?utf-8?B?M3JacWZhQXZDaHZTbTlnTk1SUFRNM1JwY1FKeXV5cTlHUTRBeWlkc0RuT2RK?=
 =?utf-8?B?RkNHN09GNFBzdXhsRlZTenpDWHEyUkRSS2FLQUFrb2N4ZEZ1QWN5ZmNzN2lu?=
 =?utf-8?B?bSt1SCt6YVlYODhzM0xCOCtpUC9UUTByUzVRVmxyajY2WThhZ200Wm5aQlJZ?=
 =?utf-8?B?MUJBMUN3cFIrK2ZOU2JYVEtRbGkydlJaUUIwTnRaMG14QlE5VCtNamdhL0xB?=
 =?utf-8?B?Z3VWU2o0YzdsNXpKVjdISk43UHoyU0xuamVkVEdWVVYvYkprMW5QOUJIb0xx?=
 =?utf-8?B?cFNXVzhwYkRFekJIc1cxL3JMZTlLQmswcktodExzazlhVHFEeEF2T044anY0?=
 =?utf-8?B?VlVpeUUyazJvUDcveVdjRzd4VW5uK3NXajQ5Vkx6ZUc0ckJSa2pRMks4a3Zh?=
 =?utf-8?B?WEVwM1cvTmtDOGgzTWxXeStQUm5qekphR0VOZEpGM29pK0tsUVlnR3pZNXpT?=
 =?utf-8?B?UFRCdHBDVkIrcUZycDlQMFNOMzRVVERpdmRWaVdwYzVmRVBPZFIyODEwZDdS?=
 =?utf-8?B?RnFRVjB6aFBhUVVubUFSd0NwNGRFRFNCL0U0QThRNkpIMnhwSmRXSlYvK2Mw?=
 =?utf-8?B?bFRWbWd6WDJaQzVBbmJ2anRNVXk5K2pYL01sd2pPcUc4YlpOdndKZWwrZFBt?=
 =?utf-8?B?OURVYWFRaElsdklQK1VmNERGZnYvdEpEVDcvTkFaeHdtSCs1VW51bUpKZFNW?=
 =?utf-8?B?UkZtcCsyRm9keVRoQ1ZLRzQ0M2ZJUXBwQ0JvUWpwUXBNWjhtejZSUXJyZm5Z?=
 =?utf-8?B?bUt4ME5zR0Y4VGJidkhDc05ocnpuMjBUY3BvMjhSMG5ZaGc3Q2hGSEhESW9i?=
 =?utf-8?B?cGQ5Q0J1VDQ2c01uSjFPUnFlZGN1aTlQaHJEM2J4REV4ZE9zWks0RGE0ajZX?=
 =?utf-8?B?MUcvWkFGNjIyVjJOK09MV1pSbDAzY2pmdVM3TklUb1UveDBQdFdFMDF5NkRt?=
 =?utf-8?B?bTlVc0dHTXUyelA2MjExVlVoME9VaUR3R2phZTJZK2JiMzhyUkpLMGtnRmp0?=
 =?utf-8?B?WC82U3JVeFl0NVh5dktUcVJpUEN4clRTdVdJTVhwakNaS1c4V2t2SUZmVEFm?=
 =?utf-8?Q?XkyXRO?=
X-Microsoft-Antispam-Message-Info: bkkGZHEJaKbzOL6n54D+3xBsn6TdueOqkcvVNHsc7UCvn7dtmhxGL2QGhnYU5zc+9i4rBdaMO5cflSDFjxyewa3ltGr9JmUEtRx2oYIhfC3JA4ZV55OnIoa61yfWr19ArC88xwLWTD0p062IZz1oTE8opCSsG3phSXJm5k2rhB/nyQcu08pu98+bkuSLxAhG
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB1404;6:1qRLWEJAa2RLR94wv7EkClzn54KkebZUlibtOV/DGTHosGrtUMi4060VrSWy5azIJrpmTfmizJHz6vK+LqVUg9dVdr8f7di3hx4TicPmndFjeTgyh6CUmaXoZHkBFgV5Td/Z/3Lkfw9QHcpeF8+RWVzVwHMTX7TnJ9G8u8SovXZ+fxPl31nt8XA4zslPvCxQCp0CScijG4CjhdDVe0mPAoNmIu/rAExMoIqbWkscU1GxSWj3UfSo5sFFQaT2h2zvZzRbkWfyjUTt/tr1gtkRz1wP0aruyQiaqZOVVfXuhXCAjcaS6DaiHmCUnjUhmD5CBTdLz9/pAzZbdhWL5DtBnS/bfC41B2iznmdt7Wslp1EW2kLVvKAtvKVlO6+5rO9rL08Yxw1sL1vIQZq0DOx5Ihqx777E7KpVMI7ynvJm/fV2pWutt/CKLh+LQbChoLVvKQtnjdCYo93VxPYKeWJlQw==;5:eYbSxX7xLv+UiNEGhqB0ZxOMxrA+P5ZTHsDoWDrlfeGknbZk9Nhv9k5f0O2ihncIVKmqsECNa++bNb5JGMj6AP6gjNgIKxm9G9KZ1i7+KuxJXKP/tKF4rCFo7VAYwP3ND9ZLMJO+8mA9wR4xUXpqZUODZ6gz5RtvLAaqAsiSXeg=;24:J4TnvxwoQMnpRz39b+TSIyPbTX6KsiqkNTnCTd+AuSu9Y0z56zzDoMLikfYhhhfW/frAfHZW+CjtA4FmZm6UDDAOh8l8bzCQNmAktX478RM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR02MB1404;7:MLYcS2rUjhkJTUNgPaEVrM5CyaGzEqPLyr6y0p+IQzRwotGtMsNmJcOfrIukldXNg2TOlChzG8ahIfV3BhJ33iHHL6sD8jvP/SDhzS0xgXInxfZKScUKcUqoWzzFCl5dVIOKLGa3lA6MQZD2Ga8cHd5u0lOkn2awM7BswOqaxE7WT4QKGOCfI9brxZH8KcgARDCIYWTZdmMmDm2UwBfg1rd9BQjDakCAvtidv3HEo0BliBfks1zyDePKsgH/laF9
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 13:02:58.5830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e1b951-fb66-4d62-ee36-08d59ee362a9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR02MB1404
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.4.2018 14:17, Adrian Hunter wrote:
> On 10/04/18 15:06, Michal Simek wrote:
>> Hi Adrian,
>>
>> On 10.4.2018 13:42, Adrian Hunter wrote:
>>> On 29/03/18 08:48, naranimanish@gmail.com wrote:
>>>> From: Manish Narani <mnarani@xilinx.com>
>>>>
>>>> This patch adds runtime PM support in Arasan SD driver.
>>>>
>>>> Signed-off-by: Manish Narani <mnarani@xilinx.com>
>>>
>>> Just a couple of comments about style.
>>>
>>>> ---
>>>>  drivers/mmc/host/sdhci-of-arasan.c | 83 +++++++++++++++++++++++++++++++++++++-
>>>>  1 file changed, 81 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>>>> index c33a5f7..47196b5 100644
>>>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>>>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>>>> @@ -23,6 +23,7 @@
>>>>  #include <linux/mfd/syscon.h>
>>>>  #include <linux/module.h>
>>>>  #include <linux/of_device.h>
>>>> +#include <linux/pm_runtime.h>
>>>>  #include <linux/phy/phy.h>
>>>>  #include <linux/regmap.h>
>>>>  #include <linux/of.h>
>>>> @@ -349,6 +350,75 @@ static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
>>>>  			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>>>>  };
>>>>  
>>>> +#ifdef CONFIG_PM
>>>> +/**
>>>> + * sdhci_arasan_runtime_suspend - Suspend method for the driver
>>>> + * @dev:	Address of the device structure
>>>> + * Returns 0 on success and error value on error
>>>> + *
>>>> + * Put the device in a low power state.
>>>> + */
>>>
>>> Kernel style is not to put kerneldoc on callback functions.
>>
>> I have never read that there are some sort of list of functions which
>> shouldn't be covered by kernel-doc.
>> What's the problem with using kerneldoc format here? Maybe I am not
>> getting your comments.
> 
> It is not a list of functions.  It is any implementation of a well-known
> callback. i.e. we already know what ->runtime_suspend() is for, so we don't
> need untold numbers of drivers describing it in comments.
> 

Personally in general I can't see any issue with it especially for
people who has no idea how these callbacks are working but I understand
your concern here especially when there is anything specific written in
connection to this device.

Thanks,
Michal
