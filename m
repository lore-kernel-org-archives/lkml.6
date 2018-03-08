Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeCHOMN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 09:12:13 -0500
Received: from mail-co1nam03on0046.outbound.protection.outlook.com ([104.47.40.46]:19397
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966414AbeCHOLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 09:11:35 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
Message-ID: <1520518288.18140.14.camel@nxp.com>
Subject: Re: arm crypto .S_shipped files sometimes get rebuilt randomly
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Thu, 8 Mar 2018 16:11:28 +0200
In-Reply-To: <CAKv+Gu9bWQyUwxgS1Vvp8U__Wg-4Tby2vKvOozsp9RA41Wo6SQ@mail.gmail.com>
References: <1520450729.13685.19.camel@nxp.com>
         <CAK7LNARDPOaLyvcijXe5VX3hJhxzS-R5hdbk310bRUuZwQFMmw@mail.gmail.com>
         <CAKv+Gu9bWQyUwxgS1Vvp8U__Wg-4Tby2vKvOozsp9RA41Wo6SQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131649918935522395;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(346002)(396003)(376002)(2980300002)(1109001)(1110001)(339900001)(377424004)(199004)(189003)(85426001)(356003)(2950100002)(50226002)(106466001)(53546011)(59450400001)(76176011)(229853002)(26826003)(498600001)(105606002)(2906002)(8936002)(8676002)(81166006)(305945005)(104016004)(2870700001)(5660300001)(86362001)(81156014)(4326008)(36756003)(68736007)(6246003)(5820100001)(316002)(956003)(97736004)(47776003)(23676004)(110136005)(54906003)(103116003)(53936002)(336012)(26005)(50466002)(99106002)(142923001)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3219;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD010;1:MlJME6sVbsC8YPgx0AHYkjy4dse/gprshE004btRIN+ktJF7ddveHkc0i0UFFcwRtAQaHwHtZ6sGE1zl5KgRXpGHkcQggjr0bSoPr2x3oIUj8oz8FmbTLYCKOVhPlcFx
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 357d2e80-0e09-4ad4-fafa-08d584fe7f50
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BN6PR03MB3219;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3219;3:HdyhR00CA3obyfuaeSQh6Y05Kt04rFKizqlFJrQq98TZ9GMotwOev3X6VN20DXYnRtqlY8BGqSTv2gUnOUVpdplCAI/hlKMM11yZMwRdQ/0BtH8XmX5XZym7aiANGPaGFEQ5k+Bx6PlvHMY9IWmrRgQIZh2kXabIIiqQSTX/bVyR12AiIc5+KOzPt5CXyWDGLNFwAgdc4aF+e1LcZ2BBAJbmqgILhsKV10a0PxSTgP6jGAw/XXtwTR0z98Gqp7zHcAEezm+EmBitrT3ams8Lmw/T0g9yWR4VJV8XEBpEOhXzeEVhMcfg1IampVrTaBm3bc2WyX3TSq40uRdY9omIskYeCt1t+TPSmDIgC6GE0dc=;25:DUI9ZPv2lZgInkhxbK5PhGI5bYJCKNxLTTkFc/lBzj1YzYGZBuCL5u6gFO0WL1YsU21wnysMcbBRuvkuI4+JgHLmkr1W3CzSFzW7OZDe/FzwP4CdMzfplwx4aaZXQlQ2qabqQ6RqIvFYBevF8NWTyylEVhQ75i73FRuQqQUXFFwYo23dXTtaA0L0PkMq1hJJF8oYwZ41Rzgaxjw4y9NVhI7oFqY5oFiVSr4BRrbWhtA8x7MgpPbvbs8Rowz/aVCgsumeR45+GJAbPQNIJjWUTNJy0l3wih4KhWbTzaFGRvy2CiCdxFsPAZf8qmjZzGcWVhKTB9q1K86HPm+82L1XMQ==
X-MS-TrafficTypeDiagnostic: BN6PR03MB3219:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3219;31:I8xfVplSa1+3KMIWrAm3xzvsS3KkCBJLkFGisXvmg0qvhnIRMi08jS72ijm7Wc+NE8OuIBpMSx1E59UV8NG14X2sGSOs4NDi3WldYegNu9SA3DFsoUE28pPSRg0SoVUxQDnUth7GtCEkAn6WlelpZ92mBvukOFtIYYk1+Lu8NVvjzP1qwUgNSA1t71PHS7m9RoZt+puTxh7eA3xCsmPpuYUPIaVJHf/9RwVsn/gFhLM=;4:0/h9aJ0eURquHGCoij3875h3fUJFdvBJ3HxxOV5Gdb4mJHfZccqzeYzQc/pAJaXN4w0PT76clltxziN/Xc/gNIzRqGUAhHz9npSOLdB4BF9MSPAM0ZA+pa4H6iRg8/aU8droZR2EihTldB36/DsaVvvt5D6PeKQ1tYpjMYD7SFlJHnk6+DTWeJ79POHqnAGGceb/7STAtUzwOgIw2g3eOfrkxdCIv+G36ZSO8SbHfBxg6ALqUWd4xmZUSivI/a9ZPV0cQ4YOMYLqyuQDan9sIWidhrdZ1Yr/fF+K1iNMarmBysI1RnIesNNw3yIpIW6O
X-Microsoft-Antispam-PRVS: <BN6PR03MB3219BE8F36CE33806FF481B5EEDF0@BN6PR03MB3219.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(6055026)(6096035)(20161123559100)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123565025)(20161123561025)(20161123556025)(20161123563025)(201708071742011);SRVR:BN6PR03MB3219;BCL:0;PCL:0;RULEID:(400006);SRVR:BN6PR03MB3219;
X-Forefront-PRVS: 060503E79B
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjAzTUIzMjE5OzIzOnQ4OFdYeE5XdDN2MnFxeDB6S1FOQUVvMUtD?=
 =?utf-8?B?dFJJV0pqL29STzJaMWN0SHRxeEt5RzF6RjNFU1o5QnBEc0pXd1d5NVFLaitv?=
 =?utf-8?B?UzFwRXVTNXhNQU1ZSU13UGN3WnMvNmgyK0VJQ2xiWHgvMWRwUlo4NVJ3WGZn?=
 =?utf-8?B?Tm1KbWdSUHkrL1FuS3NONGJjVFZTNjYyUE9ZOW5BMXlJQXVzcUwvVUFuK1p3?=
 =?utf-8?B?Ynh4QkRRZjZURE5KcVFPekFEcFdYbit4Qk1RbGFEc2dZNGo5eVM1dzdkdGdQ?=
 =?utf-8?B?KzcvRHczMnNpWnlzWGJDMExBNko3ckJFUllLTWIzWklJT3ZLNXFFYkRsZWhG?=
 =?utf-8?B?b2IyRnRLeG82bTZQeGRzWmJPOTVjbnhuSHF4SC9MeXVwWk9pR3FOeWpyWFdv?=
 =?utf-8?B?Z0MwTkJPWGYrSWo5MVlQQ25vNXljYXkzWkJCQzZaU2J6K1hHQTVjcVpYK2hH?=
 =?utf-8?B?UGpzeER6VFRoVnVGQnE3ek1BSWhNQkFCWGpHcm1nc0NGVTFaeVNvQ2hhdkhY?=
 =?utf-8?B?a0gwdGZSQjJzUzM4UHU1Ly9PbWhWV21rdnNSYWpQRGI0aDVPNkRNdFRYU21r?=
 =?utf-8?B?aFNkNkNXaklmbTlaSjIrRDdXbFBzbjFZdUlVTGgxSG9nNGxSdmFOaVFsZTE3?=
 =?utf-8?B?Zk5Zc21lM0prNW1xMStEOU8xRWRhOGIxVGRXSnlkQVk0MC8wczNGQ2lZSUFn?=
 =?utf-8?B?d2JDemxsNmZ3MFBaelg2cFdVRmxHc0Q2NDFlVVVxKzVXQkd6UnpsUGJ3cFBO?=
 =?utf-8?B?NFpkdnJZS2E4aS9UYm43ODBhZFhhcHBNVzVBWGpjQkdPRk1yeHA3Vjl5Y1Yy?=
 =?utf-8?B?MmhqQWpXVHlRSE5HZXBpUTVoSDZCZUhnaW1SaWh4NG1QYk9nZ1pYL2YvWWc2?=
 =?utf-8?B?ZHhHWCt6Y0FCeUExbVRRMlMxMzdaTGdqUVpMNzlGZjlXZjRnb2Y3WW8rTC9U?=
 =?utf-8?B?Y01ZSnpUM1ZYeC9BM25PR3BaQUZNNmJweEtxKzhRQkpqQVJ4TEVhaG5WUWVa?=
 =?utf-8?B?QXptQktrbStQR3BQZzM1THlZVm9uNFkxYWZ2WXp3ekhiakhUcHBaVENLVFpn?=
 =?utf-8?B?amlmK0xaTFR6c3kvTVlGY2lCRHRLNC92VEkwU01zYVRpdjlCTy9nL3g1TFhQ?=
 =?utf-8?B?VFdQNkViYVNRb1dPYzluaTNXQjJSeEIyV04ybGtwemoxdWJWNkpmMkFjN1VJ?=
 =?utf-8?B?M05CRVJLaXpHak5UVTVSZWd6NGl2NjJKeFU5VURic3p2VWVKNUFBbkMzVzVP?=
 =?utf-8?B?YjlDRnZ6N1NXa3lPcm9OMm1PeWVBaDJ1T3hid1JtelJxNUhpU1N3S1V5QWEy?=
 =?utf-8?B?dFUxRlViNjNzb0Q4TmxTVWFRQ1R3UGFaSW1wSTE0c1B1Q2NmT2k2RTg4SldT?=
 =?utf-8?B?YkJpNllORjdjZmZ3SzA0Y3ZhY3ZLMlBiUHdJNlFEYmlqZ1VTTUR4VzJ6V3ly?=
 =?utf-8?B?QTZISGZTd3FEdlB0MW1oYWNqUTJ3V3laajFsYTBJSDA1YU5BUEx2L05XNHRt?=
 =?utf-8?B?RVVmblR2VW8vb0UrNUdMTUZZdlNoR1VHSmhKZkYwVmxRYjVreDZ5N3FyWmxp?=
 =?utf-8?B?MWQrMEswZ0RVRjZmeU5RK3k1OHlidnNibjV1MmJPQjdET1U3N0taYUJQbnY1?=
 =?utf-8?B?cWdqMVo3bGJ4K0JSaFhQL05OeDZ4NU5jVVAyOXJ2d25JTWp2clNmY255OXIv?=
 =?utf-8?Q?s36Iv9j3awtD8PaSYLz8OKxXvWn3UJqbqa9bd0D?=
