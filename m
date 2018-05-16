Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeEPHRX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:17:23 -0400
Received: from mail-eopbgr50121.outbound.protection.outlook.com ([40.107.5.121]:38326
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751786AbeEPHRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:17:18 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
        Brendan Higgins <brendanhiggins@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: [PATCH v2 0/2] i2c: make use of i2c_8bit_addr_from_msg
Date: Wed, 16 May 2018 09:16:45 +0200
Message-Id: <20180516071647.29277-1-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::41) To HE1PR0202MB2780.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2780;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;3:7V+QVSX948eOFcT3QHtfdqzePG+APpYjsRNwGmN4MJIAtAyCUWQWASh9jqTGrchc9rBhc1JjE0pAOn8IKr9g18lFvMB31TbZqJk/sYJviMkOq8pBoIUK/xQCU8uFo9LnNp2USmaPe+mPFXZbq1DWQ4tsVFEPE5qMkKXDFlIMfrivh4Nl0ih2UdV6rhPyhOCiVpN5PJ/krb4U7bX27EZKv4h4AbGsIJDD41WRZFF/63jRHVkkyozDzZZV/dTGNBz+;25:TJoZIctkD+7k50+M3QVsednxao70xpbnhi+Itfj0wasFKJmBdo7ugG206dd89RuXhgNC3pc27d8g3XF1j4RLCe2qq/gWUlSjwwMme8/bUUwJUSPh02UCm9iMV1M/bb5dt8zlxJxdY9lz6EsQ2735qVphyVmbWWy8UXh2M0Q0Wv9JQNOq8MTle/z2e3Vq23nZgs6pJN52S8IfZ/G8xhGWfd647bzYtIHqCisrRUTWqP6kO8oTY65SQIj6lQTgavQgVvOOl0uKC3ZMMwrYDagvsGegR3ek/n8auMdKsX22pfMIfwCGHaIAzeAEPq+K1VBHIp3deM3BE61/+/vl32uXSA==;31:l8y9d18BsT83DOkXBm27mWQjz+Erptx6ghfZxNA/Q5TDb/aHf86NClpSb5nocv0T7CFYGxsKSeN/gNm+WfHXv2seUdH2yL8M5CmpPaWtCtZ4OEkXSb07UVaxZD9Nb/Dvr/EqdJXb422Ea09XAhSNKrYy2u8/p2Ic5quwYCQTOJ2X8RKMaVcDDjZJcJ62W1z6dn7PJGUTW5F1yS5OLTcPwxR0JYeXGSZv6+Se1DRn9Fg=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2780:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2780AE1B250D2921925C0C1EBC920@HE1PR0202MB2780.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2780;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2780;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;4:ksh0iFBf5qKRMFkve+ZigLzQSGQQuLzxCxiSkIBqvfYhGRTWlCXOVodsNL8LbwFeir+V3esmcomMEORdP+DNxUsPBs5m/czvrZHsE20bZshw2gziytMlxj0BvOIrJTn7GLt7dxH6Kr3l0si3h40HwpN3CScamWL7t5Dz1RVxObDTjOL6rdN+53V+HAacRbZsEoXXh4vW4oCx8ys7uZNuvyQ6IcPB0ErCdktPsUJWhnKDihabOKQeEcoV5o/SGVNKrcpZOuOQY9jQRLTjXeHzpg==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39830400003)(39380400002)(396003)(346002)(189003)(199004)(54906003)(2870700001)(15760500003)(316002)(68736007)(52116002)(6666003)(23676004)(6916009)(66066001)(47776003)(386003)(6506007)(81156014)(81166006)(305945005)(7416002)(5660300001)(7736002)(97736004)(50226002)(8676002)(25786009)(2351001)(2361001)(8936002)(36756003)(2906002)(53936002)(966005)(478600001)(6512007)(6306002)(16526019)(86362001)(106356001)(4326008)(186003)(26005)(476003)(1076002)(486006)(6486002)(956004)(2616005)(50466002)(6116002)(3846002)(74482002)(105586002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2780;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDJNQjI3ODA7MjM6MzRJRGZjTitPc3NQRXhSSHRtZUJRTHlt?=
 =?utf-8?B?LzNySzJwTjBnbnlxQ29QanVVSFhGbkI3Y3hPcHZkbmU2MWt1M084VUJTN0Ev?=
 =?utf-8?B?aXhaaldhV1U0VlJvRHVrZ25GdEtMRzZVaDZ3Nm5mc2xQT2tObFQxTFdvcCs2?=
 =?utf-8?B?cW1RRmhtV0p0ZnF1YnV5MzJFQjdpd0lRaGtFWENCQ3JZK1dhNXBXVDJHNEFi?=
 =?utf-8?B?K0M0R1ZLeHcvcElnemdQalJUb0NzTmJKZ0t3Mzl5aFZBdzBrRTR2cmJtbEtq?=
 =?utf-8?B?M08zSGkzWDZWK2dkbEVJMndMVmR4WEc4SDF5eE1vOWJtQ3F2RStqK24rWjFG?=
 =?utf-8?B?KzRLbitvNzA0ME1ocEhtYSsyWGlHWlpaYnFVR3JhL2ljaW5aZVRMVktlQkFT?=
 =?utf-8?B?Ty85a05QMkV5K2Jtdnd1WXFDMmVzb2lqQTJkU1owV3pFcTJhb0hhQXVZZ2d3?=
 =?utf-8?B?ZUlJSEsveFpmRkk0cWQyVzNNMkdPYk9FSUNFa3RTV1UxWjVIcWEzUU9sbUhk?=
 =?utf-8?B?RDVnYWNyd0xYeFAyWHNvWFQ0MTJiSTh4dTJDRVFoVFp3eUF3TnVTcGdiWnRQ?=
 =?utf-8?B?VDZQeXRwT0tScnp1SmoxQzVtVHNXZ2JuMGdIbnRzcExGbVBzaWtuYmdhUVhS?=
 =?utf-8?B?WlQybEJYOGpQTEZJU2p1ekxwZ012TTlIQVVPdzJZNFZrWjR6cGVRUWxEenZl?=
 =?utf-8?B?YVd3SEtJZkhLYnNVcmthSWpneGQvd285N3A2ZzM5Nmd3ZEs5NXV0ZUxlQjlo?=
 =?utf-8?B?dFJEWndJd2FVZ2g4VktMVy9wYW5hSHg1RHhWVGZ5OWcySGtYS1hveTdHVjdS?=
 =?utf-8?B?eDdhWUhEamZmWFRHNVZqUDlUcVFXVSt0NEVpZVFaS1VNcGRwL2tMbGVza3pH?=
 =?utf-8?B?b2xnR1h2QzI2WjFhcTNFTkFCZU1lOUF6ZVY0V05JZk9CQm1VVnQvOHhqRm1C?=
 =?utf-8?B?SzF5WlJZTFpBT1hJWUJGVmhIUnpUT0cvUEpoMU42MHVHeXJYZ3NWTUxhWGFT?=
 =?utf-8?B?SVdrQ2U1OXA5VzRmcDkxSHZhWHNqRWl5M1NBRnZQY1JkVkFReDlHMlQrZWti?=
 =?utf-8?B?cTBaVlBvanc1WjN4RVZza2tNMW50UTdrMkxTUi85QnFERXdOSnFaTDZraUlX?=
 =?utf-8?B?VklycWFGcFpwNnlCendYZHAwNnREU3ZDbWdreXJHa3BuZWdHNjJUYUZVb2Zu?=
 =?utf-8?B?UTVORDZQRS85bkJGMEJHUEJsMmdVL2Q3RkNYeHgwNnJJWnZaemNwZEI3Rkln?=
 =?utf-8?B?WkU1d2FEYm5mbE5GWnd4VGFpNllTUUVKU2FjdzF4ZFd6eEk3WS9EbHBGMW1a?=
 =?utf-8?B?YUkrOVpZTkdUUnQ3R0pBMlhXS1I4Mi9GOTYyK1BoTkljZGZOdW1tb2hCRld6?=
 =?utf-8?B?V095c1ZPRE5oUmN4RFRld1VLNkFaMThVQ2QrZEFaV2tNbEVJN0hQSHIzRE9n?=
 =?utf-8?B?cVNwRHZ5NEM1elFockNXL0JxVGVrdGpURGw0YU9TbjFmK2JheE01MHVxa0Ra?=
 =?utf-8?B?dGxNbi9XbkVPSEIzU2FNM29jNjhNRk1nckxudzIyR2FlQ09wVzdobWNNa2o2?=
 =?utf-8?B?blNpRmQwSnFqL2VHb3Y3NC9sL1k3TmZJT28rakoyWVNFRnFIdHZ4ZkFwanBO?=
 =?utf-8?B?dWoyOTFxNUREV2JPMERsYzc2ZGs0aEJ6cDNjOTBwb2tSbnQzVkhFOEtmRy9j?=
 =?utf-8?B?WUJtWUZia0d3N0JSS1JOSVpGREhDcVAxMUZMTzVmTTk3cURMV3BiTmlyM1pH?=
 =?utf-8?Q?rGnF7JP1kjat/T/qiLWChgJxthOkBz0m+/ZH5Po=3D?=
X-Microsoft-Antispam-Message-Info: IdykplRfS736vO8JgMMsD3YPzliIfrc4Lzx+fU/oYL/ncWZ0EUTKgwGXXmGfighSVgNpPovmJRYRAFOcH4Ys7wRYvHBvSHv9ws+UQwc+tju2ycJJHN6dZwd226ridvmmNJwWVAssz+gnlMNfrUWfXkLTt8rtbJ1S4HD+LokQDPonLO4Z4EfSBgRE+vmyg6/q
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;6:NeGSzzFUcQY6lLiKHS4xxgkmrA6jGe64/XaNT0Yv2ZkKqIy467uPkS53eBvvE8oKQjnwDCrYdXuRUgJocvCj247EyFHoehK/4NDgaWTvI28ovfJCgPdQKjURy2jUFsm50v4LfTi797A3F/IFMBKkE3BkN2btzkskWzOw1HBU0KWt+j2+eGVCpDTnJBIKtaVOC/AO2LzFc0ACLp/GQ9DocZFMFT7NZXK72xohSe73XOcrGb4cwDUrxHN6Gs+/7pnEr/R/VSWHkJXWRlFJKnH3lbEi7ZdgxKdo+zQN9pHmkdydxrf1wiKX1t5JOf4D3/m8/9C5WSq1BG0T/HTsqykpvryImeRz0JIDaXk9zRds37YTHTVDqdH8IgK19GfVGn7Y2VbRV63iRPugDvaL1KgYkMnr/NWQWd8nHiT/aYM7IEd8CJlCy+0WaUAW0/bP1uOnJSKchhgQ8I1SGlwbYkw7kw==;5:WijKDZRVXzLaCc+d2qhpStELgpNh1TEpaHRctpo03IpT5s6vBX8GGV63K7kmcUmt8fTF4DH1CMLBxOXIyxxcGSPWKvyG9ml0noi9uipENRxcOijPKM1kTptarwcW7BNngCRYBXT19VwpLdZmnnCrsne39cQbrbj4+xsgRos6QJA=;24:wfeI8DzRpaXiXdi+mrwkNeOhKlECxySkV0LgVMZMqf+4b59mMvB/B3W+LeBu0VbFTFoVvW9jMoMcO1iy46eyXacE0yr1a1xinqwCOV97+Fs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;7:APluRfVZbnsh1sgwqqCBJbCtbzldsRuE2V+vJHEi9DFJ9+26LXVqfkItHv4fvbH9LojkmbKjBWdIPOGPZ/TnqDEpQwd5dLxPpl7+ij9BevgQoOpZdaC22VChRew4z6bXEz3e8n8x1dEqxOWBiqlhYSUQvTySHznjsBsaMPjhllnz5dMq9I+kVDVzo8XuYShOxLJdpMaGgt0GzvVRSJ5YUpg7Yd5STw0v0jCTPOPzjoVhOV3Gveuz2B2fiVdXiint
X-MS-Office365-Filtering-Correlation-Id: 66ae73c6-7a01-4527-0bb0-08d5bafd0c40
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 07:17:13.2809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ae73c6-7a01-4527-0bb0-08d5bafd0c40
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2780
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The nice little inline i2c_8bit_addr_from_msg is not getting
enough use. This series improves the situation and drops a
bunch of lines in the process.

I have only compile-tested (that part fine, at least over here).

Changes since v1     https://lkml.org/lkml/2018/5/14/919

- Squashed patches 1-3 (algos) and patches 4-21 (busses) making
  the series consist of just two patches instead of 21.
- Added ack-bys and reviewed-bys from Guenter, Uwe and LinusW.
- Eliminated the flags variable in algos/i2c-algo-pcf.c

Cheers,
Peter

Peter Rosin (2):
  i2c: algos: make use of i2c_8bit_addr_from_msg
  i2c: busses: make use of i2c_8bit_addr_from_msg

 drivers/i2c/algos/i2c-algo-bit.c    |  4 +---
 drivers/i2c/algos/i2c-algo-pca.c    |  5 +----
 drivers/i2c/algos/i2c-algo-pcf.c    |  8 ++------
 drivers/i2c/busses/i2c-aspeed.c     |  3 +--
 drivers/i2c/busses/i2c-axxia.c      |  5 +++--
 drivers/i2c/busses/i2c-diolan-u2c.c | 11 ++++-------
 drivers/i2c/busses/i2c-efm32.c      |  3 +--
 drivers/i2c/busses/i2c-eg20t.c      |  5 ++---
 drivers/i2c/busses/i2c-emev2.c      |  2 +-
 drivers/i2c/busses/i2c-hix5hd2.c    |  9 ++-------
 drivers/i2c/busses/i2c-imx-lpi2c.c  |  4 +---
 drivers/i2c/busses/i2c-imx.c        | 10 +++++-----
 drivers/i2c/busses/i2c-kempld.c     |  7 +++----
 drivers/i2c/busses/i2c-mxs.c        |  9 +++------
 drivers/i2c/busses/i2c-ocores.c     |  5 +----
 drivers/i2c/busses/i2c-pasemi.c     |  2 +-
 drivers/i2c/busses/i2c-qup.c        |  2 +-
 drivers/i2c/busses/i2c-rcar.c       |  2 +-
 drivers/i2c/busses/i2c-riic.c       |  5 ++---
 drivers/i2c/busses/i2c-stu300.c     | 22 +++++++++++++---------
 drivers/i2c/busses/i2c-xiic.c       | 11 ++---------
 21 files changed, 51 insertions(+), 83 deletions(-)

-- 
2.11.0
