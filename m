Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B08CC468C7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB6720875
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="p5ff2YFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB6720875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbeGLFzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:55:54 -0400
Received: from mail-eopbgr690056.outbound.protection.outlook.com ([40.107.69.56]:38258
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbeGLFzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2m5OFCHK7WpBTPrdgbT+jQd0Bz53UC1ma7gsvFxyhG8=;
 b=p5ff2YFGDuqyAOGRteTbtAuP/K4vQ5k4LEq+E1duP2EJNYdYQrjW9+scSozrnozw6E9HGDWXY6X3avIUUQDG8MORM+sBrDE7lTXlU5e1HysVZ6rJNj/Nikdt9UY1iNY1uoqN1KNhUsYnAFxRnF1Aif4BARTdGpVxVKsop1tNTU8=
Received: from SN1PR0701CA0078.namprd07.prod.outlook.com
 (2a01:111:e400:52fd::46) by BY1PR0701MB1336.namprd07.prod.outlook.com
 (2a01:111:e400:4810::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Thu, 12 Jul
 2018 05:47:54 +0000
Received: from DM3NAM05FT025.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::200) by SN1PR0701CA0078.outlook.office365.com
 (2a01:111:e400:52fd::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.18 via Frontend
 Transport; Thu, 12 Jul 2018 05:47:53 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT025.mail.protection.outlook.com (10.152.98.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.973.9 via Frontend Transport; Thu, 12 Jul 2018 05:47:53 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lkvx032054
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:47:52 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:03 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:02 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lkfN029522;
        Thu, 12 Jul 2018 06:47:46 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5lk3e029518;
        Thu, 12 Jul 2018 06:47:46 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 05/31] usb: usbssp: Added first part of initialization sequence.
Date:   Thu, 12 Jul 2018 06:47:02 +0100
Message-ID: <1531374448-26532-6-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(2980300002)(189003)(199004)(36092001)(87636003)(109986005)(478600001)(5660300001)(7636002)(305945005)(107886003)(50226002)(26005)(14444005)(105596002)(106466001)(246002)(8676002)(8936002)(356003)(4720700003)(6666003)(50466002)(426003)(1671002)(575784001)(86362001)(48376002)(2906002)(486006)(186003)(47776003)(26826003)(4326008)(126002)(336012)(36756003)(446003)(51416003)(316002)(76176011)(54906003)(2616005)(16586007)(11346002)(42186006)(476003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0701MB1336;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT025;1:wTTXVFrjXSzhbHZsFtMUZwavcp9DfxuabxoFPJqtTaWwTRcvD4fdgO7BD0AvvJhNkCi/uMI+hONBhY3ixUZ88SbYWVJV26ASHiD6BvamrY+7+Ah6khP4OsxJcoCPSz1e
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08cdfed1-f549-4a47-4ad6-08d5e7bb02b4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY1PR0701MB1336;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1336;3:DQf8J6AlMsjQVLxNltZa6N0RBXkieyg7cH7GKnbdi/SswjEY1J/00qxtxrDPJox9MzMNy0p++gPcYNCJF8abchmvvvxu79j8haHl3qRrUMApxsIkPHp0Uac0wLMSitcM/i3de0og9qMIbYx8iB27ITcWfOBVFW+xEHauBD9iOdBmtKbiTcNxWLqbK2KjCGBbO7pCKIICSyk/3alGdL7yh15WRbvIIX5gkmyO7t+lyH1v9Obd/3qnFRt6xgucLffUBYd/BzBwnvpF8ev9y6cmiB5QUkaSiOhuvqnnD0uOlKTlP+DDQEwXAwVP2KZfxFzxDqTNsyuX9pxf16LXGKDj0dnZzKOgCTBaQe+vl5w69V0=;25:hV6/d/muZKYEDuUQmBNek2a5O8bSghjpy7Ph1kkmnApSTnBYfAIzW2gTJmJqTzETUKKnIpybV3E4An7nIX4Zx5DUsIY1iE1nyFSrB/Q1ndpHtFLNbsfyScVJSZYq+xuuT9x6nD2V2dHd3hoM3WQ/7otfe8lTO0NJ+LgWoZg5tOCls6Rb4Ft8wJxKOhS7TvLBjgZ2/S9u1rb6FbK5mTdfV/hPpoNT/RXF3fJrn+t7znCeM2h99C0yC5cP0Su9ct7+rK66mEBuHe5YywvEFq9RVM67ksMX7vmmxHtbsy9Pi/jlIAaWkRY1mMwK2PW+xBaGugcz1tXHi4qTSaoKNH0reQ==
X-MS-TrafficTypeDiagnostic: BY1PR0701MB1336:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1336;31:p0MvD51RZiqRn5/0xZg7yKE9JF3SVTyOmkyPtqk3UV0syOeRAKktYtExTLSropK4LHjNR3P+LsNmZ/TyY6fgXlLusaEuN+Y8pnHuRWT+hQnk9n40pGxhDXoIhTNn45qvgD+JoynsaUotCI7RypY1aeOFH/qoPKUc+9wGoI+QUnRRcghTlTQIlkzzTL+1uchKHLNxidQKBGZ87SDFv1XMgHSA8mc1oez+WN3iUKaF0TY=;20:tm4ATi6DRCJwfAt/Geh9ficon4qh+OOjrZRBbYBYotJpg29qTVSe+rGIYXW76QZEeXVqeIUw1JhgA2gz5bmSnoFBd4yaPIdLgoROTl/ucKDjWqzdA+e2JulZb3wqFsTBYB4Qu31KV6rPNQ7n7Huqh2IuE9AJWJz0F52MNqzZ/omUJil4jR9KsjlPJcp+Xgq7Rj8w8dauQ+b/t6h5Mvvwat2Mi00iwHA6xmjzlgNjlQrd+M0ZU48S97R7dv9JaRlH/sVznEujMQcf5Qbg+T9wWR49O6p1LZZivR22C7yr/cku9sQ2LrVvnspmQCG94qdCRM16NOmfMtMu8gsoHU35eofsDrwZFOx/OK9gaGbbpXtmo84Ppf9NpeRnmAgLb6olnuwrOyNI/T4nJWzbMZPpv646XEo6dC243e+6wSXO86s8RkBJCCoIbcHReBUfHae+IMQZ04xGQ3BhZjrUMPCAUgUWUF6gaohaa2ZzPhxhqcnanpZUWESrpefg/MLru34C
X-Microsoft-Antispam-PRVS: <BY1PR0701MB13360F172C8B8A00BAB8B418DD590@BY1PR0701MB1336.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93003095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BY1PR0701MB1336;BCL:0;PCL:0;RULEID:;SRVR:BY1PR0701MB1336;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1336;4:1c4micm9KIgs6XgJMM0jPpJ99WHl6mHesfVwLsSsFUuS+G7hhc3lXY4Kdu80Q/P9dfkPcYimSvGtccTGBDpGjOKJpB56K06AJ7BZdLlGBgplXgjdsRO0XrcWVPnzrfx+lmfQZHP7r6WVxaFZWJR7jiOFZqtcmQ9T19SMN916tk8V7XIftMwcDNGLzO8d8V0svgukNNg60au/FXaNzPDerxHWUeTmvtmD66AHbPYNflfS67nNm3Xn6e3wzOiWDszmx03at9ThOtUOhQmceEKlbtrHTGof+5wZi0EXeNnwp/yEzwaCZCN5Rfmi0tJcW9yT
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR0701MB1336;23:IsIwrsQMh6oogn5H9vy/+orsufsRMloAIjTorzC?=
 =?us-ascii?Q?13CDW+yvGKS8JJsCb4ncPi9vfzmIPPqcyCvwSqlIDkqOozJYI+rJi9rrXrtm?=
 =?us-ascii?Q?oSgLBisRDAv846JYr/I9QbYTrRriKOEzAthO3tXEa+QQGb+aY3qyBqMUee5U?=
 =?us-ascii?Q?WlVhiFLWVmY2S90EMO9orJVLk2LTQrluCgneaCLkljGhGM6eGlf+2yHhJit1?=
 =?us-ascii?Q?gs1kxCaGMB5us1WCXjfv7oL79OIBQEw7ZtBgb2Vvgv8Ig7wCGUXGN6opRibq?=
 =?us-ascii?Q?WX4L+ZVBxAaTJgUZ81k5FZv9ebUP5kRJ9CGQW9DJxT/jH/R+xydMxrycbIAx?=
 =?us-ascii?Q?3ZX2R4uzItGW6UCfduqvp/Kfy2BPqhCTiw04scsA5o3PceAM7owIv6c1v8j7?=
 =?us-ascii?Q?OyF9R91rLFaM3XbmXpXllOeEQaVnkboMn9/wAmUx7Rrv9XaN+OsC8MmDNMVG?=
 =?us-ascii?Q?w93vzTbkXWF4KU/hufBB5DixRjrmrrefxSOx3ypI/XYUUIHcBbopwrzDEwFJ?=
 =?us-ascii?Q?24tqXuF1IrjrneUDVdJKaDaZLsjstraMQqMSgcIb1Nkgjfhz8sWmI2M/SARY?=
 =?us-ascii?Q?XmXJFJVZjEFPQbBaAX3JRoDqp5BLDEc4VQayB4aiGsqb3ZaJfSExCcNIPgHW?=
 =?us-ascii?Q?NjLANVUi3xLgRXcWVPvTUu+FMqbHAxwcfY/4l6tbHH5BSgDur53CpcBad0kg?=
 =?us-ascii?Q?1oyXFh7sanj4X9QXzsE0yLGRUFZfnk2EFULxuIaGDupLDoviFXEbzS3/ET9X?=
 =?us-ascii?Q?kKUPPC2piLXwTgGf6sfryUt5cvbbBwkq7ifJxwRJCO/FrIF0kdBiat6QPVA6?=
 =?us-ascii?Q?gdtjiJlvDZUoUB8nYauetAmp8uopC9jFogxl871EaUM2nOd6RqFIF8FBOpSp?=
 =?us-ascii?Q?I8MDgEvr8djqPyzmo5RZ/PqbhAvowtBaOUBYGiQiGCOSFKs+pzmX2hWDrp3q?=
 =?us-ascii?Q?MwNlP/TLP2gZIDLKtK3tJfCpX+WXb13hp46rBD8DTW97j4iZXc5whSqLRCxT?=
 =?us-ascii?Q?bkP4v/y9YJE0Zu7Ru4uYGW608nuWWgVWAtq74Iq6xK4298EJ9sSp+xS6W+SH?=
 =?us-ascii?Q?SsU7eDBbAzy34feYOJbjTPJ1QmvrcvzlCchtLjbsmHyH5UFugeJsKeDZefYG?=
 =?us-ascii?Q?eKZwbY6xBaq42YvzALOTaKqoNJW/VxdV8IbnQg3FJCNv4gaZiHhAgs3uUjHv?=
 =?us-ascii?Q?e0cPgW/7SBgf+0IQ=3D?=
X-Microsoft-Antispam-Message-Info: 1YQfhRJks6Vb4dWrV5CuEWt7RACayCd2IjXDSpS9dcd/EYCw5C2eiVN8rmAHNr6jj0ZOMHXP/cEqrYyUehap7H+76+ffobLF4lrLbz2Gx+dY5QEtpCMkXYcXrSc5s3zdxsSHrp7UoVVowZ1JmWoOgHMW/3TO17WGDeaVcptLIdfdPYiIqHjSRuNz5DPVTxr9KCkb68zhHzxYrnDdMeMGNdkZw2llMwNDS1ARP4PHbMyQQAmPp3aSyhHmT1nMfDUVWiY7Q3rfVQmLRT2qCGmNCL801L18sDikkH+CyVQ84EfWliH3mBSWy0FVYUx3GLKOD5h48r7f4/sYnKdN6tMnubXfSec3iz2FO5xZ3c/iMCXBO0IXfe1r/CBKEMES7FoaeQn2TkxDdHV+ECiW6pW3LQ==
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1336;6:Nu7SBZreL5gh89Twk8NU4zaMTuFVPopqh4QNODzlyUBUtBA6mN2IihomcCUO49uCJ5UbQrf9zxUTHKSKGlE45T0UBEQIYbmHH+ZdN7XdOcfQSNVrrkbQhpNXoi9d2eUCm3aPnEoG8mSvyN0mhhS3uBbY4xr9TvBcVg094UEaU4RUjjN+Em2umiFb72bBch9HrIRLabvapSPhtsL0HPoFwv5mBWvBCiVni7cjvShk7JAgb317j8NOGDpRmbUtVqur5N/v6iQeQy3bEZjzT5RYwjDcFtC2nhGw/poRPThp6+JscLLQGDudZ3BR3hQeLfDI06p+cSf7t6UNPbi8kLl9UUSFLn8AlC/FWY6ASJUtixhEo4MZ+9b/U8SIbnUis0cj+FQyQM17DvSpupP+D3UBArgUZL67XRSxkacs0sEA+/7BWeiBnGXByCCt2oXkBcyJVuaaUOhqMckwmi6fIMA31g==;5:HImBx7/SE7lAoF59YBOpKkcI7pH3LI8HuCzatbNhYC29Bx6hmMNkiFU3U19Dx+Dbgv8HwBlpx3wZ9mGep1heCChRqYOoq+DnrAVa+E/qpOudNDVOVHm+Y2P+jA8uWF2gzB9qRIrxqTTJW4N9TCUmo60tamEw/OYgy4RxqNKy0m4=;24:xj3RFuiqwlMreFn8XNIVlaTJCoV+Ip2AOFJmdNdR0gL8h9ztpA/v0xa+/TochhMo5BgVEUvBbdHFuYqD4/+yQjvjIu5q3gWtborxZ8OG02I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0701MB1336;7:BqhzkbgIwLNDHsdJ8ULDVMtY1x9ybbp2xz9UFO48OKOvq+ZODsqmtwKAYOWVQwuNd1TcvzwUqzAGC65PTemmRuY2n6sjycCU1epS2wLsKsSP9xQo5TF0BH9n2YWUeCMR+NJTeIjwkEUX/oCO5kYgz7dF/xweXvKbjPscVI82uYptPagEX0oGpOZ/7wJ326hp7gnrFtEtmOO/HYlpa2GmHHdMOlPWLEbCwBnTDhYWXoh2tqEi3y67gck6o57/aoM0;20:UnCB6eTBEg0+gZ0sbd4WkH3lqiKxf/Srazm/+ad5cIIRYfv5uh71hxd7SL6u1Qtcv6FeZoRkLgrZ+E+xzW9tW69BdsdWWpZt1mlBKrtkwUYDI0cAg8S+ar1HRijDtL4+5W12DwoZ78Zdef/NBzIqRceA8FDeEr/qtAUCx3/y69sXIwws8BiHncehCK7hV5o3bZl9Z0xuzs1+eSKKbX96Y+2iPd5V+a+Js+VNoPeNm0BScjqTs4t51UAFXjSCBuud
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:47:53.0407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08cdfed1-f549-4a47-4ad6-08d5e7bb02b4
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0701MB1336
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds some initialization function. The initialization sequence
is quite complicated and this patch implements it only partially.
Initialization will be completed in next few patches.

Patch introduce three new files:
1. gadget-dbg.c - file contains functions used for debugging purpose.
2. gadget-ext-caps.h - holds macro definition related to
		       Extended Capabilities
3. gadget-if - file implements stuff related to upper layer
	(e.g usb_ep_ops, usb_gadget_ops interface).

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/Makefile          |   3 +-
 drivers/usb/usbssp/gadget-dbg.c      |  30 ++++
 drivers/usb/usbssp/gadget-ext-caps.h |  53 ++++++
 drivers/usb/usbssp/gadget-if.c       |  24 +++
 drivers/usb/usbssp/gadget.c          | 248 +++++++++++++++++++++++++++
 drivers/usb/usbssp/gadget.h          |  14 ++
 6 files changed, 371 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/usbssp/gadget-dbg.c
 create mode 100644 drivers/usb/usbssp/gadget-ext-caps.h
 create mode 100644 drivers/usb/usbssp/gadget-if.c

diff --git a/drivers/usb/usbssp/Makefile b/drivers/usb/usbssp/Makefile
index 1b6261068fd9..ccc7c5646a6b 100644
--- a/drivers/usb/usbssp/Makefile
+++ b/drivers/usb/usbssp/Makefile
@@ -4,7 +4,8 @@ CFLAGS_gadget-trace.o := -I$(src)
 
 obj-$(CONFIG_USB_USBSSP_GADGET) += usbssp.o
 usbssp-y 			:=  usbssp-plat.o gadget-ring.o \
-				    gadget.o
+				    gadget.o \
+				    gadget-dbg.o
 
 ifneq ($(CONFIG_TRACING),)
 	usbssp-y		+= gadget-trace.o
diff --git a/drivers/usb/usbssp/gadget-dbg.c b/drivers/usb/usbssp/gadget-dbg.c
new file mode 100644
index 000000000000..88e4e8d38e4b
--- /dev/null
+++ b/drivers/usb/usbssp/gadget-dbg.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ *
+ * A lot of code based on Linux XHCI driver.
+ * Origin: Copyright (C) 2008 Intel Corp
+ */
+
+#include "gadget.h"
+
+void usbssp_dbg_trace(struct usbssp_udc *usbssp_data,
+		      void (*trace)(struct va_format *),
+		      const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+	usbssp_dbg(usbssp_data, "%pV\n", &vaf);
+	trace(&vaf);
+	va_end(args);
+}
+EXPORT_SYMBOL_GPL(usbssp_dbg_trace);
+
diff --git a/drivers/usb/usbssp/gadget-ext-caps.h b/drivers/usb/usbssp/gadget-ext-caps.h
new file mode 100644
index 000000000000..0107bc18ad7d
--- /dev/null
+++ b/drivers/usb/usbssp/gadget-ext-caps.h
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ *
+ * A lot of code based on Linux XHCI driver.
+ * Origin: Copyright (C) 2008 Intel Corp
+ */
+
+/* Up to 16 ms to halt an DC */
+#define USBSSP_MAX_HALT_USEC		(16*1000)
+
+/* DC not running - set to 1 when run/stop bit is cleared. */
+#define USBSSP_STS_HALT			(1<<0)
+
+/* HCCPARAMS offset from PCI base address */
+#define USBSSP_HCC_PARAMS_OFFSET	0x10
+/* HCCPARAMS contains the first extended capability pointer */
+#define USBSSP_HCC_EXT_CAPS(p)	(((p)>>16)&0xffff)
+
+/* Command and Status registers offset from the Operational Registers address */
+#define USBSSP_CMD_OFFSET		0x00
+#define USBSSP_STS_OFFSET		0x04
+
+/* Capability Register */
+/* bits 7:0 - how long is the Capabilities register */
+#define USBSSP_HC_LENGTH(p)		(((p)>>00)&0x00ff)
+
+/* Extended capability register fields */
+#define USBSSP_EXT_CAPS_ID(p)		(((p)>>0)&0xff)
+#define USBSSP_EXT_CAPS_NEXT(p)		(((p)>>8)&0xff)
+#define	v_EXT_CAPS_VAL(p)		((p)>>16)
+/* Extended capability IDs - ID 0 reserved */
+#define USBSSP_EXT_CAPS_PROTOCOL		2
+
+/* USB 2.0 hardware LMP capability*/
+#define USBSSP_HLC			(1 << 19)
+#define USBSSP_BLC			(1 << 20)
+
+/* command register values to disable interrupts and halt the DC */
+/* start/stop DC execution - do not write unless DC is halted*/
+#define USBSSP_CMD_RUN			(1 << 0)
+/* Event Interrupt Enable - get irq when EINT bit is set in USBSTS register */
+#define USBSSP_CMD_EIE			(1 << 2)
+/* Host System Error Interrupt Enable - get irq when HSEIE bit set in USBSTS */
+#define USBSSP_CMD_HSEIE		(1 << 3)
+/* Enable Wrap Event - '1' means DC generates an event when MFINDEX wraps. */
+#define USBSSP_CMD_EWE			(1 << 10)
+
+#define USBSSP_IRQS	(USBSSP_CMD_EIE | USBSSP_CMD_HSEIE | USBSSP_CMD_EWE)
diff --git a/drivers/usb/usbssp/gadget-if.c b/drivers/usb/usbssp/gadget-if.c
new file mode 100644
index 000000000000..d53e0fb65299
--- /dev/null
+++ b/drivers/usb/usbssp/gadget-if.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ *
+ */
+
+#include <linux/usb/gadget.h>
+#include <linux/usb/composite.h>
+#include "gadget.h"
+
+int usbssp_gadget_init_endpoint(struct usbssp_udc *usbssp_data)
+{
+	/*TODO: it has to be implemented*/
+	return 0;
+}
+
+void usbssp_gadget_free_endpoint(struct usbssp_udc *usbssp_data)
+{
+	/*TODO: it has to be implemented*/
+}
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index 2f60d7dd1fe4..75272dd2447a 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -23,6 +23,111 @@
 #include "gadget-trace.h"
 #include "gadget.h"
 
+
+/*
+ * usbssp_handshake - spin reading dc until handshake completes or fails
+ * @ptr: address of dc register to be read
+ * @mask: bits to look at in result of read
+ * @done: value of those bits when handshake succeeds
+ * @usec: timeout in microseconds
+ *
+ * Returns negative errno, or zero on success
+ *
+ * Success happens when the "mask" bits have the specified value (hardware
+ * handshake done). There are two failure modes: "usec" have passed (major
+ * hardware flakeout), or the register reads as all-ones (hardware removed).
+ */
+int usbssp_handshake(void __iomem *ptr, u32 mask, u32 done, int usec)
+{
+	u32	result;
+
+	do {
+		result = readl(ptr);
+		if (result == ~(u32)0)	/* card removed */
+			return -ENODEV;
+		result &= mask;
+		if (result == done)
+			return 0;
+		udelay(1);
+		usec--;
+	} while (usec > 0);
+	return -ETIMEDOUT;
+}
+
+/*
+ * Disable interrupts and begin the DC halting process.
+ */
+void usbssp_quiesce(struct usbssp_udc *usbssp_data)
+{
+	u32 halted;
+	u32 cmd;
+	u32 mask;
+
+	mask = ~(USBSSP_IRQS);
+
+	halted = readl(&usbssp_data->op_regs->status) & STS_HALT;
+	if (!halted)
+		mask &= ~CMD_RUN;
+
+	cmd = readl(&usbssp_data->op_regs->command);
+	cmd &= mask;
+	writel(cmd, &usbssp_data->op_regs->command);
+}
+
+/*
+ * Force DC into halt state.
+ *
+ * Disable any IRQs and clear the run/stop bit.
+ * USBSSP will complete any current and actively pipelined transactions, and
+ * should halt within 16 ms of the run/stop bit being cleared.
+ * Read DC Halted bit in the status register to see when the DC is finished.
+ */
+int usbssp_halt(struct usbssp_udc *usbssp_data)
+{
+	int ret;
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			 "// Halt the USBSSP");
+	usbssp_quiesce(usbssp_data);
+
+	ret = usbssp_handshake(&usbssp_data->op_regs->status,
+		STS_HALT, STS_HALT, USBSSP_MAX_HALT_USEC);
+
+	if (!ret) {
+		usbssp_warn(usbssp_data, "Device halt failed, %d\n", ret);
+		return ret;
+	}
+
+	usbssp_data->usbssp_state |= USBSSP_STATE_HALTED;
+	usbssp_data->cmd_ring_state = CMD_RING_STATE_STOPPED;
+	return ret;
+}
+
+
+/*
+ * Initialize memory for gadget driver and USBSSP (one-time init).
+ *
+ * Program the PAGESIZE register, initialize the device context array, create
+ * device contexts, set up a command ring segment (or two?), create event
+ * ring (one for now).
+ */
+int usbssp_init(struct usbssp_udc *usbssp_data)
+{
+	int retval = 0;
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init, "usbssp_init");
+
+	spin_lock_init(&usbssp_data->lock);
+	spin_lock_init(&usbssp_data->irq_thread_lock);
+
+	//TODO: memory initialization
+	//retval = usbssp_mem_init(usbssp_data, GFP_KERNEL);
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_init,
+			"Finished usbssp_init");
+	return retval;
+}
+
 #ifdef CONFIG_PM
 /*
  * Stop DC (not bus-specific)
@@ -50,9 +155,148 @@ int usbssp_resume(struct usbssp_udc *usbssp_data, bool hibernated)
 
 #endif	/* CONFIG_PM */
 
