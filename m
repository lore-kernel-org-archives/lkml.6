Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3507392-1519926495-2-15612534785718856247
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enrofr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519926494; b=jwAdpcSdm6OUCTNLZS86Fsm3a8e2HDmnHE3aXTQlhRyJln0
    npBrcL9LTWpPezc3sSoekdSLXLaLMPB6czJd0oTG+y7FPXzf1mb5cjr+bQ3/7w/M
    H8amNVnCcoPfIxfXNkW6+7OzdcvYKeJ6xrmvS2M4bgvKD3vV1ALX1jzd7S8YOndZ
    BowbBVthA5YxHWHU6H8M5YGUS9686O+wxl1Wx/1PsxCU6uNWpIyTJDDDoJH5h2bP
    Ace/tzn2GyFz2bQ0cDAz4raiH+TNDoCXn3lKaRxwcgHANSz3FJShv7PQT43nwxlS
    pd/RZQatr7fE0wbdJLO2vo8YpYrASC9z5loqGDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519926494; bh=l
    f6HwCK9DWeC5fIarG7RHigDxRd3k3vmN6YrcFxvzsw=; b=UMqPmJTyBBaBghC7y
    2fiDumI81ncyKSwZDo/B10RkBsg8As1oh3HHPkkGDG5rNBwm0UGGkp+L9YJOeYu/
    nAk8iJ/DlLj8GehJstQDlDEITRDbDIAwk+tLEAlO3rAvmZFC2gQZCfrzcqZCZ/m/
    VaNTU4OyeZAm7KVwQuxq5JhtuxNaCPinIbBWLQ8mr/GrDZ1jzVxKAvGiEULRXY1L
    i6F1pDjC9oZIKlV/C6AGvcD4WGERnjjJ0QTcz3crTykD3UabvHUEPN04q7O1Pwvq
    IHsh3IxyAlKRSu0qEsZLDrXvBFa85hb6+rxYWnN4kFZ/twvdhUx//5akyOb5k3lZ
    HeYrg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=QaMdheZa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=QaMdheZa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=bogdan.purcareata@nxp.com;
From: Bogdan Purcareata <bogdan.purcareata@nxp.com>
To: gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com,
 ruxandra.radulescu@nxp.com
Subject: [PATCH 3/3] staging: fsl-mc: Move DPCON out of staging
Date: Thu,  1 Mar 2018 11:47:12 -0600
Message-Id: <20180301174712.2660-4-bogdan.purcareata@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180301174712.2660-1-bogdan.purcareata@nxp.com>
References: <20180301174712.2660-1-bogdan.purcareata@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: SN6PR0102CA0030.prod.exchangelabs.com (2603:10b6:805:1::43)
 To AM0PR0402MB3650.eurprd04.prod.outlook.com
 (2603:10a6:208:d::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8b1405f2-c014-4962-adb0-08d57f9c924d
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);
 SRVR:AM0PR0402MB3650;
