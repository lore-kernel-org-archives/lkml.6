Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E709C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1633121536
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="twx6mkt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1633121536
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeHQR6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:58:04 -0400
Received: from mail-db5eur01on0047.outbound.protection.outlook.com ([104.47.2.47]:32256
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726437AbeHQR6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsLhoiwcNr/0qAvDvJb7zXqb0xVF4o8w8F8TP/Pxl6o=;
 b=twx6mkt8tJSV/7NhE4gxkuTpMFpNBHben/AyO5xglCYMTSoDhMxhEgGC2uoTqgxrcccawIqCJBChRlgYf9isGI0kN7DcRopqyAlgmp/po8RHoduL4B+mnEZNqTEk5hBcjp+BOC4Purz6L7khCmtyiDAMQ9fqzbfoXiZQwl9TLOY=
Received: from DB6PR06CA0035.eurprd06.prod.outlook.com (2603:10a6:6:1::48) by
 VI1PR06MB1134.eurprd06.prod.outlook.com (2a01:111:e400:518c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.21; Fri, 17 Aug
 2018 14:54:18 +0000
Received: from VE1EUR02FT025.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e06::209) by DB6PR06CA0035.outlook.office365.com
 (2603:10a6:6:1::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1059.20 via Frontend
 Transport; Fri, 17 Aug 2018 14:54:18 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.48)
 smtp.mailfrom=cern.ch; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.48 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.48; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.48) by
 VE1EUR02FT025.mail.protection.outlook.com (10.152.12.109) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA_P256) id
 15.20.1059.14 via Frontend Transport; Fri, 17 Aug 2018 14:54:18 +0000
Received: from cernfe06.cern.ch (188.184.36.49) by cernmxgwlb4.cern.ch
 (188.184.36.48) with Microsoft SMTP Server (TLS) id 14.3.399.0; Fri, 17 Aug
 2018 16:54:15 +0200
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.399.0;
 Fri, 17 Aug 2018 16:54:17 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Alan Tull <atull@kernel.org>
