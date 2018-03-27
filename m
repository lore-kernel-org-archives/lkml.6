Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752258AbeC0OeI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:34:08 -0400
Received: from mail-ve1eur01on0061.outbound.protection.outlook.com ([104.47.1.61]:14366
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752125AbeC0OeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:34:05 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=petrm@mellanox.com;
From: Petr Machata <petrm@mellanox.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefano Brivio <sbrivio@redhat.com>
Subject: Re: linux-next: manual merge of the ipsec tree with the net tree
References: <20180326091610.148fc62d@canb.auug.org.au>
Date: Tue, 27 Mar 2018 17:33:43 +0300
In-Reply-To: <20180326091610.148fc62d@canb.auug.org.au> (Stephen Rothwell's
        message of "Mon, 26 Mar 2018 09:16:10 +1100")
Message-ID: <wih7epx8u60.fsf@dev-r-vrt-156.mtr.labs.mlnx>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1PR0901CA0088.eurprd09.prod.outlook.com
 (2603:10a6:800:7e::14) To DB6PR0502MB3014.eurprd05.prod.outlook.com
 (2603:10a6:4:99::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d9319ceb-4ac0-43b3-6c23-08d593efc880
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0502MB3014;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0502MB3014;3:QFr9mROBnfqkneoqTuIm2FtIbL9jdHaBCmfA3sR19MnMqH1si4ZNDX5O9kNx9uwcVAs+M13TJf7lz+NSNi0+yYIfORh9+WzhAW/+ePZd6bMN+Xyy8T6N/F7z6HhGmuzkHpH2brDIwhn3drnyV5UJF+25zDPRnbb+6EQtfnUNBPoqksdDYtns6x3HkMivjjxO61rk7OdlwP+bVmcvVIkzU+xvycvJedwdLaCOGNVFAM90QcsdmJ0R2eaJfuNPXOna;25:gGPk4dvVnsB7C9+kg823W3sznP3opv5VvgzNB+9QvjMNORSlzv3d9a8Prq/qRxguQRIce9y3ZxJYPNlAnF5WvlljYFHAEnii7wBMk73JlSza4HYFM7TpELYIeIcI1qx+m/BPeTT/5nVx1e5vcBSfchKbWQoKBV62hdxO8SrZArvq2mM4/2qtSdvi0KF1WK/0wAmen171fLjQ6pfVFP6Fllk4OyjjPK+hw39Sg+RE7Y3AveaoAR/Y4FqTVYyQeHWlQtfcGrehYxtENjlAwBK+vYbkChY5FZOOnD2GnDjCANI8bF1KXw3QdR4dXzzPnAV3dhi6YdnC0Tcv+RarRYV1+w==;31:QEmp21+UpZC6hzeyuFJCRuX5wi/wgmLtTuazXsxTlob6XCcbrWXU50fYbDBuyluaa6mnKnMveGZ7YfDW+PjIIwbRzfHHnIVTZvq6lCzprSfuanH4kzQ9z29U4ZIBUjWO67s7LEhENfFBLFxeeZLThgg9371M8rQ5Hfnnnt7I/8S0Yd27TFRyvroXXHGVg3+lw7Qaaf5GvWlCMjr60emOB54X1dU6XKFNMJKlpwWtBy4=
X-MS-TrafficTypeDiagnostic: DB6PR0502MB3014:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0502MB3014;20:+4RTA+5Z//GKVqRto0h3cKRdxoLSNvVksAjrXaysi1Gv4MwBEae7+2ljV6rKQWbK5lPdz0VP6mp/NozWhPSnZlJSfz64m19rHl9n4VXrDm6I5l9PDN1EcYMm1cCydp7hlvKIf/xU/KU1Wgbg0ph0Z64Y3ZYACUZAiHARYAcXGS4LZ0is9JI7Bxq72dYsn+HG7XrzxlVnxB1vXMash8UJDYmGYMvyaYtWKzO57ETVHhFsCcacNJJRCpPvT/ous6lfOO21Jhm5LgiAtof5AJWihmzIVppJi/4ZG6k8VvlFOYzto2KSYx5gxVD0RJZLYbp8T4LtLsWKJcPkKd1/Uz4nIWyDzLG3cSazzIyyD9m5ZQKc6xko4P0rCpbpdsURUnuevWexdxVSE2eiilEQYHud/cluK3uMoa3pfGCN13NQtnsK/heRUpqkqiuA1v0RoFXAbUJK8z0AHRDgyAQaP/TsRIGHJHCvw6aky7CFe4hZR/EV0DTAbycvvDp7yIqQ5cAb;4:jFW3Jt1UR+deBFOTC2GRzytkV84S0olT5wK6Do8Qj38+m3ZxSx1vulqejqLD3RG91s2SA0LN5qsr3Tq29YA2xdxS6pPi+1Z1E9iM6FYL3ni7YfSJOkpe27Tu/XUd4MQ0Kh4z6QcZpua3Axsf5mQYGA1LYM4yzoxidnBqCwU0fSXu08neSmGH2082RoUHYtd8mUz/GFuii0U1tOdVWPXMUogt21syaUKAIctbSBnMrEIFlGJalzFN6u5Uw1mcdEW3F0TKHVUaC5Te6a45PWjggA==
X-Microsoft-Antispam-PRVS: <DB6PR0502MB3014A9CF0F0EC134B101977DDBAC0@DB6PR0502MB3014.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DB6PR0502MB3014;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0502MB3014;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(346002)(39860400002)(376002)(396003)(189003)(199004)(11346002)(5660300001)(81156014)(8676002)(6506007)(16526019)(186003)(446003)(52116002)(51416003)(7696005)(76176011)(7736002)(26005)(81166006)(305945005)(8936002)(53546011)(386003)(105586002)(106356001)(97736004)(956004)(48376002)(50466002)(55016002)(25786009)(53936002)(9686003)(47776003)(68736007)(66066001)(58126008)(478600001)(3846002)(86362001)(6116002)(2906002)(575784001)(6246003)(16586007)(54906003)(4326008)(476003)(6666003)(6916009)(229853002)(316002)(486005)(486005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0502MB3014;H:dev-r-vrt-156.mtr.labs.mlnx;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0502MB3014;23:F0UNsq23D7wTdJ/G60EUGQVKM8tN91uv5YLcJWu?=
 =?us-ascii?Q?XTEhTb1ZKNc23Wt6e2nQt8lX0NmJykgFT7LjilCbMbPKYo28Hfo6CsnbToH9?=
 =?us-ascii?Q?Wva4+rhY871sb7B1NdGkowH0NQchJDY53xtwTW8vYuQewW82Mfus3U09lbws?=
 =?us-ascii?Q?RZ/BLTJNFDYbgPNHRmGAZR7fCZ/tPOw3J7BxIRlVEjrOCPuesg/C9ooZam24?=
 =?us-ascii?Q?Vs++d/KW7W3XHu1RZlsnTwB6YNq4soepr/coBbhvGkdi3Bm2PPJG+LMIwz+N?=
 =?us-ascii?Q?WgeVNd6NZytrsjdT66hGL1wFwovDj3ARI84OPZKHAxA9lwWK8rEEnhHewhKH?=
 =?us-ascii?Q?2QFMWxhIkwZfDuCErPbxgvTA4bzaDXxyPZOdRMek3Hi1f3AFwfP0NiW6M46Y?=
 =?us-ascii?Q?vS19mOzdBitJAMIrQOagsQH4IisD6MC1sqYUp7YYQl03xk24vXqAy3celQ5E?=
 =?us-ascii?Q?gLvSSRnIT42t+VujOyK/t0c4NZEOy/N8nzTmZsCM617v5IGNlT2NVJgfrN7I?=
 =?us-ascii?Q?h7jSiTpPeCuDqFZF5pG/vqvNli7bxlT9QryjgmJMzmLIQWQyZKWS9DprMmPT?=
 =?us-ascii?Q?a/3jjc9C0l697yWB+RF6pOI+dZsu08Swd8XleHomwvrklgoLQ47OLx+hvLc1?=
 =?us-ascii?Q?nHq5eDE4Y3eSM2KhmPJBG4MaT1RumQmlirIxH355KKz4tIqhWYjmqK0CQd+M?=
 =?us-ascii?Q?wsbFbLAPbGqYkUxrcDdfB46pIKjIzAiigdoejXVWXR779Ee1C8iowBAxIoid?=
 =?us-ascii?Q?TCmnTXQ0zW/Sn/4k8V5RYI9My5lG5eBxpzc/3TT5YB+e7VJdsl3PWMAPEnEz?=
 =?us-ascii?Q?VgzFH7CxWRJlGZ564K9IWRcuO+NjDnwHOerWlj7rh3ypzWJfCgWuvppJ6mWY?=
 =?us-ascii?Q?tf1h22UVIafE13kRckcx+v0enOgY2y+Kw3LkBJO3DuVys8sCN3NYpowWRs3o?=
 =?us-ascii?Q?J7qwO3Rv5mXVZz+n6ZQGE3Kmxtsk7eL8lKFQd7viwDbNmrWaEoMb3b1LKGIH?=
 =?us-ascii?Q?pIV1cMweXbEuj85Gqma6VHG62z3xmiHeUdcPLDsq5UpHvDIwVSoyXR4GEEfe?=
 =?us-ascii?Q?5rnWN8ZNORjJYfcHCqkj6sV/2VbUFJ1YELbEraz2pgwPjSUVj6nteX707Gks?=
 =?us-ascii?Q?q9XFLMxComQAX20l03foEKIkobJ701qbu052L71UhJqYXKeEFFnd8TJPKJVK?=
 =?us-ascii?Q?nIwUtlknxVF8PX8gPwuI/M5eXCQodxnO8kNnqQD0csRqRmgJsfD83JO2JZu7?=
 =?us-ascii?Q?RWiEbSUXE+UJtnN9R/De3z+yZPXSIFEPtwrobx8p7yykidc2PIbhNDFWiPuh?=
 =?us-ascii?Q?JMg=3D=3D?=
X-Microsoft-Antispam-Message-Info: qIVxXT9GQiILlMxaWwHTHrthT5Myk7bQtD6NxDvt2Pz1SXFGlcnU3+uysU7pUvYX9ZaxIoUbUpbGGQ20TB+bJpoOP0F0PLF37NCakm0Hk7+hxHDc17l4OE7Sqh234k4XjC7Yt1SVRLUIQKVm9/biCg9F/xrwSZ1h3RWfV9Ce4rcBOytzJN46w85Q8IcEUjOP
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0502MB3014;6:0X3OTZEpLk0wVQ/073iVIhoEWVm9ASWRttPsj0ACwnGJBAJ1L9Ex9LqSAomYFOJLBuV+VgqiI6O3SXRBha2e5lZ/DeiZDAqktHpy/OCs9Mh5CmtQLChDu65hw/qWWJWggcVWHK2mgrW1YxivTminHRGL6gW/FKwmyA9IyejlzhDH3oR4Zn7krhnhUZcnoLQ5u8oOv2ccFOpqlnD4y6iJWiE/2z2CwAJC1fR0yi9gtoovikeAvtQ41pYaMTqcrGdLqcUizMw3G/b0H4l2Izg27aMMBdB5eK1SkvdcBmSmj7dQK8UmMhtQyV/fJI7it6mq45vHIPyvLqnczLIQq+B3mIdTd0my0XXFF8nuipvpNnHBeoeLmInbHB7KpK0IjSCf2IBO54V7JxG+tc3YjuyykhSHscptyMHI7NpBfHw9BDoMI38qPQtd+E36xavqTxXUkcI8SqFGYqZsqBE92d4tWQ==;5:Niv/fH6Wb1fIkqPt634byVkm4HZJSFhczDV0j5krWwrWYsivj78eEEJqCF5QWoyPNjq7M1a9uzuIyqUhSSNhc4bDOnAVp8y/lxHo8SVYKAdcOk+6VzPLK7difK9qzkT+09B5aM33taYbOmLxH+oXnQPTYtmLC4JSm/QUEEzpuCU=;24:xuj8s8HP+pjjWJ96ViW9hmAO7iGPVuMOGinuB6H8AOPEwZNvdM3bdBrdidphmjyvZqG4VThNRZmhCS+M55avSyQH2TDD3VdhQR7iiYbtCqU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0502MB3014;7:4lQm688uEztoKWLNn9olfxWtMoAu2WYW5rPTWMdCLyBYtYTEoxfRhcwKrvwWR8BDbQmxlzBN5bzNP/W/b2j28VydpExYi3ysLUYP5wiav8t9fLNDiBXT1q4njWoge68yp6qdAZsnD7TaIoGGQGF9m2vrWZ9ATjCZUFTDN1xcEF6Mj02Rhfi8YtHvvRA5ff77z83dtQI+cby2JW3FlVYA1KMn2dZwFo2pXoBywmpKDKXkJpM5XXgVyzA1QuPQuJdA
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 14:33:59.8900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9319ceb-4ac0-43b3-6c23-08d593efc880
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0502MB3014
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi Steffen,
>
> Today's linux-next merge of the ipsec tree got a conflict in:
>
>   net/ipv4/ip_tunnel.c
>
> between commit:
>
>   f6cc9c054e77 ("ip_tunnel: Emit events for post-register MTU changes")
>
> from the net tree and commit:
>
>   24fc79798b8d ("ip_tunnel: Clamp MTU to bounds on new link")
>
> from the ipsec tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Hi, this conflict needs to be resolved differently. Below I'm adding a
patch on top of linux-next. Squash or apply as you see fit.

What's the right way to proceed from here? It looks to me like Stefano
or Steffen should take this into the ipsec tree (possibly just squash to
the clamping fix), as they'll hit this conflict the next time they
rebase on top of net...? Let me know what to do, please.

Thanks,
Petr

>From 2c2210e59cd94571ac67d491026d6ea0f4d69ae4 Mon Sep 17 00:00:00 2001
Message-Id: <2c2210e59cd94571ac67d491026d6ea0f4d69ae4.1522155963.git.petrm@mellanox.com>
From: Petr Machata <petrm@mellanox.com>
Date: Tue, 27 Mar 2018 16:00:38 +0300
Subject: [PATCH linux-next] net: ip_tunnel: Call dev_set_mtu to set
 clamped MTU

When adding a new IP tunnel link, MTU is clamped to sane bounds.
However, since the new MTU value is directly assigned to the netdevice,
instead of going through dev_set_mtu, the change is done without sending
the usual NETDEV_PRECHANGEMTU and NETDEV_CHANGEMTU events. Thus drivers
don't get to learn about the clamped MTU value.

Signed-off-by: Petr Machata <petrm@mellanox.com>
---
 net/ipv4/ip_tunnel.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index a57cf0d..de6d944 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1108,14 +1108,14 @@ int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
 	if (tb[IFLA_MTU]) {
 		unsigned int max = 0xfff8 - dev->hard_header_len - nt->hlen;
 
-		dev->mtu = clamp(dev->mtu, (unsigned int)ETH_MIN_MTU,
-				 (unsigned int)(max - sizeof(struct iphdr)));
-	} else {
-		err = dev_set_mtu(dev, mtu);
-		if (err)
-			goto err_dev_set_mtu;
+		mtu = clamp(dev->mtu, (unsigned int)ETH_MIN_MTU,
+			    (unsigned int)(max - sizeof(struct iphdr)));
 	}
 
+	err = dev_set_mtu(dev, mtu);
+	if (err)
+		goto err_dev_set_mtu;
+
 	ip_tunnel_add(itn, nt);
 	return 0;
 
-- 
2.4.11
