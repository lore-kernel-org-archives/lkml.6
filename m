Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2598244-1517839704-2-8442013552467866863
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
    t=1517839703; b=TptyL7eRoTmQ4eLKXw8qz6iqjwLy7VrOYIhkaOOsFYNGL4E
    O0ypAxQ8utQT8cW25yaLTzMNeKEZpXUvkIaZzAdEj5oYJwspFSStH1Q7i2LItgqs
    9nz1O2Hg4WGc1Nle3qEzul5/6WEEZHZLVJiQWgreFfFQMcJGBG9gHEYmDVaX7qhR
    Ty0h6hxRH+TGCnQIPzeL/s2fO/ezZprcMrRyX0QN3C8QZedLyCkfaXV9S179QMmx
    /OyfiePO2UeavUGhuPvcdi5RCiu7NCnpg1Q7WoB/V7A+IV3segpm3pQcTkdfvP3f
    wLi82ycPA55WE+U/UhjHHTk2JKAPn6RMy5T0SyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517839703; bh=/
    gumwGkd+6x/6stY2S/1dDlTYwL5u2lk9qDW4znmYkw=; b=SmuysQPmxNGOVUaTY
    uxUaKdPdh/wfePX797MEK8aAn5ZCjHusReBqVTsn3AFnhD4akA8h4hPxWlZbEnfx
    PP5qeIiPRXUpzh7zjZrWeuCpEb85VYEChK2lKsc24MDs5EqsXP8k6tnTf9IGP2g+
    zVTjI6o12Pp3Tp45f7IYVtZWOLbpl8Db6QK2W3FwE9uS2P8pXmyylbIm0zZcTtxZ
    u1kKN5sJA4/Ygf+7zMzVAY99dw3jgPyC3d9ikqCyi28gu4dOpuw7CMTBWBBwSnnH
    7ztExzOlQ++GqfmFYpV+3FvHPFfsvQyICtiJcauW0/fSxTKO7titK4aAhoUk42/P
    vXHyQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=neVmXt9H x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=neVmXt9H x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
Subject: [PATCH v6 0/2] staging: fsl-mc: Move bus driver out of staging
Date: Mon,  5 Feb 2018 08:07:41 -0600
Message-Id: <20180205140743.29974-1-bogdan.purcareata@nxp.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: MWHPR21CA0059.namprd21.prod.outlook.com
 (2603:10b6:300:db::21) To VI1PR0402MB3664.eurprd04.prod.outlook.com
 (2603:10a6:803:1e::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d3e3f63a-3e51-4f8d-b7f2-08d56ca1e310
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);
 SRVR:VI1PR0402MB3664;
