Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99720C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E3E2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfAGQoQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:44:16 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.210]:13860 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726668AbfAGQoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:44:16 -0500
Received: from [67.219.251.53] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-c.us-west-2.aws.symcld.net id 7E/0A-21504-ED1833C5; Mon, 07 Jan 2019 16:44:14 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRWlGSWpSXmKPExsXi5LtOQPdeo3G
  Mwe7jghaHF71gtPj67Ta7xc1P31gtLu+aw+bA4rFz1l12j1/b1rB4fN4kF8AcxZqZl5RfkcCa
  cefpGqaCA4wVi8/sYmpgnMnYxcjFISSwilFi7cXTbBDOakaJTW1XWSGcPYwSBxZuB3I4OdgE9
  CW+/TnIBGKLCKhJbHt3CayIWWAto8TZpX+YQRLCAo4Sp2/fYIQocpI41zQNqIEDyPaTOHhKEi
  TMIqAicaP9N9gcXgFDia/Ns9ghli1nkpg7tx2sl1PAQ+Lu+o1gNqOAmMT3U2vAGpgFxCVuPZk
  PZksICEgs2XOeGcIWlXj5+B/YoaJAC1oO7mGBiCtIfD44jw2iV0diwe5PULa5RP+zV1C2tsSy
  ha+ZIQ4SlDg58wkLyM1CAsoSDVd4JzBKzEKyeRaSSbOQTJqFZNIsJJMWMLKuYjRPKspMzyjJT
  czM0TU0MNA1NDTSNTS20DUz0kus0k3WKy3WLU8tLtEFcsuL9Yorc5NzUvTyUks2MQIjPKWgy2
  4H49zu9EOMkhxMSqK8s/KNY4T4kvJTKjMSizPii0pzUosPMcpwcChJ8Do1AOUEi1LTUyvSMnO
  AqQYmLcHBoyTCqwmS5i0uSMwtzkyHSJ1itORY8f3vdGaON4s6ZjBzHO/8OodZiCUvPy9VSpz3
  AEiDAEhDRmke3DhYOrzEKCslzMvIwMAgxFOQWpSbWYIq/4pRnINRSZg3BWQKT2ZeCdzWV0AHM
  QEd9JLHAOSgkkSElFQDY7jr/ZZ3ogurFD+clZp6lyX5ed2WncKfKgtUjjMdl7S+co6v6v9X1T
  Qhjs8Wv/hNIuUP8xafjeT+dfuKZL7kamPeMP194dfvCQmf7jNjcotOvfrj+ON9ybN6f1ZoMj8
  KTc5VkEoVrg1ZN3VX06yJ3M0CjuY7U9zcW+v+1R87eirnVMBth7ibSizFGYmGWsxFxYkAbrJ8
  foIDAAA=
X-Env-Sender: Alex.Gonzalez@digi.com
X-Msg-Ref: server-2.tower-365.messagelabs.com!1546879453!1235041!1
X-Originating-IP: [66.77.174.16]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2800 invoked from network); 7 Jan 2019 16:44:14 -0000
Received: from owa.digi.com (HELO MCL-VMS-XCH01.digi.com) (66.77.174.16)
  by server-2.tower-365.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 Jan 2019 16:44:14 -0000
Received: from MTK-SMS-XCH05.digi.com (10.10.8.199) by MCL-VMS-XCH01.digi.com
 (10.5.8.49) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 7 Jan 2019
 10:44:13 -0600
Received: from DOR-VMS-XCH01.digi.com (10.49.8.98) by MTK-SMS-XCH05.digi.com
 (10.10.8.199) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 7 Jan 2019
 10:44:12 -0600
Received: from DOR-SMS-XCH01.digi.com ([fe80::894b:3bdc:74ae:6efc]) by
 DOR-VMS-XCH01.digi.com ([fe80::c47f:be41:1dc7:5ab8%11]) with mapi id
 14.03.0415.000; Mon, 7 Jan 2019 17:44:10 +0100
From:   "Gonzalez, Alex" <Alex.Gonzalez@digi.com>
To:     Bastien Nocera <hadess@hadess.net>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: goodix - decouple irq and reset lines
Thread-Topic: [PATCH] Input: goodix - decouple irq and reset lines
Thread-Index: AQHUpEatvIDOh1cYWEudJPd429h/UaWfM/8AgAIFKYCAArCrgIAAAXwAgAALygA=
Date:   Mon, 7 Jan 2019 16:44:09 +0000
Message-ID: <20190107164408.GA5564@agonzal-linux>
References: <1546617648-23445-1-git-send-email-alex.gonzalez@digi.com>
 <1546617648-23445-2-git-send-email-alex.gonzalez@digi.com>
 <20190105225147.le5fgpnvq7sctxe5@penguin>
 <6b8f757eb52eb74d9dc2c3bedbfec798a58c0ec2.camel@hadess.net>
 <5dfd17505a7c2f650f1102a8c0d7008ca8dc0b1f.camel@hadess.net>
In-Reply-To: <5dfd17505a7c2f650f1102a8c0d7008ca8dc0b1f.camel@hadess.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.5.24 (2015-08-30)
x-originating-ip: [10.101.2.194]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B2493A6C59AF6C4CA6F062DD60749A95@digi.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>If it doesn't work with the vendor code, then we might not want to make
>it work with our driver either.
>

Thanks Bastien. The vendor code does seem to require both INT and RESET gpios.
