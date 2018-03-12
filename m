Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4009665-1520844650-2-12768116457890981967
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520844650; b=h3fvyuo/eTmavDymAglzMuROQdDy349RC10KZ3hiYo+8EQR
    /T65NDlhSvfZ+qo9tiBSWpI0bL9M1C8FDKJyGmBxfR9jHPPMVJ+ykBTSRPY5WEb4
    Qod0f/8Y9zPWtvPO0nYA/HdyUQjnzup3Z+zArxxd5fgQ9WxH1MpwY1qXvuqapACh
    uaSapVhVQ/xyHlU8jcCQxXcHoiv8chk3rpuK+xglqVVlk50EFqmtK97JAxHiIAOG
    MHFPeWx/x1atceKn7OBqgX37vN43tseIzhbdgdbLDxzsddHxuIw4b6J5Vga0xgQH
    3lYsSIG+2JUd9xbz+e5mjcph2vx07Cu+Q97XLCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520844650; bh=Z
    lx7VHnxbrVw26Gnq/As1idlwrCQjAhTVyaMeaVV89U=; b=dnSx8gB+XG0xFv5bo
    Vm0ojYhb5S8bnukUdoiujBYdeiv4sgJsR1sTyffWqpK+j+YLO0fPeUMB4aLL+Zke
    AXmVt6nLAMhEcLwXPmhcCE2vxS7QCC/LhfhSU03/oajeoaY42REGrl7mWVH7iHC2
    iFPMKqHdPdvekDkGWbLxH7iEfAuv940cCydq6ts5QU3sQ3Iof233PW6Z8E1Yt3a/
    ZWBh5GLuac0qnDMUReak2+Z/JwDsdDoDtPc6O08VARoIBYE8MfuBdZqYosN6LQDk
    P9ZjhfwNjPiGMMRnA8V2uepBX6bQwhZWtZcrOHYwqvMAfafcB1c89T56RmFiDKNN
    ba/6Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=qfwU/iJJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=qfwU/iJJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=razvan.stefanescu@nxp.com;
