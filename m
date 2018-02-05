Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2598244-1517839713-2-13005529372164012805
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517839712; b=ivhxS4VQDxY7594TSW/rKQU8qNOrK6q3fQ/+UCFZ8xgkQvr
    0neca5UN05p4igBF+iEm9NunzMuiNKWXsRpVleLrvD3oFaoNDJhcYHmlvaNWkpIN
    pvTAJuxhPnsL6u7d6iKiycBnp00mIhkwsip3akqpVqPqHOIYu3aWI7C3361PI+OU
    QBcgFymQRzmHPd9TobQfkqQodxR62/OJwXkVhCD9Oy4xuKx/LefOKotnlgJoRiuc
    UWL8NA9K81j3xlD6Yj9CbCrOYvLjCmFcGLGUSstYGOEB8vAwXF8/2zYKBYxUGLBu
    mqc37oRZs5OmiWsYxV+bS7NP9nxpjfM+egBnyMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517839712; bh=v
    n5ynfxvDVve6Qv0vyCnaPMfenvJMjAgxdZBV7mJLzg=; b=TpSsEXPmXrfjZldRp
    ZkOQdDHb/CgC/RQr+8GTEV/mLqe3PyE8LOMj9xqM5jhHzZKBDqZRkMWuIwddylLK
    w4XbjP9PTRuBZjpTVEFccHZMSJlJyoYNhv6NneFOt9Z+231/fcjhZydWDcjec68H
    3Eqtdb0VXsb1C2SfoLF6sytouwBepi9HmspN1VOA/O29fS08mfDyTxZOqWDWwDJe
    swzo/3rCzB0SIZX27G1FTDOFJUZetDwsDMb1sa9abMhNfzjPfqtIBYgKhx6zdmpX
    J6FNuUYKvxsXa+NiIyY09LIVJt24hRwxAkN6pVsi0baed55pju/AnIE3KePmPOIu
    po9Dg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=tu/FtF9X x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=tu/FtF9X x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Bogdan Purcareata <bogdan.purcareata@nxp.com>
To: gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com,
 ruxandra.radulescu@nxp.com
Subject: [PATCH v6 1/2] staging: fsl-mc: Move core bus out of staging
Date: Mon,  5 Feb 2018 08:07:42 -0600
Message-Id: <20180205140743.29974-2-bogdan.purcareata@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180205140743.29974-1-bogdan.purcareata@nxp.com>
References: <20180205140743.29974-1-bogdan.purcareata@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: MWHPR21CA0059.namprd21.prod.outlook.com
 (2603:10b6:300:db::21) To VI1PR0402MB3664.eurprd04.prod.outlook.com
 (2603:10a6:803:1e::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 012437cc-76d1-4892-f7d2-08d56ca1e7fd
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);
 SRVR:VI1PR0402MB3664;
