Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A0DC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E127725B96
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eCS7eZ0X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E127725B96
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965734AbeF0QbS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:31:18 -0400
Received: from mail-by2nam03on0061.outbound.protection.outlook.com ([104.47.42.61]:31808
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965110AbeF0QbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkqUT9cT0FC6W0LFgsJhKm8uhGY7b41a778L4ihX+iQ=;
 b=eCS7eZ0XBe2839HXq6Evd03mfG5FM8YHhKq2DlPJuufd04DSc3ryhBr2anKyWQY7CNkdj2GUjzgwfZaJx74Se/ZIXoLUrUnURsEnuD7bwThnhqt5Bd4xWjEGxO6L9rDRnIszCgwN9zc9zcDaPPapJ21O1ofVheF3PlH+kLE3AEA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Janakarajan.Natarajan@amd.com; 
Received: from gi-joe.amd.com (165.204.77.1) by
 BN6PR12MB1364.namprd12.prod.outlook.com (2603:10b6:404:1e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.884.22; Wed, 27 Jun 2018 16:31:10 +0000
From:   Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        Brijesh Singh <Brijesh.Singh@amd.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
Subject: [PATCH v2] x86/kvm/Kconfig: Ensure CRYPTO_DEV_CCP_DD state at minimum matches KVM_AMD
Date:   Wed, 27 Jun 2018 11:30:53 -0500
Message-Id: <1530117053-45869-1-git-send-email-Janakarajan.Natarajan@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: MWHPR15CA0033.namprd15.prod.outlook.com
 (2603:10b6:300:ad::19) To BN6PR12MB1364.namprd12.prod.outlook.com
 (2603:10b6:404:1e::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b2f54d6-ad29-4b44-dacd-08d5dc4b6542
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1364;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1364;3:BQxNMKQBcyD2KQbUXnveP20d4euL2U9tIV7prLrhkUMtK3jdSrsPel3XdAEguFFSr/ULR4X1+64YL6pP9f4CMsGHOJP9tK/xHt4U42cnULNq7uYOAEiCeoBHMRrMhP6Ok/9QlTynNtvmVl8qBZQkZJjrlHFdSlkg4JzvNDHKfwn8kNHvIHxZRd7BkeqQegMXVm2U4jNprL4IYDPeAYtrRcgT4Ty3k6lFHzgbd7iS5yuweMamYYFotgguzhky+T8e;25:jz5kjnEhKTnhdUx8MOrZccbwRQqnPOKBQ/AcVnJ/NeE6CsVpEWNhyDYupZg6Fhq8ctFxagCPE/ufK8ED01QUd/Ywu9s24nDIvIrStWPIttck3Dl0Cep22kap4eAiER+280N9N+/9yuUjQOXrU8NAVey18+X4HnXp1ZPsAaVRkCMvE1yoXLrUFftYLkGn6Ryp6MhqFilzzck3EqTmfO8Qg5Ass9ECDTgGxYW7lVn9THPzKPOo8wu3ZVUJJFdewLcIZmulCVwxo8s4rYLD22RfsMP4UMBLbBl4d/okQClxu8iubzQgnj3edhH6jpgJ3Tju5Oi37eHFxGnY0sXXfqKyPg==;31:GSS/EgArJTRy/WcWx79K3gkw7gREkzrMwWI/RX9h6gISYHHz7XPabL8hMuDLHcqXqk0OMvkGQCRpeoIV+2OUBBbw1rBVhexrFp2B4KQro657whVMA8kEkTTTzo+ZI+Ey1amfLB77WqKTCA38LU//H5npawhl3UvB3+RzfQxpK479KecinOBenPw15IEg+FzWfvCcwHjLlxXxND/+aB8BzpmxGbWdSRWdOZmCh3rxSP0=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1364:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1364;20:68N2IkHMwc5VNsMLrdzP4giW/f2iHmfzmkuolGbyAI7f6x6JA+SP/+HvRQIWpbh1X5L+a2oS7QWsHsyAN6XQI63LXaJ/3tcFgXhWoskFZtKvxhDfI812Kx0+ePLW02aXSp2CxvFeyfPipBKtdaGRRh5kWClaFWdC2xsf6+LVTeOHilgSDRI8VhyYFeySjhELX2joIlEWIKLtw/oyndGxHBYe8HpWn2kW9WIY9oD7ZBOuxJTgHrqiGV9M22WiL2qq2Zv7kHMhJEXrFCI9OQwnJrmzBhnWLKqyQUCJ6KvMMt/EqUdY7Mbxt8FXfLdvOE8ieUJbUURyDDwjzXEFB4ATV3E56Xwm9JMbBNOHWdb4ffs2JJqYzikv5UbAItoQzX4o2Dxe+G5q5aUbisLQFEm5v4FC9FtklAFDaRBl5Xhi9lnNk+zZCYQjoGn5+uuINg0zrM5PAwoljXXolHE4FOGLMhtAFTNXfAwKloVD3u8lSm6RSAdWZTWYqeylYwyLVSJW;4:qgsdAOPLHm/1TGm3rpGRtpvg1Gyt1+eFxKE9145lOPCLEv1dgeputFdcypz9nyB+1c5BdPSY3cxD/UQMmGxBqHk/W8oplInA5nCOvXulioP1NI09jy7d0rQ9qnUmWgTe9XrRGUNxLtQx+4xcdcFZjSYZCbcHWp/FDUxgvM3Z7U7wBmcQEniDwMfTLE8klxqQ2rMn3jVDRtPvpZ8ynl93QKJlzCACUTHt2f8QIi7pXvlJPRD2bgoB0U/6eUHqkLoSOERI2/KfELO3FS4/dgbs6oq/l2ZjOGIGH0eT6Hq+Op8/cRArGxq/NbkTUKc1iGNOZU8xGcLokMpo8lA8puf6qA==
X-Microsoft-Antispam-PRVS: <BN6PR12MB13641C121DEFDB45B7711379E7480@BN6PR12MB1364.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN6PR12MB1364;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1364;
X-Forefront-PRVS: 0716E70AB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(39860400002)(346002)(136003)(199004)(189003)(6666003)(8676002)(16526019)(26005)(36756003)(316002)(53416004)(14444005)(386003)(81166006)(81156014)(54906003)(8936002)(86362001)(486006)(68736007)(16586007)(5660300001)(186003)(48376002)(478600001)(97736004)(53936002)(4326008)(50466002)(2906002)(66066001)(6486002)(50226002)(105586002)(72206003)(956004)(25786009)(2616005)(7736002)(305945005)(476003)(47776003)(51416003)(3846002)(106356001)(7696005)(6116002)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1364;H:gi-joe.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1364;23:+sOoxrt7WdhHh4AD0QbCwp7L+6gA2CpLwoa/Uovbz?=
 =?us-ascii?Q?K82njZg86qplGsC3rYmovfwCqgGQuGFANo5Eq3aSP97ojWHcAgraumLVtTEj?=
 =?us-ascii?Q?zmClWeAhidmA15rpapX0JsMA80lbnqYKyQPBmcA+qa4BS8kQn6y2rJ3BTDVh?=
 =?us-ascii?Q?umQJqdb1wuJyLlk1dNYGX4UICofns9kWLL1JQYiWzq3ozEBaFxcduzo/EB8b?=
 =?us-ascii?Q?rWL5mktzubnqn1yOi6TXIcHIkzOXZhZ5Bpt/wqDrLc/hWUptCWQxGl1a6Drg?=
 =?us-ascii?Q?pBztoyiwYFLVbIvIzzvIMh8gudWfWeGmZ6wPumi72C4cmtC/ShhfSM0XOBw2?=
 =?us-ascii?Q?M0hCmJ9MIPxvQOIaoRb6Fe0nQgewljIYv2zsh5rgwXZotkMpLNyEmLxXYN7c?=
 =?us-ascii?Q?MN0kZ0ABlJTF7S/CYeAFNVe6toNWhi2q6NAJypC2KVDTBHypYQO6YpPBCRI0?=
 =?us-ascii?Q?UJxVCUvNy9GDk4mILPjF7sn6LvlgL6upbE7GNtzMYHIm3j785Z51hZKCyibx?=
 =?us-ascii?Q?2dGyaip6lU+U217cQtFU8tYA3nTM+Qprk/vhcGFn+TmEHzfmA4W3N9wYmXKK?=
 =?us-ascii?Q?RnsjruAZdiPlJNbBh0BqCfpRTb5n+IjtBet0TFJ2Wwd0KVon2nG8Cz5qDSWt?=
 =?us-ascii?Q?WsNrtnW3JBsCbELa9VP3uv0e2HW7b4ri//PS/FKQ24mbjSSkiTJLRbTm9OKm?=
 =?us-ascii?Q?YhhkV3Yw4RwPYXvW46fA/U/3O/TAaXAqhsOQx/mIrc/eWCjdeBrzgofEVIex?=
 =?us-ascii?Q?JI8nfJ7LKJyLTbljszXg2Y5EK4vJM/vT8vd49w0TvvCLBU0JfS6JIvVPgMOE?=
 =?us-ascii?Q?LrpIYGUpXK+haCMYlrub0pjXNMoEpAD8rvxB8XKe/l/Uldufn8UwDpX4wDy1?=
 =?us-ascii?Q?lPqRvRwold5jrKBJl74SP5Hg0oKxTjCEqRgYWvY/DbZS0PwjjnIZy8mc8Jr1?=
 =?us-ascii?Q?po7IQpblUILKuUqe8DRVJY2yJQWHi2+dtP/SolWGLgXYDKlcBRIwmeUzexH1?=
 =?us-ascii?Q?F4lhs54806LmeHVkwr1IRSNWp8btQq9OAsz4uaTsFbWjon9vwYo1P110TxaW?=
 =?us-ascii?Q?2uvEaBk1DvLKMSNVlBZ2Av4/T1994MzmKOicPluLsWpp6DMGBKjjk3ds4MTC?=
 =?us-ascii?Q?L5PFZ46M2bqzF8rEWy8ilf1iDE6r0NFLzkxwBSSP+r5Y9QhvCWRvA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 8iurJiLVx4RulNlG93kecZQWc5Qw8dApy+UJGtqQuEF05pbqZxyzE+rgxkQ1hl2rlLdq6wv5oR4zsTAHW6m4Zp2AjAiNELpUXVCaXugxDKr4CyLEeq4ToCwZD8dhoQP3geAV+bg7Ux3laLKSyUdmb3r0Xtt5s0uRA55nKyFuL42CSmxijjBtC93nZMWwuUS3swt8lJP5RnSxxtCfYrHy3HPSHwRJqOkTLl6XgJE1xH1kUngWGuPwzIPCcWGJYbIbCEDyIfjm62Lx8BglHCfVlFq0PyT3IyUJK6lskdSa6TrVH1WgjkMa0+G/LBBUMlBagZxxTNJ7WCasmbm2X5SEcaTv1J2MQfXjQ24oDeAXYiM=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1364;6:TpHlZxQbhF8S65R2I28U0muUYLiBakzOASx+87cT0fbLiQQ0YPuZ2PxIeHNL0yerjSssQhI5Ex2WC2+0/c24vaEgSTsu+O3lJCFBTLw/EDFz8oAWYTqiCYCIQa//71PvpO0VDVRPEf4UzuP7u04Xu+K2eD4GYz/BPou0U4I5ILfYpDwqPAdT6poKSvkqohZeaXh7BOG0JIzhK7GFcUwpBlYRHJ+qjr9E186lvKf6+mEaqrE2xG8w4SI7cZAV6tGM/w27H2eveaVoIwVs/VAxbTFNumvJMuAxVxUK6enw6ge0w4kKMC32rRqUazExVAv6D6KDVRQjVUWy8oRuqOeGqQZgYQeng29lwGGUs63cxNbRlCNraH/hknqfJNMUjpIfJZ0/022YnUoiUbZx9EKBbe6VBRWv3zPdPK81DQF9/NHGOrbYf0WXuh8kOJxZCj7zB+of4jqm5Dt9MRJG+mFVlQ==;5:OISCGK4KxU5WNsRtiaQkNvy5xWIQEx7PxDUGBYBQ39ZZ50ikp+S+ZI/UVL9AVjDQYCF8wYJtNHiPS1+zNcvHH4LEBN0DsY/8teLyo54VUXmcCekEDJJNpz/n5ns5MOAVRJvm1Cyr4jt0t2vImCMrg+OkKEygCJN6fH4IehCDScQ=;24:y0Aqec6Sd0UgsyOlzdkW7hJ8HYDS2aQf+qwrK3ieJgmhzrNBWFPpm0qbxhjRH9JyfVzW4yrqiZPjRvu8GzVBIDEDTIz3PPtLWHLTaqJTcIQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1364;7:EHydVh9yFzXybwzibdK6stwp+1fIQR4sFeiFXt8NRtpaU9nfISjUv9Y4GJoLugeRPOGgPmKgWBDbxqpIo5Cz8orhWEhTBozK23G4bZ8JOtTAxhrboyHpIuBo3iD1FhBEZtA2Ux0/RCfzZRfd87dAvWZbkUsw0czxDEKx0576j2qiUM4wq0HBham7mkDKbc6ybkCwWWVNOZDNyjoqlZy6Qu1/uyA+RuQswQ+1hen90kpi2tj/hHnRnPdArQW8pMyn;20:qwhVqchQ59MC0VMzYHwUj3WXQ09PB11a+QtLQpW4Wbmo0akEhsrqoeU4o+5ztB7T7Vc6HEvvzvRlMYwsvNhBiR9rUc+6JqahOk/UFhbuMDd7wjEeY08o6JpfTS8O5eqdV7VnuHjGMknLcTLZE1Qb+5Et8HuF3xZFCQocBUQ3Xj4T0Vg1kidHhKgcHqE8g/kyDRtHbwxmgnhgVij26IT8qfeaAmX6kDSaui0hC7VgOJfoX5L2PKXg0ipj1/7nHkmR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2018 16:31:10.3956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2f54d6-ad29-4b44-dacd-08d5dc4b6542
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1364
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent a config where KVM_AMD=y and CRYPTO_DEV_CCP_DD=m thereby ensuring
that AMD Secure Processor device driver will be built-in when KVM_AMD is
also built-in.

v1->v2:
* Removed usage of 'imply' Kconfig option.
* Change patch commit message.

Fixes: 505c9e94d832 ("KVM: x86: prefer "depends on" to "select" for SEV")

Cc: <stable@vger.kernel.org> # 4.16.x
Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
---
 arch/x86/kvm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 92fd433..1bbec38 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -85,7 +85,7 @@ config KVM_AMD_SEV
 	def_bool y
 	bool "AMD Secure Encrypted Virtualization (SEV) support"
 	depends on KVM_AMD && X86_64
-	depends on CRYPTO_DEV_CCP && CRYPTO_DEV_CCP_DD && CRYPTO_DEV_SP_PSP
+	depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
 	---help---
 	Provides support for launching Encrypted VMs on AMD processors.
 
-- 
2.7.4

