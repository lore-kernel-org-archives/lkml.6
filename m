Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752181AbeDJStc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 14:49:32 -0400
Received: from mail-sn1nam01on0052.outbound.protection.outlook.com ([104.47.32.52]:14705
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752037AbeDJSt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 14:49:29 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH] drm/amdgpu: limit DMA size to PAGE_SIZE for
 scatter-gather buffers
To: Sinan Kaya <okaya@codeaurora.org>, amd-gfx@lists.freedesktop.org,
        timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@amd.com>,
        Tom St Denis <tom.stdenis@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>, Roger He <Hongbo.He@amd.com>,
        Monk Liu <Monk.Liu@amd.com>,
        Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1523384705-3976-1-git-send-email-okaya@codeaurora.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a267625f-259d-d873-f727-76531d86429b@amd.com>
Date: Tue, 10 Apr 2018 20:49:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523384705-3976-1-git-send-email-okaya@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: DB6PR1001CA0003.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:4:b7::13) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30825b77-53bf-4855-5f3f-08d59f13c8d2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1714;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;3:4akXJluEeZlfDY2uPbcUZGQxmghenxfWTfsSNrGVi0kfqcGAaKKTZGBMEbSdwu5cg96HturmJ0hJhbSWj0kAHpxNJXeXxZghA0qq0LK6pDdkPSQTDupQsmNgFOV62HJaBZjaRxarv1HiGJenkdXT9q6V9EgYw4SevqqRmd/na2Ie/GVn13UAv62E6ZSKJtiHU9nYI2/50peU4j6njU+x0Y6nIIRKSHD2doPAnkeNHooHel0753iCTafZ07mFaxlH;25:CBXYkMWNlc+WcRUF8u1l+Hh5IDlbRBFnMri+1SSqxjLzt+tZuL1P166tBisFKndSMlmTB5vbiGs0pWueS5NoDxaY8L9XtyiaUajysaslyzUkQLRBGxHcoESqImJzj/UnvxNQ0msVw2dNuXKiFwPjHF5dQHoBd5vqf1ox7FQTvrd/sRZkKZbEJP33Z91L/RFeWQajKtRAyKrubOjDacoOGl5ONpu197+e3cukXau2m8lWhqEGHViIKWN0f53XyKdylBi96VkIB+teHPfKtVkwdOiVYmCVihyLuvfFTm4ZjcZREofQxyeqfXq0AY07YPUBAc1178KbxFbf7bX3dMYUfQ==;31:Lb8VoXnAJD/RaEABeEbRb5BvFtjvCNdG+y3QqS6F5ZMhtzFuW++yBm3s5P/WjPrGq72nYcnHiy16DF2oD69ga5svVj7LRCECXE6WHxr9/3X01CyB0UZVtie++5vxAdsuxucLip9cEfVv7nUlQBb/4fSFzap0Dbka9KKfdwmVWW8zlorPWkcmBusKxvTLeiTZopSPT9uaTFlt2kII+2cYSOaiIAmbnGAMP6bu/tf3kYU=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1714:
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;20:sGoldAGSM3E2d6LfXxI3sTUKOzRHGxezc0li8ofa9On4TNyHDSq9G1vykt8WL6x8AwDS9Qda2vIDAjWno6qb13P9zsYbqzG40GsSqzjEaXIMffqrlsaSRC92uat+QewjxTEWXtXp+jxDsQxcp78I+6P4BVF0DnSQGtSF3hV6EW+hrdm8QU+mcLj9Pi1c70oJNCuQi8RieE2hT/3/CqBCh8S1IBMDV4n/Yl4EOr4IhHMUzra7GayInFeQy5ID7PbKCdPB2Bj/0D88dx7j2nkg6X57IV3Api1XQv+Qc2EPWBR8s4sS15OwxrJoXQR4rTSx83QVGS6I+a/DQBW4Xw2utasjDIZ/KgcDVZwr2M1XL/dgZLLyD81dvZlsIEoLP6JBhmQp1O9NL07Ponrnth1Iiboquq+LFEL/M7F9P50g04HRZCXLSq0pGwzqe6qe1LwWvknqParCEtkX2xTUYbGH/4+3WtXJ0XMFZ1d6HZfa8d5OBxnK3FqfNl4PmyDVPtGS;4:WUfyN8uzlxpan9Y3EM0vK+O1E70CsAvSL6mr3hohq4ShTY+GlmbP5HkUsTEIQB7rKk0Oa7ORTbs2DSU5XOEDfDT+QDnwG9IWOsR7iQ3w8G216nuXwcExE5zEb1oCYfa2GQCVPJ6yBZ1f+uTjXQWW8NxDQLsJ/aRXeRLkVq1ri9BHVp8CjDeYTaVVOgZzJBPoFLLS+E5BZ6TCTpMVrYM86fbXmUrY1VM2tHZBR58tFtX+03DWRNxAl3soAtoL30QhM4z+VgiE4Rb7YGkjKQ2V0d1zoQcvQfZ43JF5l2kOUBPYPje/WqM72LX81uX8SEIw
X-Microsoft-Antispam-PRVS: <BN6PR12MB1714CBF634DF8454C37230F283BE0@BN6PR12MB1714.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(10201501046)(6055026)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR12MB1714;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1714;
X-Forefront-PRVS: 0638FD5066
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(39380400002)(346002)(396003)(199004)(189003)(76176011)(386003)(5660300001)(7736002)(1706002)(68736007)(478600001)(230700001)(229853002)(6116002)(65806001)(65956001)(47776003)(6486002)(65826007)(2906002)(6666003)(72206003)(67846002)(8676002)(52116002)(31686004)(4326008)(23676004)(52396003)(8936002)(97736004)(81166006)(105586002)(81156014)(316002)(305945005)(486006)(106356001)(46003)(25786009)(54906003)(53936002)(36756003)(6246003)(50466002)(86362001)(58126008)(476003)(16526019)(64126003)(31696002)(2486003)(446003)(52146003)(186003)(11346002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1714;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzE0OzIzOjFwYXU4NVBJbnNvM2prYThpVmZ2L0pyTzQ5?=
 =?utf-8?B?SE1JQlFDV1Vrb0UrQi9aNytQT3l2bmVXWS9tYko0Tkp3TjFPZ1UzcXZuenZY?=
 =?utf-8?B?V3hUeVVLYkFvVzZqYU82RWI3Tm81aVgyT1diU0h4Tmh3cnl5ZWQ4NFhzWS9F?=
 =?utf-8?B?M2VDU1RMcEF2S2JKUXhkTnl6VzR3dUdZL0NWR3ZnQ29SRmNQZ3pQdE9LaCth?=
 =?utf-8?B?dkpMS1oxM2FNSmRXUGhBdWwvMk9KWlR5dGVVc2xERzNOR09ZZm9VQ0pSUlFk?=
 =?utf-8?B?czlaWVJ5aEw4R0VVbnVEZWpONnBTU1p3NjNqK3FXUkhQQjllVS83RmFnUWE5?=
 =?utf-8?B?THBiaEh6T2RmektjbXJHa2U3b3RzdjBDRyt5aWs2Wlk2Y0g3dnRldit3STJU?=
 =?utf-8?B?YVdsWGt5S29nYjdnS3gzVkdIb0VoQXhMT3kra3plL0NVallVU09RamZITHZK?=
 =?utf-8?B?b0d6TkZIdEZ3MHlVOFQ1ejFVM3h4NU1JQjJ6QUdZRGJudGpWODg3cDd6TGdh?=
 =?utf-8?B?aVJ4NUd0VUQ0WmJnV2pESE9BbXhuTDlTMnJGa2VQUHdqR0lkdGkyeE01U2ZB?=
 =?utf-8?B?STNodjh6V1ZyWWpNK0tMb2wwU0dtWW45d1ZVM2xEVXdIREl5RTJncDJxb1d1?=
 =?utf-8?B?S3c1UkxTVVFieTBRWmNXRlFSampidXB6NWE1ZVdQSld0K0QwcnAzdFBiZWZj?=
 =?utf-8?B?cUZvZm5sMGdZR3BrV1dGOE9VRDQ4OEV5NjVUeTJUUVdUcFVFWE5rU01abVRU?=
 =?utf-8?B?a01CT1g2cjhmUVpXYllIWjJzdDBEVEc4Q2RROER6UWgreTBaVzlYSDRNc3hn?=
 =?utf-8?B?eGlCZE9qblh5WkYzQUV0NlBiTnpuS1owZWs2UHh0ZzlaSXpheWNtOHg2YkdQ?=
 =?utf-8?B?bXF3Q2lSMnZUaEVRbTlhdjNDUUM4Z0FBSnlvNjFxR1AyRG13aEZMTnFyQk5K?=
 =?utf-8?B?ZjF5dGJ0L3NYQUlGbXBNaEl6bGdGdkhoc0FCWHVYTStIRzdndkNSRHhHbEtH?=
 =?utf-8?B?bWZSUVZTaXdTRTVsaWJoODdXK2Q3cDVZa0ttaFdyK0ZZbG0zRnFiM2xxYzZP?=
 =?utf-8?B?U3l3L0JHOTVYWkYyZDJOQjRTcU05ZUZtZmhMTDhWUmplWlpjK09pVFNjaHNJ?=
 =?utf-8?B?M09JMk9kcnkvREtZVDU2bzAxS0t0dG9MZjlHWFo4a0hESjJtU3RvL01KRG5z?=
 =?utf-8?B?NFI2M3ZETmJHcTJQNE5Kc3duVkFPVWJIUVIzdGt6MDFCQWdDM2UvQ21sWnNQ?=
 =?utf-8?B?K1VrcElpN3c2YTl3WUxzSklxZnNxWkNYd2JsRTFoTGVYZmxQbDV1ZGNYQWpq?=
 =?utf-8?B?UERMcTdCUXNkK2pTN1E5NUdQb3BxZlJadzFRZ3hOZlF1MzVFOW5ETWRRREJR?=
 =?utf-8?B?WmJ0S1hWL0FabDlxSGZGSmtSVjFyTlZkY2ZYOUUwMFJGaW9sVStZUkEvbGpV?=
 =?utf-8?B?TG5MRG1POGE4Sisya2dyMkF5a1h2V0JpQ1hrZXV5OEpGbTI3VE5zYmZlOGJZ?=
 =?utf-8?B?aWZBcEdkZXMzS0d1U1JJYi9tNFk2ZkhZeHkzanNEbWxJakh6S3c3UEh4bEVX?=
 =?utf-8?B?S3hqTGYvVkd6RjlaWlphR0duTDlrdnhueEk2M1dCSmdOUnhTNHFab2xBRTJl?=
 =?utf-8?B?OHk5QlJSQVlXdGU0dFlZenI2dUZySSttRlErRHhBT2dZQWxqVG82d2ZFMlh5?=
 =?utf-8?B?aTB6Sm9MeVBPYXVYTStsdHgvek80UTg2dHM5cThyT1ZKUXF6VEhTY253SXpF?=
 =?utf-8?B?SFBJNWN1eHVPUm42cmRBSEJBZzFFY2RGaHpWdWtQVFlUdXdPQXEwblN2Zi9C?=
 =?utf-8?B?RFVHMkxleklJYW1aN3hLOGFzVCtUSFFCUEkyZXQrNzhkOHc9PQ==?=
X-Microsoft-Antispam-Message-Info: 7OMyn4nxd9rVOLa7j+DLaj65PWQ4Dg+TD0/HXskmcsSLzfM0mWkHxn2FEKvHetLi/Y+cMV/pMaAjJx+fiRob0fufGz/WSRbfvipOReFTVjsyh0UsC/3ghGWjc9z5JGLZ77NgNCZ8TDRiypVFXUo02x3ddaLGhlALJhQBo0lpEEKZj8bdlV1DvCkYcsbxxC1Y
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;6:c4co4xG9/jzgkYuN83pQrSYfrHd1CcQnnI45hARQy53wiJdR7pdjeOt+z3xRjZf2ip3uhw1MKekYS857vfWs5Ht/raYlpg6kQZQfKlmFdqRITjcdtuzbyfbi1UgRN9durjKGuSC1kFYAennqhKIXxOydxzEf7HnlLKPgYkBf0D1A+LAbeoWcIBZRGCvlxQyA9perWNAwLou8xAdzvyh9Ochdg5l0iVBcLyA8+KHQH5sIstGdKrfut/X9Y1Sq+97dj69nCMJTf/rVtrAmKa/d+i72IlZeEmkN7sjvqHhMEBIx6/RmkTmkB3TZ3G8+FAp2h6YgUIOuwpkTs8ySzVlzrIOrdVpawG4dtSRDziwCcgjDiQkrOmcRcoUE59z/1EjqQ6xhfKNHBmCRtYQ2CjfKZif+wfJPT4gwSAWBb03RGW6DlOoVHuBf+6FnZIhjcZu2j1FZ59LyFZ01wINW9AKb+g==;5:wTO5tNKheKAUninnbXYW58oixinAGLEbjTm8MB1svpS3UQ2lPaPbgrKxRSlxchtnTy4up3FAqVNnLQZAU6933Vg/zDt8ll60pkTYsgZIqUoFzuuGTRzmICJH4rOVT5UaYAI7ZhJMtlhavGbdw6KjFapzAtXAPkDpKWFly3BRaz0=;24:Wyd6Tfq/lyU7z7IbUBA349h1tbEI26yMT9ZqhEssczpzqYMhuLlkSiqcD1usMxZ8HNRhbMsK//+fV6X8ajT/75oaPisv3m0TveOj+MW5hxU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;7:PFG7F0hkFPlTOi1WTIQ1DLTw9cXsEML1QcJsfDpAdk8+tuwQBmWpckuj1LxiE/cVJO3wOeVypMU901pHDb7Tk4q6a6HCbkBDEt7J36VyuOEN/dINZe3EAw2nHmuAIKslrtMeDukqWqE9hwjN2v5S+UEeqxLOq7uCOHyi7DiT4LxAEsgecr+W5AAGyFmza9cV/nxzmOnvF/TXfJQ4Sn8lQVFMwkJA/IH4DHruIuJmlsQcBgxFzxDTPLvLc4f6h3ke;20:23ZIOZ6mOwKHB8V0PIydim2Lvt71Q5foSK16y0t++WxlbtAbOnICIkOo/hdLUBQQ8iW81Fl2DGkw/6cU3E1j2kN3zvCjko3QI7mbfogFOKqVSaJu+QE/FZKF2QldhqzabH4tkOwV7OeJlEQID+u6oQkmgRaB4dv+zUZC5IhOHKR4bZyZK4WoBSiOGFLcx7LLrxZJj31wjbPkgd75r6VJ8Bv05zbi7p+H5Hr8ps5DO01qYyga7Cvmv3qvs3hZdLTO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 18:49:23.8499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30825b77-53bf-4855-5f3f-08d59f13c8d2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1714
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 10.04.2018 um 20:25 schrieb Sinan Kaya:
> Code is expecing to observe the same number of buffers returned from
> dma_map_sg() function compared to sg_alloc_table_from_pages(). This
> doesn't hold true universally especially for systems with IOMMU.
>
> IOMMU driver tries to combine buffers into a single DMA address as much
> as it can. The right thing is to tell the DMA layer how much combining
> IOMMU can do.

Good catch, but wrong place to set this.

Please move it into the device initialization functions.

Regards,
Christian.

>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index e4bb435..02465cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -787,6 +787,8 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_tt *ttm)
>   	enum dma_data_direction direction = write ?
>   		DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
>   
> +	dma_set_max_seg_size(adev->dev, PAGE_SIZE);
> +
>   	r = sg_alloc_table_from_pages(ttm->sg, ttm->pages, ttm->num_pages, 0,
>   				      ttm->num_pages << PAGE_SHIFT,
>   				      GFP_KERNEL);
