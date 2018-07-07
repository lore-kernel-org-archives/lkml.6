Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44D9C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 13:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565A6219E0
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 13:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="TvpytPen";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="XfPo06TI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565A6219E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754116AbeGGNcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 09:32:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54560 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753173AbeGGNb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 09:31:59 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w67DRnni010845;
        Sat, 7 Jul 2018 06:31:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=khC2OL6l4LnP978ImMq5T6KcN09cIPCBc7y4rSJRy/M=;
 b=TvpytPenQDY+UygpgoM6UTxD9LSiSKCNvG12lJ8na+THIyzB/h63ZTbMoIOSDYly+5Je
 //SgTi3EgAZqNmp+pdU6dgwD98iy4cCzkRK80BH/btPUqGofqKaUVFdTw/4FfC2I0han
 Ge6RT4sq4K71u5CO73pY1Sifr0aZHg7IzxI= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k2vts03tc-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Sat, 07 Jul 2018 06:31:38 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Sat, 7 Jul 2018 06:31:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=khC2OL6l4LnP978ImMq5T6KcN09cIPCBc7y4rSJRy/M=;
 b=XfPo06TI3rI9yNBMl05tyWd/FNdUx3H/it9VnfDNTWZZWpHT4jbPN5vYZuFeR5+0l0ySfEU3RFmLM5YRb4m0QySKrJ7No/laRNBCKsDXdBfVbGvfZEoZujNZFkNXhPCk9skMKp/JaSt9jkK0gB9dA+JnfF7CWYfCGQ5itz/JOdA=
