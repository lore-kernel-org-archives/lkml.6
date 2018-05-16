Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeEPMTr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:19:47 -0400
Received: from mail-eopbgr10074.outbound.protection.outlook.com ([40.107.1.74]:47104
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751510AbeEPMTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:19:45 -0400
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; lists.infradead.org; dkim=none (message not
 signed) header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=mellanox.com;
Subject: Re: [PATCH V2] nvme-rdma: fix double free in nvme_rdma_free_queue
To: Jianchao Wang <jianchao.w.wang@oracle.com>, <keith.busch@intel.com>,
        <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>
CC: <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>
References: <1525945328-1908-1-git-send-email-jianchao.w.wang@oracle.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <c32eef8a-ae1e-ce7e-ee39-eee60192e517@mellanox.com>
Date: Wed, 16 May 2018 15:18:47 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525945328-1908-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset="windows-1255"; format=flowed
Content-Language: he
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.223.3.143]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(39380400002)(396003)(2980300002)(438002)(51234002)(199004)(189003)(3846002)(77096007)(31686004)(26005)(106002)(186003)(16526019)(53546011)(4326008)(65956001)(65806001)(54906003)(16576012)(47776003)(76176011)(106466001)(110136005)(316002)(67846002)(6116002)(58126008)(230700001)(5660300001)(6246003)(305945005)(65826007)(7736002)(356003)(36756003)(478600001)(486006)(2616005)(126002)(11346002)(229853002)(476003)(336012)(446003)(575784001)(2201001)(81156014)(8936002)(31696002)(50466002)(64126003)(8676002)(2906002)(81166006)(86362001)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB1760;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DB5EUR03FT041;1:itje5jgAlgyb9gqQReMVEYPDwUHALAf1iHDsALN210RFycZdsHih9NlhSu/whUMA5StxpNxt4gh6SvtXaaoS3JdEPx/4j4XKLZ3YA/KeFQpgw/DpBpPY3LqO8J5RpySr
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4608076)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB1760;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB1760;3:uCnltAhKVLOukyl4wc1Epz3FueOuigwv4b2DAYJ7VRvTKMSSVQXNnrwIKd4r4lIo/CDWrauhJveYvgN0S3JBTPNLfI9tc4esW3PhcAfalZljpa8DEr3dOWWq5IfiNepYinoS0Gjn2VEmeyKKg8eVZgo6vhPD2gVoJeoQebK1ZMv1oTUijG/eKG0KGE+iAZzFjIunVjoB86889FLz48heTNJE710fMxASQ2q2OvUY6Eo1Aq+HU28X4Z8xAScFm5ZhD46qLnjOXzuyeNMhScbohcTl4Mm/qJZRwSTzhUv8DSp/Jgulq0h6ek+Y1XxcwYhW4e00SOoUEFzfbNdRPmReMqn79xSFVtqe+Q0uxNYH3vs=;25:AsVSWPJNg/KfEH2f11a5/OKnfzxLMrY9IfZ/oDWST0Kuqi1KrF51q9hb2sNTG7ka60pG0/ZkSUdNB6KbHeMzKRfDHfr+K2/+yOHDtYfOwYljYubFI2bdOwUr1Pg+fNVEukArMXKQCZFPF74ozK1Cnaq92Fu1XdH1Dn8OavHRWxvYO2gDeyESyrMT9AhvMZD+V1U7rqBrsH1+zr4Z7Bmlf0Nv2ZrH5AaeRMAXurllCHa6hQARcvBKwJQt19HiiuXn8GYYfHicDwdTsLz1CFJuAVmxfBP3KKgMaYxPf2kcMHO39ABo+BKxKNL/5stVWYtbLlf6e24fLPaf2smC3Ghwig==
X-MS-TrafficTypeDiagnostic: VI1PR05MB1760:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB1760;31:dLf+2p4kDaY6vmNFvaRcuVjN9iyjeSlD7uxTkEWL1fwOoQPhHIGV4Gp+JSVeqf6JvTaoBYMMLZAREPmwe0qhdJ4xoj5kbg56njx2aF4OnKtys3pAcNptCJ5If2QbCIkr0ri4T5kZvbNcV5AfoQaG0P5h1zDlb6cZdG2/04l9s6MLoDSbyf88HPacBkcT+T3rg++bQ5XZEVuhI1jbTXRRF/fJsU9ydB1cfztqkoi6wMM=;20:xFw2ZcqwtRKYhEFO6icPrXi+T4vdk5m3ojB8pnjmRHqQqgRByHGaAFNr9Vkn9xRdmMNmiX57BlajbbxN4BwpOALsqcPg1UvBQHYIrjarMzB9Jmvidt/CDbZYklRvkKXOt+0ebAp2d4EPMmThe9X3mDA26tz1q39xW8jg4KaI3T3e6tKz8oV+Qcgmn1DtI1WADd+5CC2yy5PBCnpo7UB6/MccpDlfW9SLIAdJT0rDc+cZn9gaYvqitZG0c0hbTYaGh+EkJjWE97fvlmkQXu50C0G2vb4kYHvd6llc6M4VB4+HQxqgvTy9nWCms0ql3TjzdKAyqRNx9ov/fIOpg16gHHCluf7LqAHb6cR5VJEYMa0hd20BGdJXO0htWFfanaKLigSpsPAXlMiEBrwyck3V4ZcJjAKM9d4b/OZkS9KhLmzyHNASyMnsmvjWfE02I4TGw0RXIe8vhxF13nWYK57Ncuv0X0FFlcwCxvRb7ScOajJEnxVque/0DSg/f9cDw9uH
X-Microsoft-Antispam-PRVS: <VI1PR05MB17609078E2EE167B25E38A19B6920@VI1PR05MB1760.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(146099531331640);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR05MB1760;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB1760;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB1760;4:fc8yytP6tbxKbqIqI2pchTyqXXWXeJ3asibLaTcGbe0KcWtlfnMAyBDeYbkDdeeyXGz8+wbqRv9KQNym7BuPjuywRVzpqxDgdsuLM0/4O63mGSs5GfpIIb+Wi5iKYf9mSdE1Cg/3ZIMl6Hzj8R9JxxPp83eGv9KrrE1Fdrl2JiCtyPgQSu1mt0QDuHsl5gVJpXP9CCUE0Dz4Z+6yB+zHvjYqw6Gx/KGEJHqHGkDzEZMYU2i0Q7VbF7ugmebjVP0j7oE1boyIfN/9C+ggjLcsQ2UkJG0EaS34vXUSMWhq4CIVai+QOydIRcZBM/ar3IgS
X-Forefront-PRVS: 0674DC6DD3
X-Microsoft-Exchange-Diagnostics: =?windows-1255?Q?1;VI1PR05MB1760;23:B6SZJtz4q2ImrHf/p4ykYHXBl5SyjW4mSx5rH?=
 =?windows-1255?Q?Gpt2LsNEe4PDmJNP5+ee89i3uwrEGVJXNfo/oZD6XuZ3sfzC5e45fp6s?=
 =?windows-1255?Q?7TwU6dUw/UxpLN6/cL0G/hIprXY1MAFKshEQu95DF59lR7sHY3aSSnhH?=
 =?windows-1255?Q?XQinMzG4OZw1fhWvzhzM6SFovAhjNiCNiW8jEEWXJrsv/1Gy0bDCzzWR?=
 =?windows-1255?Q?h1hkUk8vepyyfcRvJhlfDxfg+mE3CaBzGrUa3s691qPPWBkP2D8Ziqur?=
 =?windows-1255?Q?i6Vt0V0MdaKhLPrDcKFBwvE3o5ekeV62cGxN2KU7JxGpYIJK5ymNfAws?=
 =?windows-1255?Q?ZPudBYcoWAKCaVgnXaetpeyaL+eSqKdMirtVo5ytfqT6Z+JgnUZIkdmJ?=
 =?windows-1255?Q?MrlLfL7u4BfxqMqTh1eKUbIms03h3n0eR3f38JQLZx1PvYBQS/KBYdCf?=
 =?windows-1255?Q?MySncwtSHPsoYWbEekb1/kd+3WhXUbGiuxD6EgVCfQ5pwguOCk73Nmcu?=
 =?windows-1255?Q?bBT9HyDRGOX6YdLtlMRLCb+eyMU8KhMjKVZw0MYLSNpEmo2fgqbFosSd?=
 =?windows-1255?Q?0jjWncIQokNbX73opk3lODKhlNnxZaqssE1TSxtvyKSKniWP6R937Bus?=
 =?windows-1255?Q?GDiqA9VU8VxNcBkz6gQMDgI9IOvPnSMWJDGRSOXUIbN8YIqDdKtaaZPk?=
 =?windows-1255?Q?1yWy2tQOD5vgX+hiqf1zbI+a8FNaPrrc9e+NRmCIBJRbqfaIS8uY7omK?=
 =?windows-1255?Q?edxKSGq1H049/ZJ/gOF6oJKewEpapHpmLY/vftcuynJDS2QfbxfwFWQV?=
 =?windows-1255?Q?L7FLEUiofpqENnYqXMfoMw7AF32MHzhiRHkSy3CYHG1V3t+ki0g759NP?=
 =?windows-1255?Q?SCxX/WftC0I9tBze8NQNbMyBJUZN4YhgAps7qhtt57FKFNUaHngNZChA?=
 =?windows-1255?Q?b8sOmYrjWqCVeniq8XAPkF/CbdcVBr7SgbQCTMfvnHpAQ7PtEdpi5VTR?=
 =?windows-1255?Q?lIwuQFxPrheohlz5kHpZ+BvM86cpekwLrK8UFqyRkJ/eXEDS5JfWHlAp?=
 =?windows-1255?Q?UZ6Gdtla36HfwnJeiZvUX9I8RNRPfZm1QsqZs8f8O8fZjbj6fNJeowMO?=
 =?windows-1255?Q?w6ydMmHonIDmoy0c2opV0Tnn/dRg4ADcSATJE7SCcUzJ3EswQLUfm69f?=
 =?windows-1255?Q?tKxkLj0ukStNvSsO+ZNktoqmP0w1/Fty0vlsee5gKnMViPutY/ONw7fg?=
 =?windows-1255?Q?Gvf0S2XMhpS0GcLUsmEdACDsN+qYvjUHRUHPZjnU2dJSe2wcI23KOJxC?=
 =?windows-1255?Q?Oh+QNLa3aD+YvqgpddEB7c8+WTAIGRNgXuYeir0oU5gnOdViaI3fuDAJ?=
 =?windows-1255?Q?B7GxwWKnEOhsoZdi2jC91eoWGWE+zO9seaG7zutVNsj3M2zdlDE64e6P?=
 =?windows-1255?Q?RaWDqeJEmMnmaGFUUPw?=
