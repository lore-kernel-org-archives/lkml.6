Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753164AbeDQMen (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:34:43 -0400
Received: from mail-db5eur01on0084.outbound.protection.outlook.com ([104.47.2.84]:51258
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752800AbeDQMel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:34:41 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com;
Subject: Re: [PATCH v2 5/5] ALSA: xen-front: Implement ALSA virtual sound
 driver
To: Juergen Gross <jgross@suse.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, perex@perex.cz, tiwai@suse.com
References: <20180416062453.24743-1-andr2000@gmail.com>
 <20180416062453.24743-6-andr2000@gmail.com>
 <f8ec79c7-1b6f-dd00-5bd3-fc9fb8b42de1@suse.com>
 <e77fe463-68aa-b117-84c5-6dc729a3df42@gmail.com>
 <06ce3d52-5a38-dd1e-90b7-7b9414b6819d@gmail.com>
 <d29712f2-80de-203a-8246-243adcdab734@suse.com>
From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <04e57166-eab4-c27a-fb9f-900f06484385@epam.com>
Date: Tue, 17 Apr 2018 15:34:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <d29712f2-80de-203a-8246-243adcdab734@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.223.209.56]
X-ClientProxiedBy: PR2P264CA0038.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::26) To AM4PR0301MB1939.eurprd03.prod.outlook.com
 (2603:10a6:200:38::15)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0301MB1939;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0301MB1939;3:lMsa6JOeeD/N/CmXD6U3mtU2x4T+fNW0dsq1UVU/d/tR/jPsztiwWq56xX/addNnMgyId3VGTBxq3D8SG7sN8v32rpTAkEgeu18JjRXdRl4UGFTNECYkFnXfGD2GDf5vv5Jq6vauCBqIfKrJugETr3TKHmyyz3NpGUYGsgGTiJKlnGdWgZfaJgr7lE93e2MHa2ABhs8iX/UwdVjeBMxLb8Shq77oRyZO+Oxm2fPd64hIkM6xj96BUI+7L2xnh4u5;25:yNuDlPs9gMbtjipSpqFaWsfWxQP5ZUwtY3dOMnuoBXdDEPNaH8Js4QIS3cHn2piHDSHMnMz4iTBxzv+YBpmE82ncW6oPfNteguj3mYw7gRBePtByzzLsl2RQBdwFIuJYT4RSvzpkGj3q73T1zX1jFCgTifXlCsR2+Yo8LQGTK7pWiTZNJWGB/HjmNSUqHSlYAMQ0TuUAeSogXK6DpEh65fKY1BKQqvxFW2nxOJaHsSvt9SKRRJkYwWfHJ2Mzvydm05N7S697xOAw04Lm+m5/qhxtOfa5VbXRabfJ/zQdAMG+IfOfUrITDBikB/9fo+gdgtfyVH9Q+Cp37prefJRrrQ==;31:zBfWBEtvmQd0IJlYkE6biddkbeB7HEAFifZqEkwCGkopLsdLhcb97l+GKFY3g83xToYesFJwNj/e9w/4OSy04brIvNZ1By2X3P9XkPK4IbEWHYN0w6o82oBGgKVG76mUb8eZ/yYWVfU1SXuXMVbKztqzTiH0w4dzy5DpeHJxROlfwOC6w6CDye9dscmtSJRv0jHAHeWzyTnPCmw+cl4ZoOLvPnZZaQkvh6KyFZejQUM=
