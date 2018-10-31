Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41360C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1BE2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="DAKSYxfy";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="edi12I4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1BE2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbeKABcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:32:47 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:54344 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726720AbeKABcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:32:46 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9VGQN4P001242;
        Wed, 31 Oct 2018 09:33:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=/U3dVzFcGklit3+BSnXM9959P1eK9fQ+c+Qr7DB0BLM=;
 b=DAKSYxfybW+nZbISZ7SvKsFNclS1+w+hZHFJpFv50EfD5G1dPrzOHIkQ28dtCUIYxMv+
 jQjg8dXe9FksuCz20qaXP4zPO+3W+2Dh1h2gmDmhtbWPewBO8YMnioEc7d4ZgWGjZ5Am
 DwAs+jX0+MXWGmfikQa1/KqtDi7reIDSpkQ7yw2Oa2/9UXnWTHSHRMp5c88R7+K5bdWd
 6SGEW7C5Ca9MoW5rnRdq+sHQzsdeDuQxCwjh6lrIgjnD8pjFLRkdlqU1R2lLzyncu3oS
 WzacHcFNGbYgHf3haQIORrsp8Dwh/oRpuH6OdgvjAptf3SbqbXkk0SftGqcCoAQCrniB kw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=adouglas@cadence.com
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp0016.outbound.protection.outlook.com [207.46.163.16])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2nfb6f125j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 31 Oct 2018 09:33:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/U3dVzFcGklit3+BSnXM9959P1eK9fQ+c+Qr7DB0BLM=;
 b=edi12I4pOH7WkwJe4ST9igFHz2yY3jp/znjGJZtF07rMaKvL5mdAtS3kdv85U3IQWLnC+xmZMs1qte6H30FSm0AhBzLrKuPeKQRsovrMWc7PnVtZAW6nT+eHDMVF+MvB1HFxxLgxxrC98MLLyOzWfP2PqNeAoxwtm8GMfL9CXNE=
