Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9735ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB81208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 01:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intra01.onmicrosoft.com header.i=@intra01.onmicrosoft.com header.b="TcUqJcpQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB81208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbeGQCRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:17:48 -0400
Received: from mail-ty1jpn01on0117.outbound.protection.outlook.com ([104.47.93.117]:63169
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729934AbeGQCRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intra01.onmicrosoft.com; s=selector1-intra01-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTdj2oSLdPWpzU80ILDP8yo3q3NNoI4X8SQ5ux09NRY=;
 b=TcUqJcpQuIUSGsXB88kq1K3Dy2/jUGHQGmzdR336PPSmusbn69dI34313nDS5kh0ovAYvMSTLIfuXssdxDPlJXyplZOn09vk9wRgpx41Wz3X7yhm27/EGbl5SBC+6WRF2i0mZLGOnYTomWvu532Id41jYBgxn9tOHHXeVXlWEkc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=masahiko.kimoto@cybertrust.co.jp; 
Received: from localhost (221.114.197.178) by
 OS2PR01MB1275.jpnprd01.prod.outlook.com (2603:1096:602:5::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.18; Tue, 17 Jul 2018 01:47:37 +0000
Date:   Tue, 17 Jul 2018 10:47:33 +0900 (JST)
Message-Id: <20180717.104733.1408380842449139305.kimoto@cybertrust.co.jp>
To:     andrew@lunn.ch
Cc:     f.fainelli@gmail.com, fugang.duan@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hiraku.toyooka@cybertrust.co.jp
Subject: Re: [RFC PATCH 0/1] net: phy: skip autoneg of ethernet(fec) on
 network boot
From:   Masahiko KIMOTO <masahiko.kimoto@cybertrust.co.jp>
In-Reply-To: <20180710.105230.2160849304208584873.kimoto@cybertrust.co.jp>
References: <20180709.182902.1637265651643155858.kimoto@cybertrust.co.jp>
        <20180709144106.GJ10376@lunn.ch>
        <20180710.105230.2160849304208584873.kimoto@cybertrust.co.jp>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Originating-IP: [221.114.197.178]
X-ClientProxiedBy: OSAPR01CA0165.jpnprd01.prod.outlook.com
 (2603:1096:604:d::33) To OS2PR01MB1275.jpnprd01.prod.outlook.com
 (2603:1096:602:5::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 143282e7-4cbf-4894-0ff1-08d5eb87468b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:OS2PR01MB1275;
X-Microsoft-Exchange-Diagnostics: 1;OS2PR01MB1275;3:ykdwd0tjD5jXWdL8peJ6lViGAPOoMMbkwkGmd6rojDdpExL118N1zAvipzO3fi4DSHTUUbDTW/FTNB7QSEgxOdve8LYYeIU906knSVpR5Ok2doS2xsTQarH1qsGHNoZ8Wjzne5oOAfBm4/6zP+N9WSZoNMYnBHDPtnzgKUeQ+rDBIeVwConwrmI0DBeKtU2OHpTNsK/xKs5FCbmwzANGrttYKfKgfaBc/mfIzXRuWyYfN/JLHUUMilcJvHWfCzey;25:WyzlA6rYD5bC0LZ3nKcqvkZbeFO9sdoXDPPhuJ6x/q4PNsRxG7ik9TFNqvApbz5vBfFH/dNBhblg4+dmBTR4YjeU0/e7l81I4mj7N6rlYDRNVlpKY4sRn8KSzOIeWlzvxwiWTHl1G3cX8cPa/GsXBMVouTA/8IQRFRkm25BuwvzObal5zvwLyxlhV/vGLY55ZsVvFSuqvqbOJQr1Ha54SZnQPCfu4UH4a04pA/h4nT1lmOj6jWU0fJp8INML4VYkcC0b6rePzPPdwxnEOsKU27aqJKqVLuWTK8EYID70I2R98Hj3V1vcI1rQaCQVxjWavyHi9KUDXbj43RaR2uNC+g==;31:de0KX+w8qnbgm8++jRkWo5P8EHTYMqD1BrzgVHnd7aBZen1oL1jrk7xt50TxfWVtVfg9UQIa+c9PU54JS6C1vgTFt6vC3MJPu4qp2BRob6TK84n3ySDqsLNyXmEgIfT6fp38+OzgvgGy83aYSlh1TERI1tscCXhnXbnz597rBu/zDx0nBDDPrnkVTWuYMg/zuqLyNReykQupQ5f6PAvNbtxZwjw+xAarYdVW2mtvtNI=
X-MS-TrafficTypeDiagnostic: OS2PR01MB1275:
X-Microsoft-Exchange-Diagnostics: 1;OS2PR01MB1275;20:BPYcLdXU69XSea7foV+C8q968OUjRsywsdxyfsDcuvoIkGG9jcXWoUluhbXsWlPpfpZqkixrg6bMsLO/+XQDb6wA24cpLo9klohRnvkLparbfOL5wBIlUwHh4bAPJNtx5jXLcNKlzM5zlTUefOifPaqdkeZEIMTwCa7+FBk9wBo5hUXwIEmmv/9M0qTHVl7fS7oM0yQ7aZbt7vaYsZtxeXXXax/7Qmb3h5TQGPQK3sTRqMTQvl/UZl9rHU9NNMJxt2Nfh6dPo4L5U0j6Oh0WI54jvyXEi9OpdPJ8/zqGKAHcChOi0aGvgRUkvRFHUPRFxQo9qHR9Hnsm+XiQ//+yxnThur/Ezr9+X9h640XMmq0IWC7DHRkWIAjn4ceuiK54Izr2MXTEWy8JUMJrbgL9JjQEi+ejD7TgA6NTn0qJr84hOfjLKpOuMZq+sy4RYC29czK+o94dyXHsUr9GVlTLC+g/eIheA0bizfLeQWTgn7erPIqWomh9OaaHesXbwDtl;4:r2RVfJ6kGEvYTRuZnt5GRqSpUSEZzIs93LR5d4qW3kZVhpThWJ00xGPQ10b7WDFxWMl4CCygPDKVP9fdifboyDb1ULj8umB7ie6AMHkSXG1VddXBA6ws/34mXJdU+xANGAEJAwBMIg1SELON1vPzNUw0eZVtbugf1FOlMEZhtSIVFs4ByjVv3Dz3l0cnMA5uOGt1gr+E+6YkAkmXPvvd/xNgOM1Qxo6kRdSmA6nwcoFvDaCGFrsROpRBJXDTol2cLmC3MGueiSUsNH3TBSJJ2g==
X-Microsoft-Antispam-PRVS: <OS2PR01MB127523617B6D844DDA204731D95C0@OS2PR01MB1275.jpnprd01.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:OS2PR01MB1275;BCL:0;PCL:0;RULEID:;SRVR:OS2PR01MB1275;
X-Forefront-PRVS: 073631BD3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(39860400002)(366004)(396003)(376002)(136003)(346002)(189003)(199004)(229853002)(8676002)(103116003)(6666003)(6496006)(3846002)(50226002)(8936002)(2351001)(6916009)(2906002)(52116002)(7736002)(305945005)(6116002)(478600001)(2361001)(446003)(36756003)(47776003)(23726003)(11346002)(81156014)(66066001)(68736007)(6486002)(81166006)(76176011)(25786009)(5660300001)(386003)(26005)(966005)(6306002)(217873002)(97736004)(39060400002)(486006)(105586002)(4326008)(86362001)(106356001)(6246003)(107886003)(16526019)(476003)(956004)(230700001)(76506005)(2616005)(316002)(186003)(53936002)(74482002);DIR:OUT;SFP:1102;SCL:1;SRVR:OS2PR01MB1275;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cybertrust.co.jp does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;OS2PR01MB1275;23:q/ts81YZW6S7VJtANcvB30qF0UXUte5eIxvoL9fsE?=
 =?us-ascii?Q?xBp2KhaQ4IcQYFx0CJP2UktCgTlo7pcrAGjyoHni2cmk7O4mkNpkNJRyplZQ?=
 =?us-ascii?Q?p7fMLPEtTdbV55zUaCgAWpPwdb2ifWc0TrNghHsNl8a/GnFpGtM57Twm6v7K?=
 =?us-ascii?Q?wKNMhF+c8OVIUjdv+Ekt4mtCzoVNl/HHzC3crwbkCMg1gG6PgFlN+ykdgupW?=
 =?us-ascii?Q?rS7zxVcW8Yx/q08kHAZY1KVO0lMxjkUNRU/kavv4j/wr3hlQ8+uhUIfXWb6M?=
 =?us-ascii?Q?1JQfepNR1FCOmfnFC6lakEMrCzVWl+AvomUN4Hn7eYPWCrNmhc/r43xubOpv?=
 =?us-ascii?Q?enPbxkzwzoOCzPwnUmy8tUgIH9TqaKSNlc39Vbpsny32eAxEs84ryhhavhwr?=
 =?us-ascii?Q?+rg8luZ7XO9Vuy/evhZ3/1fDofAD9rTvT24f1LvAjFCqf/Hty7hKYakrMZur?=
 =?us-ascii?Q?n7WsrdCMoEWwbNv8xIMjW4rams45G+ACKUIksy76QEPIYx1pgLduFdSJEQwj?=
 =?us-ascii?Q?Q2dmnsuLzmVABdsitse2z82twcqmUetjLH73xCr5DnhLYPP1R91DmkJ1+sBR?=
 =?us-ascii?Q?FcUkB8daPUp+sKnPghktxtvFLKinJPb/DOovgyWVR7cdJZ7+QKZxNctOpry7?=
 =?us-ascii?Q?3LNaziMf5CGTeQypXmvWLhqh6V8cMYFj5c8FPSQB7nyiGnZTL3wv6BzJOCEj?=
 =?us-ascii?Q?MnJ/JjBJIjGOtdSx1hkRY+laxLv7/EM8y+9Wc9MfGJ+HlqsAJtB08gCF6YfU?=
 =?us-ascii?Q?zJ0Pe18qgr2SV6TiC/iDrMsKvBWVcYtJv3dXVFSgImiQBJBMBiEjkKq/UIXC?=
 =?us-ascii?Q?gIhwNsE5OD0g3usOC6npknEYFHe6pTyR9zE9Bvjsq+zGoJrwCzw68TH+g0x1?=
 =?us-ascii?Q?LbPjVyFJywBWfnRMa04XLwbhBTjWojru1rAH0MHnJOTdqus0BsA4tK1qkM8q?=
 =?us-ascii?Q?dKaTJzUxiAHwF9g/1LbMY8CLb6iIWWqt6+I25YUTQXnBQKgCIWxa88AQKAAx?=
 =?us-ascii?Q?PPHPj386f2kC/cCK8H4J5NKovfbLfm6TuuZpbggRc7jeeTITPGXg/Yi8lVGw?=
 =?us-ascii?Q?VkgwEmDr8hQ6zZ7cmrts96sLB9EAtHJeGD0UrOHIQSa1WhDd52c7GzYTrzHU?=
 =?us-ascii?Q?4wlHNGK5cPNvSc9jRI47uJuKA0WS/8iei6qYCnV8UJh8TDzwQxAEm/dGFZ73?=
 =?us-ascii?Q?0DlQmNqyE9L4nJxY/Lcj+eZ8WHwrA3Y0NgCzrId6TcoXmdaP3Fi3Iz8YhQ63?=
 =?us-ascii?Q?I7ZOCTbYQY3zHD0I+nW/t1bekyrvgi5c04dJfdmU6YVmmOYXnHAuN8o/efxg?=
 =?us-ascii?Q?h1kpR+3m0GhSf51jxOxdg/yMZmWhQBJCpFcnFYjxRGs6a79cSWvMd12mrJkw?=
 =?us-ascii?Q?4Mi8QHaQyFMQHO+FSPyG7NxyoE=3D?=
X-Microsoft-Antispam-Message-Info: mK6bqX5xiA31inez7UnBAoKQR6RaRd08aLnTc5tnfm61am0dEZq9LsECXkLo9LcwJz5OCkDT8XBeLocHqkSQYauV9P73QBah7QJVNtSzLCmE/Di7pyp2HdWLkXt+Yx76vDlvqGxjpG2UYepKqqxNHsntTx1/fKamZKimxB5frjlGzMnAv0hOt0muc8HtkjOhWyk1cdBus8DX46lYyK7iQQSZ1LXI4MXDUt//DNBJ/3Z925Wl7aN3s1F4OzZrgcoGt6Cj/felL55qCMGWZhHLJvYqbJOBvvnmIZBzZHfq37MahHdZmoue9it37ItV/LVz6XmiA1ii1V8p7CMDhjGh4gWGUk675lub/0iU6PoBL6M=
X-Microsoft-Exchange-Diagnostics: 1;OS2PR01MB1275;6:kMAMbeHRIFnZ+SRwzS/vb8YrmMU3LRnCz4Ynt8T0cipgXPLC55Jf2Bs3FdHVv3h0ZAvJvNcn0RNzyXVcLq+NNboZxAIAYsurUfOJctb0F1NnU6mb7Sw8zFKHT2hCWvqzScDcKord0wqjGml3AbQ4oTMarkaqtkXLicOTO+jrGvDZb57xGUT8m8lHlleiEHXMjrIjIEYAUrH6+611CiSh9vAtzCifx+HVPHOI9PUSRa1q0uv5rWm7HuimT+ofzWWyTBupyrnZ0tQ+RwIcDPoLi7sDU0zIoSZREdJMK8XE42L7H9S9tt1bws/otUa11gGq7bsuqoLLHulm+XJ5fsK7YqYZ674xT06uHmQqG8uL3Dm53BLd4b0dGisBxM5KX/spSqhzdEsWDHQ9Rfmdj0BNXRRKcTMUPDE8B2C4rIgFxw+14+h4rmu8wsMpQVzaC4eI0vr9q2eEU0C94FVkOOjV0g==;5:yjoX25dwS2rSlZxMN6kHtz2zYY/oAaExl1PLDt906qCaSXrgB624lI/egoE+k/TP8pMDAwzo9vJKBJgmx3jC6Rbmwu1FupRpJU9UXN9i08G7TjVcTmoXQObi00t91AxuEjgG6NlVg56y92Filk+dqHz8Unv4XMhVcYF/yEBdaqc=;24:FgIDjoKq0t/R3xi7pprSmavfHYDIP2uJUk70wWO8vyXzjJnc1RBddn7cpRu8EpQnaJQ5iIIrP+Le8LHIOnTdkpLm9Rdgx8MWAbJfiJtAUMM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;OS2PR01MB1275;7:2gWVy1txqJUQjST7w2DA3uS38P3c3M+D3VZMoVprh/4HTAMG2poLB0d8xOYDHt0lQGtq0pFGcFSg3nmHzTsRwiuwc2YAyaTmf7LjD9AWyoXsLIgSFiG+LLYH5k0QnMeafsOAaLfR0RODLQqavEDaDf5YoEfg6Y1zOlbUQ8sX62nWfn2DcArk8P+ilOzDLivy5Oejq46/+vu7utKXLMxoRlHMbQ3bchForBZcSoBt/lQVRWovUqQu/D0W4BkSn34f
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 01:47:37.8642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 143282e7-4cbf-4894-0ff1-08d5eb87468b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS2PR01MB1275
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  >   > You said that the PHY is being configured 3 times, and might be doing
  >   > auto-neg three times. Often a phy will not actually perform auto-neg,
  >   > or do it much faster, if the advertised bits do not change with each
  >   > re-configuration.
  >   > 
  >   > So check how u-boot is configuring what is advertised, and look at
  >   > what Linux is configuring. In particularly, look at the pause
  >   > configuration. If pause is configured different in u-boot and Linux,
  >   > try to make it the same. Things might go faster than.
  > 
  > Thank you.
  > 
  > I'll try to check out u-boot side by mii command and Linux(server)
  > side by ethtool.

PHY setting in u-boot and after booting Linux is as follows;

We may avoid second and third auto-neg if both settings in u-boot and
in linux make same value, right?

---------------------------------------------------------------------------
=> mii dump 1 4
4.     (11e1)                 -- Autonegotiation advertisement register --
  (8000:0000) 4.15    =     0    next page able
  (4000:0000) 4.14    =     0    (reserved)
  (2000:0000) 4.13    =     0    remote fault
  (1000:1000) 4.12    =     1    (reserved)
  (0800:0000) 4.11    =     0    asymmetric pause
  (0400:0000) 4.10    =     0    pause enable
  (0200:0000) 4. 9    =     0    100BASE-T4 able
  (0100:0100) 4. 8    =     1    100BASE-TX full duplex able
  (0080:0080) 4. 7    =     1    100BASE-TX able
  (0040:0040) 4. 6    =     1    10BASE-T   full duplex able
  (0020:0020) 4. 5    =     1    10BASE-T   able
  (001f:0001) 4. 4- 0 =     1    selector = IEEE 802.3


=> mii dump 1 5
5.     (dd01)                 -- Autonegotiation partner abilities register --
  (8000:8000) 5.15    =     1    next page able
  (4000:4000) 5.14    =     1    acknowledge
  (2000:0000) 5.13    =     0    remote fault
  (1000:1000) 5.12    =     1    (reserved)
  (0800:0800) 5.11    =     1    asymmetric pause able
  (0400:0400) 5.10    =     1    pause able
  (0200:0000) 5. 9    =     0    100BASE-T4 able
  (0100:0100) 5. 8    =     1    100BASE-X full duplex able
  (0080:0000) 5. 7    =     0    100BASE-TX able
  (0040:0000) 5. 6    =     0    10BASE-T full duplex able
  (0020:0000) 5. 5    =     0    10BASE-T able
  (001f:0001) 5. 4- 0 =     1    selector = IEEE 802.3

---------------------------------------------------------------------------
root@imx6qdlsabresd:~# ethtool eth0
Settings for eth0:
        Supported ports: [ TP MII ]
        Supported link modes:   10baseT/Half 10baseT/Full 
                                100baseT/Half 100baseT/Full 
                                1000baseT/Full 
        Supported pause frame use: Symmetric
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full 
                                100baseT/Half 100baseT/Full 
                                1000baseT/Full 
        Advertised pause frame use: Symmetric
        Advertised auto-negotiation: Yes
        Link partner advertised link modes:  100baseT/Full 
                                             1000baseT/Full 
        Link partner advertised pause frame use: Symmetric Receive-only
        Link partner advertised auto-negotiation: Yes
        Speed: 1000Mb/s
        Duplex: Full
        Port: MII
        PHYAD: 1
        Transceiver: internal
        Auto-negotiation: on
        Supports Wake-on: d
        Wake-on: d
        Link detected: yes

root@imx6qdlsabresd:~# ethtool -a eth0
Pause parameters for eth0:
Autonegotiate:  on
RX:             off
TX:             off
RX negotiated:  on
TX negotiated:  on

---------------------------------------------------------------------------

---------------------------------------------------------------------------
Masahiko KIMOTO,Ph.D. / Cybertrust Japan Co., Ltd. 
mail: masahiko.kimoto@cybertrust.co.jp
web: https://www.cybertrust.co.jp/ https://www.miraclelinux.com/
