Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751962AbeB0F5c (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 00:57:32 -0500
Received: from relmlor3.renesas.com ([210.160.252.173]:58033 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750770AbeB0F53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 00:57:29 -0500
X-IronPort-AV: E=Sophos;i="5.47,398,1515423600";
   d="scan'208";a="273581851"
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=<>; 
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH 0/2] phy rcar-gen3-usb[23]: Add support for r8a77965
Date: Tue, 27 Feb 2018 14:52:25 +0900
Message-Id: <1519710747-26435-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [211.11.155.138]
X-ClientProxiedBy: OSBPR01CA0043.jpnprd01.prod.outlook.com
 (2603:1096:603:1e::31) To SG2PR06MB0981.apcprd06.prod.outlook.com
 (2a01:111:e400:5213::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6f555504-dd46-4a7d-7a7d-08d57da6f8e8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(8559017)(2017052603307)(7153060)(7193020);SRVR:SG2PR06MB0981;
X-Microsoft-Exchange-Diagnostics: 1;SG2PR06MB0981;3:t2jFJsQaty/siq3ej6MoLfMRsmkAmnGR5F3nOfejhE4k19ROeo+vfvYhBBNFvhLcLCB7LtrzGcl8TwXnasLiWFb/Jd4LjNMYIYL73lyGrGxpt3u/LQtdy8oDn2R+T3RG9uMmTEAhSVkKh8F9M3zydb+YpCFwz8o2nAny9KHLDbPdiVuDwWRafzzXmNcxwO6OonNU43wjjg94f+EpOqTvIfW6SpCY91e6lwq7TST+70zCR+FKE0HSbh7ZihpK9y2j;25:bi8d8MZsMZBC2JsqhvtEUJHy0NhwpZBZf0Y7sQre0lY/myea4lDuVwSTk9adgj35dZ9po4qdkWqDHWdDIHXHp7ilTZ0xi33QbI+mQzTG1Xemq58IpnGmik6mHej14SdowPupjybVM30wo+o7+nP8FyNWY27NKUyefx028TZzEpmuMVR3PP1XcLTDxi6rqHm+2KtFepN+J7fqmYoGzE2aExAcF4IX00Tp7hgGTa9oUYD3z8vldEDye/3DZ04OjCAAs/fjo85UL7ayRbnGnHPQsRTwB/dv/Vif6s7aXAX2SmcWuZbyHeL+OWOeMm56OCD8lvtGY7gsPD1+0Z8FgU5Vmg==;31:jNyjflPHT8pgMMZC59cuI74P/hInMzR/s4uGOTNG6bvnL5y8ZblH0zvclvQYo1mIG3ErlST4DSo+YOL1Oc5u/d0WHd3tOlOEM0ZTHeICiN1D+Y50F8HkFcDf6GcEQkFWjeGiSY2I4FlpCxWDWhaGZ+5fgFYQi4fTudrGPHY1PkJfzb3yokpYUJAeCQ2cKSKYaqgQdBKX6UV2reCiAYsxtNONsWDil1OrvhW4sGFmoQg=
X-MS-TrafficTypeDiagnostic: SG2PR06MB0981:
X-Microsoft-Exchange-Diagnostics: 1;SG2PR06MB0981;20:NmwwfI4wmhT6ZAgLf1sDtjm7VL70whrR8xM72pnf/I2603AYzPBV4thC5Qc8wr4SlkSmTvIgyXk0XU6w9NG3xbBkxt7TDrzjAsZUqC8foIl5k4O3ns9U0PIOTqFWTGR1VgPof1Xe0tWJjyO7aFUZC7LINMfewLgHEqFXw1h27IL9lxFWWZFkXvywhsH3sewx3V/7cAjYX+OQEkSkD0fVnkidRm50pO1eBSNmtWrwmJRmN0LBnL8UNH6TPglXKEJIf+VG4k4BbHbKp5LvjjdXMnaCa86Wjf7CRN5pxCC8IIWqsNQcv9MGb3UxJ9sd/8ZYYyNIC/AaxM868QmiwYdZd0e13pn0+cBlp9Dk1A7vW+d6HQN2S6XwZxdb/0AJw7B/TSnXCQ9Q0QlnL/HThGRYAPls937lMc1ytB1Pyh/H0ZySjyIGsjnifwtpS6iaA1NOx+dVGs+oNJvAT3dCSr4oZ6OdRh1X+QDOQoULRmKs444pj7eb1d164D+12dgAEmuM;4:XTjQrmOVVVhI00S9sTwybzZUoXIKwyh3sxmgHIJmkHljCNNQ9pA678VhGdr4dKNxpZUtSRdyI6Bxbex9K0spTLookxjJXeM0+jdUVWipaNbICbjrxkGNPZLgpoQzU4ZUx1LhNHtjQWgaP5/Yb7XExhaEY1y4e5eL28Q4MyB2lr+ee6UOSGWXe41ytwRgmiVa3z/F+yo7oQbY/kSrX+so/4VG8SeNywszLiytjq4jWdvca9xBAPEuZipgr70W66UZxUDNIBptXGsvZdbp+E3Gaw==
X-Microsoft-Antispam-PRVS: <SG2PR06MB09815EA0ABE40F2CF115B26EB8C00@SG2PR06MB0981.apcprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(3231220)(944501198)(52105095)(93006095)(10201501046)(6055026)(6041288)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(6072148)(201708071742011);SRVR:SG2PR06MB0981;BCL:0;PCL:0;RULEID:;SRVR:SG2PR06MB0981;
X-Forefront-PRVS: 05961EBAFC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(346002)(376002)(39380400002)(39860400002)(396003)(199004)(189003)(106356001)(8676002)(386003)(6506007)(3846002)(26005)(42882006)(16586007)(316002)(66066001)(6486002)(52116002)(68736007)(47776003)(53936002)(6512007)(50466002)(51416003)(48376002)(498600001)(8936002)(97736004)(36756003)(7736002)(107886003)(25786009)(50226002)(78352004)(305945005)(105586002)(4326008)(2906002)(6116002)(81156014)(81166006)(16526019)(5660300001)(3720700003);DIR:OUT;SFP:1102;SCL:1;SRVR:SG2PR06MB0981;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:0;MX:0;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SG2PR06MB0981;23:q8t/sC9G98qtbPtjneI1ZBqUd9fDxh14Blb51g5p2?=
 =?us-ascii?Q?Q/HDWiisbrNfrvldFLsOUmE6UXYjjCa/1zyzB8v5xfqdnoLJGX9Iqh2KuqQ/?=
 =?us-ascii?Q?7TQ3ZH+ETr4fHBygL9L2UU+K5RLlz2wO1Pd9SRPciYoHTnxiSB04hVLClBn5?=
 =?us-ascii?Q?YS5us0UQ28VubOVkeeK24M8Y4ruJfcH1pCycCSnkXjQS5RpvUZtER1fH5uwM?=
 =?us-ascii?Q?sIrJnTeCZNGjNJDoXcXo1gs3Z/kqQGoWd6lF8uCPrcgeM8XAhTe/lVNCFfGh?=
 =?us-ascii?Q?ivh7pyydIIkbj/OBuOX4XF+PP0yMHvneNohrumcMKjBsyNCBOdd3Xwb4i1j0?=
 =?us-ascii?Q?0QyGbDD+La4JmAKSLe9R5AAQkS9GvkLJcWgqWQrFPBiv1D2n7fUUVQv+2oyl?=
 =?us-ascii?Q?JMc5UUeShnJVPE/gW6AT3KmdILSh7AFIklZdZn5l3nCO4r76mk923LhKhr3w?=
 =?us-ascii?Q?afx/ukBRCMeu4zTcemCOrpiJTYGRul4in0IRQdCAw7YY6AFSgmxzx7voAVsO?=
 =?us-ascii?Q?DhayfPpr7Og6EWfNvUtgB8Elxu4sC84XPCFL14jKr7urO4TEyydQ4Sk+XC/M?=
 =?us-ascii?Q?tn+W+XwaDDFnVAaoXs+bOyZYTGn6UkFJbq1unDkLaFFvTZGc4fPXkdAu2YBa?=
 =?us-ascii?Q?Px2hFNVrpCPMflDMXovHbxP2TimYXWdL5xUh1HRsVxjxlT0bK6Uc4JyEQ86X?=
 =?us-ascii?Q?tsGQ/Y1gH577GPaHD6yOs3UqdNAtheGUlE0pzNu/UEg7PPN+wZGJKllO07jS?=
 =?us-ascii?Q?s0r5zeHgd2fTT7nh1a96d+XOEAb3oQw9WpAEpMxmOvNLwMWe7wOFksiqOFq8?=
 =?us-ascii?Q?dFvWnUa2p/w9poJgTSZMsCXXbmfnSEk+3JwL2WYuTBqhIYAWZaIJ8/WBerGH?=
 =?us-ascii?Q?jc2+1+J+OM33bBU1oHOjfS7Ms1ifn3Lq9xKt0o30PLlam7shcyUBFG6C0GXF?=
 =?us-ascii?Q?8B5aoOfNoTgph/rmPBYjHo4eeilj8tGLYucfqRRy2fHhNQ37041isePCxDJr?=
 =?us-ascii?Q?iw+5TNrOakxgEh/UVDlKbGltb8DaIYmrcqo7S9TEZG460bPLM0mIHrxhMst6?=
 =?us-ascii?Q?lJRL/Nd6lZIN72KudEkYuRLX7OV?=
X-Microsoft-Exchange-Diagnostics: 1;SG2PR06MB0981;6:JRYDyAF0kF6xk3NAEpDhXlOdqGLgFzWR7HJ876Z0EcuDxYU3aPP727LhBzzoQzqiO80/Tz2bBcaDwhExtzwTnrEuWDFjatEa1Af3paJUxISTLK64Vs/u98NSmfTEkEX8abPBrE2Wvo0X7CZZ2XS83J62KPZxkAuQoZE02hoKDPNH1+GfCw6lr6ugQDsXQjKz/ug1qZca93MsN0B3Te3OUaYY8LuGRFUo7U0H8HEw+kGQ1enFXrlsJeWwhrCSk+YcRi0LrOKTZ2SekU/B1dvWt3bjJnvD2Dv36LbHx4QD0lNZ/EaOgv5C8fHmQSyhL1vJfhADpgtGcfDGCMqlSD5FsklgSWXOr2C6raFmVngYoOQ=;5:hT16KewVLEATenKuhm81VgTlBRUSfzcm1S3vRM23x50TCR3uA32FjwEk/1YUmYXzply36gSWF8TBFz0yfas8EUDho6pRI7Luj4Dgws9b7N07wIDFJ5qxx81DHQ8SeV/FbipuUpsAyNDpt28Z05WjGBbgJQz1sa0uxZw29H3nGxI=;24:OYMomNeBQ0CC8EXoGx7bToDEZgaUAu66yWxZVZOU1SeetniXwjuGw3HRaost/8okU4sl0xICSEdKGdOMdYPlHdAK2zlAQrkGhKKXEWHmdPM=;7:IKw5kL+biyUbWcLuckOmViUKlzP//4tbU0lRY4ZxO2MbhOQQadp2w1Syg74rCJGuZme+wofxylfmgTJUxFhNYp+JYQLJL4erX2dy5I22t9AYDmAlTk6f0dLO9obXSmLMzKKXu/Mgl8fX4E24N9Hudwf6/qQVQy0kPxZJFyRtBCnFK4kijV/OYGUPxkdRloWDlpl0pAlvNrNxzy4jIqPtuhlbn8iHV0AS1MQIuMVq5PyxdiE+GUnrMG4ExyrqQgLA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SG2PR06MB0981;20:qFWlbJr4z5UuRXyjVi9G21VHWev5zn1Q0jtM3157Wyu2QngBk6+lhCqNoJcRcHFfua0d7fXNDJWlK6TmskZzBG5JimQHPLMYT6zI9kQElyT+z7TprPk8XFjhEAqzFFSvXVYLk3Myes+66vOOrOR9e9HFH34oyhEycHpSuxFOTEc=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2018 05:57:22.8696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f555504-dd46-4a7d-7a7d-08d57da6f8e8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB0981
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds R-Car Gen3 USB 2.0 and 3.0 support for R8A77965.


Yoshihiro Shimoda (2):
  phy: rcar-gen3-usb2: Add support for r8a77965
  phy: rcar-gen3-usb3: Add binding for r8a77965

 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt | 2 ++
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt | 2 ++
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                     | 4 ++++
 3 files changed, 8 insertions(+)

-- 
1.9.1
