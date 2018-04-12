Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753875AbeDLPJy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:09:54 -0400
Received: from mail-eopbgr50106.outbound.protection.outlook.com ([40.107.5.106]:38104
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752975AbeDLPJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 11:09:51 -0400
Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia.com; nokia.com; dkim=none (message not signed)
 header.d=none;nokia.com; dmarc=pass action=none header.from=nokia.com;
X-HPESVCS-Source-Ip: 10.151.73.41
Subject: Re: [PATCH] rapidio: fix rio_dma_transfer error handling
To: Ioan Nicu <ioan.nicu.ext@nokia.com>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Barry Wood <barry.wood@idt.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Logan Gunthorpe <logang@deltatee.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Frank Kunz <frank.kunz@nokia.com>, <linux-kernel@vger.kernel.org>
References: <20180412150605.GA31409@nokia.com>
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <307953c3-6f41-2e2c-eba5-5dcd2fb5e1b4@nokia.com>
Date: Thu, 12 Apr 2018 17:08:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180412150605.GA31409@nokia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.240;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(346002)(376002)(2980300002)(438002)(189003)(199004)(6246003)(5660300001)(26005)(336012)(77096007)(59450400001)(2486003)(106466001)(23676004)(2616005)(44832011)(53936002)(446003)(126002)(476003)(11346002)(65826007)(22756006)(76176011)(53546011)(39060400002)(486006)(31696002)(68736007)(8936002)(230700001)(229853002)(36756003)(97736004)(7416002)(305945005)(106002)(86362001)(2906002)(64126003)(478600001)(81156014)(65806001)(316002)(65956001)(110136005)(50466002)(81166006)(8676002)(58126008)(356003)(26826003)(47776003)(31686004)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR07MB3287;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DB5EUR03FT044;1:KD+iKF269OT7SuplU/XCaksEBTUPLWHGiCDhGtTo8U7SXI38SeIvZUudX2PojA2jo2TBjqXPoFBdMlm0j6nEv57T1YrNuQfkhsePXcKYgkKZCLolCugbMyVw+51hu6E7
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(2017052603328);SRVR:DB6PR07MB3287;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3287;3:RJ1r20tNmBmD7C/EbvxHBFUJGKV88HCUd/U7Q/DtCMT9SWT5lqiknPbAsB5tO7LDEUM7U2k7xhBKmOgyAR/bsy12FigAeSuRwy050nmb4SM/zkhJdJeCT2BJb4BPcrUsD/P6QCKR782xjOWbrZhAimOWTb3IRGj8SUIVxx3dFqKv2ecKzaoSELw2ZbMUQFH45w25qokfIzltnPRJ+3tOjrU8hlSB8XhwraNT/CbteB9WSza0FGgj+YrBQNniHUtKHuXQgCyYInbrrxsT2sSSuvUBhey51hLTB0fRTWWRtUuhJz67PE8t+FCg0bhwWKiRws2yeykSEkY5GZ9QijKJs7Gxbxr5byK9SLF8GX/ODmg=;25:acTzP0+OXxwRWRYyctbmpDcBJ3n91Yz8B0q2yr3pNOmwzqwwHR0WliMwJOwuiw/9m4kBnOTPzbhpKwkjLSRI60LtyIKsdt1DcasJZVE1pTeTI8sxs0k6LaDQl764qoH0Q8c5ivH8+q14Fa8CUVHVic9oO/LcPpzUHNSuLy15GeKpLFYrU2pyLNd7H0dkuQ7WFU1PQ6PvSgBqX7jX0eul6EWlUN2ny2QTjobJxv6sASrVu9SJC/zVpGrS+/5FJOKSZFYJOfkuh8ZRM8uJogD7/Jl2dSYYz/60B09DWFmJHRxYyzhGhWuCO2hRnBM8WhbbF1+xBxgUg3J3nxhb6LwsCg==
X-MS-TrafficTypeDiagnostic: DB6PR07MB3287:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3287;31:DsYs6ObPjPUqsC7sZCUI5vCOyQ1lmVEN7iPlOpqXPIg29PFyObpH/sIYo6SLUHYfh3YHKYeQqJzw1upzwGkhG+kDrFN33MSQS4XGfsbKF6XXDhh7W8nCbPSvMV1zriCmC2/TDXHhyKC7eh+dNhhKpXRa1I/SYBSP84GMBghPVvTwRSg9ojhRCnzUR1hEfIdY46hihuhAT54PCxPTI4S2OtzAACmxtvwclEzYQUu7jfg=;20:y6YC/NV+APvH/qxc1tComfY0wwmvvDAQw/ivbPjba1+0l66je8UvyKRu9Gn0+3mzWk1B5JVvMQOk6AJxr0mTmDc2THhCR0Dvfcf/hTkorQ3xgS136p4mIsBw3gCjxbbyihHKLZ/pRJM97hGLG9vXnMx8JxHsCO7M/ZLMbjKGQRROR2Rc4R7WqoEnbZvQol0P4x0taigictas7hAFiQ8hD7hRJW6RK1w/zcTp6x0KXkc6/B+kbViyyAtVYeXVn53bA2pQgRO8oZtjt08DnX+7OtiO+C+gHfedbVWL4b++LcpDY1N+ZhtHxByfRgffEkql+a/krHjibiPuAbXY4aqIw4/lX+sqShOpvXEYb5H8M46C6xD4qVtVCGT0L1kBYVi++hANNt2Mo1NT6KdNqescH3l29dAH8Sgz27mvMd55/a7ZXL4rvcrDjEfL7QNtPZx0bPcOCZUNIkDINoSMtAvCNi+I0cUDQmKU3A8nNsM/4IcBcKoGG1I5msS5h6GcLt8oxkIz/+d2vTfaqwCyw87E6/1ssTAK0ymtHRe8mFRg/GzB05P2F0vgHjfU/c+jP1oBJ9kd4Ln8wBQHZ0MHHhGFMXnrdThhFpiFUdutrma9lc8=
X-Microsoft-Antispam-PRVS: <DB6PR07MB3287238457CBFA924E97355788BC0@DB6PR07MB3287.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(82608151540597)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231221)(11241501184)(806099)(944501327)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB6PR07MB3287;BCL:0;PCL:0;RULEID:;SRVR:DB6PR07MB3287;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3287;4:n5VL4qT3r/FojpsxZ8HwjAk64DD1v31cUjN5HCJZtfQbPHTbyf5I3tmH/eiOew4JUnjI91Bek4ZCFQSVm5eKwB1R3tjtvlNvQ8dNRToMudxRTIkWMO2C9PBAtoepicmpNMxxIGxw7dbfmMItO3uEFPvj2q/VJ+yz/s9PCYUB178yAFtks/+47+oTfTC2kbCigtok3oyDSxs5asasfHuml+dWgFtc7oHBqsYe66vBhR217Yf6Nzs3XmzA50wuRYF+PJYfBFLsOBqpjvpT+uQyI/ATkfGOjNMIPEHPhkpcQbQG58uZkVLdNkyE0ztJCyEXT6xF379i1ermAOk60Rdu4NAb83KmtwlaCOG5f8gJBFA=
X-Forefront-PRVS: 06400060E1
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA3TUIzMjg3OzIzOm93M0V2SUsvME9MdjlkdnhpTm5zbHV3N1lI?=
 =?utf-8?B?aHZDREVvZ0tWWGNlc0l6KzIyY290ZVFDd2ExLzJaYlhFWVVCa3dUQVJJY08r?=
 =?utf-8?B?ekpucDg4SklsL20wZTNKdDNBYThYMTNETTdDRzZiVGJZRENod3g3N2ttQWRE?=
 =?utf-8?B?WG55QWErRm90emZJYityeVRlSHQ3T2NKK3BPV0lqYmVMQjFYdTBOQzJDN3Zn?=
 =?utf-8?B?S3VYcUtNUXY1WjVyVDZibmhmNEhpY1lHd0FYSkdpVzNENVdGb21uOGZIbjZi?=
 =?utf-8?B?WlQvclhpdE9VbjBrYllIU2NwbHhrZ2ozNUQ4NGNjeDFtTWsxRC8vMjFCUE56?=
 =?utf-8?B?bk5Eakl1QUFvK3B3cmFtU2RtNWdHSEI1QlV3cGtXUnVJREhZZEdzMVBhalcw?=
 =?utf-8?B?dWtsdHJNaFFyd3kvaFZMek5JSnNQWGZiaXh5eml5MXYrSnZRampoQmk2U0Zq?=
 =?utf-8?B?YWYwRjRaa0hTNmlHYUtOanJzUzhlSjhTV3dtekRjalB6cGFLSlhpTDFnbnNV?=
 =?utf-8?B?WGVHZGI3bFB6ZWFGdmVKamxLSDM4bnpUZkQwY1M5aFBHMHd4YlkwL3gyOElx?=
 =?utf-8?B?WGhTaTVMMW1DUlFCTjBqOHp5ZWJZaVM2cStGcHRWWEZpTDhwV3NtRS9CYmd3?=
 =?utf-8?B?V3NuU0dvYzhhQ1hyNWRrL1BINmE3a1BUZ1FOVDRDa21hNkQ3dkhRb2xvcHU2?=
 =?utf-8?B?blRiZnlZQ2V0eXU0elNXNlBVbWRqRVlyLy9vVVVFZjhYZ3BacUlmMlMxSjYx?=
 =?utf-8?B?VHVKMlUxY0x5dWNoRUd2NHNRUFdWYzkzTjJSY1NzZDhtVXNtbTF1aVIzaHdr?=
 =?utf-8?B?NEhGbU52Y3dsQ05iZkQreFdPeXk1a0FURGg3OHpyWjBwV0E0RStrMnIvemlU?=
 =?utf-8?B?MWVrZEpXcXZpNFF6eDlib3NUelN1ckRZTTFML2FzRTArdUpobkdCYlh1cGl4?=
 =?utf-8?B?RGNaa1pyRkhJUWRFTmZEY05nclVrcElaVWNDUnJJWDJVZC90VzhaQmxlcUEy?=
 =?utf-8?B?OUVMREwwR0ZNVnJ5NjRaNlEzWC9tN2lJN053b0xZRVd0a0dhcXIyTElsNnVS?=
 =?utf-8?B?aGhseGErODJGZWlrQ1U1RTkyQ1NsY1hrdEs0Wk40T2E4N0lRM3dWUHpKWWlu?=
 =?utf-8?B?ZHUvWWhNUStGb0xOR095MDlyZmplb1JyRE0xNE12K1VKdXVTZDV5bGRjRHpJ?=
 =?utf-8?B?R1RMOFYrV3ZrclFoY1ZUdjREY1o3OG5zdlNHTmZ0QUJwQjZ6eHcwNzVXd1Fv?=
 =?utf-8?B?Wk1pdWg4eTVEMDh3RHBrOVlXVG05QXV4YmtMUnBnc09MNUhhdU54NDRRcXE1?=
 =?utf-8?B?WEpWbGppTU1aYWprRkNxb0UyMSsrWm5JSk5HYXFvTjBWOHM0V08zVmJJVDdP?=
 =?utf-8?B?bUZ4cFVPdStxNVE3djcwdEVwdEc4K0gyLzB2WkMrMnlqY05wTWVObE00OEJ5?=
 =?utf-8?B?dVd5MTVrbTJ6UTZQaURsMHJqYVF1UXJscENvTGJCNHdVOFhoa25kcWRKVG9P?=
 =?utf-8?B?aFh4TFR6K2ZEd0VnS3NTUUw3elkvc2ZLdStNYTJaL0oxSWlzeVpxaEY4ZVAx?=
 =?utf-8?B?QU5wQVJ0b1VQL3pRWndkbWZ4OFA2VXVWQUtSNEt4V0RmWGppRXVKb25MSzlK?=
 =?utf-8?B?ckhhWGNWTHl6K3U5ZWQ0ek9qOVc0OEpXa3c3Y1JRMlFrWmFLd2NwZTZha0d1?=
 =?utf-8?B?WDFrT1IwOEhhM3ZjekVQTU5sK0VzYjM5S2JTeDI2Nkwwcm9vaW5Pa3JyVzg1?=
 =?utf-8?B?Q3M1VlhQdVo1WkxaWUJraU9pV1F0SnY1UVRUeGF0K1NmWDlySXRhdHMwVWhC?=
 =?utf-8?B?UTBPOXdvRkZEUHY2WWNwaHFVRy9MTnhOK1hwZkFtZmRncVE9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3287;6:H+J8t64n4x7Vol0MghmJk0IfLpY9hzvkXWpVmTctTu9YEN7YlDr6XWGIwkA/NihjqtF6CZzGZystW4d1z3OLfS6hGr4wGOHm3wXrXYARsPamM1M5VeZDUH53VZ+M+88/Gec/ft7szNXMoiTlMtFU1YQWskGUiKhY4XWTlgxcF6bfmQVOJQ70vItR8kkFYGj9vj+ZCQ4MEm1Xx3n1xQUgY/5GBB79VAD8AG6hSBtIlOvlq8YDMaT3bLVt3RR4PjI92uN1DAgpaeAeQcc5Fr3FEbXKH8Utk7TQi5JXbZauOEPpOYGERV6MSobvuoG1EbX/83Gu6au6T4QSimvDDknQ+snid/mCiBEMbkpIgEjFvcDboadQS15wqHCbWRlS/NZSWUH1/oNYXfgML/sGJvYvZD+3qRvxO6lW9bwMn29SCP5v1+GBEzN0vmfYz+5fYt5I392TY0JOd6ZbNRIGybRxKEiWLTvFzYC5JpkeS++mz0RWtDyDGv/nc+mFVsX21IsX;5:RzDsJ8NCXzhiC1BFIVecGL41tmxhQcRssesfHNY8UEy8WP82n0GJvxs962oDefxu2FDpQkhJcZG6QNq2I23fuO+ENS4iOyKviCpsICPTFYTF62NPCEHfFwigW4iTHmzuW8na1zSzkqegDY1eYuK9x/OXQ/mAtCj9BroA4vmqz6E=;24:KOSiRm5cwUlNMAlywoCAO1Rxfuqll/xg3dQo6w4iiunTY1aogCZSmL2OKhPPLcFjCy4MaKooW06MEPVufIdQiODCf8V6tD2O/qYNVhg/35U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3287;7:xmMDqne67Alh2exlv54oZlf3HTZbxc+/49i2eN25uORsgrweASusUzDkAZxCtbZ4TZvlpiA3qKl1G1RrCCYcdnH/lLrA6EmSBOp2S6DBDQ3zqNr1V23yUXqiu15AwzYcVa90EqLbuuLUutfkDVIzxCiD1JKd0OlBH7seMv4RcfnVV2QjFQnVHDS1KlgX32QDCVmOSAKoobM/hznJao5AkRTC24NRlA+e0zSbSF/AHIkgxojbydSA2wMgOMl94nK0