+int usbssp_gen_setup(struct usbssp_udc *usbssp_data)
+{
+	int	retval;
+
+	mutex_init(&usbssp_data->mutex);
+
+	usbssp_data->cap_regs = usbssp_data->regs;
+	usbssp_data->op_regs = usbssp_data->regs +
+		HC_LENGTH(readl(&usbssp_data->cap_regs->hc_capbase));
+
+	usbssp_data->run_regs = usbssp_data->regs +
+		(readl(&usbssp_data->cap_regs->run_regs_off) & RTSOFF_MASK);
+	/* Cache read-only capability registers */
+	usbssp_data->hcs_params1 = readl(&usbssp_data->cap_regs->hcs_params1);
+	usbssp_data->hcs_params2 = readl(&usbssp_data->cap_regs->hcs_params2);
+	usbssp_data->hcs_params3 = readl(&usbssp_data->cap_regs->hcs_params3);
+	usbssp_data->hcc_params = readl(&usbssp_data->cap_regs->hc_capbase);
+	usbssp_data->hci_version = HC_VERSION(usbssp_data->hcc_params);
+	usbssp_data->hcc_params = readl(&usbssp_data->cap_regs->hcc_params);
+	usbssp_data->hcc_params2 = readl(&usbssp_data->cap_regs->hcc_params2);
+
+	/* Make sure the Device Controller is halted. */
+	retval = usbssp_halt(usbssp_data);
+	if (retval)
+		return retval;
+
+	usbssp_dbg(usbssp_data, "Resetting Device Controller\n");
+	/* Reset the internal DC memory state and registers. */
+	/*TODO: add implementation of usbssp_reset function*/
+	//retval = usbssp_reset(usbssp_data);
+	if (retval)
+		return retval;
+	usbssp_dbg(usbssp_data, "Reset complete\n");
+
+	/* Set dma_mask and coherent_dma_mask to 64-bits,
+	 * if USBSSP supports 64-bit addressing
+	 */
+	if (HCC_64BIT_ADDR(usbssp_data->hcc_params) &&
+	    !dma_set_mask(usbssp_data->dev, DMA_BIT_MASK(64))) {
+		usbssp_dbg(usbssp_data, "Enabling 64-bit DMA addresses.\n");
+		dma_set_coherent_mask(usbssp_data->dev, DMA_BIT_MASK(64));
+	} else {
+		/*
+		 * This is to avoid error in cases where a 32-bit USB
+		 * controller is used on a 64-bit capable system.
+		 */
+		retval = dma_set_mask(usbssp_data->dev, DMA_BIT_MASK(32));
+		if (retval)
+			return retval;
+		usbssp_dbg(usbssp_data, "Enabling 32-bit DMA addresses.\n");
+		dma_set_coherent_mask(usbssp_data->dev, DMA_BIT_MASK(32));
+	}
+
+	usbssp_dbg(usbssp_data, "Calling USBSSP init\n");
+	/* Initialize USBSSP controller data structures. */
+	retval = usbssp_init(usbssp_data);
+	if (retval)
+		return retval;
+	usbssp_dbg(usbssp_data, "Called USBSSPinit\n");
+
+	usbssp_info(usbssp_data, "USBSSP params 0x%08x USBSSP version 0x%x\n",
+		usbssp_data->hcc_params, usbssp_data->hci_version);
+
+	return 0;
+}
+
+/*
+ * gadget-if.c file is part of gadget.c file and implements interface
+ * for gadget driver
+ */
+#include "gadget-if.c"
+
 int usbssp_gadget_init(struct usbssp_udc *usbssp_data)
 {
 	int ret;
+
+	/*
+	 * Check the compiler generated sizes of structures that must be laid
+	 * out in specific ways for hardware access.
+	 */
+	BUILD_BUG_ON(sizeof(struct usbssp_doorbell_array) != 2*32/8);
+	BUILD_BUG_ON(sizeof(struct usbssp_slot_ctx) != 8*32/8);
+	BUILD_BUG_ON(sizeof(struct usbssp_ep_ctx) != 8*32/8);
+	/* usbssp_device has eight fields, and also
+	 * embeds one usbssp_slot_ctx and 31 usbssp_ep_ctx
+	 */
+	BUILD_BUG_ON(sizeof(struct usbssp_stream_ctx) != 4*32/8);
+	BUILD_BUG_ON(sizeof(union usbssp_trb) != 4*32/8);
+	BUILD_BUG_ON(sizeof(struct usbssp_erst_entry) != 4*32/8);
+	BUILD_BUG_ON(sizeof(struct usbssp_cap_regs) != 8*32/8);
+	BUILD_BUG_ON(sizeof(struct usbssp_intr_reg) != 8*32/8);
+	/* usbssp_run_regs has eight fields and embeds 128 usbssp_intr_regs */
+	BUILD_BUG_ON(sizeof(struct usbssp_run_regs) != (8+8*128)*32/8);
+
+	/* fill gadget fields */
+	/*TODO: implements usbssp_gadget_ops object*/
+	//usbssp_data->gadget.ops = &usbssp_gadget_ops;
+	usbssp_data->gadget.name = "usbssp-gadget";
+	usbssp_data->gadget.max_speed = USB_SPEED_SUPER_PLUS;
+	usbssp_data->gadget.speed = USB_SPEED_UNKNOWN;
+	usbssp_data->gadget.sg_supported = true;
+	usbssp_data->gadget.lpm_capable = 1;
+
+	usbssp_data->setup_buf = kzalloc(USBSSP_EP0_SETUP_SIZE, GFP_KERNEL);
+	if (!usbssp_data->setup_buf)
+		return -ENOMEM;
+
+	/*USBSSP support not aligned buffer but this option
+	 * improve performance of this controller.
+	 */
+	usbssp_data->gadget.quirk_ep_out_aligned_size = true;
+	ret = usbssp_gen_setup(usbssp_data);
+	if (ret < 0) {
+		usbssp_err(usbssp_data,
+				"Generic initialization failed with error code%d\n",
+				ret);
+		goto err3;
+	}
+
+	ret = usbssp_gadget_init_endpoint(usbssp_data);
+	if (ret < 0) {
+		usbssp_err(usbssp_data, "failed to initialize endpoints\n");
+		goto err1;
+	}
+
+	ret = usb_add_gadget_udc(usbssp_data->dev, &usbssp_data->gadget);
+
+	if (ret) {
+		usbssp_err(usbssp_data, "failed to register udc\n");
+		goto err2;
+	}
+
+	return ret;
+err2:
+	usbssp_gadget_free_endpoint(usbssp_data);
+err1:
+	usbssp_halt(usbssp_data);
+	/*TODO add implementation of usbssp_reset function*/
+	//usbssp_reset(usbssp_data);
+	//TODO freeing memory
+	//usbssp_mem_cleanup(usbssp_data);
+err3:
 	return ret;
 }
 
