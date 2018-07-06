Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6A2C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2F622B59
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Q7VTOLrG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Vjzqd4V/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2F622B59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933234AbeGFVaV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:30:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43876 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932713AbeGFVaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:30:17 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w66LSBhG011219;
        Fri, 6 Jul 2018 14:29:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=Ai7P05Fr6W4ih9LD+8YjoyF0F9Cdt8zb1ruX/MqXMoU=;
 b=Q7VTOLrGd/Dan+coRgMTyE4cP6EaYhnocV782RzDNUa1fIFd0F8ht+hti7QVy1fy7X4u
 U0RIbZt2rnKI51raLCrf3jKLEgburbUxyh4ZQIXMMI85s1OZavpnCxGDy9hIvxF3KkJk
 KMMt+H/bU2As80tEZj8qlY5oxuytKJji1B0= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k2fr1032f-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 06 Jul 2018 14:29:54 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.25) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 6 Jul 2018 17:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ai7P05Fr6W4ih9LD+8YjoyF0F9Cdt8zb1ruX/MqXMoU=;
 b=Vjzqd4V/slyd5P9vwEexb3kWzwTT/oAFuaaDtY1qeJu9N9ZlZHnbIlvzmotpE/TLYuePsskL47fduj3+wybWgOa19lZqmNynvRa5fuycfqItBg3nf7mvSuaacFQSZXPXUDPtjIarkVsVm/E8z2wXJ3wM4KLpznFK4JYYlZb5UdU=
Received: from castle.DHCP.thefacebook.com (2620:10d:c090:200::4:3096) by
 CY1PR15MB0172.namprd15.prod.outlook.com (2a01:111:e400:58bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.19; Fri, 6 Jul
 2018 21:29:47 +0000
Date:   Fri, 6 Jul 2018 14:29:42 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v2 bpf-next 3/3] bpftool: add bash completion for cgroup
 tree command
Message-ID: <20180706212939.GA3582@castle.DHCP.thefacebook.com>
References: <20180706183012.6475-1-guro@fb.com>
 <20180706183012.6475-3-guro@fb.com>
 <20180706135805.1d90ff33@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180706135805.1d90ff33@cakuba.netronome.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c090:200::4:3096]
