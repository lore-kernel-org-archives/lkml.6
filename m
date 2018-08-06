Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95F8C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED74219ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="KeWGHiuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED74219ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbeHFL0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:26:14 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:36046 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726572AbeHFL0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:26:13 -0400
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w769BDsF000403;
        Mon, 6 Aug 2018 04:17:45 -0500
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp0180.outbound.protection.outlook.com [216.32.181.180])
        by mx0b-00010702.pphosted.com with ESMTP id 2kn9y5kk7p-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 06 Aug 2018 04:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fi1zKmjC3cA3NaMmBRcIlfEKfyVT8h0S3dzDT3k5AXI=;
 b=KeWGHiuMS/O84Gt6h1I9YbKsrsq7MPXM2PWf8BCaNwMoQWHbUaq1o9CP9pViVnwyHXUXIJQA+MLzOghkIprNtf0hmiSTkyd5i8xGbYrcQjUSwLyMPMyBbUSTDxlrjkLVyZ9MQffPjExfhA+JneC9S7+YDcfFNG0+W44oXI+j+Ro=
Received: from jcartwri.amer.corp.natinst.com (130.164.62.116) by
 CY4PR04MB0966.namprd04.prod.outlook.com (2603:10b6:910:54::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.18; Mon, 6 Aug 2018 09:17:42 +0000
Received: by jcartwri.amer.corp.natinst.com (Postfix, from userid 1000)
        id AE52B302144; Mon,  6 Aug 2018 04:17:38 -0500 (CDT)
From:   Julia Cartwright <julia@ni.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Alex Shi <alex.shi@linaro.org>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH RT 00/22] Linux 4.9.115-rt94-rc1
Date:   Mon,  6 Aug 2018 04:17:16 -0500
Message-Id: <cover.1533540554.git.julia@ni.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [130.164.62.116]
X-ClientProxiedBy: BYAPR01CA0026.prod.exchangelabs.com (2603:10b6:a02:80::39)
 To CY4PR04MB0966.namprd04.prod.outlook.com (2603:10b6:910:54::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b911249-87cc-45e5-5130-08d5fb7d769a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY4PR04MB0966;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0966;3:soGM0O7OuYnG1RCVb2b2ik6XQpRD7Kbzm0gZsBIPb344NsBCM49oXDJEZfSzHM1DCGrDrjm3UX6jVw7/H8t5OAhDS8NHDZQssKC8xscmbOMPskH+cF/84ejkzK17rOhsBGWy4QELfh0AT+390Z3ZDMi6vcXCwf/uBbZQGTNx+Et71u+HFkDjzPXBVLLOeQpJ0dJ9psmS07QV/EuBVPw53Q27c2CE9C0lhh2Mr8uYsBduKT1R4PHMaPGsqonRebGn;25:7F9jm9NV6Yti5DaXVdCawUwsAHzw2MlboDWXLHSILi9I4PqKzSmKtoYpxq3lw+e5wxREsuIOFjEoo94rO6r242irbuakOHqje8hX2g70Q2XwRQx9zvgkvx0IuTYXMGdcPunS4kWIikagilR/g9K3n7oEQK/ME+kjABv44BWrPlVgg119QWJjllXAONNCiMmoLqb39BzJ2buBNzq1/1oMZ+8LHhMKsksvx4+vcQb5ZAphp2MgYq5oofoz4l7igVEdhGxRXNaKq0yKzefeeB04MdPQKosbA/Ujyr+L/l0m/tCGovBAdmIwkj8mNenACmvc5HmsxMY4CN1fGAlVDnhUSQ==;31:6ggUABH8lmb3ADNgINsdUiBDeNtVmG4NXxht4TKrH0Yw+pqk76vnnKsBUU9FgEG8XojevwfdTnekXUoLH2QEcBeUucsLfE18gy5/1CIuDlzfAlzCFEzphaRLxPpvpxCuZ3IhRvNw110ZLa3tKNgN20qCKw3Skp70gfLk/GCQ0qvt08CCZUXY/qyBgxnaQTvPJOkoCmWABwMgNJbBvO72aF7W1CBAzdo+7e/kpPP1gHw=
X-MS-TrafficTypeDiagnostic: CY4PR04MB0966:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0966;20:u5Lj5IyU7jOWCnVQXY1dOvLbNXgzYl3I3cLrS6fq7lzH/NdYLfydIAfAnlRJnI1+yRqXsdLHUjD7l/U9hwnpZziFu7/0GvssOdd6heoZHQhiuAb/zeN76N1IujUkqAfaUVEO2pnt+U7wyWwe1p+bdMh6CAjRGyhdLi2ODFgZdzbfNaMdZCaOYAGA2h8iEKR1vvfRn0/rxAcfATqxWCiN4K9q5rKLm4OCzmZ9+oihgxZz0DODuMffOBRz8X4JGxeyWy/dvcWE+zOqo73NCndnFkVLQrLhLViDUgWACtmTGKB9JtOwKm0pYhWjZHU8ekf0CEAqdcOgndXCMQCfGR/1PsAVWkZWhVTw0AZSnBshxI4ilhfg4P0GuBStCN2Kux9rSp4MCzVs8FiMfP9ZMASSEg60Cekl6JPAZcDlozHB9G9m9sS/WvYmWWDfexsMB1PkH1Aaij9E35oggXfC6rSiAAL/K+zYA4SfzFOoeHG6DPI5Qz2bjVVeUbycD5tznaVUVj5d3d/d+tgZr/uIZw/IFaNLkJ2LTyVLmF5aSKFJoFRZGabMMUaBruKbbhQmRyXn1P1cOOZP6c6kmGqMu8V9ooa6yJNJZLcnd3LNJnhgfEU=;4:qfBPi2959cu3ZoEiU/X9TCZsPMK9F3Zfdqws8xQ6ztLh/iPoEhHMN//L6JjkMMYUdXYK0gfkQwam2Qajogp5uVhTwbcvYt/N0H3KEhB6ltwDhAZO5G4akBLKcx1bOWxDb3BuEwJExNGgB9Ob8eoqyC2rLW1yf5QqGhCSC8YPGm2sOhSiodD+xdNgEWeNKMPyISpa6oNnlLCBgurX/0u58jp5PMxkxSxOtma/4xNEJfpeOmuaX2hPpmIr4eKsBH9G45gU7cDejvn/rzWdEb3AP3aCFnp6Q6uyjfM3sFTnJwX8nNXFgi1yj42RTsbMjWdh
X-Microsoft-Antispam-PRVS: <CY4PR04MB09661EBA5627BB80A20E689EF4200@CY4PR04MB0966.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(5213294742642);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY4PR04MB0966;BCL:0;PCL:0;RULEID:;SRVR:CY4PR04MB0966;
X-Forefront-PRVS: 07562C22DA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39850400004)(376002)(366004)(189003)(199004)(42186006)(52116002)(316002)(966005)(53936002)(122856001)(8676002)(2906002)(23676004)(81156014)(105586002)(81166006)(106356001)(2870700001)(4326008)(6306002)(478600001)(5660300001)(50466002)(66066001)(6666003)(52956003)(50226002)(7416002)(90966002)(6266002)(68736007)(8936002)(47776003)(2616005)(26005)(186003)(486006)(476003)(386003)(14444005)(3846002)(97736004)(36756003)(7736002)(6116002)(110136005)(305945005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR04MB0966;H:jcartwri.amer.corp.natinst.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA0TUIwOTY2OzIzOkZSLytVN3Z3dGRKa2NielBZWmNmaUVtbVVF?=
 =?utf-8?B?SWV2Nk1wZExZZG5QTXRsbnp4R1RmYk11Q2U1VFdheTFHL3FEUmo0UFJpbzVX?=
 =?utf-8?B?Sy9XRFVTZ24yWWk4QUNOU043WExTMHZveDdTdm1jMXpWOUF0VmpEWnBLOHpN?=
 =?utf-8?B?SXZaV0g4bWtBUndLeTFwZzhrdG9iQlY0eW9NeVNYNDI0V2EvenYxVDE0RzJ6?=
 =?utf-8?B?QmhTUkpPZzZLaDF1K2NGWUZlZVgrTW5ldHRST3o4UWZEdVdPQ3laODdNT3Ro?=
 =?utf-8?B?dkJQWXdhZGNEUTgzZk95bHZnVkhLQWk4S1RvMUlBMjNob0NIdEpvd3lUSVA0?=
 =?utf-8?B?Kys4UFdpR3JWUGl3M1FtN1ZXK2kxeDhsbnY2UUZBbVV2UzNwL1BBLzJXSVVT?=
 =?utf-8?B?UmpXRGRQY2I3MnlYM3dUbXgyazhLZGpxeW44UlVQSzVLR0FFWUw4RWR6N2w0?=
 =?utf-8?B?QWVWZDk3eEd4RXpBVzBBZmo1Zks3Vm5JdWhvTjZwQUlzeFlIcUtoZWdvT2Nu?=
 =?utf-8?B?TlpxWGlpdm1sQXhrOUVVcXpVZUdzcVhlYWRJUC8zR0lMMlE4WkVMSUlEWmdT?=
 =?utf-8?B?SDNLQ2NLdVozVXZKK2N6TlZHSk9ic3RReCsxQUt4OEZna1h5SlpWekFDc1F2?=
 =?utf-8?B?UlVmdk9VbTFESHVOZDZBUnJkbFdJcEc1ZWFLOXBPdjRWV0FzNlhRelBMTWVo?=
 =?utf-8?B?TUVuY0xaY3BOTzQ2dC82aE1OV3M2TG9Fdng1eVVUODJRUWtWNVNZK3RaZW5x?=
 =?utf-8?B?OStxSXh2YWFiZ0JoZDMrdEc0QUlZYzNZNnZ3ZDVFSVIrL291OXpCeEZyUU5D?=
 =?utf-8?B?WGhUQlUvZVFQSTVYd1dvcWI3aUVJc09yZkNvajFmS3lzc0dBeExmbE1PQnht?=
 =?utf-8?B?TUpxVHZ0c3ByaHlqcHBnQlBpeXBENjJJU0R4MkNGVE1EeTZ6TzMrZXhROURu?=
 =?utf-8?B?dkJwSDZLdmI2UEU3STR6dUd5SFF6a3MwRFNweFBkUjR0dWNzT2dsbVJZRllZ?=
 =?utf-8?B?MmluZW92K0oydWIrM0JjRlA1cFdleklhVEozd0pGSlY0TnZhOGZSazBqeXBy?=
 =?utf-8?B?MmJPOGthUlVsUFFyUC8xTTdVYVNIRjlZeEw3UE9qalpSVXBvenhXekN6aGdl?=
 =?utf-8?B?dys4Q054RGhiRXdkZFVZS1hCb2dodU5aZVRpdWZZSTV1dTc0R2Z6Vk1ubTFW?=
 =?utf-8?B?YjdUUXdxaHFoZ3NGSnlNZ0UvSnhMcFcwSUcvMGc0Tm1pRGx1NmxXMWJYQU5V?=
 =?utf-8?B?WUZnVlBDVDdCQmJIdGpEQkpMa0VDdmxHZzdsclhqVklMczFraTllUSsreHFh?=
 =?utf-8?B?Vmt2ejdLaWZxcGZJTi8xZ0RGOEVJM09mcUxBUnUxemI0eGE4ekFBbTRXdHI5?=
 =?utf-8?B?TjZiR24yKy91VjZmYkttbFVOT1dUWFJwZGJYczhqRWV6aWRwNk5xd2VaOXNM?=
 =?utf-8?B?Qmw3TGZFOTIwRXlMV2d2ZUhiTHZCbkp2Q1R5YkpvWG1vLzJVNkVlZnlQRHFj?=
 =?utf-8?B?Ym9KRGJ3aVZVT256ZS9RVzNnZGpCa2NJSlVZbVk1SGFLWXo3bmZ2Y2hrTnlh?=
 =?utf-8?Q?Rba3q27hiyuB4GBGIArWL3rbx/RW2y8LRnkygXhgrqp4=3D?=
X-Microsoft-Antispam-Message-Info: 99KRtgWGIh2KegKb9kqe1iM6l3vFx+El+vUWXE3+K4tYPpNFsBTkmq+6rOrEvz12TKQHaZH9Mk9uDNqnd3gf5DNdxOx3ZR/XkWKajSpQ3lnbzrsrGhZX/XuF2wR7p//1mL1RyFoNzKIbD+OiUj0kqJSXsJc2/gc/4n3sIu/PfN0m9K9y8nEnn8pHIu7xnKXGlGAo2GFs8cmk8nRHcTrkB+bHCgrveF2gqNgZrQiU8ampanym9nCEBE3pidI53HDGfaryeY/b+ueUQUf+9Yu7DG63p47MMCjaQXx/pXYOp0MJiPy+b86UoYBE2yjueuWNFRmueHIMa+JN9gU1hMSoIGSUEZAr+lAmRuCkl2CSnDY=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR04MB0966;6:ZhFgAKY8QkkmXyZSl82VxJSb4hkQJHSj7EPPJEfSER3DJKPFsFMm6nFjo1IbR96rb7XNTUoTAYUItOXjOgG3TGWu5yT+jH6fXMlDUc0ta+e6+pdyir7BFbBQXv9bYTuj79vJDucHyeNKKykGf3TNUMn29BabPOULpyUu4+ElXoSpdLRvg7T2U/ir+rl/R2sYncxnF9rnJ78otjLd5E/BxlLHHHcPYg53kua5AG52mQ5K2j9kSOpQmy2mfEF2sT61Sg116vSvtklqMsKmkZEVnv7HJzGmhP3GZujJkKqBO8UGWbOFHMYUbGlQMauciWZXwdXlwnDOhL4rsk2TjEIyrj2lQYMgEZIhw+xzEjPi4BSIhC2/hbUHcBeXrZ0XYcPHra8R5ZgBy3krlj4UWYhpU0SUGFbZ7NDPBEV5CRRJ80vTVHVSFOHh9O7PLrQZ9oHEPyvNf84Z2FawlaK32o1vAQ==;5:Yri71fI05b60zTP3tpDVLAqJTcxz2qdTHFHjU2NeZMJm/4aIc9fqy/jn7h6yEgZurTBHp1BrhwWuahAc55tvm2hOKd97IHAkPkYe5BCVdXundzNsfrC2OI5R0SIrn3XeS6iecaOY1OENTJAloB7AHSE9OkY00Dhwil7KwaGku3g=;7:tOqjMr3hgDUflcNbLklwOafKvGirXs8s5qQSAlPLXbBnbhbNCJ/CqXqTE9iYOhH800Smee1f1/rU97SSi0rc1fMEYHbu6neivv879wl8eU0U9KOzZ8zYOnCFr6roECXSeXoucW5SZFZj9Q8sg3X1xsdA7kXCiRv6/tXw9pF6rMUOTmaifoMItAV3bLpng6KnlP/up9WeQC4arDF3sz8Yjh59QpsTka4w77/ey+mnKajxZd57X9oVbSh1qxR7vi7p
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 09:17:42.1281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b911249-87cc-45e5-5130-08d5fb7d769a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0966
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808060100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT folks!

This patchset brings back many RT-specific fixes that have gone into
subsequent 4.14-rt and 4.16-rt releases.

One of my x86 boxes very intermittently triggers a WARN_ON() on bootup
in migrate_enable(), which I'm still trying to triage.  If you can more
reliably reproduce this, please let me know.

This release candidate will not be pushed to the git tree.

To build 4.9.115-rt94-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.115.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.115-rt94-rc1.patch.xz

If all goes well with testing, this rc will be promoted to an official
release on 8/16/2018.

Please go forth and test!

Thanks,
   Julia

---
Boqun Feng (1):
  rtmutex: Make rt_mutex_futex_unlock() safe for irq-off callsites

Julia Cartwright (4):
  locallock: provide {get,put}_locked_ptr() variants
  squashfs: make use of local lock in multi_cpu decompressor
  seqlock: provide the same ordering semantics as mainline
  Linux 4.9.115-rt94-rc1

Paul E. McKenney (1):
  rcu: Suppress lockdep false-positive ->boost_mtx complaints

Peter Zijlstra (4):
  futex: Fix pi_state->owner serialization
  futex: Fix more put_pi_state() vs. exit_pi_state_list() races
  futex: Avoid violating the 10th rule of futex
  futex: Fix OWNER_DEAD fixup

Sebastian Andrzej Siewior (12):
  rcu: Do not include rtmutex_common.h unconditionally
  sched, tracing: Fix trace_sched_pi_setprio() for deboosting
  crypto: limit more FPU-enabled sections
  arm*: disable NEON in kernel mode
  mm/slub: close possible memory-leak in kmem_cache_alloc_bulk()
  locking: add types.h
  net: use task_struct instead of CPU number as the queue owner on -RT
  Revert "rt,ntp: Move call to schedule_delayed_work() to helper thread"
  Revert "block: blk-mq: Use swait"
  block: blk-mq: move blk_queue_usage_counter_release() into process
    context
  alarmtimer: Prevent live lock in alarm_cancel()
  posix-timers: move the rcu head out of the union

 arch/arm/Kconfig                           |   2 +-
 arch/arm64/crypto/Kconfig                  |  14 +-
 arch/x86/crypto/camellia_aesni_avx2_glue.c |  20 +++
 arch/x86/crypto/camellia_aesni_avx_glue.c  |  19 +++
 arch/x86/crypto/cast6_avx_glue.c           |  24 +++-
 arch/x86/crypto/chacha20_glue.c            |   9 +-
 arch/x86/crypto/serpent_avx2_glue.c        |  19 +++
 arch/x86/crypto/serpent_avx_glue.c         |  23 +++-
 arch/x86/crypto/serpent_sse2_glue.c        |  23 +++-
 arch/x86/crypto/twofish_avx_glue.c         |  27 +++-
 arch/x86/include/asm/fpu/api.h             |   1 +
 arch/x86/kernel/fpu/core.c                 |  12 ++
 block/blk-core.c                           |  22 +++-
 block/blk-mq.c                             |   6 +-
 fs/squashfs/decompressor_multi_percpu.c    |  16 ++-
 include/linux/blkdev.h                     |   4 +-
 include/linux/locallock.h                  |  10 ++
 include/linux/netdevice.h                  |  54 +++++++-
 include/linux/posix-timers.h               |   2 +-
 include/linux/seqlock.h                    |   1 +
 include/linux/spinlock_types_raw.h         |   2 +
 include/trace/events/sched.h               |   4 +-
 kernel/futex.c                             | 144 ++++++++++++++++-----
 kernel/locking/rtmutex.c                   |  31 +++--
 kernel/locking/rtmutex_common.h            |   1 +
 kernel/rcu/tree_plugin.h                   |   5 +-
 kernel/time/alarmtimer.c                   |   2 +-
 kernel/time/ntp.c                          |  26 ----
 kernel/time/posix-timers.c                 |   4 +-
 localversion-rt                            |   2 +-
 mm/slub.c                                  |   1 +
 net/core/dev.c                             |   6 +-
 32 files changed, 412 insertions(+), 124 deletions(-)

-- 
2.18.0

