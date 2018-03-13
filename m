Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3262519-1520949158-2-2338191195540087596
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520949157; b=tQWHMCqzd7CY5wFRE6R0fqSQ8kXkKHc3ajetJPTaxumHnN6
    OyMy2pqaWFjucnSIoxNFb/zPAFMCQSd6KUkbQ0aR1xg0E6j3aOENV5ZLWTV9yhXk
    ZezMTnOZH7PKsz9Bo7XYcuuaLf2MeoZ5p6gGzqc/ck3+I18Y/d7VNEi/mkrpLpra
    Nd5kvFOIPUeoa7BgiVtdNynRKvtVZ5DVMrXBHXgaVg4wUSBa5Tc3VWi1BeEionZ+
    1e3zF2RfgnbZJYuNAJ8LTOA0DsebFCAW0bB65PQhFRqKEwKUUBvTjl2WVRKxtTwf
    1uk00pSWFt2z8MHcuYiESyVjHsJqxoytoGX+w0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520949157; bh=G
    lariqdHeyf5zHW+Tmdt1dc14X1H0WI7zb3ldKT2u/Q=; b=JGzAkEHtCLKxOfT0x
    i9IWkZixmbJg4K5fKZJ90sKnUujIOZNSzrq5Ex4tpWKVXqzHJpjPkS2dSzTJogM8
    cVxEPSh2AAzHr3D/OM4zPu0iW/zFATCJH4zQv1Bmwp1ju7Gc6xOEza9Zpqp1t65n
    ogjwQmtL7zHd9wo0cBWMo0dEQsTRsbpAiNwTIgTI9FOZg+OSZIpahbDjqYsVc8fU
    EMCMLtInHzCG7HZ4ObTyu/72ityo9WC9eO3gxSAJooN8O0thvBwDQs3etg5XNh+g
    pwPG4F+4mOOvTKzWFK5lB7rb3vQU9jgcf0hqA4QaZ6L1g2zktocbegMr+/R5KOkh
    ePmXA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=gZTk+x0s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=gZTk+x0s x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
Subject: [PATCH v5 6/6] staging: fsl-dpaa2/ethsw: Add TODO
Date: Tue, 13 Mar 2018 08:51:56 -0500
Message-Id: <20180313135156.3322-7-razvan.stefanescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2af8fe2d-ba58-4819-b64a-08d588e9a65b
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR04MB0747;
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 3:1PehunoVobxi5UEerqPtKwlWdqQDw3ICB4ItD4to8qjuDEWy9FcBdpaNQ+SQAiXVyffE4KSI2u9L/3AnCb+1gb3CE141vmSo3hKLQY3COK9yj5QfzoTfQSk5Ej85Qs7GDEvuCA5gvnpQ3bXmDqxyzZl+vLnh1rNJCmxi+giaZZ3d46n256qAAJb5JfbWfjH7q5UElLRtlNlBk0UeUqGKs3Olf3boAtbCaYrsqpwP1UdRrBxQi1jaDkj0Xb60ZFuj;
 25:xPUgXksrX2VcL/k2Rbxi4OspXPqCrbcPGW8idrmrkZaesQ8G5Qn/y0QjVDFaNplkYL5wuDqJZKYuJBZwmGmlLo9U9KLwj42tAljcRaTVogW768h/eoGbBnbiJdkbaC6VyyhJRcxEYXrBMO4BhmdHxNrBV1mwXaw2F4vCoNFhN+jPVEoeOYAfWr1H2A8H9YjK+WjOcV3Q+KX15LKrTJ2KH+eCGfS+bSIAHX8lKJtjOw95gTkVu6RngmgwrAxjvBiQ6o0/JOVoDvNh3jeGjU/glmZkaSmEHNbo5KUXPxzUHqWXImNTDWXKHwkXy5FjjjHaAlaLpg25kFQTKmFpjoYxyA==;
 31:wFzqXYcVMBhv6wy+9XERZUW7QhK2BNOphIJTBc77HSicaJIc4ePw+6V1A0ZI+0u9C/sFe/bzVhNkONQgVY1G11nhBxP1fsmTukFRq+mDoo8pfvXSXqJ/3aF9vzHnucGI2o2eT9gDUiZ/1LTmU9thTi4sSz0Zdy9t/KFpxBGXmd1wSB8SJ72km+Lub/BvbhyCDm6VQXd3YLp5AfGzuKzG1m61l7BktU/sP0C24rFXSSQ=
