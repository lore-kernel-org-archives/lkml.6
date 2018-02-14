Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161261AbeBNRid (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:38:33 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58614 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1161207AbeBNRia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:38:30 -0500
Date: Wed, 14 Feb 2018 09:37:51 -0800
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
Subject: [PATCH v2 00/14] x86/crypto gcmaes SSE scatter/gather support
Message-ID: <20180214173751.GA61573@davejwatson-mba>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:180::622a]
X-ClientProxiedBy: MWHPR11CA0048.namprd11.prod.outlook.com (10.175.56.162) To
 CY4PR15MB1752.namprd15.prod.outlook.com (10.174.53.142)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6500d86a-e828-47dc-d661-08d573d1b1be
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY4PR15MB1752;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1752;3:FfXL8wVMwsk4swdkK80KdKTA1/xkZv7XMWBuhwgWgAcmppzMoL0wMnYGmTUQ0SYhgIBBD1W2jJJr9MFO1UHbHgF6n69I2S3s62920x47bStvW2VlJZ3ALWj8Z+1UuzX8GT/sLvhjDjvHu68rXeFH2lCmkL7kCACTjTuR1+a3A5mnej7TcJWMQrtmKlt1P9IX9NmgFk+gqMUZf/Dka0CBb/D6OmRpQyaOHsP3d9xSoCH1iSDNGOZbJe3E2Szu/swW;25:Agr9cE9gncwiA+nf3OJTtLWQMHYC/lkHxx5GzZ/g5fyFA8gOWEy7ai3FmpCyxAvp8W3H7rG0TVeXZQkGzynHQX27rrOlrysZYSnOIhodCNTmVyEm0K9BwqXLYz0UF+8qnoHCni8cxuqlw9ol+bsCQm0LH3JacMglhYU5/1XRwiT12LFWokoRJHhVFZ4Vpfy09C3qBiBbAe/rnsACUQ4HL73uJVHufZu02/3+jnkPz/lxYACh2sz6CLD0j6h3HnkaRm24Kt5uawKF7rSM9QH+ZC2upjD0nZy170OM/QDmxz4guQc2nc38BRuaqo5qlJOl7yLZvk7HE+LAr2JSD5DM/g==;31:Z4rw3ZnZhU6q5WNzy2z5OPmxaridEO1b/OKd2KbBpWPL0IINfM0OGLNDv1hUZh5j4iPXIw3zFHC6l9/yfXk8KTvuNlHhX3XzbTuSpLUvQwDOM3KUISN2zIXDnd2xRsrFBpVFoEwNnMRexuTHVfOmTYcATRe86DtyDrrkG+5HxXd62ZDBqg257dWWvnkrZ1SaOLNDoG4rYsoB6dIeNzZKsbtR7ZvJyG+bPzkneJNYDrs=
X-MS-TrafficTypeDiagnostic: CY4PR15MB1752:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1752;20:rsBuo2DofNk7y+RrHOO6YEChUtC1ghaRZCDl6NpTgW3QxYwBSt14J16G9MuiBPsPuNzmBrtKMV1gm9XfDia75DrCqi/PdaMQDaIHkNdtj7yHGjQ8a2mQ/ubhkB8NF3UM+ZEKXl/Un6bhyXw9SuldYLCB+tLoUXasfvR7biHwMGNf5+x0xAVzvjMjlR/1MTyPKY2FMJL1kITfGwX/UGFNo1GfPmW37Rv1K+eO7n4+eLmBeCvOrHZ8Tb8LVSpaSBd6v4lz8k16IyYwZ69lPMybCFOC8OdYQRA9z1R1X3ZQYZ5+xpnbzd2BvPTJ+m5CaWCKv1j0E4dM++n0l9haq0DlQ3xa+64YjBksw4b/Vjy+rQSdVru/iAz+D+wvn2F98xNq5Lq6osjQHP2woTFO90HU/3u8KuNddoMiHI8fxf9oAOarSTuRuuvO102GZV8hQODSpAs/0Brpc5NDR3eyceSfmb//C1+TWyD6jb5S4uHBLSbVNebVPwkSn5DlB9THmoUX;4:51wE9W+TMSCPoHS3f//AyyAybHMz9bJBw3EXieg5BrwMkGhodBatXZUxxxls3HCflXP6TA1qB63njaQLKl8mThQc9cMt0Jev1sDDfycyBgpgT7TKngcQZpWnIJnWyEWDhETHSlYWIu67OP0A4SsYdhLkVCXbHP+NsAIZghCYD0/MjUDnGlI6bMZYa1+YVQg3VfECuW55eGP/bN/NgRv9dtfSuQBh5zD3nkPLWyWVdusYMcoCU49AVuAVIqOMaUoblmb18WnhdpggPVQNqt24vqet/XIGMjjO5DwGwtwZdQW6zRS/bQzmshgSRtpCoa81
X-Microsoft-Antispam-PRVS: <CY4PR15MB1752DDEE4306639B30FBF0C3DDF50@CY4PR15MB1752.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231101)(11241501184)(944501161)(6041288)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR15MB1752;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1752;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(199004)(189003)(305945005)(59450400001)(6496006)(52116002)(9686003)(52396003)(83506002)(54906003)(16586007)(58126008)(386003)(33896004)(86362001)(16526019)(6486002)(8936002)(316002)(50466002)(97736004)(76506005)(7416002)(110136005)(81166006)(105586002)(53936002)(186003)(68736007)(4326008)(47776003)(1076002)(8676002)(33716001)(6666003)(81156014)(106356001)(2906002)(25786009)(23726003)(33656002)(5660300001)(6116002)(478600001)(7736002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1752;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR15MB1752;23:HvomY+8O9H0cZRfQJqG6ZJhrKSW4YgIUviNaVlsto?=
 =?us-ascii?Q?oR1yU/+kXa1FJBO0w/sisZxDzthHqGLMdbIVs12nn5xLImfhGowtcoEf3D11?=
 =?us-ascii?Q?3STDNpud4RclMDCJmn/P3GoD2nSutPHd+z0wCAKj5D4VJTCZPBzCQUArNSuE?=
 =?us-ascii?Q?gMErS5ZrVg+xdiCVwcwuiYJyHNjifZd92el8HmbnkChG5VeaUxAB1+3K2Iiw?=
 =?us-ascii?Q?SjHWoKaDRDo5oc+jwEq1T2D9hj5V1LVnGkJB6GvwpgcnVR28EehPjDz2FVGu?=
 =?us-ascii?Q?fzmVEAMnWL/J4IqHedlLLnPY8xXj1fbTsR+RbS7yJQD8VqZcdC7vn3CzGZv+?=
 =?us-ascii?Q?X8xID2AGRQvRjCWPHp9tyS4qze3beVVIfYoPB78/eJEkTtGnoikaa44UNTSr?=
 =?us-ascii?Q?52iZo1aEHP34ZsjR8Acm7ySlPod6GuJHYPPRvsC07rEcg8X9ELbDHycvLaks?=
 =?us-ascii?Q?Ju46MmobTjaYcqR6xE6HMUiAuar62fR1R9PX+scbz8HcsJ2iPj9GKyDg3p+h?=
 =?us-ascii?Q?NinkdWf5916emuTNZa0Er+o89+BFJ1VH4HIoFSp9/LWWu1ZHM3IBCbMRMbZD?=
 =?us-ascii?Q?e+ja6ihYJSrvVBqMLKT3e++tWbMQW5/KPLxwI5JVZN2m48QMBNn5bL5d08Ge?=
 =?us-ascii?Q?5dBSp5Xx8E6dfHwmK63zkdpx6xl3lvSzO2btbz4fFmNF9zGU/l2I2DJGq3SV?=
 =?us-ascii?Q?LeDCdCiDOoiG5mNpeCfQOegXRUEEAIVfDjg6oXSK8wzWuQsEBChcJe1D9+uf?=
 =?us-ascii?Q?mFFdk3f4ArsrUrhnluNPXBgxoMBQyLDA61kPmGMD7LbOdyRe41JKj8dC+Gg8?=
 =?us-ascii?Q?ny+4Dg5XwQzuihkzxMp76KUIZRBH9ql2CLi4Ldab6Y/ti58qoE+HBkuJ/G2H?=
 =?us-ascii?Q?Fa/IYKt6B9mv/aa6rlV/H1BU8+ZnSb4TxWoeHHcOBTv1vxOoD2m7tqSt5k0w?=
 =?us-ascii?Q?6t2KhQM27Jhm56oHk9YaNa20/lWUbxVMb8r5w+QuCEop0PRNFjwPjXWd8+cL?=
 =?us-ascii?Q?eiew9z9X+vKhElush7Kzr+KjgWKf3gfQT8aKDQ2DmoF2nPknOWBOjsUOmH92?=
 =?us-ascii?Q?pXwUaK0n8BelByVEAqzhhZzai3b5aka2JQhCjiU5qw7B0yBCLfrgAPB6tg9R?=
 =?us-ascii?Q?/2lLV7debUcT/tOI4HNQapjmmPbpKjU7QXs17djIF+xAi3wV/PKSvbGvszOX?=
 =?us-ascii?Q?IpRaXCeG4tEgFY27cQjiYuTxXCX37OnpE/hCTbZbxUMTvmiqbQGMsON7hTda?=
 =?us-ascii?Q?xCiYjru7TwarCFW7mI=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1752;6:TqpNrAg0tyzst7rihPxfUs3Pl8SR2xDpmorqSgqkozs3fpk8Fpc7kPPFzpqSb0rUFoAsy7cMfKf8+QuefG54M55AcEZWRPa9IuB8KDcuwFKSjRtjwMC+T1GS+aPNZFuBdGu9K5+2BFw7fMhd8aI+jhLqoyh4WMBqDA+EXT/tPyhqSGaN4oGh/eGXe6zyeZgBRUm+0X9qIhmUbA36CJtN+xAS275fUxCZc4T0yIlMQzqyWwE1tt9QV69OTqgQ9BnTp87ge/HwrYi+T2w6yLnvgRzNfPkOwOvlGpXyH9g0J9WoglGZn1HtpHSYb6x9LO9x3iGWl7J7W5nAIh7puD2PxH/1UXVylEsL4XzpZZ6ssEg=;5:UXjuWnD/y6zoB0WNVZnGmBg11EoEozVooi7vPvM8ki0bBmtd+5XkjCI7nPwFCKntods+K8HfI3IP1SXq6gQSvDFXKD6arlNH7YNV2x1ytWq8CT+nbrnS2I91zx9udQaUrjH+PtyKy/j7pmetkL2FzozLE7uWOjfnRhO9o35p/4g=;24:tDDFkGIVrQNdbYzE69qq8k7kCrmS2XWibHXcN22Dzlej0TSXAVoQlBL8Cm9UomnB9zx9Cb55UdoQvSbLFiiJAHxRKiqnXh0VnpPdZXfy7bM=;7:A2lGPzPE2GlzkoFG1cmk0VEPspMOLqcoTzYx8yDj/NWZ0/HPYE0CA3tiaRz54o9N62SRbwGo7m5GL2X6itAaT7eSg36hHbk9+2OEY4CHv04LhTjtLMBHFUUVf5INtlDkxZUdG0130gp1N+57GmCXnJH5ggFoe/ia2jJp8pDl+1cuGwSyrFHjPikDE/f2VAvErkYewizKQyqilLb3wv4MuhqvwWpGjBkdAn+swUZtQg6LdJuP4N3Mir75aD1pqtNY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1752;20:cQC6hkn7TlMxZxem+liqD3jPJz3vQ5Xg9bhYmPgLhWF+UN0re3J0LNMcU3ta7/w8hk3QbEVNZJFzmrsTIiKIwp7s4OA8ul0ZDrwkPA42dETK/B50wbHRg+a6MLy2btIdQa/vdexQ1t3X+wv0Yk3wftEgFXcfp6eCmPFC+J0hNms=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 17:38:00.8663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6500d86a-e828-47dc-d661-08d573d1b1be
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1752
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_07:,,
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

V1 -> V2:

patch 14: merge enc/dec
          also use new routine if cryptlen < AVX_GEN2_OPTSIZE
          optimize case if assoc is already linear

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
 arch/x86/crypto/aesni-intel_glue.c |  230 +++++-
 2 files changed, 899 insertions(+), 745 deletions(-)

-- 
2.9.5
