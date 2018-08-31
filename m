Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D26C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7659204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Oh/xvv8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7659204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeIAArJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:47:09 -0400
Received: from mail-dm3nam03on0112.outbound.protection.outlook.com ([104.47.41.112]:18883
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727245AbeIAArJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6vqqyVKGwCRCi7hs88rsyeNCXJZh85rXoK9WGBX0yk=;
 b=Oh/xvv8Eyqk2ZgNvmRVOUDav6XY+AwTSti1umOFMduQRU5hSpOnPnBKsagOodgTrlikUr0aURWAQNaAVhYAM9D2DlFy+U/XNVupa2b+xTCjHMUoX37VkP3MVVWgjIWHtPSRm3NXKOzrYZ8oxiCo3eMJ7ukAfjsJWmT3GyP3wNZw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BN7PR08MB4932.namprd08.prod.outlook.com (2603:10b6:408:28::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Fri, 31 Aug 2018 20:37:54 +0000
Date:   Fri, 31 Aug 2018 13:37:52 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     James Hogan <jhogan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/3] MIPS: jz4780: Allow access to jz4740-i2s
Message-ID: <20180831203752.37rsceiwotcmeses@pburton-laptop>
References: <20180606193811.16007-1-malat@debian.org>
 <20180724204757.qrgjttepzcfdzxlv@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724204757.qrgjttepzcfdzxlv@pburton-laptop>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR06CA0069.namprd06.prod.outlook.com
 (2603:10b6:3:37::31) To BN7PR08MB4932.namprd08.prod.outlook.com
 (2603:10b6:408:28::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccf14f73-2300-4b38-cd8b-08d60f81a152
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4932;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;3:p1GJPgsN3oQf/ZzuKXeO27x+zu4e8O5VHPXR2Oytdhp3/cT+FmKTyvH17Pwk8kM5eKP3asnHERIxyb88sA1uorzoqVpSflBpvn2eyrt777SMJo1ojJjVawS9i5AWoThg0C726nLE/wgO+EP/b+vUSiQCdrzr/diSbQ2LxUL/1guvufgp2FQuDT04UFVVwt96A5n6u2M2pTqD9UpIqQiGaZV0gpkRg//uGKbk+vu3SFqugDHevIbyOKzrNo0mcxKh;25:XReZDownNR17jsYc7ADvkucEBuIXSMoQwqQIBdx6eB4gzndiqwxpcBIZAc7h6iZoYCTShJungeGYVCMjHs4VMmTuvY+Oywr0R3JYtGSnYChJO0cq0ueD0qEwtsdrIzO7wgcsGYLquhsKB2Llv5j/UGZ5XDoqbxFBkkvcbspKSaz7K25UhW5peb4DIYufQaRhcrNceESFf3B1Ik8q2vkMePNfOa+WASL+UHIDn9xG0DxwfzmW00BppVnRPH6kINdMllCTZ/7o+3Yi7b2hGSYaGH9cZOaLkz0FAKyqX9HPaR+V+a+ijwfYx3chVRS3n/RdWWR+HjxlIcrKbbE3PTI0kw==;31:261E5D8xYSEFn0HVljX9zAK+g9SlwJXfvnxvC+4+uOTwW7zBT3nsRacgk7shrBy4lbJ8IUuaYeOuq+VQ+x6eH5+bAb7uj2BeshkiThMEtMScD3WdSC0QNOKYtQbotLnRDto23bKuOLa2jMaUFZDzM+M7Cr7qSSYlM/rvQVpQq2K2Y2toYEB/auaFLcSIJD48Ydbw4nqbij9ASZFtUyJaRzmqZrbSiwlHrG1PhAAznXU=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4932:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;20:RlqLe+IwK4nVUVBqHSQe+JL/K86/SUIonZtz7k6CRHiSD17meMk94Y0SUaKrSc3qx+w9Yl1ogvDW/EWQRvOoNx3G3TrGRfZc5NlYltwlKde3XR4UY3rireDVda9g9LErGOcyhTuJQvz3MoervuXDEajuVumIb7FOpduFrht66y+GlkYG1SzKSPymDuCzHX2Dy79a7Gfh2N9la/YU6SXpx3oAW02ow6VSmBwMk89yRiR1yAe4yX7ZcUn2SqSMCr+I;4:0nzXmGnEA06itHV9Xhyd3U+pjC5iNx+egL3QAP7X1eWnQMo9458M0pVUTsBsA6r8LPm8LWYUPUuk/ABSHQM7Ifx9dG6gLxPDna0ppq162e6YntrRP6qWsstk3aytwFhbRL9i9ccd7Nb7t91ZrP8Gy+u54/iXo8YSLfNtJgWvlpMrNydSeHjVLFzm+rKhQLBI8AXis3MO3WpGcz/dV9EBxg1tNTwJHnWU2+0TOGnG7k8uDmVcXipCpPuzlxxZoDArazZ/jEOaqDw1RCBKrmbuOaKiUMiEoGzwGu316mjO0qnLh5Z8SMNwKButmQcsnh+MnfMipgoKoQodHzrTQvPFXe/Y2HVLRe6t2tdmFKBKX6M=
X-Microsoft-Antispam-PRVS: <BN7PR08MB493279259D5A1D55F5B8CC8DC10F0@BN7PR08MB4932.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(192278398808882);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699016);SRVR:BN7PR08MB4932;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4932;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(366004)(136003)(376002)(346002)(39840400004)(396003)(199004)(189003)(106356001)(105586002)(76506005)(8676002)(316002)(66066001)(33716001)(47776003)(956004)(44832011)(2906002)(11346002)(81166006)(476003)(8936002)(81156014)(575784001)(966005)(97736004)(446003)(486006)(54906003)(7736002)(68736007)(305945005)(58126008)(16586007)(52116002)(39060400002)(76176011)(33896004)(25786009)(6306002)(6916009)(4326008)(16526019)(186003)(26005)(6246003)(229853002)(6116002)(478600001)(6496006)(7416002)(42882007)(1076002)(386003)(3846002)(23726003)(6486002)(50466002)(9686003)(5660300001)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4932;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4932;23:1tGj4U8iqklJeIs2+tKgf9R0w4j1ZrQfDKb0bm1pQ?=
 =?us-ascii?Q?u516epXlkJV8rWyJ3mxsBTfHDcqQkzxchAFz7A/NxPLQKbwtdiLWRN4y1PfL?=
 =?us-ascii?Q?fGCvwEGF66tHXArPD0pm3jEP9hSW83ysNO9A7y74TFq46G8Y+YeHtNm5hKF/?=
 =?us-ascii?Q?xZLtHoc3cBlP11q63RLFlgIP6GcSr/uphSbFVX96FjDK67rGHeg08KYRKXar?=
 =?us-ascii?Q?7+M9frpo+rbb8GxPhCnY2vykxqzxQDaDNezu2GdZU9xjZtaFYbkj7EoUcD4O?=
 =?us-ascii?Q?EBx70ODa88nTnEDtbUy5CsGImTX1KcHmHxXSaFg0o8zSklzw8HEjN0GCyWC4?=
 =?us-ascii?Q?kTnxD4UWanTXUA44qb1aFjXd3iO9lqZ0LS4htQVgBV2zY3A4Rf5lDUDKbnEz?=
 =?us-ascii?Q?5tPG3aJ9aedecR/+rQc+IxvYUazxmJW2m5kpsH4AxPIOjSxFtKHimKD14K9E?=
 =?us-ascii?Q?sWtDfvwR9F5XImu0nIdT6Eo0JdL3chuI+NJ4ZrmldK32XON2yFvpjA6KY9TO?=
 =?us-ascii?Q?GAtLOgSd2Afwm8SP93Inu1HH7Wsdpt+YRR7My6ZK7Fsoh180XXHREc4+xlEU?=
 =?us-ascii?Q?olo7SHR+20VPsDTPwToJ3ZCEdaSDyyspsYFjhF7/hz/Jqz5kVBF+hfXJeCQl?=
 =?us-ascii?Q?73O2s922h9pnJGAX1WmDjBv44LL7yce0l1/FE+qFa1Oi7rxgCex4Tud1HAM2?=
 =?us-ascii?Q?L3CNyRCA8ZcZq4CUNhOz095/5kMrCZ9EBmxtZ32NHLTVWJ4tZHSK970aYgxo?=
 =?us-ascii?Q?iihK6LdTBmLm3nBgVykMnGcoTxEDwQsJ9zO8aQhhrKvSJTUBG2ufTlW3+FFg?=
 =?us-ascii?Q?FepmFX5uRSGwsJ1l3OR+Dq1q9xB5arOdQSwpP85BXvQRB6DSjz0BbLRusCcP?=
 =?us-ascii?Q?F7dL4j6McHwTWk87XyvSbqjaTcGDVxjyO0/GJf7sh7jrhhuj4XjO48qKvMNE?=
 =?us-ascii?Q?XZCAQ+/Inm0r9eSv6I7N93BGgAnsVdDqbOfbOCuYJzYvoRpBEWnJFBzoupk6?=
 =?us-ascii?Q?ocWMBVYDQlo9Wn73RtY8VNMPeWXuuJfKuPAVLjXy4sdfYvqByVpZ2qviawxc?=
 =?us-ascii?Q?ztHsJ0Wq89N1QEJ7H4NQErpVhwHw+IIZHrKjKM4Hf60yP3l29EQSKLYitjh9?=
 =?us-ascii?Q?M5Sq1ba6qqTa+MKvh3cj+PD85LlN/1s01QBUDuGNk6DcWjAy8XvsKsRIsusF?=
 =?us-ascii?Q?hhIALuw0KgkdZnAqa53WESAVqYQZJzf6vzDgKYX9Uw8KKxya4+ydGEO9ciIw?=
 =?us-ascii?Q?Ag6olgrFveYqE8CoI2gpqKJjmQA8mAJln7co0fvqIMDWbpdbmqtJDNcRIiUk?=
 =?us-ascii?Q?4Zg3twiuo14KrYFKi+f/sW2MRPFYytLg8cW3Nrnjjn7RLf0ufCylGyqwPMQC?=
 =?us-ascii?Q?4FDKmGJMc+SQAkodjuNquTlFtTAlG0UJrK1eWXB0MPM7gzd?=
X-Microsoft-Antispam-Message-Info: kK1DcKuUr64zfwBxLALtxii91rZ38BSjINyTX3v2N3OvClPVbc7GcRAC0YLVpxTU5oQNDCx5TIo3PiRGe66yqq6pOCFAn4lTQPO5emn7C0RK45jqOC6dBOLZLC9/SxjH5H9eP5GOZ3aiC9Ae6V7Ok21/wb7swvX/EwJ3wvzunZiQMjZ8n8Tjl9qEMNBl8qX0+FDGPGCBGZhJGGZgczinWpbPnvLZWMOOfs1h2R1bz+P0zGMtSzkZjI86g+uoWf/b8Bt31fxN/gsKswICqGbyPWPnXJPLvAaYkHndl2kZoEU1+doJHJaioV103aolQTjfcvZ6eVOw21DMd+yGJeHru3S6BpcB19zy5hmMPfbr/HM=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4932;6:pFSe/IKK8+6RhbNPFedSGSxJ7nQ+vOEI/hwp3n4kKl/dbB9e/890apkRJCNVP303yBqZTNmakDjOmmB1US3SljlYhDoU9l0MrJ/pOBImbANT+Yh0twsrEuqrRGr5MiAl9DkKhrZYHrmovKBMhfoerYwqkXbBys0wzVb98OYt7LTbo92eIqq+Svyi3CVmDFO6Qcc0GbpJW1KqJVulQAeK9S+2APmIL4wfBC6zwhN6unb2bfJnEMLKNUVbvO0zKRLcH3G8TEXpOpkaBQdOTYbmy31qDsZrdYidDHObWW4SQCUB4lK1/h0x515yvq53YoMcKrfKvTA5Gtfj+GRo0F37wJRBzwVwu2Z8fgyo0j/5ovogdDs9p2UdZ51V4bcEU9OZn23B3xGAXzaE5BYwew8eFIISOfyKHexf/3Di+oQ9OYLkG/iF2jjaq8rk9Fr9RCOxuRG7k+aplTJ79Fx5qZv9mQ==;5:Vq386C0zo15MMRAN8pJjKatDOq97I0MdhoWCZz5pnEn1mTmEmo6XtMlAssH9XJE3wWYOqDWH62y8uhpHEsZXxfiol0lr6cpEiLBWa6JMRgZy2kb07xreBuW5Z3qNFKQWRJHp0LcMOiT6NTGMwuy4VyliKUuYFR1HGoKzuTGczIw=;7:XEBTOqHc4/EvFTGRBl1S+0dsQhmNi1JSJCT24Y6j3QIKYkEIF/c3csNpLY6bIszSmgdXEJ+yng8TvUKW2F5L/s8+1fR2BmI4NdmhX89DEMxlaQCW9Sja7877/efZpLExlOduNoQsdHf2yzn9iQW+D1Lp42iEGDZNVtrNRnULFqkscj/Ceb0VJer4sXvxNEeVTBwC//YEURx30tggbW9cylxeDeB1aAxh/ijuypluMZOpaQm/QYBeII+52QEi+RG/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 20:37:54.9072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf14f73-2300-4b38-cd8b-08d60f81a152
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4932
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthieu,

On Tue, Jul 24, 2018 at 01:47:57PM -0700, Paul Burton wrote:
> On Wed, Jun 06, 2018 at 09:38:08PM +0200, Mathieu Malaterre wrote:
> > diff --git a/sound/soc/jz4740/Kconfig b/sound/soc/jz4740/Kconfig
> > index 1a354a6b6e87..35d82d96e781 100644
> > --- a/sound/soc/jz4740/Kconfig
> > +++ b/sound/soc/jz4740/Kconfig
> > @@ -1,20 +1,20 @@
> >  config SND_JZ4740_SOC
> > -	tristate "SoC Audio for Ingenic JZ4740 SoC"
> > -	depends on MACH_JZ4740 || COMPILE_TEST
> > +	tristate "SoC Audio for Ingenic JZ4740/JZ4780 SoC"
> > +	depends on MACH_JZ4740 || MACH_JZ4780 || COMPILE_TEST
> 
> Perhaps this could be MACH_INGENIC, or even just MIPS?

Further to that, this series doesn't seem to work for me. With
v4.19-rc1, with the patch from [1] & then this series applied I see the
following when booting a ci20_defconfig kernel:

  [    0.846684] ALSA device list:
  [    0.849642]   No soundcards found.

Nothing else looks obviously relevant, but here's the full boot log for
reference:

  https://gist.github.com/paulburton/336fa3a6ed756f9bbb587f01dcd520e5/6a5042a258348ed5e5d3d0cb1a72076abf31d85b

Thanks,
    Paul