From: Razvan Stefanescu <razvan.stefanescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v4 3/6] staging: fsl-dpaa2/ethsw: Add ethtool support
Date: Mon, 12 Mar 2018 03:49:52 -0500
Message-Id: <20180312084955.12686-4-razvan.stefanescu@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180312084955.12686-1-razvan.stefanescu@nxp.com>
References: <20180312084955.12686-1-razvan.stefanescu@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: DM5PR19CA0022.namprd19.prod.outlook.com
 (2603:10b6:3:151::32) To AM3PR04MB0743.eurprd04.prod.outlook.com
 (2a01:111:e400:8839::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d45b5921-2ca1-4a4a-f094-08d587f64655
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM3PR04MB0743;
X-Microsoft-Exchange-Diagnostics: 1; AM3PR04MB0743;
 3:Vr+kn4L8DysydgDci8xWfQq4xHbn5+ZcCdmvzytEjt+HPAv40KgTLw3folU7A/zVycmXY0LuV7z7H0gd9bdOLsuPhP49vbY3i0P8VzXVMF3VWaX1yBKafvKVI2FpHN0GZXHgwLIPOx2FlBdTB3THERxcEWZw5rBNDDoEy2MY0QWJ+85uPBFAliklq81AM+wNQ1Q2+U+ujIdwa9H3v4j0JdfVAESDb3JJy7v2ImGZlfWTuQy+FYP4Tpbb3zhXg52q;
 25:HvGqV+o9fjNXuEi4RNePE+Fy1cs457K8vN1Dj826u1lYqBPimhQZW5eYKgi3FlHxDoq3cYMvjk2HEzH1gAhjt6OND+GYwsl1uiV9WAtiecrp16NmiZOfgKO6n0lo7xbXhqk2m/WRkQVo1a18UvUetlKWL0JRud/ZucNgZd9WRw0tvtX+m6Yzmo3FCQOZSmGUAcN00wSZayP2U/ehuP3K3/ln6YPtIO1YBIG0JLfPbh9GrIUqg3Gg5eOxvt5djKPw9mtQ3843LkifzKpJTezBZV+FZ82lqgZXD7fudWAS1xMga5yymSjoUgk7p35sutBAJq/F2l8bVxtIYl9DBhX4OQ==;
 31:PkXI1dBFEMB93bgY7so7+yCVK98ajgb05441kb8kmWloq4p6vTe2xKSXZ9VYgcnfNbZL7YgoH58RzfqsC/vCKqzs59jhPN4Lh4aXxpRV02a6dIMLVtPNImhN0P0v+cStUvupK05lSLvLa3v5xv5QppWC4WH3XEYwxjoslHy7prv94m70STPiI/SIQis+58xdmynsAbCntml5aadQAASH+bm2clh41D2rWksK+zhMZmk=
X-MS-TrafficTypeDiagnostic: AM3PR04MB0743:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1; AM3PR04MB0743;
 20:frJdz9gnjqMbMf/9CzmrFNlxfELZcH4r8+fZGDIuxrBHy8flGwOaz8VfJLbWC4Sv1WQcPzwrFF47j9K4Nxj32CWxcqoPAJCcW75kirk97bTvxHRL+neTdXzTwPlzceNIdaoR7eP4I76AYMHDKlqlsj/D8OLmm0gfSmeu4SP6pa3kQPWfeo6NEKoWWU/n6rSW2Qc+K/TPQD7B9VZzCHBDmtmRyCyFh15uwfUdH+9XUG5q/XcNopsWsUigoJSzgwaXgUAfEYZPYecl313ztRhifXLkql5QHHALSftZArRoQ9lLzLXlFKJdVzaeuHTXT+stw0t3O02y283N8CuBPM2lpLuIvp3wfmcXbJXE5ptGYlFGBaWyk1p07TrJ9cU4QVTIlsCYt+Tx3tucXMX+C3RxeikJsLYb//E4tMiMsZWDJ01ZInDSc11x9aE1BNV+uObGkwDRvRU2ucUUmBSz9H/5mW82Yrg53hYlak1ErejlKGySEjfSY8Wr/qv6XNCfr97s;
 4:8An5NTYDi/3WaQ7QQx034QwENOtCL+fQ7rv42/gXR5rpGnLTKfismHu3ff6rXIWlPEuW9MDdZ69oX48etzd39dmGnTt7MIyyhxzH9ieETivfRQoF+tYkRpNMFA7hg0FBO5Xtir/Ricjij9DXEqwpeZcCqeXbkmi0CWr8dZy2Ca3Y6t9RhaAJjT+gJ7Bg4O6c5UI34vtiz/8b98iX+emv9w+y8rmNIhJOYo+0p5orWENKRDTAWV0uuqmQ8LiyyAQ/4kDL8IvPyOCexFAqI6+XDDBfACy4RjQ5q+wZ2XjXg/y+XcpVVfci4/bcZHhtgaPe8ThD8Cq4/PYHbJz1sAwthtpHSsBv7x+qEZj/JqqnqBw=
X-Microsoft-Antispam-PRVS: <AM3PR04MB07439BC5BFFC99FDDA7A8A95E6D30@AM3PR04MB0743.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011);
 SRVR:AM3PR04MB0743; BCL:0; PCL:0; RULEID:; SRVR:AM3PR04MB0743;
