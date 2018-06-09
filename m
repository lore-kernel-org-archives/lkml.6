Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EqMpNbCCG1vfPAAAmS7hNA
	; Sat, 09 Jun 2018 07:42:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4D3566089E; Sat,  9 Jun 2018 07:42:55 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="RWdx1lDt"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 642D6601D3;
	Sat,  9 Jun 2018 07:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 642D6601D3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753216AbeFIHmu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 03:42:50 -0400
Received: from mail-eopbgr720060.outbound.protection.outlook.com ([40.107.72.60]:12648
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753098AbeFIHmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 03:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ln6RxxPwxFc25j/dmqrilTa1IDALf8Bvi6bk46T8cTM=;
 b=RWdx1lDtbqSdbqEWeCfUMQM2ZeEv45kw97hQuf9FZBON5HvkuzStIExfAhSn+5zgakUOS9qV5Y5IL5TElhdE0l0ZNv+24RwDQ9lMq8cTiJEdjIm2V1fZs8C8xiockSgGlVsE0nX8U0QSt3GqzpF9eQMK7F30HwxelrdwpvPkm08=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
Received: from localhost (188.169.253.180) by
 BN7PR07MB4372.namprd07.prod.outlook.com (2603:10b6:406:b5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.16; Sat, 9 Jun 2018 07:42:39 +0000
Date: Sat, 9 Jun 2018 10:42:27 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>,
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
Message-ID: <20180609074227.GA6810@yury-thinkpad>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180516081910.10067-5-ynorov@caviumnetworks.com>
 <20180608173207.nwoi25jee52gpdwy@armageddon.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608173207.nwoi25jee52gpdwy@armageddon.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [188.169.253.180]
X-ClientProxiedBy: AM0PR01CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::21) To BN7PR07MB4372.namprd07.prod.outlook.com
 (2603:10b6:406:b5::12)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4372;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4372;3:99mAtPXiDq3Me9BasiJm2UvXIzLaPg/gfFwus7+LcuheDJGNdDg2LWRy+gOTf9V3BMxmKButAPUCprytswU5FjtxhFrXSQUDKme2nIfQnejutwlHECE7O415j41WKORAu5FHKUspHdpS5SA6wcrQIhYvK7K3n1/8vsA2YHPmK1k5Jf6Qo+jCd8FV0gxZHR5eg3Gd13hqgYdGX8Kc6bU2Ov5rzeq5hprnOLp27oivlKocI+PefhbrZ0/Cmra1tWU1;25:6e1jra9/bE0vkDSelQ6KY+QCDZ57efw1iNrFJrBot+IPZ9uT+eqdcsXgPWBl+36TnQ9mmXM939RdFYdbGSoDwXeiW2ya8jO5TSBhft7zSh3yuTO5ftTCN9I+BTSffMgY0A3pMrHzC27Ism4bwhj8ALV8rjJVUHpnQTe5nsN1jEeCjF4nvm800bx87EdJ2ubCOjs4MOzUauarSjCRPHzLjBXx3tfclrvR4S6nk1Dbf1aqMlsX/loqTfiiAKBfeg4vARSVQ41hrlYq0Ks3d9A5+Z2L29wqJv4LsgM5/GWlkXecnBG8npjdvs2Mugc8XQIkBo6eCYs81OIJFbDgKKBOZw==;31:+HYxwIXavqwGOmo4nqojRDzef852Sowg3y2FVjQ2nGAY7emvBounURHsu3BdNZDmYhovra50I3HQ2wVNGN9HGw0q5ChMS+PmVbFIg75MgeICRRFvfVCDq9Wu0QMVAkasG02R1MgtpSjhXLmXMT1s6kHiogQlfHqWBdiKEUOUbClPWJpuLUPLT3theQh7kq/K3e9YUJ5MEYtNWu2ShfUXtnmTt2hW2N6Muq3IyfWIktg=
X-MS-TrafficTypeDiagnostic: BN7PR07MB4372:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4372;20:1MEOKRrWDJfjFwFUTKU5Wbdj4abHht0Y0N1NS1DqUbU+iYKzTez1y+oHBhCBXXzeGxtVY0Zi6NO8yr/SRSW6yVRbhVOEGg3kKthefc8rfpRwwJA9p0v+MfouTJkcABwWHNGTk+rCQW1mfYs78oD3qaICqX5g0rpGTnkvXwsocdGHzZFRQaX1GlhIzXP4O8nw5e3hRx2mCXCjrgzYk4WLlBCzaTG31EL2pIFIGB4V5fBeOERIjoEJvyB0ripanwCEbL1iLtZqXEooapwXl4TiwRJCzbdW2k5rNjLMp65iuud9BdgRyOrzRzI3a9zLOX6W78NUasP9df6OfNPMkSBgrelgggfwcSq9ubSAtIeILQ4OcbavKxIvmdBXShrrf7169e18itJl9CZxBhUMci9bGgrT1qs5MPb+qK2+wDXfRz0/ZvqQ2SFZaRzAPxzzgawP5ijeu0DxJWGdoi6mtSt08ZmlJzM8L1SMtfecwCBU6H3rRZpzGTh31E9YZrdo2wMCa1hAdMJDYXpvaVXPr6rv26HZdrAAnFjlHu+McqJeOkrv0A8RSTBrz5FVquZfv358F4ZesyrLfsbhRsoRdFGlQR+o1bKxwUSPyMLd4+lMe/0=;4:p5vqJFxaQ1VfTAfQMnrxhzEf9pOXghdoxnJgEHcWopgLX/X7+aJ1GBJivTcik3ElonGvzdAVS0+EhwM2qqasAskPff+Tk63+SjkWQkNCeUPLiXi0rWqATwOguQGho0+Yk0t/LraCHWz00GyGeG8Rw8VB0sgubEl15pbVxHugVYaQa/puVLPfPtx5AgqSfJZPali7VXlBg3MAVOKYiR98iTyplPL40vuOUeodV2wHsNI9L6J8+4Iu5LnroZqwPMB+oloharJTiU4Fh+cLqULO7g==
X-Microsoft-Antispam-PRVS: <BN7PR07MB4372EA39F19E7139AB44A88FE37A0@BN7PR07MB4372.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB4372;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4372;
X-Forefront-PRVS: 06989017E3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(39860400002)(366004)(396003)(376002)(346002)(39380400002)(199004)(189003)(1076002)(26005)(68736007)(16586007)(54906003)(58126008)(316002)(50466002)(33656002)(47776003)(66066001)(7406005)(7416002)(9686003)(53936002)(229853002)(42882007)(5660300001)(305945005)(39060400002)(7736002)(478600001)(72206003)(6486002)(6666003)(4326008)(25786009)(6246003)(2906002)(105586002)(6116002)(3846002)(106356001)(76506005)(6916009)(446003)(23726003)(956004)(11346002)(486006)(476003)(8676002)(8936002)(81156014)(81166006)(33716001)(97736004)(15760500003)(6496006)(76176011)(52116002)(575784001)(186003)(33896004)(386003)(16526019)(59450400001)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4372;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4372;23:jcJ6zP/j+DG9nAK8dphHk6v1fGAvFWxWrBeaywUkE?=
 =?us-ascii?Q?um/sqWMlZexJ4JzOnwRqLxZSz44zH18EvTNv78hMk+ntjD/gd6OsBe8QkvXl?=
 =?us-ascii?Q?U6fM0jRNo0JYUj+iY2y99jGHgwz55x76RE5UG7g7n+xYWszsfTdfzzfxYPpI?=
 =?us-ascii?Q?im/OyQyUXDLw36b453WcmTCDeOm7CXOJe3xnMttTr9ShtkbI/GKCiTShcW5y?=
 =?us-ascii?Q?kZijGynBRj6zBpEn8sk+be+A0eM7GbYVQKoyvE/i20OA9AkKaueP/6UEP6Bo?=
 =?us-ascii?Q?ZoH6Of9yxDy/d51EbnwT0L3i2jHz4hyx7kFXXfCRHX8TATxb/qkmNr81ew5T?=
 =?us-ascii?Q?MXnMJDGE3d1ji/p9rEdUoNIcznvNZiLFkwsTbWvW83uMT+VUWBikPRF15sYn?=
 =?us-ascii?Q?ZpmpncoYUD1o1c2w+OYdRIbawdPlXaMScpIym8Ghw4HH/N2+E5a19oi3e/QM?=
 =?us-ascii?Q?kcQslayMaLT29VH1Q/5N0mIKSB60UMCU3eRHOwCQDlT1LrfWg8MRH1d28Vpn?=
 =?us-ascii?Q?jUkiimeOZNracyZzXaUQvPzmhFMEZug19KKbCHxBxk2RqJ46niHxiyBs3Pcc?=
 =?us-ascii?Q?G/9FqyjNzkjvUHDrz0nc0XVi9PnJHHMXnsKjm6QYE72AmSvEDzAMPe20PZnD?=
 =?us-ascii?Q?xjeW0QjaGFOVGXUJGQIU1LUkrWeEMt8het+xAdDwGrQUz/VjLExIGQ2unufZ?=
 =?us-ascii?Q?ZreTIMj/uXOHrlcTE6BMBfYqgQGelFyftpZ0NqM6bviwCIZ68yIiqM4XQ8Pv?=
 =?us-ascii?Q?1CU9yRBvS8rclFCxyxQBx+tnIpUuBqkXCt7IrAXxs6kRnXs4Fr69Na1Xd48h?=
 =?us-ascii?Q?wuE+TDAK7SwF2B6e7oZH0UuWKIc8MiMsdCAlTaQdLmWgkeiqho/UrrRvjYPq?=
 =?us-ascii?Q?9b/WZwRffawg+KQdiRAuC/gwnjfJXafmdDfSB7A3K3N3316xrUocSkhnchgB?=
 =?us-ascii?Q?9bUuDrAcrCGkrTurOcDzLcpjYFQNXLAHDgJALM1NkytUWciV/iiOH0PVWEb6?=
 =?us-ascii?Q?fNQcy3mZdIWVuLQHbT2cGp04WsLFta91+CVqVg8GXlfGqhP2dO998QSl5nN8?=
 =?us-ascii?Q?rLvr8VJtGYkwM4Wv/8XVAn8PYYpiJRA7ht4ah8wWQL3iCI9OXZy/VbALC3ZC?=
 =?us-ascii?Q?1FjeJbcSvrbRmiXsegDoXul4RinDb0BOFWYzMefYhSTE/xz8uZdAgMKpROh3?=
 =?us-ascii?Q?fPjRb+VWbeNDWSvitDk73/6ZY8Zi4aWjBXeu3T0n+xZxgpbKTARX/LBLRqtu?=
 =?us-ascii?Q?wb5jkeRB4B8dVH+pXUPQkZCFBOCG69CEgPDOI518XnCVJDdqDb6NkpCv1l8s?=
 =?us-ascii?Q?cR2eQezsTH9AhbuWqAePBQ++5gnkwfYgYabXYLW6lsTpZ4/YOeXTiaBD0tT7?=
 =?us-ascii?Q?68IhV4tTzVk2FM9sJXblCuiX4SSkxPOzFXFV74vDMF+nUzlZe7RGzXf51e3e?=
 =?us-ascii?Q?XFcyuxQsGiq8r9dBU4B4lNUusxCGPXbeJovwFwJ+0oPInN8DsA/6ir6hcqVe?=
 =?us-ascii?Q?avbTw+QG1HsqGgTtC8LnJc4I17+g2L0qA0=3D?=
X-Microsoft-Antispam-Message-Info: cbpgIwYn7FMmfkEqRldo48zLQR+wXJctbGD2EVV66oEmeU0f9IMokDlfuCz3JZqZ1Fw7EY7FaiG0uD2QyC/wGVbr+PgoK4G2Bw0pXZaYvXcYxbqljD6iWwleXytFuoYfl2Xyl73Jcoe+vFXW/pYCliC7mY2GQNb83hq2jHwCukPiKmyfY/yxqZ3FdCEb62xg
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4372;6:caz5Uz4Ii8aZMvyPxcgzIQsHq6cWa4/NKT1n8PcXVvslfsHBSIENJ45sBCXEnwEm3C1rDrb62+iVKmRULZ5roKN+thmds3eJh0UzvYzjRiDjDyDNMZJCcgnf2L+5r/IVpDzI+fYuGeYDpHyAQj71WyLg9aBhJ6o15roq+75GSiYjk+NuAG0i59ABARHI4hjpfLmwMHDsCGu3Uwco+/eNX0jrb+VNigfqbK4F2cCXndqbP8kOPsm612aGlXZfAO4OKeYL8j0M4DDU49rAsxkYc2M7m/dKQQZp+qNVJ6P9DjHp2+1JdqpL2ErDbfr2YvoC5NWUNUmbIiK7ULMsc4B/Zv19hYscoD7I1o89yNQxUGFuYjF0usYQKAHd9SN9dOjerwohrISepzrjmd/kL0QgruDsaZfcDvQdruasUXtgJYkbIBromE39pARVo9zM243IU1wy5Iybkr6w7VZ+L+W9lw==;5:kphzqxTjFnk5GeBk8xgF9UuAySE0691hNpvz/mBJ9Mt164OZqgFBuQEnd2Kw4zJXwlUf6TqAbWtve/L4LBR3ancMLxoMU03wIwayen4hd3IRidIA0QDbj3g5KMuev/rZ4cT7MPXnQTXvREDns16MDW2U/uTihVOi55v7FUczoH0=;24:7dNvks/jQMVYZj2Qtk94NgZPVuKqYSh1XVq6g/INzJfVrYfu226aHDHA9oBLj5uWxJX2oUBMv7TRDc/2NR1z296zVxy3vnrxUdXqvBy+c3Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4372;7:tTytUZgpYZTdWkGzIROyeNRrGm6b3CQsQ2b5ozpwULxf5nIxO+uz84YPcWNvQ2WBVeqLjxpiRrz31NTvEHeqcaYp4LrgzsD706jK593orUTRKYhaX0PAz4fdyQrMyZZx4i65KwSmpmcEFOGmbAFIIAQDwXg3AZR2HW6lctMtuXUvrSgRFO3sSw5GGT5CClD1eA2TJAzOtKrsuqAbOugZnB7gcXbaKgXg0nWU1y9tvPRJDDsN61jE6eTBw2T4mjhi
X-MS-Office365-Filtering-Correlation-Id: 0a552a8c-2471-4258-45a2-08d5cddc9406
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2018 07:42:39.6697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a552a8c-2471-4258-45a2-08d5cddc9406
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4372
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 06:32:07PM +0100, Catalin Marinas wrote:
> On Wed, May 16, 2018 at 11:18:49AM +0300, Yury Norov wrote:
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 76c0b54443b1..ee079244dc3c 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -264,6 +264,21 @@ config ARCH_THREAD_STACK_ALLOCATOR
> >  config ARCH_WANTS_DYNAMIC_TASK_STRUCT
> >  	bool
> >  
> > +config ARCH_32BIT_OFF_T
> > +	bool
> > +	depends on !64BIT
> > +	help
> > +	  All new 32-bit architectures should have 64-bit off_t type on
> > +	  userspace side which corresponds to the loff_t kernel type. This
> > +	  is the requirement for modern ABIs. Some existing architectures
> > +	  already have 32-bit off_t. This option is enabled for all such
> > +	  architectures explicitly. Namely: arc, arm, blackfin, cris, frv,
> > +	  h8300, hexagon, m32r, m68k, metag, microblaze, mips32, mn10300,
> > +	  nios2, openrisc, parisc32, powerpc32, score, sh, sparc, tile32,
> > +	  unicore32, x86_32 and xtensa. This is the complete list. Any
> > +	  new 32-bit architecture should declare 64-bit off_t type on user
> > +	  side and so should not enable this option.
> 
> Do you know if this is the case for riscv and nds32, merged in the
> meantime? If not, I suggest you drop this patch altogether and just
> define force_o_largefile() for arm64/ilp32 as we don't seem to stick to
> "all new 32-bit architectures should have 64-bit off_t".

I wrote this patch at request of Arnd Bergmann. This is actually his
words that all new 32-bit architectures should have 64-bit off_t. So
I was surprized when riscv was merged with 32-bit off_t (and I didn't
follow nds32).

If this rule is still in force, we'd better add new exceptions to this
patch. Otherwise, we can drop it.

Arnd, could you please comment it?

Yury