Received: from w1t1fb (2620:10d:c090:180::1:72fc) by
 BN7PR15MB2498.namprd15.prod.outlook.com (2603:10b6:406:86::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Sat, 7 Jul 2018 13:31:13 +0000
Date:   Sat, 7 Jul 2018 14:30:58 +0100
From:   Okash Khawaja <osk@fb.com>
To:     Martin KaFai Lau <kafai@fb.com>
CC:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: btf: add btf print functionality
Message-ID: <20180707133057.GA1697@w1t1fb>
References: <20180702183913.669030439@fb.com>
 <20180702191324.570616684@fb.com>
 <20180702220659.6baa77ba@cakuba.netronome.com>
 <20180703214559.GA4448@w1t1fb>
 <20180703152331.151d1c4b@cakuba.netronome.com>
 <20180703153843.7a3425af@cakuba.netronome.com>
 <20180703233350.aa33jyzrc6hmaelq@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180703233350.aa33jyzrc6hmaelq@kafai-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [2620:10d:c090:180::1:72fc]
X-ClientProxiedBy: MWHPR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:300:16::15) To BN7PR15MB2498.namprd15.prod.outlook.com
 (2603:10b6:406:86::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f1c0ca9-e03f-474a-048a-08d5e40de9ab
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR15MB2498;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2498;3:siAgz2SuF8H9Sg8vmm1w0lGzzuScRiEUpD1rFlMhhjQNOYb1eFHOZDXpDCwY4T+diuNIX7F0yhgyDifDRg3RjM4fu4nok4njpmIKDX2lZPi29+3eeKboWb/GChV8lL6K+BMYKJor+EXk2ReyYxi09K9hlc2TxDhv/AVucdiAD54kXA2OW+RgZKKrFGHDJIwhXOiRjvESPO26Q8F5kELtCoHOUmCvTICm7IYGCfACSbVmoo8DuyssMxUbdwwk0Uax;25:2E3HzUOFPwnmyGDU1tpO07TrEuV9BbbZXMuSzscyjbLB8f1I7PzKZMI6dBSp1EqFlgwtmFGs03X8AmdCG9Fa/igIM/TPFN7Mmq3zkoZ9AUeAFRQDexUVcnBRLNg7UmKcuvhyPYoWi/61FM3DtdjS6VG9fBlAHjqF2HnyuaNwPMoM1uwGlc0oqnIj7eUbQGYSmx+ifJR7J0x3BFRJlI9CeTqtsU3ulia5Fx+C5CxXfMpXiAsbt259LT+fo5mhihQA+bzHO+QYGISL6IBn8hBLcvJC70CP254XSb7VIefJAmeziv/hamlCT46VuV/k0ui4A9qlKjvfNkOo9QGwFjKwPQ==;31:nz9wvEe71VRjhJM4UnQCJJFoEDWY49g1RhZqB4Wqbu7qJkGWWzTMeR1moy+ryCXpAJDakJ6Xe+FfG/oFqA8rmNJwpmvO0g+iwp1DmhOT4inNSBtoBfJDwjssSxZU6BB1LT4B2/uzfreK3jAqP+v6B4zjuwwtS1CBZLmRQUDEdbFC9/6rCaPZICNCeDu9cKBshvUpvD+sYQoWIOO0/RisUJNyZrUo4z5m5lPfuBLGTSU=
X-MS-TrafficTypeDiagnostic: BN7PR15MB2498:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2498;20:zC9koBTwYueRyBRHtQA3/MDjhJcRFFoQnGTKPcMk/i/sppgKzG2pcz96/YT27FboczSxIP4pYBRjLo7Djl7GRwAh8gpJM39YlI38Yx4t230VZVCakY6ygT/QOo2PCLm6optctbvmVB4o9gcAv8cI6f01fRuL1RAEEGJ0qUiSRSog5CUEZPtg7og1c+PFl1hEra7T4wMBJuak5T3JtMYJR1CgtG/JxwXUYFkHTojTkInOCC24ZlTLKgMQKeVhphv7ftcd6TXTIFBn974xAfs3VEhfcww6dwXb7tpO3xyU8X02l480ZZKedO5KpdYhv2qo8uBNElKqAjVWvVqGgTBNMobboY2qjyFZufztjxlm8xCeLxewcdKUE85qNENEYpTJGhCn9O+3Km22ScISt09QNIPcJ+o7LODD9nIEkssO3u6SKMqOGny3BKh71tU75J8PidAnujEHnLvPy1rnG3zsDq94oIfm+V895alG28waWVaegE0hn5Fz7Q3D040TPQfG;4:4X98dec4bJDiDNhJtl9mce+ZGl/DFffmkklq6XbqlzgYJlhUQX8DGXpJVN1g2RZU3wv34fAwEn+RDg/KfrvIHSqVu1CrIgPg2tMHYKlzn2YNfS6qU1R2gi2UH2fDMikSqO1h+HtmmAU6DLCb8NV9vWK+h4CTNSUwV6dWTu/htcbhdP6vEPSOUBqwoKIt99ZXGGay0Wp9geKdeoUV+I/K1UXEpqMNwPQIKYZSyJWhVFOm0PO4mNrUlhOy8rkCJHIPZZmVM0TttWH4Mqd2TMD36g==
X-Microsoft-Antispam-PRVS: <BN7PR15MB249840F8F0743F0D15EEE050C6460@BN7PR15MB2498.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN7PR15MB2498;BCL:0;PCL:0;RULEID:;SRVR:BN7PR15MB2498;
X-Forefront-PRVS: 0726B2D7A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(376002)(346002)(366004)(189003)(199004)(8936002)(6116002)(2906002)(386003)(5660300001)(9686003)(55016002)(23726003)(6496006)(52396003)(1076002)(106356001)(76176011)(52116002)(33896004)(105586002)(50466002)(81166006)(81156014)(8676002)(305945005)(7736002)(16586007)(6666003)(229853002)(25786009)(97736004)(4326008)(11346002)(446003)(68736007)(16526019)(86362001)(316002)(53936002)(6246003)(33716001)(39060400002)(93886005)(54906003)(46003)(478600001)(6862004)(476003)(58126008)(486006)(47776003)(33656002)(6636002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR15MB2498;H:w1t1fb;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR15MB2498;23:7Ay9wnunxk2XGk0h4ngWCW4TpYXhQE7HtI0Px2ReB?=
 =?us-ascii?Q?5g3wGI3avUfYGy3bIKGUapkXB0faByAVzrHQUmJr3Eu9K8BPoG6XFGbBn3rB?=
 =?us-ascii?Q?4DTo5eY9pxSZ93JunlHh6n8p+gb64IgHU4OgQOO7a9G1TyuMgTlaqJztExdt?=
 =?us-ascii?Q?T7iZyR/END0KBGlVXWrQXn0ekwGtcUSlF93qxHDKSG+C7X9+Gs+M7gitNxwH?=
 =?us-ascii?Q?JAZIsc5g8Igz8LaLjUV3yb1D0hcQorAxOBcHckFKBJ9D7X6V+V7g9/Si97C1?=
 =?us-ascii?Q?U+m0UyeTOvjwbRj9rJcv5u2WsaBnWT04jtMK1Z6DY7N4DI5i4izttfpq4DG1?=
 =?us-ascii?Q?+ItFkQAw9fU7Vk1/rXW9OXGXHUEBZo+b7mVcoBO27WRlNyJEAY1QqhbFBaLf?=
 =?us-ascii?Q?4EwpzCW9sCNYSvRGETjUAgJ44MTtuxL2sjRZFGJJUoX8LIiWcSh4NxUJezhd?=
 =?us-ascii?Q?Y+3Yc19/wQoB24e8uQ0G70XfzwY66f64EzAtdMvsjJQwQ00CF9NI0T+FH43h?=
 =?us-ascii?Q?4YHKxwjZJiIDL3iA4cIZAx+mQon5dUxiqVfctn6/RtBIu/NWU9BaGyArtu3N?=
 =?us-ascii?Q?V6Rbwgp/5bUxX/1gwKKvhH3yFTya5UYpdGkhyWutT/L7oYHMwiSbYyz//B7F?=
 =?us-ascii?Q?qDZ2E+8IS28LWGUEfJQvHCHPy34tOoTU1CNSn/L2A9ldy4IqljhD+YZ443en?=
 =?us-ascii?Q?/WEQ1/hM7S7M+O6x6kJ/ku3Ozfj4LFCKlQkUQ0Jh1o6/az1KBvNhVYBpPgFv?=
 =?us-ascii?Q?7A1grDM2WXbCnxz88KpA/SGNwL+sLuONW84LaiF2WdoTDjIWPoZ0j4f+tSUh?=
 =?us-ascii?Q?PeZWBxzwBpDgTpcqGrNilzCmZu/b57uassvfUdyG0mCRYHDOTRIZRrbtCxy5?=
 =?us-ascii?Q?5qGBZ6p79wkENEkioc+xmtTm4R3tFHRJ2ZSoL+FZWpSr7j4pOs8yql3mSd3D?=
 =?us-ascii?Q?LFVx9APuFlfDhRDXVf9wTEEmXGwHcjzeOOvAex4WqpPthIxK57Lb8dc9BG9g?=
 =?us-ascii?Q?0xSoLxMGsQ8EtX9wZOVzyLXo4xfOoxSeYFguQKlWf0r32tLrYcXblLcQqVwa?=
 =?us-ascii?Q?3bORcBXxyRpIheknDvgC/PDhvnFGbuTFSBH4KGXPeFzJsE1qmjzuKKQT82EI?=
 =?us-ascii?Q?WDFBVsOcpjtDVgrLj5OqXgsOiUL8IVG6fqWRYFMe1JROEksxAgIhRP/0jUyy?=
 =?us-ascii?Q?5JthR5DaCOT2mB8ORN22ndJDZ/TrqWYeauIsT7Pu1igG/WrGU+jjAbS9LvL6?=
 =?us-ascii?Q?z+JiNzI/zA8u88sC+eOOvS50XXphOxuUCWbHMyg20XQh9wC6cVRn5ihj0vEJ?=
 =?us-ascii?Q?c+XEoCpho1/17Cb5Kl0FIo=3D?=
X-Microsoft-Antispam-Message-Info: XGEkNJWG/UfGxMbZhz9oMp9UR83V0l4ahhqJUikrMR3pUh9jgZBYhiHcdMppnZYc2qpk0K8fmWR/Lh4QTtn0lJf1oLOhwUXJE4KTIZP+CjIHjQhUOyLWydBOwqc86gK4cmyTj8gwz12HjIWRKqOjRUb51tvqs/y/UtQQklymhY3y1s8c6XjceL6noPrkhP7p7RMZCHjRXUUnL3KWTpmb+GMqAy/P5qlmtociqOlXECMqEme1epie7NNEdYWk2M+DJf1oUorJegaQVdZ3U6/uDYCQY6owSbSthlaru2jL2jfKpd9CUlVwKz08z3DxOgRmdNNZPa2wIogGNky+m70qnybgonI1vVfiraSUFiU31Mc=
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2498;6:ybh5oJzdeWSOY0rMXv+PoKQp7YCVgRFdh430Wzop6fXWWT6y9ADv2u95rJmINzL89AemNiDYVP1N4Lre1Q19BTU74eDdjTsNHS52v6si4kZRRu7B5lIx2m5oOFhnmS5Y7LhXDvmasSVL7A1QikVvHImJ8li3aFZzvutp9KgPcHLS67pw5dsVXMaHILzCqkD/vOA+hPMcNwevhLxX3g7rf5fbnV3ewmwr+/bQb40bwFX+YB0/CcN5JB4PZx2A95TMTqNoKrjboeLpyNEwypZncufSrMDa5wFrV3LvKjs3iDqm48JQYw9cUptZw0DbM4RFeMjx03V6HWKbU/PNGLmvsv7ElRIXx18VqcPiMLPx2JSyQok78LGmdPBBYh+hCFfEyoxSGltvjivvcpFzTN4XkkpOn4If5do1/yiyKYYRVm3jVPXNaHHxJ/OKCoPEMTJVNmu8z3F9qOi0AHMYZpUV/Q==;5:jY3+i70/7TcFHKOejZFipYNIwRm9EFad70Jm0S+LtN1n4ULKF/xkn0+KWEekTDF3ASJjeUkFjGsduQkDzb0a2K37hWlE1z0t5ei2VVtNRtzl+E5HkZjX9YTeUgDUrBNJVvPGX8iCc2UBgMKhcy7SdKaHaCZwnQNgvjHrAPTtkB0=;24:kEvtp6+W9PUHekl0Q9BJNW+bUT9V8xVuCHzWQI3VEyTsKWjcOSRGCep1uAhrVMLOnQK46PIDsw9ebRBbEWhTjsjcWhIc3NUcS5hFgznwuLc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2498;7:ZsNfhfpepg3PIE2zyAlI2rwPV1xm0mhO5ggXVdq2pkYJqdfLBot+vOn1TkD/hdlOK2yRF5skO4ke8BBTYDJ32b0gZ7PYO3cYL1KbWpD4GhRmgLKp2lBxxwpnsi/d71femj7cIaoj1kFnDPnYP+lFtxs1JBP3YHksRrEpD/rl/QpJJWAtk3JlapXMvaAYVmkxXCIxTFGo7vM1Td45DaFaEfHG3a64/SUoTPUNWFa9oU/hU0Foinqrh9h7PFR+B2eP;20:DaUdH4v0bMTXBT9vwtR+D5vI1pZf1VgxbuYdKmPVtgONgOxd6Hb4RHE4aBJWqjj3aJT1OvZ2MPag8Hnt4zjFVJFf2CFz2HsH1ncSuoQx5yV5Lyse4OW//Xv/JPpRzx1pLIiQm65N8DnLp0uDl0RvTLXeRuoM60BoJL8RX3+DllE=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2018 13:31:13.1587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1c0ca9-e03f-474a-048a-08d5e40de9ab
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2498
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-07_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 04:33:50PM -0700, Martin KaFai Lau wrote:
> On Tue, Jul 03, 2018 at 03:38:43PM -0700, Jakub Kicinski wrote:
> > On Tue, 3 Jul 2018 15:23:31 -0700, Jakub Kicinski wrote:
> > > > > > +			else
> > > > > > +				jsonw_printf(jw, "%hhd", *((char *)data));    
> > > > > 
> > > > > ... I think you need to always print a string, and express it as
> > > > > \u00%02hhx for non-printable.    
> > > > Okay that makes sense  
> > > 
> > > Yeah, IDK, char can be used as a byte as well as a string.  In eBPF
> > > it may actually be more likely to just be used as a raw byte buffer...
> > 
> > Actually, what is the definition/purpose of BTF_INT_CHAR?  There seems
> > to be no BTF_INT_SHORT and BTF_INT_SIGNED can simply be of size 8...
> > Is normal int only used for bitfields of size 8 and BTF_INT_CHAR for
> > char variables?
> > 
> > The kernel seems to be rejecting combinations of those flags, is
> > unsigned char going to not be marked as char then?
> BTF_INT_ENOCODING (CHAR/SIGNED/BOOL) is for formatting (e.g. pretty
> print).  It is mainly how CTF is using it also.  Hence, BTF_INT_ENCODINGs
> is not a 1:1 mapping to C integer types.
> The size of an interger is described by BTF_INT_BITS instead.  
> 
> > 
> > > Either way I think it may be nice to keep it consistent, at least for
> > > the JSON output could we do either always ints or always characters?
> >

for !isprint() case, will "\x%02hhx" make more sense?
