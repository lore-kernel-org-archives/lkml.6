Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135ECF83CA2
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 07:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F96520842
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 07:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Z7exb+1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F96520842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbeG2Iev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 04:34:51 -0400
Received: from mail-eopbgr00071.outbound.protection.outlook.com ([40.107.0.71]:1068
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbeG2Iev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 04:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XroRJP0S2k99RYyOBe26PzQrid5q2GAHOqF74q3721A=;
 b=Z7exb+1hvF/TUrOgr9mAb1VHgxaAYIeNnv92mHZdIQHl93ohZdNTVpvYpkZnr/PzuIZOlh43/mqsx95ICOZqUIWVrOE8JMlBcIVou8Xl1Z0kexEYOq1B6udYrvtFV+F3dtBYsw2McE6CNK8MXkwqvtFv3XVReUtnY17D+B0YcXk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from localhost (193.47.165.251) by
 AM4PR0501MB2689.eurprd05.prod.outlook.com (10.172.215.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.16; Sun, 29 Jul 2018 07:01:29 +0000
Date:   Sun, 29 Jul 2018 10:01:13 +0300
From:   Leon Romanovsky <leonro@mellanox.com>
To:     rd_dunlab <rd.dunlab@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Elad Kanfi <eladkan@mellanox.com>,
        Ofer Levi <oferle@mellanox.com>
Subject: Re: [PATCH 3/4 v2] arc: fix data type errors in platform headers
Message-ID: <20180729070113.GC7157@mtr-leonro.mtl.com>
References: <15326613951079@infradead.org>
 <1532661395712@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532661395712@infradead.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: HE1PR09CA0055.eurprd09.prod.outlook.com (10.174.50.23) To
 AM4PR0501MB2689.eurprd05.prod.outlook.com (10.172.215.138)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87a5d411-62a4-4b17-51ed-08d5f5211bf1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0501MB2689;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0501MB2689;3:BNd1PPUzWSI/GRMCKFXUOBc6cl8Q36O1knYj6YivdQutTby+oOQOrWabUWMJDaK+A0W6CeBhkJDHC1+axGpj+WRw4qF6BFoNJl1lXL9hjVIPeDl9e/WBJ9fXlncdx23NZu/FJCvGLdcSmRpf9U1ONUOg7J7tEC9fjwqtKwDCIh85T0DsqW8Xq6avNDxbZlNeX9q53oxiQczP65XOMCfx9wPI0E7N6WcvyyxmRuF48Iw1a9vzlKAS31hMFToB7QfI;25:Ugu2OE1JZnSwQKRhLlmFMnYLzB2sZ1DmHzQ++BDuM74wG1lUjbBIspy9nutT5dT6ZIn16OqBupm/n69w1GyzzCZtYl5I8eEpudURupHywhy5QcguoSFjPmgQ3jPS0xEZSDhMAGT1WFaykNwbSxydQVkx6WYAt5+tpX+wplHXgoW7+6u1O5TOzk/EeSi12PGV3fP6H+sQbdfYBakVWBCjzX5jFdkimG8BuacrAjMpnnWsHYRCnRCHl1t7YlTRx1RdBjBr3I5Mp1s4mxwnn8kk8ycFDOIAiAdircl/638cNrIlqnWAUo9zH6/Llccy8N9gxG5lil+AwTVjRZAcagNznw==;31:cQ3GSynmDDQG4iatZijtx2b1J/Y6qY33kITeKIIC0AJmDZSQXdxVpWCK2yTYGMp8/FQ5pvHJHT4oGio4upQY3czXm3wIh0CwczkP6BdzBF1P7WfF/LgtDZdq1JtqxVnnSlkHLU+I0jJ+BFTbVttWdihWyJ7zcgvBBB445+DT19IIC8dM6LbCHH0Y35XN51IlSUIA5uy8TDKanGEwZXtDiYeGR9VaUM63RAdq+6+8Cdk=
X-MS-TrafficTypeDiagnostic: AM4PR0501MB2689:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0501MB2689;20:3Y1FsScV55IIAvMTmRmSwVXtILoimmg3rOtlCv+pW7IaxMBgS3DzwXANV5s/mFkyXQJ9pzFVKUpN8pF/KSt0Ofe0Dyh7vuUhvcVQdNSBRbeny673IWjljtAZA0Ul5BGnkczWkteBSh5hdR7GAhFgnBPuxheBIcNrtP0YKb6xtPsEqfhmYVhdsBKID9K/SwAzLKf1DEawTnjtSMbWW7OOMOlPoE1XfbSKqJWPHdVmq0K1vlg51TJbwFhwRXTxwrzc6IQQzXnz8efURi7KClxAvL9oiscjcLBO8mzQ1E3CxAoA0xvZsENVmiNVQSmYIup3WZasSVrWvSniuo7XQhQCEJDYk62kAKnrmaNhtUKemQoFDV0fu+R5A624+UvIcmXs+DP9FCUmdeZIAoSqocYcmhwFHqemYCH3f+jxt2kjbBfY1moN8UWGN25RRYVOSyf4nLJfdnnXXjvVeaZm9XBlRXo1Ew09ryKLhd5TW/UVZWk4UKV5sB0/buFBfWw37oXC;4:4zDVELkmu1rlX4IFiOeYFjOkD+CV0DnZDJkwnIEJ74/xLfWQkoxJhU41z6Bxa5BOa3vZOcwPDIkZwz3gTcxZWX/4gvDZMgCMj3+SKdqbS+rrGBlklREPwqwCFtE19MpOKyz5AvhL1q1RleqTVgdFNeFZaanjfl/hDQqy9rfdUiEUfsR1V3xgGMy1ypvsH3MDoUNoPLwre+1pcCiIZGt5TqZDw5oxx89THLnh3J4X8jj7/BjiqQkoycJx48DxXnc93FwPJkdmoL6Xtx6BrUuwkBkQK2KOQcR3YQS3Ox7+beFBxqM3MlbBH5IqONuW6Svu
X-Microsoft-Antispam-PRVS: <AM4PR0501MB2689C2926EE329CD8C442F22B0280@AM4PR0501MB2689.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(258649278758335);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM4PR0501MB2689;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0501MB2689;
X-Forefront-PRVS: 0748FF9A04
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(136003)(366004)(346002)(396003)(376002)(39860400002)(199004)(189003)(16586007)(6486002)(5660300001)(54906003)(9686003)(58126008)(105586002)(316002)(53936002)(33656002)(86362001)(50466002)(478600001)(25786009)(68736007)(106356001)(386003)(76176011)(76506005)(6496006)(81166006)(446003)(8936002)(305945005)(956004)(476003)(486006)(6246003)(4326008)(107886003)(33896004)(81156014)(1076002)(39060400002)(11346002)(7736002)(23726003)(52116002)(16526019)(8676002)(229853002)(97736004)(186003)(26005)(47776003)(3846002)(6666003)(2906002)(6916009)(66066001)(6116002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0501MB2689;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0501MB2689;23:yrhHvBKTiPt9jL9/jRFZHU6+oef60Q1eWz3617u?=
 =?us-ascii?Q?RioEfqyg3f9b/48pJuqIJZ7G8xnZQbem2JlLNzxyVXwXhcdl+vG3YAS43jDN?=
 =?us-ascii?Q?+HnGmYivVbCcwOKoKibDSNId9r8cXjfpRRg5DqHnKEXPQO2r3bbeW+0TBZIY?=
 =?us-ascii?Q?51p/HovXTjmEEsCadh6Nwx0PV0sW0FSsclp2lYAMD8/hH8HrHCRo7NmrVtA/?=
 =?us-ascii?Q?KSTPBU/pUfP7Bbc/e2iKMIehK5PDTqg8d/UwL367gliCci0AHJvgiyge4LP7?=
 =?us-ascii?Q?DDW8LWfS0OQfLlrOpcVINFMul+dvdg0agkkDvb/JD3NvSdk6zhLIVmxNMpMn?=
 =?us-ascii?Q?+7h4eFrvqsMIWpFDzHozzHcCZXtUaJ90B2kt9b1Oaje8SSVt+kgZ3JuSc429?=
 =?us-ascii?Q?METYtfviGy6CMPycLJeV2+Dxd4GlJ4UQjlMrozDC0+nzXjgteZQnN4ge7RJo?=
 =?us-ascii?Q?VPmmBVhD3zuEC28pHwSEpO+el7DQ6AhGPAR8IVaK0LMvwfbm5t4mKMQA63Jt?=
 =?us-ascii?Q?ghtPR8W9AoLWaGwuKyQ2jTod8XiVMe6SCODCQU+zkoVPdS29paCwYEdpQXtp?=
 =?us-ascii?Q?OqsvXBTxcTV0q7D1iyTiTEK1T7PsTxAioQtFBVR8cKvuYqqfrB+Yz8NhK5SG?=
 =?us-ascii?Q?sMfdLTEaoAMkrsNInAK99L/l8x41mgXLjpoaqJWPPdXvCGSnHR8Hsv4nJd1A?=
 =?us-ascii?Q?qrzC7y/FYJmdHNY4+NwC4sd2YCgXPvRg/jtkharQR4LO84lVRBi8U2W0+FBd?=
 =?us-ascii?Q?dHwF2Qpd2DYaJSjotHwsvs190To+khVSEMWKY55SO/VvpVTi3yIWYcj+Np7I?=
 =?us-ascii?Q?LehQ9eg3sEcN32yciSkrk/3RcEAaJayyvVVmBYT/1EgoE8jheOJ42xSHYKj0?=
 =?us-ascii?Q?Vp5col5IYmRgW+NPjpKRDueQ+JITf1w3GIzSTB5MlFnFEFgT8aIss40Iu4PD?=
 =?us-ascii?Q?niRGFhF7a3iCaB1aB+fBDDm7h294851+KrEE1uAc9pWUKEHefDTBfahWhlRv?=
 =?us-ascii?Q?KQw3m+Txt15N2GGDGAjShukco9TtsDh6mHZuefP1vLGIBk8CyNzeWGlrAAya?=
 =?us-ascii?Q?9iqgqonlh2urp9HdjG5K8f0IndPp8F9UmLQfZROuuStXSCrflQqUJuVkKnz4?=
 =?us-ascii?Q?tQCmBDgwGxFXks32NZdx4PlX8vOx66fRtUFrSse4DruWxRe8amWD1V2ATNLC?=
 =?us-ascii?Q?GVSVzDs0qKfgU1ELhuD50kWXovfYLIxdVOW+2bkJiWO+98aYCxIO25braPrP?=
 =?us-ascii?Q?WjpR+5aDb3fO2ORtetoxM69o84lYqECd1Ky5vkmSFArSPJlWbNmAk13ck3Oj?=
 =?us-ascii?Q?tHUnMdYh++eAsY2nbT/TVydFBUB0wZtwFB2VEOQosEz8j?=
X-Microsoft-Antispam-Message-Info: qcza+A0l5NYsNlIwDD4pzdAyhaSRqPlrWsZUukt1xW8rlDRxjyDpKZ19E07JkASHnhlVAWL8wsfevEfjJZHw0FhnFbikRKJQMQvss+aRkIzI0KZWsrHaDFsvi5fefPvXV48WueHNj0pXJ3uMYFyb+YNfO5DZHFMABhe8IlccI3VYr1rVdadacylvabHoOWLBDBdrfTNvN09WkFyQj0tqzFksYtO5MJ0nRQn/jkJEITeDXwz2Bw+1aG28Qz4OUrbe4cUaFEU834LJ5iI9uAlr8e7Y29+tXf0Sc+bDzOVMrebTCHo+T9ttM4+REmcb2ynm8u/iS7yFYMRYCrTbV/pQzqwYWaUo2qaclpgtZHZCaGE=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0501MB2689;6:Rg+h9c2L63/RocUx03X3tAtDScJ9ErjJbiNLgyS1O9X1PVWUkJAlytStZy92IkOvQgz6GO4JEPhkB/Lp0qbKMjYOJTvY6zMrwbsWmW7mdniPDNiFN7vsUtidTnQRf8iIAKmBOcbdSBrqqL1Ppsr7ZQGcNirnubB+LCyBLKNYePR21Ju5h15V1i8Zj5yqbpL71pJpmB8MVCCMrjB/HZelTHPXDYvuzh/AOGUTSVoeym+toTCf1bxwRlziHLTnP9VqQaD4IEXptyXG/ZpUi6afzNy0wvVY5nRngymRD1UwTzCJkedfXgVBChS/PfQ8+oIfWIE6GZS9k8p+Kcim09uqjwmiav/XsJ4tWxlP7Hedv+c9uHjA7wpFsLBZnud9MwvL7XYh6lqY5oJdlH6P2bfb5afzV83612ah5CYWf+ljPDduitQrmcKm4kE02H9P47ggHOO6S43z1/DntLN6arJB8w==;5:BNf5hFhhoqVyczMG4TgPm6UglJkCJTiVEeQK6yHXFIEn8CiLJhjuAs66cTr9u66g76kdlVmsLfDfYM5J0bF3wn8BUFMD+XT3IDVIiSw/s7ELLZmYvkSQBlrjJpkMy/bcUQbPJo0/EXGlBgvtJLJi7MIIP4lgjYV3fwnf+sb8rdk=;7:OaDPQPlbhwG2kngkb86k2OGfpjDDx7Rd3EGf4djHkcliM7C0OvoSaYy490J09F24NN8gGP/ND+LBQdmYNJqnOoq0EaQieELs3MOfNB0/J3bu5xmag9l/DaE3VlD+ZMQ+KBUfEbehBiKKp+7yQXKXYHu+cf/Y7vbfZcygyFdPovdMsFwt+/+8A9upPZ9MBLyr/bPzmu82Ezs4AmbOZs+lCKiZGE1OGAaXghmpGgzSIeQse1Ys6Sp1tZ3XJ2aLjC8R
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2018 07:01:29.0881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a5d411-62a4-4b17-51ed-08d5f5211bf1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2689
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 08:16:35PM -0700, rd_dunlab wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Add <asm-generic/types.h> to fix build errors.
> Both ctop.h and <soc/nps/common.h> use u32 types and cause many
> errors.
>
> Examples:
> ../include/soc/nps/common.h:71:4: error: unknown type name 'u32'
>     u32 __reserved:20, cluster:4, core:4, thread:4;
> ../include/soc/nps/common.h:76:3: error: unknown type name 'u32'
>    u32 value;
> ../include/soc/nps/common.h:124:4: error: unknown type name 'u32'
>     u32 base:8, cl_x:4, cl_y:4,
> ../include/soc/nps/common.h:127:3: error: unknown type name 'u32'
>    u32 value;
>
> ../arch/arc/plat-eznps/include/plat/ctop.h:83:4: error: unknown type name 'u32'
>     u32 gen:1, gdis:1, clk_gate_dis:1, asb:1,
> ../arch/arc/plat-eznps/include/plat/ctop.h:86:3: error: unknown type name 'u32'
>    u32 value;
> ../arch/arc/plat-eznps/include/plat/ctop.h:93:4: error: unknown type name 'u32'
>     u32 csa:22, dmsid:6, __reserved:3, cs:1;
> ../arch/arc/plat-eznps/include/plat/ctop.h:95:3: error: unknown type name 'u32'
>    u32 value;
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: linux-snps-arc@lists.infradead.org
> Cc: Elad Kanfi <eladkan@mellanox.com>
> Cc: Leon Romanovsky <leonro@mellanox.com>
> Cc: Ofer Levi <oferle@mellanox.com>
> ---
> v2: no change
>
>  arch/arc/plat-eznps/include/plat/ctop.h |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linux-next-20180723.orig/arch/arc/plat-eznps/include/plat/ctop.h
> +++ linux-next-20180723/arch/arc/plat-eznps/include/plat/ctop.h
> @@ -21,6 +21,7 @@
>  #error "Incorrect ctop.h include"
>  #endif
>
> +#include <asm-generic/types.h>

I'm not familiar with arch/* code, so maybe my question will sound
naive., but why "asm-generic/types.h" and not "linux/types.h"?

Thanks for fixing build.

>  #include <soc/nps/common.h>
>
>  /* core auxiliary registers */
>
>
> --
>