X-Microsoft-Exchange-Diagnostics: 1; VI1PR0402MB3664;
 3:zWBeniJekmAGxJA7Gy/pi7Z8HS1kQS3m0mrFfjAbp8Ae0K65wqegnDC2k6UHysw5/ItbN02YuLHWxsz99FliHzqYoqvlqjZYM1ZwQ+UQBp3IgAK0x7T3zuovafgehPvDwb6qXfjHyY85s3B48uoyP3TLNuvTUI/RBUSg0hQlDC82mWvzknOPuRrDSj20C3c0H6I/3kfFhM2/vHo+QXfDLMJ0IAGWxUtgakVgs8mqpcyT1vsbmB6xIH/VaGOWkQfn;
 25:LZG64vbz4GdxF4XZFle0Btd3N5TMTZoYi8Fs7zZ5Qn2xK9w+agG8GF9tGm4gXsj7c7HwfYBvDm0KrVxhTsqTHF5tMKzs+OJIyWWbUs3OhN7gvLefaC1omNXWOcJUkVXwOvLsYKcbqer7XKpMQlfVh4281EMMh3iMnT1Iv6A4thGU3JYDdySmoFZ8DkiAeHlmNcBhBxjBxEstyI6erCoMFvnkev5zvNZfbQcnHZTszYk7F1gMBkpuFnHNZHK4cyHUkoxNtKbhGkGr9OmRFcsqcGCYY+GwVxK3NAVgxohMGdZy6EPd3RiCaseqDaZImrKnxKAIna5CDdvzfYjYkVOoKw==;
 31:VgT7X18FfVBXOPTd1l9U2DBhOsBUS6iSIE05lD/6JczjA9HMmoItHv7/n1NwiZ9ERSLLlh7qVJB4emRj024/mw6RX8TDMyheZn4i6G7t0+vlMzAmZvv7YYcgoev4iACWIZErB+VszIXlFyS+QWvh+aAxthVwJ9yNEM2cPMGnMZr4WXFWsw3x/6Bb+GNltWBxE7xJeeRAvnG7dJ0ObNt/TX4iPNCJB5YLDl8KBK0Gmow=
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3664:
X-Microsoft-Exchange-Diagnostics: 1; VI1PR0402MB3664;
 20:c0hrZVZ849X8WZpKIv6GSGf5eHmblFIPgqfnkXOQTrNPp70LmA4uaKSErblGnym8SwMSDYtUz7VWo78d2ijvgxF2LB4u5fiKQh9kiVtVd2dFLmngvX27QxHwtfHqzcxQlnHyUZB6+pDECttSUuEGefs3/1t/D0hk/g3hyCTgi3RKBRFERrWpnOxR1miXVH6wXErlaBmrPAjpEEA858t1ZAOyoKa5cnV9PZP3mVOwcOqQ3BSCMHN3/goPt0XAagzpNQnCbblBmFfd9intEZrvpgFHfHAhWy6enMJ5AowurP7zgKRBnfNumDeKknIqsfkPlAPgPkFsdFUGDRot1Cw6JMVE/7YCLbrtcZqrgZbPcRXid+oS02LXHv7e4JkmNgPLXhGkmMOcxRVPCXr1dB+WNzIqnkqfJP/U7hGFITMiScNPIGgUnOjSheMBpE5P8Jw04LQR1RiDkKEwgK946isSmhCHPSS5oVvQm3fIWNgK2IhjLaaK+WbchTDBQCsfx2Xf
X-Microsoft-Antispam-PRVS: <VI1PR0402MB36647CD036E3284B258BDEA5EAFE0@VI1PR0402MB3664.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(9452136761055)(185117386973197)(227817650892897)(85827821059158)(101931422205132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231101)(2400082)(944501161)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);
 SRVR:VI1PR0402MB3664; BCL:0; PCL:0; RULEID:; SRVR:VI1PR0402MB3664;
X-Microsoft-Exchange-Diagnostics: 1; VI1PR0402MB3664;
 4:HIWbJqawG6sryRhgutDPoP6m3d4438PVRDgeRU6ZodR63eZhdWrIv355gXgCtNlFeYjXpWqeN7MHuPVB05Vc2qEwvV2U+i28qxCLPcWwY4WfLrkRC0zWt9nWVEyrG22bbSHE4s2lPvUnL4aC2FZ2xpCmci5ph/oXznrq0Vu4NtGGtVfAkwupr6AviDPrmXvXF2nHx5TIQrQgak/parapmS0mtsweiTgnEoZSZHlo/g2J15KER+cUrJjKY0TnXAjaqS1GZzknTzU5H/Vl4nK7SyGiLsNVSodgHNdWmaBPId7s6gjd2/8iRaBM4JQvFGvw1aSUmQ7p/hz9iJlC2FdpbJXNgRVYLhk83+DcO/iwv42vxhH9TtBXGvRKqINB+DYU76pnZ4CKodk6p0RFrYNBRdoxtZqBRJW9HcVlyMZrHe5SQI0XwYVEq2T69Hk6p5eFxinvrTEfWsKtGvurq0elY30Kiq6moBXy5cgOu0m1lcU=
