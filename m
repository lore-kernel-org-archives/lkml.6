Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8478C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD4720861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="iVigONwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD4720861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbeIFVsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:48:07 -0400
Received: from mail-sn1nam01on0125.outbound.protection.outlook.com ([104.47.32.125]:2083
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726541AbeIFVsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpgyhHmh+H+5GeJnjQOyUWHgr3z2yf+CyKewChzDO8Q=;
 b=iVigONwdgh9lf8tQMIp5VY7czKwKukxL/gnOezeDQ/rSfT443oH/m8f2Gp2w5gbzY0+8wKDrICrebLWDBaenYkTXsAR67ccrEWjKHVHYjsLvvB94+APUyuy1DWHyi4mCFZ5y+YtuBA3vRUj5FyfAm4Hk1c97/iu29bGH810XmR0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 BN7PR08MB4930.namprd08.prod.outlook.com (2603:10b6:408:28::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Thu, 6 Sep 2018 17:11:36 +0000
Date:   Thu, 6 Sep 2018 10:11:33 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Ley Foon Tan <lftan@altera.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-kbuild@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-mips@linux-mips.org,
        nios2-dev@lists.rocketboards.org, linuxppc-dev@lists.ozlabs.org,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v2 6/9] kbuild: consolidate Devicetree dtb build rules
Message-ID: <20180906171133.awny5cx533kkolrg@pburton-laptop>
References: <20180905235327.5996-1-robh@kernel.org>
 <20180905235327.5996-7-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905235327.5996-7-robh@kernel.org>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: CY4PR19CA0039.namprd19.prod.outlook.com
 (2603:10b6:903:103::25) To BN7PR08MB4930.namprd08.prod.outlook.com
 (2603:10b6:408:28::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6cce1b1-5201-4adb-4422-08d6141bcd65
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR08MB4930;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;3:ranjkBDB6DhAJ4iRF64/7/ahOLT2T+ep9vBhHFJXakBoLCC80nUupJE1cC8D6mkhEBtCPbPbxBwmdWeNKvMpFgPBYdhH2K2gEselaL8IVfQ7qQkR2J2AW1HNTSOf+5f2tuHm7AZzS+7pEkemls2DWI8o0N4SedOYFTosueJKcmd97815WlO5LQRb8Xl1QnSp2zSw9RLJ+Fpw/LXPTtv8+a811kVu8YOtwNWjRmhb0p1z3IxSFeCVCFWdzty/CKfp;25:G4jowsCqe/Uxu4vKCiq/hIHQ/dLV+cm+3FzpI1hx9pdCpa8QPDcOSrrFSe8iEIvGODQ5THspA65oBYiu+mHr1UpzAD9pdeib8cRofewABcN45sSUSh+osqg2KOOVSs46oMNwlJ7FOCeBWYcCYuIRl6qAvrPL3vuohLnZje40TaE07/0xYI0jk7C7gTuK4OwFslOk02x9o4AZWgwMg1w8V4okDUJ8AOpA8zAQw4E60DgjM1sNIO9a8HNcLN4S2w9LFBCzzb3WnCSEmsagWAVKiy31Y7xMaX+iA5Isk+3GNHoT/9l3Ot7RdG8C3UEB1BjgLWiBOFLZwhVIIsxmgcz8BQ==;31:FC9BUqOQe+OEwGcxDNQ3g+HsI9EcH2xyL/vtb1N/K9gtB8Zz8OinQMOgCqBLdSLm7nzYYVYM6cjHv2lBfQHhy0bgn7NOyHvDdMi3uXFnhx5bIQhBtO0Ccm0g3XvvkvJE6ytAyXgkn4DKsYobfqCVvixmEzcSeF0qtf1OtPudocFBsFwPChr59tjfFl0xA9lQ5wNssCjEmicn1+KfxBBGUJjqtGh+V2zbh7loWN7mdag=
X-MS-TrafficTypeDiagnostic: BN7PR08MB4930:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;20:y2TSCZ2s9zu2CggVjS6KBBL7Elq1zNUorrMcneV/ym1kmYvZtI87OtJ6D3KC8W0nteehcEHr1WILHMb6eMvTU6FYubDhCyeqv2QU4QOVzF650PewXb3C64vHK6vx5kZpihgakrZewY7ZKdB5W5jgGlMHPAb5or83MxOrI+go8V8zIJR13WS7JVT+18hpVlLF+0qZsYWtg60w2k7k2FuHEsG5FAnu0dk4c29pAzHFPK0wilUuxo+GMVDqRHLqs2P/;4:7Y86RzvKAAqEErpW2bdN+darsAK7MqlT4ZvWm0iETE1bg0MghriQ3Pm1D26P3w0e3J0fyCYhRymNrXj+brGA4CfUViAqcfBetIoroYin4yj8Yl6kIZfSXzOTVj1cvlkD5PEMm7tYu+Agn+ruxfZdut2FH11OsFkz3OwXnD6zOrCJiBpzKoL38GxLH7Qi5bOYkireUbI1pSk6Smz0L8i4QeXVnjUFcZ9cZYbSz2uTUeRVnTK7lQDJo/ncMVyymyW/Onu5t47oo6h/KGMDZaMXsg==
X-Microsoft-Antispam-PRVS: <BN7PR08MB4930D4C1F4BA7870189B048EC1010@BN7PR08MB4930.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BN7PR08MB4930;BCL:0;PCL:0;RULEID:;SRVR:BN7PR08MB4930;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(39840400004)(366004)(376002)(136003)(346002)(396003)(189003)(199004)(7736002)(4326008)(44832011)(54906003)(33716001)(106356001)(446003)(186003)(16526019)(25786009)(76176011)(305945005)(11346002)(47776003)(6496006)(52116002)(42882007)(76506005)(26005)(53936002)(33896004)(68736007)(386003)(6916009)(6116002)(3846002)(229853002)(97736004)(6666003)(8676002)(2906002)(9686003)(6486002)(58126008)(486006)(956004)(316002)(39060400002)(81156014)(6246003)(81166006)(476003)(105586002)(23726003)(7416002)(50466002)(5660300001)(66066001)(16586007)(478600001)(8936002)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR08MB4930;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR08MB4930;23:lNz+aLpC8z2QpCGgvajrwPjR6tWLYbDxgJ76LfAkP?=
 =?us-ascii?Q?emamy1WU1Jy+oAE7v0YeFUfhdTHP7Zeh91HIUm6M/ke/6rKOYxUyU0IPgqJb?=
 =?us-ascii?Q?VvbyiKKJwaS7ghb+huaAsHHGfv09i/yDg72Ag9JKaC3zA9qWMfhhQgKlDfie?=
 =?us-ascii?Q?Bd016iXsIRxfc/tVqY9kuVIAfb+CvepNFcLTA1N9WhsbDi2s2EMgiXwVd57V?=
 =?us-ascii?Q?iVBox6kFZW2bvGUC92jYluOfwKq4klJn8gkGYyA3fsqNjEboSY9lrPIeHMR5?=
 =?us-ascii?Q?lBxVQ+yJU+JdReSSqWD78jB6erdn1YhXw9TuxR7BlsQmw/1GMdJ+jukThZvR?=
 =?us-ascii?Q?2cIdx/oW+zC/UoSHERwkLNuXGSMZLEC4XfEJ3w3b89SPHHDJiD3Btmuw5rA0?=
 =?us-ascii?Q?oz2s+hVdadWcwcV4ylKmxIWVk7D843AWl9tNqiJR0CCqU816LHouR3PUXxHt?=
 =?us-ascii?Q?QB54NfJ57DkLmPZpjr6AXshr4iWsx13l2Twy2qoMTY2oEWxeisi1GvzZZAlR?=
 =?us-ascii?Q?NGIofndPF3tXzsxlxoZE0G4HoUNqxlGFsRCnjGfRromPzid5zFZycgJB6Jm3?=
 =?us-ascii?Q?EHZEV2Q/OYQRl+x37PNa9jZsnNFN5jKp7J+RYyOZBXVY1XHOBqL/5lTFK3TG?=
 =?us-ascii?Q?oBYmWMh6Xx1Ive/JXlAsKoSkeQxV4NdwT2/4F2lPMfW/A1oK/f63U3Od2RNx?=
 =?us-ascii?Q?azjv+N4sH976bD9bFdj6mgkCTxyJ1v09IiUFldJm0eCIcBVEre8J8jvo5Spd?=
 =?us-ascii?Q?WJcJMJjyQStVE7WQJ1VvvsL5+0jKvIE7nBs5GJkn1+SefzlHO4QO3rQXJYyu?=
 =?us-ascii?Q?AM7PBFSLjlID2moHKfGAGBLl6RAWfk7lzPB383e5hmc3BqneSRSUS2IsR4U9?=
 =?us-ascii?Q?o+Q5YjxZ99L+jKWHwxiO/mBJ78iEZN3ts3+3nxOu1cc9gYvVRylNL0TpSyqJ?=
 =?us-ascii?Q?4KSmLTOX6PGSEzIKZ+dIUXvAmziLXuk2u8jwlQKQTzNt3qyB6NZEjlCGxiDb?=
 =?us-ascii?Q?yDnAMEUzoWvfvuzSZI4RPlEHkOEGch4lOqnW622G+SrQSXuKXUQSCf32x64P?=
 =?us-ascii?Q?qAsT886cQoNeGarwhaTWis706nUlFVqh8RB0D1Bz8o4V9QE2I208qDjBdYCp?=
 =?us-ascii?Q?VvzJHA5TYU9Q3dX5/KOxNy/1X4PDxzy+FEFkRY+Aja/k2FDVMVqI598XmNZB?=
 =?us-ascii?Q?AnScOS+TbmxhkGp4IGpAFD5rIoqoG2q/PB6nEcvbp7VMF2TACBGGoh6GcXoP?=
 =?us-ascii?Q?gZDLUGBjhQdu++4j6H/Zs0RlLyc6FzqsX5K40PyfqsTFozZddRCs+K6BE+hY?=
 =?us-ascii?Q?1WxJthmaYBrbOzBbzi6aASzTU/7yUM9ocRgcGgp7x5fzUAa18hFe/fCtgLpr?=
 =?us-ascii?Q?kEkeA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 93SDu8qLOT22K9ioDbfaonF3TTGh3nrP+mV2W4MsiH/XnB1H+giycSxtxY1kh9gdJajyGQogjNGbzExsS+lZaIBVCHIVng/mL4XO4PB6gwDhUIDdBdOwBttzOD0fMbW4/uwFKuUR834g2t8SMjohk5m+PfUa82gXXi+CeOctux/ffZqIpl7NrvghmdkKude5T6JxIKyRl2dLL3TYF75gVtO2aYw71waCjjqaGbnRikt7va93YUnytxkfAk5Sy5xditrA+l7k0kmXsppMBsLMcdtl6RY3ybaEYjJQGSP4ac2ndbt3rbhiLDpWVmOWeLaf/IHTK3YVTwJdsQ7ko7Rq5PjszIX6vmiHCl76jgxn0tU=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR08MB4930;6:ebxMkkEyKqqZaF6dTGDll5IzGgJuNHJ/hCSJD0vB/Qp5kKhng1WiJogRR8M0HYKHbq8Y/81E0tx3PcVxk8+cr4bXM/tNJtD5gNnJpbQhQglkdyPZ00MSXgEQQwTEicxthYL3Mmuf/bX4ijQmXzS65+eaq9iITSraO0M47AzP7y2fiByXUXMmS7X7qjwPYBiYQVFyjvXqL+RuuQP6geumS9a6GUpWhHK6V4y3B6LjysE4I2TUZIaYS8XoXjyT5LKlKIvM8dW3487llAEqvcPezVbl1swtL0Wl8qqwFRvI+FBmu5skxPXjijnvjddpyFozLSb5B9M7b742NfdZi18rAwYVHcivatOlu3+WLDkMqZ6+XRUUUb/rm/dir5Xm9SdUXZd9S+8NuFvhXOZLCyasJ41BuZqon4Myi1PlKuk/9/6D/C7DqNPyxjKhWOet1XEhrv3lXhtjCbKmhAJ4Sh/9BA==;5:TFI7Z6hkwjV2kB6MfsSjU0OnB17OCI3BmvQ4FatFemEH3+FJ0mFEVy4vnSeOpFryiVRX4e/bb7pJ2L6w9WzVQqG533tMOxIl/SKZPCyvtCkQ7nmKxCy8H8l/w+LITLoFvY9F7bIeSSX7hzQa8qt9ed8FNHozIAaiZ87TLj/51Jo=;7:NjTXWy5sG5/dv8lndflLucIZfAdASoK8HvUiS/se1VY6lmHbuY3dGYU9HA7Eo841qI6DuHnhZ0kk7/DgU0Lc7X66pWNyfFdvYFYB+pFeV9eEnPxHwL705ForxOwX+gl3ZPBHci5SGJBn+44d+T8y2+mhG2gFdiJqmRLeCw5R71FeK9JFiexwDxvD5fTZuH716uMNEKRbHMSucq0MclD9hl/Q8yXkzVQN+rGDEbSPhyY4YWHXg+oyYKepKNJcast4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 17:11:36.0110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cce1b1-5201-4adb-4422-08d6141bcd65
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4930
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, Sep 05, 2018 at 06:53:24PM -0500, Rob Herring wrote:
> There is nothing arch specific about building dtb files other than their
> location under /arch/*/boot/dts/. Keeping each arch aligned is a pain.
> The dependencies and supported targets are all slightly different.
> Also, a cross-compiler for each arch is needed, but really the host
> compiler preprocessor is perfectly fine for building dtbs. Move the
> build rules to a common location and remove the arch specific ones. This
> is done in a single step to avoid warnings about overriding rules.
> 
> The build dependencies had been a mixture of 'scripts' and/or 'prepare'.
> These pull in several dependencies some of which need a target compiler
> (specifically devicetable-offsets.h) and aren't needed to build dtbs.
> All that is really needed is dtc, so adjust the dependencies to only be
> dtc.
> 
> This change enables support 'dtbs_install' on some arches which were
> missing the target.
> 
>%
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack so I can take the whole series via the DT tree.

For MIPS:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul
