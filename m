Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeEPMGt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:06:49 -0400
Received: from mail-eopbgr00049.outbound.protection.outlook.com ([40.107.0.49]:47202
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751319AbeEPMGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:06:47 -0400
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; lists.infradead.org; dkim=none (message not
 signed) header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=mellanox.com;
Subject: Re: [PATCH V2] nvme-rdma: stop queue first before free it in config
 admin queue
To: Jianchao Wang <jianchao.w.wang@oracle.com>, <keith.busch@intel.com>,
        <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>
CC: <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>
References: <1525945347-1964-1-git-send-email-jianchao.w.wang@oracle.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <06a4d7a3-969d-c9ed-f40b-715b4d774bf1@mellanox.com>
Date: Wed, 16 May 2018 15:06:39 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525945347-1964-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset="windows-1255"; format=flowed
Content-Language: he
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.223.3.143]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(376002)(346002)(2980300002)(438002)(189003)(199004)(51234002)(31686004)(7736002)(31696002)(106466001)(86362001)(36756003)(305945005)(4326008)(2201001)(3846002)(6116002)(478600001)(11346002)(59450400001)(446003)(64126003)(53546011)(50466002)(6246003)(67846002)(336012)(126002)(2616005)(476003)(486006)(5660300001)(8936002)(356003)(76176011)(16526019)(316002)(16576012)(230700001)(2906002)(229853002)(81156014)(54906003)(110136005)(58126008)(186003)(81166006)(65826007)(47776003)(65806001)(77096007)(26005)(8676002)(65956001)(106002)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB1246;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DB5EUR03FT007;1:2zf6+pAogBRY4Udp9pG4oNGjHD9uDjx0255+D7YAcEiuJGT/ZfPK7qeVkUAh4IjHvvb71rxVtaMhHgvm1PFxQEuJUlTzf7ONYgm389ZFCc/paY98+c6lOl1tPP300dUz
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB1246;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB1246;3:pOkgAiX3XRQcma1yKPgwwk74J5NjTybmKyNwd9C4QRMhGNXhp/RbZ6/KlHCYh4WAwH7w6pJITMmjtBwu5xUeJzlEqukR6NAQ3mkJsGsNQZ6GfDtO1hNee2nbQ/YAtYg7qGlDGaGmMMmWX+pJQj/DmYXREjjT2bYdDenPYX7GjoWq+tYaqBcDnrhs9fDTlGz5k1stW+4wqI2HSc6HLjlc6hqsgSf/r0WH8y+x0h2Arb5Fzvmxjkg+8exxwqs24ntXmZGFy5kg+LGQk+STfzexeoTQddpGQh6DLfp8YjaIF3Qbd9mt1VRFnPbnngoBua2CmjH+ukqb6z4nWyagTtEW0SIfla7QhJ1w1tE6UPJB1vc=;25:PiiLETMovLmk/rrkStvO1P4Fuj9FyD1/vTM+s5yCE1oBuTCQi/om2Hz2ylYC0648exdRo/e+izhBzyJQg1mHzCXyKOHsR0jgpeq8Betmm16vpCdMVIAOFqGEubHnojqMTVTHqfDw/jrhxBS7hYX04KJb4Suun5Wl4dOTrqqYcDwwf2UcnWgvJ5fa97rongAbCpxK1OctY36sCXOj9qOVMqEA3IPx7t+4FL/LveHSeWq8BHfUk2kbmBu5j08AnJlmzTGCcJRgk+UyK++QdGHrDuUVVVI/tbTsEOOfpOFu1ZYhPe6RMz/l5rIonaGCa8ficDvinWF3C4ztCef5I3BIgOYUvIwptV4WRLdftiIr5c8=
X-MS-TrafficTypeDiagnostic: VI1PR05MB1246:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB1246;31:y9oRldue0BlxV5x3DqHRWJyBJqNQqW0VXR+1GTHdWHyzcC59YdGU9iUMh/xphIhshVvYMRziqybjj9cffSKep3rNSiJszqZYINY7pNGUaC3J8E4fG+AOrg/FeWsH0CnzZqSBxtFe427i6a9DXLhDBFPq4vaySGbZgJAN1ffRWGWaG1pMNP5mYGUnp60szaD7SxBlC/68/pZNonoEsQFLWNntBmp6Eo6izPAZeDx1hIM=;20:viu4mHgGKmEslehi4YADciHej5/IE2ExQuBxVQPTFafBw4fNZsQHlJeuOCnTw9S2qsOIqRAs9KjRGnY/X8wXO/1jCb4UJQI3DrApXDa3xGlAGuTUg0kg5mdOYx2vNgeRJiMjB1DxjcDpLrjVADBt7VZ36Vl+dmQmlN/bz2Xc9LZ7m4klfdiEdQYGZW1cRinMjYxdrO5Yjk636YM36oQH3T33eYtcOXe7j/8OJ1zmFi0oL3TlZB01V//QN8P5UVRPPkRIf9OkOSonmWoWWafbMazI5o9Gw+Jr8PyvBmJox8pWUJtSWAMwilNqQ2/LlRF5alJiO6zN5fFbCGJNmIfXzW6bwuYZDq7273BRRDOi7hc7fkdgGUzth+ysAFo+8xzFWLE7znb27DXnpvwYxVkFFwoJGMMTbSzg+XZJBr1L0Mju3zvhaaZ3xjzB6d8SG/gkbdgrnGRep0C1GaPInCrkkTswFk5sC/JH/EY6UDa/2jk5ZwtP5E73fazdaxxDNcrU
X-Microsoft-Antispam-PRVS: <VI1PR05MB124697C30975178DBAFD8BB7B6920@VI1PR05MB1246.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(146099531331640);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR05MB1246;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB1246;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB1246;4:Nmo9GcGI+dZ6wjzl8zK0ckrq0rGxQMVjYLQghKmrC+/I5dxHKxRn8nvC48T26govB1CUkPC2AezOqtEvR4Crd7PDJvainGEg5gopFZrUALkIYUl02OX17cQqroolKZ/QKGJF9wlXB/RGSRFyi/JZ/ZX0WqXQjN3NVvRtrRNKZr0G7Uw8K1n6PtadfFwExE+rTrzkdU7p8b6lVuXtJVEGKl0GIIKvj5khytUdgtO25VO278KOF8PwACe5sJC0NFhyyLlLLzk2vEdqeZFunF0qEgW2nsvQy4LhLxgKVaTRuTs+KegxCgnxQ9MoZTVB4js1
X-Forefront-PRVS: 0674DC6DD3
X-Microsoft-Exchange-Diagnostics: =?windows-1255?Q?1;VI1PR05MB1246;23:PVX0Af308I4FYfGgg4ER6BaNLnReKok/x03Nf?=
 =?windows-1255?Q?FPwU9cFLrCWQSFRNr1WjIiqo00FxoEDl6DkhUqZ8wg8inrYEjEMpwmlh?=
 =?windows-1255?Q?6tFAhp2ndGq5DizCfkxxv388D5Ud/oCZFDXRTRwL2uAvi1pac8FgZCBb?=
 =?windows-1255?Q?MqmeYyRdyd1qpF3n5ujMvHFJPhQhBoBgpIzRvzHJTzwDIOdL/guJUC3m?=
 =?windows-1255?Q?j4QC3bgvMgeVa4TC2zsjWCyS/+VH4SZT5rn6iUicZs7Z7DrRhzvGClBo?=
 =?windows-1255?Q?CRli1SUNKQVVvs6ZPcB1ffXovH3DlBxCv1BUhleDL18MZVMxkV/2ya2j?=
 =?windows-1255?Q?SciGcgcJQPTMyrdfaeyg6T2wZ5KFquGEWQSi1nL9iN9zXynTeUR+jv1V?=
 =?windows-1255?Q?D5R6rcU3Fl5ZjvXR14ZhzZ7GSzJ33+zUo6qLiRW05ejOM/UfLQpWVTt2?=
 =?windows-1255?Q?OpOe1gGaY+8K6JddKlNAroc0Gt3a9QWx8qkxx8rM6Dbl7xYK9ckooxZ/?=
 =?windows-1255?Q?VGbTquYW8j5SK4jTX2NFLqG+Kk7/QP4vIghskrCr5XS8o27RU0JxlioX?=
 =?windows-1255?Q?wA3vDRrC0eoh/GzKoDWXUqFd2a4MjR03fKfBDxmTXw3UmTNl+bBxazbK?=
 =?windows-1255?Q?FOIu+TeRS0axMG6Ld9Ev7infetP7E6lOxU5CGDNe7Ki2KxAtNrjAwGYj?=
 =?windows-1255?Q?N0Xx1ujhBWF+YStLnAHalXxLepD/RsliB8v3sOwqdcUzVZR428cnjzYy?=
 =?windows-1255?Q?wQR+F57PmqLGVgAoeeUxyDqFeih9b9ZvYlFH4Dxf0F5b0YtNgJYRs5ai?=
 =?windows-1255?Q?3VBTwGmG8gvLx0tte20Rw8gRw9krkSPjSnXCEq9eLmc29oWoPTEVRyts?=
 =?windows-1255?Q?pqnfNCKK0xElAHedlMV9qqyI3S/c+H/abEZYqPGInz8j/LrNbdFXnd7k?=
 =?windows-1255?Q?u7lp9pp127whoOQygTMjZA7EwrOCKy1tpRkHKp0PQr1r/+5geKdV3rWl?=
 =?windows-1255?Q?Shd2OF5+TNEuetx0io6s4VCWkJe4AcQjuzJ8Stvy27MEP6OUMvbDEUdI?=
 =?windows-1255?Q?3h+WP0OIl3kXW/P8G5Gw77kzhbdHyMK7j4gfpMbRaQJTTzCovydq8tvN?=
 =?windows-1255?Q?qWinGYPtB2bk73fveAC1Y5QLAljM9U0Y3v+jjvyINsvrpwrOK0iEw4Z8?=
 =?windows-1255?Q?cmljEa68h8WtViL726j5lq69gulRKF4h4M4dZY9Z09T4ZZu+muaFfg8y?=
 =?windows-1255?Q?0HtScrpx4XSKPxGS5um43SK1jwk94bl2qb3Nx0zH/CoAib5qCoPmymGr?=
 =?windows-1255?Q?4J3ngs/jgQ6kTUudcncVhHhI7LNelg9G8NHSKKfu1+bwHTGiqps2nP2n?=
 =?windows-1255?Q?OTYM+yXvB82vqKrOTFkyTpD9WnmTNeiGLmaFv+zNIaARpIe/LihNkbtw?=
 =?windows-1255?Q?AgFAw8qRVMCi7rrUQqA?=
