Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEABC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF57206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfAHRUV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:20:21 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.116]:3646 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727484AbfAHRUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:20:20 -0500
Received: from [67.219.250.197] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.us-west-2.aws.symcld.net id E1/50-18998-2DBD43C5; Tue, 08 Jan 2019 17:20:18 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRWlGSWpSXmKPExsXi5LtOQPfSbZM
  Yg0fTRS0OL3rBaPH12212i5ufvrFaXN41h82BxWPnrLvsHr+2rWHx+LxJLoA5ijUzLym/IoE1
  o/P9YZaCW8wVL9esZ2lg/MfUxcjFISSwklFi0+dt7BDOHkaJT5NWMXcxcnKwCehLfPtzkAnEF
  gGyt8/+xQhSxCywhFHi8JmDbCAJYQFHidO3bzBCFDlJnGuaBtUQJrHsxyEWEJtFQEWi89F1dh
  CbV8BIYuaaA2wQ2zYzSbxZvRKoiIODU0BP4sp1H5AaRgExie+n1oDNYRYQl7j1ZD6YLSEgILF
  kz3lmCFtU4uXjf6wgtijQ/JaDe1gg4goSnw/OY4Po1ZFYsPsTlG0uceTBZEYIW1ti2cLXzBD3
  CEqcnPkE7AQhAWWJhiu8ExjFZyHZPAvJpFlIJs1CMmkWkkkLGFlXMVokFWWmZ5TkJmbm6BoaG
  OgaGhrpGhoDsYmpXmKVbpJeabFueWpxia6RXmJ5sV5xZW5yTopeXmrJJkZgJKcUtEzcwfhuef
  ohRkkOJiVRXrYqkxghvqT8lMqMxOKM+KLSnNTiQ4wyHBxKErxZ54FygkWp6akVaZk5wJQCk5b
  g4FES4fW9BZTmLS5IzC3OTIdInWK05Diw6OFcZo6bT54ByVPPgKQQS15+XqqUOO+xm0ANAiAN
  GaV5cONgae8So6yUMC8jAwODEE9BalFuZgmq/CtGcQ5GJWHebpC1PJl5JXBbXwEdxAR00CFGs
  INKEhFSUg2MRT+zZrp8b7EPL3wQFR7MJ/a/yHuiD/9Gq9PrJ60JlFfgaWs0nnDsWFWCauaU8p
  1BV/2PJ7r2+dw4EBvnvtsrRu/AhzjB+77rFqVdTPjMK/757P83NuvXq325eWndpXMWGUumL3T
  oVdiWmJZ37/aa5C1eKxK3eIpMkjmpsnb+vj/ybpdPMKYvVWIpzkg01GIuKk4EAL9EAa12AwAA
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-17.tower-345.messagelabs.com!1546968017!6413816!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16380 invoked from network); 8 Jan 2019 17:20:18 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-17.tower-345.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 8 Jan 2019 17:20:18 -0000
Received: from DOR-VMS-XCH01.digi.com (10.49.8.98) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 8 Jan 2019
 11:20:17 -0600
Received: from DOR-SMS-XCH01.digi.com ([fe80::894b:3bdc:74ae:6efc]) by
 DOR-VMS-XCH01.digi.com ([fe80::c47f:be41:1dc7:5ab8%11]) with mapi id
 14.03.0415.000; Tue, 8 Jan 2019 18:20:15 +0100
From:   "Gonzalez, Alex" <Alex.Gonzalez@digi.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     Bastien Nocera <hadess@hadess.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: goodix - decouple irq and reset lines
Thread-Topic: [PATCH] Input: goodix - decouple irq and reset lines
Thread-Index: AQHUpEatvIDOh1cYWEudJPd429h/UaWfM/8AgAIFKYCAArCrgIAADMuAgAAlW4CAAXeKgA==
Date:   Tue, 8 Jan 2019 17:20:13 +0000
Message-ID: <20190108172013.GA13290@agonzal-linux>
References: <1546617648-23445-1-git-send-email-alex.gonzalez@digi.com>
 <1546617648-23445-2-git-send-email-alex.gonzalez@digi.com>
 <20190105225147.le5fgpnvq7sctxe5@penguin>
 <6b8f757eb52eb74d9dc2c3bedbfec798a58c0ec2.camel@hadess.net>
 <20190107164225.GA5394@agonzal-linux> <20190107185607.GA141497@dtor-ws>
In-Reply-To: <20190107185607.GA141497@dtor-ws>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.5.24 (2015-08-30)
x-originating-ip: [10.101.2.194]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0EB1086BE73FA14DAE97C15A4442E3B3@digi.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>My concern with trying to do the address selection without RST line is
>that it is quite unreliable, as it really depends on timings between the
>chip reset, INT line being driven by the host and then being switched to
>input.

I think you are right. thinking twice I should be able to fake the reset line
by controlling a regulator to the voltage source for the pull-up. It seems a 
more solid solution.

Thanks a lot for your help and sorry for the noise.

Alex
