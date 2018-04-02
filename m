Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752938AbeDBPJo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 11:09:44 -0400
Received: from mail-co1nam03on0040.outbound.protection.outlook.com ([104.47.40.40]:48864
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752358AbeDBPHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 11:07:14 -0400
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org,
        tony.luck@intel.com
Subject: [PATCH v4 1/8] efi: Fix IA32/X64 Processor Error Record definition
Date: Mon,  2 Apr 2018 10:06:49 -0500
Message-Id: <20180402150656.101022-2-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180402150656.101022-1-Yazen.Ghannam@amd.com>
References: <20180402150656.101022-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN7PR10CA0030.namprd10.prod.outlook.com (20.176.16.43) To
 BN6PR12MB1905.namprd12.prod.outlook.com (10.175.102.11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db38b163-98bf-4adf-242f-08d598ab69ef
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1905;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;3:o792EJyATFx9qeWrh2uEToLRolKh7xrDPjgBNtrPDAv/AVPb4eRj+83GEu3PBT14kxDQMXuPHGh8YtjjQJy8mDpzYODHFekPNGe3kb6iZXf9HEzbMIQCjaFBqPR3/Wbhsbmf7qAnqfoRuY7ZGGm4DYGrikUyq/NjI3nVMSyPLmStgqqoJrQQu/aW3jzIpFNSKp4aetfIIzLMOU831RPuSgCm+Ti14P53dfmZJXtAGeo/6CsBDBPBLam3TRKL7mE/;25:EVTFs3WYvRnM4Hp4DYp0uYsChZ2/O5X3pQ6wQfXzmRV2G8a6sJ1S6xqNE8fkr666RciiPt3InmVfX6mmI5OS9fAt9rmx9OAdsS6cCR7rVzhNYYaniTuLn5cWXme/CtGi7pn5IIIRV+hD+UbviYsG61pQXKDeCg03b2RO0aIobsT2vaP1f7CJ9dVi+/qBRqNcl/WLfGhznmqlXDYE6jxYEf1EyUTGK1xgi7RCAww94ZZ69crH/zHpQ9b3RcXrXMSe6QUXO4xQ2nq61469s4IWklnzJ7Avf33Bo6AmbJ610THQu1pE7wUdnminttlA7CrrSvT7yG5CWaLbzY9TtOvuYA==;31:Zqi1yDKelLncehlFPI69ZEiPX0yLk1/UyzNVj9f0xnj0evjONGgGAMoYeR8QOvoMyJ5uL1hZFC01upLEhPvmTrtdVeL6UXYPdVPoa8t107c9iStTS4FNHdylq5kBC/ZoPc5AcldimqaLFiwhu9/nvewGONDBY1ehHl8Hs9vhqyYCBHSGWOpTRERYsrnZ9YHz5DI3+wtXCexSMhoBsDyuSfJpmirqSmgKirLGVG50KUI=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1905:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;20:xdBV7t0Q7G6mD50Fj/QL/cWoOgXKNvbukzPMetI0qvR0GL7vyt8AeXvbpTUtFHAzdzMYf6R7RG0ZtBjll1NXDP61Bvl1knV8kwOOEvC+peVbqKKDOtHjoKnO8rGfgOdFRTFHQsaEQhj463eYF4LgTRbUhjBeUvQtZjpFQEtzYmponFJkguRRxMe0KqNCjxUmJWmpJyijIh4Z/56cxl59zyZvSAriO9toGM15lupl1dJDR5DxNkv/mGSrJG6oygnCwdW5C4D2UkCLK6DDCTLAjIu9ac6SbJx61CFAWpZ17EzeMg0YmmHPDG0+2CRHjmoufqTu76OQTXzpCV/jJVuFOkRMr0LfvjLPU2YlflMWIguXYoY2hH7ufpN8WqBvb08SOrQtjWOLcD6Tw3s641/ep5noyWBeiai/+L6hRn74FrGxIZ4eMgh4GWip6icT6R7/B0bmnwDsg/sFZM/H8syXbMIIL78Wql9SbinJP2n9Uq6d5P6d1IQK5K5OlL8dUlwp;4:ssagML1GIj1nGrk84SONvFOS/nZtGWTgj5LC/q8iOKjrFGEgyTV1BJ2j2RXv16FYgN4OXzwYZcSr3Gf/WpyMZ+q+q13QHCszWWzkFEeeLIVMaeU0eMb6MHpZUbRoaHJToABGL9NdeJKaouvOfUpl2nrR3ySnKnlj48EWbLibc9S0Axmcpoy2g8tpvBGIGWWUn2qKhenqsbBKffbwW0oGn/cGcH01l1qXHI/Wpw4Z4hPv3psrmnt/gQB6kyAJZZCiTXTQLBpDxyQyhxRtFV8yPr9qkW9wWyVzlYmAqagzFezEjEKv8lPshPQaxuGVYRlYldHnWHJgRLQ94SwVdE4ygV76kMpYYxSpf4OhJtU/Td4=
X-Microsoft-Antispam-PRVS: <BN6PR12MB1905FA2FFE37D3CC3B7F3BEEF8A60@BN6PR12MB1905.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR12MB1905;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1905;
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39380400002)(39860400002)(396003)(199004)(189003)(2351001)(97736004)(86362001)(105586002)(25786009)(26005)(6666003)(6486002)(8676002)(5660300001)(106356001)(50226002)(8936002)(2906002)(16526019)(81156014)(81166006)(2361001)(50466002)(11346002)(6306002)(66066001)(53936002)(386003)(48376002)(1076002)(446003)(6916009)(6116002)(52116002)(68736007)(4326008)(36756003)(3846002)(7736002)(76176011)(59450400001)(316002)(966005)(51416003)(305945005)(7696005)(47776003)(2616005)(478600001)(956004)(16586007)(186003)(53416004)(72206003)(486005)(486005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1905;H:yaz-diesel.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1905;23:w7PSHcWSFAqAdtcotwc9FK1CyQOvFrqDwM3/92Ae9?=
 =?us-ascii?Q?ccyG38PEVikHRvkkHjA3gS79VrdgL0R8bes1xSRZycgtJFi9hl0GEgZTQRKb?=
 =?us-ascii?Q?7Q5avWur+Qk5dT1azJ+BQ3vOI4tlyh+BKRY3Y2GqtANyWU9KVzj+ruT4uamW?=
 =?us-ascii?Q?NuqmlV7pQ98/045IeiKWEYL9ya/MPHV88aAHn+q7gBTMIAJRp+btAwcQgqFw?=
 =?us-ascii?Q?4u30J20LzGXwCoH/qmrm208B4jsZZ4uv5kxMqSCWcudPXcqZgyymqtSUVlO3?=
 =?us-ascii?Q?sxrk7Py6d5I03MQLuEKIAiN+gab0IO6jy+FPcF8v0kKycrILdlD45Vv3XAVM?=
 =?us-ascii?Q?Yn+HwqTOjcQEP2SSF568/VLEGNreIL1J0KnnJgY5fm/ekdtr9NK7bh6hxu8b?=
 =?us-ascii?Q?Plbgv/KJpIFYVMDr1/USnuGuSVI/Tz02L/oxirrWZxevl3V4pSwmU4nR2APm?=
 =?us-ascii?Q?sagdsiiXXZvxWHTqTGW/yNvjOcMcSq3FmwClL0rxUv8KstfBHGDQJRYVP8tz?=
 =?us-ascii?Q?thvdcEN/GC853PtHh6BnJom98ERmOt9phF21d0LuRiipaEYoLwFMEXQcv53t?=
 =?us-ascii?Q?cATwxGSIJyBWbOy5fpOcZhLZwUnQI4D19GLG9307t6MjafrworXWKu/2tqed?=
 =?us-ascii?Q?t1pazjR9afD5CiK45lLA5mk0wgP4P9nlNjTDTkXD9l4Mf2ChqI0CNANq6qKy?=
 =?us-ascii?Q?QavlXsiWPEJTz5LisU4zqqSdp+x4NydKXul7TuUfjHEkx94aNbw4Lq9g7o/F?=
 =?us-ascii?Q?HRikKTGRr0ADuVgB1qzXILvLKeEVHvQ1HXgtZfKl4r3ZtVbLYZkEQWBtI1k8?=
 =?us-ascii?Q?sVPfHnIHSeF164KuiWvV9TFi25SC3vYiB9gDSHv9EOoZbXkH5nInbGarp2ju?=
 =?us-ascii?Q?gkmgRSLpVqnFY8RUGHkIdEHu9ubrM2JhSGivYSTk3tZ+EwstX34pnqug9ktZ?=
 =?us-ascii?Q?oSdZsE1PBFVwovWg6u98B80n6y2T8DnXtZTjXylYtzIepIwWN0nVXcCOsh8J?=
 =?us-ascii?Q?K7QmApROwc/HmfhLQvwQhQplhcJgVjqCWAIj3M6IPtIu36UgQSsDA8jDvWuR?=
 =?us-ascii?Q?UpwXOSGJCNZfrU1a7xstRI7CtTCNvistvA8k4N0prh99sjYgfJLZH88kcdUB?=
 =?us-ascii?Q?PLNPUNrC5MDYposZeIPmFGqeaCg2FF9Dh323kDgFi6cO5WAjyZ+T5betuo3W?=
 =?us-ascii?Q?XVMtnXK8io+nWStND6bg4HTzUgAI1yveq+BDJpbzwaw8SPcGmceMbg5A4C2Y?=
 =?us-ascii?Q?r14LJIMOqHIondXBmnTYotRu0Oqjp6VcfBcUeUibqKM9zXxo2ROj1AfTzmuh?=
 =?us-ascii?Q?eVzLbCD4orotONj+jocWObwbTBESeQNPVtyYR6b/a+K?=
X-Microsoft-Antispam-Message-Info: WJI5Abo3f7HMMIRFiDlx8dgnERDaimDQ2+KUDVNWMosncDLNY18gK9V/TJ3N+WuTI+XTKs6HW79tmHtUQ+WO7KtzVAOWOzMt3TLbmQUbaW2sYq2LAdXK8VlYsIBybT+l5yNRiErVJVaAIhfZ7OnMRokFaTCCk9xcdx/n/zrL4ENtCcIm4IEVyziE5wm/Wb5o
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;6:PgQXxCTwC15NlodR4D/9V7TYhsVxdyB/UsJv3xn4eGr/H3RJdTzt/fMgregaIgnsMOr+SPzA+oiNBgh5vgSyj2bTrHRyb5hHggUdVKuvMxKPu6va1whxFgaPOLxEfQXFOUTqMbDN70y+cW8ScWzt8vtAKGNyWmpZP2H13TJ2BuK6XzYylGQm3+JyffzvU/mfEl8eexNLm2xGYZ7Sx2afCAabicYhu3mLiPJDYg2I0dhR9urPH/9h6VhzzkxrV3Nw/DA2LGJrdkaT3cvDiipDJUQX4NpquAZon0fxriY7xKtTdJVeew/Zh/YTJN3P2LMboIIL8C/xadQ4Mywu3WOapBUhYeZiEBcmcZEwaEe7vfh6gdhWhnkkGm31EKx/00Sdl5RWVQ3J+/XduHeqT3wXpQwPiKjReEwYomkXCyp3bxIjN2QJ1Hwjm/8pEw4QX5m7M92UIqi9QAk6VzYeNXwjEw==;5:VlMm/2t5fNcjQ7cIBovA1Yd95xhkMRGUGaT3GIYfNjJlKLgyzMZbuUbDMwlkKo29Ekr8hN6gNqB48beH9Q0z86Hcox31evg9SMyqfllOreviL79DRixFcM8iBixY5KscnFtNeuqwDzM7u4eXVfF/L43Eqv4A/fElgnJ6CR+lAZQ=;24:xl9gihwv8iSu2E7VFuM6aCheVqBYQeSV/f+KcjxKnzLWTD8C4JtRQmywlKld0yZt+HXZVTo4F+5KeFq97tZM1hLiFFXqtVqWsqDISTHLIiw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;7:jW9sKWxazQpMLHUXO7S0Bhr+44OGqZMBaqY2VcZ3Mh6bCtFl5SbhmrRWq0jVMEKK92SaeroJjNVmxORMdFm2m0Hz3Ymbz2flP64mgy1Pt1clQ3Exgerj/HKWLy9bmMK4Am/J1aP0rAPkc5WC+SVTCVAGnZRqvotnT2HrI00bgyZs2fLOWJu/6HB1lnGTROCAUOvqSq9vk6mfzeLtGQKe0I0PCjxFo738MX9kl9Z6DXv40SbJFNZ53O9Tibf3glqJ;20:TLpGDqWBhyE07jgwUke8qJmXjRSB/Tw2ghI10VdBjkm9Bn93QJahUNa9xZjGET1u/L4CXNtLy89NAvsPWd3zreCudBYwMmJEGyppDEu9Fs5k5UyA4Fj9MErTaahenwr0pN9ZDqzQRFA0JzBIfbKYfVqYIvDcDwbLP0U66fFztfWTlwUtSgzrbThvs9M1z7utkgPCJ3HYxlhdiT1RXY436/M5PQHLTiHm5g8o4+b7+1ajvXFyJmDP7IjbtlVhDzgR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 15:07:12.2799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db38b163-98bf-4adf-242f-08d598ab69ef
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1905
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Based on UEFI 2.7 Table 255. Processor Error Record, the "Local APIC_ID"
field is 8 bytes but Linux defines this field as 1 byte.

Fix this in the struct cper_sec_proc_ia definition.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20180324184940.19762-2-Yazen.Ghannam@amd.com

v3->v4:
* No changes.

v2->v3:
* Fix table number in commit message.

v1->v2:
* No changes

 include/linux/cper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cper.h b/include/linux/cper.h
index d14ef4e77c8a..4b5f8459b403 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -381,7 +381,7 @@ struct cper_sec_proc_generic {
 /* IA32/X64 Processor Error Section */
 struct cper_sec_proc_ia {
 	__u64	validation_bits;
-	__u8	lapic_id;
+	__u64	lapic_id;
 	__u8	cpuid[48];
 };
 
-- 
2.14.1