X-Microsoft-Exchange-Diagnostics: 1; VI1PR0402MB3664;
 3:6SzBHfl7juz46qd1nHpBD4xAC63A09QlmrADGEIkr83QFk+jAgS9MB8jLyE0x0vwcgsy0hsIbosApNWo4ItKWN56P2VbKLzHxZhqDUGMzolkl71iJGWZsBPmkwbuRlRCoPFM5gTEJoIdyEUSRbfMzgc5V1XLpAtRWy/ahjMKbqD5NuOMeyuFuKT4AyknYsMZ6RpQML/dyZTvKVaKcZ6wmMMH/dTmeglcaBIcPaISEI7WuJv+rtDvgrvQBplQMJVF;
 25:5OmsfDP0U3YeDBdiiBEBWI/+F6QsJOTfN7HdYq+RRTOWxGKqdnUr1Pu3HyntWGcmB5So7//sPNdWXVWI0PWkaveS21cF44KxIKcwJH8btvOl0JrthjGO5xwyckDY18MzQ3PNBXHQDxFr4EJeSVAYJG3vX3Hy0PvKYKHD05DOk53XWS0CcijouTi7uQZGEH2sVN4VXoTEHQ4DvwwWf6ZvcgY0ZNUUBVORHczj2i3+j2nGf8Gr24vhDFzZQg0CmuTYWRas24zdzGx8Ge7WA18lvvZDOt6a3NyBUSfIuKIx1OEIcTMNfsCMb3QarxgdNAC7D3nN3nTLkkyLYUac841U5g==;
 31:xYdzevf3F7ooZztPOrORFyS2agSeVK3716ROHUN2LUDMHNBh87y6LROrt57dZr1QHiXH/K+HZPg3pVUt6rhKCO20tTvsQwvKGIkFAU7gya7r3I4U3ff7Q61w8hHsLyevbGng9Gq6EAlyln7oZo7/3NYyvdBsZ4C6RdguJ+c91UC2wvvKLsbVYiqbGWBVqnkJCfcBr/a7PTLuagAko+dt3o/jXnZLMB/YV+4RLlZGZ20=
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3664:
X-Microsoft-Exchange-Diagnostics: 1; VI1PR0402MB3664;
 20:8Nv+vjBDx+2XCFzQmQTYi7jNGhPmKR9KozPSrz/iZt4xDufzqDepN7tOpJHS09kYBcW27Nl3gr7BQha5ICM+74AWJr18DHBM8WjzfW8ZYCcLRic02sfQhhi9k4iuI1r+XRzEZG7B5C3ZMKRJd5A3KrGvdSaiu1O2pYxYwoH+eY0mo/HM8Y9DrqvHYLU4xYTMyiE+YenMkejRh/cn+ONtbbQsFrIn/kAAN5KzwNWZtpiDfxPEJuZO8Q2lQOwEREQVrzghpsw86WYnuzvO8rNPxrCdB3UMcqnPb3uAoQpEcTnpDXRD4OQTxL/QobxT1dBiILwyislbm/lsZIzMfwZBTveroG0qpEHONqLY+/O3SgwrPChdz54BLhtBsDWD02CZFkblssmQe2DdBZslfgQ37ZCImBXN5jOr1XRnnDsef3+yYXjlsUq4itl7H9Cmivp8LUd+5FjVFO+oeaiLEQtaTmUrW5jJp/7EBcsabgHnQ8LxDW0xSi5RTRNhZa81jxUP;
 4:uQqxL2fi3yp3DvrAvJMgT3oyKMXHrYa7jfGsW+B+DkhRqpPQWaVJ+Rki8cIUNWD0jP8Bu+F5+WXQsQLHJ+dwLABG2/UYbwX5MJGyxeJmGJO24VSKsiGZxuDcyMwdlCsixBBeXifZqHOpDPbleugs+pUJO8LA2jGaZ+svIiDfjJ5+nH/EJSf7d0Bp5E09jPf91jLAlNWSOQx7Zevgj+8cFRLZnN+U7WFPclARXL9nz84lhZRSfvkbKNuVQj8sP7MG5ItZZpgl6lSo6JA6QzBeAA==
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3664729B96A6B51D237344B5EAFE0@VI1PR0402MB3664.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231101)(2400082)(944501161)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);
 SRVR:VI1PR0402MB3664; BCL:0; PCL:0; RULEID:; SRVR:VI1PR0402MB3664;
