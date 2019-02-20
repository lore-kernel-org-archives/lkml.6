Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3166C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 692CF20685
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="AN1siM6S";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="hr5pKs8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfBTLDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:03:25 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:41408 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727861AbfBTLDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:03:07 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1KAxjnY011413;
        Wed, 20 Feb 2019 03:02:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=goiywu0xoiwJs159gu1upTvAXSUOFcCgckDH2lDUP7k=;
 b=AN1siM6SmjwLjPx2QFyCS1sw0qNZ5XxsfFrkCX+kUK+UOtq3nTqsFiJKqNRKBdP1qBWI
 BkekNT7B7DJGaFmv+Pmn3XadzJoWOt8R/xMjkYRemq5Tw4zqIEqOacVfplcAbHHecHsa
 bfz2eP6/Xy2tHkgJi3qa9Ox6QOE78aC2wqI/0Z7GGsyKVevcSWaZsYQHtCZp38Qp8SyV
 G+mwG+WIChxS2C1N+EzIBsO5MG3aLVuqfWiy23QaB6+rk6obLdOddF19CcK6QQfHapoH
 p/mH+n90F8QSvBNaNylg4ImyR2/YldZ5vs5x8EECsbvwWAkiCrFwixMEETlRnmHWpVW1 ag== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2qrh8xbr2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Feb 2019 03:02:49 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 20 Feb
 2019 03:02:47 -0800
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.54) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 20 Feb 2019 03:02:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goiywu0xoiwJs159gu1upTvAXSUOFcCgckDH2lDUP7k=;
 b=hr5pKs8G5TLKeRxvTrEEfw/C6kOW056U25RZZWCNyjbc/PO5U+phetYAQZRVZMw0RgJujuVqGGOI9lkaPoRCsKb+Di773RTNjhlHLv9qNttfD4o9b8r/mEhOAFOeYy5VMtWNQCItDGflNPD45v2fLfiw/tRCjo3BE6nlQ7u4ILA=
Received: from CY4PR18MB1112.namprd18.prod.outlook.com (10.173.183.147) by
 CY4PR18MB1350.namprd18.prod.outlook.com (10.173.247.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Wed, 20 Feb 2019 11:02:43 +0000
Received: from CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4]) by CY4PR18MB1112.namprd18.prod.outlook.com
 ([fe80::7561:d13b:e106:12b4%4]) with mapi id 15.20.1643.014; Wed, 20 Feb 2019
 11:02:42 +0000
From:   Vadim Lomovtsev <vlomovtsev@marvell.com>
To:     "sgoutham@cavium.com" <sgoutham@cavium.com>,
        "sunil.kovvuri@gmail.com" <sunil.kovvuri@gmail.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "dnelson@redhat.com" <dnelson@redhat.com>,
        Vadim Lomovtsev <vlomovtsev@marvell.com>
Subject: [PATCH v3 0/8] nic: thunderx: fix communication races between VF & PF
Thread-Topic: [PATCH v3 0/8] nic: thunderx: fix communication races between VF
 & PF
