Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757576AbeD0HwB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 03:52:01 -0400
Received: from mail-eopbgr30104.outbound.protection.outlook.com ([40.107.3.104]:15796
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757171AbeD0Hv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 03:51:57 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 00/24] device link, bridge supplier <-> drm device
From: Peter Rosin <peda@axentia.se>
To: Andrzej Hajda <a.hajda@samsung.com>, linux-kernel@vger.kernel.org
Cc: Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
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
References: <CGME20180426223215epcas2p38fe3b0b7b1ea1c8190805f9e2a89e11e@epcas2p3.samsung.com>
 <20180426223139.16740-1-peda@axentia.se>
 <25d8e621-b3f8-094f-32a2-d22efc2163a4@samsung.com>
 <7d4bceeb-9611-cbf9-3906-fef5db88aad8@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <8d747088-3214-97af-4616-bf5d2602892a@axentia.se>
Date: Fri, 27 Apr 2018 09:51:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7d4bceeb-9611-cbf9-3906-fef5db88aad8@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR02CA0103.eurprd02.prod.outlook.com
 (2603:10a6:7:29::32) To VI1PR0202MB2784.eurprd02.prod.outlook.com
 (2603:10a6:800:db::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;3:nDLp+DKD0/tVZ5QpcE6Vj6KRBkouse+J3zv/ro1Qv4v0ULLO2V0lnJ8pDNrPKRGMm7NQnl2npoCA7dSUHropNyrMS3Zg6qggzMk9KiKzfFiSQiGTi2waR+X1Oz9MGSs29oFIixgUs0JTzGlxGwyYlkl6mtwEWkwaiszlM3zR5Tk6CXh0MlaNELnIC/0t4Uigobd1ygkLIe9Hvss82YwaK1URRD0nGo7O8+qKh2cVRaS/3q/nlTXoHnqavSFtmpr5;25:SGe9ULPjow0coQ0au1mhPmlZVus0tZAPSsU51jhBbgJ3wnLpV4ua8QjIUSGJlkZjIL7wCvl+nlzexanJok7llrkmIjwophxw6JucwjiAB99jCY0rxhZ+OC/PE5S8SWDPJO7o0c/KL9m1S7ZX1cRv2LwWjoS+4wsiOzXKCaVdRGBDgSwkkuY+E3lwyki5JH9/isxUWyn/9S6639c6lBGS5o19+Ee00Fd9/jUNpzmmXnKGMlUoBtFh8lU2u3dP+a9PzxZhB1ANZBfEDhMxcIdx2id+mO7rEodSD+ggPs2hkdAdYDU76eXDjgS7X7FfLlKYCLwiYjIcq/RhEeVcgFZ5Nw==;31:+ru9iVHkx9ycdj5RKyLBvUN3eAKM5zVNJooO4B+FNzzhe4MsY9dlubyhdEna4EBdYHYKRH2j///dfjam5CvTGpxrOSwjsALo2Ej4rYyye7FYhiixN7ucDBuxVmFrk6XNzkmlN2shNDAQ6ZFM+bvwbXARPHh9EllOma/usMpj5XeEe8R7BU1EOYgVvpkg2ieN8g6RqnMGd/pAK/6Qi4ivWyN4ksAY9AzPG5GPHD7dLWc=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2784:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2784E70063296F3944CA7EE1BC8D0@VI1PR0202MB2784.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501410)(52105095)(10201501046)(3002001)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2784;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2784;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;4:Fp0VlSS5tVMcDs4zsDbu/zQ3XmzTQxexT3E3JEGvhhE+/whbZYW/STlH3tM13IeMouoy6YhC7j/aWuk/oSlryzpmHmvXihyzLv3bPV4lBhaht/GELYkRUAjV6S74BUgaEW1SMsn1IUlKefm8aLdkFryXxwS9lTPJTsE5svTNB2+V18b7B4doV7DKW8GUX5bd1LIPkFOIDoaizFeePXZBJ6dhJL/noftb8t9eh+A0ETl0BnkKVBBBWBdRACxooHSeIkfgQhTO6R2onY26Lpo1+5PTlr8jfCDLuyqBSo7F91INa5cUyuf1Elj94bSAJMlW
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(366004)(39840400004)(346002)(39380400002)(376002)(189003)(377424004)(199004)(6486002)(105586002)(36916002)(52146003)(386003)(52116002)(486006)(23676004)(68736007)(76176011)(8936002)(2906002)(2486003)(97736004)(31686004)(7736002)(53546011)(64126003)(65956001)(7416002)(65806001)(5660300001)(36756003)(7406005)(50466002)(65826007)(81166006)(8676002)(81156014)(956004)(39060400002)(74482002)(446003)(47776003)(31696002)(11346002)(476003)(2616005)(4326008)(3846002)(6116002)(305945005)(6246003)(106356001)(230700001)(16526019)(186003)(478600001)(25786009)(3260700006)(58126008)(229853002)(316002)(117156002)(66066001)(16576012)(86362001)(26005)(53936002)(6666003)(77096007)(93886005)(54906003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2784;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDJNQjI3ODQ7MjM6SlNoMzFQdCtKN3lXVnRkSnFhVjhJdFhI?=
 =?utf-8?B?RHV6blhienlheTZ6Wm1qM2E0eTc4RDdEcVVnczBVam5XcWpKUmZlbStiM0RX?=
 =?utf-8?B?dkl6RnkwbjdjcFBORGgrakhrUGNjSmhMR1k2aDgzSCsvd3F2NXV6OVBMNTBz?=
 =?utf-8?B?eVlFTmF3SDIwWVdnWERFbStGTVhhMlBld1hjL0NaZ2hZK28zczExS1p4NmJQ?=
 =?utf-8?B?SlErbTlVTHJyTFVSUkZ0amxBRHZHck5EWnZmbDRUVEtnREZ0bExuanNuWCtk?=
 =?utf-8?B?a3JtTi9RTC85VU80clpDZkVNR3VMRDJNc1k3WmthdlkxOFZJMXhlWlEyRXhj?=
 =?utf-8?B?YUxIRTFrdHg1ejJqRUlWZG9XMkZoYklRemRpcDlnRW43elExbmdGQUtkWVVJ?=
 =?utf-8?B?OVp4M0ZxTXFUVGM3NE85VVRSeHJSQnVxdXZWZEE1Wnpkd3pwK2NaZ3NHSkZV?=
 =?utf-8?B?UzdWSngyaytrNXNQVm1EWGlCaVRhSm9UNVJlTk5uOE94WGdoamhiMEVHZ1Iy?=
 =?utf-8?B?UHpzVUVKOFZSRU9jODVoVytxcmlNa3RTOTNPaFhMWWNlUFZXVEoxK1ExcE0y?=
 =?utf-8?B?Vk9iKzNHOWxkZ2tYUm8xVjN1WUVMZlByaytJSTlNSGpJWVFicGZ5NnIrOWVK?=
 =?utf-8?B?ajF4ckthWU5SS0NpTS83elRNWW5QSjcwbVduSnhtQUdyUnRCaEFYWEMrc1J2?=
 =?utf-8?B?SjJqc2l6dm5hdzF2ZGpPRlFCdlYwc3Z2ejQ1SWgrejM3anVydVhvWHkvZWRB?=
 =?utf-8?B?bTRaVmh5aVQ5WlVkSG1GRVRINkg0T0Y3MlhUbkxOVXRJalQzVERjSUdYUXBk?=
 =?utf-8?B?YnppR2s4NEVIVmhNMkhqempHbVNwc2JhdU43dnB2VUJOZnNYdXVCdExoYTNL?=
 =?utf-8?B?QmhsTVZXdlhlNEZselRSM1lRL3U3dTA2NjJMdUZrd0tRNk9KaW1tZDRvdEg2?=
 =?utf-8?B?MWp5TWtjTmw5eW9PTWpDWHpKS0x4YWFDQk1aY25mQVMvV2RjMXlVdzZEYmFZ?=
 =?utf-8?B?ZXZRRkJ5NmVJUlZXWVRKWmJkMXNpRktoekFFcDl2ak1Ba25xbjl1cWdnc3RQ?=
 =?utf-8?B?NmROdmVBY1pKdmdQcm94NStOdmhHVWdmcFVOYlhLUFl4MGtWdnpDM3J6NzJ3?=
 =?utf-8?B?U0xybTlvcDYvRE9IU3d4cHh5MXNwOGhuVjMzWnRwT0U2ellweU5pdHUxaEZa?=
 =?utf-8?B?QXk4aU9DN1Y1VzMwZkx5Zk82K0lCY1dQN2JldWUwVjdZTmhOYWF2UFp6L2Ux?=
 =?utf-8?B?dTZVYXBMelQ1Q3lDQ01tM2pMVFNOSzRBN3pEaTE1NnVlV1VKUjFoRnU5RzJW?=
 =?utf-8?B?cmZCWFNybDlMOTljUXJnWnI1NnRZUGliWENUeXlDZTdqeGpOZ28vVFA4MnhQ?=
 =?utf-8?B?RkdyM3gzVXVhRC9OTGczaXlvOC81RThBVVd0NEI5ek5hZ2p6SjBORUZDaDQz?=
 =?utf-8?B?eGZzbldoV2daNlYvd2dkczZLYXZUNCt2ZDFiN0hRUW9JUHZmVEZ5bnJBUGlu?=
 =?utf-8?B?WU8wekFva1hHb2NwVGcxVEV0L2gzRE5raHljMnFvVzc4d1ZrbWpsZWJna3VY?=
 =?utf-8?B?LzBMQlcwMjNPTDFueE1kcFU1TCtHaDU4bk9SeDVDTlJCT21weDkvNmNGYTcw?=
 =?utf-8?B?YngvckxmbUx1N0QweGFGbHRPc2prZEdGVWNod1JSWEN1azJzVVZaTlFYay9z?=
 =?utf-8?B?VEUxWVRxVzlSZkFkTFJyUTc1SEN0T1FVd3A5NmNDTkxDWW1Fd2lqMFduVzgx?=
 =?utf-8?B?KzB4MzB5Y1VFZlBJR0ROSDh2MWJTUnBKWXU3T00vMEVzV1Zia2NrWUNrQTJl?=
 =?utf-8?B?SkFNRHZTU1BKTGdIczRJNXFpZjhZYVE3UXowN0xLYWszcm13bTFsZTh3SjUw?=
 =?utf-8?B?THRGK0c5QjBOQS9MdDMwUmRhanJ6bXh6SjY5TFlhZ3ZJbkRDcDhWSXM2RWlY?=
 =?utf-8?B?Y0JvOXhrS0pwYzIreGdSZmk4VzV0ZXhNTjVzaWFsZ2RUWUJyQjBzQjhqb25s?=
 =?utf-8?B?Ym9SblNBM1poVjdhVlI5eHRaaEpvTTFLTFpWckFLcTJoNWw5WTR2TjBybHZU?=
 =?utf-8?B?OFA5dy9TRkNVMVBUa24veFpoblIxaXBtWUN4cE1RYW1yakNXK0FzWjZUNW1B?=
 =?utf-8?B?STQ4YTM0WjNUM1JhdVd6K0NuOFdUbTdvMGRIcVkrbGlSUU1rQjZNaEt4eG5T?=
 =?utf-8?Q?XFFAzVvZcxWzb/3RYTmxyUtta2G8PtZxSnJwryRr2vB8=3D?=
X-Microsoft-Antispam-Message-Info: VegONOKgdHXn9oAMc0P1jiHNWMT9pEsU5ooUBVQf3MGMGqk5sOS9QGgOoFacpRrjQp/HEZTtDiZXcj0CNnecYVO3qkVTt7xPMjUUgCVVNotd5hZNB4k2D43eZ7r06bl/6elFmiw4le4s/97S+yDjrNwWeoRTwEBSrPqnuAx3Va7QYQxtHTcexRC69t0gCglP
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;6:F8lSYUjeZ+IF35VnlFQQRZuNouhwsWnZ7YPfYQ9JxETWfQxEcBSTqm06k52pUwqd8Xpmjn2VczNLVA+clXAX0Ccm6WRbuNQqNakoSPFhCWnkYqkSJIofywVmEWe7clnnrLBaFgVdPDZxlomFb0rAvre72pGp62ckIXgn1Gr948eEksXLNL3d6O3u6/QWtPiTEZqHy0i7+MlO3ocL2cNB+4gsC/x3MRsxGMb5SQQnXPJW1fdimTEbilbDnHgVIq6RkvG7Enf+XHk8NivfDHFTVDriUHAK9sqXdSxbXn06+8hHX/8wuyLKMX6t3ebOllSHwKKHQ68P9p93A43MB6NJ9l6cpealXSpLRdiOmorBTwZF4ZSYyJqqyoDeN3/UO02zrEJUbnydifMdSD3izWYYNDzKaj1wUyu0+QHB3a/gXH0QTGPFw1tSBGgB9noIIDoZSBH+uePlNCTrzupUK3J7Hw==;5:spbVU1kZa/HmfBUYPsAfIcOeaSi0gxnI2t0qv9XFi1MN/Y3SNjCn2oVAIitvZdTi+d6vJfPa5cfibafr+223BC9YU9Ei8ne25zfJcyH6oMQGHn6NNLeMy1FNXCgPbhATg6gaIY6gnA8vCJnkOXXygSLQD/mqAaeFsntDfXMoyyY=;24:/QLCt3P4kdxtMm1Ts1/b27MKjAPsfXiMLqqsx46oNmTUnJBY46Rmyp+vfASKQdB0J2VUNTLBVc8Kwf5Ve2jHhyLfcm4pJN1IpcG6S9EBbP4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2784;7:HFX44tHw92id9t5Dnps3m7bSQWojK1wmSgMHsv3r3jrD1kSxv5gd5RiMfjlVmoUVSDMcIun5iT0mis4Hum28znB4UWb/QyM7NlWaJiSq5taTT2YHrQaaAFqWj4mHW5LEB7FueWPwS+yHUnPEH8/ovaE0Njn3e2frwPv5HGlPaPYFNJAIen023Jic+pe8mL/W3WYd9h+EjJrMHyKY51x+X3XylbD7CnLFYMyUQCfpsTEMpb8KDhJ+9zOpWKdWifNc
X-MS-Office365-Filtering-Correlation-Id: 42d73e4f-a1a5-4557-b28b-08d5ac13bd0d
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 07:51:49.8471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d73e4f-a1a5-4557-b28b-08d5ac13bd0d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2784
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-27 09:37, Peter Rosin wrote:
> On 2018-04-27 09:11, Andrzej Hajda wrote:
>> Hi Peter,
>>
>> On 27.04.2018 00:31, Peter Rosin wrote:
>>> Hi!
>>>
>>> It was noted by Russel King [1] that bridges (not using components)
>>> might disappear unexpectedly if the owner of the bridge was unbound.
>>> Jyri Sarha had previously noted the same thing with panels [2]. Jyri
>>> came up with using device links to resolve the panel issue, which
>>> was also my (independent) reaction to the note from Russel.
>>>
>>> This series builds up to the addition of that link in the last
>>> patch, but in my opinion the other 23 patches do have merit on their
>>> own.
>>>
>>> The last patch needs testing, while the others look trivial. That
>>> said, I might have missed some subtlety.
>>
>> of_node is used as an identifier of the bridge in the kernel. If you
>> replace it with device pointer there will be potential problem with
>> devices having two or more bridges, how do you differentiate bridges if
>> the owner is the same? If I remember correctly current bridge code does
>> not allow to have multiple bridges in one device, but that should be
>> quite easy to fix if necessary. After this change it will become more
>> difficult.
> 
> I don't see how it will be more difficult?
> 
>> Anyway I remember discussion that in DT world bridge should be
>> identified rather by of_graph port node, not by parent node as it is
>> now. If you want to translate this relation to device owner, you should
>> add also port number to have full identification of the bridge, ie pair
>> (owner, port_number) would be equivalent of port node.
> 
> You even state the trivial solution here, just add the port/endpoint ID
> when/if it is needed. So, what is the significant difference?

Or, since this is apparently a rare requirement, you could make the owners
that do need it fix it themselves. E.g. by embedding the struct drm_bridge
in another struct that contains the needed ID, and use container_of to get
to that containing struct with the ID.

Cheers,
Peter
