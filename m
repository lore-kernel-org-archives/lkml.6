Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3CAECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4D02077B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 19:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nio365.onmicrosoft.com header.i=@nio365.onmicrosoft.com header.b="HbdTWrb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4D02077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeKIFKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 00:10:42 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:50272 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725199AbeKIFKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 00:10:41 -0500
Received: from pps.filterd (m0098780.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA8JUmYu002968;
        Thu, 8 Nov 2018 13:32:31 -0600
Authentication-Results: ppops.net;
        dkim=pass header.d=nio365.onmicrosoft.com header.s=selector1-ni-com
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp0116.outbound.protection.outlook.com [207.46.163.116])
        by mx0a-00010702.pphosted.com with ESMTP id 2nkvaheb84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Nov 2018 13:32:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector1-ni-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KD19gdOUPfBLT6+ALuKkgiqo+nwdmD1QVSd5A2PGZIQ=;
 b=HbdTWrb52STDDsCn+sFXJ+IoAEAf4GV59KMGBR95pCPpqVHCOL0YFYOXBdFh07wBPrY5pVltTIpNIANKyzvBV/upx7b5zR4FPbb9UaTIspRz2/tSXsqkec3Fy1MNLY9J85vCL7orQZMYw+JGXmXxE0EzN2TWGVFPivs91zfRsVw=
