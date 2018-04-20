Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754903AbeDTNKG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:10:06 -0400
Received: from mail-db5eur01on0127.outbound.protection.outlook.com ([104.47.2.127]:64191
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752351AbeDTNKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:10:03 -0400
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=axentia.se;
Subject: Re: [PATCH v3 7/7] drm/i2c: tda998x: register as a drm bridge
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180419162751.25223-8-peda@axentia.se>
 <201804201731.D3OnDg0p%fengguang.wu@intel.com>
 <4e9bd91c-6b29-cdd2-9e1d-1728311ddb81@axentia.se>
 <20180420105337.GX16141@n2100.armlinux.org.uk>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <82eb95e8-c085-59d6-7b13-ef7e1abaa40d@axentia.se>
Date: Fri, 20 Apr 2018 15:09:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180420105337.GX16141@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM0PR06CA0018.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::31) To DB6PR0202MB2775.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:l4WAZga6p9X6800G+drPCtJaDq2x/bcCMy8h9ojzvcRnan+YzmFfSkgXGYb++sxhsuhebC8oVzo31jGKhMYC/jBP1dLo+NdZfUGqLfKHg92l15Cr7BoM/vQrlQC6N+iiYH7Iy2KxSsIRvnHkRsmz7eDQxBK+22Nx1kQcNsjNMT25kSVJy4iNjTbzKfguINWjTvpKqBN7d1raf+HDUIurlDIjIRfR6CDwh9fYKmeWXl3yeTh/EYzQVPM0Z+G/OC9O;25:db8i0odQ+ObeubfmInhRvnUWBwiSOpMfsshpqbPHp6h9pnZDijg9KQ0VCS1n3Qzlt5osqMN1Tlz1wFc71hBx10plhrdHZTrIiPe+Xf271fI+F/IHhYTvyuCJNgft6whnZ2t603u7WklHmKOTeyRIGjRy2sKVwAwb0A+sb+nJC/SswMaA4JK3YaRioIqyPJ0LBNcbbD9RpHKzctB/84Me5y26oqtjHjK3R0R7MMrRyQ7aECsFLI1mhvTG4qhIEYJipcVSbk6K6Qt8KlGuzpRQz1H0f43OluS9Pv4g20ljBuY/Y5FtAAPlGiHyUTGX5PJmZjyVZ9XewU3st+Dv7uCApg==;31:9Y50GRphrb5Ez/QBBwv3aOETWEhclu/kC4nvCJNgcdMoTz0daL+iH7J2Axneif5aoBLKu1WIJxDCWTz0zq3WMlNzk8GIB1KfnhONng4rCcGxJ90h47GMr3elJ7hTOQuzzIInQJv6/7v78yLZ3kfehB/kpiqgF0g72CRpKoBUL6eNhKzHBnJUZrwp/8uOf50SVwKa3+O6ok3NfeZWwCwBAThI2zS88IVPTm0/1OoXL1g=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27753412665FEB48722B85FFBCB40@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501394)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:pnKQyR7K4u6KZN6i7ENXbsKXPs4hx70TA9f9rzApVWP0YI8ojiy5jz47MECZVLtW1Kn86gjaA39uRkUfbXUlSVAYi/e4SVlkdM+QoVAjw8yp8lUVAYThZQoB8ZqbiK1tCRDiKXFkAODv3qUCe3uVqjqkCoDD+RGpb3AiwGqWvCb3BG1gHCeJuez1ILUC5TEpEK9wDIVCW1xUR4Pnnd86UjBpGIMJ091QRBxfB58X+K9UE34m9YTEOjRx8/Bw6eDDw6FBaylIqUe+ocAMExyMDPesKTEK4MLqiLbqMX/lLTWX4r4N1jKla5hY1M+wS5aQ
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(39840400004)(396003)(346002)(366004)(376002)(377424004)(54906003)(316002)(16576012)(36916002)(8936002)(74482002)(7416002)(53546011)(25786009)(5890100001)(11346002)(26005)(16526019)(66066001)(117156002)(47776003)(2486003)(23676004)(76176011)(386003)(52116002)(52146003)(446003)(3260700006)(186003)(50466002)(2616005)(956004)(476003)(77096007)(31686004)(6916009)(6116002)(93886005)(36756003)(65826007)(3846002)(7736002)(4326008)(305945005)(86362001)(478600001)(6246003)(2906002)(53936002)(230700001)(31696002)(6306002)(8676002)(966005)(6666003)(6486002)(5660300001)(81166006)(229853002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:[192.168.13.3];FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzU7MjM6Q1RBamcvVml1MWFjQjdiMTl6RGorTU9D?=
 =?utf-8?B?SHkyeDFkVS9CV2FRNUh1bTFVUUVkaW1rRnNKUG8yTldOZ2NqUGNGbVdjcjdj?=
 =?utf-8?B?TXVOUDdJcWpUL2JsQUtKZzlpSUxZb1RjOWlzTFhiejJWaFdHa1dCN0Q2NlJE?=
 =?utf-8?B?SU5EVENVeUg5REplSWZ4NmdvNlZ6bzVoT3FiRmo3ZnhWMXZOdzNFUVdnS1Rs?=
 =?utf-8?B?UG9XM1lHOEZWV3JGZmdUek5RQlFHSlNvMHIyL09BMEZiU2lyRWd0SW5WUS9L?=
 =?utf-8?B?SUF1WXd0QldXTHpSaUw4T0JIY2RSeWRTc2EwM2ZPbVVoUlAxN0lHSW5WZGRU?=
 =?utf-8?B?cW5ObHNWbzVBRXpOR2NkU2poSTVEMHpwUitPMUcrMzBHcHdySUlwMVhrQnMy?=
 =?utf-8?B?RGlNTVhOMjEyam5VWlpqbHBRakZpNUtoWTBGSEl0YllhL29NcXd4b2xoakJp?=
 =?utf-8?B?WSt4RVk0R3V4Z3B1Qjh1YUF4WUF6OWY2b1BqWkE1ME8wVWhWY3Nta2V3Sm4v?=
 =?utf-8?B?ektiUjVkVmI2cDlUYWlIQ3R0MldvcFRjOUdIVEpEWm9wYng2SENwMDcreGZq?=
 =?utf-8?B?cjhSOFFnd0pYOWlaeW1JVVVQNDFjdTlvL1QwZ21jQzNrWnJiL2tSUGhWa09Z?=
 =?utf-8?B?czVLK1RDV29WTVp1VXZyS2ttL0hoWTlkaWpPcEMrbHhHZ0pZaWlJMlBrRFM5?=
 =?utf-8?B?MnIrMmw1eTh1WmxDNGhCelpvRUMyV3d6bVJUZDh6R080bFJFQmtEaFI3dGhU?=
 =?utf-8?B?YkgzSCt6VDIvcVhER254MHRnZ0tYZm0xNjRrMmJBMk9GdUpJV1ZOdGNyV1J5?=
 =?utf-8?B?ZjhORU1oUE5HbjRoYmhxVVlMcERTV2wwUndtZFFaYVN0WVlVT2htbUk3T1pu?=
 =?utf-8?B?VXAzb3dmMk5Lb1JGK0hTSWpjWVhmeEs2STA2Y21ma0dOczdIcmJCL0QrRnBL?=
 =?utf-8?B?UmwwbTNDQ3YrenRNVjFqYllqSXNTUEc0d091QXpnK1JMeG8rVU5BaDRBNnMr?=
 =?utf-8?B?THVmMVhtaXdHZTNBWWwvcmgxY2E2SDNWZlJ4bGdIZi9tbUFpemM1WVhhODA0?=
 =?utf-8?B?bUtMbVhCTkFFU3F2dVhPcUhneFhabzdhdklNVVc2YkEyTFpTbnc2SjZyWFBS?=
 =?utf-8?B?eWpqZEcrOHJNc2tDdDk2TmRqWEV6enFMT3dOamlNVThGek5SUFFpRnlSRXhM?=
 =?utf-8?B?dUd5bWtqQ0ZuVys0ZE1yeWphTnNqc2hXdHN4YTBlV1ErS0h4dVJ6TTM2UFVx?=
 =?utf-8?B?a25meUpYdm9La1FQMFJlWEsvc0hWcWdJZzNSVkJlWHQ3YkgrL21zaFc4c3B4?=
 =?utf-8?B?VnVJNTFiMzJRRllZeFhxTG9zSlhEek1FMmd2TnFxblEzOWdXcWxhVzZwVDlO?=
 =?utf-8?B?bkpLOXB0QjZ5K3hsTm9JRTVLU2NzditvUzgxaUhLYURYb0d4MzR3a2g0U2RC?=
 =?utf-8?B?UU4wZU1Jd2pibUtxeVJtdFp0RnJDbnQrZVJtbUhuMVE3ajRkS2pCTllTMWcv?=
 =?utf-8?B?ckVFaDM4ekZzb1JpWXZmcnUxdVJpSUk2WlN1dVFqQ0l0eXlQZFRNa1FPc0Fa?=
 =?utf-8?B?U09leGhiSEJYdWIxQUZXdjdndFEveFVVSm9BTW83ajI4ZzJYZFFUWFJ6czZy?=
 =?utf-8?B?QnZsRlhpNlVPK1B5ZGpHdTNNeU9yMHBHK0VEakFES0tPYkkzVG5TK2dRV2hU?=
 =?utf-8?B?RzF6KzkvditHRThoZlVRSG8rMGFqWENQZW14WGp3c3ZRWFBLeGdSY0RLakpC?=
 =?utf-8?B?dnFmZnZ1TkxjQktsd0ZIbU5PMXBscFBjVWMwOWhTdno1OXdsN2c4UHVDRlA0?=
 =?utf-8?B?UVkvN0hlZXNDSHk4RVNySHhPRVJlaWtuSzFwbE9sdzNPMmlxUDdOcmc1K3hJ?=
 =?utf-8?Q?y27YMEmJzSwZucLl0lCr1vvM7gZng3DCFV?=
X-Microsoft-Antispam-Message-Info: 45efN8ZGYJBSQaV2QOOWeY82uTMjxbovaoiwKwj8+6F8+INnOqxyzAy7st1Kqu1Gpx+mYL/OPbMlPUKkFnTbIQ/B37yvclf3Qv0jNXIPd09mOLwhvfTb5B+037Nu1n6S8lQb95PFsiF6C7I47kW9Ji8YdpzSRhmKbCNY4siaPbJtHNwjg0Sd4/LIx39vEPZ+
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:WzySs+V0G6RJ+uGCQrzv7Hu1GAHo3H138zJEDEsFYkc3GWfi/KoS8DVCoCFrRWQG15FWI9pVa33UKK76Z7+4VlxSf3ey//+7rODaRyJ3hPKHZU+cl0MDzxwl1HRp+4JfYWqQV0RbTUCYes3T/PSXkqZypW7wfPUrDomy43utC4Ehr+YWDo7qDw38uRy3CZfLyvCxKzvuB/A94UvHvcETue1LJk0TP+CTDqb3PZcSI823mlUnk88gpmfxLArqa2Oil0kKqOKWzPZeUCtky9L34j/7eg+vSF9zrHfSJk7nKeMpkbVsSMNCs6a0e4u9vmd/E0ZdauLq4kl1zVRrSu03TCuWRzJTolyF2CvQ8gUUtvwYwxG/q85/xZV+bPz+WJyppYpDYdTSIvUD5dLfbS+DnBWfK2vUEDNYCoIzcLCX/Q2ma0FkZYBPqg61f+eYPp8ahtFHAs7ujS+rCNeh1gk8LA==;5:e4hWFYdCtxMKuuaZK6bFi3V6nthyfk1nb0sAoveKfkToMZNN9grTkXsY2denL7h5/qlJh1kiBVprWIQFqdltHgRUN2FboH9oA68ujJX3A3fxSCbEj5xhrxejUix7I4jOfqceZ+QJk4UNgZEovh35mjpCCfeDXr20cW1U7BuepdY=;24:by+9ruyxxJfT8Hmk7HDTWXW9FcpHusT13pKbXmndxX+TLzsswGBy1GVUammyITSL/IC/U6MN6j0NBR2Mi23w6MtFBV3WufDMAuiK6tzl3z4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;7:ybAFmLJl62CqUV97YUPJyLzgtfY+EneolBlhRC+OBlnGqB96hrz2pOm261OyYOwbgV2gPAM9CubD+dL30NL/fHix3j0qHOfVgBDi3p3lT3b8FJAknJ67tiLA0HWQWx2avKDP9ru5BlvbB22f7At/4kWAG18i+G4Z767p970tRuESo4492yBVdwdJVxpXwA3scqGiYzsTphmbZN7U+2/RSlz+le+OV1Vt01NN7ZB5jzNA3nC6qQaOU7tsnMh5gOEN
X-MS-Office365-Filtering-Correlation-Id: 623e9e25-9389-4fb4-c188-08d5a6c005b6
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 13:09:59.1650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 623e9e25-9389-4fb4-c188-08d5a6c005b6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-20 12:53, Russell King - ARM Linux wrote:
> On Fri, Apr 20, 2018 at 12:49:42PM +0200, Peter Rosin wrote:
>> On 2018-04-20 12:41, kbuild test robot wrote:
>>> Hi Peter,
>>>
>>> I love your patch! Yet something to improve:
>>
>> Yup, right you are!
>>
>>> [auto build test ERROR on drm/drm-next]
>>> [also build test ERROR on v4.17-rc1 next-20180420]
>>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>>
>>> url:    https://github.com/0day-ci/linux/commits/Peter-Rosin/Add-tda998x-HDMI-support-to-atmel-hlcdc/20180420-160131
>>> base:   git://people.freedesktop.org/~airlied/linux.git drm-next
>>> config: i386-randconfig-a0-201815 (attached as .config)
>>> compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
>>> reproduce:
>>>         # save the attached .config to linux build tree
>>>         make ARCH=i386 
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>    drivers/gpu/drm/i2c/tda998x_drv.c: In function 'tda998x_probe':
>>>>> drivers/gpu/drm/i2c/tda998x_drv.c:1859:16: error: 'struct drm_bridge' has no member named 'of_node'
>>>      bridge->bridge.of_node = dev->of_node;
>>>                    ^
>>
>> Anybody got a better fix than this?
>>
>> #ifdef CONFIG_OF
>> 	bridge->bridge.of_node = dev->of_node;
>> #endif
> 
> How about the bridge code provides a helper to do this, something like:
> 
> static inline void bridge_set_device(struct drm_bridge *bridge,
> 				     struct device *dev)
> {
> #ifdef CONFIG_OF
> 	bridge->of_node = dev->of_node;
> #endif
> }
> 
> which (a) nicely hides the firmware flavour, and (b) hides the ifdef in
> the bridge header where it belongs.  If the bridge code needs to be
> converted to fwnode in the future, at least this would be abstracted
> from the drivers.
> 

Hmm, I looked around and found numerous other #ifdefs for this, so my plan
is to just add one more. Fixing up all these ifdefs is orthogonal and can
be done later.

Cheers,
Peter

PS. I also noted that I had forgotten to remove a couple of dev_info calls
in this patch. Will remove for v4.
