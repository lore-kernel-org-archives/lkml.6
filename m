Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752160AbeEQU24 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:28:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58878 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751671AbeEQU2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:28:55 -0400
From: Matt Mullins <mmullins@fb.com>
To: "davem@davemloft.net" <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Dave Watson <davejwatson@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aviadye@mellanox.com" <aviadye@mellanox.com>,
        Doron Roberts-Kedes <doronrk@fb.com>
Subject: Re: [PATCH net] tls: don't use stack memory in a scatterlist
Thread-Topic: [PATCH net] tls: don't use stack memory in a scatterlist
Thread-Index: AQHT7T4+bIQkA99UI0GMWrqFJENYvaQ0RX0AgAAbUwA=
Date: Thu, 17 May 2018 20:28:46 +0000
Message-ID: <1526588924.24138.2.camel@fb.com>
References: <20180516174841.2119-1-mmullins@fb.com>
         <20180517.145056.1635507477734784563.davem@davemloft.net>
In-Reply-To: <20180517.145056.1635507477734784563.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::7:affc]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1663;7:zeiNAFX1do2r/YIHjwrbSmx1kb5/UXfzPMJ8DNq3nurfH99GuhEjyU6yQy4VmDyxGXE5M5tkV4SRWk88nvy2/sqv/OVEyGQ6bj2ywolZxiuLlhd006PHohDB0uGU4vgSGtio3uOiaetG7SH5HfqpRQWoCf/T1KuzdB3VDr5c5pn9ZqpDTpYPZqeFPfWIIAkeBEhZItc3UrTPcMdT3dNzMLWQckV43DOVuprEg5PvttQ2+T70RI3ooH09sr9t2RiH;20:HUWCueqmqZLEydgsme8JtZy94dNLjUK4PcUTB4CZiQ91lCXYXzrt3rL/gOJeH5akivBZwaOJKGmyAT/Cpd0CVMVshbEKN65hsZKJ/ve/OkRKJd8Y8EiDmAUzkD3sBWD+AGln1oFoBAFmhEthueBAPvmbIJIlKL2gF+SpB7gECsM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39860400002)(376002)(39380400002)(396003)(346002)(366004)(377424004)(199004)(189003)(5250100002)(486006)(229853002)(6436002)(2501003)(99286004)(5640700003)(4326008)(6246003)(446003)(1730700003)(2616005)(81166006)(11346002)(81156014)(103116003)(8676002)(476003)(106356001)(105586002)(6486002)(3660700001)(68736007)(102836004)(7736002)(6506007)(6512007)(2351001)(8936002)(53936002)(6116002)(2906002)(97736004)(305945005)(14454004)(36756003)(186003)(54906003)(478600001)(46003)(76176011)(25786009)(2900100001)(316002)(86362001)(6916009)(5660300001)(3280700002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1663;H:MWHPR15MB1262.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1663;
x-ms-traffictypediagnostic: MWHPR15MB1663:
x-microsoft-antispam-prvs: <MWHPR15MB1663BAC2F548180788CC77CEB0910@MWHPR15MB1663.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(11241501184)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR15MB1663;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1663;
x-forefront-prvs: 067553F396
x-microsoft-antispam-message-info: NhoE8fScjF8k8Hv33ttgxhjV/EEojsWUWY8c9EsOE5TQ1Db+ykH95v4chrYoGSLW0+UsSJ7/SFgv5MaZaU6kaRewZGrUZlDHI04RMNIMhR/CEN/pR1HvxeWF0o0v7IsCK0jifNIwBXPfkBkUiKRnI0SVk27FccEM8T41SWt1f1eZAsagE4HcxhoW3qbqMmDQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2775A9CFE0E5904D8B6D9C1A664F1920@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8672f82b-8ffe-4203-01ee-08d5bc34ca8c
X-MS-Exchange-CrossTenant-Network-Message-Id: 8672f82b-8ffe-4203-01ee-08d5bc34ca8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2018 20:28:46.3568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1663
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4HKT2qC007300

On Thu, 2018-05-17 at 14:50 -0400, David Miller wrote:
> I'm surprised this problem wasn't discovered sooner.  How exactly did you
> discover it?  Did you actually see it trigger or is this purely from code
> inspection?

Honestly, I'm not sure how it got uncovered, but it was observed at
runtime.  Doron Roberts-Kedes hit a null pointer dereference so we
turned on CONFIG_DEBUG_SG -- then it became a proper
BUG_ON(!virt_addr_valid(buf)); in sg_set_buf.
