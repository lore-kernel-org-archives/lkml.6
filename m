Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752380AbeC0NEy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:04:54 -0400
Received: from mail-ve1eur01on0127.outbound.protection.outlook.com ([104.47.1.127]:37024
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752169AbeC0NEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:04:51 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v2 2/5] drm: bridge: add API to query the expected input
 formats of bridges
To: jacopo mondi <jacopo@jmondi.org>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180326212447.7380-1-peda@axentia.se>
 <20180326212447.7380-3-peda@axentia.se> <20180327094743.GL27746@w540>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <f35fb82a-d098-475c-4daf-cc2800a70c91@axentia.se>
Date: Tue, 27 Mar 2018 15:04:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327094743.GL27746@w540>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM0PR0202CA0023.eurprd02.prod.outlook.com
 (2603:10a6:208:1::36) To HE1PR0202MB2778.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 397ad042-700e-4df2-818a-08d593e35131
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;3:VONSWt2xbFraIkayK5uW1rVTdqMFTyV/kBIe77iLsda7YmnniNn2qaeYPDxJqTLIbtIhj/ee+L6Qp6ktK/60HI0EObigAL/Am9rMC8VeVg1DLYXnJdWFyCLqWw4WDM2mFU2NNMTHLFmZv6MCBdUArKOCSpGUU2orIwLkU8jUzwNoyDgVu0AeB4qHely0w+2VHZvSGlC7DJKyW/0BDKp4Y8TlydBrKPkkwg8TWcu/9xZJolfdYHDhJSJRsHgISCm7;25:rWASq/xZKDxFW/ffx35Dq2WUcBpSMXURq8dSh66Ma/gyv6Mmpb8pULnzCK11DQohP6d+ZZf92KnOJWZ4qbSxilVEyxi4gD+g38hLEcIE/7F0vfvIKRvYhnXiNvabFCz2rkKlhofhv6BnqO6HhK+YqFMhzGz7pDyeDR8jdjlZ7Ycklck+x/tgIWDYhQTmsOGmObbSQprdt9JA2vpNPWYrCNxYydih+DDA9h9TxI2cF4hHScsKb6+0l9CnyoJJlnneDWctmOwySnF0FyCyNbMdHc3egadrLHQz1qI+wyTWCz0C1nqsk2/6YrjdryAqeRv7ktH16mG0dED5Z12eA83jAA==;31:+CiDRAPNkF0NpOfpcYHxHzcCq+vKOmO6Awb6hepTsHO8lfxQLhiKcTwWkwWM9ytgabzfWc1ujPAvGAdMwzuLGYJw0lbPCQTNQ4+FxEMDH1dH4QzVd0ly+DPuUZ/wgcZojK8kzXU+qJBrNEtiAdSryac4SADF2j+my1Qf4KB5jk+sRJBKCktlB+oYsR5ot+CbedrFQkL50OVVeiClYERHCa2bKDnE7D7DU8OLoHpzkrc=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2778:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2778A991908972822EB60E45BCAC0@HE1PR0202MB2778.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123562045)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:HE1PR0202MB2778;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;4:hfCQLAYU+NZRlKFncOmOC0pdyjp51fr37rubvIRzD0hlRESUfepnhWfDB+15Dph4JzwbMX5p5S5W7hUfE2rx5fhwAPoxB23KSgDYYS2bLukp0LguC8s0OZQ1f6TY+yi1MI2xjhZ3QfcV4uf8zZtYDP6U5qwz2dn4a9vojF2ocsp0t5K+omfjTc0HJWBqLNJWoYmn/JuDuzI75zLNTazIK7nY5zUnL+64ZnsnbIxEUuB9w9Tjqik+QY/bKtu2i4rOhfnmwgIJJt7pspVizO3Uvw==
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(376002)(39830400003)(396003)(346002)(366004)(377424004)(189003)(199004)(4326008)(105586002)(54906003)(316002)(25786009)(47776003)(230700001)(64126003)(8676002)(58126008)(11346002)(86362001)(956004)(2616005)(486005)(486005)(117156002)(68736007)(3260700006)(8936002)(6916009)(5660300001)(106356001)(81156014)(36756003)(446003)(7416002)(81166006)(6666003)(50466002)(6116002)(478600001)(386003)(16576012)(53546011)(65826007)(76176011)(16526019)(3846002)(26005)(186003)(31686004)(77096007)(97736004)(305945005)(74482002)(66066001)(65806001)(6486002)(229853002)(53936002)(2486003)(31696002)(476003)(6246003)(7736002)(2906002)(23676004)(52146003)(36916002)(52116002)(65956001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2778;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3Nzg7MjM6NjY4bjJiTndYc3l3NkdEYTZZVGI2eXpX?=
 =?utf-8?B?TWFjNGhWOHAyb2JRdVhSSnl4aTBGOUZDM3g4R1NHMUxtWDlMbTcwNHhSZVNV?=
 =?utf-8?B?ZkU4Snd3MDRzN2lLR1ZwdXBHdE9JMUMrb2NNSTQzNmR3RllUWDROVlh4aGJS?=
 =?utf-8?B?MlBMVG1MVHF3d28yTWh5dnQ0SEhiT0xyWkFFNmJ6NnFSVEZEbEpscUNZVThQ?=
 =?utf-8?B?T0IxTjNDdXVvNWx3ZGt0djRWb2J1K1ZsVUZlbEVHTUNQVDAvY0hvbEJObkoz?=
 =?utf-8?B?Uk44MHkvYnZKbm5SRzVkRk1pYnltU0ZybVVqcGpFbkhWelJiSTEyTElCS2M0?=
 =?utf-8?B?cHFIZnc5ZTZKR2k2VHQ3SjRjdDRVekJacDlEcXV2cTR2RnkvY0FGWUVPdEEx?=
 =?utf-8?B?cHB2Y1kzUmtTUm9lZlhicmFVZzJJOGZrN2s0K201MVp1MEZadmlNd0JKV0tY?=
 =?utf-8?B?ejR4YXJqYURPOUZCeU4raVFvYnRzd1JHbzArOWJGQWRzcUhhdG1welZHc09F?=
 =?utf-8?B?ZWRRTEp6RWl0elNSQ3dCelRVQjFiWWZyckdUbjVDR09QdmpBRisvUVhYdmta?=
 =?utf-8?B?K1lId1JGMDJpNWpodERnUHg0RUJIaVUxVFBnRFc3cUhmcEFGaUQ1WldOQUk0?=
 =?utf-8?B?VjREV1lRWDR3YWcvaUE0ZU1qRUFyTlJ6ZDNKZTZTL3UwUUZPMkpjMnJXR0ps?=
 =?utf-8?B?V3psSzR6Z3hEZXBvUkMyekowT05ubmljQTJxL0hzbUtiM3ZWU0NNSk9jYzMy?=
 =?utf-8?B?N0w2bi9qMFd3ajcwOGk2NURMMXJyYUMwRE9RKy9FZTRCdTA4Nm9FMG9Qc2Vo?=
 =?utf-8?B?STBMNHZVQ3BwZXJMRURQVFNWdTVFM0lTSEwyTmJGZ25NbUNkL1U0OUZWcWlh?=
 =?utf-8?B?MFFXM2xZL1JVM1BrU2tGSzFpOG5SLzROMnBpK05vOFA5ZzNFL1NVd21WVjc0?=
 =?utf-8?B?Rzd2Vzd0MDJwZSt3RzkvM2N0UXNoclVicmI3RVp2akYzN1dxWDVxWThFTi8z?=
 =?utf-8?B?OUdKbjhEUytDTUs4UFVubkpsSGZKeXYrazEwS1RuT0taUjJMM0YrRGJtc1VE?=
 =?utf-8?B?NkdnMWRRWDNUdzZ5ZzdtSlAyQ2pvZS9nU0hId1gxaUpBaHQwaGVQb3ZvaUFP?=
 =?utf-8?B?aFF4TzVOSm5Vc3RqRHdqUXNNMHh6eFdMMUNrcmdvNFhXSTgvTTI2TnBtQUNk?=
 =?utf-8?B?bjkydjJEK25xOW5BYmtsbUtXYnFBT1Q4NzBaNE9UWmdQdDk4WWR1ek54ZlAz?=
 =?utf-8?B?czgxUkUxS1A3SDlNNlpTWnFIdE5IWnE4aWlURHhFT3UwdTBwS3NNTUozRE85?=
 =?utf-8?B?WStLcG0wYWI4Y08xRDRKb2d4a0d6UnR4dmZvRFBQcHpURDVoeG9aS1RvVW5p?=
 =?utf-8?B?Mm1oMDg5VUxDQ1VnSEdqdWdIVGxIS2EvUWZoZnc2MzVtK0pnUld5TkkvSTF5?=
 =?utf-8?B?Y2Y0R29xQWFsZ1ZGQWVKVDJIdGVIVG4yeVdFMFNTLzZQOXdCSCtiNWk3VHhV?=
 =?utf-8?B?U3VaZnNkVngyUWMrcTBFMWdHLy9ybk5WTGZ2RTR3S1EzNi9zS0NKdjhWd0Nv?=
 =?utf-8?B?VEFCandJVXljalpZa2N3OVFtdEM5RFRuUXBPMW94c2tHMnkzekdQTlB2OThh?=
 =?utf-8?B?eUxHZEd1ZEFKSGQwZm9NdjFtb0tvUGtlWW91Z1g3Tzc5ZFJsc0pNZWwvNTRB?=
 =?utf-8?B?MXc5MVZEYTJSMkdPN1VKaStYam4rV0p1eldFc0d0bkNoTnlCYkhBUHNiK1Rx?=
 =?utf-8?B?eFFZWmxHUGZsMi8ySUY5MkROTCtBTkRJWmVhR0RFakhqZWY1Tk9YdVhDeHAy?=
 =?utf-8?B?UVVuMVNGaGllek5vaDFKazRpRzVMSW9Ucks4SUhQWFQ0WS9mSjgySmtBNE9h?=
 =?utf-8?B?TnZPTkZBY05JQTdVMXltcnlCVFFvcDgyVHV4TDdnUkJnZGtVRGhGb1FhcWk2?=
 =?utf-8?B?T05IcXNjdStDWG9QVysyak9xQiszUXp5Tnhmb3lqMEc4NWVHOEtISWhCbk1x?=
 =?utf-8?B?Nit5bWR6MUZtKzNCRnBjakpFaUFzUk91ZFpvT2twYjJHNVhyU0JGZXhUVnY0?=
 =?utf-8?B?QVgrOFVtbWdPakpndWE3OUdUSmxFTEw5dStETUxvRVhBSCtDR0p1am5nTVdn?=
 =?utf-8?Q?7B08+hKu4bWx7pB6Akg1jcaDGxEQr5Bq98PR5vyefDUiT/?=
X-Microsoft-Antispam-Message-Info: r6ddiXaDJT/JEyJ1RiPu6269XAdr7RzrMTg7k9S7J0zUzls7B2nY/Qpc2+Zn/a8CF7XLQ5pD/59ftCGMheGjembEhYb2cdbV9/QYstJrM1AsedMk9PbEWui08YT2ylExId5FdYex9PJQ+McyKihb3talofw2cWpd7Wvv1lj+gLx2dMnAmnxtnfb4q2rgu85M
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;6:qpSJryCsdNssrFMHkqhF0ExCmmOGN/JBfgTxu5uHKmAK1W4BF6F0vNvSebwmZWSdXgh+PoVC4xl7rlR8g4Gj/OOuK9sz6VhOAfsa6X/RjXLzqaWNx90oc56CsDC8qdKxYEkRCKdSG0BwjtQjwhimvUhi9oUx45qlbU640WHF4861G/har8vBZLwz8ozOSMGdLl3gt1xD5LRMYQdHo9303CYSBP7Kd4Fln+vruiyAkADeYoS0jglne2t3GoklnE8Z2nlutevlShMvr9HoVpBJU919p9ciN+yh+CVhrn6bvkz8hq1sucldmRy/AHlh5ekdvOWclci3ZbHpHnq3nWw69fW1ldJ4a1JQz7skeztqGvFS90XnHeW2W22dNrReq8h/hs0L4PDarazWXQoo6y1RG4rx9+L+Rvj/+45NvX1jIzIRCdPbM0kb1IyRJpyO4cCSMSp2fJi4EjA1yk+vOQurTw==;5:/+EJuTjSZJu7/D6Xd+d1aVl9L5pJNF1BzxzBmWC7Q6A41dWlvQDGBrd4STG9Xvcqm96L+iG9xccuODVHT32ktBYAFwAZ5+pTWxzKoUDznftPM1qBj2Z78Dxl8t/HQl+CX0Mn7nzyHYy/QoGNiIPlVrCB7NRwXK3/09g0wLNfbDA=;24:DT4KH1A6cVbiVk3GiBvy8jqMiAtPwONDUC8dd9mMeaCQNsATQXXhh83YRXaW6aitx2lWFVEfOm+bcxGHxkLUNHg6Wpj1sUtESnaJsvPOvNk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;7:Tn0bi1rAUqWXbTeaRXTN+Sh0yzoBuYyy5OJeGePAvBi9cWNAMW+6r59Zh3zq53UgPMId7zBrncs0xRDDcKvvcwjwHQGjuqn5YI6DGZGm6kFDuhXUk0R7r/A/enuzIZgEiaDTfpvSMTni6w6FKcCUop+av8/ula6ogOv3FzY3etnKMDNYnLpSs571xhOEWL/zRdV/yPJA1IGaYI6uYGp76iLjT0EaVGA5vaxnYClgHrPsZ7vr3i++AQVRH2gjFjmY
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 13:04:45.9976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 397ad042-700e-4df2-818a-08d593e35131
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2778
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-27 11:47, jacopo mondi wrote:
>> + * RETURNS:
>> + * The number of bus input formats the bridge accepts. Zero means that
>> + * the chain of bridges are not converting the bus format and that the
>> + * format of the drm_connector should be used.
> 
> How do we get to the connector format from a bridge that has maybe
> other components in between in the pipeline?

Forgot to write something here in my previous reply, sorry...

The chain of bridges do not end with the connector in the in-kernel
representation, IIUC. So, I think it is up to the caller to find the
format desired by the connector. See patch [5/5] for an example.

Maybe the connector should be passed in as an argument?

Cheers,
Peter
