Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966045AbeE2S33 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:29:29 -0400
Received: from mail-sn1nam01on0057.outbound.protection.outlook.com ([104.47.32.57]:32611
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965726AbeE2S30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:29:26 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: "Konopko, Igor J" <igor.j.konopko@intel.com>
CC: =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Dziegielewski, Marcin" <marcin.dziegielewski@intel.com>
Subject: Re: [GIT PULL 16/20] lightnvm: error handling when whole line is bad
Thread-Topic: [GIT PULL 16/20] lightnvm: error handling when whole line is bad
Thread-Index: AQHT9nLk+7vqiSCzNkOz9kbNSFk2TqRGsWQAgABXlQA=
Date: Tue, 29 May 2018 18:29:19 +0000
Message-ID: <19F83A5D-1449-4F9F-B8E3-0B2B104DA1D2@cnexlabs.com>
References: <20180528085841.26684-1-mb@lightnvm.io>
 <20180528085841.26684-17-mb@lightnvm.io>
 <C161E678-ADEE-4E05-AC19-B54358005532@cnexlabs.com>
 <76C92B909A93A84C99173B331AB578DAC7AB5252@irsmsx111.ger.corp.intel.com>
In-Reply-To: <76C92B909A93A84C99173B331AB578DAC7AB5252@irsmsx111.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB906;7:Osmlo/AiNT/0HAIbS4cV2e3proz4vf7TbgJ5nte0RlVbUEmD80z+JZ4sZM9jhpbfenbT1+AqwP4yrR6h5FQqgUd4ngEmvu2sY98bWx+477t9oU40ArBKzrickb7fmq+8PP/lvgytFMDVeengi9ZihDXvdptWz3UTqodg8RjgwuO2+2oyW9MHMATjOxGGKgC0RWRVZrUTNxZ0w8TQDWGWKaluXqajTTUG5At6EjT1jMM9Ogj4NREyug1junydabhv
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB906;
x-ms-traffictypediagnostic: CO2PR06MB906:
x-microsoft-antispam-prvs: <CO2PR06MB906846BAA18D47E66645177BA6D0@CO2PR06MB906.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(17755550239193);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB906;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB906;
x-forefront-prvs: 0687389FB0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39380400002)(39840400004)(396003)(366004)(189003)(199004)(186003)(3280700002)(3660700001)(26005)(14454004)(6436002)(3846002)(305945005)(68736007)(6116002)(53936002)(93886005)(478600001)(54906003)(59450400001)(229853002)(82746002)(6486002)(99286004)(76176011)(2906002)(33656002)(2900100001)(6916009)(8936002)(66066001)(5660300001)(36756003)(316002)(102836004)(25786009)(6506007)(105586002)(106356001)(486006)(6512007)(99936001)(86362001)(97736004)(476003)(81156014)(81166006)(6246003)(8676002)(4326008)(83716003)(446003)(11346002)(2616005)(5250100002)(7736002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB906;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 0HSJ/tLaRPQuEilyS2r9P1Jcyd03IQE8cIboQ9niIwe7GZ6jHjddmSHW9sWa4WwLn1XUub+O5aMkQ8qjFtcMRdwdAxVdWglYk3Q6taissgl+wdjdWxOwF5EEsDjtH55ku7ozvWELKIdprvEQbmG5eVZAxuIsECtmqNDz9x3qBk2Yjk7IJsZzQP6l5bL1ZQJM
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_5664C234-7830-41B5-92D4-BC7BC63B8AD1";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ddf8775b-e4d8-4727-f457-08d5c59217e8
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf8775b-e4d8-4727-f457-08d5c59217e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2018 18:29:19.9208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB906
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_5664C234-7830-41B5-92D4-BC7BC63B8AD1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

> On 29 May 2018, at 15.15, Konopko, Igor J <igor.j.konopko@intel.com> wrote:
> 
>> From: Javier Gonzalez [mailto:javier@cnexlabs.com]
>> This case cannot occur on the only user of the function
>> (pblk_recov_l2p()). On the previous check (pblk_line_was_written()), we
>> verify the state of the line and the position of the first good chunk. In
>> the case of a bad line (less chunks than a given threshold to allow
>> emeta), the recovery will not be carried out in the line.
> You are right. It looks that during my testing there was some
> inconsistency between chunks state table which is verified inside
> pblk_line_was_written() and blk_bitmap which was read from emeta and
> is verified in pblk_line_smeta_start(). I'm living decision to
> maintainers whether we should keep this sanity check or not - it
> really just pass gracefully the result from pblk_line_smeta_start()
> where similar sanity check is present.
> 

Let's avoid an extra check now that there is no users for it in the
current flow. If we have a new use for pblk_line_smeta_start() on a flow
that does cannot offer the same guarantees, we can add it at that point.

Javier

--Apple-Mail=_5664C234-7830-41B5-92D4-BC7BC63B8AD1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlsNm/cACgkQIX4xUKFR
nnRZ6A/8D5UCV2VtrlxE60KDd+UJYs1q/Ltj8xlZe1MXmexaFRYEAUb4Li6UABo6
Zv0cN7u8gIGX61UVvFmNu4fk9++WurBLjdptqMDYk2CFynG4nOx4KfYjZNzYjuEf
F5oqZczCDlqJmVXsJW3qZLq2qU/Tq1BYD58Mhh7yZ2G3Ph0ThK2l0Wgo9Jcx7hgi
G0CY+Oa79yjS5YBvn1ENywf6L6y4FzjPr1ah3l3mdkFiMIfw7kB+fE5eNvD1Kt0d
eHMwi+H9T/EUKJGAHOyEKwCEC/cEKIMHQNzromeNHRN6xdGzOY+VcTThKBMpmuEU
o7GYEX+d+5lEH/PkNtHWq/1KrAbrvR0qdYcGTFlJXE8YQkF77mNJoRtx6O2XXFed
A5kU8pRnDNI5Um60gxu1dWBCWAjz+8L/GPg89YT9PA2WPI6zDJrBS1RRrVTAGIWr
YG3DWtdO5+jhD6KuGSFijhyT/Diteq65eV9eTByqxJr8Cwdsz2atoLDrm84Rsmwh
/59HDL0f9g9xIPTf8BD7FyUMR8auPL18ODbWoR8BGFgPqiq1AgnE8T60irv0KhLz
kk5iQhleuNH3+AiqL+aFPYHWUZO2xFuDJOxh0eliacZp+OjhZNur1rczgH3FCWwV
z5s2MRx9fH/WKvZp01b5d51SQ1XZpt7r4D24Amo7svgj21sH+kk=
=hwe1
-----END PGP SIGNATURE-----

--Apple-Mail=_5664C234-7830-41B5-92D4-BC7BC63B8AD1--
