Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FA8C677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E0D2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ezJBSyWn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="X6ZO7HWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E0D2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbeJIBta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:49:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49142 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727803AbeJIBt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:49:29 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w98IEBRW014372;
        Mon, 8 Oct 2018 11:15:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=xpmMP+nmul4W15lUX9O75cMowKt1q9w2++/rtvgBCAQ=;
 b=ezJBSyWnbAiEE1E6CDvgbNrKgEAF39sCxDWQscj5iKl8WV4UAwBt2P+LTB2gmaySJyOQ
 2yC+ikX9uTLDEFUkn/M7fEgQZ83ve3JnO7DkJodWZea00W8LyP3fkUG9KmXqrUnwH4gV
 ah7gAWstTjtDQdjpmGCQmZxcPnxk7lKO9jU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2n074415ev-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 08 Oct 2018 11:15:38 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.31) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 8 Oct 2018 14:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpmMP+nmul4W15lUX9O75cMowKt1q9w2++/rtvgBCAQ=;
 b=X6ZO7HWU6InyR8q8leaWPO82cEa2RiN/CtyGKjXx0uBSLZdXZAAoc+RVhKB5qMp7jLKyeJe7t76WrC/kZCIQ/YaC4/R99YI2Rz6QI6w87VBCcVMxp1K70qDR5lakowoVA6g2MdVx1DNztGEay/A/wrwHNP+IWusSg9jJ1DIwWnQ=
Received: from [192.168.1.213] (67.253.148.112) by
 MWHPR15MB1885.namprd15.prod.outlook.com (2603:10b6:301:54::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.21; Mon, 8 Oct 2018 18:15:34 +0000
From:   Chris Mason <clm@fb.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
CC:     <ksummit-discuss@lists.linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] code-of-conduct: Strip the enforcement paragraph
 pending community discussion
Date:   Mon, 8 Oct 2018 14:15:25 -0400
X-Mailer: MailMate (1.10r5443)
Message-ID: <FA87081B-1344-4CC8-8BCC-F00A985719FF@fb.com>
In-Reply-To: <1538861851.4088.7.camel@HansenPartnership.com>
References: <1538861738.4088.5.camel@HansenPartnership.com>
 <1538861851.4088.7.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Originating-IP: [67.253.148.112]
