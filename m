Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2033369-1521043006-2-10361244831054137854
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521043004; b=VPD7n6JAk9NSbg976HxSqYsEYyM7sz2qa/bYC5tqsDj6VDX
    4L6sl4EoF4saLmHXG+rxhzQGCijLT/b9eDyUFCvzildT6A2Wr1rOr3+qFWiSYMXB
    qo+HH78LcEasVRth3/vkUgqEcXaq04G12pVY/+CdT7JyyAIgsmVvLR0Cy7XPPvB7
    Y1G6xY55JVNC1qPaYi1WvcxthpXIXMhk1ypSYxkdhXxvLCtRqmYcJD0Peu+Miqe9
    pKYfZyYc4Y4+nK+bxVTGYI8mh39x1Q7CkpdR7gZdm6sw02PJDwAn0jC152Dtjv7Q
    7abuhh/u+tJIXKcIT0mefQVSPwdLznAb38kVklQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521043004; bh=v
    KGfksyK4UalzJ45DcnCZHhuBqitAj0LVz6fDnstSnI=; b=xABTGdgTivzijDsO+
    PlK8y8/pmJdNhK63EC+OOvwv8kMEw5cl35AlLvgnrxZFITCNx8qda0Yf8/mtIOfQ
    JKAFeIqVy3tonRd4uNfAOMWhVPAh4N4enoc9cDJWG2zhB578Caq8PMa6Gomy9qrz
    vykLKufyJZ2ekCIE8MQVzydxtv03+Ehk+ZMmDJDbAY/rdp7BsO9FabhOHsCNi6Xy
    kgAtvc2q6AbSN026q25Y4tZfqiOsHt4SsREDvWz0kIkWng87mhScSAL2xPaL9xsK
    d8XpoSvUv2fKhfhy9p+pklE4LEq2v2r6veN0SFqj6WJeelAN3Y0kXLGsjTmRml9K
    TAYIA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=AwYPJgqY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=AwYPJgqY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=razvan.stefanescu@nxp.com;
From: Razvan Stefanescu <razvan.stefanescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v6 2/6] staging: fsl-dpaa2/ethsw: Add Freescale DPAA2 Ethernet
 Switch driver
