Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2061918-1521043017-2-4247114795746112748
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
    t=1521043016; b=hRjX8qoPG5bMDJ1Eyw3fd5TNg4ZvZ3/UOYwqn0gjJtrK3ZW
    yPz5rEU/iyKx7/fT4AMd/9uBt3lJm3+59jJ+9lG3H4kL1XMJ+688W+ep25Z8lxo7
    6Yu6ZFoDupwPHNGkWiX+jHrB2yPsA7lJ2m3YxNSQ5Qra2O996+EQonFSfWt1NrzS
    QODF2onvkygUrzuWFLQLXRpR4VFoCJN7DCnpUq4LCwFvZNPy9c9l8zhxBONJLjKW
    Q5tYMiy8XciMsosyEvQLa7rq2z4dt9imIn1DF/RW8lnQuwv/TU//op6YatjBdDlQ
    QeyzVG3iwhuC5PKaNy7nd/vHih7zqsprDgc4OEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521043016; bh=0
    u0vbMS7Zlhlh9Ff32jxLp+EN2hiy49wQe/j3C8hLBk=; b=nYpCUdZ4BizGPQvYE
    fEJBo8vmCFgWEfX3wz1EfzJ8BKo+YtJg6Ljpplr1qHWqAL2K5LPnwd19Jqnne956
    dCIO0Z/R9Ks4efLnrp3ymQsQJuIt7HcuFGJUAAIhZr9Wg8s/82mvQ/NOfJeFuyTL
    wxiLCSBUPE6KzFPHe4fnxt4oILG95GMnmP4v27yQZ0piJuBOpBOO0zcyaGpkiG4b
    w5oZrID6ro11nNwoG257zW3Qjwl2dcElpcSqE3fVurhPBFuMy5oeh9ylDmP7QIOY
    Iy2JyzQzGX7EhJwPvo2g8Ranpi5MixjDROkd3bwKit+knWaMFNwP8iO2atpfLIub
    m7Ehg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=daLmRHzi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=daLmRHzi x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
Subject: [PATCH v6 6/6] staging: fsl-dpaa2/ethsw: Add TODO
Date: Wed, 14 Mar 2018 10:55:58 -0500
Message-Id: <20180314155558.6898-7-razvan.stefanescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d75f5574-d601-4c80-d5bb-08d589c42afc
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR04MB0747;
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 3:86xDHPl0qlyUs0JWDFZj37cZPmanpdtnxwHxH5+GvVTsrscvFvx2zG42FnmFYztiVN7wa8iHa8yG+fxtmyO9OjvS4eKL5NJ2xp9fkBzZ3f1zlr5kPoMJWf+nSANpIU0pQYlqFt8Lem1VVGMsGbUfxsKGyilhtW8sKFIkrNxfBlrwa44QK/2e7thf8KtisJpjG9BkBjAIlR3/BeZq01nQ1lGMC3+56f3ibAwwiFhytGBkgiM4wlF5lFla+XPGzIE2;
 25:8ojJqXh0ATl0Cwrdhllyk9t12fa/4nfzzcr0wxC5k8zIhIfL85xzwBlRpV8b8Xvk+kSI8gky5zgvn4C/az9v/nIzumvsrVOiw1gzVlvzkN4rJCc7b9PWlp3+Sul3mvLbxDmEej5bx+grwBjtYt23z3YeXjuKJCAgED9gLKlPRwTPnGE0QnEgMXyxIDfGIXhTVn6KnNPL0TSN4T9Fr14jKedmdssnmrgU9M3mmdz22Fiik+CbMASG1sjddS7s4DqEj/4qC2ZRe2nsJyICDxcjLfcGwlMDVsPD5NOZJQzT7a2T33ktJEL3CaG5zy6kWlA7iiojidmEqvrCP7buP3jCJQ==;
 31:8c4zlXNSPU78Wmymg0oF/BxsVmCGLANvHKHFzi18SRQNk3Zn4UPB4JyHCIuOMWDB4saRdY3a8t4fJ7m5UddiVo37DYW5+yY9r7sSzm2z5zFzoGRYDcrWBkVkFch6H031sKybdV5RM4hIQLcHEF3uogWnmqT3FHzpJi7fauT8s3b+u88uMbitBiNTDgGJmOfW1yI//nyFTTMvkOoDE8nxFgXuJBAbugSgsbqGCawZi7k=
