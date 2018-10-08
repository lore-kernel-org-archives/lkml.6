Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947BAC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 374912085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="SHVCh+7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374912085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sony.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeJHVsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:48:10 -0400
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:22156
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726078AbeJHVsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector1-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XooCG2+nw+k8LNeTdSE/lAY8WvXjlN/quNVnY0MXAAs=;
 b=SHVCh+7mtytxxaqOwvSlVd8R5SUBxYHpiyk4ivT+EWarx38bfzILze+WcajCfLoePGbVMX3y394qECW8rYf2lvCyLEsEIjORsXyoJeKS0Qe2DXM4OO2IQ++WcmQq9nZZkzbuqVGOsGxGFIF6+3Q0+Hz3GPrySV4H03JCr6fpbIQ=
Received: from DM5PR13CA0068.namprd13.prod.outlook.com (2603:10b6:3:117::30)
 by MWHPR1301MB2029.namprd13.prod.outlook.com (2603:10b6:301:32::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.9; Mon, 8 Oct
 2018 14:36:04 +0000
Received: from SN1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by DM5PR13CA0068.outlook.office365.com
 (2603:10b6:3:117::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1228.11 via Frontend
 Transport; Mon, 8 Oct 2018 14:36:03 +0000
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of sony.com: DNS Timeout)
Received: from usculsndmail03v.am.sony.com (160.33.194.230) by
 SN1NAM02FT027.mail.protection.outlook.com (10.152.72.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1228.17 via Frontend Transport; Mon, 8 Oct 2018 14:36:02 +0000
Received: from usculsndmail14v.am.sony.com (usculsndmail14v.am.sony.com [146.215.230.105])
        by usculsndmail03v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id w98Ea11X026375;
        Mon, 8 Oct 2018 14:36:01 GMT
Received: from USCULXHUB07V.am.sony.com (hub.bc.in.sel.sony.com [146.215.231.168])
        by usculsndmail14v.am.sony.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id w98Ea1uR016664;
        Mon, 8 Oct 2018 14:36:01 GMT
Received: from USCULXMSG01.am.sony.com ([fe80::b09d:6cb6:665e:d1b5]) by
 USCULXHUB07V.am.sony.com ([146.215.231.168]) with mapi id 14.03.0408.000;
 Mon, 8 Oct 2018 10:36:01 -0400
From:   <Tim.Bird@sony.com>
To:     <laurent.pinchart@ideasonboard.com>
CC:     <James.Bottomley@hansenpartnership.com>,
        <ksummit-discuss@lists.linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [Ksummit-discuss] [PATCH] code-of-conduct: Remove explicit list
        of discrimination factors
Thread-Topic: [Ksummit-discuss] [PATCH] code-of-conduct: Remove explicit
 list   of discrimination factors
Thread-Index: AQHUXxMe7pCI5sa9sEalwfJKNlaJiaUVaIrA
Date:   Mon, 8 Oct 2018 14:36:00 +0000
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF8051747E@USCULXMSG01.am.sony.com>
References: <20181007085102.17795-1-geert@linux-m68k.org>
        <20181008022931.GB30346@localhost>
        <ECADFF3FD767C149AD96A924E7EA6EAF80517449@USCULXMSG01.am.sony.com>
 <2170645.tuLgNU61gi@avalon>
In-Reply-To: <2170645.tuLgNU61gi@avalon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [146.215.231.6]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:160.33.194.230;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(346002)(136003)(2980300002)(199004)(51444003)(189003)(13464003)(33656002)(8746002)(6346003)(47776003)(5660300001)(26005)(66066001)(356003)(2876002)(85326001)(8936002)(186003)(19627235002)(229853002)(316002)(106466001)(246002)(46406003)(966005)(102836004)(54906003)(6916009)(6116002)(446003)(55016002)(478600001)(72206003)(76176011)(2351001)(3846002)(7696005)(50466002)(55846006)(305945005)(2900100001)(2920100001)(11346002)(575784001)(336012)(426003)(86362001)(486006)(2906002)(126002)(476003)(4326008)(7736002)(93886005)(86152003)(6246003)(23726003)(6306002)(97756001)(5001870100001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR1301MB2029;H:usculsndmail03v.am.sony.com;FPR:;SPF:TempError;LANG:en;PTR:mail03.sonyusa.com,mail.sonyusa.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT027;1:wUz7nE0Jsu6bwwjP+TJs8JF/xE9yBrpynjY2w0Lu71sa6g9KcujJqy76T72jGOZkx9TX0RqTwvgm4b+0dsSl0UeAZjjBpRCQiLPksZ0Fa3WIa8kLqXg2cZpJ8Gxw3Bjc
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2d42c54-69bc-4b79-77e8-08d62d2b5f6f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7193020);SRVR:MWHPR1301MB2029;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1301MB2029;3:P09a1iHuA5oklH6HfVocqCA+B1bwXdn/UYpKr6XQ70DeMynDLxjI2DIa6sMhtGQRwtPRmsE7HwSM3D2PKKElez1a4sUNSTqK1XjdjA5Nhsn0/VniWKc3ZHYFrSIBr+dSZkjmc+owAVoRSviKrCknnarwJQBVWuIHmf+yC8Dcf84/DedoNRMN68GKZTLp0EtqzmiiIiZSIX21vkrDpQ7DyzWjg6IIPXhXkefOnqyaZG59b0rg/+OfDkUI0Zjp5mkH5QCPJ05Lr9KQcsVXOytb/4nVnBZWlVJvvlPnM+AOgXEmo9FUk3I+UjTUN38uLBBI6I2KjPgF1obu7p+B4mOTBag21Yj53qGoukRiU/tiYIQ=;25:s9/aP7c24gKzy3CYFCXzKnCp1b2LVfjnJJAu1AEmyl8QDSmAmjGw808bAC0rY5cjQ2Z1q97XKebiIh7CESxV4GnkhBrIOlgkR6oYJ8bWQ8OOfoRrnge7gEWIofTAozJFn802tMXkBDasbdPMzaiqlMy9U/UTu79peJ3HWBYYN2wqQzjbo6mI0hgJMfV2vMmtndcsblTLCBeZmHdJhltNBLIHQRokOZ/zCKS4wf/rm+yMpIVXXVUNBSq7xxSAo3dQcQ5kqQMkGVz0XVnf9Z5CgPu4/lJUk8qz3KYjHK6aHN2sB5UEHjRb49ZacPDyaQEkt4+s5UGP18CiYfZRCHI1sA==
X-MS-TrafficTypeDiagnostic: MWHPR1301MB2029:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1301MB2029;31:L2AeteaQKyCjZU+sqCqCABFBQMo3i2XWtWkPzeZtgfnXVHRFJi0AerZcJXqzTGg3IpMyn50FyJQC+pd/DXXXg6/hNb+lnPnpD1rOQ/bDUS2U9oVho/a65r1ZcKf3BN/S3yNzByrfO3AWCiHRsx/uLWOjwNUSgTJ8xHN0080ePrj4xmFqYkAy+dKIio7/rYcztkm4+sWAx2qkCCFy4NNuycwvJ6ho42jk8iSQrMa9Dck=;20:d4Lc+uBzltzJ1YNc2RClLEi0f/lLAVFAgk2CbSjsvyiNMghGoqB/PSL9OJgT219pmA/uNAU4m6gc9rb1Z1bMm08RvwLtBsTYc4s9XhHHeQdOcTInXlOukzr0JmkbsCsXU/nRkqWN52ChtdUKZ8/G1IvvYFCbB5aMNUj4L/C7Y2bEuSiV9sdkbrvel6Wt3DbMSm5LWMpUK6lawb6Nsn4o64qpmPilIDqizV1gGigu8eYWckXHtJWnOqq1c/sKGBPCcOBKTFZaD1ypy6UqWGzKT9Mh6p0UGQcBNTK4JHei0XJGl8jbNQdgzEjSI2LLncK1220GvQfjV+eBIDw6K5/e75cL3kxkJW2VpafBzuPtX07DUp/PC2Zba1oe5zwddDqnedveiLMlk8wTW7SKI20QVRAvSy4cpC+pDDT6AQPIRlO3+dz0hqBF7AxWH3AtJo/eP/gxoAyONtqn2WwCh1VXnQaBavti86lDbH+3hXkFfu9ixHOpgDSydaZPDF6OfGqO
X-Microsoft-Antispam-PRVS: <MWHPR1301MB202902FD0A44D114A357A920FDE60@MWHPR1301MB2029.namprd13.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(182409339516656)(5213294742642)(209352067349851)(10436049006162);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(3231355)(11241501184)(944501410)(52105095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991055);SRVR:MWHPR1301MB2029;BCL:0;PCL:0;RULEID:;SRVR:MWHPR1301MB2029;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1301MB2029;4:kaEbN5xsGb4/RhggfP51N6QWiuEN4iJBTidNByq0H52kQHeOScFS2xzfXF+EmuOxk2d5U9p0A2Ojm0qgYoDU0Ici4+WSJ0ZZ028r6We7pJUChR2TDrrQ6Fkf65jy3uvOYujkY6yeOy8HVRucX4YDeEGLSyJhGCsp+FYKoyamdtxt8B/rpKVrt+jPvW4RgT6gi7C6lkdL9SsUwzBDXoB1etqyZvUuoYetERUzs8r66+6gcI3H9sfbDIUztgXuVSaVeLyqPsHQieUyr04veDFBkbL36ColtrSdaiwuHvHhg0p286Q7ipV6vSVA7ZGAM3KLg93DUhSmO5JoWF7RR3++oPUrLrxRrLkU0QFC7H5ucUT389vj2Rr0dnceSFsRf/s0yMcvOMX3C+/tGJJe7n+SEtE6mnpbGpDnTVxbspjDSmA=
X-Forefront-PRVS: 081904387B
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR1301MB2029;23:H/nSlF2tuyMHFWfJinr+LeKK6HtYBcT3H4+nd/Z?=
 =?us-ascii?Q?AsytoMNZm9oJXUJT3bc1SvvAcr24oxDwmsdGkKCiIoOsrRgKohOLVosdHVta?=
 =?us-ascii?Q?63Othb2ourCCjhWy8HKRxMQuBTZN7FTv489cAufJsb+pteWyp4ykXLvMRLGX?=
 =?us-ascii?Q?Vf5moFOjsOVql+HJzxnHRl/jxy/5XneZbimMmT2L9GaX/dT0LBp+REycgHda?=
 =?us-ascii?Q?tJKFPmlheCmr5AQrkWaeB2bWaqRZ6tX3nXXs0mzWvt8g4Pt92bOVyv+L01CK?=
 =?us-ascii?Q?HwfXS7yMy0M2sRmlBTmI87XzeCE55eRzsCI5XmB9ZI6VIHZ31uNEUcJXr2F0?=
 =?us-ascii?Q?DRgi8RzzDkLXcAIum2vhTeveh0pph0Rmml9B0P1Ur+mfBhvoICM74ERf/5Wz?=
 =?us-ascii?Q?nk90dHibU/MgEo3UmC0nyygTP+s87qevDUEUvzNSnqJ5zDKOZmTBputhD8ko?=
 =?us-ascii?Q?lERu79ysVl9CFq+bqqPyWaDffivwk2RAui38SIgQKvBRN+7C6cOrUf31/USQ?=
 =?us-ascii?Q?Wmw3OSZp52MUdmhz7Mup9TqrkpxLrTXEDIvCP8L7PgIdIg7p2QLqVZnRTyOQ?=
 =?us-ascii?Q?BQCWCC3Ll4mY0TRw1jsQip6QY0ANmU9XiA7xAcTyTPNqBbI16mOLEhzx0LNX?=
 =?us-ascii?Q?ZIJ08I3032Xsr0JooDrq8ARynvKuX5k4N3du01Qa3w+s61iMaidomQ9Zb2Gp?=
 =?us-ascii?Q?T+sqqV7OSATSPpY3AgQgastHUgn9ScHNtHGOvicPCxLAKm6jrm9ewHZT7vmv?=
 =?us-ascii?Q?RukezkkDh9OTYb07iKJotqTPee6HW1YfxSSI3TMetKDpKd7ysu2V1KK/z6CE?=
 =?us-ascii?Q?bQt5IEAMFdZnMaKFrWRp3VNdebiM++3+3s4R7su634KTl89QrCzoBg3WTw1F?=
 =?us-ascii?Q?zdxZz45gcAGUohyMNRBd9r1h5tJf/XGwBgKv+pD2fFXqvhDyMGz70EOr5gI+?=
 =?us-ascii?Q?4GIehA39yMPlqQfQ+MdAgOLEpkxos1oARNmXLqzKiYgCEms+D4ljpLAlgLV3?=
 =?us-ascii?Q?FNM7x8KyWMMOcLOTdpkJLQ3fsoIGIHdzTAOEiqzz7LVFMlyOtGKnla+ic/vf?=
 =?us-ascii?Q?dejarpusSPHrOQNxzvzS3tlE6LwaqDuv8ZbDC3fLIyFpfwMgagOkcihJY6TR?=
 =?us-ascii?Q?7jBk8uL/KNjEl73eSwECltYOQenKtyv6CkIEQjmUpa1yOWKo4Ok2eLuJdeSb?=
 =?us-ascii?Q?I197XsPB7mfaDysDL6zmnK9fKHDWZ5fVEnlgAChR2+fPJVQkMhVUKS2Vc0aV?=
 =?us-ascii?Q?LbyKriuwS/JJSHgZ3L1oGi/m/LuBbJnZUvL5Vu7MHjtcbRSqPPSbZSejwM5d?=
 =?us-ascii?Q?A52dXUTO4ztwdoZDtOTG2Jovb2cKvJ+KmGd/o9CP/iYSsIrX96sr8Y5I1rEu?=
 =?us-ascii?Q?wqeXYvtCIbp33ZDP80j1w2F8gOFmJpFyoPfiFcowtHRnmeUV7/QKLlFLmAWK?=
 =?us-ascii?Q?BR10AcF093w=3D=3D?=
X-Microsoft-Antispam-Message-Info: +9bDZIf+//joeAk+1qdGHcqVqY+a9BKU0PnpiwjY2qzd3TXsCDaj879QMAIlTU5lAuUZJH2i3p7kNLDbwLXl/dnJneW/T/OrOxPyc1SWXTnncls4futi0gkIBuLJbGsXWn7FHNVZAXVJijgCo3Fd4v0uNkPEyej1P8Z6i7fNvdX17ZbzaE/2lobyj/a5nKvrGGRNF/gvSiRinkn0lKY9LeHtY2nushUffTwvmRenb13Y7GiRBrmB+QkK2zHU17llIz3S1+JoJZwywTvEAdCx/pwDu5zX1/scvgLAIlopMmuRv+pl8Jf00MixTb7tmcxPLvE+sTvE6XIGyH8GPMolN5fIEBEZ6tF4mqNb+VToW4U=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1301MB2029;6:lcKeC65hXA4ZNmTMzRd3VqeBViQ2IRB+q80jBqv1xj+3rr1BZvuR6hEKlyKf0yAW+3c3p7eKjvTt5sx9Atm5L/Cs7RgEAPha2FvkLjg1vh9V2jA6h0ns6q2TAM28CCbzi75811bgkcYujDgfADH+O9g8WBu04CLTJWsEId/JopO/lWp59DjBdWv5FwsI8ruHuShheM/S+vVgDvr84dXkM+203/JmWRLwbRlL2Hc5XSqj3HJnaFD8sHJEyIN+G5M+ExdQegzWUa1YYvgI4JEr09ibw511wKfnS0+Y7I6k8KWzP6qtJ1DDb5j9magksqdvIqyov5HjB7pn0bVPt+ia/tVPnKM3rsH0rABdi82aY24tSRCtmuUn/ma9T7/bgd2kFIMf6xL/h0/Q33NffETEMQNtcLo2MSUrBIFnl+cLEtw5K7R1P9mL8/oRK4CqFbdmZefsj1r2Yu8CP2TuIirzVg==;5:KiXlUk9J3YCwJHC+n5NEmc6mD7SX9JKheX6nycYS6Nomz5c/dW51qakUcgbkNnRDdeet0+fTDAtaINfub3ZK59Ql7KZ03hjNkklZsoI0TPhpYftuLOjlzhZqd7HEMxZY+o6rywYA+xTdki1HkO7zjxFIy4yBp0+M9468YbkeRfk=;7:z8Y8TeC+BmFlAFgYtqu67++yag0kGsJE97UoVdP973vCr/S1UJZdu4UGPGn17aMC0pBoZOVbhKuuUrrLVhkw7K+F99XTOtdEfngIJKkPRE+HKMn2RkOhL2eP9FNTODTAdXXPOxpNA+n+3hc8mO1WfmMtWF2ZNt+/L1JZwdnUt/9kfEhnc6+DSCr4JllTPUGXdnY51zc61i3qYugRdJHttHqvanwmiPAHQgDUDRVgqsAQidontAZADNUOAhAk36u8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 14:36:02.4675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d42c54-69bc-4b79-77e8-08d62d2b5f6f
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[160.33.194.230];Helo=[usculsndmail03v.am.sony.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1301MB2029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Laurent Pinchart
>=20
> Hi Tim,
>=20
> On Monday, 8 October 2018 17:12:05 EEST Tim.Bird@sony.com wrote:
> > > -----Original Message-----
> > > From: Josh Triplett
> > > On Sun, Oct 07, 2018 at 08:18:26PM +0300, Laurent Pinchart wrote:
> > >> On Sunday, 7 October 2018 14:35:14 EEST Josh Triplett wrote:
> > >>> On Sun, Oct 07, 2018 at 10:51:02AM +0200, Geert Uytterhoeven wrote:
> > >>>> Providing an explicit list of discrimination factors may give the
> > >>>> false impression that discrimination based on other unlisted facto=
rs
> > >>>> would be allowed.
> > >>>>
> > >>>> Avoid any ambiguity by removing the list, to ensure "a harassment-
> > >>>> free experience for everyone", period.
> > >>>
> > >>> I would suggest reading the commit message that added this in the
> > >>> first place. "Explicit guidelines have demonstrated success in othe=
r
> > >>> projects and other areas of the kernel." See also various compariso=
ns
> > >>> of codes of conduct, which make the same point. The point of this l=
ist
> > >>> is precisely to serve as one such explicit guideline; removing it
> > >>> would rather defeat the purpose.
> > >>>
> > >>> In any case, this is not the appropriate place for such patches, an=
y
> > >>> more than it's the place for patches to the GPL.
> > >>
> > >> So what's an appropriate place to discuss the changes that we would
> > >> like, *together*, to make to the current document and propose
> upstream ?
> > >
> > > I didn't say "not the appropriate place to discuss" (ksummit-discuss =
is
> > > not ideal but we don't currently have somewhere better), I said "not =
the
> > > appropriate place for such patches".
> > >
> > > The Linux kernel is by no means the only project using the Contributo=
r
> > > Covenant. In general, we don't encourage people working on significan=
t
> > > changes to the Linux kernel to work in private for an extended period
> > > and only pop up when "done"; rather, we encourage people to start
> > > conversations early and include others in the design. Along the same
> > > lines, I'd suggest that patches or ideas for patches belong upstream.
> > > For instance, the idea of clarifying that email addresses already use=
d
> > > on a public mailing list don't count as "private information" seems l=
ike
> > > a perfectly reasonable suggestion, and one that other projects would
> > > benefit from as well.
> >
> > So I raised this issue with upstream about 2 weeks ago, and here is my
> > experience:
> > 1) I suggested that the email clarification could be put into the coven=
ant
> > itself, or in a supporting FAQ.
> > 2) The project maintainer (Coraline Ada Ehmke) was pleasant and
> supportive
> > of changes to enhance the document, and said either approach would be
> fine.
> > 3) I noticed that there was a FAQ in progress of being created.
> > 4) After thinking about it, I decided that I didn't want to alter the
> > language of the covenant, because I didn't want to dilute the expressio=
n of
> > a need to get permission when revealing private information.
> >
> > My own opinion is that putting clarifying language in a FAQ is sufficie=
nt.
> > So I made the following recommendation for the (not yet included
> upstream)
> > FAQ:
> >
> > Q: Does the prohibition on publishing private information include email
> > addresses sent to a public list? A: No. Information that has voluntaril=
y
> > been published to a public location does not fall under the category of
> > private information. Such public information may be used within the
> context
> > of the project according to project norms (such as in commit meta-data =
in
> > code repositories), without that constituting a breach of the CoC.
> >
> > You can see the history of discussion in these two issues, online:
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__github.com_ContributorCovenant_contributor-
> 5Fcovenant_issues_590&d=3DDwICAg&c=3DfP4tf--1dS0biCFlB0saz0I0kjO5v7-
> GLPtvShAo4cc&r=3DrUvFawR4KzgZu1gSN5tuozUn7iTTP0Y-
> INWqfY8MsF0&m=3Db6Q42NB0w9BZPta7p9Iyr2Lw91cD5dszFL52DzV3FL0&s=3D17
> HaUjlX7xwXIvGmJLYhuclrQ1ze-ySl5xLrWIKUDbU&e=3D
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__github.com_ContributorCovenant_contributor-
> 5Fcovenant_issues_575&d=3DDwICAg&c=3DfP4tf--1dS0biCFlB0saz0I0kjO5v7-
> GLPtvShAo4cc&r=3DrUvFawR4KzgZu1gSN5tuozUn7iTTP0Y-
> INWqfY8MsF0&m=3Db6Q42NB0w9BZPta7p9Iyr2Lw91cD5dszFL52DzV3FL0&s=3Dp
> MGMapO3n9KVVxipezDC8cn2BvpY2xmJKq0T7p-Gt1E&e=3D
> >
> > I hesitated to post these, because a formatting error in one of the pos=
ts
> > makes me look a bit dumb. :-)
> >
> > I don't know what progress is being made adopting the FAQ, but Coraline
> > seems very supportive, and I've told here that I will come back and hel=
p
> > with it if it stalls.
> >
> > Honestly, I believe Linux will adopt its own FAQ or some similar docume=
nt,
> > so with the Contributor Covenant adopting the clarification as a separa=
te
> > document, I don't know if Linux would inherit it (ie include the Covena=
nt
> > FAQ in our source tree).  However, I think that the existence of this e=
mail
> > clarification in the upstream FAQ would still have a beneficial effect =
for
> > all downstream users of the covenant, so I view this as a useful exerci=
se.
>=20
> The main argument I have heard against amending the code of conduct
> document
> itself is that a fork would make it more complicated for project members =
to
> understand the expectations, in a similar fashion than the fragmentation
> created by license forks. If we end up having our own FAQ, which would
> need to
> be considered in combination with the main document to understand its
> impact,
> doesn't that create the same problem ?

I'm not currently persuaded by the argument about modifying the CoC.
I see pros and cons, but 1) we have already changed the wording, and
2) I suspect that wording changes we adopt will not be that confusing
to rationalize with the upstream document, and 3) I don't think that
upstream will change so radically that it will be difficult for us to adopt=
.

So I guess a shorter way of putting this is that I'm not worried about a
fork.  The document is not long, and there should probably be debate
in the kernel community before adopting any significant upstream change
to the CoC. (similar to the debate and eventual rejection of GPL v3)

I have a similar opinion about a supporting FAQ.
 -- Tim

