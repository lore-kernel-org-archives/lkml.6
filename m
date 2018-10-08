Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEB1C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9F9214FF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="fsw0sYqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9F9214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeJIBLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:11:44 -0400
Received: from mail-bl2nam02on0099.outbound.protection.outlook.com ([104.47.38.99]:43453
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726391AbeJIBLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBTQe0ajDBKMAbR6TYMkwyP75lKlGV651ulxmn9SWVo=;
 b=fsw0sYqkXcktNie1BFw/jXqNEL4r5U/JnCNLn+eRZy12D8yZlWs20bqSmrV1tyoD+9ZfP6c99n/xEDCFRoBMNCh7PAtmgU3EN+7MRSmC2GNzuh8kZIEeZeNsD490gohF+gtRdlxbnfyb1p89gJs1mOjL5GQZhbib0iDRzFbzezU=
Received: from DM5PR1301CA0011.namprd13.prod.outlook.com (2603:10b6:4:2a::24)
 by MWHPR13MB1423.namprd13.prod.outlook.com (2603:10b6:300:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.18; Mon, 8 Oct
 2018 17:58:46 +0000
Received: from SN1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by DM5PR1301CA0011.outlook.office365.com
 (2603:10b6:4:2a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.9 via Frontend
 Transport; Mon, 8 Oct 2018 17:58:45 +0000
Authentication-Results: spf=permerror (sender IP is 160.33.194.229)
 smtp.mailfrom=sony.com; HansenPartnership.com; dkim=none (message not signed)
 header.d=none;HansenPartnership.com; dmarc=none action=none
 header.from=sony.com;
Received-SPF: PermError (protection.outlook.com: domain of sony.com used an
 invalid SPF mechanism)
Received: from usculsndmail02v.am.sony.com (160.33.194.229) by
 SN1NAM02FT011.mail.protection.outlook.com (10.152.72.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1228.17 via Frontend Transport; Mon, 8 Oct 2018 17:58:45 +0000
Received: from usculsndmail13v.am.sony.com (usculsndmail13v.am.sony.com [146.215.230.104])
        by usculsndmail02v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id w98HwiVW010675;
        Mon, 8 Oct 2018 17:58:44 GMT
Received: from USCULXHUB01V.am.sony.com (hubs.sonyusa.com [146.215.231.15])
        by usculsndmail13v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id w98Hwi9Q019186;
        Mon, 8 Oct 2018 17:58:44 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB01V.am.sony.com ([146.215.231.15]) with mapi id 14.03.0408.000; Mon,
 8 Oct 2018 13:58:44 -0400
From:   <Tim.Bird@sony.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <ksummit-discuss@lists.linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: RE: [Ksummit-discuss] [PATCH 2/2] code-of-conduct: Strip the
 enforcement paragraph pending community discussion
Thread-Topic: [Ksummit-discuss] [PATCH 2/2] code-of-conduct: Strip the
 enforcement paragraph pending community discussion
Thread-Index: AQHUXbzsST+hQw7zT0eB3iy5jbswn6USvpZwgACmBYCAAfY7MIAATdkA//+/s3A=
Date:   Mon, 8 Oct 2018 17:58:43 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF80518843@USCULXMSG01.am.sony.com>
References: <1538861738.4088.5.camel@HansenPartnership.com>
        <1538861851.4088.7.camel@HansenPartnership.com>
        <ECADFF3FD767C149AD96A924E7EA6EAF80516F31@USCULXMSG01.am.sony.com>
        <1538883209.4088.14.camel@HansenPartnership.com>
        <ECADFF3FD767C149AD96A924E7EA6EAF80517411@USCULXMSG01.am.sony.com>
 <1539007780.4344.3.camel@HansenPartnership.com>
In-Reply-To: <1539007780.4344.3.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [146.215.231.6]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:160.33.194.229;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(376002)(136003)(346002)(396003)(2980300002)(448002)(13464003)(199004)(189003)(51444003)(7696005)(336012)(426003)(85326001)(436003)(2486003)(23676004)(86362001)(47776003)(50466002)(33656002)(4326008)(26005)(102836004)(478600001)(486006)(305945005)(66066001)(7736002)(11346002)(110136005)(476003)(446003)(356003)(246002)(14444005)(126002)(2876002)(6116002)(55846006)(106466001)(3846002)(316002)(2900100001)(2920100001)(229853002)(93886005)(72206003)(86152003)(5660300001)(8676002)(2906002)(8936002)(76176011)(55016002)(6246003)(186003)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR13MB1423;H:usculsndmail02v.am.sony.com;FPR:;SPF:PermError;LANG:en;PTR:mail.sonyusa.com,mail02.sonyusa.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT011;1:fGSiNAgU1h9+K+RoqlIYIbEPZynHfcIsKAhlQyupGJ16LOBSFpfSXcZs6ei37l5aGx9ptwKvPee86445N8I3Xb/m5ZTlnTAc/yQBzOB8foFIcK3WXYam4exKkf8wzuB+
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 784691b1-20cd-4cf1-c8e2-08d62d47b11b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7193020);SRVR:MWHPR13MB1423;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR13MB1423;3:T9MxJ6pxH6AxRyepbOZqVdf6N1VFxLfma4ZACcvmI68wPcnf2J3i54R5lnThRu8mipzD0cl/XfaaxbfRd76C72tukOU3HJBHQT0xrb2sRbG+1M4bGhe2h5cFCd8bCmjJlkVr75JuKgT8dJXtResQb/+RjmxsEjtnbdb9cADW5NFZBWCsqxkZ9Rt1TBIUKWkMYtXI7tA8oXS9rRQDpydOgqnW1NUVU/XEu9oofNTdq+pT8mZ4eFhDrnch7CztZp9Q/e3YmvxE3nNtmdNZWkpSD1TlUxnn6IJGTAS1nfzUsmBUFCMHFQL2MmY7EcKILEd6NfEE75TixCQ//lH9XgX/+fBQGIynJtfKeVsb2Z3RuG8=;25:OW79a0Ws5zqCRQ0vKo4IQ6CAUT77RsjzfPF9AC4DTizWK9cdBeogCd4j3gv4ipKP3ENWPen/nTHmipbB81ODkTegTYZ8KBab/WLnef2oxIPt4ebFTWL4InkpS2kO+wTcmPAbU3DRlW9t8ZGUeqX4E7l3z6lXcg/Uu96/f02nEzfkyA3i+yu8RQk3nfZWmlpmtU7oexhhov7a6L107U9qkO3OZbA++kESYVPSLvp1e+vDQFfP+S+YsgG9Hst4r9czbLJO1QbLFqsneKF3ACTth+QHAYI1qNVx07wCvnucjmo16Jx9aejBRl5YGtFvxy0cdrxmxpNvAMA8x7ZS5JOYRA==
X-MS-TrafficTypeDiagnostic: MWHPR13MB1423:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR13MB1423;31:HZKg7WYSXX1P9kP+mGonhBpCLhcSoH4il4jVO+bHDjTnwHeOxTtPrllcKdLIGakmG3qGAGurYuZPiGM+wGoSQBuxXN+dZoxMjL+6oAM50GDhNOZkKdxlbBGSUVQorSoxBLH2lJWwA/WtraGA+K43EU04R0+9xo3mttBC30FW6PJhFfx+b9cXV/xMl953KIwVKs94iEf9QOKK7e3lwhRObY5j7vqxfvd9B9jnp7/5wYY=;20:b0f6FWihzchxWdV9MYGvfzHefslO+SxlCclgDN/s4JuTXSe0SeCS0QwkI7jgE+U1HUuNVl6Blb5Ok+NuVwBnauIUr1cODU4gZosV7vDwgc9D42uD280u3IMScMXi9A7O3OyxQtWEEA7qcuS5mQyh8aT7wqdfkgBoCH3nizBVSlKZCbqm1pMf00hqzlvEWLTFIiIkx+zJHln5UO/qW7SuAcZOkur8pes8rPzVTbfcgB557boTXYdvDbM75rGt6KgwBHKsej7N9/Z0goB+5TgGn9lS7xiTd8u5iQSRqitH5+JRj5VvbBRwisJJvg4VJtDLDhZMkS8KshMntbJK5yIAAPc7CERTx0r9jExWXEQSbu5Fuzq5tPo6ZBFOGg4sl54WdzLopA32TBxbzD8128j6hqeiVTmY/9c3lF0bQwD3CPSeQokZkLHnNBQQFKP5T5qAIAvxKFtWKFMysFjimhMIWOBsB7k8Eq7jju6dKaf29n27/vHGuOgyXpiayfb3jZPa
X-Microsoft-Antispam-PRVS: <MWHPR13MB1423F5A40D526DA4F4F5CD27FDE60@MWHPR13MB1423.namprd13.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(182409339516656)(209352067349851)(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(11241501184)(944501410)(52105095)(93006095)(93003095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:MWHPR13MB1423;BCL:0;PCL:0;RULEID:;SRVR:MWHPR13MB1423;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR13MB1423;4:l1DiSWbfR5p/YRrE4r+FqB+AQAoTB0Bs6CRWwgPYfW4ZN265ATRM3kUO25i6G7MkHRbrEdy4w+pmeyo9gVeY+bxCcZlGjmDK+J28nEe1YzYauCBHD1QRQb+Ky+0+JEiTrQhBmv4e9I6hES+Rjwq39/IGIZrfzIfK0sz1F1x2RHywjislEkEmbo9+ds4y0wry/+6Gd++odmrW7/Gwcghq+vntEA0XPkJHt/wCwKGT8QISWV/bcjup3tncX0CSJl7F0NYTGLFHirns/FeOiXiVv/dWp8l/N2rl7GMcz3oJY43g/iCYmNhGhzPcWWOqcSo/gI9uRZ+FMz5kH2pluSEiXYeVzo14RQ3FN3ZoMstoO7kVQAGcNaToaP5MPLUXb6Pk
X-Forefront-PRVS: 081904387B
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEzTUIxNDIzOzIzOjBlOUFZTWUyNnJXQ1ZKdXdTd3E5WnczaFJn?=
 =?utf-8?B?K0tEVEhub0REbGJ2dlRVNDhUWEp2dEVEZ2krRVAwYUZDRnBZQnRaS0pCblZR?=
 =?utf-8?B?TDQ0eVl6UFBVNW9Ya0R2SWd0Ujc4WGxYWlkxWTVXT0dYaUdGMFZqTi80QVgv?=
 =?utf-8?B?aE9kZG1GMnkzQzJYZnFySzNnK2FSeXAvL0ZmcWRKbkRWd3JHRHB5MmdRdU8w?=
 =?utf-8?B?WHE4U1Q2ZlcwMExlKy9jaFZiZzJPVk94eGNEVEVtSFFTOVlTZittaXl5VUs0?=
 =?utf-8?B?OUEyZkVXdnBDRk8wcGRwTXFuVFhTUnJMeG9jNEhoSlp4Y0F2SlJyZ05wUFdV?=
 =?utf-8?B?NmRkMmhVL2NDbm9MbEszTnhwUS9PK3VyclBSMzRaaWs4YVlxdUxlWWVZZUha?=
 =?utf-8?B?QWV2a2pUWlFkV2s4VU9UejBodlhhYk42M1R6MjYxUkpleW5qNDdkbUIyYjB0?=
 =?utf-8?B?amp4OVRqUG1xcVEvYXFUMUo2WUVReTVuZGlQUzRmN1FzK3NVcFMvNE1NV0My?=
 =?utf-8?B?VUFQVmw1VUN3NTBySGhrWS9tU0JqWkxtaCtGeEd0aHZIcEZXSEs0UEtQazRr?=
 =?utf-8?B?ejlNdmhYTFozN2lzK3JZV0xHYXc0SUIvSXV3WGxtY1I5RzNrQlJLVFpNL2l0?=
 =?utf-8?B?bUVzU1J2ZTRaT2pDRHV2SitQc2tUQ0FBZ3d1OG9Cd3pySXhXWHVXUUZnbkNX?=
 =?utf-8?B?akZTWmEzN21FRW5ia3FBSWRCV2Zpemg4aXRjaWxYQzVTcFFTVmhJN3RsVktu?=
 =?utf-8?B?aTYvc2E1eTUyTWlxYjV6ZVZxZHYyWk12T2RqcXI0OTN4U1pkWnM1bUFPOFFW?=
 =?utf-8?B?dXAyeWpNdEgxQXc4T25INCt6bmZhOG85Zm55Tjg4SmdkeXBTeHFLQ0ZUWWtp?=
 =?utf-8?B?bGZUT3kzanppd1RNMEdTWkp2MU0wVTVwUEg1WXRialh4N2cvNzdnU2dZY3gz?=
 =?utf-8?B?eEhDQ3BhZVFnVk56TXQ3Q3BCd0FPTnhrVWVOVUFtSUV1c3ZDY21xVDJiTzRq?=
 =?utf-8?B?WXJoU29IY3Z6OEkvNmcyYUZuNENTM0l0RXhBNlRKTmUwVjBUOTh2Vk1pdlNw?=
 =?utf-8?B?RkZyVElkZlFjZGx3cmtXWnhlbk0vajhkSFU5MjAwcHZoc2VRdXZ0UDcxUUtz?=
 =?utf-8?B?bEh3VHdYSVN1ZUE1em5QRmpnR3J6YlFYVkoyRTZITUE4OVlVWm9GUkh1MENj?=
 =?utf-8?B?SUZSYWtzQUVtb3Mza3Z6OHFqRDVhdnRkMGFNY1lqRjVIdnBJdGNwdGxUaUJt?=
 =?utf-8?B?YjhjOEFmZkRkK3lDSldGWGxPMzhuSGk5clMyeUlLa2lUbWFuU2l3d240MG5O?=
 =?utf-8?B?QlJNZnViMXNjWk5HaytJTkF0eHpianVJM1NRZzBJejNvUzRDeFNDalprZity?=
 =?utf-8?B?YTlDUThhTXl5Ky9Yd1gzL2toMmxGR3FSQ0swamRPcGs0SDdiRXpSbFIyN0dN?=
 =?utf-8?B?YVA5ZjNPV2czTWczYUVjRXNUVng3YmZrZFBaQmYvbGVKM0R2Z0E0M1J0ZzZN?=
 =?utf-8?B?WnFOSHZMTWcraVhPdWgzYlpmbkViOWNoSENYK2I5aTE3R1BBUnBsTm9Dbmwv?=
 =?utf-8?B?dnE3c1I1aXV0L1BPY1lMVjlSTG1CaXJTYS9kVVRRMit4MGxnOS8xcTZMd3F4?=
 =?utf-8?B?cEpHSytoN002VmJwRWYrenlrMGxrVUNPUmg5NEh4TzhzRDZPTUY2NTU0T2Ju?=
 =?utf-8?B?WWFUNXRKd3drZmE1QklQV3lEMHkvRzM1Y1d3RXBVVEJ6bHZFVmhxRnEzNDM5?=
 =?utf-8?B?MG5tQ0ZiS3NFd1BrQ21qQT09?=
X-Microsoft-Antispam-Message-Info: iqWrSQVRJXEXJakzm0ahh5yFEw8vAWLJDRYyrTSr5wVpWAu6I3k4F3dLlpYMUiiH+zP/uef+HUOsi6WXShBubJ3yH9pp9PUXCrAnSqw+fpCV0U8unbxZV/0lbZ16vX3mSMn3WdSDS7PZekegNaBRnaCO2lqrQKuG9JpG2EAYyz5qOOdKHWVS2KbWYSK9ONVA2iT18i9Rek+LneLYJRa7RYhCo39rDP1Wcpd6XODje8dK9txmB+Nyys1yqd12abHfU8M77ANcQ3+IMUigOj4uiIuhXEiOwyHsdBCy1N/Qn3mL+cv7D1fAxUezui5QyhadEKvASbeKvN3CFUrsyaoBGXWcJB4va9atyjzuFJvU32s=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR13MB1423;6:vHJXN24zD9eLnUKpwjf4eFGuLZOZP157fd09PnDkzc6KHH99th/XclRbE/NWwLs5tam1uc9WcjfKLU4NcqgiQdajBcjmWhRgdDUX5hRvm3WAopAY25EcB7LmIT7WMcLIz67LHuWe+Ag/sKt1qif6f3jR+ExCt6xm/EkWr0YF9Oy2kEQxseQG7OlazM+koeRaX34O4jg+cbU0d6DG+evo3gS980AI6tJOIFwEwoLQl8b++J0tEhJzqLTet9lBEbvn9u4Ad3FNAl/AAUWlQgVszS8kw/WXXFtCnc8G11hBWqaGvmMi61rNiwPHTecbZf4GpPihtVSmUhjk5qnYNmenisNaZSi8H3jplYY2+nidr/Ony7j+KTWcncg40/oo3TXpR9x9FkhAY9keMU20k/qO4+ZKrbb0Cr4PrP4hCYdjofZUOhRcJ4veidygP3KRCFxMwVFhGEZ4DX3oqh8motttXw==;5:Z95Bv6KTlDgUTy8YJMJdbTvogVUBvGKD0EW3xQqIczmwG0TKJPg6ilUr+RGGUydsGKcPGsFlzBDHAzckzjaTSIcYLMlcmoOcAn+pjlDkgxnhQp81plqExeHBH61w3sD3BxzfQ/uXmyAUhF7B/VLXENe/Hj2RDeLuuYjKHod9lWo=;7:nS9WKcEeaIWbAjIj2XVOrIqhWMwmVTj5EZ5rxJ5yhY5z1+gm0s2CU2HjPu5lxy6W+QubINX3dmnKrFSARfNCFPrNdqkc/petOIart4CDw+MOEu51pReynNFa/2nfRsJWrHYqHBkAPreFfnAcMDijwpzuU4FI35yk1xHZCSP4EJYpryG7X/IZesobJ6HiK/5/rO5P74D27d/JY9z0llQKIVmGghECscy1Z3CajmD4HsJyGVzoJ1cX0ymL6i2+vBjn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 17:58:45.4476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 784691b1-20cd-4cf1-c8e2-08d62d47b11b
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.229];Helo=[usculsndmail02v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1423
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYW1lcyBCb3R0b21sZXkNCj4g
DQo+IE9uIE1vbiwgMjAxOC0xMC0wOCBhdCAxMzo1MSArMDAwMCwgVGltLkJpcmRAc29ueS5jb20g
d3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogSmFt
ZXMgQm90dG9tbGV5DQo+ID4gPiBPbiBTYXQsIDIwMTgtMTAtMDYgYXQgMjE6NDMgKzAwMDAsIFRp
bS5CaXJkQHNvbnkuY29tIHdyb3RlOg0KPiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4gPiA+ID4gRnJvbTogSmFtZXMgQm90dG9tbGV5DQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBTaWduaWZpY2FudCBjb25jZXJuIGhhcyBiZWVuIGV4cHJlc3NlZCBhYm91dCB0aGUNCj4gPiA+
ID4gPiByZXNwb25zaWJpbGl0aWVzIG91dGxpbmVkIGluIHRoZSBlbmZvcmNlbWVudCBjbGF1c2Ug
b2YgdGhlIG5ldw0KPiA+ID4gPiA+IGNvZGUgb2YgY29uZHVjdC7CoMKgU2luY2UgdGhlcmUgaXMg
Y29uY2VybiB0aGF0IHRoaXMgYmVjb21lcw0KPiA+ID4gPiA+IGJpbmRpbmcgb24gdGhlIHJlbGVh
c2Ugb2YgdGhlIDQuMTkga2VybmVsLCBzdHJpcCB0aGUNCj4gPiA+ID4gPiBlbmZvcmNlbWVudCBj
bGF1c2VzIHRvIGdpdmUgdGhlIGNvbW11bml0eSB0aW1lIHRvIGNvbnNpZGVyIGFuZA0KPiA+ID4g
PiA+IGRlYmF0ZSBob3cgdGhpcyBzaG91bGQgYmUgaGFuZGxlZC4NCj4gPiA+ID4gPg0KPiA+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IEphbWVzIEJvdHRvbWxleQ0KPiA+ID4gPiA+IDxKYW1lcy5Cb3R0
b21sZXlASGFuc2VuUGFydG5lcnNoaXAuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+IMKg
RG9jdW1lbnRhdGlvbi9wcm9jZXNzL2NvZGUtb2YtY29uZHVjdC5yc3QgfCAxNSAtLS0tLS0tLS0t
LS0tLS0NCj4gPiA+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxNSBkZWxldGlvbnMoLSkNCj4gPiA+
ID4gPg0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL3Byb2Nlc3MvY29kZS1v
Zi1jb25kdWN0LnJzdA0KPiA+ID4gPiA+IGIvRG9jdW1lbnRhdGlvbi9wcm9jZXNzL2NvZGUtb2Yt
Y29uZHVjdC5yc3QNCj4gPiA+ID4gPiBpbmRleCBhYTQwZTM0ZTc3ODUuLjRkZDkwOTg3MzA1YiAx
MDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3Byb2Nlc3MvY29kZS1vZi1jb25k
dWN0LnJzdA0KPiA+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9jb2RlLW9mLWNv
bmR1Y3QucnN0DQo+ID4gPiA+ID4gQEAgLTU5LDIxICs1OSw2IEBAIGFkZHJlc3MsIHBvc3Rpbmcg
dmlhIGFuIG9mZmljaWFsIHNvY2lhbA0KPiA+ID4gPiA+IG1lZGlhIGFjY291bnQsIG9yIGFjdGlu
ZyBhcyBhbiBhcHBvaW50ZWTCoHJlcHJlc2VudGF0aXZlIGF0IGFuDQo+ID4gPiA+ID4gb25saW5l
IG9yIG9mZmxpbmUgZXZlbnQuIFJlcHJlc2VudGF0aW9uIG9mIGEgcHJvamVjdCBtYXkgYmUNCj4g
PiA+ID4gPiDCoGZ1cnRoZXIgZGVmaW5lZCBhbmQgY2xhcmlmaWVkIGJ5IHByb2plY3QgbWFpbnRh
aW5lcnMuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAtRW5mb3JjZW1lbnQNCj4gPiA+ID4gPiAtPT09
PT09PT09PT0NCj4gPiA+ID4gPiAtDQo+ID4gPiA+ID4gLUluc3RhbmNlcyBvZiBhYnVzaXZlLCBo
YXJhc3NpbmcsIG9yIG90aGVyd2lzZSB1bmFjY2VwdGFibGUNCj4gPiA+ID4gPiBiZWhhdmlvciBt
YXkgYmUNCj4gPiA+ID4gPiAtcmVwb3J0ZWQgYnkgY29udGFjdGluZyB0aGUgVGVjaG5pY2FsIEFk
dmlzb3J5IEJvYXJkIChUQUIpIGF0DQo+ID4gPiA+ID4gLTx0YWJAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmc+LiBBbGwgY29tcGxhaW50cyB3aWxsIGJlDQo+ID4gPiA+ID4gcmV2aWV3ZWQgYW5k
DQo+ID4gPiA+ID4gLWludmVzdGlnYXRlZCBhbmQgd2lsbCByZXN1bHQgaW4gYSByZXNwb25zZSB0
aGF0IGlzIGRlZW1lZA0KPiA+ID4gPiA+IG5lY2Vzc2FyeSBhbmQNCj4gPiA+ID4gPiAtYXBwcm9w
cmlhdGUgdG8gdGhlIGNpcmN1bXN0YW5jZXMuIFRoZSBUQUIgaXMgb2JsaWdhdGVkIHRvDQo+ID4g
PiA+ID4gbWFpbnRhaW4NCj4gPiA+ID4gPiAtY29uZmlkZW50aWFsaXR5IHdpdGggcmVnYXJkIHRv
IHRoZSByZXBvcnRlciBvZiBhbg0KPiA+ID4gPiA+IGluY2lkZW50LsKgwqBGdXJ0aGVyIGRldGFp
bHMgb2YNCj4gPiA+ID4gPiAtc3BlY2lmaWMgZW5mb3JjZW1lbnQgcG9saWNpZXMgbWF5IGJlIHBv
c3RlZCBzZXBhcmF0ZWx5Lg0KPiA+ID4gPg0KPiA+ID4gPiBJIHRoaW5rIGl0J3MgT0sgdG8gbGVh
dmUgdGhlIGFib3ZlIHNlY3Rpb24sIGFzIGl0IGRvZXNuJ3Qgc3BlYWsNCj4gPiA+ID4gdG8gZW5m
b3JjZW1lbnQsIGJ1dCByYXRoZXIgaXMganVzdCBhIHNldCBvZiByZXBvcnRpbmcNCj4gPiA+ID4g
aW5zdHJ1Y3Rpb25zLCB3aXRoIGFuIGFzc3VyYW5jZSBvZiBjb25maWRlbnRpYWxpdHkuwqDCoFRo
aXMgc2VlbXMNCj4gPiA+ID4gdG8gbWUgbm90IHRvIGJlIHRoZSBvYmplY3Rpb25hYmxlIHBhcnQg
b2YgdGhpcyBzZWN0aW9uLg0KPiA+ID4gPiAoSU9XLCBJIHdvdWxkIG9taXQgdGhpcyByZW1vdmFs
IGZyb20gdGhlIHBhdGNoKS4NCj4gPiA+DQo+ID4gPiBTbyBJIGRpZCB0aGluayBhYm91dCB0aGF0
LCBidXQgaXQgc3RydWNrIG1lIHRoYXQgd2l0aCBib3RoDQo+ID4gPiBwYXJhZ3JhcGhzIHJlbW92
ZWQsIHRoZSBjdXJyZW50IENvQyBpcyB2ZXJ5IHNpbWlsYXIgdG8gdGhlIHN0YXR1cw0KPiA+ID4g
cXVvOiBuYW1lbHkgZXZlcnkgc3Vic3lzdGVtIGhhbmRsZXMgdGhlaXIgb3duIGlzc3VlcyBhbmQg
dGhhdCdzDQo+ID4gPiBmb3JtYWxpc2VkIGJ5IHRoZSAiT3VyIFJlc3BvbnNpYmlsaXRpZXMiIHNl
Y3Rpb24uwqDCoFRoYXQgYWxzbyBtYWtlcw0KPiA+ID4gbWUgdGhpbmsgdGhhdCB3aGV0aGVyIHdl
IHdhbnQgYSBjZW50cmFsaXNlZCBjaGFubmVsIG9mIHJlcG9ydGluZyBvcg0KPiA+ID4gZW5mb3Jj
ZW1lbnQgYW5kIHdoYXQgaXQgc2hvdWxkIGJlIGFsc28gb3VnaHQgdG8gYmUgcGFydCBvZiB0aGUN
Cj4gPiA+IGRlYmF0ZS7CoMKgVGhlIFRBQiB3YXMgY3JlYXRlZCB0byBjaGFubmVsIGNvbW11bml0
eSB0ZWNobmljYWwgaW5wdXQNCj4gPiA+IGludG8gdGhlIExpbnV4IEZvdW5kYXRpb24uwqDCoFRo
YXQncyBub3QgdG8gc2F5IGl0IGNhbid0IHByb3ZpZGUgdGhlDQo+ID4gPiByZXBvcnRpbmcgYW5k
IGFyYml0cmF0aW9uIHN0cnVjdHVyZSwgYnV0IGlmIHdlJ3JlIGdvaW5nIHRvIGRvIGl0DQo+ID4g
PiByaWdodCB3ZSBzaG91bGQgZGViYXRlIHRoZSBleHBhbnNpb24gb2YgaXRzIGR1dGllcyAoYW5k
IHBvd2VycykuDQo+ID4NCj4gPiBXaGVuIHRoZSBDb2RlIG9mIENvbmZsaWN0IHdhcyBhZG9wdGVk
IDMgeWVhcnMgYWdvLCB3ZSBhbHJlYWR5IGNyZWF0ZWQNCj4gPiB0aGUgY2VudHJhbCByZXBvcnRp
bmcgbWVjaGFuaXNtLCBzbyBJIGFjdHVhbGx5IHRoaW5rIGxlYXZpbmcgKGllDQo+ID4gaW5jbHVk
aW5nKSB0aGUgYWJvdmUgcGFyYWdyYXBoIGlzIGNsb3NlciB0byB0aGUgc3RhdHVzIHF1by7CoMKg
SSB0aGluaw0KPiA+IGl0J3MgdGhlIGV4cGFuZGVkIHBvd2VycyBhbmQgZHV0aWVzIChvciBwZXJj
ZXB0aW9uIHRoZXJlb2YpIHRoYXQgYXJlDQo+ID4gY2F1c2luZyBjb25jZXJuIGFuZCBJIHRoaW5r
IGRlYmF0aW5nIHRob3NlIHRvIGNsYXJpZnkgaW50ZW50LCBhbmQNCj4gPiBhZG9wdGluZyBjaGFu
Z2VzIGFzIG5lZWRlZMKgwqB0byBhbWVsaW9yYXRlIGNvbmNlcm5zIGlzIHdvcnRod2hpbGUuDQo+
IA0KPiBJZiB3ZSB3YW50IHRvIGdvIGJhY2sgdG8gdGhlIHN0YXR1cyBxdW8sIHRoZW4gYSBwbGFp
biByZXZlcnQgaXMgdGhlDQo+IHBhdGNoIHNlcmllcyBJIHNob3VsZCBzdWJtaXQuDQoNCkxldCBt
ZSB0cnkgdG8gYmUgbW9yZSBjbGVhci4gIEkgZG9uJ3Qgd2FudCB0byBnbyBiYWNrIHRvIHRoZSBz
dGF0dXMgcXVvLg0KSSB3YXMgc2F5aW5nIHRoYXQgaWYgd2Uga2VlcCB0aGlzIGRvY3VtZW50LCBi
dXQgb21pdCB0aGUgY2VudHJhbA0KcmVwb3J0aW5nIG1lY2hhbmlzbSwgdGhhdCBpcyBhIGxhcmdl
IGRlcGFydHVyZSBmcm9tIHRoZSBzdGF0dXMgcXVvLA0KYmVjYXVzZSB0aGUgQ29kZSBvZiBDb25m
bGljdCBhbHJlYWR5IGVzdGFibGlzaGVkIHRoYXQuICBBbmQgSSB0aGluaw0KdGhhdCBoYXZpbmcg
YW4gb21idWRzbWFuLXR5cGUgcm9sZSBzb21ld2hlcmUgaW4gdGhlIGNvbW11bml0eQ0KaXMgYmVu
ZWZpY2lhbC4NCg0KSSBiZWxpZXZlIHBhcnRzIG9mIHRoZSBDb2RlIG9mIENvbmR1Y3QgYXJlIGFu
IGltcHJvdmVtZW50IG92ZXIgdGhlDQpDb2RlIG9mIENvbmZsaWN0LCBzbyBteSBwZXJzb25hbCBw
cmVmZXJlbmNlIHdvdWxkIGJlIHRvIGtlZXAgaXQNCmFuZCB0cnkgdG8gYWRqdXN0IGl0IG1vdmlu
ZyBmb3J3YXJkLiAgSSB0aGluayB5b3VyIHBhdGNoZXMsIHdpdGggY2xlYXINCnN1Z2dlc3Rpb25z
IGZvciBpbXByb3ZlbWVudHMgKG9yIGZvciBkZWxldGlvbnMgaW4gdGhlIGNhc2Ugd2hlcmUgd2UN
CndhbnQgbW9yZSBkZWJhdGUgb24gcGFydGljdWxhciBzZWN0aW9ucyBiZWZvcmUgYWRvcHRpbmcg
dGhlbSkgaXMNCmEgZ29vZCBhcHByb2FjaCwgYW5kIEkgbGlrZSB0aGF0IHByb2Nlc3MgYXMgb3Bw
b3NlZCB0byBzdGFydGluZyBvdmVyDQpmcm9tIHNjcmF0Y2guDQoNCj4gDQo+ID4gSSBiZWxpZXZl
IHRoYXQgaW4gdGhlIHZhc3QgbWFqb3JpdHkgb2YgY2FzZXMsIHRoZSBUQUIgd2lsbCBlbmQgdXAN
Cj4gPiBwZXJmb3JtaW5nIGEgbWVkaWF0b3Igcm9sZSB0byBzbW9vdGggaHVydCBmZWVsaW5ncyBh
bmQgcmVtaW5kIGFuZA0KPiA+IGVuY291cmFnZSBpbXByb3ZlZCBjb21tdW5pY2F0aW9uIC0gdmVy
eSBzaW1pbGFyIHRvIHdoYXQgd2UndmUgZG9uZSBpbg0KPiA+IHRoZSBwYXN0LsKgwqBJIHJlYWxs
eSBiZWxpZXZlIHRoYXQgYmFucyB3aWxsIGNvbnRpbnVlIHRvIGJlIHZlcnkgZmV3DQo+ID4gYW5k
IGZhciBiZXR3ZWVuLCBhcyB0aGV5IGhhdmUgYmVlbiBoaXN0b3JpY2FsbHkgKEkgY2FuIG9ubHkg
dGhpbmsgb2YNCj4gPiAzIGluIHRoZSBwYXN0IGRlY2FkZS4pDQo+IA0KPiBUaGF0IG1pZ2h0IHZl
cnkgd2VsbCBiZSB0aGUgcG9zaXRpb24gdGhlIGRpc2N1c3Npb24gYXJyaXZlcyBhdDsNCj4gaG93
ZXZlciwgSSByZWFsbHkgdGhpbmsgbWFraW5nIHRoZSBwcm9jZXNzIGZ1bGx5IHRyYW5zcGFyZW50
IHRoaXMgdGltZQ0KPiByZXF1aXJlcyBub3QgcHJlanVkZ2luZyB0aGUgb3V0Y29tZS4NCkkgZG9u
J3QgdW5kZXJzdGFuZCB5b3VyIHBvaW50IGhlcmUuICBDYW4geW91IGVsYWJvcmF0ZT8NCg0KVGhh
bmtzLA0KIC0tIFRpbQ0K
