Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4082281-1517502831-2-389802916575754624
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517502830; b=mHs2s895YxOsl2tmmeGveLGExo8m1keIRmdWQG675wnlzUj
    IV30Ycl767BpNDCsiigaLvKxaWufQ3PlAJ40dzD/BroVFvAvGYO2Z5PtsRLp/mSL
    JhXw2C4XgTHudB3CXUjer+QjOr7erFeJM2D44gTuhdSDrtxMldLpIhg3TBXBLSE2
    Z/ZgNKjo5qVRsR1vUDbCPc/z8c8Du3oAJApEwvRN9Q42Mx952a3WaH4tZk215/zi
    9F9lEt7W8yrmqB+kKuY1VmOII9v0X0FudUrHJ03mSiBkFh1O2weh/gOxFlEecNJv
    46paZ/k7NjkKLQPtJVo+10fPeCL3CIJFzOBzeFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517502830; bh=AXfDhdHjEV4UXO/iLJvulj4BKh
    bvllu4i5DFq8ZtIhU=; b=eDMQls0Gk4XGNb1qpdxtlewT9Cm+wm3nKx9Vd0lmfG
    19FjqUXU6C5bwCyD1gi5lf0o+KIFCKL1ltjek2EG/zUD4C1Z2h+ceW4DQOVxa0v8
    5QiWdhDwkXC6bE60/w1PeAVwDdtFZotnD3qtNLQ7/+34HoNYlIuB+bzv5X1s1mhf
    DRFDQmFZdmdbNuTxRznzsZcJOjPo4ppobyyfWarWl2RnrlKRFhOHDTFrDW1Ffw7y
    UaWCgPRBVM7FQtJlk0Hq7gji/gLU3HveK4bhwPzCoh4RijFIYkMD/fFrXW61NBtR
    ji3wPrjgkpnJAJwbEP9vWLLN5ib1Uf1bC6QjkRXlh9xA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=CpPN5vaC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=CpPN5vaC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbeBAQdp (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 11:33:45 -0500
Received: from mail-he1eur01on0118.outbound.protection.outlook.com ([104.47.0.118]:8135
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751526AbeBAQdo (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 1 Feb 2018 11:33:44 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Menzel <pmenzel+linux-kasan-dev@molgen.mpg.de>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        stable@vger.kernel.org
Subject: [PATCH] mm/kasan: Don't vfree() nonexistent vm_area.
Date: Thu,  1 Feb 2018 19:33:49 +0300
Message-Id: <20180201163349.8700-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <12c9e499-9c11-d248-6a3f-14ec8c4e07f1@molgen.mpg.de>
References: <12c9e499-9c11-d248-6a3f-14ec8c4e07f1@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0186.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::34) To HE1PR08MB2825.eurprd08.prod.outlook.com
 (2603:10a6:7:2e::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 089d06d8-cd90-49c5-039d-08d569918c7d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:HE1PR08MB2825;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2825;3:g8R4UojZ1wDt5GllHrOz6vZdWQl8Om55zTJxvP6YP7mWKXRvsKkL+BRJfpZzIjQfBjc6En8XVMiIdT/b3D7wpUTDYjeszUEPxOiCFOgMHIuJZHHeaUlfO+bU/JipsT/fgTGEXP71oqxF/umT/CT7X3KqC03CQL/HVjI8zEuOZE2OklaqiArzKq/G+uNSBAJd3wYSWU8YoXv65ywSxP4h+oDdcbdG/N3/dsAanuAZTSrr2g/EHeuwdj+MAo68b2SN;25:XCCcGPVu1aJXithM5kNoWmJbT8Q5CUF4xslXmvnUc9x2uvWAK8WK5ic5yJ691/Zh+rWsFxXrnyzhULyq/KHR8R0nuvvmL5sp0KImzUgrOEZgUYpBcBR37z4FCd0x8E/nveTR/plSASl9tEzVYdXPSD7tH2Gf0SFUYRmrjmZf3EgzKDu6GNt5aCJ+a9aRf8jRghGQFxWU798VD/DPnebtt4lYAD4N7kVWVNNKvcU1RhcyW7UA5iLtDbX/52nv3EZ4+o4MMtX9dBPjfWgTp3Vgg77Jvi6zDaXTDCEJwzmti95/orxXHsTQchzSRWU4wdbfkh38a2feCMJkhzSszudNgg==;31:mdkFY4sHwMCiwve8ILvV3Nt271W95DJiWI0lDvxpuGdFA+psKnYTW35TJ/D/NM7QspVQJdZucKwinldXYNexGS92fMSGUF8unrJ4SD8+E9aLHanBk3ovSlZB1qnfKeM3ww8gaTRMVnXYQunnyXex5sQvWjl/H0/xp+HCMQzAtA4IUrKewjMslxhx6F68uljRoGuwVQ3QH7Es1vkeHENIP3/BuBs+duLNqq3nfOOh288=
X-MS-TrafficTypeDiagnostic: HE1PR08MB2825:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2825;20:zAY5SGJuniwNF0QKJVIJvw0xlXrwxRlwOqbJEEQjRZ+wM42nCfVRhZ2xWvRsHB7NBOwgUhbWzdyShX9lcxHy9CzCPvAF9G3jlM5atiLk+WXoRtWtvW74zBERuNH/uO6EjY+pXLAPq4qdKLsHlP3iiE0c8xYH16HjRDB4avvSxQBpvPDwxsyuXvSPLIkxq06Pw3vJGHFRbgzxZwsOmcVM6iCIdeYrdbVNq8KqlybZdoTaYK0wq+3VyYWpnsMCZeyUN588xlwlS/3MXD02BS0DG0Z9wATlG22ilW+0LZA8ijIlUxgpPZj4DHLzF8HOXC2GwR4wy/BDpiXoY1pBN4GiWV0pwWIKNN+zkbfVKOI9jJy/05bQtAxFVdc1YXpBUYfwEIE7D35atC8I4+e/7BOlBmm1jB+tzQfQ4+rstPjTzeE=;4:qaGBYcscZK0Bq1nSPVTlB8tOUjjjJ/R7K7twGCgsY97DS+EbtoegSM7z0VZ35r/E+JuVIUtEDD0dCe0BcVlXY94X4EMRW2f6SjQ4rtBM/b23PKOik65BF/r9QrNViCiZjgy43nQMe2jMsIUCw5UnXMX5r7lAIZz2DbnISPK0fISk1igYhej4aLExM443ZFOOk48xuKnY1Y+RfcQVWLVCBwteB0cqk62SoRrvUd7cR2RilhpWQLPAXZq3dndbwNLKAGYopWBb4rcNPQbXPYulF09+0sIhIk9iS3Ajmuqqg3Shc/rOgx9CpUp5RT7b6w5/FGC+6gRvkgUwDxtAMAkrDA==
X-Microsoft-Antispam-PRVS: <HE1PR08MB2825461B17CBD49D8EABF85EB0FA0@HE1PR08MB2825.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851)(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(3002001)(6041288)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR08MB2825;BCL:0;PCL:0;RULEID:;SRVR:HE1PR08MB2825;
X-Forefront-PRVS: 0570F1F193
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(396003)(39380400002)(376002)(346002)(39850400004)(199004)(189003)(86362001)(54906003)(81156014)(186003)(36756003)(48376002)(16526019)(26005)(50226002)(81166006)(8676002)(105586002)(68736007)(6116002)(69596002)(2906002)(478600001)(3846002)(8936002)(16586007)(2950100002)(6666003)(1076002)(5660300001)(6916009)(316002)(6486002)(6512007)(106356001)(47776003)(7736002)(66066001)(53416004)(76506005)(53936002)(305945005)(59450400001)(6506007)(55236004)(4326008)(25786009)(52116002)(50466002)(76176011)(51416003)(386003)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR08MB2825;H:localhost.sw.ru;FPR:;SPF:None;PTR:InfoNoRecords;A:3;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR08MB2825;23:fUtLOxhDsRLKqwyk9T+BUJXuh9CI4BsLKhdvNIuxH?=
 =?us-ascii?Q?WQb4KYBJqZby0ePulhrF98B6agflKkrcEg9+oylnuU3ogFaGDV/LPYX+vl3z?=
 =?us-ascii?Q?rtjVhflx65+AUwJphdS5IabguVuoSfNHunVE8gZIpJuXCZE2dE4cj8GpUc3F?=
 =?us-ascii?Q?kPNQngKPcOEismGBcVYvrL+OvdzVetIjF/Bw3RkWodMgAlIScosdNqcKHBPP?=
 =?us-ascii?Q?rptiI+cTZPfrZNAkINOFMhb/ZK4eClYH6axDI4sfVWp9SIH92Z6ClA4mk7tM?=
 =?us-ascii?Q?NqzC+aJFh70UMLAJLvMbmSmuiworNakCJWl1hrrxBkdKBonyzw9EZtd6SDhT?=
 =?us-ascii?Q?rfK7TIgePsbAN6fWL5GhfZp5rI/TxHnRSeAhb3ai6J8lYLej6Uk9Q53llGB0?=
 =?us-ascii?Q?66yyKKC3xWzH2WnWDyutFmYDQubL+5uaqBkAY65OpZZGcqPIhBJgTbs/IL4s?=
 =?us-ascii?Q?mUJ12jgmWhYoCKQJoqk89TcMs3WAcUtDiy/urig+e9xxV0X9W4R0Yf32Bya5?=
 =?us-ascii?Q?4dkxnyjSZlAiatErprIaOQg6KuvCIW6qqT75wTBCM5JYnJKNm6Ws4cj7+4p3?=
 =?us-ascii?Q?OCjOrSl/0ZuVA+qwJEm1MxHMnlON8pUxsXnqFGmjMca0mVamsGKp9uVBRtm4?=
 =?us-ascii?Q?GwmUfKJzx/C4g7iUt1fWAmEK5w5k10VpZRDLXjk277nVUXcNPQ8JfJVwDqvx?=
 =?us-ascii?Q?jiRKU41/aGYPccB63jTnuKzdZDrYENafFuD39tHWneOw41ZWqQREQRXYrINT?=
 =?us-ascii?Q?d2HnslotGuMtq+a2SeF6HAtIauvRUyCF/ODFqIr5FajU0Z2pnnvrATMCsLZ0?=
 =?us-ascii?Q?u66eJcjmJm+3mmYtYP09pERz95TdhhuQEnhkiUt95il9poOt88oD+v0in3Y0?=
 =?us-ascii?Q?G8f+dQKg7U8BaA8O0eHjfbO4k1XecmAJ5cvtTgzukdjcvEN638OlSnuYbXcd?=
 =?us-ascii?Q?5M7kBOWCu/0d2bA5hLpW5z3WHXko53EdNx4uqujLwQLpxZTFU+4Q4KG1quTJ?=
 =?us-ascii?Q?RgP3kUZImv4T+UspVoW28Lho8unScwt4HHn0fLViDsvBC90tHeayOQm6Daih?=
 =?us-ascii?Q?3mFEgtlEeIPon3ilyCMfeI/pXPky4MvIecPkamTePSzJBynja5L69RcqnMQr?=
 =?us-ascii?Q?DFOTy/jqTohKiyefRc6KvkuiAXwRfHvPbRrQs8WSwEeusXy9nFBAtpjuZKQz?=
 =?us-ascii?Q?/hLuZ3cIGNbX0neZ4D9FcNMln6+CPpHX8iU8AvAwu7vOur7VcQ6z6sAM9q8Z?=
 =?us-ascii?Q?6N+YVAyPuD0fhWP9jEwv/b2GtrlntBHVQ2thSci?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2825;6:1jG6HbOXSO8jNFChv7jJRGXyAFzI9qu8BOSKbkJ4wWt7XFGGYWJt0hHkJ8OU8dA+ofxXaqJNCFY6nErfg872X9aswb4smirHm5pp5Z/NtcXhZdGpHIO4kootLRvwKKAofZYIVV9gYMJEexRV9ZOKGt3a+Ur/ATGmym/T0DgyOfa8TIbhWuKxHeMFHIVsipNUKFYyvallTr3Y2+7m3D2NnmCbhp8NaXsJXKoK+D8xiTKjNXMlLPCW0XwIzaNBYprmtp3w4tpoR5cNC9jtY6P7EQug67Nb2UDyGsa4UEbURFmbnLmWfwOS0/RuRYUSWcLDhHetn1N0dRZos/ixHEK1VJZciuEor7xbOp6s4EcvIM4=;5:ZCfXn+4FAzFJu6JI/9hArC+m3TJ7PSvtkSfvFvJb0jgZG1oANh3FF14JHTAq4/3x47W8jhSlvGOxFtMXGcMR3lhLZ/87BladXHSiF2ttSPgYPL3TFS6emzQgjMG8ca71zGKWcJ0mOQNPtldZI2nO91cnQu3KX/R5bGbll6dvkoM=;24:TgrFtiU/tD1wzdtISwTNZswH0G0YdFAcngLPY/tDid/AQH/iIXo3uQt/m2MriF1HH/FI5HzwKKLsJvCeHY4D+06qCXoGN0z7OTpytjQ5rxs=;7:8RuwJZXjSyoF+5LRRtGnxErYnSAs5DUFc/Pa1JwJsON36HJea2VI+kgPk7KN5u5ahuvH2oTZyW7wu7y8PRxeVfoJzFEdBS0n8RGUxeoXO1/BuEkMpW5znabMaEGtfZyjCMYRXE40iLpFbBxiuqoCOPe3ePYnUIOnAmZ9MNfSjIkcSFOuHnJDg2QLdhcMW1keU8x+Sa0tNHWtUqx0VncMta3UUhX7t1OUVDgm/JXqqvbHXlFx6s/AoFyLO6nk5xzD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR08MB2825;20:LuWCT8daslHv7SOwcPiJmB47ANL9IEC4vNNSORqTFLj3M7h826H6YyTKMGs/AbmPd1swW8anl29lB6/S6W1YxZMz/jrz4C6dzhmendSs0IP3pkd0ZvaG0cm1Fr3xZRWrfV1WrVt0hJfIxsrJmRzgcUiVs83qcF06oFFWVm5X3U8=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 16:33:38.7845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 089d06d8-cd90-49c5-039d-08d569918c7d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2825
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

KASAN uses different routines to map shadow for hot added memory and memory
obtained in boot process. Attempt to offline memory onlined by normal boot
process leads to this:

    Trying to vfree() nonexistent vm area (000000005d3b34b9)
    WARNING: CPU: 2 PID: 13215 at mm/vmalloc.c:1525 __vunmap+0x147/0x190

    Call Trace:
     kasan_mem_notifier+0xad/0xb9
     notifier_call_chain+0x166/0x260
     __blocking_notifier_call_chain+0xdb/0x140
     __offline_pages+0x96a/0xb10
     memory_subsys_offline+0x76/0xc0
     device_offline+0xb8/0x120
     store_mem_state+0xfa/0x120
     kernfs_fop_write+0x1d5/0x320
     __vfs_write+0xd4/0x530
     vfs_write+0x105/0x340
     SyS_write+0xb0/0x140

Obviously we can't call vfree() to free memory that wasn't allocated via
vmalloc(). Use find_vm_area() to see if we can call vfree().

Unfortunately it's a bit tricky to properly unmap and free shadow allocated
during boot, so we'll have to keep it. If memory will come online again
that shadow will be reused.

Fixes: fa69b5989bb0 ("mm/kasan: add support for memory hotplug")
Reported-by: Paul Menzel <pmenzel+linux-kasan-dev@molgen.mpg.de>
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: <stable@vger.kernel.org>
---
 mm/kasan/kasan.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
index e13d911251e7..0d9d9d268f32 100644
--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -791,6 +791,41 @@ DEFINE_ASAN_SET_SHADOW(f5);
 DEFINE_ASAN_SET_SHADOW(f8);
 
 #ifdef CONFIG_MEMORY_HOTPLUG
+static bool shadow_mapped(unsigned long addr)
+{
+	pgd_t *pgd = pgd_offset_k(addr);
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	if (pgd_none(*pgd))
+		return false;
+	p4d = p4d_offset(pgd, addr);
+	if (p4d_none(*p4d))
+		return false;
+	pud = pud_offset(p4d, addr);
+	if (pud_none(*pud))
+		return false;
+
+	/*
+	 * We can't use pud_large() or pud_huge(), the first one
+	 * is arch-specific, the last one depend on HUGETLB_PAGE.
+	 * So let's abuse pud_bad(), if bud is bad it's has to
+	 * because it's huge.
+	 */
+	if (pud_bad(*pud))
+		return true;
+	pmd = pmd_offset(pud, addr);
+	if (pmd_none(*pmd))
+		return false;
+
+	if (pmd_bad(*pmd))
+		return true;
+	pte = pte_offset_kernel(pmd, addr);
+	return !pte_none(*pte);
+}
+
 static int __meminit kasan_mem_notifier(struct notifier_block *nb,
 			unsigned long action, void *data)
 {
@@ -812,6 +847,14 @@ static int __meminit kasan_mem_notifier(struct notifier_block *nb,
 	case MEM_GOING_ONLINE: {
 		void *ret;
 
+		/*
+		 * If shadow is mapped already than it must have been mapped
+		 * during the boot. This could happen if we onlining previously
+		 * offlined memory.
+		 */
+		if (shadow_mapped(shadow_start))
+			return NOTIFY_OK;
+
 		ret = __vmalloc_node_range(shadow_size, PAGE_SIZE, shadow_start,
 					shadow_end, GFP_KERNEL,
 					PAGE_KERNEL, VM_NO_GUARD,
@@ -823,8 +866,18 @@ static int __meminit kasan_mem_notifier(struct notifier_block *nb,
 		kmemleak_ignore(ret);
 		return NOTIFY_OK;
 	}
-	case MEM_OFFLINE:
-		vfree((void *)shadow_start);
+	case MEM_OFFLINE: {
+		struct vm_struct *vm;
+
+		/*
+		 * Only hot-added memory have vm_area. Freeing shadow
+		 * mapped during boot would be tricky, so we'll just
+		 * have to keep it.
+		 */
+		vm = find_vm_area((void *)shadow_start);
+		if (vm)
+			vfree((void *)shadow_start);
+	}
 	}
 
 	return NOTIFY_OK;
-- 
2.13.6
