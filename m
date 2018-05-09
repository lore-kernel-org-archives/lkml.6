Return-Path: <ktkhai@virtuozzo.com>
X-Google-Smtp-Source: AB8JxZoC2VrBjVM7MKGh8C3OCerMO2Sz1MUbAGJBHwG1EGGB4m+nCWahiU+xC22QndyQNZWdtAco
ARC-Seal: i=1; a=rsa-sha256; t=1525867039; cv=none;
        d=google.com; s=arc-20160816;
        b=1LaL1yJZlvjkZvcp5JrgJFValoO19n7tctASNmC1+GJSvKzkotvzuQPKxUDlVBu9Zv
         KOROOrWBQaMTCG2azpWz/qs3f/c7HbikT2TUZY4PC2HsDbZKI7S/f0s4duuw3RHOccyT
         NgHjrnedGjricL5hqL+qjYulQOF3Vn263kCFjuu5bf3lBRi6qo5uKOT8xbzv/JIOgqBB
         xD/a+IdlbZS7jw0wIG114FGwbbqCaEpKXPgCViAbMTqq0Nsw7yULsuBIVi4EfKtXHzek
         ckR4E0ScdJxqF+T6GxU1HLizIQYwcFWqK2DhwWyPsfsEveo3fbPO+1eYohqhLgx/y+9D
         +R8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:to:from:subject:dkim-signature
         :arc-authentication-results;
        bh=bvTOhhzafBIbnrGHiSvQjRCEOJbvnQjYti1uuw+Yl5k=;
        b=U1emQdmj6FSwRW5ZkTAd3XC3zxFrDaIe6TNPP3cW3SMdCtEYAxbzcFyHCV+eL4ZGNS
         xvQiboz8bon/2U8mdhhDy0U8EO5LoWg+Q6g9fFbA2WstEkm+tkPe8pv2J2BqBLkHwUrs
         WZNx19dT9tUGCyLaH8bwimfIqcNyCMx4tf7sk7gUgLm38YCCvaotD/toyzrqGKsi3a9Z
         VpoAnLFsYaNtxjtUQC1Zr7C5AnkVV21xywBj+tjalQlFJCQRbkySAHThyWoQLi4Tdqoh
         IfWegnMciH244L3L4C1od+ynNMXAVWgiUv+vmSlWoXkOLCwl8aihur6UjKPLsyaVGTGL
         9Ltw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=IdP0+YWk;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.113 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=IdP0+YWk;
       spf=pass (google.com: domain of ktkhai@virtuozzo.com designates 104.47.0.113 as permitted sender) smtp.mailfrom=ktkhai@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: [PATCH v4 02/13] memcg: Move up for_each_mem_cgroup{, _tree} defines
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: akpm@linux-foundation.org, vdavydov.dev@gmail.com, shakeelb@google.com,
 viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
 ktkhai@virtuozzo.com, tglx@linutronix.de, pombredanne@nexb.com,
 stummala@codeaurora.org, gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
 guro@fb.com, mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
 chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
 ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
 linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