X-Microsoft-Exchange-Diagnostics: 1; AM0PR0402MB3650;
 3:3LTcMwJK/aA9KF2QoJqaqJfNur0FM2P0gn52SL+hq3UzJDHbH9TlpJvsAx6IUJ1WdpKH5xTK7gQ6LapPNYwmdmXj89xtQmZfWxvWLWptpDs5N+LRO26xvommvxIjKmWeO+wrYCXHd+P6YiCOl5M3f1Oi1ttDs/Ps6EOoYedsmdbmVwnZz976PTqAJIMvosrfSKCfoCJ6rTbchnZdmt6lsiHjUEbi1pCmAQrxVrmuuMSMGy5qHPtWMoHHbJUocmrE;
 25:UpQSB2tyrflRPEHNF3ey8M7TkfkRn0WqHIOJHq5xZq1fEHqJHJlIy5EofEf/RLXEAjgIP80uONKbwa5Uw07/6hdSryz6xPmGnTcYzAO6I+m15QXRsx6Tfq82YdBNdd9tkFCyryjWGDvyg+skfGzLah8NeXviXoPxopUpvz2v2tApgKkCEmQTbEIPDD5z7d6p8WJvUXLKkEfCtAzOW8wCnORn0kLR2vDBmTKNYBQ8Pp3dVPiMAHzZK49VYV5++25WfEdVFYMVQxgB3CWTkNLdR/dKWoreh90auUVlL28T+fznlwkIikHzGZUKDLohOCACLjMmzb5oHcUz5g2p67V29A==;
 31:CRCRGXxYYQZO+PYcpR18WmsUN2x+o4SAYZiPG9DY55u6jOg8Jk2iVqSFkzn/1tYzebkWqBNmHCsrVHyQSCUG/nlE25je/JEEipB1lKkvXi/5fUR8+VA5RyGkaFMYrgW6OXBVCY/5cwBoEurtyb3Ys8Rer8h0uwhxFFTUxf5HioNyZoAxaTeH+IXSrCNHdpke481AYJdlTMUWTWPABVqX4KQxAR7ujdfmIzzebTyU+F4=
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3650:
X-Microsoft-Exchange-Diagnostics: 1; AM0PR0402MB3650;
 20:IDHxKs9TfvUa+iQUzBDybg7+Tt6RqEsBhFdIGp0pMvlf4ww0iMSZ0ygACzlW/myL2+Z9qMT4ydW/+9dIEDnYeQx9qciVM77VKWoJyUNZbx026Te0nrETvl2OhMLPyhX5UQ+VXQ4cXr8qCDtY1VMC3V+FQ4+b9M8IE2/Yvxo0rHlGQScRJ6cghKphdUhnnyoJUgAUmdl3WOXZGsIPB7hCqqIjqfpuR7+PrRxlaHjWOPr5/AK4NwCRQaJLx/10J9bflT0OgORzZ8dqBgMPOsgll4YmNMNUZNw/pIM47lCGgoE9SHSi/ZM7DSsM6/TN+JCjsdOf3c93AHBIiUUpJh+m5mJTPUQgbvHhVIXBDd4RgNYxff4iTk5r+qA3Lfb8lhasSIPdm42Y3dRToI/QSzF90ASlM8lq1Kfi63sAPFlpKSpdkUJdky+OistY/wRAc7c8xHW7e+A+Y/rNFjjjeGCmdkb1R2QZMGGC7sR2IQAWP9weGmGC4D1DD4Bb/WSzFGK/;
 4:8HLhSm2zScfujzretWmDSXcasjHc9pviNKbXblyR2cETie1CbWeCS9jXmUyw+jvQAPpVR8dT0kqgAEhqA6bIjyhqS55XMJJS05MvuRVvEmLngyAcghAMcOyTzNItthNyZCvnC07whD3E/jhkl7GqIeuTLwFCws9RGr4ft3itqr1tZPd0L+D0jNXttrTibyJMic5AbZYLo5Ld9hymQNqp48No8YdSOvG1ooeJt0mdDhfuPU8dRmX7PJgvrujOLKX4QVPnM9mJ3TJTPYfOvzMpD7n4UOivC4xRy84CQeTGy344bhUQj6kzssyONt9anlLq
X-Microsoft-Antispam-PRVS: <AM0PR0402MB365069B9FDBFEF8E67A396D8EAC60@AM0PR0402MB3650.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231220)(944501230)(52105095)(10201501046)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);
 SRVR:AM0PR0402MB3650; BCL:0; PCL:0; RULEID:; SRVR:AM0PR0402MB3650;
