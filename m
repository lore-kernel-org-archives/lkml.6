Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753021AbeBEM5b (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 07:57:31 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:2808 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbeBEM5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 07:57:22 -0500
X-IronPort-AV: E=Sophos;i="5.46,464,1511798400";
   d="scan'208";a="71154127"
From: Avri Altman <Avri.Altman@wdc.com>
To: "Asutosh Das (asd)" <asutoshd@codeaurora.org>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "rnayak@codeaurora.org" <rnayak@codeaurora.org>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] scsi: ufs: make sure all interrupts are processed
Thread-Topic: [PATCH 1/1] scsi: ufs: make sure all interrupts are processed
Thread-Index: AQHTmYaHcSUT5SYu3EOc2oEnVQ6gu6ONmZLwgALdrICABNE6AIAAg6Qg
Date: Mon, 5 Feb 2018 12:57:18 +0000
Message-ID: <DM5PR04MB10856D45C7281AC736D328B7FCFE0@DM5PR04MB1085.namprd04.prod.outlook.com>
References: <1517288066-13171-1-git-send-email-asutoshd@codeaurora.org>
 <DM5PR04MB1085C5039CA525D6FB77DBE3FCFB0@DM5PR04MB1085.namprd04.prod.outlook.com>
 <6ca20a27-3c10-bf0e-35e7-542b7ab77356@codeaurora.org>
 <b336fa7b-e79e-95b8-ea21-7b1e2b01677d@codeaurora.org>
In-Reply-To: <b336fa7b-e79e-95b8-ea21-7b1e2b01677d@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB0619;7:ek1njcLowZHp5tqeh7hjnMkkq8IPTZEkrJWuERZug8uMrPTzwJBx1Dly/5c6uh6VNMdtAt8XKZGOYXLumbTSrexIUpDlzPAIinNP8JIOrIIW9/uXbHFlT4NNMHWsaB1GtuCmTUGRH+D8UG1nynZCTiNzPMG8HP9tZXGAxP5NwraP8U0YQCZ58GxKSgEo0stMtPoUp65D1qSDZeKa1AYKzS2JQNZVArmit9eOyVh0FI7p0ECRy1RjzM2BzddUHdA4;20:cXFsLe1CJSKpgrPaqAaD77ysM14eQ+PkH1dRlR1raLwHEqN8JxvCu3N80BV9wFiR62p12x8zNgmlUMaaGK8u9vdJgszWFBxMrsIP3+5XvJfCFzUrqVvbFiHCHuNAx+NbU4J2WhRSytbfwCF42uS8gWEX5uo/ESS4HefoIrdoc6c=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5c91b8b8-9237-43a4-cd84-08d56c97fd7d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM5PR04MB0619;
x-ms-traffictypediagnostic: DM5PR04MB0619:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM5PR04MB0619F1F4987A88780CAED086FCFE0@DM5PR04MB0619.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(104084551191319)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231101)(2400082)(944501161)(3002001)(6055026)(6041288)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR04MB0619;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB0619;
x-forefront-prvs: 0574D4712B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(39860400002)(366004)(39380400002)(13464003)(199004)(189003)(7416002)(14454004)(8936002)(81156014)(5660300001)(2900100001)(6246003)(2906002)(39060400002)(81166006)(25786009)(8676002)(478600001)(66066001)(93886005)(54906003)(2201001)(186003)(6116002)(99286004)(3846002)(97736004)(86362001)(316002)(68736007)(110136005)(105586002)(106356001)(7736002)(9686003)(3280700002)(33656002)(3660700001)(7696005)(2501003)(305945005)(229853002)(76176011)(2950100002)(4326008)(74316002)(26005)(55016002)(53936002)(6436002)(59450400001)(6506007)(102836004)(77096007)(72206003)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB0619;H:DM5PR04MB1085.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: mH/Sw87EyRoJ23b8vPPDNQ7DRIeAU68fyDHH82CYbsN9knHMhPHGhphA6mB+hknoBJF3LEh+xK8rz0LKqRtfew==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c91b8b8-9237-43a4-cd84-08d56c97fd7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2018 12:57:19.0597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0619
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w15CvqH8028864



> >>> -----Original Message-----
> >>> From: linux-scsi-owner@vger.kernel.org [mailto:linux-scsi-
> >>> owner@vger.kernel.org] On Behalf Of Asutosh Das
> >>> Sent: Tuesday, January 30, 2018 6:54 AM
> >>> To: subhashj@codeaurora.org; cang@codeaurora.org;
> >>> vivek.gautam@codeaurora.org; rnayak@codeaurora.org;
> >>> vinholikatti@gmail.com; jejb@linux.vnet.ibm.com;
> >>> martin.petersen@oracle.com
> >>> Cc: linux-scsi@vger.kernel.org; Venkat Gopalakrishnan
> >>> <venkatg@codeaurora.org>; Asutosh Das <asutoshd@codeaurora.org>;
> >>> open list <linux-kernel@vger.kernel.org>
> >>> Subject: [PATCH 1/1] scsi: ufs: make sure all interrupts are
> >>> processed
> >>>
> >>> From: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> >>>
> >>> As multiple requests are submitted to the ufs host controller in
> >>> parallel there could be instances where the command completion
> >>> interrupt arrives later for a request that is already processed
> >>> earlier as the corresponding doorbell was cleared when handling the
> >>> previous interrupt. Read the interrupt status in a loop after
> >>> processing the received interrupt to catch such interrupts and
> >>> handle it.
> >>>
> >>> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> >>> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Tested-by: avri.altman@wdc.com

Tested on kirin960 (mate9)  and msm8998 (htc11), both where interrupt aggregation is not allowed.

As a side note, I noticed that this patch is part of several patches, fixing some qcom-staff.
Maybe you want to put them all in a patchset?

Thanks,
Avri
