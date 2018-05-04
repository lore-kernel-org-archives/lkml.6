Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbeEDVmB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 17:42:01 -0400
Received: from mail-co1nam03on0133.outbound.protection.outlook.com ([104.47.40.133]:56480
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751582AbeEDVl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 17:41:59 -0400
From: Casey Leedom <leedom@chelsio.com>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] cxgb4vf: fix t4vf_eth_xmit()'s return type
Thread-Topic: [PATCH] cxgb4vf: fix t4vf_eth_xmit()'s return type
Thread-Index: AQHT287W3iNpHHawt0awZqvNR5y9pKQgKWlv
Date: Fri, 4 May 2018 21:41:56 +0000
Message-ID: <BY2PR1201MB0983B5AE34A93565090F4BB8C8860@BY2PR1201MB0983.namprd12.prod.outlook.com>
References: <20180424131902.5767-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20180424131902.5767-1-luc.vanoostenryck@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leedom@chelsio.com;
x-originating-ip: [12.32.117.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR1201MB1032;7:zbTevdq1r5Vdrp9bAoOmfVx8JRD+1Xxkl1fU+bdf0HNAxJrYTZxFhhbqd4J5rFR9iJJxRa1piXbYc1FGfZWI/L0KGzXMCdAAOOFiFIrM41DOvEUcvfnWrlBpQZflMs7GjzKW1b7aldeA8xe4mYlNv3+p/mpS6TitgbGChFw3JqMUxEC+gnOI8+SvQZJA+q0Vn9ebDAd5eEkMcgogCTnH1xin0t6HI/07FDLSkzuDWPTIhRZasyleKSpMGtNXgiAG
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BY2PR1201MB1032;
x-ms-traffictypediagnostic: BY2PR1201MB1032:
x-microsoft-antispam-prvs: <BY2PR1201MB1032DC66EAAAFA9538AD07F4C8860@BY2PR1201MB1032.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123558120)(2016111802025)(20161123564045)(20161123562045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:BY2PR1201MB1032;BCL:0;PCL:0;RULEID:;SRVR:BY2PR1201MB1032;
x-forefront-prvs: 06628F7CA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39830400003)(39380400002)(346002)(376002)(366004)(189003)(199004)(316002)(5250100002)(110136005)(2900100001)(55016002)(229853002)(6436002)(53936002)(3280700002)(33656002)(5660300001)(74316002)(99286004)(14454004)(7736002)(478600001)(9686003)(66066001)(68736007)(3660700001)(97736004)(446003)(486006)(476003)(76176011)(6506007)(25786009)(8936002)(305945005)(105586002)(106356001)(8676002)(2501003)(102836004)(86362001)(2906002)(3846002)(81166006)(7696005)(6246003)(39060400002)(186003)(6116002)(81156014)(4326008)(26005)(11346002)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR1201MB1032;H:BY2PR1201MB0983.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: khJIggK/adCWCAHeW115u1RXur/OatuOLGLl7AhJmpdS+e+21K7gIlgvMkt+larQQhV+INBWSRR3gljQWfzNnu6s9yMnCCcLyDpSCtsX+VKoc6CqfVqNpzJe+0nXZlLbA37IG8huwmOIM9k4ZKyqnz9jvN0xQxNMWVR7/VQDjyiKBJ6eFn0GktaWfnDcdq3C
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 1ccc00eb-ad9d-4ba9-75e4-08d5b207dc1e
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ccc00eb-ad9d-4ba9-75e4-08d5b207dc1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2018 21:41:56.8729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR1201MB1032
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w44Lg7Xe014003

| From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
| Sent: Tuesday, April 24, 2018 6:19:02 AM
| 
| The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
| which is a typedef for an enum type, but the implementation in this
| driver returns an 'int'.
| 
| Fix this by returning 'netdev_tx_t' in this driver too.

Looks good to me.

Casey
