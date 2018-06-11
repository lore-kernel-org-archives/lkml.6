Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ms4MEM1cHluzJwAAmS7hNA
	; Mon, 11 Jun 2018 11:28:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2466A607A4; Mon, 11 Jun 2018 11:28:13 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="f3W53pIr"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 798FD602FC;
	Mon, 11 Jun 2018 11:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 798FD602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932879AbeFKL2J (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 07:28:09 -0400
Received: from mail-sn1nam01on0089.outbound.protection.outlook.com ([104.47.32.89]:2085
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932765AbeFKL2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tt20yBFDMxXD3V3KJricrrA+NlZgMUMYOg/9789LXE=;
 b=f3W53pIrnZ2nHC2LSBO+VURItncsBzvEAe4TBKQsH3XpfskDYrdrrb4pgzyiXCmVHga32EG5WhHRcKdEmknFKaG1GpQC0a7Zo6RsLIu+fXFZOBFlSBu6IrcX5qYxCvncqEFMsmwBTPmZ7joSvSbuA+jtcRK+SZZnvB3tibcz3MM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
Received: from localhost (5.63.162.243) by
 BN7PR07MB4371.namprd07.prod.outlook.com (2603:10b6:406:b5::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Mon, 11 Jun 2018 11:27:57 +0000
Date: Mon, 11 Jun 2018 14:27:36 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Andreas Schwab <schwab@suse.de>,
        Alexander Graf <agraf@suse.de>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Andrew Pinski <pinskia@gmail.com>,
        Lin Yongting <linyongting@huawei.com>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        James Morse <james.morse@arm.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>
Subject: Re: [PATCH 04/24] 32-bit userspace ABI: introduce ARCH_32BIT_OFF_T
 config option
Message-ID: <20180611112736.GA19952@yury-thinkpad>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180516081910.10067-5-ynorov@caviumnetworks.com>
 <20180608173207.nwoi25jee52gpdwy@armageddon.cambridge.arm.com>
 <20180609074227.GA6810@yury-thinkpad>
 <CAK8P3a16ByPtCwKbdLQRDRni3qV9DXLNYZ9QJUH6uHaZYHr34g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a16ByPtCwKbdLQRDRni3qV9DXLNYZ9QJUH6uHaZYHr34g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [5.63.162.243]
X-ClientProxiedBy: HE1PR02CA0112.eurprd02.prod.outlook.com
 (2603:10a6:7:29::41) To BN7PR07MB4371.namprd07.prod.outlook.com
 (2603:10b6:406:b5::11)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4371;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4371;3:pfhhU+Hlu+oZ8JmqVnTMf/eQYt0x1Th38XtzLSPdIaPPxHpUJ/YTwRlnoI3YmD5fKSFCz+J5INDKKL0JXexq0YxPjUxeA2DGr4bAuYQR+3dSkzwyH9YpQ+tjxbAqx9GmAoHUz9bm3rS8rm1sGfVHLxesCWPvzANaUEDjSCrxYXcOFU2W/cH+p2piLubZi6x1R8yPUdz10C6qKxlkOsDdEyITnIKEe86FMbBYZmWNZkmAwfHM+uq5UCETCkmUbQrQ;25:SBZf6X+XUkmINoGUfsGjb6RQtYfXPpWrHwHSoLaZOIUfMCx1Gl1cHONHH4cwJOgSsRmx5D2Ckk6QXugSCF+0sOZERDZAhebNp2Jwjk1fIDvXFOdj9aeFpbioA622BzFqwGdNlh3FOH8tYB2MHmX3I/k+B4et2FPoZ2z7KzcnJiq0v6RxSC/cnt4e/UI2zo1IbgzPu5pxqrHWwFW6rPxI5EmmjXqgrmFVHsr0f8Xv7prPD9mKA/CdUr/S0cD8iJ03tU2KroODayLDBhv4lyPazg6z+b0OScH5dRdwfidCAdnsId+edeRHuH8my0+rvMpBtO2iktvsnuPkfwy8DI4z8g==;31:bWK2l2m7LGQTOslpxk9B5NftSiLwBv6ZJgt7muWj4aT4VSmbgQFVgo1FfzWdtKHvkUGJQFMv0VexMpbQTVvex6WOgwHtU8YGl7ql9dop1tcfGrY2Eq/87FS+mYsNEhclrS8sdV48CnsmnZ4bxa00t2JF9i/RJ5cxFOz4Aj3EqIIRVTbu9mnrvUL5PRSBZmfAv8avgt5OSU4bEJxbx/SwRZjf5iYA3iGS/+iZfubhJ6M=
X-MS-TrafficTypeDiagnostic: BN7PR07MB4371:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4371;20:g2WNXsuLsWgIXvmWON5YvW2eZknB0efzB+9kwrj8wehF7amp0YGUmvNWFSUnpMKlZdqanI/4MJRMCpQ5q5yerFEHHw1MDy7r1Izyr5oChGyp9xvbwPfAXViuAn1Xwqe0jUmTIHOFUE8taYtllPICB3b5A4mhoKsQ75UyIvcz3DhAM9qG0fKPTm+yrp12ZlyJpKLUY5TaEVpeWS/o8fc7XNP4Le5yUG2UF23xv9PPVTuTbwX2m/0iUKHyw7HNSFu5CWpI/d1IX2fHJlMMl1yO2G9saTvZiaioPr2RRZw8JXUjEHJcLL+2pAYjuyzibS0i+ORDMhUniFOhkblQ91Tb57HjjVRcxAtl+42wUF67of+o9Uqc40YFO1OClyaXzH1YIFiQvpmMBHLBF3ahR5Bt89+7wvGfIavza16VG0wlI7I0dkD+FFaw4nqnYx2j4jNJJx6sweMsfvmlAOLfyBpybsyiWdCdTLoh+3d2WiUdQeba+7ZtIVFiu/mOZ2FNPQGTB643FGZ5VlsYTGAA0GatB03WRZ1SGhCzCW5w+gU3SQ8ktyZfhWmbS7vD/q1Bfe8CS494sb1mjTIser/p+DyqYrQYmbF5zZUHJaC7ZJrEMOs=;4:AXhrPXUBsd4FANG9Gy5vZSR7ROfZIwemykwxs+x3lQFTf840I6Cc5Rae4KVOIQ4jTunGYYfR6GQK1Nw0rUVVddx1TwAv99VVtBgV3YFlEZkHxWnXv7p9sKPyEH0NWRg9+6BxIy6jpZxxHQz0Tixhurqwsz3tLsg5yISsDnx6aAInC6PHUY5uxSiuO0VpAXkwQdBsyvKhUfxkUgAwvIQCCdy0pld71xq/qym/yX1G1R2DpDq423KucQNZ5CbzdK2u77q50UaMcxbWWeXvUOKnqw==
X-Microsoft-Antispam-PRVS: <BN7PR07MB43718CE40AD6A490863DEF34E3780@BN7PR07MB4371.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB4371;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4371;
X-Forefront-PRVS: 070092A9D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(39850400004)(346002)(376002)(366004)(39380400002)(396003)(199004)(189003)(33716001)(25786009)(6486002)(76506005)(106356001)(8936002)(229853002)(81156014)(105586002)(81166006)(58126008)(8676002)(16586007)(76176011)(6496006)(33896004)(54906003)(52116002)(386003)(53546011)(316002)(575784001)(446003)(59450400001)(956004)(486006)(11346002)(15760500003)(476003)(33656002)(7736002)(2906002)(305945005)(68736007)(97736004)(71446004)(93886005)(26005)(16526019)(186003)(50466002)(7416002)(42882007)(72206003)(966005)(7406005)(6666003)(66066001)(47776003)(6916009)(6116002)(3846002)(1076002)(23726003)(478600001)(5660300001)(9686003)(39060400002)(6306002)(53936002)(6246003)(4326008)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4371;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4371;23:IEs8bxb2ozo4x4ydyBpvJadNKocteka/divsjLFZM?=
 =?us-ascii?Q?nMamipV/JvfIkdSi0+TCyPOLG5MPJ+5pXM2KNaZ2ggd9vCpoADuVOUqPuU0T?=
 =?us-ascii?Q?Ba/7KavOQ7z7hS+lk0HKR7clK0STSKJGjnFtsskk21ctF8psDCY+62NyhctM?=
 =?us-ascii?Q?3PfgwcT/4doaow/o/KbPSjj7LhfZLQvQA9B9HaaHnzkC9UBqKUauOoe4wkt7?=
 =?us-ascii?Q?QSerJxrT67do2GKRzRWkvwx+sAfwyrmCYEQNb4xLmA0Z2sL3GT4X3LORI4nM?=
 =?us-ascii?Q?00g+JbuLia/37umNuUn69/Bl3KTidGLnAjsQ7ZbiDj0iFI12I/MzMzmx9oxQ?=
 =?us-ascii?Q?l0p4v1mujzpb3bzFW5hRFlE8ZXrlvew8mvfwljX2JRvrp681tH3aRDb68Ryc?=
 =?us-ascii?Q?DQ4yE8CD5OCWmeWdhKLlc7S4E93TmleVCiqV4epRPriWJpglD0NSPZzL3Lk4?=
 =?us-ascii?Q?grc3xwvgIMW9NdPPegfF0VYY8iyVA7G4502RDfZcFmDAqCIFbxU6mM4NjBWG?=
 =?us-ascii?Q?kqPea1mH4esplgmuRUL9CAriyE2flfVWovNGIj2T/UlwobF9DQjdX4utzdV0?=
 =?us-ascii?Q?n51xxpC1SFV0q8tio6U5sJB9c2QnVFzTWCrZ5UKzj/RbUqPYy09eLLfOnDTk?=
 =?us-ascii?Q?ROlAepf17DlEXq8DDVdvrn5CjuLx2fUdijXY3lYWcCJSxbM7at3N5dyt2BDR?=
 =?us-ascii?Q?h4YcV5fCsqjfh5g7+4+BvZpwu4IfmzRndwjHSOU7v4l7qD36XzGWjVbLWHD3?=
 =?us-ascii?Q?Is5HKTo0Ngtx53j2chtH8/rDzZ1Mpphob5fbOvNwfqPfkTN4Vm0rd8sPc3p9?=
 =?us-ascii?Q?5I5MEQR5sL7c9QVSF7oezErXVnaiOegAYf78yF+cN/YskgHdqk6YP4/zUlj7?=
 =?us-ascii?Q?WYjRjwszrqYBph+pkskRhRiyLDRCVcxL3gdd0zz0n3D0JQuQ3QnpjLFgx1wH?=
 =?us-ascii?Q?fmhKdVAqpZeRNHjEb9i3gh/I7b73TgUCoJ9og6e2/f0nNh6391BQOhCDe/2f?=
 =?us-ascii?Q?rp3JAVv9qbXukjOkio2KkBB4bS0COjD2yclKhFopEniJKd2xCvpFZt/9bDct?=
 =?us-ascii?Q?dQeM5pvaXHibhAc+/dkTSHWAmHeB4rR3/XmS/31AKF81kGT+jhwN9t6cfN1I?=
 =?us-ascii?Q?YDZvD62JdaKunZNlHm9ST/9x4sycuHfD3FuBxNCDkwIkg50IQabO/n1rUORi?=
 =?us-ascii?Q?T13ROE7nI/qGDI/RQEgP4pLH9J3L8s7ZqRdz2xFpnc2ap5D1oqvby+zT1HpG?=
 =?us-ascii?Q?/Nweg34UdSKAqBcF8+Sotct6menui2YCuUx60H6rfy7tHQiinbYdCxG2EVNN?=
 =?us-ascii?Q?JMAR9bGccjnUiL4AmFsSNA5m5QlFuNbHUGCeO+nL8iKQqyAMNS/5lMieIggm?=
 =?us-ascii?Q?3C96/LOkQU/FUv4daetQAbNpj0Ar2THNJvNPG39RSe9O+bJkiSt6LciFnPmC?=
 =?us-ascii?Q?ujoYIsBUKZyJJG7VDfmgGkslTdEGMbzx8pMDBea9VslSQhKfZlOiWqiRAMdv?=
 =?us-ascii?Q?Wj7m9EKFKfCH6T5+B2rzk+FL0H7WVHhoijONxJDm43lpY1tCJOBJTtShk4u9?=
 =?us-ascii?Q?EAo98XTK6Ba5yWCjTHqtJ2nNslB4NkvvBDo15/goXTAsQabIyQsKT3EUbqio?=
 =?us-ascii?Q?m8zYGnGtQWgLfi9Wq8CpA=3D=3D?=
X-Microsoft-Antispam-Message-Info: BiveaWzDBACKFe1G87Z5GP7YWLZvPt32i2Id7Zk2ev+yPCovUV7xZ8sKdp6LjiaHUlmXMiLEEXLPUz0tbgqLev/Qjfeejbl+6cFXi3FRu/Q/Q8D/IsliXxiC6u8Fn5JPXQzrV69sLLEsXjnxF8Hk8G16MxRgCMBxVrFPTiwIKETosBWr8pHpf62IURcDt+LK
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4371;6:7wX56ZL5YV2LiqHU/9wfBV7CCL35kScRQyKUwd9Dxd1d+Kq26IWbDIR9H53GftuAUdw2djPSDPZBAzCdFjAKBID+STt/gcRX9ycrzozkNyi04LlXr8hwwrU4PFfu4l/OlHkZdIF3ZxXwh2ZiGp1Eyan/WottEennMgxNQoWQTT9TK0h2myZsY9Ndt85D1hB+9gKRrY4qtyr/E3bQYY0st0WWs+3649midB697OS+XNDySXvGZ20knIFd1zAmLe2npe/Xpp8AbGut/Q6DMKMs6h3lZlczMtTBWSLUYpKGn1uYVrt8XrrVMU7uo5nrXxZvArRqpH4qZYk5zn/ip9rwtWjegjBqbzHJwr+VWKnHPmU//rGt3ZV2C3OUBgMkKUhlLEqoK1RgyoNWWSxH01dJD0q1Zu4tBvEl7I4h0NUjeic2QC1wWFEwaE4oyduxMhleHyJ7YP1gNEfOl5ICIuzSZA==;5:Rk+IbQWvGXAo3u14v3M3B12ojxaY7JRZNAWK1uKPSieZVlAjzXS1lN2bT91/NbpVekaJnHmqYJmd/eXdqQfKqttPJq/RTILQMxwrKUF2A/hHm+hCUVPKxiyeshjw5g5pSQExFywO3Hq+Ei/pV+AgZtyA25PwlkTVkMYhQtBKiKk=;24:tzAIW3Gw4uvs1gL+tczSx3OMjReXRoHoZAI9Z5sFw/vc+BGa5tSeyaySzP8SIk667Y/2pPBu0GIfMl3cz1L/sL+eck4DV/bfR4r0eNgDnXw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4371;7:BumOeYnewp8dwi6pJu4On07hGLqe//Hlv0YVbU/XjS1BOvWagfj+8+WC5NTFHRfD83iuFnCSGRQhZ+w0JHrmEC1YAIDUf11nEjeCjIY7TOsp1RAqXNwXvY8QVqMK/ZfhAZsmpxX/gBTpeXm8QPGWThlVFUe59QUe+HrUlq/RVktqmNsOAU2r/4De9PQy0SB7oFjlVZZd6r40sz2aaRh47nIsivJs0nY9SY22h/FH7LR7ZUgzi2nYn0BQ0rdX19HZ
X-MS-Office365-Filtering-Correlation-Id: f4f34d41-30a1-40ab-6976-08d5cf8e61cd
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2018 11:27:57.0937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f34d41-30a1-40ab-6976-08d5cf8e61cd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4371
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 09:48:02AM +0200, Arnd Bergmann wrote:
> On Sat, Jun 9, 2018 at 9:42 AM, Yury Norov <ynorov@caviumnetworks.com> wrote:
> > On Fri, Jun 08, 2018 at 06:32:07PM +0100, Catalin Marinas wrote:
> >> On Wed, May 16, 2018 at 11:18:49AM +0300, Yury Norov wrote:
> >> > diff --git a/arch/Kconfig b/arch/Kconfig
> >> > index 76c0b54443b1..ee079244dc3c 100644
> >> > --- a/arch/Kconfig
> >> > +++ b/arch/Kconfig
> >> > @@ -264,6 +264,21 @@ config ARCH_THREAD_STACK_ALLOCATOR
> >> >  config ARCH_WANTS_DYNAMIC_TASK_STRUCT
> >> >     bool
> >> >
> >> > +config ARCH_32BIT_OFF_T
> >> > +   bool
> >> > +   depends on !64BIT
> >> > +   help
> >> > +     All new 32-bit architectures should have 64-bit off_t type on
> >> > +     userspace side which corresponds to the loff_t kernel type. This
> >> > +     is the requirement for modern ABIs. Some existing architectures
> >> > +     already have 32-bit off_t. This option is enabled for all such
> >> > +     architectures explicitly. Namely: arc, arm, blackfin, cris, frv,
> >> > +     h8300, hexagon, m32r, m68k, metag, microblaze, mips32, mn10300,
> >> > +     nios2, openrisc, parisc32, powerpc32, score, sh, sparc, tile32,
> >> > +     unicore32, x86_32 and xtensa. This is the complete list. Any
> >> > +     new 32-bit architecture should declare 64-bit off_t type on user
> >> > +     side and so should not enable this option.
> >>
> >> Do you know if this is the case for riscv and nds32, merged in the
> >> meantime? If not, I suggest you drop this patch altogether and just
> >> define force_o_largefile() for arm64/ilp32 as we don't seem to stick to
> >> "all new 32-bit architectures should have 64-bit off_t".
> >
> > I wrote this patch at request of Arnd Bergmann. This is actually his
> > words that all new 32-bit architectures should have 64-bit off_t. So
> > I was surprized when riscv was merged with 32-bit off_t (and I didn't
> > follow nds32).
> >
> > If this rule is still in force, we'd better add new exceptions to this
> > patch. Otherwise, we can drop it.
> >
> > Arnd, could you please comment it?
> 
> I completely forgot about it and had assumed that it was merged long
> ago, sorry about that.

Hi Arnd,

There are 3 patches like this in ILP32 series that change ABI for new
targets. I've submitted them in separated series:
https://lkml.org/lkml/2017/9/25/574

They all seems to be acked by you. If you ready to upstream the
series, I can rebase it and add riscv32 and nds32 exceptions.

If Palmer and riscv people will decide to follow new rules, we can
easily drop the exception.

Yury