X-Forefront-PRVS: 0574D4712B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(39380400002)(39860400002)(376002)(366004)(396003)(346002)(199004)(189003)(316002)(39060400002)(16586007)(16526019)(7736002)(305945005)(36756003)(6506007)(6346003)(105586002)(59450400001)(52116002)(51416003)(6486002)(66066001)(47776003)(7416002)(68736007)(186003)(386003)(4326008)(6116002)(3846002)(1076002)(26005)(478600001)(2906002)(966005)(50226002)(6666003)(6636002)(6306002)(106356001)(25786009)(53936002)(86362001)(81156014)(6512007)(5660300001)(8936002)(50466002)(81166006)(8676002)(97736004)(48376002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3664; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=bogdan.purcareata@nxp.com;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; VI1PR0402MB3664;
 23:y33R/TWoQMZwYd+2X41sko5+3xeOI2Pxt4oymgn?=
 =?us-ascii?Q?9Rh7nYNfFbY0iJQrbmN1HlCoELUASiH3nV/+pujHrZ2xlQzQElRHGCS1vfa9?=
 =?us-ascii?Q?uOUf+Dq09g10A8Molj/pbNmRl+ZLKNo5ImVfhqJeaBMICaap8mlHzYwgIhQA?=
 =?us-ascii?Q?NFYJhxGTHRPgz7SB6QusiVvJIVGshq6ZbKxC5+VZotQr7fTwWrMwD3Q/qEh3?=
 =?us-ascii?Q?ipshDDTTvHgLPfbyAw1t94FwOhEjYTMjggGD0X++P6ydPEX2nmIw32AAaHLE?=
 =?us-ascii?Q?zbU75L9Z55E4eFNTCz6SMb9M3y/j/26g0dergWZrdS9yG7cWGrfhbujx+vRY?=
 =?us-ascii?Q?tSvh+rpBtsmNzeOVV1iIKZWieWv3jsDH52kMv2YKyzEZ10+PhOdUMXrIi+Bt?=
 =?us-ascii?Q?kNo+smTVj/sPjY5byf1ti/cQpH0//45FkLQLG1WJDeQxMN99/Ne4ANJ3lWUx?=
 =?us-ascii?Q?yXMHVzqQKuNwIplYJcF89T9z3SNkRnQqCjvnIrz+rThNcLfyBNp6PBevZrco?=
 =?us-ascii?Q?xiMer+/fkWwgymBuD5SHMQ2ng7sJMydn0/cPOGH9V+bxIpGOa55TBu1CElwa?=
 =?us-ascii?Q?MAKj8I2jKm4XI+kq5qN1yGuH5c1FaPz1ffL7Q0MuNbaIic6gXLc2ySFaBKa8?=
 =?us-ascii?Q?ap0YV8pCvEw/ZHjMvV7DPWz6IWlaLGFVHAnrHjGmRUIsgALRl0APv18dM4wx?=
 =?us-ascii?Q?FEKKPdISsvgVhwtM7VbQRjBWiuhi3qnb2JCT7pIauLAZ3MR4qNDxQdMWwOTh?=
 =?us-ascii?Q?Sc44LiZtsmgkDliK4sxk9LyjML36bBj91ccsb6KRW1/dEo1DBNE+ahz7MAVn?=
 =?us-ascii?Q?1nAziZ6FeTRG7LUDAdDlR6+Sc29R474SeXrftYYYgghw8JkObayjiFUszN9U?=
 =?us-ascii?Q?DQQ9meOUFBFqhsgV/460Ug5VgkrHkbfNi1LcOr3k4tFIvo1D4k9Snm/VxafQ?=
 =?us-ascii?Q?ZKvaxu8eyozuil1ZRuSUAI5Ve/sfhBl6oxYoPt75u0DHWQClDYGK3Jy1hwme?=
 =?us-ascii?Q?bnXzv4ZE1806DqGKasnzp3ahMHZsZ8QsemxnYqVdNipLatzXVODUtTmNnG/V?=
 =?us-ascii?Q?3uBE83s/6smmwuV6N930kOLUXnC7etNFy4FfCiaG0jBZofHY/CvffsNxGVqf?=
 =?us-ascii?Q?LlJqYNhPIILfS7dcF4ZM4gPlmwd5H2f0mJEdaH48IoWFruf2pZhvnpg8CpQJ?=
 =?us-ascii?Q?r/IqZ1/5+oSL99jgfEFADgj3GNAHbKWJkW48w?=
X-Microsoft-Exchange-Diagnostics: 1; VI1PR0402MB3664;
 6:II3ER/uv4uz7WMnOMk2jX42WknIj2FbnrNn9tITYIWya8qRvae7psyCE0NYgjyLr+XiJs13momWeypxLbdf4qnBUxBppPqm9+u0dobkussSbohf+Z5sb7MhDqbrWCdUvilO9xwqp6AuR4I3tCPogQ+kchq4RUczXbeiMtf5fc3R3Pudw20zZoeAezoLUVd3VlnigJVrUxKT8ur/g6JMnMkoAVKJEqk0LVUOJOt8zq5ybVB5EASLbqqt1hpWzYYCmy5IvtoUZShWJuRQ6Yy8MzDk7TtYPb9k5tQsEXivVn7xIPg/TEGSDLLS+KV9ScGJhxFOgobRfi95iJOmJm7DiHnNHxH+eZ8eMx1jH1Mega9E=;
 5:JoLF+Ji6lKc8E7e0oyRWjh22LXnrbqJZbS+s5aN+b0Rh7OUAeRp+jtLqGx+f0WBP7xiMEybMZtO4S91VMWct5SRMGuy3D15xhKF4Em20szN0rLoeYZpVRKP6O0zS6bR3Yy6FUX3kZUG38QBfYSAaC5BDmE+dFTWGsEtTcMioYtI=;
 24:LbMfZt2hEaR06pXwLly8wZ4DCzTcZQ92KIUJLuGYRW1M7c1S2ZyrABIx0fOmsEZBl+IosrTcJUzRMdeLqSCyuwHB1Bq+qu++X2fuzvW863Y=;
 7:RUrFi0o24/uAcCfxL5eYUrH/NqPJdx3GJIuNDbiVZgZ0icVX3UAvqHPT+/3gkdA9grX0R0Jbyk0fqdZAbvQyZuCgFFM1y6HzTxR+p5XrO1hUPU9FzXvoJ2hTB3EWzJqTbLrYWp4QM1WJZ8bIQ0IgL9TRbuyK92KcUPr/2GQX13AcHrMNe+tqJh3ng59WCTBuHRrcUGTk4nPzMjbVP6nd+xdwZckjItpFOVkdXD36oIKlTMT+xWfjuUclVEIY7uWS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2018 14:08:05.0507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e3f63a-3e51-4f8d-b7f2-08d56ca1e310
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

Previous submission: https://lkml.org/lkml/2018/1/26/215

Split the code into moving out the core bus infrastructure separate from
the irqchip glue code. Add a Kconfig dependency on ARM_GIC_V3_ITS.
Integrate the documentation with the kernel build system.

This patchset only handles moving the fsl-mc bus core out of staging.
The remaining objects (DPBP, DPCON) and drivers (dpio, dpaa2-eth) will
be moved out in subsequent patches.

Notes:
    -v6:
      - generate patchset with rename detection enabled (GregKH)
      - add Kconfig dependecy on ARM_GIC_V3_ITS (Mark Zyngier)
    -v5:
      - split irqchip glue code to separate patch (GregKH)
      - integrate doc with the kernel build system
    -v4:
      - regenerated patch with renames detection disabled (Andrew Lunn)
    -v3:
      - rebased
    -v2:
      - group irqchip gic its glue code together with the rest (Marc Zyngier)

Bogdan Purcareata (2):
  staging: fsl-mc: Move core bus out of staging
  staging: fsl-mc: Move irqchip code out of staging

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
 drivers/irqchip/Kconfig                                |  6 ++++++
 drivers/irqchip/Makefile                               |  1 +
 .../fsl-mc/bus => irqchip}/irq-gic-v3-its-fsl-mc-msi.c |  4 +---
 drivers/staging/fsl-dpaa2/ethernet/README              |  2 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c         |  2 +-
 drivers/staging/fsl-dpaa2/ethernet/dpni.c              |  2 +-
 drivers/staging/fsl-mc/TODO                            | 18 ------------------
 drivers/staging/fsl-mc/bus/Kconfig                     | 10 ----------
 drivers/staging/fsl-mc/bus/Makefile                    | 15 ++-------------
 drivers/staging/fsl-mc/bus/dpbp.c                      |  2 +-
 drivers/staging/fsl-mc/bus/dpcon.c                     |  2 +-
 drivers/staging/fsl-mc/bus/dpio/dpio-driver.c          |  2 +-
 drivers/staging/fsl-mc/bus/dpio/dpio-service.c         |  2 +-
 drivers/staging/fsl-mc/bus/dpio/dpio.c                 |  2 +-
 .../staging/fsl-mc/include => include/linux/fsl}/mc.h  |  0
 32 files changed, 76 insertions(+), 60 deletions(-)
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
 rename drivers/{staging/fsl-mc/bus => irqchip}/irq-gic-v3-its-fsl-mc-msi.c (97%)
 delete mode 100644 drivers/staging/fsl-mc/TODO
 rename {drivers/staging/fsl-mc/include => include/linux/fsl}/mc.h (100%)

-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
