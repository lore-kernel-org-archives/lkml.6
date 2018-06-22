Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F7BC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21AE24995
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="F1CFofBC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="k4SDKpX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21AE24995
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754842AbeFVWtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:49:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53376 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754559AbeFVWs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:48:59 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5MMki42004761;
        Fri, 22 Jun 2018 15:48:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=facebook; bh=z6QM3WWQdKplHy9rJdf4XVvc/2uhaGk3koOp1kEFSuk=;
 b=F1CFofBC1Y3N+J2sBYHXNOQGG1cDGOsbavYGud3Nx4NtsZ41UhLEJGqkkC++1i6ZDv60
 a5Hen188Ht8Ba8ZPzEkdJc3xKSZwjAnlIuQAWc6R+oFJrD3rVlhwTKFuZ3UGR5r2BNQK
 HkPd3a9+e4wejkaCedkkFPeml2OcyBhRgwQ= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2js4nx8wpe-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 22 Jun 2018 15:48:31 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.25) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 22 Jun 2018 18:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6QM3WWQdKplHy9rJdf4XVvc/2uhaGk3koOp1kEFSuk=;
 b=k4SDKpX29uLdseH25p8PaE4XAnb/f+L6iOiEw1/1kQWmzZMF79/uw9NLvBewQlTuANSCFhmUVBSSdqNFS2uyCW3nYkesdz4pwitQsausdd8n7Cj2QqLTfuxijjJ4MN1q9eppP8wAddi6OKVK9nHrbGB9LshdESGFpETvDx7wSqA=
