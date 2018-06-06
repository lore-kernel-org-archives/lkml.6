Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=LandisGyr.onmicrosoft.com header.i=@LandisGyr.onmicrosoft.com header.b="ZjhI6iVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 78E966063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=landisgyr.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932381AbeFFICO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:02:14 -0400
Received: from mail-eopbgr30091.outbound.protection.outlook.com ([40.107.3.91]:40304
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932122AbeFFICM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:02:12 -0400
From: "Onnasch, Alexander (EXT)" <Alexander.Onnasch@landisgyr.com>
To: Florian Fainelli <f.fainelli@gmail.com>
CC: Andrew Lunn <andrew@lunn.ch>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers/net/phy/micrel: Fix for PHY KSZ8061 errrata:
 Potential link-up failure when Ethernet cable is connected slowly
Thread-Topic: [PATCH] drivers/net/phy/micrel: Fix for PHY KSZ8061 errrata:
 Potential link-up failure when Ethernet cable is connected slowly
Thread-Index: AQHT9CU4VytUKi6CykefQ8cMEkckh6RAjqeAgBJiEOA=
Date: Wed, 6 Jun 2018 08:02:09 +0000
Message-ID: <AM6PR01MB42623DC75064CE76AD07A8C9F0650@AM6PR01MB4262.eurprd01.prod.exchangelabs.com>
References: <1527251853-22218-1-git-send-email-alexander.onnasch@landisgyr.com>
 <b560368a-e790-164a-7414-a88a21da64b5@gmail.com>
In-Reply-To: <b560368a-e790-164a-7414-a88a21da64b5@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Onnasch@landisgyr.com;
x-originating-ip: [80.239.165.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR01MB4021;7:wqwjFDXBcQ1BdlI8ZCZk54t0DseUXhNpTyuUJ6Ufr/ICiYUB/zrMki/z5fxT7EJ+3V3qiyeB8LLpCjsV+rydxWngI15C4kBdcv0PCgu1T1jpAXUkU0hISHpR5sdIOzTUYoVb52e5AMghG1X+M8V7VS6Cs6UAVHv1fizPc+/kCotoh9DblPesPy37NuxGSQLFP+kcxq91r0ORG7ZKWq9+gilUi0J90Rkszayj1ltluPhRZUKR41S/PRBLEvPUXyft
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM6PR01MB4021;
x-ms-traffictypediagnostic: AM6PR01MB4021:
x-microsoft-antispam-prvs: <AM6PR01MB40215944F3808F85BE0655EBF0650@AM6PR01MB4021.eurprd01.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(144836121648609);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM6PR01MB4021;BCL:0;PCL:0;RULEID:;SRVR:AM6PR01MB4021;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(39380400002)(376002)(346002)(396003)(189003)(199004)(51914003)(13464003)(9686003)(4326008)(72206003)(5250100002)(8936002)(81156014)(446003)(97736004)(54906003)(5660300001)(11346002)(53936002)(99286004)(14454004)(6436002)(316002)(5890100001)(39060400002)(186003)(81166006)(486006)(74316002)(476003)(102836004)(26005)(76176011)(59450400001)(53546011)(3846002)(2900100001)(33656002)(2906002)(6506007)(6246003)(8676002)(66066001)(106356001)(68736007)(7696005)(86362001)(25786009)(7736002)(229853002)(55016002)(105586002)(3660700001)(305945005)(478600001)(3280700002)(6116002)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR01MB4021;H:AM6PR01MB4262.eurprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: p6LWgalyFGhAD7yax4jnP3JB5IHAPVn9uSF43ti/obkaMkhQiXbbGyIU2B4vreQrBNXtwu8miaxzawymewtUMTdkn4O6O+AP8HUwdXn5+8uAogJGt5Nrm+rdE3Ju9yBAt6beN1U0xkqqeZaf0KxxolrASNT8qKU/WEwMhkkwnc3DQFxyqyJMPPeYg2pfxqMX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 4540fff9-2136-4e56-b1f1-08d5cb83cdad
X-OriginatorOrg: landisgyr.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4540fff9-2136-4e56-b1f1-08d5cb83cdad
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 08:02:09.3939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ee2cd48b-958f-4be4-9852-b8f104c001b9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR01MB4021
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello=20
thanks for the hints! I have changed it accordingly and will now post it ag=
ain.
best regards,
Alexander Onnasch

-----Original Message-----
From: Florian Fainelli <f.fainelli@gmail.com>=20
Sent: Freitag, 25. Mai 2018 17:17
To: Onnasch, Alexander (EXT) <Alexander.Onnasch@landisgyr.com>
Cc: Andrew Lunn <andrew@lunn.ch>; netdev@vger.kernel.org; linux-kernel@vger=
.kernel.org
Subject: Re: [PATCH] drivers/net/phy/micrel: Fix for PHY KSZ8061 errrata: P=
otential link-up failure when Ethernet cable is connected slowly



On 05/25/2018 05:37 AM, Alexander Onnasch wrote:
> Signed-off-by: Alexander Onnasch <alexander.onnasch@landisgyr.com>

You would want to make the commit subject shorter (ideally capped somewhere=
 around 72 characters) and provide a commit message which explains the issu=
e and why the workaround is effective.

Thank you!

[snip]

>=20
> P PLEASE CONSIDER OUR ENVIRONMENT BEFORE PRINTING THIS EMAIL.
>=20
> This e-mail (including any attachments) is confidential and may be legall=
y privileged. If you are not an intended recipient or an authorized represe=
ntative of an intended recipient, you are prohibited from using, copying or=
 distributing the information in this e-mail or its attachments. If you hav=
e received this e-mail in error, please notify the sender immediately by re=
turn e-mail and delete all copies of this message and any attachments. Than=
k you.

You need to remove that footer otherwise we cannot be accepting your patch.
--
Florian
