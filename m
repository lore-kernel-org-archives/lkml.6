Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751783AbeBWPfu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:35:50 -0500
Received: from mail-db5eur01on0063.outbound.protection.outlook.com ([104.47.2.63]:47162
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751351AbeBWPfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:35:48 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com;
Subject: Re: [PATCH 8/9] drm/xen-front: Implement GEM operations
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, konrad.wilk@oracle.com
References: <1519200222-20623-1-git-send-email-andr2000@gmail.com>
 <1519200222-20623-9-git-send-email-andr2000@gmail.com>
 <2f2c6fea-c0cb-e244-41f3-269db07986fc@oracle.com>
From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <56c4a78b-356a-fb35-a97e-187581ae45ad@epam.com>
Date: Fri, 23 Feb 2018 17:35:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <2f2c6fea-c0cb-e244-41f3-269db07986fc@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.223.209.53]
X-ClientProxiedBy: VI1PR0102CA0001.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::14) To AM4PR0301MB1940.eurprd03.prod.outlook.com
 (2603:10a6:200:38::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a1be7ed-976e-4190-1b20-08d57ad31b21
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:AM4PR0301MB1940;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0301MB1940;3:wS+3X0wlnKG6rKynYKC6UsNL/cqKGnzJbcG8tuEeni5ZcnHri9zsPOeMJZDvgqrkBtYGhLibtGG233746cVGIvCTRJaYP53R/5OMs8wIsnRsa1S8xqYQt+Tqr88BGl8ehAX+ucovDe9ecvkzRLID+LIvSl8tVGqe6S/hk0pN5LXNFAQ/ZHot6C+GJgVopj/I2oVFpcikhwWUVEyOidowS3rgsWXrXIIY74eyGby5acePGjt5+ztA8aJYssAq5URv;25:T+u118AGUJ/El5vZQ00Yxn5xBwNNJO8uPXj80eUCTDGKdZ4chiXny4Yvx0USNuWYNLTyOtI4da3Qo193/pznP84YlqDd5rwB7wOQLAV+Ta+/zsGqPGlPMdge5DTguaUXCJiaHHRlLRRKholxn5vM3TgCYakfyF5rbhG+//c3TIHNGWC2xtUb4DgvKP3Tea1DvURGX2/0I9+kOBM7MaRFt4SmQBk2GW2rmE4+QglgvkrbcjuXsQzN9i48MitjCxjSVueEIlDs97Ml6gzBpNIB3ChFIu589z9bjHWAJKAephyo+s8OkuWRMXnKiYoD2o9yfBqbCLOa6/EMCnoeKXhLlw==;31:X0z9pm3TORzJfcGrh97XNAsX6gnAv9y89yR5HajZ9xmbQpV7nTXWGf6EQoEF8ASrtJ0+xEWrjirXNlBISnp5iyMA5mWtga5kxP66/e1TI4T1W/My8/U+auIusR26co+Hhnwo+kB+YO7NA1PO6uKxGox0bU6KAx2sgy+ApFGF1Ljx/gjSnSo+V4f/zldxwz4s+68QyK3RXHK5QEAF5DiQMPNqGXC6ufEle3Nh9y5id08=
X-MS-TrafficTypeDiagnostic: AM4PR0301MB1940:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0301MB1940;20:HonvjbQuikagK7XHDVTTZzmX9ROuNoqnm7vgD8pmUafI+jFKHcKcXsT5nK+h9oTn3COhO5cJSBbUJmINqQLRFwXhzmHgri1yeNlJCKZYPw0xZr1eiV+SEzl6FWwOtfLBBQrSJB47Qk/PtJyxh8Vuy6x1jm/ntjTCXRxFDq22IRv88uJCi4TB6LiagHLg/yFdmHbPVXbZXFyIub+fxNv33ddoYA/jTbUCAq6jBhgWKg358Pr31X9acdPSc4uI0HJ4Ee+NBnK8uMtqegmMP1EdNOsK569wub5oZmOYV1DJPIaI7+3WF6ZsYHZuo5jGhGC4FUbfSkwAw57ZPf9pGopb5dmmUcEvchUjhNrvZsjeSg49oLcza80w8L1/v4hVN6SYhoMcp6TKxdX2RVj/q+J+R+WKyCUOkALNZhSHY6S5Lse2V87TTIsaKBJ6CBGqy8Qgraksf3KswneY5kK2ske6FAzf8V8lFXouydsu7eCYVHDXSBzf0dimR9f93MXzNIqK;4:1BYar854zrgtTjvlnJWLojlp+59HN3ZMbWnH4/+O4WYlhEtKTqvVFI9NVBbXJNv05pr++Z8ka6vHj9Xc6KxUyUZEUyQO73g6S0GQc984EkysubawHIqlhJdq/4+U4s+0SkcEVWrTCl7WsZgLok+g5SM17YxcW5NhPn+6/JiI6WOHbqCSuek8NHFsgaFSNJ/EcAy8SfYNA6lZOYvEwDopmXfL0gB8tuHUEm+vzNbNNVzQ+ZRsCCKR6kL+FE3Ki56vz49ImLjOrQ6r2a9sc0a0PSoqLC4ZSnmjcglYF8c0mkViCPibeeC0pb/imO9j9AVJ
X-Microsoft-Antispam-PRVS: <AM4PR0301MB19405EBF4DCAD87426C5A38DE7CC0@AM4PR0301MB1940.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231192)(944501161)(52105095)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:AM4PR0301MB1940;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0301MB1940;
X-Forefront-PRVS: 0592A9FDE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(396003)(366004)(376002)(39860400002)(39380400002)(189003)(199004)(105586002)(305945005)(7736002)(77096007)(478600001)(68736007)(8676002)(6486002)(8936002)(186003)(65826007)(316002)(16576012)(72206003)(5660300001)(16526019)(2950100002)(6666003)(7416002)(86362001)(97736004)(80792005)(31696002)(53936002)(81166006)(81156014)(64126003)(66066001)(65956001)(47776003)(36756003)(3846002)(6116002)(65806001)(31686004)(110136005)(52116002)(58126008)(52146003)(2486003)(23676004)(67846002)(76176011)(2906002)(2870700001)(53546011)(386003)(26005)(39060400002)(59450400001)(55236004)(106356001)(25786009)(50466002)(6246003)(229853002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0301MB1940;H:[10.17.182.9];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAzMDFNQjE5NDA7MjM6bCtjS1pZODc5U3JoSnB2VE1IVTRqMHlv?=
 =?utf-8?B?YVFpc05XbkJmMmxhOTVnenNDYzN5R1ZYUTdNNi9FTkhWRUxZL1ZicjFyOFZk?=
 =?utf-8?B?Y3M4OTcwdklaRHpnb0poNkFieHllcllLWVIvKzM0UEY3cy9WbjNKSTVreHNx?=
 =?utf-8?B?SC9KRkhjUHNwaWxlSlA3MytYbkpacWgrQW4vZ1Frc2plM3A0NkxkMWxBaUwx?=
 =?utf-8?B?a0EvUTRBYXcyTm93VmJHT1ArWFBWOE0xNXk4WnBLZmI4TmJwSG4rQmhIMDl1?=
 =?utf-8?B?dkZBSU5OTFhnUmRHUk1pcG5sOU02UHBLOGQrRGZoWWxxcjB3SExockMzRVZH?=
 =?utf-8?B?L2NSYTJFY1U0TXlQTFNlS0hwTk9KajVIMHl3MW5NTE9ZbllzcVBaWnZnUGwz?=
 =?utf-8?B?Z1R5eGlxZ29qUGZIRVRKWGZxRkQxU0JuUkpzajVMb0lzSGRpNVRnRUZ0dVpV?=
 =?utf-8?B?YWltZFk5anFBQ2FYaEhzKzAyNkl3Tm5iMDN3bkNoYkVSb3pkOEJzcEtha0hS?=
 =?utf-8?B?ZS9GNGk1VHMrLzAzdnV0ZjZDWTFxa09iSm9vak9PbVRBVUJvVjE1bmJFVXlK?=
 =?utf-8?B?ZEdFL2hyOW1INEdDWVY3MHo3SlMzdlc0TkdvUlVKNU11YWM0ZGQrTHpQU3Vo?=
 =?utf-8?B?b3NDQjgya3RWZzVOUlVUU1JOQVNiRzRRQ3FMaUZIWS9ZdE5kK3hkcGluRkVy?=
 =?utf-8?B?VWpWZy9SSnFDMmNSQVdUK1o3citVVXNRTlRLSGpNK0ZOMnJEbThxTU84SU44?=
 =?utf-8?B?cGlXWVQ1K2ZPTDJCcmxHWllJRkZ6M2xFdmZwbGoxOEIzL3JnOHo1bUhGQlhK?=
 =?utf-8?B?U1NqTW16T1BOYVVNVDhPTDl4QTc4RWU0TnlrNkI1T1FvRmhuNDZzcjkwM2lF?=
 =?utf-8?B?MW5FQ0x1anJtMVFJS3dDVzFUMmNITmZJNm1KSnZFc0FkRllWR2lhRVVtRUo3?=
 =?utf-8?B?dkhHL1RKa3VCcmN5MFBOYkN1VXpMWVIvUVNyS3JHMkUxOVYrMVd6elpXb2hG?=
 =?utf-8?B?SHJPZ0JDS0Q2RUNKVmNYOCtwMDlPdEF4K24wRW5ZL1FyTnpNMWVyQVhmU29X?=
 =?utf-8?B?ZC9ESkhMZ3cwM0tSZU1lOFRFVE9wVmtuL2FtUFR2b0l4VjVoODNkSTZkcTlp?=
 =?utf-8?B?c1RjN1pUYjNLRmxkazdYbWUxN1pKMG9tSk5sc2ZLN29vcHorY2ROeEJHbUJn?=
 =?utf-8?B?ZVZaWWc5YXk4OC9kRDJZcy9TVUJmWWx5OVhlSS9nVmVqZDd3eGd5YkpiaExa?=
 =?utf-8?B?UHl1Wm85d01CeElXT0lhY0hjM3huczQ1eEFOdG91eDZBM2tGODNtWVY2d3ds?=
 =?utf-8?B?NE50WGhzVndBcDMxb2JicXlYcDZPcmpMWjdIT1lpRlpoT0t1cnZuekU5bWNC?=
 =?utf-8?B?c3FGM1RoRDYySUlENmt1L2sxOEUwSWxzQmZiQzBRbC9rM1E0cHBIQXNLWEpa?=
 =?utf-8?B?aWVXRFYyUEVjbndrT0dtaCs0T040eWUxV3VSSGhoQ3B5cjBRQjdHRzBtb3Bz?=
 =?utf-8?B?aHN3V0Vaa2RKck43bWdVTGJoUTdCa0xjelNhWTVUWTNBNG9rRlZYUjJXTjI4?=
 =?utf-8?B?Q1Erc0tkdm4rWS9vOWtDUTIyRHErMUpzQjNsMmpFc3Z2WHhEK3NkRTNCbUZ5?=
 =?utf-8?B?QThxQWw4dktBUGJITW1JT3hEU0xXNFFiTktqNzk1N2M0T0l3WWVsbG4raUJo?=
 =?utf-8?B?RXlkWWJSNFBXSVRQMjVxOEMxVHBaODhnNWdMMUhjdng2QzNpUW9aSHhkaWlZ?=
 =?utf-8?B?ZWFpYTFuL1puUDExTWFzUERXZERXZmtDRGxPNEdEOERmOENHZGxUOTFtM3JI?=
 =?utf-8?B?b004ZTJ4cE8zaEQ3a2JFMGo2UXFYOUFRVEtTeURJRzFYdkNMa2ZrZ0xrcGFy?=
 =?utf-8?B?QmszMnJOL0FTVVVzN1FMa0lTdDRnVjRYaGhKemRjbE11TG9uUTBDeG5GcXJx?=
 =?utf-8?B?dGZYR01WdXFEMmVZQnhsdTQ3ZFprb1czblJiZ0xXT2lBVmNYa3BCcHk4TXZB?=
 =?utf-8?B?UVVkQjBQdmFKRk5MVkd2bVJtdWdYVzA0RzY3V2U5aytTSW5yT2p3OXc4UHlU?=
 =?utf-8?Q?KpcpUQ=3D?=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0301MB1940;6:M5swqmz1ol0YgiIJ88fLKruBGSsd1bI3YcH13fph+RHY8TCbjJ6rUojsSRxM0x7Z2FdW/tLKCtuuqlJT+vlGGoZLfPFyzJ4L8fKyh4D1kGj3ouV0almrd+qgItywhszoeG3rilalKWTTMOczXvFr4192QWFnPU5hnpD4bWIwXppp/VV/3Acegl/zZM2V/111Q52/G3MGPkzFAUOJ5xM48OFzzujNIrYx3WJa9ZAx4FkXMOfiIDtR/y3SKRQi4EKcQzFPZBj5tHQzMEYY09BH7pcOHJyG268WmBqOb4O94Ch1F01b0rcMxTJuQlOfVGLcai0DAzc+rs7gixXehYNqJV9B7EuOvzPRMie0tZC/0LI=;5:2K/E5puLyIenv0t2Ja+UxD9FgPSbP9qYilBMHai7QGRZDrw0ADJZ5fvJ/XEucpnTIDewjwxxjIcqFrHir5N4vv//eXI9xOLUgiwFtaFPOBagH4u2OYnD2qgfMumMEzBZM7HDA1ZGaJeHsSev6/3PWfnWxiBEUgL0xquVJxP/Gck=;24:ydDG+48Q6SGiaYhwwJ5a2ofJ/MpSgN6js8svVfrFQnjNCZoUTmmdq1uSBqbbwSUPxj28aPlMjo+ocmnPhb0a4JlKre3bqxG1vpOCUi4KDOg=;7:L0xZDAd4momGoeQBJl9ze595reDrd60JQ1467vhYJsKAsNjyfBpQlclBttxvqOXifD8uiN059+n3pcN18hGNmcS9K4agd6zwqnywHxQ/9gNYv8Ic04g5JTK/G7tkfVXU9c3SneBvFvo+BhbZm4KIYeEDy5ykwpXJ6mse4piqTzW4EmRdulfNl9Pih60CZS9lAfwK2b40MTaH8Jpbl1XqPM7ATw06iLQhKZQaFoPX/Z9u8b4mC+0EUuMjkWywYcVH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2018 15:35:44.4791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1be7ed-976e-4190-1b20-08d57ad31b21
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0301MB1940
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/2018 05:26 PM, Boris Ostrovsky wrote:
> On 02/21/2018 03:03 AM, Oleksandr Andrushchenko wrote:
>> +static struct xen_gem_object *gem_create(struct drm_device *dev, size_t size)
>> +{
>> +	struct xen_drm_front_drm_info *drm_info = dev->dev_private;
>> +	struct xen_gem_object *xen_obj;
>> +	int ret;
>> +
>> +	size = round_up(size, PAGE_SIZE);
>> +	xen_obj = gem_create_obj(dev, size);
>> +	if (IS_ERR_OR_NULL(xen_obj))
>> +		return xen_obj;
>> +
>> +	if (drm_info->cfg->be_alloc) {
>> +		/*
>> +		 * backend will allocate space for this buffer, so
>> +		 * only allocate array of pointers to pages
>> +		 */
>> +		xen_obj->be_alloc = true;
> If be_alloc is a flag (which I am not sure about) --- should it be set
> to true *after* you've successfully allocated your things?
this is a configuration option telling about the way
the buffer gets allocated: either by the frontend or
backend (be_alloc -> buffer allocated by the backend)
>
>> +		ret = gem_alloc_pages_array(xen_obj, size);
>> +		if (ret < 0) {
>> +			gem_free_pages_array(xen_obj);
>> +			goto fail;
>> +		}
>> +
>> +		ret = alloc_xenballooned_pages(xen_obj->num_pages,
>> +				xen_obj->pages);
> Why are you allocating balloon pages?
in this use-case we map pages provided by the backend
(yes, I know this can be a problem from both security
POV and that DomU can die holding pages of Dom0 forever:
but still it is a configuration option, so user decides
if her use-case needs this and takes responsibility for
such a decision).

Please see description of the buffering modes in xen_drm_front.h
specifically for backend allocated buffers:
  *******************************************************************************
  * 2. Buffers allocated by the backend
  *******************************************************************************
  *
  * This mode of operation is run-time configured via guest domain 
configuration
  * through XenStore entries.
  *
  * For systems which do not provide IOMMU support, but having specific
  * requirements for display buffers it is possible to allocate such buffers
  * at backend side and share those with the frontend.
  * For example, if host domain is 1:1 mapped and has DRM/GPU hardware 
expecting
  * physically contiguous memory, this allows implementing zero-copying
  * use-cases.

>
> -boris
>
>> +		if (ret < 0) {
>> +			DRM_ERROR("Cannot allocate %zu ballooned pages: %d\n",
>> +					xen_obj->num_pages, ret);
>> +			goto fail;
>> +		}
>> +
>> +		return xen_obj;
>> +	}
>> +	/*
>> +	 * need to allocate backing pages now, so we can share those
>> +	 * with the backend
>> +	 */
>> +	xen_obj->num_pages = DIV_ROUND_UP(size, PAGE_SIZE);
>> +	xen_obj->pages = drm_gem_get_pages(&xen_obj->base);
>> +	if (IS_ERR_OR_NULL(xen_obj->pages)) {
>> +		ret = PTR_ERR(xen_obj->pages);
>> +		xen_obj->pages = NULL;
>> +		goto fail;
>> +	}
>> +
>> +	return xen_obj;
>> +
>> +fail:
>> +	DRM_ERROR("Failed to allocate buffer with size %zu\n", size);
>> +	return ERR_PTR(ret);
>> +}
>> +
>>