X-MS-TrafficTypeDiagnostic: DB3PR04MB0747:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 20:DenrYHXb2B9k54xEzlJPizss5FPOZQNcR0Hj9uKhfJRqWrdmbB6TvPl0/kdcltB3NhOQM6kF0oeoC+1b0yb+SnZ+53v61eTS28KWiWGKzd3NIjzH1Q+Ygf2n0PbI2oJuMwKVE6l9jjSJt0DqTnsJm0qsL2JfEmBNl+nFujADajDz9QuOf4zIS0Pc/WKcaAGSgk85nNCfPX686irZvE0L/Z3Bj+ejGNXeu7be6oYeex8W/7AxbYvhi8EeSVpkgQ7qUUch7woghmb0AcCk6/z2V8bbimQlbws1ADUejl95R14Hqf3vsmJ0pL1uzfpdpikk0T1bOps7PVlY1l7de2oIuyKZth4YgMcj5YvVPpztVCI98ASDcLDGQFyH4xzvxl+cjAaQr9Os43vbaj0uhWmfgWPR4w/Skp1mN9NnquL/c2gvm7sBv64IBuCPuDEy3BHeL6vXZpgYTpZxiTn4FAs7fwI2c2dHAxxuP4eSZQYLMdigx1REBznUc4Qt4dZv0cMI;
 4:5KoElNmNkuYeoIFpmjo8Tbev2jNUs+nf7/V6MYPRhW7gBlnxbEqrU5Ld1FdUlxuvTu/ATsjDwa2I/BPaGw9mPyqbsHOXqfGJdft4Fbh9ny72VD56W7dZk7IGlmg+4fblMMAKYOhFWX0sHxBdjLElMzo/pCteEebCy2qcPeBq4uNKc+OxH5wUOSycH2X+GZzfA/0D+wpPTAMH1qEIpZRGQ1aNu3Xv3YvfLNzxs1kBkwIH/D2NPHRKQ3Dq7ivG5c1HdS8jFvnYuMFij8P8rFNWc40v5wUmyhibEE25TrylmwPRm5YsBIJmH1WNLqEQSxe+
