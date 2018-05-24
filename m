Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965846AbeEXOxg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:53:36 -0400
Received: from mail-db5eur01on0047.outbound.protection.outlook.com ([104.47.2.47]:26303
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965332AbeEXOx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:53:26 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com;
Subject: Re: [PATCH 4.16 008/161] packet: in packet_snd start writing at link
 layer allocation
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
        syzbot+71d74a5406d02057d559@syzkaller.appspotmail.com,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20180524093018.331893860@linuxfoundation.org>
 <20180524093019.375532134@linuxfoundation.org>
From: Tariq Toukan <tariqt@mellanox.com>
Message-ID: <c380ed51-85f5-b63a-d424-77c7450e63c9@mellanox.com>
Date: Thu, 24 May 2018 17:53:15 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180524093019.375532134@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: LO2P265CA0221.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::17) To HE1PR05MB3257.eurprd05.prod.outlook.com
 (2603:10a6:7:35::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB3257;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;3:vUi25eY3ocIspL9SHZ/dj4OZ/NhJCSNQ4sodDtWl3T5CZm6Vqj+aPy0AHXZ/94fxB0dkqY25RidcDh32ayFCAqCVBBWOI06Z77w8g6xN5GXt10oNRaQkqz8bD/L9i3DFdvS8kIWC9FtFDz+eZSF3Ab9+6LjypbBphLtqUyF09v9WFmriG8q6WkEvnfOQsJahFfyy90BH4OR1hKGDiy/IY0mnq2sqddZdiUQvTDVNijN0dYEGnZkI9jNEVxY+NKOt;25:zV+evWy/GjOe8pxA9QMRtZ+/H7RMkfcqsr7Mkpsef6Ro2UoTKXMK1hv8qbus8Sg2M28/wOrWqfl8yAqq8+BFwPNkmDMoZpQk6B4x0cEnfQnKCj1lOO8uewtkBD4C2TEwuQb76HuTegb+osQS4nID0HMaYGtTWWgw6LdRk92uMXEhnJXHZKXdEaiNFk3xUJcZ2XcSy/2luDn0Tt8gIQFsMQrYcdHpPWTgi9u3y77doWzsb0YiS6+fyMKQ15cnIxQE9FKTz1S4fuP/032EjiCwihm1Dujo2/sBjngbI+g/Y5LeHZt+eDGokwKkQahLUp7siPly8TZ8cdVHaZ5X48W0kA==;31:SwUdGH9aii1xDhQMKSloKNsGh0sTKGvE2k9Tn7yyTj7Mhst+zszhx7b4IqHyO9xeqYskg1Xxmzhyb57Qub0/62H9vS8aoj2tufYSahPmbR2tAI+3hxR4xN0hr5xki73YxNRV/czTuc86/sV8whtD/Q95EaYBaUnHhJSvfkBV8TZ1dd2aIxehgFkumTiF9qeEOzwElOh/hLdDb/Yh3e26Ze7ZjO6o8Ha17vMtgrZ2j+I=
X-MS-TrafficTypeDiagnostic: HE1PR05MB3257:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;20:AHTq4+URDG8vd+yk5zhL7kWWeCIfDPXK5QbwPuo/naEmASSUp6rM2vqvI2hX9YbWVAw2iLXC5EwfKkYmB9hCFIwSDlJJ0l2LMooqGtpfDaCFWJ86VZbfjdYrlsseFLA+maERpFjFmnekDXGZaoMoExI1VQ47/73ziROCO5tJwcG57iRzd8by1YMT7LbS4xeHo/MOOyld87kLVP7Tp+ppfFTnvbV+PH29IfFAi6YWUnIHaA2DybLjh99uvShK8PeLidVoXWs3kxdIZ9QSxJJLag7Li+oC3avy5tJ7qGp3+gnwgzSOZJ2Sa2ThdOPNNk++BAO3foEaE9JtZyM3yJlO1dpfBBhCfFDYENdweYyGp7YmEtWOIz/9V8RxSudEay7FRfvZfRCnxNsecIPQjW4kn4hwjNfCxUy3MUuzruc4kPqTsiAfofKqNdifArY4fnEAMgP0hpVS0QJSgQP8h2vkxa89PhQ4oNhYf7UBXUMCNgU6OucHPB2FeVxI/4H19amz;4:AYk6nt8+I/xvFgcJzepFXAZMbjyKvm2sYFHma5isWRBuHNdquSmFglbaDg8s1G7DULtFOTGqBTajcuYXTcrp+7eJDIZqXh2dHxnuvFVkD5uGYxt0UZH7oZQKM6SrFIGXeE27SgvcCT2iq9PbdIfp0a9YM5tJfnkAcF6PHqpcAWgNCg5JWdfzIPwL6bO4JrTV8CxsY3yD5uUOEMdzRM6hpYlZKH3TpYKDZ6cCysmCuL6dNq0SvcaT5Suw1TwTO4haOVAqc/5AuXM62p+M135XuJRGkOBQFGm78K97+6Z1WTXJuvd1VSr2VNj5cGR7dxTZFS8eXP0MvYZQ6Ev3JNvd2PGUMA7kZLlAC0xAP2bRRYs=
X-Microsoft-Antispam-PRVS: <HE1PR05MB32574B8D4310280721D81F9FAE6A0@HE1PR05MB3257.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR05MB3257;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB3257;
X-Forefront-PRVS: 0682FC00E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39380400002)(39860400002)(366004)(376002)(346002)(199004)(189003)(229853002)(106356001)(486006)(64126003)(8676002)(4326008)(956004)(11346002)(54906003)(305945005)(6486002)(25786009)(7736002)(476003)(36756003)(6116002)(6666003)(2616005)(58126008)(97736004)(53936002)(47776003)(6246003)(446003)(81166006)(81156014)(316002)(8936002)(16576012)(77096007)(230700001)(65956001)(65806001)(66066001)(50466002)(5660300001)(23676004)(2906002)(68736007)(52146003)(26005)(478600001)(67846002)(53546011)(16526019)(186003)(386003)(31686004)(76176011)(3846002)(86362001)(105586002)(59450400001)(65826007)(31696002)(52116002)(2486003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB3257;H:[10.8.18.17];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA1TUIzMjU3OzIzOnFwdWY4aytPZGhoRExORjZ2cUtQcXU1Z0xG?=
 =?utf-8?B?UElvRGZhZXBmSWN5NkwrR0lrOU5ON3R6MkFWNlRDYnhzdFA2YTB3eEI1ZEx5?=
 =?utf-8?B?NHdkTjBHSnZmU3gxa2c5cVBSNXliSjZrNWNhL3hhN0tOR2hWVlFMSDhraGxw?=
 =?utf-8?B?RWFkNk9TNWk3QW0xMWFMdUQwSXllbjMyamxJOUpjL292eFVMdjdGWUZYZDFN?=
 =?utf-8?B?RkJGY0VPenBYTHFVT2NXVlZoMEtzRlNJSUpCdkFLYXRSMmtqUVVTcWRSZith?=
 =?utf-8?B?MjQ1Z3ZTUDBSUmkrZE85QkdTRHFHaEFVbnl4ZlhnVDRWUVFvc21GcEhoNkg0?=
 =?utf-8?B?TmxjdUE0Rm9FN2FDNmt4eXV3N3F4S1l1ZWdpWkNVQSsySEdyeHEzakJWRU4x?=
 =?utf-8?B?aENDMyt4c2t3SGw2M1BCamh4NEkwZ015ZDkzQ2NVS2JkaE5JUkJramZ2N0xE?=
 =?utf-8?B?R3puZGptSnZYNXJOTmNRWDhYL3BwTXl6Z2JWa3pRNk9JYlg4alFMSUt4TTRS?=
 =?utf-8?B?bHhuRlIxa3huVVNSZkJhMXNFOXVGY1RjbDlaM014T1NVK1JnRHE5ZmZWWlhQ?=
 =?utf-8?B?bExRS2l0MzM4VkRPNzkvam5mb29QL2lwajFSMGxLcGFVNDlsZ01Dc3Y2N3V2?=
 =?utf-8?B?RnNJTlZLTmE4RWlYQ1ZteVZjdTk0U3pBcGFKOWVtNS9ac2NEbXhxcFk5T2tU?=
 =?utf-8?B?eG4wOVNSSnVDRmNGd2NrcFNNQks5U2ZSMFFIUWpxdUxJbSsrZlRqalQ2eWlM?=
 =?utf-8?B?cHZUQ3RoY1FiWXd5cVdsL2FTS3FFRGlhM3BOd1hmNEUwT24zeFdMNktYa2xS?=
 =?utf-8?B?Y0RHOERpVWgyZ0ZoUlJQdnhUZ1FOaWtLSWhzUEV6T0dYL29hNlZHcGs1WHNO?=
 =?utf-8?B?MnVsY29vYmZ2QjhuMTNYU3ZsOENudEhhWlNyaUpwRlFHNlpPSkZNK3M0UHEx?=
 =?utf-8?B?UUtRV0dKZU9xS04wZEorM2tjcHRvdXdUdUxJWHdPNkFUY0xwWDRNeFNRMlkr?=
 =?utf-8?B?Yy9YUnU4NkVub01pUTJIYmJtNEZpL0tWTVhCWGgyK3dHT0E0akNadnYvS1lq?=
 =?utf-8?B?ZTVIblJBMTRWVnEyYyswd3hQWi9SUnpLajRVMUxyc3BNRVRQdkM0d3ZGMk5p?=
 =?utf-8?B?ZHlaN1pZVE96S2JsVlp6SW1Wb1g4UzY2NE1RR21kY2djMmdnSW1pU0JYTDBS?=
 =?utf-8?B?ek03bUppY0kydGtpRXNxeG9UcW15MTI0OGNIWitxUk9JMjBhMFl5VlBVOHph?=
 =?utf-8?B?L0pWc2FaSC9VL0p6dkIrcnZCTkh1TiszZ2xGYTZUSUFXUGk1WGVlRHI4b3VE?=
 =?utf-8?B?QzVxWjNXYW5HS1JTekdxMXlBL3hKSmxQTGZ1Q01Va0I0eFNzd1hXc0VCQ2Fo?=
 =?utf-8?B?ZFh0b2pVRUpQekllbnJxeFBUNTQ3OXBjSkFaL3kwMFhNRmhEY1UvOGRxc2cv?=
 =?utf-8?B?WXNkOWQ2N212OW5kMmFwUnJJMHh5UG1uOGFCNXdIL1ZUbWZwL0xxNmZTOGla?=
 =?utf-8?B?d1dib3hpWUJkZDB1NGpUbEtpU2JkbjNPR0tjbjBGUStyQnNCeDJJL3RyVjRV?=
 =?utf-8?B?VEFRUXFMNWx4Sk5zRDlqMUlveFI4MEliRE1kM3JXeEN3MjlrNTRYbDB6RWdp?=
 =?utf-8?B?VTJDQU5zOC94bVVUWVRKLzYvL2tCWUFQR3QvVk44MVJsdVJkK1I0Y1FTOFA5?=
 =?utf-8?B?T3JYeVdoQ1Z3a0dKU0N0dm4ySEJwWC9yMWMvYnJEKzNTaEY3R3ZZV3NWUjFQ?=
 =?utf-8?B?bVdRa3BKSzhYOHRlWVUyd2JoT05yOEc0UUxmbE5QZW95WUFNTW9kTWk5MzZ1?=
 =?utf-8?B?RytYZDJyeVpFSDE1dkRMN3JnOGF1bVliYjFKTTRWOWlLUnAvYm1DTUxqYXMy?=
 =?utf-8?B?eE1ZUVdsdUpwcDJ4dlFqMzRkWWY3Q3YwT1pMeElMUFF4Vjcrbk5ydEJ6SDhw?=
 =?utf-8?B?ODRrenBMZVNoWGx5aTV1SjNRclhNa0lyeXFOS2R1bGZYK21YVU5MV3hzNkY0?=
 =?utf-8?Q?2ZS2Dg?=
X-Microsoft-Antispam-Message-Info: mCTKZ5xCwSHA8VZg4Iy4IaI686A+dmPY9oIEe2Wn43HKta1dZkY8kkEIZagR8G0lqNSQ9t1mVDLVxeUcAHTb/IISoksdWJxzxCVXEzYk7BBx7EjFeVyXLW0WGAEjZpaS0HVbGzeAujcvFovfmtgBpLGRUMo9nLThOBqEdXycRrxfRQWnSQrPvDGyCEEZGSQF
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;6:r6BPJWy1sGlKGNtr6oQVWA5FjgOMeSDnf2mAV0jhkUTFHSkhf4nxCI8y7qmE+e8QOdgRI7DlmaDqqaOHo2+pbykxHCbGoPbtqBbpSF3nZqj/OfDXk1QmxL1PCntHq6YzQAGQoeA+4qSTjMPtfM5KtdMWYqRwje1H+FzjHsI4CKKR+XSm+Dzo8UcSvSO3LObC41AVoz59onmeIz8yR/AbkpeUhVJa1GPYVkF8AXaH5nmiU2743CQo7YD6f3L0bFcaEj5fLB8HXE0OX7K0Zn9Q1UmVpnHMlgRkF9pNzub8/oBdqD5CKKW0k+ejwUlInXVcyf4WA2moO0q9LGG4bFPVfPZf+Dim9jdVkC42xoTlRSGyR5d937f/K/Hfj5zoKrwPnSssPxWjRxLtV3dMYtICzZp5YOtyfpNN3c1nZBvBjfK5J+lCz/6UJjMxX/+GO8m6nvIGBzndtyrOfNH9TE1+fw==;5:meNl+yUOXn1apfvba8OV+POneOVsj47isGYMfUoDDU8b0wZ+SPIeGBmpo5jXY4J6Uiitqnnhktr5KCyzQCU6ZXndkIf2amDSIHWC22tLW1e3xjd0oERnZ48Oy48YbEZK7mg00IsROaM9GaoZEyAGhCOZJTxMRZH/+tr2ffy7CUo=;24:5z1HdyQqwhgLWl5B8Usr9xb6gJodKQIKE42PAgO5QvKcJT1UVuUsVxArr9fxG7oQATS87TpRKXasAzxhB3/sYYDAxycXwxcF5pAaofl1WYo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3257;7:UzaDUGNwJDWNjrM7C7kso6IA3PTMDM58CxDGjsKaUZY/4lLCjUniwcLGKrDGzi9/ihc0Zt6UtOKpR3sYQ1z/fo5zumkCiwGyHkZQ04XqPtfCcUwzX+JvsdjD5UBZYLnsUmIj19Op9OAhWLYlrw5Jo2A6PPdVt8c8U/oam1H6s0WCi954ESMpTPjZJwuiIz5xNYyAxAZ11YEz/SS6yzZhLqn94cjlwa7QkGFNHhKSYz6smhxpalz5RYpbL7XR62rJ
X-MS-Office365-Filtering-Correlation-Id: ffa02bc6-1f3c-4bef-e5f8-08d5c18618de
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2018 14:53:22.1707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa02bc6-1f3c-4bef-e5f8-08d5c18618de
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3257
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/05/2018 12:37 PM, Greg Kroah-Hartman wrote:
> 4.16-stable review patch.  If anyone has any objections, please let me know.
> 

Please hold on with this.
I think it causes some degradation.

I'll report the issue on the original patch.

Thanks,
Tariq

> ------------------
> 
> From: Willem de Bruijn <willemb@google.com>
> 
> [ Upstream commit b84bbaf7a6c8cca24f8acf25a2c8e46913a947ba ]
> 
> Packet sockets allow construction of packets shorter than
> dev->hard_header_len to accommodate protocols with variable length
> link layer headers. These packets are padded to dev->hard_header_len,
> because some device drivers interpret that as a minimum packet size.
> 
> packet_snd reserves dev->hard_header_len bytes on allocation.
> SOCK_DGRAM sockets call skb_push in dev_hard_header() to ensure that
> link layer headers are stored in the reserved range. SOCK_RAW sockets
> do the same in tpacket_snd, but not in packet_snd.
> 
> Syzbot was able to send a zero byte packet to a device with massive
> 116B link layer header, causing padding to cross over into skb_shinfo.
> Fix this by writing from the start of the llheader reserved range also
> in the case of packet_snd/SOCK_RAW.
> 
> Update skb_set_network_header to the new offset. This also corrects
> it for SOCK_DGRAM, where it incorrectly double counted reserve due to
> the skb_push in dev_hard_header.
> 
> Fixes: 9ed988cd5915 ("packet: validate variable length ll headers")
> Reported-by: syzbot+71d74a5406d02057d559@syzkaller.appspotmail.com
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   net/packet/af_packet.c |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2903,13 +2903,15 @@ static int packet_snd(struct socket *soc
>   	if (skb == NULL)
>   		goto out_unlock;
>   
> -	skb_set_network_header(skb, reserve);
> +	skb_reset_network_header(skb);
>   
>   	err = -EINVAL;
>   	if (sock->type == SOCK_DGRAM) {
>   		offset = dev_hard_header(skb, dev, ntohs(proto), addr, NULL, len);
>   		if (unlikely(offset < 0))
>   			goto out_free;
> +	} else if (reserve) {
> +		skb_push(skb, reserve);
>   	}
>   
>   	/* Returns -EFAULT on error */
> 
> 
