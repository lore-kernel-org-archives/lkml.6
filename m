Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbeEGOJp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 10:09:45 -0400
Received: from mail-eopbgr30138.outbound.protection.outlook.com ([40.107.3.138]:32160
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752486AbeEGOJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 10:09:39 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v2 00/26] device link, bridge supplier <-> drm device
To: linux-kernel@vger.kernel.org, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
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
        Rob Clark <robdclark@gmail.com>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Jyri Sarha <jsarha@ti.com>
References: <20180504135212.26977-1-peda@axentia.se>
 <20180507135601.GJ12521@phenom.ffwll.local>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <12173f3b-e4dc-940a-8abb-b7be7b79f451@axentia.se>
Date: Mon, 7 May 2018 16:09:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507135601.GJ12521@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0402CA0014.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::24) To DB6PR0202MB2775.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:MQrgK4Cx+2Lt9J5mC6CGcUE3nN57KQGo0BPOGtwnvmgOUJkMGYnsXJQNORmB5Z4QtT9dDzZxyGCesIKYrMEO7wkXJrA7m9fKIN0eG96bAu/Xg8SGXm2bXPrPJIqqaOaPdTzojNAiOdB8ObGQ1k/qYcGaEtuGJh0NRivy/u17yzZ5a9BQqL+nDJFvj2DRG/0HJuII1vquAHUohiGCjd3NZSNjmGz2a/tbzbSOfEgTsseq3xdIq8QxtalCpUC3btyc;25:ZiqlKi76nUS+sBuo4T6E/r/LSJ9sJdJ0sOKNg30WeYwodfFM4nbRR+qJWOCQWzMRnsSmfixeq38YN5sxVKDLSAAb2IvoKIOuwv19HYRP5jF/pYxIihmEprOdbjMhvFM6Gc2vz37SifD8jbwv28ZBao3CWpwbn4VDUH4aNio9GrC7k0DTPABufbhWAYHQoT7ASk/tfpDbTPlOCUFyKX4mUH8qt4NacgMDsB+qWF0Thd0N6KBMheau2Dtf/czJSqRMSWGralm7MrkJyCaQcAsqH9zRIIvQ9QPNsBlUAlEB0n+P3UQJDIS0RhNp2CtWl7ivin7d+1+tPzHP5KB/9y/k4A==;31:rblSXHelvEtUp9c+nac4RSSfWx2S4u/ZUhQQFngEwcnBlN+vDMYMyqJHHSt4iAUT7FeMmSaH5ovUJe8SnQb45AAdhw8IKbJT0hzzYKx+8jzd0EUfUbsn/OeXWuBblk2j+DkVCHWIP5QU9ycQFObsUWJLiSvI6mPkO6yWTfW5CxLXZnGl8YUdhUdyS1H3mWqonVUVQeF+iLm6mg+3cUfvChwXP8/PJbXl3T+Fv7s1ddI=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB277554FDE6CFD572C12C344BBC9B0@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:Jn6wu0MxRzKc3A/M9Hvjx7/oIxG0ljrRJNYab5xE/bGH1ywodiqDN5y3KyWSRcSLD8F+yIym/MxDZYILUyZBKd4MtkUPvHCudKTvpy+/48FRWLpYPpwprPZIdWWLTlZWyDrseeZEWmX6KAov/kwUgVObV/+2YcthaRYigV5rWuVpa/sRZdOV+aISPjbuL/CrMMg7SejWYYdm4WIiWFCzuCdDISQCnsgplhYyh5e7jQctqqnTzHo/n4p4AyCvQqzh3tn9z1Z60P2Jcf1lfqXHdg==
X-Forefront-PRVS: 066517B35B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(396003)(366004)(376002)(346002)(39830400003)(377424004)(189003)(199004)(86362001)(8676002)(36756003)(6306002)(7416002)(476003)(7406005)(2906002)(6486002)(2616005)(8936002)(31686004)(31696002)(117156002)(966005)(6246003)(39060400002)(74482002)(25786009)(3260700006)(53936002)(5890100001)(478600001)(6666003)(486006)(77096007)(2486003)(81166006)(47776003)(386003)(52146003)(76176011)(81156014)(65956001)(66066001)(65806001)(52116002)(23676004)(36916002)(26005)(16526019)(50466002)(305945005)(186003)(7736002)(110136005)(229853002)(16576012)(97736004)(58126008)(446003)(5660300001)(64126003)(65826007)(11346002)(956004)(3846002)(230700001)(6116002)(106356001)(316002)(68736007)(53546011)(105586002)(921003)(42262002)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzU7MjM6ZVBaR282bkZKTlVPOWJXM05RbUhTNlVT?=
 =?utf-8?B?blFibHp3ZGZ6SU1uSXNzYkplcG9vUGlWd0Y3a1RmV3pjSjQ2ZHk1TzFsMExM?=
 =?utf-8?B?bUtKcTdrYXUreTZRb28vTlNvVytkSTB6a3ZPVStJYnhicTV2Q1VrVEhKUmkz?=
 =?utf-8?B?TnlYV3dXU29SYVQrRWxseS9JQlhaMlh0bk9DNHhwMnhIS2NTZDFQODhFUlBP?=
 =?utf-8?B?ZXQ4MExrNnZpbEVpNGtKOTM0VjlidVRlcTd4VnRDbzRJTGoxR3FZeXE3eExq?=
 =?utf-8?B?VnQydGxlS2hFQkNUVW92Uy9wYkY2ZW5ONmlRSWErNVAyZlFJQVcxME5WMmVz?=
 =?utf-8?B?ay9Edk5kQTBNdUZ6NUxYZ0RtVUczeXdkbzN0RTZQN1YrYjNJT25GNGxyOUtz?=
 =?utf-8?B?K3ZhRUhRQUVXRHlTazdBekNPZlVVRENVYlRxREVUN1BubGFUanBjb1FVWDlt?=
 =?utf-8?B?aTZzMlVlck1kemVsU2R0K2NkbDgxTGpwR2NldEFHeFR2d2E2WUhQRGNVV2hW?=
 =?utf-8?B?NWFLQTI2U1A2eGJzNXRheWQ4Rmp3T0NKNXVzYWdSTno5Wk9zQmFOT2tvK2NR?=
 =?utf-8?B?NkZ0bGljdSsyUEVoelp3TjdwTm8yYUdwOXdXWm9JdzBYOWEzNGUzVmJYcGdl?=
 =?utf-8?B?cUxWQnZqcGF3eXcwUHZkKzE2cDA5VFZWVGUxODJhbmprQklYOVpwOUQ2SmlS?=
 =?utf-8?B?U2d3bkxTTjQxaWN4NlRWdi84OXlLWnE1L3lSNWV3c2dvNzhld2ZIRERIV1Zm?=
 =?utf-8?B?cXAxcUxPNjZCSVNZcGhpNEowSFlqUUwrSjh6Q0twekM0dU9QdzJkT3p3WjI2?=
 =?utf-8?B?QWlheUo5dXJVZmIwSTJrVnFCTC80bFNLSnRrdENFWkkyYUUyU0hJWTdla3F6?=
 =?utf-8?B?UXlvdEJBK1FkWkZ6Wm5DRHVqeWh2WkNhcFZUcVNSNTl6RmRxWkNRZVJqS1g0?=
 =?utf-8?B?WG0zaTVGeVBXa3dCaEZBNHR1bmtyMjVMaTlsK3ZUazJUbjgzdVBwalRLYTBp?=
 =?utf-8?B?YThlNGRoNklMVmRLa1U5bkhLOVNJaVNKRk01VU5ENXlsSUJVTmxoazI0czhK?=
 =?utf-8?B?SzlsYVdYTWJwUHk5bm5OSDBrQWtvM1BjOVlxTUplU2dta2kxM0kvQkk2SXJm?=
 =?utf-8?B?c1dNZ1VjeEJYWTV2M2x6NzN5eHhoQnBoamcxajg0OGgrRU1tTHc0VXZkS0to?=
 =?utf-8?B?TlNtSW1HcUZrbUt0Q2JNTVJnelJuSy9vdVp6QlpOT2t1Wk1MM0grMUF3VHRB?=
 =?utf-8?B?YU4xbXQ0VUhzQnJEZEpJdzVZd0taQ3RhdThSbWRQU05IcWw2VWU3YUxnOTBa?=
 =?utf-8?B?bjdaeDBmZWN0M0dFeWVYWFZJYUpSNHBBQ3Z3eWVPSXpNU2hTNUZDNmN4WXdp?=
 =?utf-8?B?a1I0NzJ3L2djTGVLTUpubTdZcVhhY3kreVVqdWlFckdZWFJMaXNSdUcvaldh?=
 =?utf-8?B?YXpENXY4WXZ6OWo4YWw4L2xkSzgrZ0FCeklGdlMyNldEZjhWTGFQWmI2UXFj?=
 =?utf-8?B?dWVyVnk3d0VXcElLRmk2NlJRZ1hyUVI5bGdmLzQvUTNBTk9oWG5oeU5Kemhr?=
 =?utf-8?B?cUpMb0Q5Nm40UUp2UzRhQk5JandKcy93OUNOU3JUcUgxM2V6eFJqSmp6dEpn?=
 =?utf-8?B?ZUhoaGtaWEJUaFUzTml5bktSUFN6QzNRNjZnVkR5NFNkZkZjS1loVGl6NkhL?=
 =?utf-8?B?WWprMjlDSmdQUjkzV255bHIzSDd5Z0VaWEpJOWdzcWxwVGlUcFJDQTVPbmZ6?=
 =?utf-8?B?ZWN4d0lqbFhsdmxPMDlRZWRCRjNReEw3bXhYYmh3dFdnamF2Q0gvZUJma2ZB?=
 =?utf-8?B?WWZsVnpET1A4YXVJM1czcTdhbGtHWHFWeThaR3FSNm5kWFZKTFNRaUdqeVJF?=
 =?utf-8?B?QlplTUVlOHptdkVDeVBkWkdkWGlKN083TW5udGNBMnptWmtXVWE3bTdHUlhv?=
 =?utf-8?B?ZUY4T0hyQjVOd2JLd0FIczA2YkxyYzZ2Nzk1SzFKZ09WajhraFp2TU9JdUJJ?=
 =?utf-8?B?Rmppa3V3dU9qcnk4Z0pTOXlOanduek53MVNWaXBJc0Q0WDVURDIzWndEdzZH?=
 =?utf-8?B?N2I2YkpJUDErVzBtSGVLUGt2alVVSXdEY2pHVEF6ZVlkUTlmMStpbE5XT0tP?=
 =?utf-8?B?T2cxWTJIZjRJOEltZWdOelhjWGRCQzBvcGdERmpwa0hrc0l5RE1EM0lQQmFI?=
 =?utf-8?B?VXE0aUhuZUU5NUFlOEF2YW9iV3dsMEJiNVp5RTRBb29kdHJMQ09tV1hYTW1i?=
 =?utf-8?B?SnpkaDhuUGJrNHBIVlcxV2lBYTdONTdwcjRpOW8yRzJGOHBiYnVuMzIzSDlR?=
 =?utf-8?Q?dgTHGpIR/4VTe9Omuo=3D?=
