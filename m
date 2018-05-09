Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934451AbeEIIyh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 04:54:37 -0400
Received: from mail-eopbgr40059.outbound.protection.outlook.com ([40.107.4.59]:4176
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934082AbeEIIyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 04:54:33 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=petrm@mellanox.com;
From: Petr Machata <petrm@mellanox.com>
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@savoirfairelinux.com>, <jiri@mellanox.com>,
        <idosch@mellanox.com>, <ivecera@redhat.com>, <davem@davemloft.net>,
        <stephen@networkplumber.org>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
        <nikolay@cumulusnetworks.com>, <bridge@lists.linux-foundation.org>
Subject: Re: [PATCH net-next] net: dsa: fix added_by_user switchdev notification
In-Reply-To: <20180509030312.29548-1-vivien.didelot@savoirfairelinux.com>
        (Vivien Didelot's message of "Tue, 8 May 2018 23:03:12 -0400")
References: <20180509030312.29548-1-vivien.didelot@savoirfairelinux.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Date: Wed, 09 May 2018 11:54:06 +0300
Message-ID: <wihmux96wgh.fsf@dev-r-vrt-156.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1PR09CA0054.eurprd09.prod.outlook.com
 (2603:10a6:802:28::22) To DB7PR05MB4188.eurprd05.prod.outlook.com
 (2603:10a6:5:18::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB7PR05MB4188;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4188;3:+mxPus2+kwBdRsvfWEpJG4E/vYvW24J0SBcrkXQD2xdRIdLW4T4LTKq7UCEc0HL+X7SVnONv185nC2pArV5791p7vIJoDVxcuGhuApmfspOKe2T8ugL8NRayRHZ9bXEm3WMzpwzQUDZKU9UOAmAFLhJ7pTtTCSTpxG+lks/u94opgVKIljSfcbA8GKzaXDS9Iy4HgE+7Lzm3/gv6UFeMQ4uJFNaamaMMq9ZhUlrFcQw/dbiTtnSFXydGPZnpL8wu;25:z6CtZ0HlhoAvUEP9byp7C3eiK7GiPgMhq/rgPb45VlQ7DbEWFg+s9vi/lpVDXKsHTnMc41LbBubyRv1vBLYV/XBaYtnoB+jER3LeZlXJKApE68ImlzEvuV5YfmVUYH/BerTP1V1s072rg9db9ISK3NXXFNsM+lJUPGQhUV3ANvV9GjLs6o19TsDwuzdI3/GnVlPewO3FIua/tqHQrxPo4txMPNSb6S0VPoW7C95Bccg/hC0sgzxitBS60q8Dy6LHmxoCKF+XrqvO9PGZanm6n3Z5AYStuRMJ7w8t1jpRoHl6R/tx3dr7MYJS+59kkg6R1DCa2MoUlZgBNYtwZ/SUjw==;31:v5EFLUprjUYB3LjbcsrI/FmBSqj7xzlesILQNWcB+JKC6vnw8kAOU63PWB4sCygRtbxCy1wMZAdi4i8FW26IiH0AzRmbxVLiVyUJ5F3LYKD9eLYRanOI14lWCUEZEBfgKNgWJalOIzzTU4CGuc9UbSB0yQQTuhNRhJl18LxjuSag7J/w1W4lorZe+DhDuG0v5mMzS4mwE/jsFMHCyvdE096h6Ueykx6suE6RqlEacQA=
X-MS-TrafficTypeDiagnostic: DB7PR05MB4188:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4188;20:oglWx8/Gq712eCAW+T+hh9/f1tuqegchNAXcFXEBYdEY4uch8YmXIDEsv5E0WzfrWSv68OPXYOsjvMLKay7wJiS0+mIvihw/ZPfLFHIEVm7awF3GD4XkMo0zY6kKkzHv+tfFwlVLuvjvqnY/h/6xbX8hqucX+zgLMFrz5wANsxzpHB6H3N1on76wmf8LYNdV/yKBdMhWjFwe8YCFkG9tJ6VVL0cEWEHsLIH6Q/X4Mxvva5QgorMCzDxjejp26N9+q8az37rmS2HSDrtJMfAWuJpKgUKQz0WFdIT79hI6FBtFz9moJbCgy/LyfG7mCZm7Z9ymOx0CP5cDG5Rqv1wfKYYMXvAfmO1fsMlHxajhXq2oRdkHAX/RMsJBz3ZNVAPsRGwT9CwdSqBZh0aEgzsXyzksoBbAY9s68zbZzgCuTwdf3QCPRwLEW0bANCm0Del9qshPVc4S7AbL3yBf3EA7c/NK4xDRU6AX3L4vIEDGmrFC1ozTBZBGz5DCsbSNWooE;4:POJiOeFQUiP5tL/MkCsGs78FZ1VAYf2ddbfd/AsbIi5ULs+CS9rEEPDFrdJ8weVMDsgi4+AmQTKK4FOtl9Wmp95v7zsPKGf7ALtUxqZs7mF8QSJcwQrU6tuQZPFBOV2KoJbGWT4Gu3owyLbqNuiDW79okWnZTzZQ5l/HyDry2RTHVUxnXw0Tj0T4D16FtB1i/pWL2wmC2ilANCskUC5Q1MkX9JmiWJDpn4TxumG/CjD7EHCbAGHKv5b24RBb7RDT/7NQOHGXLHMqROLBR4hZWg==
X-Microsoft-Antispam-PRVS: <DB7PR05MB418863F72185936EE605FF59DB990@DB7PR05MB4188.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DB7PR05MB4188;BCL:0;PCL:0;RULEID:;SRVR:DB7PR05MB4188;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(366004)(39380400002)(189003)(199004)(6246003)(25786009)(26005)(6116002)(76176011)(386003)(97736004)(58126008)(229853002)(51416003)(52116002)(6506007)(478600001)(7696005)(4326008)(558084003)(956004)(11346002)(54906003)(39060400002)(446003)(316002)(50466002)(6666003)(486006)(16586007)(48376002)(6916009)(476003)(8676002)(86362001)(105586002)(47776003)(2906002)(53936002)(106356001)(9686003)(3846002)(66066001)(81156014)(81166006)(186003)(305945005)(5660300001)(8936002)(7736002)(16526019)(68736007)(55016002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR05MB4188;H:dev-r-vrt-156.mtr.labs.mlnx;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR05MB4188;23:i7pFTRbuGL6D17GGIOdNXBWL5DbkvHyUIEs3faNSh?=
 =?us-ascii?Q?nb1snEE3JIavHb8NIzV5+NUo8OK3m3Z/BpswxVndSHq4+zDcS0QXobScaO/h?=
 =?us-ascii?Q?d4NghE07lplYDASAP9Zhq2pykjRJ00nF7GgcjxMESXP/wcw5Gm/wuE/YlWLY?=
 =?us-ascii?Q?z7U3t/lO26ncUmJ/kCdOiWUYjCD+PttimWKzxRRvRQNfaYjvFwrmSh3tMKin?=
 =?us-ascii?Q?K70wVzP7m1v6J9tJl+SsWV4XNpfdg40RYhmhkOnnl/nZf3xMLqhRc1PGYtAA?=
 =?us-ascii?Q?QuEMTcqbYjvxxTc13LdvONg0b3zcfWRFaZWMN4srDFCtBlN+w4U/xixpUpB1?=
 =?us-ascii?Q?odvQQbkhyJEEd0b1KkLR1308RoKKQiX8n/bdEHgQofLXlKmTRIrJP4OWiUtj?=
 =?us-ascii?Q?Cs1NDGfVy85Ssgr11SLkl1NfOkz+wCbtdbsJaOhoHv5qX4za5M81J3WQk+Q7?=
 =?us-ascii?Q?gm4tbRsWIKp96GXazc1NoaQn8jenbQA0remu0RY9/OPEb3N5pQD7QWEg375p?=
 =?us-ascii?Q?i3nqtZBY1xyUhlixHPgHlhoNaRCw/6NVbFGJ0R13CvPZUFprCDT9pbR8hJ0M?=
 =?us-ascii?Q?MXqv4m4N1OVmFG2UTjfQm/l9xPDb2zTbWMomgRnVYjMZWNjN/KFmda6u5W6v?=
 =?us-ascii?Q?zXflr26ow3IfbJmpiWfMS9QscnbClAeVU8BkbUopbGh7b0sMl6OhfgvLqcjN?=
 =?us-ascii?Q?A2IgEx8Okq6hZ2HBi37AxsoW0BbdXyri7XWRS8SslreV3AjkC7l3IwDUQGVC?=
 =?us-ascii?Q?LyXk2Cn57RslgK+3hFCDdJ7ZCDzvF+qKNHlcy6IH+2YtSyn66Qrs5xso+9FN?=
 =?us-ascii?Q?j5/1ZcR2QpdDzLP8l7dsGUbJ2YAzGdA5Pc+dXQGdmuWibwrHk/opxzY+zVzZ?=
 =?us-ascii?Q?Z/pFcnBaYd9chMBbYTjrS33B+9HsBbUq4C8hrtdTV+kP6dOBmiNTg/gxPf7n?=
 =?us-ascii?Q?4j98CxM/yHetMOZLF74WagNgKN4XzXTN6l45pK4AnPfKloP9pyIeFobjUVKK?=
 =?us-ascii?Q?tGoK4Vej/bjdD4l4S0+5H3lyYZa8XZs0+LJbEfi83AjFv+zq/4GmkTdRZtH4?=
 =?us-ascii?Q?B9YoVEQ2p05u5d0IjRv8ogkuD0v7YirALTIZgSIEZIbkwwf2wOOjWX4BtYPQ?=
 =?us-ascii?Q?c73W8a5UMTB84rtIT8QXesgd7ick3DPvu+ZX417TFO/9BLgbQUrcXvXln8IY?=
 =?us-ascii?Q?i0TROwCrvqzcov5Bbhr1cgyTFK/zIyfXkWtNallPvZ2Kma8+yNF7K4fqUGsn?=
 =?us-ascii?Q?Z6odYHteCtj9Dj1r5JSOuVf6b6BMHodVFktbwYObQLdNbovEwbjP7u6yxs3v?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: HBP1HzKUhcfIw3iJskKgxM3KKtREDGqHX3RpcRzwM16cSeJy6ROA6ymWJPrXconWEx7Ks02TWlUrNxK/NuamV8CcseNTEItHQJ6z7umwC6hM9Nd8tEB1+j7zcY+GyIGf+CXNX+fR7sMbZkAHQiehkP+aEABSPrmQvpacXZptrh5aGu7lMPvySq13McveZpbp
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4188;6:8C6QsIb9u559KXLw88coEHwGwaQMAdoRvPBERsqYWx3qY4UJzHEF+TizFrVY8bxvCTsya9h9Nj8AUsoVNxz8fg0s6aTSEmY+bGRqR3IBrNVFSxzYh8zJWvHsAb+SQplhpxHf3LQX2JwGVey3NmlykgIJkExCTcH1eI+YVq+41OoIU1nSVssaeNVG/dX2/Ck4k1Epv1TCOenqqxLgDaPJ4XuJwNDuYp3u8E959b2pn5cYdOUatIOtJGZSUrUQSi9bfzKk/syno3W14hSW5pss1XjgHW3PG/Rz3OQOqlbGazYmDMQAcO81sbRHeXJ61yOEvSLIYSiqFa5tr0P0ltK2iCaV3C8TKeelyhCJ6hr/cRmXK9uPT4Ry4+VPB6i3ffR77krZ+0dhXPqUkhVgKOOME949m8Lk1BXTLquJ8LJpUHHBT2tOjkQW5ylsV+5TwR6A/7Iw5bR0mHhJoVEbyEIzzw==;5:2eoT7d0PGayXyWX5sZRJbkbeS13fc433IEXj0R3+vb/XyBnQfjvtNkk8PE9kqyF+WvMBYTtJUeaL86Dc1bP/1cFmmoB0EQNsqQViQH0zhTCAQwDmUczJVS1akP23VYmcKKv2QdTUm5u2jAPeVFARzeRSfJPkQjHNnt1ey40aaDM=;24:Xd1rLmsaljD1yMR5HPpTtxdQQuDckjdJETXN8NKXAVoDgsF0cOZXQgUmUNXNusVDfZqtun9zPMz5LVYD5wC89kB0k2TB20dvOrvZH1VAM0w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR05MB4188;7:rj5gZWBv4G8LvdaDi/lGb/MDnKpF9MYLJQPIQiudMHgMfd6RvcXlB2In6N8E/JFacuqmmZ4L7G2ZHszkNimcFqGJMXiheJEAXhslG77wzs+GwwGSi3mwQptyOnRq4fJSQClX83cMJ66xtxGIrZprKZTuRrRbjgImF0l6Pql8eHj7jsVdI4hWynF7ZT2nhL711kdZoHNXZ66FR+XazSpHKZ+UmTrTjw8VQfbkjzMLWszO/0F8HjxG+pEmD8vdgL7+
X-MS-Office365-Filtering-Correlation-Id: f25744ab-ef68-4c23-8693-08d5b58a7972
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 08:54:26.7331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f25744ab-ef68-4c23-8693-08d5b58a7972
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR05MB4188
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vivien Didelot <vivien.didelot@savoirfairelinux.com> writes:

> @petr I expect the same issue with Rocker, but I haven't tested it.

Yeah, pretty sure. Such an obvious bug, sorry about that :-/
I'll send a rocker patch later today.

Thanks,
Petr
