Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932236AbeBSVM2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 16:12:28 -0500
Received: from mail-dm3nam03on0042.outbound.protection.outlook.com ([104.47.41.42]:35230
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932067AbeBSVM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 16:12:26 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jayachandran.Nair@cavium.com;
Date: Mon, 19 Feb 2018 13:12:10 -0800
From: Jayachandran C <jnair@caviumnetworks.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, catalin.marinas@arm.com, will.deacon@arm.com,
        corbet@lwn.net, Robert.Richter@cavium.com, Jan.Glauber@cavium.com,
        Vadim.Lomovtsev@cavium.com, gklkml16@gmail.com
Subject: Re: [PATCH v2] irqchip/gic-v3-its: Add workaround for ThunderX2
 erratum #174
Message-ID: <20180219211151.GA158953@jc-sabre>
References: <20180118052820.30286-1-ganapatrao.kulkarni@cavium.com>
 <20180121070038.GA4450@jc-sabre>
 <86po635trt.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86po635trt.wl-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR12CA0068.namprd12.prod.outlook.com
 (2603:10b6:3:103::30) To BLUPR07MB659.namprd07.prod.outlook.com
 (2a01:111:e400:89e::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ba1c3a7-a58d-41e9-8d20-08d577dd77ab
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:BLUPR07MB659;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR07MB659;3:0413KfPgTYo2Q6olFwO5a7+j6TrzrNns/ibwppz9jXl39VZUCETdDMfgpzo4SBRPKCHaRXgkWnvHTQM4TPf/SNMGhwEscaEoSl5RN21ggI5NGq306sJM1onV6iT6GOdvbU+m0TdklvAMuPnfxKF8JByOAI7fhDp56+qHNWMa61bdytiYA9YnVsEw6qXfxXTFtx93QieB3CpjCGiEyIqMjKT6zdKBN/kXBPBfvEAomtCFB1+/ePAJSSWgRnz/Z1K+;25:ZJXahtHPoKMmivGdyVnrGGYbueayQViKfqYPmzu5Hxs5BWOOzVmoHVUAADHZiL7suyxesj1Yg03GEPjwU/1QCW+mrD1oRFWnlOC8R/hP7qESAF3HCgYZzHzKNg6qimda7mvdBQKSu2Nwk+z9A6ouM9h8QLoNythq2+LG3eLVm51TOhPtJXhnWGgz7TcuNHTp6t5c+3ckUJ2tj2vSVqX1V7QSD+d6A38p8qwaZuEwjM3aYZCp64ZsXzcFpojqIWBz5xNLBbP+9+hWjMLzwC80c6rtnOtzwWtE8UHDHGp1XTLxTjvRslmWy0vGRismtTlr1nShtDyeRGEKTQAWtkD0Ag==;31:KMFfDN5FwRdP5Y4JbiaQh5iLiIAGcjPIVGemEgv+pDF9uKRDpeqFsxx/KmEDS4wMtgkYo/X11UqJZMjXj2G2b0tOGqMsooV4q7jZX1yRZHC/aaLfJPJYQecj6rryl0mOe4wYzlWLtsBBxYa6qYdDnAgtfbbrOoA5N9YYZ1ohS4NOcYv/FFwlmcm9DBqHZjvP9j/302IX0kSP3xuQFiukK31ggZrqL9HzGWUDfLOfF5Y=
X-MS-TrafficTypeDiagnostic: BLUPR07MB659:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR07MB659;20:ISejCikhpioY+fC8uerh8bH+dHVNBbQNGQTRDqHLO3zmTPWAle4xkBaaalycm1DMuNQ4vrlBMtvRSxhNnUVCIgmJ65CrXJk9wErTnY/QnZT0K9osNc9VXIEhQoNn6xlocL0CP90WBJmn/eftyQphjZrQjUI0foE4/fb1Jq5rIDFyoMKYlMNADU/zDNlgi6yFdBbGbmlT6elAiBdNPl7naRN9WYSU56HmBNQ8+5RTAO+YHtNa0c8kj1XJ0Ovq8eMEm6foMaPd/95XrPmtoG2Ga6tGGyu4L+S2QhbXmhqR/u7QK5pdkkvtPII3bBPe6JD6aBLZt0jT6nz14LElEk/VykpfLJzO4SG0yZPx+Vmeydn2kxq5k0LAEpKotGn8+ECA7lg5MqKy//P595tN3irFnJG2REia82ZEx/U/v8aZbvHsw8iV/eE2ELY9CYwG1dzUIXOIcEhrki0xyUdi9iFMNuG4s6+QYFWxvTk3J9Comf+zczJM1NE4KePeEgmcr9IfJSHv1Hu5bhOI3QELG68EAl+bfJchhrnVpz2OpmBF3w1loZNTJdDJfxeDQnz2/IHNQVV+1PX8JONYgELi8pon2bvqkeK8PHqsBgb51lkC/ac=;4:TgHecD4mQb6iknO/qCm3MxllC3dIgbb4+gI+lLNF630vRtyqQKYIuJ5WzPW1Vj7C3iVlXiM+kPragjKQb4O16DqIfv5A6LAyBPdPw9avX0p2omCQa2Jik8NBBch4+OO4hQHhZ8VlstSzQ40sO4NnVbCp5MWkN19NgzLnnYsO5IKwjHbmxUMrJo4fa6B6vlpSeH//3o5wTZuFTyUZ2mdWZJu552+FFOaIpnaZ2Vl/x0xLjatJtkqn5cFNmSSPpJr9U+w3BI4k4TNKnqU/UAn3Vc//vBoDMPZbsIP52ym2BFjhKr065pp9Hc66UxcgsA9i
X-Microsoft-Antispam-PRVS: <BLUPR07MB6590D3566C2F04AF30F5FAB84C80@BLUPR07MB659.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(93006095)(3231101)(944501161)(10201501046)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BLUPR07MB659;BCL:0;PCL:0;RULEID:;SRVR:BLUPR07MB659;
X-Forefront-PRVS: 0588B2BD96
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39850400004)(366004)(39380400002)(396003)(376002)(189003)(199004)(55674003)(68736007)(76176011)(52116002)(33716001)(26005)(6496006)(305945005)(7416002)(186003)(16526019)(6116002)(6916009)(2950100002)(42882006)(6666003)(3846002)(1076002)(105586002)(229853002)(7736002)(53936002)(59450400001)(33896004)(386003)(47776003)(106356001)(83506002)(66066001)(33656002)(2906002)(23726003)(9686003)(316002)(81166006)(55016002)(8676002)(16586007)(58126008)(97736004)(39060400002)(6246003)(25786009)(87496004)(5660300001)(72206003)(50466002)(478600001)(81156014)(4326008)(8936002)(18370500001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR07MB659;H:jc-sabre;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR07MB659;23:St1Dv7LfAeXAHDCtDNOSOC2Nb6jzjMUtitRVQLDHRf?=
 =?us-ascii?Q?Gd32M23BMxjtFwzJlpByZWdn5JGBO9ySH+giD0oCkaOiNkFM1sI4kznGX4a8?=
 =?us-ascii?Q?tYj0i4OETyKSuexeMJsgK7qE6L+o1q1Hw+4rgIJ/oIAKC/1UgSesDXM7A+dm?=
 =?us-ascii?Q?E8ixdrT0A8M9fFAb0t7De2HIP9+IonQsjmaP8e9ZV7MV1pPBrl06L0kTTyFQ?=
 =?us-ascii?Q?fufGYrBNnHQQPPm6W3nc2NN5oHeYTPzf6X0T7b5f9rPwsizjrnoJ+55JPBqU?=
 =?us-ascii?Q?1VuTTHMG+/Z2LCZ5fwdd5xSVavC0CswKzaMeZ5rRa2wKy+gPSHMGxzu4k63P?=
 =?us-ascii?Q?s8zidrtN7/1KkFv104hl0B9OC+6qZQyG5jkkJGM7jru9M0UKnZ/Az33Fk88Z?=
 =?us-ascii?Q?NX0AGQKLJKpDqbg7Fhn+kGWk4sO7Zh5pP8dd4fiCv7ZYS5X8qrhKCFRtC7hd?=
 =?us-ascii?Q?nwIE3UF+qG6WLp2z4pV9xmgw0EW2C0cdb9Pz88zKPJMRj0DbiqcVt4C5P+H7?=
 =?us-ascii?Q?hZyng6B4aVujfmEWFoRn7VYzW9uUcDYahjnxfL0/EVWN2qL72Gsp9ga/IqLk?=
 =?us-ascii?Q?FunB06Wxk0b+xTWKMugaeFwZodNk3S2hRgbwV045hIqZ1whUt89FSP00wZ0P?=
 =?us-ascii?Q?wF+XulgN+H1JAZ4qo72WCLfonnYSfCaCSU1JoeYaLvBrE2YU4cdlDdo2ePNZ?=
 =?us-ascii?Q?d//QtCst+o8b6/92cr1OmFaRe6NPcRQNGeNxDSEwDnA0UZ1//5+GRk4dt1+U?=
 =?us-ascii?Q?2zi/lxiH3pqKW5JKc4/TTmSnIMwX5ATWpRbekuVrlDT8SKgrZIMF2A4Uuson?=
 =?us-ascii?Q?HfaGygcRgGL1g/+DMJ9/H7dQlwU77MV74JGSgassHRpl+0ZrCfPmnYEmzVRv?=
 =?us-ascii?Q?1A1ORucq7YF6sh2qFhmoYbwAHbwcGoZSsmFeAajTYCxJUTaJhTEzghf0yWwz?=
 =?us-ascii?Q?RJPDR7frnzeJ79xzqtoFaEF6L5Qto8/iYRNsFYSETd15dsHSh49B9mZNx95w?=
 =?us-ascii?Q?dHSJ8b/Q89EqiKdnMU3By2QGf4YTxjakY9MIeMAbUJd0iwOSVQkggq657JcF?=
 =?us-ascii?Q?lv2fxxeq9CmGFk2K01z4pqajWgweKRaO+VBhMCNJluy5hPGNrMsP1kvFHnGU?=
 =?us-ascii?Q?4Up7DBTzJKL90X+GugQPlBYEEzgEQTpvGEb7Gc+K8+ckgmOfLTkHmAPPW0//?=
 =?us-ascii?Q?DjEkFsgaxs3yOf3UlGWQVpwJ6MIm/q1cGwVgtDgv6Mpwzojbnur+RTFjzGUq?=
 =?us-ascii?Q?BY/UF88EGR4NPGVm16kDlYwDU4Q55zvZtVkh6KBpIhDMuiWMDJ/ysyUCY5Hc?=
 =?us-ascii?Q?m8cwrirz8uJNDlxlisYgsrGqfw+Rqts3+7K+9QxaF6U0PQMOi8mWgKp1+soW?=
 =?us-ascii?Q?W0YGBt3jQ0AieyITnW7EDpvFbK7Hf8K1LTtlL9eW4QU5EF?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR07MB659;6:2qZEBs0u9YZr7YhSeiDbsHZOEOBLGqEOnHCqssJG8LOWPYGQYbH+8Y23YPzc6zydfJkbKiPOpP1kuFZCTNwsC9jEtQHCsYu4WjFgUkdDGKn6XsJY2RjYmCmX0yR+1pw3E2CnvM0Ey9iPthlTcT0NOGUAahbdXt86UrUTL55VDRxI5DXfA23Dj1ndVf8OVwVgVMQRoxGdCRTTZ83FvZIJfMTriMshOckOtSprOCU42Zhg7BY9B4FFpaCyDOpwzr97BSUWG5u/QYpa9d2TAVe1nYhqADjxjxY3CTCt3fHuBI7i8LS3/IdXpWFG2lfl9Ta2NXxeLBiUoDFbtH0neg8n7K6/nLu9CzR48PuA8pfpfjw=;5:N+ZJJYGSTluaBUNw2EHTm0N/+zJmwSb+S27cvbv9CmmnYFIUpnMPLVzxjiNbb9/3Kjva5oUKce5ydTdHQjbZieTBZLodwDUtH3JE0q6DBYVhEI/ByZ8QWGt6V9kaqXCAmjB4QUgoI3xSbGmTbfWkwyT2AFxZf5xH1UHEiUbEoao=;24:kp6IVkeGntwwD0217zAZUOt9PsPloLGuRRfENnNe2VhZxXrvzXnyArByb6m2xBw1GG3n8dr7Wu/eeCMNLwA6cAOiTj5IALGXYt1S4ms6eO0=;7:yk58LlergJETmB1UmTryNVAdsCYzNRAuhtORXChTgBaK7jHobwkWwbon/RmAweqnvS8mbbshOTJgTmRkCGxkjaqQ/X8XmMphjlLlmEIt3cQkJkz79HTb58Ztn35POxK193ytHjlRbsT4ziq7dm0FAFnztUGKARnx9uHGgPM5BoqlaK63++T5x5vv8zs940Wa8D30+eYKXjQIzOPtKJ2Zc1u6ybVBlemI6/eBvSRtCoZyrL0GgRo7vV0jT+wJ+0As
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2018 21:12:20.4033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba1c3a7-a58d-41e9-8d20-08d577dd77ab
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR07MB659
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 21, 2018 at 11:35:34AM +0000, Marc Zyngier wrote:
> On Sun, 21 Jan 2018 07:00:48 +0000,
> Jayachandran C wrote:
> > 
> > On Thu, Jan 18, 2018 at 10:58:20AM +0530, Ganapatrao Kulkarni wrote:
> > > This erratum is observed on the ThunderX2 GICv3 ITS. When a
> > > MOVI command is used to change affinity of a LPI to a collection/cpu
> > > on another node, the LPI is not delivered to the cpu.
> > > An additional INV command is required after the MOVI to deliver
> > > the LPI to the new destination.
> > > 
> > > If we add INV after MOVI, there is a chance that we lose LPIs which
> > > are raised when the affinity is changed. So for now, adding workaround fix
> > > to disable inter node affinity change.
> > > 
> > > Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> > > ---
> > > 
> > > v2: Added workaround to avoid inter node affinity change.
> > > 
> > > v1: Initial patch
> > > 
> > >  Documentation/arm64/silicon-errata.txt |  1 +
> > >  arch/arm64/Kconfig                     | 10 ++++++++++
> > >  drivers/irqchip/irq-gic-v3-its.c       | 21 ++++++++++++++++++++-
> > >  3 files changed, 31 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
> > > index fc1c884..fb27cb5 100644
> > > --- a/Documentation/arm64/silicon-errata.txt
> > > +++ b/Documentation/arm64/silicon-errata.txt
> > > @@ -63,6 +63,7 @@ stable kernels.
> > >  | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456        |
> > >  | Cavium         | ThunderX Core   | #30115          | CAVIUM_ERRATUM_30115        |
> > >  | Cavium         | ThunderX SMMUv2 | #27704          | N/A                         |
> > > +| Cavium         | ThunderX2 ITS   | #174            | CAVIUM_ERRATUM_174          |
> > >  | Cavium         | ThunderX2 SMMUv3| #74             | N/A                         |
> > >  | Cavium         | ThunderX2 SMMUv3| #126            | N/A                         |
> > >  |                |                 |                 |                             |
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index c9a7e9e..0dbf3bd 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -461,6 +461,16 @@ config ARM64_ERRATUM_843419
> > >  
> > >  	  If unsure, say Y.
> > >  
> > > +config CAVIUM_ERRATUM_174
> > > +	bool "Cavium ThunderX2 erratum 174"
> > > +	default y
> > > +	help
> > > +	  Cavium ThunderX2 dual socket systems may loose interrupts
> > > +	  on affinity change to a cpu on other node.
> > > +	  This workaround fix avoids inter node affinity change.
> > 
> > This has to be fixed up to match the commit message (and for spelling).
> > I have seen some questions offlist about how important this fix is,
> > and how it can affect users - so that would be useful to have in the
> > description as well.
> > 
> > To clarify, this errata comes into play only when the irq affinity is
> > forced from the node given by the device (and ITS) affinity to another
> > node.  This should not happen in normal, useful configurations.
> 
> Define normal. That's all under control of userspace, and the kernel
> doesn't really have a say. irqbalance will happily move interrupts
> around. Disable all CPUs from node at runtime (again, from userspace),
> and you'll get the exact same thing. I can't see what's so "abnormal"
> about any of that.
> 
> > Also, we will hold further posting of this errata until we do another
> > round of investigation with the hardware team for a better solution.
> > If we can handle the pending interrupts for the small window of MOVI/INV
> > in first workaround, we will not need this restriction at all.
> 
> What do you mean by "If we can handle the pending interrupts for the
> small window of MOVI/INV"? Taking the interrupt on the source CPU?
> Sure, that would be fine. But that's assuming that the souce CPU is in
> a position to actually handle this, and is not simply going down.
> 
> If there is only a slight possibility that you may loose an interrupt
> in the MOVI/INV window (which is not that small, since that's a 4
> command sequence), your only other solution is to inject a spurious
> interrupt to replace the one you may have lost in that window.
> 
> In the meantime, and until I see a patch fixing this (or a decent
> explanation of why this isn't a problem), I'll consider it broken.

After reviewing the issue with our hardware team, we decided to
tweak the redistributor cache configuration from firmware rather
than go with this errata workaournd in Linux (and other OSes).

So, with the new firmware MOVI will work across nodes as expected,
and this patch is no longer neeeded.

Thanks,
JC.
