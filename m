Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FDFC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 21:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA335219A2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 21:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="LbvJ7GR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA335219A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeHRAWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 20:22:08 -0400
Received: from mail-eopbgr50062.outbound.protection.outlook.com ([40.107.5.62]:55968
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726344AbeHRAWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 20:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28RgH5E8Fm2kzHXKKnbAflczLG4Iwpe9UuuaaTTekjE=;
 b=LbvJ7GR82uTVoaZ41JGD+fxypTz5aQW1OpDzIBySKtO0j7ZipjbC8al+4zBACmDr1dj+T9876+4dZiLptF8EGCbix7gOodLnLc5umybkXppfmCMSfRvTuBbwimAzRTeqA0e84VciHT2pRVrxaUmmZTgmO0W2ZfI2Z4ikrkx2SB8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from mlx.ziepe.ca (174.3.196.123) by
 DB7PR05MB4458.eurprd05.prod.outlook.com (2603:10a6:5:1b::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.25; Fri, 17 Aug 2018 21:17:03 +0000
Received: from jgg by mlx with local (Exim 4.90_1)
        (envelope-from <jgg@mellanox.com>)
        id 1fqm6y-0001Xn-L2; Fri, 17 Aug 2018 15:16:48 -0600
Date:   Fri, 17 Aug 2018 15:16:48 -0600
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20180817211648.GK28676@mellanox.com>
References: <20180816215726.GA20526@ziepe.ca>
 <CA+55aFxgT8Hipm6bDrHMZ-nmdk3KZTP=J6D5k10UHTcajXAEHA@mail.gmail.com>
 <CA+55aFxD-Ua_jrrD1X6Y0Wd2gftP9=UVaa0uS=gi53zEEEAf3w@mail.gmail.com>
 <CA+55aFyGLKSzS8O3m4JaE69wUm03tGOf+507jCCViTRQaGBGxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFyGLKSzS8O3m4JaE69wUm03tGOf+507jCCViTRQaGBGxw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [174.3.196.123]
X-ClientProxiedBy: YQBPR0101CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::22) To DB7PR05MB4458.eurprd05.prod.outlook.com
 (2603:10a6:5:1b::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1aa50a62-6712-4207-d7b8-08d60486c788
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR05MB4458;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4458;3:SFqiBhp+jQ0SIVEkX5xUDTSZ7lpAFRrbN6vzmBySty9lFjnX68roNpAikqPgWbSMJSYwx6Ht9k8YYYU/U/apVh9xuy50yO2V695Ne308V6ODQZjbEaEbwruGP1grDhuR9loxOecPXRgTnK2xGI+eaC/dlN2bLHfL5gV9LV1JDEtJvj15cWdLJIedr1N44ypUPqZJPF4dCme35LEPu9dSw8lxi6mivd48TG+dQWynwPm1Ukct40ovOtVPk+QFXF2X;25:HqTUbqY6/hSuP0o65iu0A3drrP6le98MoDzO1Itm3DjRULzoQHnjasN8TsG+2TpjMMk9PmntaAZRlKJjsQjP9LqvGJGiO5L0n6AVAli89PXmqRqlnzzGVba5e5GlfRHYTJiSvV5a9K+hnQ73j+W1+668P2k9ESjMpCHXNAfqKXYe4T+0Hgw6av4jZCbIjw4IkrdLAgBDr+kJXvq8Fs/byD4XXxSEpsSl08hTvG1RT3DpOmiuhi3mpzIxyIWFNW40Er/DUnTvxYzgucNJrb6F+Mz/R9L5uJl01buGXQld9jtrx5WljSXKW7/L1tu9Rw4T5H8S7Ko5BSb+/kwrQZOSkA==;31:F+uPB+d0uSrlNQCJaTa4pPEVtoPZHXUffmjIhCcYSV84O04WO2meN34YxAzmN/EvckIeK+weg4TkuCiB7rmdp8R+XCCm3FZXiFqo9C5Snd77AoWx/RPhSRhpjDWp0y1p91W37OvxMK7sADPiXDc+y7D8+aFwklYZ3YGdwmDYytWrmH3bjHYX8rGjVLmxdgMnixw1bHru7yzJJa6gI0VrqUOatgf3y0Y5/wE90WNcYZM=
X-MS-TrafficTypeDiagnostic: DB7PR05MB4458:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4458;20:vhiAwVRcMOmf9BiAEcGYA3Rq21+tad3/HduswRhZGfbVAN0ScqVkMTnu0G0rFhvhHPReWl8iZyix8hzzinkJIs8vrCcWMCgfPtr8vWe+ze/be/JRc/kh25WoLE8btZPekPA2dBYlxF3JInzoKwjoLsmNQimn/HMohPwKLE6s6XQatDCD7nr39O+D8mDLPp/ejxHgDhzevPQickfCwzqK0ARs5QgsaXirbqk33MBk8XAT0uXAPqsYD3YC3ePtdr+WIamXnH13fdkxKkXtZLxDBWQX3YFkeHUK9HdZNA37D9y5krDltJ25yAbJmahcB6Z2lvRWqGPMxgWhLJUHfCVXk6IUTi90nZXAGj9m8YSL3HUh8zmrpQ4N+A83misxUBtAd85hb4MMBzR+yQx+UJwQYAdRc6jN9wEaBN6i8PXrCyDJuxT2MTxtG/ol5i6uD/2UaTUZXn3VEk2y4ANCeoKwwhhzZmV9XsZ6RexHE6YLP1pvhaoQGmkc8mfoNo91mUmS;4:HLTBk1azc5F8QEGJuD44bBa/5xChNU5/yA2ljadimvEdhnbzh4OIB9yPKDhYce7vLCMCQH/LsHe/XXygb9pNk1Dq1EFX3SDWaRdKnCKkWrHEiixyvcQGeETqIfnUsVpMsuayicyMwKzYl9OCZr8KW8utxlcYD8BhWr5OX/fVxWVnZ7IpvmeY7WpoKa8SZOvBSP3l4CRPmHx4w24cUk1+SOxGoMkFBBw5HVF5K3FeIDGdTtoo3ZOp1UcAA54+xKJTLnyYZW/yYhLa9l3xTNxFww==
X-Microsoft-Antispam-PRVS: <DB7PR05MB4458D096777C57045D657B24CF3D0@DB7PR05MB4458.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:DB7PR05MB4458;BCL:0;PCL:0;RULEID:;SRVR:DB7PR05MB4458;
X-Forefront-PRVS: 076777155F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(39860400002)(136003)(199004)(189003)(186003)(79686004)(36756003)(476003)(5660300001)(76176011)(93886005)(6916009)(2616005)(11346002)(446003)(426003)(486006)(86362001)(53936002)(52116002)(26005)(66066001)(81166006)(81156014)(8676002)(106356001)(46656002)(6116002)(2906002)(4326008)(105586002)(3846002)(14444005)(9786002)(122856001)(97736004)(9746002)(8936002)(33656002)(47776003)(68736007)(478600001)(57986006)(50466002)(83796002)(1076002)(23726003)(6246003)(305945005)(316002)(54906003)(69596002)(16586007)(58126008)(229853002)(386003)(53546011)(7736002)(18370500001)(24400500001)(42262002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB4458;H:mlx.ziepe.ca;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR05MB4458;23:U+bRRcW9l7zT2KOPWgN/dg01GqW9npyS3IwJ8bVQm?=
 =?us-ascii?Q?ZneBvzvigTYjoqrTK1JgBYf3QwYGQ1RLVzmIu1Rn2qKlijL/asYFrRuWv1Cb?=
 =?us-ascii?Q?dYXlIDYFFgMxQtmXFl+XIfje4ebXOIrlCU9XWdwIvKeEo/b9xBnsDuyhgc2f?=
 =?us-ascii?Q?+mnoNAttUyYlp+yGtaR0SGkVzGsp8sZvKnVLkRnvwbaWNRofIkCQ8h5UjKUI?=
 =?us-ascii?Q?Ev1wGzZdKg3yNXuprpRPl6hH8I4PShl6zjQ6O8n9/BgndiW0HHzMVFRZMhvM?=
 =?us-ascii?Q?As2NCZgt/+hva7mjiaUE8cM7Eny3QLQAp4fIZjNM4vrbeFDJWICqBrc+VjwP?=
 =?us-ascii?Q?zmu1i094Z62CleVFVzwOb4W9zC3txfrJfVtVdSh6uSiBI88Tda/YGEWNdYpu?=
 =?us-ascii?Q?I9woM+140kWtlMKVbCSTBscD7RFh8i/sPZymoUQsv/UVKzT6nS8qh85+MUWi?=
 =?us-ascii?Q?SivvO/XUoyCGdfVKTwLd38GRAxNCEik962MO6NE3hph87Lklwkr3bQaxTpTl?=
 =?us-ascii?Q?YmLACeO0wNNODimNABKqok4ESgEv+6h4fSn/VPbr8fLaAdmyN8UUpe9x2lgN?=
 =?us-ascii?Q?8mcBX+XSfckaxyTTAUjclp5D+m7xmic5xvu04dJOCGHLVBP87wKk8/cnDh9i?=
 =?us-ascii?Q?rA8apTKOcBYrgaigAtqHzEt/vck1kyFX1dZd2nqA+4RzXr6x4DVyPO9y+JyB?=
 =?us-ascii?Q?RK6iqShLdMY3Rgs4Sn9L48Y8hslNVfnj6qUcOubuPRMtF/rNZsX58LB3S2/3?=
 =?us-ascii?Q?N8HpLoyQMGUEBmV6NHWmIVgbQlQVCfQ0Xr9YA1uJkjk8VJ3z9JxmwC4LWmss?=
 =?us-ascii?Q?Euxa7M1U/IbDQSWylslriymJb4t0xzyQySTNcNA/t2btsLf5VrshuGmciswz?=
 =?us-ascii?Q?IbDZWtHdpOUF0hqyIoSSvuwGQOjr/HhtbO7T7GXT564qyY7fVGoo/zgSQnDO?=
 =?us-ascii?Q?9q7MubKVwLF4kTs+8n42OxKEVUMcRzZHEWvnc8U/ll8CG2fGUyUW4BeQDfvh?=
 =?us-ascii?Q?pXHz6w7dfxVHkSfC/d7A7406lGn8Qyj5UApkeRK+FK6muN6HSgihtF9cpvQL?=
 =?us-ascii?Q?7tHWIP/lFm0FQgqnAfbacvtjAjRfm77Oxil5tHpnucqjM++ekGMvb+TsmKZL?=
 =?us-ascii?Q?vENrOM8kPRrAYGYVYI8iiFPwQO6ns7CL02Vp84aa43uANvQgjTMAPCCe3HHN?=
 =?us-ascii?Q?vIH5xdQN0/ZPuHiqLqOVOiWSroJ5ipeo6wQOnYLKYiFg+pF9MRkFbLfK9Rwj?=
 =?us-ascii?Q?JDr3QiTnv7V/pE2iKkouxkmQiDxM9ZWZQvvbR7X4lZD97uw28DVMyu6sq7WZ?=
 =?us-ascii?Q?uE4CTOvwAQrMAP/X+zTZT1Ja+KEleB2gZihFcrp9o63hffxOPbzkZI6XrTS9?=
 =?us-ascii?Q?SbfKkAPVUnuZiqH/bCEzjIAxDMP1Xo+o/t6jZFajFGYjHLgbpGrKJikYJok7?=
 =?us-ascii?Q?Y7bWeg/ty+gJduij24IQ4Dd9Bmn5Lk=3D?=
X-Microsoft-Antispam-Message-Info: 8epIEjRthYZ2YBetslXZqUb8Ss7eDN44KompWJyP5yBOsvyrBI1BvuxGn03rIoJRpsmEsob7v1kkZriKVLJ5PZXoP5unUNdbEkk2bIm4TkjB4SFsuSwASnjpdmQt8DxLxLjoZ18Y/xCawhj70668EYnMY6jUlA2yDKVRhBY4K7EvbxKzkM0q1G7M9cBUglai6wgO0fVgag+OpDGljoxmwg0QAKre9tz38rX1KTz+L1dmh/LOFBSViEv2nlBJEbQgeuk7IylZ+hVB4H1Vxwn20S1RwMuh7exed1wG+eq6/YqiGBvsTS5SyIE2kKus+wl5HQ/nD4Db8qcBbUoM7Am7rwnLren7KMHohe7Em8ZWhUU=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4458;6:u4UQX1ZIIXd39bvwbIu54500rqd1Hu4Gr5Sc2oPuV/g2m/tkbpRZNt8/heiXWTEEMBz2lWC9lFUsqPV5OmQT0bSkRPaIJEnosBguG1jUch3IySMb8RYDNq9SV1QlohO2XOAQ9nOVO+84KMJQDc7s9DluHIh3zOt3LOiZL2g9c577eoV3dNr5hy4Z1V+Xv99J8/9Yv4p4tYOusRugMZcapxHZPpnE45LMUb4DncYIy1ylmf+7eB2dEzqH4pVV8EXtOoRrJBJ5gNTM9fdD1JO0+An0nsLsa2vMWK8o1+waruQZwx4fgXv+fB45qBc8YOZoGORLc4thtVe93k0jh4SqXqfB7A5rRZO9pIU9NciSMzn5Xe0aMmQEUg70dn3RT7RuuIrxhq8MJkf0HdU8VmUO/tlbfVXt2GWKBmv2YF1wk3abMG2GlpjPdUPHH82sNCTC9ss02/LUhVpJ7EUc+QlLUA==;5:JXeUwLQ8ohSU2inw691AjFUt3LOHbnsGlOmX+gn0ljW+gr2ZeTbV65djMLPDGsiwL4vmP0l42MfHV5hqFiX/JCP1scIfVy2T+I8yD0qcLvTofvFPM27ljGfFb61wYm1dIlnH1B2AUSZRXvQxpYU6Qu3rGbSyr0HwknIESrMLqqU=;7:Jgzj2yD9z95Nl7wtHowgjOPy0rx67ONHPS5hutTn/W9x8NM0lO9tLoZuRfFfaA0VZqbHXg+1ZLJdNhUDWt0o4Vj5RSzEbI7b+0Y8bdhtZ84Y1BOMPsHuoOpTkpIp+koFcYfx6QmhByE4H0jwIsweIoNtAc6ebLM+g53O4qCjUEyqw1Ed9axhCDfEFF+PptmG+Pme0zPdI8H7z2D//+UeQmmD7Hi8k97HAKG0QG7bfeiUPjFQF9pehELfjRAb7FiF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 21:17:03.9266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa50a62-6712-4207-d7b8-08d60486c788
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4458
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 01:50:05PM -0700, Linus Torvalds wrote:
> On Fri, Aug 17, 2018 at 12:44 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Ok, everything but the max_sge thing was trivial. I just took yours.
> 
> Oh, and doing the full test compile, I notice there  are new warnings.
>
> That is *NOT* ok.

I expect to send you a pull request to remove all of this next
week. This is fall out from the SMC merge conflict reversion.

> The whole "x is deprecated" is not a useful warning. If you can't
> remove something, making it a reminder for yourself for later is not
> an acceptable excuse for  bothering everybody else with the warning,
> and possibly having other issues hidden because by the time there are
> expected warnings, people will start ignoring the unexpected ones too.
> 
> So "__deprecated" is for stuff that really isn't used any more, to
> catch possible new users. People have tried to use it for anything
> else, but it's always  been a much bigger pain than it is worth.

In this case it has become confusing what
CONFIG_ENABLE_WARN_DEPRECATED is for.

If the kernel is supposed to compile warning free with that config
set, then why have the config at all - it does nothing, by definition?

Would you like a patch to remove that CONFIG option?

Jason