X-Forefront-PRVS: 0574D4712B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(39380400002)(39860400002)(376002)(366004)(396003)(346002)(20264003)(199004)(189003)(316002)(39060400002)(16586007)(16526019)(7736002)(305945005)(36756003)(6506007)(6346003)(76176011)(105586002)(59450400001)(52116002)(51416003)(6486002)(66066001)(47776003)(7416002)(68736007)(186003)(386003)(4326008)(6116002)(3846002)(1076002)(26005)(478600001)(2906002)(966005)(50226002)(6666003)(6636002)(6306002)(106356001)(2950100002)(25786009)(53936002)(86362001)(575784001)(81156014)(6512007)(5660300001)(8936002)(50466002)(81166006)(8676002)(97736004)(48376002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3664; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=bogdan.purcareata@nxp.com;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; VI1PR0402MB3664;
 23:tEin2R2gUvJdyiPGB37+jScI9haGMvtzuq1mj+S?=
 =?us-ascii?Q?OynSL36EKKc8S4BZ4d5xm/vPZXeurgXGdK2AkfiG9GUMQqyEdE22YLxM6M/a?=
 =?us-ascii?Q?OUggZkG/xvJT9D8peLclb8XiENao0i2XDgq1/kt4aSJyxtC9mEaPRS3htsuW?=
 =?us-ascii?Q?WYLFqIWE/hHXmR+enic3aTFBzi//35N+R/24tOBukqmsm2Gktji/CldXAiBU?=
 =?us-ascii?Q?+G+otuD7CyFxZGomaPqL9eu59cULhMFfCp+LmUAMKX4jgPf8hO9Y9WUYdBaF?=
 =?us-ascii?Q?fPTh2P+hucaWSKFWVJp+eKD9i7RFQtI7Z5N1lw7nehKX+Z1NkLTOpL1qi/9e?=
 =?us-ascii?Q?GfKMDWjD5ayO86Na0RxhKh7LpCFRjqpVsMq7fIeQfaXaL7BOOKnlyC2LzC99?=
 =?us-ascii?Q?zDCtbJ46uSIbOlNG2iQF88N/ApbQG2+B4+rduOxaO8I4lmxhAYQ4CiLgwb8c?=
 =?us-ascii?Q?Lfqv4H0wTzoT6bZUfiNjz1INDDCvg/2VEHCy9AIF3i9AlQzQWMjzkpiYNGJ+?=
 =?us-ascii?Q?5WlyQjNLQ4fmnHggoM73jMdtseSJ0RlKADwxM/j5t9X15zsvokydFdFF6gJG?=
 =?us-ascii?Q?lY9pszsG3sh4vhkmUAeMUr6zHPWuJDPIiiTcWmlsjkNCLhTfZhZX28KzfU3S?=
 =?us-ascii?Q?6O6ri71V+3ublnoSvoal1bekg0CYkKmhLGmXzN80t3bLE7qcjbxElta2OsL9?=
 =?us-ascii?Q?WmAigTYZVLFf3MFM+3fSyRKeN816RKCjtNGR25gEAbG/Dic/h4OHXadDnuk7?=
 =?us-ascii?Q?bsB06i2mMer9i6xZvKOMQrcT3Hvh0gORZD2r4REgLrP5vr1ai8ApjlL5jc64?=
 =?us-ascii?Q?4ndSkJM5bzGdQSd60Eu7b0d/8bksYvAnM53ny6HO2qlv6DOOktUccXdOgxl7?=
 =?us-ascii?Q?jB+0AuQdRqLaqksqhnJC1EZ65coZXyju6JFLT+hVGs6LJuF1PCtvItfkeBOn?=
 =?us-ascii?Q?BeiAZl1DiCyRPzmltpkSSutbfkj868L4Dc3qIz0lR7jz/NEQcPj8EYSI58Fq?=
 =?us-ascii?Q?LHZ3VE1O5zTHGD8JgQS17vNmkSBVurcLt5C9NJPzw1tf/zx/FF/TSshx4RwD?=
 =?us-ascii?Q?IvzHPIJ6T6tX7eD6syYXU8FpaKpjIG9pOOJWjGZOli7e98usrbcn2DxhIeXm?=
 =?us-ascii?Q?WdumFQ4D5/Tvl+zaQtxelKYUsp7LNDgPCbLGHLLSn5b4subST8ZRMnwl8PpR?=
 =?us-ascii?Q?5pipguusepnW+DZ8Ii1ObMoLHg7dWeudwQvAAZHCiCFvJ6aRO6s0z9nVQ8n+?=
 =?us-ascii?Q?pjcr43chn/DrGqiHM1W7KJsREFHiZ36Rqn3/FLzgIJtOI/5A3PYCMnPRyvI7?=
 =?us-ascii?Q?FDg=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1; VI1PR0402MB3664;
 6:Ut4jhVbPeCDbU2+xjT8PguuDIikWbYU8P+ocxPjrkSmMP56oI8L3KruuN77kiANqSzw1zTwrTfPIXyv6p0QPvii0H2iPIUV33+95UVM2Yiu/kU2OCbHbtp9tvunyV4B220Z2lmBMrlnOe+KgT63tUQsJ+acjt7QhD7ziO1+rFAgyQae1IHy2KTlgK6zXYYLVESeWDnIjvTE9JtrAhODR2d297NvfX/9AXDDckaL6QkM6pDhzBzHMEQrDZNApeWl9HvaGs1Gzw+wUKHzRxGb35WB9hnawcwMYiLeJYekcHVI7K5S160F8gBtYQC4vPyaZQaEI6BhbJ1YnowV7jxPpZ+J29BcKDy3OoSie0GypA38=;
 5:1T1vx5QLACEh2XZeB6BnnQCroHjjLqqH36tdk/VxpL2gjZl5h1gbh16fSt46h81JqOh5VKt0b2gX+6uxiU/rGgqfs4BX8uCwQlJT8oN6o2arJ7eQwwEo6jm2lXyKwB7kbLvZBGFrczusriD8KTWCuUjeXAZAza02xNLd57uwjls=;
 24:l/BO9c0Kx1kgG8oMr2tsk1Hs/u13w46u9+bqd7LdGcuiQBbBMcaHIz6STJGhrTmrGWvz7hO6gC7fJw4nqvdRAUGFzCcE8HtLSY79DRncjqY=;
 7:HejiOfSzcQf6BMtE02/fKze+Ec1YUl+SdtEfSzOrxxKAI+YZd/ksHsHfUhCybta9wpV/PZcDlOim1tMPe1AAJUpdT+PZigd18Mgr1fX1UOurBAp+XRWiWMGqIgFerURKXah+J+XepMP5CX8qnLSq7kJUL2KlTaCbSSCU4Ewyp1dx244IoWmlxl0eVibmyJMi1SXDr+ZgVPg3Nqep9ooQyLzjOcdKIR33zmyCeGiacYE6r7VDzJLMkh+8yff21kLo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2018 14:08:13.3789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 012437cc-76d1-4892-f7d2-08d56ca1e7fd
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3664
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
Cc: devel@driverdev.osuosl.org, robh@kernel.org, stuyoder@gmail.com,
 arnd@arndb.de, marc.zyngier@arm.com, roy.pledge@nxp.com, ioana.ciornei@nxp.com,
 linux-kernel@vger.kernel.org, razvan.stefanescu@nxp.com, horia.geanta@nxp.com,
 nipun.gupta@nxp.com, tglx@linutronix.de, bogdan.purcareata@nxp.com,
 linux-arm-kernel@lists.infradead.org, jason@lakedaemon.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Move the source files out of staging into their final locations:
  -mc.h include file in drivers/staging/fsl-mc/include go to include/linux/fsl
  -source files in drivers/staging/fsl-mc/bus go to drivers/bus/fsl-mc
  -overview.rst, providing an overview of DPAA2, goes to
   Documentation/networking/dpaa2/overview.rst

Update or delete other remaining staging files -- Makefile, Kconfig, TODO.
Update dpaa2_eth and dpio staging drivers.
Add integration bits for the documentation build system.

Signed-off-by: Stuart Yoder <stuyoder@gmail.com>
[rebased, add dpaa2_eth and dpio #include updates]
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
[rebased, split irqchip to separate patch]
Signed-off-by: Bogdan Purcareata <bogdan.purcareata@nxp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
Notes:
    -v6:
      - generate patch with rename detection enabled (GregKH)
    -v5:
      - split irqchip glue code to separate patch (GregKH)
      - integrate doc with the kernel build system
    -v4:
      - regenerated patch with renames detection disabled (Andrew Lunn)
    -v3:
      - rebased
    -v2:
      - group irqchip gic its glue code together with the rest (Marc Zyngier)

 Documentation/networking/dpaa2/index.rst               |  8 ++++++++
 .../networking/dpaa2}/overview.rst                     |  0
 Documentation/networking/index.rst                     |  1 +
 MAINTAINERS                                            |  3 ++-
 drivers/bus/Kconfig                                    |  2 ++
 drivers/bus/Makefile                                   |  4 ++++
 drivers/bus/fsl-mc/Kconfig                             | 16 ++++++++++++++++
 drivers/bus/fsl-mc/Makefile                            | 16 ++++++++++++++++
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmcp.c     |  2 +-
 .../{staging/fsl-mc/bus => bus/fsl-mc}/dprc-driver.c   |  2 +-
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc.c      |  3 ++-
 .../fsl-mc/bus => bus/fsl-mc}/fsl-mc-allocator.c       |  2 +-
 .../{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-bus.c    |  0
 .../{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-msi.c    |  1 +
 .../fsl-mc/bus => bus/fsl-mc}/fsl-mc-private.h         |  2 +-
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-io.c     |  2 +-
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-sys.c    |  2 +-
 drivers/staging/fsl-dpaa2/ethernet/README              |  2 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c         |  2 +-
 drivers/staging/fsl-dpaa2/ethernet/dpni.c              |  2 +-
 drivers/staging/fsl-mc/TODO                            | 18 ------------------
 drivers/staging/fsl-mc/bus/Kconfig                     | 10 ----------
 drivers/staging/fsl-mc/bus/Makefile                    | 16 +++-------------
 drivers/staging/fsl-mc/bus/dpbp.c                      |  2 +-
 drivers/staging/fsl-mc/bus/dpcon.c                     |  2 +-
 drivers/staging/fsl-mc/bus/dpio/dpio-driver.c          |  2 +-
 drivers/staging/fsl-mc/bus/dpio/dpio-service.c         |  2 +-
 drivers/staging/fsl-mc/bus/dpio/dpio.c                 |  2 +-
 drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c |  2 +-
 .../staging/fsl-mc/include => include/linux/fsl}/mc.h  |  0
 30 files changed, 70 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/networking/dpaa2/index.rst
 rename {drivers/staging/fsl-mc => Documentation/networking/dpaa2}/overview.rst (100%)
 create mode 100644 drivers/bus/fsl-mc/Kconfig
 create mode 100644 drivers/bus/fsl-mc/Makefile
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpmcp.c (98%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc-driver.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dprc.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-allocator.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-bus.c (100%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-msi.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/fsl-mc-private.h (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-io.c (99%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/mc-sys.c (99%)
 delete mode 100644 drivers/staging/fsl-mc/TODO
 rename {drivers/staging/fsl-mc/include => include/linux/fsl}/mc.h (100%)

diff --git a/Documentation/networking/dpaa2/index.rst b/Documentation/networking/dpaa2/index.rst
new file mode 100644
index 0000000..4c6586c
--- /dev/null
+++ b/Documentation/networking/dpaa2/index.rst
@@ -0,0 +1,8 @@
+===================
+DPAA2 Documentation
+===================
+
+.. toctree::
+   :maxdepth: 1
+
+   overview
diff --git a/drivers/staging/fsl-mc/overview.rst b/Documentation/networking/dpaa2/overview.rst
similarity index 100%
rename from drivers/staging/fsl-mc/overview.rst
rename to Documentation/networking/dpaa2/overview.rst
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 90966c2..f204eaf 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -8,6 +8,7 @@ Contents:
 
    batman-adv
    can
+   dpaa2/index
    kapi
    z8530book
    msg_zerocopy
diff --git a/MAINTAINERS b/MAINTAINERS
index 4c104db..91e79bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11365,8 +11365,9 @@ M:	Stuart Yoder <stuyoder@gmail.com>
 M:	Laurentiu Tudor <laurentiu.tudor@nxp.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
-F:	drivers/staging/fsl-mc/
+F:	drivers/bus/fsl-mc/
 F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
+F:	Documentation/networking/dpaa2/overview.rst
 
 QT1010 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 57e011d..769599b 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -199,4 +199,6 @@ config DA8XX_MSTPRI
 	  configuration. Allows to adjust the priorities of all master
 	  peripherals.
 
+source "drivers/bus/fsl-mc/Kconfig"
+
 endmenu
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index 9bcd0bf..b666c49 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -8,6 +8,10 @@ obj-$(CONFIG_ARM_CCI)		+= arm-cci.o
 obj-$(CONFIG_ARM_CCN)		+= arm-ccn.o
 
 obj-$(CONFIG_BRCMSTB_GISB_ARB)	+= brcmstb_gisb.o
+
+# DPAA2 fsl-mc bus
+obj-$(CONFIG_FSL_MC_BUS)	+= fsl-mc/
+
 obj-$(CONFIG_IMX_WEIM)		+= imx-weim.o
 obj-$(CONFIG_MIPS_CDMM)		+= mips_cdmm.o
 obj-$(CONFIG_MVEBU_MBUS) 	+= mvebu-mbus.o
diff --git a/drivers/bus/fsl-mc/Kconfig b/drivers/bus/fsl-mc/Kconfig
new file mode 100644
index 0000000..bcca644
--- /dev/null
+++ b/drivers/bus/fsl-mc/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# DPAA2 fsl-mc bus
+#
+# Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
+#
+
+config FSL_MC_BUS
+	bool "QorIQ DPAA2 fsl-mc bus driver"
+	depends on OF && (ARCH_LAYERSCAPE || (COMPILE_TEST && (ARM || ARM64 || X86 || PPC)))
+	select GENERIC_MSI_IRQ_DOMAIN
+	help
+	  Driver to enable the bus infrastructure for the QorIQ DPAA2
+	  architecture.  The fsl-mc bus driver handles discovery of
+	  DPAA2 objects (which are represented as Linux devices) and
+	  binding objects to drivers.
diff --git a/drivers/bus/fsl-mc/Makefile b/drivers/bus/fsl-mc/Makefile
new file mode 100644
index 0000000..6a97f2c
--- /dev/null
+++ b/drivers/bus/fsl-mc/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Freescale Management Complex (MC) bus drivers
+#
+# Copyright (C) 2014 Freescale Semiconductor, Inc.
+#
+obj-$(CONFIG_FSL_MC_BUS) += mc-bus-driver.o
+
+mc-bus-driver-objs := fsl-mc-bus.o \
+		      mc-sys.o \
+		      mc-io.o \
+		      dprc.o \
+		      dprc-driver.o \
+		      fsl-mc-allocator.o \
+		      fsl-mc-msi.o \
+		      dpmcp.o
diff --git a/drivers/staging/fsl-mc/bus/dpmcp.c b/drivers/bus/fsl-mc/dpmcp.c
similarity index 98%
rename from drivers/staging/fsl-mc/bus/dpmcp.c
rename to drivers/bus/fsl-mc/dpmcp.c
index be07c77..8d997b0 100644
--- a/drivers/staging/fsl-mc/bus/dpmcp.c
+++ b/drivers/bus/fsl-mc/dpmcp.c
@@ -4,7 +4,7 @@
  *
  */
 #include <linux/kernel.h>
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
 
 #include "fsl-mc-private.h"
 
diff --git a/drivers/staging/fsl-mc/bus/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dprc-driver.c
rename to drivers/bus/fsl-mc/dprc-driver.c
index b090757..52c7e15 100644
--- a/drivers/staging/fsl-mc/bus/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -11,7 +11,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/msi.h>
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
 
 #include "fsl-mc-private.h"
 
diff --git a/drivers/staging/fsl-mc/bus/dprc.c b/drivers/bus/fsl-mc/dprc.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dprc.c
rename to drivers/bus/fsl-mc/dprc.c
index 97f5172..5c23e8d 100644
--- a/drivers/staging/fsl-mc/bus/dprc.c
+++ b/drivers/bus/fsl-mc/dprc.c
@@ -4,7 +4,8 @@
  *
  */
 #include <linux/kernel.h>
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
+
 #include "fsl-mc-private.h"
 
 /**
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
rename to drivers/bus/fsl-mc/fsl-mc-allocator.c
index 8f313a4..452c5d7 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -8,7 +8,7 @@
 
 #include <linux/module.h>
 #include <linux/msi.h>
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
 
 #include "fsl-mc-private.h"
 
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
similarity index 100%
rename from drivers/staging/fsl-mc/bus/fsl-mc-bus.c
rename to drivers/bus/fsl-mc/fsl-mc-bus.c
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-msi.c b/drivers/bus/fsl-mc/fsl-mc-msi.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/fsl-mc-msi.c
rename to drivers/bus/fsl-mc/fsl-mc-msi.c
index 971ad87..ec35e25 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-msi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-msi.c
@@ -13,6 +13,7 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
+
 #include "fsl-mc-private.h"
 
 #ifdef GENERIC_MSI_DOMAIN_OPS
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
similarity index 99%
rename from drivers/staging/fsl-mc/bus/fsl-mc-private.h
rename to drivers/bus/fsl-mc/fsl-mc-private.h
index 83b89d6..bed990c 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -8,7 +8,7 @@
 #ifndef _FSL_MC_PRIVATE_H_
 #define _FSL_MC_PRIVATE_H_
 
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
 #include <linux/mutex.h>
 
 /*
diff --git a/drivers/staging/fsl-mc/bus/mc-io.c b/drivers/bus/fsl-mc/mc-io.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/mc-io.c
rename to drivers/bus/fsl-mc/mc-io.c
index 7e6fb36..7226cfc 100644
--- a/drivers/staging/fsl-mc/bus/mc-io.c
+++ b/drivers/bus/fsl-mc/mc-io.c
@@ -5,7 +5,7 @@
  */
 
 #include <linux/io.h>
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
 
 #include "fsl-mc-private.h"
 
diff --git a/drivers/staging/fsl-mc/bus/mc-sys.c b/drivers/bus/fsl-mc/mc-sys.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/mc-sys.c
rename to drivers/bus/fsl-mc/mc-sys.c
index f09d75d..bd03f15 100644
--- a/drivers/staging/fsl-mc/bus/mc-sys.c
+++ b/drivers/bus/fsl-mc/mc-sys.c
@@ -12,7 +12,7 @@
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/io-64-nonatomic-hi-lo.h>
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
 
 #include "fsl-mc-private.h"
 
diff --git a/drivers/staging/fsl-dpaa2/ethernet/README b/drivers/staging/fsl-dpaa2/ethernet/README
index 410952e..e3b5c90 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/README
+++ b/drivers/staging/fsl-dpaa2/ethernet/README
@@ -36,7 +36,7 @@ are treated as internal resources of other objects.
 
 For a more detailed description of the DPAA2 architecture and its object
 abstractions see:
-	drivers/staging/fsl-mc/README.txt
+	Documentation/networking/dpaa2/overview.rst
 
 Each Linux net device is built on top of a Datapath Network Interface (DPNI)
 object and uses Buffer Pools (DPBPs), I/O Portals (DPIOs) and Concentrators
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 2817e67..b519fee 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -39,7 +39,7 @@
 #include <linux/kthread.h>
 #include <linux/iommu.h>
 
-#include "../../fsl-mc/include/mc.h"
+#include <linux/fsl/mc.h>
 #include "dpaa2-eth.h"
 
 /* CREATE_TRACE_POINTS only needs to be defined once. Other dpa files
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpni.c b/drivers/staging/fsl-dpaa2/ethernet/dpni.c
index e8be761..b16ff5c 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpni.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpni.c
@@ -32,7 +32,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/errno.h>
-#include "../../fsl-mc/include/mc.h"
+#include <linux/fsl/mc.h>
 #include "dpni.h"
 #include "dpni-cmd.h"
 
diff --git a/drivers/staging/fsl-mc/TODO b/drivers/staging/fsl-mc/TODO
deleted file mode 100644
index 54a8bc6..0000000
--- a/drivers/staging/fsl-mc/TODO
+++ /dev/null
@@ -1,18 +0,0 @@
-* Add at least one device driver for a DPAA2 object (child device of the
-  fsl-mc bus).  Most likely candidate for this is adding DPAA2 Ethernet
-  driver support, which depends on drivers for several objects: DPNI,
-  DPIO, DPMAC.  Other pre-requisites include:
-
-     * MC firmware uprev.  The MC firmware upon which the fsl-mc
-       bus driver and DPAA2 object drivers are based is continuing
-       to evolve, so minor updates are needed to keep in sync with binary
-       interface changes to the MC.
-
-* Cleanup
-
-Please send any patches to Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
-german.rivera@freescale.com, devel@driverdev.osuosl.org,
-linux-kernel@vger.kernel.org
-
-[1] https://lkml.org/lkml/2015/7/9/93
-[2] https://lkml.org/lkml/2015/7/7/712
diff --git a/drivers/staging/fsl-mc/bus/Kconfig b/drivers/staging/fsl-mc/bus/Kconfig
index 1f91000..5f4115d 100644
--- a/drivers/staging/fsl-mc/bus/Kconfig
+++ b/drivers/staging/fsl-mc/bus/Kconfig
@@ -5,16 +5,6 @@
 # Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
 #
 
-config FSL_MC_BUS
-	bool "QorIQ DPAA2 fsl-mc bus driver"
-	depends on OF && (ARCH_LAYERSCAPE || (COMPILE_TEST && (ARM || ARM64 || X86 || PPC)))
-	select GENERIC_MSI_IRQ_DOMAIN
-	help
-	  Driver to enable the bus infrastructure for the QorIQ DPAA2
-	  architecture.  The fsl-mc bus driver handles discovery of
-	  DPAA2 objects (which are represented as Linux devices) and
-	  binding objects to drivers.
-
 config FSL_MC_DPIO
         tristate "QorIQ DPAA2 DPIO driver"
         depends on FSL_MC_BUS && ARCH_LAYERSCAPE
diff --git a/drivers/staging/fsl-mc/bus/Makefile b/drivers/staging/fsl-mc/bus/Makefile
index 29059db..18b1b5f 100644
--- a/drivers/staging/fsl-mc/bus/Makefile
+++ b/drivers/staging/fsl-mc/bus/Makefile
@@ -4,19 +4,9 @@
 #
 # Copyright (C) 2014 Freescale Semiconductor, Inc.
 #
-obj-$(CONFIG_FSL_MC_BUS) += mc-bus-driver.o
-
-mc-bus-driver-objs := fsl-mc-bus.o \
-		      mc-sys.o \
-		      mc-io.o \
-		      dprc.o \
-		      dprc-driver.o \
-		      fsl-mc-allocator.o \
-		      fsl-mc-msi.o \
-		      irq-gic-v3-its-fsl-mc-msi.o \
-		      dpmcp.o \
-		      dpbp.o \
-		      dpcon.o
+obj-$(CONFIG_FSL_MC_BUS) += irq-gic-v3-its-fsl-mc-msi.o \
+			    dpbp.o \
+			    dpcon.o
 
 # MC DPIO driver
 obj-$(CONFIG_FSL_MC_DPIO) += dpio/
diff --git a/drivers/staging/fsl-mc/bus/dpbp.c b/drivers/staging/fsl-mc/bus/dpbp.c
index a4df846..c0addaa 100644
--- a/drivers/staging/fsl-mc/bus/dpbp.c
+++ b/drivers/staging/fsl-mc/bus/dpbp.c
@@ -4,7 +4,7 @@
  *
  */
 #include <linux/kernel.h>
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
 #include "../include/dpbp.h"
 
 #include "dpbp-cmd.h"
diff --git a/drivers/staging/fsl-mc/bus/dpcon.c b/drivers/staging/fsl-mc/bus/dpcon.c
index 8f84d7b..021b425 100644
--- a/drivers/staging/fsl-mc/bus/dpcon.c
+++ b/drivers/staging/fsl-mc/bus/dpcon.c
@@ -4,7 +4,7 @@
  *
  */
 #include <linux/kernel.h>
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
 #include "../include/dpcon.h"
 
 #include "dpcon-cmd.h"
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
index b8479ef..182b384 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
@@ -14,7 +14,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
 
-#include "../../include/mc.h"
+#include <linux/fsl/mc.h>
 #include "../../include/dpaa2-io.h"
 
 #include "qbman-portal.h"
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c b/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
index d3c8462..1acff7e 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
@@ -5,7 +5,7 @@
  *
  */
 #include <linux/types.h>
-#include "../../include/mc.h"
+#include <linux/fsl/mc.h>
 #include "../../include/dpaa2-io.h"
 #include <linux/init.h>
 #include <linux/module.h>
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio.c b/drivers/staging/fsl-mc/bus/dpio/dpio.c
index 20cdeae..3175057 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio.c
@@ -5,7 +5,7 @@
  *
  */
 #include <linux/kernel.h>
-#include "../../include/mc.h"
+#include <linux/fsl/mc.h>
 
 #include "dpio.h"
 #include "dpio-cmd.h"
diff --git a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c b/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
index 5064d5d..b365fbb 100644
--- a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
@@ -13,7 +13,7 @@
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
-#include "../include/mc.h"
+#include <linux/fsl/mc.h>
 
 static struct irq_chip its_msi_irq_chip = {
 	.name = "ITS-fMSI",
diff --git a/drivers/staging/fsl-mc/include/mc.h b/include/linux/fsl/mc.h
similarity index 100%
rename from drivers/staging/fsl-mc/include/mc.h
rename to include/linux/fsl/mc.h
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
