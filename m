Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZrTC7i+Ldy1r0U1ex30rgMgU5DXCRht7v75LBnXuB/hcvHMa0cofGHMytqFhcnIacKgHf0L
ARC-Seal: i=1; a=rsa-sha256; t=1526374512; cv=none;
        d=google.com; s=arc-20160816;
        b=n6Y2803lnzl6WBdasX4nAJoOoMaTuyQKd15Ch9NqnDR4mf88CdcVrV0u3eoHBnELTM
         rwJXurskJecpjZi9zOq0OvB1OKFvIqGjXxkFj1ZDL8CR8Lui8XM5EhV0AvFcPbo+bpGB
         BREDk7/3jnt6OFoPljRpkngILSnN91kYiM3f/k4ltyDOcTs54I4GTlkv2QnS+ordZSqV
         K2lo3rVoTDV7NIyNosQaKl2D5cnk5rSI4lz0CcdOdcvs29xLFI8IbeQBf1YDqSgOjeKQ
         6D/75r25o1vPwTwdhPrloK0cV9CDSpLe/EQZQoHRaSBU9X46XFvtEb0+grXr5G47h0EY
         GgnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=66Q0aknQ4S6ml1i8YaeKf+yl+bVU4pWqOzta8d/g7+I=;
        b=PGu6uMEu90Mki9IwG7eXr62ddRdrT0HVAQ9xDMbMRghLMKAj7RohVRIN6/bnHLoYiq
         KrXkGxhT/4g1WY5EGTQqrebeZUwERRnC1XkPw1gUa/e2riY1Um7q9yKRjCezv8nprUzP
         52qFraINOGKD45cKgrJHjBDeR8Y4I6JK4hdQju9nBdAMSnH2HRoLE4tYXtPrut4HdO9B
         4dJd1TDGJpNYbZodJgs1euv/qrTwoIUz5gW7LEAvfAul/pPHzw/2wbbufFj+RGRPaxvL
         /U734y9w3L5UOzeze2JToJEWgUmHo6k3/Qm0zyhUak2EaQnus/7/35Jem6Vppb1hoIVO
         ZjJA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Mdv+gLy6;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.111 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=Mdv+gLy6;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.111 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH v5 13/13] mm: Clear shrinker bit if there are no objects
 related to memcg
To: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: akpm@linux-foundation.org, shakeelb@google.com, viro@zeniv.linux.org.uk,
 hannes@cmpxchg.org, mhocko@kernel.org, tglx@linutronix.de,
 pombredanne@nexb.com, stummala@codeaurora.org, gregkh@linuxfoundation.org,
 sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
 penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
 longman@redhat.com, minchan@kernel.org, ying.huang@intel.com,
 mgorman@techsingularity.net, jbacik@fb.com, linux@roeck-us.net,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
 lirongqing@baidu.com, aryabinin@virtuozzo.com
References: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
 <152594605549.22949.16491037134168999424.stgit@localhost.localdomain>
 <20180515055913.alk3pau43e3jps3y@esperanza>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <1e31235c-f4e3-1046-57c8-741de095e616@virtuozzo.com>
