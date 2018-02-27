Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbeB0WQd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:16:33 -0500
Received: from mail-eopbgr40081.outbound.protection.outlook.com ([40.107.4.81]:10876
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751633AbeB0WQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:16:29 -0500
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=mellanox.com;
Subject: Re: [PATCH] RDMA/core: reduce IB_POLL_BATCH constant
To: Jason Gunthorpe <jgg@ziepe.ca>, Sagi Grimberg <sagi@grimberg.me>
CC: Chuck Lever <chuck.lever@oracle.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "leonro@mellanox.com" <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20180220205924.2035765-1-arnd@arndb.de>
 <1519161268.3737.12.camel@wdc.com>
 <F2FB1034-BFB6-45ED-878E-6FADD756157D@oracle.com>
 <c3eab137-1c37-0e6c-a53a-df2cf80653d2@grimberg.me>
 <0f90134c-3d40-1d24-711f-e4ab32802bd8@mellanox.com>
 <c1bcd5cc-381d-2d94-1278-f9fb5c9c0b14@grimberg.me>
 <20180227220958.GA21714@ziepe.ca>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <193aaf91-c9d1-38b1-a89f-45f129ca5798@mellanox.com>
Date: Wed, 28 Feb 2018 00:15:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180227220958.GA21714@ziepe.ca>
Content-Type: text/plain; charset="windows-1255"; format=flowed
Content-Language: he
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.0.7]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(39380400002)(396003)(376002)(2980300002)(438002)(199004)(189003)(76104003)(316002)(93886005)(110136005)(305945005)(7736002)(81156014)(8676002)(478600001)(81166006)(16576012)(58126008)(356003)(2906002)(5660300001)(36756003)(50466002)(8936002)(64126003)(4326008)(31696002)(86362001)(6116002)(3846002)(186003)(67846002)(229853002)(65956001)(53546011)(106002)(54906003)(65806001)(65826007)(76176011)(47776003)(6246003)(31686004)(230700001)(2950100002)(106466001)(16526019)(77096007)(26005)(336011)(59450400001)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR05MB123;H:mtlcas13.mtl.com;FPR:;SPF:Pass;PTR:mail13.mellanox.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;DB5EUR03FT063;1:Hjl89PbESq+/b9nf1wBESd0yMAgRXC70Us8p7JYzqINwZM7jRz8UJjrlbD8nHNdt9rJO5prx5pt2VpcPNCBOKmaAvME8h8IGvnjHSCcdngTAGj/AklDCRZFQEGnHkQF9
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d86843cd-4866-4b6a-130b-08d57e2fbe43
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060)(7193020);SRVR:DB3PR05MB123;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR05MB123;3:DWrzxfj1c4VHnfgQXpwk1ACRySguh2wxrTZtR170SJ02QsNyoGfHoFn5Qgz9Lyxu8eZkEoO+/T9T4PQ5B4c4jDhjT8aHoD8tuBirjKpdFgvw+pcMIKhp+bnxFLO6+E4MdS7FfIaWW913wUG8peKF3T0/3UCxJkRVr+YM5RWRBZH12SZBGaHpidvAUxhmGuhzY2ah3bImBbG/hgjcy6dY2eNVBIaFUYu/etoJV4xRsi6uAEoPQz3rV9bbS98Xo2Bgi7CrHtalhjjZb7D06AStRsJOV/0cSF8vpi4PSiR8Sjt99rWpmLhbkQCgMJxKdO/Iq7VnBeHn3eYAi3IzBFxAfNoGXjwBSFVDdtj93/+/uVw=;25:rH1fvOMO4p9yVjm5T19RSeV56kawFx7Udja9XEX69/SOW4hjc9kEgWxmKXmLstcbAQxHQFjF/OHzg5Dufpf4ZDif1p9Q4m85Nm80YXvEn0EeH5vyjPX6O1dQftl988x6WyDshY21skmeJFyuV/AFwN/olMb8O74NAF86MYhdgMxNrMGRyhEvNfLqHQnASn266fyTr9jpdPLy4ypDP+S/zdsh0fk66ohaCAZUBcMDfsaK6pBWfcPaU/wM6DRBt4S7EjUZ1Sz7TBoSUTFzpc3sUHGF/YlMormaX75E+yJ2YGjk7FK3VEMwUrTTM4nRqwZg2vq7nXFWqb8WjA45lu135A==
X-MS-TrafficTypeDiagnostic: DB3PR05MB123:
X-Microsoft-Exchange-Diagnostics: 1;DB3PR05MB123;31:DGVaDj/QUz0L9cO3sx+EhpC7CtRL1aS8xjcuPReoyObvyC3g2w+JpupJZ4Pg+shK0L9VLJduLR5jVspZ+fEshSorRVlPB3fbXPoTS11lYbhyY98G8c852yaefZYpPtZqt+p6etHIBHXMc9CWVORyKXPxkrGuqoNCK7+wL7V04XAufSqwJG/Q2rtEfOtrZpDJFdH/2TmRCwlP7dn9q11yK/aJcGa1Ywe/qiVsEeTrMtk=;20:EbUxab0DBAiD4b8NRvsPRihiTLqaXmepI7AujrhkXi/T9RLahxd9Y6r1nPiQbeGTgqQNaZKnYGmxCT9TnleYQa6fXfPDATfRwqHApSy7Vw3lc2px5YsTPh7G+fEdglZ54GHiTOrJD6g/Ss37Zqt1QduS2CcjSuIhSO5JNHAoNS2OjvJ6cLp9Ge17S+BjQJz5vg4X/J4yry65mTArJQw8ilVGe11F+0mlIbJswvmjit7CyueAGZjpCegokSTM1S5t+P9v2oh2aDhvpc+/iLPt8onZ3bPLVSDPVPJckCX+i0BcZkZabdr0lezXstS8WAi1T10nItkg/l3QU9MRO5q1ifO1vZWhzY3umIUQNwXB5MFrQiNxSuE9/wRUbSTROTfhTAiMFdeGPQos8CSGTd+QSAF+wiQ0yn8Ii0Dmu1GGmC9L3xGSTfHezdAk66I8sNqi2bS3rBjqzcyhSo1FP1/TRQWlOaXFfJJca2PxjCXM10M7BByKvKvfKhoX8Z0cPyMy
X-Microsoft-Antispam-PRVS: <DB3PR05MB123048D611E8F06D73D197CB6C00@DB3PR05MB123.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3002001)(3231220)(944501161)(52105095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DB3PR05MB123;BCL:0;PCL:0;RULEID:;SRVR:DB3PR05MB123;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR05MB123;4:jhmQAZMvWVSxUV71fCVcTy22ublCxdYBQAxlcTaByG+MeZlar8Ea39FUHtj7DEfYIH6xAi13Nv35uSxV1eu70k92Ksj5mlGcg+hqbwq7nFZRWDUHRI6yQgnxIGysiEmUTdaNDSb26X8WXnjkXuGk20JRwYmg9GzrgMEf8nBjG3LVcQ0i9kYO0yWFKncRr4Q8J8Oj5sTIxsnEIE65gAcX6zuAehfiMLoIUr+oJV4uGcXP1vvRsmoscloddVrHb2vdJPjg/N4qSt/r2fggzYshNg==
X-Forefront-PRVS: 05961EBAFC
X-Microsoft-Exchange-Diagnostics: =?windows-1255?Q?1;DB3PR05MB123;23:9nZLLeA6sbB66oSSTXorL+hFyqezHjOn8BYFew?=
 =?windows-1255?Q?gnfwAnBSs5q050KftRzi+rkFgcOKArLBSm7TTOv9BGkDzWN7vk97Am1e?=
 =?windows-1255?Q?l1lq9bg84x3EztkXTbeTXM/tuLJ9EYWWgxBkGTKNzC5KMuiumO5Jz3F4?=
 =?windows-1255?Q?ilvx24mwAesrGchLL+B7cf5/fc1JJQgsVEm6sStdOpC6clTmGD3MF9mC?=
 =?windows-1255?Q?t7Rk873LDH9a7BoiDoeYwoxIHCqhGAR2LdajAFuAS/yihikHgKE3L4Fc?=
 =?windows-1255?Q?1ZCWQPBvXP2Sv7dvBhod9OcoRk+iThoyBPLUyorwUdeoap8c58KnGP3p?=
 =?windows-1255?Q?4IbR5Yv/G60FT8RCmxu92JDhRkQh2Wtg1ajm7gaQdIi2W/5I534gdBcE?=
 =?windows-1255?Q?wmr4Ac2Q4niVRy+99Grk+qkVmgPOOsgxQAeD6iSeKOp/taVUSKhDORYa?=
 =?windows-1255?Q?IA2cX1sDjEJJmLAl1e71kweSL1OA9USlWFIk+OmHqiLlne42Ub41HbWq?=
 =?windows-1255?Q?+y/5s/hd4sqiuWvEnsCAx/93YB0J96EfQkjgGUVSfJHqeag15F1O6z09?=
 =?windows-1255?Q?3q58BgJV0vLFmBG1QqigIzgDz0pgETi6FzLVBasiJ9bHgz0ETtYa96FW?=
 =?windows-1255?Q?Z/XPUk9jBY3e9PSi4c0Q4+X40A1c+asmZmvt2B/9NXHc9l0Ovq/HnKGY?=
 =?windows-1255?Q?O0qJBY3mnKg+bH4m4CDeNoW6amibeabVKsrS7Mu8OBd8m8FOLxT8r4Hs?=
 =?windows-1255?Q?V4IhwkP5WhlEPXashoMnSaVh2ydDFUnfCXu+IjD4/+zsKdPiZUkMzJee?=
 =?windows-1255?Q?UniuvbyITGjyP+T2MpCTWo+mly5TBSjhPKCrq0vcTQVojyk2CeqvzJDs?=
 =?windows-1255?Q?+Dbia77Px4QHOVzRv6VuG45p6kbaQSnXzu5QnSEGcq14HAsJM0nPgrM2?=
 =?windows-1255?Q?RC8BE7dgqgTmX0T/RcDGCN5cy7gcnACYE0xD5C9x4BzOzJCLpQYPakwn?=
 =?windows-1255?Q?8Q6jlCuVbv+2NcRdCMpsREUNnf6lHgaHjYv5B0jCEXOsYxIrM5e8EY1D?=
 =?windows-1255?Q?GY1eINbTdhqvBXbNz45txVyOSeoUNEW2MoOMk5ZdbnScY3pSq/HEdV7F?=
 =?windows-1255?Q?GHDVsHpwmnFNPjoBjYP1IiGQgf9Gq1t3+gp1pV57xEuqlc9dxvDdl2KM?=
 =?windows-1255?Q?rVVWer5j8A6HHlXRrj018xARpr3cfhbjhjHwVkkiyBDsCLGyzX1SmNgK?=
 =?windows-1255?Q?rgnTsl6JVZlmjWCCuN4tTF3OfK5thcWs86URb80D+PspX4y/nziBOsej?=
 =?windows-1255?Q?RRB7b7McSrfwxXQcX5uQfdV+EodUi1ctH0ooIOzf/+rhdStBr/6e/Fjv?=
 =?windows-1255?Q?cbB50K50cY?=
X-Microsoft-Exchange-Diagnostics: 1;DB3PR05MB123;6:xJtqO0I/5qt1tyX/EkAPwzWzk488uJB6WWihwLUSqRgkaO71IBO/uDi30+sHZn6Z7zZtWPsoSlQ0SDhm+YOQemvnU5LKOga+19E9OicZJnpvkniIr7GLtxF3bYPfiMaZpv0m1dHZJOjBmyOcd1ooeBKHncBYA7RBdig4BpxWm9uZo7Qy5HYs7S0hYLV+DSwEwcv+dhlobZfn44TVRiMkdeG2PtToTFNro+aijR799vSLXhqRuQf1zh2RzderyI+GbJ8kZSFiP2+FkeGRS0FXt6NN9MTL3DNDg0UuXG2rl8xJhR6Idk5W/0eemcrwzwpNm1OZ9dHLVH+aLmLtPGW4yB1Knxvt2HO5Lb35UtDOj/k=;5:a5vhYsRaO7MaepivymAbIOBT0iTdk2gldW8Cx4H4fHfzTqYetT7dtztFZCBMxoOtk9wl1c/FCX9qtM9sHPIFNQQtQTdT8jN5E21DRnAt1a9C+H3EAP1+fkrmbmmXYthgU55lEmQNqUc/biEbWaD3lKfvfse99PIoA69Yk6lK5Ig=;24:MaOseLBlupEyM9qpn+yJlzRPwTkx2KuxS3PMcrtJo0bDm0+hWnRaLa4Gp6n2k2L+7z9J7AvfcNt18HpJNBStxEW5aKWSk5Mqh4h9sg3yf3g=;7:0VgDxVZzgamNXypo2SSY4klx93PByh7Q6UQx8D3kl1wBfRhpe8DuKmMOQQElq/WSCbQJdcUCtyRz3aZjNaRIE1yRjrSBE3syvgu9CillPn9B67MAH5un56zP263NyvqPnmI2+3KJZalRLcfLTchZkd5RaHisTnyBFjaqHhX03YnbYgjmpvl4SqFs87/QkmHQl6UIuhmriDfVj+L2FwjX6wKGyZrJs3mai5uYqeSludODhdfZET9JKijrvUTueU3d
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2018 22:16:26.1547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d86843cd-4866-4b6a-130b-08d57e2fbe43
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR05MB123
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/2018 12:09 AM, Jason Gunthorpe wrote:
> On Thu, Feb 22, 2018 at 05:39:09PM +0200, Sagi Grimberg wrote:
>>
>>>> The only reason why I added this array on-stack was to allow consumers
>>>> that did not use ib_alloc_cq api to call it, but that seems like a
>>>> wrong decision when thinking it over again (as probably these users
>>>> did not set the wr_cqe correctly).
>>>>
>>>> How about we make ib_process_cq_direct use the cq wc array and add
>>>> a WARN_ON statement (and fail it gracefully) if the caller used this
>>>> API without calling ib_alloc_cq?
>>>
>>> but we tried to avoid cuncurrent access to cq->wc.
>>
>> Not sure its a valid use-case. But if there is a compelling
>> reason to keep it as is, then we can do smaller on-stack
>> array.
> 
> Did we come to a conclusion what to do here?

guys,
what do you think about the following solution (untested):


diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index bc79ca8..59d2835 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -17,6 +17,7 @@

  /* # of WCs to poll for with a single call to ib_poll_cq */
  #define IB_POLL_BATCH                  16
+#define IB_POLL_BATCH_DIRECT           8

  /* # of WCs to iterate over before yielding */
  #define IB_POLL_BUDGET_IRQ             256
@@ -25,17 +26,25 @@
  #define IB_POLL_FLAGS \
         (IB_CQ_NEXT_COMP | IB_CQ_REPORT_MISSED_EVENTS)

-static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc 
*poll_wc)
+static int __ib_process_cq(struct ib_cq *cq, int budget, struct ib_wc 
*poll_wc,
+                          int batch)
  {
-       int i, n, completed = 0;
-       struct ib_wc *wcs = poll_wc ? : cq->wc;
-
+       int i, n, ib_poll_batch, completed = 0;
+       struct ib_wc *wcs;
+
+       if (poll_wc) {
+               wcs = poll_wc;
+               ib_poll_batch = batch;
+       } else {
+               wcs = cq->wc;
+               ib_poll_batch = IB_POLL_BATCH;
+       }
         /*
          * budget might be (-1) if the caller does not
          * want to bound this call, thus we need unsigned
          * minimum here.
          */
-       while ((n = ib_poll_cq(cq, min_t(u32, IB_POLL_BATCH,
+       while ((n = ib_poll_cq(cq, min_t(u32, ib_poll_batch,
                         budget - completed), wcs)) > 0) {
                 for (i = 0; i < n; i++) {
                         struct ib_wc *wc = &wcs[i];
@@ -48,7 +57,7 @@ static int __ib_process_cq(struct ib_cq *cq, int 
budget, struct ib_wc *poll_wc)

                 completed += n;

-               if (n != IB_POLL_BATCH ||
+               if (n != ib_poll_batch ||
                     (budget != -1 && completed >= budget))
                         break;
         }
@@ -72,9 +81,9 @@ static int __ib_process_cq(struct ib_cq *cq, int 
budget, struct ib_wc *poll_wc)
   */
  int ib_process_cq_direct(struct ib_cq *cq, int budget)
  {
-       struct ib_wc wcs[IB_POLL_BATCH];
+       struct ib_wc wcs[IB_POLL_BATCH_DIRECT];

-       return __ib_process_cq(cq, budget, wcs);
+       return __ib_process_cq(cq, budget, wcs, IB_POLL_BATCH_DIRECT);
  }
  EXPORT_SYMBOL(ib_process_cq_direct);

@@ -88,7 +97,7 @@ static int ib_poll_handler(struct irq_poll *iop, int 
budget)
         struct ib_cq *cq = container_of(iop, struct ib_cq, iop);
         int completed;

-       completed = __ib_process_cq(cq, budget, NULL);
+       completed = __ib_process_cq(cq, budget, NULL, 0);
         if (completed < budget) {
                 irq_poll_complete(&cq->iop);
                 if (ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
@@ -108,7 +117,7 @@ static void ib_cq_poll_work(struct work_struct *work)
         struct ib_cq *cq = container_of(work, struct ib_cq, work);
         int completed;

-       completed = __ib_process_cq(cq, IB_POLL_BUDGET_WORKQUEUE, NULL);
+       completed = __ib_process_cq(cq, IB_POLL_BUDGET_WORKQUEUE, NULL, 0);
         if (completed >= IB_POLL_BUDGET_WORKQUEUE ||
             ib_req_notify_cq(cq, IB_POLL_FLAGS) > 0)
                 queue_work(ib_comp_wq, &cq->work);



> 
> Jason
> 