X-Microsoft-Antispam-Message-Info: ZLoAjGt65mMtJVhvSeK+SD03KRXd/laoaAYwemKUlzBVd4iNzQYZpwSrFWS1CNnsMpK791+tLG3BFhcEDz1J/tbTJ0vToY6sVpl3NM5Gnph6RWpstGwPVIH8SrwhHIynensYCLJrVivAOewvemGk2u6A20fygFrzKwANZdXuEVw9IfalS8ddIR/ci5R2YLDL
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB3219;6:Y6+OvOYmUK4nMoHSXrQ44FnH3PbVB2JlF13n1T0S0t2So76wRPoRkVQOVD0kuJVVr2bfDtKUohUx3U1N4zMg+KCxBI+a949MepxxUS3c8vFuXubzA5xIhR6fOGWm1e8EAN26W7VBjGmJFL5wh4PKtvn2hWxOdilPzknuWmzIhS3JR98UIXWY1gptvdPIGoM6zFOQICMYIjjVBONx4GMCuyR1VwxJbHkNmXoJJHmLzLux0ZnPTrxtG5c8IiHll5NsWiKWKaY7aqlskDCN8zB7iuQHa2EEW5JIGkn8veI68V5VKL16VQDie2ojLxG5iFdavHj2AvhDWnnZFYkNGzfBLP1nlg1k5VXmavOz130tSHA=;5:7NwIvb+XGc0NU4QsuMem6e2KNEOtciOFJq8AmcqeqkOrafLhSN8tDyTzADnVLUciQTUIfm2ASNNP89yQY6XPeexN9/WqZAhHDFr61vsgfW3j0kWCO/0tIMS+k8FtBMwxX/jImDxpoV3OuiqUUuObgrxGMKWPDdC3kTWlyrE8Xkg=;24:07fRZqh8x7n8KOLciOoUyOe34Y1PmqJTMmdpb96iGsfS4I0cQjlQSqErA3Ri+AP0hZmkV0cSPIHU+tH5QGehu0m8sb1hzu7ca/7z9ACAHVc=;7:K8RTa4zRYQvZY7NlWPCu5a5+DC/WAaKEwctNZNjA8T+Uns9laSJiloUpEv01dmNFD+08blCyFxFBzlSgWb8HkJmiSNb8Wn5X06/7GummG+ntp1XO0zn+W2S1hzyxTjoc2QgNSlZ42/ABl9I0TJtX+YAYR14gUCmR+bcT3X1CtRi6ChOvJv/bgd+Gfkg21Yl+dUv4nbomT1mQo3snb+JLPa1eZHQKc2vWbGAqpj4Ovh89Qr8ofF25GtvsrCumwZdl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2018 14:11:32.9750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 357d2e80-0e09-4ad4-fafa-08d584fe7f50
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3219
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-08 at 07:02 +0000, Ard Biesheuvel wrote:
> On 8 March 2018 at 05:00, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> > 2018-03-08 4:25 GMT+09:00 Leonard Crestez <leonard.crestez@nxp.com

