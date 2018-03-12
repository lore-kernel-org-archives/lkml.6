Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4009665-1520844640-2-7070263145025786251
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520844640; b=q85wFR6AtnM+Kr1ETJdd5qtTrLxq5QkzDmXUnR5LAhvoPxw
    FJMRFugyaptYs8ss401r/C8HrSh6bivU9yfSP7JLZqmiTeHv5NA1/N5FC2dKdPf5
    JssFPYtEk2fCRPRamvdHbOCdTNgghejnQ2voSmrb3DhhETkBwlmHZ07RL0ixUvHk
    JvmuTGCma2IJnAqY+aEd/X2WZZpL3iIFoatuzYhsvNoTb8DfGnLuhcbvj+v4eb/6
    rqG6rIVPHP/vzTLTC9YZEzO9+U1xluscUBFlVBs+si0o3acln5SOzPrHuNS11yG0
    2WNiVUm/Y1x/avVb6c28WWsGVBJeb7jN0iL4R1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520844640; bh=l
    2Trsx5EqUVVLHoF140BBwza6RnWq04QDiUXx27m7pU=; b=Iiteh/WoSxYUcR+BY
    8KD8BVCPHLBTTwN9Op6IggSoMbpyMD614OrEUIuWrk50GQUdasDVMOy8y3qOArhK
    C+SgOay8wMs9rxdyUcXDctLPKWlszTrom4L3Mf0LtOqx9QdA8314dUJbDtipsOZv
    qEwnYklJrtiYPHXA+DQh9drnL1nYxlUpJooHN4PHRyJtK1iGapuV7GeXmGctT0iF
    KkgdoBz+gwkkvVsxI4nO5MOtQpV4FZfE0fmbKnCngBF7j8fcoOR3FaZ1ktTS+h+W
    b+0hT4ESZVzWN1gHm6f9A0OZpYLjGFve0sdO+pNK3M2GGIqZNbq2Illjf/5qjt4F
    sSctQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=kF/Hpj7h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=kF/Hpj7h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
Subject: [PATCH v4 4/6] staging: fsl-dpaa2/ethsw: Add maintainer for Ethernet
 Switch driver
Date: Mon, 12 Mar 2018 03:49:53 -0500
Message-Id: <20180312084955.12686-5-razvan.stefanescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d6773ce5-d735-4e3e-a4bb-08d587f647ce
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM3PR04MB0743;
X-Microsoft-Exchange-Diagnostics: 1; AM3PR04MB0743;
 3:+yyMGWF6rmY3fa7orTU6XHRXjMJVYUSLeOwnscw1em8OYzCazEOa+mWlpWZHSTOEmw76CDqDfvZmcDyx3vT3UrM/CGmJWi6fmpDZ03OzZnZ4e30V3DS+pJDd70obwx7zbZDW77bHh8zAuAlpsen6nLjH19fXkOadMFW3nXZMuN9UQJUjuNWS6m3eu1qz8mbXrj69NMXhpyyqwgfLl7VdUwYdAWbath1ccFbIe2gbrVZW4rnX8yocARWwFyp3CSec;
 25:SPrIFieiG3NWLQ8pcf1F76+odAFU6JRaeIax25/OXA7H6Qzsm5Bu/AkOjtqj+7MEzGs3aVSY66oTXcmcqrG6tEReP8U9OkFA5Wqplb3ih6puNQ5HBjJJPmmtTWHWYF2lNBKtD+2iUcTuph1w4EMFLBoeC13IW3uOlxoHZe4MXv5eNE6uA40N+GPbI2hmlS3w7FIorELD/RR1X1kMVumgeILG+Eo1KkPNiF3348k/B3juieKF9FKuW0SaAmQ0KrCdVA+9nTNn+btF/ZvjwfdFWRl2VqZSf//txgB1UWfhC0Si8aQzgIK+n8+A4QuRJc1UgGURDzimTjNb2sih4FCS1g==;
 31:m3Adu8EEcV+iudumz+AkZz+knThQvXLlpYr9eknro6zem9IVSuNqZPrTOtHfFUle5hun3cCUvXovNrzTg+G20TlS4AUcnW8PsIQZqR9Ol44jBmV02BlVjsBmGUTPRn8p6jn3QGtZtiZ20LgJCXN+PCBvBI5lG9sMeCWXLgILUv8qVP2wx2zX5Y0B4W2DmxaO3lDFt0c3rd9nM0NNMyJ8dkuh6HTJ1oIJBqjbW9tEqAc=
