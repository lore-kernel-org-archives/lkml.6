Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4009665-1520844644-2-13430089571729274251
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520844642; b=Bn10+qzVZP5GNkY/8Q7a5OzESBN3Rzeq2qO0Cth5IUWpP3l
    834RohepZ/fLFNX7M7GP/kZVldioG2AxCi8b4sfU5cjXE+jaXcofiqyOGDHPzixj
    c/p6G2Ee7ybJVtVkKe7WTorbokmjrdxFwpZYvPBWY2uysRLxg0wiAy/XaIkncMjm
    xopyMoW6N2zBUgueZhNkfc9zlnkqhESynU/fMYQLVfEhrKmEHSWaZlK3qA5on3lq
    cpH0NcZaZ2Y9qI6yOERw8gjKmWTMCyi931MxKMGbOGTILrBKBWlOhhbJuUP8Zf6F
    nGK+B/vNKQnm8CidSnK4tsvhi6zmsGa56jsvRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520844642; bh=e
    0WGRKpZ3n4EfAb/4U1gZsEQ3/XGdvgZYqRiwSo92SE=; b=lzoSFkAtM2HbiehL/
    TgW9WZ1IwvnzNIw0jrI+QKygCIUN7qgEyep4JCCUdc1Hk35wUhuVFsyS4yFj58EW
    V1rQp/10+rIvl+pJVP+wEQUQwAa5KwnY8cMyVDuJlEXJXziHZR51wwq4G2kubl6O
    P77EtNy8/ZHVf42rnhxzOgmVtENUP9jFX0OZVkEmyq+NX4mTakLhQMtUyqvl+dp+
    +yy1a+uFoBwyAXJU6kA0bOINA0/DfN65SvsBYqreW9F/liC4pvG+h7fAWy8UdTmP
    P5zAx/o1gPgq7XXjaqUp5O83XeEJURPaEdQqS/7OEs2W7i5ZCpQQRvXXZwbXvI8Z
    h86og==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=iIHFougr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=iIHFougr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=razvan.stefanescu@nxp.com;
From: Razvan Stefanescu <razvan.stefanescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v4 2/6] staging: fsl-dpaa2/ethsw: Add Freescale DPAA2 Ethernet
 Switch driver
Date: Mon, 12 Mar 2018 03:49:51 -0500
Message-Id: <20180312084955.12686-3-razvan.stefanescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 50920870-44c6-479d-b460-08d587f644b4
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM3PR04MB0743;
X-Microsoft-Exchange-Diagnostics: 1; AM3PR04MB0743;
 3:jITwvmfP+wvYsObVXLZN6k8ZsmQSH7o+dZPcWvuB65DSeTVYYwVZFs77oqgCV1tyxUZv3LPPuxgRDm4rjCdxhocB0SJYSBfjCFRIJjuKtWx6FXxB7rHC2fh98lLnOJZz1Kure07OgT3Z1aANamPkqlWsyf16hW2d/N+XD9tk+q741ecUxeTDieUgXLkfHnk8UJpJChJu2w/qzghjp1Fkoqc8bzPcNSAxZoM+88XnDHJiJPgGomfohUjAqGshwx4Z;
 25:N5HhkaBdZ3DKVaX0Z81sMTgFlyqnNRn87O4zSShKdgCzqsMgAsNIHsGoNyd+H7Y7iqBUis1RADN0O6l/F2YAuVJhwIR3I4z0SsogBi+/8aw7A0z8BSJ0qP4c91DOVPVF43KkIk4WkbB21o5FfHFSLxQ9qL+1O3O6pwiCrY1wu4vLzsycjFEPGy/ww2V7/wGI9QQAJ5oGGYC7nkv5Ypc2OAFQ7iI9tXcGsOHc0hZMvDv2ak2F83VjBjnEkdScacQuyy8ok034R5cLoV4Y7q9n4a0KJeWi7xAcgZ1GNEy5SUb9PVhDPxFN2vK2qAZCXuDkAiy1DlADfyHhO00Rkh5KZQ==;
 31:1+7+fUjdooYpzZnLleW3UeAIAiB9SDR7Ml2swGQ3uks8BPphcpNwA+5Q5+07+3j2JXnoyvBoE/wrIdABcrJBidD+y0tWCM/DC2gEAx7cDpBuHLpNg8Aa7zgZ+guEf9MLvU4k8yiTZwQXcOrwWxZXsIEgnkb4JSLpnLIsZSpFhEWGzhbzgJcDhYc/VINh7SIUw8YJWYbfn7NcIe/GvcNB5B2OFD8rwXvzxoGpcYjevEs=
