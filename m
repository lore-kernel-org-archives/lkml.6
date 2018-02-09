Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753062AbeBIV4I (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 16:56:08 -0500
Received: from mail-cys01nam02on0046.outbound.protection.outlook.com ([104.47.37.46]:65078
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752953AbeBIV4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 16:56:05 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com;
Subject: Re: [PATCH] amdgpu/dc: Add missing cast in
 dce_clock_set_min_clocks_state()
To: Matthias Kaehlcke <mka@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Justin TerAvest <teravest@chromium.org>,
        Craig Bergstrom <craigb@chromium.org>
References: <20180209212834.72129-1-mka@chromium.org>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <95c4b316-ee97-d7c9-a9d8-f2a7e0daa9e3@amd.com>
Date: Fri, 9 Feb 2018 16:55:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180209212834.72129-1-mka@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: MWHPR0201CA0054.namprd02.prod.outlook.com (10.167.160.31)
 To DM5PR1201MB2474.namprd12.prod.outlook.com (10.172.87.136)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a06a2df5-82db-4998-48ef-08d57007ea45
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR1201MB2474;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB2474;3:zxVx/2pLWLk/PaZNfVj06vg9/bXM/STRq5R2E3t9eRuNANYwa/3MKYKOm7MKRrkAw7QvF32bMT/zWiuxFAi7vz6P0RP3typXli0h0tTs9+HgwhMAoL3u67ox+p0dwR43HVuZN5AZh0QDuFP3FU4zpzSzIyTHw8cFGKrdpJGH6dPjEXTi5WzAaK75LAYxYBVK2wNt1/+trBne6v+ejN96dwxwDd3ELJl4mIM+hve1MnHBOmBOZVnYIhKgXNdq3D7c;25:9rr5E6xVtNEnoluiaVNWjWMzs2RUNtNv30aoecOQzAsXmLNTP/oiaq7SV8Mfy0VoYcwMPUH/XkMgid9mgWNrJ6uAm962Kx1Z46rBBI+6+6bUinxefKJcVN07zt2OaAd0y3AhXhDgqekQNBdkQSeoKTLsa49PNKkB91F+7FCMz3unIjZTEFYqbZFVRgstQ0yG+Y6wqrNtijHNb0jcNIZNHxp6/1VLOxqq3rtcBV67dp8UwCmQaOvAirgtLsYSKjMbaPwP+t4HYmUkbtuuhsH+eH6Xg0TP3/TTjePTbC5RJK9oKmVE6K5p/D0w3ZjlhKIEh9vpxoDdMmNIUUlEDSk8RA==;31:k0i5Io6rgnh++i1HAdGtCgYBdUDFGeAyCrIg1R8nCW4IfW6FuGDggyer/9ChFmF+BQTd1OFFbdVgNPiCL0PBkBmAO8hibr+pgHmJYnK5dj/Iz6grii3xvaSjpZqHBjbczfC/yNnoV/KJBZ2AsG0/EZO3Eh1fvgGXoLVmdiNhQ2LPBy8ArFshpxFsYc+tamepHNzQlf7NWPHN7HaDxhtIZAq7DnrEhe/EPI0tM1D7VbU=
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2474:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB2474;20:ltJInr495I1Z93nbp5P1yG8M2TTDmLNXz56RWh3WTwZIktYAs/GJzgEBVPwP+AlSh3AQ5IJiWW8njppHgZsVQ410UXiNMFCJkM836NYbwzQ1nc72AnD9KNQbjrk46Z/MWTVRaTu9r1jjmHr3/3gOfY7VlvRWpYxf3Yv4KAh6KSETp2Vvew+eB/jtr8GfiHUYxkIOyz6Sqtfit8LgBwNjYBZYO0CArrdnScaO3afOK4Un233LD3t9vL1fjxsvNDd4/AMLQQIRjpcMmL3o2Tj69Od8Ta1CQAhBR7tX/Ua7h8NdJ+sJyhtdWpQdJjhrwIi0dbXTdHM6tsLI2atJGasTSdx8dlNUMUElJI9lPh5cBWu8Cn7BYOScYNrkxxThrjXJo2QXHNxyTKzEBtM84OLlGhiwGNlVWdO+0WvVf/pIdyvA3z3f+TfR+RXIU9/WfsmsdglcuoAbARQe9c6ptIjSGODgX9j0W2+90/ekdMNQfVJWk1nOebz2yEN+7QhH4gvm;4:z+Ze9Ed2Qb+eYZ53PCscJplqTfrVUz9v/DnD5+q6byhpNHFIGg8osijiIkJd/ab2wjXm4tfpvVGsuBsloIGrHw7peyS8Tk9Nk+QIrlITxaFn/4pVunxOkNcxjD6YvzyAY1GgCPWxBtoWCl25rfXpcE0ESaiVfJT/tRQpetty45hKe8vct98CddeUBnFktFlTiMRQ1yg4GFZI0mpH90cpWawGPHm9vqFGJpPPBo8/QMGQ9HG6Yi43n8eFZ5zKK0td1ynVjjkzDY8kMZkf7gJzsA==
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2474C8363D16D4AFF89E7C6E8CF20@DM5PR1201MB2474.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231101)(2400082)(944501161)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR1201MB2474;BCL:0;PCL:0;RULEID:;SRVR:DM5PR1201MB2474;
X-Forefront-PRVS: 057859F9C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(39860400002)(39380400002)(376002)(396003)(366004)(189003)(199004)(377424004)(105586002)(50466002)(97736004)(106356001)(7736002)(2486003)(23676004)(31696002)(52146003)(52116002)(59450400001)(53546011)(229853002)(305945005)(64126003)(25786009)(386003)(5660300001)(53936002)(90366009)(6486002)(186003)(4326008)(478600001)(86362001)(6116002)(16526019)(77096007)(6246003)(72206003)(230700001)(65826007)(3846002)(26005)(76176011)(66066001)(65956001)(65806001)(31686004)(47776003)(81156014)(2950100002)(68736007)(83506002)(2906002)(6636002)(8676002)(6666003)(58126008)(8936002)(36756003)(316002)(81166006)(110136005)(54906003)(16576012);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR1201MB2474;H:[172.29.157.161];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyMDFNQjI0NzQ7MjM6TDJrZmlpeHF3UmlWTzZhWWxLZ0tHby9r?=
 =?utf-8?B?ZEdsSnhISEdVSzQ4cE92NmFIaVZsYmQ3b0U5eDVmbTdGV29OZXlwVU9KZ0Nj?=
 =?utf-8?B?UGpSeXZ6dVA3b3hIYUtBZnJmR0l1cUN6bnhnQ3VYUFN5NVpKOWFZQWlOMkd5?=
 =?utf-8?B?YmF0WFZjRUc4YkRaSi95czNQZWZzSkR6cS9pVjdnWHJWY2FLYnBJSUgyRnJO?=
 =?utf-8?B?MElqSmVydGRvSkRlWFg4T0RWWE52WTFMNmUrbjZpbGpGanM1VmlPQXgvMkRy?=
 =?utf-8?B?bGsyc1dwaDRIUzZ5RVZZUVRtVEhnclZkWmQzeWFOTk4wT3g3V1l1SXI5YWdl?=
 =?utf-8?B?Y0ZxeXNnYzRxeVVOZ2RuUzR2ZHp3YUVPWEZVcENOZ2s2Q0R6TjVCRjVPY0tk?=
 =?utf-8?B?aU9ZbmxWVG5ld2pFd2FyY25TeVdXa2ZzZm5YR1JoV1EvL1YrbWgzUHdpTVNU?=
 =?utf-8?B?MEpzOGlGUHZDdmFDRmx4TlVrbVM3blRkTVhhSHRVcGljcmlZb1NXV2ZmblhD?=
 =?utf-8?B?WW1iS0w0TVUyKzI0a21IUHIycjJWYlNnMnE3RTIwNEUwUzJoMXNzUkZJYlB3?=
 =?utf-8?B?ME1DZHNUdkFxRlhMaGdpM1V4WEZnekVXZHhRR0I4V3pyaDIxbVRRUjJPZ3VT?=
 =?utf-8?B?WHk3anJhSjNBNDNVMHJwdTBaTGlSWnlndzNPL1ZTR09ZY0JXV21SR2IvNGRv?=
 =?utf-8?B?Njloak5vc09mZW9TWXlzMDZUa1g5VFgvMTl1UDlSZkx3N1ZnUFRjcWp1RE9N?=
 =?utf-8?B?OUwwcjAvTHJGVEVSTGwyaTdjdUlSM2svNEVsNjV0c3IxaFFHN2QrY01Wbkk5?=
 =?utf-8?B?TnRldjVoNXM5dTNKcS9xU3pPWVJWSTRyTHQ1Rm5PSDQzaE5rWjdjTEkvZ2Zy?=
 =?utf-8?B?TU8vTUhObzk0a29iLzFtTTBUWXRmT0tqL2xOdjh0SnQyZ0hzZjZmay9sVzk1?=
 =?utf-8?B?Z2xzWmpWUlB6UGtxRTNWSDZ6VU1pWXVJdS9TRjZXUzNtQmpZN00weVZPZDZ5?=
 =?utf-8?B?dW5hQ3d4R2tFL3BZd1lkcE9zajZnRUgrcHlGbWJ4bjFmTkVqaTlUeGlxYmtp?=
 =?utf-8?B?VmhmbllJbWZKQU4rWGFQT3d5Nm9RTGdpVVZYWGJJa3ppUTdEVC9TNHRiQ1Nw?=
 =?utf-8?B?YzFmaS9YLzMwL0RVSDcvenRJR1hDRW94ZUEzMGRhOFBiUHRCbW5yQm5FdFcv?=
 =?utf-8?B?NkM4K2ZiWXZKdnRKZ2VFOHp2Z3Q1bkczRldHNFhydW54THJPMWYxRFhYY3JW?=
 =?utf-8?B?dERUVVFRZER1UExUU2NBMExvcGZ3NHlJMkhNUCt1SndaSHBxZWVpK0FFaFhX?=
 =?utf-8?B?RUp1NkdTZnJaUWxGalNZZmtva1BScFF1aFJWNkRrSWxKdnI3RDFsdWc2S1RT?=
 =?utf-8?B?T1JGMVZDSXlnVmNKOEQ5ZlNnQlpUb1UxZ0loRUg3UTIxSlY1TlRmU3ovUmhY?=
 =?utf-8?B?a3BSWllFSU9kcnpaY3NCUUFjTkJIc1hKbmIxQkx1YnBmakQxV3k1NURKTFNZ?=
 =?utf-8?B?WlRWTkNRUTQyNXVIRUJLYjdjWmRMdllybHR0bFFwUWFMWUVEK2FDR3hERXBY?=
 =?utf-8?B?WjFWK1dINTBHd3hsMTN5dlJUdk1sdnI5bjB0enByR1BvNXg1Vmh2MkNJdFBJ?=
 =?utf-8?B?QmVKaWdZWHRDZFprUHJyQUlpZFFtaVQvREp6S1Y0TFQwanRVVUZURFR2OUU3?=
 =?utf-8?B?aW00VHBXWHlOUFBvYXhhb3NSV0N6cndzengrZ1RSaStBbzZaakxvcklMUkhz?=
 =?utf-8?B?QmE3NHorQnUyemkrOXJkUWtaK29hMkFWVFdMcnVBU0hCY2grd1JOME5lNGFl?=
 =?utf-8?B?R1VhZ2daRlllaUIzVGVQRUlNRmM5UnE4SDlWNjhBRCt3VVBjN01BTHdPSmFP?=
 =?utf-8?B?Q0ZRRzFXQ2h6ZGY0d3duZXBnSjN5NDNIek1palA2TW9na09hbm03RDRYRnB6?=
 =?utf-8?B?TDMyY3FVYVZvWXlVWUg4NVR2RHFaYlFGMDM1VFdpb2V6aXlHbW1NSmVQODhM?=
 =?utf-8?B?eUxBZS9SZlh3SFFteUVZR1BFTEEvZjByZTkvUzRRPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB2474;6:+zLA6I/piWc45XhiJflxeqApGMGWOgs0N9Y4hCb1tvJ5uv3aBup/Nd0zb5++PGA7tlbO2wDYWwiwjit7/qLLhutBzxaRPONZuLAby30JKphwozwFwr3h/+1AfJTCKRyd4ajZOgr8Obh1zRABsxDHVmdsgkcLl35FnubDtwa27PFRJRLw6t2wr/R8IVKPpDDNBmhIIKMJEg7+kJSg1O8UrtFEv0eealrEurY+O8pdxspq0KKCa75wmWsI1+doXiHrOCDwHKEEkKhAAxN6vQuo6Iwq54EldQmj4xRQsQjv6lMawau2m5rNzFKVp7rQctab7hTPDfn8pm3IO/ix9TFCDo0oLiBy4LqF6ubXflMMP8Q=;5:nwMcCSy2LLbUVuwc3mlVue9701PhD+7LHimkGC8p5uXNZb4c4Ii29nGRGmONl4OQ6DtHMWyzzShBEdtx+rsmxUbaN2rRDprNfa9GHbIg3wUgQldCscMM7+/UbM3973sRORqMnU8z0BeoHqe2mmnZpNGxjZCvpFrcMVM+aZeG4D4=;24:mPORZKtsDX3H8dfG0GpVZkdPDtjn/DkTj0sVLe2IZLMfvp3GphqEGVTDVWEM8bJjcsFUuCuKvqn3DvgLKTbiu2zwHRpdKH7baGRo2AYakqw=;7:vWhcEkUkIXRiJ3JjOQrVi7wKx5gy74zO3VkpWfcNfT1moMDoig6G6WovaYuI1Ycm0lCgV2ovCx1f92BK4FfSuAcpH+4a/JHsTBz3yazw5D8qTy68GULJ8f8qXIgGsEzbwklfuMAwIOFr3gV8N0EdjBHJ78hsq87ffIHgb8G0lu16kx6zm7mDNLCy6FumimQ5pljycbH8fiQM4/d6lKpy8fjvNwE7VFvm2bsRoKX1YD2p7JOkJYzGsx4DOVoNr29L
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB2474;20:Vu4G0peQStyyHwuHUcQUyh7qwxQiCnX39zkQdoFPrXfVXwvx4p5I+8OXlk8IPUH4z5DfM5EuRUxyl3UWsrfOX8eX+9uKOSQ8yhdRVKUpplMsxHrxLXx5b4XRh0LudktvMnldEkaeWjSZMBDZ6J8D6Gu2SmlHoBtDcauDHWKoc0JcW26M8fDU++oaUAG/EG1MWMEdU77+x2N8WRjilSVKOI0KpaACE1DQyE84UAZ+Z1YKibt5AKvpj3/cWtAwMYRt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2018 21:56:02.4973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a06a2df5-82db-4998-48ef-08d57007ea45
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2474
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-09 04:28 PM, Matthias Kaehlcke wrote:
> dce_clock_set_min_clocks_state() assigns (intentionally) a value of type
> 'enum dm_pp_clocks_state' to a variable of type 'enum dm_pp_power_level'
> without an explicit cast. This causes clang to raise the following
> warning:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clocks.c:308:4: error:
>   implicit conversion from enumeration type 'enum dm_pp_clocks_state'
>   to different enumeration type 'enum dm_pp_power_level' [-Werror,-Wenum-conversion]
>     clocks_state };
> 
> Make the cast explicit.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
> index 9e98a5f39a6d..db3ceb283255 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clocks.c
> @@ -304,7 +304,8 @@ static bool dce_clock_set_min_clocks_state(
>  	enum dm_pp_clocks_state clocks_state)
>  {
>  	struct dm_pp_power_level_change_request level_change_req = {
> -			clocks_state };
> +		.power_level = (enum dm_pp_power_level)clocks_state

Thanks for spotting this. Looks like both enums are exactly the same so no need to keep both. I sent a patch to remove the dm_pp_power_level enum to amd-gfx and CC'd you on it.

Harry

> +	};
>  
>  	if (clocks_state > clk->max_clks_state) {
>  		/*Requested state exceeds max supported state.*/
> 
