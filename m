Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3262519-1520949171-2-11976694400513845750
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520949168; b=QWi4H/bIJLrdkU2+45bHFuXQvdVr3Xa8zeacru4K42u/l79
    jj1pehcWtUItOAaiMEXfXPpP9WXjJ8X4upOcex0aCSpCvhGBAu5MpIz3YcoP0Lzk
    SxDogVaxT9HOrmsHOmm5EmthyQYVGFDBklPUX9fFW59sCjtrqFK2XcAIOrkX/niX
    TeJ0KJ0NkZQjlXdbRCvHnl/Gar+dMSSYQHTKM0oyI3+XAihHbd0dvrBg0VwUP9T3
    PRQZE80mIkGe0ruOLUPVokzVS40U6cTfbAvYoNMIOtTDHaJz+mq1c9WPC2xIzrk7
    gO5Qsz+aHemXpy7g8aeu6uo1/aVSd5q0QPS5zPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520949168; bh=D
    +g0F+lCsO964RZ+/hBzq92NnTCYakEeWWSKGFh7Vc8=; b=iynfxxbd8b2xFod+k
    mqtxUzRjMVwaqIYv4tB8rnm+urdbqlgpQpTD3lbDoaw/fsEUhy5UwEAr/Tp0QI8W
    gmcY1UxSpLrJ12pxxLWUjLwkazWOB2euse956KYNhUFL1HlfTlEpw1qklJgIwfmb
    N5FtMkmK/9fA8w1qe5ZZiom1jQsqMSMSA5XmevEoywX5NWLY1QMh2N3/ywNXICMo
    UvT7132Bfc4TOFgAm8Uqk1+wB5ZG5QY6JX8TVFwUju1A+T6njaxrdL3f79iVyGF9
    mg6irLR86iNMTyXbePhsJD+AFvPcSDBkjbX/SSqTqSr1N3JDLFbLX9bTCiEoAsqu
    L4GzA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=KwDAc7fG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=KwDAc7fG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
Subject: [PATCH v5 1/6] staging: fsl-dpaa2/ethsw: Add APIs for DPSW object
Date: Tue, 13 Mar 2018 08:51:51 -0500
Message-Id: <20180313135156.3322-2-razvan.stefanescu@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180313135156.3322-1-razvan.stefanescu@nxp.com>
References: <20180313135156.3322-1-razvan.stefanescu@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: DM3PR12CA0069.namprd12.prod.outlook.com
 (2603:10b6:0:57::13) To DB3PR04MB0747.eurprd04.prod.outlook.com
 (2a01:111:e400:9440::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a6da94fe-0c91-41a0-9fe7-08d588e99ed7
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR04MB0747;
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 3:vecz0wQkU/Kx+4w5vQq/Sz6fAXWcylVBD19jT5N8IayfPlwULWcGe1bzXk5S0SfZ/45J4ktC4SvrrVOyZ+g7pX7JCTRYBKOW1WGqfuS5y3GB2BWo8Mowkpc+2dgQj0J8YieYDu7O/VjnCV7HUpAvjsSxwEUKDf5YHSMIFwNw+gGSyss/RupvDrsMv6L+m558FWjQInARbhTjClorzeGpbRAtUYWquzbzLWUllIFJ3l5fAK7YsWUazPV1fJ6hJTCf;
 25:pwn3mKf5mPg6+qBELn960CoPsKeRXr5LOtnUHDETILlOMunivaxBcEWqNi/KXWktdgPd8NtTuzuvJEFIZTkCHaEmQ9O+iXeC55Ywbiy1nOHLgjzZ2NK8WG27kTBXzdTxJcTpF3NHZAaELVSOLaGJ1JnB3Lz8lEScQ/nLZlQ22zoKIPUS4Si2X0Z9cLqoAbpbPe2BbsN/92tSWZVb1Nd/q61t0RaCjBP2HvkyQegjBPe6zfMXrIxA62mnslPUnUWkacdqSDc5hkDK3Gh4lEzQQaAbbJ+gqpCecdTVMnZPFJldoqJyLn9vVQhm3LjigtFS/Hyk6kgf+PzGNki1twCCSA==;
 31:FnRhBCs0Hf3RRxml8V6tx4ywNmxuclLBehf7lR5fotwSC+vAgfEHld5xtEEmi7uO7+gKNwGVxXCl6miXawYEOL8ryCMlbMdG24awdHmzUqWXsfnEsjTGjB4Na82BcsTa1f/YPe5T2cuU1vwSGdUSRqtbnxzALhmnzb9s3g8wAjsLjlmFV07Y2QA1MB9GI6Rss4FeaWmR0s7yOAyEZ1QA9MJM9eElIRFJdJkQUh/wL+A=
X-MS-TrafficTypeDiagnostic: DB3PR04MB0747:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 20:j1ksK+BQTEKBkNBKhX29t5kE7sILFOLZ8za1L4WH3StSjQGC8px1J/uIFhyYGHhcFY+ekz2CDPNCKPlAXUQwAIpsvVYpZmOR8/kEb42vmAa/pognOfpT6mME8IZFhJnvRJBEaVcLz15NRuRSZRq/Vt5297qlhDp8+oOWjPnJRg7d/fqRJBlxl17OWli+eTIBoUQ4b8hzVffo4pfbsNdI5hiNih8JJMhrIIYGW4oHYuVzShDLCAfxqVFu0BCLVZeo2R30XXJRPvkHXjUC+m/aHHyNigXT3L1uZVt4aywOCnNEWPvRE1XdFAgiqz3/8HgFQLegg7K7zadRMnoErTAh4WLMsjOvNke0hoiVJN/rdbj74VfnhC5Xn/3C1s/5yhgowQYvoJ39HLFWLU1Zocz+F0d1muFzGItJIZJ9B70o9dOOuJoZhCWqvvgnnmBjXQd5xJSpNOvsD/XnSEhrZ0eE5E3eHDv/6qdfbx2lWfabQ6y5oWt/71ARWQmqiQfF2h8p;
 4:nL2WDM/HaPbvAoA74EMTcbaqifQnu60xpfnX/aXY8mjlUj4XjXED5k+T9hSABwQUcnBGzhzNiCaazqoD17nJEWgZIbXC2UkxsmXS8CWhi1QazvZL3NIIsUqin1ZfI5t8dEBmqJFES6LGrxNvGz1YU1cCjP1EI4v96x9GOBJL9K+pQNKhGaU6OLYP6vwtkp7Rg7thE/WdouF0u1aoJeAnVPS3yhJ3hBFEq0kkVRI9KjcmpI7OQm4ybJWWLq7haizSPrbCpyjNzqBU0XOdWCRTWg/AfX5CDHT1bw8jkHUhS5zM8N0qpx1IjkdgML0x9wFyBkZvdfom8kOsBcUASbpQtQGKBPFBR7cwUmN1/touWd4=
X-Microsoft-Antispam-PRVS: <DB3PR04MB074746A50385A12809138102E6D20@DB3PR04MB0747.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501244)(52105095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);
 SRVR:DB3PR04MB0747; BCL:0; PCL:0; RULEID:; SRVR:DB3PR04MB0747;
