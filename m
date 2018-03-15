Return-Path: <ioana.ciornei@nxp.com>
X-Google-Smtp-Source: AG47ELtb+bDOyhUMqkEj4xhZfjGB8s/c550RDgZrj09NAQaubkYG1BAbLy+RnXtRsy+mOQEoJCyM
ARC-Seal: i=1; a=rsa-sha256; t=1521133567; cv=none;
        d=google.com; s=arc-20160816;
        b=yCY2MMDxljnRsCqnKuF4a1FvK4vfGopJm0/CIZU2UFVJFKlwMqGgtSI4z57mPJsL1+
         NkYQPmYyWx4TliGVlR4aDKlNAHh4y79u80neoVOam88zI6fpPK2OcI476cfdumcx7zCm
         V3AUBd7Pkfr2M96jYomiY3NGDwfPCZBUJaeeKRaiHX65CSJ7nm2JXJjlNoyoWR7re+PT
         jpVVN6Tu63QM0WqLaj0cwN1xBnnBIXcLuYPb0Qe1qld1jeiYYgFYiVFsR0wShj5voJ9g
         IVgQ0gq9JZ2M1QG6pQhZTT1/6rvtCjlPCsknuih8Du3PTrM7fLrICxa3kK5Vw3nsYu6E
         ckzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=9qYhxSIE2NCM533IebBmunPSJAQKZFMZ7q+QBjdt7U8=;
        b=xPjtCqF1bu5PAQ4jyg48zwClCL8EWcm7JxmMypQSqpg5VBwV/A5MPFBT8t5vRSZV7s
         myMoiNTdUXsrXO8oQ6K0yqtKj4e/1y2SWu9qv3sDNSYWCDUsEvISOBThOJAUFwSkHtGy
         23r7eDWjUSbOBiEnZZ9qg57yfL/yqtbjbVvA8oz1oABhu6hhGHOGpO0diOgZs6+cKCvN
         598OsjFWculMk5baJThdQauVMSSz9Np3z5l/JGqGxF5YMzuE7sX/+woU+CZmMqck3J1M
         OOfghEkMuWNSemWMEh6OvWfB6cRk70jgUxxwhU6BCIT+a3ubiWl4kBZo+IkBbjaipQ1Q
         U3jQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=L6P6mKqz;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.2.40 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=L6P6mKqz;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.2.40 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com;
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: gregkh@linuxfoundation.org,
	laurentiu.tudor@nxp.com
Cc: linux-kernel@vger.kernel.org,
	stuyoder@gmail.com,
	ruxandra.radulescu@nxp.com,
	razvan.stefanescu@nxp.com,
	Roy.Pledge@nxp.com,
	arnd@arndb.de,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 0/6] bus: fsl-mc: enhance Management Complex userspace support