> > > If a decision to rerun the rule is made based on their relative
> > > timestamps but both .S_shipped and sha512-armv8.pl are included in git
> > > then won't the result be essentially random, depending on file checkout
> > > order?

> I agree with your analysis, although  I never see these spurious
> rebuilds of these files.

It would happen at most once per checkout since after it happens the
timestamp on .S_shipped is updated. An extra line in make output is
very easy to miss.

> > We have two choices.
> > 
> > [1] If we intend to generate
> > sha{256,512}-core.S from the perl script during the build,
> > this should be:
> > 
> > [2] If we want to check-in _shipped files
> > and avoid running perl during the build,
> > we can surround unnecessary rules with if-conditional, like
> > 
> > Recently, Kconfig switched to [1].
> > So, flex and bison are required to build the kernel.

> I would prefer option [1], but only if it is already documented
> somewhere that Perl is a build time dependency.

This already seems to be the case, in Documentation/process/changes.rst

> You will need perl 5 and the following modules: ``Getopt::Long``,
> ``Getopt::Std``, ``File::Basename``, and ``File::Find`` to build the
> kernel.

Maybe "integer.pm" would need to be explicitly documented as a
dependency as well? I don't know anything about the perl ecosystem.

Building the kernel with make PERL=/bin/false seems to mostly work
though, it's used for stuff like docs and headers_check (which is not
enabled by default).

--
Regards,
Leonard