@@ -60,5 +304,9 @@ int usbssp_gadget_exit(struct usbssp_udc *usbssp_data)
 {
 	int ret = 0;
 
+	usb_del_gadget_udc(&usbssp_data->gadget);
+	usbssp_gadget_free_endpoint(usbssp_data);
+	/*TODO: add usbssp_stop implementation*/
+	//usbssp_stop(usbssp_data);
 	return ret;
 }
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 2f9ee3543911..ce0ac6883efc 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/usb/gadget.h>
+#include "gadget-ext-caps.h"
 
 /* Max number slots - only 1 is allowed */
 #define DEV_MAX_SLOTS 1
@@ -1671,7 +1672,18 @@ static inline void usbssp_write_64(struct usbssp_udc *usbssp_data,
 	lo_hi_writeq(val, regs);
 }
 
+/* USBSSP memory management */
+void usbssp_dbg_trace(struct usbssp_udc *usbssp_data,
+		void (*trace)(struct va_format *),
+		const char *fmt, ...);
 /* USBSSP Device controller glue */
+void usbssp_bottom_irq(struct work_struct *work);
+int usbssp_init(struct usbssp_udc *usbssp_data);
+void usbssp_stop(struct usbssp_udc *usbssp_data);
+int usbssp_handshake(void __iomem *ptr, u32 mask, u32 done, int usec);
+void usbssp_quiesce(struct usbssp_udc *usbssp_data);
+extern int usbssp_reset(struct usbssp_udc *usbssp_data);
+
 int usbssp_suspend(struct usbssp_udc *usbssp_data, bool do_wakeup);
 int usbssp_resume(struct usbssp_udc *usbssp_data, bool hibernated);
 
@@ -1684,6 +1696,8 @@ dma_addr_t usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
 /* USBSSP gadget interface*/
 int usbssp_gadget_init(struct usbssp_udc *usbssp_data);
 int  usbssp_gadget_exit(struct usbssp_udc *usbssp_data);
+void usbssp_gadget_free_endpoint(struct usbssp_udc *usbssp_data);
+int usbssp_gadget_init_endpoint(struct usbssp_udc *usbssp_data);
 
 static inline char *usbssp_slot_state_string(u32 state)
 {
-- 
2.17.1

