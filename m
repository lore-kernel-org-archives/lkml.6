Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbeDKJR0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:17:26 -0400
Received: from mail-bn3nam01on0076.outbound.protection.outlook.com ([104.47.33.76]:14080
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751921AbeDKJRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:17:19 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH V2] drm/amdgpu: limit DMA size to PAGE_SIZE for
 scatter-gather buffers
To: Huang Rui <ray.huang@amd.com>, Sinan Kaya <okaya@codeaurora.org>
Cc: Tom St Denis <tom.stdenis@amd.com>, sulrich@codeaurora.org,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Emily Deng <Emily.Deng@amd.com>, David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org, timur@codeaurora.org,
        open list <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, David Panariti <David.Panariti@amd.com>,
        Jim Qu <Jim.Qu@amd.com>, Roger He <Hongbo.He@amd.com>,
        Monk Liu <Monk.Liu@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        linux-arm-kernel@lists.infradead.org
References: <1523394001-4615-1-git-send-email-okaya@codeaurora.org>
 <20180411062602.GA29109@hr-amur2>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6f99b01f-2f3c-7263-9df8-f8a73f4a9372@amd.com>
Date: Wed, 11 Apr 2018 11:17:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411062602.GA29109@hr-amur2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: CWLP265CA0027.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:11::15) To BN6PR12MB1713.namprd12.prod.outlook.com
 (2603:10b6:404:106::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1713;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1713;3:klfUDSfi9bEGunIKXLRhXUJq9wPEJwrSrQguuTEvURRm7MwFC83/W15demvjk88Ck22JG/at7/VZZlItGxpjbVAAHQkpM40gW3n6zwsYBEQsy5hTrNF5ThPYTXSBlSkdFTAaMItLuBlLvKaZlO5s204aF6QzPAo9lo8ESqO5OEW0YSFrcSe7bkvH4owbxYYVyzPyBJAfKn0GTErASCLHgLqSZ0FNqlxZ2wubrnAEkYijSAgagpkoKPPhQBYZpdoE;25:7XoNTrNzplx7KjEtcEsch+fKuDUgmLPgho4aiCzRaKxSZj2WUboAj+Mro30zyjR/Fk+xk/B2qhpUHzugSZDPMjySUJHd5eF+/eEh5PMIcuCUGu+ww8dlnl5dkETGSSqfhS/YB90i1ySjlfdmMMlq77Yyw3NN5BFFYMuPcKjt396AyHPXMEKvkjAcXFDamIjwlU8lxFWQBGZIBfytsTMO4LFU8HSrbiaR7hrGGs27qsM/oF2f4DVDiwy1rOYvVhdMk1vO8RV2MYs/XuILAvO3TqiPEaA2NUCuvGncMBfx7I4botTMqgHDY8pSOPYJmPi9VReEyfkprDiKEo+u3AXsCA==;31:kn1/KWJA1JuYFmbHZqGgmXpoNxMaeFiC2pqjsVAClHNKXptspFe5hQVTuseUCZlhKsqS03dEpoBi3AESi79Ma5zV5cBLUEFtbU/UK8uIrH9VuF52X+6y5ZKIJgKDV4V21V5dmHKWRC9noEqzG26z2Q22QzCUIVly5mNl8X0FBU0Qv3YfYq5O+QYqETHv8DqnRh+G+fNvfuXAH9RLF4t0rxtNRSHiLDzRQUTAMVXNVdg=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1713:
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1713;20:2eDU8IXEcUO5R59suDso6alDC1/5X9QU8n8mqIvv7XbkR0DA49WQnBALUCIPZmfC6QRlla/iNqFBnTA/qBcU1kvrr71OubA5t60aG4kyBl5PO21F0dE50qq8b1ybT64f0Y+GYexYQuIkVksx3TmkdJsTYW8HEaS+BjqzOVpU6NCyA/JidP2lxAcLH4Zpcg3NZurVkGdnXnX7cs8EJW0N9xhyddlQw0VJB7uPIzdYgXgVwrYiFkyKA5FTpwboArw95WZ8+OE0td6kZgzpVpRLewM38fZqAxJ2uAwr8fvEF3P8T9dx/rZ/E1rrRFSbVKHDQB7JcMTeP8HXSJoyPDhAdxQivoasW9CVNsQ5F4uMIvT7Qtz4pVIHByJug1jIWUuCL1/t4aVIdkI5mf1lOKhtKNr4ikPDtKyvprfEXcBdGDF/r0eDHii+n4GL+a1T4Fw9lRU7b3frVPU1ZB3bLV8luqszH+oBuvnwbiJ/r1EITzEOqAVUXZfQPJSEb/uSrD1Q;4:22kC12+BlS2zPjujQ+8IpgEdV7zLS13itfnUYTJSUkqsR3FqQzVRbJALpNtbOtPQyO3MwkwF6PKpagWhqBxLmfulqHVeMgk7ue2pR8D55R4xLqq5rEKgmgvTdphbsYcxWHt2gJpyDmRB3VLrV5LFznzfFrbDx3IM+EfPTVM2OCFQddFd7op3hDoBd7d7E/apiGXZxjmIjV3XcfGh85aeZ9v3h4cYnncj/lCIvXaP+qp0CNGqCwMgvHdrRDef13DvXsxLCmQgUw950mwH+RCWj3ZHeWk2x0Vf98ibHKML7JYNjFoxF6OwM0S3CH5SmXOzgo4LE/ve4jMUP19GPZoLHzmjGh6vVCjxjfxL8THSpf4272wBZafCk/KoEiDPcVkV
X-Microsoft-Antispam-PRVS: <BN6PR12MB1713E438E5197872E66649B283BD0@BN6PR12MB1713.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443)(15185016700835)(217544274631240);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR12MB1713;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1713;
X-Forefront-PRVS: 0639027A9E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39850400004)(376002)(39380400002)(366004)(189003)(199004)(86362001)(6486002)(478600001)(386003)(50466002)(65826007)(68736007)(31696002)(65956001)(65806001)(6666003)(230700001)(6246003)(6116002)(25786009)(229853002)(2906002)(52116002)(106356001)(64126003)(6306002)(105586002)(76176011)(47776003)(5660300001)(2486003)(23676004)(36756003)(52146003)(31686004)(53936002)(97736004)(11346002)(54906003)(186003)(16526019)(52396003)(4326008)(446003)(110136005)(7736002)(72206003)(81156014)(81166006)(8676002)(46003)(2616005)(486006)(305945005)(67846002)(476003)(58126008)(316002)(8936002)(966005)(1706002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1713;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzEzOzIzOk45c1k0U1FMUzhJdndUZncyYmFxM0tLd3dr?=
 =?utf-8?B?L1BwREo4ajlaM2hmS1lzMWxpcVR5a2VrbmFOdzRQK3BVZTYwWlNTZENiZWlr?=
 =?utf-8?B?S1J0UDBITzZIMUxjK29oYzV1TWdlU2xBUWZMajdBanNjRllHbVJoSHRrbjMr?=
 =?utf-8?B?WUJnRUZBQ3VCWnJ2cHJhNVhDbFF2cGQ5b3N2SnpzdXh0TTdNN1F4VEdJZitn?=
 =?utf-8?B?L29MUGtVUmRUQnBYYW5ISUZoSEFYWkU0c29ldEw5TUptTXE1N0ozTUovenpI?=
 =?utf-8?B?UmZxTXo0OWt1VnpPNFV5MXdNT2lOTjhpbWRBS2IyOWUxSGp3M1ZobnQ5T2or?=
 =?utf-8?B?ZmRULzMyTTYvaHZ5N1l4K3BmWkpsL1hlcVZXTXBTOEZ0ZTN3OUtjSndTZk9w?=
 =?utf-8?B?SVd1Vjc1ajJqNHlWdHYyL09abmdEVDRoTVdkRkoyMWhvNWNjSW4wM0wrNGxB?=
 =?utf-8?B?cklUbWE4RkxuUlZKMERvVVBGRnlya2JGQklYdGpEQVoxaE9ybEllbUZuVU1l?=
 =?utf-8?B?YWNkRmU3cEN1ZTZQeVpPRHFtQWRTbVgwd09VOUdkejBEaE5EZE40aVJiNGRH?=
 =?utf-8?B?RXRYVlBSUG82b1JKOEJHcy81OTNmdTFCa002SXdTZ1p5dmplUWpYSWlaR1ox?=
 =?utf-8?B?bk9KSzAvcHhtUCtneWZsK0dacVVKL2NsVHkxYkZjTU81b3cyUGVnNWNsd3Y3?=
 =?utf-8?B?WlNKdGZDV0pLNzZpWk9rMEZvL1dJYkozTDNtVVAzWFpQdGxhcFN1RGRhVm80?=
 =?utf-8?B?QUhhUnZCOWphMzV4SSs5MmlTZEdreU5iVTF1VVhWQ3FxeXZhRi9EaDQ5Vkh4?=
 =?utf-8?B?ZmxBUy9jNXNKU0RKUFBrNkxkRDk3em0zRTJ1TDZ1WVVkSTZQem9neXdKM3lN?=
 =?utf-8?B?dXFYSXI5WjFnSmRIaDh4V213WDRYNnJtV3lIMU1KR1dnMkVjYXIvQjRvek95?=
 =?utf-8?B?QkdmcDhZM3E4N0Z2N1BJVGlnZGpoMXJBSnVMMmllcTZmWGx6akpCSjdyeElG?=
 =?utf-8?B?VE5SdkhDVDlxeE82Wkt6amVZOEVaZGtuVSsvR3pYOGZpVTlOS3JrcDlVRzE2?=
 =?utf-8?B?VnB4ZFV3bWNsQmdxazJYTm5NVHg4VXk5aFczVUQ5Mzh2TmFQZXUvNWVQdHN0?=
 =?utf-8?B?Y1ZhS25Zb25ueEpaQ1NuZEI2MEFGTUxXblFSM25ybzlkQVFuTldzWEJwMnNC?=
 =?utf-8?B?b2Z2ellHbVVPM2NkQnNIRE5tTmtrSFdDQVFvSVhjYjkyRlZsaEo1SWR2bzJR?=
 =?utf-8?B?TG1CVHltdFlnV1dySjhhckkvZytXZ2xmSGVtbU9rVWQzUVNGVHhxNHRiU0ti?=
 =?utf-8?B?QXRXZGkzc2JSZmduQ1FXK3M2UVZzQWJxbVR5V2pOaVNzcjN4THRwa3B4UnJH?=
 =?utf-8?B?MStYUzJaK3d1WEJwTDNZNHY5M2FYcnl6d01KZlFUQ2Z5VnQ1a0t2MHJDMGJO?=
 =?utf-8?B?UmpoMjhRdHg4TGJWa2d4TGxzMlB0MmVxL3c2VDJYazNTalFBV2JjUXhkRUlQ?=
 =?utf-8?B?cVh6Mk5RUkxHTExnaFN0K1c0M3hjbkozbXlJTVhPdWoxYkZ1UE80U1hERUsv?=
 =?utf-8?B?RkoyeXJpSVFyR1BYYitneE9YZlBERFJPS0VSMmhUa3hQaGYrSVZCSlJrYmxr?=
 =?utf-8?B?dGMwRFRETWpxMWdMSk5TZUQzaWhhYUpMTEc1WU5pVUdFcERSYnlCQU1pR0Uy?=
 =?utf-8?B?YWtEQmREZm04STVSUEpCNU9UcDFsZ0tiNDBsSE0yOVNRUnd2U3FsYnBYaGdX?=
 =?utf-8?B?dkxKT0hhU285a3pnT1JIZlRVSmcwcG9qbFlhUG5iWk9kVzdiL1F5aUJDVzl5?=
 =?utf-8?B?ekNrcTJWNHpJQ1J4MkxDK21xRldmL0wzTks4YzN5ZDMyNE9OUFYvMzk3WWNO?=
 =?utf-8?B?SXRDR2RMU0JpOTNnTGZPelBpb2pOdjNtem9zY3lrT2NUSWRsM0VpLzZOR3N5?=
 =?utf-8?B?c1dibnF0ZDVBPT0=?=
X-Microsoft-Antispam-Message-Info: 4pVwlhnI36Ejr5eOXDceol0v10G1s8cedbvo9/gxi8AL98XUs/BglHEpCS85SwNc+WZ6B5VRNQNInrIqIpEb2oDHRgAHc+vazxqm+NEn8XMnI331BEqiGrT+tv/OSakubSr0ixDJk+i8U7AK/2E2pP0TEh95HvNxHf/CGD78O+A2AlFpvat/T7LMBHyG9E42
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1713;6:lOnaGhMw8qGt776r2YedCp1iiuCGjGL6QRByEn9r3rcRXCYZb/sd8MCxffbsy90FKqpfsAwxlqXLwggtTe9jDWw0Rg36dgoGL8PBE3sRUzcIaspCKu2WwahZoxFNC2Wu1uxJ92GKgs7NCLp1p0PqzslX8NSWkijfMCTcDSmoUczQTMxK19SkXuk0CNhQZFDOwoBdr6HOpI4oCZMN010Uil7no0b7vAo5ZYveprkWJok0XK+Q2pQEvwd5waDS0JpSb3cQ3Sj3iDKVODsZpcL80hDxJo1EeEdp7Ywsc4XqUFjx05PRNr7OO3ATZqkhTKcTto56CWUhm3MK/C/zjmoMudfVvsLnAtKIJ6/qIlXN9SSBjKkoEgu/t9y01vUrncWsVQPj1kJs+16mqE1BCaRz0kvZ/xwrjf2ppAMzM+66SuoMWyfoJGm67FuZCioaMqYXc5LMvAbkOdhC2O3S8qMyGQ==;5:CCgWURc4ByfHAq7286z+5diq8G6cNKf4aDk5p8bQWqc2L8Ga4ElwdzOW5lWYFo5d5YUP05xB2P7Ef5iWIbXJO32g3fHopupsNQpwhtZNUcsM/xh2K9dsFQwRyi0bTYqHNpFM/TgCB5sNltGKd0vZhCS7VmiyM9+2AFzFvXDajto=;24:w++I/3DAKpgicV1Tx6L+nxw5bZQVIOgU9PHRuyJlP2QgMnBHANZ797E5x3rzZrKvSSxAoRNGEw0xGaknt0FTVkgu4xSwxFckPkS27Cmd3QQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1713;7:pwPFdIFqUl260VEXq3Oko3ZiNbxVpWoUwsoEeJsTw7iUWNjQyWd9/bNAp943JmO69X771smceycmz/0/i8Sb9WGSfji8U175LJwPlnSx5IuR3b6RD+qRJ992hKG4GbFSm18Agkzm1Nr1402FxMuXg6zIIPnvd9nJme05442fMcAqrSFsOMdxcFjmTg25vdtsSz6kMTobjFhW02GjbgOPTTlW1eWDXbRPFkZ2KXFgn/sMJMg9NpgUSU3Wq3X6JXlB;20:Vvm3/Vkfw1znOXkm0N3Cnbt5tOH98wdQcDXPmhFb3765PXPx684tox0LPXj4HTRy7/Ed1utPpH/rxIs5BpPnlZd/32ihJhx+I00i8MFh8PbV5hHOoHzkH5StJ46siQxoDIgAhIwUfLm2Osv7RXO9jjGJjXpcmhbEDr4PG2wRUsf7vR1eQwNsmtYDQzzOtTMg31LOM8GPtFp5aTAhKwcGFLlPC+BESNWPS66FQGFLkOsObet7r58K1B1Wb/yvo/od
X-MS-Office365-Filtering-Correlation-Id: 5a17624e-c117-4013-ff40-08d59f8d0516
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 09:17:14.0829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a17624e-c117-4013-ff40-08d59f8d0516
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1713
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 11.04.2018 um 08:26 schrieb Huang Rui:
> On Tue, Apr 10, 2018 at 04:59:55PM -0400, Sinan Kaya wrote:
>> Code is expecing to observe the same number of buffers returned from
>> dma_map_sg() function compared to sg_alloc_table_from_pages(). This
>> doesn't hold true universally especially for systems with IOMMU.
>>
>> IOMMU driver tries to combine buffers into a single DMA address as much
>> as it can. The right thing is to tell the DMA layer how much combining
>> IOMMU can do.
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Sinan, I guess Christian's suggestion is to add amdgpu_device_init function
> like here:

Yes, exactly. Looks like Sinan just tried to place the call next to 
pci_set_dma_mask()/pci_set_consistent_dma_mask().

Not necessary a bad idea, but in this case not optimal.

Sinan please refine your patch as Rui suggested and resend.

Thanks,
Christian.

>
> 8<-------
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 0e798b3..9b96771 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2339,6 +2339,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>          /* init the mode config */
>          drm_mode_config_init(adev->ddev);
>
> +       dma_set_max_seg_size(adev->dev, PAGE_SIZE);
> +
>          r = amdgpu_device_ip_init(adev);
>          if (r) {
>                  /* failed in exclusive mode due to timeout */
> 8<-------
>
> After that, we don't do it in each generation.
>
> Thanks,
> Ray
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
