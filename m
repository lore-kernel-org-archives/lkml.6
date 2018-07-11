Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F27C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DD020C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jpQ+onAa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="QxkyYUtu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7DD020C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389452AbeGKV1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:27:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53496 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732301AbeGKV1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:27:35 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6BLIKAc027166;
        Wed, 11 Jul 2018 14:20:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=facebook;
 bh=++hI02YttavEhA+/d/mw8cNtQppPs54kRYRXVCfeVmk=;
 b=jpQ+onAayVQIYPXpbyHtIVLnnZlaJiOaum3po43u5lkA33jI9t25hnUpCOvnsozFzTYr
 ZG7jLs+ErU220STWzwjL5AO9WPKqKY1+acETljhGFuVnZRNYg3Zrcb6a6F9FBXyYA4vd
 g2OwXAEQxm0Vp1vlwvTP1IISUzqD8fWRFGk= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k5pkr0ker-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 11 Jul 2018 14:20:58 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.18) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 11 Jul 2018 14:20:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++hI02YttavEhA+/d/mw8cNtQppPs54kRYRXVCfeVmk=;
 b=QxkyYUtun3mvbH67ZC3FRs6hvvUhmRTDoSDyTvIJ2MClXsLfRlKiSsGUPN4gEkIpFxbQmtd/0CNyzwx0PpPaoH0XCEPtLy4GgYpgpZTuywynHOcS4jdf9VyogkuxohXqD6u+SEhYqF6g+RqiyYOA/mAXAUOzzgPXTCqLqB+JwVo=
Received: from w1t1fb (2620:10d:c090:200::6:84bf) by
 BYAPR15MB2504.namprd15.prod.outlook.com (2603:10b6:a02:8e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Wed, 11 Jul 2018 21:20:54 +0000
Date:   Wed, 11 Jul 2018 22:20:49 +0100
From:   Okash Khawaja <osk@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 2/3] bpf: btf: add btf print functionality
Message-ID: <20180711212049.GB4102@w1t1fb>
References: <20180711032108.631367556@fb.com>
 <20180711032557.728015225@fb.com>
 <20180711121015.42873aff@cakuba.lan>
 <8887ff9a-329e-3d89-8872-4bcc16c462e2@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8887ff9a-329e-3d89-8872-4bcc16c462e2@iogearbox.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [2620:10d:c090:200::6:84bf]
