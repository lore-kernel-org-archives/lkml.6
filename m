Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2F9ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 19:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C096C20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 19:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="gZ8VaKvY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="J4N4fgoh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C096C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbeGSUjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 16:39:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52658 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727539AbeGSUjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 16:39:00 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6JJnPbe007022;
        Thu, 19 Jul 2018 12:53:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=buJkqeZWCacNEUvWO07bHmW9EcpQ3nuyOMm7iiTjmoE=;
 b=gZ8VaKvYOmZI1BnIHqMKilIOTAamCrF1XZtDraSHwEvxRKptGS5JYJBrkY1W360H8GCb
 lTJZLc/IE+V2G9OQ4D87fqgURr/AxnqBWsjMls6NFWRBeNGILleBvvzpMB+5iWSEDOgJ
 ijnXDT4fY3JXt/Rnn5iSy1zqYsvxp96qmEU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kax7c0hys-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 19 Jul 2018 12:53:48 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 19 Jul 2018 15:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buJkqeZWCacNEUvWO07bHmW9EcpQ3nuyOMm7iiTjmoE=;
 b=J4N4fgoh41IlFzCTvv6Vd0mGI1rBaQm/s7mj5ntVHRRQkBPZz7UyqGu6e+ZKGo0c8+opHksaD0rML+FBhLdYxAvkChmAmmJOnIUj8aLvfM55wUaD3Z1Ae2oFB1q1275tgXoCtJ9rdXzsYnnX2BkHg1/Gq6TO/KikjX1ZPgyBbZ0=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::5:7d2) by
 BLUPR15MB0163.namprd15.prod.outlook.com (2a01:111:e400:5249::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.19; Thu, 19 Jul
 2018 19:53:39 +0000
Date:   Thu, 19 Jul 2018 12:53:33 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: Re: [PATCH v3 0/7] kmalloc-reclaimable caches
Message-ID: <20180719195332.GB26595@castle.DHCP.thefacebook.com>
References: <20180718133620.6205-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180718133620.6205-1-vbabka@suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::5:7d2]
X-ClientProxiedBy: MWHPR20CA0032.namprd20.prod.outlook.com
 (2603:10b6:300:ed::18) To BLUPR15MB0163.namprd15.prod.outlook.com
 (2a01:111:e400:5249::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4be9457-1251-4f11-0552-08d5edb153c2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BLUPR15MB0163;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;3:wJ5W5i2+8UkBOuHxf5+H42MIV6VJzius+OEHrvHtSfMRoxDMJV4ZkK318KaAB4h6ZPFu4x88QPKfTU71MaMDNZrrzPnur5YYgRs4CJL04R1nNce6P1wZ2k6nM7ubC4ajTH1GRhJSUybFilo53g1bOZ6LX1NLsdu6yJ9/DaaHE25Ueu1e6OG5IY2xu8wDIxdkxjZ/s3IN4erYZo909APm83hEdO1CUZl1zD2cnQY8TCt/dE5EduL27SV9DfdR96i9;25:x5wX83s6S6HZWPhv/GLnMJSJTCb60qoJ8FzqnBnE6hewXQS2eYACbPmDv67Sh9ECeBv1T69aSL4hBvaLwQbTxGrb4yh+SrdND8omrePZ2QVvRcyvQXI+llw1W9jVtirtjXh7x+tMaLJYaP31GCD/tzsQynVNA+Bpfb2ivBp8e/Q1+wN4LBaR6ZQylWbuT9Tv/fICiQCgCtFlMSskeGgZcS80R/xuMFCw6HVKNlRCRf9pqGVUjXWbGUBsrz33u1qdCTIh+erhiz1fNixn0ebpuCjU+wefdOq9tBF9EwPt673JiW0eccmVoQsTefUpsjJU8mc0G+yR4CAZ3vRErI4EDA==;31:Gpg2R4TWDllwZ1hD+DTqRzmKU3yjCqR23YG4ZxE3UzrxgwdEkR8TnyK2jjWqYTg5bb+0mWnYLh5Er4Jd9SojX5fORaJSMd+gFEHYXHivk+fqEJ1EaM7XTMmQhU02Mlc5AcK0vqUQaP+dBlo/k8Zrj6Cu1MMxurA0Fj3AYy5uulSoB4k3nFv2BO9OAuQl64+XEwcr1Zs6q2n1CjtqKzChPcKZ+K95jB455fyQdIZWXv0=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0163:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;20:wcJKroY54iSJxbpwwj8BW8n0qc8XiWC/8Fh+RjXWDykUaJeZrbKx+pmtpW9XX0Wr8RVVqGqNxmiHAAaEWY6RUa33q0VAoaiDu19QjuWIbr0dFdnjbG1qzUD3I+DAb6SDQF7DrP1R5DBZKZlhUJyZEqEQrPDEiw5TcK/nrbR98LOS920ldgRI4c5aa0q6QBCXy+c2YHpsYEIjGQ+vC6fpQ0T8d+eTvR4kzjQUwaF+ZweR7aOcAmdOjAv0xgTdykg7jQcQOgDGb5mwigoQCkxLpcjoU5QsqDx2MUw4YZggbTOVawWQAyrAGRqW84IMcCSeVaPZ/R1sYld/1kOiS4Q9d00S5MG0VREhMB8h8hGqS3OGFaeXN0UVDdWlXSnUg53JdBF67ds7SFKgzyv0nRmwyFFYkBH/DMRPOCQC0768dXP2Uvtdy1q8LHcLuBXv1wQFRHdrC/0fl3MWKOzapxJfXNcOiLcJWcKCYSfhU9w6pgafss9MHzD24K3O+WNeCUYe;4:2QG036aYz5Tu3jbJdrfQwpE9aipt377skk8p1Ey5NnTZhIDLNtjAVJ8hVFqdsvIikfE1PtWYVCiOmaM2IhiNY/FMC7HQbYbfuipvNr7OywM6g3cZurUIBh8XqZ4YqZCHkaIH3kFcObfUqM8TSrg1ytz6nxNzXSYl+ZpmvWhtdgi6y43Uw7zob0Be0Yk8MS4PmU5095ojxYwbI9Ne5bPzyA6Dg9p8vrgX1U+QdlOkadunmhHADZFOAmVSKQU6rhZh2peh9tzqIScvip4ROqd1pRlvx0/Vs7Tu1VHS7Xv9TOwz+NIyeUlYwM/WUR0xIBX5dRYzCgIv+/QLibTQYLBfaDz+kSoOk7ox7VALLZOmMVk=
X-Microsoft-Antispam-PRVS: <BLUPR15MB016321114F2F191AD880E8F5BE520@BLUPR15MB0163.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BLUPR15MB0163;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0163;
X-Forefront-PRVS: 0738AF4208
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(68736007)(229853002)(8936002)(106356001)(105586002)(6916009)(7416002)(2906002)(6666003)(33656002)(478600001)(5660300001)(53936002)(6116002)(23726003)(47776003)(1076002)(6246003)(50466002)(7696005)(97736004)(4326008)(25786009)(8676002)(6506007)(386003)(55016002)(446003)(186003)(16526019)(14444005)(81166006)(316002)(54906003)(16586007)(9686003)(52116002)(81156014)(476003)(86362001)(7736002)(76176011)(11346002)(486006)(52396003)(58126008)(305945005)(46003)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR15MB0163;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0163;23:RuefyWYOPkQbNC4fG5ujtPHv/F6PZPgLkiub1Bf8i?=
 =?us-ascii?Q?L3sGm3b1RfMSahucH+eVVudoT5rWe7KvgFIV3TihePL+8J7/JX8vANThGxyw?=
 =?us-ascii?Q?kEO0B/NGGQnoSLTkKpKBRZZQkz+j4b6DHhvRutFxhtXzqvPcv91s55oWqNpO?=
 =?us-ascii?Q?PX8K0D1PacUmip7oNdF3EYTfU563MIFcPGmxOsq53szMVF9YmE/vq2SZt1M3?=
 =?us-ascii?Q?Gs4vpPJPCcq2Q2RQ8yjjDsmWZy+WAqwGkpMg3aVXZnUKQpB0dms+1Rje8yAW?=
 =?us-ascii?Q?iCXdpLBf5hemITRRuDpNT2FHa7DVovn0DH0TEtb/HSN7SYOz6ySI03+NaAUH?=
 =?us-ascii?Q?Dc/EeoclzLakmSTRo+QvvwVjtbVBs9+VBZ6Gw4GOILyBwekFXDJQzVuoJ7L4?=
 =?us-ascii?Q?OjmV5THxWfkvCT/qN1Oew+L4JGdN0rlPqUVCsrhxE65vkYwDcvw/HUsNNqjY?=
 =?us-ascii?Q?lqh5i9ca88l4wTXbiCp8qDCkmI85JT3Fz9b39KVAFdalkr5eVKV1TSHEqjkX?=
 =?us-ascii?Q?nXkcaiy/8HOCp/zrUpOCwT3JYhmbAc0ZZOmDlEjLDE7HINACb7oeNOpmUyJg?=
 =?us-ascii?Q?GE28kWorIk3vw+lbyAWjPTz9HBCMvKImKQsGBcMLVLjbNeqIAtxgTB5MbD5g?=
 =?us-ascii?Q?hr1a/IcEJyOX+sn10NWdHWtjBUNDsh10Fp0V9U7tVFHPYmPjtV0uMQxT2mnU?=
 =?us-ascii?Q?6UG8mwkqg+/wBpo1/B2vVBsP907I7Pm5D+NLFvH004CXixmA2IsCQOwEvfzl?=
 =?us-ascii?Q?fXBynSSE9pt0VcFEMmLqQwNdRM1+tvI8JESPIGRXU55nKmhYDPQzLx15+DZp?=
 =?us-ascii?Q?eNScMjmGHTCpIImu0jOW5XjdFIMYFcu9JGUTh5SYdkYX0LJveTjwYGYwYkXZ?=
 =?us-ascii?Q?pcRsrVDTZ5aE7cKno0H/5Tz2T5q0NrrkKuZc1T61fQmyycxAUk6wC9SgHgXJ?=
 =?us-ascii?Q?NVaccxAA6tq9tlLUpcmAoUWF7l7B7xecW8/TecJ7SVpOwKnmvwTcHb+FEbPS?=
 =?us-ascii?Q?zKvGGoW5w2ca8Ce6aWhYsFCO3Cmoaj97pumV8I3swah5fWsyBzs5ZTt1U8i0?=
 =?us-ascii?Q?bYI+QxYoa6S8YJ5b6SX15bZJyzq3GeN+Y7OJzV+6gcP8TbYrIGk59x+su9PZ?=
 =?us-ascii?Q?3dVdE8r3RPKDOOt8Z28j4a8Fst4L+M4p4etYgYaKfcZuGcXB3SKmdHqF6eBr?=
 =?us-ascii?Q?7d0rAt0t2j2gtrRekyfqRK0JkxwKNYAH1wbVwv0d22c2K0DYR3dGOOWUI8Lr?=
 =?us-ascii?Q?mCVsdW6uMgdifs5NLGxsQlC9uB/223kQdaxVHWH?=
X-Microsoft-Antispam-Message-Info: toNzPB6C9B5mkGHuCr5k9EV4GW0K31h7L1/u4pXHD4bta5G1rvf6BpQBg2/gE+c+VqXvUAuG48Dzdx9nuVF5jE2ERQdGicO57RSb6xWrnb3iqz/1RngINusPNgpiBzgOmg1HzHK0NRnq8jS5W/0scJFARwgH2i7WDfxwtTTrQfEw+3ak7GTNiVWfb7X0abyrtsBAV6lodWKIU1BtItdQ1qvxDdYPILfujlBU4Lt5VL1Ge8olAffXqd+8W2Q8FbMAuAEAz4fSsHKuM+PaupZDWJicJKxiQQsQn63B3pukIvxVwX2z5cKcwGzkFTAQ1yLsHt+8E/XTw3PF+7w8BLQ2q20dz/P8YLtGGMzB5+QNTIQ=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;6:sOw9Eed0/YXUomR9d8wTIWjirrxvkmmD/wO6S/s8rVvRPmuJQ4dEhpSIEXBrL+CxcpdGvQLDLsYOvDQq542LrkE6o6o+9+BLxkuIJciN9UZ7TXrg90Xrs1OsaPyxHEqMlc9P5ntO/Al0yr6Fe0QIgHosyAXgwYP6PMPJ/WjCzktdYSTzsu4kfHdCP5Wsu48dC3JhU8M7oaiULNVstPM9EFwJXFwa6XIYIaH1T0CATQqYZy96K/Ue56K7DR/V6JUP4ExVy4qB5IMVnDvcInFxi67oDxOMni08oR98SydkneVMvMB3Nkuq1J41fM5AZKiA5FHhMXwgc0rXQ66o/s4jkLcEDvov/ByxPvQ9lHgExFCsHH4QLa+zVRPtm6+UWv84/waT9yFM9CSdo0MCmaGok/yBmNbGM3DMDPmxDR8ewIAR0LNUiuSDj9DJIqxypsEQupOgHL6d4x17CmdsyW1ONw==;5:jIAN5CAscla9ROWPwhwz8hxJmc4mM1rIU7QjSNsRInMBDTu8gcdcMCK8jmcHSYyZb+HNIZpGNDkF2EyJCr4flEO5Ax0CzTaPLxwlj1Fa/pCbRk8GTuskOlxIfEjZjXdk3aNInZX6RfSPWB+x/mIaEjXOwAR/bNviyn+/JaL3gOY=;24:AInanIPfHFZ7nZNcOymRvXamCajN8W0hXpbzDd2PqrFakUvZaazQB1LngwTKA6S4bKLpqc5UDeHXNuEaDlH1yAzxe8NfmLIK7wZxHmyzKuw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0163;7:jZZ2z7W2a2t/Uwgo3UVvMfeXAcVpZs8ZcMS33y8m+Ug9HzFp66zb6yuye9cyquGC48ujZRYEHiLzeFzPpkQoRVIO3ohvWKAd4TV3AovP6bizW7/zNejn1xvvb4xN+V1t1ceeBXByIKUXbwbrBZgYY482lZgqGvHT63+BoGQAh6s4OW7m6XabYKSgLWbGhyJY1Edu7vMk8v+0itEE5ukN3PyXpiBzCty0bKaBsFkC1xAD4K1aw5axArpzysL+lwAv;20:+QHvMhGezsJg0FaB3QpQIgyoW7QlsFq+0NiYg4ZWoAnTcNHbW56CNgQw7u0Fq/oCeLlzB/zgMeya6kBvGwXEsSnLoQMWvtjq+DXZ2vAppYeSMQKrrkRs1GSZGUqfS7X3cg7/58kcEDpT8wSbIurqz3Xla+Ovp6hBMOvLwsUq+lw=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 19:53:39.3644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4be9457-1251-4f11-0552-08d5edb153c2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0163
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-19_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 03:36:13PM +0200, Vlastimil Babka wrote:
> v3 changes:
> - fix missing hunk in patch 5/7
> - more verbose cover letter and patch 6/7 commit log
> v2 changes:
> - shorten cache names to kmalloc-rcl-<SIZE>
> - last patch shortens <SIZE> for all kmalloc caches to e.g. "1k", "4M"
> - include dma caches to the 2D kmalloc_caches[] array to avoid a branch
> - vmstat counter nr_indirectly_reclaimable_bytes renamed to
>   nr_kernel_misc_reclaimable, doesn't include kmalloc-rcl-*
> - /proc/meminfo counter renamed to KReclaimable, includes kmalloc-rcl*
>   and nr_kernel_misc_reclaimable
> 
> Hi,
> 
> as discussed at LSF/MM [1] here's a patchset that introduces
> kmalloc-reclaimable caches (more details in the second patch) and uses them for
> SLAB freelists and dcache external names. The latter allows us to repurpose the
> NR_INDIRECTLY_RECLAIMABLE_BYTES counter later in the series.
> 
> With patch 4/7, dcache external names are allocated from kmalloc-rcl-*
> caches, eliminating the need for manual accounting. More importantly, it
> also ensures the reclaimable kmalloc allocations are grouped in pages
> separate from the regular kmalloc allocations. The need for proper
> accounting of dcache external names has shown it's easy for misbehaving
> process to allocate lots of them, causing premature OOMs. Without the
> added grouping, it's likely that a similar workload can interleave the
> dcache external names allocations with regular kmalloc allocations
> (note: I haven't searched myself for an example of such regular kmalloc
> allocation, but I would be very surprised if there wasn't some). A
> pathological case would be e.g. one 64byte regular allocations with 63
> external dcache names in a page (64x64=4096), which means the page is
> not freed even after reclaiming after all dcache names, and the process
> can thus "steal" the whole page with single 64byte allocation.
> 
> If there other kmalloc users similar to dcache external names become
> identified, they can also benefit from the new functionality simply by
> adding __GFP_RECLAIMABLE to the kmalloc calls.
> 
> Side benefits of the patchset (that could be also merged separately)
> include removed branch for detecting __GFP_DMA kmalloc(), and shortening
> kmalloc cache names in /proc/slabinfo output. The latter is potentially
> an ABI break in case there are tools parsing the names and expecting the
> values to be in bytes.
> 
> This is how /proc/slabinfo looks like after booting in virtme:
> 
> ...
> kmalloc-rcl-4M         0      0 4194304    1 1024 : tunables    1    1    0 : slabdata      0      0      0
> ...
> kmalloc-rcl-96         7     32    128   32    1 : tunables  120   60    8 : slabdata      1      1      0
> kmalloc-rcl-64        25    128     64   64    1 : tunables  120   60    8 : slabdata      2      2      0
> kmalloc-rcl-32         0      0     32  124    1 : tunables  120   60    8 : slabdata      0      0      0
> kmalloc-4M             0      0 4194304    1 1024 : tunables    1    1    0 : slabdata      0      0      0
> kmalloc-2M             0      0 2097152    1  512 : tunables    1    1    0 : slabdata      0      0      0
> kmalloc-1M             0      0 1048576    1  256 : tunables    1    1    0 : slabdata      0      0      0
> ...
> 
> /proc/vmstat with renamed nr_indirectly_reclaimable_bytes counter:
> 
> ...
> nr_slab_reclaimable 2817
> nr_slab_unreclaimable 1781
> ...
> nr_kernel_misc_reclaimable 0
> ...
> 
> /proc/meminfo with new KReclaimable counter:
> 
> ...
> Shmem:               564 kB
> KReclaimable:      11260 kB
> Slab:              18368 kB
> SReclaimable:      11260 kB
> SUnreclaim:         7108 kB
> KernelStack:        1248 kB
> ...
> 
> Thanks,
> Vlastimil

Hi, Vlastimil!

Overall the patchset looks solid to me.
Please, feel free to add
Acked-by: Roman Gushchin <guro@fb.com>

Two small nits:
1) The last patch is unrelated to the main idea,
and can potentially cause ABI breakage.
I'd separate it from the rest of the patchset.

2) It's actually re-opening the security issue for SLOB
users. Is the memory overhead really big enough to
justify that?

Thanks!
