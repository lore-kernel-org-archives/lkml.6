Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753340AbeDSRr0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 13:47:26 -0400
Received: from mail-dm3nam03on0064.outbound.protection.outlook.com ([104.47.41.64]:51856
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752890AbeDSRrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 13:47:24 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com;
Subject: Re: [PATCH] amdkfd: always select MMU_NOTIFIER
To: Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180328155340.2253343-1-arnd@arndb.de>
 <664e2827-5237-160b-6ecf-c2da163569e1@amd.com>
 <CADYN=9LTmdLzeszPDeLZ1==9g1ciS1ubunC6jdjLJUiv6J6N3Q@mail.gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <57c0cfd4-7be6-2572-0bb8-6e1d3e87ef33@amd.com>
Date: Thu, 19 Apr 2018 13:47:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CADYN=9LTmdLzeszPDeLZ1==9g1ciS1ubunC6jdjLJUiv6J6N3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YQBPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::28) To CY4PR12MB1701.namprd12.prod.outlook.com
 (2603:10b6:903:121::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1701;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1701;3:ZV8A3kY9AVmR/nKY2De/Jvw3wFfU56t51VpAqrTIzGrgLlMJ7DlD8/QvgphZSI2I7qoGFz7DMGQez4P3/6jd+juTbAtODrm7Y4n/KvqiUlzqGQnNX4WLvqbqKBx11ZS3tLcMYCx4AY5BPa5W8obwBluM0YJaxGLyiW+2OWzoT+FUuZiVQGJlCmYG9HEQTOfUeOubX6Xw49j1/1eDmIATo8uguaqxILSUpoIomTeu+Q+VQ3L0KJKFW4+VilrGuq6l;25:Hf6v5wduhg5Ew2CHNWkBTYPLxc/nD1oKCV5a9Ab19mWESIZSpHAvm2djLpItkvWBup0RJ/Zs1ecCjO8lr0CQEyZ2VCRHDK97ZlVLncqot6xlqrzdlEm9FXzcXxuSUGBZzuN9YfwND7cexy8zm+W0nFPxUaB2SXLk66mVPDgCQ1xnR/gvxybkw0GaMYQzDQh4/WRlvyAkRQ6ULV6j/yYp037br9PLCxMYxHdvQEArN0hm1OQItEEK/3Jr661Phl4z+dpskMz0/4OwkBFwIhWgdy1wWGXkctIkSZdE9FGEz1pCqdWyeaukjxUfSRamkUuzmb5qLzmzyATttYzxhMLCqA==;31:ZZDmgW6FgLUpXceIxNmtQ0ItIZ6O5mh1Yelzvw4TYQumrNCDPRnUuBcypCl1hyrKQKpXmX7kV7KUIRDYP1mce6XMySfhOLe+fQk7bLpV8XQTVTov8A9GJbKrLMZUGpUmKElcspjT9BvqhWBSvzByZDn5GCGWjAip0IN3M3UHw+TpBisxl5zukbsuMsMp5ArzHkR9NhqvrLub+Kw6aB+4yvh63HL9RNZu43EgtSf4Oy8=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1701:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1701;20:hEux/ig3GIuRh6eYSPQKGWbcm5mfYxFvfWTyN3eEKVvnJgT36NDCqotZws4Evsc6dBfp40APoNbputbwfGwWmwEBnmaJIVorptVyQ7d8FH0WmfU6RrX0KGosfM7wwHeF+zNfqmQG+9KmyxKct212is6jOFdsFMFKyPIOIHRa3iaQgz6AqWe9BzP7shbKp/nWgjHam5OPJiKiCPioKzI/ptA0S98cwqxCug8RIyOWMvFNzVBr1HuoOwjEghvY4HKA4DEdyMoarOOnOIjSKFGEzW5k4M/DSDfV1VYJ0jnyme38gilZdxWXmIkN9eBn3uLUuBXjvqJbw9M1yeKuzS54vv1YQU+f43XfwoxDx6G5mIzLUUB7rcoU1qdroa9dWum7aISJCXGMYV7B5vHzaoojad5c4a4JS5TpfpfGwt/gro2impqw/aC2CTklniu6cefa+mZOCKjvy4FI+a4kCmZ2Dg2ykgJBV6ZC5kfmHHM3nnh4RqlyCXH6iZva5r/lpGgs;4:4ZhO5ySMwqHurhjIpShInaIoRADDT5DYnrSCz4+83CIrd5gWeUQec7ZxBZwEtJAeBmi6Cw2iuCaTPbd7FH/V1xvIfMu9sOULa128Yc/rLtlK+s3hUOfmoKJ+ncE2/eY5RzDEdtovHErkabAHT44N4bVPxoG6pV8kvuqM+/T8byTod07RDp/7SN7qE6Rn8NqycctKPJXvjXuLgTojBhg9PqFF78d7ytM4/XX2eoC+o0qmIa/yUSvLpQa8LtczKt1kMFdjXNsAIWoU9l9NZuSykAFbHQM0TJzafm2nB/Ywe1AzoSm8B1mpq6ZqxVPQxSBd
X-Microsoft-Antispam-PRVS: <CY4PR12MB1701BFC3BB405E1A81FC3F4892B50@CY4PR12MB1701.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR12MB1701;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1701;
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(377424004)(966005)(6636002)(2906002)(6666003)(5660300001)(54906003)(2870700001)(31686004)(6486002)(110136005)(64126003)(8936002)(25786009)(65826007)(81166006)(86362001)(50466002)(31696002)(305945005)(8676002)(53936002)(7736002)(53546011)(72206003)(386003)(36756003)(446003)(6246003)(11346002)(6306002)(956004)(2616005)(476003)(3846002)(58126008)(76176011)(6116002)(52116002)(4326008)(229853002)(36916002)(23676004)(39060400002)(52146003)(16576012)(26005)(65956001)(186003)(2486003)(44832011)(478600001)(65806001)(66066001)(16526019)(77096007)(316002)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1701;H:[172.27.225.16];FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxNzAxOzIzOkhQazlKT1piSVV5SDNWdTQyZyt6OVV6Rlpk?=
 =?utf-8?B?RVJGNGtJSEVlS1E3NnRjZHdqYndMdmltUXMwK0hoYmtKWk1MOUVncThwOXVh?=
 =?utf-8?B?ZUJxQ0VNYkpwRnE0M05JTG9lVlZicHZHK2FkeG82L1h0UmtaSFd2M09SeG9N?=
 =?utf-8?B?WWhUTm9NOHU1akJhdm9jdjNvZUYwNDlpN1NQRGV2K1cySmJXR2ZORmRLQktt?=
 =?utf-8?B?K1hhTjRWZFZvRWdDUTRobUZ0a3hHYXo5NjhsY3UreTNZeWVLS21NbEwzQnhW?=
 =?utf-8?B?QUhGUTVKNEhsY1JEemJVNmdTaVI5cWdMNjhEaVZpeTllV3Zmd0Z3YmFSa2Vz?=
 =?utf-8?B?K2VGVU5Wd25FWE1pRDg0ZlZZWUlJR0Nhamc1R1FUWHM3NzdBTENtTlV4RVhn?=
 =?utf-8?B?UHd3eU04RDRTVnp6cnRpSTRQK3lNTHdyWVY2U1JWUnJOOVllbW1YalJFTHY1?=
 =?utf-8?B?N2hwQXhEakFkRmxBRWlBSytDS2h2NlY4cFZIRS9HOStWeWwxU0x3eFRPOGY1?=
 =?utf-8?B?Zlk3VmR5SjhuWWtnbkUyNDJ0amM3dTdUSEVNVUs1L0hRcndhaUtCY0oyL2lE?=
 =?utf-8?B?M01WTlhVaHY5MTMvbGp5U2g2QlpneE5vT0laMktDYlIvdnNyLzdPOVJZSWg2?=
 =?utf-8?B?dkRlcG1aam1CZ3ZKN1ZySThSSmFrOEU3SVY2eGJEaFZremRqT0llWXNEcm9E?=
 =?utf-8?B?dGx1Z01vN281KzNDdi9TOW91bnBlaU1yVWViZzVtS1VoaEtIbElnUm9MeG9L?=
 =?utf-8?B?SWtsamlDbHpUNUNCVlJtbDZlTmh1RmR4NTh6WFZYVklGZE81K290aXFCQTBo?=
 =?utf-8?B?M2Z5dms3b1EydGpqbjRiaXV1NHBhSXVWQjhldHp4dkVCcDg2WTZVeVBwMEVo?=
 =?utf-8?B?b2VzN0RKMkpRcndLMWs2a3JMVmplNi81UHkzcEFvRkxoeCthdlZtZ2FjMUtE?=
 =?utf-8?B?VEQrUUJZMFJwMjUxQmE1YzZLb0luZGlMd1ZUbHMzM2F5MWZJVnpMdGJxTFF1?=
 =?utf-8?B?WHNyZEI0aW9kQ2JrSTBZSkcwQ1dVRnBFT21TZERYeHQyMmJRWlF5Tnp6cUdL?=
 =?utf-8?B?YzBPKzN6dlczUXUwakc0OFVDNTMzbExkT2k5STRlR1c5TThDZlpIaUVtSElo?=
 =?utf-8?B?aFdhd21UazdQU1ZYZ0VzbnhXNjRZTWxBMHN1UUt3bGR6SHdDZThHVUZlWU1a?=
 =?utf-8?B?OU14QUVFRGxQM0VRc3l3SmE3cEFXNTFjQ3pBaU5zblh1S0xKc291OHZLT2hq?=
 =?utf-8?B?eUFtUVJHZTdQVzNhRlAwZHBWelFMNzhHQkxvcW1Ham84a3cwS3BwNnlNaUVF?=
 =?utf-8?B?VDlFS1BWNmpZTTliTGtwTXRnUmUzOU1ha1RMbWhTVnZCSEdDK3F5VzV1TW5N?=
 =?utf-8?B?aHpLaXM4UHYxS213QmVoMk1nY0pzSDY0RVBIcENEZVU5bGR1Q3lBRlpJeE9Z?=
 =?utf-8?B?ZXpHRW5zM0U4UDR2eVJmeFlSYkNaQWNBdjN4SDRMdUxZZWwrdXFxRzd6Yzhu?=
 =?utf-8?B?ekJKRVFKM3hvRk5QTjlnQUlDbFNHNDVTbnhZTmlSODllRDlEdGt3RjJjOHN6?=
 =?utf-8?B?R0p6K3lPWndTYzJHQllSTlhwd0lGbDNXZHNhRXdma0lLa2tyT1RXSlVML1Yz?=
 =?utf-8?B?akVBWTdXVkd2NGhOZktZME1acENOdWY4anNIR3I0UUlkYW1tVUNhSjA4TkpZ?=
 =?utf-8?B?SWZOYTducmVlNEpEOWdVSE1mZjBDNkM5czlKSHhmVFgwWkhUTlo1ditNR3dM?=
 =?utf-8?B?eE9jdVBJV3hERW8yVXltQzV2YmFPUnFDUVB2TWdTWTV4WjlsNmw3ZHMxYnBn?=
 =?utf-8?B?SEVlYklYVTRqcVI0T0FRY1J0RU5zOHlnMnFybzBWQmFBM1Fxei9OQ29Ib2o5?=
 =?utf-8?B?NE5lTG82KzN3Vk5pcy9tdWF6c3R1TU9WcU9aRmhzbXVYVkhlajBweDNLbWR4?=
 =?utf-8?B?Nk9wUjBQaDJ0MlFRdy9LZzIyZ3kyQmFXZlhrWSttMG9xeEVUcnNmOFJHVUF5?=
 =?utf-8?Q?cn32VK?=
X-Microsoft-Antispam-Message-Info: Rblh9saW9Q313gCriHPFjvDv81rUyThlddLFS/igw2PH0TAJqFh/CRghoLRP/8ZkfnspusZMIOm7o4m74jhI+MuK+WVIRnMZb/IilZT5t8jqr6kO0rNS9iAdC3K78BPSBXnSlEv3CyOf3e3qRudMuqeQPNFX8JSqVDBYOPSGqup1bkQAS4jki17Aw6TI3Qhj
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1701;6:hWawdlzQSiFQgHm2UY4MsL20IEHiHzbwUn3E9ivxqUxjWz2gjbHnCQmURN2tyKBnSqE0l+1ROq349lhfX1uLO9Rdm+tUQhgH9q0PGEft+qfEsxhg6EBuJAmUE5I3fPtizEN7p1WhBTcqvaSnl5COWdpwwjiGXkt/nYEYlh6UHikxJIjGbJKK1cmngAb6WjCeoqctTgjQV0BhzuhOtoLHNuc0l/SoJZtWsTA/0OWkGmxgAz8R6SL4kbU0MD0S/YwsltreCJnNUgn2CnWvdgL4K1MJYB/dX23aN26ydGIvsxnGPOfcYgtknQcF/AvCySLNKnLChv+3LoQyRwNrrH7fg5N+e2BuX4wZI6MAIPiyCeKM+07mWCpp9Kol7lPHR8EW/FWzfPb9fzgQ+yMxL79Wz9ERILBSm40FmT6kFySEa9uf39+6tsBbuB8JbzuCuKOWIU/TqQ7M3Nuu2PBYVakQNA==;5:lsWNH/c92Be0oL9eugTe97pk07nuG/NVvEYRt8XZiMHMYuKeR1a7BCOIGoMNXmrJ7Qe/moXlFMwPNnxgO7At5knNV47O2/6NJQDOjJsO+SZcF+KoEKdnn8qr8VOVxg+hKBtaw5KLRvFBXnG3IoV3upIGDev08i58mLgx2iGzni8=;24:0bx40QS97aor72KMh5Jw3DUC+HB7BHn68TsjYNhS8K8xvqgdYsrgOs6ZGXf6W/po2GwYWEog7uSyooQtSBWGUxuqVjqNjmdXfrlHCm9trQ4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1701;7:jv1QBCHXMukUCb1RLod0nlAYEyaOQL3kT4it6mHVpy1UerTAFV9QQMghzSlpbhAOTQfrFkUFmEw7U5ropHnsZ+1FkA4UXpULq325E3b6dfoNb38HddXtdA79PDzMNZPf2LtyUCGxVHDgBj9ThaPnmI4EPedZrAYgY9+lAz2AGe8jcZjWsCzM/9MQ6Y+aGKMFfVN3deNN+UEVYVVh6JSVkU+cb/LMyno9NVWbVpyhO3MrTEGC1Uc0QyN44rPN6S8+;20:5akHs+von8wrmcNz2ymOwrp9ftSOT3B52OYrqB4TvaOti0O2tYbfaS+/VznVwkJWEMe1yK4dmf774tyWNQLTGQMfuDrt7yUCHBih7wAikE/ulSu2lvi0UQouWCKFYXCiT38EgjNSddb0ZUKhdKAzQBOgwAnSdPQJJrbz8mxdvU/DECBwXmgDNAv6jSsxJUhBmEddrGpUaj6AbwEtsvzGcODvRX90HWSUv8rNxP3GafNz1EQOBtoGK2WbEcbaYOYt
X-MS-Office365-Filtering-Correlation-Id: 54670910-0e09-41fe-427a-08d5a61d9a1d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 17:47:20.2976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54670910-0e09-41fe-427a-08d5a61d9a1d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1701
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-19 06:56 AM, Anders Roxell wrote:
> On 28 March 2018 at 18:04, Christian König <christian.koenig@amd.com> wrote:
>> Am 28.03.2018 um 17:53 schrieb Arnd Bergmann:
>>> Building amdkfd without MMU notifiers is broken:
>>>
>>> In file included from drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c:28:
>>> drivers/gpu/drm/amd/amdkfd/kfd_priv.h:584:22: error: field 'mmu_notifier'
>>> has incomplete type
>>>
>>> This adds the missing 'select MMU_NOTIFIER' line to make it build
>>> cleanly all the time.
>>>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Acked-by: Christian König <christian.koenig@amd.com>, but I would wait on
>> what Felix says to that.
> Tested-by: Anders Roxell <anders.roxell@linaro.org>
>
> Randy sent the same patch [1] and its still required.
>
> Cheers,
> Anders
> [1] https://patchwork.kernel.org/patch/10340885/
Yes, looks good. I think this probably broke when we relaxed the
dependency on iommuv2.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Regards,
  Felix


>
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/Kconfig | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig
>>> b/drivers/gpu/drm/amd/amdkfd/Kconfig
>>> index ed2f06c9f346..5a26acb90e19 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/Kconfig
>>> +++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
>>> @@ -4,6 +4,7 @@
>>>     config HSA_AMD
>>>         tristate "HSA kernel driver for AMD GPU devices"
>>> +       select MMU_NOTIFIER
>>>         depends on DRM_AMDGPU && X86_64
>>>         imply AMD_IOMMU_V2
>>>         help
>>
