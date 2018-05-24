Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969888AbeEXMQA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 08:16:00 -0400
Received: from mail-dm3nam03on0105.outbound.protection.outlook.com ([104.47.41.105]:63504
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966168AbeEXMPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 08:15:42 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
Date: Thu, 24 May 2018 15:15:24 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Adam Borowski <kilobyte@angband.pl>, Alexander Graf <agraf@suse.de>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andreas Schwab <schwab@suse.de>, Andrew Pinski <pinskia@gmail.com>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Morse <james.morse@arm.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Lin Yongting <linyongting@huawei.com>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: Re: [PATCH 07/24] arm64: ilp32: add documentation on the ILP32 ABI
 for ARM64
Message-ID: <20180524121524.GA3873@yury-thinkpad>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180516081910.10067-8-ynorov@caviumnetworks.com>
 <20180523140620.GA27215@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523140620.GA27215@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [176.59.19.210]
X-ClientProxiedBy: HE1PR06CA0145.eurprd06.prod.outlook.com
 (2603:10a6:7:16::32) To SN6PR07MB4382.namprd07.prod.outlook.com
 (2603:10b6:805:58::13)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4382;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4382;3:rhQRBJl8r2dCnpRVQsucyAe3HKKysAOJnQZBHHZaAzSuqELW+t6Z/h602898JFgWAthuG09GLAd7I4I1lCM57gYW8+TDjL0AsYnHX5Uh2SLTY7jOWEATp48gbsysBIetc12jhJjGApFKMRCQ3A3CgfF7mU4uZFeC4x7BgPO73nR/5MCmUEtJlSGgKsgYvAHEcDvzmF5t0EBuVNJ7YzZNCbcwcMF7UKOVNodseoBvT/iENTOi1SX5O1pFZ/GvwdsI;25:2GBCn0Jl45nbZra0qZGdDztdy+In0nuQwjS0i7nOKDjhvNBwmrc4RSZl88iFvPRPpDLUA2TsHiNf6VLnDpeOxzPGyktf3Z4KYn8s/MdOslhypIVvUtlX8qO+zCfguMpihyoqU9Ww10WnUR3+Y/QBuMXf9lye+MjybCETc4IpMig4pr4KCrjyT82Kct4aFn7XA5KEu6lF0cAmNaGQpR7UzQ3tnkhpLTunMSqlchCSEtx/PaZxPNEvenpDyFJWmq401Ib9YfJOVTTGHsGD+RQrtDaD81gWx/G2Qs9PVvB+7Tvdbo04WSk1NLWFHeBt1M0oDn6lfth7OdF9C40vRXqMZA==;31:Faw2eN9O6tSTCp8lZ2eFXYqydkJQBwmGwQVaZE1C7c7vRlm59uUWYQPIJb9wvtO1u97R/1znfYXBSnW9xDjru3dAUe5Mw8rok9C2y1PNZZx/b8z4AwFEZCaXZ7EVPLuWSgWWoXJ3sMbcFpEg4WT1VeUQAOTD3P8Mpk9c51XGEztojMiFJoVPRngve/WkpPnQ03nTyLraV4jQV/sI0uI1EDyljpKdFJjRScOByVFthSA=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4382:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4382;20:A640eMVA5VuMyJTbiemZ2lHr7NA7D2S/3zdlMIRBHTYHz2TkkT9/rkXSgwmGVGTba7c3wRRT1LLbbSEdv02udNcv7ABkKTHbwrBAnDs92LoESGeUE9MMcRKyziBqN5EWowNzV8OMD+QYzKkJ8IsPE1z0aMJF9zyv5SaKPO836A0RkIPTzAMqiWKW3ZswzlOCVsCNkhrQQY+8oRmEQpQ/xqeFgdNPzQ+F+lHT0ZN8VarqH3GA6M8ol4FdiaylS5HfyCoSFIBIFiVMMI9GQvJGVCknubR04GJcP/3xiwTOqmBJ76wK7B8e2Ug+6TxBRkDBt5kTw7Lq7YwkL0G+DX1jd398hcooPDov7YrnzHr5Sdqwtgqv0qURDqe1T0evoECvOPFMvDwrt+xoBBTjs3eog0DHDPeXdjhpnXC2SRh1ANK/PoHioP8A2Cs8ulFVXgbX0eGeaomj79PFznGQlfezSrG4dpw3OTUyVDVEHa3oJvM6fUQjAIkpjqUmAvIPR94TEWB/q+tFCu57P2oGKtaXWTVqDHZ9LRsORlPGIh1E7a08f+S270f1TJdq+ioHM5hopWUPpZPI/4LrDf+cBgICfpiNXmR9Py+/nu5pCbLZW/s=;4:x8vZX7pPCVldGr/xIDks16qsSusCWz8V6HUXYhexMHcPDZcN7P7W5k81A4/nz/gur6jsGKHLTCrgzg3xtsXk3dzmV7WjSN59s4r7SvP6JUxzdOjwv9jvHhO+qDOL1QEDQ8S3V7N4OliTVzVN2nlzFLqPaeqpQggGpqhK5FiDdqeyxrpZ6J0qjVTsEe4nIyf4q6A+KK+nptLvdB/Y5gB8gAaCfD/AbrfGvvjnh7tmOTM3oEuNqUdEIxco8DJT7QdHWdGG+Nn/o4GCNdYxFVbsehohWBW58tnRYXpU7FtGnf4hUDt80WWniNVcC3Q5O79+
X-Microsoft-Antispam-PRVS: <SN6PR07MB4382681F38B38FAC6E9BA43EE36A0@SN6PR07MB4382.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201703011903075)(201702281528075)(20161123555045)(201703061421075)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN6PR07MB4382;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4382;
X-Forefront-PRVS: 0682FC00E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019001)(6069001)(6009001)(428001)(51704005)(24454002)(377424004)(199002)(189002)(20776003)(69226001)(63696002)(47776003)(74876001)(23726002)(74706001)(33716001)(33656001)(77096001)(76506004)(76786001)(76796001)(81542001)(42186004)(54356001)(93136001)(92566001)(46102001)(64706001)(81342001)(92726001)(15975445006)(77982001)(59766001)(15380165004)(56816005)(80022001)(66066001)(76482001)(90146001)(65816001)(87936001)(56776001)(15202345003)(54316002)(74366001)(44376005)(87266001)(4396001)(47976001)(50986001)(95666003)(49866001)(47736001)(51856001)(50466002)(85306002)(79102001)(85852003)(83072002)(83506001)(21056001)(97336001)(94946001)(93516002)(95416001)(94316002)(97186001)(80976001)(575784001)(81686001)(83322001)(19580405001)(81816001)(31966008)(74662001)(19580395003)(53806001)(74502001)(47446002)(3556765001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR07MB4382;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4382;23:XD8IHKx5ylMyyPN7CvzVSo4OvHSh55oZoyVgurKTk?=
 =?us-ascii?Q?svufSxTZSNpshJ3mSjr7JljdkYZwxE+6LQR+m6+j8f2uuv9W8MvGkYWclWRA?=
 =?us-ascii?Q?03KAf58HZsLO0CgNza7UJ+y9fmDSkwaWCdiXMUgrSx8aHFWPglKduTs45h98?=
 =?us-ascii?Q?s8eYxl/Tk5G2LKlYxnuahay5jMiJ7jO8iCnHKRAzDlrTjosB0yJ36zqJG/RM?=
 =?us-ascii?Q?TynmzVpa4zczTuRvJ16iP4yBpY0NxhLecJE2sDl85xRmPbBwMIA/jLIMgpNw?=
 =?us-ascii?Q?msdiU1gLx6axMhbi0SLOCkOPpO7ZxfYCl5Ho6+bmZ/dFnp5khHkhM678Iiaj?=
 =?us-ascii?Q?H5jM4+/RrRyFJLdRDUnI/B12DiANq9t8mF4OKt6uwNuGeFP1kmDeBTzanal1?=
 =?us-ascii?Q?n9pnpX+Bl3/+QFHgxt2iQLuiz+BvHB7xhVEZfNRBCyP48CetQng9LE2e0XRf?=
 =?us-ascii?Q?uxk1QGfCFnvzmc4SXLEKUpTAmE4kzdBjEoKo8HsJFoziOmbkg1TlFLggrltk?=
 =?us-ascii?Q?APCeWJw42w4vUBMDyIQMqByYc2zMKduA1F+yfMWoTE4zAZY9zJeV1vhVxjG1?=
 =?us-ascii?Q?7gGZeSp4b3xGfq8KL999HTnUCEc1AqLKQrxIACvaJBpMbmsmUerjv7go0h1X?=
 =?us-ascii?Q?724mC1WjTmxMeWwiLv3cCZXAWA4a5x5L7gJFyz8ZGXLrwd/VTMnILG6PDb2M?=
 =?us-ascii?Q?+DF6GSQXZcH569Y58RA2WuRn3sSZpKOnTFd4BJHCtMn8/cXVQxt5UG77JJXz?=
 =?us-ascii?Q?VHVlEgTBBpeUE9a7WyERdlB3RCDrtXg/M/b13V4vlzbISMD18hNTdQEgmBsz?=
 =?us-ascii?Q?LbRmyFykwRvK9TB1P7r+LnkvjqeMuCX6hxfvU2lnGrn+OzRz9SUUZhlyI3iM?=
 =?us-ascii?Q?YNEA5Vm9QZOFPve6v+MSfB0nmGArz4ecE000JHv/oYpewRLD2agx8/B34FOL?=
 =?us-ascii?Q?Q9v9GzTQ25nxjApS0K56apguVgQ1AUSYaidWnYcpMCL0ISU6YFohpd+xQ1EB?=
 =?us-ascii?Q?umfi7dBxkbWxVEuWIpE94rwmsA1MNFRdHz4+kP7VFotKDXsNMx+TfkVQ1BbV?=
 =?us-ascii?Q?n3h6jtpf9TFLVfJR94W03N17MUbl3AGhXte0u5nAOj214JOdDfWXGHQNXHFo?=
 =?us-ascii?Q?Jn79TdujdtQwNUmQeJ2YTM2wDLUFQ2fPC7wqxthZuwPYIy3yY34fKttbh+ls?=
 =?us-ascii?Q?sIlrgOahC1oK5PBw1C7Hu4cx+csz2jNAnS4vKiOlGAB+AMhqrRGNImWkr5H8?=
 =?us-ascii?Q?1Ftv1Il7OoaOqptBhY/i1BQUHmLESzsA9GFumOb/cPo35XMHNnCjJ9+wpVPt?=
 =?us-ascii?Q?j52gCQiH+EjLRimwe67EyLTtMAlXVwSeo+iw633oRAAfUIPkBc+Ufysa7iMK?=
 =?us-ascii?Q?x0fO8clQdjZbuV+w9tQ3oRYgnKAgjy7tiHxODDTberm85hlp3+Rzc259XbAx?=
 =?us-ascii?Q?jZmVFYY1RJL64YHNZJ+9X+XtjlAC33olA7htFVwl5ZOm6woTSsZSgXrGtMzM?=
 =?us-ascii?Q?nvbsV4ht0BxQHpD7Mm0KNG+z6OK+PDw3nhIi4g/blCMa4jVVe1JX3iT3gQXK?=
 =?us-ascii?Q?yCESz910HLySTtdxftGoLtzDeyoBa68HqstrsvdZ9nXY3QioE1KO9xosyFoq?=
 =?us-ascii?Q?iRbk00NnGx1Bxdkyzao9Sw8PCqv3m/pKR6uo8Kb9N1IQFRM97KZuG+fMZ5k/?=
 =?us-ascii?Q?APX0Zdc1NZQhDlYPSt8e3iW1+sMjp1iFHLzI5lllDaSX9qUE9oarbqkD8crN?=
 =?us-ascii?Q?RToAeI/CiAoVDpdm8BsU/5csgJJeS6dtdOlurNrxdiT41ZJvHMHcXB2VTGPy?=
 =?us-ascii?Q?NDkQYf3KcgIGvwH00RREStZzunD+F0+7kk5IalyIGc37rtpvsl4qd8N/GLj8?=
 =?us-ascii?Q?I4RAd4tq+nAPDJFMMnXLJm0dW3UW0CweqmLfA=3D=3D?=
X-Microsoft-Antispam-Message-Info: lm5zVQMOvnS+LpPStqnwD18GqYuY+oshfPZ1YX2h3nuzJ7PPjIOel0KrcU/+33avMu3aR5lxXrwUPGj1nJMeKCa7wEtG2g6LdA41BFQH+aKj0O0OcNO0CJTL7H69yW7sTjhFfmD9g5VrP4BveEus1h+LMiXQAspKBWMtSWO0t1t48evtT9WepA2eOQe3NFll
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4382;6:JI14Mol7lN1oacYWwklvFcMPDptqg0w59Kg7ZGjtp0VJjwJfl+TJduQdGn+t+ysrHBO9OA5QsJLsA4fDN9x5HAwgeu/NGQJwBJ80hmoBb66KBrTbTT5klXfcP6WCPFRLOU1pjJr9WLn4LeiqRHeXU7kdDhVcccxSWFv/yaUFT34HT1UbjFfXDcqhF3AU+hlhNb71DMlGdSnd9nORQzPfQZ2L4Xdlt+S4ui+A3fmNzE9qNlYM1YONy2bXfHVVhShqDPDZnvQkfkJmmn+vvPs7u284BiHdFzjXcwYkiQDCPAUSI9iRybcv5hBpGnHc7eZxII7IsK87viZHcKd9k0POj/Avnh4DNORMb4pAHP37X26c61ho83Dmgqm54Q1fz+6GT8eJicGEQF/1nWbrQR2XFB1iXm8QEDCe4Vb4tLGYuclAbxb3YJrzxczogZVjHqZdPaw+8q65CIt9whF/AhCj1g==;5:lFdkTgd1860qpSH5KOsDTs3OaoM3482RslkdvNQDBjXYmDhqUDqTNVbje9Ka19FTPrjzdAC9mmQfBaoP4GK+QKZ1H1RBSDUhyeW41Z2BnCQQEOsWDfN2MXP+am+QhbI9y8wPwXSNslGy/Zph9mYMxAhnv4HgTq6pAI4DWG9/NgY=;24:aMg5MuTt5oomqofRJSfwGy13KKz6anyUWTghtXX5p9DjvF3tODugMqbUWEeBDIPRyHpo5ucazuwc5DLPcsJJNGQmVsZOT7QvLE1446nNePU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4382;7:BMTXgZosKP2X79Tuz+/hRzg9D9eZ5f7EQ6Gtz+BEDk3TBvTS5MoCl+TRaTdLEJOZKhdCdVgcLt9FaHj+s64WUeXsE7GHDEzhMH/pWfuC9JyCXcaed7nMVWSxgCSQ0bxtHefKLu0yAH7lHUsm6TSReNDXbMN7/mLKwi49h1P5PnJ/p0AzAeam1aTRZpT8YDEgdy69tSFFSFglrucGZqs+qX0qtZQFu8vCpL81hVTigBvxYFJljGSNnwHxpWgcl7gA
X-MS-Office365-Filtering-Correlation-Id: 106b5636-42a6-4025-d1cd-08d5c1700efe
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2018 12:15:36.7996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 106b5636-42a6-4025-d1cd-08d5c1700efe
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4382
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Wed, May 23, 2018 at 04:06:20PM +0200, Pavel Machek wrote:
> On Wed 2018-05-16 11:18:52, Yury Norov wrote:
> > Based on Andrew Pinski's patch-series.
> > 
> > Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> 
> So Andrew's signoff should be here?

Yes it should, but it lost since v4. I'll restore it.
 
> > ---
> >  Documentation/arm64/ilp32.txt | 45 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >  create mode 100644 Documentation/arm64/ilp32.txt
> > 
> > diff --git a/Documentation/arm64/ilp32.txt b/Documentation/arm64/ilp32.txt
> > new file mode 100644
> > index 000000000000..d0fd5109c4b2
> > --- /dev/null
> > +++ b/Documentation/arm64/ilp32.txt
> > @@ -0,0 +1,45 @@
> > +ILP32 AARCH64 SYSCALL ABI
> > +=========================
> > +
> > +This document describes the ILP32 syscall ABI and where it differs
> > +from the generic compat linux syscall interface.
> 
> I was hoping to learn what ILP32 is / what is it good for, but no,
> this does not tell me... it would be good to do a short explanation
> here, and maybe reference it from cover letter of the series...
> 								Pavel

ILP32 is ABI acronym that means "Integers, Longs and Pointers are 32-bit".
And LP64 means "Longs and Pointers are 64-bit".

There's AN490 - "ILP32 for AArch64 Whitepaper" from ARM which covers
the topic:
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dai0490a/ar01s01.html

And some talks:
http://connect.linaro.org/resource/bkk16/bkk16-305b/

Briefly, ILP32 is 32-bit ABI that works with AARCH64 instruction set. It looks
better in some performance tests, and is useful for compatibility with 32-bit
legacy code.

If you're more familiar with x86 terminology, in ARM world LP64 corresponds
to x86_64, AARCH32_EL0 corresponds to x86_32, and ILP32 corresponds to x32
ABI.

I'll add link to AN490 in next submission.

Yury

> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