X-Forefront-PRVS: 05986C03E0
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(39380400002)(366004)(376002)(346002)(189003)(199004)(36756003)(16586007)(2906002)(6666003)(2950100002)(106356001)(316002)(6636002)(26005)(186003)(6116002)(16526019)(59450400001)(3846002)(25786009)(76176011)(51416003)(52116002)(6506007)(386003)(50466002)(48376002)(53936002)(5660300001)(478600001)(47776003)(6486002)(8936002)(1076002)(6512007)(86362001)(4326008)(305945005)(97736004)(68736007)(81156014)(50226002)(7736002)(105586002)(8676002)(81166006)(66066001)(39060400002)(473944003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR0402MB3650; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; MX:1; A:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM0PR0402MB3650;
 23:qTHmHB7Sd0Dk9Zs7O5yvAyD2StZg0qW0huaEqlB?=
 =?us-ascii?Q?937SEFKU0pkF0cMfDJjxVIHRhXWJrgzJV+DXpq0QbOHCWOC7xCIzrMlG5CnZ?=
 =?us-ascii?Q?UnNB6yW1zZTYzy6TP+ub211vHNeFS+By4RNNXYKufXti2gYmD/4F9Egy+Jox?=
 =?us-ascii?Q?3xT8++XkaTA0qF2maXJRsOmpKImeT4Hv/umqsSHeMMwCQwg/bZP+z8qDtjRj?=
 =?us-ascii?Q?a4NQLhJe/C4TEu3050/95FybmadhELODltZ73+O8e6O39BUF5AjIe+o8Gkio?=
 =?us-ascii?Q?CjzD3QwKFJkzTlAY+EregD7JDLXGUIWeOLTYzmHbGDxaYphXqvK3Cc9ILo57?=
 =?us-ascii?Q?dfhTo8B81okuIxVlPYGQH9r6Avfir+0EcKIsNhq43siJx6YCfvecY6rrVQlC?=
 =?us-ascii?Q?8XlmGP2qt8nz36SKK9vidEHPEXc+rwyz4RYDUKpfbqWSu+8L233dZPTLLwl1?=
 =?us-ascii?Q?wx0h4baiU8wmIRv6cdnTbatvf1TbaHJsP+pu3El/HEdhxKAA7vARgjkM4TQS?=
 =?us-ascii?Q?62qhIe0PTyNxpC/NW4UcZ5m0wKYKKAOXuu36MHSNkW0CzSvncRAHHoNNaJk4?=
 =?us-ascii?Q?F45rw9qW6UamwgtBKG9Lv9sDPyR7OCu7uwUgMaeYCFkvTNaYilZMSm1kMxtC?=
 =?us-ascii?Q?lGSQd8CIGRgb+Q7kYld04rOA/YfNup+FuHD/iUA7LIMNB2i5f1PMsHU2fIRw?=
 =?us-ascii?Q?6GdkKGyikNh0dWTXiXSwtH/fxdq0Dcx0aUdJpGoyvJM0fhrY163bywcbdpsh?=
 =?us-ascii?Q?Dsv/ybfvAvgydeEQXg2n8ViQx67zS5zM+/jy3qBJIgh+8aGzHxfLmjKGNFuE?=
 =?us-ascii?Q?LYMguih5aogB8GJBJoErg29338TvdqDju3sfjrN0ZFVf4lKUHx932P2In+Se?=
 =?us-ascii?Q?YMZ4DHKO3zjFLglVP3XkaD/f5mgFlJpvB9yzLNnnjvn55EkSzUj4XGHGyUdj?=
 =?us-ascii?Q?5YchcAkVyETZhkkC66mVqiuIIdgb7IyKEBcOtsmMokaU90VXLE7HKHvNs36l?=
 =?us-ascii?Q?nIfWolzBK7q7LKbQHORME84Pj4CDI4pF9oBIksF5OzAZ+AhkD5ll8kjKn3X0?=
 =?us-ascii?Q?O6CikrfZ8EXPCFoJ0NIoNbal34X63JvlEj1mkPE/v5lyGc+/SjpOUq3ZPVe0?=
 =?us-ascii?Q?gg2SEcv3vWRcsrp9w7JeBxa1PyQFvvGkpcOfCfk6SsrKWvREYUIcWbe7DtaM?=
 =?us-ascii?Q?vtB0nljSPVMKE9PqByK8XLuex7qZ5Y+snZaG6?=
X-Microsoft-Exchange-Diagnostics: 1; AM0PR0402MB3650;
 6:SB+D28cuF1fysmU2ITPEz5255fNQDs1E5UvFIIz/SzamXhrjvkg6r2HLuPgW3OO1x2ANccG5f/FBfT5cw7RNfXbuTBdvTCb5moPRXgg8kKDT1UcLCfZb3Y3spvXFN30WOFDVwsT/fKYxkvfTGiDvqAk+2kNA+AuszRNZ/XsQI2kUhqrWoE/WSFCvIpaWlCagq6GpZT83WReZLEgXDVrVakk5ba1NUYeZ6RgN4y8OpW/qk/qq78c3qc6PToFpDAd3O7Nr0DjSgHfk9hia2CgF0b2eeCD45HoA6o3LkceCTZrOwK2myLduJiIjXZ9tFkLBxw2y4msKuPgKtZV/AJZGxtZ6X+PKH/38B9MaThNhmRE=;
 5:9ijTERI+TQhWIddlwresWclyyP5El7nP5L+fPzup8WKD+3kctHI3izK8gryGBE/onm52ucXs/4Ww6OE+vPnRWVNUZKEfc/TcfD+CkLl9ezwPMqkxjrGMUrN369oHQyFAf/8FpuOVIISllQlH1f5lx9dLfm1theYyKMR3j9A+Kj4=;
 24:qKUub2RBwdP1GtLrVAkcfdA6L0ZE2rWpU9kvuxKSnCRwULx1iVl2zIbBdXU4mJpOWdj2JWZQ3WV2UjFw9KAuRS5W1UMwwvZE6oNfgzkh+PU=;
 7:KRjJ1uFT1RrTey5cX00WfRCb2OJwnbKPLRpjMEqyCfij5I422A6hq7Uz7HyR09s/84RECQyXo+89lAG2GgyR7+FZjgIfw1Jz6h/vokO15Fj9DrD2F3GxobLER4xa+6O+nzyJQkcRvFMtAJ3nx9VSkXbhdO5u4O5U29crodiAakEj3zCJod3L0BxpAsef5AWbatAu4DzjLvItsel6RmXAGnqN7NfKY/aG4rUyt1rK5zlg4E0mjpa+6jf67kZ9Hbdn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2018 17:47:56.9920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1405f2-c014-4962-adb0-08d57f9c924d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3650
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, stuyoder@gmail.com, horia.geanta@nxp.com,
 roy.pledge@nxp.com, ioana.ciornei@nxp.com, linux-kernel@vger.kernel.org,
 nipun.gupta@nxp.com, Bogdan Purcareata <bogdan.purcareata@nxp.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Move the source files out of staging into their final locations:
- dpcon.c goes to drivers/bus/fsl-mc/, next to the core infrastructure
- dpcon-cmd.h gets merged into drivers/bus/fsl-mc/fsl-mc-private.h, next
  to the other internally used APIs
- dpcon.h gets merged into include/linux/fsl/mc.h, exposing the public
  API

Update references in the dpaa2-eth staging driver.

DPCON stands for Data Path Concentrator - an interface between DPIO
(Data Path IO) and its users (e.g. dpaa2-eth). You can read more about
DPIO in Documentation/networking/dpaa2/overview.rst

Signed-off-by: Bogdan Purcareata <bogdan.purcareata@nxp.com>
---
 drivers/bus/fsl-mc/Makefile                        |  1 +
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpcon.c |  4 +-
 drivers/bus/fsl-mc/fsl-mc-private.h                | 48 +++++++++++++
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     |  1 -
 drivers/staging/fsl-mc/bus/Makefile                |  1 -
 drivers/staging/fsl-mc/bus/dpcon-cmd.h             | 53 ---------------
 drivers/staging/fsl-mc/include/dpcon.h             | 79 ----------------------
 include/linux/fsl/mc.h                             | 66 ++++++++++++++++++
 8 files changed, 117 insertions(+), 136 deletions(-)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpcon.c (99%)
 delete mode 100644 drivers/staging/fsl-mc/bus/dpcon-cmd.h
 delete mode 100644 drivers/staging/fsl-mc/include/dpcon.h

diff --git a/drivers/bus/fsl-mc/Makefile b/drivers/bus/fsl-mc/Makefile
index da26e52..3c518c7 100644
--- a/drivers/bus/fsl-mc/Makefile
+++ b/drivers/bus/fsl-mc/Makefile
@@ -10,6 +10,7 @@ mc-bus-driver-objs := fsl-mc-bus.o \
 		      mc-sys.o \
 		      mc-io.o \
 		      dpbp.o \
+		      dpcon.o \
 		      dprc.o \
 		      dprc-driver.o \
 		      fsl-mc-allocator.o \
diff --git a/drivers/staging/fsl-mc/bus/dpcon.c b/drivers/bus/fsl-mc/dpcon.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dpcon.c
rename to drivers/bus/fsl-mc/dpcon.c
index 021b425..5d220c9 100644
--- a/drivers/staging/fsl-mc/bus/dpcon.c
+++ b/drivers/bus/fsl-mc/dpcon.c
@@ -5,9 +5,9 @@
  */
 #include <linux/kernel.h>
 #include <linux/fsl/mc.h>
-#include "../include/dpcon.h"
+#include "linux/fsl/mc.h"
 
-#include "dpcon-cmd.h"
+#include "fsl-mc-private.h"
 
 /**
  * dpcon_open() - Open a control session for the specified object
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index 4ef8d7e..52c069d 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -418,6 +418,54 @@ struct dpbp_rsp_get_attributes {
 	__le16 version_minor;
 };
 
+/*
+ * Data Path Concentrator (DPCON) API
+ */
+
+/* DPCON Version */
+#define DPCON_VER_MAJOR				3
+#define DPCON_VER_MINOR				2
+
+/* Command versioning */
+#define DPCON_CMD_BASE_VERSION			1
+#define DPCON_CMD_ID_OFFSET			4
+
+#define DPCON_CMD(id)	(((id) << DPCON_CMD_ID_OFFSET) | DPCON_CMD_BASE_VERSION)
+
+/* Command IDs */
+#define DPCON_CMDID_CLOSE			DPCON_CMD(0x800)
+#define DPCON_CMDID_OPEN			DPCON_CMD(0x808)
+
+#define DPCON_CMDID_ENABLE			DPCON_CMD(0x002)
+#define DPCON_CMDID_DISABLE			DPCON_CMD(0x003)
+#define DPCON_CMDID_GET_ATTR			DPCON_CMD(0x004)
+#define DPCON_CMDID_RESET			DPCON_CMD(0x005)
+
+#define DPCON_CMDID_SET_NOTIFICATION		DPCON_CMD(0x100)
+
+struct dpcon_cmd_open {
+	__le32 dpcon_id;
+};
+
+#define DPCON_ENABLE			1
+
+struct dpcon_rsp_get_attr {
+	/* response word 0 */
+	__le32 id;
+	__le16 qbman_ch_id;
+	u8 num_priorities;
+	u8 pad;
+};
+
+struct dpcon_cmd_set_notification {
+	/* cmd word 0 */
+	__le32 dpio_id;
+	u8 priority;
+	u8 pad[3];
+	/* cmd word 1 */
+	__le64 user_ctx;
+};
+
 /**
  * Maximum number of total IRQs that can be pre-allocated for an MC bus'
  * IRQ pool
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index ce864ee..b8990cf 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -39,7 +39,6 @@
 
 #include "../../fsl-mc/include/dpaa2-io.h"
 #include "../../fsl-mc/include/dpaa2-fd.h"
-#include "../../fsl-mc/include/dpcon.h"
 #include "dpni.h"
 #include "dpni-cmd.h"
 
diff --git a/drivers/staging/fsl-mc/bus/Makefile b/drivers/staging/fsl-mc/bus/Makefile
index ea6479f..21d8ebc 100644
--- a/drivers/staging/fsl-mc/bus/Makefile
+++ b/drivers/staging/fsl-mc/bus/Makefile
@@ -4,7 +4,6 @@
 #
 # Copyright (C) 2014 Freescale Semiconductor, Inc.
 #
-obj-$(CONFIG_FSL_MC_BUS) += dpcon.o
 
 # MC DPIO driver
 obj-$(CONFIG_FSL_MC_DPIO) += dpio/
diff --git a/drivers/staging/fsl-mc/bus/dpcon-cmd.h b/drivers/staging/fsl-mc/bus/dpcon-cmd.h
deleted file mode 100644
index 27fa098..0000000
--- a/drivers/staging/fsl-mc/bus/dpcon-cmd.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/*
- * Copyright 2013-2016 Freescale Semiconductor Inc.
- *
- */
-#ifndef _FSL_DPCON_CMD_H
-#define _FSL_DPCON_CMD_H
-
-/* DPCON Version */
-#define DPCON_VER_MAJOR				3
-#define DPCON_VER_MINOR				2
-
-/* Command versioning */
-#define DPCON_CMD_BASE_VERSION			1
-#define DPCON_CMD_ID_OFFSET			4
-
-#define DPCON_CMD(id)	(((id) << DPCON_CMD_ID_OFFSET) | DPCON_CMD_BASE_VERSION)
-
-/* Command IDs */
-#define DPCON_CMDID_CLOSE			DPCON_CMD(0x800)
-#define DPCON_CMDID_OPEN			DPCON_CMD(0x808)
-
-#define DPCON_CMDID_ENABLE			DPCON_CMD(0x002)
-#define DPCON_CMDID_DISABLE			DPCON_CMD(0x003)
-#define DPCON_CMDID_GET_ATTR			DPCON_CMD(0x004)
-#define DPCON_CMDID_RESET			DPCON_CMD(0x005)
-
-#define DPCON_CMDID_SET_NOTIFICATION		DPCON_CMD(0x100)
-
-struct dpcon_cmd_open {
-	__le32 dpcon_id;
-};
-
-#define DPCON_ENABLE			1
-
-struct dpcon_rsp_get_attr {
-	/* response word 0 */
-	__le32 id;
-	__le16 qbman_ch_id;
-	u8 num_priorities;
-	u8 pad;
-};
-
-struct dpcon_cmd_set_notification {
-	/* cmd word 0 */
-	__le32 dpio_id;
-	u8 priority;
-	u8 pad[3];
-	/* cmd word 1 */
-	__le64 user_ctx;
-};
-
-#endif /* _FSL_DPCON_CMD_H */
diff --git a/drivers/staging/fsl-mc/include/dpcon.h b/drivers/staging/fsl-mc/include/dpcon.h
deleted file mode 100644
index 062e90a..0000000
--- a/drivers/staging/fsl-mc/include/dpcon.h
+++ /dev/null
@@ -1,79 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/*
- * Copyright 2013-2016 Freescale Semiconductor Inc.
- *
- */
-#ifndef __FSL_DPCON_H
-#define __FSL_DPCON_H
-
-/* Data Path Concentrator API
- * Contains initialization APIs and runtime control APIs for DPCON
- */
-
-struct fsl_mc_io;
-
-/** General DPCON macros */
-
-/**
- * Use it to disable notifications; see dpcon_set_notification()
- */
-#define DPCON_INVALID_DPIO_ID		(int)(-1)
-
-int dpcon_open(struct fsl_mc_io *mc_io,
-	       u32 cmd_flags,
-	       int dpcon_id,
-	       u16 *token);
-
-int dpcon_close(struct fsl_mc_io *mc_io,
-		u32 cmd_flags,
-		u16 token);
-
-int dpcon_enable(struct fsl_mc_io *mc_io,
-		 u32 cmd_flags,
-		 u16 token);
-
-int dpcon_disable(struct fsl_mc_io *mc_io,
-		  u32 cmd_flags,
-		  u16 token);
-
-int dpcon_reset(struct fsl_mc_io *mc_io,
-		u32 cmd_flags,
-		u16 token);
-
-/**
- * struct dpcon_attr - Structure representing DPCON attributes
- * @id: DPCON object ID
- * @qbman_ch_id: Channel ID to be used by dequeue operation
- * @num_priorities: Number of priorities for the DPCON channel (1-8)
- */
-struct dpcon_attr {
-	int id;
-	u16 qbman_ch_id;
-	u8 num_priorities;
-};
-
-int dpcon_get_attributes(struct fsl_mc_io *mc_io,
-			 u32 cmd_flags,
-			 u16 token,
-			 struct dpcon_attr *attr);
-
-/**
- * struct dpcon_notification_cfg - Structure representing notification params
- * @dpio_id:	DPIO object ID; must be configured with a notification channel;
- *	to disable notifications set it to 'DPCON_INVALID_DPIO_ID';
- * @priority:	Priority selection within the DPIO channel; valid values
- *		are 0-7, depending on the number of priorities in that channel
- * @user_ctx:	User context value provided with each CDAN message
- */
-struct dpcon_notification_cfg {
-	int dpio_id;
-	u8 priority;
-	u64 user_ctx;
-};
-
-int dpcon_set_notification(struct fsl_mc_io *mc_io,
-			   u32 cmd_flags,
-			   u16 token,
-			   struct dpcon_notification_cfg *cfg);
-
-#endif /* __FSL_DPCON_H */
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 66118e1..cfb1fbf 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -493,4 +493,70 @@ int dpbp_get_attributes(struct fsl_mc_io *mc_io,
 			u16 token,
 			struct dpbp_attr *attr);
 
+/* Data Path Concentrator (DPCON) API
+ * Contains initialization APIs and runtime control APIs for DPCON
+ */
+
+/**
+ * Use it to disable notifications; see dpcon_set_notification()
+ */
+#define DPCON_INVALID_DPIO_ID		(int)(-1)
+
+int dpcon_open(struct fsl_mc_io *mc_io,
+	       u32 cmd_flags,
+	       int dpcon_id,
+	       u16 *token);
+
+int dpcon_close(struct fsl_mc_io *mc_io,
+		u32 cmd_flags,
+		u16 token);
+
+int dpcon_enable(struct fsl_mc_io *mc_io,
+		 u32 cmd_flags,
+		 u16 token);
+
+int dpcon_disable(struct fsl_mc_io *mc_io,
+		  u32 cmd_flags,
+		  u16 token);
+
+int dpcon_reset(struct fsl_mc_io *mc_io,
+		u32 cmd_flags,
+		u16 token);
+
+/**
+ * struct dpcon_attr - Structure representing DPCON attributes
+ * @id: DPCON object ID
+ * @qbman_ch_id: Channel ID to be used by dequeue operation
+ * @num_priorities: Number of priorities for the DPCON channel (1-8)
+ */
+struct dpcon_attr {
+	int id;
+	u16 qbman_ch_id;
+	u8 num_priorities;
+};
+
+int dpcon_get_attributes(struct fsl_mc_io *mc_io,
+			 u32 cmd_flags,
+			 u16 token,
+			 struct dpcon_attr *attr);
+
+/**
+ * struct dpcon_notification_cfg - Structure representing notification params
+ * @dpio_id:	DPIO object ID; must be configured with a notification channel;
+ *	to disable notifications set it to 'DPCON_INVALID_DPIO_ID';
+ * @priority:	Priority selection within the DPIO channel; valid values
+ *		are 0-7, depending on the number of priorities in that channel
+ * @user_ctx:	User context value provided with each CDAN message
+ */
+struct dpcon_notification_cfg {
+	int dpio_id;
+	u8 priority;
+	u64 user_ctx;
+};
+
+int dpcon_set_notification(struct fsl_mc_io *mc_io,
+			   u32 cmd_flags,
+			   u16 token,
+			   struct dpcon_notification_cfg *cfg);
+
 #endif /* _FSL_MC_H_ */
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
