Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164543AbeE1K7X (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:59:23 -0400
Received: from mail-dm3nam03on0088.outbound.protection.outlook.com ([104.47.41.88]:27552
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1164219AbeE1K7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:59:08 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>,
        Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Subject: Re: [GIT PULL 16/20] lightnvm: error handling when whole line is bad
Thread-Topic: [GIT PULL 16/20] lightnvm: error handling when whole line is bad
Thread-Index: AQHT9nLhZQG0AWZ7+0eSepUfeJyN1w==
Date: Mon, 28 May 2018 10:59:03 +0000
Message-ID: <C161E678-ADEE-4E05-AC19-B54358005532@cnexlabs.com>
References: <20180528085841.26684-1-mb@lightnvm.io>
 <20180528085841.26684-17-mb@lightnvm.io>
In-Reply-To: <20180528085841.26684-17-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB491;7:4JMmXD3eRcOg8KHbjlC7q9KiQMD7pWOdxioVrukrJdWoTUX7wdBgj06ivqHPldrtQBbCwAx4QQ4dydmSUClcE5+SSW37d89zm4SrS9FqLJ71WO0uqxZvKhGCt/ihppqbMHFmf0glu/Q/WpEPnDi9ry/45tCy+qx/y/u/KKRolgSt8DdF8vb/ztG5Wyh7dKIjFmFPyxiP0ezMDNAz/kOPVwAEuPBz8olTougtfD0f43Q706+VDfjc54M6YwU8X0FY
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO2PR06MB491;
x-ms-traffictypediagnostic: CO2PR06MB491:
x-microsoft-antispam-prvs: <CO2PR06MB491D57F3E685523A3D569D6BA6E0@CO2PR06MB491.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB491;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB491;
x-forefront-prvs: 06860EDC7B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(376002)(366004)(39830400003)(396003)(189003)(199004)(6916009)(486006)(76176011)(14454004)(86362001)(53936002)(82746002)(6512007)(6436002)(102836004)(5250100002)(83716003)(97736004)(478600001)(3660700001)(54906003)(2900100001)(316002)(25786009)(2906002)(3280700002)(68736007)(186003)(26005)(99286004)(66066001)(8936002)(81156014)(8676002)(6246003)(36756003)(476003)(446003)(59450400001)(105586002)(81166006)(2616005)(6506007)(229853002)(11346002)(5660300001)(305945005)(33656002)(6116002)(4326008)(106356001)(3846002)(6486002)(7736002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB491;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: dFgBImAi+H6CzAU8bxHcDmzvnu1HSR9b1h1TrUh/T4BijmYIW+CpfrqI64rhZWrg1dDfdhWgTHflO/IvL6yB+2MGoVmtKV4tgd1Qsi//8pEjMmlpRr1kYyjwWFNai5U1Is0ytkL51BA84FJozNlUjUaNr2tzAIMiRWvKveHLte2apOzd7gMobp7x7hkCYx0q
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <72E2B33D0636A841ABBB7FD0EEC1251E@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5e01f252-0192-4a49-df09-08d5c48a064b
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e01f252-0192-4a49-df09-08d5c48a064b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2018 10:59:03.2334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB491
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4SAxVjN016939

> On 28 May 2018, at 10.58, Matias Bjørling <mb@lightnvm.io> wrote:
> 
> From: Igor Konopko <igor.j.konopko@intel.com>
> 
> When all the blocks (chunks) in line are marked as bad (offline)
> we shouldn't try to read smeta during init process.
> 
> Currently we are trying to do so by passing -1 as PPA address,
> what causes multiple warnings, that we issuing IOs to out-of-bound
> PPAs.
> 
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
> Updated title.
> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
> ---
> drivers/lightnvm/pblk-core.c | 5 +++++
> 1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index a20b41c355c5..e3e883547198 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -868,6 +868,11 @@ int pblk_line_read_smeta(struct pblk *pblk, struct pblk_line *line)
> {
> 	u64 bpaddr = pblk_line_smeta_start(pblk, line);
> 
> +	if (bpaddr == -1) {
> +		/* Whole line is bad - do not try to read smeta. */
> +		return 1;
> +	}

This case cannot occur on the only user of the function
(pblk_recov_l2p()). On the previous check (pblk_line_was_written()), we
verify the state of the line and the position of the first good chunk. In
the case of a bad line (less chunks than a given threshold to allow
emeta), the recovery will not be carried out in the line.

Javier
