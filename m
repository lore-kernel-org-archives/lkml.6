Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754579AbeCGTZm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 14:25:42 -0500
Received: from mail-bn3nam01on0068.outbound.protection.outlook.com ([104.47.33.68]:35657
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754052AbeCGTZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 14:25:40 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
Message-ID: <1520450729.13685.19.camel@nxp.com>
Subject: arm crypto .S_shipped files sometimes get rebuilt randomly
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
CC: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Wed, 7 Mar 2018 21:25:29 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131649243386251706;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(39380400002)(2980300002)(1109001)(1110001)(339900001)(189003)(199004)(36756003)(498600001)(85426001)(26826003)(86362001)(53936002)(4326008)(50466002)(8936002)(103116003)(50226002)(23676004)(106466001)(105606002)(305945005)(47776003)(356003)(8676002)(68736007)(5660300001)(81166006)(81156014)(2906002)(5820100001)(2870700001)(956003)(316002)(110136005)(54906003)(59450400001)(26005)(104016004)(336012)(97736004)(99106002)(142923001)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB2273;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD019;1:iYvEkejs6I3h42S7cg6FdLBElQbEF3zoKVAAw3o4u9HNOIPuDKwqave9MLDrvm7pdKXZgBVtUC5QBv24bmeJhN7d7+TFNcOLo3syRv+T3FwVZzPsvdnAshyTCZHN8B0M
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c7af20d-d780-4d60-285a-08d584613571
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BN3PR03MB2273;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2273;3:JxmB4SPasQ9+g7Af2oEC+iNYbjFePMWH//dV3VywPVAH5mxYyvHsNVKbJXcWUOft2N9z6ed+L2h54VixT8gMzMtHE65IfcKWD/j/lsWaAQxW7Hw+kfVrq3p/ZHlfq8Cca1dkIy3jQfYZ4IWK154R21Hvfer1R6/+H6iYMZ1XQEMKo3Kr5Oj51e5IpXK3QeXpALE3TVQOz48NtZDlxLM7e08WiYI0GmVHaEauw58TcukuXcWmlMhohQRDMjBIBpF7Kr0y2YP5iUe9kjDkQq8WxJQf7pri1wPKxhvrYVcIi9ufbySG+M98ycps74rMN9ueHTHwwyMfSglNzuk4pf6SFj7yu84IQrN31S6cfie8Tng=;25:7kunyVvqu1IO3CBAMH0deZLkDR90pgRIz2AhoxkscSbKH1ByAXjNLzymtLKnvaZA81FWRbdyzSBajdqSf+yZ/26E3S5L+20bYfjyHlZGb+s8c8peNA3OtK3NUIDJ6scGyH3NTcUueWXcGWWXNZg7PHeicEvPQYexJ9LLD5KKwUeQtgcI/CYIOwJdfQyvBiGccyrlpQ9cZBiV1VfBBFVoUzn9ujvG2J6gwfrUm1/m0OSXi0Lcxw/il2j2T7Q/VNuvTCKJDxfq0Aw6UqUTADJAfoRACteQ1W9uDq/fiZJeTgZblAnYWKbCmb5o1BrL+63i6E89YI4JbeCCp0S/P1+Y0w==
X-MS-TrafficTypeDiagnostic: BN3PR03MB2273:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2273;31:CTLVD9lyTNQ481IUbas++0kFGmMC7jo1Gk35nwSxBzUidKsid4XIgHbT64xvLQlVmBNMag8Ih3K26lhNNbtGt29t1BRjrRtAYD1LlMhKxFwNWWcw7XEni7Jt983vQRUpzbtadv6qLn9Y08bNh8iV7Xi+j7m+FsGEb5ixAWUOYmh5cEzlmw2xTFad0GmREMRJ83EJ/xGgmvsfirTtTWTwBJcfNA/odUzF3letfJdvLSI=;4:B9tj4qrXjrrsf4mWuVjPkF9EuS334J7FIGULodssOOvfsctnF/U/Wfun8WlqVgq4eeZBfAo7QkXckyCM3uCEke9qdOsABUA0ebnEKdTjjAXnA4G/zZtVfECzoI9MqoA9z8WttLSikhf1/wehfH44aiAXvMIleXwh8qDcn0F5QG/bDFnC8HBy9eDHq9E4uUNJsX+sIJnSTvDFoxTj6tU05akvUDzkJ6DxOOYBoh32+q/YJvN8PvcG6dDtlR+5do/jOOmUkotER5MEfXQZsNYLvA==
X-Microsoft-Antispam-PRVS: <BN3PR03MB2273C3E7CC4AAB895C3719E7EED80@BN3PR03MB2273.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(6096035)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123565025)(20161123563025)(20161123561025)(20161123556025)(201708071742011);SRVR:BN3PR03MB2273;BCL:0;PCL:0;RULEID:(400006);SRVR:BN3PR03MB2273;
X-Forefront-PRVS: 0604AFA86B
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjNQUjAzTUIyMjczOzIzOm1FYzRFYVdubXc0cEpHK3UwOFBJRnYvcUNK?=
 =?utf-8?B?VVhyN2Jzb1hFOTAyYWlNSlZ2YUdCTWFPRWxqVkdJVHQ3UG1RNE4xZFg3dmww?=
 =?utf-8?B?OHJxWnNiZmJ1eEc3czNDQ2VOZzhUbHYxTW9JaWwxbGJRQUM4Rnk3bTZtQ1A2?=
 =?utf-8?B?WXd3OUplRkZJNXVpbEx6SCtjQzEzZ1UwU1B1RjNpM1NzdThtTWZ2RlduMEFs?=
 =?utf-8?B?MlNQU0xXWGxXTENFbWNUK2VTNGFseENCS1NwMzhicWM0SVg2ejd2Ly9GbkpW?=
 =?utf-8?B?b3hKaDZIRGpzaS9aYjhLdzRhNHhLeTFwclYvVzM2TFh1U0hUOVN0M3hvN0FK?=
 =?utf-8?B?YzNabHpBVmZZQWNaRjg1QkZka09VNUJuNWVWZFdONlBJTmFXSDhQL09sOTBO?=
 =?utf-8?B?b2xPZWZBVGZBQlBTRW1ScGdRNU04dUxSY3VoTmJCWDYvcmdYdjYzOTQwa0Mz?=
 =?utf-8?B?Nm5zbGNJdG10MUxnRnJybE9oanNaYlUyMDF2cVFESXg0U0orUDRnQlQyZGNB?=
 =?utf-8?B?dTA2RmFFQ0wzTmNzMG9YYVlxWnlTZjBVRVhYbnhuQXY3TS9ySUpGMThncFFF?=
 =?utf-8?B?RTNnRmVnbEV5RHFRcTVPcG40NllYOUhjMU5zWWRISnJBVTlTOE5IZlZ3MXYr?=
 =?utf-8?B?K1E3UlRIQXJYNm5nQjZOUVREVy9NOTBYSnNkcmVnaUpoaE5HTTNWbUxaY1ZJ?=
 =?utf-8?B?ZzFUSllLR2ZFaFJHb3ZVVytEenZlSkVNQ0ZiY3JMN3ZjRWtQcmVCNEY4UG11?=
 =?utf-8?B?QnhhYjV1NjQ0YXVzUlBNVXh1SXA3RzdVVHF1Z25BbU1HbldFMDQrcXZMSmNP?=
 =?utf-8?B?NHdGaGNiUXRMMjU4UUt3ekNsOGYyYlk2dXFNQ2xtWTFudFR5emx4TjNvM0cw?=
 =?utf-8?B?V2RyZjlnZ3E5dHM3VHhjdktmNGVSV0IycHVTUUk1cTZwNnpBbXRrMmluVE9U?=
 =?utf-8?B?b0d3djVZditPajhNUWhiZnhkc0JwTkhRVmlLYlVuSWt5OWhxcVp2Mjh2YnI4?=
 =?utf-8?B?YXhJaHhudWU3R3QvWk9GZkl3R0pKVWJjbFBGemFXVGNOR0t6dHdXSWdIQTJW?=
 =?utf-8?B?NUdJMGVUc2MrOUtnOGZrdW12SENFTGlOMVhhZStDL0h4bXM3Y2NHQkpHbDN2?=
 =?utf-8?B?eDZQYjU4UWovMEMrY0ZzVWJ1dFZTVzJwcENxeTlPcjVRQkdYZlRaSXRWR2NK?=
 =?utf-8?B?elkySzFRZnU2SFN5NW5ZYUxaVWFKNWtuRXRHMVJqQzhXclpPNnZnbHdNRGc2?=
 =?utf-8?B?K0w1M0lsRzVqSVdYdjhLODdFbmFsVVdxZjM5VTdyRjdubHp1Yk4vVzVEVUIy?=
 =?utf-8?B?Tjh1N3M1RUFDY3Y2OGNuMUVoVUg1SENzTTgrN1IwbjltbXFNSG9XVVBaZWR0?=
 =?utf-8?B?Mzl1MGVub0QxZGpkSmVwN2huZnpxRnRINkVIeC9GV0t6WHNLc1ROcWFnc21j?=
 =?utf-8?B?NzRyL1pxTXNrSWhDWkhuc1V6NWhORHMzSDlhZTN5ZXJLeFh3ZHNaUzZBbXBB?=
 =?utf-8?Q?Jh2X/G15cMWTlOTPXRcdXag4n1nw40sqk5TYlZX6lDZy/1?=
