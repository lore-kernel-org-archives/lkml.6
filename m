Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4682DC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA4B21F41
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="eWAkbUIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA4B21F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932180AbeGCUAB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:00:01 -0400
Received: from mail-sn1nam02on0063.outbound.protection.outlook.com ([104.47.36.63]:18259
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753109AbeGCT6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBXuPmpVEyj/ZvVUhsd/bKbvZi/g3TYsODv1xuLNo7s=;
 b=eWAkbUIrt5vtnttYsdgbFzlKErW14BbNDXeRrMpvMLOibPHYs+vxBmJLTBztDfZi2XXrXBYeS6SnpuL2VJtu/bJbEpPLEbMOlkMNNU6DH7/erRcfuDSzOHvmpFr6rmUg7W5saLlm3f9lHs325T4BzInNPoAz1z8881ysIbF+Sa8=
Received: from BYAPR07CA0028.namprd07.prod.outlook.com (2603:10b6:a02:bc::41)
 by DM2PR0701MB1342.namprd07.prod.outlook.com (2a01:111:e400:5119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Tue, 3 Jul
 2018 19:58:34 +0000
Received: from CO1NAM05FT018.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::207) by BYAPR07CA0028.outlook.office365.com
 (2603:10b6:a02:bc::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.20 via Frontend
 Transport; Tue, 3 Jul 2018 19:58:33 +0000
Authentication-Results: spf=softfail (sender IP is 199.43.4.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 CO1NAM05FT018.mail.protection.outlook.com (10.152.96.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.930.2 via Frontend Transport; Tue, 3 Jul 2018 19:58:32 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w63JwMsB006991
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 15:58:31 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 3 Jul 2018 21:58:42 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Jul 2018 21:58:42 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w63JwPio012369;
        Tue, 3 Jul 2018 20:58:25 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w63JwP6C012367;
        Tue, 3 Jul 2018 20:58:25 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <pawell@cadence.com>
Subject: [PATCH 13/15] Introduce Cadence USBSSP DRD Driver - added usbssp-pci-of-wrap.c file This file implements wrapper between PCI adn platform driver.
Date:   Tue, 3 Jul 2018 20:57:57 +0100
Message-ID: <1530647879-10007-14-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1530647879-10007-1-git-send-email-pawell@cadence.com>
References: <1530647879-10007-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(376002)(136003)(2980300002)(36092001)(199004)(189003)(305945005)(107886003)(105596002)(4720700003)(106466001)(6666003)(50226002)(26005)(51416003)(4326008)(356003)(36756003)(48376002)(5660300001)(8676002)(76176011)(186003)(2906002)(50466002)(69596002)(53936002)(47776003)(97736004)(68736007)(8936002)(14444005)(81156014)(81166006)(336012)(446003)(478600001)(2616005)(316002)(110136005)(11346002)(54906003)(42186006)(16586007)(426003)(86362001)(486006)(87636003)(126002)(26826003)(476003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0701MB1342;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT018;1:VYS7INGwtkeyaVPSEc7atxtrkPIKKFjAtnZMkMghPfsj86JQIdVXeOUYKl1Fca8pqhaW0T/ZDyrpUurqNVM0ULxodSU2Ctb0i3zV35LgYi3RFFaJLnSYJrM4n94Og92+
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51febba2-3256-46c0-8edc-08d5e11f5b1e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM2PR0701MB1342;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1342;3:G8JihGE8bmmG8f6mhFh7icFpW5Jg8fJcQZL3QMKUqVUF19+7bRKzwdgChJ00OGE4uAX62JmLooQzUNWZ/97QI2vYF5eOBndw+k7g35KPwAWP0PStwqE0x725HLzntIyJoUd6cSmztvkZlbV5iMOuJW5T5mgDD6RkZH4r/E9IHFUGFHNV959oxHQmNvV1wgfEzDYh/mqo3UwT3fWq1+tsS5k+a0kXnQSjQn5kKXsNGPXbuPcb88aXoO+FyU4M8Do6u1czqP97dURsNBJe/ENdg/Du8d37U+8XEubwrq7vqmcDAKPzXSJ+0C4q7PVHVs50PxDuru0y/KmZRFcHsKl03A==;25:TlM8g9MxgnzprJMUPOmp8fRRfb9LB7JLQiQLfxKlji/Z+TnFXE/WJZPIqDUwtbRpgm6jg8UPwNy5xKJ2TeJs/tNaX6DdqiyNUiA55jf7yvZwSMOjv/2mBMRXv34Bv1BJY3AtzHNwlbFbZd7Kw5BSCsAVNnfR2XgsQMOAyIY0xrtpdTyQVGwCwJnVFlpvs6AK0Z04tyQ/+JDwLKNRBe9WPS/UtpCxtaR2+0Fweh+25nePeGht2BFikzXSng1wEdxGrZJ2eU/wc4nY1/0uJfV6ui90+HNy7696INLsdvxvpEBMBVBf2VcIvucWG7eI0/MZnkZGF9Xct5ShVr1ykGt+Fg==;31:g5m2Ph1+yfK5sMtusVFjTvglUYoP+g6FOxQ2+3cUxFhAuQn+DuKP/J7gIXiR0pZg9sFxmFa/eNTegM9ze0Pe6bh+ZbUDrXnV2kemBirs/swPtIaf5ewkfNvV5o/CaC6hCkrmQwwKSNBL/XLc9I8CvDYg4d99qxq7RyNExteD3D1+doIi3O8UpY7VMS1ioe+KvKrmWrRi1FCKIjWh8FwNJRLMdEGo4n8Apl0TPo5GXoI=
X-MS-TrafficTypeDiagnostic: DM2PR0701MB1342:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1342;20:MMIXrMEsPWisAW1zwOsRnN7+GcEDInUM6GsENVtjZgXuUkx7LPEnkCc/J/3ya/ya7+MU2rOv0B27OJg8rR8m5gOuRtO5LB7MERDDE7JKMGq6CvqSZzngm6eC0GGrDOUmVpiEL5hBeWU/cljxABgHlS+YJxnP68Fh+osKxXzAJQ5TUfrFb6M0Pa3/jqKnA1fhWCndFZ97mrFuJvhY0UvzXoNlVz+3gFVVc0lmqHBw+qukAKPUxLgzY+GWRmGoh+ulxX1tKhQ1OvUKdPXf1D7pTRSrQ72anQzSOBEJ9JQT2At66LTR5iYf8hLc1hVrPTxm0sEjvejc7xg+YDNdGXHtVJGGqP5tNSiZwwQQZhEI+iEmPMgOgwne+nOcSGyGCSf8RO6aXbnMWKZ9hPFiCbkQI7zJkq0CXts7F0HL9DddMiGGYGZUdQ4Esb0sorSLeW0wmoC5Dz7QJE+B/UEwMq2Fa0HY8W/tVm3ReYZ/3XDsqssFjZgXLUQBdmInfN+Oy8Gq;4:s86JhTtqFE0gOCloXug9MDLmqxi0vZH0EkDWr6H4E2aBie5QkFoHAfEBHGcn3GF5LuhY1uQXDS+EM7AC5VbC+0qGXFp8lKntt/1Ri1+9YE/5xJZ7u35aQWT/6uMziNYrlNCFs13cYZe2aCo6vA0pqoe8BUDEKbX3vy9xyUfKruPFcnX3FpYzTAh2h8RzCxFNP2TzAqtF0POqGjPphWMNSObl2IkRyPmkB4KcfDLFqUSCHP4/keDUlAZUeGOExlCM256pvpzOBV6Itvm0X5KBYBDkslFesbL/2pdmwYOXoTLfokne29eGpLxnFs/TFrFn
X-Microsoft-Antispam-PRVS: <DM2PR0701MB134244E89CF6D593B5765BD7DD420@DM2PR0701MB1342.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM2PR0701MB1342;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0701MB1342;
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR0701MB1342;23:LGMWt41IrzkgJ52t+eh0bxkdrWSV5yk3TkR12YJ?=
 =?us-ascii?Q?8g+cuJ1oWVlQ4whl1pscFZ6fsOyBqCpGyLr8O7ZZrIfOtAV5GbVuFBI0tZJL?=
 =?us-ascii?Q?0fgab2oY5W9i/EFUOs6Iv7ro9Wyv4AqwDwQA79ti+hK3OcAFKXzYIy+stkiI?=
 =?us-ascii?Q?vSUcfaZbN2tQIhyIg+pQY3bMB0AzWr2Gea/tOzoW1Df8l3meAsf6AgpQLSNf?=
 =?us-ascii?Q?OKPDu9xVDnW97npI376Vkr5hPHWFjOwenE1p8SrHytIERjaKOFKN1ZGVLG2k?=
 =?us-ascii?Q?1YFMSHLJrejRjj9bsoQH2WX9VISvYyN5ZFWeVxVGBBdb9voFjZBYw3HVfQ7B?=
 =?us-ascii?Q?EWAsOSjb3+VG0Vc2W0Tha0FfqH6TfQE9oS1IG6PufxFiO+TswnOA9G2SUiy1?=
 =?us-ascii?Q?A0dIt09jUW3FHgOr9uvWE8RUPpER8jQHtz5nkchkNnY6BSlLqU0zjKHRUNu4?=
 =?us-ascii?Q?BhjYLjJeJlaVT64kzN77wlYVWwnLi9UqWAI/92Ku5z5FdBsRA+FNUELbYmJh?=
 =?us-ascii?Q?/ushkfgSnZmbRwasb/7rTMbHvP0Da8lVq9WZ8Sf0MjBjbtAZIM28pOBkiEoo?=
 =?us-ascii?Q?L+C9fiMJBFe4kp3AL3wOYWuAU1lA2JBKQGCTTkMfxhzlpCDOVWNEpVzBqQWK?=
 =?us-ascii?Q?1lAInYAHOR7SLLIpZe6UYMHe4xj0Si9IkybG8TDLEdPUTkfOP+dGkACk24G0?=
 =?us-ascii?Q?XK4ETMxnGT94DwleXaig+745jHnXIX7EBSxpq3IxR9651HxI3OXQJhg+p/IZ?=
 =?us-ascii?Q?q9fPJd99lzc2dxzCEdWgc1tJEOOH/DSeQM6EeB7Iubs7LytjqR9GVY7+G5qS?=
 =?us-ascii?Q?H57KzRotrjtMSeK9B1ptm4Vlt61puSN9tqZlofBScwgnTDoM+VS0YVbZEHof?=
 =?us-ascii?Q?LA5rQDczmwova+2dmIMGwevVLHGc/hJe0lZTXCjNGbTSk84Qi9kK8jla2JfR?=
 =?us-ascii?Q?mI26bxFYX87mBrrZFBHYXY179Ep/iMcfIyBGVoXNUMYsLDlcixvaxu3Ilv21?=
 =?us-ascii?Q?5BL7J+iGh2P2W8Lm0YGFcuET8PgN/567/uhvnFsMBd2utlXbZhMKEDir6jbt?=
 =?us-ascii?Q?5FFFbG8WG2/lXvKTPPGDHg8+Ixfw3Pi4x6XPOR5InUsteYUbvSVt2stBD3wA?=
 =?us-ascii?Q?y/U0JQsmPyE2kxoDVfh8xjFueEbyvVi9zkZSSHZDAK9KLL0lRgLT5lj0c3Vp?=
 =?us-ascii?Q?IlwzC4iLy+rt/Bl3UpRaTZN6VLmAvvSbQlNcb7mGZnVKEwwOxujmhLK+1oQ?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: UoMJdlJN443JU0U6u1Igl7NUqUcZh/0yAYRHyUlvHJQBVyuogVlWpMjEta9r4IpVp3v9ig3bmwnAJH2AbaSGLrct44lbxLVGMRGBV50cSU6iCK3PHgmwZFjpm7hyGyG3usNlIUJ4wddZW7gSEI5rqs+DhlsT5ROMLGElQSJ0PFVxdwJSvi4MxtCVIZ04/WVLb7son5OkOV5QRgpF//OzQe6kSgrY9Z+KVLVtEe3Bydva1rrUXa9Fg6zS0DByncW8LWeAzxSuWB/H5Q3FvOGyHrTKnG0vBUKcEUMYpNaTfj1yq5rE18sTr3PfTTULWyRe6S+6bz1KLa5lLSn5RdOI7iy+P6+R88wOSj8uKG71YERjOvwL2oUDgznVWJ/ZBblb6gkaGKqG3vWgREf7boj1BA==
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1342;6:IeLtMyEv8jye793FhZWShPHJwNobFIWd7OUY3D9uE0CcTqVH2FBkkAoBEsSUb8T37OgS5WIqD73CcDy2PeYOfI0OzbTggtU6yNNNXX3/fwC4WnWbKajT/GqmRUBpQWtkJU1DaSZmuBEo0TlrFJrzaUFyuQBHkmcFJ4v6/T+7aRCekkXxl1YwylF7eUZ6mOfg4xq3oanQasXKB2HGajMTk+87eanwCo9Nk1m6brXqA/7SuMoKtjiq1OpXL0ghF2MIDupsUMJsyM5njLAIm6COvwjvJRPZWuDjSiXtAcUq4MUekQf6yDKpXbYB2uqVPbS23diTGAy1hEfJRytAGgcnBxjyl75szOB+nBHrfUAOd2yN6r3pOxE/QxZvgm0clJWfBPa8uNsds3V9wubEmcVespfpGKBnGMwLh+/q/0h6l/cVNZ2WLOlD6+lQtt6KnPkr0g32QL6eeyOanbxITFOMbA==;5:0gC0AaWVswpv9AHXL42jIFSZcz8e79+e+aCoH1YhpImJqq4GI031iricAgaK+OqgUZrZtbl2z/SjbiFZSs9lqBA6uXix19p1lRc2fyegV8KuYlF8h/iaa64/n9wcaNd8JSl2S4lDehAd5y0F6VA/1NEpOIQ2kUnbZ90rEkOXVlM=;24:bQmiWIYmCPDGX19oDSy2m8Bw8eIda7+McQ5g2iP02R4ma6nD8scj1cS0+aJ4Yzl3/E7Z6ylWgmdPb99PxTBGymJD1sAQYBluXJNGfuIU68w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0701MB1342;7:qGj/OOqF0mDprsQrgu7fQhEpZc5m4SAQz0/Huy2suOWeJsJA3hMvK93xMVMPup8uWtO/0Tih0mBWEIa04SSaeavr1UVpUiVgTk5l2/LJWsAvM3wFHSKSf0ff4oCzi9J/BXDuMAdVZjyetmtR8f4zjJ840SasehRt4l4fgZjmlmUw9etV8hqdjVXy0kRezFbGdvLKiEMPBY6UC63z4Cg2YuG/fZmYMyxvHKRNAy9uGALn9/2nYrTiOb/bliX7tgtC;20:Jln2uFbNUq+idrZk5q1p9HvxJbPHAUBNRHVsHGIXsF0Ykh3sziZu/0QmY/31eORSpPUvcysyt/4JzqSdlrr3ZC+BQNZ3xRfI2Kt2JIPWbpAUg0QOlab7SQhvvSyUQ6XQspFCqNtoPYHpzJ7NpQkTZMfKBsw3apYXTGR3YF5iR8o1/wevjPTPMGsjcfabHsYW19IrT5Ii78U9kLddX/po5bnLbSV1lau76wozYdfLBW6u5A0t0gFLGrIf9WXtQxRq
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 19:58:32.8789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51febba2-3256-46c0-8edc-08d5e11f5b1e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0701MB1342
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Laszczak Pawel <pawell@cadence.com>
---
 drivers/usb/usbssp/usbssp-pci-of-wrap.c | 229 ++++++++++++++++++++++++
 1 file changed, 229 insertions(+)
 create mode 100644 drivers/usb/usbssp/usbssp-pci-of-wrap.c

diff --git a/drivers/usb/usbssp/usbssp-pci-of-wrap.c b/drivers/usb/usbssp/usbssp-pci-of-wrap.c
new file mode 100644
index 000000000000..a8511f062133
--- /dev/null
+++ b/drivers/usb/usbssp/usbssp-pci-of-wrap.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver - PCIe wrapper
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+
+
+struct usbssp_pci {
+	struct platform_device *plat_cdns;
+	struct pci_dev *otg;
+	struct pci_dev *hg_dev;
+	struct resource res[5];
+};
+
+struct usbssp_pci usbssp;
+
+/**
+ * usbssp_pci_probe - Probe function for Cadence USB wrapper driver
+ * @pdev: platform device object
+ * @id: pci device id
+ *
+ * Returns 0 on success otherwise negative errno
+ */
+static int usbssp_pci_probe(struct pci_dev *pdev,
+			    const struct pci_device_id *id)
+{
+	int rv = 0;
+	struct platform_device *usbssp_plat;
+
+	if (pdev->devfn > 1)
+		return 0;
+
+	if (!id)
+		return -EINVAL;
+
+	if (pcim_enable_device(pdev) < 0) {
+		dev_err(&pdev->dev, "failed to enable PCI device\n");
+		return -ENOMEM;
+	}
+
+	pci_set_master(pdev);
+
+	/*
+	 * function 0: device(BAR_2) + host(BAR_0)
+	 * function 1: otg(BAR_0))cdns3_remove_roles
+	 */
+	if (pdev->devfn == 0 || pdev->devfn == 1) {
+		if (!usbssp.plat_cdns) {
+			usbssp_plat = platform_device_alloc("usbssp-dev",
+					PLATFORM_DEVID_AUTO);
+			memset(usbssp.res, 0x00, sizeof(struct resource) *
+					ARRAY_SIZE(usbssp.res));
+			usbssp.plat_cdns = usbssp_plat;
+
+			if (!usbssp_plat->dev.dma_mask) {
+				dma_coerce_mask_and_coherent(&usbssp_plat->dev,
+					DMA_BIT_MASK(32));
+			}
+		}
+	} else
+		return -EINVAL;
+
+	/* for GADGET device function number is 0 */
+	if (pdev->devfn == 0) {
+		usbssp.hg_dev = pdev;
+		//device resource
+		usbssp.res[0].start = pci_resource_start(pdev, 2);
+		usbssp.res[0].end = pci_resource_end(pdev, 2);
+		usbssp.res[0].name = "usbssp-dev-regs";
+		usbssp.res[0].flags = IORESOURCE_MEM;
+
+		/* Interrupt resource*/
+		usbssp.res[1].start = pdev->irq;
+		usbssp.res[1].name = "usbssp-dev-irq";
+		usbssp.res[1].flags = IORESOURCE_IRQ;
+	} else if (pdev->devfn == 1) {
+		usbssp.otg = pdev;
+		//OTG
+		usbssp.res[2].start = pci_resource_start(pdev, 0);
+		usbssp.res[2].end =   pci_resource_end(pdev, 0);
+		usbssp.res[2].name = "otg";
+		usbssp.res[2].flags = IORESOURCE_MEM;
+
+		usbssp.res[3].start = pci_resource_start(pdev, 1);
+		usbssp.res[3].end =   pci_resource_end(pdev, 1);
+		usbssp.res[3].name = "debug1";
+		usbssp.res[3].flags = IORESOURCE_MEM;
+
+		usbssp.res[4].start = pci_resource_start(pdev, 2);
+		usbssp.res[4].end =   pci_resource_end(pdev, 2);
+		usbssp.res[4].name = "debug2";
+		usbssp.res[4].flags = IORESOURCE_MEM;
+	} else {
+		return -EIO;
+	}
+
+	if (usbssp.otg && usbssp.hg_dev) {
+
+		struct pci_dev *pci_hg = usbssp.hg_dev;
+		struct platform_device *plat_dev = usbssp.plat_cdns;
+
+		rv = platform_device_add_resources(plat_dev, usbssp.res,
+				ARRAY_SIZE(usbssp.res));
+		if (rv) {
+			dev_err(&plat_dev->dev,
+				"couldn't add resources to cdns device\n");
+			return rv;
+		}
+
+		rv = platform_device_add(plat_dev);
+
+		if (rv) {
+			dev_err(&pci_hg->dev,
+				"failed to register cdns device\n");
+			platform_device_put(plat_dev);
+			return rv;
+		}
+	}
+
+	pci_set_drvdata(pdev, &usbssp);
+
+	return rv;
+}
+
+void usbssp_pci_remove(struct pci_dev *pdev)
+{
+	struct usbssp_pci *usbssp = pci_get_drvdata(pdev);
+
+	if (pdev->devfn > 1)
+		return;
+
+	if (pdev->devfn == 1)
+		usbssp->otg = NULL;
+	else if (pdev->devfn == 0)
+		usbssp->hg_dev = NULL;
+
+	if (!usbssp->hg_dev && !usbssp->otg)
+		platform_device_unregister(usbssp->plat_cdns);
+}
+
+#if CONFIG_PM || CONFIG_PM_SLEEP
+static int usbssp_generic_suspend(struct usbssp_pci *usbssp, int param)
+{
+	/*TODO*/
+	return -ENOSYS;
+}
+
+static int usbssp_generic_resume(struct usbssp_pci *usbssp, int param)
+{
+	/*TODO*/
+	return -ENOSYS;
+}
+
+#endif /*CONFIG_PM || CONFIG_PM_SLEEP*/
+
+#ifdef CONFIG_PM
+static int usbssp_runtime_suspend(struct device *dev)
+{
+	struct usbssp_pci		*usbssp = dev_get_drvdata(dev);
+
+	return usbssp_generic_suspend(usbssp, 0);
+}
+
+static int usbssp_runtime_resume(struct device *dev)
+{
+	struct usbssp_pci		*usbssp = dev_get_drvdata(dev);
+
+	return usbssp_generic_resume(usbssp, 0);
+}
+#endif /* CONFIG_PM */
+
+#ifdef CONFIG_PM_SLEEP
+static int usbssp_pci_suspend(struct device *dev)
+{
+	struct usbssp_pci		*usbssp = dev_get_drvdata(dev);
+
+	return usbssp_generic_suspend(usbssp, 0);
+}
+
+static int usbssp_pci_resume(struct device *dev)
+{
+	struct usbssp_pci		*usbssp = dev_get_drvdata(dev);
+
+	return usbssp_generic_resume(usbssp, 0);
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops usbssp_pci_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(usbssp_runtime_suspend, usbssp_runtime_resume)
+	SET_RUNTIME_PM_OPS(usbssp_pci_suspend, usbssp_pci_resume,
+		NULL)
+};
+
+#define PCI_VENDOR_ID_CDZ 0x17CD
+static const struct pci_device_id usbssp_pci_ids[] = {
+	{PCI_VDEVICE(CDZ, 0x0100), },
+	{ /* terminate list */}
+};
+
+MODULE_DEVICE_TABLE(pci, usbssp_pci_ids);
+
+static struct pci_driver usbssp_pci_driver = {
+	.name = "usbssp-pci",
+	.id_table = &usbssp_pci_ids[0],
+	.probe = usbssp_pci_probe,
+	.remove = usbssp_pci_remove,
+	.driver		= {
+		.pm	= &usbssp_pci_dev_pm_ops,
+	}
+};
+
+MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Cadence USBSSP PCI Glue Layer");
+
+module_pci_driver(usbssp_pci_driver);
+
+
-- 
2.17.1