Date: Wed, 09 May 2018 14:57:05 +0300
Message-ID: <152586702519.3048.13324048197835952040.stgit@localhost.localdomain>
In-Reply-To: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
References: <152586686544.3048.15776787801312398314.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0301CA0019.eurprd03.prod.outlook.com
 (2603:10a6:3:76::29) To VI1PR0801MB1342.eurprd08.prod.outlook.com
 (2603:10a6:800:3a::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1342;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;3:8H9mZtYHeGNwrRxx1ykOb/hZ1MiwEydWNoWnUwh4q6JdB3B6Y2AUFi9eBhdY+v2uv7qRPpkgq7BPtRghuWhBPpUj/m5zB7zQ9hDKeNI7EIXdLHgRdPLWJ8gOv4XAmDS6/hVBXXy11t2wlxzUpj/WSySIf8Witwlm1jkE6mGRVpAeF9Wzi6rS7UXl2nTE7MucXBVkl3XYuebdKZMl/RsaNOAFc8wn1gxhf8wa9LSqjdvJ8nX6OiA+RdMaq8+Uv69g;25:7UmyVE50ndbHV8vjl3b9LGTv5DT381Ajmup9RJACFj+FYQYS00YNqcyLF1cV4SNn8pO4bBOZzg84nxpgzaWcCxkZ+nEETfk5oPSSw5dbwUcZ5nzpY6cNMUTv2yThnPBNpSP9vzONiCsqlJ0LMYcaztaWl95TeMHOeq+2L9YhucpDeDpG3pCdfGJpnq3qvO3q2NSGFrO+1msYnYxcCZswRO20eUkrFacR8UN4jLmY3vR1GXRwBq6ycZVAD9DNEen540v7SQNUlzMt6Pmkg9njodQKQxPKacEvdBtW/eCusrYrCj1RfCaAq42rRbDPyDFsbj3abZj/vMHmGTi+QZf7xg==;31:ae1+CU0nD7xzpoQU9UaJq1SB/WBE/IY5gu1/JHXMAIH6D6yA3plWVJdInj073G6PfxpwpiBWviQqxaP8+S6FEvpyhfz8h9cfB1M8G4+MCPo1+ljygGPtSi4xQrbJa1nK4OzIhIasZKGeE6jrb6TgIx4zgnTKonmulQdXTCDwK9LhmuSEGz9CCtfeAbzKA7jZQtkZ7+gK8DsWEnrtcX05ohcpQW2h9S+QLYXnR8+WG3E=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1342:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;20:NgyzTj3VbtPcBYRBJ5C0P/cKoFp/HGS26UCl5SEdwT5oVG5zQUirzfxwl8mpFWjX+TLBc7bx4u2au+xJjK4HR1a+79GlZZkd7xK9JAItsGDlNHx2xrJCmqyYpkvW90lFGI6l1/ILMvg66kcRrlshIi2qq5Z9oFrsxZTMkiciMKdOHSBB7M1yPczO6H5SEEo8KldRxEjsMloPQLZY9z/yN5xrvMLFl7nyVh4VNyXNP552jzzJEiXCLhDpsjriFYnGsRokv5y9lqvdRBYm8p/VaYyMy3GuKaYbnq6bbbCER6LEQWsNw1Jc275G21LL8l9g9eQ1whIlVd+31bdpKrKOEuRiRPuOTJoBFDeoRxunCZshceLu4fxeAVWg7gC/7x/cKtAmtX6Z5HMtdrtElXpveH/27IjwZ7f0ggyCkIO/ItnqEiBJZQRs7LslDTub7zbamm1csnT1POmqewlxbhGBcT9Sh40L0XvSg41nzfmD2j7HSf4mnP/OP0cbms+QWnQZ;4:OFAnwKpIGTLWlw100OCl33au0AqmHRKG6lh+tKuowi8lYZH03uVLu/EJD/ZxSr5OlBZsoinPXxKL4selC3RwfOb9CXWcbADcgkKpisn7uCOSGphpj4wJZJc8EFJLYaUiIoK6gf+zkJLzhwi9dllqbGKrtU8EG76hVxueO3XKgNwetiQvbAX6XM9COkou626lyfLvtjP2Ao1/0FT6opEPOiui/ixxjleTM+KpcF/pwL/6DugIN4+Oq97SuW25ElTp0wg9eqCxU5CX0IIuwhCPdA==
X-Microsoft-Antispam-PRVS: <VI1PR0801MB13425CDAEFE876A2E5ABEF98CD990@VI1PR0801MB1342.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR0801MB1342;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1342;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(396003)(39850400004)(366004)(376002)(39380400002)(189003)(199004)(8936002)(26005)(68736007)(52116002)(2486003)(23676004)(186003)(97736004)(61506002)(6116002)(86362001)(3846002)(105586002)(106356001)(16526019)(25786009)(478600001)(47776003)(11346002)(486006)(66066001)(55016002)(7416002)(956004)(76176011)(446003)(305945005)(230700001)(7696005)(5660300001)(7736002)(316002)(39060400002)(476003)(55236004)(6636002)(6666003)(2906002)(6506007)(386003)(58126008)(53936002)(9686003)(103116003)(33896004)(8676002)(81166006)(81156014)(50466002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0801MB1342;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4MDFNQjEzNDI7MjM6cXM2bDFDT2xSL214eU1PZm5yRXYrSDQ5?=
 =?utf-8?B?NHZyRjBjMDJ1eWdLWTBaNmFvUDg5bE9HT2xzdTY5MFZoNWRCRlZiK2xadkha?=
 =?utf-8?B?d3dYUXdzYW0vd3poSWlIYkRDK2JEOFNVQzAvT25BYkpMUFhDdEs5dzdIMWdL?=
 =?utf-8?B?WVhrVGQ0eXR6aldqdXZPR3Z0eENQTzY3QytqcmFkS2Vwc2Q2UGs3azZvQ0FR?=
 =?utf-8?B?YW44QlJ4SHovbDVQS2l1YW0za0thbWxCUCtnSWNmQllCc0U3dHkybGNtWHVG?=
 =?utf-8?B?UGx5WkQxUG1oZFczRjlwUFdEdFYvdEZIZmxkbzYxY0d2a0RPY0hLd1NVSlRM?=
 =?utf-8?B?SVlkVTBBOU1kWlN6Vm1MTk1aQlEvQU1EQXlyS2tLL0xiQnNlNHE3YUJrUWlO?=
 =?utf-8?B?MjFZUVU3K0NYY3dMcVI1WlEvWTU5WkJNVkZHa21JS0kxZDNYdzFOc0FUbXNO?=
 =?utf-8?B?MjQyY1ZDVnViYXovVkFMeGw1dUVWR0pZOXdHSVU0WHBLOUcvZ2pEYzFQcWxj?=
 =?utf-8?B?ODd6VVNMdFpGVHVFN0xnb1lGQmx4K0VrL2V4c0Q0eE52alhybDNKOVBZbGNC?=
 =?utf-8?B?eHJBYVhad2FnYVBhbFNmZnhWa2NPTUJrOHJEVWdjbGE4QTBnQkN5NUh6cyto?=
 =?utf-8?B?MTRLOHZoZzZ1UFBGdERrbjN6eDNvZGwxaE5HQ2g2SmZ6SUdCZWxuUjZTTmJz?=
 =?utf-8?B?R1M5L0pwSXBtS0w2dXZwU0thTUp0RDE4U2IvcHI2TkxWNDFKeDJpZmdWRWZs?=
 =?utf-8?B?T28rc0h2OWxyMldPOUcwWFRoUWQ4elZLMlhOVGpiZlo1aVlINkhTcitmUU8v?=
 =?utf-8?B?ckRGM3lxUVE4RDdZMHZmdTlLTzg3eHpaUTdNY0c3N0hvbDhUQWpmNElyL0hh?=
 =?utf-8?B?Y2ptNzkyR1RBeDJORy9HM0JVTlkrQXp2VGdRYSsvbllSYzZkOGJxSGYwOEI1?=
 =?utf-8?B?TkNrTXZZV2R6VElvcFpQd3NSeFBpTkUxVVZ0dFRaWG9WTXpESzg1M1Avc0g3?=
 =?utf-8?B?cEZ3RHQ3WEdObzNmYnFDR2M1SGhtaTRabUZXa2VOQjY2UFZ2c3NUTjdZRFBl?=
 =?utf-8?B?TUg5MGdyZUVuQUlSWDNxWEU2VXEraTM1alk0SGlQazFHclg4TGdqL3pPSTIr?=
 =?utf-8?B?UzVLZnlKSkw1eDRWRFkralFzeUJrYXV1VnhvZGlRaHd0Wndia1Y5NUZJYXU1?=
 =?utf-8?B?d0pjVlc4M3dteHdrZUhMblEvcStUQ2cyeUNYZks5L2ptMG84REdocnBlVkxF?=
 =?utf-8?B?TXZXTVZFTzFoN2llaVFDbEV5NjdTbUtpdHFRdTZWY1lHMTB0SCtodDVBMkl2?=
 =?utf-8?B?YXVFampjcEtTRHVNZ0NaWFJLT3JkRkxMenpLVktlM3ZmSE1SQU5pOTh4RHpK?=
 =?utf-8?B?TWF0RXZpVEpCbkV5VERQSnljSTU4SFhMclZGS3g2WFZqV2RsNTc4TkxmSUhJ?=
 =?utf-8?B?MmU0cWtpZnhrYWo4K2VOZ1lENy9YS2ViYVNUSFpad204LzNZQXdtRFVWdDhP?=
 =?utf-8?B?Vk9Cd2JKbnZITDlEUmVLdm9DZUNGcjZxS3BwanNhWUptZzJNa0FUZEViYXNN?=
 =?utf-8?B?VHNtN2FtSHZmbmkvSk5Vb1hjWGVXRGRGVVhlRTRTTDN5MW5XdDk2KzEzNXNw?=
 =?utf-8?B?dS9JZE9ZcEIvaTBSZUF1dm9sNEVFTnJybVNJTEN1OURLMWJjbnpXZjFOT2ZB?=
 =?utf-8?B?TVovSW83Yjd5QmpKU0Z5UjJTSUk3WTNleUkzc0w0TTJ2SWVlcXdTUWpBQjF2?=
 =?utf-8?B?Ukxkc1FTMVF2NE1qUXk1ZFlUVmt6U1h1NnNWMFIvNGR1NG43Qms1RXNwdjls?=
 =?utf-8?Q?p5LMhazX1xgqMCt?=
X-Microsoft-Antispam-Message-Info: tBUVGtapBf3r7380oRvkbMxb6t1Bv0+ZO9djQT0IL1pDS6M3fL/tNAsiCTsyzaNGZBHZu25U8kLm91bsrTpOlcwVaJHqc3YUy0YFYsXqsK0QsH5FR32N2UwEvIu8b2LNalg+L04mpmWngtcSL6keVNMFmf1Wp+duTE2gnvo5xwW2CJV9/Dzhb5IvqLEkjSjk
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;6:TMDNt02QlxX0mkvWVE2HcuPj+0m0NpDve3yv+8aeRVnBnbcDL0qnnA75HafMokTx+F7PHM+ISQ9yt/MFKiT7B54WJj5U6nCMdQvfoyUuVsYAvesIOpsfQKq4dQsNdoDeBgJnfAv1P8Vdr44PU5j5Y318DzlsPdEOXfZmAyIVTXZtVPjukDq6gdKomrqj7YNSL54muFEUfGjRTtF0Sy96EBOp1Wb4SG1MUSlYR7IcFnWC5xC/aijEn4nseYh2+WWhVBivBPdJlpue4VX8A5NldNbeedpWO1zUf/7Ilh9eFh28D+twFGN7RfA589g0J3/vhW1c5L+ofrIf0xlfGtLtF2IYeN527fd9K0+xGW4oz/8fHhRwWx/mMLvf4GLG5GrS8WgEugRTI76XF08JC+rmKMj0wJALgZJ/insqo2F/zJ/lIUs6R3mYe7Vff+2JjR852t8wvZR3V3Z0slrPFUpXSQ==;5:sZWro6VLNyGP+Kq0bEYL6b4O2bweMyAA4scflTb/UaZfcJpm9Hjxg3N9sx6ewzUx3MtkDvb4YlnDHCMpyfFroF9HTuZa1qtARfZLMKei+7xYiuxpopCYfa4+Jek8D/Rf6k8G018wV1KjN4WPguxkCUKy2WrMzqwfpGrN3EdZKL8=;24:6qeZkcmrVT8w4AD6yDaL25v/Hnmh2uFoHOoQi/s4fY8i5s0Qta3kZg89nG/6ISalLBjWbkG9dWlP5bEcc9aeQcA4bHm6Fg+fzofMejdqLP0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1342;7:/WmpWPE6zfBk6hVof085AcfKXxDvl8F3F0fYTd9dUKsEIAlw6qmZBxf44xOVY/GMQVML024OepCRaawslWP6PJggtD+0beSqYeg7m04xo7UFGxm9TS5XbO8GY4uC6GyxBTDNKAVV2Z8LdVssKu9kuibZ/dVgVtYdc102KtYbs6MHEOMfo2Y3IH1Y+F6u1C5vYQDoZdcQ/BoCsRKBb35HRrSFQfLXANpZ3+rVftFxTg9AKfSeFvxkWyXGWjLzSk1A;20:ww23Q/Ik8Q2bhW1KuugBuyVyofzIAAZ+QLCQPGf3lbgH6VMi96sNq55C9I02kHcB2xyhiHSAJxriDItKqFS4GuDuE9VoL5bmZBNDqo+3mh0HxCkFdQFFpvH1haFoF+xTyjx2HUjFS8hLw3hhTIC8+yoIJH9XKbMFJXydyXxe1oU=
X-MS-Office365-Filtering-Correlation-Id: 1dd04962-e505-465d-0bcf-08d5b5a3ffb1
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 11:57:08.9069 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd04962-e505-465d-0bcf-08d5b5a3ffb1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1342
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599987557283387161?=
X-GMAIL-MSGID: =?utf-8?q?1599987557283387161?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Next patch requires these defines are above their current
position, so here they are moved to declarations.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/memcontrol.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bde5819be340..3df3efa7ff40 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -233,6 +233,21 @@ enum res_type {
 /* Used for OOM nofiier */
 #define OOM_CONTROL		(0)
 
+/*
+ * Iteration constructs for visiting all cgroups (under a tree).  If
+ * loops are exited prematurely (break), mem_cgroup_iter_break() must
+ * be used for reference counting.
+ */
+#define for_each_mem_cgroup_tree(iter, root)		\
+	for (iter = mem_cgroup_iter(root, NULL, NULL);	\
+	     iter != NULL;				\
+	     iter = mem_cgroup_iter(root, iter, NULL))
+
+#define for_each_mem_cgroup(iter)			\
+	for (iter = mem_cgroup_iter(NULL, NULL, NULL);	\
+	     iter != NULL;				\
+	     iter = mem_cgroup_iter(NULL, iter, NULL))
+
 /* Some nice accessors for the vmpressure. */
 struct vmpressure *memcg_to_vmpressure(struct mem_cgroup *memcg)
 {
@@ -867,21 +882,6 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
 	}
 }
 
-/*
- * Iteration constructs for visiting all cgroups (under a tree).  If
- * loops are exited prematurely (break), mem_cgroup_iter_break() must
- * be used for reference counting.
- */
-#define for_each_mem_cgroup_tree(iter, root)		\
-	for (iter = mem_cgroup_iter(root, NULL, NULL);	\
-	     iter != NULL;				\
-	     iter = mem_cgroup_iter(root, iter, NULL))
-
-#define for_each_mem_cgroup(iter)			\
-	for (iter = mem_cgroup_iter(NULL, NULL, NULL);	\
-	     iter != NULL;				\
-	     iter = mem_cgroup_iter(NULL, iter, NULL))
-
 /**
  * mem_cgroup_scan_tasks - iterate over tasks of a memory cgroup hierarchy
  * @memcg: hierarchy root