X-Microsoft-Antispam-Message-Info: Jx1kRVy8StOzZ88llys0GiLNCFKioGPLr+C5FkeLfnPKR91kXl3DKM7+s/Mbk77ywlt7Y5hxJT/36gVhyBe4BkZvnawu11cnccDdIpjTkYFImkvvPlnU1CeRP0UgCzeKzbErw3uNhfO6qUj6q2CwmXStl6vme1gCL2RF3WInoJg53M2bZN/TDAU/bOx243J0
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB1246;6:1FycRNOojIqo67yx5Aw/Nlaf0bOXT0e+ZOLHW956sWYlnpeGg2Tl9voIf0Q0w838+T7Si4WBHE02e02ta4s2+bxTlK/4eS4qc3AGc9vtjdAEPEL5JKx4Ltl7CDb3rHe7eMjiWXknHVTuxp8pNcTIVXP7bjzmifYKLby2c+zWBskqksTxaN2xEP91pSDQ+OmuQ3S6B/mw78huBVLFa1NNQAsDVUsbQfP4aSlWmvwrnnZrCJ9oa82Seh74fn3LFvBEtLrgl/CGBJ1KJq7CS34Q1hmdDXGAVEzhgQUOrhGnb/gdGbIx9sZNP6Rwig1EATk3G+g+6y/4fCz0S4Sr9BBm+bPAEWkrl9kSworWb44U7tzpm1NXvl056Zaa5FliSHqfjXEAeYpURlNtKxkuykRzggdiIsluCl7dZHiMgSp8qt06Y3G5teAP/G7++71MKz4BqZN1Kmqd1bFs8Mel9tiY2w==;5:FaxusJkD8B2AljWvt8ocrcPKqSivmz3gLcawuI+zPpQakNiIQYp3Lti6fi1AIDDbC7uT+kmSLb//EF7AlEV+WjvYTtEjWjX2jCsLRnEi072RsOlj/R9QqcXYtLJn7CPiLWpmaOg3ECiKe8WMcikhuc47rjx9oWdZQKGwd/L13QU=;24:zeQmdWT35ynd7XJj9eLxdGqpOX+019J19XKW9Td5IJCvijQxpwaT1kH3cp1pszc/iIcK9N05g18Am8Zd8OrIoxrMZfGpyFzC76f9slpMfW8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB1246;7:lh5samPOA9Ynb/O7ZbszW0DHFtLv9UI1cGRD3dp7A6Pz0uQMlXH3jqCiohMpcAJ+W/li503Ps4CxTFeFOqMgUkgi3q8uyZloeQjGN6a87S8P/xwYa2CAb3fdhpcfRXjr1rdzcmILaNL2FCJE2BfEL9UAyvo7RkbIemAbxvHS2sT0JLyGp6frYntPbA3aYCo2JcSiWm59aPEiW0KAvHE0Dt/JgI50eOT3GSazpdyMb5X4dLtl6gkTH1+FotPjlEDx
X-MS-Office365-Filtering-Correlation-Id: f8b52cca-c834-4b73-8ee4-08d5bb257cda
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 12:06:42.3800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b52cca-c834-4b73-8ee4-08d5bb257cda
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB1246
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/2018 12:42 PM, Jianchao Wang wrote:
> When any of cases after nvme_rdma_start_queue in
> nvme_rdma_configure_admin_queue fails, the ctrl->queues[0] will be
> freed but the NVME_RDMA_Q_LIVE is still set. If nvme_rdma_stop_queue
> is invoked, we will incur use-after-free which will cause memory
> corruption.
> BUG: KASAN: use-after-free in rdma_disconnect+0x1f/0xe0 [rdma_cm]
> Read of size 8 at addr ffff8801dc3969c0 by task kworker/u16:3/9304
> 
> CPU: 3 PID: 9304 Comm: kworker/u16:3 Kdump: loaded Tainted: G        W         4.17.0-rc3+ #20
> Workqueue: nvme-delete-wq nvme_delete_ctrl_work
> Call Trace:
>   dump_stack+0x91/0xeb
>   print_address_description+0x6b/0x290
>   kasan_report+0x261/0x360
>   rdma_disconnect+0x1f/0xe0 [rdma_cm]
>   nvme_rdma_stop_queue+0x25/0x40 [nvme_rdma]
>   nvme_rdma_shutdown_ctrl+0xf3/0x150 [nvme_rdma]
>   nvme_delete_ctrl_work+0x98/0xe0
>   process_one_work+0x3ca/0xaa0
>   worker_thread+0x4e2/0x6c0
>   kthread+0x18d/0x1e0
>   ret_from_fork+0x24/0x30
> 
> To fix it, call nvme_rdma_stop_queue for all the failed cases after
> nvme_rdma_start_queue.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
> 
> V2:
> based on Sagi's suggestion, add out_stop_queue lable and invoke
> nvme_rdma_stop_queue in all the failed cases after nvme_rdma_start_queue
> 

Looks good,

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
