Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbeBLTsf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:48:35 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59092 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751048AbeBLTsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:48:32 -0500
Date: Mon, 12 Feb 2018 11:47:41 -0800
From: Dave Watson <davejwatson@fb.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        Junaid Shahid <junaids@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        <linux-crypto@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sabrina Dubroca <sd@queasysnail.net>, <linux-kernel@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Ilya Lesokhin <ilyal@mellanox.com>
Subject: [PATCH 00/14] x86/crypto gcmaes SSE scatter/gather support
Message-ID: <20180212194741.GA59290@davejwatson-mba.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:200::6:842f]
X-ClientProxiedBy: MWHPR20CA0018.namprd20.prod.outlook.com (10.171.151.156) To
 BN6PR15MB1746.namprd15.prod.outlook.com (10.174.238.136)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88c30968-95d4-44fb-feb3-08d572517c94
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR15MB1746;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1746;3:7cvmua0yJubrDrUIwcB+t/VK4mn46lSYhWMLS6syIEn4i3LOwoAMbwYuSPYeke4vYSkBdzlcu7uZ4KMWI3JPmUfItemrm4RtJ1viBod2vXx4/0GOmhzKNXyeYjovoWBzCyo6W5lmP1s0GjPgSns4oUCVfdyROzifb2UOXYixPIq40L13N0t02o4DG1bKaqy2BkyleFTMRwn78zgiGewgn5oV48rKKRg6iuvV2bz8QNVgnrTywW6bcdz9adIEbV0A;25:d1sDZfNI5gf19VpuKNrLlqzteb5UwVmDwXoer1tHxImP86Kt0uGOjoIFTlM6lCf4m/uW/PyoVoKCz+bQ1K4ZjwyKtr1eOCyftQv+zh9Bbcv3nPHvWyrtRR7SE1/NMfqIMFNUrOJyH2UH4P7MrXfUtrHyFzFN+WIjUOCC1WlohRrOhxtkx3FGPR+50izghKiEEsqPzl8EDaRA1kfV6vyNyXxel6Bq9bBMNO4j9gsZEtnL0tqqzsJxGBUtFSR1PHzLgDBGrRL3tlqu3/0fuVVIBXOCi8uKiGNzOx7kGk3yxZ7UR6YuSw9YzAk97mnSW/+NcIXcPht8myVZQ/UW6O18pg==;31:YxUZ4goAg5ez0QMu1QVW3hYPnG3Zfz2bZj4QSzXCNJtKoz9Hiy0OlGdhU0abu1jzmk7JIb2m9gIKzM+ZKI07Kqg/v2Ovb2nC33Tjts4u/j6y4oWV0uaspbE0Dkqukj3JDQZAZaW9ty7QDoTeUZMI8sFBVH+khco4ciN8msT81i43DYOpVP/8n3aQThdRRFaQQQSS71oYjY55gmjpPCudVVA/6Ccika6UDg2ZqvfXgcU=
X-MS-TrafficTypeDiagnostic: BN6PR15MB1746:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1746;20:IRbVysFqO5h1MT2Akto1QkniP/OdQlsoBoC2BHZD7ULThI5QOrRXyx/WwwrDJcR6rmWfftxa3Dj8RYosFGHZ2NjUMKop0WtXwIgQDqkSsSMRlhx+PxDKpQbLaUHC5g3GOVKXUXRrK72Kc+wsTE7P3P8wlWQ4+7VNrAwN0vJkJg25NLmh19gvjW8QV2dz5kHFdRC5N8MkxF2INeZrkR6q5jMKp5qwlTKyRDrWA970oUxaNOTMkXZ7RS45/F0wFVhykHqcNY6jOLQjCQ8BEaMNUeyzlXGRH7iCCNArKgmctAd5196ANAPDYTFdzLsmX7ai5IItE4VknWtruBFeYpLgbInDO/Rpg3AuuACCqEVlqNOcaxTPJhz6S8Mxs9w/jvHHY635+pdSCVUSINgM+T7LCH0fy6qWDtNnRmbLsWwbE+j39s6brNBnUL7W5fiyCFCkAl7W2+NjVkgw0DdnZ78ZbZpxZoU3iWgfted7WRtB8wiWt/9/oy1X2fjFLVPpfX8q;4:I0QD+pumOr8VzP/1Saa58iy3VAoyE/0+/KpgRdSgQWtA1cjEyuW3JNOYCLHhvDPqpyFjY/2UFXH2mmUajCaJanUm4FAwIBzLJjLBVMSsIkw4OEYpiY29xRybRzGy7wSZO0AQVYK69rcpqACGr5FJnaOjn/7ziN/SgAKh+ktzrjbsjC4wHKBeBHsfJibwOHyKBHaH6ddCo6qpPog0U/9inAKPcuakug1XfQIAImjXHhYpZu1e9vL/qPB5EC5taBT/nGYtRHreuAf6TsiI4REriz1kbF8vvj+7AMLhQ52zpfm2SZ7hhRzSRNnzprGgTpvj
X-Microsoft-Antispam-PRVS: <BN6PR15MB1746F51F92928CA6F1B5B2BCDDF70@BN6PR15MB1746.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231101)(11241501184)(2400082)(944501161)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR15MB1746;BCL:0;PCL:0;RULEID:;SRVR:BN6PR15MB1746;
X-Forefront-PRVS: 0581B5AB35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(346002)(376002)(39860400002)(39380400002)(366004)(189003)(199004)(54906003)(1076002)(305945005)(68736007)(6666003)(7416002)(7736002)(6116002)(98436002)(81156014)(110136005)(58126008)(83506002)(16586007)(5660300001)(33656002)(8936002)(52396003)(81166006)(2906002)(52116002)(6496006)(6486002)(47776003)(316002)(8676002)(50466002)(186003)(16526019)(86362001)(97736004)(76506005)(23726003)(33896004)(106356001)(9686003)(478600001)(59450400001)(4326008)(53936002)(25786009)(386003)(105586002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR15MB1746;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR15MB1746;23:UOK4H89i4/PvalBtAXjsOBPN1U1fAz5utHyWZCcnU?=
 =?us-ascii?Q?1ft0spbJRofngQGgL/R2GXQI1ykLNh9QrPmg1LNLIXpAsFe2rvjY9Fivc2yu?=
 =?us-ascii?Q?+vGg8uYZGbitAkD86iDgdi59iueKsHdNAY69QPzpbZhzpjmhR40c6QUHf73a?=
 =?us-ascii?Q?goXq10sG2rYnvzOyDphzDSEhmOlDNsOGDPuwYjKWeZpvJ0hY/hkFf/J66hGd?=
 =?us-ascii?Q?Qrx0UYFshauCAN3lt8GHbhw3llfyRW0yI120g41lXsur1Yfe0j7xmy4lr2CD?=
 =?us-ascii?Q?Uvd5BGTMNPCKca9ktGbQ9n+HmfMcXMofF1wHli8k+mOoxmvNW+m/1ir6iZi/?=
 =?us-ascii?Q?JLUhbysKHAH4FY2QNswBrd3UOrDZvVBoUDD+8qsudJJ7y/j73hnziR6xw/Rg?=
 =?us-ascii?Q?Fni8gjrtvSpyMboLrJ+lIFwETelAOjSd+NVPwLxWN1vZmI4kmAxu5Dbrz5aD?=
 =?us-ascii?Q?8Albe8DMy3TRJy/BfoaDlUXB30OU34jffJyKQzNEI0gcQlPkiBO6oZh+J/1F?=
 =?us-ascii?Q?+vRngaa6jHBVmJGslEa+a5VvQHRBhTratVn3y1hNPyNtsgx2WyE7/bSM1vgO?=
 =?us-ascii?Q?XQYykAli7QSiU5kVdJhhy7i3iJcL12c2gGwBuVgn4T88wFeRqYYIHwMiJNeI?=
 =?us-ascii?Q?N02byAx/kuGCuCMldmsFTQdnRA27OnKIFqQqmRGUSYmLAhkmu1rdOPZFjmkV?=
 =?us-ascii?Q?fo+xVdYq9JCvzDLYT6ZkNsGrVlurvjgInSFfdXDYJOVCK+bgmIPrzPsiq3jX?=
 =?us-ascii?Q?2R1rZYhZNEPNn8S04Oadx2OBKZGT+FQ/yZMBLFDhlseZ8VaHb3NxTE42zlPl?=
 =?us-ascii?Q?hrhV57l6hgUP9ihXj7KalaFOExgMk5OCSZJKcX34OGwW5VY2zgQFHw0+EdG1?=
 =?us-ascii?Q?le8ZTqCrJpbwDUFgEkKlDzTulU37lRLgJhzAhIJCNY2D/ZSawPcickPUD2bf?=
 =?us-ascii?Q?ycQYBdeuy5/8IBYjRoyumkFREgXoXmZPUIjpt2xiEdpRhZY3wIFREYx20b3d?=
 =?us-ascii?Q?F3xhsRuLUNVsQJo2qQLva4TE4hYlfKqLAGG4EGgIMCw15KTMOzMWatjjv6oO?=
 =?us-ascii?Q?fOTmCR4NBBi0gk/KJkFz/rnSIYF1+IfX1p+sz4Ft4huRHSMfUHaySxti3oqE?=
 =?us-ascii?Q?gm5trYR5x2Ac5ZGyxWJgAlCw2/glsGNcwli0MQxZafy2YurRPTwUvvmxLF+Z?=
 =?us-ascii?Q?5NDCnBUOG5noSJow/60jwMnO6OrneFpvEffeZxbaJr9KV380XvBkcEsDQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1746;6:kAfK13Drk+syzYvnAOS1WPbCb5RwyygwdQ71SfVinRY2YK/eRxdJQM5ybMazGVoe2OgTnMbjXCNm0dc0B204OLwpW/y4CENK7Ecuq5ythIiapuUwbVKyx/7UgAwitsNndc6jJwrY5kjAzjRbQpyQxebM59VeUmaDRXz/khrNtQnDRbudA49cU0LLb8AyJoGz8C9Y0YwyJ+HJnRo3/8HXxGFJ93O7wpz5ES7aDveVNuvB7TSWLN1xtaxQG6l/7Fv0mJ99bbE5g39qZ45sQDLZOV3zuqR9dW/BKLRBRt4YiGU+EdLvvM6A2ReZt4eVKI9OubPAw4HOP1mm9GMEzjtRvpC/W6nDPYmo8G99ICp7FCM=;5:2jf956GwNhnNo57eg1flpUR7DbVn2GLjVsg7a7tL261huwWINoiCcwY1Q+0Z4gRDcV0FA8z0RuAH625E4tnevpC/iFB4j0GTeStlK8TfM84P5kYyuc731pwHO9WuwxEQ4eS0ap6okOMHcdaZmRRLfyszfAD2W4w8LTnwvAdv3ew=;24:L/ABU8hzFbqHDMtu7h0Fi3EEfUo4AVjpIuY5gVZck074mmL3CYNLjUto8wzjjFR1eZSuq9uK8BFgi1dPnleFl+pBh6cdnoYXXaw8aUTQIG8=;7:NplUDBfQzgecfqmCQ1ISD1q0O5p5UfjhEAa2zNs7na4tATj8GS9rHnPJ0sENJZGK1CPEJCB7fUdcSWTpJsUdqVlnQ/3kG85l33UlHOhil2Zt2x+tbVbR/YMmnb1tjn4RvqWOnFEUjMSrC02qbz8+b35YK9ZfiI0qeqa0SksCS7rzwa6MIN9wmCOJvn7jiYcEeujAAtRNWlDUKvW/NZnrxJFGLGoZmLF86uBOmsV4zrZtiRWB0G42qxsufT1BpBGC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1746;20:PRuUrnIYhFvtgLpJlTOa9/TRlo519vLP0vzv7vHi/UBQ7W9UYDnl20FRmDo6xHEr20MKejxDjuRggpo+1JEvYLns1fZwTyV154ZYCQp5y53bc+XpMrs7QKF9FmzBF/KbyjkEgj23y6dQxehDopwakbL6Q+Hf/otw2VLXQK7WgVE=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2018 19:47:44.8662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c30968-95d4-44fb-feb3-08d572517c94
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1746
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set refactors the x86 aes/gcm SSE crypto routines to
support true scatter/gather by adding gcm_enc/dec_update methods.

The layout is:

* First 5 patches refactor the code to use macros, so changes only
  need to be applied once for encode and decode.  There should be no
  functional changes.

* The next 6 patches introduce a gcm_context structure to be passed
  between scatter/gather calls to maintain state.  The struct is also
  used as scratch space for the existing enc/dec routines.

* The last 2 set up the asm function entry points for scatter gather
  support, and then call the new routines per buffer in the passed in
  sglist in aesni-intel_glue.

Testing: 
asm itself fuzz tested vs. existing code and isa-l asm.
Ran libkcapi test suite, passes.
Passes my TLS tests.
IPSec or testing of other aesni users would be appreciated.

perf of a large (16k messages) TLS sends sg vs. no sg:

no-sg

33287255597      cycles  
53702871176      instructions

43.47%   _crypt_by_4
17.83%   memcpy
16.36%   aes_loop_par_enc_done

sg

27568944591      cycles 
54580446678      instructions

49.87%   _crypt_by_4
17.40%   aes_loop_par_enc_done
1.79%    aes_loop_initial_5416
1.52%    aes_loop_initial_4974
1.27%    gcmaes_encrypt_sg.constprop.15


Dave Watson (14):
  x86/crypto: aesni: Merge INITIAL_BLOCKS_ENC/DEC
  x86/crypto: aesni: Macro-ify func save/restore
  x86/crypto: aesni: Add GCM_INIT macro
  x86/crypto: aesni: Add GCM_COMPLETE macro
  x86/crypto: aesni: Merge encode and decode to GCM_ENC_DEC macro
  x86/crypto: aesni: Introduce gcm_context_data
  x86/crypto: aesni: Split AAD hash calculation to separate macro
  x86/crypto: aesni: Fill in new context data structures
  x86/crypto: aesni: Move ghash_mul to GCM_COMPLETE
  x86/crypto: aesni: Move HashKey computation from stack to gcm_context
  x86/crypto: aesni: Introduce partial block macro
  x86/crypto: aesni: Add fast path for > 16 byte update
  x86/crypto: aesni: Introduce scatter/gather asm function stubs
  x86/crypto: aesni: Update aesni-intel_glue to use scatter/gather

 arch/x86/crypto/aesni-intel_asm.S  | 1414 ++++++++++++++++++------------------
 arch/x86/crypto/aesni-intel_glue.c |  263 ++++++-
 2 files changed, 932 insertions(+), 745 deletions(-)

-- 
2.9.5