X-Forefront-PRVS: 06098A2863
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(346002)(39860400002)(366004)(39380400002)(376002)(199004)(189003)(54534003)(1076002)(47776003)(76176011)(52116002)(6512007)(36756003)(6486002)(39060400002)(66066001)(51416003)(386003)(6506007)(59450400001)(5660300001)(478600001)(26005)(4326008)(53936002)(48376002)(6116002)(3846002)(16586007)(2950100002)(6916009)(6666003)(105586002)(2361001)(2351001)(25786009)(8936002)(97736004)(106356001)(2906002)(81156014)(316002)(50226002)(81166006)(16526019)(575784001)(50466002)(86362001)(68736007)(186003)(305945005)(7736002)(8676002)(2004002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM3PR04MB0743; H:rhuath.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM3PR04MB0743;
 23:MYd5ouSrVo8JIx9Mhrzj6ty76LnbBh1lkpOWqA7v2?=
 =?us-ascii?Q?3kJjA1RqQiRBj9Pq3TQtHQMwjzSr5phJ79RElE5NwrEPCWEbnxZpvGMkeBwC?=
 =?us-ascii?Q?5LDwJDJhpbzECGxj55FJlIvOXd9ctoGgAYeeljCzaE+Ciadc6h+zAqo7VIu4?=
 =?us-ascii?Q?sF5olF0MYrHc9f6BM9eZ/QZucVhzqOAwu2YssGpy0LzM/tEAJ/9638Xw4va0?=
 =?us-ascii?Q?gg3d7AEktOCuCxfVwvbQKkKMD5V3kOmlehuevDSWYVjM7e+pyAK7xqpujZj2?=
 =?us-ascii?Q?+cGcc++2AgFU8nPNpP5yLahT55b86ojBimMtdwiUzTflDhaSVU3vA4+w+vIv?=
 =?us-ascii?Q?edVwQhX71QkFGRRn0ISc7XNaLASDaV74RLIHYd15v4fB8mfiTSTemE8cgdll?=
 =?us-ascii?Q?9qkgQQvYf4s6KcwRqdgRcoP1WCPbzO5PqQwk6PQpz73rsAvITSpFxU+oHBEl?=
 =?us-ascii?Q?WBzLnSPdRX9vKHIjvO4Rz1TXnadJONsgCrZ3h0z/57I9WetwvH7tia+40J/5?=
 =?us-ascii?Q?6EALHCl/Jp42Ha1KiGrz++vAUbyAvTCqjCZWA6loAgsDqM6+GdQ8jgIFqjxF?=
 =?us-ascii?Q?tSugg15NgPwSIicpvgC8C7xnKy9bDDKs10tBQJrQAsDf0ms13aak/P5UBn1w?=
 =?us-ascii?Q?yZZgBahS242uf5bHM6XbnQMcUFeAcwXeVa9lkYqNc+LAbzkngFOz0WRHMTtm?=
 =?us-ascii?Q?Q+HxaAie55w4VC1q9rk0UH2HBgjdRqY4oyzzp0KBR2ir973JQcn+mYJSuL1m?=
 =?us-ascii?Q?frFJLYv81xEqZ3HO07lIncz9vA+6sdeRrmo2FDjl9DEHvldoynn6KElOCoFM?=
 =?us-ascii?Q?DGOiSL90RbZy2g/vVHLM9xphxmFUJaN9+tT76RSIHSHxU+VqGdTxCvpTmIe4?=
 =?us-ascii?Q?i3puGk59j5Eg/ybcRYQiDFOFNcUFPasmiGPZwacfJEH+tXjM5k/ILSMJg47I?=
 =?us-ascii?Q?CPSvwpoigjOy5GfFzfpYzxz2v/JpJO/nouy/xcgbMPEnjCpiH3cOCo3R0Jyj?=
 =?us-ascii?Q?yH/NhlbrHZ2w2R9OYWKmlXORssR5d944nhWHf8/VIcJoytW/8vaa1ROtrMsV?=
 =?us-ascii?Q?hdG4jwGDiA6PnPitlkbRAl3c1guTeAqlp9B6Fxo5856sxdeoJGPuxA05AlJe?=
 =?us-ascii?Q?cuqHcdWp5B6KqQbKEkXzahHrwy8sxCpEHDdgGZrBWfMo8kPryDUgZyu9nA+i?=
 =?us-ascii?Q?fkW0HZDjbqecaP6rH7Nvin2k61gJGPgA2ylxFCrNjI7cjHb0PZ476/4EUs7s?=
 =?us-ascii?Q?QCN/mY+1mv7Fun96Ji9ajY8Zpq77IeOjehqUzj6?=
X-Microsoft-Antispam-Message-Info: bmI3SXg+fdjwo81c8KiZvEA/8DS4+OvNb8AE91UNLArDm+KaGRJJTSSareX91Hpr3gKtjRRSUPLCp74wHk0UPm27PzqE1Ov945qK5Sv+gO0b5atwZPC0zMJml/U0WCEPgJ5uLIeCGE/xs4MHq32VOyl3y2baEvbgZeXOzEAE1ah+8pRenuWRb/cELkCjoLJ2
X-Microsoft-Exchange-Diagnostics: 1; AM3PR04MB0743;
 6:VVEVuhnJYnPJih04jGm+1dVUXEgHFHhKhMzmQpPAeVekQzG3MPQxYU4LHapcRdRUmfqbKZZvFFhWMJOcvn75cdF/TSuBCbRfvnTHkWQwwRVwDQ18LKiC4luqSiGmdxi00MRmiIH4zNoQlvTbu9cmFQFWr7U42X+O74I7SsV9zl1YKpgi+zfdcKCBKBMqnMk54h5FAnwXs16psGYZ5N2sY6lRworpW5m/s4Dswr0I8ua8QH532cvCNeOz0/qVbpC+6pRbT5VFKqRL3FEQxyq7aGSYCtHQXvc7vLqazM4Yn+I4JiRzhPcugmhmb6ij/k1ipHFudnePESzVx/zFVJAnMZR+s6HUj557NMbmqUWwVnk=;
 5:pb41HjQNHE7MpcxsFUm8+JMHyfaRPevwTHGyoEemQjwQls+URDcA2bu5eaX99NQwxqw1qA2y14V/WcVliK6EU86GERSdQkJ7ngIAu3Za+NJz/Rl4uNFetVb8uRNlxfkwx0cKwAGK5tlWwHw1KDPD8UbRtzdXgcwCiWqbTRTV58o=;
 24:UcEPRfNRb+CVehWOGTRCQfOz9P9+MFXgxY1e3niGMhLXtz8lYgajiXT2qHZMp2LPv2VMG1w1/88Ux8MKfBofg/zMnjrCevvugpQPwFFVus8=;
 7:ml8i+aDljn5se/oOiC0kVBPewQeB02iTUCBMHKzeFFms4ZjUV67lRyrUvqsqli3fHkWhrSZuNcu8uJTLVN/W40YfxBd1c56lJigurRG3/vZ29/bSxbtbsvErjY3WCW3yrM7SP2Xbd2wMmqT/YsX9IHvXPcAViYxV4Kc+/+I8XJaE0TF7tPKMMSRwbAZLLaggpRC9QL++oIkNTyT6rzrTj9vb1I1V+ygT+MwPXKVYa/9sxuMJ7KREUOzbTqRpx3je
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2018 08:50:13.2503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d45b5921-2ca1-4a4a-f094-08d587f64655
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB0743
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
Cc: devel@driverdev.osuosl.org, arnd@arndb.de, netdev@vger.kernel.org,
 alexandru.marginean@nxp.com, linux-kernel@vger.kernel.org, agraf@suse.de,
 stuyoder@gmail.com, ioana.ciornei@nxp.com, laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add driver information, link details and hardware statistics to be
reported via ethtool -S.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
---
Changelog:
 v2:
    - no changes
 v3:
    - removed driver version
 v4:
    - no changes

 drivers/staging/fsl-dpaa2/ethsw/Makefile        |   2 +-
 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h      |  13 ++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.c          |  32 ++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h          |  32 ++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c | 206 ++++++++++++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c         |   1 +
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h         |   2 +
 7 files changed, 287 insertions(+), 1 deletion(-)
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c

diff --git a/drivers/staging/fsl-dpaa2/ethsw/Makefile b/drivers/staging/fsl-dpaa2/ethsw/Makefile
index a6d72d1..de92cd9 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/Makefile
+++ b/drivers/staging/fsl-dpaa2/ethsw/Makefile
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_FSL_DPAA2_ETHSW) += dpaa2-ethsw.o
 
