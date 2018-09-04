Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3882EC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 23:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7C420661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 23:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="RhzknaPh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7C420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeIEDbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 23:31:19 -0400
Received: from mail-by2nam03on0133.outbound.protection.outlook.com ([104.47.42.133]:28550
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbeIEDbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 23:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kw/v+OCUOxyp34IlFItVk/qtMu/BbUSk7MX4Sb7gdbw=;
 b=RhzknaPhCIl2k1oo0t4RF9bDzdeyGODICHerlpfX1qq+YzrAxmJsUis+42/D/MXv7p393JaiXpt7VbW/wFwVefu0c52siArucylfHua5+bvPvH7ZMLykrDE7UZv/36e7ZHU3OHW/OVmAeWACHNih27sWOSAl3FI5JnR9rVZt5GM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BYAPR08MB4936.namprd08.prod.outlook.com (2603:10b6:a03:6a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Tue, 4 Sep 2018 23:03:55 +0000
Date:   Tue, 4 Sep 2018 16:03:51 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Miller <davem@davemloft.net>, andrew@lunn.ch,
        ralf@linux-mips.org, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kishon@ti.com, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v2 00/11] mscc: ocelot: add support for SerDes muxing
 configuration
Message-ID: <20180904230351.vwlq2s7joulvqw2i@pburton-laptop>
References: <20180903093308.24366-1-quentin.schulz@bootlin.com>
 <20180903133415.GF4445@lunn.ch>
 <20180903134522.GC13888@piout.net>
 <20180903.220910.899357653888940454.davem@davemloft.net>
 <20180904151653.GI13888@piout.net>
 <20180904161028.nh5ejrtj22r5az5e@pburton-laptop>
 <20180904180006.d5th3jrbhr4vtahi@qschulz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904180006.d5th3jrbhr4vtahi@qschulz>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR10CA0043.namprd10.prod.outlook.com
 (2603:10b6:404:109::29) To BYAPR08MB4936.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0d0abb5-ec4d-41ec-f35f-08d612bab081
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4936;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4936;3:w5XJmMRX3fIjJlzyPPHPVTfyfHMN9gUps5c286SvpIJC/bc6uZB/AL0FhK1JVxQLFdE1U8HTKoOuSIvW/KyfxDHM4p8baWarjpZXcTmDvIdq4RaoOqsx9QiR0v3O3tFjjsF5oVLEiLtHrBfwm0hblmT+M8L7BZQ0iPSIperX2KmTN2o/wTM8GcjG2ASh1x9LWGWol6CK3lypGJemmmZ++Ydf09kIuVKCt1jji60Mow5Q8BWL2abJN/eSZ0MjdTsK;25:vfpU95vIrLNWemSx5UryrQN4orios1bftufzCfXesHL8LPycHoGN8J0TA9ouhIfeTHkU5MIXYeZIxwvB1ANr+ZKDrzuS04zl7+0nIUtNLrqCbgTYUMolhyfTJ0hu17wvmwPd4QQ0t0EpmhIm/yDL2FFLD+VbDfiT5xF0gMQJvQczvPhvUBTjP6WsqIthxrkwwWWnR7sUsGlYYirlvE4TI0CsC2I/SyG6qkEA1ETSk++xELm4rqIpGdSZOy7HQtkcPhoBfWngj9MK4JCy0q6FO+vRodZCzD93NdRBcTYLht4AMXTc85MSEtx2JlchGcP5G58itAKUhJDif8LK3csSvw==;31:guykbc1VcwQVXTX6Yd6g9KiFXrrF4N2IS7rbb6Ke0F9ufiF1Q5ZARhhA+3l9Um0kagXqEbsXGRJREX38YDvlI2IHaqvHG9Md+/H2JXtW1YOCJr0d/DFo5z+8e6cuMd2qmtNzJUTte64IqfmBczqs8idQe10SmL8JI35ixoxg6ooCpFnd6O+5Z/3LF8/YouoMtqHnliozBVZV50XAGozHMULxtTNSEgVt0RMwvtwQeI8=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4936:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4936;20:FTtHaP/Kug4u3/D9Rt+15roqnhxn60rtvvaGCSNYGu+1N+djebOH6asUDiJgmu43JQHGhMGmUAS73inyDgxVXSWMyKIQjhIqDg/OqmPWyMn1JeGbjiQ21mCh07/pxw41rJbPa0z/x/b39I5sxtS+xG/3ETjSsBUQT3OcJO2iqbX9rO0gryxoFqhQJtOM48kqvMQll6lgJVLGX+UtMAuZ3rd6SpKZkzVVM3RGDxlHSTDWHUh4xFm/9YF3YhFr9zC7;4:JXEOfqMyqJwPp4sTEBDVFvnE590f5mMiuJL7zaYAWMXvWGReAFByx8OctUTDZP5fM2lwCIT9c/0n4bnsO/mAkgDKfYIbkPAPlMYzF4gGkiYXHyY3kVOZ/ZiW93epKCEd1fOXkoX8Suj6ws7ipB8aTmnuMiKIAWmOuwGxb3wpNUQQ5cShOciUOw/KyFsQw4YvpHAUcBuYGn18i3xOrEBxW2ZtQUE/TgS6Odaf9X58YFgReUnByCrtuPhfBl2uqbptz8w5lzXLxks0T24hlWzFGQ==
X-Microsoft-Antispam-PRVS: <BYAPR08MB49360F6FF92F1E8F7F6C48CEC1030@BYAPR08MB4936.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699016);SRVR:BYAPR08MB4936;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4936;
X-Forefront-PRVS: 0785459C39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(396003)(39840400004)(346002)(366004)(376002)(136003)(189003)(199004)(446003)(11346002)(25786009)(16526019)(486006)(42882007)(476003)(956004)(386003)(97736004)(26005)(186003)(6116002)(68736007)(23726003)(8676002)(1076002)(4326008)(8936002)(3846002)(93886005)(50466002)(47776003)(106356001)(66066001)(6246003)(39060400002)(478600001)(76506005)(105586002)(54906003)(33896004)(58126008)(16586007)(316002)(14444005)(6486002)(6916009)(6666003)(52116002)(6496006)(44832011)(76176011)(81166006)(5660300001)(33716001)(53936002)(2906002)(81156014)(7736002)(9686003)(305945005)(229853002)(7416002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4936;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4936;23:KLy4rMm498LP/km4SDC4bDnvDViGQWKclWp9UYo33?=
 =?us-ascii?Q?3P0jqvUq7Ydlsa9si6+h3D14a6EkQjpWh1vZ7LEeHAxdlq/LpWzaZpUnsaIt?=
 =?us-ascii?Q?oSrdVquQInM3usU5wTUkKgQ77U659gCj619OZr+xdblaTl4VGvTnRJfrjCuF?=
 =?us-ascii?Q?ls1V7Prr59kyOaIiEsxyd6g6gFEyW+cZjwLkudv96ENia/z4rVA9hc3dqoLF?=
 =?us-ascii?Q?5F9uiPs4Jt/oiSVuJX3ShXPakWZDiyCuUR7/cdngno/SGH4uahxfwm7yME1j?=
 =?us-ascii?Q?drHtpl88fq56Clyve+dk4XlTKHL2LunxnFIh2s/SdtO9U5KpheF344Vcstz9?=
 =?us-ascii?Q?8VyGgoXtq41rtQPmJKsxiwjyCOQXBXO5HzWZYuo8SFzCRQ+M/aX+Suxswk7+?=
 =?us-ascii?Q?IAUlIha+/1g3v4dwTNx0Wp/NvXA+s0pNReerdCZ7KDPhXo/PXRFaPaQLDspQ?=
 =?us-ascii?Q?MFAIm3jK1z/IsewF4PwQdHgpRVCWzpcovv2Lxno5V0/pBVK1rHuitdtwgPWa?=
 =?us-ascii?Q?+L4/6jx4yukbuSxJ2swauHJzjffnd/foPGMOR2+wgT/0xA8MGuKXnrTww+4X?=
 =?us-ascii?Q?TatvC+CbcCP4+H5YSE3XQfBoWeHLUSgyXzK1DKxthvW8Nwj4XM10Ba7RkRBr?=
 =?us-ascii?Q?sp3Oc5Ok0qqN5848v9K+5Dd/MEYCzKqY1y2a4OE8KElXa7cHTJ2ByC1uVO1I?=
 =?us-ascii?Q?C1/2BDEXubMEl5FxGSURwwJECVQjcwLBaprafVG4Sp9zecnCeP/EvLy8wEZj?=
 =?us-ascii?Q?6u+OZ0+wGye8Ir080WZpCQqeT5aUvy5QCdrtNvNFnuI7KzHAzYU/hOGmiCaS?=
 =?us-ascii?Q?6GWacEk8pJ94a3IWnTplYHi8N0i/1e83d4l+WfkpYtxa3bBvdEQp9+9pUqsg?=
 =?us-ascii?Q?WoJQ3xtPPwsvgI6jkEQw64/RpBZ7OWz2CX3LnyYWFzyseF654hKlYF4hV3Bo?=
 =?us-ascii?Q?ZA6f0mVR3csYGbg8o4JM8DGPaIRIlwMQFradbQikc1nxVpmBESPhurbPPW4t?=
 =?us-ascii?Q?5DWoSAaWCvKhDQNHNlBPPu4ZnLb2A09slTUXC37O8TiPHIMHL1+Kp7mVPmtZ?=
 =?us-ascii?Q?dXlWXN8mSjOqBoOzn/UKMRhP9JV/t3jNSEuiY4ESQMCZdM7UCX+FijVXREyQ?=
 =?us-ascii?Q?7L5CceTWo794Qs2ZtvyM9CDkzF2A2l2050IDTJcyIUNe2EQRsRlyutD3uF4B?=
 =?us-ascii?Q?0PCqx83Ggj+EfTAv440OLjCogEtR9U0B3OHqVl6KqJ0qEY/4Vd+55cLJyB0g?=
 =?us-ascii?Q?miGIKflny9iW3PZqANIJPwfro6qW06lplPaqAIeg2CgtSxFISykMdBs/AFMR?=
 =?us-ascii?Q?R8U8uWtegqJ1vWrqGsCjJDbNQZFCWPA+ToQmXKhhU4e9MCl6yKkn1dYXalHP?=
 =?us-ascii?Q?3bddrzPFtWEmgc0VzG0ZUuX+woVYic1Fz2RS+6tuUlkl7cg?=
X-Microsoft-Antispam-Message-Info: 2kFCfSIJVE3hdFXvhe3Z2G+qrG37QtRmZ2oxNNkQAK0SPsR1hB+6wMQy5q7Du4gt45iOQm7b1qAjcfJU8i8vHOhkVhlfuSPEFr9K/4SKhXrZTKp2RNHbkgFlkn0mMhMx9xIPi/MtNioVONO+P8ynxyv2l23Vf3hcXPTXqzI9Y/4gXPWkA7GqC3j+isc0rTy35StgYWAPDe2yqi+G2lYY8pTT9671ccJ+BCRZ2Y+GaXHn9E7JmzXhSfOWOo0m2a4GRzalfRI1WCXrdA3mNx+oEKefDg6qSLelr+m/7yETV3ThHgY7mgwRSNVNKdCA1bIkyTmryqjcnfCrfjnrFfnJuBNOSK8MN51Kabk4Y3ge4fk=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4936;6:os26g8ZItESikat/1qzCVHX5+w3JLvx29tTP/rZjlCYtQFISMXUnmUBLZjv7WCOp8nz0DWSPtCpEU9X1N2CCk36zcKm71UhdhKuGz6AmNFITe+cDkZ1l5aiCCAwnfQBSCYhTe4znf6FT5FUh80K6HmojfQbyC2U+qx3JR91WavM2HXDvE+hsC1zklNVtfnXa9A2FzCI6XPNhnjXByB3iwGFd338hf8K/YRO/5GnMVDpCaZomzS2ncuK6JwzetJOGpEb9q95wKANobQPZh7XUYMN2SGwxyuM89QtYkCjW8z3jrkRQhSliD6s/4ZByfYIoNGA3sYkk1q1ZZF4EtsI9FqMrfUGoZ96U84SmVSHmOSXxzp6HrDrL8oAkmsjPcBy7Dp/9rT+Gg8nGG9tqJjgN2q1QD1Ke/X/u4Yu7lpeA6ZwFGTkiNDns/SKiiXiQ1R0Fm7uaeRp7NBttgth8TwFIfg==;5:3moxKwY5S4z8VtkSMAXZ8ss3nufK9GNqht0wPRy9wjWu6fbsApYAdpX7sytepGTudu3m2u2sCUsSipej9r0jwpWXOrd9AzRO/t7tKd4G34/SBOWsnpiqyAIm6Qr3RSJ3tsjKrP6JtFyayjMx32wf8UUFDbEgXaY3mWTs1lu6rfk=;7:5A6Wo17LdZIpv8QxwhnlgEosMvqpf1WYdGgbhRcNz+LtPOP+NcfxdgK3EYm0+lM2avcOqO+Aen91bqr49K7fEGH2Vi3N/aPnxzAmmu3GKVhzNXKsWdV2VwxYKXZr4/HLxqdHWIR3mfb7VuXN+wZhApGZfXY0TdsP0rEFdhsl7wmZbb8/mIcfN9yJ9VPnBglE4wOOLSievV8Eu8WANQIl/nFfVK/W/EE6YU2lTR+/Mq4xPG7odauldr/6rPVyCVaW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 23:03:55.0444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d0abb5-ec4d-41ec-f35f-08d612bab081
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4936
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Tue, Sep 04, 2018 at 08:00:06PM +0200, Quentin Schulz wrote:
> On Tue, Sep 04, 2018 at 09:10:28AM -0700, Paul Burton wrote:
> > Hi Alexandre, Quentin, all,
> > 
> > On Tue, Sep 04, 2018 at 05:16:53PM +0200, Alexandre Belloni wrote:
> > > On 03/09/2018 22:09:10-0700, David Miller wrote:
> > > > From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > > Date: Mon, 3 Sep 2018 15:45:22 +0200
> > > > 
> > > > > On 03/09/2018 15:34:15+0200, Andrew Lunn wrote:
> > > > >> > I suggest patches 1 and 8 go through MIPS tree, 2 to 5 and 11 go through
> > > > >> > net while the others (6, 7, 9 and 10) go through the generic PHY subsystem.
> > > > >> 
> > > > >> Hi Quentin
> > > > >> 
> > > > >> Are you expecting merge conflicts? If not, it might be simpler to gets
> > > > >> ACKs from each maintainer, and then merge it though one tree.
> > > > > 
> > > > > There are some other DT changes for this cycle so those should probably
> > > > > go through MIPS.
> > > > 
> > > > No objection for this going through the MIPS tree, and from me:
> > > >
> > > > Acked-by: David S. Miller <davem@davemloft.net>
> > > 
> > > What I meant was that 1/11 and 8/11 should go through MIPS because of
> > > the potential conflicts. The other patches can go through net-next as
> > > that will make more sense. Maybe Quentin can split the series in two,
> > > one for MIPS and one for net if that makes it easier for you to apply.
> > 
> > I'd be happy to take the .dts changes through the MIPS tree, though
> > looking at them won't patch 1 break bisection?
> > 
> > Since you remove the hsio reg entry it looks to me like
> > mscc_ocelot_probe() will fail with -EINVAL (which comes from
> > devm_ioremap_resource() with res=NULL) until patch 3.
> > 
> 
> That's correct.
> 
> > I'd feel more comfortable merging this piecemeal if it doesn't result in
> > us breaking bisection for however long it takes for both the trees
> > involved to be merged.
> > 
> 
> How do you want to proceed then?

Well, it sounded like David is OK with this all going through the MIPS
tree, though we'd need an ack for the PHY parts.

Alternatively I'd be happy for the DT changes to go through the net-next
tree, which may make more sense given that the .dts changes are pretty
trivial in comparison with the driver changes. If David wants to do that
then for patches 1 & 8:

    Acked-by: Paul Burton <paul.burton@mips.com>

Either way there may be conflicts for ocelot.dtsi when it comes to
merging to master, but they should be simple to resolve. It seems
Wolfram already took your DT changes for I2C so there's probably going
to be multiple trees updating that file this cycle already anyway.

Ideally I'd say "don't break bisection" but that's sort of a separate
issue here since even if you restructure your series to do that it would
still need to go through one tree. For example you could adjust
mscc_ocelot_probe() to handle either the reg property or the syscon,
then adjust the DT to use the syscon, then remove the code dealing with
the reg property, and I'd consider that a good idea anyway but it would
still probably all need to go through one tree to make sure things get
merged in the right order & avoid breaking bisection.

Thanks,
    Paul