X-ClientProxiedBy: CWLP265CA0155.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:52::23) To MWHPR15MB1885.namprd15.prod.outlook.com
 (2603:10b6:301:54::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfce6e7a-0027-4083-9036-08d62d4a0b1e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1885;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1885;3:u39OxoelXjZ7PHJD/dxYydtRuuXsf3GL5vM4FAYdXMyWa8Y28dllRdBZFjMqlLKbmzyxRfN7mIQcpee762u2XLTDYw4gTxScRWy5+oP0viwN+grJ3LBY1aTb/IMLcUrmZ04aEKsovbNVgRqyXxnJTopi1weKR0GYM9RNJjUbfNsEQDLhvhbaSHFYaZik5Q+93Na6M5AIZJ0LTwmYmsxi4VkSikTAeXrpQbkMsrGqmO6CYpAtdok+HAqwvQZAl8je;25:/fpLZyB/trFbljfHaDGdznKga9riFOf0acC3+UtCrMUB5Pu/SZSXqNvHRCduSc/HqA+vaCQMJ+k7dSuHnstSu3schLuZ7VAf8us7d7GWWkpYaoPKfTcYpfcZCLi+RWMnd5BlKWji2U8iRG62KslTwoTQQZ/s8SklnBVuUWro3rxRCstJpuSPH0bYVSN8Y6iw/JsX+5OjPxnntUKVSVsc3jiOyJVyflab8t5PSz405EypCISDve1M6kfT5aFhI18/nFZBVTKsrXb+mni5Mc+kQl+Ya+LdJyc1FqvjHu7Oz/BDnE94UEw+z76CJpqe3Pxs+45aKkZ9Oe0BnPo2dTuzSw==;31:T5i/hITuv2d4sYjnAob+K74kMODKBdvqQ6XsLckNhBHwWWJJi+gOYUCOCLpKV5gfF7FTKKlSCy9G4l7XV2E3/JDISCe9F2WXR3F9FErgTBDLLDuly8VTJZEqAbEndoDSyFhuTJMF/5E48Oc3ZZDUAN52kyjk7T4XkjbYMtK/JHcxezEIrz5RK/spgAwe+ww8Oe7axJg1MPu4MpUZAeXZhzTnZrbDXf7Aklg/c8lUYec=
X-MS-TrafficTypeDiagnostic: MWHPR15MB1885:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1885;20:/Og7JiDY5UqsOe3KTY097ndIw3vmKgZO6yGDMSt5DMphbAIMqT1+QTIT50h2oCXnsJCjFVPa3dEqHMdzLw9CyYemQVYcEfk8v8uxZd3gk5Y2aSpbdyqiJbUjcA/ACSWBnzr6jn0PvKOK2s7CgbtMXBCnSCRBJrdz2efoeUJU8AZTTHMeSpVc7ZFIRypqzRaoPC2rw5IO6U93t2Eq3tv5GT99TevMlZOGL011HUU2jD+3Yr5LXRY4/dHM9RX5ZJ8ARxOaXyS7872mHk+o3TJN7yUYTzdB8hLIzedYw96jRtC6RP7U8s8YfeucVA5+civFx4AhfPDilEZ6NFeYYctUYb8ZVAvFRyBQBeIQdsFCBQ6zWXl5oBB89fAunckOQyCsPt/HXwlI3IlAiY86sO4CocN+QOFG3etHQLe3sE0gAAZ//FRyYWTunxQtXmFG7g90TYX52pMTGONWczl0i3sS/pZff+ZzdvRfG9qtOyHAiqYkaQLzbPiuk9UBIlXwXwkS;4:ylXnAUiJ5JjnZEkr9YztmyUqel2qhe0nVTOTi0hQK6grUBgjvGPigMKk3ObWzAQjjd9yEOjC12qzYY7yzUTmf9NHifdiwdzbxxgYSFUx4mWeHYYmbuKCbruXqTGVlK3N+VFS2yV+YtgeSL48QR8kmTDB1Im2sqUh0pGOOewtXvPpyVkfin+TjeCyE7LT3BOLz+9X63iKwSQwMRnis4KTPVwt42ZBI/13JcU2O/sLmoO/D0xQmWP1Np6NQseP3vyyGx7nR9EYElmv9O2U5J2l0g==
X-Microsoft-Antispam-PRVS: <MWHPR15MB1885BFBA9293199C00F3C4A8D3E60@MWHPR15MB1885.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991055);SRVR:MWHPR15MB1885;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1885;
X-Forefront-PRVS: 081904387B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39860400002)(396003)(376002)(346002)(366004)(136003)(189003)(199004)(68736007)(6246003)(53936002)(67846002)(53546011)(386003)(6116002)(36756003)(16586007)(8676002)(478600001)(33656002)(305945005)(16576012)(76176011)(81166006)(6916009)(81156014)(7736002)(97736004)(6666003)(50226002)(316002)(51416003)(3846002)(52116002)(8936002)(82746002)(956004)(2616005)(5660300001)(105586002)(186003)(16526019)(486006)(47776003)(446003)(476003)(229853002)(6486002)(11346002)(2906002)(86362001)(83716004)(117156002)(4326008)(66066001)(106356001)(77096007)(50466002)(26005)(25786009)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1885;H:[192.168.1.213];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR15MB1885;23:OZDE4D9HpU+ny2TOpJ9nAhqOPUDJ3ICoNAijckKxo?=
 =?us-ascii?Q?CQIHFEXmXHRWhndc+pZ6ret/P+eWBoMlO2ItSnwNuRu1CLxZ/9/5lFIumjLe?=
 =?us-ascii?Q?CXtzDwL9QzE24rvVC4x7pZyTf948Rwd+cqJtbnTPhG8FXon4AbOez43c7cN/?=
 =?us-ascii?Q?m346EYOkruuXHv5m15B1ACRXMwvqtJwB0S1zHWGyPea0MYUgw1RcWMZ826fg?=
 =?us-ascii?Q?ZmKN2wmvJrEJE2le7JCga9O3uZh0+hn/+D2lHI6pMTh2IxJakBk0yy4/sJS5?=
 =?us-ascii?Q?Bms4uxiFLHxFUlqubIBYdFgp/g/OjAUZt9+LGRBdMpn9QAPcR6DsLcvmO8Ko?=
 =?us-ascii?Q?1bpJ8v+rRN1iEwf+85sCMfZwaIVHd7j/1/Aoeh00Q7gH9xymlEmJ8xViVUgQ?=
 =?us-ascii?Q?81D9VX1/Ts6T05qTPrfmplo2JBPU5AcYgXJJX55NgzNhW8PiwRbi15NkaP3X?=
 =?us-ascii?Q?LkPnpm1BBYcbE5xfpKpdRfk8Izx/7Vuu4dELiRH2YuwJL2l7Czs90HR/hp20?=
 =?us-ascii?Q?jxfVbtpH5NU0UM+ahO0KYX7jEkbPX1yDEBRKM6PPSv4mO/GsI4Bo5njzgP2G?=
 =?us-ascii?Q?KESRkWRPsPOpmkHOA8Z6F02mPS6Ap1ToJubmpAC2QtpHpLGH2ojfEWkb/NsM?=
 =?us-ascii?Q?BTqajJPoEOa6sdCROwPh002evJX8m3JTK2Rnw2t60URU4oK2NhWfPdd3Oxeh?=
 =?us-ascii?Q?3UAiEYaS3iyjfY8kJp/B+Uf4I/sjd8caxqsYZxvK415gbEYq0C/7CJBcNITs?=
 =?us-ascii?Q?pJNpjUUEV7Jg7DfYkXeGWf+2j3PZ+6CfgdxlrDjgCipjx9RAcj0CbvSB9/uy?=
 =?us-ascii?Q?vwtJXLysJmz2pAfyGhMb5DdpsMz7yqBVlRs/MJYK3oC3T50YiwZyJmg1Mcra?=
 =?us-ascii?Q?CxOTMmtiR+EWReYntOvK21otKr8PJKlk6Az+lvj1oaGYxNFPgTRmfOrhqdte?=
 =?us-ascii?Q?sgp18bQh4kNMOLGKd5zVj0zRwHuUlxXoAQaI2rAUr7FZP5D4E1qEJ9EEn5zS?=
 =?us-ascii?Q?8Pec9z5VQ8lat203sFwBMOzdqeT0R7QDZ2F8nPJTP2k64fLb+vvDcrU24uPc?=
 =?us-ascii?Q?0cxK9Ujo0fIwnr2Jtx7ydv9Sk0RlE8KEiv7Rf9vAei6PDtecq4lW22GoZe3v?=
 =?us-ascii?Q?okE2LFEg78XVnzBUamjYNoVdoF3qKfo75AP0aHfpV9cJCpvg870x72L7eewd?=
 =?us-ascii?Q?Qi5+LuJ5jCeCx/miZQVIVeA0X6ckkIdGYkfestIHC1EfhvHdMSkAAfrKo41z?=
 =?us-ascii?Q?R7B3gXIsGYT+q5G5Sw+zwyCWETNyiNJ2opwQiLDg77qdFZeWGzL+x998KNeV?=
 =?us-ascii?Q?mQ7NTVaxoG2zMG1qGCLxqOdoAfjgDOLGB7bJ9eDv76Rfw0jdzw+PHpvUz1J4?=
 =?us-ascii?Q?kUYew=3D=3D?=