X-MS-TrafficTypeDiagnostic: AM4PR0301MB1939:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0301MB1939;20:X/euZFrkU1Q/kcYZS4JDX7fSWYIOzg+pexTIm5kf7Go5ZfvE/r/Cjirf6jK+NcdExmiY187bQ8YPu3YGNmtReCQEQFZzBBVCTyvHCHQRJgrfje1avLr/qS8qA8EE2Rs6hOFsF41m3OgF+VbadURRw5HuPK3hoI8A4Tv1pyyZOci0OWzY6OrKDYjYGcco570q4s7m46lHPyxWvaODqNzHpil2CJxWeMLyR5PkKcoX3ofg++5PBQCNoLvcI4B45EgN04LZnPCDm0xXiCyDA9vnuj99QuK+DfQtS30AXSx5WDbSRsLtGmo6QGEXHHMyhZondM/Czlv/NKYtvgy3L8n+KaHHY8PbWfTKzm6tXsZ7SrTFgClZbi8QHy5RyV2RFM8WC/mnNn0TpwxT4LLLOeZzmMOW5MkwezMKIPhk+0OoLQFVFMqO/E2ox9tlQKa2alT4gW2HvecC+gS2APEjjyk7TT89rA0pIW/kQ+vQUl8n4taa+MIZFEN+eQtHB4MkzgWb;4:Dq9R4hZxX8+X0PfvbQr9u5cF9xC9MKmak1jkYO7bgHXa0muDJEjCRHMFCmaQCj5HddG14Gx4wOALW7AcJj2K5GaAc0Q2rK+UKCd0ZPV6dO7/cgt86SotFxwwhs+zHGsNKVaK/Bgxh1AvmqnMMwDBGLg1cTfWXjugRErZC3PLBNrURvkk3TAR6S0MvLe/BidqWB6mQv3nyf+EzHPspnMLTSe4rYHCPkl/Us8At5yGa2oC+/SP74PmwEr9RZ1WWj7RWF6gNfnzKg7+GccH+KDR46C0GqZMdJE3F9ZA/vzzbgdenSNs7KybB4YlxGa40Ut9
X-Microsoft-Antispam-PRVS: <AM4PR0301MB1939D3C10830A2BF35E70E3CE7B70@AM4PR0301MB1939.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(4114951738403);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501327)(52105095)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:AM4PR0301MB1939;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0301MB1939;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39380400002)(346002)(396003)(39860400002)(376002)(189003)(199004)(16526019)(105586002)(65806001)(65956001)(66066001)(47776003)(59450400001)(6246003)(386003)(72206003)(7736002)(39060400002)(93886005)(55236004)(53546011)(26005)(77096007)(11346002)(476003)(478600001)(68736007)(446003)(2616005)(305945005)(486006)(31686004)(53936002)(6666003)(64126003)(5660300001)(106356001)(956004)(25786009)(6116002)(186003)(2906002)(3846002)(2870700001)(50466002)(52116002)(6486002)(16576012)(36756003)(31696002)(65826007)(80792005)(8676002)(97736004)(76176011)(316002)(58126008)(81156014)(23676004)(52146003)(2486003)(81166006)(229853002)(8936002)(110136005)(86362001)(67846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0301MB1939;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAzMDFNQjE5Mzk7MjM6RzZNVFJKL1Y2UDU5WExqVWt5RUVZSUNE?=
 =?utf-8?B?aFRrVG13K2gxTjYrRkh6TXhoTitYTGF4T2dlVEtyVTVLT25DSE0vdzFRSHJD?=
 =?utf-8?B?bm95d0lDZm9BeTRpdW9FVWpSYVhmcXR2SFphSU1pd2hyYkx6N3FVbHJCb0Qx?=
 =?utf-8?B?WGVya2ZSd00yQWlNWk1QVGwvZkx2dklzUEZRSncrdjROa3d1MnE5YUlWM3lI?=
 =?utf-8?B?NXNETWlHSkl0WmgvcGdXa3lxZFFpYnZ0VXR6T3hBQmlmZW8wbSt2RW5SWjRD?=
 =?utf-8?B?TmswSGlaYWk2dnZiUkU5VmhEaUhUSEE2bHJ5emZLVU5TYlVhMHJVc3JnWktC?=
 =?utf-8?B?Tkp6MzhXRVNYcDgxb3Zpc0FybGduSjBzQVFpWGxvV0pvakVNUFo0K2RrQmpk?=
 =?utf-8?B?OVFmWFZscEtrUUJDZzJaeFkwWitxT2xPY2NiRUVUZ2RVRmtCck9xSXB6dHZZ?=
 =?utf-8?B?dTBxNXFPZVJxQkhZelRzT2N1bWlacFNGNlBESEwyT2RXTjlVWjRreEJDczl1?=
 =?utf-8?B?b0VXMmpJUHI3bzNPeGFVWnZ4TEJLamcvYVdFTllEZnFTRFduRlFvTTFHb2lp?=
 =?utf-8?B?cjNmNlFlSW96T3haNnVyTUVSVUprYjBkRHVMdjM2SGJ4azhaR1NyV0RYYmdm?=
 =?utf-8?B?N3IwbENBUzFzWVdEZjRyOEphQW93OWgwTjlWMWw3UExMQVlIOXRPL2FNQjJm?=
 =?utf-8?B?bjgyQXpoREduSVVmRDd4bldaeUxiR3hPNTRXRWFkODFwaiswajBVY2V4eElO?=
 =?utf-8?B?Q0ExbHcvNjNNZ295VGtySGVNcDJKdGUxYTJVRDlVMWNaSGxTRUNyUGIxTmNP?=
 =?utf-8?B?cnlIUzc1TjM1endrYlRjaHVzMjVycDBXTFlZSFFWcmM1Z3p5TGlNZkRvOFNB?=
 =?utf-8?B?WGtXakdPc3ZSd2JIWTFZZ2x3ZlN4WHZIREpiTTcxWGszM3BEaXBBcEdrOGJx?=
 =?utf-8?B?bUZsU2VsNEtTVVhvYWg5VWN1aXVJRm1HcGJFZHpDVW9kcWM3U2hDMHF3NXlz?=
 =?utf-8?B?RFVsV2xmblRMK1M1VTZ3ZFBMWTJNVXZCNUVnRFZDTG9GUzFSbUdiRnp4aWo2?=
 =?utf-8?B?UjNDcTdlRlFFd0QxN1VlSGxQUDBHUjNqeGIwbnc5YjQyaE83YmkzajlBWW1o?=
 =?utf-8?B?alFGMzlUYTdGRmp5TWNZV2FRV2xQQ1haUVlMbk5scm9Wd21CbmN6dXQ5a2NJ?=
 =?utf-8?B?bHN3NUlmVS9CRDJTemtRRkFvTWtSOHY2bEs2aVl4MGpSb1EwbzRKNDlMQTBm?=
 =?utf-8?B?K2hvZGRUVzY0dk5DMHBqQkc0eVNuS0VCTmNEVnhYbnVyaDhxWHlOa2luaDcr?=
 =?utf-8?B?VEJ4eThxSkRYWE90ZGlqQW9zOXFCa09QV2NjRUJVdk16Um5sMWNlYVBNdnI5?=
 =?utf-8?B?dzF0Vy9weUxnM3dOUHhwRGxNRFFXdlhOOU04Wkw0a3hydnRHbUtCUUNIdm03?=
 =?utf-8?B?Z29zTk0vb0dYZ3U2VFpZUlhFc1NaZDNJSkZTSnlBRUhteitFTkN3TTU4OGJl?=
 =?utf-8?B?Znp0YTJCSU9Za05VT1BtcEFHNjRpZ0VWU0RHRWRyelIrZTdMVmJ1d2JnRWdS?=
 =?utf-8?B?b2g5V1NRb05Tckd4SjlrQ0VWSm5Bc0xXLzR5K2FnS1RWbVRwMW5rSjhZOTRs?=
 =?utf-8?B?bklRVE9KL21vcWtwa0R4NzY0Q2o4czEwbkY1MWhIckFndE8rZ2lxYjlUY2Jo?=
 =?utf-8?B?VjBvczcrQTd6cld0QWp1dmx1OTQ2TEJYVWxKNWdnY3dJM1FObE14T1ZnSTFO?=
 =?utf-8?B?elBreXRybjNNL3Z1RW03QVJmQ1NBajFFWUtCL294aUZVbmIzeVA4b2NwK1By?=
 =?utf-8?B?UVZ5ZktaQ3dBOXpvZVZhL044SDkxdm9FOXlvMFZZMm9wWmtid0pTU2ZRSlM2?=
 =?utf-8?B?Q0UrRERYdW5wUXBMQVY2V09CYm1Mb2I1WjA5TVRJUGpkVXEzKzZ5VGVpQTFk?=
 =?utf-8?B?M0N0OHFoVmE3Tnd2NWhkWEJYMVAyRGlhQ1paOXFvbER2blpvUXpjbGsxNUFO?=
 =?utf-8?B?ZENoeE5KNWJIenpLZlRpZ09wc29Wa1doWXNQTW8yNkR2c1dsa1ZZa3dTV0FH?=
 =?utf-8?B?ZjhZa2R4TUhVbEd3UUdyTzlkakdmaWJOUjJDdENiSUlYRTZJdkt1V09scDE1?=
 =?utf-8?B?bUVPdz09?=
X-Microsoft-Antispam-Message-Info: OwRmqJ6p4+sTEUX4uXQxeeGiGowKH3k7RPbWXFlg3nizYJ9yfJMdefqQ746V5VIGguJ3VEIZEpgm7GHKNlRc+VRJ56kwEGGbmBSYsM6scmQFiyMGZuSZZx6lznckJAoBLbQwIRZxT4ephUnYRkofwReeRv9vqsv1bDfG9zHZKwQZnkPUO4WW/JbLu5KlH8cV
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0301MB1939;6:9Xfl7qr+3bYERvRl6fwWR9tr36eKyoP0jgskmZBEEgh9flXEjYlOgnospz+fmq4TkLrhBxMIOLTP6JUv/NYa3rSzxVsfyuvR3RlpQb1zyWWeJpM8ytcHfMm2QCFg9M17L0tqGMN2JzaSxxYo1J/W23Bs80BGXt4tU9XadHlrhftofdTIa+DOKFXik5kGhVHcuJ9Zh7FC+JfQlq1T/Xdbl3K0tTneFB0hcXV8jwXoGYDjTuCcxcZhezs5yhOEdvz0ghekIxlw0+sWPgstRISzdtnrqlwX+ATVc56UjDhLTtdq//R8ERlExITVtRCNPkAi9ysfXFYsARM4Kt3x5cm3IcrExaDmegXU5fC8jKXjL7SgdTMzqYIGqOkqD48cnzt00x5FE5uC0fARSe+BaLPBnxta6tR3LW/CaGueuBULy//vcTp9L90VWR/zvr2RNtzDAwzfoLMjnoi1p3BkqhN8zw==;5:V9+GT8qjNauzDDGjr/uSH2w6rsMRp/lv0Uf6UlhhFEg3GG82ubOwG2U3/9i/uQHilYvZqNS6o49NIs4XWVZIlRR6jTTgrg7wd6pRx9sf8fk8LkTfpkq3aXdHEdhvFyoWWrWaDxqCE2TOoyRWNtxjRKZvvEr+a4Iu+LxiWQwmHQE=;24:coO6HBly0KKWEedEskELnB2GKUQ0WP6kTke6ebnxpbl1IDb2SPV0jGTyvZe5kFcCRhVTQ5ZUj3JM+IhkUe4ki6n4x2b8PVMVMNjdQD2/CpI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0301MB1939;7:Dn35nmx3OyKl1k9KgpzSXpVQapheHKct5AGaOpg0oG8k5vrV+7FeM/Wg+r3dAtzysUK1FxfevumxoLg2Ozt5n/P64l/H2LzrLoKwK7w0guFg8HVhImr9TH7pkQ33hTosKZx2rxUkeWMvjXz1U1a9Q6TimaJYPNcsW5TJbYmFrxnMNpLebwwSkEHNmWAR/avc++OSTz/UOYw44h+4KqSTbzaxtqqIpMOHC8a5k/69RMlVzSwPXpBW67IqSwFwEj47
X-MS-Office365-Filtering-Correlation-Id: 6f3047b1-0594-4f6b-db9b-08d5a45f95bd
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 12:34:37.7482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3047b1-0594-4f6b-db9b-08d5a45f95bd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0301MB1939
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2018 03:32 PM, Juergen Gross wrote:
> On 17/04/18 14:26, Oleksandr Andrushchenko wrote:
>> On 04/17/2018 02:32 PM, Oleksandr Andrushchenko wrote:
>>> On 04/16/2018 05:09 PM, Juergen Gross wrote:
>>>> On 16/04/18 08:24, Oleksandr Andrushchenko wrote:
>>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>>
>>>>> Implement essential initialization of the sound driver:
>>>>>     - introduce required data structures
>>>>>     - handle driver registration
>>>>>     - handle sound card registration
>>>>>     - register sound driver on backend connection
>>>>>     - remove sound driver on backend disconnect
>>>>>
>>>>> Initialize virtual sound card with streams according to the
>>>>> Xen store configuration.
>>>>>
>>>>> Implement ALSA driver operations including:
>>>>> - manage frontend/backend shared buffers
>>>>> - manage Xen bus event channel states
>>>>>
>>>>> Implement requests from front to back for ALSA
>>>>> PCM operations.
>>>>>    - report ALSA period elapsed event: handle XENSND_EVT_CUR_POS
>>>>>      notifications from the backend when stream position advances
>>>>>      during playback/capture. The event carries a value of how
>>>>>      many octets were played/captured at the time of the event.
>>>>>    - implement explicit stream parameter negotiation between
>>>>>      backend and frontend: handle XENSND_OP_HW_PARAM_QUERY request
>>>>>      to read/update configuration space for the parameter given:
>>>>>      request passes desired parameter interval and the response to
>>>>>      this request returns min/max interval for the parameter to be used.
>>>>>
>>>>> Signed-off-by: Oleksandr Andrushchenko
>>>>> <oleksandr_andrushchenko@epam.com>
>>>>> ---
>>>>>    sound/xen/Makefile                |   3 +-
>>>>>    sound/xen/xen_snd_front.c         | 193 ++++++++-
>>>>>    sound/xen/xen_snd_front.h         |  28 ++
>>>>>    sound/xen/xen_snd_front_alsa.c    | 830
>>>>> ++++++++++++++++++++++++++++++++++++++
>>>>>    sound/xen/xen_snd_front_alsa.h    |  23 ++
>>>>>    sound/xen/xen_snd_front_evtchnl.c |   6 +-
>>>>>    6 files changed, 1080 insertions(+), 3 deletions(-)
>>>>>    create mode 100644 sound/xen/xen_snd_front_alsa.c
>>>>>    create mode 100644 sound/xen/xen_snd_front_alsa.h
>>>>>
>>>>> diff --git a/sound/xen/Makefile b/sound/xen/Makefile
>>>>> index f028bc30af5d..1e6470ecc2f2 100644
>>>>> --- a/sound/xen/Makefile
>>>>> +++ b/sound/xen/Makefile
>>>>> @@ -3,6 +3,7 @@
>>>>>    snd_xen_front-objs := xen_snd_front.o \
>>>>>                  xen_snd_front_cfg.o \
>>>>>                  xen_snd_front_evtchnl.o \
>>>>> -              xen_snd_front_shbuf.o
>>>>> +              xen_snd_front_shbuf.o \
>>>>> +              xen_snd_front_alsa.o
>>>>>      obj-$(CONFIG_SND_XEN_FRONTEND) += snd_xen_front.o
>>>>> diff --git a/sound/xen/xen_snd_front.c b/sound/xen/xen_snd_front.c
>>>>> index 0569c6c596a3..1fef253ea21a 100644
>>>>> --- a/sound/xen/xen_snd_front.c
>>>>> +++ b/sound/xen/xen_snd_front.c
>>>>> @@ -19,10 +19,201 @@
>>>>>    #include <xen/interface/io/sndif.h>
>>>>>      #include "xen_snd_front.h"
>>>>> +#include "xen_snd_front_alsa.h"
>>>>>    #include "xen_snd_front_evtchnl.h"
>>>>> +#include "xen_snd_front_shbuf.h"
>>>>> +
>>>>> +static struct xensnd_req *
>>>>> +be_stream_prepare_req(struct xen_snd_front_evtchnl *evtchnl, u8
>>>>> operation)
>>>>> +{
>>>>> +    struct xensnd_req *req;
>>>>> +
>>>>> +    req = RING_GET_REQUEST(&evtchnl->u.req.ring,
>>>>> +                   evtchnl->u.req.ring.req_prod_pvt);
>>>>> +    req->operation = operation;
>>>>> +    req->id = evtchnl->evt_next_id++;
>>>>> +    evtchnl->evt_id = req->id;
>>>>> +    return req;
>>>>> +}
>>>>> +
>>>>> +static int be_stream_do_io(struct xen_snd_front_evtchnl *evtchnl)
>>>>> +{
>>>>> +    if (unlikely(evtchnl->state != EVTCHNL_STATE_CONNECTED))
>>>>> +        return -EIO;
>>>>> +
>>>>> +    reinit_completion(&evtchnl->u.req.completion);
>>>>> +    xen_snd_front_evtchnl_flush(evtchnl);
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static int be_stream_wait_io(struct xen_snd_front_evtchnl *evtchnl)
>>>>> +{
>>>>> +    if (wait_for_completion_timeout(&evtchnl->u.req.completion,
>>>>> +            msecs_to_jiffies(VSND_WAIT_BACK_MS)) <= 0)
>>>>> +        return -ETIMEDOUT;
>>>>> +
>>>>> +    return evtchnl->u.req.resp_status;
>>>>> +}
>>>>> +
>>>>> +int xen_snd_front_stream_query_hw_param(struct
>>>>> xen_snd_front_evtchnl *evtchnl,
>>>>> +                    struct xensnd_query_hw_param *hw_param_req,
>>>>> +                    struct xensnd_query_hw_param *hw_param_resp)
>>>>> +{
>>>>> +    struct xen_snd_front_info *front_info = evtchnl->front_info;
>>>>> +    struct xensnd_req *req;
>>>>> +    unsigned long flags;
>>>>> +    int ret;
>>>>> +
>>>>> +    mutex_lock(&evtchnl->u.req.req_io_lock);
>>>>> +
>>>>> +    spin_lock_irqsave(&front_info->io_lock, flags);
>>>>> +    req = be_stream_prepare_req(evtchnl, XENSND_OP_HW_PARAM_QUERY);
>>>>> +    req->op.hw_param = *hw_param_req;
>>>>> +
>>>>> +    ret = be_stream_do_io(evtchnl);
>>>>> +    spin_unlock_irqrestore(&front_info->io_lock, flags);
>>>>> +
>>>>> +    if (ret == 0)
>>>>> +        ret = be_stream_wait_io(evtchnl);
>>>>> +
>>>>> +    if (ret == 0)
>>>>> +        *hw_param_resp = evtchnl->u.req.resp.hw_param;
>>>>> +
>>>>> +    mutex_unlock(&evtchnl->u.req.req_io_lock);
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>> +int xen_snd_front_stream_prepare(struct xen_snd_front_evtchnl
>>>>> *evtchnl,
>>>>> +                 struct xen_snd_front_shbuf *sh_buf,
>>>>> +                 u8 format, unsigned int channels,
>>>>> +                 unsigned int rate, u32 buffer_sz,
>>>>> +                 u32 period_sz)
>>>>> +{
>>>>> +    struct xen_snd_front_info *front_info = evtchnl->front_info;
>>>>> +    struct xensnd_req *req;
>>>>> +    unsigned long flags;
>>>>> +    int ret;
>>>>> +
>>>>> +    mutex_lock(&evtchnl->u.req.req_io_lock);
>>>>> +
>>>>> +    spin_lock_irqsave(&front_info->io_lock, flags);
>>>>> +    req = be_stream_prepare_req(evtchnl, XENSND_OP_OPEN);
>>>>> +    req->op.open.pcm_format = format;
>>>>> +    req->op.open.pcm_channels = channels;
>>>>> +    req->op.open.pcm_rate = rate;
>>>>> +    req->op.open.buffer_sz = buffer_sz;
>>>>> +    req->op.open.period_sz = period_sz;
>>>>> +    req->op.open.gref_directory =
>>>>> xen_snd_front_shbuf_get_dir_start(sh_buf);
>>>>> +
>>>>> +    ret = be_stream_do_io(evtchnl);
>>>>> +    spin_unlock_irqrestore(&front_info->io_lock, flags);
>>>>> +
>>>>> +    if (ret == 0)
>>>>> +        ret = be_stream_wait_io(evtchnl);
>>>>> +
>>>>> +    mutex_unlock(&evtchnl->u.req.req_io_lock);
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>> +int xen_snd_front_stream_close(struct xen_snd_front_evtchnl *evtchnl)
>>>>> +{
>>>>> +    struct xen_snd_front_info *front_info = evtchnl->front_info;
>>>>> +    struct xensnd_req *req;
>>>>> +    unsigned long flags;
>>>>> +    int ret;
>>>>> +
>>>>> +    mutex_lock(&evtchnl->u.req.req_io_lock);
>>>>> +
>>>>> +    spin_lock_irqsave(&front_info->io_lock, flags);
>>>>> +    req = be_stream_prepare_req(evtchnl, XENSND_OP_CLOSE);
>>>>> +
>>>>> +    ret = be_stream_do_io(evtchnl);
>>>>> +    spin_unlock_irqrestore(&front_info->io_lock, flags);
>>>>> +
>>>>> +    if (ret == 0)
>>>>> +        ret = be_stream_wait_io(evtchnl);
>>>>> +
>>>>> +    mutex_unlock(&evtchnl->u.req.req_io_lock);
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>> +int xen_snd_front_stream_write(struct xen_snd_front_evtchnl *evtchnl,
>>>>> +                   unsigned long pos, unsigned long count)
>>>>> +{
>>>>> +    struct xen_snd_front_info *front_info = evtchnl->front_info;
>>>>> +    struct xensnd_req *req;
>>>>> +    unsigned long flags;
>>>>> +    int ret;
>>>>> +
>>>>> +    mutex_lock(&evtchnl->u.req.req_io_lock);
>>>>> +
>>>>> +    spin_lock_irqsave(&front_info->io_lock, flags);
>>>>> +    req = be_stream_prepare_req(evtchnl, XENSND_OP_WRITE);
>>>>> +    req->op.rw.length = count;
>>>>> +    req->op.rw.offset = pos;
>>>>> +
>>>>> +    ret = be_stream_do_io(evtchnl);
>>>>> +    spin_unlock_irqrestore(&front_info->io_lock, flags);
>>>>> +
>>>>> +    if (ret == 0)
>>>>> +        ret = be_stream_wait_io(evtchnl);
>>>>> +
>>>>> +    mutex_unlock(&evtchnl->u.req.req_io_lock);
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>> +int xen_snd_front_stream_read(struct xen_snd_front_evtchnl *evtchnl,
>>>>> +                  unsigned long pos, unsigned long count)
>>>>> +{
>>>>> +    struct xen_snd_front_info *front_info = evtchnl->front_info;
>>>>> +    struct xensnd_req *req;
>>>>> +    unsigned long flags;
>>>>> +    int ret;
>>>>> +
>>>>> +    mutex_lock(&evtchnl->u.req.req_io_lock);
>>>>> +
>>>>> +    spin_lock_irqsave(&front_info->io_lock, flags);
>>>>> +    req = be_stream_prepare_req(evtchnl, XENSND_OP_READ);
>>>>> +    req->op.rw.length = count;
>>>>> +    req->op.rw.offset = pos;
>>>>> +
>>>>> +    ret = be_stream_do_io(evtchnl);
>>>>> +    spin_unlock_irqrestore(&front_info->io_lock, flags);
>>>>> +
>>>>> +    if (ret == 0)
>>>>> +        ret = be_stream_wait_io(evtchnl);
>>>>> +
>>>>> +    mutex_unlock(&evtchnl->u.req.req_io_lock);
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>> +int xen_snd_front_stream_trigger(struct xen_snd_front_evtchnl
>>>>> *evtchnl,
>>>>> +                 int type)
>>>>> +{
>>>>> +    struct xen_snd_front_info *front_info = evtchnl->front_info;
>>>>> +    struct xensnd_req *req;
>>>>> +    unsigned long flags;
>>>>> +    int ret;
>>>>> +
>>>>> +    mutex_lock(&evtchnl->u.req.req_io_lock);
>>>>> +
>>>>> +    spin_lock_irqsave(&front_info->io_lock, flags);
>>>>> +    req = be_stream_prepare_req(evtchnl, XENSND_OP_TRIGGER);
>>>>> +    req->op.trigger.type = type;
>>>>> +
>>>>> +    ret = be_stream_do_io(evtchnl);
>>>>> +    spin_unlock_irqrestore(&front_info->io_lock, flags);
>>>>> +
>>>>> +    if (ret == 0)
>>>>> +        ret = be_stream_wait_io(evtchnl);
>>>>> +
>>>>> +    mutex_unlock(&evtchnl->u.req.req_io_lock);
>>>>> +    return ret;
>>>>> +}
>>>>>      static void xen_snd_drv_fini(struct xen_snd_front_info *front_info)
>>>>>    {
>>>>> +    xen_snd_front_alsa_fini(front_info);
>>>>>        xen_snd_front_evtchnl_free_all(front_info);
>>>>>    }
>>>>>    @@ -45,7 +236,7 @@ static int sndback_initwait(struct
>>>>> xen_snd_front_info *front_info)
>>>>>      static int sndback_connect(struct xen_snd_front_info *front_info)
>>>>>    {
>>>>> -    return 0;
>>>>> +    return xen_snd_front_alsa_init(front_info);
>>>>>    }
>>>>>      static void sndback_disconnect(struct xen_snd_front_info
>>>>> *front_info)
>>>>> diff --git a/sound/xen/xen_snd_front.h b/sound/xen/xen_snd_front.h
>>>>> index 9c2ffbb4e4b8..7adbdb4d2019 100644
>>>>> --- a/sound/xen/xen_snd_front.h
>>>>> +++ b/sound/xen/xen_snd_front.h
>>>>> @@ -13,17 +13,45 @@
>>>>>      #include "xen_snd_front_cfg.h"
>>>>>    +struct card_info;
>>>>> +struct xen_snd_front_evtchnl;
>>>>>    struct xen_snd_front_evtchnl_pair;
>>>>> +struct xen_snd_front_shbuf;
>>>>> +struct xensnd_query_hw_param;
>>>>>      struct xen_snd_front_info {
>>>>>        struct xenbus_device *xb_dev;
>>>>>    +    struct card_info *card_info;
>>>>> +
>>>>>        /* serializer for backend IO: request/response */
>>>>>        spinlock_t io_lock;
>>>>> +
>>>>>        int num_evt_pairs;
>>>>>        struct xen_snd_front_evtchnl_pair *evt_pairs;
>>>>>          struct xen_front_cfg_card cfg;
>>>>>    };
>>>>>    +int xen_snd_front_stream_query_hw_param(struct
>>>>> xen_snd_front_evtchnl *evtchnl,
>>>>> +                    struct xensnd_query_hw_param *hw_param_req,
>>>>> +                    struct xensnd_query_hw_param *hw_param_resp);
>>>>> +
>>>>> +int xen_snd_front_stream_prepare(struct xen_snd_front_evtchnl
>>>>> *evtchnl,
>>>>> +                 struct xen_snd_front_shbuf *sh_buf,
>>>>> +                 u8 format, unsigned int channels,
>>>>> +                 unsigned int rate, u32 buffer_sz,
>>>>> +                 u32 period_sz);
>>>>> +
>>>>> +int xen_snd_front_stream_close(struct xen_snd_front_evtchnl *evtchnl);
>>>>> +
>>>>> +int xen_snd_front_stream_write(struct xen_snd_front_evtchnl *evtchnl,
>>>>> +                   unsigned long pos, unsigned long count);
>>>>> +
>>>>> +int xen_snd_front_stream_read(struct xen_snd_front_evtchnl *evtchnl,
>>>>> +                  unsigned long pos, unsigned long count);
>>>>> +
>>>>> +int xen_snd_front_stream_trigger(struct xen_snd_front_evtchnl
>>>>> *evtchnl,
>>>>> +                 int type);
>>>>> +
>>>>>    #endif /* __XEN_SND_FRONT_H */
>>>>> diff --git a/sound/xen/xen_snd_front_alsa.c
>>>>> b/sound/xen/xen_snd_front_alsa.c
>>>>> new file mode 100644
>>>>> index 000000000000..f524b172750e
>>>>> --- /dev/null
>>>>> +++ b/sound/xen/xen_snd_front_alsa.c
>>>>> @@ -0,0 +1,830 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>>>>> +
>>>>> +/*
>>>>> + * Xen para-virtual sound device
>>>>> + *
>>>>> + * Copyright (C) 2016-2018 EPAM Systems Inc.
>>>>> + *
>>>>> + * Author: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>> + */
>>>>> +
>>>>> +#include <linux/platform_device.h>
>>>>> +
>>>>> +#include <sound/core.h>
>>>>> +#include <sound/pcm.h>
>>>>> +#include <sound/pcm_params.h>
>>>>> +
>>>>> +#include <xen/xenbus.h>
>>>>> +
>>>>> +#include "xen_snd_front.h"
>>>>> +#include "xen_snd_front_alsa.h"
>>>>> +#include "xen_snd_front_cfg.h"
>>>>> +#include "xen_snd_front_evtchnl.h"
>>>>> +#include "xen_snd_front_shbuf.h"
>>>>> +
>>>>> +struct pcm_stream_info {
>>>> Not sure how this is generally handled in the sound drivers, but when
>>>> reviewing the code using those structures I repeatedly tried to find
>>>> their definitions in the sound headers instead of here. Same applies to
>>>> the alsa_* names.
>>>>
>>>> I'd prefer names which don't poison the name space.
>>> I'll try to do something about naming
>> One question still remains wrt alsa_* names: if this is for structures
>> I have (alsa_sndif_sample_format/alsa_sndif_hw_param), then
>> those already have sndif in their name which clearly says these are
>> Xen related ones (sndif is a Xen protocol).
>> If you also don't like the alsa_* function names then those are all
>> static and defined in this same file, so see no confusion here.
>>
>> I have changed other non-obvious struct names:
>>
>> -struct pcm_stream_info {
>> +struct xen_snd_front_pcm_stream_info {
>>
>> -struct pcm_instance_info {
>> +struct xen_snd_front_pcm_instance_info {
>>
>> -struct card_info {
>> +struct xen_snd_front_card_info {
>>
>> Does the above work for you?
> Yes, this seems to be okay.
Good, thank you
> Thanks,
>
> Juergen
