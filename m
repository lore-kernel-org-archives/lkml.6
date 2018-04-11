Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752311AbeDKGVd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 02:21:33 -0400
Received: from mail-sn1nam01on0085.outbound.protection.outlook.com ([104.47.32.85]:58336
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751845AbeDKGVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 02:21:31 -0400
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; linux.ie; dkim=none (message not signed)
 header.d=none;linux.ie; dmarc=permerror action=none header.from=amd.com;
Date: Wed, 11 Apr 2018 14:26:03 +0800
From: Huang Rui <ray.huang@amd.com>
To: Sinan Kaya <okaya@codeaurora.org>
CC: <amd-gfx@lists.freedesktop.org>, <timur@codeaurora.org>,
        <sulrich@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>, Monk Liu <Monk.Liu@amd.com>,
        Roger He <Hongbo.He@amd.com>, Jim Qu <Jim.Qu@amd.com>,
        Emily Deng <Emily.Deng@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
        Tom St Denis <tom.stdenis@amd.com>,
        David Panariti <David.Panariti@amd.com>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] drm/amdgpu: limit DMA size to PAGE_SIZE for
 scatter-gather buffers
Message-ID: <20180411062602.GA29109@hr-amur2>
References: <1523394001-4615-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1523394001-4615-1-git-send-email-okaya@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(39380400002)(346002)(2980300002)(428003)(199004)(189003)(6916009)(104016004)(229853002)(77096007)(26005)(97756001)(4326008)(478600001)(76176011)(106466001)(33896004)(105586002)(486006)(54906003)(97736004)(50466002)(23726003)(316002)(58126008)(305945005)(86362001)(16586007)(6666003)(1076002)(33716001)(126002)(476003)(11346002)(426003)(446003)(81156014)(81166006)(2906002)(68736007)(186003)(8676002)(336012)(6246003)(33656002)(5660300001)(356003)(46406003)(47776003)(55016002)(9686003)(8936002)(53936002)(72206003)(18370500001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0765;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT049;1:VpXfnNz2h3Z+0bbDZ3Mker7DmQEGRnfMnuryxjEGkJNvc9lWYioJysiR8Vr8sIgv8uoeqjM+uknSqsEPvbTV+ieLrTfZhHtA5L/Y/UcKJEV4CTciG8b6Kx/ii//eTrsV
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:SN1PR12MB0765;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0765;3:QVgUKyeJTw4B+Y0wgimfgNfzFd0w+bIx/SDz5ml3Wl5xgLXU1Veop6o58cdHme8Jcr+n8xR7iMEfVuHbecDWB/NRRdj6tv0PCzH6qb/LgN3sx+XufP+olwtZHjgYP0jGLiSa8DSb5PCajgag48lTJ3iOmg2ObQuHCB8tAX/r3q2V9TIGjd2RCHsbWNzs4d2KK2OktO1MIq8RQYlKiqu362vkb+rGtN+tGIfu9Gx9x7YbqHDvkx1qOgjdoub9JO6bRUSfr+GveV9uZQcGJhOWPJ1iRIF9W3j9kPA50mtzHUuceoJGXswjpSref12VGLXdtYudFQ6XAOQtjgEtpadOglVBs0r/AFpLaReG3xrDhBY=;25:6Hut5Eacsr9MIxTNH2sEnse4N9GfI1XMNGzyGLyGCOGQhzGJ6XOTvUOmwe6uhK9Qr2WooX7vyg5Zz9Z6k5LU80VtKGRLRPjI386ClPmAilyaW9SOwAb8oTInSx+ikHrUqOyUvxMTHs1rT5oDCYMEJGuy+MyXjtdNBnrpm+gW6H6NBGKnzDvE+1yDz9KAF2JgI9UsT8Xcefab6xmBm46UwWNHQOOfb8BphP+aqfEd7NUvIwuJOVD3zk6th5Y24eeG335h6IUYX2L0suhF1hcyMPLCkbaZMoWZpL+4/RmBkj0uBZQ9j5xGKSozYXYtFWcqRw/BM6umLBAsfbSBpDsUVA==
X-MS-TrafficTypeDiagnostic: SN1PR12MB0765:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0765;31:utloYLlgDAxrSp5je+dxpT4s1Pos9QMuUF2SRqzr0mu5qFO0c0mNLdl7BZAIqcL4M3wtqi5XfLWgkNE8UzQxNNcB7qXC0C/Yo5io2/1v/4TExKBIXYNXt3sYwV1ZTypfPZkVm2Olb4ZoU0Sjz6/xHbPmarITvclO+iqE0JY/9RoBy/sz3sqCfmUKmjnL247Pt+GAH7NReeCrb1raUuC50WyxhNqqxp0vGwaMTAXQfcw=;20:lPn8Hj2UVEO0XPwIDqT1k1NUe+A6c3RnvJvNm6lEmQDt6MV1mJYCaNnHyB+VuEqBS/K67mYMzoIvBkgxfr3v5d0yhnCoeWKoX4XVSPe1ozov8eZCppVry6Yewu7zxCzZX7E2hehekYtmRKWR3FrCYss9rMq4Bu98Z9rPELx5/W8gqBEwJTJtnyie7IJpJmAUSjGuQZeIKX+g18iB6rqrK3OwqFX20dEoT7UMCs8xzms/UF5UajMDG7BGtoAB9QgzpppN2bdXRLHc7j7VxmHxYBPrTPARierSICCzyof+HMUp3wKZVZazh2vWbWu5ZIIbcyqWC2tZrFbJUl6bbl7sIsaDNLD9F416tAMGMEET9gJNOBpb2+y28sc5tW/xHXjV6t0e19Td74F32gzVp+fLWvWivsmpZDQnj6vBpUCe5I+JBnOUReXmIoj7wfy0bQ2KY2QUE/buLWoqLIrK77sESqkvDe9HFaavMhqKHVDHQDFy72E9ElHng9nAsCuSkfIJ
X-Microsoft-Antispam-PRVS: <SN1PR12MB07655CC846B76284F7A9E60DECBD0@SN1PR12MB0765.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(190756311086443);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:SN1PR12MB0765;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0765;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0765;4:WxlOsIpxuy3PQuqq2eoBawXPBWA0KBi6WQzCkk1DF1t4FHWQF7ntyPsLu3FGHVOgM6iRV7KJvQpsevJwelllAHsnr0kbXmP95rybcsouEAlImdQeTOuzwyXX/8D+kd9DmnxkzK1m8YOW0U3PH2fqoeFSTm/KfH+0GtM55AgQ4LwLx2hJXQh74MAGxFzRPnMdW31s41dwoOg78VnVbljC/WjxxX3jdXsDEn8o9JvK5OYM8ETHmJ0jqAMuukwzstX9CRNScEYPETJeovT/o2MIPc718EdSGGZILiL5HZLRfxOcpA9t7ADKd8D3NZxcfLch
X-Forefront-PRVS: 0639027A9E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB0765;23:pZ+Svx17BjtjKrDBK1XJTW+fkbl2hS0VhQKe309iR?=
 =?us-ascii?Q?hfrU2QxmzmIs/RSgVA8Un5J/UO9lhQU6mcMdfR3nao+rCMDR7M2qrMfsj7mh?=
 =?us-ascii?Q?nFDfc+b8382U4I0/bBvz6oxW/rnsEELMMdO1JYvBY7+4g75LtC4m1nabPFTg?=
 =?us-ascii?Q?W1rVYr2INb6lkLpK3bMH7uNYWxLqL5RscsGVt8n0+SX9I2Z/zxxKSQJjiuF9?=
 =?us-ascii?Q?x3HoJzWXG7aIvvEQSAjgcBi+o13y3M9YOxoexyG0tIdatcQSJZlEShkprlt1?=
 =?us-ascii?Q?TlFV61V2bHw7SXV5Bejx2BrgL0dI47WAn2MHMrAcQ/rwHrbM6pRy9xz1XdD2?=
 =?us-ascii?Q?cCLC6d8S3yMFwaJGRpe+NtfYjXdLyyGncqpXRpnKzaR5T3tEHFy4dqHKhb2r?=
 =?us-ascii?Q?teYz56YH1yI2kf9zlaGTfJY+09fhVE+FO35dcMeLYwF9Y0xCGuDcUONBHcU/?=
 =?us-ascii?Q?2nt9hJXIkos0c9wTmwt0M+GUuHMll6ansOFOrNq1SBFWcbW8Z77hzsCrCVV/?=
 =?us-ascii?Q?vDmJQK0TAllqdr5HHyxFCBHhrYIhCDGx7komN+6u9Z1Q4QtC8/aKjN5uQsbd?=
 =?us-ascii?Q?KwAeQRf67qjOV6jhDRmXlqnAaPMtr8hrx33p/1xj8hwPacRFfV42EG5hXYcJ?=
 =?us-ascii?Q?Hnxaoc9uSbwNO4TEghadHLpYQHOs1M6jOAmsG39pmA2qbB52IcZiF9Eaec/m?=
 =?us-ascii?Q?IYmMWOdaCH+YdkTM5LNVwL3DFt5HD9zqu9Q7Cg97zFcsqMeR5KidjCE35hME?=
 =?us-ascii?Q?4Te2GlsAeHvkG3yH673gpHXZzd69vIB6okXcT9c2zxuyERIOe+USjDqyEimv?=
 =?us-ascii?Q?EjnbWRQcj/sgnip0hFe2R7B9/BqvvNEWa4zaCR2xZ8Gv0Bnb+JsqH7l2A8XK?=
 =?us-ascii?Q?gpL/ou/0IzwGQOYknf7iBR+E5vaMDMria7L6TScc1osxzbejtdGef0GcBEBK?=
 =?us-ascii?Q?xfM5NMlgqrLgxtdRJ1YhJDMuQjqUlYcjb91G6qac0ZxFZ+daYiIF5ZkmqusA?=
 =?us-ascii?Q?t34K2M8KO8N5ToIJRWCWZDbfJt0KgiPIh+GQRHKskzmxjKCVtplvzXsP3hX7?=
 =?us-ascii?Q?Fsd809aJu+Lq2e26Ve5WzZbYlLSvqUgqIxvHxwWQAYG/LoEGdRJvWgtC0Ta0?=
 =?us-ascii?Q?Y9rn3173zRD/C4LhXH/SHcReON0gmQq3mE+ltdqhJoWLKUJlr8ygYYgFt7nJ?=
 =?us-ascii?Q?NS6QopXu4T5Svw1x8RZKhggYBJm+P6FgV8bZFhXMjFYdB+fdfBoMQoe6AUGh?=
 =?us-ascii?Q?foxGgN/FXJ6/10cK09qy/4vvFAn0/uOSRUf4RvHIqDv5Q0O01+Jdc+/yXw7X?=
 =?us-ascii?Q?FMymF5e8HzUL5JiK/JoPpU=3D?=
X-Microsoft-Antispam-Message-Info: 8PZGW9F0QijP6rMay/1qmIK4xZXoYH1/aU751I+DEsh1lw+0KEm5KRXSEZqXPb/ADPQuB1dAYAkPYRzlsPUy+imzxm8V4q9lDijKRjV3wq4lVRj6vzHrhqqXBdQ8W+5IosMvyJl9qkM8LdVee+LUS0cmwttGsdsA+6iSR6KcRvuD9pB+gxshM2pGq7judvIk
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0765;6:14/lEZErVJcN4mQUKtkW3TBNL+hsVwH3JVs1RSfgakjX5vIofZu8CQWu44ODcpcHv1KubzNuOQUAV8PeT9K0Aj4qhnroY8zY7h14ZxjAbOdTv+81hGJpeJ/vjE/Y5VJiItQzDuotRvcIhcsIRriO0idIuDXjy7QIoulcgO37dpanVSPx9l0sxh7tMpsYUaLy06+Om7SZQoM/CyxC0HVH+vb+nE7V2Grcun4XLpIlgGyxUIiXQVpyzpHH+isFZdjDDXH2kyRUQKWSNQ523S5IQgovaD0XagFttusMo5DS6NKUd+vWkS1K0t1fFvjWkp7GO0vLCqijY+rTEknuaqk1Q3CWIK9c9lfjQ2QaECdoub5N/HfHZ6K1x7yK5TVTjoo7YkBZFt38iStM/S5aWtwYdDlqVi+ZLGDIOyLZPmwvtTEZ7TzuO8OchAj+8sJT2fLEi9L0WwFkHvkkcNcfgQpe7Q==;5:unHoZd/OrLawPhm/RrUeyUCDjGuSBNxXO4jSZ74yQ53pWJF8v4xvjD0TC3c1zJPGFmpaJAPp62ByMTKy/TXRkcRujuQl9/O7R5RX4dWM1HRRHIHhNXbt2XVnNsZ9KnkGP/l3ztC9IIZEhwDLlPMjhWF2IpcPL3F/ZQf9H3dI8ts=;24:OixiOprA7XNyuvRcbJxTPOsdGEGGq2GW73mqRzhKnCqn579j2zb5+cA39MXSlN+78z0wB/goI1mBdSJV65/WXbb4Cr7MN+XdzWYqrSNZsBU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0765;7:LqgF2Jy+WiWkKza6ro4sftujtIMT1z1vN9vVQPeMuaN8QC66UW3VVZon1XNparP3mLF9aji1DWpNjXlslnpq4Qa+FgzXdG9hziSk0p7VP0bzZMHRfvw3PJSN8Mi6pZUh0XBVvGx4A0Lxrny+Hly3QDTLwLE7DJcRjfAfIvwVKAe9FbMacX5Ur5YiEOuPFBHGK6iO2g9pTsP8JfzfQt7kLJHuchoCWGfnyQE9ANPitH4r94M51LnR8jGV/PiC1m2K;20:/s8WfNFA9Fx/sGEsvvKAY9WNC7c84X67mCN3IDRX/O3bo9kvYFbtWHErIB6eajlariMttNPTOFfqaKPeJTWUwUUvyjpstUzJcSsz+Sk244e92OGBkN6ULsOX/e1kFR/zx2NxyKQFZfYEJxH7iFQs6Izbxjjd9+3GgJq+GXyoTEeA3tLd/rmLmhnPCLsHcp67SAbHeovc8Uub73AFY2uNIBqoV1qT1VAwJ14PUnaovbLjiojIkiTVGtRuCMI13uRv
X-MS-Office365-Filtering-Correlation-Id: c84f4ce5-b559-4100-5c5a-08d59f747539
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 06:21:27.0446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c84f4ce5-b559-4100-5c5a-08d59f747539
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0765
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 04:59:55PM -0400, Sinan Kaya wrote:
> Code is expecing to observe the same number of buffers returned from
> dma_map_sg() function compared to sg_alloc_table_from_pages(). This
> doesn't hold true universally especially for systems with IOMMU.
> 
> IOMMU driver tries to combine buffers into a single DMA address as much
> as it can. The right thing is to tell the DMA layer how much combining
> IOMMU can do.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Sinan, I guess Christian's suggestion is to add amdgpu_device_init function
like here:

8<-------
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0e798b3..9b96771 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2339,6 +2339,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
        /* init the mode config */
        drm_mode_config_init(adev->ddev);

+       dma_set_max_seg_size(adev->dev, PAGE_SIZE);
+
        r = amdgpu_device_ip_init(adev);
        if (r) {
                /* failed in exclusive mode due to timeout */
8<-------

After that, we don't do it in each generation.

Thanks,
Ray
