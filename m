Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751488AbeFEGQz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:16:55 -0400
Received: from mail-by2nam01on0071.outbound.protection.outlook.com ([104.47.34.71]:7414
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751619AbeFEGQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:16:50 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH] drm/amdgpu: Grab/put runtime PM references in
 atomic_commit_tail()
To: Lyude Paul <lyude@redhat.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>, Shirish S <shirish.s@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180604193509.29153-1-lyude@redhat.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1a4e687c-f5f4-4716-0461-2b549f17fdc6@amd.com>
Date: Tue, 5 Jun 2018 08:16:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604193509.29153-1-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: AM5PR0201CA0013.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::23) To MWHPR12MB1725.namprd12.prod.outlook.com
 (2603:10b6:300:112::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1725;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1725;3:bt4C4xqH9KNSp7nt28xxsUkgIyKJzTDc4caM5OwR3w7w54an5EBiKAdHoYNYo1Kt4QCy65L3DrWaJ0ccBDru42acsxLeCxeakZNLnL+atRMBIcwEl8ojW4BTqa1FslcqYnEvsj+iCb6XrRgUIOmRn0EAAsLCNNvw0ltrn76zzWNqIYW7f+LR5lrhrOWLrStsunrZCw8noZK/EUk6HJ/VRlnGoQUjFolBegu/nOfgNi3uzRoxXiu09oCw4Mnnzmrr;25:t5ovQsdcy+hGNx6o/S2B+d6TFb0OrPMg5cyloOrv0I2TcDj9XwkEaC7CrUvlPAa28JPCc4MtuxReRgNi2a3K5Md1HSr0NFPPyQmJEMSHlXTzyRWulbCw3DNft7HGenPviOtXzJwV82ZEAyT6GBf1YCLw22nhk4NhV6mDfY6w9VTb/7yjVj5PXzIJLnnPUjeEMTxWBRaPL1Ek5pTzbQhJFuAd7ZNkTFixYAX2KRTkOBnECq4iuVG3u91NhAJVW7hNTQexUDmvQAI1wVfMOgLYdnhGitLHoz24HohGqtH1kEkWpsBgC1euij+VJ6lGXNFdGFEnJUIMKu+EkFjvZnjXjA==;31:0QVp2qdVGdYWUuXhst3Jp+gAdDFRTrlVF9uJAY7gN9vYBI70QnpI72s1L+6lkbtiWKv3CRxM+rR+BLGE+ymw//Kx9+9sk4ieL7n/0eGFh+7+QB8XvEJectg3J63Y+wIBUVC/27m0S8PDB5BEc1lBEtLs126cALcwnf42csIw3bb6+vFnj9uU9C7TzAQvABXu9fggEkZDhIzOqvbqkL8U0i+sBPWvGCBSlCBXLAbInh0=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1725:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1725;20:fWWh9LgsO2WzGb3g+9ltLysyjra9m8BXKFQMWMScaDTZX30d1Fd9dvzUCFfZSCbM57+8Y70t3Ani2rMWODRR+LNvuD75kt2GTHEMFUxAGWanafj7g7BE6L8olN7SFrPPk5rkv/dQTBlFr056/zek72Ef6x1TPEPQBfz5HS6okMzzYYXMDnhJIgzR2laP4iRYx0HbT4X2jxhuHyna0e8xSHaLgf0w31AJ+RH+uaEsq+E0gUgnxFauRLf6iYZXgFUHkJwtbJQalDsRQhLU23Yf5ZSsQt6ltTqv5t43ZFPxYJAHbTg/Qk72Yx8YpcUzuz2nkqhJzN0noR6Jo2WCcDt6glC7/z80bP2BLHy91CeXN4gqnm1epnf16MrYehaTgtnIW6F8fQmisHn3XvzjPfPEp6dtfpzqAsUIFC8s+nxpYIxQCLfqvuUNtKo3Lenj+BHx0V0D6M6MIUQ0v0uhNaEV9beP1CZ3WahGWUywtLeU6HCmKgTLGUpTFwi0aiPQIgOy;4:3iWfYmqkZy1xyf7rnhw2JJvOCvlXQ5Nv9ib06l62fcQw8LTSWAOeGWoWZ4E1PJHsIkcpekh8IZWqu8woYiLmj7ceTUtrIDs8/vWK/hMkCrksBQyPRGGjrSPi+lydSNMFIGGL6xg3UhMpDRzQhQ2luUOuWwYff+hKZDeTA5Z090rYWEHH4VfTqh87xvOV8AmhGbxEF+F66rGtUJPtKSsC4/Y0UUqaqjONpqPHDchlDvu0WeLbZ8sj2WZ49cSkNDVV3VunwuNOk2uiRZbPYDNc6kN4AyIp0PpTgW9Z3ZG1Mw6vR3og0QwwNp0uxaX9YiPJ
X-Microsoft-Antispam-PRVS: <MWHPR12MB17257C78C954A2BA3C0F4AB283660@MWHPR12MB1725.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR12MB1725;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1725;
X-Forefront-PRVS: 0694C54398
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(396003)(39380400002)(199004)(189003)(478600001)(65806001)(305945005)(386003)(81156014)(54906003)(6666003)(81166006)(72206003)(229853002)(6486002)(5660300001)(67846002)(65826007)(68736007)(1706002)(65956001)(186003)(105586002)(59450400001)(486006)(6246003)(16526019)(316002)(7736002)(6116002)(50466002)(58126008)(2486003)(4326008)(52146003)(8676002)(97736004)(52116002)(53936002)(36756003)(31686004)(8936002)(106356001)(25786009)(47776003)(2870700001)(52396003)(23676004)(31696002)(11346002)(2616005)(476003)(64126003)(46003)(86362001)(76176011)(2906002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1725;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxNzI1OzIzOlR6ZlpPaVpDUU5FNndpR29mOVdkNjBQeUZN?=
 =?utf-8?B?a1EyOFpLZmVjWmhwbjhYdFM3VTF1cTNlbGZEMHVhMkJKMGlvRG5VR29rSi9U?=
 =?utf-8?B?NHBUWE42NUxVL1JzYzF2YW40Q0gvc2RROVRrMGZIU3lJNjdpNEpvdXJVTUdj?=
 =?utf-8?B?bUIzeGVZVEozc3VlZ2pnaWV4cHlHQllTWFZSY01HZzgxWHNOcVo1VitxN3h5?=
 =?utf-8?B?R3JHM2tHNHJBYXRlNzZlSDZPZ25wOERMY00zZUFoYTFuZ0lMbVMvNUpkdXY0?=
 =?utf-8?B?a2owMk5rMHZaMThndmNjN1h0T0g3OGhlLzFXVllIWUYzMWVTVWRGajRNbmJ2?=
 =?utf-8?B?Mnl2K2tDWFJFcUdZbHp4WmpQYWl3SmZaTkg0WmQxL3pCN3oydDlYZExaWTNX?=
 =?utf-8?B?cldaWEtZRlhneDVBd2VMcTEreXNzMHVRNHlRbEpQRVMzNXZlcWhoYnZBN3Js?=
 =?utf-8?B?SGFsakpoZC9nbVJOWmF3NUdYclhmQkR3OVF4NHVtNExzL3VVU1Rpc2E0OGZp?=
 =?utf-8?B?Ui9JVzBaMjBkZncvMlZudTZzK0VmSHc1bE0zQW9PRFNDVENPL0tlOG1Xb3NS?=
 =?utf-8?B?ZmIxZ21JTHJrYS8wVUF1dE9kQ2YxZTFITlBtMEFyMjFqZGU4SzFuYklVWHpT?=
 =?utf-8?B?bEkvazdFSlFPYWVNQjBxbVI4dXAvTnovVVhESFRMNTNkRVMxajRadVlublNZ?=
 =?utf-8?B?VUtDb3pVNVlXTGJsMTJGTzNMbDV0NXRlVFlLQWZrSnN1aVcyYmJpc0c3Y0hu?=
 =?utf-8?B?bU1ZVk9tOGZxOEhZMnRJcVhVNzdpN24zM0YvK0t1M3FhWDlWemJ4V21oUlc2?=
 =?utf-8?B?YlhPSERZVDlrYktYVFl1eFkwRXU0MWZlVFVZd2Z5bzNOUXpZN211TGhjT0N6?=
 =?utf-8?B?ZmZScUZKS3plUDVVdVRCdy9IZjhaazVMRXAyNnNBQWxzRGdLSmltcVZoSFBt?=
 =?utf-8?B?eGV5bDdpd0hwVkNLanA2YzZxWFFndlBlMkJkTWJuRWlNek9aa1QvdzZLRUhx?=
 =?utf-8?B?Vkl3K0t0aVUxeTJ3LzY3OWNRWndaUzZkZjVmWmpxLzF3SnRmb3NEOVlSczY5?=
 =?utf-8?B?dGF6Z3FHRGNmZi9UZWMzNUtmZXliM1ZZVDVSZk5WVXdaem0wNCtKWE03TFpH?=
 =?utf-8?B?MFhEK2ExS20ySWJFZ2FMclBHdzdPdWpoMnh6b0d4Y21BZjlGdExtaVZMRUFt?=
 =?utf-8?B?VUlacEdjbXVPOXc5ZnA0dFFyeGY1ZnllbmhRa1k2bWt2SmRTL3RqNEg5UEg0?=
 =?utf-8?B?WHd6S2s3eWR3dlZCcWVSUHBMRTdKeFFSelY4djdNUndWUXBDQ3p6bG5tamtT?=
 =?utf-8?B?Q3lYNCtFNUZvaW9lc2E3d0QrNTQ1RHJlcmtwSlUyc3lkM3hCTWFYRGMrMGkv?=
 =?utf-8?B?Mm5PZHZ6bDJPOHZnMzZFb29YVkR0R1Y3Q041WHBualdtMmR0NEpZVnMzOHJx?=
 =?utf-8?B?c2VnUHovN1Y4Zk5XcUZ2NTJUdytSV0FMTDljTlZ0emU0alNKVFJhUEpPTVMx?=
 =?utf-8?B?NUhHdXF1cCtOSWMwTTgxSlB0SFVWV0w3RHRBUzVMN3RLTW4wVHdrSkl4OHUy?=
 =?utf-8?B?WWwxRXhCeVprK0VFTnJTZllvTURFYWFDUXFpaXhKOXZoU2hZL3BYQjZpbGUx?=
 =?utf-8?B?UzBCMUltQ0c2eWdoaU9yVGRxUXNhaFlwb2RSNHdhRnNKb3J4RnF2dUY1cnJs?=
 =?utf-8?B?cXdjMTl6Z1JjRndiZS9ESGpFczRKbnovc3k4SGZmVVYxaGhraHZhUzVsK2l1?=
 =?utf-8?B?dUlnaEl1dGdJWVMrMThtRlBxUXl5TU5VYVFzdU5pcnp1d0ZzMDBVNFVTRUd2?=
 =?utf-8?B?QUF2N0VlVUUzcnVRMVNMNXV4WVRZWm9TNmVKWGZDUUdNc05NbU0rZHVnNTZZ?=
 =?utf-8?Q?0L9E2B0vDYR7pkoI83bwd7J/nAbiY0Df?=
X-Microsoft-Antispam-Message-Info: e/bI8QJ+Gij5Szq/7BxMY1ujyoWlkP6HQTPvlyrOHYeaL+yPNuJxzNe1zIg3duBXy+UQoQ0/o3D3NlTPGyXQqRTcLrhZW+K+uvo1ZqLuHu0jrVZ2dEx3T6/AMu3hym7m3oN7VWzRamt782kuh0/LzMCiHrE9/+vhcX+JR1ZlJeNnwgB8ExZasYXgYc0QZErI
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1725;6:6VWesB+39RUDVnc+yVziXfE1Xi0wVxlIwDF9pVgFfkZ/D001XMxNXVboTSvVFF/EIwuMXUwpRQeimQpTXpkiZin3tW5eHZwkQ5Y2xXeYJyvaL+zG98goLTxavbescKDBqyz97Ca279NLbo7bE9AOKk5276IZ9uytsUrc1jOm8X9Aw/2MbcHIuNSmOPF/awUdMjc8lMx42aMWWpjr2ra2xpcRNf0T5Lmi01QnbRRiUo06jfn+BQxnZ+MRYctOre8RqH8+pfv6KfQHor2uadSTOOKF6EUMWxVEFqzKmnFumSvooJePUZdYB8qfjtgZ2obyDjBGsNRfylHUgahUOz1YbyZpqZ2L68tZzfFIZm4Ezg6vRjuWSknJPaMG+OwUiYIOuc8ksJzffB7fkAK9A/QuzOWFQWJZV4HILWF4+oaJ+J2N37XG54OCSctcxw7PCrDlFjtcREGdMN2h2aH9ODTBDQ==;5:AevLp/BB8ASyapx/drmAk6Ehovcwqgb3HraTUSBPRzgkzqC8tlfDpQWFNBlC6qTAFI6bba/t0ILbR5s0pJ//k3R2TaON+8EiL54rTsQD0r5EInhqym9kcT1K9zODfcH7Sx4HNIbvx7B0+X0wkQBAFlr//cnbOxxsvxNp7usiPI8=;24:Q2aPjsnqog3M0WtERi/gIFInu37Z3Flz+yppXXz0cH4bS7O+inbyRU9E9hukR48PGFsHSS4XoSjYwotAOmoAYyEcokKMHVksPS6IuQZ1Trs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1725;7:bZeLCuKFl0wKy8h/lBebHygEixsO1gRvgQIUCznPbBlJGeqcj2eCJsMKDKd9g9QCiBdjHDZvfuS/PShdViqJb+1v5/zfN//0F1PPUinFSpYrcj64bFj4HzZmCZz9C679bnm4ne7WiVd2zMlE4MViYRC5DFJoUxQZ1ToDPUBFIx3LQMyif2IHKQkt4fwFL4XiPbqpQLvTFEhdm8myfeVNVSWBiri1g7WhQW1PiE1WpSt3ySHCW4GmGvbSzayTBKGU;20:VcRi+vLSS12LNyb52nHWEm8oW6DPdnEmT2bWhxK5tMpwsxWd5sd/lZVVbVIL0UTsRQ8MBKP/5GHmIcQtgoqLX+1rG6q9HWJiRW4KaTHvLa3qMTP6NWdtlH4/DlHrubrROLBjOOM5giYFgX1OST8N/MiR2ukDjJZzdj6g8I17mZgYREUieDmoFObdzaY6JxKzwlfJ5jD5z2wgHSx5diqzvTF7k1xFyHU8oQm8gviit0iH0KMtht9Xswsj6H1sRG8G
X-MS-Office365-Filtering-Correlation-Id: 26e8d48e-54d4-4ece-0f41-08d5caabebde
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 06:16:46.2897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e8d48e-54d4-4ece-0f41-08d5caabebde
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1725
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 04.06.2018 um 21:35 schrieb Lyude Paul:
> So, unfortunately I recently made the discovery that in the upstream
> kernel, the only reason that amdgpu is not currently suffering from
> issues with runtime PM putting the GPU into suspend while it's driving
> displays is due to the fact that on most prime systems, we have sound
> devices associated with the GPU that hold their own runtime PM ref for
> the GPU.
>
> What this means however, is that in the event that there isn't any kind
> of sound device active (which can easily be reproduced by building a
> kernel with sound drivers disabled), the GPU will fall asleep even when
> there's displays active. This appears to be in part due to the fact that
> amdgpu has not actually ever relied on it's rpm_idle() function to be
> the only thing keeping it running, and normally grabs it's own power
> references whenever there are displays active (as can be seen with the
> original pre-DC codepath in amdgpu_display_crtc_set_config() in
> amdgpu_display.c). This means it's very likely that this bug was
> introduced during the switch over the DC.
>
> So to fix this, we start grabbing runtime PM references every time we
> enable a previously disabled CRTC in atomic_commit_tail(). This appears
> to be the correct solution, as it matches up with what i915 does in
> i915/intel_runtime_pm.c.
>
> The one sideaffect of this is that we ignore the variable that the
> pre-DC code used to use for tracking when it needed runtime PM refs,
> adev->have_disp_power_ref. This is mainly because there's no way for a
> driver to tell whether or not all of it's CRTCs are enabled or disabled
> when we've begun committing an atomic state, as there may be CRTC
> commits happening in parallel that aren't contained within the atomic
> state being committed. So, it's safer to just get/put a reference for
> each CRTC being enabled or disabled in the new atomic state.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

The final decision is with Harray, but at least the explanation makes 
perfect sense to me.

Acked-by: Christian König <christian.koenig@amd.com>.

Harry do you want to pick that up and push it into our internal branch 
while Alex is on vacation or should I do that?

Regards,
Christian.

> ---
> As a note, I'm not entirely happy with this fix and I wouldn't be
> surprised if I missed something while looking through amdgpu. So, please
> don't hesistate to suggest a better fix :).
>
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1dd1142246c2..361b81ef6997 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -46,6 +46,7 @@
>   #include <linux/moduleparam.h>
>   #include <linux/version.h>
>   #include <linux/types.h>
> +#include <linux/pm_runtime.h>
>   
>   #include <drm/drmP.h>
>   #include <drm/drm_atomic.h>
> @@ -4211,6 +4212,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   			if (dm_old_crtc_state->stream)
>   				remove_stream(adev, acrtc, dm_old_crtc_state->stream);
>   
> +			pm_runtime_get_noresume(dev->dev);
> +
>   			acrtc->enabled = true;
>   			acrtc->hw_mode = new_crtc_state->mode;
>   			crtc->hwmode = new_crtc_state->mode;
> @@ -4396,6 +4399,16 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   		drm_atomic_helper_wait_for_flip_done(dev, state);
>   
>   	drm_atomic_helper_cleanup_planes(dev, state);
> +
> +	/* Finally, drop a runtime PM reference for each newly disabled CRTC,
> +	 * so we can put the GPU into runtime suspend if we're not driving any
> +	 * displays anymore
> +	 */
> +	pm_runtime_mark_last_busy(dev->dev);
> +	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
> +		if (old_crtc_state->active && !new_crtc_state->active)
> +			pm_runtime_put_autosuspend(dev->dev);
> +	}
>   }
>   
>   