X-Microsoft-Antispam-Message-Info: /RvUcGoBvcBlRZvdDzKCzAAr1cuBw6I/KbI1pSIK0ATyVulrRdeXM7HatRggX4RRqzjUvugEFpqrmuuYr98iJpupjK7mvDVTTpLEYupxq8/1Ws2vMbJ/+1rS2fq0hd/b5RuQ7gHlaO7aUtB3Y8HmDkRtwtCmbXOcKYt6Y1A1rKXF/ImhvyJU9uo+8FAegNnL
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:6P57wxWQeTDhwAHKoK/FBEhQbKCUuX7rffd4dFa/a+90VNc5b+GPUMpZzR281CwEvYltmDPUtSyWVbHXxXfvCXovKWKS/m6Ojnp0sDs5Wz7Ipn/2J3lkdl3FJyOeLxfxmUNrf36Sg4WSqFIDaGFqZjKCHJnGQUokn98d9aVxhsqktxc/lq4zJ+UYvIvtMKgTIoMA4oVFkQ5tEM3JSkiXxkhVXpHn7lYXATpbp6cOhcUnBE3+S5qXmxeILnk3tB2U4xRL9vb1+olMrhPy1+vBGtdO1yPbSYxeZM4ajvCRpQq/pqxTsYI00CX4dFL0kwpvvivYEddhWx2QkG9N6UD2enbYbYwo/9zLMk6ij6PA0ZbldX0ZMBuwLa6PDyT8Slw2h9ADBl/cZtJMp/QsnaeqB8B+fHHL9OMvC3S+pOTzK48PIOgT1AEar3b9si76jKXKRZzG4q322r0IP96zU3HMHw==;5:sK2OrzYC1kuiJg6PseJ/yDanGYGkjN0/6M9Ieh9Ei7htI4OUM6+pMINfiwhBaNW7vJ8dMEKsf3L5kXBzJYmr9jAWYjW/eflvw1bChZd4tOFZwn4qK8LulbB4MVcnnYoFwcMKUDKAqYo3p4/l93TqzpOOzx9a00RbO57LuETtutw=;24:UXKZyKbeqiMGN8lvxJc2yZ8BrpkB1FDhvbWPTPTnTEg9+R1fINjYWAtG6G9OQ/2jBSt81qU6OX3vYmlsA3hxMJ1NYFnmr5xTGGUS3yzejVc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;7:tN9lVaQTv/v4tuwpaKmVnfnSSidJHhHmzATvJ6r9wfohtutn/lbT1aRSG8IF+Ueax9VgTibnouDgQ83Xn7cXGm9ruIsgYkdYfROXgwXb3zSdpatb+Q/HbNUef2avTNtu1fEB/TsazVTBmYcgp3te94YsVksM/6TZ+SmZm26Da8ZNckYs1JfJawl6pBIo4oBDUnWWKBZfKN6sMOlexKyydBthq7kY/sMIEED/R6ZGTCPFrRrC+8rZeOd0IFCRbYRZ
X-MS-Office365-Filtering-Correlation-Id: 84f7ad61-6b9a-46a7-3aed-08d5b42428af
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2018 14:09:31.0000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f7ad61-6b9a-46a7-3aed-08d5b42428af
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-07 15:56, Daniel Vetter wrote:
> On Fri, May 04, 2018 at 03:51:46PM +0200, Peter Rosin wrote:
>> Hi!
>>
>> It was noted by Russel King [1] that bridges (not using components)
>> might disappear unexpectedly if the owner of the bridge was unbound.
>> Jyri Sarha had previously noted the same thing with panels [2]. Jyri
>> came up with using device links to resolve the panel issue, which
>> was also my (independent) reaction to the note from Russel.
>>
>> This series builds up to the addition of that link in the last
>> patch, but in my opinion the other 25 patches do have merit on their
>> own.
>>
>> The last patch needs testing, while the others look trivial. Jyri, are
>> you able to test? That said, I might have missed some subtlety.
>>
>> Oh and the reason I'm pushing this is of course so that the issue
>> noted by Russel in [1] is addressed which in turn means that the
>> tda998x bridge driver can be patched according to that series without
>> objection (hopefully) and then used from the atmel-hlcdc driver (and
>> other drivers that are not componentized).
>>
>> Changes since v1    https://lkml.org/lkml/2018/4/26/1018
>>
>> - rename .owner to .odev to not get mixed up with the module owner.
>> - added patches for new recent drivers thc63lvd1024 and cdns-dsi
>> - fix for problem in the rockchip_lvds driver reported by 0day
>> - added a WARN in drm_bridge_add if there is no .odev owner device
>>
>> I did *not*:
>> - add any ack from Daniel since he suggested "pdev", and I ended up
>>   with "odev" in the rename since I disliked "pdev" about as much
>>   as "owner".
> 
> As long as it's not owner, I'm fine :-) Ack on the idea still holds.
> 
>> - add any port id. The current .of_node (that this series removes)
>>   does not identify the port, so that problem seems orthogonal
>>   to me.
> 
> Hm, from my cursory DT/of code reading last week I thought the port is
> used to lookup the right node, but there's no port thing on the target for
> a phandle? At least that's how current drm_of_find_panel_or_bridge seems
> to work ...

