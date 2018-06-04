Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753607AbeFDOxV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:53:21 -0400
Received: from mail-sn1nam01on0059.outbound.protection.outlook.com ([104.47.32.59]:57264
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751784AbeFDOxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:53:19 -0400
From: "Tayar, Tomer" <Tomer.Tayar@cavium.com>
To: YueHaibing <yuehaibing@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Elior, Ariel" <Ariel.Elior@cavium.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dept-Eng Everest Linux L2 <Dept-EngEverestLinuxL2@cavium.com>
Subject: RE: [PATCH net-next] qed: use dma_zalloc_coherent instead of
 allocator/memset
Thread-Topic: [PATCH net-next] qed: use dma_zalloc_coherent instead of
 allocator/memset
Thread-Index: AQHT/AV/Ocq0yZYsKUaAAM+tQdR0LqRQLa5Q
Date: Mon, 4 Jun 2018 14:53:15 +0000
Message-ID: <BN3PR07MB254752026445D0C36508C97180670@BN3PR07MB2547.namprd07.prod.outlook.com>
References: <20180604131031.24476-1-yuehaibing@huawei.com>
In-Reply-To: <20180604131031.24476-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tomer.Tayar@cavium.com;
x-originating-ip: [31.168.140.228]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR07MB2483;7:NAPehwIjB52lTaCODhlQ0fhaPBGVYj14wHROkdTXKanLFQXVT43hVRF+JiDXh0jRS0Fm5dtjnQ7RjqlH2QmgeiRNA29Vz3/ZY8bb+W8Sy9PZbiC06MJCzWzr9Fs/SLmSqkuk6SUgB2JP2UaMwpfmFCSOZ6obj3l8c/1t0pPUSBfGw+RWwXHVFoLpFWb25V2LQQFBaEErrbAYdNutSzeY3QBfYpzlb80/I8qnYqahDxj08Vd0A+Yh8Q6BqICLQuk7
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN3PR07MB2483;
x-ms-traffictypediagnostic: BN3PR07MB2483:
x-microsoft-antispam-prvs: <BN3PR07MB2483A8E127EA8119AD01A89380670@BN3PR07MB2483.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BN3PR07MB2483;BCL:0;PCL:0;RULEID:;SRVR:BN3PR07MB2483;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39380400002)(366004)(39850400004)(199004)(189003)(107886003)(6246003)(6436002)(99286004)(55016002)(33656002)(2906002)(72206003)(106356001)(105586002)(3660700001)(316002)(3280700002)(229853002)(8936002)(97736004)(14454004)(5660300001)(74316002)(25786009)(86362001)(478600001)(53936002)(5250100002)(305945005)(66066001)(7736002)(102836004)(2501003)(68736007)(110136005)(54906003)(6506007)(4326008)(2900100001)(6116002)(76176011)(7696005)(3846002)(186003)(9686003)(446003)(486006)(6636002)(11346002)(81156014)(81166006)(558084003)(476003)(26005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR07MB2483;H:BN3PR07MB2547.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: iFQ3GCp5vERJW+ciEa9BUvfiOfg2FbgIjK1o4jq1vVk1Ls81sQShukjvUK/eF3KhwmyubVewgYCRvc98Ozx5THnKPJMqy4GL1vF4jRwQkE96DzzXrekWE/3Og6m+iFJYKGO3aahvVIHS8OgQNNG2hS4h4sFBe5AdXsZuFNt89bO2giWzH/UeZV8/w/4/yONT
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: bbca400d-a447-48c9-ba2f-08d5ca2ae6f8
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbca400d-a447-48c9-ba2f-08d5ca2ae6f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 14:53:15.4079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR07MB2483
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w54ErQDw023438

From: YueHaibing [mailto:yuehaibing@huawei.com]
Sent: Monday, June 04, 2018 4:11 PM

> Use dma_zalloc_coherent instead of dma_alloc_coherent
> followed by memset 0.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks
Acked-by: Tomer Tayar <Tomer.Tayar@cavium.com>
