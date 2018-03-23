Return-Path: <ioana.ciornei@nxp.com>
X-Google-Smtp-Source: AG47ELuBF5gPxmPigmoMv5iZE8DmVry372NHHcdlxbO6zGmU8OtCehb0rmMgOgEjXFwEJia3PqFS
ARC-Seal: i=1; a=rsa-sha256; t=1521819583; cv=none;
        d=google.com; s=arc-20160816;
        b=t5hnhPVv9osRgie+4vv2d0T0ojP+MQ7+G8eUGCGO2EF+QKVDeW4EiQYuALLoZuNrNw
         +TjnhoiqQ6cVZqYNm5WZEKCYZKkIMr7AptEi8/kN5vZHGPRqB/bPEjXodjKCtGVywp20
         09XH0FfDFJAhysHnRNUL7PGqx9TAkl+Cby+NN9o0FCwi7ObPekFW/aNHPCr+BpFOxpu3
         CbYZmxyBhFBAZ1QTAYrp71eAdtsbhT0EnZKe+uzKPCGDZGllRkyjGjwiK7NpvnjJQ/jD
         1TjipINd2zaggQeemQwjEwVAQUazGO3aAwPFiaYrzDV9nfTx/e+tqe9MruEw8PhAZyD6
         zMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=PhoAZMDioLmT2KmhTk5+K2cb6RIn7j9mjrrj1JXt7Vc=;
        b=Hr5ATfrglgNOmMve7Ld+92I/825nKQb+RI4bHkVVHdYlm202wBQomai+d1Pj6iR2RG
         7Kqh1c9eklP7K9STeue55ytiE2DbWf4SKf+/6FXlxf1iusDN28UOh3aL2YhGHMwuOao+
         iwxBfhdoliOxZYDXqtOPOgKxxeY/kdu4t2eFeaxhvP6JVanIfJXz42ZHKRTIT/hDM4L+
         3hw5aHiryiT5EOdK9YQ8E0jqvXa4f2UubjliZc5xeGOamxL+T0BE2MxSFqKOxcqmbm0F
         GQt0z0ACuGCZbTTCJ+q3n69TnkzdVdIBhTjfeZZ5uGZQ70Ljfa1BqRnwyJ/XNxJM96ua
         todQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=t2iM06Qo;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.1.46 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=t2iM06Qo;
       spf=pass (google.com: domain of ioana.ciornei@nxp.com designates 104.47.1.46 as permitted sender) smtp.mailfrom=ioana.ciornei@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com;
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: gregkh@linuxfoundation.org,
	laurentiu.tudor@nxp.com
Cc: linux-kernel@vger.kernel.org,
	stuyoder@gmail.com,
	ruxandra.radulescu@nxp.com,
	arnd@arndb.de,
	razvan.stefanescu@nxp.com,
	Roy.Pledge@nxp.com,
	Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v3 0/4] bus: fsl-mc: enhance Management Complex userspace support
