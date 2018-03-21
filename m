Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752800AbeCUPgc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:36:32 -0400
Received: from mail-eopbgr30135.outbound.protection.outlook.com ([40.107.3.135]:45375
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752643AbeCUPgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:36:04 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 0/3] ARM: dts: at91: cleanup pullup on uarts
Date: Wed, 21 Mar 2018 16:35:49 +0100
Message-Id: <20180321153552.29213-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR09CA0053.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::21) To HE1PR0202MB2779.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed2a244d-3f9d-44e6-03c6-08d58f4173f5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;3:PJaluH9mevxnYeTt6QwBmEF4Ksgp/L+bja/h2N1noEs0L5FQ2diJhugMDQ+hVJuCNUubbh4zaS039vWL/UKCm5Owynm6PnSkyMVRoaVVydf6Y0ZqOL0IEFh38hNoJ7uXQ5QOamGib91TTAhqQNzwod3rHWhJ2QSo6H11rtVQTLteycaJEBmBboLY+kA1WTUg7XhhR26Tie24Zn8M1IQifGKWyd4p/Hj30br2IodsmkO7bdVPR3ulXGGbd4grTu3s;25:d20MjBcBcQg4FSZ6ce+9z4DY2kcbCLOJMSCYV4qgIOaZzTMtd0KEcbJcKhce28BJXkjLmmmXhk9Ah0wCzZOEnOUzLk16YE21mO9PWc5v/+wBqo8eUU6pXVnSw0pMTJNzPES1MMtjP48LCwG6TPMlQ2liXc/hPsZys6EbxzNFNkWnjgKCdn8r+6s8t+Y+zGpEToZHc4sjFcbDYEL49UUi1TSFfnG5DJuwjBPekgBYmCjT3ZubtR/2oIF6/STHw13FBBL4S3zTztKk67CS+5UOIJrTyf0OhYL/m7CpwB53KbXfgr9QUXhQrQ9QaG/YNIFtMwiiG+Abvcp6DSsnHwp4OA==;31:+L4Y8fBv/MQj5QHAN/fVwEzSutRAuVSC8HzOJn8eomE4jkw+9VNMiii2jIMxY5TcfTxJqBw6+R2xjzGZ7gZ94GfJf/64/OXwAAiRT8ANXucf2nC4OabeSwOPymhVg4k2vgwKJtqkFshKBw0WWAH+li9G642fevFaYoijtsGZbGwE4L7OHlLXXl8Kq5IQFWp9wyaGaSWg+VAW/Io6vcjznrZc2G9UDIs8V1ljQGsWpR8=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2779:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2779ED44226FFE2C65C47EE4BCAA0@HE1PR0202MB2779.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231221)(944501324)(52105095)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2779;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;4:5pCr+RPSMgtvz1gdKq1YaycucG6Q6/H8uf9d5g5+4Fj1uHl6Kj21T0Q7Uvjj3k2fd9NZY3zsPlERHIwklStC847YHGOI7UcY1BHYRtyF1WsTuHhjqMZKnQ4xzomZfBUQbTPiK2eqYDpd6DAE7i4fLMmuJXSxG+vBmKu6bjE2tL0Z6yrc9cF60acSY/pfnCYd3xoRWFRN8MCDZUcsn8gdkWSSetsSoxIvjlfcv9Fm0vl+vNclQxwKWq0ymUmlCMjmjMekkZhjBLIB7kAUlgGddg==
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(39380400002)(39830400003)(189003)(199004)(6916009)(6666003)(16586007)(53936002)(54906003)(36756003)(16526019)(186003)(8676002)(68736007)(6512007)(7736002)(26005)(48376002)(316002)(47776003)(478600001)(52116002)(6486002)(305945005)(50466002)(51416003)(81156014)(2361001)(86362001)(8936002)(386003)(4326008)(5660300001)(81166006)(6116002)(3846002)(105586002)(66066001)(97736004)(6506007)(1076002)(74482002)(50226002)(2351001)(106356001)(2906002)(25786009)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2779;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2779;23:f85Za/TVo6fWIK99LDgYwWTUjk6xBSz1/S8l9Xe?=
 =?us-ascii?Q?BThKfQCh/k9aJKSgfZ+wMdNv5tEe0+pa613KP/c80AncR3KKjrtojjiJlfKn?=
 =?us-ascii?Q?ghIhvR1bt+vOp8YcIFNxvbOurknnHWmG10j0gBu4DGUdyWC59SUtFvet5+M4?=
 =?us-ascii?Q?5Wtp7U02rEZ/AsA1D3gvI+PuGN1Z2XWytAV5qteUu63K1MO06PWop0Y9K5Ln?=
 =?us-ascii?Q?4uWqLnWgmRUyvqOf3hGU66GjXVMv5dV3XvrAvwnrOHFpDstrDZPaZK5T+fjj?=
 =?us-ascii?Q?ieWcfP0505OTwzEZxzMsY5KS8x+Fje9cC534HteqJ6kyukDqc8vlG1TMiArQ?=
 =?us-ascii?Q?AVrAWiu9oRjXeLqUSH0DheACUrmtq2wF8ipAmTLdsd2EvLrF5lsAWP1K8CDx?=
 =?us-ascii?Q?8fk+8pu4o9yC4ucZz1JdPmnc9053AJMCPQIPBa4rIdgiRUW1FsKAcXKUVVAb?=
 =?us-ascii?Q?d4UHoez7OVAMIkLKFH6X7Ww6svcrVqe/E6scLeqgHwUBnoeYi/k6dZnhr9mW?=
 =?us-ascii?Q?oehEScglwUg8wuBqDWyefa5K3B7MCbgThRJLPhYwWRxwmYQ139lH+H2+Ycly?=
 =?us-ascii?Q?0QE0LC5heaLzI/sUnPzG8RnyT827snmaJuILuj2Ij5BjOCtazIShzX1xTlCa?=
 =?us-ascii?Q?DDZLcODavdX/jaSneu2/0vedXms364BqOicDmu5398tE/2hwXbUooQC/bVeG?=
 =?us-ascii?Q?VFmoFp3NdY6uosuGEt+5dgwSlaaFj1jpz5ZlSgYWchOSvJjmnC+ppsWF1j++?=
 =?us-ascii?Q?f8kGarjrDLAFHsjM3fjdd98ea32vmKdlH1hx39RtXLK8nHRH+w/Sc9aYWY2n?=
 =?us-ascii?Q?1JB2cZeaNwZtVXnaejWOdFOBPlQBowIwBO9XHGfw7R7oTNTQe36tQzG2KfS8?=
 =?us-ascii?Q?gOyrORmp5wWUmgWPzDp0MSQX7gpD7see5EeifJ8T4H4ItiP/KQipjZXuBvPx?=
 =?us-ascii?Q?La0AmT3+lnKoSDtmOk1sxjJMRUQWUfo4naYSwUjOYmYXp6omRMtYKVGIJb46?=
 =?us-ascii?Q?/tfCHWYfhKkM4yVD6DgLwsKhrJvbdZKv3hPqO+NRhiRxRefJk7I15WTGx2pN?=
 =?us-ascii?Q?cwys1xTip9fxk4fsZgPqySyIqXL9L9enWdOplPH8xvWc7XskewGO9vYlc/Hv?=
 =?us-ascii?Q?qJCkutd+h1dmxHdAp23tT7K0kCzYqDxZlsOn5fl4mW2JdrhUGRkvZulZXJaR?=
 =?us-ascii?Q?T0GTwEFIhdPwa+o0=3D?=