Date: Thu, 15 Mar 2018 12:05:30 -0500
Message-Id: <cover.1521132659.git.ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: MWHPR15CA0039.namprd15.prod.outlook.com
 (2603:10b6:300:ad::25) To DB6PR04MB3206.eurprd04.prod.outlook.com
 (2603:10a6:6:6::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 19d2c3d6-fe2c-4443-d0a9-08d58a9709e0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3206;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3206;3:R4cQ9m9G295y7OrrNKR/gh60ZZzsQhCcpDUO79SGPa9TL6b9yYpiYMjxe/3J7VG8zD63sMq/kr73YrjdaV1Qzo/Mm8fEa23V9XDY/h1QT/1QedrhTN0UDbAtw48hf7jTPaP377cQya5i1ucbQzeb0WAIGpCwToIsc33+6zXBgH7UJkow647wBd7zZTZAKJFJL7T31OBxjeRGQlkgEzs9/yijOp2CCa0vctjHQzju/sYh2poReq8rYpxd6rFx1MHh;25:m7c/tZl4UThqkI6Cwi87wE0+t2GY0DD0IJV+ZCRKFgVXYUsyUIafkk8NUoFii6xrXgPhp+8cSMhFspdUIrV5vvySwsSgO3AV041mZP0l3Mw4AVTpLyo5cFqK3z//24IHvlIXA76VmWedKwa/Hj1DkDsczWPyGAzxW9PdLbHz1fUfAx7b5bJjbIxa83yYPwtA6dMMhrZY7U3TY90YdRxGllPZaK0fNfDh1dUGb8aC81EFgWSacZ5QB2tRwqzlO75C+ObeoWYnZyj00lQzn9HGyDBy+t2+Oj/+3YGSVIOE4fN3+e2eD8EXvw6AlczXMYSffqHq4kJWu8Sx07ssUCMOrw==;31:8GjQM6vidtlyA0zalBmgbqOdmefyCCTJlDubxwX1+tFAxoJ/ssNhMzu4bxhE6YhMU+sEe027C81PCNN2hR05dV3Eob7Ax3yvyR25hilw4tiW0tBqKB9OuzZuwfNSQcRbezi/M8KSDg4aEvwiaE7gQHTM/Nl+tkDlQ2ZKbj+PDYJXU5WYLVRuPBdcv2SKdgpfNbngDJaKQHwUdkbotrlVvCdImJowwAHCXolJKW860wo=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3206:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3206;20:ukX149cfLJQ4lwFDOh5CZ89UvVf3U1MCmLu7Di5aMWm/2/Zq+rWyyldx5NfD4FYr4NYTwjI0ZmHqhUdy+nRC0vFOaoDD/t+OzxtrNSU/lIgFDLM30xwhyd97uHk3fTudGMgPeE6NjmLEvpxHIEBPl+SjW5lY2Gdh4DuoVjv5fiiSAxYqqQl8je9D737VU+Zxr/JA9g21Yp18U/e9ya6vHaRM4S2lcr9109KgYaE6nYF/tj9TMSCQeWsrlSaZF3mY7oMOX82Hsi3AUBiG81gUrYidf4XyupGpanIEykd8cLDF7QFDC61rtsRa/j4YSlU6oaMd/LEuVFeFxWGu4C9lt0x5OvkpyLXEf7edarw8Z7lE2pDIuqjHqV+UeANrbE8sS3kGVQ8not6sViZIesauO1ehLJOFro+RA9YC68vAw6nR0LRAjBAYR7WHARdIq6EjphTnxWAMGZjV/j098j7kojQtT7emwyWj8zvkliZDYi/9W1zkiTKKXDcBk3oC/nDN;4:EreH/djs82tHidYijwgIIqi0jjvUHo2agZN8JNUwKx8prrPcNhFcOItAsNgdkO4m758a4akprOzZkZjEZIumB3nOoYvYuXeFaLFYySqRE+P9MbEQf1zmWTjfaVcm4hPg4UB++MBwpnICpu8F83Q0VeNwQI2A9EOqqwUW5sSz9RLcALPxEEU1GVaR5Q58Qjb7VKeney+PF8P6aSjIRE2Qu7ZBUKjiaCLtyq52E+7SikXuHFf9IPA4I6qEQZSwn6xvj53B+JoTPC7PP2QSH2KSYQ==
X-Microsoft-Antispam-PRVS: <DB6PR04MB320675C77C292D63E5FF5F82E0D00@DB6PR04MB3206.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB6PR04MB3206;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3206;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39380400002)(346002)(366004)(39860400002)(189003)(199004)(7736002)(105586002)(81156014)(6486002)(50466002)(68736007)(3846002)(47776003)(66066001)(50226002)(6512007)(305945005)(6116002)(36756003)(48376002)(8676002)(53936002)(8936002)(5660300001)(478600001)(186003)(97736004)(16526019)(316002)(86362001)(25786009)(106356001)(39060400002)(81166006)(6666003)(26005)(6636002)(4326008)(52116002)(386003)(51416003)(6506007)(2906002)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3206;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3206;23:NevPbtG1xGwONYnZEy4UBhKST3UA///euOXRhFzKj?=
 =?us-ascii?Q?4y1mtT6hLsPyCo3X8Ij9/HQq3+geRalpgKFYHaZRQMnxEBOMgRplNGs7L6ue?=
 =?us-ascii?Q?AtJvNdU+87KdxbwciYjqNFZ8JGIRB8wAhFDiZNxdD2U+pTdpXdai+N/pLtGX?=
 =?us-ascii?Q?wVXJ5orvTnniBVVR2WkBG9bt8Eba7l+9znxGMZTovkAAh3u/DaUo/evLnUgE?=
 =?us-ascii?Q?NrlHf38Ya/Lk98mVKBiPiMxWa5W5fwMcG7hcsAdu13dbWEHn4yAM1C4f2c+y?=
 =?us-ascii?Q?+g4RNGMoND6U8y1MGHIdsavR48FULlfTR37OZQkU3Pm0KCyVr7706QDpvAZi?=
 =?us-ascii?Q?jSpaAmfDuzuBnmheiz8UeDDZnviOQBQmU4agl+rT/nag9THTcH9nc7kgXqkv?=
 =?us-ascii?Q?g5sr6kPqYihiplbHK4RSz1GITi5bXUC4jIpbikBdBl38AahV2TjBk4BJ8JjQ?=
 =?us-ascii?Q?Q9+t8sPa/2dBimaAiHZiy8BVym3Pd0ReGYfB9KMb00p+gjBn+sFDDcbNw1DD?=
 =?us-ascii?Q?YbA1v4zTvpy23SIhidA38Guv+0TUcC9VG+5vtDx2QrqtK+t4nMdzFPCuf3FV?=
 =?us-ascii?Q?a+MmfJ8pLgH/9hkvcZetf3iZ29q8lkLncw8NXGDE0K7PXiTEZqTLMTX059jK?=
 =?us-ascii?Q?h3nknimh7v/6DR4dAMa4wGhecqLw8vQOwUJ0BzsyEKHTLiBCNwKn5mGVRgkF?=
 =?us-ascii?Q?VgsbbNulro4VJNVXgjxa2okfGovvVmLeP1LK01y5AZ2svhe4PQr+KeVq0pdg?=
 =?us-ascii?Q?vd8szAWjSaNCP2MqjRJbrR9HQbku8ys3ucFeISsVvRfQryV/tFWV9rYsz4Wq?=
 =?us-ascii?Q?c03lYnVaOK55C7zIpxWKkK69rpA/x3yA6x+L8hdo0FGkV2Vcm2UrC9f0Ss06?=
 =?us-ascii?Q?o8+5JDw5dD8Eh+L9qkRpYw2eRxj7iF4Ht2VcWmXVlDmwWeIvaUURqJryB9tD?=
 =?us-ascii?Q?TYA6ozl5JNlZDa4GrvSSr4mrM2qJi0ggr1pr8QeN2ysOHYV2aZ7teDJnng7/?=
 =?us-ascii?Q?DMvJYGbXR9w2cAfgCruYMwgwXnLG00LJZywtO1Qa+t2i706Q4QucLjGazV8Y?=
 =?us-ascii?Q?GNOAx9X41+bx9NDYaBd6uoFaD0H?=