X-MS-Office365-Filtering-Correlation-Id: 74cc1373-616d-40e2-1078-08d5a0876e90
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2018 15:09:47.6882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74cc1373-616d-40e2-1078-08d5a0876e90
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR07MB3287
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/18 17:06, Ioan Nicu wrote:
> Some of the mport_dma_req structure members were initialized late
> inside the do_dma_request() function, just before submitting the
> request to the dma engine. But we have some error branches before
> that. In case of such an error, the code would return on the error
> path and trigger the calling of dma_req_free() with a req structure
> which is not completely initialized. This causes a NULL pointer
> dereference in dma_req_free().
> 
> This patch fixes these error branches by making sure that all
> necessary mport_dma_req structure members are initialized in
> rio_dma_transfer() immediately after the request structure gets
> allocated.
> 
> Signed-off-by: Ioan Nicu <ioan.nicu.ext@nokia.com>

Tested-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

> ---
>  drivers/rapidio/devices/rio_mport_cdev.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
> index 9d27016c899e..0434ab7b6497 100644
> --- a/drivers/rapidio/devices/rio_mport_cdev.c
> +++ b/drivers/rapidio/devices/rio_mport_cdev.c
> @@ -740,10 +740,7 @@ static int do_dma_request(struct mport_dma_req *req,
>  	tx->callback = dma_xfer_callback;
>  	tx->callback_param = req;
>  
> -	req->dmach = chan;
> -	req->sync = sync;
>  	req->status = DMA_IN_PROGRESS;
> -	init_completion(&req->req_comp);
>  	kref_get(&req->refcount);
>  
>  	cookie = dmaengine_submit(tx);
> @@ -831,13 +828,20 @@ rio_dma_transfer(struct file *filp, u32 transfer_mode,
>  	if (!req)
>  		return -ENOMEM;
>  
> -	kref_init(&req->refcount);
> -
>  	ret = get_dma_channel(priv);
>  	if (ret) {
>  		kfree(req);
>  		return ret;
>  	}
> +	chan = priv->dmach;
> +
> +	kref_init(&req->refcount);
> +	init_completion(&req->req_comp);
> +	req->dir = dir;
> +	req->filp = filp;
> +	req->priv = priv;
> +	req->dmach = chan;
> +	req->sync = sync;
>  
>  	/*
>  	 * If parameter loc_addr != NULL, we are transferring data from/to
> @@ -925,11 +929,6 @@ rio_dma_transfer(struct file *filp, u32 transfer_mode,
>  				xfer->offset, xfer->length);
>  	}
>  
> -	req->dir = dir;
> -	req->filp = filp;
> -	req->priv = priv;
> -	chan = priv->dmach;
> -
>  	nents = dma_map_sg(chan->device->dev,
>  			   req->sgt.sgl, req->sgt.nents, dir);
>  	if (nents == 0) {

-- 
Best regards,
Alexander Sverdlin.