X-Microsoft-Antispam-Message-Info: i5PIQfiHf3e+01Sx7uT1rwaNysI58Uw5INTtvgyF/yy8axZuTCmqOH51AYFATvReUrr9IqCT9WmXupFGANXwly89CGJNQZZjxllIA/BkC7loI0n4BG4JXU3Axx3ZJe1y2eB8HzaFET7GYqs8kKp8O0vl9mhcm+FrW6tscqDojHTjRloGN82zxi681fWLObuh
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;6:pLO5+ZiGSkKr5XEwrsYW5W2M3wFIgSGbGbFDyUHMwjlRc8zBR6jH7F0m9JbkHail6svHWdv5MBYWJbomP6QHC78MeaxnM5qeOCqj0j1J0uGawA9/TSHUbx1+39yp8flvbEguV/W3dj7rWF8/AOD6h0xn71wvlnJ8MQt0GsQShFctRrml48/ru85laHK+Eo47ieVxR/lPQ24p7i+sHee0b6rjWAQpymj6eFckaOwV+37tTGvDnFQraokfJUB1D3Nm2KxpP6RM5RQC7bBOM6w8DV2pJjofwB7tss9PYCrqJ/0mQ6CBaJYRNOWqKmntrb8UV1FP0bHpujVjXWjBEXjWdP4aCoF/GEdZMDLEX/w2cXA=;5:PBEla3du8DWIhVq0TqWgJOKGXhRqlQrHQ53b/z2GlPg2ibBgMoP9F5vfA9B31Fk20aeq7uI5mUyXp9/az6gbhBkHdAdhEUhlqiaI14blh3y770h41r+i2ossnGdOrwvenFaym3OFqh/u1/4XiY5PLp+hxbt6WU1GunGK8Laea28=;24:CUbnCkDqIbBX2xvMGRlJk/nfjmc7+BT+EYqJeTWupyaZ96uYdvv8T4JiqsnbdW9V8BwqDJngVPf1OzVMuv1irvvsqoRQPU7IDWlLv1KmpL4=;7:2WuEmFRfsHNreIsjBUAUMv4/n6xoAddoEnNK35qpc62zJb4uSkQz5zwR/dvqWEJkcOSNRTUYB3rcQnKMbV3FnfgH+8NEuG0fOBFZ0wf9x2Xjzl49sCPMabfmWrvf1YBZLdTZtoNz+At+aHdvmPCWKKyDWYTdZY7JjbwcDJ2GyKNSvmVhf5chqMMtg3zO4neDTVFF/2pMfRGntwiQDG5NFNRsKMs5jGO1dqx4WBhItpwttABmujzV3PCHc5K7o2Cf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 15:36:02.1532 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2a244d-3f9d-44e6-03c6-08d58f4173f5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2779
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I noticed a *LOT* of pointless pullups and missing pullups related
to uart/usart pins. These patches fixes what I found.

