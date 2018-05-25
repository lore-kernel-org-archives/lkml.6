Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968326AbeEYUX7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:23:59 -0400
Received: from mail-sn1nam02on0059.outbound.protection.outlook.com ([104.47.36.59]:55968
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S968035AbeEYUX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:23:56 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com;
From: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
To: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Gary Hook <gary.hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Brijesh Singh <brijesh.singh@amd.com>, Borislav Petkov <bp@suse.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Subject: [PATCHv2 0/2] Add new SEV commands
Date: Fri, 25 May 2018 15:23:28 -0500
Message-Id: <cover.1527274269.git.Janakarajan.Natarajan@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0801CA0019.namprd08.prod.outlook.com
 (2603:10b6:803:29::29) To CY4PR12MB1368.namprd12.prod.outlook.com
 (2603:10b6:903:41::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1368;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1368;3:oePHzHp1uvdZgyHBFNv+9O+4boZ46TPCokp1KEfr0DmLVg8fWs9+rfR5ZV+L/kV+aoacSX73q+nLJsz/uR3UAQMaPelP4+5+d38++rXokc14yuPXqG9lYVFZPrK3Dlzi9hYx/vXY7h46W8zAbkdNsCcUu10HBAs0fmBxPfrIiP+8p0KyE47p67iQuVDKpZgIrrWAT482E/hSFwt3yeRCu2wmeVBlOAmq7f3iZb4Qg0AjR9et0xXRZ8Zo+UhRlRZ4;25:wzywX7ZwnOjcEP3qzDLCKF2JVzJPyj/6mswBKO3oK5iRFlQNYVh7+q1QCDsAhXcJLwegLrQmdr4820fM8LonF11c+cHcQQBnvkhIP+LR08cPgen0tBpxnlhj7ezCCD/2JCqmkV+X9GrlFgkBSk9RcCu0uMDd9rI/y8IDJLCk8xgOMbmbNUDc0ZNMnsWkg9TrccPgfC3h2wEgIh0sjL/fr5BjNdqbfeg+T1/jLnQKqPezA0HQpie9WgtLR7/5e592pBx87UV9gtq6drwcGc+KwQU+ESbeQaXuVIIZXpOreahiE+dsJr9AomBtwrl8xblwoMS0MWzqWhqZPPolZK4Xhg==;31:kjAoy9P5lWna8CsqxZSeKtUHREhle1w4J2Eq8WVEASqEP/dY0HRKcHbVPqBASbukk4GnihFWUBe4O5zb2DOskRai5WjyIaS2PbTNNWnjbgFk00EZwEIJoQKqjGZ5ai5JCsfKXqyQ6RB6mldNAKILtxSaU48dPgF1IQcRLmzONW8UcPcfMKjVOgg/Zuuk3qANSu5uJfJZLZCylSXS8XsyvxiGElXgL/xe2OVpjnAAogc=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1368:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1368;20:7YiTcHFIE63LLeOqbgn0e0/TI2G71OtCGqP/1cq3P4OrZ8F4oo8Nlj8Mj4ibp/ot6rY/mAspmwS2PxKCZB4Ghak52u5+DQhYKtXR7foBWldQGFyniSTTwegMhXUn6XjzVcYBr4Z73qPBKe+w2+65A+9WgNi76xz7ZwSevsIv4WEUpeRQrHpM96yGo3YR0ynCxTj+u17N/0hbeSIYBIQw0HCks50WLZdWXDayk5hRW42CESgDET9Ja7N9aYsnELko17eogr8t6yvzUmnx80a2F9RjN3Q8+5XDFrTju1gbsn5mBVH/6Sobi7X7SHKcdtWZUvW7qLLOHpj5fRXIbUzfa3uQFsvnvmm4L8bn+BGlWlkgXRM6gW2ysGxNt/y9gyon7gxLo9Vy7l+qF8racPYfF0WPiVk5BTmxzik323PhPM7f1hshny30Wh2CVJkkoK3S7X+voki7cCeP1MdYNXU8Tv+Dwr4BcKSeeRo6OJp//DTrq2MsKmplgTe3XytZ3ZR1;4:cZ0ao52GcGneuKf/OaG/1+2tVFNLCZbYQAAh09M2j1xNe92PBWn3ExZ4feC8VmzrAIGxprdH06/5B/XrWLPn3r4w4s2mChdbgoU0U43XxZ2wmb3+8KSEMKSHgGYRy8BvgTzo21CY0P1QOVTjWHooC7EtJLIwshW2TAKEFmyulcgK7+kGShmZChhPXwn+xDUcHmK6QYQd8Aax/swF+2DXU8oaEHHQ5bfqDlpkS9mC9N2W2se3pzsKI2ecclMmapdVfwZPZrLso3DGmEG+jZYLew==
X-Microsoft-Antispam-PRVS: <CY4PR12MB13686A7778F08F3A6F9018F9E7690@CY4PR12MB1368.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY4PR12MB1368;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1368;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(396003)(366004)(189003)(199004)(50466002)(72206003)(6666003)(106356001)(68736007)(48376002)(53416004)(2906002)(4326008)(305945005)(25786009)(6486002)(53936002)(3846002)(5660300001)(105586002)(97736004)(478600001)(7736002)(81156014)(8676002)(486006)(36756003)(6116002)(50226002)(81166006)(54906003)(316002)(8936002)(956004)(2616005)(386003)(7696005)(51416003)(66066001)(476003)(47776003)(16526019)(186003)(16586007)(86362001)(26005)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1368;H:gi-joe.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR12MB1368;23:CCo1wKzsforhFAYC/AZ0/mHUqxkij5UJySIkOsHgw?=
 =?us-ascii?Q?UVCeGX1ydpjvjXeNYhz4po2r4Ba1QlZjy7/Zd6awi+SyHpkiUKYMlG9d8IM4?=
 =?us-ascii?Q?ryyG5YJZZA5pPYN+9rupj26DAbXL7jxLY/rHDtTGk5nkrWw/wzSnMo6+ZBIB?=
 =?us-ascii?Q?3tnfdGGILrpqQYRNaFT+ojriKMGOcphPn3uvD8Ng0kxckOnU4Hb9BNpQPe4P?=
 =?us-ascii?Q?LEt+Xz5Ls3Erum89nFa6XQiT/3QkgUGxh4hVqluV9kZmGltbRZ6s7glP9AR0?=
 =?us-ascii?Q?UkPy2EkpSKL8/wWJ/MciDfINJtSJ8cN0SEseGKM7tSq1jj15G+F0jixgZ4SX?=
 =?us-ascii?Q?sR6mamEtMa0a/+chsB5nx/ljG5hqu51tCED1shR8oU/uz7bdrRDSW1wPA0XY?=
 =?us-ascii?Q?O3CAPc1wsm99SEHPBPidVNfX548V7/pLVzGIoepDhFNCKRQxTQz8/fzTf2r7?=
 =?us-ascii?Q?ynEBCVo7ZY5bFN3VB3TCC0PGLH9GMa6uMCPDLtDL/abagOCqodahDLye/4AS?=
 =?us-ascii?Q?bqPkuHGui6YleVN+XyjproI86jN1un996vyow/JutRADhafWvsnvreviru9F?=
 =?us-ascii?Q?eT/1eTCknu94kctnVWdOahykJ8rhvpio5PkCqaGJBS6u1BERCSYxUBiCSO8t?=
 =?us-ascii?Q?iQTJLYup5thMZo9yNlllt5TjKhNvOV4cts0X2GPj5ozVuejmzedK/T5o+0p6?=
 =?us-ascii?Q?oVaxTJxSDNPSqcNZUjYVZMGfS8KSC1jDjaIb5Sbw4R7sQOjiUjzLmmc5OKd5?=
 =?us-ascii?Q?cFQJJLRXbsa+7kh2JJjbzcU53IziweQkwCM5nSI6KLgycNq8JGGPMBoLQcP/?=
 =?us-ascii?Q?+HmXeWUUpW0jQJTX0QzHcZvYZoSgZFMOE+11mFwYpSnldKB2STjfh9NMVTqY?=
 =?us-ascii?Q?whazQrr0hGFSfpiw42cvXyDhKTPb1Jh8WeqYWQljXGqJS16JG2vvxrg/NTfo?=
 =?us-ascii?Q?brCUIZZKlZjenjNpXCqt5msN0ulVpJINfgEBTMZUamKUVV/pzaLtBWu5CHDv?=
 =?us-ascii?Q?EIv6YvTmpCWY5XDcyN4C00WSMR1rpVawOGoergoUUE6X67A1mKUN+euIUj+z?=
 =?us-ascii?Q?wEW/FgY7/xvHEJ5XIuNLT/BzjkHjUhh+FUYLawksXhaSoTPqpDXu0lyT6iwO?=
 =?us-ascii?Q?W5MjWrjG4FX7p/R/boQf9geSHtXSi/l?=
X-Microsoft-Antispam-Message-Info: iWZpLFjNpNJ7jRhy4wIidc+ENDpx29RPtzK3ipODhjMaD7vevKBsOifA9IFiTRN5fy60Dr4gyQzwybeNfX0WgdGS8ays21yjfoIn+Oufwe12oKbK7zSCOy5prhGPudNuYlQDFhUF/cYV7Cghvn6q903+Y4Je35N2h3ugKj8JW+U68n5ozMGPEl090mx1bG7t
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1368;6:rzFNmcWls+NJiwn4PmsFf4xetIYlVgG8z1J5Bv/mH/jaEGCLzgglpDK1/BH1ykBI1qOkSRufTcq6t6SIaY3Mu6tKWRnd1fyUxMi8hXkLhp+rRiuY4faQ44RWtkgjln1rew0ELb9O4C2mmSQT4TUoBEYpGTZKQ/q5b/1eZB9PAvoN9/JluiBuBrnCGVLyTCvGvyUz5nKdF79eeekpU2IQ3PFStuy1hIlzf7kld7Qtr2G8hvjUsupCiVEZwkh00zXEU6YWzkiGuiG18lTPck9O402iIXNiUM3ZBxOKEPbRV0lh6bX7zk8nmzXysZFlRZVyl2tXfCAfpqPyHNA21X+hUGOh1mJOhPPemYxzOHUNx1TmVmhdgFqqfpgnrnGSitwMCc15mXolmSokS+9xs9pG7oTnRYpVA/kKxxB794ZklStCGv4plTX87VTR/43i4QL4ssd9XaUqt1jzTPAmbgsEYg==;5:c4aCTOf/ZyTmeYwflN5WrYWCdU+OgzibdV7W9GE+8mHWRL+lx8LMwgb+ULSbaSPVLEvbysqJxWANWiGpUlnWnMb6lxokEwQyuis9f9wHkPFjnFt+LZExtKNun0PeFgAW03BqrxRe74tQS/qg/XunwetOcv3Fuq3VGHBnIMw3GJ0=;24:OU8oOi/oX7uqj4GKm7R2VrMd1ru/wKqb0fzTI7GhKBMaT1yECUscGe2gEbepyADl/fwhLC6vigF/s81G+q/MvleySGb5dFB++Mplqe1cqoA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1368;7:cXlnLIvnnDprerU4vYKxKhcaF5yL3+H+EPbI6Noy2pGDEH8uKxLWfFmvmegwW9Y3a2TT3bOvSIFW9Wxv2niqKOlUcnQkI5+rwo7E/hPVfeGuEUjZ/eJuCUu9AD242E2qJiXnqFSxElEyrjn3Av8i31OuBA63rXZc9CtOlrRTQwvkFqCVQNfQbEsW7T2HtQg1nKFGvPpF2cGh0dW+YXtaGfysgn1S3CfYL44EUL8FWbI03qU8REYXafNbvT6itJKl;20:OlWPK72lWT3YoonIUeaec2n29UDlwvqRrlfVPynhU1Tu4G+UWxCmZejiUj6Vjc/HOnnBks0K8YUllDbGpK8pLLAKl87u87V7ds9YLHhdfm65kK47BF4eTrwCMa1YS8wRuX1M6eceEkC2pY992I7Vpc0ICQaZ3PwODv5lVrqx6eyeeIW09STP/rh4CnaqVlH+gHyUAs6cbvImcr6JmAfqcetX4yMDyc98hc1cl3wJCpjfzvMyDmfmcB0JPijQkeCE
X-MS-Office365-Filtering-Correlation-Id: 4e0b2439-94b7-4439-53d0-08d5c27d6f1c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 20:23:52.7371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0b2439-94b7-4439-53d0-08d5c27d6f1c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1368
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds two new SEV commands, introduced in SEV API v0.15
and v0.16 respectively.

* DOWNLOAD_FIRMWARE allows the SEV firmware to be updated if a blob newer
  than or similar to the exisiting build is available.

* GET_ID allows to query for a unique ID that can be used to retrieve the
  Chip Endorsment Key (CEK) public key signed by the AMD SEV Signing Key
  (ASK). 

v1->v2:
* Added cover letter.
* Misc changes based on Boris' feedback.

Janakarajan Natarajan (2):
  crypto: ccp: Add DOWNLOAD_FIRMWARE SEV command
  crypto: ccp: Add GET_ID SEV command

 drivers/crypto/ccp/psp-dev.c | 143 ++++++++++++++++++++++++++++++++++++++++---
 drivers/crypto/ccp/psp-dev.h |   4 ++
 include/linux/psp-sev.h      |  23 +++++++
 include/uapi/linux/psp-sev.h |  12 ++++
 4 files changed, 172 insertions(+), 10 deletions(-)

-- 
2.7.4
