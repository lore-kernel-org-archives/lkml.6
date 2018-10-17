Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5427EECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E714E208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="Vu0vmfRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E714E208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeJRFQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 01:16:07 -0400
Received: from mail-bl2nam02on0117.outbound.protection.outlook.com ([104.47.38.117]:22848
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725745AbeJRFQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 01:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wA1o3/6NMN0Xj13Jj8f3j0i+LnXAhNx4pQa6WC6EaQU=;
 b=Vu0vmfRm/E5V61vxXObSc0xsV9RTP8QS38pA8bmBjhE7lrz/MCXzmWp0pUyY11F6iqWIIeYBeEMnlZl5Gpqt7VztFpICKF0f/LNfiB0Vs85Uwx+6EVmtqEKhdFe9HLE598Ytkhe5hVB97ZxLNbKeTP/iODmxiDK1xnDKDVLwDqk=
Received: from CY4PR13CA0028.namprd13.prod.outlook.com (2603:10b6:903:99::14)
 by DM5PR1301MB2027.namprd13.prod.outlook.com (2603:10b6:4:32::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1250.20; Wed, 17 Oct
 2018 21:18:30 +0000
Received: from SN1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by CY4PR13CA0028.outlook.office365.com
 (2603:10b6:903:99::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1250.12 via Frontend
 Transport; Wed, 17 Oct 2018 21:18:30 +0000
Received-SPF: PermError (protection.outlook.com: domain of sony.com used an
 invalid SPF mechanism)
Received: from usculsndmail02v.am.sony.com (160.33.194.229) by
 SN1NAM02FT060.mail.protection.outlook.com (10.152.72.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1250.11 via Frontend Transport; Wed, 17 Oct 2018 21:18:28 +0000
Received: from usculsndmail14v.am.sony.com (usculsndmail14v.am.sony.com [146.215.230.105])
        by usculsndmail02v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id w9HLIRKf014082;
        Wed, 17 Oct 2018 21:18:27 GMT
Received: from USCULXHUB03V.am.sony.com (hub.bc.in.sel.sony.com [146.215.231.17])
        by usculsndmail14v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id w9HLIQpF014662;
        Wed, 17 Oct 2018 21:18:26 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB03V.am.sony.com ([146.215.231.17]) with mapi id 14.03.0408.000; Wed,
 17 Oct 2018 17:18:26 -0400
From:   <Tim.Bird@sony.com>
To:     <brendanhiggins@google.com>
CC:     <kieran.bingham@ideasonboard.com>, <gregkh@linuxfoundation.org>,
        <keescook@google.com>, <mcgrof@kernel.org>, <shuah@kernel.org>,
        <joel@jms.id.au>, <mpe@ellerman.id.au>, <joe@perches.com>,
        <brakmo@fb.com>, <rostedt@goodmis.org>, <khilman@baylibre.com>,
        <julia.lawall@lip6.fr>, <linux-kselftest@vger.kernel.org>,
        <kunit-dev@googlegroups.com>, <linux-kernel@vger.kernel.org>,
        <jdike@addtoit.com>, <richard@nod.at>,
        <linux-um@lists.infradead.org>
Subject: RE: [RFC v1 06/31] arch: um: enabled running kunit from User Mode
 Linux
Thread-Topic: [RFC v1 06/31] arch: um: enabled running kunit from User Mode
 Linux
Thread-Index: AQHUZaubKrs7lN8yQ0OXjbB6TpE4ZKUj1CUA///kU0CAAHqFAP//vbkw
Date:   Wed, 17 Oct 2018 21:18:25 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF805248BE@USCULXMSG01.am.sony.com>
References: <20181016235120.138227-1-brendanhiggins@google.com>
 <20181016235120.138227-7-brendanhiggins@google.com>
 <f0d64a0a-7914-f390-c0b5-dc7626b45476@ideasonboard.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF8052436B@USCULXMSG01.am.sony.com>
 <CAFd5g45owvjnVh633_kqf9DKeWQDYdGNi9j1crNZC3k02r=v1A@mail.gmail.com>
In-Reply-To: <CAFd5g45owvjnVh633_kqf9DKeWQDYdGNi9j1crNZC3k02r=v1A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [146.215.228.6]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:160.33.194.229;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(376002)(136003)(2980300002)(448002)(13464003)(189003)(199004)(7736002)(5660300001)(426003)(33656002)(126002)(436003)(6116002)(336012)(316002)(86152003)(26005)(2900100001)(93886005)(478600001)(8676002)(356004)(85326001)(305945005)(2920100001)(55016002)(2906002)(11346002)(246002)(446003)(3846002)(6346003)(186003)(2876002)(476003)(486006)(55846006)(8936002)(229853002)(2486003)(6916009)(7416002)(4326008)(2351001)(106466001)(72206003)(86362001)(7696005)(50466002)(23676004)(102836004)(6246003)(47776003)(53546011)(66066001)(76176011)(54906003)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2027;H:usculsndmail02v.am.sony.com;FPR:;SPF:PermError;LANG:en;PTR:mail.sonyusa.com,mail02.sonyusa.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT060;1:CMBTkiCOZyH9Y2vSz5uSGZwaMc9iZia7DmYJN3gki2b7qE7820c+7xIiRz0Hh2x/k8mIM8dQ5UjOzjVZiSFzR3CN3+7nFZ0RYPv8qi0W6By9THh5yvXqCZ4BAAdPokm7
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a3eaa00-e553-4493-20cf-08d634761612
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR1301MB2027;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1301MB2027;3:SrtXgcLimS6y3oQQ+LzfqETO0vZqMponrnSGF0oApR9ANN+PXJ1ElSG4OkUBGiHg/a3cq5bptxAr8IXbdtOUqdoysdqg8KIP477mouwLImKM97UnuMXaRpqreE66eGNYC2LlAEAWEHLi7GBvoSlPcAGifUvsOhZIgV8aoBLgwXD1jY9m2U9MIAo+ljtjcg7zxABCGfoDzbtLS7DoMeRMFDXtsRVWAuanLntz7pTuF8Zx0SBMSYI/u6ynW0eSdfTXQKmqIg9mw16ouWng0pCJPccDnkSJvFgJeEFkmSKO72iEr/vY7MuT0v1vc9HCwt2JtmOHqIAxG+qGjZofHoNKDXrOEM0C7PV7RLnM06unT+0=;25:is/jj74X7chGRHhzg2wg3oj9Bjt7hcCVBBQQXr7cBZgCI2gQz6HaU8htXGBA703e52iCrQ7nwBtIRJWsQhZdXWszqRvsTftpTZhR9zaDZ0dqE+3rPvLAV9T5IqD7wlqt+2Y9Nc9yvFpAbRR2b475ptlxya84EeirV8zNro47GbFEu8x67u5zt1951adk/DaWP0o3PiDB5ez2XTXT4bi2mr/9mF0qKYWxBvIr5QM6BTquh+3XEL+KbsF5M80D85ZcKSm4jwM6G9hj9cPTvjz2sQBCJvYHnZAJLD023FuOB0DN6dhnd+GVTl8jKPylbEoFbqhM/vt+2TGIqauD7wAPHg==
X-MS-TrafficTypeDiagnostic: DM5PR1301MB2027:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1301MB2027;31:T8N0BGYG1AvQr80QYwiFWf/Nt/dBWWZgiVhKwSq4f2BW/3Jd5ham/Lzx2+IKqrfZC3rtvgr14aYQiVXwgWYL9ub/jXEnOcGpn0CHERzyy0iqlsIUDflQ0s4lzAGiIvbPsqpfNH1DcsEacQZiA7DtZlUnupeICbOiTNzhoSb8gRtXmCucsU2+a/GaXAkEelHclZFpHrNCgFZKN8Ko4n8lqCZFjjdQQpw6w+ACdYvr2Xg=;20:1072HeYx8vQTW31BprD8u7hjZ1Ceih1kg9HRzjdyumm8ZWo/4pPHcxMa6WwNBhSeShEZfqMih/tUrGqoiSBQe/vU4QGDpqU/Ekl/s2sPqbu4xzcMC8oieId+NJufJFrNK9HjY26+mq/wOQk5puV/zxEBdJ0Oqt84AIrCSqnBf0FDj9qIp32w08i+5gTZpBcCvjW75HViaovKui5txMSw2U58xdgQjeBJmiAyiQsZbnTmClkPzLlIbNsRsekXTRdfKbJUUsCrJUQbJOHJTOGCOnHxUt3KBjqzcu2wi0ibjerRSWADDSpBAhUkWIIV1NnRws1WbqC+/mbZAnIp46ru4tg49ew361lvQ9PVxKf5mcvDGv2WeE4u68h1oe6Tuh0IenOZZ853ZIDqSo666n7Ab33gsvag6+q6oRth000WxUEeRmOLGJhyxZAXX/XHV6dCgR/EjWpypjwhJom7PH3OQYpK0z5BLuEyE6NQ9NmJDM8Jp1f10ESgkJXh5n0rzYjT
X-Microsoft-Antispam-PRVS: <DM5PR1301MB202771D8D44DFDA1FDA2C439FDFF0@DM5PR1301MB2027.namprd13.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(182409339516656)(158342451672863);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(10201501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM5PR1301MB2027;BCL:0;PCL:0;RULEID:;SRVR:DM5PR1301MB2027;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1301MB2027;4:1QoLYRTwnK9k+ZMs112KKy0sctXmfAI1McHBrBkVInu5tjYcUPaCYBQGqUrafIfZzEeDsWFsSXw1BI6oT3PJgq2MR0AV4V3xBresJSOEg+F1ZvMq+A6a8yTB6RnQKAjpCmNCCuw/7AI+rsPnwvID+OzKbncLi3/W50qL+ZD15CRRWsbqFo3kD813EaGgqx/0FKEaURdQi6ySau+/IdmEwC3tCW5ILaw0fOrEIQ8kyryPgWC6bM2zG+JsRRtJ94vobY44zqijYX/f4wfHeU3oQCkf7HBOm9FCqcXyL9/JSOfHE44HgcHpt/29IogX1YH2MP64SIVRqLVYXoocWXUgynrVM1pjXl8y+ojM+324Hm4=
X-Forefront-PRVS: 08286A0BE2
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEzMDFNQjIwMjc7MjM6NDB1aFJKSGRTVG14QlVVazhBUVNNRTB3?=
 =?utf-8?B?dlNUMy9odmxUUVdJZHlRaWNucmFGaFQrVE0xb0lvUnJZYUM3djczUTc3RE55?=
 =?utf-8?B?bkdMSERORmtyY0pmMHAxVndpVWRZcW1JLzl0clNEVTd3OEdqUlN3c2JqcERZ?=
 =?utf-8?B?MVVjRUZxNjhjbHlaMnlqdzNoS1NjUklENDRLMTBkMDZNNHlhZGw2b3dwUE9k?=
 =?utf-8?B?UVByV3BXVnFteXU0dElQNnRJWjFxWk9FaFNwZjIvUDF0RUpOOHZWUldFbnJC?=
 =?utf-8?B?dGpNK0NqOUFydmF4Y0pqenQ1K2hxaGViTjV3UnFnaDdsSUVhbHZGN1dFTE1o?=
 =?utf-8?B?T3FyMG53VXJ3aXR1dXRxZFFvUFpOdmVTS3dKa1N6WDJVcHJLS1d3azY1aFdy?=
 =?utf-8?B?YlJ1RTRWZDVsbmdpUUg3NnhCcnlsOTlhRHBSSEtveExsZENEaWFkNXZBUmJr?=
 =?utf-8?B?V1NmUmlVa0JQRGZDdit1ZHRtMG54UmtFTDZUWVBPSk9sVHllNDg4eGlEcU41?=
 =?utf-8?B?eHhnMmprSGgrV3BEUTdLWlRxVS80VVhmM2xaZWYzM1QrZnJBTTZCNWZvelpj?=
 =?utf-8?B?NGFaODB0MEJ5dDI3SWlSeGpJSG11WFhTek1aRmswcVNxM2RwUGxnVU5ubDYx?=
 =?utf-8?B?NkptZ2ZZTVF0eGxZUFlIWExnU01pWW4vY1gxNkFEb2FmSk16b2V4Z3dYa3Z5?=
 =?utf-8?B?dzNFakhub2VVTnN1L1VXWVhIbjdwK1BFc3lPZHAzOXZOMVp2T0svUkkwK245?=
 =?utf-8?B?eUFSWHJaREc2eGhTbGR2UUZZbTgvdjJjUThMZUJnNFlTbG42aUlHV1hBRENv?=
 =?utf-8?B?REUxbHk2RExLNDB3aTBFamtsY3F3aFBRUUlaeWsydHJLeVhhMHdXbG1sZVZQ?=
 =?utf-8?B?WUg1RWx1dlEzWjBiNE9vRDQvZHl1Sm5NYi9henlDYi81eE16U0lwTUtoaUxF?=
 =?utf-8?B?TkNoUWJlaU0yRDl0UDV4ZEp3UU0rcFdrUjhxamxBQTU0blVQbW5lU3hlcTBB?=
 =?utf-8?B?WHJhN0QrVEVaTHpPclRPbHVlR3c1dEd1Tk44K2F5T1pFMVErZHdlaVlFNm4r?=
 =?utf-8?B?YWlXL1loc1pRUE93Tm9EcG9iamtUN1pjQkxGb0JlTTYxaXpiMzl1WlcxdHow?=
 =?utf-8?B?M1pBWEh5cFQzZG9YZlNPR09WcFRMSFB5NDZKcFZXaEIvdmx5azN5YVhoUUJI?=
 =?utf-8?B?Y0I0TnViR3d6UjNYT01MQzNTaVlDUG5iKzVUY2o0Z1BEeUpLcGh3dnhnK0NX?=
 =?utf-8?B?V3VCSVBTMkMvRVgrK2lUR1VsQzYvY2ZmVFEzT1JSZXJISFZUTnR4dlV1Ylh6?=
 =?utf-8?B?aUp6cDlCVEpWMkUyVHlFbkpTd3ZNOWZpeGVlY3ZCZ3ZieWxPVnpuVUdPcy9k?=
 =?utf-8?B?bW9XNTI2bHJScE9kSVl3TWlNZFovMFp2NkpXUUpBK214eVh6S0lTcnIxY3ZZ?=
 =?utf-8?B?Y3Y5UTNMNXFoc0hrbzFJQ0s3YmJhdHpCdHk1MDIvaGhmT3J3K1NYc1VpZGV1?=
 =?utf-8?B?a05jQkxtQWJYTDZLNUVNMWx6c1JGS3p6Zkg3bzVhTXJMbUs2dVAzMW1SQ01h?=
 =?utf-8?B?TVl1VWVDL3JGZE55MmoxM3M0Z1gwVWRYQWlGWDE0dXZqcjRRTEZDdWN2MUpL?=
 =?utf-8?B?QjlYaUc0REFJdy9udnRaWUd4NHFOMXhlcE5JS3N3NXZ5M0hXeXZrTXNuWU1P?=
 =?utf-8?B?OFpBbDlsNU93R0ZzWjRSTTU3V2syWXdJeUhwYTFia1RvNXdmMGhyVml4NHZO?=
 =?utf-8?B?bTQxUEZ3L3pMYjhIcit0QUlVRy8yY3YwN2FvWHNFa1pSeDI0SDV3VnhRbjQ2?=
 =?utf-8?B?Mkc1Wmg4R3psT0VmZDNwQlRQRTVqeWRBVVlnU2VvdlZmdWcwQT09?=
X-Microsoft-Antispam-Message-Info: tvTThxMXMnyhI4XIV4IhjSv7kYAtE1oX1ZFjXP/3Z5T8YiPBKifznlPiRvjUQwgBFrwi+xX0sjacybGDM2mELVs4A9kyCVTAXULs3+HoAHsOO0wAbtg+zQizUg4CMT7UEfgv4BucWCChOoI4uqB7v4NNueIlpYCMqzHUtBhA0Mgg2ZUBXqrxxnUCg3YcUy7PrUQb/LUeiffNMa+MuGsU4L7JuqnwqM48e8LpkPpSslba25hMfnu3z5kWpHncmORQPH3BeUAHEBlYTeAT8X0rq15Irx6IG5/hQRC57Zq0ptex3hbJltVjno4tQOrG7VL9PffbsfBwY/ArIOOYdCQFa5a0FWGxw38Foc49jKjTbIU=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1301MB2027;6:aMXGJWlZWq7YI/IMXWHtM/N4Fcijn6oIW90k0m/d3c5na9pUvS/JX8vVTvOZtrQahrFGLoYThQa+sp/Z/SEFIQE1nZMTCoit1Gt3RdVqxwXwgAC/C1anGaXFBOYvHg1fZkX54jtbs7OaOATQfJiPYv/kXwN1vbBOdXrTaMRabWz7qjys9qEdnjNEvBxXg/pYO6b4YnPTclbZv30OFSe3KYFwJNO/+W8Gyp32oJxB10CFqMQNSnDsv/pOi2k3xariOUoeKnLYx2lHNDmKDB4waGH1UyI+de1a3+IK/82/nkEBmBnkUTAROPkgKjgJBj0udo2Qmui/GuhdGxfUGvjx92iZnT80nIhG6A6KtflxkY39BAbSBh7tf8uY41ooo3lRvZHfHEcPAnw8EZXZyvJ7so85DNQx42wd2pXY1MvVWashsdbKafOXS7lZAf9IE5VBYq0hR5j1caMABZ9k6DVAzg==;5:F51nf2N+gGgUSPqEFGf7N2OADwEJ4PpunQZPnRjBFbwOwONU7BcahQuOIsPf5PkUno7zEkMLPOWOiZyNM+w4Olumu3JURTGI69vLn2yXcJnzu7OdGKjp2a0V0Xvvz68QL6F/t/5MrNO+Aws6P9R/bsFQ9VvoZ9TVqMMr1rJYvvU=;7:E3dKlHv2yRFZ020cXwm3hpfuI01eZN5AUMOH7qy4pMt5Qr0pDvC04S9GawikqCGa9UYiEF8GgmyFrpEwhUlOhXZT7TMjstc9JcWWGVzkpZXaU+UAiUwqhexEI7+yGaweoMZzUncTAAQKOQWyCw0YepbTnTeoGQJa0mVGVt73sBj4nayJVcxrWbVRaKNc+DdDPBo678s2Gs6numEPJxif/p2AFveosK+xMfDBOtPMlyk7xJUVDk44r+zQyYYbm0NR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2018 21:18:28.9481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3eaa00-e553-4493-20cf-08d634761612
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.229];Helo=[usculsndmail02v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQnJlbmRhbiBIaWdnaW5z
IA0KPiANCj4gT24gV2VkLCBPY3QgMTcsIDIwMTggYXQgMTA6NTIgQU0gPFRpbS5CaXJkQHNvbnku
Y29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBJdCBtaWdodCBiZSBvZiBpbnRlcmVzdCB0byB0aGUg
YXV0b21hdGVkIHRlc3RpbmcgbWFpbGluZyBsaXN0IHRvbyA/IChUaW0/KQ0KPiA+DQo+ID4gIEkg
dGhpbmsgdGhpcyBpcyBpbnRlcmVzdGluZyB0byBncm91cHMgZG9pbmcgYXV0b21hdGVkIHRlc3Rp
bmcgb2YgdGhlIGtlcm5lbA0KPiA+IChpbmNsdWRpbmcgbXlzZWxmKSBhcyBhbm90aGVyIHNldCBv
ZiB0ZXN0cyB0byBydW4uICBSaWdodCBub3cgSSBkb24ndCBzZWUgaXQNCj4gPiBhcyBoYXZpbmcg
YW55IHNwZWNpYWwgYXR0cmlidXRlcyByZWxhdGVkIHRvIGF1dG9tYXRpb24uICBCdXQgSSBjb3Vs
ZCBiZQ0KPiB3cm9uZy4NCj4gDQo+IFBhcmRvbiBteSBpZ25vcmFuY2UsIGJ1dCBieSBhdXRvbWF0
ZWQgdGVzdGluZyB5b3UgbWVhbiBhIENJIHNlcnZlcg0KPiB3aXRoIHByZXN1Ym1pdHMsIG5pZ2h0
bHlzLCBhbmQgdGhpbmdzIG9mIHRoZSBzb3J0Pw0KWWVzLg0KDQo+IA0KPiBJZiB0aGF0J3MgdGhl
IGNhc2UsIEtVbml0IGNvdWxkIGJlIGhlbHBmdWwgYmVjYXVzZSBvZiB0aGUgbG93IHJlc291cmNl
DQo+IGNvc3QgaW4gcnVubmluZyB0aGVtIGFuZCB0aGUgc3BlZWQgYXQgd2hpY2ggdGhleSBydW4u
DQpUcnVlLg0KDQo+IFRoZXJlIGFyZSBzb21lDQo+IG90aGVyIGZlYXR1cmVzIHdlIHdvdWxkIGxp
a2UgdG8gYWRkIHdoaWNoIHdvdWxkIGhlbHAgd2l0aCB0aGF0IGdvYWwgYXMNCj4gd2VsbCBsaWtl
IHRlc3QgaXNvbGF0aW9uLiBXZSBhY3R1YWxseSBoYXZlIGEgcHJlc3VibWl0IHNlcnZlcg0KPiBp
bnRlcm5hbGx5IGZvciBydW5uaW5nIEtVbml0IHRlc3RzIHRoYXQgY2FuIHVzdWFsbHkgcmVzcG9u
ZCB0byBwYXRjaGVzDQo+IHdpdGggdGVzdCByZXN1bHRzIHdpdGhpbiBhIGNvdXBsZSBtaW51dGVz
LiBXb3VsZCBzb21ldGhpbmcgbGlrZSB0aGF0DQo+IGJlIGludGVyZXN0aW5nPw0KSSB0aGluayB0
aGUgY29kZSBhbmQgYXJjaGl0ZWN0dXJlIG9mIHRoZSBzb2Z0d2FyZSB0aGF0IGhhbmRsZXMgcHJl
c3VibWl0LA0KbWFpbC1saXN0IHNjYW5uaW5nLCBub3RpZmljYXRpb25zLCBldGMuIHdvdWxkIGJl
IG9mIGludGVyZXN0LiAgQnV0IEtVbml0IGZlYXR1cmVzDQp0aGVtc2VsdmVzIChtYWNybyBkZWZp
bml0aW9ucywgbW9ja2luZyB2cy4gZmFraW5nLCBldGMuKSB3b3VsZCBub3QuIA0KSSBvbmx5IHNh
eSB0aGF0IGluIHRoZSBjb250ZXh0IG9mIENDLWluZyB0aGUgYXV0b21hdGVkIHRlc3RpbmcgbGlz
dCBvbiB0aGUgcGF0Y2ggc2V0Lg0KT2YgY291cnNlIHRoZSBLVW5pdCBmZWF0dXJlcyBhcmUgaW50
ZXJlc3RpbmcgYnkgdGhlbXNlbHZlcyBmb3IgdGVzdGVycyBkb2luZw0KdW5pdCB0ZXN0aW5nLg0K
IC0tIFRpbQ0KDQo=
