Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DDCC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16287208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qdFedZzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16287208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732981AbeG0PDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:03:51 -0400
Received: from mail-db5eur01on0044.outbound.protection.outlook.com ([104.47.2.44]:28832
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730953AbeG0PDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxlvFUxrYu4UDXC+bd0ouRI3/bYNGu5oOW7Dc8mfRbE=;
 b=qdFedZzSfvpWDAR2neZkTmBnI4bWBTGJyn7Qjn7Uo1idQ8YxlVBXgq6FC+Fj7g+rI8f9bfn9Tx2LcthNrZds/JIh3ksqRCIkrnKM3+k/0jEnLikrWYJjA8uxIR5eOg2HMdP2evHrL8a7+j64+5q129JBNm0+nYgvZ80BCyIVarU=
Received: from AM0PR04MB4788.eurprd04.prod.outlook.com (20.176.215.21) by
 AM0PR04MB4274.eurprd04.prod.outlook.com (52.134.126.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Fri, 27 Jul 2018 13:41:48 +0000
Received: from AM0PR04MB4788.eurprd04.prod.outlook.com
 ([fe80::9066:e4a0:871e:56c2]) by AM0PR04MB4788.eurprd04.prod.outlook.com
 ([fe80::9066:e4a0:871e:56c2%5]) with mapi id 15.20.0973.022; Fri, 27 Jul 2018
 13:41:48 +0000
From:   Camelia Alexandra Groza <camelia.groza@nxp.com>
To:     "andrew@lunn.ch" <andrew@lunn.ch>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Camelia Alexandra Groza <camelia.groza@nxp.com>
Subject: RE: [PATCH] net: phy: use generic clause 45 autonegotiation done
Thread-Topic: [PATCH] net: phy: use generic clause 45 autonegotiation done
Thread-Index: AQHUHpkhRppx3uTn+EqPQRQZK8PlPqSjIJng
Date:   Fri, 27 Jul 2018 13:41:47 +0000
Message-ID: <AM0PR04MB478842A44CC90EC171E2AC54F22A0@AM0PR04MB4788.eurprd04.prod.outlook.com>
References: <1531919535-20269-1-git-send-email-camelia.groza@nxp.com>
In-Reply-To: <1531919535-20269-1-git-send-email-camelia.groza@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=camelia.groza@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4274;6:1+ZDZVPQr9936UJBs55OlF7yNFQjFTl5dQ+xun7aaxEHTTZRnEcYyC+aZPA7NaovN8t6jmGSa/aws27V4ixMbx6BxiX8NFjqQPz1axdC4fOvuRbG/3LkpYvZQupkn+k76jzdy2vzbqabtXBzJCnzPnp5YTh4LqkYIGgmj/xUz3c3JvKKmE8SplYSvs1I/27qwa0n79LWMrm85eYHIiYuD8Zz6QbSuH/4M6jdoXKV9sTRI0xF4OprthNTH1w9CcAi1i/X9yFeksR1mWD4yCyVXah1QwDkNXcjBBpJeLYgnORpSWsZZXINL5h5EOfouqdFD1FB8L4RIpwGI6aCo6kAMcSCRQ6rxM5mcCx/qysBhbat3IaEmG4Aq3awaBtFa/likRjJV58coFaxvHp409hTdp3+Ku9MkxxyzyDV7T3NBoyruXpb4cF3FZp2rhbn0nLvsQ6xzaySds7jB+SlEfub6g==;5:7DTBrBjslWgRuzUXpBDZ+QbfHKWiPjDM1lMmGOmD07E662FsYSh3rQD5bjpJF6q4nxkTxR2Swt9vcG/iGgGief+doZQByPu9vV2ZJe8a0wgvat6whVoWkbXng5WkYEO4tZxv3Miz1yFmT0t8s48uPutDVAG78smSZj6OmKA3qN0=;7:thbYYOrsqA/DwvlU9h6diuEi+rEx5JjDJ8KEVJm/y+K09iLHyI04YKus3S8bp2l3R79e59AyCB+V4hOqNaAc7d/wfw0Kb1zd262U36NKwloY/Hnb1CoZxdNe/qq0M6N6jHi0TF+ZAT8W2wFv2YKUEtm6pwIAHTPclItxPvL/5hFCTiltBW8BNtDEPPaSkN9//3QJMRjpxEVx6VWrly1UWpF6Om9PIF4T42o4vyFN2WoEYcyIdsxadEUZtMaqPpaL
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9da44551-8cac-48da-a63b-08d5f3c6b350
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4274;
x-ms-traffictypediagnostic: AM0PR04MB4274:
x-microsoft-antispam-prvs: <AM0PR04MB4274FA6EE87994D18AED21BAF22A0@AM0PR04MB4274.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4274;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4274;
x-forefront-prvs: 07467C4D33
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(366004)(346002)(396003)(13464003)(199004)(189003)(86362001)(6306002)(2501003)(8936002)(5660300001)(5250100002)(6116002)(3846002)(39060400002)(6246003)(68736007)(14444005)(256004)(55016002)(486006)(9686003)(2900100001)(25786009)(476003)(4326008)(33656002)(229853002)(97736004)(186003)(966005)(305945005)(7736002)(14454004)(478600001)(53936002)(110136005)(54906003)(6436002)(74316002)(8676002)(105586002)(106356001)(76176011)(81166006)(81156014)(316002)(446003)(11346002)(7696005)(66066001)(102836004)(99286004)(2906002)(26005)(6506007)(53546011)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4274;H:AM0PR04MB4788.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aG1KaCtZ1iAdG3DHKourRqcWvDRFOfTXNwAJWCeseU6prnjPxhDCHXwEp945aWLVykjV1KLSIMcN0dKVe6lizZY5QsuwbV5KPSRqc+MuRkcMEJS5uRzFnppECb3YM2wf26CsyJ9yPBvRfzfDFjIPaYbbyM/T/7jcvlpsq9veMXqqtRYqLyUMJ+tWWMM0Y3BileKWKUt2aJkCcZu+g7ntbvbJv52PVAjfQR6JXB5nH0ZdwKIKqR9ONXWra+bpneN62fPsvNoMt3PI2P8IJTovIPVnJByMF8t2kdHuga0Nwf82eI/DxT3XEXnUrHvtNmYyLVWbVnqQ0WC5mIt7F/0dn6ciFPV8gaq65HZsKya4qaM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9da44551-8cac-48da-a63b-08d5f3c6b350
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2018 13:41:47.9053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4274
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Camelia Groza [mailto:camelia.groza@nxp.com]
> Sent: Wednesday, July 18, 2018 16:12
> To: andrew@lunn.ch; f.fainelli@gmail.com; davem@davemloft.net
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Camelia
> Alexandra Groza <camelia.groza@nxp.com>
> Subject: [PATCH] net: phy: use generic clause 45 autonegotiation done
>=20
> Only Clause 22 PHYs can use genphy_aneg_done(). Use
> genphy_c45_aneg_done() for PHYs that implement Clause 45 without the
> Clause 22 register set.
>=20
> This change follows the model of phy_restart_aneg() which differentiates
> between the two implementations in a similar way.
>=20
> Fixes: 41408ad519f7 ("net: phy: avoid genphy_aneg_done() for PHYs without
> clause 22 support")
> Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
> ---
>  drivers/net/phy/phy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c index
> 537297d..4fcc703 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -151,7 +151,7 @@ int phy_aneg_done(struct phy_device *phydev)
>  	 * implement Clause 22 registers
>  	 */
>  	if (phydev->is_c45 && !(phydev->c45_ids.devices_in_package &
> BIT(0)))
> -		return -EINVAL;
> +		return genphy_c45_aneg_done(phydev);
>=20
>  	return genphy_aneg_done(phydev);
>  }
> --
> 1.9.1

Hi

A reminder for the original patch above. Since I sent the second patch for =
phy_config_aneg() against a different tree [1], I didn't see the need to re=
submit this patch. If you need me to resubmit it, please let me know.

[1] https://patchwork.ozlabs.org/patch/947831/

Thank you,
Camelia