X-Microsoft-Antispam-Message-Info: u3LCMEVnkUTiVsWv5iHy+7aDAso76QsQFo3/ppyeRpUxgXHcU7rmf46Q0UI4dGGZUpaX3x2Sq9HVV27+Yjli1IpnK4LpaTjDKcsVWvYR4UCyY1VEJy1ZzNBAcNDE16g2V4Tb7b7lKR7lSGt4eyZEBykZ3+DGfdxJ8ErgbjsguRid4BDVTU+V4obToE0iogo0
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB1760;6:m0HyDgDehcpCvS3qOk32upRFKi+JvxQLatbXMvgoJKEGY1WIPtXwHojlZKcuCqwHuUSPsDyMpsX7H+o1ZHc8dqoBsrkrg3LscInRAjEh/78NVFzWSV0hHrmtn2wIanmbpLN+2uUrXdeDf7vcHnwZuDxuAdzo5iESwdp1ykG5+OwSGoxj+7/J9mjauE6ZDzJHO7XdxKECAuIhYP3LIC6EbCFIDo/a7eYc8QoyjOBuLBgcpSzuiJNJol0nHjfGK+JyixhWqqifo6RX+VeNWSogU9+MpnOCvzSk40nTesuH7LhDZfWd++mQTWOKOnbIJcQKtVCTe5eP5p9R1fNLryZkPGDY0fXVcDEs0g3SAAI6zKh4I2SbV0Lpj3CnQP4LTyHpL+ZeDFPAjWw7e5ZWwgL9FiE6PfrQW6UrZtfVx2NbXAnNzO/4+KbGzhBOYXnjdv6mfbbXp2c47B77ecIHtBmj/w==;5:isVnzeoRRg9tVm65OeCu6CoRxFXkI9bWOF2/aYZR4yjX4XfyIqJYOoHtrHcq1j4qxmQwYCSSiC9MhvzJqzLR6vqfT7/x/qHi+1hMkldHSonQ2lnj5LHMWvWCiAKkXN1y3SQtm+4lhe0hd9kOAvejhM+dn2Q4+BpR/w44iWh+bhY=;24:UuJ9ydTupcSu+NWuQBDHhBVRcF6mToL5G5G8AqcHM0kVTWtsCinQkChtQaYGIPcV4E4zgup53nankJuuZaKfUe1mZ0i2hXvca91NKsrb/0M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB1760;7:JsHnR0WZG3kMOFw+B1I1d8hqlaAsDBD9r+n4fRszbcWdpnXYjX0Dz0xvZqvEY2XaTdFvNnMyX199pqg/iFKo0jvoUkPrkZDEC045w20CMXqAppYuSCORniD/2aLMQd+GFZzIO997y4zCHMR9G6zv9m2dZidnTEzfoLbZZgEoZhLT8I1h/T7/dmy0YbgwAPC8jVc1L+T+ZnusiZwTiFo5dr0K4pZdef/kOzCjhrZxb0sul9hBRFZ1qxSQqU4lXUxh
X-MS-Office365-Filtering-Correlation-Id: 63054344-bb50-4403-320e-08d5bb274923
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 12:19:34.4830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63054344-bb50-4403-320e-08d5bb274923
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB1760
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianchao,