Thread-Index: AQHUyQvNOlcO8xFId0+BQURXujZvyA==
Date:   Wed, 20 Feb 2019 11:02:42 +0000
Message-ID: <20190220110225.9497-1-vlomovtsev@marvell.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
In-Reply-To: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [4.28.12.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b2ff20c-ac4f-4dfb-471b-08d69722eff1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR18MB1350;
x-ms-traffictypediagnostic: CY4PR18MB1350:
x-microsoft-exchange-diagnostics: 1;CY4PR18MB1350;20:JKmeGyZM7uFjxmkCZrDjK8zJXtBE3ZoQ4Uk8XszvokoNmKg3LB45VTTmL6J96bPq5cWzmhuEuV9Gy3sD0txYp6cEFoiJYYiZu2OuGONDuk/Ym6Dueg29oifC/U5DnL83y2nslkwimtBzwrqKH0eh+YwdPGcAhMnfVn6bQCkbl94=
x-microsoft-antispam-prvs: <CY4PR18MB1350FF9C080451F4085BC861CD7D0@CY4PR18MB1350.namprd18.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(86362001)(97736004)(478600001)(476003)(11346002)(2616005)(14444005)(68736007)(446003)(6512007)(5660300002)(256004)(186003)(99286004)(14454004)(76176011)(2906002)(36756003)(6486002)(2201001)(102836004)(6506007)(2501003)(6436002)(26005)(316002)(8936002)(305945005)(7736002)(25786009)(1076003)(53936002)(71200400001)(54906003)(81156014)(4326008)(110136005)(106356001)(107886003)(66066001)(81166006)(6116002)(8676002)(71190400001)(105586002)(3846002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR18MB1350;H:CY4PR18MB1112.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8vYcK1LpfXRPldeFMqcd9LiQ+Zji0Oruaaqj4kCILnIiMGIc3JISVxWKJyXARs6nSroF/StqgOl8VhbSSJPxJy/fv2v94PiVAS0uszKC/IoCXArmYR1WrYl1gjZTCQrakR8LmTCKNqLXu5DlDBsTz3/cp3Pjw5KFkVMHCRWd2Nf31RwoypqFoJsBHoNsjzamCPvKj/zB7Fn2nO+7MIH2rDIxf2z6Azg1E45qmLeSjqm9kIW3mXsKVSmQGkBy8S9NjPJ+LWx+J4geFt7x0khCTvBqUxAt/lhbsZn3gLzH6hq4AyI9Jr/GUnjsBxd9XxIVwLo10HUNPHBa02z9fe/UC/ISk/3TB8uyv8kf54iQW+dFouAFt1YrhZD7dcjvt9bspAfkfxGhTHkk9ixpstlnd7izK8CM5pFAbI6PpN1TZ9c=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2ff20c-ac4f-4dfb-471b-08d69722eff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 11:02:42.8582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1350
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-20_09:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=623 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ThunderX CN88XX NIC Virtual Function driver uses mailbox interface
to communicate to physical function driver. Each of VF has it's own pair
of mailbox registers to read from and write to. The mailbox registers
has no protection from possible races, so it has to be implemented
at software side.

After long term testing by loop of 'ip link set <ifname> up/down'
command it was found that there are two possible scenarios when
race condition appears:
 1. VF receives link change message from PF and VF send RX mode
configuration message to PF in the same time from separate thread.
 2. PF receives RX mode configuration from VF and in the same time,
in separate thread PF detects link status change and sends appropriate
message to particular VF.

Both cases leads to mailbox data to be rewritten, NIC VF messaging control
data to be updated incorrectly and communication sequence gets broken.

This patch series is to address race condition with VF & PF communication.

Changes:
v1 -> v2
 - 0000: correct typo in cover letter subject: 'betwen' -> 'between';
 - move link state polling request task from pf to vf=20
   instead of cheking status of mailbox irq;
v2 -> v3
 - 0003: change return type of nicvf_send_cfg_done() function
   from int to void;
 - 0007: update subject and remove unused variable 'netdev'
   from nicvf_link_status_check_task() function;

Vadim Lomovtsev (8):
  net: thunderx: correct typo in macro name
  net: thunderx: replace global nicvf_rx_mode_wq work queue for all VFs
    to private for each of them.
  net: thunderx: make CFG_DONE message to run through generic send-ack
    sequence
  net: thunderx: add nicvf_send_msg_to_pf result check for
    set_rx_mode_task
  net: thunderx: rework xcast message structure to make it fit into 64
    bit
  net: thunderx: add mutex to protect mailbox from concurrent calls for
    same VF
  net: thunderx: add LINK_CHANGE message handler at nicpf
  net: thunderx: remove link change polling code and info from nicpf

 drivers/net/ethernet/cavium/thunder/nic.h     |  14 +-
 .../net/ethernet/cavium/thunder/nic_main.c    | 149 ++++++------------
 .../net/ethernet/cavium/thunder/nicvf_main.c  | 130 ++++++++++-----
 .../net/ethernet/cavium/thunder/thunder_bgx.c |   2 +-
 .../net/ethernet/cavium/thunder/thunder_bgx.h |   2 +-
 5 files changed, 144 insertions(+), 153 deletions(-)

--=20
2.17.2
