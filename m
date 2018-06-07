Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fm+cKr5LGVuHXQAAmS7hNA
	; Thu, 07 Jun 2018 15:14:30 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2BB5B6063F; Thu,  7 Jun 2018 15:14:30 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="pJPsj5WD"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AD8FF601B4;
	Thu,  7 Jun 2018 15:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AD8FF601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=de.bosch.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936021AbeFGPO0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:14:26 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:49760 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935988AbeFGPOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:14:23 -0400
Received: from fe0vm1650.rbesz01.com (unknown [139.15.230.188])
        by si0vms0216.rbdmz01.com (Postfix) with ESMTPS id 411pws3ppvz1XLFsv;
        Thu,  7 Jun 2018 17:14:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=2015-01-21; t=1528384461;
        bh=5rxI6fYL9wd3HGUtcwlzBi6RuUarhfuGqGmpjdvD9c0=; l=10;
        h=From:From:Reply-To:Sender;
        b=pJPsj5WDtq89w3bBkM3GNhfDycWGEw4wxJYSEl+sGqO7TkkddCrAr+InkVKgmorF4
         Doj0PSinn8Q4C68BgwyKLvt/rzGn9PZ6sMAS0xBVYhrz2oOkaKPyifvb5Mv10btxxz
         A3E3RROlkpKDKRJDJAVpGUZyPr+xCxTSUsRob4AM=
Received: from fe0vm1741.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1650.rbesz01.com (Postfix) with ESMTPS id 411pws3Qtnz1C7;
        Thu,  7 Jun 2018 17:14:21 +0200 (CEST)
X-AuditID: 0a3aad15-9f3ff70000007ca2-a4-5b194bd6d77a
Received: from fe0vm1652.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm1741.rbesz01.com (SMG Outbound) with SMTP id F1.D4.31906.6DB491B5; Thu,  7 Jun 2018 17:14:30 +0200 (CEST)
Received: from FE-MBX2049.de.bosch.com (fe-mbx2049.de.bosch.com [10.3.231.59])
        by fe0vm1652.rbesz01.com (Postfix) with ESMTPS id 411pws1fBhzBpBg;
        Thu,  7 Jun 2018 17:14:21 +0200 (CEST)
Received: from SGPMBX2026.APAC.bosch.com (10.187.83.38) by
 FE-MBX2049.de.bosch.com (10.3.231.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1466.3; Thu, 7 Jun 2018 17:14:20 +0200
Received: from FE-MBX2051.de.bosch.com (10.3.231.61) by
 SGPMBX2026.APAC.bosch.com (10.187.83.38) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1466.3; Thu, 7 Jun 2018 23:14:17 +0800
Received: from FE-MBX2051.de.bosch.com ([fe80::d5b5:44fa:ef15:153e]) by
 FE-MBX2051.de.bosch.com ([fe80::d5b5:44fa:ef15:153e%6]) with mapi id
 15.01.1466.008; Thu, 7 Jun 2018 17:14:16 +0200
From: "Jonas Mark (BT-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Heiko Schocher <hs@denx.de>,
        "ZHU Yi (BT-FIR/ENG1-Zhu)" <Yi.Zhu5@cn.bosch.com>
Subject: Re: [PATCH 0/5] can: enable multi-queue for SocketCAN devices
Thread-Topic: [PATCH 0/5] can: enable multi-queue for SocketCAN devices
Thread-Index: AdP+chLnyTJ2ZZYkTkCGsiGJDRAw4g==
Date: Thu, 7 Jun 2018 15:14:15 +0000
Message-ID: <b7f078ad43104de9bf2e7dbbe6a2a463@de.bosch.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.19.142.147]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA22TfUwbdRjH+fVaOCoHx0HLA8qylcVF3aBMdA1Mxwwv3ZYY/9I4TPSwN9qM
        tqRXEIgm0DjpoLoXN15Kx2CTbbKRtphldEMr3UZhSMjAqGQKTBmupIgLI0yWoXdrof3D/563
        z/d5ft/L4Rh1GU/BNTojY9DRpbJIsVCc3Z267ad9yUXy/to0he/odaTo/XUKU3Qtn8QU41dt
        kQr7mRNCxUC7VNE56RLlRinbrINCpcv6W5TywdgdpDzyRK5c7Nnwlmi/eKeKKdVUMIaM1z8Q
        q5dcW8tWiMp/lrsFNegHoh5F40BmQY3fK6pHYpwimwXgWvAFkz4El5xtwWQBwe/TDsF6Mj99
        DQUSN5f4R0S8WCSZDXXnhqPqURSeSGaAu4Ifwch+AZxe/RzjRxLIAnCPnhLwcSJZCPfqWjgd
        nIvToa07ng+F5GZYPJLPTxBkDpgmLyI+RmQqOByjT1UwMgl6ZpdFgReQ8FVfoA6kBHx/rIp4
        GSA3ga35DT7EyBfAfjUjQG6CEw13owLq8TDUMiM8iqTWMFFriLCGEdYwoh0Ju5DkACOv0Gbu
        yMpMNxQzbLU8M/1DvbYHBb6gpBd1dLztQSSOZDHEvoLkIkpEV7BVWg96BRfIJMSZNCiiYov1
        qio1zarfN5SXMqwshUARERFUwnqZLS/WalhWo9d5EOCYLJGgx6RFFKGiq6oZgz6AedCzuFCW
        RFhUH++nyBLayBxkmDLGsNbNwXEZEN/v5W6INzAlTOUBTalxrS1LDeyUhnfC1wrwaA96GY/h
        dst5CYIto7WspiSIJwdwaq0aQm+hPbj/M4sFw2fGGy0YJdTpdUxKEpHLq5D8vLpct35HynPE
        ln7OEklYI6Q1hyYQ52QCcYqHY7jfJXQBEL0Jtnep+GAxBG3v5BjyfiS4J8YR2FfnMfjUezoa
        nJ3fPQP+s2YCzJ7LBLhbj8fCSsvJOLAcPkSBy7dAwZfH+iTgfHRjA4ytnE0D80DXVni45N0G
        N2/Yt4PZ9GMWTDq+fhUWzVM58O/1Rzuh9abzNRj0f7ELnOftueC7NJUL7k7Tbmh+OJwHjxdn
        8uCCrTYfrk1P5HMCo4Xg6bUowT1k2zPH2Svg7FViT+010sb/sTdYDb0upQYNvTfSTW9UmYq9
        JsN8bauSNN92bz5G/Py4ztHQEbsjrmWLv6q98aXG8YMOf820+M07+uNLaeU9f4617JqtbmCv
        jNi+nfUd+vuT2L+kTTED32wkJK0Xf8kbLpxTyzseJHrvNomznzcWCHbfj3ty78o5etBUmd41
        W3/rcLz9o9vvNHWIZUJWTWe+iBlY+j8cBYg8yAQAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keSwNCg0KPiA+IFRoZSBmdW5jdGlvbmFsaXR5IGJhc2VzIG9uIGFuIGV4dGVybmFsIHBl
