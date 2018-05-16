Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4134569-1526459156-2-5540386876364626054
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526459156; b=JV8ouUVpUTUtrw+U4ntb74saTHiY+f9o7i2aFQCarRCaaIqGR2
    p0gA60L3uSOjIDulLI4TiXx2BnBY7RR8xdLRSWymHX4UWDjmoIfFQq8AxStkQiXF
    MKKm/V4m5Ed5su5aBxpegy1nP22nocjaTMwjssKR0P9nQ7m4MfznpetV9FJBXIlV
    y65eXsOwpWyTAC6EtHuluqCvdqBToL/Z9qvy8VSdO545gsHrhvYH41DmMYnAqcZ/
    xty1kr/gi2XHTldFQtsXpBv+0MjgKcz54yLqvIW3RzLpDxaW2vYwALm1C7XQLU7y
    LeQbqOSedJHltzvKPiK83xaeGM19PRIDSIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526459156; bh=C+Wn1O6kyibrgpSqxupTo+4bjixWol
    Y9GRjXPa82e8I=; b=HDAkPhr325F08xLlCD+2xXfCSmGzxvDv/AgzfNDN7yr98c
    LcAak9ww9EArtMEfjbSHh4tfwbKzcPw/vpsVS4Oi5NhHgqScVm9nB7QjdOU3Q0Nj
    tpuUQnaFodsujVeuDBCwPsvuaeH0s93lnZtaNeG5f/S05TkaBGAncTPVjO6Qq2Hu
    ep8mYWVqqpL15VK/bJ+hcKfbGWJA95iFJDaGDkGuR+rU0HeVUxMzvZYx7fv61YNO
    25OA8dNutRP42ZKTec1qYJ/U1Cx049VCtKRZ54uDQViOA8T/AfjR22TwC70XqLWY
    YgPtSskPRoE2WzdC1f3M1tbZteJ15VLg0SbS56eg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=caviumnetworks.onmicrosoft.com
    header.i=@caviumnetworks.onmicrosoft.com header.b=HiZpmmRr x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=selector1-cavium-com;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=caviumnetworks.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=caviumnetworks.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=caviumnetworks.onmicrosoft.com
      header.i=@caviumnetworks.onmicrosoft.com header.b=HiZpmmRr x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=selector1-cavium-com;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=caviumnetworks.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=caviumnetworks.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM4rjQz6wWyoaj9Uv8LbaDfa0c3TTD/sH9j3ObadaZ+mAASvwHt3qqQbTLoi3l2xrfMesr9hv+OuLONUE9mm4svVIZt5P0RoxkBv69YFkv4e8uuwRK+e
    69R2aDUD3u2anJgh8SxKwOhAwJ6G4wLA6MG+JsPTbxXYsh7IPjcXHiQg5tC6CvGjyInqNoMe+sloISN/pBrRhUW17B0Fh3udxnPpbW8tz/yByAzwJOi8ZAkF
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=sFUR1tI3dlkA:10 a=P23N9hKgfBoA:10 a=156W7YIXQOAA:10 a=VUJBJC2UJ8kA:10
    a=ifRc6kEuNzAA:10 a=enOvQawGAAAA:8 a=VwQbUJbxAAAA:8 a=TcWA1hjmsSw6wTIxR-sA:9
    a=x8gzFH9gYPwA:10 a=OuzhcWw_GC9nAYdNdRwA:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeEPIXM (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 04:23:12 -0400
Received: from mail-co1nam03on0040.outbound.protection.outlook.com ([104.47.40.40]:30432
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752657AbeEPIXH (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 May 2018 04:23:07 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
From: Yury Norov <ynorov@caviumnetworks.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org
Cc: Yury Norov <ynorov@caviumnetworks.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Alexander Graf <agraf@suse.de>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andreas Schwab <schwab@suse.de>,
        Andrew Pinski <pinskia@gmail.com>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Morse <james.morse@arm.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Lin Yongting <linyongting@huawei.com>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Yury Norov <ynorov@caviumnetworks.comk>
Subject: [PATCH 20/24] arm64: ilp32: introduce ilp32-specific sigframe and ucontext
Date: Wed, 16 May 2018 11:19:05 +0300
Message-Id: <20180516081910.10067-21-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [176.59.36.13]
X-ClientProxiedBy: VI1PR08CA0115.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::17) To SN6PR07MB4382.namprd07.prod.outlook.com
 (2603:10b6:805:58::13)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4382;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4382;3:8DjKnixG5wrCIyuizCsGAgsTpmtZathCmyJ6TA+0yXVJMdi4bPDyTdirZbDOK7rYkZJ3YXXrMX5h/2s3tf7jIquEWrcKJSaYAjTs1iswMZb3ttwZXY8Uj7KK8CaEG+P3UTRw/H3ISRC+t46IG7RrFtv3BAW+haZX8trvbmyeTby2XQEnpPsIVVcZGsPQ5064K6Zmqm6XOJzafJ6dqUKAUKKqTFnhXOj77cwPpMZ5Kk3yx1ymmVkMzl6HZI/ZvWPq;25:j0ebvTp4rwfDAaFbw6G4cJ+xK4A+YQFO+qtTrmESEzaiWilLqdX0VgINyCWx2KIloNFIHzgxt6wh0G/kO0qrHH/jBh87yN/1XFEKrukt3F371kkG73tjauMB3E0Q+JVfylrGVr55XsDW67zGh5Aiwksfi5Emojbn+UmWtIF7SQ2TaPp8HjZUnKlf2W8cu9WOovYRgkZgyapK1I1t8JmPtjwzDl6VgZebAsttb75pRWlGYcPefwO4Oo04OufoDYsyrZtNEhFJTHNQiFTYOTv3U9Epo2E+OwlqtXsLgZdovFJ1fQf5WMYT2byVOkx53ewqTbIW15T+dpS0Rcixc5cAug==;31:C0JXCFhO+34v6bg9CVZNlx5najheRiJogpMEzt0kbjD7jKFKRpsyh72T2XUxE01TENuuO7YbUnWL4KoX0/HPogO9A81nnoaU2HUB1H6edHPu29oncla37ZzZ42M17y5L3r3zaqR0KcCOgHxEbxERH2sU+wsOSMmK4vBxDyGRwJay7BvEsudr5qyUYA0Xn+9iKfYMVWuptF4ldSIvm9zp/YYBNC1IN83WtTypF8xynMo=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4382:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4382;20:exVsVIeCvHVAxqKZYMIkUs3jbVk4JsqVYPwUfGvRMGimz4D4Nvx89usGhr26Cf3TnqhrUbw9SBm0HsCCAnYOu5JF+FnptR544BADVNO575oAH9C1UX982XeRLSDy8hINy1dU+/OR07RlFBJaDgwxKYUtSFOw2kKmI8CGXmF+5xMEItAYYWRpH9BJHqL5NQPk2Ismsx5haY4/6ClxW95u30iSjjELYuPDWX2H/MwBsvzzgUs96folzaigoZiKaw4nyLuHTYyvrGLBH077QmvKbdoLo4kn0aZh/oSjPvUjhmjWW2cw1SWLECDWUD0huNWqN+sSO0NVl9E8L6WH5mIUGPbEecEmludBuMoTa7vbC1nbNF2NsP8TcN9VT48w1eQtwYUOXptRyY+Lv/zbGylKvYJfD1/bo7I/ofzu4Z0+n5cBBHya78xZ54+S2Eyvhx4/pYUubrTGDjW1BZ/buTsMveBNUx6qf359AJOr29oDN0c4yadLWvoYhvChIQrzd54IcaQrIICqm5JUy9QNTBjmtSPFKsT3xmFus7cNVMr63g8rhzm7skm1bIWI+qK8ZOQtAY9pnKAmOyGuP2EnhBdye7asYb9BNu1LROU35SxULTw=;4:3c/G43IfI9oybLBZDmw9UzuraAC4sowFyVvFdRbuqKndr/1j/QDme178P2rTGZaN9w5eP4iYFyQByCRn+3UD1ZHjqX2AQgYhk7u3ahKvogYzoUGntojpDWvj6cM1PK2wpKPYyJyKVqzwoLaRgApvfx2yHP/CTU8CcgmSEHq1D9rjMph/xQ7Zdsb3kFppViLLbX2ucpWbWzUtvIUkC7l6IDjYXb8pQQRaM+CAcCWNffoME1vI7MPIqxU5PR/Cf4P/+QlLuOjQ1z4Qy3R0tpGpNw==
X-Microsoft-Antispam-PRVS: <SN6PR07MB438247BA7A3A3913A97F6B7EE3920@SN6PR07MB4382.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN6PR07MB4382;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4382;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(376002)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(25786009)(8676002)(575784001)(478600001)(16586007)(81156014)(81166006)(386003)(59450400001)(110136005)(8936002)(54906003)(6486002)(50226002)(316002)(3846002)(72206003)(6116002)(36756003)(2906002)(1076002)(76176011)(186003)(16526019)(7736002)(106356001)(105586002)(53936002)(47776003)(66066001)(305945005)(7416002)(7406005)(4326008)(39060400002)(68736007)(5660300001)(76506005)(26005)(42882007)(446003)(51416003)(2616005)(476003)(11346002)(48376002)(956004)(52116002)(486006)(6496006)(50466002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4382;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4382;23:UNhE/KRFYRgpIXk0jMwZyYvOKh91ygp96Ekgx3CWw?=
 =?us-ascii?Q?OT380RM3V2tivFkOhmV8AlVrsfLQbxc7e2IBNGbPUg48qxgIDZyryNo3HYWN?=
 =?us-ascii?Q?AXwFfEtT0nLoBWT4PawAlBubWTraF4B/+o2J+Wrhkni5WIBveKiqvP4TZkaI?=
 =?us-ascii?Q?1iOQRinnXxIZU65q6qH+mPkR4xxK8RfDBBm3pdM0BeCqo5yWHxQ8YlO3iBrd?=
 =?us-ascii?Q?uddgLbse8WvLEprKXG6nRG0fqMNaYmS7NJhqqUg/24CayrJ2I6wj0v1Vol75?=
 =?us-ascii?Q?K0zqzxlnWHovH9VLGJ0can/pa+d5G4YzSQ031WJ8RuuRun2F5kCMb4a4YW/N?=
 =?us-ascii?Q?JLCtADoaoSgWp1z9Ow5WFlzH1eDRXKx//yi0ExrTGGJ1kq191vhNgXF6TkjL?=
 =?us-ascii?Q?y5rnQuWuZXIVKC8DIiiGBkLOk/vAhFWcPqt0yxq2GZN9rv5UMA80VeROu5hO?=
 =?us-ascii?Q?RMNIjGuMCj+buxIYmVUtDRO5DR3lxczGtxpKXFU7ehGF/nlO4cRf45t9frbR?=
 =?us-ascii?Q?2hgG0zNyabFonpTXWKG330t2Nv3edYaLgCfXK1pP1a6Gc665f2Ur9m5n5P9w?=
 =?us-ascii?Q?0T22gHxVkAEVKZiubXL5vnw6jAv2YHUAjPve5gm9pfbGBZ5RSm2PrRDEdMMv?=
 =?us-ascii?Q?agVnQ79hG40XEGhWtTTppY1K4g9y2B4IFGgNzKCRzwMAGFU7VYaXFJNyeUzj?=
 =?us-ascii?Q?UO6ndFMsTH4Fndvgp4jX2dY3mn6UVR7rVWe/QBgJD5SdyGLceWgrN/cboG94?=
 =?us-ascii?Q?By89cERP4kCo43Mqd8RrGyom4ddu2Mc0vvXbDBnO+inXPiZ4iD0CGfKvs88q?=
 =?us-ascii?Q?FJOsv4mpcu13T/4lHZBZm5gDQAdFJy+r9H6Rt2tKNB4ehC/CC5YQdTAtXIbx?=
 =?us-ascii?Q?6on+Xo2PcSyyVhImdVHrLhEZ7UC+UavQsesQQKy94/crvJSEOdzsa0WkvKMQ?=
 =?us-ascii?Q?ZFz6v3cy5iWboqYyTO4VRnitiMISEMErzW+c2CONEUUiNcUvhl/m2QfXfx8k?=
 =?us-ascii?Q?Cx17090R6W+cDYAWHd8rr1BlcHTyCNw+LQFcxFY0dbTTUy293M8uTdg5+asM?=
 =?us-ascii?Q?Pszq4aCNZ7xcZipZ5Zqlyz3PysPCbN+U57BXckTPoIpSIMkJbdQzIBUm34Ac?=
 =?us-ascii?Q?f+eSJRESA7N2dl7B5r09GjGETOVHxMT7Fx8zCzE4CAiV0phWuDVuJSq/2Q3a?=
 =?us-ascii?Q?4Z5LvA7gWbEtW0CkbBrWSvmuxeeFjtQ9tpg7jxoE8iPzlfzk+VSTvBIybqOj?=
 =?us-ascii?Q?VgANWPfo0sd3wJgoPlWexfFHy0ooeMMxwPHMBt7OJLoa5/BDD/2v/mqn13rg?=
 =?us-ascii?Q?+vScOO1C89Bsg5cBr03P+169ue9qg6BDuBIcPOnc50Cj1B+7AShH1MUMEnvY?=
 =?us-ascii?Q?diqDA=3D=3D?=
X-Microsoft-Antispam-Message-Info: mQ+zZex1StS0mXiLIrJKZ8qmQAR6DtkcpHCOtdckJmHHpWdbSe0MOVk9xPsMJn2ptOIymBEybV8dKpAt9jRrw1NkXmnf8bE90c+OJigS3VjYUWnczB5t0XY16nJh22hSWaQouv0glyliZk1HMAyZJ6EGochvtbqLcFV7iTzyjwdDzH8PmoKbl25Nj3HVOlI9
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4382;6:Xr5po3u4Q2hmgrzis1T51D9hM/7Ok95qo7+gvp15FFPqdOGyzAsEvqgZfNON1RDxK49oXbidhdtb/vbEVePYe0H9h9DkcAbvcgmD604pWCp2y3xyBJ6+EaZtayACKWg/czCVs1i2kbn4aDcQB2CzlOy+iR9dJaMwUPu3VBGtGVVbZOZomS/nf2aeqEfe1UjVv78O8rghV1aVLrQklkpstWpL2Cesi1TtRMoytC4gKeB2zuKVcsVTeJQG17VvDQZvyXQtlVcOsA28V/OKX7t1lmGek+Rtzd04RSmVJhlxHeoag26866jH3FmZmjobGXZeYczYRVoIIreU9vN7uvPcsBqcx8iKLTG+o847mmFAGv7kDStz7f/lGyoEBlfsBXnEbZwCY607C83SzuQw6d9OR2OsmUB2osmuygYD+aFqXwPmSDo6OGBRRlSPUHbl/WBp1AmdFWPGUdKOnaKE4qrAig==;5:zVzpajV+KgpgdS/VowQox5KXwhQ7htekgmWT783vEmxon8PB9fpNNN0IWm+q9CzRSYd7cZ58UYUZ7yl5YexE2nbV0mH9Tb79b6EIMY8W/h1Ap/38qMF0oq+3C4LgOwDLwAZ1zWD+fHtOlxgwapnOjvG11tCGai4Xs6cVsxvwKLQ=;24:V48hpagvVmODUbhhcZBE/22ZjwFchLE9CHFtCEf8g32ax5Kui788SxdfTRLsHD3q7u+kK0YMOmknRUWVTWRfY37ybcI1SGRpKuOFZsi5Bus=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4382;7:a/GSDyPBATxLU7VffoWBvTsO1jFj0VCap9Asqi6Ld3opERd2zo1AkchOJoML4E3DRcUp7+RxssfZNhoYOollDjOwkt8HGATEFGSXwDxMocWEy7R11wMbNL2NqXftmMgJoeFhnyEiyRS9lnxVbMwQL3tq1RmiqA0b4f5QJ3PIonmQx9RQqTnFvivvgu2UuOUfMeGChRLDO9TFS/oEZi1EufFSBxma8IP+zzGyelO6qem66McmFfOenDUwSkaOETWt
X-MS-Office365-Filtering-Correlation-Id: 83ffe429-2e4c-4f39-62a3-08d5bb063e14
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 08:23:02.1829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ffe429-2e4c-4f39-62a3-08d5bb063e14
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4382
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Yury Norov <ynorov@caviumnetworks.comk>

ILP32 uses AARCH32 compat structures and syscall handlers for signals. But
ILP32 rt_sigframe and ucontext structures differ from both LP64 and AARCH32.
>From software point of view ILP32 is typical 32-bit compat ABI, and from
hardware point of view, it's just like LP64.

struct rt_sigframe defined in this patch in
arch/arm64/kernel/signal_ilp32.c redefines one in
arch/arm64/kernel/signal.c. And functions located in
arch/arm64/include/signal_common.h pick up new structure to generate the
code suitable for ILP32.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/include/asm/signal_ilp32.h | 23 ++++++++++
 arch/arm64/kernel/Makefile            |  3 +-
 arch/arm64/kernel/entry_ilp32.S       | 12 +++++
 arch/arm64/kernel/signal_ilp32.c      | 65 +++++++++++++++++++++++++++
 4 files changed, 102 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/signal_ilp32.h
 create mode 100644 arch/arm64/kernel/entry_ilp32.S
 create mode 100644 arch/arm64/kernel/signal_ilp32.c

diff --git a/arch/arm64/include/asm/signal_ilp32.h b/arch/arm64/include/asm/signal_ilp32.h
new file mode 100644
index 000000000000..7ee97c133605
--- /dev/null
+++ b/arch/arm64/include/asm/signal_ilp32.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __ASM_SIGNAL_ILP32_H
+#define __ASM_SIGNAL_ILP32_H
+
+#ifdef CONFIG_ARM64_ILP32
+
+#include <linux/compat.h>
+
+int ilp32_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
+			  struct pt_regs *regs);
+
+#else
+
+static inline int ilp32_setup_rt_frame(int usig, struct ksignal *ksig,
+					sigset_t *set, struct pt_regs *regs)
+{
+	return -ENOSYS;
+}
+
+#endif /* CONFIG_ARM64_ILP32 */
+
+#endif /* __ASM_SIGNAL_ILP32_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 9e127c47a25c..27ddf5369f89 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -28,7 +28,8 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 
 arm64-obj-$(CONFIG_AARCH32_EL0)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o entry32.o binfmt_elf32.o
-arm64-obj-$(CONFIG_ARM64_ILP32)		+= binfmt_ilp32.o sys_ilp32.o
+arm64-obj-$(CONFIG_ARM64_ILP32)		+= binfmt_ilp32.o sys_ilp32.o 		\
+					   signal_ilp32.o entry_ilp32.o
 arm64-obj-$(CONFIG_COMPAT)		+= entry32_common.o signal32_common.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
diff --git a/arch/arm64/kernel/entry_ilp32.S b/arch/arm64/kernel/entry_ilp32.S
new file mode 100644
index 000000000000..562d5d0a7d82
--- /dev/null
+++ b/arch/arm64/kernel/entry_ilp32.S
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+/*
+ * ILP32 system call wrappers
+ */
+
+#include <linux/linkage.h>
+
+ENTRY(ilp32_sys_rt_sigreturn_wrapper)
+	mov	x0, sp
+	b	ilp32_sys_rt_sigreturn
+ENDPROC(ilp32_sys_rt_sigreturn_wrapper)
diff --git a/arch/arm64/kernel/signal_ilp32.c b/arch/arm64/kernel/signal_ilp32.c
new file mode 100644
index 000000000000..f4bcb7332010
--- /dev/null
+++ b/arch/arm64/kernel/signal_ilp32.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Copyright (C) 1995-2009 Russell King
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2018 Cavium Networks.
+ * Yury Norov <ynorov@caviumnetworks.com>
+ */
+
+#include <linux/compat.h>
+#include <linux/signal.h>
+#include <linux/syscalls.h>
+
+#include <asm/fpsimd.h>
+#include <asm/unistd.h>
+#include <asm/ucontext.h>
+#include <asm/vdso.h>
+
+#include <asm/signal_ilp32.h>
+#include <asm/signal32_common.h>
+
+#define get_sigset(s, m) get_sigset_t(s, m)
+#define put_sigset(s, m) put_sigset_t(m, s)
+
+#define restore_altstack(stack) compat_restore_altstack(stack)
+#define __save_altstack(stack, sp) __compat_save_altstack(stack, sp)
+#define copy_siginfo_to_user(frame_info, ksig_info) \
+		copy_siginfo_to_user32(frame_info, ksig_info)
+
+#define setup_return(regs, ka, user_layout, usig)			\
+{									\
+	__setup_return(regs, ka, user_layout, usig);			\
+	regs->regs[30] =						\
+		(unsigned long)VDSO_SYMBOL(current->mm->context.vdso,	\
+						    sigtramp_ilp32);	\
+}
+
+struct ilp32_ucontext {
+	u32		uc_flags;
+	u32		uc_link;
+	compat_stack_t	uc_stack;
+	compat_sigset_t	uc_sigmask;
+	/* glibc uses a 1024-bit sigset_t */
+	__u8		__unused[1024 / 8 - sizeof(compat_sigset_t)];
+	/* last for future expansion */
+	struct sigcontext uc_mcontext;
+};
+
+struct rt_sigframe {
+	struct compat_siginfo info;
+	struct ilp32_ucontext uc;
+};
+
+#include <asm/signal_common.h>
+
+asmlinkage long ilp32_sys_rt_sigreturn(struct pt_regs *regs)
+{
+	return __sys_rt_sigreturn(regs);
+}
+
+int ilp32_setup_rt_frame(int usig, struct ksignal *ksig,
+			  sigset_t *set, struct pt_regs *regs)
+{
+	return __setup_rt_frame(usig, ksig, set, regs);
+}
-- 
2.17.0