I separated out the two changes that had pullup on neither rx nor tx,
since there might exist some reason for that? But a pullup on tx and
a missing pullup on rx is a sure sign of confusion, so I lumped all
those fixes in one big patch.

One or two of the removed comments with duplicate info where wrong
as well, i.e. the info was supposed to be duplicate but wasn't.

Cheers,
Peter

Peter Rosin (3):
  ARM: dts: at91: fixes uart pinctrl, set pullup on rx, clear pullup on
    tx
  ARM: dts: at91rm9200: pullup rx on uart0
  ARM: dts: at91sam9260: pullup rx on usart0

 arch/arm/boot/dts/at91rm9200.dtsi        | 16 ++++++++--------
 arch/arm/boot/dts/at91sam9260.dtsi       | 24 ++++++++++++------------
 arch/arm/boot/dts/at91sam9261.dtsi       | 12 ++++++------
 arch/arm/boot/dts/at91sam9263.dtsi       | 12 ++++++------
 arch/arm/boot/dts/at91sam9g45.dtsi       | 16 ++++++++--------
 arch/arm/boot/dts/at91sam9n12.dtsi       |  4 ++--
 arch/arm/boot/dts/at91sam9rl.dtsi        | 12 ++++++------
 arch/arm/boot/dts/at91sam9x5.dtsi        | 12 ++++++------
 arch/arm/boot/dts/at91sam9x5_usart3.dtsi |  4 ++--
 arch/arm/boot/dts/sama5d3.dtsi           | 24 ++++++++++++------------
 arch/arm/boot/dts/sama5d3_uart.dtsi      |  8 ++++----
 arch/arm/boot/dts/sama5d4.dtsi           | 28 ++++++++++++++--------------
 12 files changed, 86 insertions(+), 86 deletions(-)

-- 
2.11.0
