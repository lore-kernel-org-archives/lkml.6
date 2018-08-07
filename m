Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3B4C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 05:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC77121537
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 05:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jJIZ/4e9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC77121537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbeHGHcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 03:32:14 -0400
Received: from mail-sn1nam01on0063.outbound.protection.outlook.com ([104.47.32.63]:6608
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726951AbeHGHcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 03:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxAHNmCM35WiAEP7/hau6sE1PHY4xb7r/ykajQsHHzo=;
 b=jJIZ/4e9+ZWbXkc3PiqHbHXGxHdC8E9KEZlQS5PrfHJ576b3Cn4GRL73BkrBOtwvQzGvZirzyMBb4fe9XcHc/6aZ5cSmCXh1mGERsLFcFCzLmsnGulRC2dJ26NV4mw22DVE/FdkJcESm3ntEkbQFbQ/rdMc9B64UPsgc+rex354=
Received: from MWHPR12CA0035.namprd12.prod.outlook.com (2603:10b6:301:2::21)
 by DM5PR1201MB2504.namprd12.prod.outlook.com (2603:10b6:3:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Tue, 7 Aug
 2018 05:16:45 +0000
Received: from DM3NAM03FT049.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::208) by MWHPR12CA0035.outlook.office365.com
 (2603:10b6:301:2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1038.19 via Frontend
 Transport; Tue, 7 Aug 2018 05:16:44 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 DM3NAM03FT049.mail.protection.outlook.com (10.152.83.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1038.3 via Frontend Transport; Tue, 7 Aug 2018 05:16:44 +0000
Received: from hr-amur2 (10.34.1.3) by SATLEXCHOV02.amd.com (10.181.40.72)
 with Microsoft SMTP Server (TLS) id 14.3.389.1; Tue, 7 Aug 2018 00:16:42
 -0500
Date:   Tue, 7 Aug 2018 13:28:19 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Felix Kuehling <felix.kuehling@amd.com>
CC:     Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S++/vW5pZw==?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amdkfd: Use true and false for boolean values
Message-ID: <20180807052818.GA913@hr-amur2>
References: <20180805002702.GA26671@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180805002702.GA26671@embeddedor.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(2980300002)(428003)(189003)(199004)(5660300001)(105586002)(33656002)(26005)(2906002)(77096007)(186003)(33716001)(33896004)(305945005)(356003)(16586007)(97756001)(104016004)(55016002)(9686003)(6306002)(8936002)(58126008)(110136005)(54906003)(47776003)(316002)(106466001)(39060400002)(4326008)(6246003)(97736004)(81156014)(8676002)(46406003)(68736007)(229853002)(478600001)(86362001)(53936002)(50466002)(966005)(72206003)(446003)(76176011)(6636002)(23726003)(486006)(426003)(1076002)(476003)(126002)(11346002)(336012)(81166006)(6666003)(18370500001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR1201MB2504;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT049;1:yKb2TtMMpRwD0bGOfMgZK4c5kIgXaNdZXDykI5t8kEtAp1C4/ChPK891eMHkfVSNyEDzRmnZot8p0nozWy0shWZz5nmyzLHNZGXwMxD6pad3yfu8kgkRRmHHAzm0/9Fn
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cb6c80b-4554-45a1-fede-08d5fc24f784
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060);SRVR:DM5PR1201MB2504;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB2504;3:YXX1jdam6EmBftLY2UK+y14PVu7Oh69W8UIGbQam6cdERZoTxbcK+iKIJfxwviWRzfhavGtlF4qNQzeoHdbjqhdR3c/Iv1a4VbkEaqD0dB63D58rA4KaLH62ZrdrlmvHZPH7GppbfSNEZUKL5IeH/Jp4L1TJSnaw0AXwqp+asBresHGk3Gxny9PGO/rwc40xLDmD7zwecTuVUOFkE7ZRloNHYDVWJu2TZ5ftrpjJPpJiBnb+otQG+NX0U/qxlTo2ziQHvcLz4ZRJVBeK7fTHrds/cwu/pM0WnvTR9WJ3VoEXt0i8ZFE5qg/xLDzkdig1JXWayo56f5OTQc8TB4LbMyUWs3xe/qOy/tU2yldyU3g=;25:Cl0UumvktlDMHDADBwayf1ryjH0JaoQ3kP/XGPy32DYEbjZvMM4m+qk6zfg4arAno0RopVgt9wGVlQfkfCMgXIWzTAjk1f9+n50qYmEnQZjf6VXsBX6ibZu4cK3EaMyF3Mi/Idd+RzSvXwcRWEUsTFwiitzfwam0ii/GS/Vrxyf2Ug/nHc0YcF7jPnree74k79OhDBGFlEVA0BiewFgHEgr2lls4VMyplxDbnRTNM6u7pxdE+tFHuc0e3mEgsLYV03EXCKZBGREkIIAW+jthhgbcgWbRwvCQRmXSJREFb+Nl/6p4JW7NWouXeYkhphVmONls1LnE/xhCFB575FF68g==
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2504:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB2504;31:FIfVJFn1NXQYRnmGpHi2KRJJ1RQTWT0AlXIm6tHZyy0b3YixzwkCSMzsNH/GyfVc6uT8qYmMhKWa+DjHqwp7ZZBIsu16eu0YSbGqvlXROUOEQa4Jt6ATqSzlh3GtlLMSz10XI7FkDU0bCjh3QqJBTidID5FzlWD/3UbHsvksbfWUzzUR8Dom0/KYe9jpq+jwP2hZF3eHOAkWfUt7sPdYHmrKabFXXOjwhHLYUPFERew=;20:Fjb8fkrgH5TbRdKLC0NjjXktrUFPARL7/CVVtD02Hfxrlt4YYQyX9Q2J4gV0jmfTuK/Y5Y9c3FNol9l0+eG1dFk8lfrrQRBAZfDA8EyPZHMmD5/YKWa7lXz6TrjuFybh0JuVqH+z1BEVfz2cw89nxap7BXGhPAuo99hI64wBd0PR1CouJzd+V0Osg/jMjMvuf+Eevk6CH0DnE/XcWonDKnws814pbUo3F/WJBU79JSrF0JcdnkktmsMJNuEvCeMFNbIs80j8X7mqxZy6muvHbTQyXw0P9/+OZ2tTEWxCrwIsaVRimVMJbEltdyjkyrJSZOhVuTrst4mxirUqH5P04Ith7wLL2l/RSc5rqwDri2dOusTgN/7ogOoZ1gIdASjN2GKuS++GtDS+crauBJlxcPeLSerwXcxvX4Jb4bxEFvTKt51y94AGqCdgKWzRDFRj4SRIlAaQgEp8r07quGqxg8YYYaZhSdQlM/mnXR9wWz7clNMgM2el3uWy6leXLnmV
X-Microsoft-Antispam-PRVS: <DM5PR1201MB25049049A6DA858A84C91224EC270@DM5PR1201MB2504.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(217544274631240);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM5PR1201MB2504;BCL:0;PCL:0;RULEID:;SRVR:DM5PR1201MB2504;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB2504;4:nK56+lXWpZbsJOGnAYMTMpHZdit9Ya1LbLKFQLpUXBQ6kGY9iV7iLajYyCs7iPXf+3RFm71m/K3L+jzZiGqroWfXhaFWsX23wStz6xgw4j4My1xDlUjTLP+RDymcRmObL8Qo40/RIGi5CZbXJSIeOZLV9IQ4JN0BSuYnfjD/aP59XtrLarZU3F0vPoG3UnENfbgsluZEaRwWhJQzPCC32bvjNbonnT4cQF4BrEbq4IdeoCktC7tta83A6nAHqIcUGPfF5gpF2ygjpsnNVjF5RlKpe/SyQUAHxvPMJ97gKllOQNXa4S8sj0soXqV7Cykz2z5rns7qXLTHxpb9Ren5BssORDfMpZ4jke5TbdxuY0A=
X-Forefront-PRVS: 0757EEBDCA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR1201MB2504;23:V+WpWBAU93TEf+65aXFhZOR0yzkklXBzRrN5nlz?=
 =?us-ascii?Q?dtRQm/faaqhHon/Wv/o/lDZo5vJcyLEKfdwQwEgkqRbTv0c1PUCLGhQBWoKs?=
 =?us-ascii?Q?Q4C3GXQwdddhthvVicRiXh4w2iTqTJIZWhG9kHGwB6pH7YABWIapI6bh8eBO?=
 =?us-ascii?Q?G9NHxfezF6xJgsaR/d7hh3dhBMCkWQY1EMc2Akuk3P0HqKpTF00oQvPWC0o2?=
 =?us-ascii?Q?JBoug/ICbR9nNHJmhOzF8i90F9vJFt0RUKueHppmaiW36Pjz3dk6ZOPnrSoR?=
 =?us-ascii?Q?dvFXerIo2tja+auSqFamvhjlCSz+xSy004dqIyNm+8kyfOTB2dJ1rZvobt6j?=
 =?us-ascii?Q?b2FtkwFat1E7Yp4yZ0fN6Vcg7W5a2rgqYpOHTC8MYWcgMmhyz4ckc52x0o6Y?=
 =?us-ascii?Q?YyR5ch23qvW+QtuW/mWxTa2XaSpMtraaJCu7tknrRz5Pbfl6oE2xBP5RrJli?=
 =?us-ascii?Q?WREel2vyi7Z1b81hJ2dHWEczYuaamHrk9Sr4KpmkEReT/fDzZT340n4WVV5K?=
 =?us-ascii?Q?2AxYjzUDB7WN7Ljqua9nI7kKTZESw4F7yTS5UfJ/EIqiNdn8QQOg5PS9zOWj?=
 =?us-ascii?Q?M9sUjVMFb3PoRZw6/OlJM0twEB41TIDqPyfTq3ZRpIz/+FGmJjJRrpTlQQoM?=
 =?us-ascii?Q?YpXIHhlTpuhQF2t5FByuoUgzFo4QXYLjx8LMW5dS+g92qsOKkQX6eWL26fu4?=
 =?us-ascii?Q?b++LCVQU5ZpiWrVPLmQOxqo6iJuE6iiacuCpgL272WLBOVkuf/YBMsk80y8u?=
 =?us-ascii?Q?MmWSkDtNTKfxx/waI96ktCrrSfvJVXsku+gzuBNATMnPgOhaPcYO+cX9lyJB?=
 =?us-ascii?Q?CisRGqqr+/zkSGf11FJ3nO4PB0NojXHnaEqNA1dHde53Fsvt8en0c2Nm3tpF?=
 =?us-ascii?Q?vikzk6ATpZ8JLBI7m28nFDDdlsDrc6Ah+Uxo5TE89hhN6anaNGfDtMekRSI1?=
 =?us-ascii?Q?Mc/tt60hpFdDOoIcNV/oRgWOXaOQKn7TikdGXxMca658VSxYM1rBJpSKJSgh?=
 =?us-ascii?Q?MihilB3AuktCCEC7RrJxwHURslE7uo3Pfq0c92dN6cOnzJPHGYL/ltRogOSI?=
 =?us-ascii?Q?AFcnhvSJhK1O0cqMJlwVsUzU9E9mZOi9mXq0uJNfOlYIhcV2Let31St53Sef?=
 =?us-ascii?Q?Z+mPpmx4flmOLQYT8Gu/yHsPcMcD5+i64HaTitTwBJBjEBv28kt9KsiGo+mp?=
 =?us-ascii?Q?abuTfdPlT1O3fSAoX6N2R7xWiHnvrMiBSMhM9cTMo35MsC34vUzpFj4bhXRe?=
 =?us-ascii?Q?wqlVVoyX8Lv8UIFWcRoGOXD3WSCnzuCpf3O4GaFI+j7ArpLeZyZbEJa0grbr?=
 =?us-ascii?Q?SWXdfKq0pftx5ubXvTqSvcG6evLtmZZdl9VrJWKVtpB71bib2DGkvDxRw2x8?=
 =?us-ascii?Q?pkr2gIyP59BlOJKQ07iABVsEwuQcIMDxe/hFTmonNOtDth/td?=
X-Microsoft-Antispam-Message-Info: vqHfcDZsf2EOqHpOu7xL+SoMAN0q3v7KxAlFLjWUMiAWon9GD4eKE0y4sUV/gWd2cYiwLnJPllIkvvhIKQjDwkrDHqtHf80JM7C4vE6cCBtMbZJkPQczo8bLF1LBr2P0jme0hxLB6y0D/Uw16Jvx63sTe3cSpMZaORq7C/4k8YuywLSMN2tT4YBh90tCQfHz2ZR2MC6qvYUHV6IF+uBAyx0KEm+NRYu/QTXNruVwe1blxtz/S5P0HU0omxjX9j6fUpVn3I0CckEqSDrcKzyRBF9+/wJ/qWolduw8G2vakrVQHllHZFE9QcrsRl/HfKHP9p/0OyDCtDN3I9BkYuLSOWFBKaofThXaHtM5xkpsu+Y=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB2504;6:LxHjYpRdDBBKGAzjZpWxFVXrwYeF8T8AJy6gFHfnk9zT/9R1CIKuKcVhbFMKvN+RCbvRIC2afF6Mh60b2LsArqB/DPdkB+WwoFVVeLGZQcsYUvk6E0yL09OUq9NNQtRHx5zQdbdqTsTh3N2qg+NRC0vK84HAFUMO0O5KJK3azsfsddQVkqkx1+nIVSKXp29F6r160zekmQB1yY0LjoxxOmycSDBAz4zOkTR0bpov3tOlXBk8rv5/F69ce4f1sVqrCY3BgoRmfD1DfmSKZiDyx/vOQleM9yfpgIvsdLoLKHiMZ3Ja49BLkLwG5MQWaUB/2ObOc5GmDjYquafiYQ72gf21NhA5+YaBrU6qt2iNAQ1LGXMnNEM7cgdOL0Zn7Pb3SDweQnjiJ0fEFL4ehN8AE/gafNNqwzrZmkOtz5LLSVY7oQdvxm8vtPXcT2JiNaJxLtw3m4n9/kvBmtpCj2jzKA==;5:pSg8iOqjikX3Ig4KR8jU+211dTboegNgokwOHKuWwi8wrVGEcRfJgTs0yhIDda7EYT/iC21BnE6kVQGH3DxIR1WSOAhoIL2Lmp1qlZeYB9z3vbVX2DUO6V0Si34zTf2P4UL/eyKXF898KbgY+fpaH7KX9Gdnl2EEFjduTSbNdD0=;7:Fxwi6bgSuzg/Tvwcw4xRjFv7AgHXJy4OdxHNhuWngMPxsCAqtHJdkBqmruLIxYpVgInKFmwvGt52cwJWIdT1lHe/8BCsKSkHWKYFrzyQxlYjc9rAGo+sEBFzyY5CSqGeZY6vTBIe/2yqDdrhrJMdudQ4WWx7CPz3WMLho3wTBZ78LtjTnCGF/aZuL8RhNuiGLPkdXfTQpQW3XiGBPB357qKiChQEsBT3HX6LYu3NKCBWE2imhrUrfVeUp29CQt2B
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB2504;20:MhloOjLTfbz1q5bZ9Lto44Ne1mNmcoCdkm4szddjdc7xeoqOjMGDrrZVSL3vwpUfTg2SK/k1MBls8uIFbrn+c/gDDIXVig9MrzSiBiCddCjOqcEJgDQmmzPvxYrXKxptQnGnFZujMKNXwndfcnwKzZQK6USb8HCvifYCO0TLH39qhrc97PwqidLt0W7fxbOVKoVehUHvUReU/nHZDpvGS4O94VJhYHBPHoINPAcUFr/gNffGZf2cilJsrf+6uyIp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2018 05:16:44.1222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb6c80b-4554-45a1-fede-08d5fc24f784
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2504
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 07:27:02PM -0500, Gustavo A. R. Silva wrote:
> Return statements in functions returning bool should use true or false
> instead of an integer value.
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Looks good for me.
Reviewed-by: Huang Rui <ray.huang@amd.com>

Add Felix for his awareness.

> ---
>  drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> index 5d2475d..16af9d1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> +++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> @@ -62,12 +62,12 @@ static bool cik_event_interrupt_isr(struct kfd_dev *dev,
>  	vmid  = (ihre->ring_id & 0x0000ff00) >> 8;
>  	if (vmid < dev->vm_info.first_vmid_kfd ||
>  	    vmid > dev->vm_info.last_vmid_kfd)
> -		return 0;
> +		return false;
>  
>  	/* If there is no valid PASID, it's likely a firmware bug */
>  	pasid = (ihre->ring_id & 0xffff0000) >> 16;
>  	if (WARN_ONCE(pasid == 0, "FW bug: No PASID in KFD interrupt"))
> -		return 0;
> +		return false;
>  
>  	/* Interrupt types we care about: various signals and faults.
>  	 * They will be forwarded to a work queue (see below).
> -- 
> 2.7.4
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
