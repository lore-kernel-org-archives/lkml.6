Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525E8C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1441208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Mod9oInm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1441208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbeGaOsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:48:19 -0400
Received: from mail-eopbgr680072.outbound.protection.outlook.com ([40.107.68.72]:2665
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732099AbeGaOsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zZ1qR683OVq+tXgU8rmKtfQ7Ift/AI/OUaBPOk51a4=;
 b=Mod9oInmwOj3jLlLS+6RYk8TcjzQ1GgJBVaFjxYtc20yeiRBrHa2f4cDOBwyJJnrH+PIbV31kwtVNPNST5oiyTqayHkbTa4Z0dYTo6I4QjA2CS+WrjMefAhiZykH67Btzs21iitY3DUhdKm9MW5GF2SIIabId+hPhDM59Q7P3QI=
Received: from MWHPR0201MB3481.namprd02.prod.outlook.com (10.167.161.158) by
 MWHPR0201MB3434.namprd02.prod.outlook.com (10.167.161.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.14; Tue, 31 Jul 2018 13:07:58 +0000
Received: from MWHPR0201MB3481.namprd02.prod.outlook.com
 ([fe80::8c23:c29e:5c0a:a63f]) by MWHPR0201MB3481.namprd02.prod.outlook.com
 ([fe80::8c23:c29e:5c0a:a63f%3]) with mapi id 15.20.1017.010; Tue, 31 Jul 2018
 13:07:55 +0000
From:   Nava kishore Manne <navam@xilinx.com>
To:     Nava kishore Manne <navam@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Michal Simek <michals@xilinx.com>,
        Soren Brinkmann <sorenb@xilinx.com>,
        "atull@opensource.altera.com" <atull@opensource.altera.com>,
        "moritz.fischer@ettus.com" <moritz.fischer@ettus.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>,
        "atull@kernel.org" <atull@kernel.org>
Subject: RE: [RFC PATCH 1/2] ARM: dt: fpga: Added binding docs for Xilinx
 zynqmp FPGA manager
Thread-Topic: [RFC PATCH 1/2] ARM: dt: fpga: Added binding docs for Xilinx
 zynqmp FPGA manager
Thread-Index: AQHUKLXjboO8pwvbjE2osMCstNpM9qSpTShQ
Date:   Tue, 31 Jul 2018 13:07:55 +0000
Message-ID: <MWHPR0201MB34813A97EC92F8DC6E3F9CA6C22E0@MWHPR0201MB3481.namprd02.prod.outlook.com>
References: <20180801100457.25614-1-nava.manne@xilinx.com>
In-Reply-To: <20180801100457.25614-1-nava.manne@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=navam@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0201MB3434;6:hWtU62mwmU2kTISi8aezhDE94IRlZhYx/jns1ndqCJZU5RHN+11XCZ6EKc8j4or5vprKOTXvW2O+qfNR3sePXRebqPSjndTVnCRtArTXS15DI8DJ614yOTFRp+GUFd7h044tLumkLFTaaZgIatp3ER+WOwpzKoXobtKyselEooudVZwl4HMMSYfgofbNp59cicvI8oyo8aRPX6+ROdDGBHAwnKEHazfqKIs/EwtlJ9mbHyx2Htbt0syPafnLG8So4KCOFW7jV6Az1+MaVttkAtZl/OgN5eu7iRa9RPbNyFg6az51kI4pcyx2C6Cp1xJ6NFN/F+G3fOxv5LycX3Va8xzyJn0G6iqZYjvDFrpLmBTJn5LUF2Hq+j5IH/DiqhlR/Xlq8HSVlYo/bH+CJsDjm+WkyB+y6/iviGr04jyqA5qScgtRCVw3BJlOcVTv9s0Vq/rzMIfADhblMKkDNWrl4g==;5:YwMks6wUsh9F3QvKPtq2NTHb+EiwZhkF82/2k/aiQt3yrAZL16Fi+J2lwpduvqGMtzrKWb3ZLh/hRNicwQlAFrrqtDf/jdPcGQ7J1B3wpwtpJcw7JFZ8rnoNFelslKUfgbL6GR0EY1NyH5bk1LF9MKoFIKKf9An1QtxVp6N6gH0=;7:IcmxK/pEeFPNXeou05m0pSZKa+SFD5oEDGmw/innBbZbqSu35eSxlXy6OP9ctO7cIKum2FNqcRu7w+x4rboRvnCK4ckAqLbdnd7c5gQFhQrK68eKdlQSsYJIwr9Dc1YDW23wXLaMHxmzWpgXi5o1IDrdV0QQegUMJ4YCR7zPfHTNBNjJuVhhfO1WEOO4d0v4FcfMKVsOMTEUBzPU6umd2AhnSssh5ttKGP5qmWnYYmYfysR+zq/040hMxT71FUjd
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(366004)(39860400002)(13464003)(199004)(189003)(6116002)(2906002)(9686003)(3846002)(11346002)(446003)(478600001)(53936002)(26005)(486006)(33656002)(39060400002)(476003)(6436002)(68736007)(55016002)(229853002)(305945005)(5660300001)(99286004)(86362001)(25786009)(316002)(8936002)(2201001)(53546011)(6506007)(66066001)(74316002)(256004)(2900100001)(2501003)(6246003)(217873002)(106356001)(102836004)(5250100002)(7696005)(97736004)(76176011)(8676002)(81156014)(14454004)(7736002)(105586002)(81166006)(110136005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3434;H:MWHPR0201MB3481.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 5518c3c5-8855-4d2b-3537-08d5f6e6a169
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR0201MB3434;
x-ms-traffictypediagnostic: MWHPR0201MB3434:
x-microsoft-antispam-prvs: <MWHPR0201MB3434A299FF03B45F2F046027C22E0@MWHPR0201MB3434.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(85827821059158)(80048183373757)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR0201MB3434;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3434;
x-forefront-prvs: 0750463DC9
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Jk6lIAcZqzO2g9JAndRG454lHD6J2G23+kls+HaEPSef6j/9ZfmYjjA7a7rjSZQn5St+TGKsYg+RCgkpCc57ppIO1vI0JTbj10Yvo6/c/souZEYDrPzkzOOdQaKvnrygVpiJIQOfbKU/kaRuj71/4o+zwr6/vzIcwKZbNxVU2L8r1rQhb9MoANjsLVcHBgSxN/K2SmKP2DlXP41UN23h9QDAqK5qvKScNODJibfBzKEqJrtjWcN4bp5vUDK32ITp1ViXX2OLY1Tgmxk+0NEPY1kCcEFbfM13sR8CfnHjok1Q4B3Sxjf/uzD7MmyQuGW1jo3CVDQ1130UbKDgu2ozjjsLOKzy3H5CbPW3fa2dNvc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5518c3c5-8855-4d2b-3537-08d5f6e6a169
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2018 13:07:55.1969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3434
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Alan Tull

> -----Original Message-----
> From: Nava kishore Manne [mailto:nava.manne@xilinx.com]
> Sent: Wednesday, August 1, 2018 3:35 PM
> To: robh+dt@kernel.org; mark.rutland@arm.com; Michal Simek
> <michals@xilinx.com>; Soren Brinkmann <sorenb@xilinx.com>;
> atull@opensource.altera.com; moritz.fischer@ettus.com; Nava kishore Manne
> <navam@xilinx.com>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Appana Durga
> Kedareswara Rao <appanad@xilinx.com>; chinnikishore369@gmail.com
> Cc: Nava kishore Manne <navam@xilinx.com>
> Subject: [RFC PATCH 1/2] ARM: dt: fpga: Added binding docs for Xilinx zyn=
qmp
> FPGA manager
>=20
> New bindings document for zynqmp fpga manager.
>=20
> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> ---
>  .../devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   | 9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-
> pcap-fpga.txt
>=20
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-
> fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-
> fpga.txt
> new file mode 100644
> index 000000000000..0eac747747f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> @@ -0,0 +1,9 @@
> +Xilinx Zynqmp FPGA Manager
> +
> +Required properties:
> +- compatible:		should contain "xlnx,zynqmp-pcap-fpga"
> +
> +Example:
> +	pcap: pcap@00 {
> +		compatible =3D "xlnx,zynqmp-pcap-fpga";
> +	};
> --
> 2.18.0