Received: from SN6PR04MB5343.namprd04.prod.outlook.com (20.177.255.221) by
 SN6PR04MB4701.namprd04.prod.outlook.com (52.135.122.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Thu, 8 Nov 2018 19:32:29 +0000
Received: from SN6PR04MB5343.namprd04.prod.outlook.com
 ([fe80::f413:7e57:83c2:5a52]) by SN6PR04MB5343.namprd04.prod.outlook.com
 ([fe80::f413:7e57:83c2:5a52%6]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 19:32:29 +0000
From:   Kyle Roeschley <kyle.roeschley@ni.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: phy: leds: Don't make our own link speed names
Thread-Topic: [PATCH] net: phy: leds: Don't make our own link speed names
Thread-Index: AQHUd4ulDGPDI0qLPk6gFantNtCpV6VGKpuAgAAZ3AA=
Date:   Thu, 8 Nov 2018 19:32:28 +0000
Message-ID: <20181108193226.GA26998@senary>
References: <20181108175106.25684-1-kyle.roeschley@ni.com>
 <fa2751d5-a15c-6414-9b80-15f54fd9f135@gmail.com>
In-Reply-To: <fa2751d5-a15c-6414-9b80-15f54fd9f135@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0086.namprd05.prod.outlook.com
 (2603:10b6:803:22::24) To SN6PR04MB5343.namprd04.prod.outlook.com
 (2603:10b6:805:fd::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [130.164.62.249]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR04MB4701;6:JGn1k02ZRO4sjA73nDp7ZCkNsiSS9XkiYZFPMCD6AhKbbM66JD2Duqp5JoxFeHfseKHOeP0+b6W7meBJlcb4pWqAp7O8xc/FF30w4jZY4yWkhgj7VqomzNiZy7oRLrWoViZVcLYtiJRdMbPAtVGWsLV/+AgN/pQcWWZszImuBr6gWWK+jZz/RZ0CzmRHmCJbl4JYwl3UNip0GgUFU2poXNS/i2t0+pcWtNVkDn2iwaSsuZdOZvogB5c/eVoq+43xHSIR7tLoOgi/vAQmQ+2rHSTXV7ccSHf6sZyrXwD7eFGA475UDeOv2W0550ezN6xROWHlNrAGOwwQ73fkmIKqizr7q5PwmG95zT38lmjQlcgp9rxHMWC+XDKoB4k/7p7ya+BfAZcBcU3aAPfu77uF34SCK+glAZuv9UdQN5yGOMvhjPFG+7ctWGEhzbOz5tiLd30HvTX3WMqbbPDoiir3iQ==;5:hWGZgdIyisuxwH+xkzAbiRAoCVxxzOb9eL4+7IKu7VjBzJ2ibawVl0OkuWCcs1iDAdVcYWN4jR76JQCHZrjc0QCMXzusINORb+IjBcsHtyhxanlQ0JsFmw0crCCW6PwO3K639bczP+dLPQpqvmBRjjmEDzX7odaSGiUzyKF2hko=;7:qVsuaehA3LiNEiYysORJXRBGdKpRR+yR5NE6x1vHWIta2h+OWggfZ0dC4jABWzHD6DBL5dNwYPf302+MXgntAoIvTMZKhLqIvXFHpuhFP44aTuMNK8vTqn1Nj0IxnLs2/AtuuDqFmr8aSU93ldo6xg==
x-ms-office365-filtering-correlation-id: 37b03c45-68c5-4a18-ffe6-08d645b0eb67
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4701;
x-ms-traffictypediagnostic: SN6PR04MB4701:
x-microsoft-antispam-prvs: <SN6PR04MB4701223A1EF1A5E4E3354D5AF7C50@SN6PR04MB4701.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:SN6PR04MB4701;BCL:0;PCL:0;RULEID:;SRVR:SN6PR04MB4701;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(376002)(39850400004)(346002)(136003)(366004)(199004)(189003)(86362001)(97736004)(4326008)(81156014)(81166006)(25786009)(2906002)(478600001)(8676002)(229853002)(6916009)(9686003)(6512007)(8936002)(6486002)(39060400002)(6246003)(53936002)(68736007)(1076002)(106356001)(105586002)(14454004)(6436002)(6116002)(3846002)(2900100001)(76176011)(186003)(71190400001)(99286004)(7736002)(54906003)(33716001)(476003)(486006)(5660300001)(52116002)(446003)(33656002)(66066001)(11346002)(71200400001)(102836004)(305945005)(26005)(256004)(14444005)(316002)(44832011)(386003)(53546011)(33896004)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4701;H:SN6PR04MB5343.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ni.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: alDvOYz2N5eLygkofUw00o2e7LyMxtLlsxdLQajMtwsFu3rhqw14sCuIEIjXnj0iZ18Uvg3AkVKerwfsEO4ifUOdyJZCOT5arWzlctXQ3CiOc/hNyWQaQC1vfCYtCQNwTIk+jqpuQZ5HFugvx07MLxeDy99hb3lg6iFc0H6WxfLaH1pwIhOtO/3G21NX8JUx1vJ85ASqJG7IQi49GQInRYDpEf+iH8iVKF5pVrRY4SgtTzuXZrmKtmV5cLY4oQZq7niLkBTLLMTa82u2crhrA6V0vlLdwx0cl00LYzkUki0qyOiXUrPOeW7JEqqRVZ5fwAL7GjKIRUX1GA9fwfYihqmFwyE/cOOmmDQ/LcPEx0k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BAFE07DBC2003E45A66F1A6F973E1CAA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b03c45-68c5-4a18-ffe6-08d645b0eb67
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 19:32:28.8928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4701
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=717 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 09:59:53AM -0800, Florian Fainelli wrote:
> On 11/8/18 9:51 AM, Kyle Roeschley wrote:
> > The phy core provides a handy phy_speed_to_str() helper, so use that
> > instead of doing our own formatting of the different known link speeds.
>=20
> In case the speed is not supported, phy_speed_to_str() would return
> "Unsupported (update phy-core.c)" which is bigger (by 21 characters)
> than name_suffix.
>=20
> If you bumped name_suffix/PHY_LED_TRIGGER_SPEED_SUFFIX_SIZE to 11
> characters, that would be just large enough to accommodate for the
> "Unsupported" part of the string and that might be an acceptable
> solution in between.
>=20

Thanks for catching that, I'll send a v2.

--=20
Kyle Roeschley
Software Engineer
National Instruments
