Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933580AbeCEJa5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 04:30:57 -0500
Received: from mail-he1eur01on0068.outbound.protection.outlook.com ([104.47.0.68]:64188
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933494AbeCEJap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 04:30:45 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com;
Subject: Re: [PATCH 9/9] drm/xen-front: Implement communication with backend
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <1519200222-20623-1-git-send-email-andr2000@gmail.com>
 <1519200222-20623-10-git-send-email-andr2000@gmail.com>
 <20180305092515.GJ22212@phenom.ffwll.local>
From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <7a6d19be-a740-dae4-551b-17740171aedf@epam.com>
Date: Mon, 5 Mar 2018 11:30:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305092515.GJ22212@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [85.223.209.56]
X-ClientProxiedBy: AM5PR0602CA0014.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::24) To HE1PR0301MB1946.eurprd03.prod.outlook.com
 (2603:10a6:3:e::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbc00010-3b3f-4410-e7d9-08d5827bc35c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:HE1PR0301MB1946;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0301MB1946;3:zy50j0jJv4tDOacQEjfPMK2Sws4XlJFARm0WHs4Yt8r5Cl6XD7gnm5uhzezjIDiQlbti4Xw6M6Mo5xHMNvQDFWTnowO5TEx9CyXod43eu3yISBENTIQBCB2QdNuSwN+Sd4t/KAxRyPUWgp85OpggdXgqo/a0JZEjWEuK/ny0gkliIproIofeWsVc5o39/OVd+/0QAmSXGYfr7IQxhxh/q3L5aLWz1hql+Dz44Lo9BHcwNXhaSxWlw7Jk/1zQWY60;25:Ocd1tmujfvnhFoC5+41jB5uouQNlfwCS76ZdMU7nuKa4pXnoo0AmVJUww0oXj2vFrApTkz3rDVNLQhWLNFcqzJN4wL8HDwgEhesLMCZFU2q/7Czxuf+h634MZR8IdVfy/0qt5inOa+YGyyBQ86cHvTSKbzohpeQh6DOIHAkSk1nHXlwa10ASgwiqm6ZOk61ZT+/vnnS4u3P2Nt1da8kfTwSrUcf2ErmHJBN5imxXiXoY13VthclqE+23/gcjpD/5BJzSSRrJbp0/sPDka+Z48YMiuCaXkf7y5mfiDA86BI/c/qwlQi8/K7XGkXHLMyQ3B48dsdNP2k2bXHlmwnTV+Q==;31:vsXfFq04Zy5dEpv0oFHPHKgatsrFLs3FuGnKBqzu2Q+Um+K7y5NlehMgmgToMPtPWDfdNJIyAeLWRj83ubqBZ/LGm/3xuYRsFgFGiLqq4GeB1LGF0T3b3Vcr0pqJkvYnqyaHqC17M4UUDDa+KMv7qRkyQUgCqzrZ7Ws9nfUt/lir8L5/ufpW6GGcozoy8OwzpoYohCuKb4kNz8hylIc6WoyTf0o7grSSCEt9GcvtSDs=
X-MS-TrafficTypeDiagnostic: HE1PR0301MB1946:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0301MB1946;20:CVfJ/NlicX4C5xTIS2NdnqtnUxEGVFop9i0/rBuOl4Ktcdp0SdDoXr5AZcdbYkcGqY98mKwf0uAR9EPCc4BWdWg9aywn1SIwUH1r5hY1i1KK6Bfc06wyf27cw833kEGkcoYV+TX7bluMqUoj39uya7mli/qq01LvNYJG8ak4M79/hReq8saQVkepH8SlbX9TPJQtgNHy0uGNaA01IuncNzpoEBgNA4os7layhmFi39Otx9Tn2tWBSkXqbVwJDhgUzEcNfV1n+HgM4dnLcHiQw0a+azUf+HDMYmRS/4gkxHkEphMzVPCjQiuwanQO6rYXifeB6Vl7NSYG54LGkNxPaIhGrtH3zHd1d9GpWUKZExBY5X9W/AVMgchCToacxmPbJpAiy6XQXu0dH+6oTpC+Eby51oBN8RuCaKeQsuKhVxMr58G3/tA13YVW9liIzMqVcHntA7xwDs8lGDvs0A9xxHtnck/CHiNaAaUWqYFJ+iQ+5ZV+/EsOndAsT7Nf+2Io;4:oildc25tscVDuYRtneT2mQAwZ0/07/UN8Py6ayBvC1EEoCG0ZPZtzwkA23BbQuDb1zHWgXLQj5ETy7hbQxOWSVz8fi/+PrIWasKsCLuN7RJCYR0f+xfSQ0odZWYh3+LbibBtG0Y0JIWNzPL5TquXx4YJV4eTCnVXQ8ii+9ERz/8wwKdfW8kY+FUkaBD1VxAmJeiYy34APg3EBHVNZC6AE4cp9zUILxJoT0m39V5hicdUEshnEbinR1o2a6zDAT5YS/CJgwuNhiNJgdS+lXjwlrkNY4G5m2ZoPqb48Jxs0H7wKs3NFmJCYfXSvUtjQwhtYtijiFSifgsJ2Ybvi+24bA==
X-Microsoft-Antispam-PRVS: <HE1PR0301MB1946CBD1FA92827EF4BD52CBE7DA0@HE1PR0301MB1946.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(217544274631240)(4114951738403);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(52105095)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:HE1PR0301MB1946;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0301MB1946;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(366004)(376002)(39860400002)(39380400002)(396003)(199004)(189003)(36756003)(81156014)(81166006)(8936002)(8676002)(16526019)(186003)(53936002)(52146003)(23676004)(6246003)(2486003)(6306002)(52116002)(76176011)(305945005)(5890100001)(106356001)(105586002)(68736007)(229853002)(65826007)(2906002)(966005)(72206003)(31696002)(2950100002)(59450400001)(7736002)(478600001)(6666003)(7416002)(77096007)(386003)(6486002)(65806001)(66066001)(316002)(47776003)(53546011)(65956001)(80792005)(26005)(58126008)(16576012)(67846002)(97736004)(64126003)(25786009)(230700001)(39060400002)(5660300001)(6116002)(3846002)(55236004)(31686004)(86362001)(50466002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0301MB1946;H:[10.17.182.9];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAzMDFNQjE5NDY7MjM6U3NKbVRtaytvM3pTRE9RczZ4OXA0Mi9X?=
 =?utf-8?B?Y21lY3N5QzM4eDZnem1IOHdDK3g5NTZzZ0hRT0lPdFNZMlJEcmR3NWdZN002?=
 =?utf-8?B?RVc5alRPTkcyYTIvMStRYUMvYzBtNHAyNEdyWG1sV2FYOUdOenR4eTBqUVBi?=
 =?utf-8?B?TnI1RGg3UGhyeFZueWhFeGtjYit3NnppNE1rM3V3MnRHQWp1R0p0VUV2a0lM?=
 =?utf-8?B?YjM3SkxDYlNxYnF2V3FWQ0ppV3IzK1MrK2pnYzdJcFBHV1VaM2VEVzdXTndp?=
 =?utf-8?B?cnBjSnBUNzh5SU5aVGpKMklNY011U2NWVmdlUy84U3ZBZkFWNzNiWFE1a1Vo?=
 =?utf-8?B?TklwaGdheHkzUmlQcFNIMWhzUnp6azlTb1ZQUHB5SlU5V205bFdNQ2VkYS9k?=
 =?utf-8?B?czhkUHd6TldMM3NEaDJ2YjVsa3A0WlcyTGRoR2NBd2pjVERnSldJLzUvc0Ji?=
 =?utf-8?B?ekl1ZEF3czZBck12ajBQRFBWK24yV1dBM21kdDhPNWtzSlJyUFgwbHBVSnNC?=
 =?utf-8?B?NU5NSlBUcXlpbXZzMVRrL3ZacW85ejR1azRyVmRUSCsyQWk4QTR3V2x3UFN2?=
 =?utf-8?B?OGNldHJVWGt3Zm85YVpncG5OYUlGUW81dWNHN1UyaExkSnlMcGhQNGRqYVNs?=
 =?utf-8?B?NzdRYW92UUxkbjRPYSs0MnpjUkxJV0JWOUVobU82OFJXN2FmWWhYbHBrLytP?=
 =?utf-8?B?T2lEODhMNWFvcUVDOUhSZmVPOWFQZkowQ1g2emE2VE0yZGY3VDZoS1pVaVVa?=
 =?utf-8?B?R1RwK1hMeFgzNkRzTkFaZG0zTEJHZEVrSU5GRnVTQ0VaUjZqUXNGOEZkTUtv?=
 =?utf-8?B?YXFtVXRwVk5jWnB4R3ExWGNBS1lvaGVhU2owak85UG9GYmtieGFLWlduWUp2?=
 =?utf-8?B?NU9WQ0RTYk1OOU5lTWFZYWNRZmo2K0ZhSlNHSjQrN3pRM09YUCsxTWZ6dWdE?=
 =?utf-8?B?ODNNTldaZnZ5bGRheEpCWWd6TGw0eS92TlBlSHc1S25tUFZnSlFCL2xqZEVB?=
 =?utf-8?B?SG1IYkpycERYdGVlUnhPZDVkZlc4Ylg0MTFxdUtqNk9Lb1NUTW03UW45Z1Qw?=
 =?utf-8?B?KzFUMzdPM1pWK0QwVWhkZm1ZN205a3dudzh2RzFRQWtVZjhYdytiK25ncXNp?=
 =?utf-8?B?NVBlTUttcTZzdHhCc3RKTzkvSW9YQmhvclk5Ykp3UDVST1Y2TURKVysralhl?=
 =?utf-8?B?OFdKMEZzdVRhQmhWazllTnJwOHVUemh0VnQ4a0xCeloyNzJmMm1sYm0yb1FX?=
 =?utf-8?B?MGpDQ1NvQU1WU2x0MzIwcTErY2NHeG4vWWZDa1BMYWdNOTFTdTVsTlY2OHY0?=
 =?utf-8?B?ZTd1MHFkRDBURklJWU1UL2N2TkdSdWxxK3BsUXYwSmFrUUdySUZhUWJvNVJJ?=
 =?utf-8?B?aFhLK3JSSmR2T2UzQkJiRkIyZXY4S3pDUzNqSW5jTG1Ca040T04wSWI3MWJV?=
 =?utf-8?B?TnlHTitiLzlGdUdWSG9SdFNCQ0pRaUUyRzNBRFllRWg4ZzNoT2FtUm00alB5?=
 =?utf-8?B?UTEzYkJMQ2cycnBpOFJZWGpIbVBKMmcvV3dLUkI1S29wS3BxdEo4cVlBUmJx?=
 =?utf-8?B?YXNEbE8rTkhiN3hpS2xNQU9wV3kwTUJYTXM3a3Fjb2VKenIzWkFVZTBPWElh?=
 =?utf-8?B?TzhKZUNrSFhzTFh2YzBjSXlNUjZlbWVKeWtWNENTbzhtcmZmc2ZpR3ZQcHpT?=
 =?utf-8?B?a0xPQkJSNHFYWVNzMnlPT2RubWhGM0kxS1VHUGZYdkhxMjM5ekdmY25pTmhB?=
 =?utf-8?B?WjdQNEFCckFyM3AydVdQRWg3MUhZc25IdUprS21aOEJzWnpLTWw1SnJydGE2?=
 =?utf-8?B?dUt5NkxGVWh5WFAzTkp4UG9FVDBXbEVNL1plc3N1S2pEZTFMYjFja1h5NmIr?=
 =?utf-8?B?V2hwcm5RTkRIdTVGMzhZZVJjQ1dTbnp0R3VSelloSjNVWmt2K1VrN2Erc1Av?=
 =?utf-8?B?TktOc1Jpam4vRndIWms0YlZrTnEzMm1ySUN6dDBDV0RDRStoRnNRTUFPSnkz?=
 =?utf-8?B?cDl1c2EvYkF5ODhPVFpQeTBSbGl6NzJUQ2FiTkp1eTZieE1ZTTJGUEpNSFpi?=
 =?utf-8?B?Y0xSWmRFbDFncUdpb1FEdllxWlEwRmdKR0pKLzZxdFdqK016UExpcEI0eVRQ?=
 =?utf-8?B?SEY2dz09?=
X-Microsoft-Antispam-Message-Info: S4TqCH+4uwGTr+QPpcKuTzWtKfOCxmPDqaZl+Z08NNF0vGPN24p2xf7KRqq7fQ21K5xj4Ol1cE2sFZPkJzfW/BwUvReoTAFEI38IiyYvZ1W9qLNe44w/MXS+wsGJV0xD7IiZNsXjz9rIq1ReSbpIbtkcCWNOE9CdMhWRimKL/uuWaGWw+Dkf1w1KyBaeUGkx
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0301MB1946;6:9W4XncNKf72kDiURhK6q1Y9yvOb3uHE7ybaUxfpX8+yMNojgapyiMCXWbR/NLSrMGnEI4Mq5+q8kP4EyAraKaM7U3SU8OYv4KL+AN4fXWPCLgDJA2wNmtcIVi2gX7pp8FgPiYEatt3PRFjzt/8EgUH85frtYuXCyeWW8wBkWlUHoTGF9/TMRizp8bIZBucQmCTy+yR9K1oQIQhQdpku6OuC6F8dJ4O5QCWwtSs4PYOFsO1YlVXdVZv51o2r2paZTjVE0Bj2f2wO6yk6GG9By6BeQhwXWN4Es1rKdvi4poT4GeZbZc6RjadSWdE1t6xsMLlrjwzjRyThLYYvNwHDMDOANBiN3A3x0Q42dXxk7GsI=;5:wpoxdYBsLv38gMmgOfagJtDUFMTRhrjrCv+G5DAv0gBBK1o0P3mymsYuM4huO5m+wBSaggQazUflILUowxDykeZOEOKuvNMafYvpWZKG5NVZyXBvna9fXevBuw6B73m2PbTyePo+Jy5jDa0NxADe5NmAS03ukJ34KB4r8hmW4SA=;24:CRYClXOavjAYcwUeWjGtG7/chQbrCp7VI+6Ik+av9Fo8OiDLraPe+B07yV/IYxvNYYxjaC4uf7HtcfrKZGYDl0Ong1EPi9VeRDK4/dWw5ns=;7:OTxQW0c7DA1j0NI9Do9Zx9Etxmbc+yoQldNLChnGbGAMdxJExl3eHlZirm3rFFnLjovBXuG27s5d/mrN3kV9KaXJZQvU85mnboQ6RD+ZZezxRrRLHgJG9KIoT4T4yKFURty73K4FkL3OCheZiZg1JL9PrDsp3AuXP8/aynS4Plf8kqIopCLi7HGx2f///PEuxVlYn1H27y55xL87XmhIBaXvyFxClhOw05PopMl6ew0TtEK3EJ91mJxScmMpp8Ac
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 09:30:40.3963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc00010-3b3f-4410-e7d9-08d5827bc35c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB1946
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2018 11:25 AM, Daniel Vetter wrote:
> On Wed, Feb 21, 2018 at 10:03:42AM +0200, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> Handle communication with the backend:
>>   - send requests and wait for the responses according
>>     to the displif protocol
>>   - serialize access to the communication channel
>>   - time-out used for backend communication is set to 3000 ms
>>   - manage display buffers shared with the backend
>>
>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> After the demidlayering it probably makes sense to merge this with the
> overall kms/basic-drm-driver patch. Up to you really.
The reason for such partitioning here and before was that
I can have Xen/DRM parts separate, so those are easier for
review by Xen/DRM communities. So, I would prefer to have it
as it is
> -Daniel
>> ---
>>   drivers/gpu/drm/xen/xen_drm_front.c | 327 +++++++++++++++++++++++++++++++++++-
>>   drivers/gpu/drm/xen/xen_drm_front.h |   5 +
>>   2 files changed, 327 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
>> index 8de88e359d5e..5ad546231d30 100644
>> --- a/drivers/gpu/drm/xen/xen_drm_front.c
>> +++ b/drivers/gpu/drm/xen/xen_drm_front.c
>> @@ -31,12 +31,146 @@
>>   #include "xen_drm_front_evtchnl.h"
>>   #include "xen_drm_front_shbuf.h"
>>   
>> +/* timeout in ms to wait for backend to respond */
>> +#define VDRM_WAIT_BACK_MS	3000
>> +
>> +struct xen_drm_front_dbuf {
>> +	struct list_head list;
>> +	uint64_t dbuf_cookie;
>> +	uint64_t fb_cookie;
>> +	struct xen_drm_front_shbuf *shbuf;
>> +};
>> +
>> +static int dbuf_add_to_list(struct xen_drm_front_info *front_info,
>> +		struct xen_drm_front_shbuf *shbuf, uint64_t dbuf_cookie)
>> +{
>> +	struct xen_drm_front_dbuf *dbuf;
>> +
>> +	dbuf = kzalloc(sizeof(*dbuf), GFP_KERNEL);
>> +	if (!dbuf)
>> +		return -ENOMEM;
>> +
>> +	dbuf->dbuf_cookie = dbuf_cookie;
>> +	dbuf->shbuf = shbuf;
>> +	list_add(&dbuf->list, &front_info->dbuf_list);
>> +	return 0;
>> +}
>> +
>> +static struct xen_drm_front_dbuf *dbuf_get(struct list_head *dbuf_list,
>> +		uint64_t dbuf_cookie)
>> +{
>> +	struct xen_drm_front_dbuf *buf, *q;
>> +
>> +	list_for_each_entry_safe(buf, q, dbuf_list, list)
>> +		if (buf->dbuf_cookie == dbuf_cookie)
>> +			return buf;
>> +
>> +	return NULL;
>> +}
>> +
>> +static void dbuf_flush_fb(struct list_head *dbuf_list, uint64_t fb_cookie)
>> +{
>> +	struct xen_drm_front_dbuf *buf, *q;
>> +
>> +	list_for_each_entry_safe(buf, q, dbuf_list, list)
>> +		if (buf->fb_cookie == fb_cookie)
>> +			xen_drm_front_shbuf_flush(buf->shbuf);
>> +}
>> +
>> +static void dbuf_free(struct list_head *dbuf_list, uint64_t dbuf_cookie)
>> +{
>> +	struct xen_drm_front_dbuf *buf, *q;
>> +
>> +	list_for_each_entry_safe(buf, q, dbuf_list, list)
>> +		if (buf->dbuf_cookie == dbuf_cookie) {
>> +			list_del(&buf->list);
>> +			xen_drm_front_shbuf_unmap(buf->shbuf);
>> +			xen_drm_front_shbuf_free(buf->shbuf);
>> +			kfree(buf);
>> +			break;
>> +		}
>> +}
>> +
>> +static void dbuf_free_all(struct list_head *dbuf_list)
>> +{
>> +	struct xen_drm_front_dbuf *buf, *q;
>> +
>> +	list_for_each_entry_safe(buf, q, dbuf_list, list) {
>> +		list_del(&buf->list);
>> +		xen_drm_front_shbuf_unmap(buf->shbuf);
>> +		xen_drm_front_shbuf_free(buf->shbuf);
>> +		kfree(buf);
>> +	}
>> +}
>> +
>> +static struct xendispl_req *be_prepare_req(
>> +		struct xen_drm_front_evtchnl *evtchnl, uint8_t operation)
>> +{
>> +	struct xendispl_req *req;
>> +
>> +	req = RING_GET_REQUEST(&evtchnl->u.req.ring,
>> +			evtchnl->u.req.ring.req_prod_pvt);
>> +	req->operation = operation;
>> +	req->id = evtchnl->evt_next_id++;
>> +	evtchnl->evt_id = req->id;
>> +	return req;
>> +}
>> +
>> +static int be_stream_do_io(struct xen_drm_front_evtchnl *evtchnl,
>> +		struct xendispl_req *req)
>> +{
>> +	reinit_completion(&evtchnl->u.req.completion);
>> +	if (unlikely(evtchnl->state != EVTCHNL_STATE_CONNECTED))
>> +		return -EIO;
>> +
>> +	xen_drm_front_evtchnl_flush(evtchnl);
>> +	return 0;
>> +}
>> +
>> +static int be_stream_wait_io(struct xen_drm_front_evtchnl *evtchnl)
>> +{
>> +	if (wait_for_completion_timeout(&evtchnl->u.req.completion,
>> +			msecs_to_jiffies(VDRM_WAIT_BACK_MS)) <= 0)
>> +		return -ETIMEDOUT;
>> +
>> +	return evtchnl->u.req.resp_status;
>> +}
>> +
>>   static int be_mode_set(struct xen_drm_front_drm_pipeline *pipeline, uint32_t x,
>>   		uint32_t y, uint32_t width, uint32_t height, uint32_t bpp,
>>   		uint64_t fb_cookie)
>>   
>>   {
>> -	return 0;
>> +	struct xen_drm_front_evtchnl *evtchnl;
>> +	struct xen_drm_front_info *front_info;
>> +	struct xendispl_req *req;
>> +	unsigned long flags;
>> +	int ret;
>> +
>> +	front_info = pipeline->drm_info->front_info;
>> +	evtchnl = &front_info->evt_pairs[pipeline->index].req;
>> +	if (unlikely(!evtchnl))
>> +		return -EIO;
>> +
>> +	mutex_lock(&front_info->req_io_lock);
>> +
>> +	spin_lock_irqsave(&front_info->io_lock, flags);
>> +	req = be_prepare_req(evtchnl, XENDISPL_OP_SET_CONFIG);
>> +	req->op.set_config.x = x;
>> +	req->op.set_config.y = y;
>> +	req->op.set_config.width = width;
>> +	req->op.set_config.height = height;
>> +	req->op.set_config.bpp = bpp;
>> +	req->op.set_config.fb_cookie = fb_cookie;
>> +
>> +	ret = be_stream_do_io(evtchnl, req);
>> +	spin_unlock_irqrestore(&front_info->io_lock, flags);
>> +
>> +	if (ret == 0)
>> +		ret = be_stream_wait_io(evtchnl);
>> +
>> +	mutex_unlock(&front_info->req_io_lock);
>> +	return ret;
>>   }
>>   
>>   static int be_dbuf_create_int(struct xen_drm_front_info *front_info,
>> @@ -44,7 +178,69 @@ static int be_dbuf_create_int(struct xen_drm_front_info *front_info,
>>   		uint32_t bpp, uint64_t size, struct page **pages,
>>   		struct sg_table *sgt)
>>   {
>> +	struct xen_drm_front_evtchnl *evtchnl;
>> +	struct xen_drm_front_shbuf *shbuf;
>> +	struct xendispl_req *req;
>> +	struct xen_drm_front_shbuf_cfg buf_cfg;
>> +	unsigned long flags;
>> +	int ret;
>> +
>> +	evtchnl = &front_info->evt_pairs[GENERIC_OP_EVT_CHNL].req;
>> +	if (unlikely(!evtchnl))
>> +		return -EIO;
>> +
>> +	memset(&buf_cfg, 0, sizeof(buf_cfg));
>> +	buf_cfg.xb_dev = front_info->xb_dev;
>> +	buf_cfg.pages = pages;
>> +	buf_cfg.size = size;
>> +	buf_cfg.sgt = sgt;
>> +	buf_cfg.be_alloc = front_info->cfg.be_alloc;
>> +
>> +	shbuf = xen_drm_front_shbuf_alloc(&buf_cfg);
>> +	if (!shbuf)
>> +		return -ENOMEM;
>> +
>> +	ret = dbuf_add_to_list(front_info, shbuf, dbuf_cookie);
>> +	if (ret < 0) {
>> +		xen_drm_front_shbuf_free(shbuf);
>> +		return ret;
>> +	}
>> +
>> +	mutex_lock(&front_info->req_io_lock);
>> +
>> +	spin_lock_irqsave(&front_info->io_lock, flags);
>> +	req = be_prepare_req(evtchnl, XENDISPL_OP_DBUF_CREATE);
>> +	req->op.dbuf_create.gref_directory =
>> +			xen_drm_front_shbuf_get_dir_start(shbuf);
>> +	req->op.dbuf_create.buffer_sz = size;
>> +	req->op.dbuf_create.dbuf_cookie = dbuf_cookie;
>> +	req->op.dbuf_create.width = width;
>> +	req->op.dbuf_create.height = height;
>> +	req->op.dbuf_create.bpp = bpp;
>> +	if (buf_cfg.be_alloc)
>> +		req->op.dbuf_create.flags |= XENDISPL_DBUF_FLG_REQ_ALLOC;
>> +
>> +	ret = be_stream_do_io(evtchnl, req);
>> +	spin_unlock_irqrestore(&front_info->io_lock, flags);
>> +
>> +	if (ret < 0)
>> +		goto fail;
>> +
>> +	ret = be_stream_wait_io(evtchnl);
>> +	if (ret < 0)
>> +		goto fail;
>> +
>> +	ret = xen_drm_front_shbuf_map(shbuf);
>> +	if (ret < 0)
>> +		goto fail;
>> +
>> +	mutex_unlock(&front_info->req_io_lock);
>>   	return 0;
>> +
>> +fail:
>> +	mutex_unlock(&front_info->req_io_lock);
>> +	dbuf_free(&front_info->dbuf_list, dbuf_cookie);
>> +	return ret;
>>   }
>>   
>>   static int be_dbuf_create_from_sgt(struct xen_drm_front_info *front_info,
>> @@ -66,26 +262,144 @@ static int be_dbuf_create_from_pages(struct xen_drm_front_info *front_info,
>>   static int be_dbuf_destroy(struct xen_drm_front_info *front_info,
>>   		uint64_t dbuf_cookie)
>>   {
>> -	return 0;
>> +	struct xen_drm_front_evtchnl *evtchnl;
>> +	struct xendispl_req *req;
>> +	unsigned long flags;
>> +	bool be_alloc;
>> +	int ret;
>> +
>> +	evtchnl = &front_info->evt_pairs[GENERIC_OP_EVT_CHNL].req;
>> +	if (unlikely(!evtchnl))
>> +		return -EIO;
>> +
>> +	be_alloc = front_info->cfg.be_alloc;
>> +
>> +	/*
>> +	 * for the backend allocated buffer release references now, so backend
>> +	 * can free the buffer
>> +	 */
>> +	if (be_alloc)
>> +		dbuf_free(&front_info->dbuf_list, dbuf_cookie);
>> +
>> +	mutex_lock(&front_info->req_io_lock);
>> +
>> +	spin_lock_irqsave(&front_info->io_lock, flags);
>> +	req = be_prepare_req(evtchnl, XENDISPL_OP_DBUF_DESTROY);
>> +	req->op.dbuf_destroy.dbuf_cookie = dbuf_cookie;
>> +
>> +	ret = be_stream_do_io(evtchnl, req);
>> +	spin_unlock_irqrestore(&front_info->io_lock, flags);
>> +
>> +	if (ret == 0)
>> +		ret = be_stream_wait_io(evtchnl);
>> +
>> +	/*
>> +	 * do this regardless of communication status with the backend:
>> +	 * if we cannot remove remote resources remove what we can locally
>> +	 */
>> +	if (!be_alloc)
>> +		dbuf_free(&front_info->dbuf_list, dbuf_cookie);
>> +
>> +	mutex_unlock(&front_info->req_io_lock);
>> +	return ret;
>>   }
>>   
>>   static int be_fb_attach(struct xen_drm_front_info *front_info,
>>   		uint64_t dbuf_cookie, uint64_t fb_cookie, uint32_t width,
>>   		uint32_t height, uint32_t pixel_format)
>>   {
>> -	return 0;
>> +	struct xen_drm_front_evtchnl *evtchnl;
>> +	struct xen_drm_front_dbuf *buf;
>> +	struct xendispl_req *req;
>> +	unsigned long flags;
>> +	int ret;
>> +
>> +	evtchnl = &front_info->evt_pairs[GENERIC_OP_EVT_CHNL].req;
>> +	if (unlikely(!evtchnl))
>> +		return -EIO;
>> +
>> +	buf = dbuf_get(&front_info->dbuf_list, dbuf_cookie);
>> +	if (!buf)
>> +		return -EINVAL;
>> +
>> +	buf->fb_cookie = fb_cookie;
>> +
>> +	mutex_lock(&front_info->req_io_lock);
>> +
>> +	spin_lock_irqsave(&front_info->io_lock, flags);
>> +	req = be_prepare_req(evtchnl, XENDISPL_OP_FB_ATTACH);
>> +	req->op.fb_attach.dbuf_cookie = dbuf_cookie;
>> +	req->op.fb_attach.fb_cookie = fb_cookie;
>> +	req->op.fb_attach.width = width;
>> +	req->op.fb_attach.height = height;
>> +	req->op.fb_attach.pixel_format = pixel_format;
>> +
>> +	ret = be_stream_do_io(evtchnl, req);
>> +	spin_unlock_irqrestore(&front_info->io_lock, flags);
>> +
>> +	if (ret == 0)
>> +		ret = be_stream_wait_io(evtchnl);
>> +
>> +	mutex_unlock(&front_info->req_io_lock);
>> +	return ret;
>>   }
>>   
>>   static int be_fb_detach(struct xen_drm_front_info *front_info,
>>   		uint64_t fb_cookie)
>>   {
>> -	return 0;
>> +	struct xen_drm_front_evtchnl *evtchnl;
>> +	struct xendispl_req *req;
>> +	unsigned long flags;
>> +	int ret;
>> +
>> +	evtchnl = &front_info->evt_pairs[GENERIC_OP_EVT_CHNL].req;
>> +	if (unlikely(!evtchnl))
>> +		return -EIO;
>> +
>> +	mutex_lock(&front_info->req_io_lock);
>> +
>> +	spin_lock_irqsave(&front_info->io_lock, flags);
>> +	req = be_prepare_req(evtchnl, XENDISPL_OP_FB_DETACH);
>> +	req->op.fb_detach.fb_cookie = fb_cookie;
>> +
>> +	ret = be_stream_do_io(evtchnl, req);
>> +	spin_unlock_irqrestore(&front_info->io_lock, flags);
>> +
>> +	if (ret == 0)
>> +		ret = be_stream_wait_io(evtchnl);
>> +
>> +	mutex_unlock(&front_info->req_io_lock);
>> +	return ret;
>>   }
>>   
>>   static int be_page_flip(struct xen_drm_front_info *front_info, int conn_idx,
>>   		uint64_t fb_cookie)
>>   {
>> -	return 0;
>> +	struct xen_drm_front_evtchnl *evtchnl;
>> +	struct xendispl_req *req;
>> +	unsigned long flags;
>> +	int ret;
>> +
>> +	if (unlikely(conn_idx >= front_info->num_evt_pairs))
>> +		return -EINVAL;
>> +
>> +	dbuf_flush_fb(&front_info->dbuf_list, fb_cookie);
>> +	evtchnl = &front_info->evt_pairs[conn_idx].req;
>> +
>> +	mutex_lock(&front_info->req_io_lock);
>> +
>> +	spin_lock_irqsave(&front_info->io_lock, flags);
>> +	req = be_prepare_req(evtchnl, XENDISPL_OP_PG_FLIP);
>> +	req->op.pg_flip.fb_cookie = fb_cookie;
>> +
>> +	ret = be_stream_do_io(evtchnl, req);
>> +	spin_unlock_irqrestore(&front_info->io_lock, flags);
>> +
>> +	if (ret == 0)
>> +		ret = be_stream_wait_io(evtchnl);
>> +
>> +	mutex_unlock(&front_info->req_io_lock);
>> +	return ret;
>>   }
>>   
>>   static void xen_drm_drv_unload(struct xen_drm_front_info *front_info)
>> @@ -183,6 +497,7 @@ static void xen_drv_remove_internal(struct xen_drm_front_info *front_info)
>>   {
>>   	xen_drm_drv_deinit(front_info);
>>   	xen_drm_front_evtchnl_free_all(front_info);
>> +	dbuf_free_all(&front_info->dbuf_list);
>>   }
>>   
>>   static int backend_on_initwait(struct xen_drm_front_info *front_info)
>> @@ -310,6 +625,8 @@ static int xen_drv_probe(struct xenbus_device *xb_dev,
>>   
>>   	front_info->xb_dev = xb_dev;
>>   	spin_lock_init(&front_info->io_lock);
>> +	mutex_init(&front_info->req_io_lock);
>> +	INIT_LIST_HEAD(&front_info->dbuf_list);
>>   	front_info->drm_pdrv_registered = false;
>>   	dev_set_drvdata(&xb_dev->dev, front_info);
>>   	return xenbus_switch_state(xb_dev, XenbusStateInitialising);
>> diff --git a/drivers/gpu/drm/xen/xen_drm_front.h b/drivers/gpu/drm/xen/xen_drm_front.h
>> index c6f52c892434..db32d00145d1 100644
>> --- a/drivers/gpu/drm/xen/xen_drm_front.h
>> +++ b/drivers/gpu/drm/xen/xen_drm_front.h
>> @@ -137,6 +137,8 @@ struct xen_drm_front_info {
>>   	struct xenbus_device *xb_dev;
>>   	/* to protect data between backend IO code and interrupt handler */
>>   	spinlock_t io_lock;
>> +	/* serializer for backend IO: request/response */
>> +	struct mutex req_io_lock;
>>   	bool drm_pdrv_registered;
>>   	/* virtual DRM platform device */
>>   	struct platform_device *drm_pdev;
>> @@ -144,6 +146,9 @@ struct xen_drm_front_info {
>>   	int num_evt_pairs;
>>   	struct xen_drm_front_evtchnl_pair *evt_pairs;
>>   	struct xen_drm_front_cfg cfg;
>> +
>> +	/* display buffers */
>> +	struct list_head dbuf_list;
>>   };
>>   
>>   #endif /* __XEN_DRM_FRONT_H_ */
>> -- 
>> 2.7.4
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