Received: from w1t1fb (2620:10d:c090:180::1:f383) by
 DM6PR15MB2508.namprd15.prod.outlook.com (2603:10b6:5:8f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Fri, 22 Jun 2018 22:48:24 +0000
Date:   Fri, 22 Jun 2018 23:48:12 +0100
From:   Okash Khawaja <osk@fb.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
Message-ID: <20180622224811.GA2566@w1t1fb>
References: <20180620203703.101156292@fb.com>
 <20180621145935.41ff8974@cakuba.netronome.com>
 <20180621225117.dhrkrtmkfbeihbe4@kafai-mbp.dhcp.thefacebook.com>
 <20180621160719.2cfb4b58@cakuba.netronome.com>
 <20180621235746.dfq6kdtkogftw3ws@kafai-mbp.dhcp.thefacebook.com>
 <20180621172523.6cd00ed1@cakuba.netronome.com>
 <20180622012052.htkvholi674x6i4f@kafai-mbp.dhcp.thefacebook.com>
 <20180622114032.162b2a76@cakuba.netronome.com>
 <20180622205535.c6vjhdwt5er4wc32@kafai-mbp.dhcp.thefacebook.com>
 <20180622142743.2b890d0f@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180622142743.2b890d0f@cakuba.netronome.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [2620:10d:c090:180::1:f383]
X-ClientProxiedBy: MWHPR19CA0023.namprd19.prod.outlook.com
 (2603:10b6:300:d4::33) To DM6PR15MB2508.namprd15.prod.outlook.com
 (2603:10b6:5:8f::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87e917f4-3e50-466e-db95-08d5d8924546
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR15MB2508;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2508;3:yFKQ0vQyb/yKSl6cJr3Pnm6kZhlc01ieQSLgHnaMEuyQ3V1TodPDOVFJbSIx1lf4m+Nq+kDAVuxsPByiC/Cso0/0/g1ZsNaTdt/74LrCR282KHqlqwduUtTJnmAHnkhkgdd3Oa97D70lVZeD3LBH8P6vdH2IBk08rZZX0XlWuztCj/k9f+If70XIwytNL6rWqupRsbuHAZUEShkjaGoZm47f1GqGQ4ybKPOhYxgPwFvE5enQG/mWKwWVl/nxMAb5;25:egtuI805It0rWBCHQfYymTy6sQ/YSeCMmQ0GCb21QI6EFuCe/DrJHneomq4bBxC+tdP1BgEUX0NECWnIQHTnDgQgoLGnGTGw+hf7Iac98Q4p97qLc2Dy+JuuVF3uEN4ABlKoGWWwvq4/udJYHE3CZBAJ9qEgQkPDhfAjFXiBUYY3tLi6WYNnnDjbENLgcaDbUyGBXCHcYZILQ6Ao7xalWYzlafhtAWMceV0K5zcnE2iCRlxSyYnRL01MBxt8G7RtxpPJoi+e/G3ieUDiQFrKS5nZuI63NhLWwXPgMT69plNOO8PtXK7HDgeyD52NVwrYk2/Na34V6xpC0EOQhwKwqQ==;31:8d3UyJM8PW8h1UnFk+fSU4H9Bcr09ZN1o/rjjldYCCWnbYs0uDchDo+E7JS2S91ClZs5zqzurt4kaooIlnTfItMgQ5Z5Gw5RRP4Pg4O+UWYJmnMU2u4TDxqDppir/q6vFY5gHS/qFmkpXHrbVtrZaqgtMqma0vtw3RzBSNmVgnneq0vH/a4iePvXErgGjc/glZxdAiHGozZlsztOJZUeq7KcwL10Gs4vgGUnduT+1UQ=
X-MS-TrafficTypeDiagnostic: DM6PR15MB2508:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2508;20:xVPbBF3MaAYnfp/pXiN5gG1NKpjXZg6SorahRdfnFyMSmgKY3mkTX8dENsy8H5GCm4R6q3qgjwtatd2MToSah1HCuVBy9x16wnnkx+I8HWkRpmNCm7iXp4wSrQlw2ZoLor/db1yY5nM1tbfxaUzXf9TqKTXBmMh4Hpo68yN2qF1H9QTfz5g2pznuYAc+jyidYUGT8ad+jpJuisnYaWxNarHc2xcoft5KAfgVzJYCr19tw5Z/ZaDcFZAHZ+mfKiZCf6OarakloGmjvzWCBBjyF25EFelnhcc6aQAUrhsH/hMaH/FNZ5MKstLiY8mGRJi5G3CB4ZzFlSdsgVh3DgZlfsttoRsqPj7iJZnde5KQaVXdc8ZWPfxuWdXnniMiCs1xdUNMgF6mk4z7s+w87pdSpyUk57R3Xup0NvSiOIHS+78U9sHHY0ro57bT5LKhr+pGGyGMNfhiTvsiszRktoCfbKXL3LbTXyBme2rKsCvCTipcYppSQE5YcC0XKwLz98DR;4:1UbA7xLkjKS4lT7PaGKQ0lreH1VQJWdc1p9dYhETvSYuwoM5F27tkuk2Iue9ulQTmIwbznSreMQCPRZTXh/i2DQ3+0G+gMm6Gy82gDvIVtE1JE06vKoVQs38oDixiX2TJdhTR33MVjUho6NBF7D22ILZdmfoTrPRKjjuBUg7AsdeTPFulGyakXtn4RhhaJ6lv+xD71yl3Lgwi3zjj3mysxQE3lCVM73ac6B+32AppwlR8AuVJ+uYIEsvQ8XGwc4gTUha0Et7HHJelKpq36JVXg==
X-Microsoft-Antispam-PRVS: <DM6PR15MB2508EB3A835DD74C1F92CD4CC6750@DM6PR15MB2508.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM6PR15MB2508;BCL:0;PCL:0;RULEID:;SRVR:DM6PR15MB2508;
X-Forefront-PRVS: 071156160B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(39380400002)(189003)(199004)(229853002)(478600001)(81166006)(81156014)(8676002)(97736004)(47776003)(54906003)(55016002)(7736002)(305945005)(33656002)(8936002)(6916009)(6666003)(46003)(5660300001)(6116002)(316002)(33716001)(1076002)(58126008)(16586007)(39060400002)(6496006)(33896004)(186003)(16526019)(59450400001)(52116002)(386003)(52396003)(25786009)(76176011)(93886005)(4326008)(6246003)(105586002)(68736007)(11346002)(9686003)(53936002)(86362001)(446003)(2906002)(106356001)(476003)(23726003)(486006)(50466002)(18370500001)(21314002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB2508;H:w1t1fb;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR15MB2508;23:6hw/OAiJsocizF8n+lwA+D4U1efGimIJ8/IWJrztm?=
 =?us-ascii?Q?ezX1eTZaYB1MAIK7E8mgtZ8UB2t+gsgDXzkRF60BsJIHtUY8l29Q71Rt1uSw?=
 =?us-ascii?Q?FWsMoHVsR+02v9aO+kio3u8ILxqtEavwTgpMISQXnlPT8ozsgREyEUxl/U9l?=
 =?us-ascii?Q?kMZM5wFED16Uc55H+gFg1eG/oCN8jTkeJb0aL9/2G3z0xGX9Y8mIfr22/XcD?=
 =?us-ascii?Q?PWXd57nvqhbpsCkKDfkFiVzKyZLakZ5oQx1PoKgdDuaKMuGkooruyi08loXH?=
 =?us-ascii?Q?ApF6au7OPSdQNEU5fPXrWesuebWHjzg0kh4SuWsDJSDY1EuzZ6euOlche7K1?=
 =?us-ascii?Q?yhHSn7whaBpSUh/2wC7T2dz75y2Rzk9HZ/ZTZ6hpZqcPUtZmP1n0ohY1H5MS?=
 =?us-ascii?Q?8zYePICPRwge0kwJMjsdyE2szKiL8/0a2HppHyIMgTebncPAkWMa6ikPnxnJ?=
 =?us-ascii?Q?TVo816PcrICEzIy9Y11Vk+CLdQLmxJ9R/ULiGr+SbykGU+WiGZlarNaeVOW1?=
 =?us-ascii?Q?F/y+XDOCAmZxAs+ZBLTV0w9CFf2tjcDaxF99PcUaX1VOQj5Dmjf4jHZ/zjC+?=
 =?us-ascii?Q?rL5BSDjXCGcrkDTiCpSlK9TDyQOMRGu+SFy9RlJNeGR6EtX8jDDD7yLuE7jI?=
 =?us-ascii?Q?edrYPQALFJigSH8wsgR/i+3b5nWLDwwxOPiewEUIDBXgD2MUgpaWG3g82GYR?=
 =?us-ascii?Q?EcWtVBqmF9gi54VZRE0R47NttHQNXjLdXvRlasxG0w/vpiYzkC66ykcNGB3t?=
 =?us-ascii?Q?d++VB8bSbMyNgcL7vUzFF5ypfvVPz8zT3Bt6JGk1DgEBWVSaoKC+cWndCE/w?=
 =?us-ascii?Q?9YEZaJMOmJMbqIqkcZNXvVjM5BA7KS+sBGZiTFOEzzfjJzPNYY7jP/gXDNVm?=
 =?us-ascii?Q?atKj5ABlUhbPTE9gyQTloAgKI/RUMR5UrgO2iVMVl4HH4rNP+MlHhSdN20HD?=
 =?us-ascii?Q?G2vZXf53E+9YTHlUwoGlrzwGrfk+Tk/6jAZuO5mGXWGCNtIT8hct5AfOdEfd?=
 =?us-ascii?Q?ekwuoUM/9PAEi+gTpcg03FRJUy8bgiQinLnD5auUqB/rD5Mt3ULgK41ywArq?=
 =?us-ascii?Q?9B6QzLszlPvuQBx746Tk44AsLZPdkERdiEuhHRxX1rUHdWDjelRlqePxTeGM?=
 =?us-ascii?Q?S0X7otVR+wx8xlwt+4s/QycU0j4S4emz4Jo/DT+/jxX3eSUbhf5n2nn7RyI4?=
 =?us-ascii?Q?SRjcpVf1mJe4cHfo6/DUkQ9tsvbWPFMccblAoOx0j0rfi6eEwKu9cJS6YsgQ?=
 =?us-ascii?Q?ytOteEpLekHWKMtwHLg//2L45aXhnCtGyWEzekqTOsPwrf8XP+Z6zKT5R3s9?=
 =?us-ascii?Q?C86DNyD/MNHDKdnmqwqwZHSWL0XPeJ+sav1L6MGjJdb8NEW74GVcw0cr9MtW?=
 =?us-ascii?Q?FOLVZwQiujHVbmLdfLAH/QYmNU=3D?=
X-Microsoft-Antispam-Message-Info: 7v4JLTktnNcpO+7vbrCENsh+kGlDXjPNOEipSixp2wt4M3yPDCHRQ10KFzWXkevJhrOXgwviDDTPP6u6FPFJuFbLlMmgG8ZsAzNi+zKFZKV6ONCV/YhcAoyfrgcF/CFwjk7N9g7ux5VwdQ19FcHKXy+PngLy+nD1tTyOqVlPlF7AG10FOuw4SXHkoYHZHHZtTeSzizgDJHqdwOmQtLSAKihSzavRTV9cuj9LIQkmx23lvq5DMepk4cg9XwLISoUqHL3c3FnS+y+S9Ti1LwlYdHQ3t1lOxPpguCh1nEnEJYrq+hTBRRbeBzMuSn0+pQpNsnvKGIxeZBNHMUCWgvD/QQ==
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2508;6:YJFTkWytxWCO+XLDU6uk8WqBKDrHcTt5DRuRJMmAixZ8hM6KL3vyTST6QYlsM1bE+XIlNdFTTuUF4B2yFs0mu+qmJa0QpdIxLnKAcKeV1cDLEP8c3BJpaD3AYAZY4fYdccVEOHSssrCf/Sr8O/G+I9Rq+LzKqdHJ9SC4BWdx/Q0zABbUus/dMXWAkxlCg18K1db6plBvkUUmzluXYQiNrCDEuugsTpONj+JqlTpxM8rwuzTaFesl30buEsDwoxYkWYIHYYTclb+GaCCf5RoK5Hl1XK0hsoeKwlXYIL1dZRe62u+/ewLNsD5kwvT63zfajv0ROGneusJ5jXsU70/TPdJI/43vWRUQ0i/kHZyvOt8XMqh6MFPjhwnysdG4wnO5lBVUz0mu87q9ldDBBUTEbOdCRxsaI3a+g8FkZAG4u6f+pP/oIFuA0+D7omGEauO+Xxw8hQcUwVJkInKWOwVyKw==;5:ioMTuV54ppNLCrmnlrd79+0mLIxRsOgt1wrulkpnxIEVkC/xdl8FGdIIvMDODOk4EnoSLi6pca7eqvCTc96lYqO9U3C8+wkB4HZrJoM3CyqtLFwWq9IxZEPMiYuYlwYu7etOR/CPalgIn5vHUmQ9j1dRTLuK/SweqRuSmzqu7Bo=;24:bkhPLgjUEQTxugbLN3XYQYZJ560WJ/n8qSmRZRQ2G1LK7rKMbhSHBmgfh/1PmWY0nEogJl8jRF5B3ow8+2CdimGPv6v79k5HVQLorNMP0wI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2508;7:5GZWoYsbh1tKioj0pnz5Xaqs0nQXL5Ra2uEP8snyGs2f5npYCHQqDuTvN80BgnAidT9UmnunjhSc3l0EpkJ+eqR8AXfRBeBGPH94M0UPfgVC2UqfxgrZ6D18IlLTilsBPvnu45Od5YIbEA8W/6BUbEH+Y94a651okn1t9l/zu3BlHbIWAD+FnzBSiDsWgBzbfhN6T99bjfyEhAGaQPGPYlgzPiKzBgHikvKm026wUF0Jhhkz5Rpw11f/8VkKqTRr;20:oplfJkZjyHIZesS4ivKCKShtSOf/diN9JpQ7OdCHwLR0/ig3zG2xRzpLTR5IxD4LDjbWmX5oNjO/CEZ9zbXUAGcozFIqeCAPDzLvyhSkA566lwUntQoR0moAutvkMa4W+7dWMNUfdflXX4JozPzgs/ppWp9ysw+EyP7p4Wwx1EU=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2018 22:48:24.6955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e917f4-3e50-466e-db95-08d5d8924546
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2508
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 02:27:43PM -0700, Jakub Kicinski wrote:

[...]

> > > should just use the BTF, I'm not sure we should format indexes for
> > > arrays nicely or not :S
> > >   
> > > > The key could also be a struct (e.g. a struct to describe ip:port).
> > > > Can you suggest how the "key_struct" will look like?  
> > > 
> > > Hm.  I think in my mind it has only been a struct but that's not true :S
> > > So the struct in the name makes very limited sense now.
> > > 
> > > Should we do:
> > > "formatted" : {
> > > 	"value" : XXX
> > > }
> > > 
> > > Where
> > > XXX == plain int for integers, e.g. "value":0
> > > XXX == array for arrays, e.g. "value":[1,2,3,4]
> > > XXX == object for objects, e.g. "value":{"field":XXX, "field2":XXX}  
> > It is exactly how this patch is using json's {}, [] and int. ;)
> 
> Great, then just wrap that in a "formatted" object instead of
> redefining fields and we're good?
Please don't let two formats of same data in a single ouput. Overloading
same output with multple formats suggests a confused design, IMO. It
will confuse users too.

> 
> > but other than that, it does not have to be json.
> > In the next spin, lets stop calling this output json to avoid wrong
> > user's expection and I also don't want the future readability
> > improvements to be limited by that.  Lets call it something
> > like plain text output with BTF.
> 
> I don't understand.  We are discussing JSON output here.  The example we
> are commenting on is output of:
> 
> $ sudo bpftool map dump -p id 14
> 
> That -p means JSON.  Nobody objects to plain test output changes.  I
> actually didn't realize you haven't implemented plain text in this
> series, we should have both.
> 
> > How about:
> > When "bpftool map dump id 1" is used, it will print the BTF plaintext output
> > if a map has BTF available.  If not, it will print the existing
> > plaintext output.  That should solve the concern about the user may not
> > know BTF is available.
> > 
> > This ascii output is for human.  The script should not parse the ascii output
> > because it is silly not to use the binary ABI (like what this patch is using)
> > which does not suffer backward compat issue.
> 
> What binary ABI?
Reading binary data and linking it with BTF information.

> I'm also not 100% sure what this patch is doing as it
> adds bunch of code in new files that never gets called:
Please take a look at the patch then :) Code in these files does get
called.

We seem to be conflating two different - and conflicting - intents here.
First is progam-readability of the output and second is human
readability of the output. I believe both are important. Let's leave
existing output for programs to read. That way we can try to keep it
backward compatible as well as JSON compatible. Let's dedicate the new
BTF format for humans to read. That way, we don't have to worry about
backward compatibility or JSON compatibility.

Let me know if this is not clear. If we agree on above then I think we
can move towards a solution.

Thanks,
Okash