On 5/10/2018 12:42 PM, Jianchao Wang wrote:
> BUG: KASAN: double-free or invalid-free in nvme_rdma_free_queue+0xf6/0x110 [nvme_rdma]
> Workqueue: nvme-reset-wq nvme_rdma_reset_ctrl_work [nvme_rdma]
> Call Trace:
>   dump_stack+0x91/0xeb
>   print_address_description+0x6b/0x290
>   kasan_report_invalid_free+0x55/0x80
>   __kasan_slab_free+0x176/0x190
>   kfree+0xeb/0x310
>   nvme_rdma_free_queue+0xf6/0x110 [nvme_rdma]
>   nvme_rdma_configure_admin_queue+0x1a3/0x4d0 [nvme_rdma]
>   nvme_rdma_reset_ctrl_work+0x4e/0xd0 [nvme_rdma]
>   process_one_work+0x3ca/0xaa0
>   worker_thread+0x4e2/0x6c0
>   kthread+0x18d/0x1e0
>   ret_from_fork+0x24/0x30
> 
> The double free is on ctrl->async_event_sqe.
> If any case fails before ctrl->async_event_sqe is allocated in
> nvme_rdma_configure_admin_queue, nvme_rdma_free_queue will be
> invoked. However, at the moment, the ctrl->async_event_sqe has
> not been allocated because it has been freed in
> nvme_rdma_reset_ctrl_work
>    -> nvme_rdma_shutdown_ctrl
>      ->nvme_rdma_destroy_admin_queue
>        -> nvme_rdma_free_queue
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
> 
> V2:
> handle it in nvme_rdma_free_queue and add some comment to explain it.