X-ClientProxiedBy: MWHPR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:300:ee::15) To CY1PR15MB0172.namprd15.prod.outlook.com
 (2a01:111:e400:58bb::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab990047-e4b6-4f04-a723-08d5e38799e4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0172;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0172;3:xPro9bNqsFG/eUQ1xy1By5pJ7BYiT2FyuULRuXs53lt2JdPTKLKaOYI8ZfvtfyuCi/HPcOvsy9gr/9QRrAC3WddskpgNovY8t7ucEJk4UwbL6PeGcVZY0gJmERT8Uve4QHXIp/0ufujizadRqKDd4FeMViFL9zlUqBker48BY6DXTmOn3ianG85+dCCDKDeHO1ucsO010n0pPMFKPz9EYSVwjblgOY0n9VosLzicsIuWF+FnmT+tT7xrbboRjo+k;25:LvRcKrijDUZXWq7PRYA1UvSiBKreoi/FouoF12++we5aFNUhp8eJc0sfYJHxqEie16wPsMlK6bOya5SWSOIyDUqlBtZ0xxqU2xKxwlfbHRn5+EEvU4Euve81vcSUr80s90BBuHJHVD19szwbkNGiehoeLFRYP37ggA1eDFfgDjSXBf4jDHzvBMCLdIoVe5zAtzWYuNVZQLtCwt3aMOS7E+gHyhgWp4nGWNGC5wUqwoq0Tk16XjBxUU20raKplCrhI718T69cR8YOvrtRX1Nrso5gHDtYE3tJfFCU122Q+nkXIuCjNRk6hvy+uhHIvdRomKRKliV4BePqyyfm/bwsNQ==;31:1jRI09sihmX6BGm6Xa+8yBo848Piq9m8pI18P9JwhZtJ8ogCrYIlDNNL5bdHKmUb3o8AAK4BcvQr8DfphTtng7DUoqDMAJeTF0LdDil8LIuA8x2IbPMfSwx9+Jp+V/+x2xmcHDnSEAyknNHipncxogN3lkfW659txHctNYdUGf0v9kR9b/PnDTlpzN3GQUfzNjWbhDtnibSi8/69vW18meu2gMljfpluBQ1zU55cTTg=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0172:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0172;20:AgEznj05zfCmXd9B1A1GQ3FkbHnbfFdukTFGTMsnSCLI3Xs40ZgKc4PQkyaMIoF6T47Mcpg7BzU+OKEHEbBlwhUErXGUvgS5J+DXwWhIiICWEjJ0ORpIFuwVkFzFBKlZJGLZwULUdeQFM4PWGXui17V5BiZYAosydTDGzSEv0QLbHv3Iza3xxzfpsqEsuMdpqcMALnkNZFKzdXW8gXzIhxvzzhwNy51lsQ0N17aSmeNfiiisqbx5rb6H4lZSDNeOKyfCTvRz7WHFfcqG0JAbn7t6jZn4gfV3idxPq9d/WoKS9v929oyDFvulHz25mg92FWPd8fP//VvsrDcs0PS434TcAT8xbhzYQxvB/xv6Lvs19t6jTcFg6z4So2iaev6vQW1qwknM+FAPKnrzRMBaYc1Ix6jxuXDL7N8B0i05eOz75nPeS0OnMz7iDF+rDVPCrvL+v1Zf8yUUBjM27E2sleiW7KTallHXFit5HFKIxR55kuVMr9nWm/ZEDB14uGaU;4:N9SesvHDHdha/qeUT3F9inp65p/lnazrUwaOaMRJSdzWYeXe2DdzN0tm72h7O1f1i3CIiMX0RawIEULv/lnGVdxXDR2NtBDwyiR3cO8Xg/EIK+fmV1D/Uyi+3JPbKiwzKTZgNoSzHiIHezw4qfgXo7C92zEA1L19kpg5j4TVoVr6ullIkIL3UISQp5bE7HBh+HWi4CKAgSYKGyAbL6wAYeiPC3zJeVBXKpGWa/dKLK9UnN7knSeb00w8saxFs0Z7TJBoFxQJP+8Haad3DBbo0fe7GHSpALhtlqNnZ+HrJHMyJ7Wdn19pRZyPnpN3d9Sg
X-Microsoft-Antispam-PRVS: <CY1PR15MB01727B7076D2593A0DB50D44BE470@CY1PR15MB0172.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY1PR15MB0172;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0172;
X-Forefront-PRVS: 0725D9E8D0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(136003)(39860400002)(189003)(199004)(105586002)(52116002)(186003)(16526019)(25786009)(86362001)(55016002)(76176011)(386003)(6506007)(52396003)(106356001)(7696005)(5660300001)(6666003)(39060400002)(4326008)(6246003)(6916009)(50466002)(68736007)(229853002)(97736004)(6116002)(476003)(8936002)(81166006)(81156014)(33656002)(486006)(23726003)(1076002)(446003)(47776003)(9686003)(478600001)(7736002)(8676002)(2906002)(53936002)(305945005)(316002)(54906003)(46003)(16586007)(58126008)(11346002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0172;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR15MB0172;23:RGS1Tb9mZY8vGqJvYA6Yt+VqPLAr2Vo366QCFCJRS?=
 =?us-ascii?Q?3Pgt0vGm+3YYgsCpwcP/NnbZUN2O9G4XOtMLxWLEeGog5mmByaSGybRPbhkG?=
 =?us-ascii?Q?YafCVXhF+lkcE4lWBeqnij9CPSPgfqQffe+L2AoEz/Pnk1t+st0nT1CJtp+y?=
 =?us-ascii?Q?wUq4WzoHbBPJAT2ofFzWd0SKQkDNQb0jl4FuPEgRT6L1hc2nt9C3DOoweunH?=
 =?us-ascii?Q?t+wUFtwinL3VWv7BHpzBCx5dsOiiuoh+rmjDZ+F6FGyFk+hpEsJ3hnroJKD9?=
 =?us-ascii?Q?m1a7yGeycMEFhlDsCbY4LKcG94bBK+b/NNh/u0LzdCc/TbGS0TMzPk33A1/a?=
 =?us-ascii?Q?0LBH5nQDzYQQnkvIkUZRXad0SJKBkjQJRYoz/uBOpTF03L4JT6xsrM56+1y+?=
 =?us-ascii?Q?ea0WDbqXGokCyc6l7X2QMoHRWTMCZtQTfPYk78wLHM1Ll3iRQkZbkmTxitAZ?=
 =?us-ascii?Q?rZbAZq5eWQsXP32iWpHWqoOkbwqOdktVka9ZJIL1iAIx7Amhqg6mC6srY4tI?=
 =?us-ascii?Q?eB1TSUf6VLgXNGgKtAofD9IR7h+PnzZH3dYt1sdS35eBXuk/9qFxERlX7f2G?=
 =?us-ascii?Q?Yc+fZQNsWEIUd/hKDkY/5Be1OcerGWVsQHPZB/cuBmTtP5g9ybeP/jJd4/ZS?=
 =?us-ascii?Q?ihfikA7BIs24W5GzBgRZYIhVuPuH5j73YDXXNNOyix+croVUGh5+f5XhRlAR?=
 =?us-ascii?Q?1XCHL4gaLtmwC9CU8ySiz7yiEZ/7HdNYlfROEVRt1+C1b7kqI5yA7ep34swJ?=
 =?us-ascii?Q?kVu1CJGeElxmVOTtMh/nxTYIABx6csOjbd84ao4TyzoiOgGl3sv3LgORDw99?=
 =?us-ascii?Q?i7grx65A41SGhWh2+eBJh4KhDY2I0bI3sn/D7KjhYOcmfsfrfawvUJ40c8MV?=
 =?us-ascii?Q?sn6I/x+HZSIrFp/1HirzX5Ku83wF9+o4FEJNGBwwQ5P3RWUWBOUvaksHdiaq?=
 =?us-ascii?Q?2DefxAR+PgbU1VIUBnWrX6q9RJZ20aXo3NLR9wdhbAvSraaYN3BgL1NxKF00?=
 =?us-ascii?Q?CFZhVq436oG6/FJH2IFVtPF3tiILVzFnaYTMuz5e01POvfR57fgFWTcWuazc?=
 =?us-ascii?Q?DsKCuZcmKnt/78+V/gEBtS5c+MQdZ8Qc1SGUAhQ+W4MW0zr85jUyEc/UKCOy?=
 =?us-ascii?Q?SqT1tuwsXwonLSLWUHTPXks9snOrlJ1nLduBCtqzBEheieSvP2TXsMiUI+9k?=
 =?us-ascii?Q?ldkk1X9Oim5E4Lkr/VDvMYxFELfYOozqcNJLhuGwalVvGot/cDUbtpyNMpgE?=
 =?us-ascii?Q?UE4D3KYz12RrrPZirOGujBCvpmnKFBoEKigefjN?=
X-Microsoft-Antispam-Message-Info: 5UREr2xZksDRsjB7qCRcKNLY2hGU8uZZXJ5WMd2kCscIujjliYA0Jaes1pIQoVAKw8Z7QczHrJSNPYGlS80m8cXsoGBMDYOmuSTxyFEae150eJQ7tTMVqYEhDleuZJxkw0R1CUAvaNYfsNEJJ/zPjHgDwDsV+HWWOzjqHCPZJQiqQoSx5pdOG48nsx/foYLE9ogLHgyPI/+mUYbjRQJafRm3vCZnZf+oHktwI1TXbzpZuh/Nh926DnT2srHPIVFAQzhvOpilwEPPOwjRXr49zIcVTzECBc782o5LiIEPT82C+M/YRwbxV0dlS9wO/pGlsXStx5slb48Ggk717mL54mypd6WiJyaVFgSjKxX5jug=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0172;6:wDNrTqV7OXgvnexzEhj3Rlw24tuYvyu0FFJgKDgZWzDMpeG3QlrN/PkygT6ZuleFhwHUjeeh6gOVpeu52EnAMG8vSTnOfZu2EFC5u9D/uWLcYmqB1LSYSLPQTtpu6ic5UR7kXDVvDCLPgk+4QbjHhjlCHYZ2mMI2N9FLCLNhVvj1580Z4GHjpsFlmPJ7efuzvEFp8baH9WbAtpRWd5IFXnRl8VSxLi31Hvxwo81XtXOAA+t96PhNE6OHm9RHb6UIpyWrvINB2loLBEr1aXxScwlsgSc4HCfeK7BHh+ku91HuUHghfggJSovTU3f1YEvk6HaXNUUQmK+Ie2IC355MB+5d+yLK4LjqocP1QstTYdCEBjzC/HDS3gb6cxPJ1cAb+zPx77bxMsQOeBaFXcPLWmWj7NyDgm87qFysyXZkdsPkfXjyzCHeeUDBZOIPeo32QmNKk/sxoXKw+e6XDFi8lw==;5:KcnppDXEkteqWYxo2z//HZrjRwW5lg/rBgoawY8WBOMBYmywrbE4JYOMZA5Ndik5VD0tNXn2/uetLUAaE9L464PzHgz5X6WnMlpHT2WCsDEQ/NYYLSDWQtKYH4l0IHP+y2DOyzT8Ag7QF1KEiGa0/OFNehTk9csazAh7BUvwypY=;24:G1lg/zO5OJKgdYrlIEF23QgvIN6AdMpIxE8s32yaNYQiLI2qXFOS8Zd9M6lot0wjpyB5duYldxJDISgsRfFNy24lwuugrKPjgajlN62CVI8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0172;7:OxjIZ/0B4WrX62IY4xvvmJxaJckBcLOd0+/NaEOHdgDLouIfg4Igz6da/+9N2j+d5yv4uDLQdo2e4vTxl1ydbVUDdg2fLkRW5WTpaysQeOpXUBBZbAyXlLKCmLVCEUL+Iu/6rIVgXUvungJ8KFOsspgqEzbokO3KAA6XoDJpRGnvAVliEPyLEw4rrSwAjyhLD5gErTDh0aQdKCj78hFEkEU+B0WQnOMs9McPyLHxduHQscvHb1zQgJjTy1J0X3qx;20:zADNVs8UoY7v2MJ0YhPL7QBZxlADhZouNFOfgpRKUtRKd+r2hCVrOfXrJfmpnFuQesENwIXQgH4ryMQ3Kr6z7WgmA3yyDpyV2gSVinRnU4TQXxhIbsesWQM81bgq+4EyyQRsKztiL7EjEqI0F9MsodG2nr3ibU3N25EpO7eR4gk=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2018 21:29:47.8527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab990047-e4b6-4f04-a723-08d5e38799e4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0172
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-06_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 01:58:05PM -0700, Jakub Kicinski wrote:
> On Fri, 6 Jul 2018 11:30:12 -0700, Roman Gushchin wrote:
> > This commit adds a bash completion to the bpftool cgroup tree
> > command.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> > Cc: Quentin Monnet <quentin.monnet@netronome.com>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  tools/bpf/bpftool/bash-completion/bpftool | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> > index fffd76f4998b..82681eb9c02a 100644
> > --- a/tools/bpf/bpftool/bash-completion/bpftool
> > +++ b/tools/bpf/bpftool/bash-completion/bpftool
> > @@ -414,6 +414,9 @@ _bpftool()
> >                      _filedir
> >                      return 0
> >                      ;;
> > +		tree)
> > +		    _filedir
> > +		    return 0
> 
> Oh you have not tested this at all, have you?
> 
> You're missing ;; at the end of the case, this is not correct bash
> syntax and completely breaks the script.
> 
> When you respin please use spaces instead of tabs (I know, *very*
> annoying but that's apparently how things should be for bash
> completions :/).
> 
> And please add "tree" to the *) case which completes the actions.

Sorry, thought it's simple enough for a copy-paste, but no :)
Fixed in v3.

Thanks!
