Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34E5C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9339A2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 10:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=landisgyr.com header.i=@landisgyr.com header.b="fIVnc0tH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9339A2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=landisgyr.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbeHMNXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 09:23:25 -0400
Received: from mail-eopbgr20134.outbound.protection.outlook.com ([40.107.2.134]:38064
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728356AbeHMNXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 09:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landisgyr.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx1PkNHkAOLCTlMn/lrL2tsHJw+inzEM19ntoo4BtcI=;
 b=fIVnc0tHUSm0tkrLBOKM1i+ptUBYOQLXeSRMdWH0cgEdgGnCJCfZ4eAZ9wWQwTQtVaXO51GrrSY9Mi3vqBzopVybLv2uGjR1Qf+i82K71ErUCbeGhKdnVYXI3QJVB7R3fKVhcqe7eEZPjnlF3+0GU87zCe/te9oWD8tf7xlN6c4=
Received: from AM6PR01MB4262.eurprd01.prod.exchangelabs.com (20.176.242.28) by
 AM6PR01MB4166.eurprd01.prod.exchangelabs.com (20.177.38.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 13 Aug 2018 10:41:40 +0000
Received: from AM6PR01MB4262.eurprd01.prod.exchangelabs.com
 ([fe80::29fa:83cb:3fa7:452]) by AM6PR01MB4262.eurprd01.prod.exchangelabs.com
 ([fe80::29fa:83cb:3fa7:452%3]) with mapi id 15.20.1017.022; Mon, 13 Aug 2018
 10:41:40 +0000
From:   "Onnasch, Alexander (EXT)" <Alexander.Onnasch@landisgyr.com>
To:     David Miller <davem@davemloft.net>
CC:     "andrew@lunn.ch" <andrew@lunn.ch>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net/phy: Micrel KSZ8061 PHY link failure after cable
 connect
Thread-Topic: [PATCH] net/phy: Micrel KSZ8061 PHY link failure after cable
 connect
Thread-Index: AQHUKA3ctF73hnLT+UqrN/kAIs0lkKSn+VwAgBWZU0A=
Date:   Mon, 13 Aug 2018 10:41:40 +0000
Message-ID: <AM6PR01MB426266447FE9251ECAD75CE9F0390@AM6PR01MB4262.eurprd01.prod.exchangelabs.com>
References: <1532959287-360-1-git-send-email-alexander.onnasch@landisgyr.com>
 <20180730.094534.351189879060038512.davem@davemloft.net>
In-Reply-To: <20180730.094534.351189879060038512.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Onnasch@landisgyr.com; 
x-originating-ip: [80.239.165.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR01MB4166;6:jF4JvRTpxlygmdHjGfNiHDaSJ+wX1lhOkjhIC2Am0DmQcNtVcvye0KRYJYSwedl/LKY49t30H/To++wt8zVkHsgSCkaIjBgsb2NqVftBJFpcAMKsxtEZ9hjViI/zFfjxYGAdYpWdRN6l3SzF/G1uFTHf/55Dun/1yBRZNsFqDacyLP0onVClQkEqFaX+1miGK0Kbh/3sgmzRpq+7ZvS+hPIK6s0USdRNPJ8tSSxaAWohMnag1loa87xZfO7I+Pc5vfOjpUW7u5dAktvrTPcu3p0qKLBBNwyLVrJlDz5Xz/FeTxVx6wfHlBoKErbUFeedT6O7StznkzUyhuX78/W2QpGCNSMZQAwJ2i/0YI/OJWFtVdNCv2P63exc4OaG6yNA/r+AcB1Nn7bN9hV7CQ+sUnuU8eMAUe8xWUbP86sOFp8kdGMIttjt9MYyCDr2heJrT+VzscAj3RiCl+mkcqEryA==;5:fFPwRyXJQrCC/uiVoNFQKBw1BMlpghesGqlqWPqtkQ0OoNw7j+pAWJ7KNIJK7piSqbkLpMYzWqIQCK5ykgFlz2Oh5Q+r92GdCsOQUbbbsGkGAKutC+ecyzJiZwSteg2H9xS1Bq1R8l4XShQrMZ3VK70fccksIuEaNa1estStXbU=;7:Fc3tpnDrN12ZsRgOhmgPTs+3b1+ECua+Nrm7kYFuSZ/6mqZpa9AcstgXr2q5Z3/tNh31KUePMfAwUGcj2VhK54YbsLGmxWH+tSq3EHO+Gfgteoq+cvpO0I2eSOdaTZ5A/lby1ggZ1IolTL3rXMuLPvF2QP0Pyj619HC3YksrCqz2PemkmDKAruLEmfvFyKQN9jM11o8ojk2DOWW6gOQFYFOaJjib+7d4qHKOjykHJWkBm/OVQ5o8Kq7E0ZX5mF8a
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9d7fcf56-64e2-4a83-0687-08d601095a54
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR01MB4166;
x-ms-traffictypediagnostic: AM6PR01MB4166:
x-microsoft-antispam-prvs: <AM6PR01MB41663FB6B15921B7D6B511A6F0390@AM6PR01MB4166.eurprd01.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:(247057607073920)(9452136761055)(85827821059158)(144836121648609)(21532816269658);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM6PR01MB4166;BCL:0;PCL:0;RULEID:;SRVR:AM6PR01MB4166;
x-forefront-prvs: 07630F72AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39850400004)(366004)(376002)(136003)(346002)(189003)(199004)(13464003)(252514010)(105586002)(6506007)(6436002)(5250100002)(8936002)(102836004)(316002)(68736007)(5660300001)(229853002)(97736004)(7696005)(72206003)(3846002)(53546011)(2906002)(54906003)(106356001)(6116002)(478600001)(14444005)(11346002)(33656002)(26005)(66066001)(39060400002)(99286004)(486006)(14454004)(76176011)(305945005)(4326008)(6246003)(55016002)(25786009)(2900100001)(7736002)(9686003)(81166006)(53936002)(186003)(476003)(446003)(74316002)(6916009)(81156014)(256004)(86362001)(15974865002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR01MB4166;H:AM6PR01MB4262.eurprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: landisgyr.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BEEEpnYR9M1UoGZ7CN4tYFoSahSooQOdnkGAwhPQ684rgFmUnsmW9nSrpx4Sek7+eoemXXqLDTuPIjf0NBzhDyexOm97unP5gGd4qEIdGrCJM9HA32FTwrL+YX29Uz+Su9vtYB5IuWW3NUzlkO48DuZRqJ/3/cQJtJbTZC9KFR1BoKJyCJl0RFlwjtXeWRdzGIQvlLGg8EuktoOeluQxLf+MKXAyDFEAgHvNeglFLT6WhaRieI0eiTyAJLxT8SGPxNjZr8/11iLy7wzor49FUsx51CoTq537EXvw7KF3xBmTvfaCPypAut23NqeFBvRjPiHpC9IWlyggEK6Q8Re0uPCpwfWh2IUSBOH8YVsg/lA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: landisgyr.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7fcf56-64e2-4a83-0687-08d601095a54
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2018 10:41:40.0202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ee2cd48b-958f-4be4-9852-b8f104c001b9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR01MB4166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: David Miller <davem@davemloft.net>=20
Sent: Montag, 30. Juli 2018 18:46
To: Onnasch, Alexander (EXT) <Alexander.Onnasch@landisgyr.com>
Cc: andrew@lunn.ch; f.fainelli@gmail.com; netdev@vger.kernel.org; linux-ker=
nel@vger.kernel.org
Subject: Re: [PATCH] net/phy: Micrel KSZ8061 PHY link failure after cable c=
onnect

From: Alexander Onnasch <alexander.onnasch@landisgyr.com>
Date: Mon, 30 Jul 2018 16:01:27 +0200

> With Micrel KSZ8061 PHY, the link may occasionally not come up after=20
> Ethernet cable connect. The vendor's (Microchip, former Micrel) errata=20
> sheet 80000688A.pdf describes the problem and possible workarounds in=20
> detail, see below.
> The patch implements workaround 1, which permanently fixes the issue.
 ...
> Signed-off-by: Alexander Onnasch <alexander.onnasch@landisgyr.com>

This patch does not apply cleanly to any of my neworking trees.


Hello David

thanks a lot for reviewing ! How to proceed now ? If there is action requir=
ed from my side please tell me.

best regards,=20
Alex


Alexander Onnasch |   Landis+Gyr AG   |  Firmware Engineer
Phone: +41 41 935 6357  |   Fax: +41 41 935 6211
Email: alexander.onnasch@landisgyr.com  |   Site: www.landisgyr.com  |   Ad=
dress: Theilerstr. 1, CH-6301 Zug, Switzerland
manage energy better

