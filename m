Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbeFDLhA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:37:00 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:24503 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbeFDLg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:36:58 -0400
X-IronPort-AV: E=Sophos;i="5.49,476,1520870400";
   d="scan'208";a="79551018"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: return when BLK_MQ_S_STOPPED in
 blk_mq_run_work_fn
Thread-Topic: [PATCH] blk-mq: return when BLK_MQ_S_STOPPED in
 blk_mq_run_work_fn
Thread-Index: AQHT++LktZto+gtBn022uZFmNCTA0KRP+OQA
Date: Mon, 4 Jun 2018 11:36:54 +0000
Message-ID: <c8f8ad2989f641187091a5d917538dc30085bf71.camel@wdc.com>
References: <1528103035-8009-1-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1528103035-8009-1-git-send-email-jianchao.w.wang@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [178.117.55.239]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0878;7:hxgSqX+p4ktpcP1u9Jnv/XnF/UxqhPOmm+ewdtlkt1RxhMwNrAbPLZMXIfNefd44rVWHdQvpOyjIYqqedijtb3tCyQHDTZhzJE1WcsUO1trVU0yNfki5ryTC+RZ1kqmmt9SP32+lLHBNo6NdlWLd4T8aC5P63FzQ3CHUZIT0NdvOtfr+hcGuA8Ux9YMyihOqdXnNBzLqTFTs3u3PwFey5zVtFimeqY5b/fFstv+lBA3/AYioUiV8rQf5wSTtbYlk;20:m8+o85+r7bffXtTrf6a5cUSvKemTWnO0MqqkuchMgNcCqY2HSBQUn1bRgIzPkOrQJN67zWC+nQ8fXFoB0naFdXQlp79lppYZ4sGflA3tCz6lKO9+Bm5hFxYkCWKn8y4NMNsVzmjrtSxX1bJvAxUTTWHZ6SgUWqH7yPhFUxmaJ3A=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0878;
x-ms-traffictypediagnostic: MWHPR04MB0878:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB087848ACC1F206CFBFFD32AB98670@MWHPR04MB0878.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0878;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0878;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(39860400002)(396003)(376002)(366004)(189003)(199004)(476003)(68736007)(81156014)(81166006)(2906002)(6436002)(99286004)(2900100001)(486006)(6486002)(5660300001)(2501003)(102836004)(558084003)(316002)(186003)(2616005)(110136005)(54906003)(8676002)(11346002)(26005)(446003)(6506007)(229853002)(5250100002)(36756003)(118296001)(8936002)(3280700002)(6512007)(478600001)(2201001)(76176011)(25786009)(106356001)(7736002)(3660700001)(305945005)(97736004)(3846002)(6116002)(72206003)(53936002)(66066001)(6246003)(86362001)(105586002)(4326008)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0878;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: PpZG5bY7xkuaT95yCs3M3+tNMtqF9v8vWPDw9I2FIAjoYZGvzkif5/9qf/XPlqs/ds9dIEgGqlbdKcslrPjQ4uGeDL3yCcLV0idFw5rjZSBHZOhzMSKjXdaMvAikGEw92VE3EAruXF4SwXs+WoZsLssOUI/qAOtNSD0EUtYH8JVEnKNE95mTPeehak3heeeR
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F89785310A73234BA5E6D36465C05349@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 290be81e-79bd-4e82-4486-08d5ca0f78b6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 290be81e-79bd-4e82-4486-08d5ca0f78b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 11:36:54.0386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0878
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w54Bb6U4008009

On Mon, 2018-06-04 at 17:03 +0800, Jianchao Wang wrote:
> if hctx is stopped, don't run the queue in blk_mq_run_work_fn.

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
