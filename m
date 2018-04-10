Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbeDJMGg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:06:36 -0400
Received: from mail-sn1nam01on0053.outbound.protection.outlook.com ([104.47.32.53]:30151
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752408AbeDJMGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:06:33 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [RFC PATCH] sdhci: arasan: Add runtime PM support
To: Adrian Hunter <adrian.hunter@intel.com>, <naranimanish@gmail.com>,
        <michal.simek@xilinx.com>, <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: Manish Narani <mnarani@xilinx.com>
References: <1522302530-27550-1-git-send-email-naranimanish@gmail.com>
 <29f0aae5-3cee-8a37-f5aa-3830f466a759@intel.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <b02c6970-f4f5-53af-2834-710ff3b7cbaa@xilinx.com>
Date: Tue, 10 Apr 2018 14:06:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <29f0aae5-3cee-8a37-f5aa-3830f466a759@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39380400002)(396003)(39860400002)(2980300002)(438002)(3190300001)(199004)(189003)(8676002)(446003)(81166006)(81156014)(426003)(186003)(76176011)(65826007)(47776003)(58126008)(53546011)(63266004)(229853002)(486006)(8936002)(50466002)(126002)(356003)(476003)(2201001)(77096007)(2616005)(11346002)(86362001)(336012)(26005)(6666003)(2906002)(64126003)(36386004)(31686004)(31696002)(305945005)(110136005)(36756003)(9786002)(478600001)(316002)(230700001)(107886003)(5660300001)(106002)(106466001)(65956001)(23676004)(2486003)(65806001)(39060400002)(4326008)(59450400001)(6246003)(107986001)(5001870100001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0201MB0587;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT062;1:P4ditOIU2rYL4jGYxGe+Jx3VxW5U7fW31K5cHhhK4ZlBL/+Pi/QZTWyoOYvBIgEto9qR0lziSR1yX2zMTPRqJpeuhUQI9olKHHgBMvJ0Mze1KrCEdoMkHQVFevs3C3JX
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 075e063c-2393-416d-7b67-08d59edb7d30
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY1PR0201MB0587;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB0587;3:vRNXmIRVqDch3s/+O3y8WPZ4dodgeolSMxrC78z+ILluRS+v7cL1Fkb7otHsJU01eu8LFEtsKpRU4/SkFfo6rh6jFpdXiaMN0rSmcJEDCuu78lZ4mGFQP8s46DPlnVvw+soTwhdoFOGXDigGtUs4I/Cv6Esct0jN8wVjZKwgAxHaIEY3StwiFy4rmWTKv3kzlD+A1fJ0NJoB+k/8saaM+YnF0jVMua2M5kyOVPCQ6Wnttl3iODDoJQ4i44oFFU2kbNObzssXIbZY7WaNhGS9iFu9RUQl1RvEYmdqFpr8EyyfhyMi3gaat+gPpIDBxOb3vD5FI30vHOcyBH6wJNZHu1YRvEmWIGTDOi5o/bx7DCg=;25:yOeb41vmM0X5zYC7gFWtZ+FgHBzr6QOX471xvswlrCINHnZpirjHd+PFLf6esyp+uRlYdZQbxjepQypbab1XpWrNTuAFCbDanVc2ZQv/4um/0i08bGxe2MOaGb38KC3ZVwi63GA2pem6yZ7B8TmTFcsOxtSoXGD3EU6ifjGmEMjkXNWg02w4MrzNuGHYNyY4j14mE/dQ59cBnzT0A5cpPqaPfzRag88kjmmWKMxibyMpgyFjFp7evGrgiWwc/6c5eBo2im861gW8u/HYIagVhWz0wLV/5CNdzq5V7Whcvdyrd4tTj+X/UfTVV/JHNjdfu5Q8ngY1RK1cwfGBQb0i0g==
X-MS-TrafficTypeDiagnostic: CY1PR0201MB0587:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB0587;31:fFjza1FFigyXueWfpP6WLO5NsxNlU+nLu92PdwXFgoNN8O2WcGrkJkop8wGvdJycuIzBgFKR6G5jaHLQt735cpjUFmzhB5XNfr2hlvMvWpz6+ULvUmK9yj4jtZ4cABeDk9n8Y6xi3CRU8p0tSLfu6BL9J3P1ygtUMVRnmPUBxe9JO2I/rVK4awdZYAOKnAf4Eaj2j0slz63kKGHoTPA4a5VzcPLjno+grv+d1hjsqWg=;20:vjQwD/U/H3QVsnBWKb3M+Hv/gVMh2ZJn5OvzaQMurdsfEJuSIhuBZO2naf8yAryHDGuQL2Hoe33GrV5I1OJS9EJeilIWClZpqB/Wr43xzCpvmfWj+h7WSdewt+Lvebd14PG9LcXXXjkLlj09u72UpTrIbV2ALJkP+otboFGAKKTIfTLE2QfMj2rk4lWnNl8h30mRMKl0d18ZbCl1Q0wc6pwwU8PdNdGGYRKqyItm+dL3dbInzGtad8cwB55zX7tpcpyHbsQDy7WBtHnOic4DCOplOLZrvwSnZWdGLXdsjhrnzqOXYT3YKOZgf/s5zwJ2pYRrOQkuEiLvI4weEDu30kE0/DNjSigEKI2EMzP6hCSIjHq7fOQ4aCkLIHZgd+tdJc6zueRRIhWU5I6hUAZITlPRqDFxYiVZ/eX50j/0B/zztojrb5BXBgdxEBAcmbxm4ACK6bf2AC2GbvtxPN5MSNQ+dvOR50rij7054qBxRsSZyERt2lMFSiE/fqJjHQiL
X-Microsoft-Antispam-PRVS: <CY1PR0201MB0587715D9E48EDE6CAE023B3E2BE0@CY1PR0201MB0587.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93004095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:CY1PR0201MB0587;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0201MB0587;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB0587;4:ZfzjoTrIIZV1hatvxzQXxZEyH61TjNGxwJvqhHyiNnAZWndH/w527qfU8sh/3Rt+DI1InwwN/CV/QNDV5FEjB7GWWSLGA0JTlwXqMlv6zs34QwHZH2MFgQX+grE5oqiuN+H2GesLTCG06HdYFN9VZTIdFAvqnY7xG71PTfsiS+XP/vduT1yKXiWvpHTJDIYUmVgtKri15TbK4yYxWMi6vWkp/ifhp17NT3MvMQhHJCyvGjIHnHWUJRUbaRKXSgP4Lrtuj/J26THALKmBE32d7Pu2etEw0waP+kpcm4oXgRVZ9YM7ClzldaLK/ovn0eUuleqIdC24+vERuY8nYDruS2dKwnWQTT2Ulb+0qcXj058=
X-Forefront-PRVS: 0638FD5066
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjAyMDFNQjA1ODc7MjM6RkNERDd4c0NFS1dPMzVxT0dKNWtwVXdx?=
 =?utf-8?B?Snd4emErRUlZV3JpK1p4QXQ1ODBPOWorM3AzaEZydHZRTURXR2t0ZTZ4ZHY2?=
 =?utf-8?B?b3U1d3g2ZlBENEp5SVkvS1NIQTIvbGZqaHFKQnIyQUdjbFFSbHlmK296T0gr?=
 =?utf-8?B?dkFNZzNtemFFNitLTGQ4U2hWV1NkQ0ljSlVvYUtadjIvN0ZUNW40MzNWVC8x?=
 =?utf-8?B?NllSRUR5OE9uUkNRWXZ1YTBuY0lYblRDMUY0ZWozQTRTRFJ3clB1OTVhVFJ3?=
 =?utf-8?B?UU5QZGV2a0s4dGZIV1BqTXpWRlFDcHFLTit0emVqRkQ1S2RWM2NYc0RWZmtE?=
 =?utf-8?B?SWswRzYzN0ZMREJMWXgwZ0FMZlZmTHNBczl0TGNxc1ZWeGRIZWRyT295OENO?=
 =?utf-8?B?dFo1UEEvZWd6WGVnMXNnd3l0Z09ubVVTL0RZZTRJRlEyM09jRmpZLzFwZmE1?=
 =?utf-8?B?eDVxTGVqcnFzdmFqNURTemNxY1ByV0hTaG5RMVRtS012N2tEZGNJN3AyUnBx?=
 =?utf-8?B?R3JoZExqK1h6NFlYdkhEaEpkVzNGOTZka05BVmRKaGk3OU1EcXp5ajdZOE4v?=
 =?utf-8?B?amN4U0RFT1l1cHRwRmpuQ290QXBPS291T0ErdUJPODFxSW9SU3N6cXhVMVFo?=
 =?utf-8?B?YTNMMWFyd2RQUnZ0aDB2UlZWZVhQQzRBMjZvektTNFJ0bDVFU1Vyaks2QXp3?=
 =?utf-8?B?Q0lIdUpDRm5sM2d4eVhkUlFNak9PTStrNis4MVZsUk8xd0RsTnhwZzJVZWJH?=
 =?utf-8?B?bnZ4TitORHhDb0NKbE5vek9hTFFLMFRhaExiTHdTQkJvMnZzRVc5MHBpYnQ4?=
 =?utf-8?B?ays0bVJTelZ1bThibDd6N3lpZW1kOEQ5UGZBMEhNMVJHNEJkRU1Uc3d4V2tL?=
 =?utf-8?B?K3dXWU5yQ2lEdGI2eUdyMUZYVlNNdzlaT0dPeVhsMDN3RSsxTFdCT0hOcGt3?=
 =?utf-8?B?ZHFEVGRtSHUrbkdrKzlTS1RIZkxyVDB3ZGIvczA0M2dQVDhnTUE5NmRDYnl0?=
 =?utf-8?B?ZUxmMmp2VC9JNTlHc1dHTVNKMUpJK2xOQVEraTdnMnUxdVN1dWdzUWxkVnRi?=
 =?utf-8?B?aHowckJTZklSMDVsNEl5R0ZHcE8vZlBUM3k5THkxWjFRb3hyMnFOZ3lHTGU4?=
 =?utf-8?B?RkdDVDhWK2hKNW5WWFRUdHZjeTgvOWczSzZmYjZwS2hqYlVLSFFCV2NNOW1K?=
 =?utf-8?B?a2M5Y1ZDRFVlUFg2MTBVL3pMNSsxVkNuZ1lEOS82YTVVOTM0V1pPZC8rLzBu?=
 =?utf-8?B?NFZqK3Y0cE5XbXY3bHVOSG5vNDNOL2MwSzg1ZkRscHlySnd5OHAwRjljT1JT?=
 =?utf-8?B?clJQK0lWMTdXR1ErTDlNaGtnVHVLczVPQk1EZ1BwdXY0Z242VlNKTld5Tzdn?=
 =?utf-8?B?bm4vcTl5MVlEWXV1T3V3SWdsTEQ5Y0pMOXBZRit0bUtFMDczWHRDSmZ3VmQ3?=
 =?utf-8?B?eFlEL21WREFkV3VwRXl0S3RPeEFZbDB1SzZLUjRHc1dxNklVUmIySFFXU3c2?=
 =?utf-8?B?Z3FCcjJFaXZqWnp0K0VVY09rNmhnRDN5OWtqRDZ2a1dIbkc4dkhzd05KbzRT?=
 =?utf-8?B?L2tva0NWbVB4TmpaOVhjOXd1M3Y2bkd0SE5KRXczck5xV0xITHNmSjZHSG85?=
 =?utf-8?B?dk0zU0QyTlpwYm9ueVg1UVRYOEhmNEI1b0piSUF0ZE5teWNsNjFaamg5dWps?=
 =?utf-8?B?U1lCSkFvcVMyeS9QSlIrWVpZVU9MekdxdmM3WGlqYlloRU0zRHlHOTBZZEp1?=
 =?utf-8?B?Lzk1L2pSYnhoanExRDdXUkZVR1lyR1FkMzlqUW50K0RPNHBlRm1Fak9raUlW?=
 =?utf-8?B?QVBpeDZyblA3ZHpxMXJDZmlVb3QxcHNmVkJ1ZUhGb0x5eHROcllGYnphejd0?=
 =?utf-8?B?dVpPT2lsZFNocnBRb01qVDNKQ2twRm1DUWkxREZIejEyZHBYUG9jVWxJWElE?=
 =?utf-8?Q?f5WfndYSBflPWt0yDIq6qRff11odo3tg=3D?=
X-Microsoft-Antispam-Message-Info: yMnoEd2+HnXgdnTkZ2Eqdy7kT7cJ2VD8lU0X9yItljkqqinmm8iXwLxy7I2V5jKmaHLw89YXrc8uIG3t8+y5tracpTi3iZvJmwZZCGsCEmn4XUHalJ9ayWyDdo/K7eVJO0bdc0pEsbWKF2KtmTGYuHjSRRKfRm0HEpw7+8v+UY6Sd3ii10R2nu17PTNAE/Fl
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB0587;6:sAU77VlzweTlD8tDUg//ccyyXFq49DhSakqTySYu4iuHUoUe/2Qve0PBp+gbaJqSSljhVtgg+n5EY3FiG6Ol5NT6ZyJW1+6vGcSguxZCSybnEDfswAtbdoOyerQGE+vku82IxXgPSwBRzkhQ2GZM+c4mrt6at7EVlBb0uUEloe0oZU4o0LQGzXUgxnakhZCk1fXMMlg0VuZZqvcemTBG6GBPkWdKq6oFLNLpHGCuukqM+CrZx5aqEPw8dHieJ/B2Wllssat9CUxHmTAq6n7zxd0nV6PSpqG4Mp62mpeSxeIF4kHAuV8yOumFhqlEytnWvD4glnSEJTTOQFzggpVfwygTm0GqIUDp3xhnrSlfFGIsY15oyfSEbFraxFkDwUpH5n5h1F53GC0JmKClYtwHwnOuo0uv345CAKe+CC+ygSXkYb1PuJ0tOxCa+yAwLzHS9WhuEygRYuumca1/aue7mg==;5:/zwzPNAlBThls0xkVlvP5eyUQytFlS0UoHv27IwOx19zO8cO30tgXjzkuTOWcmZH+8qK+Zl+khvrVbwIC+tifodv0lovmhVwSAKrmRnmh6QHRqFFnCR3NlvtSUDrlxk1KdtLs77cUeoEpbUoCKb4BIIzldKEhxjpQcO/ppNNxUU=;24:MOiDI4VGlAzSFHK8h0s0jIBLh7EIn0IPssYkSgcaxwOZAHOzNCXti5WT1Kg3VE9yKYIucIE8L/63dUQP0vSu5vfjuNhS/I5w1kRxfOmHqaw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB0587;7:iXu5iw5Jvlb/ZUqhRzLUb4zkT4iq/Azy8ZPRWd3dZU7tavW9bKUPN+Etj+rtAtttqCR7hAzIopyilZpEkpt9jCLKJUmug/4tRJPMeiqfY545HoTb0udIMwUDU4HjgyLl6U9uw9u7tF1WcqnGzK7o4e87Lwf3qb8eXSOsIrIKu5XQYQQ8ZFBM2xNjtKj3BSAYToQTG9Y9Qo6Jc4yOLiPBw1ylVHWLSV94I3p5grjOk/iBzJUl0Q4bJpRfW9Lm1XK8
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 12:06:26.7054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 075e063c-2393-416d-7b67-08d59edb7d30
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0201MB0587
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On 10.4.2018 13:42, Adrian Hunter wrote:
> On 29/03/18 08:48, naranimanish@gmail.com wrote:
>> From: Manish Narani <mnarani@xilinx.com>
>>
>> This patch adds runtime PM support in Arasan SD driver.
>>
>> Signed-off-by: Manish Narani <mnarani@xilinx.com>
> 
> Just a couple of comments about style.
> 
>> ---
>>  drivers/mmc/host/sdhci-of-arasan.c | 83 +++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 81 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>> index c33a5f7..47196b5 100644
>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/mfd/syscon.h>
>>  #include <linux/module.h>
>>  #include <linux/of_device.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/phy/phy.h>
>>  #include <linux/regmap.h>
>>  #include <linux/of.h>
>> @@ -349,6 +350,75 @@ static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
>>  			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>>  };
>>  
>> +#ifdef CONFIG_PM
>> +/**
>> + * sdhci_arasan_runtime_suspend - Suspend method for the driver
>> + * @dev:	Address of the device structure
>> + * Returns 0 on success and error value on error
>> + *
>> + * Put the device in a low power state.
>> + */
> 
> Kernel style is not to put kerneldoc on callback functions.

I have never read that there are some sort of list of functions which
shouldn't be covered by kernel-doc.
What's the problem with using kerneldoc format here? Maybe I am not
getting your comments.

Thanks,
Michal
