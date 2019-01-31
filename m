Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA83C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42755218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="cd/vml/0";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Uf/JLtGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732572AbfAaLxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 06:53:35 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:59286 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732223AbfAaLxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 06:53:33 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0VBhk2S025357;
        Thu, 31 Jan 2019 03:53:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=dfayb8sN4LxyKiht7i2MxMmt7tpSOhpE02ovlwCHyk4=;
 b=cd/vml/0v8GSwYonKxEVjFxZ4KPnt4/9ehuK6N3Oa2UdN0O4SQaS4MjPdYH/U3dwaEnU
 iJus4zxRC1ZkUjwAIPvzahmlabk+ZSpxXtmC3a+4eX5s6zOeGLztJ74pnZAOZCWwmTRE
 ZcJNosObtiRv6T2BFLpskRa6U7n6S/4U4KqR3ian72Bo87vUWh+JRnnbMg7WFQR3wRUL
 hr7tLibuetMbVy0kCimMzA+sTF2bMM8CN36sgFVh90RqC6wTDvy8H+uo0Rur1Qc9ypfm
 lZPq862Q3qinygwz+qbJqxov6PdYVK0HBQdJIwYDO0++wEmsaCQzNmr2rCpZ7WbwRgKt zA== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2051.outbound.protection.outlook.com [104.47.32.51])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2qbn3fjye0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 31 Jan 2019 03:53:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfayb8sN4LxyKiht7i2MxMmt7tpSOhpE02ovlwCHyk4=;
 b=Uf/JLtGucSSTTgDwAXyiqBMepsSbYSZp4IalunWyH0O/+WbLiMPmhojGMdEUrPNaWQzrLTEGqPaARiFo+OCwGe/pZbCCyQTeS0hzcTXeJvZcMHttczxWF/2YXbWb2DcI3VnzvK/ndzPOKtWc95dgTcwZqKJJGG91ZtKTKucVgas=