X-MS-TrafficTypeDiagnostic: AM3PR04MB0743:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1; AM3PR04MB0743;
 20:kOXQoSuHHbxTg1lFnf+SPinXBMCZ2F5FQmuTxEWvoaFeSS3+XMxwuDZX8VGnyi2IhJK3Ps6aEbhsl47m/Ei/JQWgqMBFJsaHREvAmyv5mXLnZtY0LX4NDIo4q9zNPGTvRzJjG725IxyzKD8tZu5MLz/2towLDIiiiDPrbTLzEgNIlHx3LvSzIrhCWo1DHBaz1cgx3/oiBRxVfsRUu3bR+Z0EWkH4K601ecglVvRR2IICcmYom1riIfYNmAytWMjJFf/mFenfs1gBzI/t+AatZ3oOy5zs4wV7TKqh4NimCzZHZcrH46FOgTbWBD4gPtYP2TtlgPyTJUS8E81E++6XqUI3UZuuvtQbFx8DyTc0aNSc5xWabHGbNYA1hWK3A+2STIQrTbMS39Wc6KAJwvOK0fI77AlcvDWvzYc7UXkoHDYtoWezvgcpvtd+3cuE7QC6dx6y9btYnYr9pgdDnIypaVt3Nzcg7q07idZH4FRjG5J2PsA3+E7xaOrj66IkunFS;
 4:5u0PRA9I8OfSaR4xfBahu4PytgxeBmYXnKl8Ft54pwsRb21DmV6o6sqUBeA0cH/TsyjsfC5TpEO7CGbdOAeKVojbu8RnKH6jkU+zMchgRqsQyMRDioDZbtDGXQOFPbZYM2OWb0lhv/UKGrrqVWJs06QdP5qLKmPpRmGsTUrhGN9l311ya5vbRmgViklUx+HkQ6d66pQL2c78nI55287Av3feOPjECyEVo4Pm12xKBAEq1MDb6vgBTBF6VD7j5MsVJealki4V0WoV/SCbkzs3c+2aXGoah4hsBP8Ov14LFegCdQXJ8N502PIi8d5RHnwY
X-Microsoft-Antispam-PRVS: <AM3PR04MB0743AAF45CBF92FEB15E3D54E6D30@AM3PR04MB0743.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011);
 SRVR:AM3PR04MB0743; BCL:0; PCL:0; RULEID:; SRVR:AM3PR04MB0743;
