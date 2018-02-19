Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752923AbeBSO6x (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:58:53 -0500
Received: from mail-ve1eur01on0076.outbound.protection.outlook.com ([104.47.1.76]:46992
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752654AbeBSO6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:58:52 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com;
Subject: Re: [PATCH] drm/simple_kms_helper: Fix NULL pointer dereference with
 no active CRTC
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel.vetter@intel.com
References: <1518511456-28257-1-git-send-email-andr2000@gmail.com>
 <20180219143002.GC22199@phenom.ffwll.local>
From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <d676eef9-55b2-a7fd-be9b-4d53d59610a9@epam.com>
Date: Mon, 19 Feb 2018 16:58:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219143002.GC22199@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.223.209.54]
X-ClientProxiedBy: AM5PR0701CA0018.eurprd07.prod.outlook.com
 (2603:10a6:203:51::28) To VI1PR0301MB1949.eurprd03.prod.outlook.com
 (2603:10a6:800:13::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63941223-35ba-479c-3843-08d577a94847
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:VI1PR0301MB1949;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0301MB1949;3:cJRKfIQhCBD/vHX0vAKlJtfx03GZDHG3CVl6LJ1Fc7g7+Qk2UDYtmo711rlivTTOblviofge8gwgDq+gxZMeCJ13oLcd92VX1uzbRg8ZpPTOcKFHrfDZOKqI7LjwB4mWrOSgdsiyR5QscfY594plaouXrEcVOBHHDUXzHuiD9b5qcd5lv8RyR7OHrfvRSIzknbBsjIN8UkrTCFbmQJl0pnGADwwV+3Whi3bVhltKkijzgjx7lt5fUQvfyCrp4HyA;25:a+T8AnU7rB8MwFfyzq47U55o09inA9SXi1m7XUCgzJuSv1UjE2npy3Ib0YOuEcpC5hGboNvfF1xDwDRJ3D6uhTXgvhi23gbZvaio4D0vYjSDDKMcApxFiiPEwDGQHKd5Xh97s0z4tfFxgOiOGaX4ntXhdw97Gx74yhTjI1erSIQFC5amrhgZbvlSxNACDZelFaXm+hsombo9F3Kq/J2YrrQd2iq6bMSckPNkz8VdGzTXzc8l7jMMUDN0aflswiEHRteG9NXWIp4BW9wpUsBheODVL6Rcwxd4uaHAa11GRJZ368PK+KjhOlGbJTTlKV5c7ncvcZTuYVAJ/gXZr4Uoyg==;31:eNfPd1jXqryYJoHsu0V2kF9WQzhjC74ARjYmWL0AVaZo0vjudlnce43OIMzfjaTdOpufOUh3DjLMY4rCAu1oaFA4R2X6n81q3lOYsqyoxG5PoPUqrTYxloklMao2fzy0lZKhwETKSNxqE8IVO1JNFOOj1k95q28/NksJEW+zhOuVY2qdakYmG7411GjExWnBlirFF2UxcPcwLwvG8kq+WyGQyqnH0MwihS+slW70fOA=
X-MS-TrafficTypeDiagnostic: VI1PR0301MB1949:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0301MB1949;20:hsZG+IdMsw8tDH9NogrxAXvi9zC8FzoAoCl/BcFUjJ2gPQjF4biWMWbtCja6qlhJzKIgfClCEPcw/mLAYiv1Y4sTx+JtplQz6Yn3xQeQujXipKgupvR4pWuDbWjiAQF5YhjyPQRR4PufC6tVTEvFIGHOxmn8aBj8vNBrOwAX1SxWLUReQa8dbwTSmHn5uqfKRIC1NEdqzKghn3cE1raYnwQNk3mo2gDZfQtfvCmqmfxMvh1bN6S6rgJrk/fr4ihS2/qbJRELaDK9CLuUKuMFAo1Dm9dbKMX4EairrDlZNIHTqF0JD/E5KCHutYydIcO7FeTtuf39pKNO1QIt8fvyt6odYeJfRLXQUi7AwlauyuGbDXnFMP1GMi63LEzl27VtGxGGRG9K5oDV0eFoLeDsQM1ViPHDbaZncdjx4YOHVu3a/Rg6sbYgatLpsc8t86sjOSo8ssJ11o11KjqzwMvQbetmVE6M3PuIurd/GyrUNXndsMb2na81BpBgSq9kUEUM;4:pJl1yFxfPvoVR4eh9kIovVGAGJ3SGrj8nPICMq+na7UGIXzyvxbSu0QA6nDRsFAspz8k9YrQPFTwUFNeciU8X8HtTspCT0yYRnOtijm+6qEdPMIZfcclGNhmPli995la4Jv5NU3wsTMLkvkd2oatSggZk0q3T1DwqogkOCkDPB2JX7tMrtGMJ3K3FxSv1Z7X4hEu7c1n3liazTxiUjBuCRpBCDlxLCWNnY9jMzXJ6y2hiTY4c6mEbsSjRFqevgg6/0SNsYiVVsJEUnFI6iGlQlYxLJ/mrE4cfFCfRN7//DVkUxBA9gmLiPaMg0uxeSdD
X-Microsoft-Antispam-PRVS: <VI1PR0301MB19490D88DC185367A909E9F7E7C80@VI1PR0301MB1949.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(4114951738403);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001056)(6040501)(2401047)(8121501046)(5005006)(3231101)(944501161)(93006095)(93001095)(10201501046)(3002001)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR0301MB1949;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0301MB1949;
X-Forefront-PRVS: 0588B2BD96
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(39380400002)(366004)(396003)(376002)(346002)(199004)(189003)(51444003)(6666003)(83506002)(25786009)(72206003)(478600001)(65826007)(39060400002)(36756003)(2950100002)(2870700001)(8936002)(8676002)(106356001)(81166006)(81156014)(2906002)(305945005)(58126008)(6486002)(316002)(64126003)(16576012)(53936002)(5660300001)(31686004)(86362001)(47776003)(7736002)(65806001)(66066001)(65956001)(6246003)(97736004)(80792005)(68736007)(105586002)(23676004)(76176011)(186003)(3846002)(52146003)(77096007)(16526019)(6116002)(67846002)(59450400001)(2486003)(52116002)(55236004)(229853002)(386003)(26005)(53546011)(31696002)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0301MB1949;H:[10.17.182.9];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAzMDFNQjE5NDk7MjM6YVpGems1eWh6SUg2YkxKK2lxeTluTEVi?=
 =?utf-8?B?RDJQdW5LM3E2Q1drTUQwYlV6NGZITGVwem8xSWYwQmV2MVZVSU5uY0hjTGIw?=
 =?utf-8?B?SFhaaE5aaHE4aEhxSklQcGNabDhaNThIWkFVNEJqaUdNM2VlRnFLVm1vTHEx?=
 =?utf-8?B?WDJYRlRRMkxkMFJkOU1vd2tNeW9LTXN6eFk1OWtzZGZDMmcwWWxhSFo1THNP?=
 =?utf-8?B?N3hwRTVoanp6T0JNb2xjeFFkczJ1bkZrOVE0SHp6YlRTai9XY09PWW5iT0c5?=
 =?utf-8?B?ZXNxV3M1aGtzMWNrTitRT09HcVM0OEswVzBTNFlrMnJ3QTBycEFRWmR5RG9R?=
 =?utf-8?B?TWMwalpzMm43NUZJWXJRbnNaR1ZoNlZFbXF1SVFrYU56MnJaU3FHWlYwVm0w?=
 =?utf-8?B?c2p4VWhvMVhHckdYd2pEUXQvOWdPTmE1dU8zVDUrMDRKOTh3WGxqTUF1NkUw?=
 =?utf-8?B?dnczMWs0NkRiUVRucWRIdzhobTk3WWVQOC9MT0hpTjkzNmxyS2kxbm1SdVFm?=
 =?utf-8?B?SC9xd3VqTlZDQmRVUERJd0YwelJmQytJRTk3S0YzemNONDc4UGtiYmJVT3VE?=
 =?utf-8?B?aUE0Umc2cnhlL2xXcWowUEtQNEFMcTNHdXlwTXhDYllnV04zb1QrM0ZIbFV2?=
 =?utf-8?B?c05LSzgvM0VwM21GSDhVblMzYkJKa0ZVYkh5OEVaZXRsbVhzZ3FNNTBnblVV?=
 =?utf-8?B?ZVZ6NUk4SjhKSXlldTJWUzh3cmFSaTVFTDRGVTZIR0FQM0FVT0FjUjhBZzlU?=
 =?utf-8?B?Q1g0ck1aMnYveTBIOWZncDR0WjY2WDJtbW0wRlEwVkxMcm5zZDZGUExvSnlL?=
 =?utf-8?B?cW5PVjlCazBGSCtZWVFwK1FGYXFHMVVXaFFwa0tEMkJVckNZVzlyWndXQkxH?=
 =?utf-8?B?bnV4TmViMzk0Z1VXVTREampDckttak5vNHBCbkdFUkI5bDUySE1veWtBaWFR?=
 =?utf-8?B?TFRhdEZTSHRNVWQ1b3Y4VDZxallJeDVTcmd1c0RSYTdQVGE0SXZ2em8xQVBJ?=
 =?utf-8?B?cEFsckNxakFZeEpzbFE4c3Y5UXhZZmxURGRQeFlHakgyK2VVRFVYV2JERUpi?=
 =?utf-8?B?VHRVL3FqSXNEbm5OUWRneTYwa0tPODZFZCtSWG9mU0lJTkJWemZwTkh6cW04?=
 =?utf-8?B?UHZqWTNTMklBTEI1VjJYRWhqODZ3OG9RUXpFMStnVHVITTlKRGhqSDFCb0M4?=
 =?utf-8?B?bXY2VEhueTMwNjMyUURIak5kTEdZd1ZtUkhTUXd0eFg1S200ZnV1RlYwVFN6?=
 =?utf-8?B?RExyb3VwcE5xUHdYSm1TUFpHcUw2M0xvamt6RkNVWTMvQTZYZjJzUFRPOU9B?=
 =?utf-8?B?VkJsUGNyQzBXSlk4QjdCTmo0YkF3ajZmZVBxd0l1TzVUdm5RVUVQaGppV2ZZ?=
 =?utf-8?B?LzJrOGlEN3hjb0MwaFRiMm5GTlg5ckV5dzJXaW04U0FvZG1hY2J6dy9Ibnh6?=
 =?utf-8?B?T1gyOGNTcWRWYzBWSUdXMXRzZWtNc3owdW9sanlENUpRS054dEpGQk4wZ3My?=
 =?utf-8?B?UWh0cGk0azhxY0cvZXArWjYzOCtwd0cwblgzd2NzU1NENE1xUkwrdE5KdjZL?=
 =?utf-8?B?NTRpZHFkbzdJMlMzaUEyaGUwMmZMU3U3RXRMZy8zSTFJMjR6UnJIRjd3clp6?=
 =?utf-8?B?WVgzWWx0amppVlZoS0NtVEJzdE5mL0twaGo3enRjRWIrM0s1WDZqMjdJS0VL?=
 =?utf-8?B?UlZCaWhibzhuVm1NekRJanlHNndPM0JaMGx5MzVvcXZ1TGhRZFNJb1RZZm5B?=
 =?utf-8?B?bE1BaDZVVGFEY25sb2toVWxiYUhGVElaODFyRFpJekdoYjhCRjdsRUJDelkr?=
 =?utf-8?B?N0pjeUY0TUdQNXhtdDFNVUk5NzQ1UkphV0hXNVkzZjAvSWN4REZ1NGhmQnNR?=
 =?utf-8?B?a2F0K3hZVG5xWlZoVHZCbWY1V2hCUS91eGxJZUdUTloxZHhYaklReTFkN0U3?=
 =?utf-8?B?WlVPYUVHYkRIY1JIVmxVTzFRUHYzNTBKeXJ0R0Z1MWVLSmZIYWdWR1psekYr?=
 =?utf-8?B?MU1iSjRvaDQwR0c2bGI2NGZ6cWpHc3R1ajVTaGh3PT0=?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0301MB1949;6:eCYl84sW8y7m+9ZvMRYRfr4hC+4rftbf+uuToXiMZE+ut95JjOThLz4nIB8rpmyr6mQ9Y0U7uu1VFQg8jWu8+y3Th4nLl0ev7L8qWKM0NADdLWFvgP3CrsYj53Hcpt4JHoR5D/0MtrUUXSGGXzkwHNgjVMUQ+pmNL+G+0T9bZi8X+Vh85/XknzvSDePhYBVzqbuKr9BLIr6OTruIURFoCtJHnCA0dknAKwfPjEQWzA7z+37VdAZsWNatXm+0fUg1KPF+b84XVhzenRwh8DmSB/x+l2NxTRx5blTO0DimNeWcYdCq63bcm9jJ6t40+KnZEye9Snmhq4WAnHPFyR57sqjGTdl8brxASTtPpXbp6Zw=;5:dDwoteepzD7ObShM9GcpQ0vzSjZrlocM8TyRr1ZzYC6POmoDHTsO+KAq/z/LynMxSywciq9ccWqEjO0pAPUEPOHZzGuSALUEsna5eJxbaBdieAU3vhtEr5p8z3L5Wp+zAScCzmsEvMS8xvpcotM5QZvmOYA7IQ845ESaUhzoH78=;24:QYCnHoHeSdqlFKr4bPxu6V+w8I+SOWyWVt71buM/L1HzGmt/bCRfO83KhC23a9suvxKYiZgukTvUhuzfgyBbWchPHl28crj5ITqTM0vxEaE=;7:BookcfhOiw0kHTkQJTIItwj1k9eD/F8Slgci5bOewazY0t/qtL2lHjskNrXktH7gzMVJhWqxqDXRPgTKeAK1NJt6peLHIDI31xsG8kWsMJzXWjJeIywMJVILFMC8Kmv69Y1MCggoUiBKObIMCg8TsoiejzcmMnSyF0CKvXz2uNtI7Ok7F4BKlXmgZxF0hZUXJiyDpyErGLmjfTL7oPFRJd1+yeBzmr7awDjGatHpKOUSCpfAwCBYuoFpHY2JTzeB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2018 14:58:48.3598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63941223-35ba-479c-3843-08d577a94847
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0301MB1949
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/19/2018 04:30 PM, Daniel Vetter wrote:
> On Tue, Feb 13, 2018 at 10:44:16AM +0200, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> It is possible that drm_simple_kms_plane_atomic_check called
>> with no CRTC set, e.g. when user-space application sets CRTC_ID/FB_ID
>> to 0 before doing any actual drawing. This leads to NULL pointer
>> dereference because in this case new CRTC state is NULL and must be
>> checked before accessing.
>>
>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>> ---
>>   drivers/gpu/drm/drm_simple_kms_helper.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
>> index 9ca8a4a59b74..a05eca9cec8b 100644
>> --- a/drivers/gpu/drm/drm_simple_kms_helper.c
>> +++ b/drivers/gpu/drm/drm_simple_kms_helper.c
>> @@ -121,8 +121,10 @@ static int drm_simple_kms_plane_atomic_check(struct drm_plane *plane,
>>   	pipe = container_of(plane, struct drm_simple_display_pipe, plane);
>>   	crtc_state = drm_atomic_get_new_crtc_state(plane_state->state,
>>   						   &pipe->crtc);
>> -	if (!crtc_state->enable)
>> -		return 0; /* nothing to check when disabling or disabled */
>> +
>> +	if (!crtc_state || !crtc_state->enable)
>> +		/* nothing to check when disabling or disabled or no CRTC set */
>> +		return 0;
>>   
>>   	if (crtc_state->enable)
>>   		drm_mode_get_hv_timing(&crtc_state->mode,
> Hm, this is a bit annoying, since the can_position = false parameter to
> drm_atomic_helper_check_plane_state is supposed to catch all this. Would
> moving all the checks after the call to that helper, and gating them on
> plane_state->visible also work?
Yes, it does work if this is what you mean:
diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c 
b/drivers/gpu/drm/drm_simple_kms_helper.c
index a05eca9cec8b..c48858bb2823 100644
--- a/drivers/gpu/drm/drm_simple_kms_helper.c
+++ b/drivers/gpu/drm/drm_simple_kms_helper.c
@@ -122,14 +122,6 @@ static int drm_simple_kms_plane_atomic_check(struct 
drm_plane *plane,
         crtc_state = drm_atomic_get_new_crtc_state(plane_state->state,
&pipe->crtc);

-       if (!crtc_state || !crtc_state->enable)
-               /* nothing to check when disabling or disabled or no 
CRTC set */
-               return 0;
-
-       if (crtc_state->enable)
-               drm_mode_get_hv_timing(&crtc_state->mode,
-                                      &clip.x2, &clip.y2);
-
         ret = drm_atomic_helper_check_plane_state(plane_state, crtc_state,
                                                   &clip,
DRM_PLANE_HELPER_NO_SCALING,
@@ -138,6 +130,13 @@ static int drm_simple_kms_plane_atomic_check(struct 
drm_plane *plane,
         if (ret)
                 return ret;

+       if (!plane_state->visible || !crtc_state->enable)
+               return 0; /* nothing to check when disabling or disabled */
+
+       if (plane_state->visible && crtc_state->enable)
+               drm_mode_get_hv_timing(&crtc_state->mode,
+                                      &clip.x2, &clip.y2);
+
         if (!plane_state->visible)
                 return -EINVAL;

> We'd need to add a guarantee to drm_atomic_helper_check_plane_state that
> it can cope with crtc_state == NULL, but I think that's a good idea
> anyway. Atm it shouldn't end up looking at the crtc_state pointer in that
> case.
It doesn't look at it at the moment
> Otherwise we'll just go with your fix, but it feels all a bit too fragile,
> hence why I want to explore more robust options a bit.
At list with the change above it passes my test which failed
before. Although I cannot confirm it works for others, but it
certainly does for me.
> -Daniel
Do you want me to send v1 with the code above?

Thank you,
Oleksandr