Date: Wed, 14 Mar 2018 10:55:54 -0500
Message-Id: <20180314155558.6898-3-razvan.stefanescu@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180314155558.6898-1-razvan.stefanescu@nxp.com>
References: <20180314155558.6898-1-razvan.stefanescu@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: MWHPR08CA0047.namprd08.prod.outlook.com
 (2603:10b6:300:c0::21) To DB3PR04MB0747.eurprd04.prod.outlook.com
 (2a01:111:e400:9440::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 87d70e58-6d13-43e9-1761-08d589c4228f
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR04MB0747;
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 3:lGEOh6djOOAuDo9rwQ2pUE5zVCAXo5vV1rnRdCquF1JeqB4r0tRWppOt1lKI/ib9BkqcdMILUyJ+1Y+cPfln1sminrUqVgu4FY69eooSXMGZLN17A8id7bEY2L1Arh45JlMbdF0bCWbFM2qVaxxqs/No0kkMIWNrO4A0mAIm9AouGPL7nBTtr0RD5X1rm7B/6osqR4ce+ZQmjzOMx6k9h2sNGQsrM9CudU0dRy6n2hn55wjPK4FBFGmjw+IsmUYK;
 25:FHGsAYT4q1mTEuOrQHeBJ0hfWYLXo1cKzavcbxxGxcf0RHNCin1VOva3Q5oucolJkn4srTqDcv9pAaB0StEfewtV2V39qlQSfpWmoTY7YiZCz3jv+DQZ+24vXfS7qy2u5TqHNQQ1KnRTWG9L8bsc6i2ydviGQsLR+7sAqNYOf30Qn0rhqIokm8THNfthlKhZmgB2pZtYVvIWkzDdgwM59P8dmMDpHTIpemrwTYwK3RYfkKHwOjM6CrJmT8pgFyxDIPxRNQQQZ/z1D0mknjwj4XcSr429c5die2lJXJW6+VwKD6W5f4OFWtXCI5UQsyDdzE8jpAbALEyHQQm/TxNp/Q==;
 31:Ik5YrxvU1eDM8LQ1DAqz7KEM301NVQw6QPyZncU2iMs2SOpp+CJrs57i9cNaaHawGsWFywHydbetiuiLxAkuaUvXwY2A3mG4Dkl6MNTSieTuKxiR0ZcubpuZVBplzLC2feEl5ICeuTCPXuRpqXX2Ps2YjwPLM7qCF03YouLdLZ6UVKgAPp7pX7jFimU1ydbRMLoRRwOOyn/so5F6qRBTBxa0r4PEGCmqE66vU3gUvQo=
X-MS-TrafficTypeDiagnostic: DB3PR04MB0747:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 20:PGj1O6CZN0ZC/ROnJEkzjUc2s3UJWlVW9+e+TBBTPbGd6cuJ86P2AJn6SMUxCHmjHBalr9t9YeHSn8PdDidUFEsrB+rtDpQXVDhqOHcJGClryRY9otJOdTz7dMCfVVVWNDqALhsUzUslw504CndUX2IsNguhlCSUQS0ivo6LuX6gw3UgUnQLPDEZ3IAk6KassekjDGj2zKcZr33v1nnyO+EzcxPNEyuSovFYtXHTv1kjk8TcGkaf7wRBiPnT3QpiL33vfnMQp7Yx3B+mJJW4xcuuMtvaCIrLu2U80+x52m0ilWAlvlVB5/gEIr0akDw4L+bT6I2vzgIjrMwsDXWdR2H5WcJY9A115Jv7dvD7CW67928OEooyxEchbjfGtXwrM96f4z0XEyb5KWFeFu5WrqUOHfji3BChqikV92Ez5GlCaKHEwmN9A5j9IcMtEWqD6ZavpWqzPyk9VsYDUxDUQpyJGu/tX5q+Q8j32BLumz8sEVahLdXaLxqRn9zPc2o6;
 4:64v89rOEREelU0+zK8kdIH6B5YqZ+E7VPbrb/k5i3rK8QaPlleaxD14T5GOSF3xcnOah7JcJcv0NyGSlIkWdAfStrhBKa6oOC94DzuGGKXknOwjMDdHf1e5GbWwuDOPNDGZV1koKn1kUVC7FovExIMDpf13oo0oqI6TxqKXcGmPefMTc0SJpnwSpw3GuiaF+wJtATNxZgrrP4mI8f2xD1J66Vj+OhYdV5ig9zaqUMDobhlER1UFnFE/dabrL0UYVPQUlM2vpNE3fIbPhRZf5O+TTtpkK5XSJC956e5s8T3nILKSTIxHAcbTIU3zPTY5GDPS3Yb2yei+fA277fHtpo+7AqzzivZX4b2t6ioqQ7Ls=
X-Microsoft-Antispam-PRVS: <DB3PR04MB07477FBB0CF7106BB00307DAE6D10@DB3PR04MB0747.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231221)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
 SRVR:DB3PR04MB0747; BCL:0; PCL:0; RULEID:; SRVR:DB3PR04MB0747;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(39380400002)(346002)(396003)(366004)(39860400002)(376002)(51234002)(54534003)(199004)(189003)(6116002)(3846002)(16526019)(386003)(6916009)(186003)(76176011)(48376002)(1076002)(50466002)(478600001)(47776003)(6666003)(5660300001)(2906002)(26005)(305945005)(81156014)(66066001)(7736002)(8676002)(6506007)(59450400001)(81166006)(2950100002)(25786009)(50226002)(52116002)(86362001)(53946003)(8936002)(316002)(16586007)(39060400002)(6512007)(36756003)(68736007)(6486002)(106356001)(53936002)(51416003)(105586002)(97736004)(2361001)(4326008)(2351001)(579004)(309714004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR04MB0747; H:rhuath.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DB3PR04MB0747;
 23:CqtJQU6DOitv33q/58oWy6Ye34fKOXlY4bTNUXeh5?=
 =?us-ascii?Q?PJF7H9Aqx0vnTJ5Hu1IEANxKjpgwtidHnbvesDuUfShY5FjNPRvQUleN8Jpp?=
 =?us-ascii?Q?iv56T5lsWG/fMhn6KcmAankO7iDV7ur/Fy+sUTB85qclmbun0aCuMlhuda5L?=
 =?us-ascii?Q?qvNGF0wEfiycvCZA81/Ty5txDerCTmKlr+MyIN1wtSR6lx5vqlJLL2Ng9qFz?=
 =?us-ascii?Q?nwYkliFQissDsE7aH4KC2ytH7wh0WJpZx//Nm+gqoOlrRByS36t2MXJkNtQ/?=
 =?us-ascii?Q?UgrxxpTmC+0GxTm8CYCHqs/MxM888uApDkj+JO2WiOuxTZUy4nh9WSyBUWiM?=
 =?us-ascii?Q?z3DzxCqISd/X9AhLqdG4l8Pys7HAKQrp5nNqWVX0nmTk0AWJ7+iVykyFG2T2?=
 =?us-ascii?Q?GJIYNj1/ZGjdEiO+GepHB/SOY5PdZq0NnaGDv5x51LklKbzQnQMr7pyW6xfN?=
 =?us-ascii?Q?DibVe4FmHspldYDElVQJ2y/GmIpPh/68RTO8NbIX3Kidu1JbqlgfWSXx4moh?=
 =?us-ascii?Q?9lSFP3Y89Dp9myhLM0N8qKCYhC86S6GmAKCJQkWE2ttbSN8/22DuNkqJRy02?=
 =?us-ascii?Q?Af9C8512sHXjj17J9ymKwqtPPoAwDN3/GrUJkhEYTi2j+N/EqzpYXzojfAOn?=
 =?us-ascii?Q?ONLUJDv3BxuGycr/9a4zqMBhGBfkbwW6y0dvNkPbUqsC867tCDBfVw0OD7nc?=
 =?us-ascii?Q?/f/g7d5rw/Z1LO+vpaUB/jhAAan3Ke6uZKJVbqW4WBJJSsoFCG3vTPSYktUO?=
 =?us-ascii?Q?eOlyNBd1gdhy8GRbrlwHCx2aZCZOWjSqHyuq+ETcSKO4hkkRHelwvVVQpYiu?=
 =?us-ascii?Q?rA6274mctZTft5QAM6p/5Uxu4nDT5ZdYi/T2UUoUTEa9ZxOSw0VD9rysgHgp?=
 =?us-ascii?Q?TKKTakpLuyCw0ABbM268jdXtVckovYcIX1q68SELk2YiMPsYvc6BQbk7kKi7?=
 =?us-ascii?Q?73sE/wxjVBS5I1/pojH1F2uCt1IJqejBO/bVrk8Ci58aQWsC6VQ7pUuW35IW?=
 =?us-ascii?Q?ow1NSRWW5ubtap6rVMDhGiCrPq6y+P/iT3n8c+Hr/MGxR9D9WbpUJva8Moeq?=
 =?us-ascii?Q?MQY8asLns8LVG3l2u3Y0yBopzPX5BrerrHo593h8eD79gH5ubuk3oyjYKxgj?=
 =?us-ascii?Q?F3A37VyD3pPt2tm4cjnE8rQ2H2TYjr2LnK4RS6eXjIN11gBUPMda1wlQhiJO?=
 =?us-ascii?Q?eRYh+DqhkwgRD4JBNK0hxqDnyGHZ+gU4C7KNCNwhfEYT60rxJUZAYZEWAiNu?=
 =?us-ascii?Q?bUY8Y/+fuGzjGqDn+yk1ZR3CehO2GRTTU6gjFwmnFUTcNqiWUpYzeUHY+1Oy?=
 =?us-ascii?Q?c3Y6AvboUaJ9UvydwxKwYE=3D?=
X-Microsoft-Antispam-Message-Info: G9OHoPQnufqag0O9FgPPJVw9k0u7FHzWpKpgoZEt7zQxfZAAoej8lGDUVJeCvVQTbymZeDrTjzn5RaSbWqXak2lHI2vtDuoWfWgmsFixdp2IowFhM5sXgkys2p/rntMUjEZMfsVsKlU0/hVqoEEetvPEr1iyQHom73Uw9IWo7j8cP+OJPkwR+ztP4z3y7Eht
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 6:xtHfUZWh8htYa02X87auioD6GwMAS4cwrN6XXc+Aa8eVbIA2FcIkvB71LQ4g1HVlrkNw5a73SN6KoSfPm3DUeU0GLblBKsIgoOCikl1ykHvOsb5J7FAq9crSzybvMzxar96s20rXmhmSBqB+XddmNL7qsAOK+AU9ReA3QNZcwMHberQ8sdt0zXJIx+3N+B6HhNu5J/dBOcn5/GPsWuRqeRuAUIMkpT6V7mAXb6CbVrS+R2b2yQvmVBSLCjvzm67Yx/IR3hdtjxe0Wo2S72e5/eqtepOs1t8l3TeYMfKkWMkzCHpcWgQnkvo1LDS+D1zf0LPLfiA0jfMlLbEczQYWGme+035A9mBNkTiynwHJCIo=;
 5:JrIo88NuZuKmLpKc/LDIDo+fKkJGuN6l3Dz+73W+VV8RpvP70aqd2irU6md2KcpS1wMRcz9353bVtQxWmKF+CE9Q6b9cW78FOQnSLf6MdSoh4suSaUXU9uj9G72gWBVWNcBhbf/QSi+QnmYgDNOK6r7TyvrBMIBJNqzd3iuIK8c=;
 24:2mNnNUnUfUi9GQStdwEaGtEtKgPFj9w1sMETcOyBQW7nR2zyoXXZAzMmsJ6CoqSNcmiQGycfH2+/nl8FdG2kpOsYZznpsfx8DDT5NP6E66E=;
 7:BbG1eHP3hdCvnbGg2Zc/tRLUa8mwbAXsoL682p9nQjV009DvM5H2a9K06hEZXAZ7gSdDiN5gyyZAQiKX8HEkJC5NXOGYxKfTKd3Uh/fPOS1XVA3Rxyo9ejCKjFzFOJLi93KjKMXoL3gdSPnlc2IY/GK90vF2PXWIpp7eKs/2ZOl5WZJT4kel1uu8NAyo3FhZHeSbegVwOV50Bf2yYbI98YeUFaNEVmoUqIDj6JErBwINmmols/rPRc1AIyRilesD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 15:56:19.8409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d70e58-6d13-43e9-1761-08d589c4228f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR04MB0747
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

Introduce the DPAA2 Ethernet Switch driver, which manages Datapath Switch
(DPSW) objects discovered on the MC bus.

Suggested-by: Alexandru Marginean <alexandru.marginean@nxp.com>
Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
---
Changelog:
 v2:
    - fix PVID cleanup in ethsw_port_add_vlan()
    - rename err2 to ret in ethsw_port_add/del_vlan()
    - avoid duplicate code in ethsw_probe()
    - move destroy_workqueue to ethsw_takedown()
    - have a function for unregistering notifiers
    - above changes implement review comments for v1 from Bogdan P.
 v3:
    - no changes
 v4:
    - adjust to moving MC-bus out of staging
    - support adding/deleting multicast entries to/from FDB
    - selectively discard benign MC errors for calling add/delete fdb entries
      multiple times to avoid spamming console with stack traces
    - refactor setting TCI to avoid code duplication
    - clean probe code error path
 v5:
    - replace ethsw_irq0_handler() with NULL
    - do not allow adding ports of the same switch to multiple bridge devices
 v6:
    - use SPDX license identifier
    - fix indentation

 drivers/staging/fsl-dpaa2/ethsw/Makefile |    2 +-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c  | 1507 ++++++++++++++++++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h  |   65 ++
 3 files changed, 1573 insertions(+), 1 deletion(-)
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/ethsw.c
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/ethsw.h

diff --git a/drivers/staging/fsl-dpaa2/ethsw/Makefile b/drivers/staging/fsl-dpaa2/ethsw/Makefile
index 9846e61..7755603 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/Makefile
+++ b/drivers/staging/fsl-dpaa2/ethsw/Makefile
@@ -7,4 +7,4 @@
 
 obj-$(CONFIG_FSL_DPAA2_ETHSW) += dpaa2-ethsw.o
 
-dpaa2-ethsw-objs := dpsw.o
+dpaa2-ethsw-objs := ethsw.o dpsw.o
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
new file mode 100644
index 0000000..5aa6e95
--- /dev/null
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -0,0 +1,1507 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DPAA2 Ethernet Switch driver
+ *
+ * Copyright 2014-2016 Freescale Semiconductor Inc.
+ * Copyright 2017-2018 NXP
+ *
+ */
+
+#include <linux/module.h>
+
+#include <linux/interrupt.h>
+#include <linux/msi.h>
+#include <linux/kthread.h>
+#include <linux/workqueue.h>
+
+#include <linux/fsl/mc.h>
+
+#include "ethsw.h"
+
+static struct workqueue_struct *ethsw_owq;
+
+/* Minimal supported DPSW version */
+#define DPSW_MIN_VER_MAJOR		8
+#define DPSW_MIN_VER_MINOR		0
+
+#define DEFAULT_VLAN_ID			1
+
+static int ethsw_add_vlan(struct ethsw_core *ethsw, u16 vid)
+{
+	int err;
+
+	struct dpsw_vlan_cfg	vcfg = {
+		.fdb_id = 0,
+	};
+
+	if (ethsw->vlans[vid]) {
+		dev_err(ethsw->dev, "VLAN already configured\n");
+		return -EEXIST;
+	}
+
+	err = dpsw_vlan_add(ethsw->mc_io, 0,
+			    ethsw->dpsw_handle, vid, &vcfg);
+	if (err) {
+		dev_err(ethsw->dev, "dpsw_vlan_add err %d\n", err);
+		return err;
+	}
+	ethsw->vlans[vid] = ETHSW_VLAN_MEMBER;
+
+	return 0;
+}
+
+static int ethsw_port_set_tci(struct ethsw_port_priv *port_priv,
+			      struct dpsw_tci_cfg *tci_cfg)
+{
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct net_device *netdev = port_priv->netdev;
+	bool is_oper;
+	int err, ret;
+
+	/* Interface needs to be down to change PVID */
+	is_oper = netif_oper_up(netdev);
+	if (is_oper) {
+		err = dpsw_if_disable(ethsw->mc_io, 0,
+				      ethsw->dpsw_handle,
+				      port_priv->idx);
+		if (err) {
+			netdev_err(netdev, "dpsw_if_disable err %d\n", err);
+			return err;
+		}
+	}
+
+	err = dpsw_if_set_tci(ethsw->mc_io, 0, ethsw->dpsw_handle,
+			      port_priv->idx, tci_cfg);
+	if (err) {
+		netdev_err(netdev, "dpsw_if_set_tci err %d\n", err);
+		goto set_tci_error;
+	}
+
+	/* Delete previous PVID info and mark the new one */
+	if (port_priv->pvid)
+		port_priv->vlans[port_priv->pvid] &= ~ETHSW_VLAN_PVID;
+	port_priv->vlans[tci_cfg->vlan_id] |= ETHSW_VLAN_PVID;
+	port_priv->pvid = tci_cfg->vlan_id;
+
+set_tci_error:
+	if (is_oper) {
+		ret = dpsw_if_enable(ethsw->mc_io, 0,
+				     ethsw->dpsw_handle,
+				     port_priv->idx);
+		if (ret) {
+			netdev_err(netdev, "dpsw_if_enable err %d\n", ret);
+			return ret;
+		}
+	}
+
+	return err;
+}
+
+static int ethsw_port_add_vlan(struct ethsw_port_priv *port_priv,
+			       u16 vid, u16 flags)
+{
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct net_device *netdev = port_priv->netdev;
+	struct dpsw_vlan_if_cfg vcfg;
+	int err;
+
+	if (port_priv->vlans[vid]) {
+		netdev_warn(netdev, "VLAN %d already configured\n", vid);
+		return -EEXIST;
+	}
+
+	vcfg.num_ifs = 1;
+	vcfg.if_id[0] = port_priv->idx;
+	err = dpsw_vlan_add_if(ethsw->mc_io, 0, ethsw->dpsw_handle, vid, &vcfg);
+	if (err) {
+		netdev_err(netdev, "dpsw_vlan_add_if err %d\n", err);
+		return err;
+	}
+
+	port_priv->vlans[vid] = ETHSW_VLAN_MEMBER;
+
+	if (flags & BRIDGE_VLAN_INFO_UNTAGGED) {
+		err = dpsw_vlan_add_if_untagged(ethsw->mc_io, 0,
+						ethsw->dpsw_handle,
+						vid, &vcfg);
+		if (err) {
+			netdev_err(netdev,
+				   "dpsw_vlan_add_if_untagged err %d\n", err);
+			return err;
+		}
+		port_priv->vlans[vid] |= ETHSW_VLAN_UNTAGGED;
+	}
+
+	if (flags & BRIDGE_VLAN_INFO_PVID) {
+		struct dpsw_tci_cfg tci_cfg = {
+			.pcp = 0,
+			.dei = 0,
+			.vlan_id = vid,
+		};
+
+		err = ethsw_port_set_tci(port_priv, &tci_cfg);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int ethsw_set_learning(struct ethsw_core *ethsw, u8 flag)
+{
+	enum dpsw_fdb_learning_mode learn_mode;
+	int err;
+
+	if (flag)
+		learn_mode = DPSW_FDB_LEARNING_MODE_HW;
+	else
+		learn_mode = DPSW_FDB_LEARNING_MODE_DIS;
+
+	err = dpsw_fdb_set_learning_mode(ethsw->mc_io, 0, ethsw->dpsw_handle, 0,
+					 learn_mode);
+	if (err) {
+		dev_err(ethsw->dev, "dpsw_fdb_set_learning_mode err %d\n", err);
+		return err;
+	}
+	ethsw->learning = !!flag;
+
+	return 0;
+}
+
+static int ethsw_port_set_flood(struct ethsw_port_priv *port_priv, u8 flag)
+{
+	int err;
+
+	err = dpsw_if_set_flooding(port_priv->ethsw_data->mc_io, 0,
+				   port_priv->ethsw_data->dpsw_handle,
+				   port_priv->idx, flag);
+	if (err) {
+		netdev_err(port_priv->netdev,
+			   "dpsw_fdb_set_learning_mode err %d\n", err);
+		return err;
+	}
+	port_priv->flood = !!flag;
+
+	return 0;
+}
+
+static int ethsw_port_set_stp_state(struct ethsw_port_priv *port_priv, u8 state)
+{
+	struct dpsw_stp_cfg stp_cfg = {
+		.vlan_id = DEFAULT_VLAN_ID,
+		.state = state,
+	};
+	int err;
+
+	if (!netif_oper_up(port_priv->netdev) || state == port_priv->stp_state)
+		return 0;	/* Nothing to do */
+
+	err = dpsw_if_set_stp(port_priv->ethsw_data->mc_io, 0,
+			      port_priv->ethsw_data->dpsw_handle,
+			      port_priv->idx, &stp_cfg);
+	if (err) {
+		netdev_err(port_priv->netdev,
+			   "dpsw_if_set_stp err %d\n", err);
+		return err;
+	}
+
+	port_priv->stp_state = state;
+
+	return 0;
+}
+
+static int ethsw_dellink_switch(struct ethsw_core *ethsw, u16 vid)
+{
+	struct ethsw_port_priv *ppriv_local = NULL;
+	int i, err;
+
+	if (!ethsw->vlans[vid])
+		return -ENOENT;
+
+	err = dpsw_vlan_remove(ethsw->mc_io, 0, ethsw->dpsw_handle, vid);
+	if (err) {
+		dev_err(ethsw->dev, "dpsw_vlan_remove err %d\n", err);
+		return err;
+	}
+	ethsw->vlans[vid] = 0;
+
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+		ppriv_local = ethsw->ports[i];
+		ppriv_local->vlans[vid] = 0;
+	}
+
+	return 0;
+}
+
+static int ethsw_port_fdb_add_uc(struct ethsw_port_priv *port_priv,
+				 const unsigned char *addr)
+{
+	struct dpsw_fdb_unicast_cfg entry = {0};
+	int err;
+
+	entry.if_egress = port_priv->idx;
+	entry.type = DPSW_FDB_ENTRY_STATIC;
+	ether_addr_copy(entry.mac_addr, addr);
+
+	err = dpsw_fdb_add_unicast(port_priv->ethsw_data->mc_io, 0,
+				   port_priv->ethsw_data->dpsw_handle,
+				   0, &entry);
+	if (err)
+		netdev_err(port_priv->netdev,
+			   "dpsw_fdb_add_unicast err %d\n", err);
+	return err;
+}
+
+static int ethsw_port_fdb_del_uc(struct ethsw_port_priv *port_priv,
+				 const unsigned char *addr)
+{
+	struct dpsw_fdb_unicast_cfg entry = {0};
+	int err;
+
+	entry.if_egress = port_priv->idx;
+	entry.type = DPSW_FDB_ENTRY_STATIC;
+	ether_addr_copy(entry.mac_addr, addr);
+
+	err = dpsw_fdb_remove_unicast(port_priv->ethsw_data->mc_io, 0,
+				      port_priv->ethsw_data->dpsw_handle,
+				      0, &entry);
+	/* Silently discard error for calling multiple times the del command */
+	if (err && err != -ENXIO)
+		netdev_err(port_priv->netdev,
+			   "dpsw_fdb_remove_unicast err %d\n", err);
+	return err;
+}
+
+static int ethsw_port_fdb_add_mc(struct ethsw_port_priv *port_priv,
+				 const unsigned char *addr)
+{
+	struct dpsw_fdb_multicast_cfg entry = {0};
+	int err;
+
+	ether_addr_copy(entry.mac_addr, addr);
+	entry.type = DPSW_FDB_ENTRY_STATIC;
+	entry.num_ifs = 1;
+	entry.if_id[0] = port_priv->idx;
+
+	err = dpsw_fdb_add_multicast(port_priv->ethsw_data->mc_io, 0,
+				     port_priv->ethsw_data->dpsw_handle,
+				     0, &entry);
+	/* Silently discard error for calling multiple times the add command */
+	if (err && err != -ENXIO)
+		netdev_err(port_priv->netdev, "dpsw_fdb_add_multicast err %d\n",
+			   err);
+	return err;
+}
+
+static int ethsw_port_fdb_del_mc(struct ethsw_port_priv *port_priv,
+				 const unsigned char *addr)
+{
+	struct dpsw_fdb_multicast_cfg entry = {0};
+	int err;
+
+	ether_addr_copy(entry.mac_addr, addr);
+	entry.type = DPSW_FDB_ENTRY_STATIC;
+	entry.num_ifs = 1;
+	entry.if_id[0] = port_priv->idx;
+
+	err = dpsw_fdb_remove_multicast(port_priv->ethsw_data->mc_io, 0,
+					port_priv->ethsw_data->dpsw_handle,
+					0, &entry);
+	/* Silently discard error for calling multiple times the del command */
+	if (err && err != -ENAVAIL)
+		netdev_err(port_priv->netdev,
+			   "dpsw_fdb_remove_multicast err %d\n", err);
+	return err;
+}
+
+static void port_get_stats(struct net_device *netdev,
+			   struct rtnl_link_stats64 *stats)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	u64 tmp;
+	int err;
+
+	err = dpsw_if_get_counter(port_priv->ethsw_data->mc_io, 0,
+				  port_priv->ethsw_data->dpsw_handle,
+				  port_priv->idx,
+				  DPSW_CNT_ING_FRAME, &stats->rx_packets);
+	if (err)
+		goto error;
+
+	err = dpsw_if_get_counter(port_priv->ethsw_data->mc_io, 0,
+				  port_priv->ethsw_data->dpsw_handle,
+				  port_priv->idx,
+				  DPSW_CNT_EGR_FRAME, &stats->tx_packets);
+	if (err)
+		goto error;
+
+	err = dpsw_if_get_counter(port_priv->ethsw_data->mc_io, 0,
+				  port_priv->ethsw_data->dpsw_handle,
+				  port_priv->idx,
+				  DPSW_CNT_ING_BYTE, &stats->rx_bytes);
+	if (err)
+		goto error;
+
+	err = dpsw_if_get_counter(port_priv->ethsw_data->mc_io, 0,
+				  port_priv->ethsw_data->dpsw_handle,
+				  port_priv->idx,
+				  DPSW_CNT_EGR_BYTE, &stats->tx_bytes);
+	if (err)
+		goto error;
+
+	err = dpsw_if_get_counter(port_priv->ethsw_data->mc_io, 0,
+				  port_priv->ethsw_data->dpsw_handle,
+				  port_priv->idx,
+				  DPSW_CNT_ING_FRAME_DISCARD,
+				  &stats->rx_dropped);
+	if (err)
+		goto error;
+
+	err = dpsw_if_get_counter(port_priv->ethsw_data->mc_io, 0,
+				  port_priv->ethsw_data->dpsw_handle,
+				  port_priv->idx,
+				  DPSW_CNT_ING_FLTR_FRAME,
+				  &tmp);
+	if (err)
+		goto error;
+	stats->rx_dropped += tmp;
+
+	err = dpsw_if_get_counter(port_priv->ethsw_data->mc_io, 0,
+				  port_priv->ethsw_data->dpsw_handle,
+				  port_priv->idx,
+				  DPSW_CNT_EGR_FRAME_DISCARD,
+				  &stats->tx_dropped);
+	if (err)
+		goto error;
+
+	return;
+
+error:
+	netdev_err(netdev, "dpsw_if_get_counter err %d\n", err);
+}
+
+static bool port_has_offload_stats(const struct net_device *netdev,
+				   int attr_id)
+{
+	return (attr_id == IFLA_OFFLOAD_XSTATS_CPU_HIT);
+}
+
+static int port_get_offload_stats(int attr_id,
+				  const struct net_device *netdev,
+				  void *sp)
+{
+	switch (attr_id) {
+	case IFLA_OFFLOAD_XSTATS_CPU_HIT:
+		port_get_stats((struct net_device *)netdev, sp);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int port_change_mtu(struct net_device *netdev, int mtu)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	int err;
+
+	err = dpsw_if_set_max_frame_length(port_priv->ethsw_data->mc_io,
+					   0,
+					   port_priv->ethsw_data->dpsw_handle,
+					   port_priv->idx,
+					   (u16)ETHSW_L2_MAX_FRM(mtu));
+	if (err) {
+		netdev_err(netdev,
+			   "dpsw_if_set_max_frame_length() err %d\n", err);
+		return err;
+	}
+
+	netdev->mtu = mtu;
+	return 0;
+}
+
+static int port_carrier_state_sync(struct net_device *netdev)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct dpsw_link_state state;
+	int err;
+
+	err = dpsw_if_get_link_state(port_priv->ethsw_data->mc_io, 0,
+				     port_priv->ethsw_data->dpsw_handle,
+				     port_priv->idx, &state);
+	if (err) {
+		netdev_err(netdev, "dpsw_if_get_link_state() err %d\n", err);
+		return err;
+	}
+
+	WARN_ONCE(state.up > 1, "Garbage read into link_state");
+
+	if (state.up != port_priv->link_state) {
+		if (state.up)
+			netif_carrier_on(netdev);
+		else
+			netif_carrier_off(netdev);
+		port_priv->link_state = state.up;
+	}
+	return 0;
+}
+
+static int port_open(struct net_device *netdev)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	int err;
+
+	/* No need to allow Tx as control interface is disabled */
+	netif_tx_stop_all_queues(netdev);
+
+	err = dpsw_if_enable(port_priv->ethsw_data->mc_io, 0,
+			     port_priv->ethsw_data->dpsw_handle,
+			     port_priv->idx);
+	if (err) {
+		netdev_err(netdev, "dpsw_if_enable err %d\n", err);
+		return err;
+	}
+
+	/* sync carrier state */
+	err = port_carrier_state_sync(netdev);
+	if (err) {
+		netdev_err(netdev,
+			   "port_carrier_state_sync err %d\n", err);
+		goto err_carrier_sync;
+	}
+
+	return 0;
+
+err_carrier_sync:
+	dpsw_if_disable(port_priv->ethsw_data->mc_io, 0,
+			port_priv->ethsw_data->dpsw_handle,
+			port_priv->idx);
+	return err;
+}
+
+static int port_stop(struct net_device *netdev)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	int err;
+
+	err = dpsw_if_disable(port_priv->ethsw_data->mc_io, 0,
+			      port_priv->ethsw_data->dpsw_handle,
+			      port_priv->idx);
+	if (err) {
+		netdev_err(netdev, "dpsw_if_disable err %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static netdev_tx_t port_dropframe(struct sk_buff *skb,
+				  struct net_device *netdev)
+{
+	/* we don't support I/O for now, drop the frame */
+	dev_kfree_skb_any(skb);
+
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops ethsw_port_ops = {
+	.ndo_open		= port_open,
+	.ndo_stop		= port_stop,
+
+	.ndo_set_mac_address	= eth_mac_addr,
+	.ndo_change_mtu		= port_change_mtu,
+	.ndo_has_offload_stats	= port_has_offload_stats,
+	.ndo_get_offload_stats	= port_get_offload_stats,
+
+	.ndo_start_xmit		= port_dropframe,
+};
+
+static void ethsw_links_state_update(struct ethsw_core *ethsw)
+{
+	int i;
+
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++)
+		port_carrier_state_sync(ethsw->ports[i]->netdev);
+}
+
+static irqreturn_t ethsw_irq0_handler_thread(int irq_num, void *arg)
+{
+	struct device *dev = (struct device *)arg;
+	struct ethsw_core *ethsw = dev_get_drvdata(dev);
+
+	/* Mask the events and the if_id reserved bits to be cleared on read */
+	u32 status = DPSW_IRQ_EVENT_LINK_CHANGED | 0xFFFF0000;
+	int err;
+
+	err = dpsw_get_irq_status(ethsw->mc_io, 0, ethsw->dpsw_handle,
+				  DPSW_IRQ_INDEX_IF, &status);
+	if (err) {
+		dev_err(dev, "Can't get irq status (err %d)", err);
+
+		err = dpsw_clear_irq_status(ethsw->mc_io, 0, ethsw->dpsw_handle,
+					    DPSW_IRQ_INDEX_IF, 0xFFFFFFFF);
+		if (err)
+			dev_err(dev, "Can't clear irq status (err %d)", err);
+		goto out;
+	}
+
+	if (status & DPSW_IRQ_EVENT_LINK_CHANGED)
+		ethsw_links_state_update(ethsw);
+
+out:
+	return IRQ_HANDLED;
+}
+
+static int ethsw_setup_irqs(struct fsl_mc_device *sw_dev)
+{
+	struct device *dev = &sw_dev->dev;
+	struct ethsw_core *ethsw = dev_get_drvdata(dev);
+	u32 mask = DPSW_IRQ_EVENT_LINK_CHANGED;
+	struct fsl_mc_device_irq *irq;
+	int err;
+
+	err = fsl_mc_allocate_irqs(sw_dev);
+	if (err) {
+		dev_err(dev, "MC irqs allocation failed\n");
+		return err;
+	}
+
+	if (WARN_ON(sw_dev->obj_desc.irq_count != DPSW_IRQ_NUM)) {
+		err = -EINVAL;
+		goto free_irq;
+	}
+
+	err = dpsw_set_irq_enable(ethsw->mc_io, 0, ethsw->dpsw_handle,
+				  DPSW_IRQ_INDEX_IF, 0);
+	if (err) {
+		dev_err(dev, "dpsw_set_irq_enable err %d\n", err);
+		goto free_irq;
+	}
+
+	irq = sw_dev->irqs[DPSW_IRQ_INDEX_IF];
+
+	err = devm_request_threaded_irq(dev, irq->msi_desc->irq,
+					NULL,
+					ethsw_irq0_handler_thread,
+					IRQF_NO_SUSPEND | IRQF_ONESHOT,
+					dev_name(dev), dev);
+	if (err) {
+		dev_err(dev, "devm_request_threaded_irq(): %d", err);
+		goto free_irq;
+	}
+
+	err = dpsw_set_irq_mask(ethsw->mc_io, 0, ethsw->dpsw_handle,
+				DPSW_IRQ_INDEX_IF, mask);
+	if (err) {
+		dev_err(dev, "dpsw_set_irq_mask(): %d", err);
+		goto free_devm_irq;
+	}
+
+	err = dpsw_set_irq_enable(ethsw->mc_io, 0, ethsw->dpsw_handle,
+				  DPSW_IRQ_INDEX_IF, 1);
+	if (err) {
+		dev_err(dev, "dpsw_set_irq_enable(): %d", err);
+		goto free_devm_irq;
+	}
+
+	return 0;
+
+free_devm_irq:
+	devm_free_irq(dev, irq->msi_desc->irq, dev);
+free_irq:
+	fsl_mc_free_irqs(sw_dev);
+	return err;
+}
+
+static void ethsw_teardown_irqs(struct fsl_mc_device *sw_dev)
+{
+	struct device *dev = &sw_dev->dev;
+	struct ethsw_core *ethsw = dev_get_drvdata(dev);
+	struct fsl_mc_device_irq *irq;
+	int err;
+
+	irq = sw_dev->irqs[DPSW_IRQ_INDEX_IF];
+	err = dpsw_set_irq_enable(ethsw->mc_io, 0, ethsw->dpsw_handle,
+				  DPSW_IRQ_INDEX_IF, 0);
+	if (err)
+		dev_err(dev, "dpsw_set_irq_enable err %d\n", err);
+
+	fsl_mc_free_irqs(sw_dev);
+}
+
+static int swdev_port_attr_get(struct net_device *netdev,
+			       struct switchdev_attr *attr)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+
+	switch (attr->id) {
+	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
+		attr->u.ppid.id_len = 1;
+		attr->u.ppid.id[0] = port_priv->ethsw_data->dev_id;
+		break;
+	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
+		attr->u.brport_flags =
+			(port_priv->ethsw_data->learning ? BR_LEARNING : 0) |
+			(port_priv->flood ? BR_FLOOD : 0);
+		break;
+	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
+		attr->u.brport_flags_support = BR_LEARNING | BR_FLOOD;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int port_attr_stp_state_set(struct net_device *netdev,
+				   struct switchdev_trans *trans,
+				   u8 state)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+
+	if (switchdev_trans_ph_prepare(trans))
+		return 0;
+
+	return ethsw_port_set_stp_state(port_priv, state);
+}
+
+static int port_attr_br_flags_set(struct net_device *netdev,
+				  struct switchdev_trans *trans,
+				  unsigned long flags)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	int err = 0;
+
+	if (switchdev_trans_ph_prepare(trans))
+		return 0;
+
+	/* Learning is enabled per switch */
+	err = ethsw_set_learning(port_priv->ethsw_data, flags & BR_LEARNING);
+	if (err)
+		goto exit;
+
+	err = ethsw_port_set_flood(port_priv, flags & BR_FLOOD);
+
+exit:
+	return err;
+}
+
+static int swdev_port_attr_set(struct net_device *netdev,
+			       const struct switchdev_attr *attr,
+			       struct switchdev_trans *trans)
+{
+	int err = 0;
+
+	switch (attr->id) {
+	case SWITCHDEV_ATTR_ID_PORT_STP_STATE:
+		err = port_attr_stp_state_set(netdev, trans,
+					      attr->u.stp_state);
+		break;
+	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
+		err = port_attr_br_flags_set(netdev, trans,
+					     attr->u.brport_flags);
+		break;
+	case SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING:
+		/* VLANs are supported by default  */
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
+static int port_vlans_add(struct net_device *netdev,
+			  const struct switchdev_obj_port_vlan *vlan,
+			  struct switchdev_trans *trans)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	int vid, err;
+
+	if (switchdev_trans_ph_prepare(trans))
+		return 0;
+
+	for (vid = vlan->vid_begin; vid <= vlan->vid_end; vid++) {
+		if (!port_priv->ethsw_data->vlans[vid]) {
+			/* this is a new VLAN */
+			err = ethsw_add_vlan(port_priv->ethsw_data, vid);
+			if (err)
+				return err;
+
+			port_priv->ethsw_data->vlans[vid] |= ETHSW_VLAN_GLOBAL;
+		}
+		err = ethsw_port_add_vlan(port_priv, vid, vlan->flags);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
+static int port_lookup_address(struct net_device *netdev, int is_uc,
+			       const unsigned char *addr)
+{
+	struct netdev_hw_addr_list *list = (is_uc) ? &netdev->uc : &netdev->mc;
+	struct netdev_hw_addr *ha;
+
+	netif_addr_lock_bh(netdev);
+	list_for_each_entry(ha, &list->list, list) {
+		if (ether_addr_equal(ha->addr, addr)) {
+			netif_addr_unlock_bh(netdev);
+			return 1;
+		}
+	}
+	netif_addr_unlock_bh(netdev);
+	return 0;
+}
+
+static int port_mdb_add(struct net_device *netdev,
+			const struct switchdev_obj_port_mdb *mdb,
+			struct switchdev_trans *trans)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	int err;
+
+	if (switchdev_trans_ph_prepare(trans))
+		return 0;
+
+	/* Check if address is already set on this port */
+	if (port_lookup_address(netdev, 0, mdb->addr))
+		return -EEXIST;
+
+	err = ethsw_port_fdb_add_mc(port_priv, mdb->addr);
+	if (err)
+		return err;
+
+	err = dev_mc_add(netdev, mdb->addr);
+	if (err) {
+		netdev_err(netdev, "dev_mc_add err %d\n", err);
+		ethsw_port_fdb_del_mc(port_priv, mdb->addr);
+	}
+
+	return err;
+}
+
+static int swdev_port_obj_add(struct net_device *netdev,
+			      const struct switchdev_obj *obj,
+			      struct switchdev_trans *trans)
+{
+	int err;
+
+	switch (obj->id) {
+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
+		err = port_vlans_add(netdev,
+				     SWITCHDEV_OBJ_PORT_VLAN(obj),
+				     trans);
+		break;
+	case SWITCHDEV_OBJ_ID_PORT_MDB:
+		err = port_mdb_add(netdev,
+				   SWITCHDEV_OBJ_PORT_MDB(obj),
+				   trans);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
+static int ethsw_port_del_vlan(struct ethsw_port_priv *port_priv, u16 vid)
+{
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct net_device *netdev = port_priv->netdev;
+	struct dpsw_vlan_if_cfg vcfg;
+	int i, err;
+
+	if (!port_priv->vlans[vid])
+		return -ENOENT;
+
+	if (port_priv->vlans[vid] & ETHSW_VLAN_PVID) {
+		struct dpsw_tci_cfg tci_cfg = { 0 };
+
+		err = ethsw_port_set_tci(port_priv, &tci_cfg);
+		if (err)
+			return err;
+	}
+
+	vcfg.num_ifs = 1;
+	vcfg.if_id[0] = port_priv->idx;
+	if (port_priv->vlans[vid] & ETHSW_VLAN_UNTAGGED) {
+		err = dpsw_vlan_remove_if_untagged(ethsw->mc_io, 0,
+						   ethsw->dpsw_handle,
+						   vid, &vcfg);
+		if (err) {
+			netdev_err(netdev,
+				   "dpsw_vlan_remove_if_untagged err %d\n",
+				   err);
+		}
+		port_priv->vlans[vid] &= ~ETHSW_VLAN_UNTAGGED;
+	}
+
+	if (port_priv->vlans[vid] & ETHSW_VLAN_MEMBER) {
+		err = dpsw_vlan_remove_if(ethsw->mc_io, 0, ethsw->dpsw_handle,
+					  vid, &vcfg);
+		if (err) {
+			netdev_err(netdev,
+				   "dpsw_vlan_remove_if err %d\n", err);
+			return err;
+		}
+		port_priv->vlans[vid] &= ~ETHSW_VLAN_MEMBER;
+
+		/* Delete VLAN from switch if it is no longer configured on
+		 * any port
+		 */
+		for (i = 0; i < ethsw->sw_attr.num_ifs; i++)
+			if (ethsw->ports[i]->vlans[vid] & ETHSW_VLAN_MEMBER)
+				return 0; /* Found a port member in VID */
+
+		ethsw->vlans[vid] &= ~ETHSW_VLAN_GLOBAL;
+
+		err = ethsw_dellink_switch(ethsw, vid);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int port_vlans_del(struct net_device *netdev,
+			  const struct switchdev_obj_port_vlan *vlan)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	int vid, err;
+
+	for (vid = vlan->vid_begin; vid <= vlan->vid_end; vid++) {
+		err = ethsw_port_del_vlan(port_priv, vid);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
+static int port_mdb_del(struct net_device *netdev,
+			const struct switchdev_obj_port_mdb *mdb)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	int err;
+
+	if (!port_lookup_address(netdev, 0, mdb->addr))
+		return -ENOENT;
+
+	err = ethsw_port_fdb_del_mc(port_priv, mdb->addr);
+	if (err)
+		return err;
+
+	err = dev_mc_del(netdev, mdb->addr);
+	if (err) {
+		netdev_err(netdev, "dev_mc_del err %d\n", err);
+		return err;
+	}
+
+	return err;
+}
+
+static int swdev_port_obj_del(struct net_device *netdev,
+			      const struct switchdev_obj *obj)
+{
+	int err;
+
+	switch (obj->id) {
+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
+		err = port_vlans_del(netdev, SWITCHDEV_OBJ_PORT_VLAN(obj));
+		break;
+	case SWITCHDEV_OBJ_ID_PORT_MDB:
+		err = port_mdb_del(netdev, SWITCHDEV_OBJ_PORT_MDB(obj));
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+	return err;
+}
+
+static const struct switchdev_ops ethsw_port_switchdev_ops = {
+	.switchdev_port_attr_get	= swdev_port_attr_get,
+	.switchdev_port_attr_set	= swdev_port_attr_set,
+	.switchdev_port_obj_add		= swdev_port_obj_add,
+	.switchdev_port_obj_del		= swdev_port_obj_del,
+};
+
+/* For the moment, only flood setting needs to be updated */
+static int port_bridge_join(struct net_device *netdev,
+			    struct net_device *upper_dev)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	int i, err;
+
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++)
+		if (ethsw->ports[i]->bridge_dev &&
+		    (ethsw->ports[i]->bridge_dev != upper_dev)) {
+			netdev_err(netdev,
+				   "Another switch port is connected to %s\n",
+				   ethsw->ports[i]->bridge_dev->name);
+			return -EINVAL;
+		}
+
+	/* Enable flooding */
+	err = ethsw_port_set_flood(port_priv, 1);
+	if (!err)
+		port_priv->bridge_dev = upper_dev;
+
+	return err;
+}
+
+static int port_bridge_leave(struct net_device *netdev)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	int err;
+
+	/* Disable flooding */
+	err = ethsw_port_set_flood(port_priv, 0);
+	if (!err)
+		port_priv->bridge_dev = NULL;
+
+	return err;
+}
+
+static int port_netdevice_event(struct notifier_block *unused,
+				unsigned long event, void *ptr)
+{
+	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
+	struct netdev_notifier_changeupper_info *info = ptr;
+	struct net_device *upper_dev;
+	int err = 0;
+
+	if (netdev->netdev_ops != &ethsw_port_ops)
+		return NOTIFY_DONE;
+
+	/* Handle just upper dev link/unlink for the moment */
+	if (event == NETDEV_CHANGEUPPER) {
+		upper_dev = info->upper_dev;
+		if (netif_is_bridge_master(upper_dev)) {
+			if (info->linking)
+				err = port_bridge_join(netdev, upper_dev);
+			else
+				err = port_bridge_leave(netdev);
+		}
+	}
+
+	return notifier_from_errno(err);
+}
+
+static struct notifier_block port_nb __read_mostly = {
+	.notifier_call = port_netdevice_event,
+};
+
+struct ethsw_switchdev_event_work {
+	struct work_struct work;
+	struct switchdev_notifier_fdb_info fdb_info;
+	struct net_device *dev;
+	unsigned long event;
+};
+
+static void ethsw_switchdev_event_work(struct work_struct *work)
+{
+	struct ethsw_switchdev_event_work *switchdev_work =
+		container_of(work, struct ethsw_switchdev_event_work, work);
+	struct net_device *dev = switchdev_work->dev;
+	struct switchdev_notifier_fdb_info *fdb_info;
+	struct ethsw_port_priv *port_priv;
+
+	rtnl_lock();
+	port_priv = netdev_priv(dev);
+	fdb_info = &switchdev_work->fdb_info;
+
+	switch (switchdev_work->event) {
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+		if (is_unicast_ether_addr(fdb_info->addr))
+			ethsw_port_fdb_add_uc(netdev_priv(dev), fdb_info->addr);
+		else
+			ethsw_port_fdb_add_mc(netdev_priv(dev), fdb_info->addr);
+		break;
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+		if (is_unicast_ether_addr(fdb_info->addr))
+			ethsw_port_fdb_del_uc(netdev_priv(dev), fdb_info->addr);
+		else
+			ethsw_port_fdb_del_mc(netdev_priv(dev), fdb_info->addr);
+		break;
+	}
+
+	rtnl_unlock();
+	kfree(switchdev_work->fdb_info.addr);
+	kfree(switchdev_work);
+	dev_put(dev);
+}
+
+/* Called under rcu_read_lock() */
+static int port_switchdev_event(struct notifier_block *unused,
+				unsigned long event, void *ptr)
+{
+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
+	struct ethsw_switchdev_event_work *switchdev_work;
+	struct switchdev_notifier_fdb_info *fdb_info = ptr;
+
+	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
+	if (!switchdev_work)
+		return NOTIFY_BAD;
+
+	INIT_WORK(&switchdev_work->work, ethsw_switchdev_event_work);
+	switchdev_work->dev = dev;
+	switchdev_work->event = event;
+
+	switch (event) {
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+		memcpy(&switchdev_work->fdb_info, ptr,
+		       sizeof(switchdev_work->fdb_info));
+		switchdev_work->fdb_info.addr = kzalloc(ETH_ALEN, GFP_ATOMIC);
+		if (!switchdev_work->fdb_info.addr)
+			goto err_addr_alloc;
+
+		ether_addr_copy((u8 *)switchdev_work->fdb_info.addr,
+				fdb_info->addr);
+
+		/* Take a reference on the device to avoid being freed. */
+		dev_hold(dev);
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	queue_work(ethsw_owq, &switchdev_work->work);
+
+	return NOTIFY_DONE;
+
+err_addr_alloc:
+	kfree(switchdev_work);
+	return NOTIFY_BAD;
+}
+
+static struct notifier_block port_switchdev_nb = {
+	.notifier_call = port_switchdev_event,
+};
+
+static int ethsw_register_notifier(struct device *dev)
+{
+	int err;
+
+	err = register_netdevice_notifier(&port_nb);
+	if (err) {
+		dev_err(dev, "Failed to register netdev notifier\n");
+		return err;
+	}
+
+	err = register_switchdev_notifier(&port_switchdev_nb);
+	if (err) {
+		dev_err(dev, "Failed to register switchdev notifier\n");
+		goto err_switchdev_nb;
+	}
+
+	return 0;
+
+err_switchdev_nb:
+	unregister_netdevice_notifier(&port_nb);
+	return err;
+}
+
+static int ethsw_open(struct ethsw_core *ethsw)
+{
+	struct ethsw_port_priv *port_priv = NULL;
+	int i, err;
+
+	err = dpsw_enable(ethsw->mc_io, 0, ethsw->dpsw_handle);
+	if (err) {
+		dev_err(ethsw->dev, "dpsw_enable err %d\n", err);
+		return err;
+	}
+
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+		port_priv = ethsw->ports[i];
+		err = dev_open(port_priv->netdev);
+		if (err) {
+			netdev_err(port_priv->netdev, "dev_open err %d\n", err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int ethsw_stop(struct ethsw_core *ethsw)
+{
+	struct ethsw_port_priv *port_priv = NULL;
+	int i, err;
+
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+		port_priv = ethsw->ports[i];
+		dev_close(port_priv->netdev);
+	}
+
+	err = dpsw_disable(ethsw->mc_io, 0, ethsw->dpsw_handle);
+	if (err) {
+		dev_err(ethsw->dev, "dpsw_disable err %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int ethsw_init(struct fsl_mc_device *sw_dev)
+{
+	struct device *dev = &sw_dev->dev;
+	struct ethsw_core *ethsw = dev_get_drvdata(dev);
+	u16 version_major, version_minor, i;
+	struct dpsw_stp_cfg stp_cfg;
+	int err;
+
+	ethsw->dev_id = sw_dev->obj_desc.id;
+
+	err = dpsw_open(ethsw->mc_io, 0, ethsw->dev_id, &ethsw->dpsw_handle);
+	if (err) {
+		dev_err(dev, "dpsw_open err %d\n", err);
+		return err;
+	}
+
+	err = dpsw_get_attributes(ethsw->mc_io, 0, ethsw->dpsw_handle,
+				  &ethsw->sw_attr);
+	if (err) {
+		dev_err(dev, "dpsw_get_attributes err %d\n", err);
+		goto err_close;
+	}
+
+	err = dpsw_get_api_version(ethsw->mc_io, 0,
+				   &version_major,
+				   &version_minor);
+	if (err) {
+		dev_err(dev, "dpsw_get_api_version err %d\n", err);
+		goto err_close;
+	}
+
+	/* Minimum supported DPSW version check */
+	if (version_major < DPSW_MIN_VER_MAJOR ||
+	    (version_major == DPSW_MIN_VER_MAJOR &&
+	     version_minor < DPSW_MIN_VER_MINOR)) {
+		dev_err(dev, "DPSW version %d:%d not supported. Use %d.%d or greater.\n",
+			version_major,
+			version_minor,
+			DPSW_MIN_VER_MAJOR, DPSW_MIN_VER_MINOR);
+		err = -ENOTSUPP;
+		goto err_close;
+	}
+
+	err = dpsw_reset(ethsw->mc_io, 0, ethsw->dpsw_handle);
+	if (err) {
+		dev_err(dev, "dpsw_reset err %d\n", err);
+		goto err_close;
+	}
+
+	err = dpsw_fdb_set_learning_mode(ethsw->mc_io, 0, ethsw->dpsw_handle, 0,
+					 DPSW_FDB_LEARNING_MODE_HW);
+	if (err) {
+		dev_err(dev, "dpsw_fdb_set_learning_mode err %d\n", err);
+		goto err_close;
+	}
+
+	stp_cfg.vlan_id = DEFAULT_VLAN_ID;
+	stp_cfg.state = DPSW_STP_STATE_FORWARDING;
+
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+		err = dpsw_if_set_stp(ethsw->mc_io, 0, ethsw->dpsw_handle, i,
+				      &stp_cfg);
+		if (err) {
+			dev_err(dev, "dpsw_if_set_stp err %d for port %d\n",
+				err, i);
+			goto err_close;
+		}
+
+		err = dpsw_if_set_broadcast(ethsw->mc_io, 0,
+					    ethsw->dpsw_handle, i, 1);
+		if (err) {
+			dev_err(dev,
+				"dpsw_if_set_broadcast err %d for port %d\n",
+				err, i);
+			goto err_close;
+		}
+	}
+
+	ethsw_owq = alloc_ordered_workqueue("%s_ordered", WQ_MEM_RECLAIM,
+					    "ethsw");
+	if (!ethsw_owq) {
+		err = -ENOMEM;
+		goto err_close;
+	}
+
+	err = ethsw_register_notifier(dev);
+	if (err)
+		goto err_destroy_ordered_workqueue;
+
+	return 0;
+
+err_destroy_ordered_workqueue:
+	destroy_workqueue(ethsw_owq);
+
+err_close:
+	dpsw_close(ethsw->mc_io, 0, ethsw->dpsw_handle);
+	return err;
+}
+
+static int ethsw_port_init(struct ethsw_port_priv *port_priv, u16 port)
+{
+	const char def_mcast[ETH_ALEN] = {0x01, 0x00, 0x5e, 0x00, 0x00, 0x01};
+	struct net_device *netdev = port_priv->netdev;
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct dpsw_tci_cfg tci_cfg = {0};
+	struct dpsw_vlan_if_cfg vcfg;
+	int err;
+
+	/* Switch starts with all ports configured to VLAN 1. Need to
+	 * remove this setting to allow configuration at bridge join
+	 */
+	vcfg.num_ifs = 1;
+	vcfg.if_id[0] = port_priv->idx;
+
+	err = dpsw_vlan_remove_if_untagged(ethsw->mc_io, 0, ethsw->dpsw_handle,
+					   DEFAULT_VLAN_ID, &vcfg);
+	if (err) {
+		netdev_err(netdev, "dpsw_vlan_remove_if_untagged err %d\n",
+			   err);
+		return err;
+	}
+
+	err = ethsw_port_set_tci(port_priv, &tci_cfg);
+	if (err)
+		return err;
+
+	err = dpsw_vlan_remove_if(ethsw->mc_io, 0, ethsw->dpsw_handle,
+				  DEFAULT_VLAN_ID, &vcfg);
+	if (err) {
+		netdev_err(netdev, "dpsw_vlan_remove_if err %d\n", err);
+		return err;
+	}
+
+	err = ethsw_port_fdb_add_mc(port_priv, def_mcast);
+
+	return err;
+}
+
+static void ethsw_unregister_notifier(struct device *dev)
+{
+	int err;
+
+	err = unregister_switchdev_notifier(&port_switchdev_nb);
+	if (err)
+		dev_err(dev,
+			"Failed to unregister switchdev notifier (%d)\n", err);
+
+	err = unregister_netdevice_notifier(&port_nb);
+	if (err)
+		dev_err(dev,
+			"Failed to unregister netdev notifier (%d)\n", err);
+}
+
+static void ethsw_takedown(struct fsl_mc_device *sw_dev)
+{
+	struct device *dev = &sw_dev->dev;
+	struct ethsw_core *ethsw = dev_get_drvdata(dev);
+	int err;
+
+	ethsw_unregister_notifier(dev);
+
+	err = dpsw_close(ethsw->mc_io, 0, ethsw->dpsw_handle);
+	if (err)
+		dev_warn(dev, "dpsw_close err %d\n", err);
+}
+
+static int ethsw_remove(struct fsl_mc_device *sw_dev)
+{
+	struct ethsw_port_priv *port_priv;
+	struct ethsw_core *ethsw;
+	struct device *dev;
+	int i;
+
+	dev = &sw_dev->dev;
+	ethsw = dev_get_drvdata(dev);
+
+	ethsw_teardown_irqs(sw_dev);
+
+	destroy_workqueue(ethsw_owq);
+
+	rtnl_lock();
+	ethsw_stop(ethsw);
+	rtnl_unlock();
+
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+		port_priv = ethsw->ports[i];
+		unregister_netdev(port_priv->netdev);
+		free_netdev(port_priv->netdev);
+	}
+	kfree(ethsw->ports);
+
+	ethsw_takedown(sw_dev);
+	fsl_mc_portal_free(ethsw->mc_io);
+
+	kfree(ethsw);
+
+	dev_set_drvdata(dev, NULL);
+
+	return 0;
+}
+
+static int ethsw_probe_port(struct ethsw_core *ethsw, u16 port_idx)
+{
+	struct ethsw_port_priv *port_priv;
+	struct device *dev = ethsw->dev;
+	struct net_device *port_netdev;
+	int err;
+
+	port_netdev = alloc_etherdev(sizeof(struct ethsw_port_priv));
+	if (!port_netdev) {
+		dev_err(dev, "alloc_etherdev error\n");
+		return -ENOMEM;
+	}
+
+	port_priv = netdev_priv(port_netdev);
+	port_priv->netdev = port_netdev;
+	port_priv->ethsw_data = ethsw;
+
+	port_priv->idx = port_idx;
+	port_priv->stp_state = BR_STATE_FORWARDING;
+
+	/* Flooding is implicitly enabled */
+	port_priv->flood = true;
+
+	SET_NETDEV_DEV(port_netdev, dev);
+	port_netdev->netdev_ops = &ethsw_port_ops;
+	port_netdev->switchdev_ops = &ethsw_port_switchdev_ops;
+
+	/* Set MTU limits */
+	port_netdev->min_mtu = ETH_MIN_MTU;
+	port_netdev->max_mtu = ETHSW_MAX_FRAME_LENGTH;
+
+	err = register_netdev(port_netdev);
+	if (err < 0) {
+		dev_err(dev, "register_netdev error %d\n", err);
+		free_netdev(port_netdev);
+		return err;
+	}
+
+	ethsw->ports[port_idx] = port_priv;
+
+	return ethsw_port_init(port_priv, port_idx);
+}
+
+static int ethsw_probe(struct fsl_mc_device *sw_dev)
+{
+	struct device *dev = &sw_dev->dev;
+	struct ethsw_core *ethsw;
+	int i, err;
+
+	/* Allocate switch core*/
+	ethsw = kzalloc(sizeof(*ethsw), GFP_KERNEL);
+
+	if (!ethsw)
+		return -ENOMEM;
+
+	ethsw->dev = dev;
+	dev_set_drvdata(dev, ethsw);
+
+	err = fsl_mc_portal_allocate(sw_dev, 0, &ethsw->mc_io);
+	if (err) {
+		if (err == -ENXIO)
+			err = -EPROBE_DEFER;
+		else
+			dev_err(dev, "fsl_mc_portal_allocate err %d\n", err);
+		goto err_free_drvdata;
+	}
+
+	err = ethsw_init(sw_dev);
+	if (err)
+		goto err_free_cmdport;
+
+	/* DEFAULT_VLAN_ID is implicitly configured on the switch */
+	ethsw->vlans[DEFAULT_VLAN_ID] = ETHSW_VLAN_MEMBER;
+
+	/* Learning is implicitly enabled */
+	ethsw->learning = true;
+
+	ethsw->ports = kcalloc(ethsw->sw_attr.num_ifs, sizeof(*ethsw->ports),
+			       GFP_KERNEL);
+	if (!(ethsw->ports)) {
+		err = -ENOMEM;
+		goto err_takedown;
+	}
+
+	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
+		err = ethsw_probe_port(ethsw, i);
+		if (err)
+			goto err_free_ports;
+	}
+
+	/* Switch starts up enabled */
+	rtnl_lock();
+	err = ethsw_open(ethsw);
+	rtnl_unlock();
+	if (err)
+		goto err_free_ports;
+
+	/* Setup IRQs */
+	err = ethsw_setup_irqs(sw_dev);
+	if (err)
+		goto err_stop;
+
+	dev_info(dev, "probed %d port switch\n", ethsw->sw_attr.num_ifs);
+	return 0;
+
+err_stop:
+	rtnl_lock();
+	ethsw_stop(ethsw);
+	rtnl_unlock();
+
+err_free_ports:
+	/* Cleanup registered ports only */
+	for (i--; i >= 0; i--) {
+		unregister_netdev(ethsw->ports[i]->netdev);
+		free_netdev(ethsw->ports[i]->netdev);
+	}
+	kfree(ethsw->ports);
+
+err_takedown:
+	ethsw_takedown(sw_dev);
+
+err_free_cmdport:
+	fsl_mc_portal_free(ethsw->mc_io);
+
+err_free_drvdata:
+	kfree(ethsw);
+	dev_set_drvdata(dev, NULL);
+
+	return err;
+}
+
+static const struct fsl_mc_device_id ethsw_match_id_table[] = {
+	{
+		.vendor = FSL_MC_VENDOR_FREESCALE,
+		.obj_type = "dpsw",
+	},
+	{ .vendor = 0x0 }
+};
+MODULE_DEVICE_TABLE(fslmc, ethsw_match_id_table);
+
+static struct fsl_mc_driver eth_sw_drv = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.owner = THIS_MODULE,
+	},
+	.probe = ethsw_probe,
+	.remove = ethsw_remove,
+	.match_id_table = ethsw_match_id_table
+};
+
+module_fsl_mc_driver(eth_sw_drv);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("DPAA2 Ethernet Switch Driver");
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
new file mode 100644
index 0000000..da607b4
--- /dev/null
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DPAA2 Ethernet Switch declarations
+ *
+ * Copyright 2014-2016 Freescale Semiconductor Inc.
+ * Copyright 2017-2018 NXP
+ *
+ */
+
+#ifndef __ETHSW_H
+#define __ETHSW_H
+
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/rtnetlink.h>
+#include <linux/if_vlan.h>
+#include <uapi/linux/if_bridge.h>
+#include <net/switchdev.h>
+#include <linux/if_bridge.h>
+
+#include "dpsw.h"
+
+/* Number of IRQs supported */
+#define DPSW_IRQ_NUM	2
+
+#define ETHSW_VLAN_MEMBER	1
+#define ETHSW_VLAN_UNTAGGED	2
+#define ETHSW_VLAN_PVID		4
+#define ETHSW_VLAN_GLOBAL	8
+
+/* Maximum Frame Length supported by HW (currently 10k) */
+#define DPAA2_MFL		(10 * 1024)
+#define ETHSW_MAX_FRAME_LENGTH	(DPAA2_MFL - VLAN_ETH_HLEN - ETH_FCS_LEN)
+#define ETHSW_L2_MAX_FRM(mtu)	((mtu) + VLAN_ETH_HLEN + ETH_FCS_LEN)
+
+struct ethsw_core;
+
+/* Per port private data */
+struct ethsw_port_priv {
+	struct net_device	*netdev;
+	u16			idx;
+	struct ethsw_core	*ethsw_data;
+	u8			link_state;
+	u8			stp_state;
+	bool			flood;
+
+	u8			vlans[VLAN_VID_MASK + 1];
+	u16			pvid;
+	struct net_device	*bridge_dev;
+};
+
+/* Switch data */
+struct ethsw_core {
+	struct device			*dev;
+	struct fsl_mc_io		*mc_io;
+	u16				dpsw_handle;
+	struct dpsw_attr		sw_attr;
+	int				dev_id;
+	struct ethsw_port_priv		**ports;
+
+	u8				vlans[VLAN_VID_MASK + 1];
+	bool				learning;
+};
+
+#endif	/* __ETHSW_H */
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
