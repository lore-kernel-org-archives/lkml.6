Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2033369-1521042998-2-12430296089995839764
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521042997; b=gkqxsdGbikJaEdd0j4DXdWYVDCjrXHywxJ24puF1sKDEtnE
    dQM38dBbyxsYkpxVv7u/sDPVCpGgAfndnMPRTSAA5GI0cUnp5oeyHJRj1gMHLDe9
    n7UqQ7YFind4v9Goon/AspxinwJGRGv2RQ6y8pNV+g4rAnSSxYhsyji1pPrLuAFl
    GUMK0lujBeRkaKHxCnRutCO0eSM9q40YBjmOjRwoNGeCmFYRwE9ROiKJdju4Nvb1
    QNyAcGdsXPhlmcGSGWpcTh2hVzTkHPaR82I5dy4nMNLUJq2q1a1z1E3ndciQku7j
    8ofjhPHWeZdzizd6xoQuYr5cVXYhK82eOe4sWaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521042997; bh=m
    ppIlXosYzd96CV3S91wQR9Z0Pqo2qJyU35zD2oJZdI=; b=sFERwHwjcPy41U7NM
    OQ2OaJw6G1yqXv23p0MuD7CtVV2N7+rZdQBHwuZHfEJNDdBHrFHRzOSKcpzB8ZBC
    te5Oe7LaTryKfHn8dG55qFaOnASa3TGT2lUK/VcCmwyNcw/VgOdGR5oVfAcASeik
    bVKx118T0W5E3d4Hs3pb7LCh+oKtAWxCwBh73wqAMG6m4PYp/O3UlkZbMsnsCN8W
    DhJxCMRT8U6jTIC1XOo+KGVSif6bWU/9Cwp1z18Xhm7Zv06U151GkAeFFqJzPGcD
    Drq7N8YllglAu+vTAtHno2KoFsOCVkMHf5YWkzVD1GKmKFzXooRXXBKf0uxTXBCJ
    quecw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=Rsxtydf4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=Rsxtydf4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=razvan.stefanescu@nxp.com;
From: Razvan Stefanescu <razvan.stefanescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v6 3/6] staging: fsl-dpaa2/ethsw: Add ethtool support
Date: Wed, 14 Mar 2018 10:55:55 -0500
Message-Id: <20180314155558.6898-4-razvan.stefanescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8b186ede-1c37-44b0-da33-08d589c424b5
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR04MB0747;
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 3:kVjJJcXKDiE0atXev3BWuENVN0awAjByHJ9Id4ck//Du6U49twlJAI2B/b/f1VwlutZqRN2o9QxckYOPeU6pysTPQUOTXnIn6r6HXAcPN06IOJLiIjSCNstEZd/K5BZEVaW0T12HZiBydAznY4pr5+U7scUKbx/f9j4L7wEQMiYTGf+p8LyxT+qnmJ2t9/UtXLa84e4uwyy/yheQbK7f6M9ClCiuzyWXJ/QV4ogiWVlrShhBvTipyFEZb/gQIGHK;
 25:OUeH5jwHqfcojTABNymOOe1pnFyOrJIrNIKSLLFS6hU+ofsSLSGEQQzGxlmQ4pt6vCKmbuIVNgh0ifJcfA4yhYTGFVV2pLwOZAXJaBhmy/l4bi0BqhUOcdIxggz1wR15tk9N0MvvEClDmGuoSPH+RTW+wZa8cFh5zHGtgLxc6SfPZtO2GXNCI4KZVe2bn02dGQ+K2oC06AjVIyc8+B9TRw7oQY6pkvm2VSJSWZ7IuXgYvkx95HesjByKk0GazEk/IeJkmV7J+RmdrmyWzYA43OPsHn6NIYPnCuHeI63Ut71VoQdY3aTUghF3eYKCa0QLJlfTYaUc0Q/WnpGq5/Qxwg==;
 31:G/hwxnJrOyuZOaFlPnwiTOX1u2qhsbymK4lploWxPqAhLm8lFhKqU8sxDnGYqbw3FjyGluqkklIcBGSFWaGvNiKAZHvhasB/TZ/koUf2yp5J2XE01QlzvLDZJpw613+SYTxCs2mXdnqi9ZlqsNOjgIHxPh530mHVdWXb+MAz6CnOcLuMlw2vhWg0dil4MKi4+rbxSzFNlGj2SzF4CupGsmhNJWrNiM7m3E8R55ND1HY=
