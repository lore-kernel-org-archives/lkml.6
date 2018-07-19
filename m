Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97331ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B67320684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="i8N7ssyf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B67320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388007AbeGSSpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:45:46 -0400
Received: from mail-sn1nam02on0081.outbound.protection.outlook.com ([104.47.36.81]:15781
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387831AbeGSSnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/i50cBDA0wgaqtN216ewcaG5wgqsO7/JRT7n9RtrEs=;
 b=i8N7ssyfjZ4CDgc+IJ8OmO1uLvMfZENLy0sV6r95UiaVnQ4NcDBY1TYnnE/9ZABrZ5UaGWUk5IdhzvamGOpVbkl3C6gmDc3JYAFIK3DIqsO4nShmVZtWWG6hALIo3WdLeOqAuHIUlHKc8gc2b4dCxMHQYJWmxsYKCZGrAWu+030=
Received: from BYAPR07CA0003.namprd07.prod.outlook.com (2603:10b6:a02:bc::16)
 by DM6PR07MB4713.namprd07.prod.outlook.com (2603:10b6:5:a1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Thu, 19 Jul
 2018 17:59:30 +0000
Received: from BY2NAM05FT045.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::205) by BYAPR07CA0003.outlook.office365.com
 (2603:10b6:a02:bc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:30 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT045.mail.protection.outlook.com (10.152.100.182) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.995.0 via
 Frontend Transport; Thu, 19 Jul 2018 17:59:29 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxNgH025447
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:29 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:32 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:32 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxGto006060;
        Thu, 19 Jul 2018 18:59:16 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxGoS006059;
        Thu, 19 Jul 2018 18:59:16 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 27/31] usb: usbssp: implements usbssp_gadget_ep_enable function
Date:   Thu, 19 Jul 2018 18:58:00 +0100
Message-ID: <1532023084-28083-28-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(2980300002)(189003)(36092001)(199004)(336012)(14444005)(8936002)(105596002)(4720700003)(426003)(6666003)(446003)(5660300001)(106466001)(86362001)(356003)(2906002)(7636002)(476003)(1671002)(2616005)(76176011)(551934003)(50226002)(109986005)(107886003)(26005)(87636003)(26826003)(54906003)(478600001)(305945005)(50466002)(47776003)(126002)(246002)(4326008)(8676002)(11346002)(486006)(51416003)(42186006)(48376002)(16586007)(316002)(186003)(36756003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4713;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT045;1:yiJH18AUsVoAiGajZHf7HKgNReJW9XFdBvdnt7m2MNXDl2H9f4oHm+s7T5UN5F/TMw1gaNgjhOk9O2l/q15RQLr+oX/nBLJ7bHry7l+WHt+M3l+mgWlhHuIfEjfeEds7
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d40879ea-d236-4425-73dc-08d5eda15fea
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM6PR07MB4713;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4713;3:Y2jsVdiaQS49+PwAXfY+UohH70LUF2DYMK2zvuM8z8qlBWITma8d4xZgQfXD1jaXegl5zt3F7FEj88Dne7YE/weKDhvT+G7NwPpFWyv4XsKFqlGI/1plmzAalmnz1QNI7mViK6NAYXy9WBM1cptAFy5OdQlQ8/BfNat4oAycaohMyzEHXo1g8KPiPPQHRTXDW1qmtrc5rdn7UswnuJfV22sK/y/osn3gPxgMAdpsd8dcKysnQxK3g95Ur7TzckAiv10lgXGTWff6NrCIUj7vHSorPeW/WRXaGh2OfIc2j7V1crsJPwouwDLanUzKnsX3PHEUGgOym3banDFmbFrD+XO38UrhVFUcgQa1wTYa8NA=;25:CfYVwQdV4Akm9hg9OFPxRCkvPnzkkQUxBZXG2JBwq0TwpA/myPcVfIDXRrd3I3J8J/IPlurbfmKgTudUbTerioUXP/xle0YDWVzQiKEmP/P6x9Yy6sECx/ekmHZitHzOFeIDGH+yKl8ekCJwiJKUY2rAeV4BVrfNbBKXmu8aBlTKYkYTNRdQwXQkR7pkcj6xHxng3NCVSqcsZSMNI4C18qHd8krQlvIwFIO+jc5inTzzpd2yCPlBw0C1xIR8/QwCPbWRxb+N9KajzJOF6CMVgJY0RrFNUEe7ieGIOhvPF8lASdbEzkidPLqLwqD0/W2/rNlaea++C4ArzKn+sgR9VQ==
X-MS-TrafficTypeDiagnostic: DM6PR07MB4713:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4713;31:VaFx4RWLVmSrJfuAXgilUj8j9rXKJwua1Xl0QfCsp9IaU2LhOYm+rsDKNKmC1XR2t7gg24Zb88+5NdNqcIZUUQQyU10xlzPLScyTv22fE8eQ6pMHop/OXWzQWkYRNF8tC87ZtQo1VWD2gFQ/ofpKOKkOtnDVzvbS97/CrlXnjL5sxyVuzI0ytsx/QFsreDs/Jcdq0BjAzvLVvlA5F4MLeDukKhzU8QRtaqCFD2TVqh0=;20:nWL+nhG40Q7/fNNZeMMlaDnRUvcczrYgDZ2P1/Lc67HPWVmzMXOYvneEI1Mx5gwEtYZdxi3A1m4zyjFXcDJxcutgKswextFW+P0yzUDennoenu3D3cHzYpUxA0uYZZIY3RyvC9ufcAxykg6XtUhXbNv6q9HFfK3S3X/V3dR/e6mmK58h2aSXCCBzXSVmzTAitqGChyF0quZrLu2L6PeM8883c42fuKdhbQNOUZBVrRb8WUEX3llPEKVbRXdAh46GXI1Qli97JT7ilHgu9bxokIFEZnbPZ2Ocz7dInBQIeGbZibF4LogoSmyyZl94KW+5GmzpLmf2VlAU65NqWxVSo3fl6r6LYXZqpnbKURZuUOH4BT3BC3bRifSX5jNdcwxuxz1KsY8erFGIcXfej/3VPtN70fGVGRaJR4mF2j6vSf5CW+HxWUf1jLUqYgCRVNaMaJ4/kABAQgk2sEMEcNsIqED2PLTsUXIFrzbx+NbrdDlc6wvw0TGNEq05jxrnfk0v
X-Microsoft-Antispam-PRVS: <DM6PR07MB4713DB97FCC04C957A85094BDD520@DM6PR07MB4713.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93003095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB4713;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4713;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4713;4:U9jSkeFM+t/dj6vfipF8Os8lNRfDKqhYEWnsNl1xwSneQT97REWvh6HWdsO59DTnmPcWJQuu1CvX52cS36ycblVgAAjBY2vvofcH+CpAPAXJeBtD+lv4qOGpBNXjU0HRfuc6xnoRhJgvuH66pxGYaNVwnkC7yPLSEwSj3pRS8zvjb4UvRpnv9PEZvtn2+udOCbLdqwxUmI18mO9T5b22VPrusSYk6VQf4lTKguA2XeeqssKSkVvjWCLp9gZ18jEBlfJpfCnVTOnGI5YmpPuC3MwI4xJHdHc9LpKJlUKq15pAtAw63tWEB2MQUtQZND7Y
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4713;23:i2vCUBMzXvWwkIZO8QQD14+pNcxYn2oba1WlY91Qf?=
 =?us-ascii?Q?T6eZcbQqPr+qawIpAhuVz63KDXOOKPG8LtUc7yf7R+NbbWJM852qJHYuLb3Q?=
 =?us-ascii?Q?ClKhj4tgXPr14MednIvO9kogIHTOqLiGZSxg41KyfuK8xDVRen9GHnz+zbqd?=
 =?us-ascii?Q?Rp7mN+xv/9o083y76eO8C9+GvjSRsR5UYTdBupLW7PVuQQcvnFFtO5S2hvox?=
 =?us-ascii?Q?uNKCJRmXXeWc3XB6v5Dai22I+Og0+7nwZbFjjPOUnVdgfm7CGts7btaETmjq?=
 =?us-ascii?Q?mq12Sso8ebyOCCCGpdnqiwsTodkv2PwrofHjTRRLt9+uFl/Zzc94zKKpCKTV?=
 =?us-ascii?Q?90Kxw8avvFBbijXejhvwUl7sc6FD/hrP15miWDSXSDbyVw+6FrBUvIsc+NRP?=
 =?us-ascii?Q?1See73pv5BVq0wzyC9PDlHJd0GVIeQCQChTEJABdA8gVEJK6imww9ezLs0Og?=
 =?us-ascii?Q?Mu3IoxS9T3TNvXih36tGsv15K/4NqH3bsvt/2L7nlAc87rw6Sp+TrVoIWryf?=
 =?us-ascii?Q?s/UwC/2Cs8df4J6efLjxT5v+6l/Mxf15RER8Cra9+n8RyFBNgNIZvpRfNEDZ?=
 =?us-ascii?Q?qRvgSn2NYTS4eSku4I8+c268SqLXHFhjDdrbNE2+ocH4a5phIbfRVUHCY174?=
 =?us-ascii?Q?60KebR3AEIfbrpOi1PMv9Fn7sVlA0M/ZhCdUcYAWfG0KKJ6+TcehGcXZIqU4?=
 =?us-ascii?Q?UPHv4lGGdKq/UOCDzqwZZc9kPrcrWXPV11lM1tZw1W7sbwBEJU4BWMkJrNse?=
 =?us-ascii?Q?LKC0uCaBpZPjRcQafdybHS65HwQQ4wsMzobw40BZa3BrZFeZPYqd9t61T22d?=
 =?us-ascii?Q?M2/TfBVTKkDZ9tDV5sVjKYR5EgAufZ7JBpO9yOP8zC2HihJ9Ehw3rE6kfSGH?=
 =?us-ascii?Q?tVNI/PMoezqrd9beqiXs9BP0spcUoNIj3YJmXFAXX9i6z7BKGD1xNjVBGoDL?=
 =?us-ascii?Q?vuy9HaHi5g1t1ju+7mVE+C7Fn9PnKSVDWz14I31shITLfoFzxD4dbeQ4vHUB?=
 =?us-ascii?Q?qTKU+hxIXYpDR5egQCzg59xLl05U8VwllLubG4Cra8NMwZLZ0bvHYObp1Tt3?=
 =?us-ascii?Q?Bm62PyiRAtJYqJuJ0oLipSi2iUAd8vP+pkTvJ+CgVq5SlYZvQ0HvcjD1egz/?=
 =?us-ascii?Q?SVnFVfIPCQPfgh9ws62LEsxpBL5AfooEahW2a3DVRIMAwu2A0Y++5MrKs/zZ?=
 =?us-ascii?Q?qEwroOmvcle514=3D?=
X-Microsoft-Antispam-Message-Info: DulpKvBmq1s8WVXOr8IfXEvGCa1GRV8q/cPHjr7LpLs+d+/lIJgNf6PnOaqqOtT9nWbfEvf/cgXPJyAnhlwH0AMJh2CBllZE6zp7Ek68XY0aQSDZ5uWc2bs0JEs20TM8QQKt43vBKqJg4Z9f7ktS7sMdow31Zxn/DvQtmYQ5s3eWKFT2Jd3bZgOWA4xsLm+9LDjOezOkj/3EtDU+iRzhinZ/oEsd3nTPhjvKm1fUUJERii4PiLK6I8Lt9iPGv/+mTAZpcKFd1CHMyW678QhdR+nhvibb+Qd6GCNWMDZPqGlT8m5+nDDk4m1s8SVynOfxqhajKD43ofG8BFBY1cAFLAkIw8rAiM1JgcIW3VeHtzW8Fg2Eg2URi7t9V5MoiP5io4HP0Q5C5HcRYOoDcc62bQ==
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4713;6:XOsNmQ0Sbnaabjd+Zl8BQq7m0CFZiU71SscPKqWw5BHYmfz3MoD1mpspDDlEybaxx8oF9r47JqVHckqHAnLhgM3vKwhkBkzokk0jaw7sCs6eEMOIBWWRhdUAfBhZnELq3xue2K8V6NMZnHkuqXv7rCMItTPP71/tnQlqWJn6R65syjDo4LhmVqVBHWVPFwVM+D17t4gRAASwPofmjnYMQO4XLKwc05qaU7Pe14tB9PwXBsZL3BQPUXLls49l9ShlXHrv7FMaEzy41ZQ4gfdgfW0otWxB+Z4IQguc9Fi5svUBno9gvdggUwQyP8vqck7ZgsjBFL3KAcRMy+zrDjF9Kv0R06xZFiKIz843CdRRXjnLsw063cvEr+ohRruSw90lIPywN1KjJl/6rJtZM0ziBaH956s8YdCrJFz2WhVXqSgyOtVMRvV82oxVcMbNd7aws2Uc7oFwl/5byIJ7xIobcg==;5:imWnHjw4+BcjDO+nXD2HQ3EKWXXTItnBSk6vZBB2ouUjgL+zve0N4ENOz/Gb/q5AkCMsc00rOT+v3aVqGIZgkB+SmJIBVHOfJcssRAIPzEd7juB4mrnz/hg9+j5LXbIQLL9F4iTkRyY3hjpY1vwgPw+gfWS7Gk2ojQcpzEdeAE0=;7:+Ag3pPdyZ7LKEEZdcJSArWIIY2XcEPU5LIC6S2XhqJA/o77nBROOelgf4qA43FG5ERHqlOBo9LWUbEbHH7Oyo1+/QrRIcKepwvZuNG2Vc/vQfkYzgN3kuJfBn9uWD/UFuAd+MDM5w/Wzxm7nyfu/DEN8cnXQmle3EFENEQ6Lj9Nhe2beNKDZrk1DGqe3lCWKzULqsnWJmN9V4FVzk1cIY7QatnmcPLyy/BtTmW6KfY9YJLRU5HF7jC7FGjCFZMIm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4713;20:MPWIK9WhksSGRFYi8V59nOLZw4t7aoAVdBN1Ba2l3bhv5cyPVLdAu1OAqqLmMaD0TQ6snnOKB10PFTc4mzYE89eWw44uTHqXMBF777hK4101MOvvR9X36x3Pj4cQ7JWoVus7E3LqIV2mfyWOAM16E44WL1Pya2fTq/NOaxVCfv3WQycuRBHHnl/cSamlfBJAxmjxpi5mxK5PytXLG/XK8UP9oCZBRakYgHG4GSXSuORPblCPV2iJ1SYCiqT3L+lk
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:29.6730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d40879ea-d236-4425-73dc-08d5eda15fea
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4713
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch implements function responsible for enabling
and configuring USB endpoint. This function is called
from USB core gadget during handling SET_CONFIGURATION
and SET_INTERFACE request.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-if.c  |  41 ++++-
 drivers/usb/usbssp/gadget-mem.c | 286 ++++++++++++++++++++++++++++++++
 drivers/usb/usbssp/gadget.c     | 271 +++++++++++++++++++++++++++++-
 drivers/usb/usbssp/gadget.h     |  10 ++
 4 files changed, 604 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/usbssp/gadget-if.c b/drivers/usb/usbssp/gadget-if.c
index 376e03b7ef1f..afc4f32ec8af 100644
--- a/drivers/usb/usbssp/gadget-if.c
+++ b/drivers/usb/usbssp/gadget-if.c
@@ -39,13 +39,48 @@
 static int usbssp_gadget_ep_enable(struct usb_ep *ep,
 				   const struct usb_endpoint_descriptor *desc)
 {
-	struct usbssp_ep *ep_priv = to_usbssp_ep(ep);
+	struct usbssp_ep *ep_priv;
+	struct usbssp_udc *usbssp_data;
 	int ret = 0;
+	int irq_disabled_locally = 0;
+	unsigned long flags = 0;
 
-	if (!ep_priv)
+	if (!ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT) {
+		pr_err("invalid parameters\n");
 		return -EINVAL;
+	}
 
-	/*TODO: implements this function*/
+	ep_priv = to_usbssp_ep(ep);
+	usbssp_data = ep_priv->usbssp_data;
+
+	if (!desc->wMaxPacketSize) {
+		dev_dbg(usbssp_data->dev, "missing wMaxPacketSize\n");
+		return -EINVAL;
+	}
+
+	if (ep_priv->ep_state & USBSSP_EP_ENABLED) {
+		dev_dbg(usbssp_data->dev, "%s is already enabled\n",
+			ep_priv->name);
+		return -EINVAL;
+	}
+
+	usbssp_g_lock(irq_disabled_locally, flags);
+	ret = usbssp_add_endpoint(usbssp_data, ep_priv);
+	if (ret < 0)
+		goto finish;
+
+	ep_priv->ep_state |= USBSSP_EP_ENABLED;
+
+	/*Update bandwidth information*/
+	ret = usbssp_check_bandwidth(usbssp_data, &usbssp_data->gadget);
+
+	if (ret < 0)
+		ep_priv->ep_state &= ~USBSSP_EP_ENABLED;
+
+finish:
+	dev_dbg(usbssp_data->dev, "%s enable endpoint %s\n", ep_priv->name,
+		(ret == 0) ? "success" : "failed");
+	usbssp_g_unlock(irq_disabled_locally, flags);
 	return ret;
 }
 
diff --git a/drivers/usb/usbssp/gadget-mem.c b/drivers/usb/usbssp/gadget-mem.c
index d5d732b94454..8438596ecf48 100644
--- a/drivers/usb/usbssp/gadget-mem.c
+++ b/drivers/usb/usbssp/gadget-mem.c
@@ -817,6 +817,292 @@ int usbssp_setup_addressable_priv_dev(struct usbssp_udc *usbssp_data)
 	return 0;
 }
 
+/*
+ * Convert interval expressed as 2^(bInterval - 1) == interval into
+ * straight exponent value 2^n == interval.
+ *
+ */
+static unsigned int usbssp_parse_exponent_interval(struct usb_gadget *g,
+						   struct usbssp_ep *dep)
+{
+	unsigned int interval;
+
+	interval = clamp_val(dep->endpoint.desc->bInterval, 1, 16) - 1;
+	if (interval != dep->endpoint.desc->bInterval - 1)
+		dev_warn(&g->dev,
+			"ep %#x - rounding interval to %d %sframes\n",
+			dep->endpoint.desc->bEndpointAddress,
+			1 << interval,
+			g->speed == USB_SPEED_FULL ? "" : "micro");
+
+	if (g->speed == USB_SPEED_FULL) {
+		/*
+		 * Full speed isoc endpoints specify interval in frames,
+		 * not microframes. We are using microframes everywhere,
+		 * so adjust accordingly.
+		 */
+		interval += 3;	/* 1 frame = 2^3 uframes */
+	}
+
+	return interval;
+}
+
+/*
+ * Convert bInterval expressed in microframes (in 1-255 range) to exponent of
+ * microframes, rounded down to nearest power of 2.
+ */
+static unsigned int usbssp_microframes_to_exponent(struct usb_gadget *g,
+						   struct usbssp_ep *dep,
+						   unsigned int desc_interval,
+						   unsigned int min_exponent,
+						   unsigned int max_exponent)
+{
+	unsigned int interval;
+
+	interval = fls(desc_interval) - 1;
+	interval = clamp_val(interval, min_exponent, max_exponent);
+	if ((1 << interval) != desc_interval)
+		dev_dbg(&g->dev,
+			"ep %#x - rounding interval to %d microframes,"
+			"ep desc says %d microframes\n",
+			dep->endpoint.desc->bEndpointAddress,
+			1 << interval,
+			desc_interval);
+
+	return interval;
+}
+
+static unsigned int usbssp_parse_microframe_interval(struct usb_gadget *g,
+		struct usbssp_ep *dep)
+{
+	if (dep->endpoint.desc->bInterval == 0)
+		return 0;
+	return usbssp_microframes_to_exponent(g, dep,
+					dep->endpoint.desc->bInterval, 0, 15);
+}
+
+
+static unsigned int usbssp_parse_frame_interval(struct usb_gadget *g,
+						struct usbssp_ep *dep)
+{
+
+	return usbssp_microframes_to_exponent(g, dep,
+					dep->endpoint.desc->bInterval * 8,
+					3, 10);
+}
+
+/*
+ * Return the polling or NAK interval.
+ *
+ * The polling interval is expressed in "microframes". If DC's Interval field
+ * is set to N, it will service the endpoint every 2^(Interval)*125us.
+ *
+ * The NAK interval is one NAK per 1 to 255 microframes, or no NAKs if interval
+ * is set to 0.
+ */
+static unsigned int usbssp_get_endpoint_interval(struct usb_gadget *g,
+						 struct usbssp_ep *dep)
+{
+	unsigned int interval = 0;
+
+	switch (g->speed) {
+	case USB_SPEED_HIGH:
+		/* Max NAK rate */
+		if (usb_endpoint_xfer_control(dep->endpoint.desc) ||
+		    usb_endpoint_xfer_bulk(dep->endpoint.desc)) {
+			interval = usbssp_parse_microframe_interval(g, dep);
+			break;
+		}
+		/* Fall through - SS and HS isoc/int have same decoding */
+	case USB_SPEED_SUPER_PLUS:
+	case USB_SPEED_SUPER:
+		if (usb_endpoint_xfer_int(dep->endpoint.desc) ||
+		    usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
+			interval = usbssp_parse_exponent_interval(g, dep);
+		}
+		break;
+
+	case USB_SPEED_FULL:
+		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
+			interval = usbssp_parse_exponent_interval(g, dep);
+			break;
+		}
+		/*
+		 * Fall through for interrupt endpoint interval decoding
+		 * since it uses the same rules as low speed interrupt
+		 * endpoints.
+		 */
+	case USB_SPEED_LOW:
+		if (usb_endpoint_xfer_int(dep->endpoint.desc) ||
+		    usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
+			interval = usbssp_parse_frame_interval(g, dep);
+		}
+		break;
+
+	default:
+		BUG();
+	}
+	return interval;
+}
+
+/*
+ * The "Mult" field in the endpoint context is only set for SuperSpeed isoc eps.
+ * High speed endpoint descriptors can define "the number of additional
+ * transaction opportunities per microframe", but that goes in the Max Burst
+ * endpoint context field.
+ */
+static u32 usbssp_get_endpoint_mult(struct usb_gadget *g,
+				    struct usbssp_ep *dep)
+{
+	if (g->speed < USB_SPEED_SUPER ||
+	    !usb_endpoint_xfer_isoc(dep->endpoint.desc))
+		return 0;
+
+	return dep->endpoint.comp_desc->bmAttributes;
+}
+
+static u32 usbssp_get_endpoint_max_burst(struct usb_gadget *g,
+					 struct usbssp_ep *dep)
+{
+	/* Super speed and Plus have max burst in ep companion desc */
+	if (g->speed >= USB_SPEED_SUPER)
+		return dep->endpoint.comp_desc->bMaxBurst;
+
+	if (g->speed == USB_SPEED_HIGH &&
+	   (usb_endpoint_xfer_isoc(dep->endpoint.desc) ||
+	    usb_endpoint_xfer_int(dep->endpoint.desc)))
+		return (usb_endpoint_maxp(dep->endpoint.desc) & 0x1800) >> 11;
+
+	return 0;
+}
+
+static u32 usbssp_get_endpoint_type(const struct usb_endpoint_descriptor *desc)
+{
+	int in;
+
+	in = usb_endpoint_dir_in(desc);
+
+	switch (usb_endpoint_type(desc)) {
+	case USB_ENDPOINT_XFER_CONTROL:
+		return CTRL_EP;
+	case USB_ENDPOINT_XFER_BULK:
+		return in ? BULK_IN_EP : BULK_OUT_EP;
+	case USB_ENDPOINT_XFER_ISOC:
+		return in ? ISOC_IN_EP : ISOC_OUT_EP;
+	case USB_ENDPOINT_XFER_INT:
+		return in ? INT_IN_EP : INT_OUT_EP;
+	}
+	return 0;
+}
+
+/*
+ * Return the maximum endpoint service interval time (ESIT) payload.
+ * Basically, this is the maxpacket size, multiplied by the burst size
+ * and mult size.
+ */
+static u32 usbssp_get_max_esit_payload(struct usb_gadget *g,
+				       struct usbssp_ep *dep)
+{
+	int max_burst;
+	int max_packet;
+
+	/* Only applies for interrupt or isochronous endpoints*/
+	if (usb_endpoint_xfer_control(dep->endpoint.desc) ||
+	    usb_endpoint_xfer_bulk(dep->endpoint.desc))
+		return 0;
+
+	/* SuperSpeedPlus Isoc ep sending over 48k per esit*/
+
+	if ((g->speed >= USB_SPEED_SUPER_PLUS) &&
+	    USB_SS_SSP_ISOC_COMP(dep->endpoint.desc->bmAttributes))
+		return le32_to_cpu(dep->endpoint.comp_desc->wBytesPerInterval);
+	/* SuperSpeed or SuperSpeedPlus Isoc ep with less than 48k per esit */
+	else if (g->speed >= USB_SPEED_SUPER)
+		return le16_to_cpu(dep->endpoint.comp_desc->wBytesPerInterval);
+
+	max_packet = usb_endpoint_maxp(dep->endpoint.desc);
+	max_burst = usb_endpoint_maxp_mult(dep->endpoint.desc);
+	/* A 0 in max burst means 1 transfer per ESIT */
+	return max_packet * max_burst;
+}
+
+/*
+ * Set up an endpoint with one ring segment. Do not allocate stream rings.
+ * Drivers will have to call usb_alloc_streams() to do that.
+ */
+int usbssp_endpoint_init(struct usbssp_udc *usbssp_data,
+			 struct usbssp_device *dev_priv,
+			 struct usbssp_ep *dep,
+			 gfp_t mem_flags)
+{
+	unsigned int ep_index;
+	struct usbssp_ep_ctx *ep_ctx;
+	struct usbssp_ring *ep_ring;
+	unsigned int max_packet;
+	enum usbssp_ring_type ring_type;
+	u32 max_esit_payload;
+	u32 endpoint_type;
+	unsigned int max_burst;
+	unsigned int interval;
+	unsigned int mult;
+	unsigned int avg_trb_len;
+	unsigned int err_count = 0;
+
+	ep_index = usbssp_get_endpoint_index(dep->endpoint.desc);
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, dev_priv->in_ctx, ep_index);
+
+	endpoint_type = usbssp_get_endpoint_type(dep->endpoint.desc);
+	if (!endpoint_type)
+		return -EINVAL;
+
+	ring_type = usb_endpoint_type(dep->endpoint.desc);
+
+	/*
+	 * Get values to fill the endpoint context, mostly from ep descriptor.
+	 * The average TRB buffer lengt for bulk endpoints is unclear as we
+	 * have no clue on scatter gather list entry size. For Isoc and Int,
+	 * set it to max available.
+	 */
+	max_esit_payload = usbssp_get_max_esit_payload(&usbssp_data->gadget, dep);
+	interval = usbssp_get_endpoint_interval(&usbssp_data->gadget, dep);
+	mult = usbssp_get_endpoint_mult(&usbssp_data->gadget, dep);
+	max_packet = GET_MAX_PACKET(usb_endpoint_maxp(dep->endpoint.desc));
+	max_burst = usbssp_get_endpoint_max_burst(&usbssp_data->gadget, dep);
+	avg_trb_len = max_esit_payload;
+
+	/* Allow 3 retries for everything but isoc, set CErr = 3 */
+	if (!usb_endpoint_xfer_isoc(dep->endpoint.desc))
+		err_count = 3;
+	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) &&
+	    usbssp_data->gadget.speed == USB_SPEED_HIGH)
+		max_packet = 512;
+	/* DC spec indicates that ctrl ep avg TRB Length should be 8 */
+	if (usb_endpoint_xfer_control(dep->endpoint.desc))
+		avg_trb_len = 8;
+
+	/* Set up the endpoint ring */
+	dev_priv->eps[ep_index].new_ring = usbssp_ring_alloc(usbssp_data, 2, 1,
+							ring_type, max_packet,
+							mem_flags);
+
+	dev_priv->eps[ep_index].skip = false;
+	ep_ring = dev_priv->eps[ep_index].new_ring;
+
+	/* Fill the endpoint context */
+	ep_ctx->ep_info = cpu_to_le32(EP_MAX_ESIT_PAYLOAD_HI(max_esit_payload) |
+				EP_INTERVAL(interval) | EP_MULT(mult));
+	ep_ctx->ep_info2 = cpu_to_le32(EP_TYPE(endpoint_type) |
+				MAX_PACKET(max_packet) | MAX_BURST(max_burst) |
+				ERROR_COUNT(err_count));
+	ep_ctx->deq = cpu_to_le64(ep_ring->first_seg->dma |
+				ep_ring->cycle_state);
+
+	ep_ctx->tx_info = cpu_to_le32(EP_MAX_ESIT_PAYLOAD_LO(max_esit_payload) |
+				EP_AVG_TRB_LENGTH(avg_trb_len));
+
+	return 0;
+}
+
 struct usbssp_command *usbssp_alloc_command(struct usbssp_udc *usbssp_data,
 					    bool allocate_completion,
 					    gfp_t mem_flags)
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index d5ed2c48e3fa..f5b0659b6f2d 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -463,6 +463,29 @@ unsigned int usbssp_get_endpoint_index(
 	return index;
 }
 
