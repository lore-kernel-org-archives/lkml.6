Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeBUIuP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 03:50:15 -0500
Received: from mail-db5eur01on0078.outbound.protection.outlook.com ([104.47.2.78]:3215
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751682AbeBUIuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 03:50:13 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com;
Subject: Re: [PATCH 2/9] drm/xen-front: Implement Xen bus state handling
To: Juergen Gross <jgross@suse.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <1519200222-20623-1-git-send-email-andr2000@gmail.com>
 <1519200222-20623-3-git-send-email-andr2000@gmail.com>
 <7b302293-a4ca-0225-576f-0cc33f6f56cb@suse.com>
From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <ca79a556-54bc-4ea7-e708-614269b11d5b@epam.com>
Date: Wed, 21 Feb 2018 10:50:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7b302293-a4ca-0225-576f-0cc33f6f56cb@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [85.223.209.53]
X-ClientProxiedBy: DB6PR0402CA0019.eurprd04.prod.outlook.com
 (2603:10a6:4:91::29) To VI1PR0301MB1952.eurprd03.prod.outlook.com
 (2603:10a6:800:13::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51a78b3a-effa-428a-8c60-08d579081b92
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:VI1PR0301MB1952;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0301MB1952;3:XeaacmrW6a/JZqMv8db7v2bfNYtSwh3//K7h1qcMKbJcrWFlLjPCyk4o3dUudpTa1kWeXKBgXE4/ETAipiS5CabZeyPquacwDkfRQgFigrhCIS2mV18acPcLV6V8SAXbd7oIBGfu/1c/cokVPiuyEcyvnWRot00TB8Eq5She2l6cL08Uxw61dZAo6kVfbj2MNJsxf1/M5qGYnBqIz5XCyUw2o/DSk/9NawdJSr0qInAyslae7kP49jbYALTEEd3K;25:WtBmHyspMSnkywdlY/CqlDehOXvIBG7SwvUsE4DrhbVIflj2GdOwRjvK8wDljuRelvHI4L9Ire98VL2H8nrbbcaTBc8jQf3iF5elg1qiYvk+8aoFUcWb21FAirCbzpIGhuLn2eSjNID7TlOosOhtTDhnM0WDwNLoNH6i2vTf7PPnF9B0sq3f7YnBwYPPZ62bcb+O1N1JueThkmuLDA6U7G428qFEGAPI48Zv0RyU+545gP6LB+GL/1ikNUAn414zZhB5X1Df5rBJmBu1bCuf2nVyPViBFsUdCmRIWHcSDU4SZtLLuwGOgeCaJGj9EL8rXVUliKjTEIICrB20SYVRtw==;31:WVrOzCE/5P+5gQMKHSuCMxOT3EMl9xGL5zyob1X8cz7M23CcTFtzohZiEbuo0jSU9LL9plvXD3IfXi84Mk/qXUBG/G7YwtuP5oqPIDxBDIfXpZDNdT1MsTz0ykQdHh6aE9dZCU/3629APbNLashzXnweKK43OQbh2XCggXgakZsPl761Fcq5sogs5s1qFJtHFiONjVQpHfFM+Sfmp7WfUDKzFpG64rP+JRXwlni1Dh4=
X-MS-TrafficTypeDiagnostic: VI1PR0301MB1952:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0301MB1952;20:4Ms0hD9G/AYHDFR4QD4C/dbUi6s8IQ4OEg3pfcgmkocLgGCxH8R2iz9B9d5fYY5CchBo4WY4xp0OibTmQs2BJNftxU0S/JFT33HolDTsAHI3Hf+oNcRg42hXo6JXxd7/PKPEd6j8Eali+/4hA9v5naxJGwJPcRjdn/iOc9Uc9sDcIE+dGLE6uYKwKv1I4sgX73bq4G0jRLpRjLYlGbgYnkmRfLIOpeSzjUJK8xNV8NWcf7/TvXm4epx/ToJuUh9CuknSufSk1xM8sxISTmiHPtqFWEeW40AcPoUIUi3V2yuzq7jZlfA5BTYTn1soMK1cMiK6txbZoN3X0wHin15/hha/uwfAU0Y3sedwFxa0Ds0fT1jJgCdQ6aO1nC772c39zR3WYLZKmIwqjbyubwP9/IhxvsQozPbqOYLSR/lmP33mnlKjOTt5y/yK+6qAm4r1nSjqzKlaJlJqmiz5ogVDwdLZ6jVvQ62deV2GNAFqgDJgjnqJ9B+ZGf6VfK0QVFmP;4:tZDhX8DnmGsQw8oLCrCl3PqCtuB3E7AMqrO4HvBljAfgbkmidZdbJBhj1uKLyam7tv1dxGuH2EHe4HC1qYqoFDUODAYD7NcXdoVyjZvCBFESRSQtoj69TXl8xdmJIS3HVpIMQQ+swlRozBPPpr2p51RZ4/QTEfWyoqKewrrru5U6zJs/W/4HEu2Jyg3b4RPIUXO7EpK3yeX2O/ljLo8AsXPQGENcx+mj76V3ghNA2bGee6LPH4uqsABa8SsH7SCJMMisCrIs7TkkZp3cfvxDOj6I7qGAug5rH8IQCIF+KS8WeAQLc7hcVWHcJmkuxnL4
X-Microsoft-Antispam-PRVS: <VI1PR0301MB1952DA9B8A46AC77D6D93BADE7CE0@VI1PR0301MB1952.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(4114951738403);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(3231101)(944501161)(10201501046)(93006095)(93001095)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR0301MB1952;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0301MB1952;
X-Forefront-PRVS: 0590BBCCBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(6049001)(366004)(376002)(39380400002)(346002)(396003)(39860400002)(199004)(189003)(2906002)(65956001)(65806001)(7416002)(80792005)(66066001)(8676002)(81156014)(81166006)(47776003)(64126003)(31696002)(25786009)(50466002)(39060400002)(97736004)(8936002)(6666003)(229853002)(72206003)(105586002)(68736007)(2950100002)(106356001)(26005)(36756003)(230700001)(59450400001)(31686004)(7736002)(305945005)(3846002)(55236004)(53546011)(186003)(77096007)(16526019)(2486003)(52116002)(478600001)(386003)(65826007)(58126008)(110136005)(6246003)(67846002)(5660300001)(52146003)(23676004)(16576012)(6486002)(316002)(6116002)(76176011)(53936002)(86362001)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0301MB1952;H:[10.17.182.9];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAzMDFNQjE5NTI7MjM6Tjd4UGg0eVN4cGErQ0RTTkVzRm5zWEE2?=
 =?utf-8?B?R0ZKU0xnaTNNL1M2M011ekJTckhXSkIwQmJFN3lveTdYd1NCcDFSN0RwcXlG?=
 =?utf-8?B?Zmc3L1FMQ1FYNFB2dE9Gc1VJQ2JmMHJ2SHM1Y1dtbEUySytYQXRPRUtKbndF?=
 =?utf-8?B?U3E4RXZnSmdCcE1kZS90VHFJZXhUM1hkUHE4cHJTQ1pnaE5xVDc2ZEVMMFk3?=
 =?utf-8?B?SU9PdmtrTGJrczlPaThJUWVGNUU5NlFyUjFDRzBBU1VWWlZHR0ZzaDFpb0ZY?=
 =?utf-8?B?WHhxLzFyUWtwYWNiNlMxQ050aHdsUEZZOVE4Y1NJa0lLZXMrRXRwTGNaQ0hR?=
 =?utf-8?B?QWhKQWd6T2tUbEN0N0cyNGorTWdxU0NBbHpudElOUUVRTjF0K2lMamNMR21S?=
 =?utf-8?B?MGpYaEhrSExkSlB1STEzMzJKODdWbGNGUnFGNUdaTDF3cFNtSDJacVBRRWY4?=
 =?utf-8?B?MmdKSkRGakRua3A4bWk1TGM5VUNHaXdVRy9VOEVhT284UXJKc2xzR203K1ZD?=
 =?utf-8?B?VmtBUEp5ZC8rb3Q2LytzT2ZYK3ZWdmlGZW1CdlpTV3M3VUpVakZTcVk0MnFT?=
 =?utf-8?B?MDhsVGdxbzM3ck05aEFFZTJTTHY5SENPZFFCcllLV2JwaWNrRXFwbGEwckpv?=
 =?utf-8?B?WEdEeEh3QjBldUQ5Qk5odlR4bE1ocXl1WUdZZUpLMEVqQktkSm45VGVwMEdq?=
 =?utf-8?B?L3RJQXVaZW81RFJnZXdzV1pyeDBLaklVbTJZUFdPT2dJQmt1ZHI4Zjk5RFl1?=
 =?utf-8?B?TzNMQlVrbnNXaWQ5MTIwbC94RkZlQkkyekxWdHorSnlwT2dLb2VXNjJ5TUhx?=
 =?utf-8?B?M3BxSllHdTIxNGJiZ3VjS3lDZTVMaUM0M2RXS1JiSHZtOGZXWXV4YkxmZzVh?=
 =?utf-8?B?ZzJ2YS9oZmNhM0pOUWxKV2Vrdzg3MnoyajBORDl3ZFFZU3VpRGJLdGdnd2Vw?=
 =?utf-8?B?N3ZYeklXNXMyaWlBOVpnb3BjK3JDVVVSL1BmeXNJM3RpdDNndXZwKzhhSHV3?=
 =?utf-8?B?SEFSaUtmbFZUaGZ4clhnd0VqdGlBQmR3N2Q4dnVtalFuWHhLR3RvbVlaRXRB?=
 =?utf-8?B?VlFYdktNbjYvWEMvYlNIUG1ydWl6MEdYRFFGWWgrZFRCN3g1N01Mc3pkL3hG?=
 =?utf-8?B?YXR1a3BXa1pqS2o2YXJKMEh0ZjhRTCszTzVGUGdBSXdWT0x5Nm9yWTdocUhF?=
 =?utf-8?B?anFKVDd0QnNzK2xrVTBUMTJUK2I2WTViVThSSDVIdDFQdzU0SEdFc0d4Q1ow?=
 =?utf-8?B?UmY0dHNOdndSN1lDckRtQ055UEVLZzVEUGtCc1BiWUpkQ09oL3Z0SE9GN0s3?=
 =?utf-8?B?UlE0WUNmVTFDS2Q5SHVuQWpjL3NnaStHcTBOQTA0UkljRnVSNi8xY0ZOSURC?=
 =?utf-8?B?d081WlBvWjYwdVg3RzRYd2tXN2NDelJZVWpPWGpGbmUrQzRudXVFYUVNbmpY?=
 =?utf-8?B?aHZJWTVDdXkveEIxUXBrUmlQRHAzQUVPTVFVdjQyaEp1c09VVnpFM2kxMnQv?=
 =?utf-8?B?Z2t3WlFmRWtGci9wajdvTzhUZ2dCRjVncGNJblFmajdzUkZSbjBZMXlubDQr?=
 =?utf-8?B?K2dXd2NqZFh3aUFUSWRna3lOcmgrRFovWUhwOUtpRW4wNE00ZjdqOTFiVk1R?=
 =?utf-8?B?QXo1NHdMYVAzY1B0dDlYZlVveHVYWEJUUkNWWWhTNS9FSUhSaTNoNTRwUGNQ?=
 =?utf-8?B?c1d6ditjQXJuNUJlNlN6RSs1bkVzWmc4djlZWXBwbmpUd2ptNXMxMFpZNk9B?=
 =?utf-8?B?R04rY1djK2JnenQ4M2ZTdGV1ayttZjZ5bzhOdW5sSzROanNTbnB3dVpzdlZH?=
 =?utf-8?B?TE1rWlRoZ01IY3pXNXY0OWxXK1F0anlINFIyQkx0c05vWko4bEUzWktnTGxo?=
 =?utf-8?B?ZytLMlMvM2hOL2k2ckE1aGF5SkxMTEloMm8yTGtGQTBlZUI0L0t3U2sxeW9Q?=
 =?utf-8?B?MCtSYTRjczl2RFlKb2RoNnJQVTlJZnBDNFNrTWw5bkJ1azUxcVcyYlUyREFJ?=
 =?utf-8?B?TjZvaEJMb0hBT2ZtMTlpbWhKOWhwampaMWpZbGROV25nQjBLQ3FCRkRORG5j?=
 =?utf-8?B?QU53d1BWM25Qc21rcWRadGhyYXY4UmU0SmtLNG9NdHdKUHNrRkNFTzR2UkF0?=
 =?utf-8?B?VlRGK2lyZ09LaXdKMnFBU0VHVENwelphclhmVTVuRjlJSU1MMWxJSlZMNE1s?=
 =?utf-8?B?M3RkUVdXM2g3eHl5ZXI2VWw5YXZ3M2c9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0301MB1952;6:4T0oF8ZmS9lEjt/eij7zH6XAG2KyXC+72HjRPoXcjWwjbHAHNVaX5Vq4VjpZK89AQzyDVcAvyOnkSrHTPhL/Tl4wAHhDednjf283afi6wcp6fLqFCEyRKnXz0hRMS+MYbRFuyN9FBZuzJyl9kbS0ie0CtPYOD1u0LQTJ/8IOw1dnX4mTgAqjiyfYMHV2KxSYw+Z9sS4yZNFrlFquQ/921Yy6/D9NVkw8KIkY6VyCxdimvRtyvDcGQYgVGfwQIKD0C4q28WXvycptelPlX//CXRyyvhZ3bHHsh3szRps/16E1HkfSNDNbwF6Y+i+lAta4Vr7wzvBsrADG+B5n7NuLxy6SLj81hQav5XWLVoZ/LXc=;5:MHnWlXQY1U1uTR4tWhmVHKHSGRsJybvIY/+8Q5BUTccdVTW5NfLraBhHvN7y+i4/6Op6kcRqB8RqkdN9ruEgqzsJnIM/fcDRKfKJHfxF0bN0yeuIM1GgCDj0Zc6Q2uoMdPkr+qhZffYJdb9L2JM5E9TZIffZMlj3c5tUZtAAv4c=;24:yrX9s+37OK/4QnUwGh+aals1LSmGG03IezJkU9g+qVzLz5/7uRemT08OD2aCKVzEEEm1HgTTcvNx7YuOmUsoQafm+GoPTBwPvrlhbr1rRWs=;7:3PFOngfx1E8A1ci8kburEuwk35sHTJpvEI/esuZoGq5cOhgrj3Ha9uyezDzKlYC0ohe4jqN6VWNCa7HyXDRtK/jnoLLIl1Cij1iKJzd9f4fNYM1eLPOImRCinRQS5drqKwZIduFmJya/18jujzMGv97/flSZPjH5d4OfFr3QvgcDblQQVXJV75IH/otWBbnTFlS7I/Tn0JAOAL6l5Wk9hNcAVFa37kyrKGCGUHyl+mUA3zGE+bVNuY9y7zjQlK6m
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2018 08:50:05.9891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a78b3a-effa-428a-8c60-08d579081b92
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0301MB1952
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/2018 10:23 AM, Juergen Gross wrote:
> On 21/02/18 09:03, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> Initial handling for Xen bus states: implement
>> Xen bus state machine for the frontend driver according to
>> the state diagram and recovery flow from display para-virtualized
>> protocol: xen/interface/io/displif.h.
>>
>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>> ---
>>   drivers/gpu/drm/xen/xen_drm_front.c | 124 +++++++++++++++++++++++++++++++++++-
>>   drivers/gpu/drm/xen/xen_drm_front.h |  26 ++++++++
>>   2 files changed, 149 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/gpu/drm/xen/xen_drm_front.h
>>
>> diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
>> index fd372fb464a1..d0306f9d660d 100644
>> --- a/drivers/gpu/drm/xen/xen_drm_front.c
>> +++ b/drivers/gpu/drm/xen/xen_drm_front.c
>> @@ -24,19 +24,141 @@
>>   
>>   #include <xen/interface/io/displif.h>
>>   
>> +#include "xen_drm_front.h"
>> +
>> +static void xen_drv_remove_internal(struct xen_drm_front_info *front_info)
>> +{
>> +}
>> +
>> +static int backend_on_initwait(struct xen_drm_front_info *front_info)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int backend_on_connected(struct xen_drm_front_info *front_info)
>> +{
>> +	return 0;
>> +}
>> +
>> +static void backend_on_disconnected(struct xen_drm_front_info *front_info)
>> +{
>> +	xenbus_switch_state(front_info->xb_dev, XenbusStateInitialising);
>> +}
>> +
>>   static void backend_on_changed(struct xenbus_device *xb_dev,
>>   		enum xenbus_state backend_state)
>>   {
>> +	struct xen_drm_front_info *front_info = dev_get_drvdata(&xb_dev->dev);
>> +	int ret;
>> +
>> +	DRM_DEBUG("Backend state is %s, front is %s\n",
>> +			xenbus_strstate(backend_state),
>> +			xenbus_strstate(xb_dev->state));
>> +
>> +	switch (backend_state) {
>> +	case XenbusStateReconfiguring:
>> +		/* fall through */
>> +	case XenbusStateReconfigured:
>> +		/* fall through */
>> +	case XenbusStateInitialised:
>> +		break;
>> +
>> +	case XenbusStateInitialising:
>> +		/* recovering after backend unexpected closure */
>> +		backend_on_disconnected(front_info);
>> +		break;
>> +
>> +	case XenbusStateInitWait:
>> +		/* recovering after backend unexpected closure */
>> +		backend_on_disconnected(front_info);
>> +		if (xb_dev->state != XenbusStateInitialising)
>> +			break;
>> +
>> +		ret = backend_on_initwait(front_info);
>> +		if (ret < 0)
>> +			xenbus_dev_fatal(xb_dev, ret, "initializing frontend");
>> +		else
>> +			xenbus_switch_state(xb_dev, XenbusStateInitialised);
>> +		break;
>> +
>> +	case XenbusStateConnected:
>> +		if (xb_dev->state != XenbusStateInitialised)
>> +			break;
>> +
>> +		ret = backend_on_connected(front_info);
>> +		if (ret < 0)
>> +			xenbus_dev_fatal(xb_dev, ret, "initializing DRM driver");
>> +		else
>> +			xenbus_switch_state(xb_dev, XenbusStateConnected);
>> +		break;
>> +
>> +	case XenbusStateClosing:
>> +		/*
>> +		 * in this state backend starts freeing resources,
>> +		 * so let it go into closed state, so we can also
>> +		 * remove ours
>> +		 */
>> +		break;
>> +
>> +	case XenbusStateUnknown:
>> +		/* fall through */
>> +	case XenbusStateClosed:
>> +		if (xb_dev->state == XenbusStateClosed)
>> +			break;
>> +
>> +		backend_on_disconnected(front_info);
>> +		break;
>> +	}
>>   }
>>   
>>   static int xen_drv_probe(struct xenbus_device *xb_dev,
>>   		const struct xenbus_device_id *id)
>>   {
>> -	return 0;
>> +	struct xen_drm_front_info *front_info;
>> +
>> +	front_info = devm_kzalloc(&xb_dev->dev,
>> +			sizeof(*front_info), GFP_KERNEL);
>> +	if (!front_info) {
>> +		xenbus_dev_fatal(xb_dev, -ENOMEM, "allocating device memory");
> No need for message in case of allocation failure: this is
> handled in memory allocation already.
Will remove, thank you
>
> Juergen