X-Microsoft-Antispam-Message-Info: YQDDQc5izq/aD3xEiTy3y+hKHNTzNq0MmVcXdEkonvw09gr40C42TP6Abw2YofBtdMbBdA9MXu4VoT6VPixhTnXrTM81j1Etv8wHjy+PdD5NEOzh7T0QLzPs7m0hnfiCBdKIan/CWJHb6hR+Tsvz4vOm2sTVNEPHJCicvfyZfAWmPzRKNpR/5T8/+IlwrTIT
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3206;6:NxK+9KvsNNxpkItKtkYy4lMMp/+76xOBiFdbS4foq7/q7e/AhLwgYbmpJ8GoKwcl5M1+kS5IUImKAhTH3dtVIFKBMWmGm/H2JQiMztBRyK5HP0YZ7sciIOsCUT8X2YLIzP8YXiCpdsTCsi2jzLjc7EGmyT9MdALM7YB8n5nFcmHPUrxyoi82IGzwrroyirRevYjBrG2IzipvKSGYPPzpWLJdXIL7Ghd2q+VVnp6GDvhD71oAfYlI70ykoPc5HDAKUZmOTBdJ4cNAn/0wwX19XfGJwUcslm6ePcWdNUZ83jTMTbn/UJVk3H7OSzZ7zlWFEe+quN6wQSofubhetRHWoUGNjcVBrDScht9cXP+dgfQ=;5:4EB5RCNuz1jbfPpo7VhUfpQwQtv3CtLj2KR/JgvA1t6asGPOc6pqjhMjxfuKnnajJrKEkQhwQA9ux/tjHDQ+eqn/j/cmxxWOKRJZJC/OMwCOsobATr3NAg0ElTmeevmBGpIry5Um0IRyHWcMj/Wg6C2yav5GYno+MLcRjhb4deo=;24:eWklWo715uQg2V1Vt0wOq8iJGJSui1nfagosKdq6kjuNPgbinFZMifVgIJjd8isxd8A5hfNmN+6kpB0rSpEy4pKnn4pXPZDzO6fPPwWJGYQ=;7:/mcdjkqNy0bRveSjOz3eMl66X3FrLXi32MzD3STSuKyrufFOfUgv9qVBFbF2/DLg4sCEyfG4ayDU86Et46HOFOK9ndSukJaINhNu0YWzdDVApuOo+s27m/vqv20W5ZhPkkRusht23SjajIxhXhXGs2aFn4LQJufBY+KQYkWqLOmgUhZ0LhwDeYGqjrqzhLa7JDcJcgwS3BdyfxWphsq3WXcNaoer/9NKLR+QJJPf2QVQAmFbkYrR9fAMhMbunRm+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 17:06:03.0246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d2c3d6-fe2c-4443-d0a9-08d58a9709e0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3206
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595024152098474506?=
X-GMAIL-MSGID: =?utf-8?q?1595024152098474506?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch set adds restool support in fsl-mc bus along
with a rescan attribute to the root DPRC container.