X-MS-TrafficTypeDiagnostic: DB3PR04MB0747:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 20:5CPJIPmKrYaYv6CorbnR/cZIDEaQJ6MjNddf3JDD+Ax87KJt7b0Lq4lRB0eWKH9eYk0gzoTiBP6e9jUcTVNHLuuDkNVuWVlQaIt+8UzD8w/rMpGhxthNvGiZShfz2wxTqt7gw6qftT8zqpESo0nSFo1I3B1Ik+Gkv96FdacpC08bITGFELf8VD8Tn43jxPWEE/ysD6sFfgx1KXvSOpVji2vn3Af4Ubuvk18ybo9p7lB5fUhMAH2nC+1V6Fu4OjY39atd0ECxz6CuOVDeaphgTtBcyF3UF4ndrvieTjrf9v9QC46cuBkqB1ZYNvSC+VpqmlXF9toD/8zbd+AE3Q6L5KQzxOlEWiC9o11OgkEJ8kKFlDJE78PEEJ+i4oqXQ4ZwAFv0blVnUGs4VuPGLk1/3qdyiSOxjGKUvo6DeJrg6qUnfQQGMR2fMDwcPtieBrgaphi08yA7b2Otp0mLi/XbLTJ/YQx7HoM1WpbfxuC+YMOJ57xPCe7GeywudqoaHFkz;
 4:va+4V1YS7L3KgrPKkewv76enZRQ9g4AJ36WjKzqWzZQwzDZwxhtFxHgn6GwKymVKAM3ybFIrLRRwHU820nyBgNdKaDuAKHEmS4Vc2c83b4nXgfiNuOrfLI6wJX3u+64Of4sY6KXq5iq3rboPedvvazalRe9cDg5gElDIuEmKDXRNUA0xWBrGjcAvMZFzr7QVCizyhWnonMvV6zcbBexHst7I9dXxzGnDQIZ7u+uB5buWJrBdX9s3StLcT3mmoffnFJmeBmF3Ket6NZ9EA/IA3VEL7XfMwSEwc8b3MXxsFT0PVa2mwVvAG9UzsPeNrDs+
X-Microsoft-Antispam-PRVS: <DB3PR04MB07470D7CC0BFC48BD2A77BF8E6D20@DB3PR04MB0747.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501244)(52105095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);
 SRVR:DB3PR04MB0747; BCL:0; PCL:0; RULEID:; SRVR:DB3PR04MB0747;