+/**
+ * The reverse operation to usbssp_get_endpoint_index.
+ * Calculate the USB endpoint address from the USBSSP endpoint index.
+ */
+unsigned int usbssp_get_endpoint_address(unsigned int ep_index)
+{
+	unsigned int number = DIV_ROUND_UP(ep_index, 2);
+	unsigned int direction = ep_index % 2 ? USB_DIR_OUT : USB_DIR_IN;
+
+	return direction | number;
+}
+
+/**
+ * Find the flag for this endpoint (for use in the control context). Use the
+ * endpoint index to create a bitmask. The slot context is bit 0, endpoint 0 is
+ * bit 1, etc.
+ */
+unsigned int usbssp_get_endpoint_flag(
+			const struct usb_endpoint_descriptor *desc)
+{
+	return 1 << (usbssp_get_endpoint_index(desc) + 1);
+}
+
 /* Compute the last valid endpoint context index. Basically, this is the
  * endpoint index plus one. For slot contexts with more than valid endpoint,
  * we find the most significant bit set in the added contexts flags.
@@ -692,6 +715,132 @@ int usbssp_dequeue(struct usbssp_ep *ep_priv, struct usbssp_request *req_priv)
 	return ret;
 }
 
+
+/**
+ * Add an endpoint to a new possible bandwidth configuration for this device.
+ * Only one call to this function is allowed per endpoint before
+ * check_bandwidth() or reset_bandwidth() must be called.
+ * A call to usbssp_drop_endpoint() followed by a call to
+ * usbssp_add_endpoint() will add the endpoint to the schedule with possibly
+ * new parameters denoted by different endpoint descriptor in usbssp_ep.
+ * A call to usbssp_add_endpoint() followed by a call to usbssp_drop_endpoint()
+ * is not allowed.
+ *
+ */
+int usbssp_add_endpoint(struct usbssp_udc *usbssp_data, struct usbssp_ep *dep)
+{
+	const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
+	struct usbssp_container_ctx *in_ctx;
+	unsigned int ep_index;
+	struct usbssp_input_control_ctx *ctrl_ctx;
+	u32 added_ctxs;
+	u32 new_add_flags, new_drop_flags;
+	struct usbssp_device *dev_priv;
+	int ret = 0;
+
+	ret = usbssp_check_args(usbssp_data, dep, 1, true, __func__);
+	if (ret <= 0)
+		return ret;
+
+	if (usbssp_data->usbssp_state & USBSSP_STATE_DYING)
+		return -ENODEV;
+
+	added_ctxs = usbssp_get_endpoint_flag(desc);
+	if (added_ctxs == SLOT_FLAG || added_ctxs == EP0_FLAG) {
+		dev_dbg(usbssp_data->dev, "USBSSP %s - can't add slot or ep 0 %#x\n",
+			__func__, added_ctxs);
+		return 0;
+	}
+
+	dev_priv = &usbssp_data->devs;
+	in_ctx = dev_priv->in_ctx;
+	ctrl_ctx = usbssp_get_input_control_ctx(in_ctx);
+	if (!ctrl_ctx) {
+		dev_warn(usbssp_data->dev, "%s: Could not get input context, bad type.\n",
+			__func__);
+		return 0;
+	}
+
+	ep_index = usbssp_get_endpoint_index(desc);
+
+	/*
+	 * If this endpoint is already in use, and the upper layers are trying
+	 * to add it again without dropping it, reject the addition.
+	 */
+	if (dev_priv->eps[ep_index].ring &&
+	    !(le32_to_cpu(ctrl_ctx->drop_flags) & added_ctxs)) {
+		dev_warn(usbssp_data->dev,
+			"Trying to add endpoint 0x%x without dropping it.\n",
+			(unsigned int) desc->bEndpointAddress);
+		return -EINVAL;
+	}
+
+	/*
+	 * If already noted the endpoint is enabled,
+	 * ignore this request.
+	 */
+	if (le32_to_cpu(ctrl_ctx->add_flags) & added_ctxs) {
+		dev_warn(usbssp_data->dev, "USBSSP %s called with enabled ep %p\n",
+			__func__, dep);
+		return 0;
+	}
+
+	if (usbssp_endpoint_init(usbssp_data, dev_priv, dep, GFP_ATOMIC) < 0) {
+		dev_dbg(usbssp_data->dev, "%s - could not initialize ep %#x\n",
+			__func__, desc->bEndpointAddress);
+		return -ENOMEM;
+	}
+
+	ctrl_ctx->add_flags |= cpu_to_le32(added_ctxs);
+	new_add_flags = le32_to_cpu(ctrl_ctx->add_flags);
+	new_drop_flags = le32_to_cpu(ctrl_ctx->drop_flags);
+
+	dev_dbg(usbssp_data->dev,
+		"add ep 0x%x, new drop flags = %#x, new add flags = %#x\n",
+		(unsigned int) desc->bEndpointAddress,
+		(unsigned int) new_drop_flags,
+		(unsigned int) new_add_flags);
+	return 0;
+}
+
+static void usbssp_zero_in_ctx(struct usbssp_udc *usbssp_data,
+			       struct usbssp_device *dev_priv)
+{
+	struct usbssp_input_control_ctx *ctrl_ctx;
+	struct usbssp_ep_ctx *ep_ctx;
+	struct usbssp_slot_ctx *slot_ctx;
+	int i;
+
+	ctrl_ctx = usbssp_get_input_control_ctx(dev_priv->in_ctx);
+	if (!ctrl_ctx) {
+		dev_warn(usbssp_data->dev,
+			"%s: Could not get input context, bad type.\n",
+			__func__);
+		return;
+	}
+
+	/*
+	 * When a device's add flag and drop flag are zero, any subsequent
+	 * configure endpoint command will leave that endpoint's state
+	 * untouched. Make sure we don't leave any old state in the input
+	 * endpoint contexts.
+	 */
+	ctrl_ctx->drop_flags = 0;
+	ctrl_ctx->add_flags = 0;
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, dev_priv->in_ctx);
+	slot_ctx->dev_info &= cpu_to_le32(~LAST_CTX_MASK);
+
+	/* Endpoint 0 is always valid */
+	slot_ctx->dev_info |= cpu_to_le32(LAST_CTX(1));
+	for (i = 1; i < 31; ++i) {
+		ep_ctx = usbssp_get_ep_ctx(usbssp_data, dev_priv->in_ctx, i);
+		ep_ctx->ep_info = 0;
+		ep_ctx->ep_info2 = 0;
+		ep_ctx->deq = 0;
+		ep_ctx->tx_info = 0;
+	}
+}
+
 static int usbssp_configure_endpoint_result(struct usbssp_udc *usbssp_data,
 					    struct usb_gadget *g,
 					    u32 *cmd_status)