X-Microsoft-Antispam-PRVS: <DB3PR04MB0747556A934046915C5021D1E6D10@DB3PR04MB0747.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231221)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
 SRVR:DB3PR04MB0747; BCL:0; PCL:0; RULEID:; SRVR:DB3PR04MB0747;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(39380400002)(346002)(396003)(366004)(39860400002)(376002)(54534003)(199004)(189003)(6116002)(3846002)(16526019)(386003)(6916009)(186003)(76176011)(48376002)(1076002)(50466002)(478600001)(47776003)(6666003)(5660300001)(2906002)(26005)(305945005)(81156014)(66066001)(7736002)(8676002)(6506007)(81166006)(2950100002)(25786009)(50226002)(52116002)(86362001)(8936002)(316002)(16586007)(39060400002)(6512007)(36756003)(68736007)(6486002)(106356001)(53936002)(51416003)(105586002)(97736004)(2361001)(4326008)(2351001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR04MB0747; H:rhuath.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DB3PR04MB0747;
 23:ehTRJYvuq1KU19ApQKM3KqxAO7HuftLmpn+84tWzz?=
 =?us-ascii?Q?EgmPgDCZ8OZGx1Zz2YSniIjMWAPbUvDe4phDgZBCPQWg6fAxW3BbawTLKhHG?=
 =?us-ascii?Q?HP+ehVBi7HtGWpXeOpYIiv60EoO86XpKj7+VLOx/kkPzzIXScDmAP1trToLG?=
 =?us-ascii?Q?cBJ9/jlpsEWuYzQfxVjpovE24nY/TIRCwPgofONBe2XTDGK/SPiZVGaCYBVU?=
 =?us-ascii?Q?cAj3m1cfBxSsd75evJ33JppgUZQWnwItaImmzcn/lS2tteoZCiEDTl28UDSe?=
 =?us-ascii?Q?fgGGschLwuaylz3WpTsmnMnfZWPN3EwoVMoFikj0ygKnnkW+76mazj17LSf4?=
 =?us-ascii?Q?DuQXHknqEpLju61ap8UH5ZQOgdwNiNZUwMVwyXshN2pSIaWWJmEvTpHP7YIS?=
 =?us-ascii?Q?lrdecTVLh71SNkGLRgmF/W4STs1dtcEWgSuv/UdiXFL5Gu0RCvCfWeBRnHD4?=
 =?us-ascii?Q?SrQKzezepr6J3B70wIDl32LvEiJS7lP3i11kUZ8nBtDAhCEhukWLuS4v6Ma4?=
 =?us-ascii?Q?v7+o1bWVbfQbLtaHutRBTyBldRhI6NxiL9FoExG3FC6WhJcR/JzE5ktleXJq?=
 =?us-ascii?Q?AwKn+emSsOnmAnR45DVgc0QEQjzWV3V3I508KkB7iu1z1g87kGPMHs/0XJgI?=
 =?us-ascii?Q?QQNzK6MJTXESyDRIgMAEyyTEzQx8q3TcAbCSllnnET8PmksO4ZJUplXFwE2k?=
 =?us-ascii?Q?7zxiZdKeH+OnDFyioO8v9I/b/06Q1tgdyG8yC8PL7eOPvBLtCjdciHzz910H?=
 =?us-ascii?Q?n/auwnUmJT1vDkosta7CDksF9yNdjtPK+/tHLr9QUnrKbmrh8YPLqPF6xEpr?=
 =?us-ascii?Q?E90T7qvC0o7c4oTnzXkFvOTRbiunCzOu19inu0DxcF76eZ+GU7kgxU9thyhB?=
 =?us-ascii?Q?/fJxkNYwGfGkzSVWQ6WxLkGRP3wOJN6lLM4d7W9fzTy28qiDXUbvmHNLI+ww?=
 =?us-ascii?Q?IwMor/Nc/folmTsnqMkx0lCs+6tFS8xE47L1FPX2HkoDl2fH4HTIkUlS5VOX?=
 =?us-ascii?Q?VJbqQO45ASR2ospXZnivQs/zI4BXeBKhI+M9zhVpkt0S7ezWIPXiLJFy1zzq?=
 =?us-ascii?Q?WEJcQNHobIA//rq2oYeCIzONRoL83dFmAx0L0jSdGfY2JAciSMKPcmDfVaGF?=
 =?us-ascii?Q?HKpAdOoFQjNLNWDNq9iGuRoz8TTEBQKbwkDuhrSWuPKA0YrLqy+YKPmV2Ifl?=
 =?us-ascii?Q?FWUyB3bSSaBhMAJqrKQhUlZAYlar6kz10mk?=
X-Microsoft-Antispam-Message-Info: YcWZrw4VSawgbL6JlwYAnRi+C4Rs9Bie1UDpH02LeP57+G99V1f2NXANSggcRa2fEqb1KTf/BS9Sn61aWVfXFP8vztDuPWZeCg4AKBn5s83+L+Z3/4UbsjJQQlZ4O/22j/MzvKTD4FSW5a0T2zDbrXOvxEVX++1y7ojqyK9uk2iApWnxhJ/bXyU/xmzO2RZb
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 6:sZUOyA731dEF1AmyRXGpmqaR24UbnKaqdevj2SZPngOxNPjTlweeDC8QvaD57ofizV2CxIq9MYjCirJfKwn/mpJiszUnCvM14n2NQ+iZzVYRBDDWwWaIc3tAotnVREPrliamROW+e+qm3miClbaXoOU+qTxvQ6/+Wcit0e3hY+CUAd8dNx2vlo1tiJH4QpICZFs/SzfcqvVov08xSq1j2hJRG2WGITKSyj3Bte09GOl7HngMD6idiMfQ7gYGf/YQB1KqSxk1ZCloDE9wKsPw14ozU6Gybhhzuvj4E7p711zIMlcslwUbLuVL/cUXKM1mo6lYIV7yrBxvp5SQLTmspQkRdGxFGl3a+Iwy2p9azJo=;
 5:z5V289/cO3bEJW6bDR+0SP2uLwGMXlab5I8yyGL8s1X8j4MaILs6z2YCAAKw4r1qmyQikdMIhFzq0k7pZPduqVknvgKo9Oz3Yhc/L8VH4zK2PDaWsO77uqTJdE67EGRc2qaDMgyTwAmIFTsKgvsh4dkSB3ewtTAtACOvsKEBb2g=;
 24:Pua5KDE7pQVUyesbxV8+D3XV+Bd/o/O5iP8fpNkBXObceM2r1Ol9M/ZV1qT1XsDkTURCWSVSIO83ZPWxhwshCEsgSbIUHrFZ0LBTdq3PgsM=;
 7:qbgKSzbubvyL8EO2flyuE2xr/e5Ii+koq3h/vF7vkbIGVUi5C9UAIDAi5PUT+tO6JB+w+7yQeilTWeMCjZSb6456B2+fsveJ99Vc/M2AAaV1lo9HwuVM+ZoBTR/yEwG8GQRf+xRzUj+q93Lv4EaQvRX+dE1tgr5KUbnfPe4Dl1eTKSOLMOWXjSTubqSrHLbj3kuYSPul3JIq2HAjRj0yX6HL51rRTQyeMX65B/FSDDg8MLWPYA1v0GB6ztvj+H5t
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 15:56:33.9975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d75f5574-d601-4c80-d5bb-08d589c42afc
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
 v6:
    - add port partitioning requirement

 drivers/staging/fsl-dpaa2/ethsw/TODO | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/TODO

diff --git a/drivers/staging/fsl-dpaa2/ethsw/TODO b/drivers/staging/fsl-dpaa2/ethsw/TODO
new file mode 100644
index 0000000..24b5e95
--- /dev/null
+++ b/drivers/staging/fsl-dpaa2/ethsw/TODO
@@ -0,0 +1,14 @@
+* Add I/O capabilities on switch port netdevices. This will allow control
+traffic to reach the CPU.
+* Add ACL to redirect control traffic to CPU.
+* Add support for displaying learned FDB entries
+* Add support for multiple FDBs and switch port partitioning
+* MC firmware uprev; the DPAA2 objects used by the Ethernet Switch driver
+need to be kept in sync with binary interface changes in MC
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