X-Forefront-PRVS: 0610D16BBE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(376002)(39380400002)(366004)(39860400002)(346002)(396003)(54534003)(189003)(199004)(1076002)(16526019)(186003)(6916009)(5660300001)(478600001)(50466002)(48376002)(3846002)(6116002)(8676002)(47776003)(6666003)(26005)(2906002)(7736002)(81156014)(2950100002)(66066001)(81166006)(6506007)(305945005)(76176011)(386003)(25786009)(50226002)(52116002)(86362001)(8936002)(316002)(16586007)(39060400002)(36756003)(51416003)(106356001)(68736007)(6486002)(53936002)(2351001)(2361001)(4326008)(6512007)(97736004)(105586002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR04MB0747; H:rhuath.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; MX:1; A:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DB3PR04MB0747;
 23:/zt/CpL1EihO4QHN15BL4Asm29iE2wxivvS7IMLaM?=
 =?us-ascii?Q?NnY988o9HDhN6qaelq9ll/woWxtwaf6e4++TnNbBe2KlkG0vCESaaPbf+Svk?=
 =?us-ascii?Q?dmuI4SrqVxHQXqM7g/ZpuU29ZX9Wmo3q9frtHh5T1rDZz3claGCZhsSO2Hxg?=
 =?us-ascii?Q?px5IrnIh9j+nH48p/XxuaxT4vIhBcDR/dcSXZdLBaQF1/o9a98t72HznRthe?=
 =?us-ascii?Q?oKGoX6/Nuk39CoCEF553JsMkjpIbfRLemmTBIYnAa3TzWpvJmi5cwGX8ai2f?=
 =?us-ascii?Q?50bdLEbnRtaSVXcXXIeG56sZJG7ztzxlgx+Et7gzR15Cji7EhU9sW56Kuf/7?=
 =?us-ascii?Q?2CLwOWWLMOH7vWrwHdnmxIadOA3l8gZDY9vpTZvK5yZJCB3TDEowc/NWPH4k?=
 =?us-ascii?Q?CSXyFbaIZV2SzN4d3qNL3OCPwrKaxfyIT447gfjEmaVJhH8V2qKPTsWjdN9M?=
 =?us-ascii?Q?yfZRStSNFKbpnKRMwmUkaffjWB4ZYWH8dT93tziF2ua7MjDceEaLTEotfNuO?=
 =?us-ascii?Q?jRmmT087svLfl5/yKVRdlv1byFAS6+AaYFb4tetBOgtCjWQsZCBNepSxB+M+?=
 =?us-ascii?Q?tXabmrzW/8bjDyOvYCN5y8rJgndtLAL4yN0j3kh0ze8ZmzFCSV/Psa8i3x6o?=
 =?us-ascii?Q?TRmTlYxqvLWWNHFv8wN1y1dUM4CNTTN5aBzjHwnB8TAs6gBWuh2zMBrignPz?=
 =?us-ascii?Q?wJmj86TPqR9CLmv/bBp0syTs7YhU/LJDetQgOL4Zhq5jrT60BuGTWhnHRVTn?=
 =?us-ascii?Q?+Pbm/Y0pnSbqlpvGibTYpvjXGRC+3ksceeoQ2GsMStvZqXFLWclFQmi6YZIU?=
 =?us-ascii?Q?GOFNOi3M+Cl2UIDyhpOpriC3SvOXXl54zjEVbjDxdGpB/cpSfq+kCOtJgQdq?=
 =?us-ascii?Q?jXGcUemDP6rM3td4GVLZA7GEiAKEXtLWxYB1jCfuxMeah+Z44H2OYn7mnR/q?=
 =?us-ascii?Q?doyAwoAM4YLxgwPzR0xFykfwzOi1N3xmxHgjB/wOueNJx+pMWGSjGZ5wcZVh?=
 =?us-ascii?Q?e1WY7A8fvB4wbmu8bfmWTo2L1Tb0EG9k+ZNb9P6bRW7MpZ22yxuLOwWU235X?=
 =?us-ascii?Q?InM9BIngikAZu1nK/Dfvdw6U6CmjLOeTcKhgZw7aE1ZYDN9oIPPmG7g9vxwW?=
 =?us-ascii?Q?qUUsF1Ohh7JWdUDTzXZ+cdo1JEKl14iJSGLQ0ElZtP2rRtMGYvfDB3AmlQ+p?=
 =?us-ascii?Q?t7soo/VloI6xoJjifdXZDX5+d1Y+6jYOb2S?=
X-Microsoft-Antispam-Message-Info: PnTi9HSWxVf1ySuQ2uuYkCbJYHrQ10o/KjPdv9QNWsfV1A3W2VbLM8/AzwQkYbUbybDhAWFifygplt3JvQldhEmkmveUdvTBUaeuEc6/dO/St/UHnpOofdxM/XnaTap5HZ6wi0JvOCAjY87SzNsATzzThvZq2yn30b8PrNu+RsIrgwOBLCy+rPJk1uwp9EnR
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 6:gGc0eFAQf4OJtnkSNn9/IOIjxEn7ecUhnwRJxjiXFdQ7rGkt/KaHdXScZBB0o1azYfgRV20+m95aSXSYk71CLa/B+pwDQWFPppLspzN2GNF9q4yIdf/1CcApPM4hQZfzIX83qhVDQnj1pVrApXbvL4XOeWs0VzbUcPx6L7jqMoUXZ4JblCpIXJXSfCqktu+3i0+AU2mjiVzLm73HTNXLUnTc81uzcCPbx29IT/lkIUTBE4z8vxLG/9JC0BSmQGUfBEhDbmx1a/8wTpRn57Irn6fxv6deDer0T13ggiX40IM/Lj7LRuTcg7RkIfq8/Bq5HE0b/qYT7Wxnb1z7jipaMqdMfI/RT63eBDyX6XsEWJU=;
 5:sJCUhToeLlDuo9ifk8GFchEVfkegQT6EqalpeG8ccvZFCULZxmlTDCYOE8AaGqOPvYE6aHPINW+eVrZBrzPkj9SfJxs6hYQEMKsXhPgIdt2eK2BDwkhHHrx2IwdDTak0AhSa6xDjLFyKuydxdaYiGh2ZPlFk9OYcH57OV2rwXjk=;
 24:BPZjm2/DkiLMbL57ORx8aB6Km1KmT32ZAGhY7771ztoVP1CoZn3t9ZWl1ESb7oxiyvtERExQyT5g0X7WvPQ5/ipKuxOHVQ93qv/L8Nb6h9A=;
 7:3MIEBkCjun2P/7WNIrlZj1BFVifjPn0J2CG42bd8vw/ehi0UDE9wnrAACc757M0d8svii23r7Vg2ydnqJmzrbFZxaYiNLj2oeVU3TfmfkqE2eMtaC3gCqusUTH4a4n6npdFsyImL+F+NOHmT/4qJcR+WasqpMruQGYkGsRtmygQ1z8zZkSthGybwQLihp0ZfM/+NEl055kiacgiGT2TCXti5x3k90RlDDqlsdCho3qA8FAQTSUOvsxigd3nPFaF7
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2018 13:52:22.2578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af8fe2d-ba58-4819-b64a-08d588e9a65b
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

Add a TODO file describing what needs to be added/changed before the driver
can be moved out of staging.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
---
Changelog:
 v2:
    - no changes
 v3:
    - no changes
 v4:
    - remove fsl-mc bus driver dependency as it is out of staging
 v5:
    - no changes

 drivers/staging/fsl-dpaa2/ethsw/TODO | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/TODO

diff --git a/drivers/staging/fsl-dpaa2/ethsw/TODO b/drivers/staging/fsl-dpaa2/ethsw/TODO
new file mode 100644
index 0000000..d186875
--- /dev/null
+++ b/drivers/staging/fsl-dpaa2/ethsw/TODO
@@ -0,0 +1,13 @@
+* Add I/O capabilities on switch port netdevices. This will allow control
+traffic to reach the CPU.
+* Add ACL to redirect control traffic to CPU.
+* Add support for displaying learned FDB entries
+* MC firmware uprev; the DPAA2 objects used by the Ethernet Switch driver
+need to   be kept in sync with binary interface changes in MC
+* refine README file
+* cleanup
+
+NOTE: At least first three of the above are required before getting the
+DPAA2 Ethernet Switch driver out of staging. Another requirement is that
+dpio driver is moved to drivers/soc (this is required for I/O).
+
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
