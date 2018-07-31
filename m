Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1708C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACDF20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="qJelN9gC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ACDF20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbeGaTTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:19:39 -0400
Received: from mail-by2nam01on0112.outbound.protection.outlook.com ([104.47.34.112]:45338
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729634AbeGaTTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2L4pteZeof2m6fnblZls1DAZA+JEvW/Bal+cWD28Y4=;
 b=qJelN9gCJ5wT97evXjnx0qtqmt5VrCXAHs3SiGNNhG97A3W9K3vMhMZwrDeHLzmVYVbYCuQYP9QRgVWWe1UPxA4Pog53vT2a+bvHzp/EOtZ/410cUtD2X+gKtSk917wwsMiJQyM7vI/Hzh9kWajmv1vsOpYS+RuDVvSc87k9ZRs=
Received: from localhost (4.16.204.77) by
 BYAPR08MB4933.namprd08.prod.outlook.com (2603:10b6:a03:6a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.19; Tue, 31 Jul 2018 17:38:13 +0000
Date:   Tue, 31 Jul 2018 10:38:09 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Subject: Re: [PATCH v4 0/3] Add support for MSCC Ocelot SPI
Message-ID: <20180731173809.eovsuiezlqzud7zi@pburton-laptop>
References: <20180731143855.7131-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731143855.7131-1-alexandre.belloni@bootlin.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: BN6PR1001CA0020.namprd10.prod.outlook.com
 (2603:10b6:405:28::33) To BYAPR08MB4933.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 599d058d-b4c6-4f24-72af-08d5f70c6495
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4933;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;3:Ni8QfAO7yivz+Wl7YKAytNTfwnuTnUqFAC7yykZ6th8ceSJT0G5e4gSA95OywtvUYlU3l6ExAB23L1zSIgpJSbNHlVxgbjr2R8k1ItdJQb8CqCrKwgbEBXxJszqgRDORh+tAgtFgsz8WNrhC14K60+yd4HVA92LG0g14IyPWAPfVX9fgn1E1wG6IkejkTcZPnzJlgVt6+28rIDUj5lmEsdnQv4STeeN9mSaB8PjMZ3mRU1g9ygj8N8zgEQfJqdZX;25:6WnAGwYrbd+//nwwmnNYU0PhqE0MTxC8/KBr0lBlf4WO/cH2T3CuPh0Qm2F5htC9eFQDuTKli8Uemo+sh77vlLYCglsRSS/COHjR6DTiNtPOuj6DklVZ+d8ZtcH6gGXvwP2+2knDIjdYXJBTsTceuEQXZqoS4CkZqImEAjtnqVvn742wsaqczj8Qp8R4efXJQN+H1aPcDls2c8Pwzu5KGu4NCAduGp4PPNyUpornfzjWuJx/IwNpo12Sm2pjeWFP690UH2ufy34dtm+6lsPfG2IXZb7ES/zkxk7oW6hFU4auMheL6b/FeL3dRiJLwd16ibjXOLnajHlVE3+XK8kzew==;31:IMpYkwS/wi/Mwl9YeML1Iy8KVon2yGrORIGFBzcEH5EECmsz0ZsqHBCJevEQsenI7uLoTWojO05k9i4I4ZnmnNw4n3qmtoxxifmVljfBXVpEYY4IkyfDLir97JC5dmoLQ3evw1eDHkYASGyOOJ5w11br39/z6b+SilvHw8m4bHCcRAMXq1xOrLl2v6E7sGLpKu/JQfsWnqTuhwd9k+QaAUCnZuxXHpBqTEXo7JnggVY=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4933:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;20:YDDzCSv6mEhRuyqjDxWsIbikA5R88zm5L5GEbuitQlfvyklIFCwZhHGAH308gCyXaw694M6/GPrJCTDw/3n881DSSFgY6mYO1kRhOLqZfnqx6CfPXONhCTLalAWXurXo8I+4rSE27U9ixr68IKYbCEdIY+h86w3wbcl+CejrIOA/DR4q7PkY1MavjBo0fjakMe4UQtqnfef60BAXKNebMzF75GgMG8cY3INOpkwOmqro+OLvz0Y6MlA61AVZv1rd;4:Jo7qdd3DTZr1ESA2HTMadtuQbV8R4+81JxeUeUpLGRgJ4XR6JZV8Pgl8EAI5JNu+DtB6tnEN4tbRZPwVx/s+KWgFK2uMpMggteEqNW5LrGHssaNq8eLoEJOogndCVAl7r5TXGAyP8XAN0Lusf9TYkRRppW1if/fByoaOtQgm94Ev/ZPj2UMFrvgbytFWiaGF+De/VmvtvhyK6Bbs/f8vFVeewv40LS273pzyNTbaR6ubg1PTQAkNK9eu4KmK20WI/jGDBH8tuoizUWA+JfeUGQ==
X-Microsoft-Antispam-PRVS: <BYAPR08MB4933BAE8A1E22C35FF95151FC12E0@BYAPR08MB4933.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB4933;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4933;
X-Forefront-PRVS: 0750463DC9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(136003)(346002)(366004)(39850400004)(376002)(396003)(189003)(199004)(6486002)(33716001)(9686003)(4326008)(66066001)(476003)(11346002)(486006)(42882007)(25786009)(478600001)(446003)(47776003)(76176011)(52116002)(956004)(6116002)(1076002)(7736002)(44832011)(53936002)(6496006)(33896004)(97736004)(316002)(16526019)(16586007)(26005)(386003)(186003)(50466002)(23726003)(58126008)(8936002)(6916009)(54906003)(8676002)(5660300001)(76506005)(81156014)(81166006)(106356001)(3846002)(6246003)(105586002)(305945005)(6666003)(2906002)(68736007)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4933;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR08MB4933;23:70h0z9Ou+Uj1QxZ2K+nqn+DBq8GaH5zFDznv2n9xO?=
 =?us-ascii?Q?Y9K4bQMWTEXTRqj7bJUchyb+iuccB4QInsCvXHX5OQEAXajoNSHK5oNKTJf/?=
 =?us-ascii?Q?4N5oWDL1E6heBbp0twcRjiHuYqoKjbtRegAv/PSMSgqag6RnikrDGGn8Sz7e?=
 =?us-ascii?Q?bMtqji/youhtBt4jcmGbc7p1Es11esnApX1tvLR/tKW1zptJBhNFywmC9t8Q?=
 =?us-ascii?Q?he1h2qmkwiL3vOhZrKrk4Tgh/RFGiUMxTb2CxiNUQiVPPN38nTd4nJ7ZmYEZ?=
 =?us-ascii?Q?ZWpzUY1Zx2pOlJhDMIr2jpmkw1V3DvcTL5PnzSj86YX6JTsZPaUJCYoULgY2?=
 =?us-ascii?Q?NFbIwziynucE6Aa+XpLhMWl5Kphr8Evfiuf7DnTATumtKwtxEYpjsOOSikEz?=
 =?us-ascii?Q?dLYH/HzS/+80alAz7WtPXrMy6htluQYgFn5GmoJqDb+3SCQV3w3eG6N78Awi?=
 =?us-ascii?Q?Dt+yNIDZsec0pDmX+ebLdfNHuKzY4+pr6N+6HPRdDaxggZOaj/josjpGxWJM?=
 =?us-ascii?Q?IOn8VgY/BEya01I5WDYxH/mbU0wtBAZOpXFZwn6//BspHybACUUf5wLcZQsG?=
 =?us-ascii?Q?qNX3V3W+YHCxgRKTT+x8MDu+4SJPGdmBgUSYv7tVBTTqiVZmQLR6Fo2ROfby?=
 =?us-ascii?Q?W84YynVGWW+kw7wWuJt0PJzW7lYIkSRsYZ4kwNaEpnCmhvekM5hD5etW4p/y?=
 =?us-ascii?Q?uESLeN2t95k8LePPPPG0RHQs/y4pKD70zns9kSfo8u3AcTGvuyPTENJWjNQR?=
 =?us-ascii?Q?3l154jaLjaQCNtT4efXt3CcmnFq+R/x2Obq2EOGAPUtRqBivFW8wFF8ehdGa?=
 =?us-ascii?Q?n5n3GKuHdbOwDkDQrkzORnBWrFXouEhcBwNTVDHLmy9WOVQfDrN0hAcc3RIm?=
 =?us-ascii?Q?a0XnYAOU/GFTzlEHFMGL0ddiNxhJEwwOwox/LMC7Pepw69HzugQePwTGtM+1?=
 =?us-ascii?Q?4cvZzfXINieFJo5h4BMlJnSjOScNvyTQVM0hN9piGRZJO6bLcdefCEq5wQpk?=
 =?us-ascii?Q?jADEBbVHQqAi60ia2au6PIBU8ZV6KHtp6yJa9EseCC9CtFXqHwSKGLmpwCrS?=
 =?us-ascii?Q?CjO9d1pUmKQV93kQnKsT/ZJwnqEcAjFmfaOFfZvC8Xa8jj+2Zd1QHy7jzoE0?=
 =?us-ascii?Q?u1xj5QtEhyju3jIoFPRClZGkXB/jDSI3D6eJUKA2ecPdGvN9xH/Nhb6R8v1D?=
 =?us-ascii?Q?o+IonZlQsF354Y3w6gsbivqifk4liUlOBBnZjbRkTouNcx7vRDJm40ca9yey?=
 =?us-ascii?Q?9m5Hcv5BQwJWoGvmfCtp8AHqVWFT0jhts5Iqg0l4yn7+DM/L2kzxVHNkCz/Y?=
 =?us-ascii?Q?T8+c7fOzXlLgwFkYeRNF6k=3D?=
X-Microsoft-Antispam-Message-Info: 692sdMOeor+xm9TeoJGlOawIRZYv3RdFHIbus1TB2AJ+rXzhgbQ+TUgc5g8pjNIPXFhSMud/UAoj6H1AN5bmuXOmKdEOFUIVnNZcPTrZq8IsXpFWp1U+D6FSc4rScOH9XCJQpGl9FPQv5iNq73IHop6ISrYEqTmE6koq8102Dfwy0914AJ0J5CjsV3wg1DzR/v+Qp3Qo3K8Hc8INSmTZQwLgaWh9tSMkl1oagq1avX01OqH3kzZ0G0yGP6NEg19DuH+Kf5AeBzq0nJOT3qpv6gxxFGcfzeQTF+Ej2yJnFX9wHuwui1JWJWEiS4t5jFxjJBvjeDfrGazz6wwAz/xH74Th7tIhhxF65AnVzosXOgc=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;6:irBcT6VoXPlVettVajDEppD2tUaNvuFuPkRRNslgu+dAIAqRa1T/xsFWtGS82dOMMJ4HfZ0tEFYL4FIHRPu/yNWREnFa/mYJE6zG8xooqWfoRVjsaAbsWh0XzK0aB1dfvueiP6nPcFm+djbHPc0/jioC2TtDRjkNgKYvXg9kMoNalQ912MzXVMqOZcrW4kkSdEoUpGn7Gdg6K3AEqpctjM7dkVurBPN6V56dlW0voXP5LTSVQ9BbBfJWz92Jg2ap8zaeSjJd0cTwsZ4gnlTodn19aA75JC887aBe6KQycyGHnbu7HjPuJN35t+YKnw5//N/14SVKhm3B77+WRlbumHDlFu3z7GObGeERQtYNYsEtxHhTRjGwVJ4V+7lGgOGCVF80/d1zQm8CuJ7aZylb2vPQ30Rndq7cIEolK87W4OIP9gJDQ9j2vV/QobPT1qXKGAm8JMijdNzCHl+vTkwqlA==;5:8IeowB6qxoTkC1pRrGXsrn6A8FOn1M79qAvRGiXdHk4wuf7Zti/InGtaQraMn2vzzSxYhlDWdAzr2+vKeX9es8IyM08XKcXCvsEQBQM8S2Kdi9jQGqBdXwGVug939ctB1WiFj/U7L3knWcE/WBpYGMnTr2Oi46k52Sw9L7e/ZBA=;7:vbTIZRGYMO0wS/QgBjus+aM0hOYqojEJB/Y8qwoks9fh0XIthzD7Hj7QalmT7Meaovk92HIJecYGkVijHZJfQwv8VJ7KOvjBXRpsbH9L+KZxyaQBU5uzTjQ0PwYwCrOOfvrQLDW7+2YvERovLHMmvm7wLOYFIHZkiFZTuKesMZGE7Ret0XbUM3zT89Bf9jKtbgVu+5Hyy/J8lsBmyOh7icI+6FCO5J4UlmHkgJdfVo+ji+5EFieE68LhcAoSPKnU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 17:38:13.8852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 599d058d-b4c6-4f24-72af-08d5f70c6495
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4933
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

On Tue, Jul 31, 2018 at 04:38:52PM +0200, Alexandre Belloni wrote:
> Hello,
> 
> This series only contains the DT documentation and the corresponding DT addition
> since it has been rebased on spi-next.
> 
> Alexandre Belloni (3):
>   spi: dw: document Microsemi integration
>   mips: dts: mscc: Add spi on Ocelot
>   mips: dts: mscc: enable spi and NOR flash support on ocelot PCB123
> 
>  .../devicetree/bindings/spi/snps,dw-apb-ssi.txt       |  6 ++++--
>  arch/mips/boot/dts/mscc/ocelot.dtsi                   | 11 +++++++++++
>  arch/mips/boot/dts/mscc/ocelot_pcb123.dts             | 10 ++++++++++
>  3 files changed, 25 insertions(+), 2 deletions(-)

Thanks - looks like the DT binding has been accepted, so I've applied
patches 2 & 3 to mips-next for 4.19.

Paul