X-Microsoft-Antispam-Message-Info: q1S2uk5WxEOb7OVIorIluBMQnxH0F2Xjq62k9xQ9RnsgJuCUiMHSKwJk/ZrGlM2YJPS3Bcr5vNkBUYvDOSBAQFtmcdrxHkPdniKgcUl2VUU4yCN2loXVE7cSjvmpiaNLj/Vm1qxPzeIy9IDRkdCvIFkfwkUWQ3ge2GtDl1q8n4VbT6l3jOiFwIoyOAWEKuIzGyrUa+so9eTMQNGr+8vWx+T1I7Xc+AOnBvlkRUPUlqNUm+p6ER7DfsMdBneMO/24PXramyyxXb62z6tI9XtfbRe4L74AefTXXa3vNBDAVlHen9gtT9fIzNjf8goF8SxuUxFTxsHFMiUH2o//fsAv8/hL1IIJz3wi1V4uxG8onmI=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1885;6:iGOnqMOwjnBWgDGT70+vER3iAzkqOBLLG8w8ygdFP3dL71p3DHDSylAdr9wxBw1UCrCbzzdo4gXVDLdvyBQEzGoHIcz/nrwP293zZFKcixC5MfsO+nd9EAUG1Cf1mVzjXaSSfVFhA6s60UovnCu2ySmcqZ8zPS2aZerRxTF9SRwSYTxjcCOPlnv01doUofnQxU75w0Q3MeFPgsfSvyx+Hd2HhatEe00KKGPiLPLdYsbCP9KNECM460US0W3ywou4T643ASYWGwTS2IRvdU2Wn5cS2yVKD66xIGlyS/IXtOblUt7croMy9EaG9JwZPSOzJvw2hq/uDyPrvXrwF69keguPe0QnK+xmYc6/VB/f8lnh2dnvzh0w6F1+qJep9/asFEqn5yedFvQV82iz4bmnX6K8IHcJ/pcanbstOzzqjuXF/+KedVAbVQrnAtXKDYXZ0w1AWy3e2+F25rWWhiCZeA==;5:SABxNAroL7yR9xuOhazJq7LVMppua6HFZhSifT2ZLdbV+oLsZJ6oFyRxxa7kW0C/E4IbpaLlKJ0A28ejOOUqUCnTXBk9dw11T9BcfgzsUrA5TVn0EsD7eqyTAMAiJkQzuXGEN0lrYSh8vJUfsyDaAjJ5vmjyJg40y+IEtxN+NgI=;7:E/m5QR/QDmu/1D9B+jrh0gsLyE/utgZ+tL3TyjvVCqD1qYerdF+bzGXwC+yvz2QsC89vwBLVcLTtItwehL0v3HpZHFSwPa1iRREAHZnumdhHrcdFDf73HFbDpUO5ahfKz9f6pWoa8kU4lDMFTr4X3sJx/FOSoOXTG1nWeS9UwjdqNO3nBHNZjahxTho7+YiZdBbYdq+fD2MP4RI8JAlev4/GQKD0zdkxJqiwWp82Zv9fNzvRwB7BUmLW6ggILvpq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1885;20:PvlR4KIHAi96NiUtteu8d6yjAKnPBqozriYERxtXrFEj9zYqqH1yvv6eMw48dbPBo3wDO+mfCO6+JUGR1oVKuW0OG/p5B70FbFtWqkcEfRgzU3K2vhTwsU3V1cOU7Y5Ab/C3SHxAIYdFLqp4YAzHu8ie9mhRTzznRSEwaEq7uJo=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 18:15:34.4806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfce6e7a-0027-4083-9036-08d62d4a0b1e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1885
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-08_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Oct 2018, at 17:37, James Bottomley wrote:

> Significant concern has been expressed about the responsibilities 
> outlined in
> the enforcement clause of the new code of conduct.  Since there is 
> concern
> that this becomes binding on the release of the 4.19 kernel, strip the
> enforcement clauses to give the community time to consider and debate 
> how this
> should be handled.

Even in the places where I don't agree with the discussion about what 
our code of conduct should be, I love that we're having it.  Removing 
the enforcement clause basically goes back to the way things were.  We'd 
be recognizing that we know issues happen, and explicitly stating that 
when serious events do happen, the community as a whole isn't committing 
to helping.

It's true there are a lot of questions about how the community resolves 
problems and holds each other accountable for maintaining any code of 
conduct.  I think the enforcement section leaves us the room we need to 
continue discussions and still make it clear that we're making an effort 
to shift away from the harsh discussions in the past.

-chris