X-MS-TrafficTypeDiagnostic: AM3PR04MB0743:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1; AM3PR04MB0743;
 20:osXe+QGF4QyysJ4qRP1Lz9XZkCaJrlaMyKGjL5asAVzU876A5ya/Y9Cw72zU8k8gYxfm2d+UVqUFnQ9CTc4jhdAilKUp64yyox6VxwkTNC6H2zCQnYOWKuJbJCL4lt8aLqBU+lWhorlJ/Jt3BZ3hFNha9yd9AvONAJ55ykwkwqXiDwV68zcbGs/rbDR2W6pdToQBRL8DdCHjtPxUrFs67e+kXE4j+p5NOTdBb02Xva7gUwsTgLGBNv2t7C4otQ5m7RFOWYh7YVBphBvw7hDh4ruPsKoR8zyyJNS81gsOJGUKg+N+w7SpSpDH7hSw4K1OXiN0K8gJVaWy3ZMZZxHmfA34iFmjAsb2jmNKVbsaDEHVV40HZin6yRaqHMipoPc5ASV6HGzZdTE+xauPWMW7dl8E68wcybTj7KAzpql2M0vFHmfZ8RYGGT2/MDLc068zfBUfCCY/vL2Z0WRaYtLiyYutq9AlVxwn5NEVHZvYgUVnkPY1bqu/XOqf2Gi2uaUx;
 4:R3opjAueEb9IBijIkdSSMjF1eFQ9MwJ6+x7g0q7hzLKG162R6S0/NFNMkWNh0vQnb/pX+8gjBl+hW+D+kq/3Pz+CNfVytFGeqYgRRMDyVfPmh9i2uHt8R6HbvoFNrpZLHGFydUw4j74rAb+0q/loBv87AorQs8l0GVl80mzvJ1mo3hBgkBzVyMnW+vu9Zc/MOADHTZnl22+JmwROM6GpyMaGAtYwtWSJ9MxHQvfz/q3eOueCyNrljO0YW85OoQogd7BS2gFOccaUQdFejTVIS5iq4HwDv5l67DdEt66Pic3ZVnSs1Sv1Bsb9nZJ3YrOzaOK0FVpgFd1XGc9DBqfJaZlTwELg/0PLwUpqvfEbez0=
X-Microsoft-Antispam-PRVS: <AM3PR04MB074334540128B2A72FC09560E6D30@AM3PR04MB0743.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011);
 SRVR:AM3PR04MB0743; BCL:0; PCL:0; RULEID:; SRVR:AM3PR04MB0743;
X-Forefront-PRVS: 06098A2863
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(346002)(39860400002)(366004)(39380400002)(376002)(199004)(189003)(54534003)(1076002)(47776003)(76176011)(52116002)(6512007)(36756003)(6486002)(39060400002)(66066001)(51416003)(386003)(6506007)(5660300001)(478600001)(26005)(4326008)(53936002)(48376002)(6116002)(3846002)(16586007)(2950100002)(6916009)(6666003)(105586002)(2361001)(2351001)(25786009)(8936002)(97736004)(106356001)(2906002)(81156014)(316002)(50226002)(81166006)(16526019)(50466002)(86362001)(68736007)(186003)(305945005)(7736002)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM3PR04MB0743; H:rhuath.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM3PR04MB0743;
 23:zwpnCgyGNJQjHc3ej7cBzSj3qLQo65rLkbgVWj9Op?=
 =?us-ascii?Q?OrO2iCtPhJ/S6LoxEyo06vhuor7WRjly+kSmIPv3CKeuslCdOuI7erqm+OEF?=
 =?us-ascii?Q?qDs62VUoNp21Duvt+pQUts251wSAqH/4b5IuF1CM7KfgvtHn5taFRgsuzHTz?=
 =?us-ascii?Q?EBVvRH7sQ9PCH4vSsbLQvfugAppJDza82wN2ofwfh9qJojEKKY+qvNlvga+g?=
 =?us-ascii?Q?tpz5Ya5pRjxH736996VvLSaweI7i5oHGHMH/OFqp+W/EhWk+ktM9+YIoHINK?=
 =?us-ascii?Q?NG0lh7jEfXhXYSf6DiRbvXNf67eV9/OQbt5D6rJ5Dph0nfsg7aDCwyzFANk5?=
 =?us-ascii?Q?UnXpSniItjjrqtu0ydbHbMhlnuG+SDiNl6RCCUv1kVBt4q0YPVCBf/69v4Ez?=
 =?us-ascii?Q?7+Kbx+elkSrnHglPGt2dAXstgwvBd+TcKwuShK6bnC62QWkZ8/V7RCa+hSoX?=
 =?us-ascii?Q?MvLYuwjKckrspNT6NWs7C6kiRpfY4Utk/Iz7BFf7Jyiefq1aVAB99zyHZnNd?=
 =?us-ascii?Q?bcDU5VOuoUYQh0lig3ZGwohBgF1wFKAUnKdoRRCCgkKav7/INJrNmcw48oEU?=
 =?us-ascii?Q?d1XN0cqgEvpcmNJ58WlrwT5RLiawWobgD8vCySWv6Ze3waZECcqfOI21sBaQ?=
 =?us-ascii?Q?YGP/kCLP6XTVTHcThS2F46ntR2PA/B/C/mtl2FliPbOR1MhFovk5QX/d6SKU?=
 =?us-ascii?Q?4lJm2Pi59ZXrINYEnFP7M13AMvXO0VVro8E8a+Ro6bTJBoeTFd3IriWDhjec?=
 =?us-ascii?Q?6zg/cRZsu5YlqZ7iRVyIe2Dsq9g6/tCcnu9yH9Wks3H6xnZRS0T6AxGt+brU?=
 =?us-ascii?Q?a4Ig03aR4iUkDireLK2H8mA0C2qW3WheI5RA9MVncyoubnusdrYDbAPuvNlv?=
 =?us-ascii?Q?uYnPEaUx3K4QTJQMP5r+E73DuMl7Xzqh9cekmKHXLuGWCJeYcFZZoYepFgYG?=
 =?us-ascii?Q?Tdmabd4c040Z9/Rb+FCBLvZ52LrkNyMFt7p9OjrqROyzqHovHq8kYTxPnxKQ?=
 =?us-ascii?Q?ZYMnOOjrO2yUBD3LJColrHG6CMbGTajXHwEwUOfNftZE0RRFq7EqvTNQP8Fp?=
 =?us-ascii?Q?z6ieNz3npNZ1baaxDPdNT7Rb7UiSTOy1yt3Y0ZDoHfVQtdUU6nVo78g1Ij3s?=
 =?us-ascii?Q?Z6r+PYK65e0NDIx7BOJzjPMWcrJNrWkMqTkklwHpYRz98H4tJ65BhbwfWoqo?=
 =?us-ascii?Q?sM7+A2QwevAUX7eH6+b9nFHODgniTzNRiv+?=
