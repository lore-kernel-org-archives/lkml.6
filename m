Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752391AbeCCV2A (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 16:28:00 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49472 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752205AbeCCV17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 16:27:59 -0500
From: Sahil Rihan <srihan@fb.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alexei Starovoitov <ast@fb.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: [Regression] TPM char device not created if TPM 1.2 is disabled, but
 visible
Thread-Topic: [Regression] TPM char device not created if TPM 1.2 is disabled,
 but visible
Thread-Index: AQHTszZzFC58ocR1302YTljwLq5BPQ==
Date: Sat, 3 Mar 2018 21:27:36 +0000
Message-ID: <875E6A7D-483D-4A8F-9382-6B3970598866@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:180::1:7082]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2SPR00MB05;7:0gTdhMy31iz81+PzIl4ymrJJ9jCk5g3iG73vgVGbxeN0bmU5Jyn3bYFMFYHMLuQe1kVBpxLQRWKk6g8MZ/9zr/z0+YN5vp411bdJOxeRWH5D59g/YkPFWTzQNfmCayFMLveJf5ak70K6+mi8TPt0++tzHtFkS85Nb2C4DxWDQXPMF9y1WP9YQAI3PfX8L+INyCEXyrXS6G1Kz4/bSoi3uHNP6Fsw+CF7+boUdjZmJvwRHeOv7FKx7WHpkt4SBpzI;20:7HxRCKuRI0RReG6n4DenuntYHma8rzfHl4Xj4B5rPXB/G3q5O5o+aDoOffMiYGeXrI/qw43jeIQmxGl5o8QQr8LGnGuoZtQ+LWXQoXwxsq+w8LHvVkofcbVy3TmhHoYl83mhZjoC7BJ561zUCscAtw8aIv2FebGGX+UHin688fI=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39380400002)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(1857600001)(53936002)(6116002)(102836004)(4326008)(186003)(97736004)(106356001)(2351001)(6506007)(316002)(36756003)(33656002)(14454004)(82746002)(54906003)(6916009)(6436002)(6486002)(3280700002)(46003)(8676002)(2501003)(5660300001)(5250100002)(8936002)(7736002)(81156014)(305945005)(81166006)(59450400001)(105586002)(6512007)(68736007)(2900100001)(86362001)(3660700001)(2906002)(5640700003)(99286004)(478600001)(83716003)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2SPR00MB05;H:MWHPR15MB1149.namprd15.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-correlation-id: 74e3ee4e-388a-44f0-cf64-08d5814d95b4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:SN2SPR00MB05;
x-ms-traffictypediagnostic: SN2SPR00MB05:
x-microsoft-antispam-prvs: <SN2SPR00MB05FDD6F487CAEC27C1406CBEC40@SN2SPR00MB05.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(11241501184)(944501244)(52105095)(3002001)(6041288)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:SN2SPR00MB05;BCL:0;PCL:0;RULEID:;SRVR:SN2SPR00MB05;
x-forefront-prvs: 0600F93FE1
x-microsoft-antispam-message-info: LCfCNz4GeKG9Z0iJJVoQJxp7Fp8kNEG5/mPt8PmVL+ihcYCCHKL1vRxrmrJY1ju5xU1QWwI7WwAtePObZ0RTU7VlQcUW3r9Bfxvg/6dGyXsmBQg/YpT53jZpFW6VjnpKtBW1dxbF5dpWSK2PyCUWi0rJ9PG/7+4RAbE4n5cncG4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D9789300E120E40BE35776C5AC1A314@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e3ee4e-388a-44f0-cf64-08d5814d95b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 21:27:36.4725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2SPR00MB05
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-03_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w23LS5IE026401

(Please CC me on replies - I'm not subscribed to LMKL)

Prior to  0cf577a03f21 if a TPM 1.2 device was disabled, but visible (sysfs node "enabled" returns 0), creation of the TPM char device was only skipped if  tpm_bios_log_setup returned -ENODEV. 

On some systems like HP DL380 G9, if the TPM is disabled but visible, the TCPA log is empty, which means tpm_read_log_acpi returns -EIO.  Starting with 0cf577a03f21, -EIO triggers an early return from tpm_chip_register which means the char device is not created.

Log snippet:
[    4.320387] tpm_tis 00:00: 1.2 TPM (device-id 0xB, rev-id 16)
[    4.455389] tpm tpm0: A TPM error (7) occurred attempting to read a pcr value
[    4.457762] tpm tpm0: TPM is disabled/deactivated (0x7)
[    4.459461] tpm tpm0: tpm_read_log_acpi: TCPA log area empty    <----------------------
[    4.461312] tpm_tis: probe of 00:00 failed with error -5

Thanks,
Sahil