cmlwaGVyYWwgY2hpcCBuYW1lZCBDb21wYW5pb24uDQo+ID4gSXQgb2ZmZXJzIHR3byBDQU4gaW50
ZXJmYWNlcywgZWFjaCBoYXMgOCBwcmlvcml0aXplZCB0cmFuc21pdCBGSUZPcyBhcw0KPiA+IHdl
bGwgYXMgb25lIHJlY2VpdmUgRklGTy4gQmVzaWRlcyBDQU4sIHVuZGlzY2xvc2VkIGFkZGl0aW9u
YWwgZnVuY3Rpb25zDQo+ID4gY2FuIGJlIGFjY2Vzc2VkIHRocm91Z2ggdGhlIGNoYXIgZGV2aWNl
Lg0KPiA+DQo+ID4gQSBzdGFuZGFyZCBTUEkgaW50ZXJmYWNlIHdpdGggdHdvIGFkZGl0aW9uYWwg
bGluZXMgZm9yIGZsb3cgY29udHJvbCBpcw0KPiA+IHVzZWQuIFRoZSBDb21wYW5pb24gY2hpcCBp
cyB0aGUgU1BJIHNsYXZlLg0KPiANCj4gQ2FuIHJlbW90ZXByb2MgQVBJIGJlIHV0aWxpemVkIGhl
cmU/DQoNClNvIGZhciBJIHdhc24ndCBhd2FyZSBvZiB0aGUgcmVtb3RlcHJvYyBBUEkuIEl0IGFw
cGVhcnMgdG8gbWUgdGhhdCBpcw0KbGltaXRlZCB0byBwb3dlciBvbi9vZmYgYW5kIGxvYWRpbmcg
ZmlybXdhcmUgaW4gYW4gQU1QIHNjZW5hcmlvLiBIZXJlLA0KdGhlIENvbXBhbmlvbiBoYXMgYSBm
aXhlZCBmaXJtd2FyZSBpbiBpdC4gSXQgbXVzdCBhbHJlYWR5IGJlIHJ1bm5pbmcNCnF1aWNrbHkg
YWZ0ZXIgcG93ZXItdXAsIGV2ZW4gYmVmb3JlIHRoZSBib290IGxvYWRlci4NCg0KRG9lcyByZW1v
dGVwcm9jIGFsc28gY29udGFpbiBhIGNvbW11bmljYXRpb24gZnJhbWV3b3JrPw0KDQpEbyB5b3Ug
bWVhbiBycG1zZz8gSGVyZSwgSSBkbyBub3Qgc2VlIGhvdyB3ZSBjb3VsZCBiZW5lZml0IGZyb20g
aXQuDQoNCkNhbiB5b3UgcG9pbnQgbWUgdG8gYW4gZXhhbXBsZSB3aGVyZSBycG1zZyBpcyB1c2Vk
IG92ZXIgU1BJPw0KDQpHcmVldGluZ3MsDQpNYXJrDQoNCkJ1aWxkaW5nIFRlY2hub2xvZ2llcywg
UGFuZWwgU29mdHdhcmUgRmlyZSAoQlQtRklSL0VORzEpIA0KQm9zY2ggU2ljaGVyaGVpdHNzeXN0
ZW1lIEdtYkggfCBQb3N0ZmFjaCAxMSAxMSB8IDg1NjI2IEdyYXNicnVubiB8IEdFUk1BTlkgfCB3
d3cuYm9zY2hzZWN1cml0eS5jb20NCg0KU2l0ejogU3R1dHRnYXJ0LCBSZWdpc3RlcmdlcmljaHQ6
IEFtdHNnZXJpY2h0IFN0dXR0Z2FydCBIUkIgMjMxMTggDQpBdWZzaWNodHNyYXRzdm9yc2l0emVu
ZGVyOiBTdGVmYW4gSGFydHVuZzsgR2VzY2jDpGZ0c2bDvGhydW5nOiBHZXJ0IHZhbiBJcGVyZW4s
IEFuZHJlYXMgQmFydHosIFRob21hcyBRdWFudGUsIEJlcm5oYXJkIFNjaHVzdGVyDQo=