X-MS-TrafficTypeDiagnostic: DB3PR04MB0747:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 20:RFvYa+Gg4RgIwUkumFVOlFj+3feGer44QQ0B7uLCmkim1aeDuDR5+S1aYEEwXUEERKT64chK7hNKj8668bLctb8759uGupeH78lVFGFu85dE9xe/mtntX8yfJ1k7rkfFLWV2ung1p8hN2lwbDWkNO3w9zHmt6QwAOHHVLkWhpy9tg2RGuq0OuVZKt/lCTUrAoTTWx5H8/VGdrvBVbjWn+Duvj2u6DhjzQgQTvj3F9+VHizHhA2maB/cdifrxNJOsKjYgGycaJPlMZnYo5DMaAIcDTY1MLwO1jakSgxxq7Gv+B9j0ety6Dy5g2qIF67Y1Al6E4Wx3rVHNhg5fZ4ogpdpz185hVYBs2N3mohPScZGwzAvD+AsGD3ornQ0lnuyxHrHfNAAyJS4FF60+a0znxf6szkaWI90Nr9qHOfAa/xtD1tP/a4EGD0VQHg/oADarEwsXw2ujSYVsQy3ABugGbl+vLPoHWo3/V1sD79cfxWuq3svzAu4KTEXHEoXi7OAM;
 4:3VZXeUP1owH+P0FqaUEPdeTdkoTxRFZ4zonUzHE2FPSOOgp+pRX3sVs0BrO+MHDhG0j9yNHP/LBSH9cfT5MxKpYLSNo5h4Ri3DzPgVGYdnTt4QAn9mAcCccegQKOyactNfnazsPD+d3mLtTvBPJLo7f/W/172kMoN7B2wWVmta7Wmkzs425Ot5tOU35Ta+jDETxWACYfNPdw8hUgC8pw6lSEGKPfcLOTAUrQYDrAnssg0aYq8pfWPM4QAo85RToQ9cBgw4vr3j2P0ZYd4GYngpxetvxTXXTUkqPs1gSTPujgNuyPYMfy5xftqSbRwRCqkST/mzVPQpdIELzCsYq6pbSi7mZmYYfH2zBx0apsSRs=