Received: from CO2PR07CA0082.namprd07.prod.outlook.com (2603:10b6:100::50) by
 BN6PR07MB3090.namprd07.prod.outlook.com (2603:10b6:404:a5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Thu, 31 Jan 2019 11:53:13 +0000
Received: from DM3NAM05FT003.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::208) by CO2PR07CA0082.outlook.office365.com
 (2603:10b6:100::50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.17 via Frontend
 Transport; Thu, 31 Jan 2019 11:53:12 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT003.mail.protection.outlook.com (10.152.98.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.2 via Frontend Transport; Thu, 31 Jan 2019 11:53:11 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x0VBr4Sm028139
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 31 Jan 2019 03:53:10 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 31 Jan 2019 12:53:06 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 31 Jan 2019 12:53:06 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x0VBr6LV002339;
        Thu, 31 Jan 2019 11:53:06 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x0VBr6WK002334;
        Thu, 31 Jan 2019 11:53:06 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <mark.rutland@arm.com>,
        <linux-usb@vger.kernel.org>, <hdegoede@redhat.com>,
        <heikki.krogerus@linux.intel.com>, <andy.shevchenko@gmail.com>,
        <robh+dt@kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <peter.chen@nxp.com>, <pjez@cadence.com>, <kurahul@cadence.com>,
        "Pawel Laszczak" <pawell@cadence.com>
Subject: [PATCH v3 6/6] usb:cdns3 Fix for stuck packets in on-chip OUT buffer.
Date:   Thu, 31 Jan 2019 11:52:33 +0000
Message-ID: <1548935553-452-7-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1548935553-452-1-git-send-email-pawell@cadence.com>
References: <1548935553-452-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(346002)(396003)(2980300002)(199004)(189003)(36092001)(446003)(76176011)(316002)(11346002)(51416003)(8936002)(2616005)(476003)(126002)(336012)(30864003)(106466001)(105596002)(26005)(8676002)(426003)(2351001)(186003)(107886003)(4326008)(26826003)(87636003)(39060400002)(478600001)(54906003)(50226002)(16586007)(7416002)(42186006)(14444005)(86362001)(7636002)(50466002)(48376002)(36756003)(305945005)(2906002)(4720700003)(356004)(6666004)(246002)(486006)(47776003)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3090;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT003;1:gtDGiJV9DoV6Gi/qM5fiBP2UWFnw9qW327o+aDGvm0uDjK2fzqeUmS29EB6+hlE397FL7IzndIkUwiZkaRA84Tflf/pfZ+YniQ152lYzk0MrhuCt6o4mkrhnBMnq8xPnYVXtEkzZyKrATEtYvdyKJaIe9yWU/HiyRwjEG3zqx6g=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b066330c-eecc-4509-d510-08d68772ad2e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060);SRVR:BN6PR07MB3090;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3090;3:E0V+HCNbqyLpYiJjngueA7ZO5QzBNu8N6vVNZWXWKDqGD53R6qGkQ71B0ppe3D1D1PdHwuHsjNggJS5+82hKsYfwpRkXpymZLPfOwv42LedtIbQgG2uoEhTiUs9bhYu+oGXd7xXBxIKLzXoGvTd++sNZnIgc7DaXXUtvYIePuLSH+doq1o9m3Rglu38ijkAndk0R1kGEba6UvuQM7BQWc/yuG1gQ2ltvprMJtGgn6Tvgz/BDprX7o5H3pHi0lGuKU+6ymg+Gk9h4x2afrQulvDVy153fhCDcPiU6B0OzNScx88BpGcjlMS2WlhM0z9KHzszqiYTnF5XsHVCPTIdPhcGDxsPBCFME/c/09RpxqxDG1B0/lm7jjUQC+yAKSybe;25:mCqbzQ2F96/i1j+SnxC+bqjLITzbHgsLn/lBfLRBdEDjX35c45q9cLD4EP5f4aLoz9fnfg0WzJu2AnxTbizWKDg4oo0F7hR04o/f/Jx4+5T1lacDoVQSpqf0zpBNwdvfaxXOyNzg1TG9j+Pfjv2vN9yeIBp550Ztr8J2o23FF+zg/TTpxOGUEj6kPSoJIqXShxg1PCLfKnc85BcQpRxugrKpKDYj7W63FM0lVziyYkmuDvOgSN6PHic2K9eIsTR7JPi6HaHCeAFlM2VWXo5wtO7s6EGBNFoRfbQiac3uCKXfSVdaSffy04Q7hP2ql4amkvfHjD7L+0FgRLDoposJBQ==
X-MS-TrafficTypeDiagnostic: BN6PR07MB3090:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3090;31:pT5CdLLHSKVS2i0ARQUc+9PSejZDkgJBsu26SC5BuzwCDXciQ4I6st/X42iZGpURBKEbMIR+RDT3DHu3mrYZwurgane2pUBzoOFbP+dCCWh7qs0yX5hsF2LVWxfMcTFkIDTwADNavpCQ+FrWtn9bq4z3QUukwpvXGCCFadkbEYW+Pd6N8xKYzlWDWV3YW3S3fXswasG21wD6TzqP5f4woJQNEZKbVto4Oxwg3ye8vcM=;20:686coX6fHDpu2yGqst4pYN9W3S2pKlrhBMMSvZYyzStdMd3YBqzqvkuWnCOZ+Zm4Sv/wcQPqEkP1S1q23XVMmvIrGuzs/FfFqsJIRojoJhmP07jT5APeppb90Yr9GOrvtLmkBgH/zWhQtAb+ylhx7xK15arW5D74e0e0PlLP2Wih3Xfykyov+0P455Gb1nlgWMh+zt88AP/t0me+FGKyufOPdW/W28I7PtqXlzIfBnTWiqwXRJGKEUZigfatv4lIMUt5RNxS4CObKOjnuRk7DULcanI2CL3JYMpqDy+2K7FTTlolk+vM6HU+gX/FUTG9IcCkPK3h5ZVF93iJr/lQDVfPsqxFMfCQPDH0zT2r3x4rv4zjIb2dOD8vOPgJIyzlQqA1f3QxYVCWZ6zgmHSNScsmhH+zup1woTsWcI1Ndm/pOSFUbkcEoOEMJfYQzpP7w3cxWeQtfgTsiUX5ifK+iWR0la1sXSg2E/4QDprwzLVRHCFj7KeM5gKiNYLZ8fFj
X-Microsoft-Antispam-PRVS: <BN6PR07MB3090352AB4141482C8922FB1DD910@BN6PR07MB3090.namprd07.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3090;4:uOp/6JgAEZCQyyJGu18GQO9k1XkTKyQwYozvTzPYe1Kls38ARmqngC5scZ1P2feyZZkVHyYCPzpQJvnIy7wtPJsVf1H8IGNShuFWHRFsYGATt9ihQDetjAOOA4bjurIWjSD7v08WYZ7NUK1mqBSkOC4WyjCzMhwbeah8W3lLeqw4H3Ks1hzax3aAkO0js3WFqToonvBG5adqTmdGk/rTm+44U2t9iaGaflw90IusvEE780njB/ZuwowzaZwbSsvZW2G/vMtahN/Zp4L0Oa+vf58fEgLdr9jpUCQdp580v+U=
X-Forefront-PRVS: 09347618C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR07MB3090;23:eYeirqn6KR/RZNIGBcFJ2wTESh69vv3TdYxr8Lrzg?=
 =?us-ascii?Q?Ovq3o6oKFkT+eL6t3nLPbQoV6C5udeBeX9SxLVo8BAsx+6YhPigfzrJxEs25?=
 =?us-ascii?Q?j6oGXuQFCqeK01kxrdREtx+CGb2tppiPlVaYvHPXt/fHE7S35LZ6z1dsFd0c?=
 =?us-ascii?Q?+CiMiCrtniGMRPmmbpZu+rQXzYvkskbTPqfvp9aLo+p69++JlI9D3akg4a/D?=
 =?us-ascii?Q?SQv5oAuv/6JqpNJjzwZU6ZzhMeziRXkQQxAJ7NjzeARURnqf/NOaYWEuhG3m?=
 =?us-ascii?Q?N95v20Lq1rnisuiLWG8Rm/RzeV13g1TSb+gJ360PvbS1upCfufRyvl6IYn9x?=
 =?us-ascii?Q?mQfLGI6PbzpTGFSDQt/xTg7HZJBNFnd7E8dXBCYwYULebpSKv6ZQje9JDXtb?=
 =?us-ascii?Q?f1OAVFrfh2IPKiAAiJRc5JsbV3n5jVd8a/I4Tzt3PqGAZRAzdYpp0MAKxdA0?=
 =?us-ascii?Q?ANnfV3jAh9x63A4h2Ice2wAVBZyscjEO9wrz05qBuh1tfWFMwuaNR5XIBGz7?=
 =?us-ascii?Q?nNNIrte4WEQA9S2UInF/3YUoDhECN/W8ZU2ZeFyl5QBv2hhlg81HTl+fb8Yp?=
 =?us-ascii?Q?gFhvvsSkQVWmGxCursJT5cPmv57FmqV2xijPyJyphMgPBhOORztztYAJEAcQ?=
 =?us-ascii?Q?7J0s/yHU+u+OfWS8cnQpa8bI9kGaghC1YvwwK9PyEE2hRTMXuzgQpy1CDzKW?=
 =?us-ascii?Q?jul8Q40/8WrOgmYxFl24UpnLjKFwRIloES4fJVahGPXhwqQNm2ejSEYuDGDM?=
 =?us-ascii?Q?PieuExwAx9eKGXNqPOE5hvmmV0z5XvATyin+xLRCJfYvZjB+qhPdIqZbFIvB?=
 =?us-ascii?Q?7sA0mXPS/0+RbY8ndstJBqYbrULxF3ICrhKGWLWvqti4SVG4W8Usals1M8OP?=
 =?us-ascii?Q?7mQebE38tFrx2XRxvv29DhWvPRwYqypLvA445ZdBdnpRw3xkvxytd9WVOMFB?=
 =?us-ascii?Q?u6GD/D/dYkZzJ55aoYNZBobFkKUNpvMaAAb/ciHw6neztNDjp6I621iAgkPF?=
 =?us-ascii?Q?FsLk31ilXvu2Gpvg5H/hxHdjVR57YRzAuVL8jS5WIqeabJlXUobutfo6YAXd?=
 =?us-ascii?Q?vubf4SvywREGAOG7V9C8vjqtu9zx+aFtb0+1nbZWwm8PAm1ZDiYsxnGhqh1o?=
 =?us-ascii?Q?n7BOnv8Yj7xBweFdis16ALFWuXtmVZBNWSAR3aiRuE13vbg5p7dvD9hNZ6xQ?=
 =?us-ascii?Q?TCEuVGRmmCuvCk=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: wqBrj5Axv76qORYL9w/nglCIoqw13cj18XnVY3sPeIuMCL3D5RotBR9HrA+xvcY7LNT2ZRqShokNWrsond16oB0dc11zseBJOpOTNXWpYlTm1Xxp5dDghJxkvuJaD9WLn224YF+zQrncZnl7P//7V5kNHKYPewcJmhXLb/gDGesSE8nNPYlyu6i8m0NUrFiTnHahCu81CMdCzBWH09mXizg4VIWSPWGZhbMosShxGRHCsvaS7Im5DzMXJI4DY4X3IGxc01eMiHyRW2H5p1MSrl9YEKuCSer4vhVyEEQRMOlwuiNl12YxERbj/ReIxiU6eQkL2Xh6wK7+pgom4QW+XK5m3eE9F5fg525+ekspTqXQwrq9FxeSGf8SFZcld2k/ShHZUFAo9Lb3ZBlPWecONtgz0sEIjV+xfYGeW8VPAoM=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3090;6:MPpGqfiJcOYM+XNuh8EDQ1ETGX28G483NGo2DFFwnwTXP6bcoa/EVLd4BihTkPs+DfgF+6ALJcEDldntNyecBBbHAcR/pO/qYyLc+dedcDukFGArDsog6LyJY/vYYVNh/ixlEL3Xkv5ONrbd9AUttAXS6UNNkhr4IAl/yxJyvPH1eaM3esRr3wjwlYpsBz2lWJiRfQIjD7ZLplF7iYkLk7vjTfkM178kw/po39GsjD7mam5ad0XtokAyVZSETo3SHbsMMX7Lw2o+EXhFvoVIpZDC5EqUDW+DShvEHBW/XQuk+3Ee1Dm0mbBG9+VB5CdRuVRV17BHNSXQwcUB9rUfxi0TSdlh0llDujA7y9tr5WaXzXfMe7IwQLdQont1fuvXboqSkO24HnEOuulut2XVMwRZ3qr4t4CVSIKaPpGYZ+4zywRI9Cjj9X3HA4wG8MbR1Se+maBZ3eqENrryW9gQvw==;5:VferFuAxaQhgkj5NFUxYUust7qzmjBMNx8sCDCqYxFwyAKS8U1yvxmY94wKYKqR087ehNneJg7szvJ2JHIjuZkr7DFuOU6d9xtE+LLxIM80tVsGupb3zDaECL+7VvxgJmlho1m3t1/M5JTAiZqmXf10QNQDrzYL/nXoB7XkNpkSWIcmLfZJX5BP9Lo6vdDjUfkJlyAPB9pUIFc9UvP6+0Q==;7:hwvIdkACHQ/zruNvTDN7m04qIgasvQXVLwjMTJ8Tejz+Gae8hfygKlpiViocxIvUoVQbX8dUA7WGxNVUNxaoUqF6a0Up2CYe2/E7ANeKYXaR+zxZt1ulFBBBacoYTXhnHnTuRsDm+gnPiwLpYMOuzw==
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3090;20:CyXmOnBL3WvcStnpVdN0bn5Km6bccndJs/DEpmmlxyQFELBLc6GRjwYSaQLzrFmCk8D3CBb+2mSMWhdlDvt+LKFTsGWONP69Z5JVmcyJsK6RRLJBs0DaLX+DE1aOjsr7dDhFXbhsp/93x3CP6ixvgceT5gT9C4w2cjOXa82mEupf3k4zgf/TQs05WNsCD6I9c/9r2+0no+uebMgWGLcG/D8fX/yFIeQA99uH7nmb/O7XEUdsd8VIQQ47R3pabAaa
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2019 11:53:11.2996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b066330c-eecc-4509-d510-08d68772ad2e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3090
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901310094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Controller for OUT endpoints has shared on-chip buffers for all incoming
packets, including ep0out. It's FIFO buffer, so packets must be handle
by DMA in correct order. If the first packet in the buffer will not be
handled, then the following packets directed for other endpoints and
functions will be blocked.

Additionally the packets directed to one endpoint can block entire on-chip
buffers. In this case transfer to other endpoints also will blocked.

To resolve this issue after raising the descriptor missing interrupt
driver prepares internal usb_request object and use it to arm DMA
transfer.

The problematic situation was observed in case when endpoint has
been enabled but no usb_request were queued. Driver try detects
such endpoints and will use this workaround only for these endpoint.

Driver use limited number of buffer. This number can be set by macro
CDNS_WA2_NUM_BUFFERS.

Such blocking situation was observed on ACM gadget. For this function
host send OUT data packet but ACM function is not prepared for
this packet. It's cause that buffer placed in on chip memory block
transfer to other endpoints.

It's limitation of controller but maybe this issues should be fixed in
function driver.

This work around can be disabled/enabled by means of quirk_internal_buffer
module parameter. By default feature is enabled. It can has impact to
transfer performance and in most case this feature can be disabled.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/gadget.c | 273 ++++++++++++++++++++++++++++++++++++-
 drivers/usb/cdns3/gadget.h |   7 +
 2 files changed, 278 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 35985633470f..20e46d8e308e 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -27,6 +27,37 @@
  * If (((Dequeue Ptr (i.e. EP_TRADDR) == Enqueue Ptr-1) or
  *	(Dequeue Ptr (i.e. EP_TRADDR) == Enqueue Ptr))
  *		and (DRBL==1 and (not EP0)))
+ *
+ * Work around 2:
+ * Controller for OUT endpoints has shared on-chip buffers for all incoming
+ * packets, including ep0out. It's FIFO buffer, so packets must be handle by DMA
+ * in correct order. If the first packet in the buffer will not be handled,
+ * then the following packets directed for other endpoints and  functions
+ * will be blocked.
+ * Additionally the packets directed to one endpoint can block entire on-chip
+ * buffers. In this case transfer to other endpoints also will blocked.
+ *
+ * To resolve this issue after raising the descriptor missing interrupt
+ * driver prepares internal usb_request object and use it to arm DMA transfer.
+ *
+ * The problematic situation was observed in case when endpoint has been enabled
+ * but no usb_request were queued. Driver try detects such endpoints and will
+ * use this workaround only for these endpoint.
+ *
+ * Driver use limited number of buffer. This number can be set by macro
+ * CDNS_WA2_NUM_BUFFERS.
+ *
+ * Such blocking situation was observed on ACM gadget. For this function
+ * host send OUT data packet but ACM function is not prepared for this packet.
+ * It's cause that buffer placed in on chip memory block transfer to other
+ * endpoints.
+ *
+ * It's limitation of controller but maybe this issues should be fixed in
+ * function driver.
+ *
+ * This work around can be disabled/enabled by means of quirk_internal_buffer
+ * module parameter. By default feature is enabled. It can has impact to
+ * transfer performance and in most case this feature can be disabled.
  */
 
 #include <linux/dma-mapping.h>
@@ -42,6 +73,14 @@ static int __cdns3_gadget_ep_queue(struct usb_ep *ep,
 				   struct usb_request *request,
 				   gfp_t gfp_flags);
 
+/*
+ * Parameter allows to disable/enable handling of work around 2 feature.
+ * By default this value is enabled.
+ */
+static bool quirk_internal_buffer = 1;
+module_param(quirk_internal_buffer, bool, 0644);
+MODULE_PARM_DESC(quirk_internal_buffer, "Disable/enable WA2 algorithm");
+
 /**
  * cdns3_handshake - spin reading  until handshake completes or fails
  * @ptr: address of device controller register to be read
@@ -105,6 +144,17 @@ struct usb_request *cdns3_next_request(struct list_head *list)
 	return list_first_entry_or_null(list, struct usb_request, list);
 }
 
+/**
+ * cdns3_next_priv_request - returns next request from list
+ * @list: list containing requests
+ *
+ * Returns request or NULL if no requests in list
+ */
+struct cdns3_request *cdns3_next_priv_request(struct list_head *list)
+{
+	return list_first_entry_or_null(list, struct cdns3_request, list);
+}
+
 /**
  * select_ep - selects endpoint
  * @priv_dev:  extended gadget object
@@ -384,6 +434,53 @@ static int cdns3_start_all_request(struct cdns3_device *priv_dev,
 	return ret;
 }
 
+/**
+ * cdns3_descmiss_copy_data copy data from internal requests to request queued
+ * by class driver.
+ * @priv_ep: extended endpoint object
+ * @request: request object
+ */
+static void cdns3_descmiss_copy_data(struct cdns3_endpoint *priv_ep,
+				     struct usb_request *request)
+{
+	struct usb_request *descmiss_req;
+	struct cdns3_request *descmiss_priv_req;
+
+	while (!list_empty(&priv_ep->descmiss_req_list)) {
+		int chunk_end;
+		int length;
+
+		descmiss_priv_req =
+			cdns3_next_priv_request(&priv_ep->descmiss_req_list);
+		descmiss_req = &descmiss_priv_req->request;
+
+		/* driver can't touch pending request */
+		if (descmiss_priv_req->flags & REQUEST_PENDING)
+			break;
+
+		chunk_end = descmiss_priv_req->flags & REQUEST_INTERNAL_CH;
+		length = request->actual + descmiss_req->actual;
+
+		if (length <= request->length) {
+			memcpy(&((u8 *)request->buf)[request->actual],
+			       descmiss_req->buf,
+			       descmiss_req->actual);
+			request->actual = length;
+		} else {
+			/* It should never occures */
+			request->status = -ENOMEM;
+		}
+
+		list_del_init(&descmiss_priv_req->list);
+
+		kfree(descmiss_req->buf);
+		cdns3_gadget_ep_free_request(&priv_ep->endpoint, descmiss_req);
+
+		if (!chunk_end)
+			break;
+	}
+}
+
 /**
  * cdns3_gadget_giveback - call struct usb_request's ->complete callback
  * @priv_ep: The endpoint to whom the request belongs to
@@ -412,6 +509,32 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
 	priv_req->flags &= ~REQUEST_PENDING;
 	trace_cdns3_gadget_giveback(priv_req);
 
+	/* WA2: */
+	if (priv_ep->flags & EP_QUIRK_EXTRA_BUF_EN &&
+	    priv_req->flags & REQUEST_INTERNAL) {
+		struct usb_request *req;
+
+		req = cdns3_next_request(&priv_ep->deferred_req_list);
+		request = req;
+		priv_ep->descmis_req = NULL;
+
+		if (!req)
+			return;
+
+		cdns3_descmiss_copy_data(priv_ep, req);
+		if (!(priv_ep->flags & EP_QUIRK_END_TRANSFER) &&
+		    req->length != req->actual) {
+			/* wait for next part of transfer */
+			return;
+		}
+
+		if (req->status == -EINPROGRESS)
+			req->status = 0;
+
+		list_del_init(&req->list);
+		cdns3_start_all_request(priv_dev, priv_ep);
+	}
+
 	/* Start all not pending request */
 	if (priv_ep->flags & EP_RING_FULL)
 		cdns3_start_all_request(priv_dev, priv_ep);
@@ -769,6 +892,59 @@ void cdns3_rearm_transfer(struct cdns3_endpoint *priv_ep, u8 rearm)
 	}
 }
 