I don't know exactly what Christoph meant but IMO the best place to 
allocate it is in nvme_rdma_alloc_queue just before calling

"set_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags);"

then you will never get to double free since we clear the 
NVME_RDMA_Q_ALLOCATED bit in the beginning of nvme_rdma_free_queue.

> 
>   drivers/nvme/host/rdma.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 966e0dd..fa5cf87 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -561,9 +561,18 @@ static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
>   		return;
>   
>   	if (nvme_rdma_queue_idx(queue) == 0) {
> -		nvme_rdma_free_qe(queue->device->dev,
> -			&queue->ctrl->async_event_sqe,
> -			sizeof(struct nvme_command), DMA_TO_DEVICE);
> +		/*
> +		 * async_event_sqe is not allocated in nvme_rdma_alloc_queue.
> +		 * so there are cases where NVME_RDMA_Q_ALLOCATED is set, but
> +		 * async_event_sqe is not allocated. To avoid double free, set
> +		 * async_event_sqe.data to NULL to indicate it has been freed.
> +		 */
> +		if (queue->ctrl->async_event_sqe.data) {
> +			nvme_rdma_free_qe(queue->device->dev,
> +				&queue->ctrl->async_event_sqe,
> +				sizeof(struct nvme_command), DMA_TO_DEVICE);
> +			queue->ctrl->async_event_sqe.data = NULL;
> +		}
>   	}
>   
>   	nvme_rdma_destroy_queue_ib(queue);
> 


-Max.
