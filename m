Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523237662-2-6710284756626951221
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237661; b=oMnJjmhPYods5ML1wyc1xCRJdgPHVGtMzPp3IegxVSvcKHzqtO
    +3rmvsNq+/4NPGXv7OAF6tmMTgr9DEgCDYXi3U6iBceb/2p/xW1js0PDcCQ4ACJR
    1delWLo5DvCMdgYRLKlh2UeSwYxtTqHoTJepTxWGZkCbooVenWWSKdFeRqqiez77
    RbeuceHaU0wnVereyg7moZ+xEbf3UFgnMZ5/oQsVfgDBoC+2y5XU5of0qCjo12dE
    s5PVPOYKOaUG7gYcrfBAllhaza/2tv/P87AEyjA1cm5Vd1VDIPTc/4rT5Xz/zknO
    XSWtd5LPh1dX9QOyb3eC9sny3ukbgpXR1GPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237661; bh=iL9suCFcvJ
    McguLVO0vBYOH5liCJek7LVHPFnIxyLa4=; b=W6gGC6hzO7TJ1LCs0veWyaBaXr
    YdbcUFOXk/TyxMabOXpCN7WhHAdqZjsEv3l1pZkjtwLMdM2qd3DY7jG94R1tzcm+
    TV2JeldE60B9rO/gIN/LPqHc+eKCRK6vfzcsSAeu2yRzc3CUL4rd/E/xERtVHlLL
    whjaLlgPrn7Xdw+ds9pm+qpuPj+wmGikhaxkAFMEF5hZxVmPUlgyHXpzpPxzDzfj
    MDWzVuSgtZcec4g/Ch22ip/mc/bZho3RGADBBMhlUV4a4MAaTrI6NR/CxTOSZ8JD
    3o4aDY7gc3zXPlqNl6oEs4vlpusPYtKcKuygWCrgL5RjhQRAfMTxkSmxh0EQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oIsFAqgj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oIsFAqgj x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfANkIe/rlFrCbuN1Ggjw/kEBS5pI8rpZBNFfrADNwYQjtcEcleaJZhlfRCq8hTMY7hFyYrg7MtK+SmERnNEugZVkbgpObL5ouznOtN/TNJdBi6vilHub
    xNjl9x44t4GYJdSaA2GLjCwwOCTjGuua2qjfjSA9EDUICrXH45GETWflPmcUoJ743163J1e+xTKuX2EsNpJIGgAb4rZo3jfzFE7FIIofDb7VDIbgYH6cfs8n
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=sg3g4v5sAAAA:8 a=iLNU1ar6AAAA:8
    a=1XWaLZrsAAAA:8 a=yMhMjlubAAAA:8 a=Gy4E4SSkQu8Ixn8RlssA:9
    a=x_lDFeQQAfHRFK2f:21 a=o9OOlKVKKvP5aoV6:21 a=wPNLvfGTeEIA:10
    a=iu1f2MN_e5UA4oevRmHL:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756547AbeDIAfO (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:35:14 -0400
Received: from mail-sn1nam02on0098.outbound.protection.outlook.com ([104.47.36.98]:45151
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932604AbeDIAfM (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:35:12 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Sujith Pandel <sujithpshankar@gmail.com>,
        Narendra K <Narendra_K@Dell.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 029/162] PCI: Add domain number check to
 find_smbios_instance_string()
Thread-Topic: [PATCH AUTOSEL for 4.4 029/162] PCI: Add domain number check to
 find_smbios_instance_string()
Thread-Index: AQHTz5mfoZgONYTzakqKxVnf09lgVw==
Date: Mon, 9 Apr 2018 00:28:03 +0000
Message-ID: <20180409002738.163941-29-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:XG/P7+15+GHd833ruHPHIZ/FpWzfck8mSrsN9ph4ikdHW5h1xzKu0KpMHAtAfaP2xf2NIFM9WsZDvRJITEFnSDU9FU5BcNbbYGWaVo1FD+fOqUemPWd2GrEyh5E2YJFOaZhOULOBV8zcKT/qU8gc+HfSGKJs4GFqq6yA8tdCxCMpKVfB8sITvTI0JRDvYiRAY7ayCwko647wQ8hGaj4KRZjxUbpaj70WreqxCyJZOpOBpznvrmtH6Px5jSiwlLuY;20:mFWf5ZHwg5jlnlAMEOkwmcAS+e8iXUL89pdJjHFl1+9F2NDgbp4JSMEXOv8shQR7MmPkva1c6YETc+8sI/EVq5W8Gk+TX48MEs3Ygppbn64lL42GgTOQZTkj2g4pu8gI9bxKgM4juqQk3icSCCUbMH2Uk/pT+YL6V7TkTfS7zzI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: bd6916f0-d260-4339-aa6b-08d59db1bfa2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725D538829412F021ED233DFBBF0@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(211936372134217)(153496737603132)(56004941905204);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(39380400002)(346002)(366004)(189003)(199004)(86612001)(575784001)(102836004)(5660300001)(14454004)(476003)(68736007)(11346002)(66066001)(446003)(99286004)(76176011)(486006)(10090500001)(3660700001)(110136005)(305945005)(106356001)(316002)(105586002)(3280700002)(3846002)(10290500003)(6116002)(22452003)(6506007)(2616005)(1076002)(7736002)(54906003)(478600001)(2900100001)(2501003)(5250100002)(8936002)(25786009)(8666007)(81156014)(8676002)(6666003)(6436002)(39060400002)(4326008)(26005)(6512007)(6486002)(81166006)(107886003)(53936002)(2906002)(86362001)(186003)(97736004)(36756003)(72206003)(22906009)(37363001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: XPNG8D/TNH+2rx7oB7k4hDVbcob2T+7tEZNYOC3BWR2rp04I9+Tv9hfB31Yab6maB1OxiVcnAMi+Jf15XcvjTm9zZsLcBGHOEHAhLSt+UJ980oPsNqF05BbGWlXqhledgrpQuch5WIUPV47FlVI44k0Zr+ofXOy0MB8UOE5rwp3gP4TNwXjfXJDKW7yHS/7jlTFl3zlz0/svPVWaMRIHKT0Pt6AJXdoR+A+ikRmHeA1+nCXJY0RCB2w79kAs5SX38NMfgQVAyEQM+78jbcHGIxycyUhLP2SxT8P34BhLEU6EOELxJcnIY3qczHRGpDIfZw0hSEKTYwYxn1x579fHL/cN37Jkz3vUIrF0TxflVSjsSOoJ3hoKyur362OAUPw9cfQZkQScCBBpMU7UPAcIycKSu34gkUHSOefkQZoVmfg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6916f0-d260-4339-aa6b-08d59db1bfa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:03.7236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sujith Pandel <sujithpshankar@gmail.com>

[ Upstream commit 6c51c82c60991bdbfb937f3bf0cdbe68d042073d ]

The function find_smbios_instance_string() does not consider the
PCI domain number.  As a result, SMBIOS type 41 device type instance
would be exported to sysfs for all the PCI domains which have a
PCI device with same bus/device/function, though PCI bus/device/func
from a specific PCI domain has SMBIOS type 41 device type instance
defined.

Address the issue by making find_smbios_instance_string() check PCI domain
number as well.

Reported-by: Shai Fultheim <Shai@ScaleMP.com>
Suggested-by: Shai Fultheim <Shai@ScaleMP.com>
Tested-by: Shai Fultheim <Shai@ScaleMP.com>
Signed-off-by: Sujith Pandel <sujithpshankar@gmail.com>
Signed-off-by: Narendra K <Narendra_K@Dell.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pci/pci-label.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
index 024b5c179348..5986aad76088 100644
--- a/drivers/pci/pci-label.c
+++ b/drivers/pci/pci-label.c
@@ -43,9 +43,11 @@ static size_t find_smbios_instance_string(struct pci_dev=
 *pdev, char *buf,
 {
 	const struct dmi_device *dmi;
 	struct dmi_dev_onboard *donboard;
+	int domain_nr;
 	int bus;
 	int devfn;
=20
+	domain_nr =3D pci_domain_nr(pdev->bus);
 	bus =3D pdev->bus->number;
 	devfn =3D pdev->devfn;
=20
@@ -53,8 +55,9 @@ static size_t find_smbios_instance_string(struct pci_dev =
*pdev, char *buf,
 	while ((dmi =3D dmi_find_device(DMI_DEV_TYPE_DEV_ONBOARD,
 				      NULL, dmi)) !=3D NULL) {
 		donboard =3D dmi->device_data;
-		if (donboard && donboard->bus =3D=3D bus &&
-					donboard->devfn =3D=3D devfn) {
+		if (donboard && donboard->segment =3D=3D domain_nr &&
+				donboard->bus =3D=3D bus &&
+				donboard->devfn =3D=3D devfn) {
 			if (buf) {
 				if (attribute =3D=3D SMBIOS_ATTR_INSTANCE_SHOW)
 					return scnprintf(buf, PAGE_SIZE,
--=20
2.15.1