@@ -854,6 +1003,21 @@ static int usbssp_configure_endpoint(struct usbssp_udc *usbssp_data,
 	return ret;
 }
 
+static void usbssp_check_bw_drop_ep_streams(struct usbssp_udc *usbssp_data,
+					    struct usbssp_device *vdev, int i)
+{
+	struct usbssp_ep *ep = &vdev->eps[i];
+
+	if (ep->ep_state & EP_HAS_STREAMS) {
+		dev_warn(usbssp_data->dev,
+			"WARN: endpoint 0x%02x has streams on set_interface, freeing streams.\n",
+			 usbssp_get_endpoint_address(i));
+		usbssp_free_stream_info(usbssp_data, ep->stream_info);
+		ep->stream_info = NULL;
+		ep->ep_state &= ~EP_HAS_STREAMS;
+	}
+}
+
 int usbssp_halt_endpoint(struct usbssp_udc *usbssp_data, struct usbssp_ep *dep,
 			 int value)
 {
@@ -961,10 +1125,115 @@ int usbssp_halt_endpoint(struct usbssp_udc *usbssp_data, struct usbssp_ep *dep,
 	kfree(command->completion);
 	kfree(command);
 	return ret;
+}
 
-	return 0;
+/**
+ *  Called after one or more calls to usbssp_add_endpoint() or
+ * usbssp_drop_endpoint(). If this call fails, the driver is expected
+ * to call usbssp_reset_bandwidth().
+ */
+int usbssp_check_bandwidth(struct usbssp_udc *usbssp_data, struct usb_gadget *g)
+{
+	int i;
+	int ret = 0;
+	struct usbssp_device *dev_priv;
+	struct usbssp_input_control_ctx *ctrl_ctx;
+	struct usbssp_slot_ctx *slot_ctx;
+	struct usbssp_command *command;
+
+	ret = usbssp_check_args(usbssp_data, NULL, 0, true, __func__);
+	if (ret <= 0)
+		return ret;
+
+	if ((usbssp_data->usbssp_state & USBSSP_STATE_DYING) ||
+	    (usbssp_data->usbssp_state & USBSSP_STATE_REMOVING))
+		return -ENODEV;
+
+	dev_priv = &usbssp_data->devs;
+
+	command = usbssp_alloc_command(usbssp_data, true, GFP_ATOMIC);
+	if (!command)
+		return -ENOMEM;
+
+	command->in_ctx = dev_priv->in_ctx;
+
+	ctrl_ctx = usbssp_get_input_control_ctx(command->in_ctx);
+	if (!ctrl_ctx) {
+		dev_warn(usbssp_data->dev,
+			"%s: Could not get input context, bad type.\n",
+			__func__);
+		ret = -ENOMEM;
+		goto command_cleanup;
+	}
+	ctrl_ctx->add_flags |= cpu_to_le32(SLOT_FLAG);
+	ctrl_ctx->add_flags &= cpu_to_le32(~EP0_FLAG);
+	ctrl_ctx->drop_flags &= cpu_to_le32(~(SLOT_FLAG | EP0_FLAG));
+
+	/* Don't issue the command if there's no endpoints to update.*/
+	if (ctrl_ctx->add_flags == cpu_to_le32(SLOT_FLAG) &&
+	    ctrl_ctx->drop_flags == 0) {
+		ret = 0;
+		goto command_cleanup;
+	}
+
+	/* Fix up Context Entries field. Minimum value is EP0 == BIT(1). */
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, dev_priv->in_ctx);
+	for (i = 31; i >= 1; i--) {
+		__le32 le32 = cpu_to_le32(BIT(i));
+
+		if ((dev_priv->eps[i-1].ring && !(ctrl_ctx->drop_flags & le32))
+		    || (ctrl_ctx->add_flags & le32) || i == 1) {
+			slot_ctx->dev_info &= cpu_to_le32(~LAST_CTX_MASK);
+			slot_ctx->dev_info |= cpu_to_le32(LAST_CTX(i));
+			break;
+		}
+	}
+
+	ret = usbssp_configure_endpoint(usbssp_data, g, command,
+			false, false);
+
+	if (ret)
+		/* Caller should call reset_bandwidth() */
+		goto command_cleanup;
+
+	/* Free any rings that were dropped, but not changed. */
+	for (i = 1; i < 31; ++i) {
+		if ((le32_to_cpu(ctrl_ctx->drop_flags) & (1 << (i + 1))) &&
+		    !(le32_to_cpu(ctrl_ctx->add_flags) & (1 << (i + 1)))) {
+			usbssp_free_endpoint_ring(usbssp_data, dev_priv, i);
+			usbssp_check_bw_drop_ep_streams(usbssp_data,
+							dev_priv, i);
+		}
+	}
+
+	usbssp_zero_in_ctx(usbssp_data, dev_priv);
+
+	/*
+	 * Install any rings for completely new endpoints or changed endpoints,
+	 * and free any old rings from changed endpoints.
+	 */
+	for (i = 1; i < 31; ++i) {
+		if (!dev_priv->eps[i].new_ring)
+			continue;
+
+		/*
+		 * Only free the old ring if it exists.
+		 * It may not if this is the first add of an endpoint.
+		 */
+		if (dev_priv->eps[i].ring)
+			usbssp_free_endpoint_ring(usbssp_data, dev_priv, i);
+
+		usbssp_check_bw_drop_ep_streams(usbssp_data, dev_priv, i);
+		dev_priv->eps[i].ring = dev_priv->eps[i].new_ring;
+		dev_priv->eps[i].new_ring = NULL;
+	}
+command_cleanup:
+	kfree(command->completion);
+	kfree(command);
+	return ret;
 }
 
