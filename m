Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751754AbeDEJAg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 05:00:36 -0400
Received: from mail-cys01nam02on0078.outbound.protection.outlook.com ([104.47.37.78]:51392
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751412AbeDEJAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 05:00:32 -0400
Subject: Re: [RFC 1/3] drm: Add DAMAGE_CLIPS property to plane
To: Deepak Rawat <drawat@vmware.com>, dri-devel@lists.freedesktop.org,
        syeh@vmware.com, linux-graphics-maintainer@vmware.com,
        ville.syrjala@linux.intel.com, lukasz.spintzyk@displaylink.com,
        noralf@tronnes.org, robdclark@gmail.com, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        airlied@linux.ie, linux-kernel@vger.kernel.org
References: <1522885748-67122-1-git-send-email-drawat@vmware.com>
 <1522885748-67122-2-git-send-email-drawat@vmware.com>
 <20180405073525.GP3881@phenom.ffwll.local>
From: Thomas Hellstrom <thellstrom@vmware.com>
Message-ID: <b87e222a-610e-05de-3ba2-7261831af5ec@vmware.com>
Date: Thu, 5 Apr 2018 11:00:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180405073525.GP3881@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [155.4.205.56]
X-ClientProxiedBy: DB3PR0202CA0006.eurprd02.prod.outlook.com
 (2603:10a6:8:1::19) To BLUPR05MB756.namprd05.prod.outlook.com
 (2a01:111:e400:89e::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0eaf50e-f373-49c5-9db8-08d59ad3ad87
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BLUPR05MB756;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR05MB756;3:RKlLzOPcoN5rOcHjZMCNisv6ZKiYxg23U9WdZ+QWdQw3A9WXOpFRTU7BglcHRw3R20FF7otS5/RRFCDiGB0krVV5Uq2t9QKEBRhTBw9K0poPQ1HZT/wDAUK43FtOTZmtP1cuJBMZaOoK72AewtLgD7ZIKORADJJKMPxrs/uICUwZEAp9xn+Dgza5ePpRvIPRaNjOKkW5zrQ6sdtLD1Ukdt3P5YnQHvtqfleyrI4OWtL6kSvn+Zyp5ZEeLou+vxLo;25:B+kpCQFnAxvJ0Yvz+IxLwCSneCeMqWrATjacH3MrBqstBVkAivk5o8FhrY/0UJOYpJQ4ASyMS2kThsKpKmK67zR+ll8DOXf/vCCwMrLUCGJ1xkz+cbPWGUwQcddzxQX3wJLeT9Jz1FMdmPUKPo76M1NGN6zFeyHnbHLBZsa4N6e16XWiWxU46fm+1qc8RinLt5CoDm1o18j1HRVTVOsttwJGejY2hIOXs3gQbVB401lrWkHPJeurvJpMa5lDrXgllge0vRcHBxnTft97n2zbyWbwCvDL2fHrSsQeFXbNUuV1D6x6WXbVCxuGKsPZwQf3C9hP3A+2Ebi4FFQmkd1qVw==;31:dOsU6JbcK1kV4qSNtP74l6zlnK420vRjHismq61IBEbOG7/8ismGPDzNRKCxDdnRGfe/ivbEdg0rUnr2/U7egLqe0T/0S2RkCH1ETX/qzkSAG6T2HPofMJ6yQt2Djj/Vyz2+HxzSypGy9/LJxCK2Jz77a6SMYRvT64bMBjIfQVLSC4hUwNqgmsyu/ZwAGZTP6/z24Cwh25J9rX35cPOL4XCymLJzCfH8AXdPK/6OrN0=
X-MS-TrafficTypeDiagnostic: BLUPR05MB756:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR05MB756;20:DzteknV1+COUwMNWcz8oxEV4EaAdO5CQFG/okV8wntnyImqg1xDKII6+v0ZSnzMmIDzqq0zqBoNcwVj/kOW7eZizCzv8ZC6o/cjsdoDKGLXZR2s2UVhjj2fIXEAAMSdlKhcGGQw0ZLqxsY3owaLWUaVXpj1tQyuOBFD70KfZjiM6pUN25GYtCnxk9c9jVuQJ6Y1nhoo6oNsvmv+hFH4T729btWT+S4zOzz6l6Z1iSJzWtYbiAHiBnRJmoCD96zjQZUACidR/BT8CL1ajsyDjnOq6BgsWUWZZpJHjbJpNrtOYd+Yil6aZ04g+QKwrphzvjbMsVpCDoh2hmypRBooxbVyGcv96wDnWck4vGBaJIayyZvFwKXE8cWRz/kZ2CO47kYYIERPF/ghCs4EFpo6jjPCKi6g5ELZVHqo/mDPm/sPXQEBR6zyE3sELhgCj5eGWje51lH6kbYDDma5RQB1segvQpDxhAk50wGLY6CD2TkUpVJ1oLkwxydSfJhDitjDI;4:GQazns7I6/BAaWVwEkVcyZ6Tito+SnHykrR+5l0LBFWwtvU7mZnjx/aDCzBxF8OeW883Ds/iNjByFaZIiJG3TKrOiJb8YkALXW5dSHSki2Q0mZ9uvGw7cJgUpmYvlBSUvsgeyXYPf5po5ZQgoLXmql6aXAYc6DxJ4KRe+U9/8utemK7XK65DnCxyYD2NsizgHoptYn0evwvbAGrHtyxwhutEYJncBv7l2lHjoBXiIvsdd31xUsIjc2eVo3UFDhq0wpeIt5+8zuM87nI5BqCTfoR+bi3vTVUyX6U2KDyMtesobCseVmH3HG8pkxREG+1hVB2ycJXPxxjWyd5C7derbGc+KpXsUvKN1Um1uLrfvSc=
X-Microsoft-Antispam-PRVS: <BLUPR05MB756D0FF897A6A050BE73DE4A1BB0@BLUPR05MB756.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(61668805478150)(10436049006162);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BLUPR05MB756;BCL:0;PCL:0;RULEID:;SRVR:BLUPR05MB756;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(366004)(39380400002)(396003)(346002)(376002)(199004)(189003)(11346002)(52116002)(58126008)(2486003)(97736004)(52146003)(16526019)(23676004)(956004)(7416002)(6506007)(53546011)(229853002)(386003)(2906002)(65956001)(230700001)(7736002)(76176011)(47776003)(66066001)(65806001)(2616005)(305945005)(59450400001)(31696002)(316002)(486006)(478600001)(6512007)(6246003)(39060400002)(67846002)(6306002)(6486002)(3846002)(105586002)(446003)(5890100001)(8936002)(53936002)(50466002)(36756003)(5660300001)(68736007)(25786009)(64126003)(8676002)(476003)(6666003)(26005)(575784001)(81166006)(31686004)(6116002)(86362001)(966005)(106356001)(186003)(81156014)(65826007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR05MB756;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjA1TUI3NTY7MjM6a2VyVDZ0WDVhYmcyTzZzYmZGLzIyd2M5d0RY?=
 =?utf-8?B?YVVxWUpWVlZOa3lMdVlMK05OVlRHV04zeE0rbDNHYjhkdk5aQ0I3ZlJiWmdl?=
 =?utf-8?B?VkJUMGVDYnRYeFoyRWQ0NjlqUzFtcUtYZUhKM1NNOFNLb1RIYkJSTUoxS1JB?=
 =?utf-8?B?VWhPVXFzbCt1NVUzYUVtTjgyZlNPTERHUDVtNk5qcTBFVVIyZEtxSGpCdTdl?=
 =?utf-8?B?WEFCckNKNDJuNiszbXE4SU1ZRGJXLzBVc1QrMmNiY0J6WUpFTEVqZTNQWlU3?=
 =?utf-8?B?N2VYNS83YnhucmNuVEFrb1Q4S2FlSGM2NVRQOW1GY1o4UmpEbVdxZzdlbm5M?=
 =?utf-8?B?RXZPdzc3MUl5bU4xSWxwVzZNTklGT00xWVdqMGMvbTNPN2V6R1hwcXE3YXFo?=
 =?utf-8?B?cnJXMkRGTnRBbFpqVEY3Nng5eHF1d0p5Ly9GKzhmYzFZQ3EyN2dHdkJPU29H?=
 =?utf-8?B?bFFMSVJSTExvWTl6VjZtMklCWVU0bk1ZcDZ3RldaS3QwOEc1YjRSL28rbmls?=
 =?utf-8?B?M0tvU0NIWlR3UCtFQ3IrU3NOYVRQSXkrR1BQQnIwK3VEUytyU1krc04zd24v?=
 =?utf-8?B?ckFCRzduYjFNSVByWU5na21CTERwa0xzeWIvRlVtUmN0YnFyM0V4ZWJ3TFhl?=
 =?utf-8?B?RzBFVDJoa28xdnlQK2FqU1l0TXd4MGcvMnNSOGNDMXlCakVSTkFlck52bFNF?=
 =?utf-8?B?YWQzekIyZU9xZWJDc2J5K3ZJWmxLMFdJaVJCcWxzV2NDWjRpOENobEl5OXNP?=
 =?utf-8?B?TDl5aUxOZkNxd0dSM0tOMm83cHgyQUFoNUZ3MkdmV0lpLzlhSUcrM0MyQm4w?=
 =?utf-8?B?NWNQMjhlb1Ztcm96OVRtK3UrSDE1Q243RVE0SXNxWWp1ZDdaVkFrWE9KbXVq?=
 =?utf-8?B?ZDJyWGRNbW0yM1kvY0VSZlFybDdLNDh1ZlJqcFNXa3BqUklaN1l1REo5KzJz?=
 =?utf-8?B?blNJbnJtRFdVN3JrMVhaZWpHRldBY3gydWVmd3Y4YVY2YWtwQTdTNGlQdnNN?=
 =?utf-8?B?T3FuV0JqSzhMQ2tzTWdtNXdYSTk4cWpJNHpiUE9BWmpid1RsK09NclBlaHA4?=
 =?utf-8?B?UVBLR1Z1S0xSbnNucm9va2NDYmVKRy9kdThJb2s4NlNDKzByQ0pZZHdkV2Vq?=
 =?utf-8?B?TERMcjZYV1gzNWxMSkpXaXhpOFZLRkJ0aUNCVUFzcHNHeUtFMnV0amRwS1p0?=
 =?utf-8?B?Z2NRNk1BK2l2TjBuclR0TjFyOFZCUUMxanA5eVdKRzlFU1YxN3Fjbmw1Tlpw?=
 =?utf-8?B?NEVySzBpQy9JazN4bGVmZWlSV0o5UWNZZnhWUE9jKzdVV0FyRFNUZUI4bXFy?=
 =?utf-8?B?UGQ3SDVVUDVLeS9GaHk0UUp0V0NVRUtHbmw4ekFzTFMvL3dydytqVnJOM0dM?=
 =?utf-8?B?TFgrSGhjNGE5WVZwcUZ5bS8xUHR5enRlOG1tbWdvYjI4a2VNY1NMdXFGN202?=
 =?utf-8?B?dEdRNnlMYzNka3ZLVERVeFh6aHEzb2xGaEhNR2JzKzI3K0NjUFhvNWVJR3RU?=
 =?utf-8?B?MXdFU3VpbTByd294VkNkWXVJSGZNZGFjRTl2bnI3SW1MSjJZT2pzdHFaV1JL?=
 =?utf-8?B?eXcyREtaWUtQb3lxckpLTW9uOEErOGxUL3B5bDVlaGxua3RQMXROa0ZMOUI1?=
 =?utf-8?B?V01oeExSMTRqVzY3L2FkT2JHVzI5OFdCNlMxWnl6bVBnT3JOdS9tNEZiVFI3?=
 =?utf-8?B?ZzBuWlpwak1JZFIyQWlkVStoWU0vcmVoNGt0Qi9SbHliK2pvOG81aTNIdFlS?=
 =?utf-8?B?ZG5FSzNXa2F3cWhLaE8zMjAwMHBUOU8wYVFOdHpKVERPWWZxTU1ZYkZNS0VD?=
 =?utf-8?B?WXY1SmZIU2VJcE9DaWZFRU5YcnA5MlZkS0xXRE56VUY5SzlOY2xVQ2tWaXRG?=
 =?utf-8?B?ZXMvU2JrMi91RFlVdXBqRThxTXhIdlJ0Q240cVdmREdSVnBrUVhUUUNnanNM?=
 =?utf-8?B?YzQ2dm0wRGo0NkJtZHZjMFdvWU9RWEo5QWxVRUpWOHlsWEFEcm1rcmQ4NkJq?=
 =?utf-8?B?S1lScjdGeTJ5QjNYSTFzdFJWZy9JSWlNa2FRRVN3ZTBVNkcyL0t1blZsUlNy?=
 =?utf-8?B?K29OdzFaWHB3QVpoclVwbEJ1QU1nR0tTeERlMis4b1VBcy94dVFBRk1DazNG?=
 =?utf-8?Q?aL/n5W0yojrHLNwTWA/FOQLpGciaNQo+a+xXIE0TTaT?=
X-Microsoft-Antispam-Message-Info: YqWXGXOGUKmU9Ivk4gAJqzNSBMeLbUk+Qph4YCCiYecXhlH7XutHc6wZs8UPyFgVX0YYX4VWtjiGuS5xADECG/1RbHtDuxSnRqn3qC60Ke5mHqhNbk16xQNhGVxWkeK9HkvIKGRSXCIE+1WurGIyzdzw18qzH2rBTIel0uIt8h6Xxfci2tSA8VGG9Qv2XwM5
X-Microsoft-Exchange-Diagnostics: 1;BLUPR05MB756;6:E5EkgtBeiFQoIQSnA0dB3cncIrzGTvlkX2/a4r7EKpU/TdBaRpTnuZcyNJT8Eizzu378byo/UnjD2Y+aa5vOqknIgxta2QIqBQ9s7A96692+Wq0xm20GyC9lCRpvXOG7u+B2VHE7bBOtaUDSR3ysdjSzIJbrRVvivpyTFMk91c4y7AhJKfZRXjezEklhihNch35Vi28kytc6VyO4HK4kMg28vG9QIZaLSEwD1NBIXiXO0mSt6yzf5CYsziwGjjQSUf4kXhNqWjt343t17Dw3viIU0RNgskrFpUIcRw/hPr6vqrvXVuGKpQ9Rrcp7lHLXGovJiVJVZ5m4khilcEGq0OxGZ378crutvGSqBklzD5pI1LbEwkdiA5uiu+SsBpd4K0SevZH0lYcUKrUJWZh31ifqjcUe5DLXB1ijIB2/yPf4e+7jatR5FJjuZOJVk5L33XoSapX1m1xfSWOg9AzC6A==;5:kfgKJ20m42UG1OVv1BeEclqFihj+i967pumLLoeVb6nCnv6wSzusMxx88FtKReQFtKAQ0ndzdG5TCFGlPRDX7NpxGjchUCFmwwTVDfNAEcxHDFUNr1O/O0AytLnRL99xsqwN08fBOUxAhxxy4nOrYhfXme5VxdHlkiUuBFwBmzk=;24:AAxmJgLJ7uRVlf+kLC/pU4HGbKNv5NfClIF2pQWlqgkz3zBP5mltKESHyA9E9Z4bNukFWxdxJWuXxdfcCQzpJOL9EoflxMmglkPNqvdVxjU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR05MB756;7:u1uXmfqB+xasDBkhDEu8zRzhDQnU1LYoc4qc+yAC/JVi/EmLf1xOWjD/DJSZwuD0Ffi9uM+yBAJ7hXUgI6HOQJC9ZRU17BJShxY8NuJypbAJUo0sEBAK/n9iZeOpmcytzZd/wlDs6VDDti+MA3gtGecrGVi024QGviu8QrtAeT+MgVaQmU77PH8+fgVXlmHoHEViYwUxJFx23JTMEkDmLtkzsjzOGj+kS0Zsd0pVaM+zLMvt28e50GGDYgvUdrDW;20:KrJ9F4e/EUqBbp/5ZJ8AZ99IcmNst01jEQB7DH/CZA5v/8QFlngm4SySm+3Imjz5GjvBCg6Jp6vZUoysPL/kALHtWMqxPwp3A7QDnApxkcMtFTQ0a0FKTy+S6DM5wDJiYVvWzmlgqlC01w/b+tdJsDLaHrICm8ZT5F5S/VuXxRc=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 09:00:26.0578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0eaf50e-f373-49c5-9db8-08d59ad3ad87
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR05MB756
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2018 09:35 AM, Daniel Vetter wrote:
> On Wed, Apr 04, 2018 at 04:49:06PM -0700, Deepak Rawat wrote:
>> From: Lukasz Spintzyk <lukasz.spintzyk@displaylink.com>
>>
>> Optional plane property to mark damaged regions on the plane in
>> framebuffer coordinates of the framebuffer attached to the plane.
>>
>> The layout of blob data is simply an array of drm_mode_rect with maximum
>> array size limited by DRM_MODE_FB_DIRTY_MAX_CLIPS. Unlike plane src
>> coordinates, damage clips are not in 16.16 fixed point.
>>
>> Damage clips are a hint to kernel as which area of framebuffer has
>> changed since last page-flip. This should be helpful for some drivers
>> especially for virtual devices where each framebuffer change needs to
>> be transmitted over network, usb, etc.
>>
>> Driver which are interested in enabling DAMAGE_CLIPS property for a
>> plane should enable this property using drm_plane_enable_damage_clips.
>>
>> Signed-off-by: Lukasz Spintzyk <lukasz.spintzyk@displaylink.com>
>> Signed-off-by: Deepak Rawat <drawat@vmware.com>
> The property uapi section is missing, see:
>
> https://urldefense.proofpoint.com/v2/url?u=https-3A__dri.freedesktop.org_docs_drm_gpu_drm-2Dkms.html-23plane-2Dcomposition-2Dproperties&d=DwIBAg&c=uilaK90D4TOVoH58JNXRgQ&r=wnSlgOCqfpNS4d02vP68_E9q2BNMCwfD2OZ_6dCFVQQ&m=J31YNV1uz3IVRaorM-eo48msi9__sQurqRZrig2UE1s&s=vzsuquF1agbOw54HSC_18Kk2k9j83m8RusmDCtPAFWQ&e=
>
> Plane composition feels like the best place to put this. Please use that
> section to tie all the various bits together, including the helpers you're
> adding in the following patches for drivers to use.
>
> Bunch of nitpicks below, but overall I'm agreeing now with just going with
> fb coordinate damage rects.
>
> Like you say, the thing needed here now is userspace + driver actually
> implementing this. I'd also say the compat helper to map the legacy
> fb->dirty to this new atomic way of doing things should be included here
> (gives us a lot more testing for these new paths).
>
> Icing on the cake would be an igt to make sure kernel rejects invalid clip
> rects correctly.
>
>> ---
>>   drivers/gpu/drm/drm_atomic.c        | 42 +++++++++++++++++++++++++++++++++++++
>>   drivers/gpu/drm/drm_atomic_helper.c |  4 ++++
>>   drivers/gpu/drm/drm_mode_config.c   |  5 +++++
>>   drivers/gpu/drm/drm_plane.c         | 12 +++++++++++
>>   include/drm/drm_mode_config.h       | 15 +++++++++++++
>>   include/drm/drm_plane.h             | 16 ++++++++++++++
>>   include/uapi/drm/drm_mode.h         | 15 +++++++++++++
>>   7 files changed, 109 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
>> index 7d25c42..9226d24 100644
>> --- a/drivers/gpu/drm/drm_atomic.c
>> +++ b/drivers/gpu/drm/drm_atomic.c
>> @@ -669,6 +669,40 @@ static void drm_atomic_crtc_print_state(struct drm_printer *p,
>>   }
>>   
>>   /**
>> + * drm_atomic_set_damage_for_plane - sets the damage clips property to plane
>> + * @state: plane state
>> + * @blob: damage clips in framebuffer coordinates
>> + *
>> + * Returns:
>> + *
>> + * Zero on success, error code on failure.
>> + */
>> +static int drm_atomic_set_damage_for_plane(struct drm_plane_state *state,
>> +					   struct drm_property_blob *blob)
>> +{
>> +	if (blob == state->damage_clips)
>> +		return 0;
>> +
>> +	drm_property_blob_put(state->damage_clips);
>> +	state->damage_clips = NULL;
>> +
>> +	if (blob) {
>> +		uint32_t count = blob->length/sizeof(struct drm_rect);
>> +
>> +		if (count > DRM_MODE_FB_DIRTY_MAX_CLIPS)
>> +			return -EINVAL;
>> +
>> +		state->damage_clips = drm_property_blob_get(blob);
>> +		state->num_clips = count;
>> +	} else {
>> +		state->damage_clips = NULL;
>> +		state->num_clips = 0;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>>    * drm_atomic_get_plane_state - get plane state
>>    * @state: global atomic state object
>>    * @plane: plane to get state object for
>> @@ -793,6 +827,12 @@ static int drm_atomic_plane_set_property(struct drm_plane *plane,
>>   		state->color_encoding = val;
>>   	} else if (property == plane->color_range_property) {
>>   		state->color_range = val;
>> +	} else if (property == config->prop_damage_clips) {
>> +		struct drm_property_blob *blob =
>> +			drm_property_lookup_blob(dev, val);
>> +		int ret = drm_atomic_set_damage_for_plane(state, blob);
> There's already a helper with size-checking built-in, see
> drm_atomic_replace_property_blob_from_id(). Wrt computing num_clips I'd
> just provide a little inline helper that does the
> blob->length/sizeof(drm_rect) conversion (it's just a shift, so fast).
>
>> +		drm_property_blob_put(blob);
>> +		return ret;
>>   	} else if (plane->funcs->atomic_set_property) {
>>   		return plane->funcs->atomic_set_property(plane, state,
>>   				property, val);
>> @@ -856,6 +896,8 @@ drm_atomic_plane_get_property(struct drm_plane *plane,
>>   		*val = state->color_encoding;
>>   	} else if (property == plane->color_range_property) {
>>   		*val = state->color_range;
>> +	} else if (property == config->prop_damage_clips) {
>> +		*val = (state->damage_clips) ? state->damage_clips->base.id : 0;
>>   	} else if (plane->funcs->atomic_get_property) {
>>   		return plane->funcs->atomic_get_property(plane, state, property, val);
>>   	} else {
>> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
>> index c356545..55b44e3 100644
>> --- a/drivers/gpu/drm/drm_atomic_helper.c
>> +++ b/drivers/gpu/drm/drm_atomic_helper.c
>> @@ -3506,6 +3506,8 @@ void __drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane,
>>   
>>   	state->fence = NULL;
>>   	state->commit = NULL;
>> +	state->damage_clips = NULL;
>> +	state->num_clips = 0;
>>   }
>>   EXPORT_SYMBOL(__drm_atomic_helper_plane_duplicate_state);
>>   
>> @@ -3550,6 +3552,8 @@ void __drm_atomic_helper_plane_destroy_state(struct drm_plane_state *state)
>>   
>>   	if (state->commit)
>>   		drm_crtc_commit_put(state->commit);
>> +
>> +	drm_property_blob_put(state->damage_clips);
>>   }
>>   EXPORT_SYMBOL(__drm_atomic_helper_plane_destroy_state);
>>   
>> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
>> index e5c6533..e93b127 100644
>> --- a/drivers/gpu/drm/drm_mode_config.c
>> +++ b/drivers/gpu/drm/drm_mode_config.c
>> @@ -293,6 +293,11 @@ static int drm_mode_create_standard_properties(struct drm_device *dev)
>>   		return -ENOMEM;
>>   	dev->mode_config.prop_crtc_id = prop;
>>   
>> +	prop = drm_property_create(dev, DRM_MODE_PROP_BLOB, "DAMAGE_CLIPS", 0);
> Bit a bikeshed, but since the coordinates are in fb pixels, not plane
> pixels, I'd call this "FB_DAMAGE_CLIPS".
>
>> +	if (!prop)
>> +		return -ENOMEM;
>> +	dev->mode_config.prop_damage_clips = prop;
>> +
>>   	prop = drm_property_create_bool(dev, DRM_MODE_PROP_ATOMIC,
>>   			"ACTIVE");
>>   	if (!prop)
>> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
>> index 6d2a6e4..071221b 100644
>> --- a/drivers/gpu/drm/drm_plane.c
>> +++ b/drivers/gpu/drm/drm_plane.c
>> @@ -1101,3 +1101,15 @@ int drm_mode_page_flip_ioctl(struct drm_device *dev,
>>   
>>   	return ret;
>>   }
>> +
>> +/**
>> + * drm_plane_enable_damage_clips - enable damage clips property
>> + * @plane: plane on which this property to enable.
>> + */
>> +void drm_plane_enable_damage_clips(struct drm_plane *plane)
>> +{
>> +	struct drm_device *dev = plane->dev;
>> +	struct drm_mode_config *config = &dev->mode_config;
>> +
>> +	drm_object_attach_property(&plane->base, config->prop_damage_clips, 0);
>> +}
>> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
>> index 7569f22..d8767da 100644
>> --- a/include/drm/drm_mode_config.h
>> +++ b/include/drm/drm_mode_config.h
>> @@ -628,6 +628,21 @@ struct drm_mode_config {
>>   	 */
>>   	struct drm_property *prop_crtc_id;
>>   	/**
>> +	 * @prop_damage_clips: Optional plane property to mark damaged regions
>> +	 * on the plane in framebuffer coordinates of the framebuffer attached
>> +	 * to the plane.
> Why should we make this optional? Looks like just another thing drivers
> might screw up, since we have multiple callbacks and things to set up for
> proper dirty tracking.
>
> One option I'm seeing is that if this is set, and it's an atomic driver,
> then we just directly call into the default atomic fb->dirty
> implementation. That way there's only 1 thing drivers need to do to set up
> dirty rect tracking, and they'll get all of it.
>
>> +	 *
>> +	 * The layout of blob data is simply an array of drm_mode_rect with
>> +	 * maximum array size limited by DRM_MODE_FB_DIRTY_MAX_CLIPS. Unlike
>> +	 * plane src coordinates, damage clips are not in 16.16 fixed point.
> I honestly have no idea where this limit is from. Worth keeping? I can
> easily imagine that userspace could trip over this - it's fairly high, but
> not unlimited.
>
>> +	 *
>> +	 * Damage clips are a hint to kernel as which area of framebuffer has
>> +	 * changed since last page-flip. This should be helpful
>> +	 * for some drivers especially for virtual devices where each
>> +	 * framebuffer change needs to be transmitted over network, usb, etc.
> I'd also clarify that userspace still must render the entire screen, i.e.
> make it more clear that it's really just a hint and not mandatory to only
> scan out the damaged parts.
>
>> +	 */
>> +	struct drm_property *prop_damage_clips;
>> +	/**
>>   	 * @prop_active: Default atomic CRTC property to control the active
>>   	 * state, which is the simplified implementation for DPMS in atomic
>>   	 * drivers.
>> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
>> index f7bf4a4..9f24548 100644
>> --- a/include/drm/drm_plane.h
>> +++ b/include/drm/drm_plane.h
>> @@ -146,6 +146,21 @@ struct drm_plane_state {
>>   	 */
>>   	struct drm_crtc_commit *commit;
>>   
>> +	/*
>> +	 * @damage_clips
>> +	 *
>> +	 * blob property with damage as array of drm_rect in framebuffer
> &drm_rect gives you a nice hyperlink in the generated docs.
>
>> +	 * coodinates.
>> +	 */
>> +	struct drm_property_blob *damage_clips;
>> +
>> +	/*
>> +	 * @num_clips
>> +	 *
>> +	 * Number of drm_rect in @damage_clips.
>> +	 */
>> +	uint32_t num_clips;
>> +
>>   	struct drm_atomic_state *state;
>>   };
>>   
>> @@ -611,6 +626,7 @@ int drm_plane_init(struct drm_device *dev,
>>   		   const uint32_t *formats, unsigned int format_count,
>>   		   bool is_primary);
>>   void drm_plane_cleanup(struct drm_plane *plane);
>> +void drm_plane_enable_damage_clips(struct drm_plane *plane);
>>   
>>   /**
>>    * drm_plane_index - find the index of a registered plane
>> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
>> index 50bcf42..0ad0d5b 100644
>> --- a/include/uapi/drm/drm_mode.h
>> +++ b/include/uapi/drm/drm_mode.h
>> @@ -873,6 +873,21 @@ struct drm_mode_revoke_lease {
>>   	__u32 lessee_id;
>>   };
>>   
>> +/**
>> + * struct drm_mode_rect - two dimensional rectangle drm_rect exported to
>> + * user-space.
>> + * @x1: horizontal starting coordinate (inclusive)
>> + * @y1: vertical starting coordinate (inclusive)
>> + * @x2: horizontal ending coordinate (exclusive)
>> + * @y2: vertical ending coordinate (exclusive)
>> + */
>> +struct drm_mode_rect {
>> +	__s32 x1;
>> +	__s32 y1;
>> +	__s32 x2;
>> +	__s32 y2;
> Why signed? Negative damage rects on an fb don't make sense to me. Also,
> please specify what this is exactly (to avoid confusion with the 16.16
> fixed point src rects), and maybe mention in the commit message why we're
> not using drm_clip_rect (going to proper uapi types and 32bit makes sense
> to me).

IMO, while we don't expect negative damage coordinates,
to avoid yet another drm uapi rect in the future when we actually need 
negative numbers signed is a good choice...

/Thomas
