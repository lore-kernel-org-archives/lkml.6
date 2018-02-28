Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752841AbeB1OjS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:39:18 -0500
Received: from mail-ve1eur03hn0231.outbound.protection.outlook.com ([104.47.9.231]:24775
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752716AbeB1OjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:39:03 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com;
Date: Wed, 28 Feb 2018 17:38:46 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Andrey Smetanin <asmetanin@virtuozzo.com>,
        "Denis V . Lunev" <den@openvz.org>
Subject: Re: [PATCH 2/3] x86/kvm/hyper-v: remove stale entries from
 vec_bitmap/auto_eoi_bitmap on vector change
Message-ID: <20180228143846.GA2376@rkaganb.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Andrey Smetanin <asmetanin@virtuozzo.com>,
        "Denis V . Lunev" <den@openvz.org>
References: <20180228134401.6544-1-vkuznets@redhat.com>
 <20180228134401.6544-3-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228134401.6544-3-vkuznets@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR09CA0090.eurprd09.prod.outlook.com
 (2603:10a6:7:3d::34) To HE1PR0801MB1980.eurprd08.prod.outlook.com
 (2603:10a6:3:4f::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 404104d5-8cb0-4e15-3a75-08d57eb8fbff
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:HE1PR0801MB1980;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;3:Q+VY7QUIw2QjQKWsVcYLqTedkC0xJs0bOjmmItofuZ44W10RkYlcsXEpjDMX4GrhZK4SFp0Ygq92AmmQNtLZu4qsUpfLgCaSstDvyaKJqjLZ3J6WtyzAaaTaFq9rXvUAkGOyUElS6yKe5zpCjjJku1k6ZdNh62Revzim9q6nmUm+0PPP14OJz1rSd297QtYaNSM56NtE0iT3dUn574JyVmv7pciFRD4xMWKx3xYk3H4zeJmBxcpzY8JtovBpt5u3;25:UJmGatrO16c2kqt8rUPP4c+8kqkFZzb09D7tFMBd1I5qatoQGCKr7m8A6Vs+9fUdKW01nIxLXLh8cplNtMSLODr536ppzH6DF4CKX38SKhkjeRRETDK8/fXcfK+RdJBIz3TPLuvVD92x0zTxdgtxzNQ8hlcWkAAaSA3Mz7oI+Lf7DuFZ12Ed7FUm6cR5+F86FJnHT4O5TJvZRvy5uAAfbMNM1GhTxDJyvCDa2x2fskmaYOLdpx5VfMq9PmAtwIyMD+kBOU8jzmOINboVfCq6QJvLN2wQiYmGiRWmeu1Rf3UGZEovrJcIcx+Ui1kYE1t++Lr5dtsfKrl0Z8bIqmI94A==;31:nS2oMZl/qlvO/S1IP0TiDeRJF9wbOIwOjQA2J37Ej8DTWruvjOX25pc4SAWX5nD+OMKwjmZ2/n2PweDv3K6dQadb1TPpgv4XPRYKlwZjWBbvRj6sSayUPEEYYuZcqZhKQ2JByockrWr9ldi9w24tSp38K6+1TEnay5U8B7QhhAn7d1CEl0nu7u0LVPPUiCZOBpx1tSs85Ilb5fPO60PdfpmRFXmjexnAWMXQHdU9JzM=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1980:|HE1PR0801MB1980:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;20:ApmOwfFky9I9jbkExp/mqDISSmOysQeHMoOORkEpkwrIRMW3A24TGmJFtSWE/oxsbrSOwG6aJU1FNyRPons4ONBS9J2Dukv5WoLeHl63pSsQ+toXy0kA7Yb2PHZqDxVfE6rOnDBA5pDk3xKp2mLjG/0NkyG8LxSxkhGQUoyssRlEQLVEqORa8zgdZ6a3MRro+khn1nI138WF3SsrtM9U2vWHvEyRLwKM/wdWoiHw87E6O3DSy3ALsaohLPzCjnLVQfK/8tqGrP5KnmhvPnis4cW3a8nNnlis38DIbZwLI+m4ees3ZvoIT5Ld1Ikeu4AqVzkHliDQ4HyfKvRtC9SuzeLO8Oxt63NGghbUxq79xos/caWLsVHUKauisQnQd4/MPc1q1hGRjbiOLkrSAW9EOzxNw4ZBoegR5a8plB/J96GshFyXy0LzDCKRkvOS2TMyLUtAzVS+ZIL1iJ+jkCHKzazcLfkqMVlnZZR1CKJ+UIyFJtRwTEi9U3tdGamLWu3W;4:3q9XqXWrEaqoRHHWJnOD+4qkLunynGM5vxXr6dS8GzqLDEN8zkVNvlVpeHJTSWmxoYZZ9EI3o341SnIpu/t4uggoSkuEovYP0OF9sxccJzq0gPICyqRzd/XO+vd3WXz086o+gjBCt2cWFfoHuvz+gPXlbGxzDtK1JtYVFFitVL/l5SxpV8jdPFuutBpqQA/yq+tegtbpg15SrN8twrAW79aXpoJypmBr4GKIKaUG8NWNXNndR7qhTncSUeaPKZ2TX3umgAPz3/Y+sU9lFXvoNQ==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1980EF624AD0B7C1AF7F0C7FC9C70@HE1PR0801MB1980.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231220)(944501217)(52105095)(10201501046)(3002001)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0801MB1980;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1980;
X-Forefront-PRVS: 0597911EE1
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(346002)(366004)(39380400002)(396003)(376002)(39850400004)(199004)(189003)(58126008)(9686003)(23726003)(3846002)(1076002)(105586002)(53416004)(68736007)(33656002)(2906002)(6666003)(2950100002)(6916009)(97736004)(36756003)(7736002)(8936002)(47776003)(66066001)(305945005)(50466002)(6116002)(25786009)(106356001)(4326008)(69596002)(81156014)(81166006)(8676002)(478600001)(8666007)(16526019)(186003)(6246003)(5660300001)(54906003)(229853002)(16586007)(55016002)(86362001)(26005)(55236004)(6506007)(316002)(7696005)(52116002)(386003)(107886003)(53936002)(76176011)(59450400001)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:HE1PR0801MB1980;H:rkaganb.sw.ru;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0801MB1980;23:9jHUp8crMIg4vhbqpgWWAFInScfdY8se46Njt6n?=
 =?us-ascii?Q?+OWBiWJA9R221Qf7/MIPqipE4gKV/T2ndalsO0UCQI5uLNkkedZ09ybB7TLj?=
 =?us-ascii?Q?rcyL5gqgPYXI/Pf3+vDD2NQ4RjyArDB0Z24+jaEkeEz80uy2itr6y4ViufIH?=
 =?us-ascii?Q?rlS/pDNWjbZqfNTFNb35qF8Twe8tB8JUX61CkL9S8V97tMtyIgUNTCbExRyj?=
 =?us-ascii?Q?hXj7i7zt/d7T56evHKoC2rvY/Nb04wJu/V4j5oLdnBRxgThzZmHWoJtgEcxX?=
 =?us-ascii?Q?SpmBEPpFSFdcE8JQHdFBqt+9AfuO8oriFM0M7C8jUwYNH82ABSK5iqy1ETQQ?=
 =?us-ascii?Q?c87oDa4B/8UmcwNwhFvih3K0cneMGu3xHVuMnUJ3KPWQaGUqDBohf481+bIC?=
 =?us-ascii?Q?MBAgexUo952QvYCGhE15bPsaGf7FaMq052mRBry37Zpb3BvSHyqIsWvtTbqf?=
 =?us-ascii?Q?wwr3jLHnxbj9Q852k21H+NzOXu8s1TpIYID5YolJCOry2PIAZ+5+enX1YSq7?=
 =?us-ascii?Q?mPiTgaNlaX9FxtkUT+MzkjdC9DPFylqoIKsc/asaKvbzoW/XZA1aGKtHChd9?=
 =?us-ascii?Q?aeIP+fOQYg9tZroUJo1qxttJ922ncSueD14asTEZUgG9qamzQi0daX8cf4SK?=
 =?us-ascii?Q?8C3/2BhGVuFUh+0JSoW0Hlc6ZTFEUmDYaSGvyeuBy4+YC7zs2PIpr1sGFjiK?=
 =?us-ascii?Q?eKUNsnwaPovS+DB7+5hk3Dxg0siBIje9sM0SUth9cMOordA3/uzsnIT2VGmZ?=
 =?us-ascii?Q?AeEHhdCCKOj0fHzPFihN8Rc4+dCdy/1ltc3w3tYMkyGkzSms5poNVDzhWJKO?=
 =?us-ascii?Q?Und1ivktkBmSVCwxj1Czh1QmBOGLlkvtIloXyZCM76wO8LRSGe7r63QiFvAt?=
 =?us-ascii?Q?BbVFcp1xdi7Zldww7MueDb+ra3TyVDeEJTJelqtJR0T+OP1VeU2ldAOMZAZ7?=
 =?us-ascii?Q?2WYYvFUtN/1BGNkpW1Jw/3QE0Ara5R0tSNCnTLKCkimxYXgKqeqamLopjgaj?=
 =?us-ascii?Q?/+DRQj5s1nx7oKVWdV4ABJB/kJDKOv25k5LOJhNAIUqdTKvWlk/l2lYC84dB?=
 =?us-ascii?Q?h1Gc79/Ku5wsXrV81ZVebmYRuq/+YMxRRNAfRyEzXEyRW6OlfAlF+TKUaPoN?=
 =?us-ascii?Q?nEYnK354Id37+Atgy7nyOLk6+7gmvB4hRC7WWhpK+6G7O7NdF5zDE7ZLUW0y?=
 =?us-ascii?Q?5JMWw9eSMgEPhlvSJsrVJ6HNj3F+8aML/hmG2nSWG/c+ikajBfMwGZ8UteXf?=
 =?us-ascii?Q?5PgACn23so+dVQeGUIeNkgzv0o4NECAlWCMBOAlh4GNS3w5h1nq0HNNrz+c6?=
 =?us-ascii?Q?72A72XdfylCq6ky8Ap2XDZKmVPEp/wZeGEnBk/mL7JARmbI/XV0PE7kfQRVY?=
 =?us-ascii?Q?cK4lJhdTR5njipXS8bbYFEfGMDT8k1VzRWl8GKgq1r05WizsC?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;23:cJLvh6YZYWMZop3XifqFh4f3YMIuKEtZjnCqU60gGrBUMBPTSG2+4qG5eAUa/g41xxOe4tENgYWw1MSfv6r9q2lh8dxzU+2CA37pLXO19LJzvAx1cK1l+oaDVJ64kzngAxhfYNaetJukwD9aSvtGlg==;6:i/YLTHtmOTnD5MW1S4dW3UrC1qUKqVi0oWEdbia3VNhVcZtzPRo5Ei00eMR+xqa11DZ8RwaQtsXKYjffHWh10/W+JCiex3XEczFkJySOf2wPtbRjU/SgL1VfORel0V9iDeocjp5KPGfbOX3DGUxrGInB5icSaqusazEZQ5PhbTqtQpanJLPpWCEz7xxDpBvLgTq/P3siV23/BISEAwDLHk+JIXDTeVwGA5LSmPT2UeJCUdza49EPUdIOUea63KQyQu8QweV/3pVyiI+jhAmB4g/XhAhk01pspwJ5Vm3fBrjWXBF2NzAnuB1pGYU5rGxi/OhzHxRIZmlKe+eRflXfxWy5I7YxCuwKuhG4APUIFRw=;5:KTLnDCTqtR8iqocMJy7uldHhvAnEc8jSBZnbaS7pi1mtXcBVfCIhHQLK/TkftkuVeClw4f+Se7mSu+N6Rret2w9SiLHHtSOrkHSlkg2XK7Wrk1L9ahzq3jGxzEkRz2fnf9RCrpZ3hQ5sU9LrFfpw8L/nwArSPmEZh3cnnZWGuQg=
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1980;7:RwL3fVnKi0xOa1YxaesfdR2yhOT31fdO02qLgqLF7IPyXvow08TItJTcYHcvfvRtWHS7RFwzK/2BgL8oM3wHgdgA1UE5xmIh8nCOpSqj3GDydZM5929Ie2taz8Q6HhbOQpb3RTgMI3W8siK8Gy+Sw31RbqMzB5JQMvAjTXxzSkzWKeXJ/4q1Yr08Wdtics+Un59JGFXPWZkaR4Bq01A7aCpRO87mJpKkZZOO5peq+JyljbnvQGRGY5/qIyf+6xqe;20:aW3hZKpz+AqGx2kfXquOyNrAqgX4zBbLPpysdukGwi6gEJnzfAjGGEy1Omip4M689DkhZA4ccqitEPCn1I9+U4DMYNnjHzj6WX4nD+XHxrdIbyTnqQzeVjwMQbFmuhLeFU75wZkObkZhwpfpIjboG+ZQtQLEH0AZOmLgi8gp6uc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2018 14:38:50.6089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 404104d5-8cb0-4e15-3a75-08d57eb8fbff
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1980
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 02:44:00PM +0100, Vitaly Kuznetsov wrote:
> When a new vector is written to SINx we update vec_bitmap/auto_eoi_bitmap
> but we forget to remove old vector from these masks (in case it is not
> present in some other SINTx).
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/include/uapi/asm/hyperv.h |  2 ++
>  arch/x86/kvm/hyperv.c              | 32 ++++++++++++++++++++++----------
>  2 files changed, 24 insertions(+), 10 deletions(-)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
