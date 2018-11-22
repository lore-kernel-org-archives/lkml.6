Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEABC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68C220838
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="JA+idckZ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="IfTiOmvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68C220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438240AbeKWE7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:59:21 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57918 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727787AbeKWE7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:59:21 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAMIEpD3020902;
        Thu, 22 Nov 2018 10:18:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ciKWqANtvDn/xvFa5tLyLxTlXpoZcJY8qNkd+iHcNIQ=;
 b=JA+idckZhUG0sxX1wkikg8jy5E6vthCG57rYA+hiNTT91QVjpyL//eWFNj85Bx8EJPLL
 zmV6owvN6/zCcoNHCCY1AijaZusX+iF9BfqX0/zcgVe1U9msUmg58xR1GhAlrl9Htc1w
 mUn3JDLkffIUdB77Pz2wzosNN6VMlSLtXPA= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nx0g005vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 22 Nov 2018 10:18:21 -0800
Received: from prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 22 Nov 2018 10:18:20 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 22 Nov 2018 10:18:20 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Thu, 22 Nov 2018 10:18:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciKWqANtvDn/xvFa5tLyLxTlXpoZcJY8qNkd+iHcNIQ=;
 b=IfTiOmvBImGi2igcOvi9/QX7faenc3XyXjcg59DgE01iLqYXUnKUOG71bGVf4w+3phHMY8FAlfCv8eNlBJ9/q0MxkOTN4hOfhN36OOQ04Pdhm+08EmhW+du6AyQByIL0WFTY7MYU3c6R0pN67/yO/Sea+lNMlnSh2mqNjTIZNdk=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1134.namprd15.prod.outlook.com (10.175.2.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.23; Thu, 22 Nov 2018 18:18:16 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::6d1e:3274:a367:a55c]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::6d1e:3274:a367:a55c%3]) with mapi id 15.20.1361.016; Thu, 22 Nov 2018
 18:18:16 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Wangnan (F)" <wangnan0@huawei.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: perf tools: remove option --tail-synthesize ? 
Thread-Topic: perf tools: remove option --tail-synthesize ? 
Thread-Index: AQHUgW4siyZx02jtZEikk8vk0I6CCqVaNLEAgADT34CAARQMgA==
Date:   Thu, 22 Nov 2018 18:18:15 +0000
Message-ID: <65755121-AC25-424E-8218-A755A084A1AF@fb.com>
References: <89AC26A9-5A18-4608-8889-9C3C9C1C69D3@fb.com>
 <20181121131156.GG6248@kernel.org>
 <da87afd6-c291-2049-5e0b-a02512122806@huawei.com>
In-Reply-To: <da87afd6-c291-2049-5e0b-a02512122806@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.101.1)
x-originating-ip: [2620:10d:c090:180::1:34c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1134;20:sHK/6J/u1nUORTnP1/CNGi5RVGPj4MEzyIV90MyPkeEvbLrMx1wr/2P8JcTzproDCLFwI8Bu2uLPmfQAsZdD2vcZZliYFH9QznsQUblXhL1ArZqFn052ryL/U0ra6hkb0j67FRrok/+Cb+WSt5Pgc6JP054rX/igKMBHHPff2dE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: dbb3b891-1831-4813-1f06-08d650a6df56
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1134;
x-ms-traffictypediagnostic: MWHPR15MB1134:
x-microsoft-antispam-prvs: <MWHPR15MB1134A5E318DD6B653C8E8EC9B3DB0@MWHPR15MB1134.namprd15.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823302103)(93006095)(93001095)(10201501046)(3002001)(3231442)(11241501184)(944501410)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1134;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1134;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(396003)(366004)(39860400002)(189003)(199004)(11346002)(36756003)(6116002)(82746002)(446003)(57306001)(6916009)(6512007)(106356001)(33656002)(5660300001)(71190400001)(14454004)(2900100001)(2616005)(2906002)(53546011)(476003)(6436002)(46003)(102836004)(4326008)(8936002)(478600001)(14444005)(50226002)(256004)(8676002)(7736002)(81166006)(105586002)(97736004)(486006)(6246003)(6506007)(53936002)(81156014)(305945005)(229853002)(4743002)(316002)(71200400001)(99286004)(6486002)(186003)(76176011)(68736007)(54906003)(25786009)(83716004)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1134;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TH4xMCtX0+z224K3sUNNYtTE+l+0rF2ChesLN1yAS1LTd+GQG9LgWasq0M9nAlK35Yd6f9Z6oIgdnLdhjovUXpavLxOBbjSCPslxJuOK/+TQyNGSTfcHdRX3F1uCsxkEfu6MRsSV8utICezpjxgpOHRqkaU8AI5K0TbTgGhKFcEX1Y1RC5v6UYdlWIyA+wk2lPndC+t/4T3WEhkO+FQN/lRUauY/0iNIa04MKCw66awZZ86Yw1NFhPLGwcJmG2jYpl/0Ry1x2L1hXXBqLG34xyo+z4kLwOwnS44jjNl0q15dF8BG8MbOTV7mhD450aBACh1so7z5yrBAJHtdclxQI61/QY5alImrvuCV6wooTjI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E8FC0D040B117B468BD8945E88A88351@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb3b891-1831-4813-1f06-08d650a6df56
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 18:18:15.9541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1134
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-22_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 21, 2018, at 5:50 PM, Wangnan (F) <wangnan0@huawei.com> wrote:
>=20
>=20
>=20
> On 2018/11/21 21:11, Arnaldo Carvalho de Melo wrote:
>> Em Wed, Nov 21, 2018 at 07:45:28AM +0000, Song Liu escreveu:
>>> Hi,
>>>=20
>>> I found perf-record --tail-synthesize without --overwrite breaks symbol=
s
>>> for perf-script, perf-report, etc. For example:
>>>=20
>>> [root@]# ~/perf record -ag --tail-synthesize -- sleep 1
>>> [ perf record: Woken up 1 times to write data ]
>>> [ perf record: Captured and wrote 1.129 MB perf.data (3531 samples) ]
>>> [root@]# ~/perf script | head
>>> swapper     0 [000] 1250675.051971:          1 cycles:ppp:
>>>        ffffffff81009e15 [unknown] ([unknown])
>>>        ffffffff81196b19 [unknown] ([unknown])
>>>        ffffffff81196579 [unknown] ([unknown])
>>>        ffffffff81110ca7 [unknown] ([unknown])
>>>        ffffffff81a01f4a [unknown] ([unknown])
>>>        ffffffff81a017bf [unknown] ([unknown])
>>>        ffffffff8180e17a [unknown] ([unknown])
>>>=20
>>> perf-record with --overwrite does NOT have this issue.
>>>=20
>>> After digging into this, I found this issue is introduced by commit
>>> a73e24d240bc136619d382b1268f34d75c9d25ce.
>>>=20
>>> Reverting this commit does fix this issue. However, on a second thought=
,
>>> I feel it is probably better just drop --tail-synthesize, as it doesn't
>>> make much sense without --overwrite. All we need is to do tail_synthesi=
ze
>>> when --overwrite is set.
>>>=20
>=20
> Some cases we use --overwrite without --tail-synthesize. How about settin=
g
> --tail-synthesize when selecting --overwrite by default, throw a warning
> when --overwrite is not set and leave a --no-tail-synthesize option?
>=20

--overwrite implies --tail-synthesize. So with --overwrite, it is always
tail-synthesize. Do we really need --overwrite and --no-tail-synthesize?=20
If not, we can probably just drop --tail-synthesize (or mark it as=20
deprecated)?=20

Thanks,
Song