-dpaa2-ethsw-objs := ethsw.o dpsw.o
+dpaa2-ethsw-objs := ethsw.o ethsw-ethtool.o dpsw.o
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
index 36edef6..c45f001 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
@@ -74,6 +74,8 @@
 #define DPSW_CMDID_IF_SET_FLOODING          DPSW_CMD_ID(0x047)
 #define DPSW_CMDID_IF_SET_BROADCAST         DPSW_CMD_ID(0x048)
 
+#define DPSW_CMDID_IF_SET_LINK_CFG          DPSW_CMD_ID(0x04C)
+
 #define DPSW_CMDID_VLAN_ADD                 DPSW_CMD_ID(0x060)
 #define DPSW_CMDID_VLAN_ADD_IF              DPSW_CMD_ID(0x061)
 #define DPSW_CMDID_VLAN_ADD_IF_UNTAGGED     DPSW_CMD_ID(0x062)
@@ -262,6 +264,17 @@ struct dpsw_cmd_if_set_max_frame_length {
 	__le16 frame_length;
 };
 
+struct dpsw_cmd_if_set_link_cfg {
+	/* cmd word 0 */
+	__le16 if_id;
+	u8 pad[6];
+	/* cmd word 1 */
+	__le32 rate;
+	__le32 pad1;
+	/* cmd word 2 */
+	__le64 options;
+};
+
 struct dpsw_cmd_if_get_link_state {
 	__le16 if_id;
 };
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.c b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
index 8e52d74..e63531d 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
@@ -383,6 +383,38 @@ int dpsw_get_attributes(struct fsl_mc_io *mc_io,
 }
 
 /**
+ * dpsw_if_set_link_cfg() - Set the link configuration.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @if_id:	Interface id
+ * @cfg:	Link configuration
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpsw_if_set_link_cfg(struct fsl_mc_io *mc_io,
+			 u32 cmd_flags,
+			 u16 token,
+			 u16 if_id,
+			 struct dpsw_link_cfg *cfg)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_if_set_link_cfg *cmd_params;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_IF_SET_LINK_CFG,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_if_set_link_cfg *)cmd.params;
+	cmd_params->if_id = cpu_to_le16(if_id);
+	cmd_params->rate = cpu_to_le32(cfg->rate);
+	cmd_params->options = cpu_to_le64(cfg->options);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
  * dpsw_if_get_link_state - Return the link state
  * @mc_io:	Pointer to MC portal's I/O object
  * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
index d13970c..5a0c7ad 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
@@ -245,6 +245,38 @@ enum dpsw_action {
 };
 
 /**
+ * Enable auto-negotiation
+ */
+#define DPSW_LINK_OPT_AUTONEG		0x0000000000000001ULL
+/**
+ * Enable half-duplex mode
+ */
+#define DPSW_LINK_OPT_HALF_DUPLEX	0x0000000000000002ULL
+/**
+ * Enable pause frames
+ */
+#define DPSW_LINK_OPT_PAUSE		0x0000000000000004ULL
+/**
+ * Enable a-symmetric pause frames
+ */
+#define DPSW_LINK_OPT_ASYM_PAUSE	0x0000000000000008ULL
+
+/**
+ * struct dpsw_link_cfg - Structure representing DPSW link configuration
+ * @rate: Rate
+ * @options: Mask of available options; use 'DPSW_LINK_OPT_<X>' values
+ */
+struct dpsw_link_cfg {
+	u32 rate;
+	u64 options;
+};
+
+int dpsw_if_set_link_cfg(struct fsl_mc_io *mc_io,
+			 u32 cmd_flags,
+			 u16 token,
+			 u16 if_id,
+			 struct dpsw_link_cfg *cfg);
+/**
  * struct dpsw_link_state - Structure representing DPSW link state
  * @rate: Rate
  * @options: Mask of available options; use 'DPSW_LINK_OPT_<X>' values
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
new file mode 100644
index 0000000..2853105
--- /dev/null
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
@@ -0,0 +1,206 @@
+/* Copyright 2014-2016 Freescale Semiconductor Inc.
+ * Copyright 2017-2018 NXP
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *	 notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *	 notice, this list of conditions and the following disclaimer in the
+ *	 documentation and/or other materials provided with the distribution.
+ *     * Neither the name of the above-listed copyright holders nor the
+ *	 names of any contributors may be used to endorse or promote products
+ *	 derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include "ethsw.h"
+
+static struct {
+	enum dpsw_counter id;
+	char name[ETH_GSTRING_LEN];
+} ethsw_ethtool_counters[] =  {
+	{DPSW_CNT_ING_FRAME,		"rx frames"},
+	{DPSW_CNT_ING_BYTE,		"rx bytes"},
+	{DPSW_CNT_ING_FLTR_FRAME,	"rx filtered frames"},
+	{DPSW_CNT_ING_FRAME_DISCARD,	"rx discarded frames"},
+	{DPSW_CNT_ING_BCAST_FRAME,	"rx b-cast frames"},
+	{DPSW_CNT_ING_BCAST_BYTES,	"rx b-cast bytes"},
+	{DPSW_CNT_ING_MCAST_FRAME,	"rx m-cast frames"},
+	{DPSW_CNT_ING_MCAST_BYTE,	"rx m-cast bytes"},
+	{DPSW_CNT_EGR_FRAME,		"tx frames"},
+	{DPSW_CNT_EGR_BYTE,		"tx bytes"},
+	{DPSW_CNT_EGR_FRAME_DISCARD,	"tx discarded frames"},
+
+};
+
+#define ETHSW_NUM_COUNTERS	ARRAY_SIZE(ethsw_ethtool_counters)
+
+static void ethsw_get_drvinfo(struct net_device *netdev,
+			      struct ethtool_drvinfo *drvinfo)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	u16 version_major, version_minor;
+	int err;
+
+	strlcpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
+
+	err = dpsw_get_api_version(port_priv->ethsw_data->mc_io, 0,
+				   &version_major,
+				   &version_minor);
+	if (err)
+		strlcpy(drvinfo->fw_version, "N/A",
+			sizeof(drvinfo->fw_version));
+	else
+		snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
+			 "%u.%u", version_major, version_minor);
+
+	strlcpy(drvinfo->bus_info, dev_name(netdev->dev.parent->parent),
+		sizeof(drvinfo->bus_info));
+}
+
+static int
+ethsw_get_link_ksettings(struct net_device *netdev,
+			 struct ethtool_link_ksettings *link_ksettings)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct dpsw_link_state state = {0};
+	int err = 0;
+
+	err = dpsw_if_get_link_state(port_priv->ethsw_data->mc_io, 0,
+				     port_priv->ethsw_data->dpsw_handle,
+				     port_priv->idx,
+				     &state);
+	if (err) {
+		netdev_err(netdev, "ERROR %d getting link state", err);
+		goto out;
+	}
+
+	/* At the moment, we have no way of interrogating the DPMAC
+	 * from the DPSW side or there may not exist a DPMAC at all.
+	 * Report only autoneg state, duplexity and speed.
+	 */
+	if (state.options & DPSW_LINK_OPT_AUTONEG)
+		link_ksettings->base.autoneg = AUTONEG_ENABLE;
+	if (!(state.options & DPSW_LINK_OPT_HALF_DUPLEX))
+		link_ksettings->base.duplex = DUPLEX_FULL;
+	link_ksettings->base.speed = state.rate;
+
+out:
+	return err;
+}
+
+static int
+ethsw_set_link_ksettings(struct net_device *netdev,
+			 const struct ethtool_link_ksettings *link_ksettings)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct dpsw_link_cfg cfg = {0};
+	int err = 0;
+
+	netdev_dbg(netdev, "Setting link parameters...");
+
+	/* Due to a temporary MC limitation, the DPSW port must be down
+	 * in order to be able to change link settings. Taking steps to let
+	 * the user know that.
+	 */
+	if (netif_running(netdev)) {
+		netdev_info(netdev, "Sorry, interface must be brought down first.\n");
+		return -EACCES;
+	}
+
+	cfg.rate = link_ksettings->base.speed;
+	if (link_ksettings->base.autoneg == AUTONEG_ENABLE)
+		cfg.options |= DPSW_LINK_OPT_AUTONEG;
+	else
+		cfg.options &= ~DPSW_LINK_OPT_AUTONEG;
+	if (link_ksettings->base.duplex  == DUPLEX_HALF)
+		cfg.options |= DPSW_LINK_OPT_HALF_DUPLEX;
+	else
+		cfg.options &= ~DPSW_LINK_OPT_HALF_DUPLEX;
+
+	err = dpsw_if_set_link_cfg(port_priv->ethsw_data->mc_io, 0,
+				   port_priv->ethsw_data->dpsw_handle,
+				   port_priv->idx,
+				   &cfg);
+	if (err)
+		/* ethtool will be loud enough if we return an error; no point
+		 * in putting our own error message on the console by default
+		 */
+		netdev_dbg(netdev, "ERROR %d setting link cfg", err);
+
+	return err;
+}
+
+static int ethsw_ethtool_get_sset_count(struct net_device *dev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_STATS:
+		return ETHSW_NUM_COUNTERS;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void ethsw_ethtool_get_strings(struct net_device *netdev,
+				      u32 stringset, u8 *data)
+{
+	int i;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		for (i = 0; i < ETHSW_NUM_COUNTERS; i++)
+			memcpy(data + i * ETH_GSTRING_LEN,
+			       ethsw_ethtool_counters[i].name, ETH_GSTRING_LEN);
+		break;
+	}
+}
+
+static void ethsw_ethtool_get_stats(struct net_device *netdev,
+				    struct ethtool_stats *stats,
+				    u64 *data)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	int i, err;
+
+	memset(data, 0,
+	       sizeof(u64) * ETHSW_NUM_COUNTERS);
+
+	for (i = 0; i < ETHSW_NUM_COUNTERS; i++) {
+		err = dpsw_if_get_counter(port_priv->ethsw_data->mc_io, 0,
+					  port_priv->ethsw_data->dpsw_handle,
+					  port_priv->idx,
+					  ethsw_ethtool_counters[i].id,
+					  &data[i]);
+		if (err)
+			netdev_err(netdev, "dpsw_if_get_counter[%s] err %d\n",
+				   ethsw_ethtool_counters[i].name, err);
+	}
+}
+
+const struct ethtool_ops ethsw_port_ethtool_ops = {
+	.get_drvinfo		= ethsw_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+	.get_link_ksettings	= ethsw_get_link_ksettings,
+	.set_link_ksettings	= ethsw_set_link_ksettings,
+	.get_strings		= ethsw_ethtool_get_strings,
+	.get_ethtool_stats	= ethsw_ethtool_get_stats,
+	.get_sset_count		= ethsw_ethtool_get_sset_count,
+};
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index b992434..022450b 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1384,6 +1384,7 @@ static int ethsw_probe_port(struct ethsw_core *ethsw, u16 port_idx)
 
 	SET_NETDEV_DEV(port_netdev, dev);
 	port_netdev->netdev_ops = &ethsw_port_ops;
+	port_netdev->ethtool_ops = &ethsw_port_ethtool_ops;
 	port_netdev->switchdev_ops = &ethsw_port_switchdev_ops;
 
 	/* Set MTU limits */
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
index d1930b6..2994b37 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
@@ -57,6 +57,8 @@
 #define ETHSW_MAX_FRAME_LENGTH	(DPAA2_MFL - VLAN_ETH_HLEN - ETH_FCS_LEN)
 #define ETHSW_L2_MAX_FRM(mtu)	((mtu) + VLAN_ETH_HLEN + ETH_FCS_LEN)
 
+extern const struct ethtool_ops ethsw_port_ethtool_ops;
+
 struct ethsw_core;
 
 /* Per port private data */
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
