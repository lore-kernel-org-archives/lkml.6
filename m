Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759430AbeD0Vft (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 17:35:49 -0400
Received: from mail-cys01nam02on0085.outbound.protection.outlook.com ([104.47.37.85]:62624
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1759082AbeD0VfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 17:35:07 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, bp@suse.de,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 3/4] x86/CPU: Rename intel_cacheinfo.c to cacheinfo.c
Date: Fri, 27 Apr 2018 16:34:36 -0500
Message-Id: <1524864877-111962-4-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524864877-111962-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1524864877-111962-1-git-send-email-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR15CA0030.namprd15.prod.outlook.com
 (2603:10b6:300:ad::16) To SN1PR12MB0141.namprd12.prod.outlook.com
 (2a01:111:e400:5144::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0141;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0141;3:OxdRBeyQS5qBFvqi7krfxkojX0NjErw+p6Qny2n5Jdw52BGtPP04MFCKkyCPh+7IjTiNiU4d7id64OaOQTCp3H4rVebsC3SLt16aQBgFV1QsA+VmjEw2/hw2wjC7xFtZ0vxMfLix3YzL8QsEhvoFuDadCyfOUBi98QRAD97Uh3xaiQmqdPxyWq5gHTcPzkFhqyiJenHR/ttzOa27sO/faN9Y4bI4gzR7dyln7zxAMPYukI4zqT/iVOMvUVKcGdCE;25:4SxR8afaJ6uHgGjL1/+TsS7jqRtKW5Z4diqkBpNlxaXhS39KR7WBtJEmlnA17CCI6sXWFbnXNvG5mIruR1WrctusHqbLS8o2IRC0ERRm1CvVcqw5mwecU4CKRnCwqbl0BKj6T9Pn48wFCqCICmwMWpRBX7MqbGww3lejMasbiC0oNO7T62N19Uu8tXDNtJb398sno1oiSOPPAswdjmTdaI0AhYfYKgjA2dQ7AP6bIVI73hAPasYkNRn7CELVAw3kHlxpRsiy2d4agCaWMBFNAT1p/EkNxh5cOKcxS7Y1jEYmkioL4GY0jvYKnLk69FFpIb5PTMjAUbTy9SUhATIYqg==;31:e7dFWnUJV5M7FecXZ5Oq0fbWWuby5u0fqaor+HfpzCCSZXqrUkH/nCXgtkLQG+a/iGgNZCZM/BD/8nEjUKy38ohLQZRyGJg84yqlmTZzVzVe3Kix3To+ODT7GxLVxOR8qKpGtZpuhb0PVigrqmGQooNlMmCS+S+yBFdN8WpFenMCaaAbTQbv4SjF7LiNBcTyT6yk1PV6uTno26Jk8nSwRkSWK+3Xi/NtFqMVWBdVUQI=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0141:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0141;20:6u6FgWGbg8SPF9S/6nI59eC6GoN3URac80jBn7/9GXGCJe7tIkUNlLwlVIilvVjeka3Dq7pdJ/JNcjuTKQXvHrb36r6Bb19tn0XddRxKisMy9Ci/RngMf+90qr7KH/ecEgTFxdovvIUFPUoClpnmI/Y8zseLm5OwZv/qpcGqQDjtnCt+Ngy0CnWXFV7SdIQFuzG8VIEaT3KHQifIXdKx3QGJJ+uynM+dRMTEa5XXi6FfmXA3X1/23zu4t7XkaTfRchhSkONUDVaYiS9NmWO5q4ZHtwtbGkzBaXnAO9ZZn5432c1+IAVZQPHgyLpDXWDyUggspBK8NjtuRxUQgEfrgRMDOHwXEK8tTtSnXGfcr0HMvT7lP28GuDa+6Cz3R8VW7w9u8w3IHHu6evOy2xeZqhJ5/e9SuUrSlo1+GI6VcxXa2OkIjwe2k5MaOSSkCRiXMw5jYtbyV23DmrNu98S5HYvg3eSrvoObOguhpPbs/uZN+LBGGplyOlTbQfqSLde9;4:Yh10UUnl3JtJ9+0Szd/T2JI/yRDqEBJJYCDa3daulJL6Adp9OKzo5m+8AwK26hRQlxEu7fBHKPLcU5VxTZ98qp08fly+169lKjAEnesGXbynRnUGVvU/gFmvPJ4+Y3fJpuW/2yhLVcmpFqNjHs5V4NH94B76aWCa0CSdqn6lSdr7r97f9oWtCpqBFiFlW7BhSaOhKtVFnNph3KCt4grvOXoDTwRXQEzEdMPrMXZtEcNoG8Uj3y26yJMEAdcFXQx3kCYU62hysQU77qHF1zRfpB1fiwzHHz0cKj0t/WIX+M/zTY8qaTgiUrK4VpPGXgS7
X-Microsoft-Antispam-PRVS: <SN1PR12MB0141DA6588A99DC7298C7A05F38D0@SN1PR12MB0141.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:SN1PR12MB0141;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0141;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(39860400002)(346002)(39380400002)(189003)(199004)(478600001)(956004)(72206003)(446003)(44832011)(2616005)(486006)(11346002)(59450400001)(6666003)(76176011)(97736004)(2906002)(52116002)(50466002)(26005)(3846002)(6116002)(51416003)(7696005)(53936002)(476003)(48376002)(6486002)(186003)(50226002)(68736007)(81156014)(105586002)(86362001)(66066001)(305945005)(16526019)(316002)(81166006)(7736002)(53416004)(386003)(5660300001)(8676002)(16586007)(4326008)(25786009)(106356001)(8936002)(36756003)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0141;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB0141;23:Su0UF6wIs/BxT3J9XUHwCZfJo0h+7C6eBn3O3HPxT?=
 =?us-ascii?Q?hqIZUaXCxqdEL/dMzY2HV1bROOF4h4EGY0QpuWGf1nvnhHx/eGN6mo9U1LWf?=
 =?us-ascii?Q?tZiJU1hZl/93QJttLEd3cAw01AxM6LIZal/jEGtoSTcZxOiVAciBIEuwO/6w?=
 =?us-ascii?Q?Za08Zsm6zBbROhR/u5L180ApqLNOKBdgB82TEyzkky8wwFVYAs3IMZcNT3AB?=
 =?us-ascii?Q?ZQ7+D2wwK/o9JHnhg1HJtRFVyaHD8nqsJWFO8Lb/qi32CuB9rBDn1KCuEVmP?=
 =?us-ascii?Q?GesdJWBKyY+kM3wlfQLAf8qxSZfqiObWw8b6D0ghgs0fxlQF2qPiaYERf8iM?=
 =?us-ascii?Q?Q6ShPJn8EEQ5ofh50Sg498iIssiEhdqwzffxWh0iYbN9coK1K9BaOlnU+pIL?=
 =?us-ascii?Q?k+dlSqTSvLaO9ddBL44QZdkMIVpCBrWgDw+lYla0yycqE8v9Bav0Z/8dAyd0?=
 =?us-ascii?Q?wE1xHW1eW7g98CZ9+52N4SoKT23QGstxyfnZHsS2SWvfcpcHVwZX64fw2Wov?=
 =?us-ascii?Q?90QP47ExGiEFly0vCGFpgGAZhvlI3Wb+cK0Wdg+xidKj8qafnNzUPlj2udff?=
 =?us-ascii?Q?vb3kgVS39ABYskG7UtVFIjRvA5msycvarTExfuH0oiRIwEafSznvU4RaH61g?=
 =?us-ascii?Q?qOaq0ypgc+U0YdynjPsauJ/scg43GutBShqQiI/sBCTChLUYdIVbAcBcDcet?=
 =?us-ascii?Q?44N3tNmAcjxtPTzO68IEAVA9OZ0C/wo4rvmKRhIjNuLUqy3Ubkn5HlnNChWp?=
 =?us-ascii?Q?t1n3i9INXMTaK+5H+n//dZt0IiqRf8ryC8l4MsawUqAs9DeHl2fHqHq33GSy?=
 =?us-ascii?Q?JLfzLlvKWEDE9XQxHD+tkP3764HPiDN0N6+W6SDmrjm1mnED9ejQGhysTCj0?=
 =?us-ascii?Q?UPML/kFtcjRWTE91ftVmgjT1DzUvAKk5gzJZCDLtQFSZiRhxiBEg/5t9J00r?=
 =?us-ascii?Q?81vcmOjxHeHwZPDArA4//BdiXlKgnYIXXs1/8kgxegle6WLnHHzqoV3C9va9?=
 =?us-ascii?Q?YE6eEdQHFTbzjWXK0MslHnekKbcCZfrDfl4Dvh28uZWWinMtQw+Yug+u/luh?=
 =?us-ascii?Q?HKnLUfM0Xa0D0wRvNin+SvKVrClGuAh9nDL/YyVVt3AjqtBIR8Ta39MPeqKm?=
 =?us-ascii?Q?1xVdTH9QSL0VqaE/yrrvydSgyYmqJZpWr6CQEk3RoBeKfrAzMZmbQtk9M9Tk?=
 =?us-ascii?Q?9xjKUTqelRkbi4gUXQXwh/TK1gvimNgZmaBDJ1Z5lcByG040CeLRQMowA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: dmFo4MneG+ICtVVebfxt+iiHIgrPIsMVQh7BYo987QaT9IL3FjykHcCjJeuR1SZ3SXkL7Ww1owBF2CED/NB6Fp6LS4krPkWlG73sSpTHXw0Viurv1FgWeAdQInnyHsA/iiGngNdpD8oTpHnI5DDZVAjnQIFk+GDw8Ran44Zg47QnY8spdRm6EOrqE4cn6HGL
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0141;6:4lPq7P0rsFAlncOYtk8SSwSe6sSBppdcz2mXHyzEzsnfxGV6MQezftGklcth486MYojhiRthPeG8IsD9tbTXVnJnLRNwaClV750EEqBM6GI/M6ECDPvToWKXuI3U1ptzbjxQJJfwANJ7UzfJGLXj3B1n2MeJ3h95Y0R6s0SrhJQErokM0cL0YKQ3Vx0PwpBY1Kt1lxeK/BFFWncR2gp24FgnT2ZI+OiPvj626oef8pKfdPEVwchLywYDxqWCCbDPQF6qTx6AyHOgH0/LTrUtjqq7HFTCKqRBTNktNOTfG4fYjOTL6B2G8YXyh03JBMumZQjooKXaSHrKBhgFBPvJQZlGr2+kTQ+xRsPquRNowZWdOyCTfaAmJTmhGxGSmrx1Zw1Wy0WNUUysvYRNqFez0aMwfvET2WHfP50C/4ykaylb2XqYIzlSalrObobtMs4RtF2R92MMjrfJLvQmON1sSA==;5:H9/QFpii9b4RRB4jfQEhU2opPB9EwqcsA2DvV+cGEzZxxd00PHTlJp1B/5n2zzmm1kaYUfgpqqQw64yL+L6XsHO3er//58YBxvW1ZdLhz09DZfPxzOpj0NpBmP52OAnGYJa1YqW6ESuqRwrmNWMvUxdGhcFJdTSeShKTTGHHQHo=;24:gbMlThyluM6xuvQZi7ER2ulWuSuDLavtkkIWVbsYsXSETA2FT5nNYRcAFwnJCASkmSmzvvtU6D6jYGHWMkMWYPTL+9wka6K9ZOSvhfEoBx4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0141;7:ZTKeG8Lk/1yXU68HhiT+psL35pwauZkXhxcdKHK/yTr1EBrsLr0aYDY0R8OQxyPzsuIj2TiiJSHYaiMkIUG4PjCXjVgt9pllvvVLPR9mXuSXd43bD9C7Pr4d0HEpYWzC7n7oL80PkU0oLpQON5+YlqbXS3r7VEG7/maGoiy0MfjyR67XgjZeEM74OY+YgX3BGSyFUeaeFnsL6A00ZbE4kIysCCMhVpFQH1p8Tu30BQ58qzWXOmNoE9l8MK46BPpr;20:nZqJtu2F2oEGKmxZLShhBn9EQfLz0GgnZjlazG1rN2wF6YTPf4sAyn1BLNVUTER0pyfmIFZ8akmf4pkWyo6X3sb/3XIQZoh78sZ+/3uvO1xqjRW4wYteOhQ76qSSlfNlgtcsJQYe/NESTnRDii3OX32z7CBKzKI1mSyXp9ubph/fhCre+teZ/868HLbT8Hv6EKau44GD6X99i8/LZOBkdypY8vJtmpVGGyQ5RHSwubs5RZw7fIyfw+LCOghqKgoR
X-MS-Office365-Filtering-Correlation-Id: 63fbfafb-938a-43f4-6892-08d5ac86bd09
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 21:35:02.8648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63fbfafb-938a-43f4-6892-08d5ac86bd09
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Since this file contains general cache-related information for x86,
rename the file to a more appropriate name.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/x86/kernel/cpu/Makefile                           | 2 +-
 arch/x86/kernel/cpu/{intel_cacheinfo.c => cacheinfo.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/x86/kernel/cpu/{intel_cacheinfo.c => cacheinfo.c} (100%)

diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 570e8bb..32591f2 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -17,7 +17,7 @@ KCOV_INSTRUMENT_perf_event.o := n
 nostackp := $(call cc-option, -fno-stack-protector)
 CFLAGS_common.o		:= $(nostackp)
 
-obj-y			:= intel_cacheinfo.o scattered.o topology.o
+obj-y			:= cacheinfo.o scattered.o topology.o
 obj-y			+= common.o
 obj-y			+= rdrand.o
 obj-y			+= match.o
diff --git a/arch/x86/kernel/cpu/intel_cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
similarity index 100%
rename from arch/x86/kernel/cpu/intel_cacheinfo.c
rename to arch/x86/kernel/cpu/cacheinfo.c
-- 
2.7.4
