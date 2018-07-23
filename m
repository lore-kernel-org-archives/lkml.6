Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4704ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F61720854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="lvZPpd0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F61720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388617AbeGWTBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:01:16 -0400
Received: from mail-eopbgr730115.outbound.protection.outlook.com ([40.107.73.115]:12832
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387981AbeGWTBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpx4bvk/Vu9PksWGiFEKPjEmEz2rh5YnV18QkVE5SXY=;
 b=lvZPpd0jiolKddez3YMPwNEz0gh4AOdSejsuBgAlVvD4axVQMvyhMrdpCT+3Krcs5Mcoa6Pyw7De6Kay97elV1+hNZBlC0d83cZgURkpI+YI8URnzAYSWPlojo/ZDN1O+m9miAAYK5GXkJ3o0FyJlh/Ck2ZGkkj9dprvvzAWb58=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
Received: from localhost (4.16.204.77) by
 SN6PR08MB4941.namprd08.prod.outlook.com (2603:10b6:805:69::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Mon, 23 Jul 2018 17:58:48 +0000
Date:   Mon, 23 Jul 2018 10:58:46 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Paul Cercueil <paul@crapouillou.net>, Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v3 00/18] JZ4780 DMA patchset v3
Message-ID: <20180723175846.udmjtkx7fsaf52wa@pburton-laptop>
References: <20180721110643.19624-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180721110643.19624-1-paul@crapouillou.net>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: DM5PR06CA0053.namprd06.prod.outlook.com
 (2603:10b6:3:37::15) To SN6PR08MB4941.namprd08.prod.outlook.com
 (2603:10b6:805:69::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8772df0-fa9d-429c-ff42-08d5f0c5f133
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600073)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:SN6PR08MB4941;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;3:XmvPjGGf9W8myfdqosMquopJRXHIWyFiA1gKMBJFd7upgcQCvXUG0PVRxkkR5/L4++PZQmAgA1VKjfCCT/ANrewLciZzT3OrfftJIYp10xueSMDthGVQbQ1kJ6XsvjDgwQzix12zr6hCr9DKIFMwm7gE7COIeuT1ZMo50zCO1qKB2/5VgnBxfnOhlYq/V1Cqd5kGw7N8YI0VIN9Z1ghZcDIhmS+WLxpXUV8Zrrn6+nKp+2xtVKFDZo1w/fv0XGxo;25:3OeexVwi6DdU+uShv8yHm0lDnwhQZV1FeYlP9DK6D9pMlqOoaV8YEA4z5pY1+i+6qff/ktRoS69R4NXwjjCTus46ectzHB49/sZqpZdTdh+OUFJElvgsce/qELUHXzQ65bK4P8qwvhxFDzuvwOwfBkNu1qrxVJKTaaEgs/2vydGM/rtdzAk8J+jVSD+syzyW4fFO3X2Ii0TU0zOUy2ePo8yo6dRAbrC6tpaP8SkNTCwYdQOGnIISEOflgc+TiOr7JGyrOmP4RFUJHd+Y7st/LJvqwgchqqw3ntZuBBTL1gl/IaQjwCD7Zdcjl6hDEkMR0sDUy6HRmrycVFRYx+xLfA==;31:569RiJ1cf6qCdT14Canj71qsE2rI+kU3J1V4DrWUuB+hzUT04AmBY10N58PVhdq+zQ+1YY0YxsWL/LD0RS0vSDvXI9HkXSn+UQzz3ah2VCwAu1+qIcwJBz4+YfkYQpKePslazriQ7NVnBuFMoSPWW7aRp0+5AMRGFKdsC3k7TD61L4SGa76GvZrf/KxvgUbtRB27t6/DWI3Q4STM+YObiWrRWxMncMLJYSbFBqhqIJI=
X-MS-TrafficTypeDiagnostic: SN6PR08MB4941:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;20:rRQL7REYB16Vh1O4L/c+/BVelBQCiiz5GalfOX03I6Rjy7XAuO7bpBLou3VXBJ+mr44Jijj5dOtfCTGTiFoB2WrGnqmXse8f5RVIp4FfnA6/lRmf7cscUwzyYeLUXyftaWOentZfRHgLjjrOjK7oRKszXUMalrxwSFaahynwhzmklodpCQgg+cFkrk2eejSybgg32bcTa4M8pEVI+BzAVwRHWIg3uSvibF1G1hualLuMMfSOBH/tu+m4f/aLsU3p;4:d7YXSgqHHRG2JDHX8mjqlyXDQR5x06CVymycxOolTKuzKC6oZKTp+nHSGDp4uQFRswRL0HDUw83AMyMvP5wEwIUQYscGM/vcbQd474JzE7njXW0SwgHn+aZ+I+ItkQ2WcvmNs7nKyStgLWzDHf3HiJa3V7S10aoW4ZNeO//owWUj6W1WWLuAJSMyzSmjRppqSp4dHkPnnKrFryDclKtYq+tITgtFx9/6ETu+Tw1G/uUCs28x4vg+7sGfxeXmNIt+1V7WwQRV8Xa0QrNBfLb52A==
X-Microsoft-Antispam-PRVS: <SN6PR08MB4941371B53B461C41A250AF9C1560@SN6PR08MB4941.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6042181)(6072148)(6043046)(201708071742011)(7699016);SRVR:SN6PR08MB4941;BCL:0;PCL:0;RULEID:;SRVR:SN6PR08MB4941;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(39840400004)(376002)(136003)(366004)(346002)(396003)(189003)(199004)(54534003)(8936002)(8676002)(81156014)(53936002)(52116002)(6496006)(76176011)(186003)(26005)(33896004)(81166006)(305945005)(16526019)(386003)(4326008)(6246003)(39060400002)(25786009)(478600001)(33716001)(106356001)(50466002)(7736002)(97736004)(105586002)(6486002)(110136005)(54906003)(2906002)(68736007)(16586007)(446003)(76506005)(58126008)(14444005)(476003)(7416002)(486006)(44832011)(11346002)(9686003)(956004)(229853002)(1076002)(47776003)(42882007)(66066001)(316002)(5660300001)(3846002)(6116002)(23726003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR08MB4941;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR08MB4941;23:T+S11IIzhQ4G0WbSjXFZLIWBOITTlNBYlKsRghQRE?=
 =?us-ascii?Q?/p79qPYEtM3x5+SAJ0qgGNZImSDeAafxdoewJsSBNuItaCZxrsWlpnDud0ke?=
 =?us-ascii?Q?GNaxjwHXlT3Ytd76+eCuVRIhkzYyy98vv78nLZzLp1KjJ0Vmfsq/69Ct5fBt?=
 =?us-ascii?Q?pIRhWxguPm3Yiiaprak5JbiZfl+IqcvPM551fMLhWsBMZhBh5KgYWws7bBPc?=
 =?us-ascii?Q?Vd7sZU/GD1cFHgJO/twDRtFhTLF2L3V6dAAm8n2wImr+GrCQTLWoKXTRL3Ft?=
 =?us-ascii?Q?Um8QCAPsJ0ohiG14umCZF7+JGxSVGjgxWsPuzAnpv9jfiukMmI1HzNr++sP4?=
 =?us-ascii?Q?hI2a+UYYKHJU4U6sJp4wg2hdpmrn9WS/EAA8k2FWlogOO0SVCuzsndFI5wG7?=
 =?us-ascii?Q?rIAdpQXBYemgqoGXrZtD6sWkdrCIXWlu7q+yPRX0UuPnNGKs2N/I5fCFhehG?=
 =?us-ascii?Q?Zyfalw3+J1Y/Q02yrbsizbfDaWQANypXM5HSm3DOQVmsuaYqsQ8rCXYvc2P9?=
 =?us-ascii?Q?oxUpml68N5UfUheu67sVXsXmtsPmdIhpMTXjtVkBjMWvU7Q6z3n+fbA7RZu2?=
 =?us-ascii?Q?ehOQI8YGXMU1KakJqlHB1YUeM5NLndBXdbsfA759er5YaaNsSUe8Zk3Law0R?=
 =?us-ascii?Q?b7hycBF8CAWoNBHw25CvMIwt/m5VImu5inyaB1e6IccK+CQW9ftXqB13EvBI?=
 =?us-ascii?Q?AeiCDCzYBqB6hb+4YpcPTl5aBDfutm8UohtqxIXQYBBSIwPhsOXmgjEz2S+B?=
 =?us-ascii?Q?ixdGgnhhNn6oq19kLE+9B+VOQlPfnoNwZv4YBtqqA5yG2gkCvkPqP0tlKFO+?=
 =?us-ascii?Q?WN95bhs+rWvHN79c4egBmRDSif2Ho5EUA9bUyktA/8ije1qxlVMGzbwYoc6E?=
 =?us-ascii?Q?cFcopWmcb59wMpWofsROOzhErN69BG7ga5UYn07JH7G/f7L+GPSWBNvHaLbq?=
 =?us-ascii?Q?2giVsEh68VCASYmQRXXWtKZdrUo8DRJptg5mHX4Rn1Lw864+VjZlcg3+G51K?=
 =?us-ascii?Q?VGWSscpT6vBX7/bSrCXdjbQmui7W31j7A0LI/dNCCfQHvoY+lQV5zp/tPK1v?=
 =?us-ascii?Q?jyepujct4opEz1jPrAmeueaBbBLKDgCIW4lKzGqt65K0mzST+QAcNT8xFTdr?=
 =?us-ascii?Q?bqaCef+pa8nWJkvRmyPKQjat28JIlPJvnmf1Y4q7R/qjkng4d/GaEm2K9q0T?=
 =?us-ascii?Q?jLOPwElBNOx0Ju77umYPKOxhCHDQptuypoJK82zLZh/JPEKkWtoCkF+ASfLo?=
 =?us-ascii?Q?zCM2KCyE4vPcbIrYZy8X5XBRL7lvYMi5vM9KBVfMbuclsRVz/8Fb4YpFQMuy?=
 =?us-ascii?Q?WgxGotTlxMbIxCuwtwTgyO0weElAPxJBL4ObTkaZALXnOHyd4bWaDHenTdG9?=
 =?us-ascii?Q?Ex5TsWxRI83LnRYzoHJn0zg+7U=3D?=
X-Microsoft-Antispam-Message-Info: qybvwg+Qfr38h/WyAxT6XJxTXeKLU6xq/q9THY/nWeJIaK7L4cwbVmNp+miZaxLTuoX/Q81ayV6rBNWXY1YDZLNgFLsp3eYTXdz6Mrk0gfWXOE3fPLeHTMAte3mG06M8wZUObVX8Virb1uQ+d9h27V1/N0r2egyBrFlq8NxyfH1r66edys2Hn8Ad7L/faZfIVxJ5zz23M3u6bvKVMI+HfrZzKcKnBCYYOvTwrWWmW7jRgkX88wNZwqy9sUuihZ/1RkD+igX5qsfXnyYSvjNV5o28fh+tS/s7DrSLcrgzU68DHkHekkh2aNYEuxJaoh38VLMRJ+4HrJc3xPum6CT9+hQefg1jOMvUgFYOjUPEpBo=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR08MB4941;6:ibhR9AGKmQhjQSnL+MR+FLxGgjUI6UjqQho0tBvcO/wvDMffcMWkxcGbS6cY3yEoQqr7KFTrR4PjZ8TqDs1pCKKYgUzH9zBRrQyxbIQrGm//ul52epkRrkz5Uy5xA3uy96BFl5otIuyR510FhHITAYAnLd8hbq16TG+RmBwsiqL4RNK6fa7Yt2GRBBOqFtGsRtPXnebhAI7IrfClyyQAVG89he3frkjSbTNIu1DeJliifc5f9VwbJWIxne3gD+0K8SB3hiV6lblvAW6ehMIArRg3fbyAWZm7SxyeGqgz7SXfUvG/8msmgZht9nTdTvayGr0yi6uIW6toreSF5THUUF+JLqNvvj9EHafCsGTNteS0YKGZOv3cfZs5lvvMe17K83q7A+hokUe1KqoePrkUyTX3kIYGoca2b64hTNNe/169HCfzt4bch1mIzlxRsEyhsxAG/rL38xu36vi1VdPYhQ==;5:wJjk39BM5fguJIZOEV3+IFlZBFyRyY9oe6Er7cu+yF2ogNaDdV85muECC5pRSb1AUXvQp8hhVeMz36Sxpfu1oe7VHeCj2wZssfnEJa+JK7cQz31vKKdZxhEVAYtQd/I5VlEpEdztsq8uk3jkKcF9HhqH8fO9NTxUKgHz1JcXduI=;7:YBg9N3/ReU3hCg+rzaSe0NB4pmisVAxE2Djt1Cd+pNNljCB3N0BA2/9waZs0wVTwwH8VBtnTKOPDGnH9WoQBObhfNZevNbr5RXrnTe0QV4PHxlgEa77hzWj0WvGhu67XplU8NXP0i5t5VByt466xEA7NcvsMYMMaF2RzY1i3sfFldWsoXZbvTeEsqNFwS9b/5YcqPSvtszBpq1da57Y8yVPT69tdNKLvD6b+Wb29VxkL6/sgXfigeH/OB6lenxj+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 17:58:48.6722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8772df0-fa9d-429c-ff42-08d5f0c5f133
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB4941
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul & Vinod,

On Sat, Jul 21, 2018 at 01:06:25PM +0200, Paul Cercueil wrote:
> This is the version 3 of my jz4780-dma driver update patchset.
> 
> Apologies to the DMA people, the v2 of this patchset did not make it to
> their mailing-list; see the bottom of this email for a description of
> what happened in v2.
> 
> Changelog from v2 to v3:
> 
> - Modified the devicetree bindings to comply with the specification
> 
> - New patch [06/18] allows the JZ4780 DMA driver to be compiled within a
>   generic MIPS kernel.

Would you prefer to take the MIPS .dts changes in patches 16-18 through
the DMA tree with the rest of the series?

If so then for patches 16-18:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul
