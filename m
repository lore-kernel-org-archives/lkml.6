Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751226AbeDXQU1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:20:27 -0400
Received: from mail-cys01nam02on0075.outbound.protection.outlook.com ([104.47.37.75]:19091
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752473AbeDXQUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:20:20 -0400
From: "Panariti, David" <David.Panariti@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Switch to interrupted wait to recover
 from ring hang.
Thread-Topic: [PATCH 3/3] drm/amdgpu: Switch to interrupted wait to recover
 from ring hang.
Thread-Index: AQHT2+GBbg9vSzZK6E2CBnt82gNLC6QQD8FQgAACnICAAALF7Q==
Date: Tue, 24 Apr 2018 16:20:16 +0000
Message-ID: <DM5PR12MB24408FF7C780D95307FB2BAD95880@DM5PR12MB2440.namprd12.prod.outlook.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-4-git-send-email-andrey.grodzovsky@amd.com>
 <DM5PR12MB244017F98FC732EB5DD86E0395880@DM5PR12MB2440.namprd12.prod.outlook.com>,<b4309ea4-c1a0-5811-040b-4390ce6f297f@amd.com>
In-Reply-To: <b4309ea4-c1a0-5811-040b-4390ce6f297f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=David.Panariti@amd.com;
x-originating-ip: [65.223.155.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1324;7:R4r8djNh/QcE5oP6hNDpCNqCT/sKzwDU4BSnhQabmaEBN9NrAilQ1Z4/ZQO3bZYr/7MRStJC0/kpWLikaBznx36wogBv3x5cZYxE+hVSxL6aSryUWJ099Cg/lMNt3+OeXW3evKx5+TwyksGGUSMrWnUxImgKrOUsnISJ01VZpE19OFoXEjAOxsXN2Xzy4CzTKEUpFqWGwWiJknvYWaUEw93q8E0ShMq1Vpimc4XqYK07J0RinGEocGMKbRUalO56;20:jj9c1J+IWzKIlUADn8CDcrpwmIr2Y+yWi9hTQ6C0cb5KwLpy02jyzqgurMwoq67jlQMhCyo9jJvmsFkFayQziLaEpEaU19L+e0lUf7o1XXviSWj1ByQq4Cm571N3SxJn7lBqnOYRCI73VPkmPKPT3zlRZC51gU6NihK6ZBHKdBsUR/hxmR18kagYJLVVnHhlY+a+XYyMUgm09ZKiU3WpsgxeqTcn1u9u0qG5Vb3n7HHAX01iull6KyN4Vx5JfIIt
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(396003)(39380400002)(366004)(39860400002)(376002)(189003)(199004)(13464003)(99286004)(2201001)(486006)(110136005)(25786009)(54906003)(105586002)(229853002)(3660700001)(5660300001)(2900100001)(316002)(86362001)(68736007)(446003)(74316002)(7736002)(305945005)(4326008)(6246003)(7696005)(8936002)(33656002)(6116002)(3846002)(11346002)(26005)(76176011)(476003)(53546011)(59450400001)(6506007)(93886005)(55016002)(102836004)(53936002)(9686003)(5250100002)(97736004)(8676002)(6436002)(81156014)(72206003)(106356001)(66066001)(3280700002)(2501003)(81166006)(2906002)(478600001)(14454004)(21314002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1324;H:DM5PR12MB2440.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1324;
x-ms-traffictypediagnostic: DM5PR12MB1324:
x-microsoft-antispam-prvs: <DM5PR12MB1324A6718523505013671D9295880@DM5PR12MB1324.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(217544274631240);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231232)(944501410)(52105095)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR12MB1324;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1324;
x-forefront-prvs: 0652EA5565
x-microsoft-antispam-message-info: AwxxkIzVVwIeb1ft3KVqfcL0E1wHux/pndxIgwBgQIrVcROUAW+pFicpe9eHffxBM31ql9HsR4S+2rIVY+554PwJHEGerb1iX0rSZTyWpPzhsHdTZ05Xghnp92gUVftpg6Fd0uY3eWaSKxs+O+3lmBAOjXiqtfr59V49MQ3zwE3I4kJ/SmjAE1QgkoHnrIn5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8b22c993-1709-453f-bcc2-08d5a9ff4431
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b22c993-1709-453f-bcc2-08d5a9ff4431
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2018 16:20:16.7251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1324
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3OGKWDV016119

> Kind of dma_fence_wait_killable, except that we don't have such API
> (maybe worth adding ?)
Depends on how many places it would be called, or think it might be called.  Can always factor on the 2nd time it's needed.
Factoring, IMO, rarely hurts.  The factored function can easily be visited using `M-.' ;->

Also, if the wait could be very long, would a log message, something like "xxx has run for Y seconds."  help?
I personally hate hanging w/no info.

regards,
davep

________________________________________
From: Grodzovsky, Andrey
Sent: Tuesday, April 24, 2018 11:58:19 AM
To: Panariti, David; linux-kernel@vger.kernel.org; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander; Koenig, Christian; oleg@redhat.com; akpm@linux-foundation.org; ebiederm@xmission.com
Subject: Re: [PATCH 3/3] drm/amdgpu: Switch to interrupted wait to recover from ring hang.



On 04/24/2018 11:52 AM, Panariti, David wrote:
> Hi,
>
> It looks like there can be an infinite loop if neither of the if()'s become true.
> Is that an impossible condition?

That intended, we want to wait until either the fence signals or fatal
signal received, we don't want to terminate the wait if fence is not
signaled  even  when interrupted by non fatal signal.
Kind of dma_fence_wait_killable, except that we don't have such API
(maybe worth adding ?)

Andrey

>
> -----Original Message-----
> From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Sent: Tuesday, April 24, 2018 11:31 AM
> To: linux-kernel@vger.kernel.org; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Panariti, David <David.Panariti@amd.com>; oleg@redhat.com; akpm@linux-foundation.org; ebiederm@xmission.com; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: Switch to interrupted wait to recover from ring hang.
>
> If the ring is hanging for some reason allow to recover the waiting by sending fatal signal.
>
> Originally-by: David Panariti <David.Panariti@amd.com>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index eb80edf..37a36af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -421,10 +421,16 @@ int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx, unsigned ring_id)
>
>       if (other) {
>               signed long r;
> -             r = dma_fence_wait_timeout(other, false, MAX_SCHEDULE_TIMEOUT);
> -             if (r < 0) {
> -                     DRM_ERROR("Error (%ld) waiting for fence!\n", r);
> -                     return r;
> +
> +             while (true) {
> +                     if ((r = dma_fence_wait_timeout(other, true,
> +                                     MAX_SCHEDULE_TIMEOUT)) >= 0)
> +                             return 0;
> +
> +                     if (fatal_signal_pending(current)) {
> +                             DRM_ERROR("Error (%ld) waiting for fence!\n", r);
> +                             return r;
> +                     }
>               }
>       }
>
> --
> 2.7.4
>