Date: Fri, 23 Mar 2018 10:38:54 -0500
Message-Id: <cover.1521818402.git.ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: MWHPR15CA0037.namprd15.prod.outlook.com
 (2603:10b6:300:ad::23) To VI1PR04MB3216.eurprd04.prod.outlook.com
 (2603:10a6:802:6::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 47282237-2623-451f-6704-08d590d44a4b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3216;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3216;3:nk28ik7k6o908M6ks6Nf+uZaINM2rFOA/Bi1iJZ2jL1VeEI6uTdgh5+yjLl/Sn+6GWXZlhibYTxohH4fDHyD/LVB64JH12rn3Od3T2NdRGtc3V6P8dLNaGih8zOQWL3c5ricr3jVJjxXxjFuvslhnsiMV5mCGs5lcdpdGwldSm4HYF7DD6X3yshDFIFqCb6N31fXIkMGtdzcrkqqHgliD5f2hK4EmW4FTsVq2OvZmxFrOAupZ/AWjMJCBqzo8nKT;25:PX4gDeJM3d2XANxokWS2DZfX4SwTK3kL6pxXp8AKAQoMgj8loY4iRsKgc3uZ0jjYb81ebaxuXwDRbFSUX2DFoN9WPVJJokHANiov5q8ID3vqTMgFWB5YV+Ua4+7pBp90YEnjrg6UWTCY+tfah0XmMFsGFofx3gYAYWCzfnOd5oFK1e2XkUmprbOY7dJrWTJKbMWPHM40szwE2K3Cmur8iKCXueEx/p2ot8dRnIHLhZugzwu0rnECKvxscDyGGluXT+zDnLYAGIPZ4q6UWlmKwPSzEAfIhoQ5BCoB4rGXp8Y1nCQMDADQ0hxefykxrLXGwB3FVylQiCYJLj3Rh6G/dw==;31:xNCU6VK50cxbkrhJkCA9MdFlnEMg9liQrj5/x7bhl/9YG8SHBJ81l+ZAPq3/6mzTY13RaEP6ZSfUMpPjA7zNDMu9GI2glbaqJG2kDI30mhSdaS69WZNx+J2G0ODLFYkcW7tsqGa6qz6wQFuRefdcl4xah9HyyTHZvA6n8CfqPy/kkZ9MUsFoDZZ1htL3ZdFG/ux7MMvYhW6LxVCXgMK5RvodUiiKS979Tpwi87uOfhk=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3216:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3216;20:jnrBJeZVIG/hfb8ehqr7rOagpx5EJZAvyfv2/GbUEgnBEK8hIvU4iCOyZbj1qzb0nDcLx3CQvTDGUwEwoODQ207VGkUxaEkF38e4uik+so4T+PGRjH7dMY39fPuuty4fj+lk4B3I1BoeTbYPrv+rZ+PXdFgbVPweAbITkX6KNpeC5skuaCN0LR3uHv57w6GEHKmvHZ7IlzwewUejOIAe9Wltw+EetaUOs33ju/oJzKONeNJq9yjR4p25Afx9+yg0gYYK3vTiJCTvlcSZu67v6GycNvVUqveJDyBJOrzODYjNk5v2D35kGLQMnmEP5lZPszzjs5UWHlR3wdKSGdJj4LwtCxQufWivJ/8uDI6sSv5mXx3tEwlGRm20AQaYE42Ie137wLfu9iYQZAQ/eoDSmGNiT1F9LdcUQzrPhulMq6y5xnd9M5Vh6KkZt1RSt5N1R2fSvorqpAwNnWey8BcE9h7LIQdqIFH0Of/aaWYv5jeAka/YLNZQ2eZr9xSODVLC;4:gvOzbIfO7zu3F+hZKhQBjdJGKHRUqE0vTWXmujmGo/VHCwb2kw375dettfI9HYCQZ4UEH8GVaX98rcup0Qrw25Sz3pLgZEP/Aq3sW3b2QrgEqzm9nGvbyCzuwJyR4bdbWT/jxkht0AjkYp/o0GeTq+k5OF9cageX8yK5WC8W3Ia7rZCJLYi3jMNzs+hc+xTkbtw/CrBFYB8Jwu/Lr6ktie4Q3oXmx7x0OnGJzKcWKAuG8u+okwxOLECd0DCZdATGXIf6WTzuAZcSvlv+L/62Dg==
X-Microsoft-Antispam-PRVS: <VI1PR04MB32161683D3ABF7692C56B072E0A80@VI1PR04MB3216.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR04MB3216;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3216;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(39380400002)(366004)(199004)(189003)(316002)(47776003)(66066001)(105586002)(5660300001)(16586007)(53936002)(6506007)(386003)(97736004)(86362001)(305945005)(7736002)(6512007)(6486002)(3846002)(50226002)(81166006)(6116002)(16526019)(8936002)(50466002)(81156014)(478600001)(8676002)(6666003)(6636002)(106356001)(39060400002)(48376002)(26005)(36756003)(25786009)(51416003)(68736007)(4326008)(52116002)(2906002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3216;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3216;23:LYh7X0J9prxmSb6qgzm9DV1yYkAd0HisoTJ+sgT7B?=
 =?us-ascii?Q?XxwqjhAGeragsflQ/n6qXf07nU5A8gu6uF7U4ivOss9eig7MbOXuoAlytvcy?=
 =?us-ascii?Q?Cn0V24r+P2S2591XULjRb+Fexr6igtes7tkyqdx8lv35m70eV0L4R6ehLV+y?=
 =?us-ascii?Q?liernGPYeAaYn5oT+GV9u/rfsPCNquKLl2j0/6hhzJ7ii3MVP7qqmguEOLja?=
 =?us-ascii?Q?MPX0CvvFGYaPgT/bCtpIUG+W/pBfivVRylt1kiOsmZQJ8NFC+rTUwqGSLWd8?=
 =?us-ascii?Q?R2oj0hpuF7sBcqgh2XC0IbGQzViRnoPWuxKb52a2yXHtXp8lsoejKvAyI7Kh?=
 =?us-ascii?Q?nCOlceessNRDRKpRGeoRjbZgJME/mKbRqUorIH6VoDjeaVTRI/ubFskVaRgI?=
 =?us-ascii?Q?3G8VirLYk6QYqD/dO4PF+6Cb8odineUZ4V16vDpWlopeQ3VOwTEOsIENk0RO?=
 =?us-ascii?Q?Y4JN+2Jx03VEDY7ZUJ4S1WptLK9aea4tVR7HMrRo2h00nlQHHQssAVaCi1DY?=
 =?us-ascii?Q?bpmOaJ9akFBZp+nq+VB77/b3PR1tLxgDnv3+JdhYJhdaTObsUQIdOFJq6pwl?=
 =?us-ascii?Q?dOas5ThOaYJat33pZnDAlaLpM3Wz22YPkIQGJZ3G/t3OA+0hLyTryuRN1QX9?=
 =?us-ascii?Q?Fo7yCTyocB0LN7wfCGfZ8wr/QT2QV5bpyyE66QTkzE93JYV7EShfKAInYfOJ?=
 =?us-ascii?Q?E65f6porI57Fwtoo3NlJDRBJrNvq5NTpKYq35rdQV3htHVOS0Lsbh13exhMh?=
 =?us-ascii?Q?Cfnx2LKju+1dwq+GxWNZMeORKOOYvUW2wPotpaLU3nMf1BGflU6dcMYlz1D3?=
 =?us-ascii?Q?w/65w1Si6/jWgg4qPFJTiE4PBZzC4qkX9xZZj3qNrVS0pgSVKD3bnfLw5lLV?=
 =?us-ascii?Q?ECip0V48dTSf3tZ/P5/qM1TbLHMl6lNfjCOmb9L5BKG4M0H5gNSLqBSy71AV?=
 =?us-ascii?Q?G44V8tLCysUmiIiepH2E6oMNlOGBiIcNTe2BssnVtQA1edZbR6AcEgfWjUJR?=
 =?us-ascii?Q?1HlwkHoakqbtyPYV6OClr5JX9LaQWR4gump2QUGBXxg7GoCFLfnVY3GFaQMS?=
 =?us-ascii?Q?/Xoi+6ISo+M6H8nUpIjSERJb+V2?=
X-Microsoft-Antispam-Message-Info: gaDkmsHYVQpUTX3XyOVAalA6PeJU18o0VlslmcTbLzpGAqV1U4+5D94Ez0TIAi5zLqlTax5bSSMFQjyy9vN3+LSmdq9rMqcK3+78H2duQZmXx/QA9F8ojEggv5nx7bsBLOzO86HOZbjNt2GiH2nYpYhMnL8Im5VHd/CUrF9IhKad/h0i8D4KVDpdoRsrqsSA
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3216;6:VFbKEYApqaa6eRlK1JsP1Tm95iyqGbYRzMui5lRnuwn8U7DEMwBjss7DlSOPhQL74TdjPu5UxOH+NqF1CuzfFgGzCmKJi/n24yYNPW60C+9iG+IwBbkGmssgta14u4EBmBU+pRTPbFN+lu+sApxwrclW07PM04h0R/lRPobmSSDHh+z/rrWOuB0lcAxOOiULHkIFqQnBbYO1WaFDN4ZoE0oe4iIRToEsT5YNWG7WcTqdGEhr10r1xNwFt8M4y+b/OEGyYmNQJmvcSKA1f8PncYr/eh+EcxBBUTtwhj0nkZUmuyeC2qsDWhD9cjCCF+E84ka5by5CtWJGMjWHlsKTnguvhAdhZyJwOTgY7rVB4Qg=;5:5K/0W5nQcSQoBseH3QAjjQGObTl3zbO0rYjpDcLMGOh/kEwd6ENJQrIoPeCFzuvwoQuD41rY+utrtp5jyKT1ZCF/NTawc5qi+ToOKkXiXI4ERVZ2ZkeDR2NL6SPJkKa/9bMTcwPqZwYBqmcZXLoXyaewF5Dz9LJF8U6w1oGoRPg=;24:WgQHFY0c52Znflg0Dow+BgXPNNeL8vMxt/NZZ8Zddk9aYZxIhp3Z5GcCcN3Z5IF97EFD3KLIZ6WlPJyq9mMlG0pxAK+g6vwlqwHzZ6kt9kE=;7:dB3YH9s7Qo21Ym4iOED7cv8D5vBpLWJt6X19H3W+dYK8clSu8qpCnDga4XUa22InC4pfvGr84kpbVBkV/XqjlcbWDN0vNs5VSBaCbHMiQ9pH9LQcM5wTI0SAZVBnRrAsAalEPO6PbtFmy/kRHcHRPfmTQakM5I+0WOumhdnjeXazpOneM1YXp9FLEpXVJ+SuRxajJUCEBFGenftKvubIfocsFH+9q2G8Ahuv8MRw+CVJTHKoBxDsigAeXhEslQsn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 15:39:37.1402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47282237-2623-451f-6704-08d590d44a4b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3216
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595024152098474506?=
X-GMAIL-MSGID: =?utf-8?q?1595743491544541852?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch set adds restool support in fsl-mc bus along
with a rescan attribute to the root DPRC container.

Changes in v2:
 - changed mc_command in fsl_mc_command structure
 - updated fsl_mc_command to use the proper types and moved it in uapi
 - added proper sysfs documentation

Changes in v3:
 - added the correct license for UAPI files
 - removed patches 1 and 3 since they were applied

Ioana Ciornei (4):
  bus: fsl-mc: move fsl_mc_command struct in a uapi header
  bus: fsl-mc: add restool userspace support
  bus: fsl-mc: add root dprc rescan attribute
  bus: fsl-mc: add bus rescan attribute

 Documentation/ABI/stable/sysfs-bus-fsl-mc   |  13 ++
 Documentation/ioctl/ioctl-number.txt        |   1 +
 Documentation/networking/dpaa2/overview.rst |   4 +
 MAINTAINERS                                 |   2 +
 drivers/bus/fsl-mc/Kconfig                  |   7 +
 drivers/bus/fsl-mc/Makefile                 |   3 +
 drivers/bus/fsl-mc/dprc-driver.c            |   4 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c             |  95 ++++++++++++
 drivers/bus/fsl-mc/fsl-mc-private.h         |  51 +++++++
 drivers/bus/fsl-mc/fsl-mc-restool.c         | 219 ++++++++++++++++++++++++++++
 include/linux/fsl/mc.h                      |   8 +-
 include/uapi/linux/fsl_mc.h                 |  31 ++++
 12 files changed, 429 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-bus-fsl-mc
 create mode 100644 drivers/bus/fsl-mc/fsl-mc-restool.c
 create mode 100644 include/uapi/linux/fsl_mc.h

-- 
1.9.1