X-Forefront-PRVS: 0610D16BBE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(376002)(39380400002)(366004)(39860400002)(346002)(396003)(54534003)(189003)(45074003)(199004)(1076002)(16526019)(186003)(6916009)(5660300001)(478600001)(50466002)(48376002)(3846002)(6116002)(8676002)(47776003)(6666003)(26005)(2906002)(7736002)(81156014)(2950100002)(66066001)(81166006)(6506007)(59450400001)(305945005)(76176011)(386003)(25786009)(50226002)(52116002)(86362001)(8936002)(316002)(16586007)(39060400002)(36756003)(53946003)(51416003)(106356001)(68736007)(6486002)(16200700003)(53936002)(2351001)(2361001)(4326008)(6512007)(97736004)(105586002)(2004002)(579004)(569006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR04MB0747; H:rhuath.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; MX:1; A:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DB3PR04MB0747;
 23:e8J4+iw6ODYZV2eIb+rH4H1mkjoDS8zSKeiybFbGh?=
 =?us-ascii?Q?QFZcHqjKFeYtHTJXsRyFOvT0nUva9Y7Gc8nuoWfN0CIz0s3Ab7Mm7ocN4c34?=
 =?us-ascii?Q?7/rvIYvVaVFLrUj1XMhvdS3T8Fh3YqwPur+BYFb9A2zV+LwTHdZNLkZSeyUi?=
 =?us-ascii?Q?uoBmrpJMTOIJ+5xvsTuI4FIzlOR73qubjjT8QWNQ+Cs2RE+Jcx/NpEVLE0vY?=
 =?us-ascii?Q?3t0vha3+SqlXL/+Y4YYwiK/3uzzKl1tG9rpSZwVS6WehGGXDJeWJYQhWIv3n?=
 =?us-ascii?Q?WDrnpYloIt2ZCQH9VH/ljdiDN3xyytQUSl0HRdNfOzt2xSYL2yqUf1LHxSSE?=
 =?us-ascii?Q?au2lUChGdF21bonfVvQz/eY50bsJS4Wtf5XoXojfcXRmLGAWaWsfLbZm4CPy?=
 =?us-ascii?Q?rgezD8V0PbesabJUksOjEkKlpBmXeZsq55NuiHDNYxf1ptNwtPk9wK1SbSf6?=
 =?us-ascii?Q?dIjMA6gb245aAg37OF0mD0RrT34oV+0J8lhb2V8A6qMzQkjV6r5lDdx36JC3?=
 =?us-ascii?Q?tODpOupJJ5FMC+dtQmBtB2stZUaki86mvrwtdJ2czYNsfsDkBPtg372MILZr?=
 =?us-ascii?Q?0RWA6nFfAD6NENN7qOvj5PW4U/CdBTA4kgeeTGMDGjz7tLOyn9pkaKwS/n9V?=
 =?us-ascii?Q?nwOjv9mCx40YwXdkieo/+9JO8aO9R0BEcxdEJbsrPavte8YFi3x0blf1+z/b?=
 =?us-ascii?Q?xqcVGh/xDFcTnu51sqKy+M4y9eEDQVFV/4RlsgXy9yJ+xvRzBmfCUYMLF1C7?=
 =?us-ascii?Q?ba5E9KMuJjWYyQtD8kP0ONgO52PmAJlm4cMJLIBF884i1wdzfRCECXlbbo/r?=
 =?us-ascii?Q?fiSrUyJYQL+rqarZoi7QnghLwtWQneAyS9aS6l73UJQkVvv+BI5TMCe/k/X8?=
 =?us-ascii?Q?xyOnY+AnuZrQQWhnYeyVjoVroJkk51Em+W5vfRrkWa3kCCvP6ozDsvh0Bedc?=
 =?us-ascii?Q?+Oz8ep0FCBEEQ+eS3NH2B6KuYxWKeLaF2RSesPIt3fHvz4DuHnvw3qck4EeJ?=
 =?us-ascii?Q?z8K2AZtzWRRL3PruTUqq4pyWN9MmIO3MCJ5fS+u4L6uFdg3fZ41qU1gl1e/U?=
 =?us-ascii?Q?Aqg0hz6oPjP/V5XJPc6IXHfZeAk7XlTQWyfVcAX0nQjFFLHI2sykYi6bZGjO?=
 =?us-ascii?Q?QoHXwOQm7Ch6BJ8a/8kj7pVpBTnpZsamygfiV85HyjbOj+/V8K7NhL1WuKi6?=
 =?us-ascii?Q?ilKpjwEprTpvB/Fid+8LnFJJzisu9/ynqxYqvwzfOTdNlPJm40bBVMhT7ZnX?=
 =?us-ascii?Q?K6Jt7SKsyCFB6+dQuApoQP1yFqh7uj0Etj2S1Y/sC99E3JR+HsfSNndIcuT1?=
 =?us-ascii?Q?aWtMPv+0Mnr9FMltrRoCZhkW8zaMxh9XfVlH2XXwYrwTVXkw2WoUUCZiYh1L?=
 =?us-ascii?Q?RW7fA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 5lfuc5EqsYsYG1bVVvfVQ3Z8qqRCH9TrqETAIfXCO59RZlzes5xnFc20xZI6JZCaji+Ch+cJSUSf7+27sSJLRVOQOSp90WfvU3PSydKO/ihzkUpEKqRwmsIcbmn4/MDZ/GM/xyl7Ni123VX0QXzirsEJlQa3Pbf0AdyDILkIhXk2178t1JQ1x2PnAqpWJm5b
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 6:To1m7+Li3yC/3RdoUJeu9FP2m+6assEZE7p3D5EvIOfElzXBVLcf6UiS9YyIGxL0Zt8uqLQWIVSej2FYx/pxDITzcwOiG3W+aoUEckI8h5X1RJIyCa2nT7ME+IenkUy0gzesnAbobIhlUXDdAoiFJIaraXBOuoP0J7OpbpKQZG0bGuXQHeDHLLDiagERga9zrPaSfxcv8pRV3/c7LAxjp0fUokk9r+c9TP1bYzOwD+cEbvSKuFBt/TPASwM5k0IFAxvKrR/qvRfYGbvwfjhBbB9RT7IPHjIsyM2xvhSpE2YDwOwWeZAcxvIjotItGURWNLCk84d8EpZap7ubSb6pNk9V4wCtSEMDJt+Kouv4bgk=;
 5:4naO5dUCID+1r7me3sYem6Gt+LoJ/F8lHmDe8vkw8xoAVut4S/lkn7iiXz08meSMW2HzyGWaW67Qfmp5o4UGzYG3RO7F4zuvdKmUEpprAKcrExlpMGCd6SHYXtZdOKKOC3PNqxaMieEPIYmxWN0AnCMvwr4FP7o7uJ3bjpuAGK0=;
 24:IoYIUqJzuCD0xUV0jrS2YgSKrsL6/Gf5yIvpp4lDWvDxDRvWbV1QkOJbEqzqbO7eF6LkdH8pNKfBd/DLS5TAPIlER2xNsvBQmewGSUKEdyA=;
 7:U/+ik7/NG4Af39XY9C04CrUAQH+VL/49LVRd55TbD+jfFmQ9Go2sk2JQQ+myXgBqsv/jAbxQzRV87PvzL+B0K3LAK+BtMgNTjJLMhQkz7ogyxx5AndaACrCtg2M2FBuLRsls90cDyOpdAzXeYbCFHlS1LXNz8+hH2EMx4woCw49c258YNthQOeWy9SoaKFw3a+DmtVlIoJGwVPLcZuSH//6MxOiAkKrvI7fo7cKIbiTjmQDX0oqdraSgNtD0AV4I
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2018 13:52:09.6481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6da94fe-0c91-41a0-9fe7-08d588e99ed7
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

Add the command build/parse APIs for operating on DPSW objects through
the DPAA2 Management Complex.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
---
Changelog:
 v2:
    - use u8 for en parameter of dpsw_if_set_flooding/broadcast()
 v3:
    - no changes
 v4:
    - adjust to moving MC-bus out of staging
    - fix sparse warnings
 v5:
   - no changes

 drivers/staging/fsl-dpaa2/Kconfig          |    8 +
 drivers/staging/fsl-dpaa2/Makefile         |    1 +
 drivers/staging/fsl-dpaa2/ethsw/Makefile   |    7 +
 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h |  358 +++++++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.c     | 1116 ++++++++++++++++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h     |  579 +++++++++++++++
 6 files changed, 2069 insertions(+)
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/Makefile
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/dpsw.c
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/dpsw.h

diff --git a/drivers/staging/fsl-dpaa2/Kconfig b/drivers/staging/fsl-dpaa2/Kconfig
index dfff675..8a508ef 100644
--- a/drivers/staging/fsl-dpaa2/Kconfig
+++ b/drivers/staging/fsl-dpaa2/Kconfig
@@ -16,3 +16,11 @@ config FSL_DPAA2_ETH
 	---help---
 	  Ethernet driver for Freescale DPAA2 SoCs, using the
 	  Freescale MC bus driver
+
+config FSL_DPAA2_ETHSW
+	tristate "Freescale DPAA2 Ethernet Switch"
+	depends on FSL_DPAA2
+	depends on NET_SWITCHDEV
+	---help---
+	Driver for Freescale DPAA2 Ethernet Switch. Select
+	BRIDGE to have support for bridge tools.
diff --git a/drivers/staging/fsl-dpaa2/Makefile b/drivers/staging/fsl-dpaa2/Makefile
index 0836ba8..6cfd76b 100644
--- a/drivers/staging/fsl-dpaa2/Makefile
+++ b/drivers/staging/fsl-dpaa2/Makefile
@@ -3,3 +3,4 @@
 #
 
 obj-$(CONFIG_FSL_DPAA2_ETH)	+= ethernet/
+obj-$(CONFIG_FSL_DPAA2_ETHSW)	+= ethsw/
diff --git a/drivers/staging/fsl-dpaa2/ethsw/Makefile b/drivers/staging/fsl-dpaa2/ethsw/Makefile
new file mode 100644
index 0000000..db137f7
--- /dev/null
+++ b/drivers/staging/fsl-dpaa2/ethsw/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for the Freescale DPAA2 Ethernet Switch
+#
+
+obj-$(CONFIG_FSL_DPAA2_ETHSW) += dpaa2-ethsw.o
+
+dpaa2-ethsw-objs := dpsw.o
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
new file mode 100644
index 0000000..36edef6
--- /dev/null
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
@@ -0,0 +1,358 @@
+/* Copyright 2013-2016 Freescale Semiconductor Inc.
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
+#ifndef __FSL_DPSW_CMD_H
+#define __FSL_DPSW_CMD_H
+
+/* DPSW Version */
+#define DPSW_VER_MAJOR		8
+#define DPSW_VER_MINOR		0
+
+#define DPSW_CMD_BASE_VERSION	1
+#define DPSW_CMD_ID_OFFSET	4
+
+#define DPSW_CMD_ID(id)	(((id) << DPSW_CMD_ID_OFFSET) | DPSW_CMD_BASE_VERSION)
+
+/* Command IDs */
+#define DPSW_CMDID_CLOSE                    DPSW_CMD_ID(0x800)
+#define DPSW_CMDID_OPEN                     DPSW_CMD_ID(0x802)
+
+#define DPSW_CMDID_GET_API_VERSION          DPSW_CMD_ID(0xa02)
+
+#define DPSW_CMDID_ENABLE                   DPSW_CMD_ID(0x002)
+#define DPSW_CMDID_DISABLE                  DPSW_CMD_ID(0x003)
+#define DPSW_CMDID_GET_ATTR                 DPSW_CMD_ID(0x004)
+#define DPSW_CMDID_RESET                    DPSW_CMD_ID(0x005)
+
+#define DPSW_CMDID_SET_IRQ_ENABLE           DPSW_CMD_ID(0x012)
+
+#define DPSW_CMDID_SET_IRQ_MASK             DPSW_CMD_ID(0x014)
+
+#define DPSW_CMDID_GET_IRQ_STATUS           DPSW_CMD_ID(0x016)
+#define DPSW_CMDID_CLEAR_IRQ_STATUS         DPSW_CMD_ID(0x017)
+
+#define DPSW_CMDID_IF_SET_TCI               DPSW_CMD_ID(0x030)
+#define DPSW_CMDID_IF_SET_STP               DPSW_CMD_ID(0x031)
+
+#define DPSW_CMDID_IF_GET_COUNTER           DPSW_CMD_ID(0x034)
+
+#define DPSW_CMDID_IF_ENABLE                DPSW_CMD_ID(0x03D)
+#define DPSW_CMDID_IF_DISABLE               DPSW_CMD_ID(0x03E)
+
+#define DPSW_CMDID_IF_SET_MAX_FRAME_LENGTH  DPSW_CMD_ID(0x044)
+
+#define DPSW_CMDID_IF_GET_LINK_STATE        DPSW_CMD_ID(0x046)
+#define DPSW_CMDID_IF_SET_FLOODING          DPSW_CMD_ID(0x047)
+#define DPSW_CMDID_IF_SET_BROADCAST         DPSW_CMD_ID(0x048)
+
+#define DPSW_CMDID_VLAN_ADD                 DPSW_CMD_ID(0x060)
+#define DPSW_CMDID_VLAN_ADD_IF              DPSW_CMD_ID(0x061)
+#define DPSW_CMDID_VLAN_ADD_IF_UNTAGGED     DPSW_CMD_ID(0x062)
+
+#define DPSW_CMDID_VLAN_REMOVE_IF           DPSW_CMD_ID(0x064)
+#define DPSW_CMDID_VLAN_REMOVE_IF_UNTAGGED  DPSW_CMD_ID(0x065)
+#define DPSW_CMDID_VLAN_REMOVE_IF_FLOODING  DPSW_CMD_ID(0x066)
+#define DPSW_CMDID_VLAN_REMOVE              DPSW_CMD_ID(0x067)
+
+#define DPSW_CMDID_FDB_ADD_UNICAST          DPSW_CMD_ID(0x084)
+#define DPSW_CMDID_FDB_REMOVE_UNICAST       DPSW_CMD_ID(0x085)
+#define DPSW_CMDID_FDB_ADD_MULTICAST        DPSW_CMD_ID(0x086)
+#define DPSW_CMDID_FDB_REMOVE_MULTICAST     DPSW_CMD_ID(0x087)
+#define DPSW_CMDID_FDB_SET_LEARNING_MODE    DPSW_CMD_ID(0x088)
+
+/* Macros for accessing command fields smaller than 1byte */
+#define DPSW_MASK(field)        \
+	GENMASK(DPSW_##field##_SHIFT + DPSW_##field##_SIZE - 1, \
+		DPSW_##field##_SHIFT)
+#define dpsw_set_field(var, field, val) \
+	((var) |= (((val) << DPSW_##field##_SHIFT) & DPSW_MASK(field)))
+#define dpsw_get_field(var, field)      \
+	(((var) & DPSW_MASK(field)) >> DPSW_##field##_SHIFT)
+#define dpsw_get_bit(var, bit) \
+	(((var)  >> (bit)) & GENMASK(0, 0))
+
+struct dpsw_cmd_open {
+	__le32 dpsw_id;
+};
+
+#define DPSW_COMPONENT_TYPE_SHIFT	0
+#define DPSW_COMPONENT_TYPE_SIZE	4
+
+struct dpsw_cmd_create {
+	/* cmd word 0 */
+	__le16 num_ifs;
+	u8 max_fdbs;
+	u8 max_meters_per_if;
+	/* from LSB: only the first 4 bits */
+	u8 component_type;
+	u8 pad[3];
+	/* cmd word 1 */
+	__le16 max_vlans;
+	__le16 max_fdb_entries;
+	__le16 fdb_aging_time;
+	__le16 max_fdb_mc_groups;
+	/* cmd word 2 */
+	__le64 options;
+};
+
+struct dpsw_cmd_destroy {
+	__le32 dpsw_id;
+};
+
+#define DPSW_ENABLE_SHIFT 0
+#define DPSW_ENABLE_SIZE  1
+
+struct dpsw_rsp_is_enabled {
+	/* from LSB: enable:1 */
+	u8 enabled;
+};
+
+struct dpsw_cmd_set_irq_enable {
+	u8 enable_state;
+	u8 pad[3];
+	u8 irq_index;
+};
+
+struct dpsw_cmd_get_irq_enable {
+	__le32 pad;
+	u8 irq_index;
+};
+
+struct dpsw_rsp_get_irq_enable {
+	u8 enable_state;
+};
+
+struct dpsw_cmd_set_irq_mask {
+	__le32 mask;
+	u8 irq_index;
+};
+
+struct dpsw_cmd_get_irq_mask {
+	__le32 pad;
+	u8 irq_index;
+};
+
+struct dpsw_rsp_get_irq_mask {
+	__le32 mask;
+};
+
+struct dpsw_cmd_get_irq_status {
+	__le32 status;
+	u8 irq_index;
+};
+
+struct dpsw_rsp_get_irq_status {
+	__le32 status;
+};
+
+struct dpsw_cmd_clear_irq_status {
+	__le32 status;
+	u8 irq_index;
+};
+
+#define DPSW_COMPONENT_TYPE_SHIFT	0
+#define DPSW_COMPONENT_TYPE_SIZE	4
+
+struct dpsw_rsp_get_attr {
+	/* cmd word 0 */
+	__le16 num_ifs;
+	u8 max_fdbs;
+	u8 num_fdbs;
+	__le16 max_vlans;
+	__le16 num_vlans;
+	/* cmd word 1 */
+	__le16 max_fdb_entries;
+	__le16 fdb_aging_time;
+	__le32 dpsw_id;
+	/* cmd word 2 */
+	__le16 mem_size;
+	__le16 max_fdb_mc_groups;
+	u8 max_meters_per_if;
+	/* from LSB only the first 4 bits */
+	u8 component_type;
+	__le16 pad;
+	/* cmd word 3 */
+	__le64 options;
+};
+
+struct dpsw_cmd_if_set_flooding {
+	__le16 if_id;
+	/* from LSB: enable:1 */
+	u8 enable;
+};
+
+struct dpsw_cmd_if_set_broadcast {
+	__le16 if_id;
+	/* from LSB: enable:1 */
+	u8 enable;
+};
+
+#define DPSW_VLAN_ID_SHIFT	0
+#define DPSW_VLAN_ID_SIZE	12
+#define DPSW_DEI_SHIFT		12
+#define DPSW_DEI_SIZE		1
+#define DPSW_PCP_SHIFT		13
+#define DPSW_PCP_SIZE		3
+
+struct dpsw_cmd_if_set_tci {
+	__le16 if_id;
+	/* from LSB: VLAN_ID:12 DEI:1 PCP:3 */
+	__le16 conf;
+};
+
+#define DPSW_STATE_SHIFT	0
+#define DPSW_STATE_SIZE		4
+
+struct dpsw_cmd_if_set_stp {
+	__le16 if_id;
+	__le16 vlan_id;
+	/* only the first LSB 4 bits */
+	u8 state;
+};
+
+#define DPSW_COUNTER_TYPE_SHIFT		0
+#define DPSW_COUNTER_TYPE_SIZE		5
+
+struct dpsw_cmd_if_get_counter {
+	__le16 if_id;
+	/* from LSB: type:5 */
+	u8 type;
+};
+
+struct dpsw_rsp_if_get_counter {
+	__le64 pad;
+	__le64 counter;
+};
+
+struct dpsw_cmd_if {
+	__le16 if_id;
+};
+
+struct dpsw_cmd_if_set_max_frame_length {
+	__le16 if_id;
+	__le16 frame_length;
+};
+
+struct dpsw_cmd_if_get_link_state {
+	__le16 if_id;
+};
+
+#define DPSW_UP_SHIFT	0
+#define DPSW_UP_SIZE	1
+
+struct dpsw_rsp_if_get_link_state {
+	/* cmd word 0 */
+	__le32 pad0;
+	u8 up;
+	u8 pad1[3];
+	/* cmd word 1 */
+	__le32 rate;
+	__le32 pad2;
+	/* cmd word 2 */
+	__le64 options;
+};
+
+struct dpsw_vlan_add {
+	__le16 fdb_id;
+	__le16 vlan_id;
+};
+
+struct dpsw_cmd_vlan_manage_if {
+	/* cmd word 0 */
+	__le16 pad0;
+	__le16 vlan_id;
+	__le32 pad1;
+	/* cmd word 1-4 */
+	__le64 if_id[4];
+};
+
+struct dpsw_cmd_vlan_remove {
+	__le16 pad;
+	__le16 vlan_id;
+};
+
+struct dpsw_cmd_fdb_add {
+	__le32 pad;
+	__le16 fdb_aging_time;
+	__le16 num_fdb_entries;
+};
+
+struct dpsw_rsp_fdb_add {
+	__le16 fdb_id;
+};
+
+struct dpsw_cmd_fdb_remove {
+	__le16 fdb_id;
+};
+
+#define DPSW_ENTRY_TYPE_SHIFT	0
+#define DPSW_ENTRY_TYPE_SIZE	4
+
+struct dpsw_cmd_fdb_unicast_op {
+	/* cmd word 0 */
+	__le16 fdb_id;
+	u8 mac_addr[6];
+	/* cmd word 1 */
+	__le16 if_egress;
+	/* only the first 4 bits from LSB */
+	u8 type;
+};
+
+struct dpsw_cmd_fdb_multicast_op {
+	/* cmd word 0 */
+	__le16 fdb_id;
+	__le16 num_ifs;
+	/* only the first 4 bits from LSB */
+	u8 type;
+	u8 pad[3];
+	/* cmd word 1 */
+	u8 mac_addr[6];
+	__le16 pad2;
+	/* cmd word 2-5 */
+	__le64 if_id[4];
+};
+
+#define DPSW_LEARNING_MODE_SHIFT	0
+#define DPSW_LEARNING_MODE_SIZE		4
+
+struct dpsw_cmd_fdb_set_learning_mode {
+	__le16 fdb_id;
+	/* only the first 4 bits from LSB */
+	u8 mode;
+};
+
+struct dpsw_rsp_get_api_version {
+	__le16 version_major;
+	__le16 version_minor;
+};
+
+#endif /* __FSL_DPSW_CMD_H */
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.c b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
new file mode 100644
index 0000000..8e52d74
--- /dev/null
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
@@ -0,0 +1,1116 @@
+/* Copyright 2013-2016 Freescale Semiconductor Inc.
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
+#include <linux/fsl/mc.h>
+#include "dpsw.h"
+#include "dpsw-cmd.h"
+
+static void build_if_id_bitmap(__le64 *bmap,
+			       const u16 *id,
+			       const u16 num_ifs)
+{
+	int i;
+
+	for (i = 0; (i < num_ifs) && (i < DPSW_MAX_IF); i++) {
+		if (id[i] < DPSW_MAX_IF)
+			bmap[id[i] / 64] |= cpu_to_le64(BIT_MASK(id[i] % 64));
+	}
+}
+
+/**
+ * dpsw_open() - Open a control session for the specified object
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @dpsw_id:	DPSW unique ID
+ * @token:	Returned token; use in subsequent API calls
+ *
+ * This function can be used to open a control session for an
+ * already created object; an object may have been declared in
+ * the DPL or by calling the dpsw_create() function.
+ * This function returns a unique authentication token,
+ * associated with the specific object ID and the specific MC
+ * portal; this token must be used in all subsequent commands for
+ * this specific object
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpsw_open(struct fsl_mc_io *mc_io,
+	      u32 cmd_flags,
+	      int dpsw_id,
+	      u16 *token)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_open *cmd_params;
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_OPEN,
+					  cmd_flags,
+					  0);
+	cmd_params = (struct dpsw_cmd_open *)cmd.params;
+	cmd_params->dpsw_id = cpu_to_le32(dpsw_id);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	*token = mc_cmd_hdr_read_token(&cmd);
+
+	return 0;
+}
+
+/**
+ * dpsw_close() - Close the control session of the object
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ *
+ * After this function is called, no further operations are
+ * allowed on the object without opening a new control session.
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpsw_close(struct fsl_mc_io *mc_io,
+	       u32 cmd_flags,
+	       u16 token)
+{
+	struct mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_CLOSE,
+					  cmd_flags,
+					  token);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_enable() - Enable DPSW functionality
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ *
+ * Return:	Completion status. '0' on Success; Error code otherwise.
+ */
+int dpsw_enable(struct fsl_mc_io *mc_io,
+		u32 cmd_flags,
+		u16 token)
+{
+	struct mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_ENABLE,
+					  cmd_flags,
+					  token);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_disable() - Disable DPSW functionality
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ *
+ * Return:	Completion status. '0' on Success; Error code otherwise.
+ */
+int dpsw_disable(struct fsl_mc_io *mc_io,
+		 u32 cmd_flags,
+		 u16 token)
+{
+	struct mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_DISABLE,
+					  cmd_flags,
+					  token);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_reset() - Reset the DPSW, returns the object to initial state.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpsw_reset(struct fsl_mc_io *mc_io,
+	       u32 cmd_flags,
+	       u16 token)
+{
+	struct mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_RESET,
+					  cmd_flags,
+					  token);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_set_irq_enable() - Set overall interrupt state.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPCI object
+ * @irq_index:	The interrupt index to configure
+ * @en:		Interrupt state - enable = 1, disable = 0
+ *
+ * Allows GPP software to control when interrupts are generated.
+ * Each interrupt can have up to 32 causes.  The enable/disable control's the
+ * overall interrupt state. if the interrupt is disabled no causes will cause
+ * an interrupt
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpsw_set_irq_enable(struct fsl_mc_io *mc_io,
+			u32 cmd_flags,
+			u16 token,
+			u8 irq_index,
+			u8 en)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_set_irq_enable *cmd_params;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_SET_IRQ_ENABLE,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_set_irq_enable *)cmd.params;
+	dpsw_set_field(cmd_params->enable_state, ENABLE, en);
+	cmd_params->irq_index = irq_index;
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_set_irq_mask() - Set interrupt mask.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPCI object
+ * @irq_index:	The interrupt index to configure
+ * @mask:	Event mask to trigger interrupt;
+ *		each bit:
+ *			0 = ignore event
+ *			1 = consider event for asserting IRQ
+ *
+ * Every interrupt can have up to 32 causes and the interrupt model supports
+ * masking/unmasking each cause independently
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpsw_set_irq_mask(struct fsl_mc_io *mc_io,
+		      u32 cmd_flags,
+		      u16 token,
+		      u8 irq_index,
+		      u32 mask)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_set_irq_mask *cmd_params;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_SET_IRQ_MASK,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_set_irq_mask *)cmd.params;
+	cmd_params->mask = cpu_to_le32(mask);
+	cmd_params->irq_index = irq_index;
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_get_irq_status() - Get the current status of any pending interrupts
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @irq_index:	The interrupt index to configure
+ * @status:	Returned interrupts status - one bit per cause:
+ *			0 = no interrupt pending
+ *			1 = interrupt pending
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpsw_get_irq_status(struct fsl_mc_io *mc_io,
+			u32 cmd_flags,
+			u16 token,
+			u8 irq_index,
+			u32 *status)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_get_irq_status *cmd_params;
+	struct dpsw_rsp_get_irq_status *rsp_params;
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_GET_IRQ_STATUS,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_get_irq_status *)cmd.params;
+	cmd_params->status = cpu_to_le32(*status);
+	cmd_params->irq_index = irq_index;
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	rsp_params = (struct dpsw_rsp_get_irq_status *)cmd.params;
+	*status = le32_to_cpu(rsp_params->status);
+
+	return 0;
+}
+
+/**
+ * dpsw_clear_irq_status() - Clear a pending interrupt's status
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPCI object
+ * @irq_index:	The interrupt index to configure
+ * @status:	bits to clear (W1C) - one bit per cause:
+ *			0 = don't change
+ *			1 = clear status bit
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpsw_clear_irq_status(struct fsl_mc_io *mc_io,
+			  u32 cmd_flags,
+			  u16 token,
+			  u8 irq_index,
+			  u32 status)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_clear_irq_status *cmd_params;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_CLEAR_IRQ_STATUS,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_clear_irq_status *)cmd.params;
+	cmd_params->status = cpu_to_le32(status);
+	cmd_params->irq_index = irq_index;
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_get_attributes() - Retrieve DPSW attributes
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @attr:	Returned DPSW attributes
+ *
+ * Return:	Completion status. '0' on Success; Error code otherwise.
+ */
+int dpsw_get_attributes(struct fsl_mc_io *mc_io,
+			u32 cmd_flags,
+			u16 token,
+			struct dpsw_attr *attr)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_rsp_get_attr *rsp_params;
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_GET_ATTR,
+					  cmd_flags,
+					  token);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	rsp_params = (struct dpsw_rsp_get_attr *)cmd.params;
+	attr->num_ifs = le16_to_cpu(rsp_params->num_ifs);
+	attr->max_fdbs = rsp_params->max_fdbs;
+	attr->num_fdbs = rsp_params->num_fdbs;
+	attr->max_vlans = le16_to_cpu(rsp_params->max_vlans);
+	attr->num_vlans = le16_to_cpu(rsp_params->num_vlans);
+	attr->max_fdb_entries = le16_to_cpu(rsp_params->max_fdb_entries);
+	attr->fdb_aging_time = le16_to_cpu(rsp_params->fdb_aging_time);
+	attr->id = le32_to_cpu(rsp_params->dpsw_id);
+	attr->mem_size = le16_to_cpu(rsp_params->mem_size);
+	attr->max_fdb_mc_groups = le16_to_cpu(rsp_params->max_fdb_mc_groups);
+	attr->max_meters_per_if = rsp_params->max_meters_per_if;
+	attr->options = le64_to_cpu(rsp_params->options);
+	attr->component_type = dpsw_get_field(rsp_params->component_type,
+					      COMPONENT_TYPE);
+
+	return 0;
+}
+
+/**
+ * dpsw_if_get_link_state - Return the link state
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @if_id:	Interface id
+ * @state:	Link state	1 - linkup, 0 - link down or disconnected
+ *
+ * @Return	'0' on Success; Error code otherwise.
+ */
+int dpsw_if_get_link_state(struct fsl_mc_io *mc_io,
+			   u32 cmd_flags,
+			   u16 token,
+			   u16 if_id,
+			   struct dpsw_link_state *state)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_if_get_link_state *cmd_params;
+	struct dpsw_rsp_if_get_link_state *rsp_params;
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_IF_GET_LINK_STATE,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_if_get_link_state *)cmd.params;
+	cmd_params->if_id = cpu_to_le16(if_id);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	rsp_params = (struct dpsw_rsp_if_get_link_state *)cmd.params;
+	state->rate = le32_to_cpu(rsp_params->rate);
+	state->options = le64_to_cpu(rsp_params->options);
+	state->up = dpsw_get_field(rsp_params->up, UP);
+
+	return 0;
+}
+
+/**
+ * dpsw_if_set_flooding() - Enable Disable flooding for particular interface
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @if_id:	Interface Identifier
+ * @en:		1 - enable, 0 - disable
+ *
+ * Return:	Completion status. '0' on Success; Error code otherwise.
+ */
+int dpsw_if_set_flooding(struct fsl_mc_io *mc_io,
+			 u32 cmd_flags,
+			 u16 token,
+			 u16 if_id,
+			 u8 en)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_if_set_flooding *cmd_params;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_IF_SET_FLOODING,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_if_set_flooding *)cmd.params;
+	cmd_params->if_id = cpu_to_le16(if_id);
+	dpsw_set_field(cmd_params->enable, ENABLE, en);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_if_set_broadcast() - Enable/disable broadcast for particular interface
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @if_id:	Interface Identifier
+ * @en:		1 - enable, 0 - disable
+ *
+ * Return:	Completion status. '0' on Success; Error code otherwise.
+ */
+int dpsw_if_set_broadcast(struct fsl_mc_io *mc_io,
+			  u32 cmd_flags,
+			  u16 token,
+			  u16 if_id,
+			  u8 en)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_if_set_broadcast *cmd_params;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_IF_SET_BROADCAST,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_if_set_broadcast *)cmd.params;
+	cmd_params->if_id = cpu_to_le16(if_id);
+	dpsw_set_field(cmd_params->enable, ENABLE, en);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_if_set_tci() - Set default VLAN Tag Control Information (TCI)
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @if_id:	Interface Identifier
+ * @cfg:	Tag Control Information Configuration
+ *
+ * Return:	Completion status. '0' on Success; Error code otherwise.
+ */
+int dpsw_if_set_tci(struct fsl_mc_io *mc_io,
+		    u32 cmd_flags,
+		    u16 token,
+		    u16 if_id,
+		    const struct dpsw_tci_cfg *cfg)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_if_set_tci *cmd_params;
+	u16 tmp_conf = 0;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_IF_SET_TCI,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_if_set_tci *)cmd.params;
+	cmd_params->if_id = cpu_to_le16(if_id);
+	dpsw_set_field(tmp_conf, VLAN_ID, cfg->vlan_id);
+	dpsw_set_field(tmp_conf, DEI, cfg->dei);
+	dpsw_set_field(tmp_conf, PCP, cfg->pcp);
+	cmd_params->conf = cpu_to_le16(tmp_conf);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_if_set_stp() - Function sets Spanning Tree Protocol (STP) state.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @if_id:	Interface Identifier
+ * @cfg:	STP State configuration parameters
+ *
+ * The following STP states are supported -
+ * blocking, listening, learning, forwarding and disabled.
+ *
+ * Return:	Completion status. '0' on Success; Error code otherwise.
+ */
+int dpsw_if_set_stp(struct fsl_mc_io *mc_io,
+		    u32 cmd_flags,
+		    u16 token,
+		    u16 if_id,
+		    const struct dpsw_stp_cfg *cfg)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_if_set_stp *cmd_params;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_IF_SET_STP,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_if_set_stp *)cmd.params;
+	cmd_params->if_id = cpu_to_le16(if_id);
+	cmd_params->vlan_id = cpu_to_le16(cfg->vlan_id);
+	dpsw_set_field(cmd_params->state, STATE, cfg->state);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_if_get_counter() - Get specific counter of particular interface
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @if_id:	Interface Identifier
+ * @type:	Counter type
+ * @counter:	return value
+ *
+ * Return:	Completion status. '0' on Success; Error code otherwise.
+ */
+int dpsw_if_get_counter(struct fsl_mc_io *mc_io,
+			u32 cmd_flags,
+			u16 token,
+			u16 if_id,
+			enum dpsw_counter type,
+			u64 *counter)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_if_get_counter *cmd_params;
+	struct dpsw_rsp_if_get_counter *rsp_params;
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_IF_GET_COUNTER,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_if_get_counter *)cmd.params;
+	cmd_params->if_id = cpu_to_le16(if_id);
+	dpsw_set_field(cmd_params->type, COUNTER_TYPE, type);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	rsp_params = (struct dpsw_rsp_if_get_counter *)cmd.params;
+	*counter = le64_to_cpu(rsp_params->counter);
+
+	return 0;
+}
+
+/**
+ * dpsw_if_enable() - Enable Interface
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @if_id:	Interface Identifier
+ *
+ * Return:	Completion status. '0' on Success; Error code otherwise.
+ */
+int dpsw_if_enable(struct fsl_mc_io *mc_io,
+		   u32 cmd_flags,
+		   u16 token,
+		   u16 if_id)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_if *cmd_params;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_IF_ENABLE,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_if *)cmd.params;
+	cmd_params->if_id = cpu_to_le16(if_id);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_if_disable() - Disable Interface
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @if_id:	Interface Identifier
+ *
+ * Return:	Completion status. '0' on Success; Error code otherwise.
+ */
+int dpsw_if_disable(struct fsl_mc_io *mc_io,
+		    u32 cmd_flags,
+		    u16 token,
+		    u16 if_id)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_if *cmd_params;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_IF_DISABLE,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_if *)cmd.params;
+	cmd_params->if_id = cpu_to_le16(if_id);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_if_set_max_frame_length() - Set Maximum Receive frame length.
+ * @mc_io:		Pointer to MC portal's I/O object
+ * @cmd_flags:		Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:		Token of DPSW object
+ * @if_id:		Interface Identifier
+ * @frame_length:	Maximum Frame Length
+ *
+ * Return:	Completion status. '0' on Success; Error code otherwise.
+ */
+int dpsw_if_set_max_frame_length(struct fsl_mc_io *mc_io,
+				 u32 cmd_flags,
+				 u16 token,
+				 u16 if_id,
+				 u16 frame_length)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_if_set_max_frame_length *cmd_params;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_IF_SET_MAX_FRAME_LENGTH,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_if_set_max_frame_length *)cmd.params;
+	cmd_params->if_id = cpu_to_le16(if_id);
+	cmd_params->frame_length = cpu_to_le16(frame_length);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_vlan_add() - Adding new VLAN to DPSW.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @vlan_id:	VLAN Identifier
+ * @cfg:	VLAN configuration
+ *
+ * Only VLAN ID and FDB ID are required parameters here.
+ * 12 bit VLAN ID is defined in IEEE802.1Q.
+ * Adding a duplicate VLAN ID is not allowed.
+ * FDB ID can be shared across multiple VLANs. Shared learning
+ * is obtained by calling dpsw_vlan_add for multiple VLAN IDs
+ * with same fdb_id
+ *
+ * Return:	Completion status. '0' on Success; Error code otherwise.
+ */
+int dpsw_vlan_add(struct fsl_mc_io *mc_io,
+		  u32 cmd_flags,
+		  u16 token,
+		  u16 vlan_id,
+		  const struct dpsw_vlan_cfg *cfg)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_vlan_add *cmd_params;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_VLAN_ADD,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_vlan_add *)cmd.params;
+	cmd_params->fdb_id = cpu_to_le16(cfg->fdb_id);
+	cmd_params->vlan_id = cpu_to_le16(vlan_id);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_vlan_add_if() - Adding a set of interfaces to an existing VLAN.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @vlan_id:	VLAN Identifier
+ * @cfg:	Set of interfaces to add
+ *
+ * It adds only interfaces not belonging to this VLAN yet,
+ * otherwise an error is generated and an entire command is
+ * ignored. This function can be called numerous times always
+ * providing required interfaces delta.
+ *
+ * Return:	Completion status. '0' on Success; Error code otherwise.
+ */
+int dpsw_vlan_add_if(struct fsl_mc_io *mc_io,
+		     u32 cmd_flags,
+		     u16 token,
+		     u16 vlan_id,
+		     const struct dpsw_vlan_if_cfg *cfg)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_vlan_manage_if *cmd_params;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_VLAN_ADD_IF,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_vlan_manage_if *)cmd.params;
+	cmd_params->vlan_id = cpu_to_le16(vlan_id);
+	build_if_id_bitmap(cmd_params->if_id, cfg->if_id, cfg->num_ifs);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_vlan_add_if_untagged() - Defining a set of interfaces that should be
+ *				transmitted as untagged.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @vlan_id:	VLAN Identifier
+ * @cfg:	Set of interfaces that should be transmitted as untagged
+ *
+ * These interfaces should already belong to this VLAN.
+ * By default all interfaces are transmitted as tagged.
+ * Providing un-existing interface or untagged interface that is
+ * configured untagged already generates an error and the entire
+ * command is ignored.
+ *
+ * Return:	Completion status. '0' on Success; Error code otherwise.
+ */
+int dpsw_vlan_add_if_untagged(struct fsl_mc_io *mc_io,
+			      u32 cmd_flags,
+			      u16 token,
+			      u16 vlan_id,
+			      const struct dpsw_vlan_if_cfg *cfg)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_vlan_manage_if *cmd_params;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_VLAN_ADD_IF_UNTAGGED,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_vlan_manage_if *)cmd.params;
+	cmd_params->vlan_id = cpu_to_le16(vlan_id);
+	build_if_id_bitmap(cmd_params->if_id, cfg->if_id, cfg->num_ifs);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_vlan_remove_if() - Remove interfaces from an existing VLAN.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @vlan_id:	VLAN Identifier
+ * @cfg:	Set of interfaces that should be removed
+ *
+ * Interfaces must belong to this VLAN, otherwise an error
+ * is returned and an the command is ignored
+ *
+ * Return:	Completion status. '0' on Success; Error code otherwise.
+ */
+int dpsw_vlan_remove_if(struct fsl_mc_io *mc_io,
+			u32 cmd_flags,
+			u16 token,
+			u16 vlan_id,
+			const struct dpsw_vlan_if_cfg *cfg)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_vlan_manage_if *cmd_params;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_VLAN_REMOVE_IF,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_vlan_manage_if *)cmd.params;
+	cmd_params->vlan_id = cpu_to_le16(vlan_id);
+	build_if_id_bitmap(cmd_params->if_id, cfg->if_id, cfg->num_ifs);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_vlan_remove_if_untagged() - Define a set of interfaces that should be
+ *		converted from transmitted as untagged to transmit as tagged.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @vlan_id:	VLAN Identifier
+ * @cfg:	Set of interfaces that should be removed
+ *
+ * Interfaces provided by API have to belong to this VLAN and
+ * configured untagged, otherwise an error is returned and the
+ * command is ignored
+ *
+ * Return:	Completion status. '0' on Success; Error code otherwise.
+ */
+int dpsw_vlan_remove_if_untagged(struct fsl_mc_io *mc_io,
+				 u32 cmd_flags,
+				 u16 token,
+				 u16 vlan_id,
+				 const struct dpsw_vlan_if_cfg *cfg)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_vlan_manage_if *cmd_params;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_VLAN_REMOVE_IF_UNTAGGED,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_vlan_manage_if *)cmd.params;
+	cmd_params->vlan_id = cpu_to_le16(vlan_id);
+	build_if_id_bitmap(cmd_params->if_id, cfg->if_id, cfg->num_ifs);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_vlan_remove() - Remove an entire VLAN
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @vlan_id:	VLAN Identifier
+ *
+ * Return:	Completion status. '0' on Success; Error code otherwise.
+ */
+int dpsw_vlan_remove(struct fsl_mc_io *mc_io,
+		     u32 cmd_flags,
+		     u16 token,
+		     u16 vlan_id)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_vlan_remove *cmd_params;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_VLAN_REMOVE,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_vlan_remove *)cmd.params;
+	cmd_params->vlan_id = cpu_to_le16(vlan_id);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_fdb_add_unicast() - Function adds an unicast entry into MAC lookup table
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @fdb_id:	Forwarding Database Identifier
+ * @cfg:	Unicast entry configuration
+ *
+ * Return:	Completion status. '0' on Success; Error code otherwise.
+ */
+int dpsw_fdb_add_unicast(struct fsl_mc_io *mc_io,
+			 u32 cmd_flags,
+			 u16 token,
+			 u16 fdb_id,
+			 const struct dpsw_fdb_unicast_cfg *cfg)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_fdb_unicast_op *cmd_params;
+	int i;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_FDB_ADD_UNICAST,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_fdb_unicast_op *)cmd.params;
+	cmd_params->fdb_id = cpu_to_le16(fdb_id);
+	cmd_params->if_egress = cpu_to_le16(cfg->if_egress);
+	for (i = 0; i < 6; i++)
+		cmd_params->mac_addr[i] = cfg->mac_addr[5 - i];
+	dpsw_set_field(cmd_params->type, ENTRY_TYPE, cfg->type);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_fdb_remove_unicast() - removes an entry from MAC lookup table
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @fdb_id:	Forwarding Database Identifier
+ * @cfg:	Unicast entry configuration
+ *
+ * Return:	Completion status. '0' on Success; Error code otherwise.
+ */
+int dpsw_fdb_remove_unicast(struct fsl_mc_io *mc_io,
+			    u32 cmd_flags,
+			    u16 token,
+			    u16 fdb_id,
+			    const struct dpsw_fdb_unicast_cfg *cfg)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_fdb_unicast_op *cmd_params;
+	int i;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_FDB_REMOVE_UNICAST,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_fdb_unicast_op *)cmd.params;
+	cmd_params->fdb_id = cpu_to_le16(fdb_id);
+	for (i = 0; i < 6; i++)
+		cmd_params->mac_addr[i] = cfg->mac_addr[5 - i];
+	cmd_params->if_egress = cpu_to_le16(cfg->if_egress);
+	dpsw_set_field(cmd_params->type, ENTRY_TYPE, cfg->type);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_fdb_add_multicast() - Add a set of egress interfaces to multi-cast group
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @fdb_id:	Forwarding Database Identifier
+ * @cfg:	Multicast entry configuration
+ *
+ * If group doesn't exist, it will be created.
+ * It adds only interfaces not belonging to this multicast group
+ * yet, otherwise error will be generated and the command is
+ * ignored.
+ * This function may be called numerous times always providing
+ * required interfaces delta.
+ *
+ * Return:	Completion status. '0' on Success; Error code otherwise.
+ */
+int dpsw_fdb_add_multicast(struct fsl_mc_io *mc_io,
+			   u32 cmd_flags,
+			   u16 token,
+			   u16 fdb_id,
+			   const struct dpsw_fdb_multicast_cfg *cfg)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_fdb_multicast_op *cmd_params;
+	int i;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_FDB_ADD_MULTICAST,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_fdb_multicast_op *)cmd.params;
+	cmd_params->fdb_id = cpu_to_le16(fdb_id);
+	cmd_params->num_ifs = cpu_to_le16(cfg->num_ifs);
+	dpsw_set_field(cmd_params->type, ENTRY_TYPE, cfg->type);
+	build_if_id_bitmap(cmd_params->if_id, cfg->if_id, cfg->num_ifs);
+	for (i = 0; i < 6; i++)
+		cmd_params->mac_addr[i] = cfg->mac_addr[5 - i];
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_fdb_remove_multicast() - Removing interfaces from an existing multicast
+ *				group.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @fdb_id:	Forwarding Database Identifier
+ * @cfg:	Multicast entry configuration
+ *
+ * Interfaces provided by this API have to exist in the group,
+ * otherwise an error will be returned and an entire command
+ * ignored. If there is no interface left in the group,
+ * an entire group is deleted
+ *
+ * Return:	Completion status. '0' on Success; Error code otherwise.
+ */
+int dpsw_fdb_remove_multicast(struct fsl_mc_io *mc_io,
+			      u32 cmd_flags,
+			      u16 token,
+			      u16 fdb_id,
+			      const struct dpsw_fdb_multicast_cfg *cfg)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_fdb_multicast_op *cmd_params;
+	int i;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_FDB_REMOVE_MULTICAST,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_fdb_multicast_op *)cmd.params;
+	cmd_params->fdb_id = cpu_to_le16(fdb_id);
+	cmd_params->num_ifs = cpu_to_le16(cfg->num_ifs);
+	dpsw_set_field(cmd_params->type, ENTRY_TYPE, cfg->type);
+	build_if_id_bitmap(cmd_params->if_id, cfg->if_id, cfg->num_ifs);
+	for (i = 0; i < 6; i++)
+		cmd_params->mac_addr[i] = cfg->mac_addr[5 - i];
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_fdb_set_learning_mode() - Define FDB learning mode
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @fdb_id:	Forwarding Database Identifier
+ * @mode:	Learning mode
+ *
+ * Return:	Completion status. '0' on Success; Error code otherwise.
+ */
+int dpsw_fdb_set_learning_mode(struct fsl_mc_io *mc_io,
+			       u32 cmd_flags,
+			       u16 token,
+			       u16 fdb_id,
+			       enum dpsw_fdb_learning_mode mode)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_fdb_set_learning_mode *cmd_params;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_FDB_SET_LEARNING_MODE,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_fdb_set_learning_mode *)cmd.params;
+	cmd_params->fdb_id = cpu_to_le16(fdb_id);
+	dpsw_set_field(cmd_params->mode, LEARNING_MODE, mode);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_get_api_version() - Get Data Path Switch API version
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @major_ver:	Major version of data path switch API
+ * @minor_ver:	Minor version of data path switch API
+ *
+ * Return:  '0' on Success; Error code otherwise.
+ */
+int dpsw_get_api_version(struct fsl_mc_io *mc_io,
+			 u32 cmd_flags,
+			 u16 *major_ver,
+			 u16 *minor_ver)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_rsp_get_api_version *rsp_params;
+	int err;
+
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_GET_API_VERSION,
+					  cmd_flags,
+					  0);
+
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	rsp_params = (struct dpsw_rsp_get_api_version *)cmd.params;
+	*major_ver = le16_to_cpu(rsp_params->version_major);
+	*minor_ver = le16_to_cpu(rsp_params->version_minor);
+
+	return 0;
+}
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
new file mode 100644
index 0000000..d13970c
--- /dev/null
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
@@ -0,0 +1,579 @@
+/* Copyright 2013-2016 Freescale Semiconductor Inc.
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
+#ifndef __FSL_DPSW_H
+#define __FSL_DPSW_H
+
+/* Data Path L2-Switch API
+ * Contains API for handling DPSW topology and functionality
+ */
+
+struct fsl_mc_io;
+
+/**
+ * DPSW general definitions
+ */
+
+/**
+ * Maximum number of traffic class priorities
+ */
+#define DPSW_MAX_PRIORITIES	8
+/**
+ * Maximum number of interfaces
+ */
+#define DPSW_MAX_IF		64
+
+int dpsw_open(struct fsl_mc_io *mc_io,
+	      u32 cmd_flags,
+	      int dpsw_id,
+	      u16 *token);
+
+int dpsw_close(struct fsl_mc_io *mc_io,
+	       u32 cmd_flags,
+	       u16 token);
+
+/**
+ * DPSW options
+ */
+
+/**
+ * Disable flooding
+ */
+#define DPSW_OPT_FLOODING_DIS		0x0000000000000001ULL
+/**
+ * Disable Multicast
+ */
+#define DPSW_OPT_MULTICAST_DIS		0x0000000000000004ULL
+/**
+ * Support control interface
+ */
+#define DPSW_OPT_CTRL_IF_DIS		0x0000000000000010ULL
+/**
+ * Disable flooding metering
+ */
+#define DPSW_OPT_FLOODING_METERING_DIS  0x0000000000000020ULL
+/**
+ * Enable metering
+ */
+#define DPSW_OPT_METERING_EN            0x0000000000000040ULL
+
+/**
+ * enum dpsw_component_type - component type of a bridge
+ * @DPSW_COMPONENT_TYPE_C_VLAN: A C-VLAN component of an
+ *   enterprise VLAN bridge or of a Provider Bridge used
+ *   to process C-tagged frames
+ * @DPSW_COMPONENT_TYPE_S_VLAN: An S-VLAN component of a
+ *   Provider Bridge
+ *
+ */
+enum dpsw_component_type {
+	DPSW_COMPONENT_TYPE_C_VLAN = 0,
+	DPSW_COMPONENT_TYPE_S_VLAN
+};
+
+/**
+ * struct dpsw_cfg - DPSW configuration
+ * @num_ifs: Number of external and internal interfaces
+ * @adv: Advanced parameters; default is all zeros;
+ *		 use this structure to change default settings
+ */
+struct dpsw_cfg {
+	u16 num_ifs;
+	/**
+	 * struct adv - Advanced parameters
+	 * @options: Enable/Disable DPSW features (bitmap)
+	 * @max_vlans: Maximum Number of VLAN's; 0 - indicates default 16
+	 * @max_meters_per_if: Number of meters per interface
+	 * @max_fdbs: Maximum Number of FDB's; 0 - indicates default 16
+	 * @max_fdb_entries: Number of FDB entries for default FDB table;
+	 *			0 - indicates default 1024 entries.
+	 * @fdb_aging_time: Default FDB aging time for default FDB table;
+	 *			0 - indicates default 300 seconds
+	 * @max_fdb_mc_groups: Number of multicast groups in each FDB table;
+	 *			0 - indicates default 32
+	 * @component_type: Indicates the component type of this bridge
+	 */
+	struct {
+		u64 options;
+		u16 max_vlans;
+		u8 max_meters_per_if;
+		u8 max_fdbs;
+		u16 max_fdb_entries;
+		u16 fdb_aging_time;
+		u16 max_fdb_mc_groups;
+		enum dpsw_component_type component_type;
+	} adv;
+};
+
+int dpsw_enable(struct fsl_mc_io *mc_io,
+		u32 cmd_flags,
+		u16 token);
+
+int dpsw_disable(struct fsl_mc_io *mc_io,
+		 u32 cmd_flags,
+		 u16 token);
+
+int dpsw_reset(struct fsl_mc_io *mc_io,
+	       u32 cmd_flags,
+	       u16 token);
+
+/**
+ * DPSW IRQ Index and Events
+ */
+
+#define DPSW_IRQ_INDEX_IF		0x0000
+#define DPSW_IRQ_INDEX_L2SW		0x0001
+
+/**
+ * IRQ event - Indicates that the link state changed
+ */
+#define DPSW_IRQ_EVENT_LINK_CHANGED	0x0001
+
+/**
+ * struct dpsw_irq_cfg - IRQ configuration
+ * @addr:	Address that must be written to signal a message-based interrupt
+ * @val:	Value to write into irq_addr address
+ * @irq_num: A user defined number associated with this IRQ
+ */
+struct dpsw_irq_cfg {
+	u64 addr;
+	u32 val;
+	int irq_num;
+};
+
+int dpsw_set_irq_enable(struct fsl_mc_io *mc_io,
+			u32 cmd_flags,
+			u16 token,
+			u8 irq_index,
+			u8 en);
+
+int dpsw_set_irq_mask(struct fsl_mc_io *mc_io,
+		      u32 cmd_flags,
+		      u16 token,
+		      u8 irq_index,
+		      u32 mask);
+
+int dpsw_get_irq_status(struct fsl_mc_io *mc_io,
+			u32 cmd_flags,
+			u16 token,
+			u8 irq_index,
+			u32 *status);
+
+int dpsw_clear_irq_status(struct fsl_mc_io *mc_io,
+			  u32 cmd_flags,
+			  u16 token,
+			  u8 irq_index,
+			  u32 status);
+
+/**
+ * struct dpsw_attr - Structure representing DPSW attributes
+ * @id: DPSW object ID
+ * @options: Enable/Disable DPSW features
+ * @max_vlans: Maximum Number of VLANs
+ * @max_meters_per_if:  Number of meters per interface
+ * @max_fdbs: Maximum Number of FDBs
+ * @max_fdb_entries: Number of FDB entries for default FDB table;
+ *			0 - indicates default 1024 entries.
+ * @fdb_aging_time: Default FDB aging time for default FDB table;
+ *			0 - indicates default 300 seconds
+ * @max_fdb_mc_groups: Number of multicast groups in each FDB table;
+ *			0 - indicates default 32
+ * @mem_size: DPSW frame storage memory size
+ * @num_ifs: Number of interfaces
+ * @num_vlans: Current number of VLANs
+ * @num_fdbs: Current number of FDBs
+ * @component_type: Component type of this bridge
+ */
+struct dpsw_attr {
+	int id;
+	u64 options;
+	u16 max_vlans;
+	u8 max_meters_per_if;
+	u8 max_fdbs;
+	u16 max_fdb_entries;
+	u16 fdb_aging_time;
+	u16 max_fdb_mc_groups;
+	u16 num_ifs;
+	u16 mem_size;
+	u16 num_vlans;
+	u8 num_fdbs;
+	enum dpsw_component_type component_type;
+};
+
+int dpsw_get_attributes(struct fsl_mc_io *mc_io,
+			u32 cmd_flags,
+			u16 token,
+			struct dpsw_attr *attr);
+
+/**
+ * enum dpsw_action - Action selection for special/control frames
+ * @DPSW_ACTION_DROP: Drop frame
+ * @DPSW_ACTION_REDIRECT: Redirect frame to control port
+ */
+enum dpsw_action {
+	DPSW_ACTION_DROP = 0,
+	DPSW_ACTION_REDIRECT = 1
+};
+
+/**
+ * struct dpsw_link_state - Structure representing DPSW link state
+ * @rate: Rate
+ * @options: Mask of available options; use 'DPSW_LINK_OPT_<X>' values
+ * @up: 0 - covers two cases: down and disconnected, 1 - up
+ */
+struct dpsw_link_state {
+	u32 rate;
+	u64 options;
+	u8 up;
+};
+
+int dpsw_if_get_link_state(struct fsl_mc_io *mc_io,
+			   u32 cmd_flags,
+			   u16 token,
+			   u16 if_id,
+			   struct dpsw_link_state *state);
+
+int dpsw_if_set_flooding(struct fsl_mc_io *mc_io,
+			 u32 cmd_flags,
+			 u16 token,
+			 u16 if_id,
+			 u8 en);
+
+int dpsw_if_set_broadcast(struct fsl_mc_io *mc_io,
+			  u32 cmd_flags,
+			  u16 token,
+			  u16 if_id,
+			  u8 en);
+
+/**
+ * struct dpsw_tci_cfg - Tag Control Information (TCI) configuration
+ * @pcp: Priority Code Point (PCP): a 3-bit field which refers
+ *		 to the IEEE 802.1p priority
+ * @dei: Drop Eligible Indicator (DEI): a 1-bit field. May be used
+ *		 separately or in conjunction with PCP to indicate frames
+ *		 eligible to be dropped in the presence of congestion
+ * @vlan_id: VLAN Identifier (VID): a 12-bit field specifying the VLAN
+ *			to which the frame belongs. The hexadecimal values
+ *			of 0x000 and 0xFFF are reserved;
+ *			all other values may be used as VLAN identifiers,
+ *			allowing up to 4,094 VLANs
+ */
+struct dpsw_tci_cfg {
+	u8 pcp;
+	u8 dei;
+	u16 vlan_id;
+};
+
+int dpsw_if_set_tci(struct fsl_mc_io *mc_io,
+		    u32 cmd_flags,
+		    u16 token,
+		    u16 if_id,
+		    const struct dpsw_tci_cfg *cfg);
+
+/**
+ * enum dpsw_stp_state - Spanning Tree Protocol (STP) states
+ * @DPSW_STP_STATE_BLOCKING: Blocking state
+ * @DPSW_STP_STATE_LISTENING: Listening state
+ * @DPSW_STP_STATE_LEARNING: Learning state
+ * @DPSW_STP_STATE_FORWARDING: Forwarding state
+ *
+ */
+enum dpsw_stp_state {
+	DPSW_STP_STATE_DISABLED = 0,
+	DPSW_STP_STATE_LISTENING = 1,
+	DPSW_STP_STATE_LEARNING = 2,
+	DPSW_STP_STATE_FORWARDING = 3,
+	DPSW_STP_STATE_BLOCKING = 0
+};
+
+/**
+ * struct dpsw_stp_cfg - Spanning Tree Protocol (STP) Configuration
+ * @vlan_id: VLAN ID STP state
+ * @state: STP state
+ */
+struct dpsw_stp_cfg {
+	u16 vlan_id;
+	enum dpsw_stp_state state;
+};
+
+int dpsw_if_set_stp(struct fsl_mc_io *mc_io,
+		    u32 cmd_flags,
+		    u16 token,
+		    u16 if_id,
+		    const struct dpsw_stp_cfg *cfg);
+
+/**
+ * enum dpsw_accepted_frames - Types of frames to accept
+ * @DPSW_ADMIT_ALL: The device accepts VLAN tagged, untagged and
+ *			priority tagged frames
+ * @DPSW_ADMIT_ONLY_VLAN_TAGGED: The device discards untagged frames or
+ *			Priority-Tagged frames received on this interface.
+ *
+ */
+enum dpsw_accepted_frames {
+	DPSW_ADMIT_ALL = 1,
+	DPSW_ADMIT_ONLY_VLAN_TAGGED = 3
+};
+
+/**
+ * enum dpsw_counter  - Counters types
+ * @DPSW_CNT_ING_FRAME: Counts ingress frames
+ * @DPSW_CNT_ING_BYTE: Counts ingress bytes
+ * @DPSW_CNT_ING_FLTR_FRAME: Counts filtered ingress frames
+ * @DPSW_CNT_ING_FRAME_DISCARD: Counts discarded ingress frame
+ * @DPSW_CNT_ING_MCAST_FRAME: Counts ingress multicast frames
+ * @DPSW_CNT_ING_MCAST_BYTE: Counts ingress multicast bytes
+ * @DPSW_CNT_ING_BCAST_FRAME: Counts ingress broadcast frames
+ * @DPSW_CNT_ING_BCAST_BYTES: Counts ingress broadcast bytes
+ * @DPSW_CNT_EGR_FRAME: Counts egress frames
+ * @DPSW_CNT_EGR_BYTE: Counts eEgress bytes
+ * @DPSW_CNT_EGR_FRAME_DISCARD: Counts discarded egress frames
+ * @DPSW_CNT_EGR_STP_FRAME_DISCARD: Counts egress STP discarded frames
+ */
+enum dpsw_counter {
+	DPSW_CNT_ING_FRAME = 0x0,
+	DPSW_CNT_ING_BYTE = 0x1,
+	DPSW_CNT_ING_FLTR_FRAME = 0x2,
+	DPSW_CNT_ING_FRAME_DISCARD = 0x3,
+	DPSW_CNT_ING_MCAST_FRAME = 0x4,
+	DPSW_CNT_ING_MCAST_BYTE = 0x5,
+	DPSW_CNT_ING_BCAST_FRAME = 0x6,
+	DPSW_CNT_ING_BCAST_BYTES = 0x7,
+	DPSW_CNT_EGR_FRAME = 0x8,
+	DPSW_CNT_EGR_BYTE = 0x9,
+	DPSW_CNT_EGR_FRAME_DISCARD = 0xa,
+	DPSW_CNT_EGR_STP_FRAME_DISCARD = 0xb
+};
+
+int dpsw_if_get_counter(struct fsl_mc_io *mc_io,
+			u32 cmd_flags,
+			u16 token,
+			u16 if_id,
+			enum dpsw_counter type,
+			u64 *counter);
+
+int dpsw_if_enable(struct fsl_mc_io *mc_io,
+		   u32 cmd_flags,
+		   u16 token,
+		   u16 if_id);
+
+int dpsw_if_disable(struct fsl_mc_io *mc_io,
+		    u32 cmd_flags,
+		    u16 token,
+		    u16 if_id);
+
+int dpsw_if_set_max_frame_length(struct fsl_mc_io *mc_io,
+				 u32 cmd_flags,
+				 u16 token,
+				 u16 if_id,
+				 u16 frame_length);
+
+/**
+ * struct dpsw_vlan_cfg - VLAN Configuration
+ * @fdb_id: Forwarding Data Base
+ */
+struct dpsw_vlan_cfg {
+	u16 fdb_id;
+};
+
+int dpsw_vlan_add(struct fsl_mc_io *mc_io,
+		  u32 cmd_flags,
+		  u16 token,
+		  u16 vlan_id,
+		  const struct dpsw_vlan_cfg *cfg);
+
+/**
+ * struct dpsw_vlan_if_cfg - Set of VLAN Interfaces
+ * @num_ifs: The number of interfaces that are assigned to the egress
+ *		list for this VLAN
+ * @if_id: The set of interfaces that are
+ *		assigned to the egress list for this VLAN
+ */
+struct dpsw_vlan_if_cfg {
+	u16 num_ifs;
+	u16 if_id[DPSW_MAX_IF];
+};
+
+int dpsw_vlan_add_if(struct fsl_mc_io *mc_io,
+		     u32 cmd_flags,
+		     u16 token,
+		     u16 vlan_id,
+		     const struct dpsw_vlan_if_cfg *cfg);
+
+int dpsw_vlan_add_if_untagged(struct fsl_mc_io *mc_io,
+			      u32 cmd_flags,
+			      u16 token,
+			      u16 vlan_id,
+			      const struct dpsw_vlan_if_cfg *cfg);
+
+int dpsw_vlan_remove_if(struct fsl_mc_io *mc_io,
+			u32 cmd_flags,
+			u16 token,
+			u16 vlan_id,
+			const struct dpsw_vlan_if_cfg *cfg);
+
+int dpsw_vlan_remove_if_untagged(struct fsl_mc_io *mc_io,
+				 u32 cmd_flags,
+				 u16 token,
+				 u16 vlan_id,
+				 const struct dpsw_vlan_if_cfg *cfg);
+
+int dpsw_vlan_remove(struct fsl_mc_io *mc_io,
+		     u32 cmd_flags,
+		     u16 token,
+		     u16 vlan_id);
+
+/**
+ * enum dpsw_fdb_entry_type - FDB Entry type - Static/Dynamic
+ * @DPSW_FDB_ENTRY_STATIC: Static entry
+ * @DPSW_FDB_ENTRY_DINAMIC: Dynamic entry
+ */
+enum dpsw_fdb_entry_type {
+	DPSW_FDB_ENTRY_STATIC = 0,
+	DPSW_FDB_ENTRY_DINAMIC = 1
+};
+
+/**
+ * struct dpsw_fdb_unicast_cfg - Unicast entry configuration
+ * @type: Select static or dynamic entry
+ * @mac_addr: MAC address
+ * @if_egress: Egress interface ID
+ */
+struct dpsw_fdb_unicast_cfg {
+	enum dpsw_fdb_entry_type type;
+	u8 mac_addr[6];
+	u16 if_egress;
+};
+
+int dpsw_fdb_add_unicast(struct fsl_mc_io *mc_io,
+			 u32 cmd_flags,
+			 u16 token,
+			 u16 fdb_id,
+			 const struct dpsw_fdb_unicast_cfg *cfg);
+
+int dpsw_fdb_remove_unicast(struct fsl_mc_io *mc_io,
+			    u32 cmd_flags,
+			    u16 token,
+			    u16 fdb_id,
+			    const struct dpsw_fdb_unicast_cfg *cfg);
+
+/**
+ * struct dpsw_fdb_multicast_cfg - Multi-cast entry configuration
+ * @type: Select static or dynamic entry
+ * @mac_addr: MAC address
+ * @num_ifs: Number of external and internal interfaces
+ * @if_id: Egress interface IDs
+ */
+struct dpsw_fdb_multicast_cfg {
+	enum dpsw_fdb_entry_type type;
+	u8 mac_addr[6];
+	u16 num_ifs;
+	u16 if_id[DPSW_MAX_IF];
+};
+
+int dpsw_fdb_add_multicast(struct fsl_mc_io *mc_io,
+			   u32 cmd_flags,
+			   u16 token,
+			   u16 fdb_id,
+			   const struct dpsw_fdb_multicast_cfg *cfg);
+
+int dpsw_fdb_remove_multicast(struct fsl_mc_io *mc_io,
+			      u32 cmd_flags,
+			      u16 token,
+			      u16 fdb_id,
+			      const struct dpsw_fdb_multicast_cfg *cfg);
+
+/**
+ * enum dpsw_fdb_learning_mode - Auto-learning modes
+ * @DPSW_FDB_LEARNING_MODE_DIS: Disable Auto-learning
+ * @DPSW_FDB_LEARNING_MODE_HW: Enable HW auto-Learning
+ * @DPSW_FDB_LEARNING_MODE_NON_SECURE: Enable None secure learning by CPU
+ * @DPSW_FDB_LEARNING_MODE_SECURE: Enable secure learning by CPU
+ *
+ *	NONE - SECURE LEARNING
+ *	SMAC found	DMAC found	CTLU Action
+ *	v		v	Forward frame to
+ *						1.  DMAC destination
+ *	-		v	Forward frame to
+ *						1.  DMAC destination
+ *						2.  Control interface
+ *	v		-	Forward frame to
+ *						1.  Flooding list of interfaces
+ *	-		-	Forward frame to
+ *						1.  Flooding list of interfaces
+ *						2.  Control interface
+ *	SECURE LEARING
+ *	SMAC found	DMAC found	CTLU Action
+ *	v		v		Forward frame to
+ *						1.  DMAC destination
+ *	-		v		Forward frame to
+ *						1.  Control interface
+ *	v		-		Forward frame to
+ *						1.  Flooding list of interfaces
+ *	-		-		Forward frame to
+ *						1.  Control interface
+ */
+enum dpsw_fdb_learning_mode {
+	DPSW_FDB_LEARNING_MODE_DIS = 0,
+	DPSW_FDB_LEARNING_MODE_HW = 1,
+	DPSW_FDB_LEARNING_MODE_NON_SECURE = 2,
+	DPSW_FDB_LEARNING_MODE_SECURE = 3
+};
+
+int dpsw_fdb_set_learning_mode(struct fsl_mc_io *mc_io,
+			       u32 cmd_flags,
+			       u16 token,
+			       u16 fdb_id,
+			       enum dpsw_fdb_learning_mode mode);
+
+/**
+ * struct dpsw_fdb_attr - FDB Attributes
+ * @max_fdb_entries: Number of FDB entries
+ * @fdb_aging_time: Aging time in seconds
+ * @learning_mode: Learning mode
+ * @num_fdb_mc_groups: Current number of multicast groups
+ * @max_fdb_mc_groups: Maximum number of multicast groups
+ */
+struct dpsw_fdb_attr {
+	u16 max_fdb_entries;
+	u16 fdb_aging_time;
+	enum dpsw_fdb_learning_mode learning_mode;
+	u16 num_fdb_mc_groups;
+	u16 max_fdb_mc_groups;
+};
+
+int dpsw_get_api_version(struct fsl_mc_io *mc_io,
+			 u32 cmd_flags,
+			 u16 *major_ver,
+			 u16 *minor_ver);
+
+#endif /* __FSL_DPSW_H */
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
