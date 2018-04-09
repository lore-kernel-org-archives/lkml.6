Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523244472-2-15558203422373153874
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enitca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523244471; b=biVbq7o9dMfTe7bJV9be8Zozac9BOEt6Hx1uZ67NCy2Ti1ZW8A
    FYz1FGuS7Iazddh6ExTr1VHkSnWn53vJVX4iGtvJ0xsKIUhw1uWxW+ir5H3DYLpA
    NarUzD2zjtpd4sKPopznMCxEiUbhZvE7d2uMKrRLkTr/bOKw9EMiQesj3lhtypIb
    KAIfLbnZ3lLi+nJwxpQ20Esl2Qjqoi2/C9+UWznxclm5GP2PWxlm0SBcYG0+uWmQ
    Nwl3dQhnkJRriqa/M8JVawk6wurvs+xtl+v8XIy7kFAyMw5zYKqm0JDKWhh6+i8Z
    Wp/yW/PHOgIrF3MoM/ipispdXo7TBvbB2vdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523244471; bh=I8fXMOOcrR
    3rZHoPw3GZ+eJTpbNeYtRwlWMm8THGa7Q=; b=dCJ6S8QNPjVTqTtq+n1SYn0h7W
    hG+QwFN5gaSOVIyyRBHD2nJkh6stAxhmwtTXa+r0pzETtfJbWFWcqNcS7WfULiE/
    grfceV6GlOsF7U4i5Q6c2uiDkc6ehBx+4Pj782/O0QzynZK3NRk37SJzRK/pAO37
    qEWB5OVipUX3YchtTBLD0TsOSl7Go3D5HKQgMOP/tUQ7brXERZbnRMy/LwoyYAAW
    BjzSDTxQ9IC6r2l6WgfVuZeuxCfWv4wTNmG3ogAohZ4/9bFIP6da2nz/DNKRTB53
    XoPi/NEHPAIggPqn8NgN4Sq3PQJnG8yPYhF+YfGQxwZVhjP3Ls1bUTHX+NiQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oEjOzqmQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=oEjOzqmQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOG4kxwf+Igip4Pa7w62IBLtNSZIQwug5r3UVjz3b05+5p+TGTLX6cQp12ourjUc8c3N+BY1T/iux4uzxVjr5Iy/ltRECD9C2litUTv2Bd19TBxp6rqw
    mT3n7NxB1L6RoFuinzmjJuOoAn0t5bhBQpEA5zMImdkKkLiYw0GXo2nN20aEvbD75W0TQqpEYOVryux9zEfKJMINjsgfpMmUtYu3YaAptsSdpx0WB69w5grS
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=OLL_FvSJAAAA:8
    a=1XWaLZrsAAAA:8 a=yMhMjlubAAAA:8 a=xZ-MdF6L0uY4eguhJAMA:9 a=wPNLvfGTeEIA:10
    a=w64Ph-BE0T8A:10 a=iAXQAx-9ccsA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=oIrB72frpwYPwTMnlWqB:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeDID1r (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:27:47 -0400
Received: from mail-sn1nam01on0118.outbound.protection.outlook.com ([104.47.32.118]:31261
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754618AbeDIAWH (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 017/161] PCI: Add function 1 DMA alias quirk
 for Marvell 9128
Thread-Topic: [PATCH AUTOSEL for 4.14 017/161] PCI: Add function 1 DMA alias
 quirk for Marvell 9128
Thread-Index: AQHTz5h88bGfR7WRXUSbKkbh3QyY+g==
Date: Mon, 9 Apr 2018 00:19:55 +0000
Message-ID: <20180409001936.162706-17-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:5nAGcC2MTn2xnoYDIzMAf/ew5x/Cz0YFWz9uHv8h9Ha6DMmCpe7B/roEWJyN0NLiNNwZ0np6ciHDO3OhZ//qFP25P4/9ao+e1B8EqOlQxzgL1VPYCwzFAX9wxxSLhlkUhO+xQSctb92xAEqgxVQxldbS3eUheY0dvtke2sd6J06UPPzA21kxpB2kmLdOQeEN2Em7z7lxPBM2MZIQTfGR365qsjgrI3oq+XTYsT2mRqFYjQx1KzHjHZf+KjkeABPZ;20:XujpwhMQ9jScvpllZNxaoXxsYyfVBYzT0J+xDegcpecLFsIm558P2nHaDLHfz2htqDKogWwudOmJo3q9ZhV2+qHSGGzU+IyWJ/PRavtSG/FLk0Q1CQEqcu8gtY2svuhDCscRnM47Znc7uflDIl5b6zIYqAVzqPTnJsFSpyY14qI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 46ed0194-dcae-4077-148f-08d59dafec7c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0966639B7E6CCDBB90FBD9F1FBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(396003)(366004)(199004)(189003)(6512007)(316002)(59450400001)(6436002)(186003)(6306002)(6666003)(2900100001)(966005)(8936002)(486006)(6486002)(6506007)(10290500003)(81166006)(22452003)(25786009)(1076002)(81156014)(53936002)(106356001)(10090500001)(5250100002)(107886003)(102836004)(76176011)(8676002)(66066001)(2501003)(446003)(476003)(36756003)(99286004)(478600001)(86362001)(72206003)(2616005)(68736007)(5660300001)(305945005)(3846002)(6116002)(26005)(86612001)(14454004)(97736004)(3660700001)(4326008)(2906002)(110136005)(54906003)(3280700002)(105586002)(7736002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: k4pYaThdyzmx/EUkUm+4pR/8i6h+pT14FERhW2OWI9Z/XLsqORRUKe4elm1QOwSycOCL1bDwzI5NFqXv1gX2PMMjdm13cuY1It3GDg5MKbbUdKKFdSWXZk3LLSICBZpW6NMqQkv8WuVBDSD7WKW8vdMbK7DiPlp1MMtPLa7fDWUZnFO6lTdiCTVBWMMqeAMIqyo+lRBLECettvJwjMylZaDsT0YzeVMTRBIbGyyM+aR4IRvMyHd2fv2k/YHB1/LEz1Q+QUje3vnxTj5/942pFak5U/6KLwbunwl5r0eSjD9yomFq5KaEIFA1bugR98baNyODvMBsbmefn9JalH7obDTDmh80nSVfS9NmU/w/8qOZJIBvj0NlkE03xzq28Nirej8HmzcVtF1P78GFDWnfXzXO6/8CsTAXTB7XbJhBzvU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ed0194-dcae-4077-148f-08d59dafec7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:19:55.3794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alex Williamson <alex.williamson@redhat.com>

[ Upstream commit aa008206634363ef800fbd5f0262016c9ff81dea ]

The Marvell 9128 is the original device generating bug 42679, from which
many other Marvell DMA alias quirks have been sourced, but we didn't have
positive confirmation of the fix on 9128 until now.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D42679
Link: https://www.spinics.net/lists/kvm/msg161459.html
Reported-by: Binarus <lists@binarus.de>
Tested-by: Binarus <lists@binarus.de>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 05fadcc4f9d2..75f57aa954f2 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3879,6 +3879,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0=
x9120,
 			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9123,
 			 quirk_dma_func1_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9128,
+			 quirk_dma_func1_alias);
 /* https://bugzilla.kernel.org/show_bug.cgi?id=3D42679#c14 */
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9130,
 			 quirk_dma_func1_alias);
--=20
2.15.1
