Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756641AbeDZXJ3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 19:09:29 -0400
Received: from mail-db5eur01on0139.outbound.protection.outlook.com ([104.47.2.139]:9280
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752991AbeDZXJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 19:09:23 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 00/24] device link, bridge supplier <-> drm device
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>,
        Peter Senna Tschudin <peter.senna@collabora.com>,
        Martin Donnelly <martin.donnelly@ge.com>,
        Martyn Welch <martyn.welch@collabora.co.uk>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org
References: <20180426223139.16740-1-peda@axentia.se>
 <1881012.XPHlTWYXH6@avalon>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <8a9fcd8c-962d-1acc-c2ba-74a3d8f59590@axentia.se>
Date: Fri, 27 Apr 2018 01:09:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1881012.XPHlTWYXH6@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR07CA0024.eurprd07.prod.outlook.com
 (2603:10a6:7:67::34) To AM4PR0202MB2771.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2771;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2771;3:J4LINitLgpBB8bDiibDPsussg/ypfx9ALvew0wXaThJJobcBhl2Y693KTRcE0+hwIcCx82xjQTHnRqSj5bTqFdDLbTKhJkS364ehmhm5Gcti1M/Fzv3KOFA4WUgprDmNiJFPIXt47ID/Rz+Wt3CtwIQ0VmTOXggukYZ5Q+quutcHKiWgB3q14cbjdXDq20AlxUgvJNV3tFDnxYhrDJz327Mfq2SoLPXY3YbOd13YQKnm/PLjvA6s+BgwxXdxjtIg;25:R1i0tZVBwSDPO+z8ZL43LUKh84UoPmxL5Yxkdp3IsxQlnFb0IHoPvwFvZaRyWIJa2Yv31FDelHrzKsm6ZH/ShWNhIhOHNBUMBEAgFqmrjFcHBVMxoSTWA5DiTQmdvXvOq7jhVr4UE8pNuSJP6/ms7BFHIUSBfe98mcqsDixeH0QG9srRapoj8zE6m2IRkiONdDIjzOSj/cR6Nged6BHJCzLx/DRyr42XPSFvzXltq5bop9u9fLfqT/gtI4NqFDtewv69A7nkPq4pUrU/8kLFft8AJFSsJbv4yMHU/VTKkbGnCQ1fpdB0M/ydM+n3MFcur9P093vcWoeU4vidsrq/kQ==;31:o7bD6UyWPWBTAwFQItbdAxAph1IgYQJRIFlif101t1hU1ZnJr3vXaVXeDu1rG6T0M9J4n1hE5TDoFQ/LnkyZVkfWXprAicl2slNyVnByH5pjRTqAAurYgNJv9l0iVMliDxW+j3FFrCVlKe/DcfvDd/9ReR1Eh1O6yG4YV+ASgHHEKtkzF2V0DqvXRWs+/1PXXM/ywAqFjpmj7Q2eB/gD6s8sELqW5NDmhf0ZN1Brr00=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2771:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB277148B0633FEDF35C8708D5BC8E0@AM4PR0202MB2771.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231232)(944501410)(52105095)(3002001)(6041310)(20161123562045)(20161123558120)(2016111802025)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2771;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2771;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2771;4:5zo6oD701+iWSRuCIRNwYq6WO09F2BcKHW0jhajDqNrEpLAmTqnoToQC5MMo4Hvgl2QZO/6Ysl/cDhMC3/juxrexlVIHqqA0q4vVn8A+NQHetrsch2xwJsLI1CuqhcxapWz2dsof4r2dJKd0kDbwcaeEi0oD0Zux0IIX2nbMfwmR0el9NbdvSFlVT4t/zYyWy6gqPMFIZJdfrlv3NRzFzeHmBsi/V84wEa403Q/57oRt+QDJmRyrWdVTFZ83fSIvu4o21wRtMmZG9tmMVvv5Ag==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(39380400002)(396003)(366004)(346002)(39830400003)(199004)(189003)(377424004)(186003)(2906002)(16526019)(50466002)(6116002)(3846002)(76176011)(81166006)(68736007)(31696002)(8936002)(6246003)(486006)(47776003)(7416002)(65826007)(53936002)(66066001)(74482002)(230700001)(31686004)(65806001)(65956001)(5660300001)(64126003)(77096007)(81156014)(53546011)(97736004)(105586002)(386003)(106356001)(229853002)(6486002)(345774005)(16576012)(26005)(36756003)(7406005)(117156002)(6916009)(11346002)(39060400002)(316002)(25786009)(478600001)(446003)(52116002)(3260700006)(476003)(7736002)(4326008)(8676002)(36916002)(54906003)(2486003)(52146003)(2616005)(58126008)(956004)(305945005)(23676004)(6666003)(86362001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2771;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3NzE7MjM6dWVMbURVaU9sZGF5M0FGYVUxc04rc1RS?=
 =?utf-8?B?Y29FaE81eGM5S2ZUSStCckVQUGUySlBWckpxV3Yrbit4M3hSUzNuMVRvRExL?=
 =?utf-8?B?STd0ZllxeWcwY1R6Y0orVGRHQUtZOFFma2dlREk0WjhQdWl5RnRDZW5DbzZh?=
 =?utf-8?B?anBKSWtJWmxOSmpDNWdhYWR0djN6a3B3MGR1UUVsNFdFWWowTHFIT1luRzVk?=
 =?utf-8?B?TGk5VEllS09yV3gvTWJRNlVucDdUUHh1anpMMTlwb21jMHZ0QUx6cVByQStQ?=
 =?utf-8?B?TVJwRDZPTXgwMFBjSWVOZGx5V0l4cFg5YTluNHpnUm9tdnpKMFVVQUN0MktH?=
 =?utf-8?B?ZUpsai8wdzJmcDFOOUZ5WS93REVOcUlvTnY1a1UwYXdaNGUzTlY1RXY1V01H?=
 =?utf-8?B?WnFMUVMwTmNYakNIam9adVV6L2JLV3h5a2dZUHVOWDlXdEprYjVJVWowMDJS?=
 =?utf-8?B?RnB1ZVBSSmQ4QmRwbDFwM2hpSWo4VTVCNVJTOFhjbmVJVnBvQzNYUlVlaHBw?=
 =?utf-8?B?Y0x4bU1ZOEFZWGlSc2NpV2ZMTmpodklQUDJRWjM5NVVNNmJteCtyQ3JpREZu?=
 =?utf-8?B?N3VZMjYxMjBSd2dBYy9QQVN3Zkx6SXZBMElRRDh1ZlVXcThrQTVONTNlSnBy?=
 =?utf-8?B?emlzRG1Xc21oM3F6Z1FEbHpaRm9YTzNvTDZHVm95bnhubHN1Rk04NUNXSmxx?=
 =?utf-8?B?UndlVUV3RWxidDVGbjJEaEt1b3dIZ0UveUZoV1BQaFIrUWRhT2RhYTJ5VXVp?=
 =?utf-8?B?QlhtZ2NFMkNRWU9FVDJzbzN2cnl1N2hYZWo4U2d1aThlR3Rjd0ZCN2RJNlIw?=
 =?utf-8?B?NnFMdkJPKzFiRExPS0NROVVEeDlRMXdYZ0Yvb2ZGcjNXejZlU1E3V3VveVFj?=
 =?utf-8?B?VFdER2ZSWHU4Qi9TZUFGMTNDNlZOdzJKd0VOVitvQ1l6R1FvRkkrUm1qSFN0?=
 =?utf-8?B?WldUdEo0bXNkV1pacndxeS93bU1LbjFVclVmbkhFSFNNTmh5SmVFbGg4dE05?=
 =?utf-8?B?TVpMcVNVY3grOXM2T2IxeGRxbWZlMWVNVUtHQlAxdGRqQ01KdStxZWR2bDds?=
 =?utf-8?B?Vk5PeVRRSDlTWks3Y1hXODFZK1J2L2xlT3pDcnkzREZUb2tYTzRJa1lHaHhK?=
 =?utf-8?B?QzhGY3I0Q1ZIY09OOVNmOU1TSzIxRCtTMW1Bc2hQbzU2OEwwYmdaWS9xZUtY?=
 =?utf-8?B?N1ZyS3NEdE4yb2NCbDBEVTBTVzVvWGl0UllLRGlaaDFwNkY1cDlBQzl5aFJx?=
 =?utf-8?B?WHFndWhLc1NGQ3EvaWdWeEtpcWtIN3hCSmp0RDBCbnFXYkRKVVorTWVEVGZR?=
 =?utf-8?B?b2w4TDlybWpDeHNzQ3NXa2pwZlBreS9PRXAwQy84UW4yZG9NZGFTZWNYUkZo?=
 =?utf-8?B?TWRKMy9aUG5pRkpZbnoyWko5L0pRNit2RUp0UnpCQ3ZyUlM0SHBQSExCaDQ4?=
 =?utf-8?B?anYxaHpVcVlhN1FnbnhlOWdSUWtPcWd3NDNMR1c1NXFsc3V0Q09JazI4VlFh?=
 =?utf-8?B?VTlheGxnQWFwNHBBSFVYSjlnWWk0eU05TmoxbkxaKy9ibEdDR0FZRUJ2MjJx?=
 =?utf-8?B?ci94M2FoVzhuTklZREMyS3o4TVkvZWJhMWk4K2Jza2g1SlpVQU1LTWRzKzBB?=
 =?utf-8?B?UXpaS1VISlBBWVpDczVmbjNNZ282OXluemRMY2w3NElnS0ptdVJ5SmNsSjlo?=
 =?utf-8?B?Nzg0dkIyeDVnaHBVZEJGSXkxZ09mdlZ0UkZaMUY0Y25zWlpJODRFZzMvSTI1?=
 =?utf-8?B?VXhsNWZ0aDhKL0xzb1hUMENxaHFvOU03a28vdlpkUUszVkRaUktNM0hzQ1Jk?=
 =?utf-8?B?WVg4cmRsZmNOUGtyb2ErdmhrdTdoVzNzNkZ3bTBxbDcrSEwvSTJZQkFQeTBq?=
 =?utf-8?B?UVU1c3RwWXJ6UDlZSjI5R3ZjZ1BGOTBneVdOTlZzcmdLQWsyaWsxR1NEVHpJ?=
 =?utf-8?B?bGFxUWUxZ1oydnlIdGQ3WnFMVHh3NEd0dGhsVHF3NHhPbE8vTTJqTXZPYXJr?=
 =?utf-8?B?Q1FNTHZGNW1GdFJwWUVqUS9tdTgzdHhzcFUraldxNENXNUdhYUxwU2dJOFpt?=
 =?utf-8?B?YXhyZVIyaVJ3N2VCU3YxaGVOWXdqZXVGQWl6ODBEL2p1VHVMZlY5QmtkQkJX?=
 =?utf-8?B?djRwL3BFVDZja2lBQ0J5WGxiYjhWUE4zWDF1K21Hc3QxREphQlNVWUxZeGxt?=
 =?utf-8?B?dDBvTUJ4Rk5hZkRlbEZqTzNZZjI4Wnd4S3JDaFhvbEt0czg4OU05TXZFb1FD?=
 =?utf-8?Q?o62u9OjRBFyoSoKVF7nR?=
X-Microsoft-Antispam-Message-Info: Hdd1ibk0Etq73ikuEodZGAiGMEklUjpZXLKL5y90/y+sSd1hQl9JgBKDg6kRsA6ltx+lFAGTtF9mbCXaUqtCn9bf4J3lYkI154T1slihjYkDYhE7SoQ379lqv8dSwCJ46XyjdYzmut8q6ihVtdmEBw7K1jecLjz6UgxokZvLjbYWxDIAdspy/Pr/NqO7Qrzu
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2771;6:tPH4nEQhAGWXBXfxuCDE05Crn07ocZpKYuU2EICvruLhFyBYR2E321uGpZhhvFwCGz/bfRUr4oMVX9arla9JEDy7ibefE/J6kJ0YprR6sdd/PDO8Bk81LSuXzcL03Nley8LeW2Qc+kWezeT5ugGtz/TJEGW1KplbnAy1gHaSclZygtgNgIcyW1HBwye6m2jvaQIwvB8SmnfK7peFEmeL0DmLUs17YvXoeU+eTT/j+Q10ujX5L8dYllssjdh9/mhk0tv3akE2ZXf8mGbvcN5JaH2Nu9SqzYWlkwiQM21cc0jSJ7lCjsRuRrTgCQZ+n0AUw6/u0thxcT9pOA1K+J/KE4fb+oZUs5rk90JFMlf4QbnxeCrP34F9/W2J+uf4DWre1oqyjOmfXPWfPj/tPfO72Z9uVHqJRY0/nerO2Va2N5zje3z8hUnpmBhiZz//dznGWS62TACKrxm6XFaW+XvdGQ==;5:yo4+9F22DQAz1ddYhaUIlztJz+uuyXYXhpuMTiWMYgfukz0GTIbIAeKMrtSWhZXniQcIvqX37pxOsgqKhHoyIH+Mc9OUCijBMSrQYefviuVpTKkD0YnHlWaYzxsAq4Syh6g1oo/K4BvTW2ak/AaaJa41RPzmuO4ec5c7ZM/YCAE=;24:vt4NKfjuxHRf6n7Ke2vfc4yXmBu57dk+xhu8+u4qO4/I77O/p7jDmrFjGVyVDJReJ4HxfgjsC0gOolN07obwfJNnZA7U9EyCAs1QuBNz92U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2771;7:NyDAjYUT3TUwikfZXPj+28Tw1eu4I2Kl505s47gv/Ib679sPkDfFz54x6LvnhyUtUvIyhgpS4ORhwQsHIBty2d1edFWbM4dvMpDnZrmu0Gsx5trp4i8oMgW1PausVouetiUzbY+1UmgibTZqupCL7xXOISmoRVkTG00RFtHQK5g+IyUcT7BAHtK3dDqBZa9XKUkUYxzq0zVrVzf2i+8Gd8J6f07hb8rJlt4OCO3371PhvaC+xtZ+mxH/vLX6SYzh
X-MS-Office365-Filtering-Correlation-Id: 3b53d96c-79f1-4caf-2b20-08d5abcabdd6
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 23:09:18.1654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b53d96c-79f1-4caf-2b20-08d5abcabdd6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2771
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-27 00:40, Laurent Pinchart wrote:
> Hi Peter,
> 
> Thank you for the patches.
> 
> On Friday, 27 April 2018 01:31:15 EEST Peter Rosin wrote:
>> Hi!
>>
>> It was noted by Russel King [1] that bridges (not using components)
>> might disappear unexpectedly if the owner of the bridge was unbound.
>> Jyri Sarha had previously noted the same thing with panels [2]. Jyri
>> came up with using device links to resolve the panel issue, which
>> was also my (independent) reaction to the note from Russel.
>>
>> This series builds up to the addition of that link in the last
>> patch, but in my opinion the other 23 patches do have merit on their
>> own.
>>
>> The last patch needs testing, while the others look trivial. That
>> said, I might have missed some subtlety.
> 
> I don't think this is the way to go. We have a real lifetime management 
> problem with bridges, and device links are just trying to hide the problem 
> under the carpet. They will further corner us by making a real fix much more 
> difficult to implement. I'll try to comment further in the next few days on 
> what I think a better solution would be, but in a nutshell I believe that 
> drm_bridge objects need to be refcounted, with a .release() operation to free 
> the bridge resources when the reference count drops to zero. This shouldn't be 
> difficult to implement and I'm willing to help.

Ok, sp 24/24 is dead, and maybe 23/24 too. But how do you feel about dropping
.of_node in favour of .owner? That gets rid of ugly #ifdefs...

I also have the nagging feeling that .driver_private serves very little real
purpose if there is a .owner so that you can do

	dev_get_drvdata(bridge->owner)

for the cases where the container_of macro is not appropriate.

Cheers,
Peter