+/**
+ * cdns3_descmissing_packet - handles descriptor missing event.
+ * @priv_dev: extended gadget object
+ *
+ * This function is used only for WA2. For more information see Work around 2
+ * description.
+ */
+static int cdns3_descmissing_packet(struct cdns3_endpoint *priv_ep)
+{
+	struct cdns3_request *priv_req;
+	struct usb_request *request;
+
+	if (priv_ep->flags & EP_QUIRK_EXTRA_BUF_DET) {
+		priv_ep->flags &= ~EP_QUIRK_EXTRA_BUF_DET;
+		priv_ep->flags |= EP_QUIRK_EXTRA_BUF_EN;
+	}
+
+	cdns3_dbg(priv_ep->cdns3_dev, "WA2: Description Missing detected\n");
+
+	request = cdns3_gadget_ep_alloc_request(&priv_ep->endpoint,
+						GFP_ATOMIC);
+	if (!request)
+		return -ENOMEM;
+
+	priv_req = to_cdns3_request(request);
+	priv_req->flags |= REQUEST_INTERNAL;
+
+	/* if this field is still assigned it indicate that transfer related
+	 * with this request has not been finished yet. Driver in this
+	 * case simply allocate next request and assign flag REQUEST_INTERNAL_CH
+	 * flag to previous one. It will indicate that current request is
+	 * part of the previous one.
+	 */
+	if (priv_ep->descmis_req)
+		priv_ep->descmis_req->flags |= REQUEST_INTERNAL_CH;
+
+	priv_req->request.buf = kzalloc(CDNS3_DESCMIS_BUF_SIZE,
+					GFP_ATOMIC);
+	if (!priv_req) {
+		cdns3_gadget_ep_free_request(&priv_ep->endpoint, request);
+		return -ENOMEM;
+	}
+
+	priv_req->request.length = CDNS3_DESCMIS_BUF_SIZE;
+	priv_ep->descmis_req = priv_req;
+
+	__cdns3_gadget_ep_queue(&priv_ep->endpoint,
+				&priv_ep->descmis_req->request,
+				GFP_ATOMIC);
+
+	return 0;
+}
+
 /**
  * cdns3_check_ep_interrupt_proceed - Processes interrupt related to endpoint
  * @priv_ep: endpoint object
@@ -801,8 +977,31 @@ static int cdns3_check_ep_interrupt_proceed(struct cdns3_endpoint *priv_ep)
 			cdns3_rearm_transfer(priv_ep, priv_ep->wa1_set);
 	}
 
-	if ((ep_sts_reg & EP_STS_IOC) || (ep_sts_reg & EP_STS_ISP))
+	if ((ep_sts_reg & EP_STS_IOC) || (ep_sts_reg & EP_STS_ISP)) {
+		if (priv_ep->flags & EP_QUIRK_EXTRA_BUF_EN) {
+			if (ep_sts_reg & EP_STS_ISP)
+				priv_ep->flags |= EP_QUIRK_END_TRANSFER;
+			else
+				priv_ep->flags &= ~EP_QUIRK_END_TRANSFER;
+		}
+
 		cdns3_transfer_completed(priv_dev, priv_ep);
+	}
+
+	/*
+	 * WA2: this condition should only be meet when
+	 * priv_ep->flags & EP_QUIRK_EXTRA_BUF_DET or
+	 * priv_ep->flags & EP_QUIRK_EXTRA_BUF_EN.
+	 * In other cases this interrupt will be disabled/
+	 */
+	if (ep_sts_reg & EP_STS_DESCMIS) {
+		int err;
+
+		err = cdns3_descmissing_packet(priv_ep);
+		if (err)
+			dev_err(priv_dev->dev,
+				"Failed: No sufficient memory for DESCMIS\n");
+	}
 
 	return 0;
 }