+
 /*
  * This submits a Reset Device Command, which will set the device state to 0,
  * set the device address to 0, and disable all the endpoints except the default
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 81d7fe44519a..c4075e765dcc 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1694,6 +1694,11 @@ void usbssp_copy_ep0_dequeue_into_input_ctx(struct usbssp_udc *usbssp_data);
 unsigned int usbssp_get_endpoint_index(const struct usb_endpoint_descriptor *desc);
 unsigned int usbssp_get_endpoint_address(unsigned int ep_index);
 unsigned int usbssp_last_valid_endpoint(u32 added_ctxs);
+int usbssp_endpoint_init(struct usbssp_udc *usbssp_data,
+			struct usbssp_device *dev_priv,
+			struct usbssp_ep *dep,
+			gfp_t mem_flags);
+
 int usbssp_ring_expansion(struct usbssp_udc *usbssp_data,
 			struct usbssp_ring *ring,
 			unsigned int num_trbs, gfp_t flags);
@@ -1705,6 +1710,9 @@ struct usbssp_ring *usbssp_dma_to_transfer_ring(struct usbssp_ep *ep,
 struct usbssp_ring *usbssp_stream_id_to_ring(struct usbssp_device *dev,
 					unsigned int ep_index,
 					unsigned int stream_id);
+void usbssp_free_endpoint_ring(struct usbssp_udc *usbssp_data,
+			struct usbssp_device *dev_priv,
+			unsigned int ep_index);
 void usbssp_free_stream_info(struct usbssp_udc *usbssp_data,
 			struct usbssp_stream_info *stream_info);
 struct usbssp_ring *usbssp_dma_to_transfer_ring(
@@ -1857,6 +1865,8 @@ int usbssp_setup_analyze(struct usbssp_udc *usbssp_data);
 int usbssp_status_stage(struct usbssp_udc *usbssp_data);
 
 int usbssp_reset_device(struct usbssp_udc *usbssp_data);
+int usbssp_check_bandwidth(struct usbssp_udc *usbssp_data,
+			struct usb_gadget *g);
 
 static inline struct usbssp_ring *usbssp_request_to_transfer_ring(
 					struct usbssp_udc *usbssp_data,
-- 
2.17.1