X-ClientProxiedBy: MWHPR14CA0023.namprd14.prod.outlook.com
 (2603:10b6:300:ae::33) To BYAPR15MB2504.namprd15.prod.outlook.com
 (2603:10b6:a02:8e::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 280434cd-9440-48a5-1ccc-08d5e7743018
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2504;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2504;3:Xe2eKR8L+Y3ikWzDKyICdVxvLq9Y/Rvg273P+LzIHRXkDpbhmEGiv5fZ/cH54yxD9rGImLyZSoWTT9AvwUVEkCSqKsFDhAMU2IKqurI0hGi9g6FFX4T4d7dCrjvKtnVcu2fY4ULYb65FYSzls5Phf1eI1Z1MkuB4OQeFxSyQJUPoGvACfXoM6/XNEf7xASnLGiZ4uhLV+VsNdYRBLdUhtgU+YDnpRUxbp0Nexb1mvPk3qWjZjN1Bwph+zxR7qvKU;25:q/jQBKH2m9fpjg25qnZ+083pklDglLbWdURuBK9nbgJIcPbXuPGdfsyu9u6atXM1ioftI4XQS/3KDmXPdiRR6LnJXEh+3T4ldB8YEQoZ2hHuCvCT0Q47m/WGswKH/MqHMjj4mRSacSznThcaDtw5xnqBL53c4nKY4+UTXBB3lMNzoFzG1kC5YvcWM4R6xaQC5CvfuDS+sfzHjr4POAKGRH6Vjvw8RDiI9ASmFUDZxLU/UQKQ/JzX2vfc8EagtjW06mJ6Q4dD+CqO/z5A8jEgi+8dKDOTtQfCrDZUJ2/GT9RiOhXoA5oYefBKsLNCwQtVh7NBzR1L/ukqNARh26l+aQ==;31:+misNydFegYjjTelYGqXL8h7zXXmb82ubaC7qEk/vKtjT36kMV3KaO9QziHg6EuCfKDCLlCLreumzg+/Do9ziUE8b2sy/OQvVHpnY6kFA5+rynsnwRqH6wJ2yTc3Q6yTSXm7UN3SgHaUDS9qp5Dl9rpqU4hZest4oLxwAnDpoP3Sren0xiobtEj1QjlYl/bT11HUPWjpelgZeGrbjTYy6iLnnb0alifkBfFatWpV+9A=
X-MS-TrafficTypeDiagnostic: BYAPR15MB2504:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2504;20:/E86X19jlGF0d8q7TD7aQLWZQFWWXp23kJaLOryfiPE6qTJx1S5y784YXka7HUt5jRle/knViioah7xZk6yX6x1b0NUV6w02+VWojyISF3z/r/raBk3cf/B+KbwZW8CkNhiQ5S3afZWwD3kmsSj4yU9ymhAtqMXNeZtnJQAJMn+VH2vnn/p5EDsVmBug01heLtqVMd1nMU4BUjTM9H12GatwNGIBC0m09T/l6kljV8P63vLfPKldDUHOSyqAZqHkXNDIxnK73G6K9rvUj0IjGs5RSPBRXP02mmXKXka+sRXInabGEPWzlfDhWYwJGh6lctYcDe165KkmO2O9HnfL3ZFC10foFUb3PGYjd9Lh4f7LpuXidFQPclUgmxUrHuGfoMCtjpkK8WMhc1dwJkVYeFLYjgxZhcw6gs1aa1XiqsbjSWEWZUi0J1OtlT+F/3ScgwupWuzbA4XZrY4aKe/pQUL88hEMNGeo2eS/MAffhBplE1fbyEJfwhOe3BINdrXG;4:9TWNskmlnyB/LgkN8ocAVTSun0ehFZDD2+b3bay+nzXu+dwhPg2Spgyy/Z4OWEzWpSBnphixWfhbIZ/xvx/i9N25fcbU2b4oIJdlsr7Fi69M3tAaBbElFGIfxaaa/xHOXMSBeYPq83ZGURdBkVOctzKduIib+eQKw4koaJBaZUFGx1iJia+3Cy9V2eCDWNqRxdNatMbtWEnkkkTbZNktWjb2htOD6za2haXmD/xVVce00qzETU0bzTwljLyoIekUBbjrDGQ4GtEmYHkYBychQlWt4NaRfTrYN86wDMmC7k0yQ+6DdY0aNILSu5utyAkL
X-Microsoft-Antispam-PRVS: <BYAPR15MB25049639684DCE35E5E06F3EC65A0@BYAPR15MB2504.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(81227570615382);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BYAPR15MB2504;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2504;
X-Forefront-PRVS: 0730093765
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(346002)(376002)(366004)(136003)(199004)(189003)(486006)(53546011)(186003)(478600001)(345774005)(386003)(54906003)(46003)(8936002)(86362001)(58126008)(47776003)(2906002)(6666003)(2870700001)(11346002)(81166006)(81156014)(8676002)(16526019)(6246003)(4326008)(97736004)(25786009)(6916009)(305945005)(1076002)(446003)(6116002)(33896004)(7736002)(39060400002)(5660300001)(316002)(52146003)(50466002)(52116002)(55016002)(2486003)(33716001)(229853002)(52396003)(6496006)(23676004)(53936002)(9686003)(76176011)(68736007)(105586002)(93886005)(476003)(33656002)(106356001)(18370500001)(42262002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2504;H:w1t1fb;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjE1TUIyNTA0OzIzOm5TaTNqaTViNFFTckYxaE16cU02R28rSU5j?=
 =?utf-8?B?MW53S1FGVjA1K0lZN3B4eDRSRTJkV3RMQTVTQXdEVWdWbldudkZwTmFnRVQw?=
 =?utf-8?B?dDVOY3ExRVBnaFZ3UC9ScE9KNW56Z2U3N24xQVVoUHNJOHNRV2IzSDFCbGho?=
 =?utf-8?B?WTNlUCtwcUkvckpsSEE0QlNYUVM4RHU4U1RxV0lHNEpSRmpPOGR1b0g5Znhy?=
 =?utf-8?B?Uk1JcmtVZ2FIdTUyVWFRN0tuRWw0Sko4UUU5ZjluTiswaFVSN2hzY25qQmt0?=
 =?utf-8?B?dXpRa05QOUJKbXRXTHFTRlFCNERVdVMzQUg1d0lqOSsxSDZvVGg2ZmNvblAz?=
 =?utf-8?B?U3M5Nm40NTJzSitVQnFJWEN6NnVpZ1hERmR1a3ErU2YrbThpbnBGdm42WDA3?=
 =?utf-8?B?Z205Q3NCS0lnNWhja0NaUEFxS1NsNThqQ0crYmNKSHZ4dndwanVrbWJjNmlo?=
 =?utf-8?B?QktUTWhiTFpsaVdCVU1Ydm1Bam8yU0U1RkIzaTZDR004SUd2NW9rZVBSTFQy?=
 =?utf-8?B?NVBBSDFUc2NwUHhvaGVUV0xqWnd5SXJZUGg5RFBUR0s5Mkw1d0s3T0w5bmNa?=
 =?utf-8?B?NEttOFU4YUZFYUFnbzR0UzhlUzhaSGN0T0ZCdXhLMVNSeklLMFl1blRvYlNk?=
 =?utf-8?B?UjhxdDFpektPY2wraGxQNnJMRGRVc0VVTEpXejc1TjdaYmpyakN0a2tyajVO?=
 =?utf-8?B?czVYUTgxU012SVRRcU0zNVNwcFBJTFpzZ1ZzQ1IyeXFtZVc5Qms0ZlZvOTNY?=
 =?utf-8?B?QUVva1FkN3JOSHN0VzFJdTZHa2FXN05hcGl6SCttV1dWVDk2RDVFUE9SekEz?=
 =?utf-8?B?M2Vsam0wS25qWWhNWFhMRGpDMnlqVnlhUmUwOVVmT2Z2QTYwd1daeU9NZVRE?=
 =?utf-8?B?S1djN0RKbUJDaS9nV296S1hWNnJKSlYwV0h1eEdoa3pldW9va2RpRExpV0RT?=
 =?utf-8?B?RFc5c1Q1eFp5NktyUUNydmx6YnFXbzdOM3BGblZQcHo3dUl2TCtMclYya2xx?=
 =?utf-8?B?NjlTSU9yNzBPeG5VRGpuZFdadXZoR3c0UTFpRUYrZ2hCM1I4anVRMEhxOC9p?=
 =?utf-8?B?cC83MExtVytsYVRzNXB4QjhJbDJaVTUxbm9Jd2l0eHM0TlVpL3BWQ3ROcjVU?=
 =?utf-8?B?UXhMbTNOUURRemhBZGVnOXJ2SXk5N0xnR1h0ZUNxUmVicERpeDdsYlVOcFVF?=
 =?utf-8?B?b1dRRU50MlBQSWZGbGxCZkcvUHZLdUhDVjJjWDltOThzdFJ6VnRvdmQ0czd1?=
 =?utf-8?B?Ymd6cG04enRvSmhhVWE2aDZGcjlhaU1qa1FtNWQvb1dGMlhNZ1ZYZFA3L0tS?=
 =?utf-8?B?S3ZpYmsxNXVKb2tSV0kzWGc0OUloVDZLV3pSdStDSHhNTllBdkZ4VWJZQWo4?=
 =?utf-8?B?Sk5nTm9oTXRUVGRITnp0MGUwaVpKYURFTFZWOVlVa0hlMjRpWEx1bWRrTURY?=
 =?utf-8?B?YWdYbGprU3FxVXVTZzdieXQxVE5JYVRKdklLZzNZaFBiQW9rQlBmN3hka1Uw?=
 =?utf-8?B?NTBaTnJFRlRteXRNYkVDb1JlQ0hvUjI1cjBLRDFRU3RrRVV6OGRlQTFNK0t6?=
 =?utf-8?B?bjVNMU1LLzV5UDlVV1gvRFJiU0lNUnVpTVZzQWZlQjl4V0hLN3d5RFF3Tk94?=
 =?utf-8?B?aTB1Z3Jadkw4U1FMN0sxOENiWkdxWC84NlpGZ1FlWFE3amVvZ3JFRmRKd0E3?=
 =?utf-8?B?eTZpUitXaTBibXhOdEprWXo3a1BlL2VHY3FlUEYwL0ZCbWNDVFg5R2FtYTJN?=
 =?utf-8?B?TGdWYXBvaGQvNnhVaytJSFZPYVNoTE15ajN2d1dRaWZyNmd3RlFYNVhtNVR4?=
 =?utf-8?B?NjVBUlYxckdhZ3V6RGZvTm1wU1JyMTQ0NnJsMEh5ZVcveHZtWGk2Qk9rZ0lj?=
 =?utf-8?B?cDJXY3hhTTlwQUVqbDR1dndnVng0SDNLUVBjM1VCbkxxOG5ScUV5S3piTmJn?=
 =?utf-8?Q?mQXj/bIANOi60BTYT+JLjo6bmFIaN4=3D?=
X-Microsoft-Antispam-Message-Info: LzZTW2HmdziPAlyiYh0jklq8R6v2IghjVICpgTECKcb/IZrWZT7krpMLRMVar87yopMRI0s8GsMJ23t60DHWNvfzLCT96wd7afCk1Wuvr9D3rGHbyYzxs9J6tSHM8p8yn/T/OaPDVjt/Br93vYDqT/m9/O/5mg9bfRJwEaBrD6+IaRADwhpqQSr0wQnfJGEHPcaJ7HZBZK8UbkSiFxUhO3S2Y88W9oOucsAnUvUB5/YW4mC9Ks7Bj59mEzg6CFVetWeMfLxWU7gCmbcZY8iLfIM1u1H3DkebVsuaD6I6l6mt2RUaIdISFYhW/gWsEtH+P9u0WI8734onei1mQl54xMsAWHfw4UpwT2sigLEMU6A=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2504;6:wvE+JguAZrTEehyolxq1kp04lXtmSl4ytLfB4z9DCeGRp00CyedB5YzIy4TCSDKnnHSQUs6JKBHOJdO24IigGSV0CmRZ+4hRYasrOZWGN8kziPXhrk27oaUEDUnLRWBUeGqyRm32S2KgofYssYDS9aiTPStFYeQLC+mzftmVOn17mPvcKsQJEWZHktKXIfc+pi4np07wJxXMK2ibN1SMGGVve/A2X9Et9joUs+B0wBWM0sMxjUh/tw4BND1OVx46EmKOGmoxSmNiDf2epahmBX0hQ1RNC960g20VVQCLHhvbQBu9E1GqWYmBKCJ4rHFqwNu5MOjy8u0sK6vT+Mq0pPQ2r1Fgcna1H3xj7cpIrSUfztx66jz57bl1JDFiJD2lAP79ly3T5+NdHTts8wDvdR44Qzc7Vy2azka31WZ2GRK53pB9PKwIBk4/kQsPrEfQ8bITSLBephzBfF0WLYpu1g==;5:RysQjRqx/14J1/8AQNb6y3nrbb4Gd78PTux0M+zBRrzb6TNQSqnSgNTB5GJWvNGtSLOxOBev0ubuyNzByglzbpLqgGe1Knglhxe045u1jzY4YhpHyiXq+vhTmdgtu446Fbj9fBTRDvA1+kaCKRJYq3GRZfpRIyC++OeJcl87anc=;24:Be1lfiJdzvGt+8z2iT72/l9HMbb0Im4sBP6ptXAh7Y1Mh7IZsE3ComG2ijCdZo4CG+O9ee7bHCvr3RwWyEQ3jJlY5uEhSfw9J6OwpJk+tEs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2504;7:tV66LZKf6tQjyavFLkp8Qf80NJ+JQvbQ4eBE6IKKq3z/e4uR7T5IVb0ZsbgYTomwp+dqZsMYO2jJRERaxZs942o8P1fmjGDRk7TMwGYUhc2AEtMHMnkWbUDY8eaBpxJD40huLiG/AYQvhgPlIMZtY3meOA3MXP36ytVxVqXREkd59XHTSYtC7G8C7yTSxKpgfn++UfT08WKTRbXVylRkzi8QE6zYTRHa4UjDzhxfVK7idHT30doQ7osrd5IhsnYd;20:uNHoAzGViAqlLnLjGdbnHiPIIk7Tfg+fu/wu3uvMlLL9LgQvZqhFwfRrvA7MNYPl2we6kMaOZzf9+4bfuOZYlcliAm+Gw+Em3alR0XHzzxIHYYrIJfDfkdEgZ8s0wQpB402G38jUMfmnofL97VS0Wzrgj8m2yl9NVzTiSRqLABM=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2018 21:20:54.5167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 280434cd-9440-48a5-1ccc-08d5e7743018
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2504
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-11_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 10:08:35PM +0200, Daniel Borkmann wrote:
> On 07/11/2018 09:10 PM, Jakub Kicinski wrote:
> > Thank you for all the changes made so far.
> > 
> > On Tue, 10 Jul 2018 20:21:10 -0700, Okash Khawaja wrote:
> >> --- /dev/null
> >> +++ b/tools/bpf/bpftool/btf_dumper.c
> >> @@ -0,0 +1,248 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/* Copyright (c) 2018 Facebook */
> >> +
> >> +#include <linux/btf.h>
> >> +#include <linux/err.h>
> >> +#include <stdio.h> /* for (FILE *) used by json_writer */
> >> +#include <linux/bitops.h>
> >> +#include <string.h>
> >> +#include <ctype.h>
> > 
> > Again, please sort the headers the way I suggested.  Otherwise as the
> > list of includes grows it's hard to know what's already there.
> > 
> >> +#include "btf.h"
> >> +#include "json_writer.h"
> >> +#include "main.h"
> >> +
> >> +#define BITS_PER_BYTE_MASK (BITS_PER_BYTE - 1)
> >> +#define BITS_PER_BYTE_MASKED(bits) ((bits) & BITS_PER_BYTE_MASK)
> >> +#define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
> >> +#define BITS_ROUNDUP_BYTES(bits) \
> >> +	(BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
> >> +
> >> +static int btf_dumper_do_type(const struct btf_dumper *d, __u32 type_id,
> >> +			      __u8 bit_offset, const void *data);
> >> +
> >> +static void btf_dumper_ptr(const void *data, json_writer_t *jw,
> >> +			   bool is_plain_text)
> >> +{
> >> +	if (is_plain_text)
> >> +		jsonw_printf(jw, "%p", *((unsigned long *)data));
> >> +	else
> >> +		jsonw_printf(jw, "%u", *((unsigned long *)data));
> > 
> > Again, please drop the extraneous parens. 
> > 
> >> +}
> >> +
> > 
> >> +static void btf_dumper_int_bits(__u32 int_type, __u8 bit_offset,
> >> +				const void *data, json_writer_t *jw,
> >> +				bool is_plain_text)
> >> +{
> >> +	int left_shift_bits, right_shift_bits;
> >> +	int nr_bits = BTF_INT_BITS(int_type);
> >> +	int total_bits_offset;
> >> +	int bytes_to_copy;
> >> +	int bits_to_copy;
> >> +	__u64 print_num;
> >> +
> >> +	total_bits_offset = bit_offset + BTF_INT_OFFSET(int_type);
> >> +	data += BITS_ROUNDDOWN_BYTES(total_bits_offset);
> >> +	bit_offset = BITS_PER_BYTE_MASKED(total_bits_offset);
> >> +	bits_to_copy = bit_offset + nr_bits;
> >> +	bytes_to_copy = BITS_ROUNDUP_BYTES(bits_to_copy);
> >> +
> >> +	print_num = 0;
> >> +	memcpy(&print_num, data, bytes_to_copy);
> >> +#ifdef __BIG_ENDIAN_BITFIELD
> >> +	left_shift_bits = bit_offset;
> >> +#else
> >> +	left_shift_bits = 64 - bits_to_copy;
> >> +#endif
> >> +	right_shift_bits = 64 - nr_bits;
> > 
> > Please include <asm/byteorder.h> as I suggested to you previously.
> > This is dead code right now, look:
> > 
> > $ git diff
> > diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
> > index c64465094b92..045add07b721 100644
> > --- a/tools/bpf/bpftool/btf_dumper.c
> > +++ b/tools/bpf/bpftool/btf_dumper.c
> > @@ -91,7 +91,8 @@ static void btf_dumper_int_bits(__u32 int_type, __u8 bit_offset,
> >  
> >         print_num = 0;
> >         memcpy(&print_num, data, bytes_to_copy);
> > -#ifdef __BIG_ENDIAN_BITFIELD
> > +#ifndef __LITTLE_ENDIAN_BITFIELD
> > +#error "abc"
> >         left_shift_bits = bit_offset;
> >  #else
> >         left_shift_bits = 64 - bits_to_copy;
> > 
> > $ make -C tools/bpf/bpftool/ CC=gcc-8
> > make: Entering directory '/home/jkicinski/devel/linux/tools/bpf/bpftool'
> >   CC       btf_dumper.o
> > btf_dumper.c: In function ‘btf_dumper_int_bits’:
> > btf_dumper.c:95:2: error: #error "abc"
> >  #error "abc"
> >   ^~~~~
> > Makefile:96: recipe for target 'btf_dumper.o' failed
> > make: *** [btf_dumper.o] Error 1
> > make: Leaving directory '/home/jkicinski/devel/linux/tools/bpf/bpftool'
> 
> You could also easily test this on s390x (big endian) through a LinuxONE
> test instance, this is how I usually test changes related to their JIT.
Thanks. I've been using MIPS qemu set up. This will definitely help.

> 
> Thanks,
> Daniel