@@ -1223,13 +1422,26 @@ static int cdns3_gadget_ep_enable(struct usb_ep *ep,
 	/* enable interrupt for selected endpoint */
 	cdns3_set_register_bit(&priv_dev->regs->ep_ien,
 			       BIT(cdns3_ep_addr_to_index(bEndpointAddress)));
+	/*
+	 * WA2: Set flag for all not ISOC OUT endpoints. If this flag is set
+	 * driver try to detect whether endpoint need additional internal
+	 * buffer for unblocking on-chip FIFO buffer. This flag will be cleared
+	 * if before first DESCMISS interrupt the DMA will be armed.
+	 */
+	if (quirk_internal_buffer) {
+		if (!priv_ep->dir && priv_ep->type != USB_ENDPOINT_XFER_ISOC) {
+			priv_ep->flags |= EP_QUIRK_EXTRA_BUF_DET;
+			reg |= EP_STS_EN_DESCMISEN;
+		}
+	}
 
 	writel(reg, &priv_dev->regs->ep_sts_en);
 
 	cdns3_set_register_bit(&priv_dev->regs->ep_cfg, EP_CFG_ENABLE);
 
 	ep->desc = desc;
-	priv_ep->flags &= ~(EP_PENDING_REQUEST | EP_STALL);
+	priv_ep->flags &= ~(EP_PENDING_REQUEST | EP_STALL |
+			    EP_QUIRK_EXTRA_BUF_EN);
 	priv_ep->flags |= EP_ENABLED | EP_UPDATE_EP_TRBADDR;
 	priv_ep->wa1_set = 0;
 	priv_ep->enqueue = 0;
@@ -1254,6 +1466,7 @@ static int cdns3_gadget_ep_enable(struct usb_ep *ep,
 static int cdns3_gadget_ep_disable(struct usb_ep *ep)
 {
 	struct cdns3_endpoint *priv_ep;
+	struct cdns3_request *priv_req;
 	struct cdns3_device *priv_dev;
 	struct usb_request *request;
 	unsigned long flags;
@@ -1290,6 +1503,14 @@ static int cdns3_gadget_ep_disable(struct usb_ep *ep)
 				      -ESHUTDOWN);
 	}
 
+	while (!list_empty(&priv_ep->descmiss_req_list)) {
+		priv_req = cdns3_next_priv_request(&priv_ep->descmiss_req_list);
+
+		kfree(priv_req->request.buf);
+		cdns3_gadget_ep_free_request(&priv_ep->endpoint,
+					     &priv_req->request);
+	}
+
 	while (!list_empty(&priv_ep->deferred_req_list)) {
 		request = cdns3_next_request(&priv_ep->deferred_req_list);
 
@@ -1330,6 +1551,53 @@ static int __cdns3_gadget_ep_queue(struct usb_ep *ep,
 	priv_req = to_cdns3_request(request);
 	trace_cdns3_ep_queue(priv_req);
 
+	/*
+	 * WA2: if transfer was queued before DESCMISS appear than we
+	 * can disable handling of DESCMISS interrupt. Driver assumes that it
+	 * can disable special treatment for this endpoint.
+	 */
+	if (priv_ep->flags & EP_QUIRK_EXTRA_BUF_DET) {
+		u32 reg;
+
+		cdns3_select_ep(priv_dev, priv_ep->num | priv_ep->dir);
+		priv_ep->flags &= ~EP_QUIRK_EXTRA_BUF_DET;
+		reg = readl(&priv_dev->regs->ep_sts_en);
+		reg &= ~EP_STS_EN_DESCMISEN;
+		writel(reg, &priv_dev->regs->ep_sts_en);
+	}
+
+	/* WA2 */
+	if (priv_ep->flags & EP_QUIRK_EXTRA_BUF_EN) {
+		u8 pending_empty = list_empty(&priv_ep->pending_req_list);
+		u8 descmiss_empty = list_empty(&priv_ep->descmiss_req_list);
+
+		/*
+		 *  DESCMISS transfer has been finished, so data will be
+		 *  directly copied from internal allocated usb_request
+		 *  objects.
+		 */
+		if (pending_empty && !descmiss_empty &&
+		    !(priv_req->flags & REQUEST_INTERNAL)) {
+			cdns3_descmiss_copy_data(priv_ep, request);
+			list_add_tail(&request->list,
+				      &priv_ep->pending_req_list);
+			cdns3_gadget_giveback(priv_ep, priv_req,
+					      request->status);
+			return ret;
+		}
+
+		/*
+		 * WA2 driver will wait for completion DESCMISS transfer,
+		 * before starts new, not DESCMISS transfer.
+		 */
+		if (!pending_empty && !descmiss_empty)
+			deferred = 1;
+
+		if (priv_req->flags & REQUEST_INTERNAL)
+			list_add_tail(&priv_req->list,
+				      &priv_ep->descmiss_req_list);
+	}
+
 	ret = usb_gadget_map_request_by_dev(priv_dev->sysdev, request,
 					    usb_endpoint_dir_in(ep->desc));
 	if (ret)
@@ -1764,6 +2032,7 @@ static int cdns3_init_eps(struct cdns3_device *priv_dev)
 
 		INIT_LIST_HEAD(&priv_ep->pending_req_list);
 		INIT_LIST_HEAD(&priv_ep->deferred_req_list);
+		INIT_LIST_HEAD(&priv_ep->descmiss_req_list);
 	}
 
 	return 0;
diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/gadget.h
index 0f8fec39917e..386a2ac64331 100644
--- a/drivers/usb/cdns3/gadget.h
+++ b/drivers/usb/cdns3/gadget.h
@@ -1000,6 +1000,7 @@ struct cdns3_device;
  * @endpoint: usb endpoint
  * @pending_req_list: list of requests queuing on transfer ring.
  * @deferred_req_list: list of requests waiting for queuing on transfer ring.
+ * @descmiss_req_list: list of requests internally allocated by driver (WA2).
  * @trb_pool: transfer ring - array of transaction buffers
  * @trb_pool_dma: dma address of transfer ring
  * @cdns3_dev: device associated with this endpoint
@@ -1026,6 +1027,7 @@ struct cdns3_endpoint {
 	struct usb_ep		endpoint;
 	struct list_head	pending_req_list;
 	struct list_head	deferred_req_list;
+	struct list_head	descmiss_req_list;
 
 	struct cdns3_trb	*trb_pool;
 	dma_addr_t		trb_pool_dma;
@@ -1041,6 +1043,9 @@ struct cdns3_endpoint {
 #define EP_PENDING_REQUEST	BIT(5)
 #define EP_RING_FULL		BIT(6)
 #define EP_CLAIMED		BIT(7)
+#define EP_QUIRK_EXTRA_BUF_DET	BIT(8)
+#define EP_QUIRK_EXTRA_BUF_EN	BIT(9)
+#define EP_QUIRK_END_TRANSFER	BIT(10)
 
 	u32			flags;
 
@@ -1074,6 +1079,7 @@ struct cdns3_endpoint {
  * @start_trb: number of the first TRB in transfer ring
  * @end_trb: number of the last TRB in transfer ring
  * @flags: flag specifying special usage of request
+ * @list: used by internally allocated request to add to descmiss_req_list.
  */
 struct cdns3_request {
 	struct usb_request	request;
@@ -1086,6 +1092,7 @@ struct cdns3_request {
 #define REQUEST_INTERNAL_CH	BIT(2)
 #define REQUEST_ZLP		BIT(3)
 	u32			flags;
+	struct list_head	list;
 };
 
 #define to_cdns3_request(r) (container_of(r, struct cdns3_request, request))
-- 
2.17.1