Reply-To: <federico.vaga@cern.ch>
CC:     Moritz Fischer <mdf@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        "Appana Durga Kedareswara Rao" <appanad@xilinx.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <linux-fpga@vger.kernel.org>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        Alan Tull <atull@opensource.altera.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH 2/2] fpga: add FPGA manager debugfs
Date:   Fri, 17 Aug 2018 16:54:16 +0200
Message-ID: <3209150.S88njOrd88@pcbe13614>
In-Reply-To: <CANk1AXTUYTEJgWneS1n2WwaqyOAmohYFFoXOU51XX6j02=q9xw@mail.gmail.com>
References: <20180815220958.3606-1-atull@kernel.org> <2759044.uKe7sI2ItL@pcbe13614> <CANk1AXTUYTEJgWneS1n2WwaqyOAmohYFFoXOU51XX6j02=q9xw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.48;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(2980300002)(438002)(199004)(189003)(50466002)(26005)(126002)(46406003)(476003)(44832011)(33716001)(4326008)(186003)(106002)(14444005)(486006)(16526019)(74482002)(8936002)(2906002)(316002)(54906003)(966005)(3450700001)(786003)(478600001)(6116002)(76176011)(33896004)(97756001)(229853002)(53546011)(9686003)(6306002)(7416002)(336012)(246002)(5660300001)(86362001)(7736002)(7636002)(106466001)(9576002)(230700001)(426003)(356003)(305945005)(8676002)(6246003)(23726003)(43066004)(446003)(47776003)(6916009)(11346002)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR06MB1134;H:cernmxgwlb4.cern.ch;FPR:;SPF:Pass;LANG:en;PTR:cernmx12.cern.ch;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eff8ebdd-81e7-4073-4f92-08d604514f0c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:VI1PR06MB1134;
X-MS-TrafficTypeDiagnostic: VI1PR06MB1134:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR06MB1134;20:HR5w3zGOhUGW37z15JLZ1exNsB/01ZCaVrsckbVImgb52F6EPfqac/raQGuT1sP8TI3/y9tvCzTFZcZ+pQTMUvof6hTUeQVQcmUerOjPo89k4DtjWEa4/C8e2gvf1yiGitd9uaGmXuoxY0s/NhMc9C7731jKQsDu6PfpN+BdEdfko9Kg/OvL35DdIjG0rwapYOpsT3J/2AMHxJ8DB0Dasp3vXAlZVvIlHVublnh3eUd/crWromM+Oiy99D26PA0PXjMQ+vTWcaEeJc6cH3i/sPvpwjn8vRSAxuILoe6jd0vcL6FPDsHV+HyO7pDDrqg7pHKqDfyvN56pV0yieKMLJ6QHLhgQjI5mY5A8TwX1MYxLZMUePIpSAavSzGZ2XwhxVfGwsiqSudKxwg5swAkUZHVdev6NU+1FUtdHA18TOQxJbJTr8Uxn/pq7Neh+zbb/CUeKETzeV6t0t2KfuJT3FZp0pGA/7M+zsf0TA+rym8Hh4yZDxyjXjefnAdL//9Vc;4:ls6Vu3C95wTafq/o1me0kB+sDlU+sMVFjXHLI1HA2u/Tzi5c68tr5tr884Zzq50fKxczNWy/NHslTmtSu/jPasdIXVlkznAISWIbP7J2xHrXRdvv4oB+gbJSKF6qGJchtbo09i2beP4Re7XCpsrGghZRYQmxtAN5AqzEyjl3j7ErH2MFKNYlDfawIhnCw6EQso6CvOrEYHRybzr90DOOXxfDiVv7bGoOueRKkizvjujlDOChTYn6HLuvLZBepw2X2ZuqvoOCg/14DnUeNuGAfA==
X-Microsoft-Antispam-PRVS: <VI1PR06MB1134554C117996C79153ACCCEF3D0@VI1PR06MB1134.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93004095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:VI1PR06MB1134;BCL:0;PCL:0;RULEID:;SRVR:VI1PR06MB1134;
X-Forefront-PRVS: 076777155F
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR06MB1134;23:FNSTzbVf55dV85DEP8WUJiqWeInjVrQpLcdAQ0Dgf?=
 =?us-ascii?Q?oXFJr4h5wZr8prmmUkueMUwwo5cpunaHi9PkpRTygLxzV2o7iCzR4kaNWCng?=
 =?us-ascii?Q?Xid9W/enHsDHCre42SU4zrbrMxlHM5N+V1yZdFnDQryor3Euy+HwTtOZqIAG?=
 =?us-ascii?Q?XKPk8KcevJsFETiqUjhDmT70926EB95Skc3CMtR7UTmtsAeGA9jf/X6iecrG?=
 =?us-ascii?Q?QnJegk6fdFwKcz66CoKtYWSAJdVB1RNBELjGi/6ZwC0lPRabnGvTucHiGxNk?=
 =?us-ascii?Q?31NBjmIZGWnTRX7P82xYM3aZYyAVOhwBaxEuAfwB+qdS7kS7OgTl/cXMwi3+?=
 =?us-ascii?Q?P+ExwtQRDDSTk/7DW8bV/D3ZcQj8yRnvnQkjBwCYfMbqJoidU5qZ9EPxMQvz?=
 =?us-ascii?Q?AT4TNLxQDgyo86O3MWcpik/q1+vFIuJ0kKGt5qgKoLvS4BJNJrXqxGCbyQIZ?=
 =?us-ascii?Q?Dp4YhK2+QPJH2p4i4iDVZAZPXXuEX5rFYgbEqJo1mqaNrTOTxQUON2zmW2ar?=
 =?us-ascii?Q?qkaev/xXKPWjleBRGgfSoF76kVAgmB3hRw9Jo62sa9ibgbyAbth3XMf+6Q8o?=
 =?us-ascii?Q?iwaADN2DiyJm3xC+ermvXhm/7gzlt+P1eVArQsZHgrLCbjbbaUe25ITTer8z?=
 =?us-ascii?Q?Nln9IRPGLWvBe9LheUItYfyyCjZu81OEa/NuOfvKroL2yi38XytLPcLlWRLo?=
 =?us-ascii?Q?4kowE7g3m8LbbsW6pQ8BobxczuSWSf8w6KO8M69C/jAnux6JpikEDRsv+jD+?=
 =?us-ascii?Q?e8ZUguUF+/lHVmjXA4/SAgawzhWuvLHVkxGIUHes/4liQzA7augAeMyM08ki?=
 =?us-ascii?Q?b2CkEc/SHdXWzagQ4bPjf5jzx/lSlSrYiszW9d0/NmD4iEHdLwBbrhvt2h2R?=
 =?us-ascii?Q?S9LihOSkiOJBL3BERCaoLIFgKco+k+bwnmPsocy1ECLIGCYJJiLH0uMIuLoI?=
 =?us-ascii?Q?83ksf6kDcjj26xYoi+NHjtBS07t8tEWEYlTBoe+yniY9XYRAVHHgPbaspBeX?=
 =?us-ascii?Q?AwttVtMbSKjZCFdbbjQ9PTLy/b5v0IBIciXhcAhTUoTM6IHgYdjm8CMDbvYr?=
 =?us-ascii?Q?SWrEyMUup6J4XkfuWsB5g66iSPkZzrtE4y/73yjB/GoXtny97wGLxlpcpKzI?=
 =?us-ascii?Q?s2BfT3TdeucO/7Dw8Vw11g2TQsDRYYDPIJHgCKfAoXmEOjUz5pNFDyGb4nkb?=
 =?us-ascii?Q?yLqqp+pxIosyCeH3PAgKVhWwcibh4MooMMaIP8vWiQp8sP6Ynvh2p4yaN/g+?=
 =?us-ascii?Q?73BG5grhV7TIpuxss5MqeYB3eSBphZ6ZYBF4S2DYxcoDGCpGwZuDqpVQfWUG?=
 =?us-ascii?Q?4TyxqarFYFjyv0HEsJ3Kws=3D?=