Date: Tue, 15 May 2018 11:55:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515055913.alk3pau43e3jps3y@esperanza>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: AM0PR06CA0058.eurprd06.prod.outlook.com
 (2603:10a6:208:aa::35) To HE1PR0801MB1337.eurprd08.prod.outlook.com
 (2603:10a6:3:39::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1337;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;3:Uuw9lrnlvR81PKxYmEEcWbxgWWxfzhmsByNV6R4jmYeHeyztf8cVmME/ImWbq3aKMheAROGMzOoa4tpYwZL7zF9hf7+fpAiA73Dp4422L7oT3BQ7qmwq4UGrHKIl8rbsF89mlywxwM3t95uVKPmbQIJm+om6ynE8vk4nftktwP5DPG3gnYRmWDRc3fPQVNDTn75WvqtAF6RIj1XpYsJ8o1qHtFj+0l3+LR69Kj0YepsvzH+aw5ZlJp+TrUh+K1E7;25:H5CsmB5PVkMyw7EQ2N7P8BQQSwvfBoO28Ic9YuQFTBxwGfyIGaE0WaUhFtXGC3PicViNiYjhjZeqZ3JgKUEQsbAqwXJ7fO5pKck8RMkKSXxsl3xbDiDNR5TflNcanw8e1dljRMa/5dSkauLR++9WK2FHtXwL6YBd/w71XLwLkJ/jgdU8m9sh26qczk+PQ3OQ2HitNsOSQlyiqA1hp3/4YQngf4PVVQCfCrrwHr5hL4uU2Em101JYbMrW7lZ1RJT2SvlqLp5Ym6GHzODPuhVVcbJM1GVHxfny2JLfDpMkLD78SHWnfN0hdsf2suPBQbD6awB4GCmDxOJ2oka3RuUMaw==;31:2DzLBJipUBM9Fkjkz0PlCVRQ0MmX2Y3PD6QBQAT1g8DE2IjWUDJgKSdHopSn1c6QjZ8tAz6U3KpdIkP/LXyYt3vYe8qi6RZOevMDWVH1edT21MNMPMLVNImdIbSZyz2+zofHX2mgFJOUY2Uxu1P+Qg+q/rkIUD5Rjj7MvuTGbAVHRBlmQ+XUnwfjNWB81f72HzLO997dEqcfWyzYmNWu7ZIhB752V2d41J+99s4Cask=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1337:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;20:C0cCAFPu5kSJPlS+EaAcRXJJi8263FvM8zW76mnZsifScgD0WAcy14Z4zUqQGS/gq0WYnRnBdvLggnoE8zoZF0ZKX7ag9hAgXo89/cvBb6ZtgNFMMcDvqYmBmAlQfBdLNpNTbVinsWcpvg73qq7FQKfusDq5p6mxJoXN78pQiF1MUUc3er73P9sM0VzrHA1SFl2MhnnIoB30yHjtlfw+Qftt4QJk6s6rJo+a0GaNOHcOKD4Cfurei4OtW1gmuYM+LMErVtRn6nojb1vSiCOpfGLuIBINLSI9arEVWsTcicFOsfMdD/tBlSQPoFffCGJih8DytFZ7sxwvo5yOgvrRsMIUxJOxXYQ+FIqVVz0YT8hkBuc6tNuWB4lLejXdjtmbFE6ntsWlQkZspF/m9/S9a5UKOXL+8dvLTIb0dSRgUQ5HfbqaVrtrTWOSnFfzyfTpIcTa17Gln6h8czQtpOygQIdUmioVwz8z+LHtLUCF+MDF/7jf6fAgEWWEQIXEy7jm;4:UeQ89AZ+B95ov3Q7XAAq3hKS0zIagB109ScbAGg6ub32w3BfsjWeEnuNPN4IcPbzXheJooZ8CYQwsnRTziDCtKMbHX5/D/a2ASNH+F+Ry3gEO58WbbvxXl1dOLdsmioOen92j+wDQfGgkBFRZx5aVRELINQfmsEYRdmHdUMWV6WJkQrncIlv1C7o8qaCvNp19LWlhsPaHCZHSJ5ys/jics8VXA5xmdaUsWjmGf9XrkFrWs+iW6Zr+Lsr3eO8lt8CPqLf0VrkbuKoSZQkLLahwA==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1337FD9C8275F1454654B66FCD930@HE1PR0801MB1337.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0801MB1337;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1337;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39850400004)(346002)(376002)(366004)(39380400002)(396003)(189003)(199004)(53936002)(478600001)(16576012)(305945005)(39060400002)(4326008)(107886003)(3846002)(50466002)(229853002)(6246003)(6116002)(5660300001)(64126003)(956004)(97736004)(36756003)(476003)(81156014)(65826007)(81166006)(53546011)(8936002)(230700001)(11346002)(16526019)(2616005)(7736002)(6666003)(386003)(68736007)(26005)(58126008)(2906002)(65956001)(65806001)(31686004)(59450400001)(6486002)(8676002)(6916009)(575784001)(86362001)(52116002)(446003)(106356001)(31696002)(66066001)(77096007)(7416002)(2486003)(316002)(486006)(23676004)(76176011)(47776003)(105586002)(25786009)(52146003);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0801MB1337;H:[172.16.25.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDFNQjEzMzc7MjM6S0libzh4RGFaa1lERlN3c3orQ0lWTCtS?=
 =?utf-8?B?SXJFbWpqMmEyYUJ6SERmVHcwN05abUZkeVVmcFJ6TmJXQnZTdDhOK3E2S0xi?=
 =?utf-8?B?b0ZPV2ZqTzA2cVpSN0V3RFRVdUtLZ2U1Wldta1NMRk5ZYWF1cDVNWUxKWkI0?=
 =?utf-8?B?cEk3dXAydGJQVGJMOEhYbWFwR0JOK1VJOCt5NDJWTSswREJKek5qQnhuQlFL?=
 =?utf-8?B?aEJjN04zdFAvell2N21MYUEyZU9Eai9GRFhkbUZHWStIQ2dOamFDRTNTdkVW?=
 =?utf-8?B?bTFDUURDZ3UwMHJRNC9BMmtCOFp6VFg4dmk5UHVyOWJvUHB1SGJTSnUyUTMx?=
 =?utf-8?B?WWcwVldKdmZDdW5pa3dRN21sM3ZTem41VU9aM01ndzlydVhTdXpQd1oxNVNO?=
 =?utf-8?B?ckR6d3phTG9HeHlYbVJYckpGNnl1QWJWTFptaVhJVjAvcVJZeVFhTkZYSkV3?=
 =?utf-8?B?RmtWSW1WQitUZUg4RVNhSVNiL0RCMHVHNzl5UkVQZ243NzQwQ0FWMzlyQ1o5?=
 =?utf-8?B?Q1pvSjFQbFlLTVFXbjlzMVA1UUFFOWw4bjJXc05wWEVCRTloK1FZUjhkVmZo?=
 =?utf-8?B?TGN5dmw1ZnhWb2dWcHBaSWh6clEra0JPcUxLOEhIWFFmV0ZqeEtHdStJcTZ2?=
 =?utf-8?B?bU9pdmNPZFI0ckZYQk1DT3pQSzE2Uks5UWk1V2ZDQ3I4NWRoMkdKSTVXWGpU?=
 =?utf-8?B?VndRTG5xb0RuNitsR1NBOE1YRUlqallnb2poeXJ6RnZKNU5sVnBaUkRGQWVw?=
 =?utf-8?B?a292OXNzaFlTZjdMd3NCMHJSM1UweUJhcEtNMWVuVXBXUEJXK1FiWWNmalZa?=
 =?utf-8?B?L1I1eGJPbDI2UHRVUUNvb3h6Z2VIT2NleElzaDRKdHYwbUVtcEViaGF6SWU0?=
 =?utf-8?B?bVVCbjE1M3NOdUxNY2txRHM0aWVEUk0wL2V5b29sVlJ4WVh1NmNkRk5qK1pa?=
 =?utf-8?B?b3dLcUdrdTV5MjZmWnJXMTV4RlpOZjFqalJYRHZMSENORFJXUkQ4aWRKVGtC?=
 =?utf-8?B?Y1J5RWZGalNYVExNd0dGcHRrZ0lwaCs3VGJMUUtBY2VNRm1HRncyN21RajBZ?=
 =?utf-8?B?dC91RThHOVBxam5VWjJvc2Uvb3krcnA0RG15ditsZGFlWEpDK1k0OWk1dnQw?=
 =?utf-8?B?ZDhiNEQ4QTdKZnM3d2V6TE1HTHU3dndDcmwrU3B1alRpbjl3cHgvVVpwamRF?=
 =?utf-8?B?ekN2VGlGVzdjaGZNRS9wUk9ZeHpVOER6R3hxUENRNUxPcFF4ek5kc3hJKzBB?=
 =?utf-8?B?Qk5NT3N4N2pmY3VIdFpDdDA0WFo0blNqZUp5czFrOTZEdFlrcXNNeldqejU2?=
 =?utf-8?B?SlExakt5emRHcUhUNjJQWUlDekE3TjlOTzlRdWRBQzliVUYyVk4rU1U4eSs5?=
 =?utf-8?B?VGkvYlNxZmFwN3BvcmlkUEQ4WU81Nk9zNnBVaFJrTmxkYzlZWnlEMkJKaENa?=
 =?utf-8?B?OCtGUCt1TlZhQ1BUS3VQNDd6MzNMNWptdElLUURHK1U1VFYwc2w4T0pmTTRi?=
 =?utf-8?B?NkxFREhDWWgwZG9ML2drU0JjNGZqZnBlUUl6K1VhNk1KZDhIMzVVWUhOL1E1?=
 =?utf-8?B?elg5bjRzaFIvZEVtTU93VVlFVXM5Q0FhRm5yVkpRdmM2MHpkQm1JVllmY1JW?=
 =?utf-8?B?VWMrOXkyZEtNSmEvbjZWODlwdVo3MXMxYW9JbktwYW5MUHBmb2V1WVl0S1U0?=
 =?utf-8?B?UmlSNGNjdTRxd2QvZ2E2TEFaVERnSG9WdldtVmpCVFUyVjl5bm9OcktTUE9o?=
 =?utf-8?B?aVlzOTdISWVhS2RvK2g4SlBCbVRySzAwdVg4dUQxc2o5UXdJZXFhajd2V2U1?=
 =?utf-8?B?T3ZzZDc2YjZGSVZhZkhrN2liaUZscmxuaXEwMkNORGF4Q2ExUkh0MHAwMmMv?=
 =?utf-8?B?cm1Xd01TanA1V2RnWEhxUW0vMnhVZjYrbFRHdm4zaHJaZ0N5UDROUVIrZFEr?=
 =?utf-8?B?dFVTd25FVVZlMDNyUmtBQ1d3ZVVRQlBPRWlMbWVxTEd2Q2xVcWtIYkdvelQr?=
 =?utf-8?B?ek90RUdpRHBxYlp0eG5kZDZkeXBqdFc3UkhhalZoTUZoZldvU2FJdThoTUtx?=
 =?utf-8?Q?qQbpdM=3D?=
X-Microsoft-Antispam-Message-Info: oY27gh6Md58bMeRjgn2SAeXwLAg9F+pAH9oo/2Sg2F96USkktElgBw5SBeNNm9UxMvFoJEiU5IsSrrCpmts1OeRD/V5ftV4GZzyPbWb/TbHHGyc0d1t1D6faTA46FRPwC/u3xV2hMJrdHHYHYusQvSDYs//fkS/9lnq6BZoNrStRkxrcUqBf36xUM016UGyt
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;6:thWdRoNk2vCNew4xp0BEUyqTFxUsi9Ugn9nn4DxR247tvKy/3ne7J+nNfmR3JQIEqJzgW+Wv4HAvRj2R100EwQI5h+ELfUIdJipUivAz/PwsA34gCfUthqz89HUuUoW5E8O3ech3i/hmjdSfxEuC2nty5tks3z2qxKCYm6U1D8pHKL14fSbXFzbFmhzyfUyepV5zwvbNUv8aF9jKLiOlIs0Bd+r7qWdHF2RWz4DcZCLh4oVZ/cFQ5yvJXbo8vpn2TkkdfFduuOrJMR3PcuCBn3nxAKGpUYb0iT3nJHj6Qf8h3GT7ZKfKy8Wyat8kn/pRF1unAKR6uXJAAh33h9VVTmdFX+9Gp35zFfyp69W47MLfuQGykwEmMnmcQb06rouRY7IyZ29w8wv1PbWj5Dm9SwOHXvsQ1GsjMcn1lbuYn+I47GkaJHbtL510YsZ8lXLmBVv6zhFIPIdkht/2ddR9lw==;5:yhNVIBaH5uvg6HrQiTvzJtebmyIM4QsN9bMz1z0DD+cR6eibx0mY7H6ZP+ZNxPVFThWWe09T+HrNQb3JxUJ6AMsipVnFEQTIxLaFAuEnPAcJe2U9J+EjzY5CXp8IQCf6ZSZX0k5gn2oJiDRJc0HPXWiaUJztwNaFBQ0zuUQ424o=;24:yDMRHsmj+hWb9Nw838WTsOQ36IUO97YWJzXdxgeKrM06ht7LkZ3oVNplwp7gUw2/uz/SJm+aLZ3CGmdBuifYfEzRpoxtBlFrcHRyl3dNgao=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1337;7:61gGsoeqgrlqjt8+Jetx5uQaPJD5jB1y8w9jipv/MKAtpq4X9YO+/bye2NwLAON+Mchuz0k4LUDW3djbwe3XccZ6yGIRtXiAkv+i5FOtyemumh1+R2Kj+oHY/BxLzgYpvPiSXWArlUhbL+jOHf3tmKrP6i2Yh2mx5BGY95LsxogeJfSJYYOHJCPwzjTBTbKCdCboKBT5if632mhacwEcaw5nULLCE/P2n6kdVWQZPIcEXEcMonVDY6nV9mMdyDdW;20:/4q1eWkVa/VDrS9hTYUh/vE8Z5QjuQ7D2jVTTwxEH6Dp90SfGV9N6ZQ77F7728m+D2IXnlXb1wpoAIDaFhj+iXw2zPmPifKQGfHly3TDSVuv5Y7IhErHQ0OYPvUQhiP3WWSU03OYeSy6RhajRhIddswd3Eh0uCSnulgWVyPd+b4=
X-MS-Office365-Filtering-Correlation-Id: fbe09e8d-aa88-4582-be66-08d5ba419017
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 08:55:07.3251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe09e8d-aa88-4582-be66-08d5ba419017
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1337
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600070417544156760?=
X-GMAIL-MSGID: =?utf-8?q?1600519681125351771?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 15.05.2018 08:59, Vladimir Davydov wrote:
> On Thu, May 10, 2018 at 12:54:15PM +0300, Kirill Tkhai wrote:
>> To avoid further unneed calls of do_shrink_slab()
>> for shrinkers, which already do not have any charged
>> objects in a memcg, their bits have to be cleared.
>>
>> This patch introduces a lockless mechanism to do that
>> without races without parallel list lru add. After
>> do_shrink_slab() returns SHRINK_EMPTY the first time,
>> we clear the bit and call it once again. Then we restore
>> the bit, if the new return value is different.
>>
>> Note, that single smp_mb__after_atomic() in shrink_slab_memcg()
>> covers two situations:
>>
>> 1)list_lru_add()     shrink_slab_memcg
>>     list_add_tail()    for_each_set_bit() <--- read bit
>>                          do_shrink_slab() <--- missed list update (no barrier)
>>     <MB>                 <MB>
>>     set_bit()            do_shrink_slab() <--- seen list update
>>
>> This situation, when the first do_shrink_slab() sees set bit,
>> but it doesn't see list update (i.e., race with the first element
>> queueing), is rare. So we don't add <MB> before the first call
>> of do_shrink_slab() instead of this to do not slow down generic
>> case. Also, it's need the second call as seen in below in (2).
>>
>> 2)list_lru_add()      shrink_slab_memcg()
>>     list_add_tail()     ...
>>     set_bit()           ...
>>   ...                   for_each_set_bit()
>>   do_shrink_slab()        do_shrink_slab()
>>     clear_bit()           ...
>>   ...                     ...
>>   list_lru_add()          ...
>>     list_add_tail()       clear_bit()
>>     <MB>                  <MB>
>>     set_bit()             do_shrink_slab()
>>
>> The barriers guarantees, the second do_shrink_slab()
>> in the right side task sees list update if really
>> cleared the bit. This case is drawn in the code comment.
>>
>> [Results/performance of the patchset]
>>
>> After the whole patchset applied the below test shows signify
>> increase of performance:
>>
>> $echo 1 > /sys/fs/cgroup/memory/memory.use_hierarchy
>> $mkdir /sys/fs/cgroup/memory/ct
>> $echo 4000M > /sys/fs/cgroup/memory/ct/memory.kmem.limit_in_bytes
>>     $for i in `seq 0 4000`; do mkdir /sys/fs/cgroup/memory/ct/$i; echo $$ > /sys/fs/cgroup/memory/ct/$i/cgroup.procs; mkdir -p s/$i; mount -t tmpfs $i s/$i; touch s/$i/file; done
>>
>> Then, 5 sequential calls of drop caches:
>> $time echo 3 > /proc/sys/vm/drop_caches
>>
>> 1)Before:
>> 0.00user 13.78system 0:13.78elapsed 99%CPU
>> 0.00user 5.59system 0:05.60elapsed 99%CPU
>> 0.00user 5.48system 0:05.48elapsed 99%CPU
>> 0.00user 8.35system 0:08.35elapsed 99%CPU
>> 0.00user 8.34system 0:08.35elapsed 99%CPU
>>
>> 2)After
>> 0.00user 1.10system 0:01.10elapsed 99%CPU
>> 0.00user 0.00system 0:00.01elapsed 64%CPU
>> 0.00user 0.01system 0:00.01elapsed 82%CPU
>> 0.00user 0.00system 0:00.01elapsed 64%CPU
>> 0.00user 0.01system 0:00.01elapsed 82%CPU
>>
>> The results show the performance increases at least in 548 times.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> ---
>>  include/linux/memcontrol.h |    2 ++
>>  mm/vmscan.c                |   19 +++++++++++++++++--
>>  2 files changed, 19 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 436691a66500..82c0bf2d0579 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -1283,6 +1283,8 @@ static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg, int nid, int
>>  
>>  		rcu_read_lock();
>>  		map = MEMCG_SHRINKER_MAP(memcg, nid);
>> +		/* Pairs with smp mb in shrink_slab() */
>> +		smp_mb__before_atomic();
>>  		set_bit(nr, map->map);
>>  		rcu_read_unlock();
>>  	}
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 7b0075612d73..189b163bef4a 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -586,8 +586,23 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>>  			continue;
>>  
>>  		ret = do_shrink_slab(&sc, shrinker, priority);
>> -		if (ret == SHRINK_EMPTY)
>> -			ret = 0;
>> +		if (ret == SHRINK_EMPTY) {
>> +			clear_bit(i, map->map);
>> +			/*
>> +			 * Pairs with mb in memcg_set_shrinker_bit():
>> +			 *
>> +			 * list_lru_add()     shrink_slab_memcg()
>> +			 *   list_add_tail()    clear_bit()
>> +			 *   <MB>               <MB>
>> +			 *   set_bit()          do_shrink_slab()
>> +			 */
> 
> Please improve the comment so that it isn't just a diagram.

Please, say, which comment you want to see here.

>> +			smp_mb__after_atomic();
>> +			ret = do_shrink_slab(&sc, shrinker, priority);
>> +			if (ret == SHRINK_EMPTY)
>> +				ret = 0;
>> +			else
>> +				memcg_set_shrinker_bit(memcg, nid, i);
>> +		}
>>  		freed += ret;
>>  
>>  		if (rwsem_is_contended(&shrinker_rwsem)) {
>>
