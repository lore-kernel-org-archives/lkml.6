Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97F7C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EEE020837
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="RH2BzJtV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="RYq6JkwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EEE020837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388742AbeGKVZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:25:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51392 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732301AbeGKVZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:25:12 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6BLF5tK012378;
        Wed, 11 Jul 2018 14:18:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=facebook;
 bh=ixUeKsrABRAqyrWuhWj9LjaAlDJsZgYaO0M6KxgzGek=;
 b=RH2BzJtVrH1sO0+oHqzzeFiedkEsC2mlT8HDio5lDJ8RAhAAuh+pMxSt3AFtnDWF+Q3A
 AljlmL8yt7AQxoa6hkfvmL51FHthpyvXixQG6e638YESh1OuqQXTW8set15UZjLbJL0l
 mZe+7SK4jM3nFGzss1Gu+gz2xkZTVq2RzW4= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k5r2y08w4-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 11 Jul 2018 14:18:35 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.18) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 11 Jul 2018 14:18:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixUeKsrABRAqyrWuhWj9LjaAlDJsZgYaO0M6KxgzGek=;
 b=RYq6JkwSqONRERraeaEmvJ9vv/FXZTdmU6s1ZqktVwFU2nW0DtPq7YRMtUBpbwStfO3BO7wNOoaKIRc/5eGY2hJ1yeAtx/Xv9s4UnM+X4bVF46aEAy2Pdi9Dd87L8yRAH+jvcaDJOGmG8kwnd7DHvs0hTTE52y1AZidFC09KinQ=
Received: from w1t1fb (2620:10d:c090:200::6:84bf) by
 SN6PR15MB2512.namprd15.prod.outlook.com (2603:10b6:805:25::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.20; Wed, 11 Jul 2018 21:18:29 +0000
Date:   Wed, 11 Jul 2018 22:18:19 +0100
From:   Okash Khawaja <osk@fb.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 2/3] bpf: btf: add btf print functionality
Message-ID: <20180711211818.GA4102@w1t1fb>
References: <20180711032108.631367556@fb.com>
 <20180711032557.728015225@fb.com>
 <20180711121015.42873aff@cakuba.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180711121015.42873aff@cakuba.lan>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [2620:10d:c090:200::6:84bf]