X-Forefront-PRVS: 06098A2863
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(346002)(39860400002)(366004)(39380400002)(376002)(199004)(189003)(54534003)(51234002)(1076002)(47776003)(76176011)(52116002)(6512007)(53946003)(36756003)(6486002)(39060400002)(66066001)(51416003)(386003)(6506007)(59450400001)(5660300001)(478600001)(26005)(4326008)(53936002)(48376002)(6116002)(3846002)(16586007)(2950100002)(6916009)(6666003)(105586002)(2361001)(2351001)(25786009)(8936002)(97736004)(106356001)(2906002)(81156014)(316002)(50226002)(81166006)(16526019)(50466002)(86362001)(68736007)(186003)(305945005)(7736002)(8676002)(2004002)(579004)(309714004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM3PR04MB0743; H:rhuath.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM3PR04MB0743;
 23:5CGQAdFSal6qojF8gfKMrLfF473eDo6p0ZBYUwxIP?=
 =?us-ascii?Q?8nQxnxjtz5gEi1UuDLUdM0mtIXPYM0dAmy/YGg5BfFD5JRu6l52ZMwh52jxt?=
 =?us-ascii?Q?Bv4v8gAFINaqEo3SeSVVKmuV8S8h4a2joBQJFIPoU5LUKkrfAXMP0hsdYZh/?=
 =?us-ascii?Q?B6o5tjqgHFkau6HDQcIii75oV3xGrhh0rUzITgf4jJLM77mQkwF0uS7TbLch?=
 =?us-ascii?Q?NKX+YaInWAqympTXAYa/i31Ii5SW9mjEHjw0WwZ4SmVYbBvjBjkqYD/OLEku?=
 =?us-ascii?Q?vyvcflr+GdBD//UaJVRoNYUcta7/2aJgkzMnO8gCuKjDhp06uu4eaXAsPCXE?=
 =?us-ascii?Q?IKfkWennkrX4elNabzzf8J+eYI81d1C/91N0eNSNxVw6veS+AG7h/C/bdecD?=
 =?us-ascii?Q?rxqcXlWsxAHMGgSKhhmD8tewazIuYKSFzpu/I32IXrR8h5zY16E/3Ljzmahp?=
 =?us-ascii?Q?yu/N7rB6Vb6aEwr1BOlsnaFSoqohlqns6y8jXuEvI1+tiwBDnfXk38O0YORq?=
 =?us-ascii?Q?lwo1adzS59bcbJO+dLp3IoRhdIy1jak/7qmAFubkJmK4L47bYQ94S2zQ2Dt8?=
 =?us-ascii?Q?xrnXGdc9aFOJdAKOgoaboQAWlLcHsTtltZ563T4Gg9mV8nudX8FFNZowXk8+?=
 =?us-ascii?Q?rnO93eSAAYFUoCgS8Djk5/XQh0sX6Ink4r+dSuhNxxGYQnKDM5fACcvGCeT/?=
 =?us-ascii?Q?8blQgERYWwKANOeyqElos2SIglVbY6LVCH2J5uQ0OOsRkxotPh3hN4E4+hq+?=
 =?us-ascii?Q?BdkBC8oOCq0SI5g1MA3zIhcPXDCmLiQw6rbyCtPEgQZjLDRteKB4NIJEsJBw?=
 =?us-ascii?Q?oz9TjfcWpUkLPFIhXKxRcEzkOQVlf5jwYxebGGT0ZG0ypv/FsgmlRwiSBY+N?=
 =?us-ascii?Q?xGj+Dul31Ta5F01O/MPX97ZeHbhMjQDEyANAyly/c+/NLRKA/x2Ui7OqW8kB?=
 =?us-ascii?Q?IiXvQbd3np1yJ8z4M0jVDlbkp6EnO/AoEVnF7afxiRyxA1XDFJb4/i95QlMf?=
 =?us-ascii?Q?+/OlkMff8q4AGr4HUfFrxeW6AhHOAxjFXn9Iyd2OyPM4wFscgYrKiiFiP3LI?=
 =?us-ascii?Q?i6NX22R9VzLXIkkxQU3LBCbL9tJ37YplifiYd5prCo2XtQ6yDHa4sX64Ghnk?=
 =?us-ascii?Q?0av4avE4baj0a94CBoGSg8bbCway48oY2A0Gvz8hOV9dGKmaJ6HqnAbVKPz5?=
 =?us-ascii?Q?cEIEXdZIKIl+P3m1HVPVD5aqCq25dp0XLPsAQoyXUbYMnukIDE6d6pvGjU3e?=
 =?us-ascii?Q?LswMZB7h6OVBRKxDnsrZwDRdCvrqbJGBtFjd/+964zDzQwYgRsBspmVLp5e4?=
 =?us-ascii?Q?5M02D+7wDQltHRjbQuBTXN/H3Mi9NdN1D4yfu2WB5Z8?=
X-Microsoft-Antispam-Message-Info: EwFNQV4EGq93sANsav2GTl6n5GTCDQc/602moXDyb/CZ6GtFrR6wE1qehNCFJWqY1AGSN5woiImXDDUmX4CBIURUpWT5KLwu6Nvihug2NLwrEXMstPzp2yf5XloENm1UBIs472WfvSjCbyGLAeKJcCyNS9S/SPbQx/DMsXNwTaKlNYBFgcOTcJATk96+CdZs
X-Microsoft-Exchange-Diagnostics: 1; AM3PR04MB0743;
 6:QcvEdOO5AsglnJb7MTwyOI0FUgYlUIMePFpDQENrnJT9dOQyDuFkStq5Fp7ntZ7GPNC+Exdw8dbbysfXhOK9cdEidRWampD6ZPLKAzLFHPAy3poBqlAhM/AWPrEpjReQUqd0huBLzZJnuSfaoSNlcsMowSKSRueYOI5tH2+A+aqzyj1b7bWnW/jdHF4181nFBqmlDz8eM3cVjxvLiAC+k+oqyzeIdDZ6tdggHYDO+Zh9RN6iBL7i8dRJkDaKVsfX6lxsdC+a8cvNqz2vQ2lGXikSJI6jYpiYdGErjSB8HTtMaJgBtBXVXpy7sa0sYaNQ3aV7jhFpRo5kx2B1Ju44MjbH244zNQPeFAjtIQ8LEYI=;
 5:g4uU3pnC0PfshSRWqPv23mObUCyRrLxQoVHa4OBoQyEQEEL9nK/1lanM393k65h/b4ML7v1/yUgWQI+F/Vs99kPvX/+FQl+SRnG5SgCkLdMPHhpr/3vwQE4YebkuRyi9IzSKYf6KatxemUje/pVEeqMc5NrfPih0omsZcqEVrv4=;
 24:t0yIGRCHfrWio7bk4aWvrXuYIQ0tZjHKC1f90kCbGM18De8R4LxWD2xziv9j4ngmG1Y4EJKfHjdSrD/te5Y+el3XkB6ho2r30lxhjYuMdWE=;
 7:dVwsvzOx7BjNvVm2rsdYgkkidSwCkNwgSPRNLOn3QpGabA1brMEe5PWXVzf3qokw7mGyeuiX7thH6+wNfcaTBhdKrOnVqlxZ1ep2cez2hUZNMjxum48aaa+oy+eU4HPL57yyrrt44duanNEnOCD41+1ClnCvilU1FrxFMDRviJVY2CxbbxHueNAQGlTA0FNGKPF5ljA8E16rwBQ5pMQ8nUJ3saZbfal76QoBbpl/4ifWyVyoK2FU80+yMAno2UK2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2018 08:50:10.4847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50920870-44c6-479d-b460-08d587f644b4
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

 drivers/staging/fsl-dpaa2/ethsw/Makefile |    2 +-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c  | 1515 ++++++++++++++++++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h  |   88 ++
 3 files changed, 1604 insertions(+), 1 deletion(-)
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/ethsw.c
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/ethsw.h

diff --git a/drivers/staging/fsl-dpaa2/ethsw/Makefile b/drivers/staging/fsl-dpaa2/ethsw/Makefile
index db137f7..a6d72d1 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/Makefile
+++ b/drivers/staging/fsl-dpaa2/ethsw/Makefile
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_FSL_DPAA2_ETHSW) += dpaa2-ethsw.o
 
-dpaa2-ethsw-objs := dpsw.o
+dpaa2-ethsw-objs := ethsw.o dpsw.o
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
new file mode 100644
index 0000000..b992434
--- /dev/null
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -0,0 +1,1515 @@
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
+static irqreturn_t ethsw_irq0_handler(int irq_num, void *arg)
+{
+	return IRQ_WAKE_THREAD;
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
+					ethsw_irq0_handler,
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
+static int port_bridge_join(struct net_device *netdev)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+
+	/* Enable flooding */
+	return ethsw_port_set_flood(port_priv, 1);
+}
+
+static int port_bridge_leave(struct net_device *netdev)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+
+	/* Disable flooding */
+	return ethsw_port_set_flood(port_priv, 0);
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
+				err = port_bridge_join(netdev);
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
+			free_netdev(port_netdev);
+			return err;
+		}
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
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("DPAA2 Ethernet Switch Driver");
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
new file mode 100644
index 0000000..d1930b6
--- /dev/null
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
@@ -0,0 +1,88 @@
+/* Copyright 2014-2017 Freescale Semiconductor Inc.
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
