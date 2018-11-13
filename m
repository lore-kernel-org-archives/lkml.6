Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38827C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61D822419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 05:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="cWubBdid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61D822419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbeKMPaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:30:35 -0500
Received: from mail-eopbgr730101.outbound.protection.outlook.com ([40.107.73.101]:45808
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726612AbeKMPae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Y2pqqLScpDWourPdg5Vkh0UrFcd5aOyLwQDt5TSC6M=;
 b=cWubBdidw3hDgkrvMpxeK4PuzAnJXHDuiCW82d8rciXGe85SivJHVxw7+2FquuXMlAgcur1+J+LzZXc4BZmxNA77w/MHEF0msCLkxgESJd///9PMzlDNxyX/sjaui76phoFZx1ukoechLS/5MZU+1dbDwJ5ZyURBGTp2JYc7pKk=
Received: from DM5PR13CA0044.namprd13.prod.outlook.com (2603:10b6:3:7b::30) by
 DM5PR13MB1417.namprd13.prod.outlook.com (2603:10b6:3:123::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.12; Tue, 13 Nov 2018 05:34:05 +0000
Received: from CY1NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by DM5PR13CA0044.outlook.office365.com
 (2603:10b6:3:7b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1339.11 via Frontend
 Transport; Tue, 13 Nov 2018 05:34:05 +0000
Received-SPF: Pass (protection.outlook.com: domain of sony.com designates
 117.103.190.42 as permitted sender) receiver=protection.outlook.com;
 client-ip=117.103.190.42; helo=jp.sony.com;
Received: from jp.sony.com (117.103.190.42) by
 CY1NAM02FT044.mail.protection.outlook.com (10.152.75.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1339.11 via Frontend Transport; Tue, 13 Nov 2018 05:34:05 +0000
Received: from JPYOKXHT104.jp.sony.com (117.103.191.51) by
 JPYOKXEG102.jp.sony.com (117.103.190.42) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 13 Nov 2018 05:34:01 +0000
Received: from JPYOKXMS113.jp.sony.com ([169.254.3.149]) by
 JPYOKXHT104.jp.sony.com ([117.103.191.51]) with mapi id 14.03.0415.000; Tue,
 13 Nov 2018 05:34:00 +0000
From:   <Yasunari.Takiguchi@sony.com>
To:     <narmstrong@baylibre.com>
CC:     <mchehab@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Yasunari.Takiguchi@sony.com>
Subject: RE: [PATCH 0/2] sony-cxd2880: add optional vcc regulator
Thread-Topic: [PATCH 0/2] sony-cxd2880: add optional vcc regulator
Thread-Index: AQHUd2G15+Kz560TxUaxmcNzyN9QhqVNMVTw
Date:   Tue, 13 Nov 2018 05:34:00 +0000
Message-ID: <02699364973B424C83A42A84B04FDA850B32C810@JPYOKXMS113.jp.sony.com>
References: <1541681410-8187-1-git-send-email-narmstrong@baylibre.com>
In-Reply-To: <1541681410-8187-1-git-send-email-narmstrong@baylibre.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:cf8:1:aec:0:dddd:6f26:e2ba]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:117.103.190.42;IPV:NLI;CTRY:JP;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(396003)(39860400002)(2980300002)(438002)(199004)(189003)(13464003)(86362001)(6916009)(16586007)(76176011)(7696005)(86152003)(6246003)(5024004)(33656002)(97756001)(47776003)(2876002)(55846006)(2906002)(50466002)(106002)(7736002)(6346003)(26005)(2351001)(106466001)(55016002)(336012)(7636002)(229853002)(305945005)(5660300001)(46406003)(186003)(77096007)(102836004)(6116002)(53546011)(54906003)(316002)(23726003)(126002)(4326008)(11346002)(476003)(72206003)(246002)(486006)(8936002)(478600001)(2900100001)(356004)(107886003)(426003)(2920100001)(446003)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1417;H:jp.sony.com;FPR:;SPF:Pass;LANG:en;PTR:jpyokxeg102.jp.sony.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT044;1:iP0dNTOlLPhQu2TbzBE6onSM0nGQYVZLhuDoolvOi1O82XSBzWxLZNy9+YvWawIUzqnFzfJ0rnUeDEs+SBVeVB02oTLh8LV0oryWgz8MJ0LHGFIsmdKsjFsIKTtj8yz+
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81486bdd-9b34-42b7-5d18-08d64929a099
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390060)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7193020);SRVR:DM5PR13MB1417;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR13MB1417;3:upiQIulylM4DZC0gnsd5tCj3Sowp7BVZhvzSfnqR4MQwgFm5ZLQ/rDaMsOjyZ74jKudjoGcEn4NhinWsxUm5UGx6+k/A9k2S78m34oITTfK8mMCiHBo2clN6kX/++zfWQURFMghovX8FhhD9b2N9ynlQuDTruhs870dzIVGGG4w6dDpCFGBI2KSDR42VxwuZgDLOKFMbhZCTJsP0cnWuRAKgN9WOrORGWZeNGyB7rVu/KScvLPRjhzgDoUPx0ZJFuvBeKxsFjWtmuQBYABMgHTTutvCEARF9reSCRB4xms+V6TE05cyskhJKcsvagGc7Y7azDfa8vw0nqvWL8SU/yiB0kfqyKv71uusLZ2wVz7A=;25:+ON+TZP0QjtItl+u4YVDcxp8wTJPURhortRsIrgAeDMNBGUsNB586SAftgwGYr/VOfvhBKydgPH/EgWy3HR3mWq8nguQIU8ikV/kicx6k7T6RiYorVjoMrnlti3r4BoNWpg8N1+Qtwiv29xXoAbOdH3w3PgQMzrkJSlpZ8RuEJbVZS3fLwj87LW7UT2jVsZJ3zdo/Yw6mCacGXXCaCVoVYe9/cCAKPQ9Ut39p69PD+pMBMOtoO8XcNqV5vQIWqvvNOVI0MqeHak4OYKkmKWMsKjibbFWGMvPEaK+yFvIK6EL0YSIdY3EybWC5P6mgQUeO0cq4KL6IdJE0b9daEOmxg==
X-MS-TrafficTypeDiagnostic: DM5PR13MB1417:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR13MB1417;31:x7UvOpbaMQ6a1+bhUiDnZfeakKzFnYMzPN56PkiaPGCkJC2anGV4ZfACmfsEidWq+RhSbUkjLmYQSNnQKn2NvajuvLBehM+kGb482ljhOBvK/+Q6hnkh0fdxpoMmOZV551PtFyvfGDms0WGXF2M3OFLcHDenXTl9zgOgIWAJLhOBQ2dBEzWa6PLDdPuHgpRcKUUR6LX/Z9l0RHimxvOzhrxGaAtdVTPQgFKxYzeqPuo=;20:jw//HzirmN/kdeISPoAKKk/iCNBFQkgN7P0y8VuWh2l2yQTUUs+AHnJNrrypYKjJVhtyVUx4Who3kF8HMrDvIyxIzNYEoOPP+Acu/GAxfAUVwkdoxeVWchlKEExnROZ/Y8sEcFDdl8TjsKbE2/qwYkvOf0b7db8ZzizUntx3F8Kz49LOFkOMnTLgsOCPkEEE13S05QEQboM8kwV2ZBt0UnZjtgu0/6AyWBMmtbH3rGpmwz4g3SlZrq4SDFz2hKFQVs2P7HwKU2rf/5JcTMS85vGSbj4QbBIsKC6EGOySqTYSdlLTU/jE0fIipma8/Z5X2sG3/dRaoIhF2jc006fuVBrBMBbLzMRLpkzLXvkWoMDSaRImK4KXB2rGkVmpcNsCqr4IEXue8VNs7iOtgLRxq3HXETyNPBk5YTW4DWNH2xXa8Zwg8DVCK3RJ68l+mvauVxpmrSFwYjtmoKTlG6X8mbHm6g5LCfeLMiXb4r8YOKLf9rLVO2FuJu0yLKOw4ufy
X-Microsoft-Antispam-PRVS: <DM5PR13MB141768145561DB0E5310F592FDC20@DM5PR13MB1417.namprd13.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(3231406)(11241501184)(944501410)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DM5PR13MB1417;BCL:0;PCL:0;RULEID:;SRVR:DM5PR13MB1417;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR13MB1417;4:QVaelF1qLmiMzN5qk4eIjXvtbpY7thxF5KMN77kZI4eu5mPqEWC2OEK1GY20KhitC3EgjcvX28RTNjZRRR8mvmOsi3ODaYW5/uYUGcuZVz/uweXwJezrmFwHK/wseaLrZ/ewb7ZGEsVuKNe+MK9Qa4Dvo+LMmm4CLfWK6nrFMRObO7OXxHl7kpRKIhx7+P00N3urgqDEm1YNTGa0pNWeOWE8DOLsPb5XjgM1CK6ni2oaxrqsRW42eCs/K9y4NpeoHYBzAP6uVu6ZA3c1xmq5Bw==
X-Forefront-PRVS: 085551F5A8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR13MB1417;23:Yjo6hW91tlOHMThGJoUVoy95ebCToCvdTHUb5YXB3?=
 =?us-ascii?Q?OoCmCSaUaCUcOQvML6vAzIQi4e7CAo6HWH9m/W8At7TgtIIpPay99ha7/k3g?=
 =?us-ascii?Q?aDMqP/87Vp0pVKPVlXW9M/j3th56TzNZF16DsMmT4kFsfytUBu9A5Z78062b?=
 =?us-ascii?Q?Ld11RJoNHMJVrWjWdtiakxzkgYb/MsK/AnPdQ2CdFPGPyse7P+NMdgiGUy8p?=
 =?us-ascii?Q?HzdYro+J8J34jKXjw7rNqNW9HBIOls6PhwP7n0tLtiAoxMKRkpE26TQw2/U+?=
 =?us-ascii?Q?NVm/ydE58rOAk/uJsB5vhktMZs2nxp1oqFcbFYyik29f0sDJUjuYRoFZJI2L?=
 =?us-ascii?Q?YZmhCmthxZf99pWzW+OJ7PmOPcBnP2WxIjGDnqzkNHb2wUorBh+EmCAKic1g?=
 =?us-ascii?Q?Xzo1mj5Ax1N7s2mvGZNaaLKT+ACT9dE4dhYBcIaZSHi+LuQ2/uyijElgAbV1?=
 =?us-ascii?Q?o6KPoUIIbPK3WfrYCvuW9Llv4fm0jEhSmzyuxwLrGFXGUPc4k+/RYkjke6OM?=
 =?us-ascii?Q?T93UlCTQF+nIH4V/jKcoMaVLtZZ0c+rqVC5pcJ2ZU9lcPwNCYq9oqxp7Z48k?=
 =?us-ascii?Q?8Wq7Vm3veVhv5+kxysm7FYN+6f8HlcMSL68UMC31Fw2kxOhg502lRXY14Jv9?=
 =?us-ascii?Q?vg3QcToIh1yv8seIbVoWSsOLaj+tDz+FXwMVTwQwth/t97k/GuDZRi8M21QH?=
 =?us-ascii?Q?QCU2sCV5e/shYgEXbt2dptd7y3VyXNm8U6440sU6Wt1ZLRraHekzWR+rz3BZ?=
 =?us-ascii?Q?RHEuH6n6f0c8Rrn/epwFskTCCaeH5EcB7aX5RWPoNUNYs+nx9UyAcd0Tmidn?=
 =?us-ascii?Q?8MyKNmaWypJpVXKld+DNnhbFT+66o4s7O+8DhJQCb8z6zUjnZ1yaYvtmU4iL?=
 =?us-ascii?Q?O5rCLuqzJsCRZJfGC4trb/UYu5p+kvDWC+Ek8N4Z2VhqxQA3Zb3SDM9dt5/7?=
 =?us-ascii?Q?RwK4rPexp75ne0qFgW5w//6MhY9qvf5d75IqEIuOg8rPD/wgnRDZwFs8qNwW?=
 =?us-ascii?Q?Uek8+pFwLnrsmq83fu8//E871i/cc/LX/jAazsf1iKIFmZ0uydS9DxPXFYjT?=
 =?us-ascii?Q?OQpO9DXm49tHAJ6jSCKFJ9J6c71R8fn/xLniXWNr8Hk+F1rm4CSu9ilfZIdF?=
 =?us-ascii?Q?pvSTsrLym1CNCKrDaFtN0ZaK719vCaO5qaoQI9L9DJyC4j7aG3AwasJta/yA?=
 =?us-ascii?Q?81MInvLK11xO9ACfwU4OtzU+yyr/vdfn51Ytz0rieMQL99F2WkDkHGu6dJhh?=
 =?us-ascii?Q?TRGXS3XtM4/zAk5G2qXuyOYQ4Bfx3hnTshrOnn5tscqifk5aSCbWwbE6iQxH?=
 =?us-ascii?Q?uTWVcAldBnQX7fAynaGM9eHk4gRVNX9L4KhxloWmhvesfpONbREUBDVKmTUU?=
 =?us-ascii?Q?1TdsA=3D=3D?=
X-Microsoft-Antispam-Message-Info: Mk24UnTtuEqL2mSY0sp4onjokBdRPfbZgpf4g0Ob6AL8WABznAikyQjS59xqLMcAE8HFE+sJ8isyNTQ1SGzccHQ37SpS4ZC9jkW6smgWJIEUg4pfIDLJ20XV0deP/WhAKts/4vtRKniVlIcuErRuZMn2BL+Ih8OsBm4+7hddPsSsVGTWZNPH6/w+WxiQV2wI3zynN6vO5xD9YiiCx0eLwIweBkU2dCcBM8m7MAz/mzDGInRHR/dK9SkqVhiAtiMpIDVn2rIL33D7F8yBS5i4fohOCPN+ZakDC16L4UC2SxDronjYE1NkmUFOSbg9+1+q5HfGaZFaNIIvjEcjwTMp3yc/8HEqzLkRNL/vZko+I3Q=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR13MB1417;6:xwG6pNTCEvzF/HlgcHhLbqJsIJhHlJLaWUwD0gJRPBeVUIX2R1+s/SVAfK7a1efiYTib89r4J60DglUL2mpXQAUhRmM36pVfO+bQIufNJsFxvY8N99rn05ltzCddMkQUxBDV7fKQfXW6TgEIhfIT4qc8U4udii0287n8zmwuuBNcusefO3m8jNtxEx9G2fWvY/rVpJS8qiRAxxsezB7lTHg1R96BqAXx6+j3hxQJYLSSb5sYfSW7V5dut4U/atjc3DEIEIpYjOxPULJm7ULvi/qNuQZc5V0bU7qMDcymzrcRBYmrjTlp0bmg4KVKUWMLUhMaqTKJWwbTrLqq7FQ6ySNP0C1Wpf0v4jq0HbALlUBRD/5OED/TlDr1YIjzZNBgG8csV+neAWwFVHLGUjNEX73QyujVub4JCPVm4feLlHTjaBfQ8MVopflTDXEBp3DaMXXRqZG44GfavButIHQx5A==;5:nqJuEbyLn2iT9kvzrE/UX0LIYT65TnIJoiHfxdG5JKd3dkmBUpw1rWtnHnaWZnJcR8cPL4DfwZKxpENfIBLpb1ccqq+v+FwyEOhdQeWKbp8EkYP0xiGDyz1lW2TBFYSW0jG5UCEUB3fWRr6hkh/Cjut4ofxsr9pBoYcSlrWdrnc=;7:2MKY9+jZnhNe8nJM5t3cUnMpcp8/GxWlK6HVA8mrwBiNKwcrv1hYLZTZsTjY+xGaE+V6Hmro3j2D/LDD+nezbyVNNypttLUX83NCUMOY5X8OcttkMvqWQLAF5EGJbj0TakdO61/35ID5Pm070ckS9g==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2018 05:34:05.1708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81486bdd-9b34-42b7-5d18-08d64929a099
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[117.103.190.42];Helo=[jp.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1417
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

I am not familiar to this vcc function 
but I check this compile is ok.

Acked-by: Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>

> -----Original Message-----
> From: Neil Armstrong [mailto:narmstrong@baylibre.com]
> Sent: Thursday, November 8, 2018 9:50 PM
> To: Takiguchi, Yasunari (SSS)
> Cc: Neil Armstrong; mchehab@kernel.org; linux-media@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: [PATCH 0/2] sony-cxd2880: add optional vcc regulator
> 
> This patchset adds an optional VCC regulator to the bindings and driver
> to
> make sure power is enabled to the module before starting attaching to
> the device.
> 
> Neil Armstrong (2):
>   media: cxd2880-spi: Add optional vcc regulator
>   media: sony-cxd2880: add optional vcc regulator to bindings
> 
>  .../devicetree/bindings/media/spi/sony-cxd2880.txt       |  4 ++++
>  drivers/media/spi/cxd2880-spi.c                          | 16
> ++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> --
> 2.7.4

