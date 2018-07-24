Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263C1C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B749B20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="rd3xeRrq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B749B20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388241AbeGXGu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 02:50:58 -0400
Received: from mail-sn1nam02on0044.outbound.protection.outlook.com ([104.47.36.44]:15413
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388153AbeGXGu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 02:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2ZUho3VkV7xOiZ2h6CqNBeFUwQ4L1zkzKFiLrTggxM=;
 b=rd3xeRrq/SfWMu8OmKJNQ92DlYQJlz4/cVbUGQdRqdczRNAxK6GhN9uFUXgRMGS247gHd9NmKE2K4nbHe5wJi4azJ3/e45ChBTsJFEMbeLVl44QADPpX3CewJA7TdHCzu2niSVIfb0LtDmH6Lt2I+u9RniW8oCrGBJh8DTuUvjg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY1PR0301MB1580.namprd03.prod.outlook.com (2a01:111:e400:529c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.22; Tue, 24 Jul
 2018 05:42:18 +0000
Date:   Tue, 24 Jul 2018 13:40:04 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: arm: syna: add support for the AS370
 SoC
Message-ID: <20180724134004.4fc660d6@xhacker.debian>
In-Reply-To: <20180720151529.GA26487@rob-hp-laptop>
References: <20180713171712.05f58a74@xhacker.debian>
        <20180713172457.6193a92f@xhacker.debian>
        <20180720151529.GA26487@rob-hp-laptop>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:404:56::35) To CY1PR0301MB1580.namprd03.prod.outlook.com
 (2a01:111:e400:529c::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce70cbce-fe44-48c7-96e9-08d5f128392c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0301MB1580;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1580;3:d1E11r70QmZrys27M5FIFli6q4OAvP/JQEbkEs1yhgjCaNscTKajIxGTJJg4gqRYNq1Uefvi/60I3jrWfaOPTzIW2OxdNmc5nHiouka4KMInfwU9B3ybkX3pEeZyAOzn9Dvcl8ZI/pO3YSt5sAyMWGKRZufiHiQQ2e0oHsB9vtSSuk2kfACj8NHFUYvtWhO8GTZl/dpdvd62+/ULiF2y3GNFfw7paR+tO+822CT4Vj37UGP8faSN2Ilfnm++LYwm;25:fhf4MJSJoS2ha7GKNqBSmByhwEWJl5rs6l9/97MI/cfQIQidoavmln4qj7THXDTkamr55OqGXOguWrh/CAfArzD+EHyyPkbpM4Vrm4I0xZ+V+TWOMP0xBAdAWJJEtYYfa/jG9s5ufMpKx8UtZn132uK95/MbdRJDona7LKImu3aZmBDrRCEVvDsS/O/Q96aI8fd0qcqVyYCC9nFOIynz2/fXRfQW9b1H5+/4WSF1CarrZZzTanTQjnSG6FQR2E1sgdfIJthQTgLHdKqYFm8jE5GkGoVo8kPiqlV3kjEf17RMgQgHOAK3bnMfWkYCjZGwUjXzil40HtOu2eZCq6TJOA==;31:+0+D4v/DTukEQ4rY+XJp+wAiWCRdOmFu0p8N+shriVhWcPydl3SVcb8N1qEEt8jzjKnEvq1j4avOYR8h9YlTII5Q19mbpipDsBG2R8RZZOXAUMsMJRYej7BwgeyqElbOb406URPlijPXnvhsaKA9nz20CLCkB9VYpHKMd2yexWA1zTPtAatxzNXyOZH2jLlVCSpvn/yROYEXZTkLNhwEEYwTgNDgh08W1nqRojYeC9I=
X-MS-TrafficTypeDiagnostic: CY1PR0301MB1580:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1580;20:kjZjcQjrOjNxK0orCY0sGIWdr2bAxev4AInbYNV61lu6fqzzeFLJsOyjTZNgnbfZ5YhMfQgzvL1P+mRibwvk+3FLYMykdylXt5gucArXnMtqqGNgZmJzrsNA99ArwN6LCW/NSsRpN73fo+HzfC/deoGhpuAfrrBy+OOVpEMK/CUMu1Qjoy/GQIDVpEVQ7Z+ZojYgVX3x4HmGjMWx5VEGXcdU2Ms1raTFN9E1fh496/9Lvoph7MfdI7Pl4TYbegpgMgqP4krvcNf1eKJCNPtx9LUprzVzV8mBZrvWM8WDAlgEM3O3JtWJKYZCSnD+wtLGbLMcunVJwkzJznNkxY0gpR/mX9atthNGvBBQC9isaAzIiXEVnqesp0BYyhrWasuAtNhy83DPxum6GqbVpE5AkBn7zQekRM8++Jj4ndJT4ywjaotMODzRK5BNvzEE8qs//jt0peA+WItDMcTR34bQQLFMltUN9V5ga5VHI/LJ+McNZuTtdixCrYl6rAkmoXC5;4:hnx2SayWSCVJBFtI2Ay4NzCf7DcSdlw3LHrOCIyxzucvgzJ0bA9y57wPzoBRwD2VzGhbfqxJuWHjtShjQb7sdVBjQkOFLvd3/opdH/yUOPap3ipqFzsRshcGR2irk+QYobfy8uPkWLuhtaVFwOuez9G9NqsitpYs8iXW2smmFBfcyiUZZYqf0LSCgfSXoD6J63pHXdTAVIkaM/yFYhG6OwYLRl1/dilthnsGN1D4wxZBb/OxVLwVTc08t+uHZVSDi4Z2wJC1WkriDAhPH/nU/fDsk5wut6q7OQPMmVIfMe2z3ZP7TOReuxzlLnfBiTQg
X-Microsoft-Antispam-PRVS: <CY1PR0301MB158094564A9FD094225AE8B1ED550@CY1PR0301MB1580.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR0301MB1580;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB1580;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(366004)(39860400002)(199004)(189003)(105586002)(486006)(106356001)(14444005)(9686003)(6306002)(956004)(476003)(55016002)(47776003)(3846002)(229853002)(1076002)(23726003)(50226002)(86362001)(68736007)(25786009)(66066001)(5660300001)(6116002)(2906002)(305945005)(7736002)(6246003)(53936002)(97736004)(230700001)(8936002)(76176011)(8676002)(6666003)(81156014)(6916009)(6506007)(386003)(33896004)(81166006)(50466002)(16526019)(39060400002)(186003)(446003)(4326008)(11346002)(26005)(7696005)(52116002)(966005)(316002)(478600001)(72206003)(54906003)(39210200001)(422495003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0301MB1580;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0301MB1580;23:uZgqieNvNBCyHJUMcp6yYD+982hT80vjcL4Gw/1?=
 =?us-ascii?Q?Cc9GXyWayNAtyBxHScSt1cpN3n/pY4+HJ3VHpryIvZPV0pgyNIbEN+EXqdSg?=
 =?us-ascii?Q?pwBwfqH2ib3RuO53aa3IqtTpGAb1nzxDxbBRVAQUXH+3ZDERKxKGqcMZDr9m?=
 =?us-ascii?Q?749Wb3FwTPrLTwS6Zao36cdws+ZcLpBj8mH56WtdnH32zvXLwxaLv76PFtBP?=
 =?us-ascii?Q?iX0Xog7GX1ZItAskZTnR2WpTc+eelo/xDeUw0apYUmkUeOt2Jj8pOSocIsqS?=
 =?us-ascii?Q?U+32Ts0SYulaks31wBn5HDQPDAqnCaoW32MCcwCzqPm/5Lj4+SlcS4yGyMZa?=
 =?us-ascii?Q?IuzyZ5/ke3RrRBfnnPS8Z1WvlE/sgxwj5AVlLSxW2Itwi/oIzpLUI0765w7W?=
 =?us-ascii?Q?dDigbSI1BOulWGPg8IbdYvZtdDeTPvkWIXRvdn3bpoCxUi+b2OUaU/bPpZeF?=
 =?us-ascii?Q?FzfEzQrPPP3M/cEY+9Fzq5xWzAu2E4h9v2/Dx/xGc7+H+s7k9/kYbnzD5++q?=
 =?us-ascii?Q?3NqB7h5qkB5yct5wtUwOfhycbus3V2VW0cA6Q6ykJMznyMVThJlf9MNL5ckq?=
 =?us-ascii?Q?ej4gN6v6WtV4c3pJ9poHEsh2yi1DHFE3xsUdggLz5MdALs/eFwMDXvduJKfD?=
 =?us-ascii?Q?CLmWEavpRtanDjxIf2B84HbLWuAT39VHM2beKQuDL8lTMO8UtJay6jNf9uYb?=
 =?us-ascii?Q?SaMxwA1cRgbXHf13B4PIBpEdmZge+fK41KDDE6iM2UBlyjuMFpaZtmlr9QHi?=
 =?us-ascii?Q?scsnh/y2bc/6nq7+Y/JE8wpGK2UgJTAS6e0CwOPgvqba2j05OiKwbcnA3y6F?=
 =?us-ascii?Q?F6C2pKWMoo4+ghoU+BTpdzxx978rOqPqMuEiYVN8LBbENCvyPaVwFrshhe6J?=
 =?us-ascii?Q?IR3xbrohQEjdPMIizud/mcBwmromocu9Ip1OV2YdzHu9JEyGKrQihtP6tUBI?=
 =?us-ascii?Q?KS/64WD74wnTKlU2KPmJgAY1hX8nwxYh31XJF0Zv69QZBN2hFADM2KdDoboW?=
 =?us-ascii?Q?3TgdqSg7lC6GQPwGkwnqPCKfLMfvVoRkhqiv3e5A3jGompp7Rq0IVc4qkne3?=
 =?us-ascii?Q?OPuDIf0HyTmXZzmKsoNg8oUTpDwIhfTkTIfUa+ufanTolRDhBNNB+PnVGOdE?=
 =?us-ascii?Q?7vAqjT1I3gsc7qL5flNrBNB2YMyHY9mwX5QooSutNT92zr/noqObb8Q0RbOY?=
 =?us-ascii?Q?252VVQf9cvxOg1R7EpF4grdY/Vn2KY68YEzQrwAnuQZAlsfDaoYZAL8ghEvJ?=
 =?us-ascii?Q?L8npdrmNmFohmYPKRpjaf/p0SEbQDVnhauC4yIEPr4+KvsghSPtx6cxcIB+D?=
 =?us-ascii?Q?TJwyi2SbM+MCXt0S5r/0lCcp461H9xmwSe2gJWZQgDT97wWuT5c4Cf+ycGvF?=
 =?us-ascii?Q?fJ3i+j36hAjzH4nNJ3tmFS6OUZCw=3D?=
X-Microsoft-Antispam-Message-Info: qLt6S3wrd6QlmQV7u/RpIGBLYMUxGH2CHpWTdArnclByF2X0tT1ZP1srHT6Pw3JpZ4CdMtoRXblyEvtJre18vEY38N7PpiXoIv5xaPR7osPu7bIXovSkymWkax6ha2FSRvHvo//1rS7mx2P4CSMVdTUlXuuW40hUtszNwPhfe9xPFO063hZT0inaFwpDs4VNoPzjgh6ulxxHHUZgAhRR9ti6OzzoFr9iNaYxZ1t+7cRTR8CUBf+oDhijhKVlDwYia2xNey9Hcgnd81IhdwUmGvDWRWBJk5pUcZCy2cos/RCgBWNwX7eksFFfWZyLjezIVGy/nN9FJkTGH8jnjatgemVLI7PkwEZPZLjcqLfFcrw=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1580;6:Dl4LZ3+4OBAg/p5yuf1cS+giLHcqYIIVGLS94aXAYen2Ud2RwkqfB7K5ArpxdwbO+QUK9J3eN/JcBrWs/+H2g5Q/GRUcJe/k4WJUvHAjJkXJznasvVfUGv4Upsq3j97gBeLdntpzXXR17hrIoIlDkTFUvrWWm51bDGZlmV/Jw2dhfHbIPMUhr1p3uUZoSPefnpju6Wx5/wPm5wyYw6F29MWypLsXscMgqgb3Xfa8HG6Pjf3uqr6nHv14Ti4LQceb44jv456eBgCIUasTzXZwkkkKzOFd804DKKOCYI6MSgluRk/oklCo9c+JfkpRQH9SYtM0CXTVXAtKofgKNRtmGIyMht4UZ45lDmgAcDRcXu1gvvhjRO0THBZfRvLLcxUyaDVljRZcInJo7D5vFPWvNghWqH1DCAe8PcLlkNeGDojhJvyP91+fw/WX41kDqW3v8+0WEYPe5P9hd9t0E8xfzA==;5:msE5H4v5KgdRXUibziqXILko4BkbQLGmLTf7ned4PIF7R1YrpTpapkwUh++n481u70AM10qG0MiDpVt7iI/1r9RJJuVIpVZVnYwt0IsPAJE9jieKZtX/0yD+tgrVw9tFJ4wG5FZV33OLsudDvLK0EJniYmiVpGZAnQpO8kKcNHc=;7:f2Pz60OjIThiHVGgO6BtP1gFhTHJH076M5rQHSw+3e6+p8iUYlcbNKjsmpFFiqpFktWZH/PTabqRXfw8uCybHkPHndK2uvl/b0DGTv7r47NwA+foLBHuBVs9isdwYzYhTSEo1tQdy/DxHFJZKb/lIeLjGzVw5hblhxAcopTagz7NYCuWeqgjkYcGivq/0AVErwxZJGmCe8fqxcP32HbUsYEIl/kHGDhLrMXE3zuvTc1mxx7JjwVE4TALYev0+vla
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 05:42:18.6440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce70cbce-fe44-48c7-96e9-08d5f128392c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB1580
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob

On Fri, 20 Jul 2018 09:15:29 -0600 Rob Herring wrote:

> On Fri, Jul 13, 2018 at 05:24:57PM +0800, Jisheng Zhang wrote:
> > The AS370 SoC is a new derivative of the berlin family. The only
> > difference is the SoC isn't named as berlin*.  
> 
> So is it a derivative or just rebranded?

A derivative new generation SoC.

> 
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  Documentation/devicetree/bindings/arm/syna.txt | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/syna.txt b/Documentation/devicetree/bindings/arm/syna.txt
> > index 3bab18409b7a..3ba1d7b5ee74 100644
> > --- a/Documentation/devicetree/bindings/arm/syna.txt
> > +++ b/Documentation/devicetree/bindings/arm/syna.txt
> > @@ -1,4 +1,4 @@
> > -Marvell Berlin SoC Family Device Tree Bindings
> > +Synaptics SoC Device Tree Bindings  
> 
> Perhaps some note about what has happened here. Otherwise it looks 
> strange having "Marvell Berlin" in the document when the title says 
> Synaptics SoC.

Good idea. will do in v2

> 
> >  ---------------------------------------------------------------
> >  
> >  Work in progress statement:
> > @@ -13,6 +13,10 @@ stable binding/ABI.
> >  
> >  ---------------------------------------------------------------
> >  
> > +Boards with the Synaptics AS370 SoC shall have the following properties:
> > +  Required root node property:
> > +    compatible: "syna,as370"
> > +
> >  Boards with a SoC of the Marvell Berlin family, e.g. Armada 1500
> >  shall have the following properties:
> >  
> > -- 
> > 2.18.0
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html  

