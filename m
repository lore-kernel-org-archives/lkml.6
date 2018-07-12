Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44FEC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6A82146F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="VZWHiQ0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6A82146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403849AbeGLCP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:15:29 -0400
Received: from mail-dm3nam03on0073.outbound.protection.outlook.com ([104.47.41.73]:22400
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732852AbeGLCP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGHRB2lvNtx09tsdN/MAAWYLbaGdTXzibvoC4Y9Bln4=;
 b=VZWHiQ0ahoIA6JXwnxpvD7MhhATiDIE0iQFEwPYOeEhedYZI0V97Pdj13FCaTEbb1MdU5wfaa2/T3FNTwdW/ULccyTw4pr/o4nsUGB5xzkQ4jNvEjoD6TYTFlNSx49MxBKzQnyY/aHBO+a61v7Rlsre70GA9HNLOQ650b0bOlfA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 BN6PR03MB2625.namprd03.prod.outlook.com (2603:10b6:404:59::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Thu, 12 Jul 2018 02:08:09 +0000
Date:   Thu, 12 Jul 2018 10:06:11 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Manjunath M B <Manjunath.MB@synopsys.com>,
        Prabu Thangamuthu <Prabu.T@synopsys.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] dt: bindings: Add bindings for SDHCI Synopsys
 DWC MSHC
Message-ID: <20180712100611.5887a195@xhacker.debian>
In-Reply-To: <20180711161206.GA1558@rob-hp-laptop>
References: <20180706151930.78b3024b@xhacker.debian>
        <20180706152047.0b0a4944@xhacker.debian>
        <20180711161206.GA1558@rob-hp-laptop>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: PR0P264CA0013.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::25)
 To BN6PR03MB2625.namprd03.prod.outlook.com (2603:10b6:404:59::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c57740c-d47c-470a-9fc8-08d5e79c52e9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB2625;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;3:ivcgM3LmzbKPz84TzpTEMnQASujaftCsOK4rSRH0n1Zsr8J2bSlGEYxgdSyQhh1nsVy9FsT/r6n+ikvnS9XNaP2+GhvQ6PKTv1iEvsr0mTGTcrDYPZmtHu5xHONfU2umnME5ScGxGP30qmtBJZVAuJAE4lVUITJCyOcudoZBBCmLj97ZFkwxqSBpM8FAPMh885+Nkq1wDLh0wY5Ku/96YJniV7HQq3wOh0kYWCH3GurmbjHPHx0qbCOcf6Kihtaq;25:6jchbIoibqPdducbujsvNmn/u/IYdm7xrmYWfz+MS1g7NuFdjjlt7FnQwL2t9OaUP+5OVV6tSeuUEMr69jPF9tIFgVt+bVzo8CL8KoTUyXtb3ApglAx7S1XWEsAF7PLABsqKmfd+0xIkOiRQ0nSQ/tCF2zY5E3V67NGTRLsvMMI+drUCKiwTQlUJxncI3MpjXow/UdLc1XWZmJtMSFSR1dLbousu50M735OAPkLfDJLg1cDMEcQbmMaK0tluepmkyYQGVsgvM3IbHz2G32GKzmNiaBdjcJknrPqUuyusWkgbvMXFJv69erzqsGHDwGUm2CnIe6DJlCo7uX/WRV7sfw==;31:+T1d3Bz1Z62coK+fK0H8zGOV7ki0QEu9x235nysslSSoPPgBlthT8/mtkSlJOvtblTUZwJFb5KI1BTrYB1yHmWlUsSf7jyBYq8M6B+ZMhnAWWK4qXswI3rjcdnZSxKCX96k6RXJaKLRJ68yHTneJ7HhpQ15Z/1bwZIzwEn97rdpIQf4XFEERXWe3kP3VXz7s32HxlhK7i/Y1d74fRvrgUh0kCu/VHzPDJaA1iBOCJkM=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2625:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;20:PVCtgV5PFXX6qYt32fpWNZKPwW+QKjEeyJ+fa+/gJbZVDqqiVhZoNi2JMXbsJbZ2tzeqidcXc1+PeaXM+nUI2abcabArKsuVXWwRNZqtisB6//2URwWovoL/hUU+R6b9QjOankDA+U2W5W4+xgjRc68ziWW39wJbUeHFsOmPqvoHI5yGNGJfS5BEFMfWISop1vdapIZuvZJvrqagtyvnXM+//7ajonHnKiqMIEhKGLXpvOLXVXH9hEZ+CltRBiZscfuU515f+Z+aXn/2uHs702bvIXPNaHaiHjvVx4KyGhw38peOyPjKXBgWXhTyanwIBOuB9iT/SGPpCU+td1zmyyeTjSn20ag5+C8rJmOPEBC/H3z6nui+jabV8zoURTtiSxq5m7QEl7qyo+PdHMU52zLxzJg3TK32MQT6Cp1Qx4IdE6y17rqOdyko7vuoanyQGUhDr+FNRDA9d4djPFrxYC0HwXV8XQ/CrSjEru6ZWG1Tfg5ZOiyyp2F1uCTb8fgF;4:U6vkbwVoWEQMZW0sJEqN3fmmf/Ttl6qfp9Db8GOjgCyeJW7Y8uObnKT22+ssf3iqmOkvhaVaD72TKVgYyCfwaOgSU6lLzd6h88KoeQoH5G8NCmxsVLKnONFykmiclsr7Vj/dAdruRbnyzGN+zEr2qdKLrfnrt6nDLx078/1mK6/b01BeZVD8rXusboRUoEczABQeEGrLxPLXjZQNJc/cNXjgIDnLhWcL6fQj45STBzSKsOrYZPmApUq8kj4pLMNPxtw73JJ9kWuUKoiDQDcYPg==
X-Microsoft-Antispam-PRVS: <BN6PR03MB26258FB54AEBEE90E119BF47ED590@BN6PR03MB2625.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN6PR03MB2625;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2625;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(376002)(396003)(366004)(199004)(189003)(486006)(68736007)(47776003)(1076002)(6116002)(66066001)(16526019)(25786009)(4326008)(23726003)(3846002)(186003)(72206003)(316002)(52116002)(7696005)(76176011)(54906003)(478600001)(26005)(230700001)(105586002)(106356001)(2906002)(50226002)(33896004)(97736004)(11346002)(476003)(6506007)(956004)(50466002)(386003)(55016002)(5660300001)(86362001)(6916009)(6666003)(81156014)(8936002)(6246003)(7416002)(305945005)(229853002)(8676002)(446003)(81166006)(7736002)(53936002)(14444005)(9686003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2625;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2625;23:5tKjauBbEqUURiE4yysxDFtvkobC2sJS0qiHwBVrE?=
 =?us-ascii?Q?RjK9CTipmYISx4m1X9j5s74XpiJ+O2icbbwZb9N1E8EqGFApIMrYjX9/wQyA?=
 =?us-ascii?Q?36FVDU7hvWFdX1bY4T1F1dhENO6gzwh4hcBvnfn8p/YujfFGpMJncQFAOqL1?=
 =?us-ascii?Q?aJrvMiXMu06s3C0Z2l85DDfN9wkRv7Gey1YMSOMfPjRObpBwORHxyoF1FFWe?=
 =?us-ascii?Q?I4PT4pscZtFqiwLLCUgMeAlgLNTr5HurLbACzsa+Ia7wTxbRz3fmiLIEpVcZ?=
 =?us-ascii?Q?e7eIlfRwCsG7ASSVzDch9mOAGQ1OFemkgRrl8/08KbLZ+o7se4vldvGbcBvO?=
 =?us-ascii?Q?5/KazfWy/GMZay1idsNLr18AtUW7FSxImz8he+DEs3scT/eiuS1eTQAkcuPX?=
 =?us-ascii?Q?dmprtA8xvePwp6mBSxHcbOmU5PeI8CkQXGN9iPaBhMAJalXq2S6MAPF8IHjZ?=
 =?us-ascii?Q?oLKHksXB1S/9hUddpCstRqktwA28oO9jhvagibcVUotxNDgllrWOqlh9xyfo?=
 =?us-ascii?Q?Hd7UB7yh8Vb/L2GB/u3vkPFu3VmPsA7pXvy/Pr82ncEMNWzS5jYMMEiVlj1R?=
 =?us-ascii?Q?JTKfIbnAokhbCsfi3R3snToq2eSiz9TQYNGcLvzMeDuF21kXieAeVV7snjwP?=
 =?us-ascii?Q?xrsRTELZBJH0mikRnTkXUHdzyvZurAWz54SJwuvdSg7Qjk3LJVp3SOJ0WSQ/?=
 =?us-ascii?Q?7znQbyGu2YAEsTlmZyDO1PvlB/+f2HKaqVaQZk8xvSVLqoFGDdhRm8/yJM6T?=
 =?us-ascii?Q?hneuVzfGU2ekorX/+aCU2dZBME8xjQ3edfaG6OqHeAA7X8m68RmjrFH0mEh8?=
 =?us-ascii?Q?WosOCjzL0xSREnZZYsrBgFGnsdVqAIRBI17Oyv0cyYHLTM4LVRV9vV/h4hiT?=
 =?us-ascii?Q?4YfN06lbYInLUpThf2DIclVLEYHvW40xC3678bYmvD4sovBvIJ6/Uv1OLaAk?=
 =?us-ascii?Q?RmVmSMCey8AXdEl4K6UkXY7GMrXw70UXCnC9yHly+G0DG6AbKhaB63OkUcAC?=
 =?us-ascii?Q?n6XQ02uAv7qML4dq/I+FQgSIHospkHsOwxORTFrNQRqhzCHLbG41Fuftn30P?=
 =?us-ascii?Q?pmfDVGW0wK90PrZIBdu6sMHTTDXFmC19TdNpE2GDqtpLb6Z9dfw+crCMIBrT?=
 =?us-ascii?Q?rps99nH+MucNIbCZxeKGGKMB4iilRXwMKznyvUS8JU0dH8K99gxHVo+NbKsG?=
 =?us-ascii?Q?uGFPiX1FfRM2P/v6yyoZSqphaO0c/EQ9kmRk6FloJxhu7gUpWRjSBD1PN3cz?=
 =?us-ascii?Q?xKh5BRi6EijSLaDDSwwL5maHn+cRARc9SM1MlIw8t8UnoqHeSmQWL8WC/VN/?=
 =?us-ascii?Q?7IDXAGJvUI6tNctNWwQ0FY=3D?=
X-Microsoft-Antispam-Message-Info: 3JSrUvAV3cbdYpbUb0L06Avmf9C2hs6OumQ+TwSk1/g/jwS8cPgO1dF7lxSKG6xc0HMsDiS4UY+4P0WwKnJVYjG+f9hl6KJ3vlYGXNam8+6xWH1uJ3mKIWL5u7knA25pu5/RoXgOzCrZEg3Qc9uil+Cw2HSRNZoDTgRTjuSpVF9p862I8GpYU+xVaYcugSIpruXyCchB3hvioH3pMQ3DAhuaKZ/KOiyOcz1xjGk+feoUmYKvM7ITwh0MJu1DyGR+zvFt2MKIx2iiQZy/IcO5WDCdvpjUI2yGVdlDTZqdIYX+7NIBGDlDDmvFcz+RVb0TtxOQsx1d1UXJSCqxjSFdf8jSIhXLnyCSJQAcgSg1390=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;6:bIJsx+NjS4qQFSOr/b9LjMFNoKrVdPldhypsgJQ5LuEjAHgxsrftSdJbOH4mJkPpp/XETWTp6e69vKjvQxkiR97viRBSLvbpGEL4lN1feOUo+MzO+SKsvMQbIX67IlJdbW/XMS9FbbwVnn9IjiiUghKkHpGlHYMPPS8HEsSwFStunCxhhx2o0NRdrvaDoc5iJLBlwB9SG1bbBkc4V6OeT/kLKiqiw/T+wAKY2RC04tXDXmlme9/TGgeHHct4c7YC/2qVF7OG4Nq8mWSiT/ztsAu7o5yb2DyNAn8SkFZ5J96rYkViEOtjc38bsQIQISNnUkHbFQHpq4m2r9B1t5hG8G+nzMTemlRR5ID/8cepFFxTtE3HziFiDHgYdVHmTNuSuJzqTCAhzFDk+9TQur8W012YoG2dkaFnNsKUxK3FJ0trMOaiabh/sTP9hP+JWRJXLDDbJOw+oLO/mfB9Z/WeXA==;5:Eu4E0cBi4ihpflIfHoTZLNkJK31C/7B+UxZHx+GINYAhXS6nP8mxkE8N2PXFKFo/cg9pWX5aa1lS37MDe/A4dwYglJLkWxZykNgGKeQSw7j7rhEHFGrV+qh/nk1uxDiVM5ipyZREDfLNQJG8Hk+nJf0I3h8qni5B3PrzH0plUqk=;24:bU/1A+LvML2xLp7xhgu1sYjuhdKlmJWf/dumP9kltZ+WPFKxE6iQcoVx6/5kB8QQ7OlklSO0AJtTOKTULwoWOY2DdKXJnvAVaEnpHqIuiUc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;7:8lp1IVLQKKv8ExkgJ4WVbsnqQP8QcLWy24pl7QVdUET1OXTtqgTEvc/3f6u8Hb7KryH+2bC5I2+Ff6nTlP6YS9QU0GiftIgkkDl3fY/TR177B008FfdcdMoTS7uDnaZiRU72AtLSP1OfNWZRPPcImsMXb8E5D4dMzwxlCzRO/eZtszyaT5khTlHWT92njS8II8tNwShWdy+jsWbziatfMQBqk+4p5uyne8KutGp/2Xl8Y3ufEGWO3Ho0XkFrplmh
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 02:08:09.7830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c57740c-d47c-470a-9fc8-08d5e79c52e9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2625
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, 11 Jul 2018 10:12:06 -0600 Rob Herring wrote:

> On Fri, Jul 06, 2018 at 03:20:47PM +0800, Jisheng Zhang wrote:
> > Synopsys SDHCI compatible DesignWare Cores Mobile Storage Host
> > Controller can support eMMC/SD/SDIO. Add the bindings.
> > 
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  .../bindings/mmc/sdhci-of-dwcmshc.txt         | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
> > new file mode 100644
> > index 000000000000..ee4253b33be2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
> > @@ -0,0 +1,20 @@
> > +* Synopsys DesignWare Cores Mobile Storage Host Controller
> > +
> > +Required properties:
> > +- compatible: should be one of the following:
> > +    "snps,dwcmshc-sdhci"  
> 
> Needs to note that there must also be an SoC specific compatible.

Currently, there's no SoC specific code in this driver, so the binding could
be extended to SoC compatible if necessary. What do you think?

Thanks,
Jisheng