X-Microsoft-Antispam-Message-Info: K4Eou/f9ksAtXELEjcAhedZU0rT8TMKbkn33SEsFkGBN0hneTPVI8QvBK9vfhqni95ZzPNLaqXKnC8g8F87aTEl1iSKXolPiN5ORr8S5PK/CzD0QmnAoGxfSIrg5rZPIl4aYwKZ06o14Vp03F37TnHjcSGw4hAPJ0D1duuadEwqUeIY8qJ9eEd/UNYms/yOp
X-Microsoft-Exchange-Diagnostics: 1;BN3PR03MB2273;6:79d5ptc68f9Lck89g86regJ7tlfrBzol5hUN/o6xdjgEVaRqnuhbHH//UTUKhA/8IJSSnjDEmLAoKr4B9aXgIK9wKxlH5hers1Q6GLxWvzBXNKchEFKsuB79eL5KKLKr4x4cVD5miiPmcRhFdpgLjW5L0vWYnFyWFFjeMtjpV/tJHghgh/z3l5rwKAzXjPDG4gtBcCFpHsz6W45PEetpV33E6Y0l8NT6FVvAGQOxSM5jpwtC7sWI+FiyJeye8mcWLUguC0Yhz/lYe7KUpdGzLcs03rxPvlM8yxKVilflMN2BXtsoN18phH8wUvd1Nmc3Bc4YJTH5GsqWBMdqPSDBqWZRVHkquEL5RXLQq2pbblc=;5:0uXknmmThbrTEp2tqMBAanXRBgLMVY8y+BmaqkV2Jgyx+BNLp+ZmYvrawyZaWcd8CX+ttnr3ix78uSqxlVGvdUZPgdFO1BPPvR8rAb0KcZ0nIQPNNHFDn/X//FLcEm118pr2b8ZKLr+t05Z6gPNf9S97rt9MTMMKUNN6bgW30IE=;24:P3r68Y9K84mQLThZYO74o4WZaMMZkIxj86Rf4QNNEzdEBe7Yyv3VbJGPvHkQMJqhhBomNJf/BNiwZxEajzcL24EvOPu6fwxEs9RUFNShRhw=;7:zaeLZbdtNFvqq3AFj33u9CLn+AeIb1IQSbMjOJsAnicvvhiheOvG12z416wBsRaEhmdStDBVT5wlqYLlXZN3U+birvgc6PmmtNBTtIvdcbyjP6R14dKg4k115Dy4iWiNBNP28HgUe0deswYOfPePgnIDcOF1L3eztaqVg65jmSYDj8rvUII8dZX/fumFrvNcBhK3ztXMY1TQ8m/N/Rdw2m6cJh8EJzCazfxfY96EFzIhfaYwuAako0hUqB8NwgJh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2018 19:25:38.0791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7af20d-d780-4d60-285a-08d584613571
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2273
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am using a toolchain with a broken/old version of perl which doesn't
include integer.pm and I noticed it triggers occasional build failures
on arch/arm64/crypto/sha512-core.S_shipped. Workarounds are easy, but
if the purpose of the .S_shipped is to avoid the need to have all
dependencies on the build machine then something went wrong?

This was introduced by commit 7918ecef073f ("crypto: arm64/sha2 -
integrate OpenSSL implementations of SHA256/SHA512"). The makefile
rules are not terribly complicated:

quiet_cmd_perlasm = PERLASM $@
      cmd_perlasm = $(PERL) $(<) void $(@)

$(src)/sha512-core.S_shipped: $(src)/sha512-armv8.pl
	$(call cmd,perlasm)

If a decision to rerun the rule is made based on their relative
timestamps but both .S_shipped and sha512-armv8.pl are included in git
then won't the result be essentially random, depending on file checkout
order?

I see random success/failure by just running something like the
following multiple times:
	rm -rf arch/arm64/crypto
	git co -f arch/arm64/crypto
	make -- arch/arm64/crypto/

A reasonable fix might be to simply drop .S_shipped and require a
functional recent version of perl. Then if it fails it will fail
reliably.

--
Regards,
Leonard
