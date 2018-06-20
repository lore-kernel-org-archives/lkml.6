Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDB7C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46EDB20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ZcdR2171"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46EDB20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933307AbeFTVAx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 17:00:53 -0400
Received: from mail-db5eur01on0063.outbound.protection.outlook.com ([104.47.2.63]:47664
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933004AbeFTVAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 17:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOC7ZH+PnI4on5ZsXwQGg9KRd+W4tZcHx3L3f7yL32U=;
 b=ZcdR2171rr7CUS/1OncsfSfzJAKElzqpBEjDnvE0JeV6J9PX8r0tpHiqquA0QcX4mHB3ocOCHOa/dgVh1LLncKPde9Co+3AElOyAl/ibbvA4T9rCf8sDuQHwEoahyu3dWjWGViu5HR7MoxZlXJXgjGMR6mEi8hGG+RXRBoxRWdY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 VI1PR05MB4461.eurprd05.prod.outlook.com (2603:10a6:803:43::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.17; Wed, 20 Jun 2018 21:00:43 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@mellanox.com>)
        id 1fVkDU-0001Fk-QO; Wed, 20 Jun 2018 15:00:36 -0600
Date:   Wed, 20 Jun 2018 15:00:36 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linux Torvalds <torvalds@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20180620210036.GA4734@ziepe.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: CWLP265CA0165.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:52::33) To VI1PR05MB4461.eurprd05.prod.outlook.com
 (2603:10a6:803:43::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51f6ace1-ed71-4c15-824b-08d5d6f0e321
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB4461;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4461;3:LGp7PqgSEXGhFj3ah3Wcfub2eyAiMpHFLlYFCCQznQJ/etNixeo1xISomRt5Ob59voumYvpkOpsNEeAzLiPe3lT3O+9/3DpgTbSLQrBeW6MyV/cddDiCxVW9jTuTFG3XuCTB3JpL0KVbMbTqu/wMl024dYZYjGs2grJSfdkn3mZGJCnG+8hmPS9GwJ9fGH7Hjo+0d5tHuKpW82k8sHWOQGqnaNi2ymHDkWufQWZFKTmCSw+MU+PFZlkmYdmFTMR8;25:bRAfOh5tHywh/8TT1VHL1Qz9qMtWhhQa4IR92/2GzciKJNFgrub09Rh1To+DyWFKpEXhTkBRXVQV7sMpZJ8x2H3ttc97Tp0bhGTOebJfRee+3X85Ax35LowlKVbdzbv+b3a7nk6tEFzTRAsQ8/wuM2puLvu7khiILtQzDeYeXoXxFQokBnKmsnOcdKf2cvBAp4mhyb6lS334IJPA+es7uiQxwtT5j7NyM1aNbRffkiT4hG6POpR4xP63NFda8MN/dbyaXDivuI50O06MgNGW8zlKxteOBHj6WJiWKrhCGZyeyH0BMsskHZcxXoo12hcMHvAZav/JLulAa8jbo1IiFA==;31:PQ0wTW0ovmgEcMkURdwJmc0pCBD10uZB04xWkuwVT6DeXOeK+sx2eNHZYKweaAX1eMJ/F99gya1piuXT6o9lfNnhpaJatpCZqg6f4CNWjclk+aYizjHoC7b9b83Er3IqvTPKXGuc3z9NWdfk2xHa/USrduPQuXUIQ9Nttl2mYR+WUfviKb0GB20OifFL/C9V8Cnpf1SCQcqYRZTCRHXucB9lbhbZgLXj6A7cPewKAao=
X-MS-TrafficTypeDiagnostic: VI1PR05MB4461:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4461;20:POLNJ08g4pVQ2ZXZwZNde0vuBS6cKUu+kjhXqILdTt1HSSDYCHXIccP2pgSe3rEiA0bwrcRYxKgjNo3BVF3Fd+KNhABWGAt8TGAhWv2SyRJqmfY9zAbS3/b9zdA6+Z+Zn/P/KoZGfkVrHDa3v5XpKwlIh1XMtP8mOS0/RntKVscXv5UyfRgIe6xhcFlj7CLBJ8AAh5OljCwqIKHIMA2lK7vlZ+Y8sBt1p1quY6Fde9HBrS+75HC1jP4H+Pqkwv0Qd9P2VN4bCpWdz4XTl6OgsVCrtZKD64S6g7r+RFa96CvBWREIJzj/bc661TUGx0EiwSzP1zWHt14py8PrYQjri4dfsJQjfIVvetpZK+SvXU04guTJ/pwVbhGvqlStV7xlfi6Q85rv8v7eOLqONZ+nKexVpR0hD+Udoq/9ibxHU/GcRHk2oBjFuW1JmuxAoOUXg5DgJOe4Gt/ewiUmS2BSVJ8/ZC9iNyaxzNor//gD5aNy+zgblelpjUvWcYxGDLVj;4:7C5DtH1nWc2YhR73Ey+LnlB1syO+hkTRg1Vdps5vG9YLhIHnKW+PgVQjvzhRzIeQaQ66aw80zuoFrllpWsRi0duZyX9f7BfCcgvn4SG/ncX3EhnWJLm0VaakdJ87LwEVk5Aq4A+0Z2C0AqhFl1gq2DLastdw6xoqnJKWI8Ma8lTRd065pTmj3W2mhSdZSQ4ClNl1VU7lRUc3d4sUXx8JhOLMDfwRlgCSjfcgtqts/q0c3itV9SWpcKe6j5wUo8qcolLr5d+kE3dJJQUW1WRaAyDf0sg4YcDNFJGzBUzmjifZ7ZGkIe5Syo4Gc5zMdyOs
X-Microsoft-Antispam-PRVS: <VI1PR05MB4461037447D80F0C619CE1CECF770@VI1PR05MB4461.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR05MB4461;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB4461;
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(39380400002)(376002)(346002)(396003)(199004)(189003)(5660300001)(58126008)(33656002)(52116002)(16586007)(476003)(1076002)(46656002)(6116002)(316002)(186003)(3846002)(486006)(26005)(66066001)(2906002)(110136005)(68736007)(33896004)(106356001)(83796002)(105586002)(44144004)(7736002)(57986006)(478600001)(9746002)(305945005)(69596002)(59450400001)(8936002)(86362001)(21480400003)(8676002)(81156014)(386003)(53936002)(36756003)(9686003)(9786002)(122856001)(97736004)(63394003)(4326008)(84326002)(81166006)(18370500001)(24400500001)(42262002)(2700100001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4461;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR05MB4461;23:SNzxNFmaJ0XKzwrLVC/OVuzztnxrjRLwUVjPx0OYB?=
 =?us-ascii?Q?hKJ4ApWtM42UjeyJUc+WX5oDdwlHsVCeY0E8GoQ4aJOEXiOP/XaOu9F9ezq1?=
 =?us-ascii?Q?46s/ffZFkJg9+PuPPEa7dBnmkMUdipcMor98eRXaOtFROOuO4jOwb77z0GTC?=
 =?us-ascii?Q?rRKks/KMSkt4xA0riY4DUwruQJxFL4Ff0+tk6OEVOryzUgFrOyyvC1RZGouy?=
 =?us-ascii?Q?3+Mi5pDf1GLHtwsmbHrpPaC8KX9Rp+VUpBht4o5yQ8pOs12x5CuCg2lhosIO?=
 =?us-ascii?Q?1RQsmHyYW8PKWM0/+7ejBNkB6SHB1Gx4pKYX0UfBHfigbFE24pI77E4DuVIS?=
 =?us-ascii?Q?idmMiE1/spIR4iUNZpp1XoXB45BUPsWlJ8yztCcrT7WUylCRIIQIuRZAYCY2?=
 =?us-ascii?Q?ry25FgZoKzW/OEcTIzF4Xa99ghKsi4GxWyMnrzY8Fwpmr+LA6XMQBwW5v7SR?=
 =?us-ascii?Q?S9bjCd6Wvi8Z4lCu9VC8n3jTcWwF1YmaFyy+x7Oa/IA4I0lUNF9RLJhU42JH?=
 =?us-ascii?Q?AaUKRBIxWVXb/LE58De5W0YpiOYZFAldKuvFVPAoRJeHPWla9gaUj+CxmWhK?=
 =?us-ascii?Q?XMJ6/0vdrzZjcmiDqDiN5c8xWBbdZniTItwU1TkNaeaRG3q7mYghHUrZbymm?=
 =?us-ascii?Q?NuUF4PmuyoGW6mOvbDJOR29tbaG83pNlLmK9OHm+gjAAZkfDiKZNQx+rwKuh?=
 =?us-ascii?Q?7kbP0vVP47yy4dRwlaFvGYZZTgZFZ7sBoQiH+uaKG29NEMUml/TW3ZAUbbO6?=
 =?us-ascii?Q?FBt/tizCdwoeYE6pV8aCXdlSbA7BSjW3dFrYxmABHDGVRyEydKFA0qRgHYHc?=
 =?us-ascii?Q?3VSY7KrEesio4JZ4YMdweoARudGFrq+a3HhxOvhOSj/faZE7e7nfKOk196xS?=
 =?us-ascii?Q?CMsCDjKjHCEJ4pnILHkVoYauNXkiNeGxr7tLjlNs/I5tPrsFl8/SiQs8CRES?=
 =?us-ascii?Q?F/YXjyoJAhWKW9G8hbiTzlVDphlJqzkGRT2mWOKFA96DlNBgQ3cqPwBRWNAH?=
 =?us-ascii?Q?UhCxeY93LCQSJkUweepjvGiG0J8a9LChjTkmTHGDm1fNy/iIapg5y3KSQtiS?=
 =?us-ascii?Q?HeKlXnSD5Wz5ubP8ARbFCcGzvUGLQQ3wPhg4DLkYcuwyo1x7ye7gZIGrqiU0?=
 =?us-ascii?Q?zMuMAko83dxwOckO85sHcTS6s+8HyBqhrex4W/GHkyzR031ftfTTl5fCz0N6?=
 =?us-ascii?Q?sRzviihKnwf9283IEaOkXrP+I8QRyvGbi4dscyWG6LnrMKEfHIxLCL4dAEoK?=
 =?us-ascii?Q?nXKwpANeesdtiJuvPJnlxjmOMrTnqPcF45HPEQsBF2FkaCA5U3+jk4dbAy7p?=
 =?us-ascii?Q?9a5QC+NxMcsSYXr1N98s9s2aN2KrFJy1d86pyGDg6VS?=
X-Microsoft-Antispam-Message-Info: Sqx+a7IZH8S49hmcNbVmbqCzj6vDkB/eiDVFxdSJsUPTyWZDqHFKHTDPVV9+T6QrDc53ZuEXwtLct+P5m8djWQfNE/C5AeCqL19MNX+aoR0tN3tMDXMAkj7eUfh6iFlYE4aAMDJ23mWMvKpO0qDDPRVT1y9ZGwEt10D+8/Awj5jE4W7DaV9WE3E3cpi5+SWZzo6sGAJ3PMhk15XYfxKswkhsarl7v38+Ec3kDfb7WiXXeMPExey6IwcQOWxVpsPi3Wv3VOXWX5yk39+W4t4dJBzlFSdG5Z0oX44TXGc02c2e2Kr0t8bK3eheC5C3++jIroCvcJBaoT5x5HLSiu93nA==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4461;6:RHtqnRIhoAO9W52mxkSAi+NLIdNgXISygWq8jinRkVP9V3LbRU4wnex8iImlR8M9e5klqjRYAha9/5fnJaKDovM+LmqF4de4Lj7pzb1Srgrh15pKYyHKUA8ZwXiTe2jxRQh/h2EeKFdcNC1nHphGrmnyQ/8BxQQhQxFlgZHlkfyyrxX4A/L7FV5CVIfXPttNrxa3LtocQ4BXk3AB8AwFRMd+DMvxfB6oSF6NkL4p9qht4WyCNFpwQtQutVpv9W4sffiqhUoLPZ0VHNxR+3qIJtTGXkdRH4YBSEReUcDWjVZtEobWPSUSMpLqiDgyP3Npv0Pprovf1f8zSNfLQFgRig572+q3aeW1wcpWxaunfxiXW+ol3m41w/rpQRuMUakSl8BY/EZ2hC3pBzyZKKtrjHGw+KqKJynbxz/N23xrDOeJ8wudk1fUr/0eg5+D+rEIo2CLSn8FvD86r5pOzLx0Tg==;5:xipB4lw6N30u2YBO1pOmpx1GxmI8H96ccWfio2oDvKJSSmmHSVvBS921x+Tm1GV/jCgTNI3Z4vgzqUL4F3AZj7n8OqIxB5FL3Hi0ipQXWZ0+yTIybTOk10Raxod2p4qaoF6GEJvJ7hvB3FKlb7GAgoHCUckzzs6QOESbyiSFjJo=;24:g3PcPrkQWP0N9UEDu8jyJIYb3LWwrJR47vYsE9t0wzw2Mzu0x395EK/HxDnmYnZihGsEADhK4SYnHWbyUkQtA3MwV6l+PcLKniC1YgLA7nU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4461;7:fyNHjbJvwtUnkmBAKIXWh1WbR4Ydt3uLFxetIwBsa8I1UFaCIZ0SvbKQtYtxhJTbPRxiF0vBKCGPMY7f1Cx5JvZ8zHp1XKim9CTnISsLilUbYX4AbqgdHY/k0QXXy2r1sRkvbMdRWN92+e/yUJCgHWdWkfJBbFUbeUkBf0Yp7d0jiJY226YvFO3zo4fhLZTt/2r21/xCoHHB4Kt6Amy/TQmL9BrQiBGQJA8JprrIfpNVEYNEX4TV0q2Q9qHeKC+s
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 21:00:43.2071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f6ace1-ed71-4c15-824b-08d5d6f0e321
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

First pull request for -rc

Here are eight fairly small fixes collected over the last two weeks.

Thanks,
Jason

The following changes since commit c1191a19fecad92b73c25770a7f47174280ca564:

  RDMA/mlx5: Update SPDX tags to show proper license (2018-06-05 14:04:20 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus

for you to fetch changes up to 375dc53d032fc11e98036b5f228ad13f7c5933f5:

  IB/rxe: Fix missing completion for mem_reg work requests (2018-06-18 11:36:13 -0600)

----------------------------------------------------------------
4.18-rc

Regression and crashing bug fixes:

- mlx4/5: Fixes for issues found from various checkers
- A resource tracking and uverbs regression in the core code
- qedr: NULL pointer regression found during testing
- rxe: Various small bugs

----------------------------------------------------------------
Bharat Potnuri (1):
      RDMA/core: Save kernel caller name when creating CQ using ib_create_cq()

Christophe Jaillet (1):
      IB/mlx4: Fix an error handling path in 'mlx4_ib_rereg_user_mr()'

Gustavo A. R. Silva (1):
      IB/mlx5: Fix memory leak in mlx5_ib_create_flow

Jason Gunthorpe (1):
      IB/uverbs: Fix ordering of ucontext check in ib_uverbs_write

Kalderon, Michal (1):
      RDMA/qedr: Fix NULL pointer dereference when running over iWARP without RDMA-CM

Vijay Immanuel (1):
      IB/rxe: Fix missing completion for mem_reg work requests

Zhu Yanjun (1):
      IB/rxe: avoid double kfree skb

weiyongjun (A) (1):
      IB/mlx5: Fix return value check in flow_counters_set_data()

 drivers/infiniband/core/uverbs_main.c | 14 ++++++++++----
 drivers/infiniband/core/verbs.c       | 14 ++++++++------
 drivers/infiniband/hw/mlx4/mr.c       |  7 +++++--
 drivers/infiniband/hw/mlx5/main.c     | 36 ++++++++++++++++++++---------------
 drivers/infiniband/hw/qedr/verbs.c    |  3 +++
 drivers/infiniband/sw/rxe/rxe_req.c   |  5 ++++-
 include/rdma/ib_verbs.h               | 13 ++++++++-----
 7 files changed, 59 insertions(+), 33 deletions(-)

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJbKsByAAoJEDht9xV+IJsaH+4QAJNtd1WhZmlurMBMbKUaOqjC
7IQk9HmsY6F4/DUYBD3Q1naOu4zweWugtk1Dw8Et1kP2WQxF5DJoHK/9dE6rtTZ3
Wc+KO8BnaGaCJvAVit8IzBowGKW2VX93GC1qawtfZouJFSNAungbgzmNjKnKlWa3
ruqL/D6BxGlh49zd5ZaMNzCxdiGb3XI1gBjltFL3IdcpZnXmBy4hR9645aKLNXt8
UySZF5grUzXPxJV1R4esXzOs34UgRArCxrEpwvx1K5r3HcaGkbLgkkT9s9DzmsJ2
aVJQ6PCXZXmjcarFh3MI8eK5NwgLse3ud7oIJ/14a0QVXBrnFR3BYlThThCqZCrX
uFVrndDRDk1d08fDsQJRaL7OWIfUXghOuBQg2yIJx54KtXRa1FQ/gH8z3mTWtCwd
SVOAcY/EEqM3XAvNkf5NsdddHXWqQ95/21foNZByP2EtV7Qlsxz84hjBpaoJ1ybk
vp/ubFP2pV4Adsz5V1ZnfG0mYOT1rxhGYGw+PMErpPLt5v5fJrvPt10djKRbQW4a
lrnsEqhyb/5qaqd7wFEZ9pEKoqQXg8Izzu9x1s6YbZnVBwIfNqwfoCTkZzD4BUQV
KWk45VEKSkMuCxkpdrigJ4e2yYmrMsRtGCj6zh7AmpS5B0tKmsvbpMCBecWq+GBc
G6aHY3ywIFw+P0wJM1yW
=l6Gm
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