X-Microsoft-Antispam-PRVS: <DB3PR04MB074702C8821D195ADCCEBADDE6D10@DB3PR04MB0747.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231221)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
 SRVR:DB3PR04MB0747; BCL:0; PCL:0; RULEID:; SRVR:DB3PR04MB0747;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(39380400002)(346002)(396003)(366004)(39860400002)(376002)(54534003)(199004)(189003)(6116002)(3846002)(16526019)(386003)(6916009)(186003)(76176011)(48376002)(1076002)(50466002)(478600001)(47776003)(6666003)(5660300001)(2906002)(26005)(305945005)(575784001)(81156014)(66066001)(7736002)(8676002)(6506007)(59450400001)(81166006)(2950100002)(25786009)(50226002)(52116002)(86362001)(8936002)(316002)(16586007)(39060400002)(6512007)(36756003)(68736007)(6486002)(106356001)(53936002)(51416003)(105586002)(97736004)(2361001)(4326008)(2351001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR04MB0747; H:rhuath.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DB3PR04MB0747;
 23:6rY3UAnW7cdovYdoNeGWI3QK5aHEZrC2s+KBircwF?=
 =?us-ascii?Q?mtkiqpsXwe9ev0spQlcFdxKZLNLTkXjE8qIuxMmd08HGsQwUT86yo+6pY/qp?=
 =?us-ascii?Q?EMC0TAAOpkFJgPdiWZBuuJujv3ToGcrT4xrYS1HtnjZVVoQPFPPRy3UCpGEQ?=
 =?us-ascii?Q?lVkR+TNSotowjrAUgQoqyqrOJz0xByubJgaxlewe3o5lmphiyvdTuONKqXWi?=
 =?us-ascii?Q?svrw/I/ICIsuU73k0ixrwUJlu4jZ8AEqYc4lC9vQ7vw/Id0I4WC/UhZQr8h1?=
 =?us-ascii?Q?bBOR0F8tjeUOw9FkGdD8/po+OWuY/iJh5r6A/WkuYg99LRBTaECduK8zVohV?=
 =?us-ascii?Q?2PzQMJgWfm3kCBhI3MdBmykPQ15So2Ap8ePDjfDTdRC0JNyLJQ8h33l2Kfys?=
 =?us-ascii?Q?eeTqR5S+Edtg7yfrqTQfXAOntAEMs/xF8A73FzDJDJukzHdtRTRVlUcXem6s?=
 =?us-ascii?Q?XIw6ALR+t8VZozjGB5hfrTS+p9f6IIFN9PQgtOQAaHJt8UOhJVekHvHjEeH+?=
 =?us-ascii?Q?SGm9VSXJWNs/jVmCSm2JEIVmu2I+snwG/WSXvrK4cPCS9vCicrbsQeI8I5hR?=
 =?us-ascii?Q?anLBe02eFc243qHbG3AMbsECXKACOcQ45yP5ToAnD31z3d88Ipg7ee26qDpi?=
 =?us-ascii?Q?VETPfH6GKp3gdzSx/lWpUm7GN025nQgmxjJWS3ME4fw6qzXK9oWpmWbKn/j/?=
 =?us-ascii?Q?vRUgXHJuW+p3cD6TG4B1QPOdOvAfEroOX8LJ4BQNVO1f+A2ZY/8EKBfwtH7r?=
 =?us-ascii?Q?0crWwMQYXlCjJBK8FYhUQZA3hKYmBaO9DKTbfDQQanydhbCFZHby5N7qlaQV?=
 =?us-ascii?Q?1AxLxkO7UsCe3G2R7WahgHF/HUJAQhvZeuWVlCCLH4mYLitr47bCm771CBfm?=
 =?us-ascii?Q?hBE5mMvkQkMqLQdpL2RCJAD2Klfg+9xpFVF+n5UG8FzTEp0bKL5UoW4sTVoY?=
 =?us-ascii?Q?hdoHnm3GOxnaxRSlQau4Rni729G46nhWadJ0x8OYIGFHFVMxZ/tEDRFaNNK2?=
 =?us-ascii?Q?repWiOu8XeEKCNo/XAOiB8GfmPt9gCWkar+FntxTzj/jiUrKdCgVOw6EeXB2?=
 =?us-ascii?Q?LinHpmmWjTiGEKEq96NiwFbqYdiMh4XRsW/8DZM1cMPlHOv93Hhc/gKlSf3F?=
 =?us-ascii?Q?sdUBEhwd3RKcKrYk2eaL9JtT0U4VL7DWtxyKM8CHN6a03LpB0PwIzPO7almW?=
 =?us-ascii?Q?zOeae7SzT+I/rjbvjVdDARFGNBsCmgXua4CS/6d7+tPwQ5qB0HL8BKW6yrni?=
 =?us-ascii?Q?4NsOgT50aVCIUTXYds=3D?=
X-Microsoft-Antispam-Message-Info: UxwCxWLW/gtBRtvFbmBNnrCEW7+oIFFMN8kZTJsUrfM8puwk4SDYYmCqbgcGFlRRNTPqYYQWmbJPC4fNRYjS8HtqHJiEW9H1rSzOJGFpkGY9d1pG2exYsJThHV/09wLLrHppBrG/tLziCcpmH8EnJAZkVCCzUm3l7RI0/LJY8+mjsKNGndPkmEJQzzJ9D5Wj
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 6:Dmz94tab2m6gOxyXLxmiTkTLnFYCNKWsJ0snuNViQPnAqyZw/ZowHzyb1OaugNuK6dBvZ77/TpHzUQZHdyZ6qNhZuvss8GowyOd3BLJHF9O2lrz3uy2xEC44jzXJyXTgwmhxHEiP/sZNKIbDGJwtalF28z/LeJUhYd2x0QZ2UkDVe4Ae+oB2An+zKOArH4haeYD8+54kaX7m/SrA0H+hK8pAPDUGUSVNPbMBBUedKCpi75wYELSo5sv4PmukAkZ6eHfDlAl3iRJF3ENYlPj/VpfZhncc3GsLzlTgzK/xrKEpDj9ZOHq6NdphmivTQvP+tQfOX4GhD4zON3RMLMov8HROTAW85hP3r9VbKMRWy4Q=;
 5:WIIA+RFTAzxdEHhJmThvozaRd7YLk0gtbbl3/IguS2LQUPgvao+VzRbqV+JNzZRMbmvTyzKEEC7YdlNN4/1EtbgXfHFySUNWCGbMKeQF44PFcP8+kVi9TTUZVxdreHGQS7RmaunVXACrR0hpWEa946nwTmFlXzd1yJweLisP1Lo=;
 24:HwCt/pBa+bXICL3pjtfVboyAHkibWwqULyzc39jc+CdnPFqLTtZteGGVef2Hog8o/vkyHex5Mcm7mqWIv04PUQ6+4glsqYUMPWiDWPSQDT4=;
 7:oah0trnmPufQ5FicQ7ehFDs8im5KzynMqUwenLeknrEcdzkVR5C6P0IJv9uFZ1iTuKzMtptHQJ3h4rHnDhOi498FTrMQYUJDGOvqsmZ2Tpm8CNuCgW0k0f5OPc7Z+qsOU8jCggsruJ8gxMlsR9D7YqNDjxW2I0H1/lQck6ffe3cX+w98Xim5jEK2oykUowAvn2bKP/1uZG81nZgjFszZBHCkvJM/3lB1Tf/6jBvreNNj3lEgJDQxlvDnzkLztqPE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 15:56:23.4347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b186ede-1c37-44b0-da33-08d589c424b5
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
 v5:
    - no changes
 v6:
    - use SPDX license identifier

 drivers/staging/fsl-dpaa2/ethsw/Makefile        |   2 +-
 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h      |  13 ++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.c          |  32 +++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h          |  32 +++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c | 182 ++++++++++++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c         |   1 +
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h         |   2 +
 7 files changed, 263 insertions(+), 1 deletion(-)
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c

diff --git a/drivers/staging/fsl-dpaa2/ethsw/Makefile b/drivers/staging/fsl-dpaa2/ethsw/Makefile
index 7755603..f6f2cf7 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/Makefile
+++ b/drivers/staging/fsl-dpaa2/ethsw/Makefile
@@ -7,4 +7,4 @@
 
 obj-$(CONFIG_FSL_DPAA2_ETHSW) += dpaa2-ethsw.o
 
-dpaa2-ethsw-objs := ethsw.o dpsw.o
+dpaa2-ethsw-objs := ethsw.o ethsw-ethtool.o dpsw.o
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
index 07407d5..1c203e6 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
@@ -49,6 +49,8 @@
 #define DPSW_CMDID_IF_SET_FLOODING          DPSW_CMD_ID(0x047)
 #define DPSW_CMDID_IF_SET_BROADCAST         DPSW_CMD_ID(0x048)
 
+#define DPSW_CMDID_IF_SET_LINK_CFG          DPSW_CMD_ID(0x04C)
+
 #define DPSW_CMDID_VLAN_ADD                 DPSW_CMD_ID(0x060)
 #define DPSW_CMDID_VLAN_ADD_IF              DPSW_CMD_ID(0x061)
 #define DPSW_CMDID_VLAN_ADD_IF_UNTAGGED     DPSW_CMD_ID(0x062)
@@ -237,6 +239,17 @@ struct dpsw_cmd_if_set_max_frame_length {
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
index 3f9b86b..aefa52f 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
@@ -358,6 +358,38 @@ int dpsw_get_attributes(struct fsl_mc_io *mc_io,
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
index 6de53f6..3335add 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
@@ -220,6 +220,38 @@ enum dpsw_action {
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
index 0000000..926a0c0
--- /dev/null
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DPAA2 Ethernet Switch ethtool support
+ *
+ * Copyright 2014-2016 Freescale Semiconductor Inc.
+ * Copyright 2017-2018 NXP
+ *
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
index 5aa6e95..c723a04 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1376,6 +1376,7 @@ static int ethsw_probe_port(struct ethsw_core *ethsw, u16 port_idx)
 
 	SET_NETDEV_DEV(port_netdev, dev);
 	port_netdev->netdev_ops = &ethsw_port_ops;
+	port_netdev->ethtool_ops = &ethsw_port_ethtool_ops;
 	port_netdev->switchdev_ops = &ethsw_port_switchdev_ops;
 
 	/* Set MTU limits */
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
index da607b4..069c99b 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
@@ -33,6 +33,8 @@
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