X-ClientProxiedBy: MWHPR0201CA0081.namprd02.prod.outlook.com
 (2603:10b6:301:75::22) To SN6PR15MB2512.namprd15.prod.outlook.com
 (2603:10b6:805:25::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd0b8c87-ab95-411e-ac62-08d5e773da46
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN6PR15MB2512;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR15MB2512;3:Z/s+lBLbueofA4TbgzYqOedf52NMEgSEdAqjW2cao3A28jd1nnbWt/spjKKzvf3kLUIdynAuT3T3mi958lfer9tHaCzUrbpPMPXZ7gU1toYueoPOM+YV0lU62nhUpdobUCj9lJt4yQTRhYVAaRILu9GnqgFYEvjsUiRk/6aL1Zh5+O7qAp2oJkJ78hqxQoMtHNu4d6Ic54C+B9uT0KR8Fsoxkg0Ia99DGvzgIXX4Ski4/mtSHjKtYPXR9sC5Gkjq;25:ZR98n/fhjyNqub0Qzcl2EtkBA7FyTXSGNEGGlz+q6KJ7kkVzPiL5mdBn5Qd4stcjj2Jz0T6vG/NEDUIV2L13vOtYf/iHT4JpNiRzMNO5nABtP65P6FJVNFs9zgfkmrkVjBmOjQZQXdg3a87/nTG7NPz/3s6JyiTyLIUf4gSlzyLsErUMzpMJ8cYoWxyLnGk4KCe1xfveqnzLhDalYFo9AsQJ/bnm5bbI0/F2tWJ6P4B2bbkzhTiMwbUMXjeeBB1SY/VJ1+oe6vnsS8UzQzFk5Lq27pCTU0u8J6SMrYr2ZUYajlSLTW7SLz46+DzXI/dfCcR6Cum2Cb+n3y7r25bO4Q==;31:+o7+1wk4s3ZDYr8v50w/tGPvwH59Oo1kXgFR5p/1w7MXzv4nXe1Vhp/vp1e85p5OZX6D75ZodEtPvOuQPov7yBKLRJNmIAgyDn51sJStrBkdLGqPwD9W8GEOGqidNCFEhaj//IXEEjQqE8V3XNJn0GM+TraZqdgaG17p7Semvckqr0XiQytgogJOHhkeExrJDKuKa7VNPgK89sgUK8VyGvh/ZIiKkNDBRyNPqEOXoEA=
X-MS-TrafficTypeDiagnostic: SN6PR15MB2512:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR15MB2512;20:Dmnhy7jtc0SJr3BXs9VXl+zXtt3n/XXQwZHdLye3WAko/zVTUb3v6K++gs+cN0wxtCiQmGf/ecpT7nLYs4TUGb9MIOQgM64JB54MqInQhAjswxA475ECqe2NSGQSH3BA3Cay110ytn/PAfJF5lFN0zgMyoB58uhfRmw+6gRBNHzjRPjTsS39EPk+HXns5dDQDw7vTb7nKgWEHv3SSr94Kf2Ny5aKnMOs84pwTwEqe9cUG+DTrpmPGUjZCEZfNYMkGp/AkJUUiRYqwU5FwMu99ukqwGeEqXbjMAzQvJ0RMGMbBH04f20VXOgli01Va8n+rpabxtGwl1/Pyo2OZyOD22QhgqFPZf2FjgEC1ixGzCY35T3Vm+u/yAhbxKDqJAU+SnS5pIbxrTfLQ1KeQLOtlbk2awP0wnygBYNPpOmTv+F7IPAQLVr87Wm0Wlho6iB1kydUcBgh8oixWq2b1/Ogz/zcOwYPxTsgsPCQkfiiOylrW3p/rjw3h9piTEXYQAJq;4:fFmJkfGgqEonjlu/6AlNp6LMizR9ie5EpVTBjtDgpb84R2bFlMUK1wg86N49/me3ElW4j0A0J1eoC8QVWeKbG0MDaC5UU+SHB6u/h933bqGFN0hDAEVqPkkRVsrdQQZtpwpYoMfb/I2v/ikJsdTGfLBfmwma6M7nY/G0A5VUo8rXgX7LXgXWOj5qHLsDsJvzCIbCJmMQHH5DJBCzTHg9D2E24eAifWOhL+ut76hbKQ1K2ubGVv2AjphJsYUNVHKut3xBwvSEPqofavW02qOwoS/QcMyIOIEmlrEuBw8FduqfJX5ASBglikU9jgXYitdo
X-Microsoft-Antispam-PRVS: <SN6PR15MB25125DBF17DF7C1173E3010DC65A0@SN6PR15MB2512.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(81227570615382);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231311)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN6PR15MB2512;BCL:0;PCL:0;RULEID:;SRVR:SN6PR15MB2512;
X-Forefront-PRVS: 0730093765
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(396003)(39860400002)(199004)(189003)(386003)(54906003)(58126008)(6116002)(1076002)(7736002)(478600001)(305945005)(106356001)(105586002)(25786009)(8676002)(6496006)(345774005)(16526019)(33656002)(2486003)(316002)(52396003)(52146003)(23676004)(81156014)(81166006)(2870700001)(186003)(8936002)(76176011)(476003)(68736007)(486006)(11346002)(446003)(86362001)(46003)(2906002)(4326008)(53936002)(6666003)(97736004)(52116002)(33896004)(6916009)(50466002)(5660300001)(33716001)(55016002)(9686003)(6246003)(39060400002)(47776003)(229853002)(18370500001)(42262002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR15MB2512;H:w1t1fb;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjE1TUIyNTEyOzIzOk41NHBUNU8zQmxQWHc2RXFDUzVkVExOWGFi?=
 =?utf-8?B?QjIrVTVFNmo3dm1GN2RtdXVwZVUra2laN24zV2oyV0kra1J0cTlxeW5xWThn?=
 =?utf-8?B?OVhvclVMTm5YbXhuSmYyWDYyWkRoTUEwaWRQcGlhSVBNMlVwTGtuRWozaVc3?=
 =?utf-8?B?aUtxWFNtc0IvNXg4Mm41ODUwR1owQ0ZWT3orcjE1dEM0bWlhbnNsdEQ3MTNi?=
 =?utf-8?B?RnB3K1ZiVFFLdk9uNzZjMzlucVNXb1o2V3F4b2E4VFhZbnRQMEd6OVh0aUFV?=
 =?utf-8?B?RVN2VlREQXMyb3dvL2JrWEpveTdaKy9RSkFxQ1lNQkY5cXUvL2J2NGdPL0VE?=
 =?utf-8?B?ajN2c0sxK2Z0ZXZLTmRMTzNjV25RaUJpYVpBYmswSExjWVlvOW04SlpCS0Vu?=
 =?utf-8?B?Zkh2WFFybTBma3JJdUF6R1NWeUVkK0pzT1REVy9BcVo5NS9keHRxeHBxMjFO?=
 =?utf-8?B?aXZzUjB1VnlzYU41ZFVBR1BlRThYWVBJMUltZGkzTEQrUzRMczhFMmJhT3RR?=
 =?utf-8?B?T24rZWJSb3ZPWHJ0NXNhZ2VSYnN2RERwUjhYQXNmMGRZTEg2UThoalJRQkRL?=
 =?utf-8?B?WFhjODZteTdnaGxYbEtXSkt1YW5WOTFUaDNXaHZvNlVzUWdnWEp5M3RSWXds?=
 =?utf-8?B?S25mOGZxQ0tmQno1b1VITURIaEdRcWZxU2Qvbklkbk42bXRpL1kvMUdOYWp2?=
 =?utf-8?B?WnUwNWhFMnFMZ3BDdXJLQ2N0b0RjTktVY1ZYUk9GSmxKaExtVzcxM1FsKzdE?=
 =?utf-8?B?OFFsM3czVXkrd3E0QytRTU4wTko3czdzMG5DRjF2S0tjU1hncGVCblNEVGdi?=
 =?utf-8?B?dUZQUXBRV21KVzFRMGowOGRkYjAxOEpzbmV5eXhSSEpzRldxVFJGRXcrQWVF?=
 =?utf-8?B?LzdldmxXeGk2U0FySXozR3FpRWNOSStTbEQvelNjemtBQXhJb25xeEhxNFZv?=
 =?utf-8?B?RGRnT3VOM2dvWXoxcm9ONzVvZUJzb2VmTWlqL05paEtVY095dGZkU213RUpJ?=
 =?utf-8?B?ODhKNEwyYS9SRW9KNXM0Q0Q2bkFqY0pDSGdLSlZLcXNWRnlBelJ5REpmV20z?=
 =?utf-8?B?Z01uamtVQXdjMEJzUnpoZWRJamF5QllpOXV0TnFtYXF3STJDZlloa0hZVWJp?=
 =?utf-8?B?NzY3akhRRXpjYmlnUnVtRzJmWU1UeFRJZEpoUlFldlF2QlJoU3ozYXh3SjBu?=
 =?utf-8?B?bWd5Wlp1Y2w2UENaVFgxeFppcGhGRU9GRGVpVVJ4K0doQTdxeEhkUldEMjdY?=
 =?utf-8?B?VHVhVTdVb2NDMThYcnJnYXFJVHJpbVJKcFY4cjAyYXIvaVVibUFvdjBBT2pv?=
 =?utf-8?B?SkliUVd4NVFyK0U1YmkydGVsV2Z6TFY5eXN4NSs3T2NwdS9mVDZwUFA2cWM1?=
 =?utf-8?B?QkR5RkZTaFJVVjVNb1NWVmN1RW0wUk5uZFpBaXEwNHVKZ25MOEdEWmUrbXRC?=
 =?utf-8?B?NWs3RWE3RWhMbWs1WHBQVEJCeWo0Q0V1U1IrV1JtNDFCNkhudVQ2RlpEUG05?=
 =?utf-8?B?Z0ErYmFqTXkwQmRXNURlYUNoaUYrZ1U2YWxRNmVQYW9SVW1sVVBnWWlheG9p?=
 =?utf-8?B?eXUxU2RjZ01DSUMrZ3NHVTFOVTQ0REJNL25IcWZCT2phNlJsOGRSSkhYT3lY?=
 =?utf-8?B?dGpIa0E3T3Nyc1QvVFFvMmxiREhDU21VaGdRbFB0VGhlWGpQZFoxd0s2M3pL?=
 =?utf-8?B?TWM3dCt1MG5Kd1BMaGwwTGVYaE9IQk1VZGwvYjY1SXdwYU82RHJFOFFPTEx6?=
 =?utf-8?B?anRRazE2akM2NzZuN2FVanRkdFI2bzZpdTJ3amFOclU3eU1LUWFFZ21mUzVC?=
 =?utf-8?B?L1lJS01KY3hjY295RTR5eFlrK0pMWDJ3NzRRdmw2NDg3VkJPYlExOWE5dEpi?=
 =?utf-8?Q?Bx/YtaUwMrtx7/iyzk4kpV+9xmAhMsHQ?=
X-Microsoft-Antispam-Message-Info: o4UfCWtyC5yGEFx39n3g6sTE0MxDv5wZZWsXQIdnZ1i/CCB0+xpZqtr2XwAEyLmJRalpqb+Fjbdt93n/tDO55r4BnQxGLqyVG8u+g0gHlWoaSRnqEcZipcS9fuX4rJM5AmBBz4H48t1Q5LwDDISZa/08nucrQ2bdXYKNS5rF1DYnwv5bdZz8KwQsfJYk4sfk7cUI+IjXUzKACUycsjAkmZ9RI8zK8lTGh3YqGNxpWGdPY9w04Fn2vjBLKWsOQOe/zGb2cI+RadIFdBrUBDqZiqjLkaIcZ+8DH+nQ2YZ4beKGI1mxAZSaTr7yfS4rc99zHBhMA3TbSijX6ezkQ/1SF5ythTGkh8Hx309PqriS9r0=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR15MB2512;6:EQ/jFW9SSOeQS7pzLbMOSd2yvGuxn2mN+QRSYYPMYlpu8rv6Wo9UTOVIW+T/X6N2zIv+PdfL07MBzB7AAXuJ4MK/1EYlY1mbP6m+cqzjWUfRSZ9td3eoTARw3bLV8vp9P07VHMZHeZR+nLDzo3+pmWK0V+5FqOSccWfUlo/K3RvqA1WuvjGuTE1TjT+Z2koqMCr/wkxD4Qegvnuhu0IVwB+v+Gp7m3bFXACZhlIm1WLxWOC6W8LTnnGxvGgRPEk1SzdYplIrK2D8GUDSkH/khqLiT0CBMQ8L/5NWlG4r0jwMZc/Ed9YavPOP1bRlZlvUpMWWhEKAdYitvIzrNBPJPFKBzaoUQVdLgXPpaBiAuTGoZ09PsdYtr51fHEzQW6sYlW+CuKjyvFw+8kYTBPgNLQPcORS5Adpkn0iBVFp6l+ULKpSJs1wenmeb2U9nxR8juoZwygew7eJOsobhoqKbDQ==;5:L4Ox+rxPghQIJs37VMay1chZRNIiTS3IhfPRawoRpMCP0CdhHUkRS/UFYdTLlSAEQKnyKlRSxOTOGVbk/Zb+K1TGEp5rI9UFbMQ/MukjoM+11RCbyau+fYbrbkL9CdCRTotcPtqsI/72ELlTWUSJWpdlp112Zu8/3gznr9/S6CA=;24:J6+x0Ax5A+LYmKhlL+k85dEsnf8F2vhqZPA8mMZQKfXdn97WA8wV6KU+VA0nIoy2+XrSiLNO1QDK70cTTE2kJOlRscG2yYTMqpuQs2n3llY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR15MB2512;7:gMkcOqVVpWTQZHWr84bp1yDx6sb4wDRmlefO6MI/L9Ike0KMykaHoEGcoVxorXd7RNrzqISjaEZ4cvxErehBkRb71CcV47hkF5T4t8K0rG7O/LKKh1OkDQPcMiCMpcOk5va2i3iLJ3BLRT/Ya/dFtAdsO1k+t4k1aosdnbSKsGQbZ/DAkjFy9sNPIQJTX9xibD6LPH/kDoz+vsVTzX3ZiuINy1yfcKE4lG3JgRZJNbZnm681TVcrugHO8u0wqz7k;20:1lf3h0xZrb+OIP6GX3MH46Z7p2EKg1hkycSBRlT8gsQ8524pmV6temPwHxR6rsNej8rScaRgQ3jfvHNQvR9RduBoX1L4AgO0aMRkAhxBl6/FfiJcgAQ02CSHfSmMfECqzXROmNLzjXIkpEKmFa8v1LELOmu7s3g5qGaJgc4HekI=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2018 21:18:29.6175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0b8c87-ab95-411e-ac62-08d5e773da46
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2512
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-11_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 12:10:15PM -0700, Jakub Kicinski wrote:
> Thank you for all the changes made so far.
> 
> On Tue, 10 Jul 2018 20:21:10 -0700, Okash Khawaja wrote:
> > --- /dev/null
> > +++ b/tools/bpf/bpftool/btf_dumper.c
> > @@ -0,0 +1,248 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2018 Facebook */
> > +
> > +#include <linux/btf.h>
> > +#include <linux/err.h>
> > +#include <stdio.h> /* for (FILE *) used by json_writer */
> > +#include <linux/bitops.h>
> > +#include <string.h>
> > +#include <ctype.h>
> 
> Again, please sort the headers the way I suggested.  Otherwise as the
> list of includes grows it's hard to know what's already there.
> 
> > +#include "btf.h"
> > +#include "json_writer.h"
> > +#include "main.h"
> > +
> > +#define BITS_PER_BYTE_MASK (BITS_PER_BYTE - 1)
> > +#define BITS_PER_BYTE_MASKED(bits) ((bits) & BITS_PER_BYTE_MASK)
> > +#define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
> > +#define BITS_ROUNDUP_BYTES(bits) \
> > +	(BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
> > +
> > +static int btf_dumper_do_type(const struct btf_dumper *d, __u32 type_id,
> > +			      __u8 bit_offset, const void *data);
> > +
> > +static void btf_dumper_ptr(const void *data, json_writer_t *jw,
> > +			   bool is_plain_text)
> > +{
> > +	if (is_plain_text)
> > +		jsonw_printf(jw, "%p", *((unsigned long *)data));
> > +	else
> > +		jsonw_printf(jw, "%u", *((unsigned long *)data));
> 
> Again, please drop the extraneous parens. 
> 
> > +}
> > +
> 
> > +static void btf_dumper_int_bits(__u32 int_type, __u8 bit_offset,
> > +				const void *data, json_writer_t *jw,
> > +				bool is_plain_text)
> > +{
> > +	int left_shift_bits, right_shift_bits;
> > +	int nr_bits = BTF_INT_BITS(int_type);
> > +	int total_bits_offset;
> > +	int bytes_to_copy;
> > +	int bits_to_copy;
> > +	__u64 print_num;
> > +
> > +	total_bits_offset = bit_offset + BTF_INT_OFFSET(int_type);
> > +	data += BITS_ROUNDDOWN_BYTES(total_bits_offset);
> > +	bit_offset = BITS_PER_BYTE_MASKED(total_bits_offset);
> > +	bits_to_copy = bit_offset + nr_bits;
> > +	bytes_to_copy = BITS_ROUNDUP_BYTES(bits_to_copy);
> > +
> > +	print_num = 0;
> > +	memcpy(&print_num, data, bytes_to_copy);
> > +#ifdef __BIG_ENDIAN_BITFIELD
> > +	left_shift_bits = bit_offset;
> > +#else
> > +	left_shift_bits = 64 - bits_to_copy;
> > +#endif
> > +	right_shift_bits = 64 - nr_bits;
> 
> Please include <asm/byteorder.h> as I suggested to you previously.
> This is dead code right now, look:
Sorry, should have checked ifndef case. Will fix. Thanks.

> 
> $ git diff
> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
> index c64465094b92..045add07b721 100644
> --- a/tools/bpf/bpftool/btf_dumper.c
> +++ b/tools/bpf/bpftool/btf_dumper.c
> @@ -91,7 +91,8 @@ static void btf_dumper_int_bits(__u32 int_type, __u8 bit_offset,
>  
>         print_num = 0;
>         memcpy(&print_num, data, bytes_to_copy);
> -#ifdef __BIG_ENDIAN_BITFIELD
> +#ifndef __LITTLE_ENDIAN_BITFIELD
> +#error "abc"
>         left_shift_bits = bit_offset;
>  #else
>         left_shift_bits = 64 - bits_to_copy;
> 
> $ make -C tools/bpf/bpftool/ CC=gcc-8
> make: Entering directory '/home/jkicinski/devel/linux/tools/bpf/bpftool'
>   CC       btf_dumper.o
> btf_dumper.c: In function ‘btf_dumper_int_bits’:
> btf_dumper.c:95:2: error: #error "abc"
>  #error "abc"
>   ^~~~~
> Makefile:96: recipe for target 'btf_dumper.o' failed
> make: *** [btf_dumper.o] Error 1
> make: Leaving directory '/home/jkicinski/devel/linux/tools/bpf/bpftool'
