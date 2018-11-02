Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C303EC0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D812081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 00:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VIWiTXRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D812081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbeKBJVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 05:21:18 -0400
Received: from mail-pu1apc01on0107.outbound.protection.outlook.com ([104.47.126.107]:32896
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728058AbeKBJVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 05:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+CT98f3ktY2NhdY4zpTAAtHTusoEBt857p5XU7kIew=;
 b=VIWiTXRI8c/UOmLNp/nGRRxWLpWBdpfy9z3xIsQZkGmB0hzCeC67JubkeBjUnAxw5h7vjrniWJONUVQvWYibloz6cZSJA3mH3G/ggSf6F6JTAi2aoe1Ha0K/TUS2fnAUjS2VGp5XnLa9v4LrcK/2xZ/d1w03a2q1LvYc0EKxQF4=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0153.APCP153.PROD.OUTLOOK.COM (10.170.188.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.2; Fri, 2 Nov 2018 00:16:03 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::e85a:f0c0:9810:d217]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::e85a:f0c0:9810:d217%3]) with mapi id 15.20.1294.014; Fri, 2 Nov 2018
 00:16:02 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     "Stable@vger.kernel.org" <Stable@vger.kernel.org>
Subject: Will the recent memory leak fixes be backported to longterm kernels?
Thread-Topic: Will the recent memory leak fixes be backported to longterm
 kernels?
Thread-Index: AdRyQEG5VIfdELkdR3eQ5BGm0rZVcw==
Date:   Fri, 2 Nov 2018 00:16:02 +0000
Message-ID: <PU1P153MB0169CB6382E0F047579D111DBFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-11-02T00:16:00.6324693Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:9:4827:13db:2d2f:a55f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0153;6:WymG3Amj4Fd8o/san9zbF12TOvCeOGe+RM9D6sE63GnVS6hFu76UWJ9810MgCfR+kypvbubpiyQwewjaiRLmnv57nZIPSJLtUZXsPtvrynQLz7pRNkAL1nK8pwtPaMHh0mwi3MwQ2EcwuEmrl45uZ+Pw9XUnQqGkgelR7WC0I0B71rfv5yt/cfgXCSLMhrOagYrMSKyITk545MjOCBQybJ5rfkZGtqd+cO7BDNOWzUK55zJeHYzGVXZ8d9pZiufomm7LDw3EOZe02Sc/Nze8aoDmVyMotr3k5fDYUSSznKNrqj6Iq8qNukhTTsOzXMLtsxkU10KotjbJnC79GKXXG1yyVhU1L15nxPMkMrtGS6I+3Xi+9skm/yt+OZ5Sw4CPnMrAg6IF5AS1IV4qEkhQwwwEbAAcNfv3Utd4Iwdj+SVpI71QUn6qP2lz5s2km1T9WKSNtv2dAya3r9H9bMPrhg==;5:ENVVAOcZ7Pb9yjoSZDSZhpULpHCn/+PLS9dxculnJRyYe3vC+KkN/Ft8adVaWi66VN1tCj9+b9gBQCcxojDjleAHwsGP+rxzGcH7JOqGYCc5GE4kht/AKC946+1tHxc9ZAZMlE4OG60DYH1zRzxpWV2H6+j9DcCtjegm9iCyhVY=;7:vU5+1aLIRYrItJtLHfLsJWM/ALv2imSwkGNklg+7rEUdXoFiEBORPVrAAOjn9sZImg/uKEzr+86k9k/A+EKEx022SO/zwJCqQYCzqRjVgSjFQ1KE5/m0u3950PS3VnVJuWxYIVSc4R5ekTbokj4/0g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8de2c731-1ddf-414f-6d70-08d640585fea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0153;
x-ms-traffictypediagnostic: PU1P153MB0153:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-microsoft-antispam-prvs: <PU1P153MB0153CD33B76E6F6DB9BCAAEEBFCF0@PU1P153MB0153.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(166708455590820)(211254476889703)(24339691489775)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231382)(944501410)(52105095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:PU1P153MB0153;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0153;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(366004)(136003)(346002)(53754006)(199004)(189003)(81166006)(966005)(99286004)(6116002)(10090500001)(68736007)(486006)(7696005)(2900100001)(305945005)(74316002)(8936002)(10290500003)(14454004)(81156014)(46003)(7736002)(8676002)(39060400002)(2501003)(22452003)(33656002)(316002)(8990500004)(6506007)(7416002)(256004)(25786009)(102836004)(86612001)(186003)(478600001)(4326008)(2906002)(105586002)(71200400001)(53936002)(6306002)(71190400001)(106356001)(86362001)(476003)(110136005)(2201001)(6436002)(97736004)(5660300001)(9686003)(55016002)(575784001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0153;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: rSIiLoFrblJSbtAftw7J5vjT4v+ClAJBUtGk+C5HRattvuc2M6jWp293h12NSp26yUMPgtAtKc0i99thnEnYhaJsMD/9X+Wv97GZCiv6sKDVHQR2XYv5ZlKc/9VeJ2jraLnmMvi5dhUhqSO6mh+zixq8fhlfqBlRjA6PV4wyhrye169htn08y/ifVGJiMmRkjfoqFhebkZxH5a32Ddj2FkU/xlDKSKjwMN2rFuwb51xQzXXp2V6Li9gOnEcnfJIxyBPW/fXZqKlTW3p8AA0Z0NOKy7pK/cBiNFjCGLsB4+owVxzg3kkdPyL+l7H/JAA3y8CvcHKox8WDlA1ajF6ZiSHGCLiFNB9rlK/XqyWubgI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de2c731-1ddf-414f-6d70-08d640585fea
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 00:16:02.6540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
When debugging a memory leak issue (https://github.com/coreos/bugs/issues/2=
516)
with v4.14.11-coreos, we noticed the same issue may have been fixed recentl=
y by
Roman in the latest mainline (i.e. Linus's master branch) according to comm=
ent #7 of=20
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1792349, which lists t=
hese
patches (I'm not sure if the 5-patch list is complete):

010cb21d4ede math64: prevent double calculation of DIV64_U64_ROUND_UP() arg=
uments
f77d7a05670d mm: don't miss the last page because of round-off error
d18bf0af683e mm: drain memcg stocks on css offlining
71cd51b2e1ca mm: rework memcg kernel stack accounting
f3a2fccbce15 mm: slowly shrink slabs with a relatively small number of obje=
cts

Obviously at least some of the fixes are also needed in the longterm kernel=
s like v4.14.y,
but none of the 5 patches has the "Cc: stable@vger.kernel.org" tag? I'm won=
dering if
these patches will be backported to the longterm kernels. BTW, the patches =
are not
in v4.19, but I suppose they will be in v4.19.1-rc1?

Thanks,
-- Dexuan