drm_of_find_panel_or_bridge calls of_graph_get_remote_node and that
function looks up the main remote device node, i.e. not the remote
port or endpoint node but the parent node. So, bridges using .of_node
have stored their main device node in the .of_node member. I.e. the
same value as of_node in struct device for all current cases.

Cheers,
Peter

> -Daniel
>>
>> Cheers,
>> Peter
>>
>> [1] https://lkml.org/lkml/2018/4/23/769
>> [2] https://www.spinics.net/lists/dri-devel/msg174275.html
>>
>> Peter Rosin (26):
>>   drm/bridge: allow optionally specifying an owner .odev device
>>   drm/bridge: adv7511: provide an owner .odev device
>>   drm/bridge/analogix: core: specify the owner .odev of the bridge
>>   drm/bridge: analogix-anx78xx: provide an owner .odev device
>>   drm/bridge: cdns-dsi: provide an owner .odev device
>>   drm/bridge: vga-dac: provide an owner .odev device
>>   drm/bridge: lvds-encoder: provide an owner .odev device
>>   drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: provide an owner .odev
>>     device
>>   drm/bridge: nxp-ptn3460: provide an owner .odev device
>>   drm/bridge: panel: provide an owner .odev device
>>   drm/bridge: ps8622: provide an owner .odev device
>>   drm/bridge: sii902x: provide an owner .odev device
>>   drm/bridge: sii9234: provide an owner .odev device
>>   drm/bridge: sii8620: provide an owner .odev device
>>   drm/bridge: synopsys: provide an owner .odev device for the bridges
>>   drm/bridge: tc358767: provide an owner .odev device
>>   drm/bridge: thc63lvd1024: provide an owner .odev device
>>   drm/bridge: ti-tfp410: provide an owner .odev device
>>   drm/exynos: mic: provide an owner .odev device for the bridge
>>   drm/mediatek: hdmi: provide an owner .odev device for the bridge
>>   drm/msm: specify the owner .odev of the bridges
>>   drm/rcar-du: lvds: provide an owner .odev device for the bridge
>>   drm/sti: provide an owner .odev device for the bridges
>>   drm/bridge: remove the .of_node member
>>   drm/bridge: require the owner .odev to be filled in on
>>     drm_bridge_add/attach
>>   drm/bridge: establish a link between the bridge supplier and consumer
>>
>>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |  2 +-
>>  drivers/gpu/drm/bridge/analogix-anx78xx.c          |  5 +----
>>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  1 +
>>  drivers/gpu/drm/bridge/cdns-dsi.c                  |  2 +-
>>  drivers/gpu/drm/bridge/dumb-vga-dac.c              |  2 +-
>>  drivers/gpu/drm/bridge/lvds-encoder.c              |  2 +-
>>  .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |  2 +-
>>  drivers/gpu/drm/bridge/nxp-ptn3460.c               |  2 +-
>>  drivers/gpu/drm/bridge/panel.c                     |  4 +---
>>  drivers/gpu/drm/bridge/parade-ps8622.c             |  2 +-
>>  drivers/gpu/drm/bridge/sii902x.c                   |  2 +-
>>  drivers/gpu/drm/bridge/sii9234.c                   |  2 +-
>>  drivers/gpu/drm/bridge/sil-sii8620.c               |  2 +-
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |  4 +---
>>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c      |  4 +---
>>  drivers/gpu/drm/bridge/tc358767.c                  |  2 +-
>>  drivers/gpu/drm/bridge/thc63lvd1024.c              |  2 +-
>>  drivers/gpu/drm/bridge/ti-tfp410.c                 |  2 +-
>>  drivers/gpu/drm/drm_bridge.c                       | 26 +++++++++++++++++++++-
>>  drivers/gpu/drm/exynos/exynos_drm_mic.c            |  2 +-
>>  drivers/gpu/drm/mediatek/mtk_hdmi.c                |  2 +-
>>  drivers/gpu/drm/msm/dsi/dsi_manager.c              |  1 +
>>  drivers/gpu/drm/msm/edp/edp_bridge.c               |  1 +
>>  drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             |  1 +
>>  drivers/gpu/drm/rcar-du/rcar_lvds.c                |  2 +-
>>  drivers/gpu/drm/rockchip/rockchip_lvds.c           |  2 +-
>>  drivers/gpu/drm/sti/sti_dvo.c                      |  2 +-
>>  drivers/gpu/drm/sti/sti_hda.c                      |  1 +
>>  drivers/gpu/drm/sti/sti_hdmi.c                     |  1 +
>>  include/drm/drm_bridge.h                           |  8 +++----
>>  30 files changed, 57 insertions(+), 36 deletions(-)
>>
>> -- 
>> 2.11.0
>>
> 