Received: from SN4PR0701CA0013.namprd07.prod.outlook.com
 (2603:10b6:803:28::23) by CY1PR0701MB1865.namprd07.prod.outlook.com
 (2a01:111:e400:51df::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1273.21; Wed, 31 Oct
 2018 16:33:51 +0000
Received: from DM3NAM05FT011.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::206) by SN4PR0701CA0013.outlook.office365.com
 (2603:10b6:803:28::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.21 via Frontend
 Transport; Wed, 31 Oct 2018 16:33:51 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT011.mail.protection.outlook.com (10.152.98.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1318.5 via Frontend Transport; Wed, 31 Oct 2018 16:33:49 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w9VGXjx2019318
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 31 Oct 2018 12:33:47 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 31 Oct 2018 17:33:50 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Wed, 31 Oct 2018 17:33:50 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w9VGXi1o025968;
        Wed, 31 Oct 2018 16:33:44 GMT
Received: (from adouglas@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w9VGXhhh025926;
        Wed, 31 Oct 2018 16:33:43 GMT
From:   Alan Douglas <adouglas@cadence.com>
To:     <kishon@ti.com>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Alan Douglas <adouglas@cadence.com>
Subject: [PATCH v2 0/2] phy: cadence: Add driver and dt-bindings for Sierra PHY
Date:   Wed, 31 Oct 2018 16:33:38 +0000
Message-ID: <1541003618-25806-1-git-send-email-adouglas@cadence.com>
X-Mailer: git-send-email 1.9.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(2980300002)(36092001)(199004)(189003)(126002)(50226002)(50466002)(87636003)(97736004)(356004)(4326008)(186003)(51416003)(105596002)(2201001)(106466001)(26005)(6666004)(86362001)(48376002)(486006)(8676002)(81166006)(81156014)(5660300001)(2906002)(42186006)(305945005)(316002)(16586007)(478600001)(426003)(26826003)(2616005)(36756003)(47776003)(107886003)(8936002)(110136005)(53936002)(336012)(476003)(69596002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1865;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT011;1:HXTYeZXmDbHqAv/Uhjpjdr7xjw8Z9oPu/kWStLj2TLm0B2Ro9hy3gJXeQAhc34ayzbpuno2GDL9jevUvF58PtqlZfaqVYs8tppMPwb7xPWBDHQIcNTIJfuo5qloq4VD1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5ab1a1a-6140-4831-2559-08d63f4ea330
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:CY1PR0701MB1865;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1865;3:HGIf9NaQz0JsMUkd2Qya5UQQMuaa8jO3fHz4VgXhNky0IKIivlWOtGJPazVzBPteAyM9XRcE1Z/7K6/sR2Je9z1UvxLG+pJtjJFpQFT6fsfTWkwngeKie8xc6WV+g9cMqun+Im+651YXHiyAq+/Ocz5lYsUXCXAclusGN8xdNxmGpngFR8/T7tAdiI+Z2/mwOG5N/EcLmb1yjlElnWbHky69WEd4vQfvcM3l2vv/qhtHJZNHLtMSg9wI9lXhWEqD7AkT53YCYkTZ0dWhgqmMlSiieMO1hO7EIsZzuIjKrajIWbYh/IyLukPfGCGvb7elk5u/KgFq934OBKXS8ICzCw==;25:i9/BTuAL8HdklHJkxx0AVjOuRKufc9+js6SSk3WGIp3DVfDhdA1uJrEe2/vDTbpKko2Ds2sMmGoCvT9/ZTUS2egtvsWSram49F2u926X3gXZimoBizOL8ljZnri13IKmtJAVLfSrL/MYDc72vgLhztiLfkGuKzyVWS2w9EKM6SxITmh5zx/oc4UJGdSZp2XnX4mnBkZu/WYgROqgg6pMMgtIfveA6beOflVKnWIOLE/b6qiFIULh0Andyo7IGrrj7IiI1uG6DsWx+yS2FvL8Z6Ekub6fJfkRypNZMsd8u+MsCJDict6fOvJmU1okuJd1fseu8blji27KQtlRA2+qpNQqMQr5F7Z1tMF0gQBVTVE=
X-MS-TrafficTypeDiagnostic: CY1PR0701MB1865:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1865;31:lf4GHaYlys24c3viRRsdXfu3ciDutEIFnlbm3akQ7TBkKhE62T9YfCRoDBzbf2+GNvRqAX6f4Vwew+AEkMTN+r+/5vmYAkzKIv/HOsuBKCuMAUcC8xhJVY8MBnmsZWP1RmSW1sgg+wjoDD3dOM4SIKwTpGkcvI/v4KdSWlC9d9NN/F13uUgPvBblpnY7eDBTsYpIiIqfVcNa45Xh57/Wzvi+iaM4WUwPx1avr1Ed9Dw=;20:9S4Wa94pGexehb/HrzRcS1onhUQyNIJLFMsinvmpB5OQCkyyOi8vDATZntTTSMzM3dIXkCV72CLYCc8dFw4UtLD8bVhdI5k/+5ZxcVYU4dJ1gIJwtqrrs5H32dWmSfL1MU75XFV94JWbWl6PZoqx2yd4xmo1SVAe0Z9hUU9lXs+xzc3imlhm1Og0DQCng/eAxM8OT86x/ZJYA/Z+Ibf6kKQggD/88l7OJ5uKsgzXCzNyZiogsbmVqTxS7J4MNJ7QgP49W9QKsY9JpqMh+usL6km3QZ3gIKO/nr/TpCTx3v3qDUfEQts8ipEpDA6kwNZrvW1V1R6GA1UijGfUdiJr3JmrVXsdRpY0+QE4q7jsFSo++9YecUK9n+2Yt50dyFmIWMRA9Pvr6AdpJ09hAWOL1G/7x0fqoXc9D9U3B2duBsq5XqgIOT75ZfpRrY6p3H7s85yMv+lvD6myfDB0HPVzX2ExlDUCaXNEKs+cxaBS6SBWVcoF3B+0pGpxcM7woW3W
X-Microsoft-Antispam-PRVS: <CY1PR0701MB1865077BB607B060EF7EF349D8CD0@CY1PR0701MB1865.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93003095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:CY1PR0701MB1865;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1865;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1865;4:umTtGSJdCJ7TnKWHTHHYq5Q699dWItV28NK6GJCOUtgAiZdQ53piBdgSDx0wI+t9sRLzyR+cVy296i3SsOWiUd5JvFWx+jx0H/nxrzE4CNz16QC6/W3Bir7Bff5JJFqjQQQauOt3Ier6blsMz65zqRWQMNoT0eaoo2OwXaLd6Axwj8BHvcxLHMFIp7Hu8yc3rkiqbySli5BhIXNViW6ttPOhoAT0NFO2il0Z/SQkMpTZqPDo2qh+KkMaeh2DjhXKbjoECyPA/bem6W/fsjL6Eg==
X-Forefront-PRVS: 084285FC5C
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0701MB1865;23:54nvnoQRKOEX4GkIPy+IUmTxBS5gw/NsRgeDxx4?=
 =?us-ascii?Q?DP9UfVSS23Ol8svQdVvBZkyMDvqOSHloH3fEugiC/hthnfmu7V6dGlseLAMO?=
 =?us-ascii?Q?07o+s/L6fER+Iz5jZ9/F7naOVrjdKxat32xo9rIAB1mg8TmnIDmh2Q/pGU+t?=
 =?us-ascii?Q?TQdnBI4kUDLQ3kZFnAgu+Dee8lJNzPtZfabarA3ktDiv+oUvWvJvsqJVbQXo?=
 =?us-ascii?Q?jQpbz7ZpPYIzQcA7EIJT9ScJyG/o4wd3ds8V+klGcS4z7cJWUtmg+WVRutio?=
 =?us-ascii?Q?P9XRbr8oNOdNgrlH05Va89ezNpgA3hMkLWbZ9LLMpkQ/nFIdsfKrCAIMbp46?=
 =?us-ascii?Q?ISTH7R+hUCOMxjXNHGjd3OfD3A20vG2s+uvz6IHs0vlSHYCHf1oBEUfDEkhA?=
 =?us-ascii?Q?OgUGVQo21dxcixiY0aUpCoFomygQZj/SaldOw7IlfhfqQlD3GONc3NoHlow/?=
 =?us-ascii?Q?8Bob+Y+1rDM8rqXMfePNPMebTF4Af3572qNab56hVy83OymTfGPbBIgXmFEk?=
 =?us-ascii?Q?N+GyNFFza97Xccl6Rjz/mE4jBZJA30GW3QMoYpoNj/16sK1pc35H1gwK+1wU?=
 =?us-ascii?Q?Wc2LLdxHJLOiGMSV8BtnDyDrs8028ie9ng/c+0DPUEbyK17HEBkX6egNwCSj?=
 =?us-ascii?Q?t33dNHSjuQnthglTUUTk6vFv2Abo06t3k2ll0AWHhP5CYtIvi18JIN5QGdwh?=
 =?us-ascii?Q?WsOe1zlUbKYkCKQFXdJ1NU9MGVjJf7LimNV1RmfXEAryqaTlBCL/JZ77JXuW?=
 =?us-ascii?Q?g7DM/CcnPA8y2uHX1LvSU3h4pnDspHK6RH2DJRh8sEtYa6xWznXWI4DzViFF?=
 =?us-ascii?Q?T5dMDKTyqkFZHUBXXFo0EbYV/by2kwIBoYHmIXLns+Rw/1fUuuXZdCUyIjNr?=
 =?us-ascii?Q?WWt6ztuo5cjZjnnbT7R99iUokGJlZPSIxVcf7HBPMsWoZK3zXP0cEcgrzvib?=
 =?us-ascii?Q?2VFx6MwbbTTlqkMayMILjFrpcVOT4Q+Zj/leFr2uxDIrBCaGQoQMkCksG//w?=
 =?us-ascii?Q?xSil3uW8z2xWSwnS1jiCEAqImeCgFPzuhce+pUOovBgmG8x51Io/yb/o/yiQ?=
 =?us-ascii?Q?l0V8wcAG8BRmsnq58/E2SuILhUHSwoTFzcmFdpL/VQpmE56LYTA=3D=3D?=
X-Microsoft-Antispam-Message-Info: sbmOFuPRSDZpkU3aJPiL0siy9fg1gAmxK5Cls/5d/oXusAbGK+VPfJKzQz/xGmdObmdaxfYRYVWVcpEPsdhrNBXT54kgqgy3Bc2qGX59dySC/f2iiD4/0I5rjtv2CyAS2s7ENn0aSsmtPAcuYAfUxQ3cee/oMxKSVqhOb2Cs11VlKLWK21jUo0VhDygwI1JDAAiPke6CML1h0Qy5fTG9NiOBobolRQDQ+Ggp8zo2lURSktFMFfPTgaY6JZ9BvHgRLZtcokZbL1j1zBjY/3mrSpPYgGHmSFNZ8LhbYLJ+dYHjCGKBW/wvE8MnbFuVRD4OajjRiztWoo19JbXzLZ34TzgZ8PufmS8SdeiFjPuEXHi+hLW/ZrzNMgx7O0WuEAsI3jLymenNf1xdjFFgV9CaKA==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1865;6:dwpPZPxOIe7hogkyeY3fLlkLAAKpavdItmdqa5g79J3iENouo+IzewlY4oqxvpxBi9HVmYGxDQQsz3ApwpgQ/qB1aWFk/cG7G85MhoRxUTuYkBiFFtxxUX3p4qRfjCBcD0lq7gGtNfPl2j8NLQR03HLlOM7xgWfHxdkSEHxATdOTo4890JlsygLU08g8NJ3Wj7q98srsuZ7snTKLF1WtTb/oOC26a7LFzxfJLstIzPMK0KmrORFxhsLVKxDw/VM9QuErN0vO1Pt6cN+XNotoQsbOOL2cNCGSk3rREYX5sFo4YcR2cUhoxm4JS+JI0oe+UV7cqzN6vt/s8B3Qa0JAIU9dCffDlTuv9MBqj3iRiNPgKJXli+wAFwXBWB6lp0gp47rtC3D/KO/BHWndJQiOgCCxfkHddWFB7vwqRITP4VYFzKH2AV8NmEKVhkR4mFsjGJ+lGxItyA6X8KIO3M+k5A==;5:+1jaYgNTvV0y2mSiF9W5q805z8PdRcZtlxqTmgVFxwu0PvskbWMSqRfgJUCvQUOdcX1O4sxgchWkTxKfFbqhKQnzihHDE3lJSuC3g4YdnkoouQB7LSgDYim5jHkiQn1Zt+mWg10JGh0QJHs2iMNl001VBePEKi1luc7nbDo8swE=;7:ZoAcsAAUe4ZOYqcu+vbW1nXPvjBgIPdrTzhwc3y2oe8EIrXsFVmHzsgVgolG80tFIgi6erGE+ogZQyUVGieQ/oP+4GLeOiJltRrE+XXSpwmqdjNXY+Q6nOrOLEO/LjCiZBgAXKf2WvkzMSV/SW7Ltg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1865;20:jeGAbHpzoZu3QIiSbZemU5waWJoGBGKZW716zxhTjrmbnV6XIXx1KKLLRF+CVvyNlB0AAYVzf+agFcLaXn39e71m6diYy3DjaliUA8eurUeglKXDPPvZfwliY+ihYS59bayNEnmAOdZOv/LDkD06sE+NPzXIbaYwJYYd/k4eRJdcuVNnx8ExWUF6GpFUI2WfXEq+lrd6MYKaqxawGEaqxrZ1014ekplXtT+dTKPQXzCY3uIY7eFH2p1hprsVhbv8
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2018 16:33:49.4063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ab1a1a-6140-4831-2559-08d63f4ea330
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1865
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 a:mx-sanjose2.Cadence.COM a:mx-sanjose4.Cadence.COM
 a:mx-sanjose5.Cadence.COM include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810310137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Cadence Sierra PHY supports a number of different protocols.  This
series adds a driver with support for USB3 and PCIe modes.

Only one clock frequency is currently supported, so the value of clock
provided in device tree is ignored.

Changes since v1:
* Moved subnode resets into each subnode in devicetree bindings
* Modified driver to put subnode resets on exit
* Changed driver filename to phy-cdns-sierra.c

Changes since RFC v2:
* Devicetree bindings modified as suggested by Rob Herring.
* Tidy up and correction of return paths in probe function.

Changes since RFC v1:
* Each group of lanes is now treated as a subnode, and a generic PHY
  device is created for each group.
* General cleanup based on comments
* A reset is now required for each subnode.  The complete PHY block
  is taken out of reset at initial probe, and remains out of reset.
* Added a binding to allow for hardware configuration of PHY registers


Alan Douglas (2):
  dt-bindings: phy: Document cadence Sierra PHY bindings
  phy: cadence: Add driver for Sierra PHY

 .../devicetree/bindings/phy/cdns-sierra-phy.txt    |  68 ++++
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/cadence/Kconfig                        |   9 +
 drivers/phy/cadence/Makefile                       |   2 +
 drivers/phy/cadence/phy-cdns-sierra.c              | 395 +++++++++++++++++++++
 6 files changed, 476 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/cdns-sierra-phy.txt
 create mode 100644 drivers/phy/cadence/Kconfig
 create mode 100644 drivers/phy/cadence/Makefile
 create mode 100644 drivers/phy/cadence/phy-cdns-sierra.c

-- 
1.9.0