X-Microsoft-Antispam-Message-Info: +SgywXc64TtfWCRzcDTUQvY63Ewr2UZGXKQyB8aEWIMIotHH6xxtdtxznuQaevm9rSkQCpK7/EL9PRVgTN+Q6y1HFqaHDN/ud4xMMOHzkgb5AfjyfBhQdAYVf50pn7M1QkxirdKjHdFlOflZqybZpN3UaXGw7IYW7noJTjm6nfP/ucZbsbX9CL+4qAH4hRuT7n9mfkQEnB45ahEtBpczvm4NA1zXK0JmjAcDcdDRemoSLXFI8oS+iWc686BfyxiaK87qU1kO+urDbvKm/BbFItkaXAE9XzUDZQv4i1elH3YchWt7Q2bhaoeBKCJrTeo7b0a+eccRd6ltuQAgskmy2Lia4iHw/hIhrDPHUEwBh2o=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR06MB1134;6:kjfH5w2wnt77eXXsGxO4oqwOTQfK+YDH1LVzswkAK2W8/68ovrmb5bqGVkW5qpM6GFC/PKZOpIOeY4odB1mcaBzqVc0EdCZGKhgJXaXmRKc+JbBwwOEPQC7nYsQSOz61atKOFeLng5iiR1jsWYp72YJAAcOuGRY47o55WZCMeH5cOLhkXKjtR2vOvVw013zXcxUy25cZrFfa+V64UgMafI4UCXTye6ke2tFLUutepKMvXRDPsRhl9M4PN9MnuP+zqhok4JnCQVc1gyVhwlHOdOBTy7cl7r67ZGJdYg8kmk6nsDJ+xTcTloeiy96sqhlGvdX0CGcXaj6vf2W9AG6rrODuZYFzCvKK8ibo1GlgV7AWQjtoMdpQM7aahClNWDaRshtkmwE0XTbuN10U6DkS0u0gqrCqxVzmPZ6ZVfc9deMCPT0OTzaxBHJA+Ppy0r6MARUXJ1DfNNFE6tkR/0OnhQ==;5:qZruCIa3YxCRrEynCTCVOrJJIFAQAYDhJcUpO1wYwXVXFjZwx3bAkM3A5/YO9Q1z05HgxlE6JVQhzPdIPpqlwZBlW+MGebeKDou2jB3DNh0+3La6zbwF353LBzcBbtnbjUpNsXBshrRp0A5lPdbe0286CvKVWJ7oPSYo9pClXtQ=;7:vuSbyL5fi4xZlNAWo7qdwGsJ6SNwUzx0WfUirEr59tX6A32xtcZ50hdPEGc267SvX34dO2sPzFHoHxDpi3FIM7AKFaSszZRZCjc+HgSBdI78HM/43MuzZeaIHTjrUm7ChcUEHaqb8qLi+dCo1jPudtFpNp0RF3cz8Sk1QzjvoIg2yKtJk00b4CpJG1A95zUr2dP1xYLRZlHa5pUjsSSPaIUBtCiU3kEZhjykQky4Qmqpays2FN9Kc+kqzWdjVMOy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 14:54:18.1916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eff8ebdd-81e7-4073-4f92-08d604514f0c
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.48];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB1134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 17, 2018 3:19:24 PM CEST Alan Tull wrote:
> On Fri, Aug 17, 2018, 2:00 AM Federico Vaga <federico.vaga@cern.ch> wrote:
> > Hi Mortiz,
> > 
> > I'm not 100% into the problem to understand all cases. I'm putting on the
> > table the point of view, mainly, of an user. If you say there are problems
> > here or there I believe you. At the beginning, you did not say that this
> > interface may introduce problems (and I'm interested in those problems
> > since I
> > implemented one and we are using it), but that you fear that it becomes
> > the
> > default (usually, being a default is a good thing).
> > 
> > Since you and Alan are working on this for a long time, you can read each
> > other mind, but I need a more verbose email to understand ^_^'
> > 
> > Of course the interface must be safe, I totally agree. In order to make me
> > understand what are the issues, can you list some of them?
> 
> Before we repeat what the doc l posted says, could you look at it and
> comment on what I'm not saying there?
> 
> https://lkml.org/lkml/2018/8/15/525

I read it, but do you mean that the problems you foresee are only the ones 
listed in there? If this is so, comments:

loading devices
It is true that it is a problem, and probably it is clear to everyone who will 
try to use such interface: "and now how do I load my devices?". But this is 
only a possible case, the FPGA may run without device driver and in this case 
it is perfectly fine for production.

If the answer to the above question is: "ok, let me see where my devices are 
in the memory ..." well if the machine crashes, it's their problem. This 
problem exists even without the FPGA manager.

bridge
My understand is that it is optional. Developers are allowed to not implement 
the bridge's operations. Which probably means that it does not exist or it is 
not needed.
When an user uses this interface from userspace it shouldn't be hard to detect 
if the operation is risky or not (bridge enabled/disabled). And if it is 
risky, the operation fails with EPERM, EBUSY.

I have to say that I'm not familiar with the bridge design, perhaps I'm 
missing something.


Conclusions
Yes, those are problems but I think they do not justify the label "not for 
production": in some cases I think is fine.



