Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbeDQI7n (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 04:59:43 -0400
Received: from mail-by2nam03on0042.outbound.protection.outlook.com ([104.47.42.42]:48576
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751147AbeDQI7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 04:59:40 -0400
From: Rafal Ozieblo <rafalo@cadence.com>
To: David Miller <davem@davemloft.net>
CC: "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Piotr Sroka <piotrs@cadence.com>, Lukasz Tyrala <ltyrala@cadence.com>
Subject: RE: [PATCH 0/3] Receive Side Coalescing for macb driver
Thread-Topic: [PATCH 0/3] Receive Side Coalescing for macb driver
Thread-Index: AQHT1DKrh4uO12ninEi+8bwBioxkGqQDgUeAgAEnuEA=
Date: Tue, 17 Apr 2018 08:59:35 +0000
Message-ID: <BN3PR0701MB1122B2FF2A1C54CD363B16A7C9B70@BN3PR0701MB1122.namprd07.prod.outlook.com>
References: <1523739187-20077-1-git-send-email-rafalo@cadence.com>
 <20180416.110855.61732218036810337.davem@davemloft.net>
In-Reply-To: <20180416.110855.61732218036810337.davem@davemloft.net>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccmFmYWxvXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYTVkMjk2YjgtNDIxZC0xMWU4LTg2ZmItZThiMWZjMTMxNjNhXGFtZS10ZXN0XGE1ZDI5NmI5LTQyMWQtMTFlOC04NmZiLWU4YjFmYzEzMTYzYWJvZHkudHh0IiBzej0iMTgyMCIgdD0iMTMxNjg0MjkxNzQ4Nzk1MDgxIiBoPSJaZlFuYzNENm1pOHAzaThpcU0yNTdRb2FteGs9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-tag-bcast: 
x-dg-paste: 
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rafalo@cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0701MB1171;7:FeneZLu4Zc6xeyGO8K4pXYoPB9V7n1S+cAfa0LzYoHwmndo9L787t7+l4ghrVcRUg51VwOCiNZOXOwigUtOGGViqOvbHYDpLz0DcUdU25JlQd9B8GCJZiOsQBDCOgp3ai41IzAEaxSroDNfAst4FUtCzmFEspUjxT2UA4pyxIVOyP5+XqHTmFzsxTERq2rXUngWrIMj1VF7+G5K9E4X5YCGMh2VJ8Xe3B5lhOQY0fc02u6oy6mQtHK4j1OgI3s6T;20:KUXCptC6n+qF9P4zxMiiWecYlxTwISEEFS//58/jiBDLtrd/FIQL06PHNbOsI2Gp4mP+nNlVGHBONgamPBY9KsqGkqKkps3zH+VBYYs6UmUpb/q+v2J5TIA1ld6+vd3cp3zWXBVjRc1wyNzT3cZyAVEmWylZicZsIbb9HJ+zPkh4Xn8RodeqL+U/PSBuHHvoRT0HnF1aUN9/09N/tq6vTEnj50udmGFH1PJesKqWO3RVEd4gtmpDMcUEila8pqC4
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39380400002)(39860400002)(199004)(189003)(36092001)(3280700002)(7736002)(66066001)(5660300001)(107886003)(6116002)(3846002)(3660700001)(6246003)(4326008)(476003)(5250100002)(86362001)(486006)(446003)(68736007)(11346002)(25786009)(229853002)(6436002)(97736004)(6916009)(76176011)(99286004)(6506007)(7696005)(54906003)(316002)(102836004)(26005)(186003)(105586002)(33656002)(9686003)(478600001)(74316002)(305945005)(55016002)(53936002)(2900100001)(81156014)(81166006)(14454004)(106356001)(8936002)(2906002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0701MB1171;H:BN3PR0701MB1122.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN3PR0701MB1171;
x-ms-traffictypediagnostic: BN3PR0701MB1171:
x-microsoft-antispam-prvs: <BN3PR0701MB1171058573DA05D33B7CFBF1C9B70@BN3PR0701MB1171.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(72806322054110);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501327)(52105095)(93006095)(93001095)(10201501046)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BN3PR0701MB1171;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1171;
x-forefront-prvs: 0645BEB7AA
x-microsoft-antispam-message-info: 2cs6iT2rid5l/0uyfyV3+m50pdvcC7BhHUsJWhaTwGtO+e8ptsMYmO5P7iERMoMg5/Mv6jAmTjd3lRPSqzDjE5pzffzMJG2ITrZ+56Z9ahFwT+KcIWwcb0oeUFAEcT7sde8Yrf4mgKUi5LlIW45W25a0wPPKfUwW6qzLPfdbfI4A/bJQZf6bw4CH5Xi0KuHJwj8ysOjtEzVo1wMiL8CEDw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d4d4c92a-6c77-4cf8-42d9-08d5a4418b67
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d4c92a-6c77-4cf8-42d9-08d5a4418b67
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 08:59:35.9151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0701MB1171
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3H8xunr000379

From: David Miller [mailto:davem@davemloft.net] 
Sent: 16 kwietnia 2018 17:09

> From: Rafal Ozieblo <rafalo@cadence.com>
> Date: Sat, 14 Apr 2018 21:53:07 +0100
>
>> This patch series adds support for receive side coalescing for Cadence 
>> GEM driver. Receive segmentation coalescing is a mechanism to reduce 
>> CPU overhead. This is done by coalescing received TCP message segments 
>> together into a single large message. This means that when the message
>> is complete the CPU only has to process the single header and act upon 
>> the one data payload.
>
> You're going to have to think more deeply about enabling this feature.
>
> If you can't adjust the receive buffer offset, then the various packet header fields will be unaligned.
>
> On certain architectures this will result in unaligned traps all over the networking stack as the packet is being processed.
>
> So enabling this by default will hurt performance on such systems a lot.
>
> The whole "skb_reserve(skb, NET_IP_ALIGN)" is not just for fun, it is absolutely essential.

I totally agree with you. But the issue is with IP cores which has this feature implemented in.
Even when user does not want to use that feature but he bought IP with configuration supported RSC, then he has to switch off IP alignment.
There is no IP alignment with RSC in the GEM:
"When the gem rsc define has been set the receive buffer offset cannot be changed in the network configuration register."
If IP supports RSC and skb has 2B reserved for alignment we end up with none packets receive correctly (2B missing in the each skb).
We can either leave few customers without support in Linux driver or let them use the driver with decrease performance.