X-Microsoft-Antispam-Message-Info: /JYC7z0e6FhJHUZRVYurw43Kf3WVJSRBS8nmdAuW0jarzsd3Zn5boRgm+gPeompLkm+BXuQf1xp9L+TVcfMYfgNfuQIgtiuY96SNMos+PFnCVyGMLxR+Xo148XusEusoayhpn0iIYIUJZxdq1zIecUUpdawngbYGCvvrgGkCQkS79OirGh/eIrCmy9BoDRii
X-Microsoft-Exchange-Diagnostics: 1; AM3PR04MB0743;
 6:wQibQIw41YbcyjzRv85NwJnlyhL7wU/J/yAWASZp+9Z9wLd2LE3G3WnnL1ZM8p7MtZzvXzLgcHd58pgdIJJytMgSxmg49bn+qWOb41PcaZm9fU09+T/o9dTE9XdmGT+FzBRtgxIuSkaWukafw07F4VJuSMPIERz9Ht1kZhDu/bFGmFRS955kMctIGezbD3iXnPv6HsRDI3fc97bBRS4+RZ31Lr8hRMZxbXsOYswqXziESBKkb//0oE7ly0NdCRqdATWKGvCP47wkm9y1Ayzf0+26vNuZrvrnCGlNWaGU/h+Fj36JEaEQyoDftydOgoWAyS+xpXMQdXpw8KQ0ROxXeB4SjmWKhUHa3nXSXfFYDUo=;
 5:63biwCfWxVkqK9MRGNxlicm7itr6Tlr4mBaQsPwzCVqh4PEeH+vRIywDonzdR4IYvUyg2jCBtIdrrIzH1qxUoQJ2N1WGoDNlsc8yLFILHrHW+PL10w9BAcfOy0CYuWdLmCKFvTn+NmG0iJdMN/4qYBNvY/vyQ77RnuShl4YVRXQ=;
 24:5XH9UqJumZ33XoWJQvO9D1upSOQalgUtGDx2BVsHnS2V4Tvn/BlwYe61pE4A1jO0BW7jgDOXzZNmoexI3m76Ytc64qLvXoCXmWW+kBw6S/A=;
 7:tCtkZEhgTHSz60W2bl6p8oK7yDnHhAedbAy7VB9aA6/ZhgizdHi1ZBkadr0CRblBN1v9fQKkYz2kv9c28SU8mPN907iWKKQbLVlXiyUGL2SBcUBJS989bwtfSt1xZE1bkJLfl0APPCYgE32UEAyVm6v+pHfgcR7Dk/uoDxBcmKMmuTtQe67+GLP/f4apLLtKH/86OHRIFVzNfQKlks7C1FhydK5N9oiRBh0suYwTa4Q0BOv7rifNmakR3FQz/4q4
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2018 08:50:15.7660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6773ce5-d735-4e3e-a4bb-08d587f647ce
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

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
---
Changelog:
 v2:
    - no changes
 v3:
    - no changes
 v4:
    - no changes

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3c2b75..20d7bf2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4410,6 +4410,12 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/staging/fsl-dpaa2/ethernet
 
+DPAA2 ETHERNET SWITCH DRIVER
+M:	Razvan Stefanescu <razvan.stefanescu@nxp.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/staging/fsl-dpaa2/ethsw
+
 DPT_I2O SCSI RAID DRIVER
 M:	Adaptec OEM Raid Solutions <aacraid@adaptec.com>
 L:	linux-scsi@vger.kernel.org
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
