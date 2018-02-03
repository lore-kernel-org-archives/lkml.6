Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1602359-1517682931-2-9959779880829926321
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517682930; b=anCPZv3WU74pKBGSBdC0B+fqUifOhGSjwNKmdY96gYzHWnr
    1O3WJWUfTKvaqKFOC2j8enpJ9/G7mgPr6pAogd/sEW4VJaFprHElPLBtnKRm08bc
    jpQQO+jHv3pWWlKN/2HUDr1BFYONtbXSCZxeBWXiTGHG5IiXXCy18mY4SzJit8m7
    uz/FD4tqo9D2H62iQ/0LqnQV7dTnUAg0VuS2AHxrmR6BPjTR4CrDBAriwsveuIsr
    6jseNuEAOzIZKFdS1Ct416JU5jBKL+rarKpt8l6pCeqqkFLqIb2czlUYysr//Zc4
    1f2TP5SSAYl7/2/cCmhAsFmZ6EldLnnUeQUavUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517682930; bh=fSOkLI
    yV9pVhGBdVPrNmc2CqbpS4Pna98Jl5OHxGY/8=; b=Ed1hFYzw381xCmKQItKCBr
    RCkutwVC7bKSQbUsi/k8p571n9avzt5XDBvQQDwc4AyU4kwD5NLid3mKTz+yUdj5
    NT8+LLowsLRVtoFzqkUkQ0+s68pQRbnCMAazjzDuW+KQV6KbIUWiTieuu+4bEOpX
    ezZHyDoPP9Eh8eOiZdQ9ipMgOI2tueGyiAl8eYgHGzgehBTQ/cwXBTTuyccthHEa
    MdPKpE8GGPcN7UAbwG/suu24GGjQWq+7bv4JH5GTJ5TdElblwldEa5SJ6Q925U8s
    ul8UI1zIPyMC0E1MQKpb7imaE6LPqhWw3xMThEpMKwwU7aFDGDfl2TBIHVAINhoA
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jHLb0HJR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jHLb0HJR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753303AbeBCSfX (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:35:23 -0500
Received: from mail-by2nam03on0122.outbound.protection.outlook.com ([104.47.42.122]:54457
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753269AbeBCSDu (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:03:50 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 27/52] bnx2x: Improve reliability in case of
 nested PCI errors
Thread-Topic: [PATCH AUTOSEL for 4.9 27/52] bnx2x: Improve reliability in case
 of nested PCI errors
Thread-Index: AQHTnRlXkZmMNhMR8UGXfg/xn1+r2Q==
Date: Sat, 3 Feb 2018 18:03:48 +0000
Message-ID: <20180203180303.8490-27-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1012;6:lhy8ap+kLYpwABMDYmzLkANzHjlLtm3R8r7VGtf/ONPX+Smhlg1uqoK6kEZmbceDmVTRgg+EtmwRvWY7TQjuSZAUuReG8ItBlpJOB9+kR4QsZjN4pusCAxuv11KyXpv80En0VBKV5mC5dj7VFX1AicSo+C1ABYeDGPZfWEnKL8eFgjyx5zwQZIJz5RDgMt+P9HIXzp8vg49Lx6JHcixLRB7imWHRQ8YYVYIlE0QyqD3xV916w4flaxBeg8j3WyPRcjo/CXePzcdjoK2Pkf1BHHI+qR4sVKBCOb8ZtHFYBbr77NC1hhNFsuYk9KpSoa5E9KzpA0M7gtIQlLcRG54zbAEiMlbYR3KxEcS8KWtq80IXjxeLDOwclBYsUTBRHPwx;5:UUn1ZBu0avJMinzeVrtNxa6Y3ky0gSHZ13PwsPgwpTLlRnQAACMjhpRmYrPg6tngjIBp4sbQZAMbQM8mM1i2G+xo2or9NqlgXAesrJQXASlRgzyOJL/scJfp50UU+U0sOCwcQu2xG0IqR/rHZyCm4WMtZ5gdGqyBshzRD8DsQ5o=;24:j2CzGyAeZV2YXw0w81IEzltzYsT0cH6I1ejjW1pVdVsKFUN77djdsAfuA7FvkLeXVrZZFTJb0Ftw39Taj1mBTuA4s+FMw85e3ziShF8cAyk=;7:yWZu22G9STY+kN/3e81qagm417oR8fcBtq7TFGCFpTVOg8mdyBQzCZvT0G8JD5Sqxz1I3RY1vHsRS86YRbNHOclyikqREV7C9EfXKTcMsybzAaMTkk3sswnvXxf1dmH0tnYfA2BBWSSr8ljnR33xa6y2naw6vQZi/16v8Ch6/2jMwFv0AjWtsbxiw7lviV+fOd41DVGxBQrx2E5o25YMtUwFO2rvV2s9aorlF9J91ZYaAwZ2dDKU5VXaNuTW39EO
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 360b28d1-44d1-44c8-d516-08d56b3079d9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1012;
x-ms-traffictypediagnostic: BL0PR2101MB1012:
x-microsoft-antispam-prvs: <BL0PR2101MB1012B1AA134A4B900C3F2C74FBF80@BL0PR2101MB1012.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(190756311086443)(89211679590171)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1012;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1012;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(39380400002)(199004)(189003)(316002)(26005)(54906003)(10290500003)(6512007)(2900100001)(106356001)(2950100002)(76176011)(86612001)(86362001)(81166006)(8936002)(6346003)(81156014)(107886003)(102836004)(4326008)(25786009)(110136005)(97736004)(551934003)(22452003)(59450400001)(6506007)(53936002)(8676002)(5250100002)(6436002)(1076002)(186003)(2501003)(66066001)(6486002)(6116002)(7736002)(36756003)(2906002)(10090500001)(99286004)(72206003)(305945005)(105586002)(3846002)(3660700001)(478600001)(68736007)(14454004)(5660300001)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1012;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: UVV1jiDtb5FdAivdTi7iIjemhuEiqSNv7rCAvjXMrbEtsIZ95IW5dRFIRXD6O2ubh/Fq+VXy/XpJkTY2Wrl74Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 360b28d1-44d1-44c8-d516-08d56b3079d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:48.6433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1012
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>

[ Upstream commit f7084059a9cb9e56a186e1677b1dcffd76c2cd24 ]

While in recovery process of PCI error (called EEH on PowerPC arch),
another PCI transaction could be corrupted causing a situation of
nested PCI errors. Also, this scenario could be reproduced with
error injection mechanisms (for debug purposes).

We observe that in case of nested PCI errors, bnx2x might attempt to
initialize its shmem and cause a kernel crash due to bad addresses
read from MCP. Multiple different stack traces were observed depending
on the point the second PCI error happens.

This patch avoids the crashes by:

 * failing PCI recovery in case of nested errors (since multiple
 PCI errors in a row are not expected to lead to a functional
 adapter anyway), and by,

 * preventing access to adapter FW when MCP is failed (we mark it as
 failed when shmem cannot get initialized properly).

Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
Acked-by: Shahed Shaikh <Shahed.Shaikh@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c  |  4 ++--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 14 +++++++++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/=
ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 0a5ee1d973ac..596f88b693ef 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -3034,7 +3034,7 @@ int bnx2x_nic_unload(struct bnx2x *bp, int unload_mod=
e, bool keep_link)
=20
 	del_timer_sync(&bp->timer);
=20
-	if (IS_PF(bp)) {
+	if (IS_PF(bp) && !BP_NOMCP(bp)) {
 		/* Set ALWAYS_ALIVE bit in shmem */
 		bp->fw_drv_pulse_wr_seq |=3D DRV_PULSE_ALWAYS_ALIVE;
 		bnx2x_drv_pulse(bp);
@@ -3120,7 +3120,7 @@ int bnx2x_nic_unload(struct bnx2x *bp, int unload_mod=
e, bool keep_link)
 	bp->cnic_loaded =3D false;
=20
 	/* Clear driver version indication in shmem */
-	if (IS_PF(bp))
+	if (IS_PF(bp) && !BP_NOMCP(bp))
 		bnx2x_update_mng_version(bp);
=20
 	/* Check if there are pending parity attentions. If there are - set
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net=
/ethernet/broadcom/bnx2x/bnx2x_main.c
index 5d958b5bb8b1..554c4086b3c6 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -9578,6 +9578,15 @@ static int bnx2x_init_shmem(struct bnx2x *bp)
=20
 	do {
 		bp->common.shmem_base =3D REG_RD(bp, MISC_REG_SHARED_MEM_ADDR);
+
+		/* If we read all 0xFFs, means we are in PCI error state and
+		 * should bail out to avoid crashes on adapter's FW reads.
+		 */
+		if (bp->common.shmem_base =3D=3D 0xFFFFFFFF) {
+			bp->flags |=3D NO_MCP_FLAG;
+			return -ENODEV;
+		}
+
 		if (bp->common.shmem_base) {
 			val =3D SHMEM_RD(bp, validity_map[BP_PORT(bp)]);
 			if (val & SHR_MEM_VALIDITY_MB)
@@ -14312,7 +14321,10 @@ static pci_ers_result_t bnx2x_io_slot_reset(struct=
 pci_dev *pdev)
 		BNX2X_ERR("IO slot reset --> driver unload\n");
=20
 		/* MCP should have been reset; Need to wait for validity */
-		bnx2x_init_shmem(bp);
+		if (bnx2x_init_shmem(bp)) {
+			rtnl_unlock();
+			return PCI_ERS_RESULT_DISCONNECT;
+		}
=20
 		if (IS_PF(bp) && SHMEM2_HAS(bp, drv_capabilities_flag)) {
 			u32 v;
--=20
2.11.0