Changes in v2:
 - changed mc_command in fsl_mc_command structure
 - updated fsl_mc_command to use the proper types and moved it in uapi
 - added proper sysfs documentation

Ioana Ciornei (6):
  bus: fsl-mc: change mc_command in fsl_mc_command
  bus: fsl-mc: move fsl_mc_command struct in a uapi header
  bus: fsl-mc: add fsl_mc_allocator cleanup function
  bus: fsl-mc: add restool userspace support
  bus: fsl-mc: add root dprc rescan attribute
  bus: fsl-mc: add bus rescan attribute

 Documentation/ABI/stable/sysfs-bus-fsl-mc   |  13 ++
 Documentation/ioctl/ioctl-number.txt        |   1 +
 Documentation/networking/dpaa2/overview.rst |   4 +
 MAINTAINERS                                 |   2 +
 drivers/bus/fsl-mc/Kconfig                  |   7 +
 drivers/bus/fsl-mc/Makefile                 |   3 +
 drivers/bus/fsl-mc/dpbp.c                   |  12 +-
 drivers/bus/fsl-mc/dpcon.c                  |  14 +-
 drivers/bus/fsl-mc/dpmcp.c                  |   6 +-
 drivers/bus/fsl-mc/dprc-driver.c            |   4 +-
 drivers/bus/fsl-mc/dprc.c                   |  28 ++--
 drivers/bus/fsl-mc/fsl-mc-allocator.c       |   5 +
 drivers/bus/fsl-mc/fsl-mc-bus.c             |  97 +++++++++++-
 drivers/bus/fsl-mc/fsl-mc-private.h         |  53 +++++++
 drivers/bus/fsl-mc/fsl-mc-restool.c         | 219 ++++++++++++++++++++++++++++
 drivers/bus/fsl-mc/mc-sys.c                 |  20 +--
 drivers/staging/fsl-dpaa2/ethernet/dpni.c   |  84 +++++------
 drivers/staging/fsl-dpaa2/ethsw/dpsw.c      |  64 ++++----
 drivers/staging/fsl-mc/bus/dpio/dpio.c      |  12 +-
 include/linux/fsl/mc.h                      |  16 +-
 include/uapi/linux/fsl_mc.h                 |  31 ++++
 21 files changed, 561 insertions(+), 134 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-bus-fsl-mc
 create mode 100644 drivers/bus/fsl-mc/fsl-mc-restool.c
 create mode 100644 include/uapi/linux/fsl_mc.h

-- 
1.9.1
