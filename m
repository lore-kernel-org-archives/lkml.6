Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3144061-1526413249-5-10731676949490013501
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526413248; b=hmJ6KWBuV5NMLazGJ2ibdUyGI4y4BM2otbz2BT6lkzRKRXTTRS
    quso9H85LwGCtkbI4UlCi6sGIq/TShHsQ5LBruaNzPp4nw4FOrWM6/iNrYmGHQ8j
    ZGUoiH/h0cXMvx4fehah9jmj9VZ5G7PgehX/eDG6N47DvKq2ixyRTZUnPRno2Afc
    6ouL5+8WtEwYZnDNp01mGEWwQrWytJku4QtEjkiHSiNjBx0kUKZROmA8ulM8Wqtg
    xDhcw6qCyUvlbWOgnzD/cFCjTZ+KfJaqMxA4AHOkZzez1JffbDzs/AiH7NqZQykm
    DOj8Mh4FrLFhGXZirMhUM9FgvKvKHEkPRYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526413248; bh=lG0pg1rQzGuGWlVWJ9ohqWHuWq2RfQ
    AEwuauIAAEzj0=; b=Vpwu9VikNBHhjNyW2gwwAaJbmIZYK3yc8qGluwq9Wo5+sl
    WHoIE5qjqK8+FKkJPVfeM33zMyKhKqy4LknjLC8trQgOLAvLbqqQJhqOSqP6yId3
    6Hc6RwVzp/ArTFWtDf74LxkqwqPWqvsfSjucJvPhn96rm2V4goxpJEDeCLJQtIh4
    Cz/ik4fs4feq4ONXI2TOokHKqY0mZ7sERI0bZJ6KQiRuDbIF6SSdHVw7JudfPR5o
    xrFVTZE+6J3CkOyVirkuUo3Sd6anBl6r4N0xCSe1IBS0igWhnn/mWwIx3cNN5hSe
    A/SX2ESR82SK8Y078bh+SkxOiBFFk8Ss7MtflzOQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=caviumnetworks.onmicrosoft.com
    header.i=@caviumnetworks.onmicrosoft.com header.b=S8qi1IwB x-bits=1024
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=caviumnetworks.onmicrosoft.com
      header.i=@caviumnetworks.onmicrosoft.com header.b=S8qi1IwB x-bits=1024
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
X-CM-Envelope: MS4wfFPSzhIPKGUoyLkHMDAtG2ZJHnZRsPrLdA5MxpJ5ptHnrH/UelRed2z829BUFhLDcc98Q3lHh/mgyVnMgktCdmOjCD+TGFGvke6iwEAfNLgai8j5A2E2
    VO4oslKg0+m5R3ev6K6lhzqi+P8pC6oS8M4kBPaoRV6QZUnvBqqJab4OQbyXJmVmwfkpwWh/iac3MKpfhh45sh/dAPxxHELmxq9VBxrXOLzFIJgPWjpdgSbZ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=NMmGLDPa_bsA:10 a=mu3WYqzaZi4A:10 a=5vAqXYkm4IUA:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=ifRc6kEuNzAA:10 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8
    a=KSb9T-wMAAAA:8 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=dflTm1vMf2RLhjx32VcA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=cvBusfyB2V15izCimMoJ:22
    a=KF4VuIdXkMyp4E_ug72i:22 a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeEOTkc (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 15:40:32 -0400
Received: from mail-sn1nam01on0067.outbound.protection.outlook.com ([104.47.32.67]:45280
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751892AbeEOTk3 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 15 May 2018 15:40:29 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
Date: Tue, 15 May 2018 22:40:05 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org
Cc: Adam Borowski <kilobyte@angband.pl>,
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
        Zhou Chengming <zhouchengming1@huawei.com>
Subject: Re: [PATCH v9 00/24] ILP32 for ARM64
Message-ID: <20180515194005.GA6008@yury-thinkpad>
References: <20180515191214.5045-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515191214.5045-1-ynorov@caviumnetworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [176.59.40.107]
X-ClientProxiedBy: HE1PR0301CA0020.eurprd03.prod.outlook.com
 (2603:10a6:3:76::30) To BYAPR07MB4374.namprd07.prod.outlook.com
 (2603:10b6:a02:c0::17)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4374;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4374;3:rQrGh4pmVOGZU/NtfVtBmCWofcLVoKZiJl4DVz17taShdtMn/kKl5/qqUsEsVo6oQxrq4wzGlfg3Xks9zCve95cZ2RHBR/sfP+9bpVrpNMJi9fuvwbN0z4VFo5ABq6XvGeQ1uW5f3xVUIB09F2iTvpoPVuzfI08zn9FRUXv2Pf+UUrwXfPwk+wQ/vpZOt/vApoOL1zZ79f5hIdcwNAJgqITqlgrOexAqK+OizyzzAxAodldtjw5SFTomhb0fKgU8;25:X2NV6L9LVSvi1PUC+UIj3ffhQPWpq+FBHoQ8CwEY3XjHGZ2cFO4SCZwhDxaIcocKhZqV5ZiUgNVME/ZI9M+v2Q4a0mH+Z9baGeu3GYXv2+Wf1j77yCsap0EK4TvQtYUqjkVUKqLh0qJzSo7Qv23X4AuiJtLP8UGXJ6+/CxUNYqWU+eXjqE8ilYo/scYSHPZ3rnumZTincTT9jipIswztJTbvK+eHb8o+uJeJeXb0bWI1HLw1u74xSM08IcOtRYQk3KMRc9sim2wp2qlmNR9ptyKscMynGEifMhSP82GZQ19bxu5eFM8ajkEdrw7Bk50FUcG+gexrZRJPF3xmX4+xww==;31:mI4cZGRKwDmU7lxEzpJeuPyxNicaZndgSu2pqj9I3U1Av3jO9j1PCwZp76SuRUWBsuburkxXAIiMK7nEAGh3oTNwfs5xlWfKZJKHDHuRME3CgnM5OGJjv5CjjcQc4SamjQRq+arL6hzc86bstrT4i+fdk0Fot/T3G08JNR6Kst2lDPPjuxZMhVl5r3FZb8RDqwTQ+PxkNBO1D4/I7y2L0E8kUoV64KVQTGFhLoUNdtM=
X-MS-TrafficTypeDiagnostic: BYAPR07MB4374:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4374;20:qmoCsGr/vQmw2R0BE6bjNFJjc598und+vAbcSkUoASha3yltrvNZM1t7k+X9FxHZesKx+q7aQhY2XojbmfN+F5iFmfaFZjGDSgOhh/IeiN8O27ZTJdRQp0+puZVy2ATfLwwNA3r0eyWin9cLAapqyQiwzPTod8HQzyoWVafWxJYKI6az/oO+gqIe0Bi5zZcKRZtnKYjThbqgE5GnF0eh/wtNOvzdBoa2QVMmGr45A6izGCzj5Xn7FO+/OH+Qvn5DI7lfDJe8d5RKc1RV5rr6CpiCbrhP4tzgUiuW0+aDkjf+bgJko2qLhSqxSK+DZbODiChgIPQiXAEW9Z6oxms2/b0oMNHxCK/gEcr4BJJ5dTkOCb3lc71UNV4eDXPCvv7hjJWQRK4MPX8cG3N3fQDPKTXjANHFteKXB1Zz80SorrIDzZybfXVvSdWYoQbJk69Gfko6q1h2aOTtvEyNfPY39RSXHU1lp52jm/GizSGY+FrDdT6SV+A2Fk3zNPZtPbr+CtvZ7BVqr87ys28HO5+Og06HaL1CtDooOeS1MUxZ0pCgZAO8RA6xmpDfTRnxvSB0kRB0U4A6mW0Z7JJLZOEkSxNkxoct0GHK4q3Z1awgi8g=
X-Microsoft-Antispam-PRVS: <BYAPR07MB4374FF12090381311A9B131FE3930@BYAPR07MB4374.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863)(166708455590820);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BYAPR07MB4374;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4374;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4374;4:x+4LnUSL/Nc9Hqj1Jn612ph4HNdZT62tHnkazihnyigRPmUgD+qjXT+XH7wJFFNp5z9QWINfur/LrU5KfrYUZZgrwLOxNXwKuBO9G4aRtCKVO4ka/yotpEf5S1QV2bfw+aUj5IMeA2mg03GcNBMtECZy7/5i++H0L5QR3HwpFwLYTnVtjYKixNThd6faN55IL9rZk6mMnA3XuCeXNmiWQ6X+WRFKW2kf4OosFlHYYYaOTncziOzCG761FMzOgEOBqY4mJqWz19v9KnvYnwISwhXCdVB9wIMqyZoXVTLJ9iqjLBIWpba19HCFK2Ntbw1itK9jeyQgRcIp+qiPEchB8qvu5RhYSMMQnn/X9DzVOuY=
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(53754006)(199004)(446003)(68736007)(4326008)(47776003)(66066001)(42882007)(97736004)(9686003)(26005)(486006)(5660300001)(59450400001)(476003)(110136005)(58126008)(16586007)(956004)(54906003)(316002)(76176011)(7736002)(11346002)(6306002)(33896004)(52116002)(305945005)(6486002)(33656002)(966005)(53936002)(6246003)(2906002)(39060400002)(72206003)(6496006)(8936002)(7406005)(1076002)(7416002)(8676002)(33716001)(81156014)(50466002)(6666003)(25786009)(81166006)(229853002)(186003)(386003)(76506005)(23726003)(16526019)(105586002)(478600001)(106356001)(6116002)(3846002)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4374;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4374;23:QT/7JAfHNSafkIjPvlPBkmwpcHPvMUs8SEhw+UWZI?=
 =?us-ascii?Q?RHYrzGyDa4SdVf+LnkVMlaFKchXE1XcYodMOyd4AI9XHTbpyIakb9dq++LHu?=
 =?us-ascii?Q?aaBcwfC7N7ovlvUq3LQTGqYyvEV9GJW48TM6Hwwtwsma79aHRe8Eim7/8aK+?=
 =?us-ascii?Q?z2YI98TFHgUGOb9IuWKRD/u9i1igFNKfxMKZsyts7ObkbML0rRWNZYLYScFN?=
 =?us-ascii?Q?mbuxhXVkk9WPTM/lSeeM7yslxUK/MzkS9vCB9Ubw0hwwnNEOfX7NENYaZuNg?=
 =?us-ascii?Q?gIGMEfMmGB+dZkkVQ6LrgstbTwJODW+nEOX4C7xJY1BCOdwEZNpIr/JLKTBC?=
 =?us-ascii?Q?b89HCoEp0iqYoZ3LSEapyDyvz9Rd1kbX+wDVQjoEOC+jCTN9W69NN9Z8KdJ/?=
 =?us-ascii?Q?um9TkMEvzr4vIUYQniwcn/OSrS98SR4sV0jvL+848Tdg2mvSbX38ui3+fpJq?=
 =?us-ascii?Q?2rvkYvn3BO1umGMMXxe/ye360vgNb35JVgpbX6BB9TpXNym85hEUemFT8uBI?=
 =?us-ascii?Q?w46Mh4xKEl/w9md6ksCJqE+ryh6w14nK6g/FYmmsK6vB8pAFhaO+vE5CvVdu?=
 =?us-ascii?Q?7cmFFpj2zzTF9pW72GPTEvz8Sm/anuB6Yb+RoWcz1WhS9uKskbZNsqZKHJDe?=
 =?us-ascii?Q?wHukeuqIOjhhGRCcqdr/qtVgUfH+4wkSYJwiOGVMSjIvAWQpDlG6fHWZIblJ?=
 =?us-ascii?Q?sF0Z9bLpjMrXwqXgFWYf3nHrhWTRL8m0nXVMF6OTv8eUSMhgXnzKkB2ICN0e?=
 =?us-ascii?Q?xi5SFsw8ZY4/V+0R+MvmEhGsS+0tksEzzjIlJHgfcleuAvJ7XBP7Qxhi/ViW?=
 =?us-ascii?Q?2cN2y+4Qtz+yuTZBnNrANE93OlPMcR5EMmykNlsAxELtBarbKwtYTTjtSNKo?=
 =?us-ascii?Q?hFk3zL6h9PVNtQnkQVLY2EQAuX5Y61dg31JOMyd6IxcmVUmvgL/yIj0NusfL?=
 =?us-ascii?Q?ar1L4sTSGxfJDmDfoWk9hUeDevCefuVt5AjfwJsYKxr4yUp4n67sdBvZM1In?=
 =?us-ascii?Q?Kpdbig8eSKOKPc1MljTvG2ioYqQdzo6tQxldI5CZfdezpFNw9+RX7O5rqWFX?=
 =?us-ascii?Q?ybktzUgbK733EzAvsUSnjiGRrb3NfAKDRuyd/vH72o+SCfXhvDZE8VahL/tR?=
 =?us-ascii?Q?Jcohwd46rFrqUL0J9vTLUdxfkbdwA2RMUDLowPxYWgVzKSiC8Bhx6AfqkMMo?=
 =?us-ascii?Q?VGb90kaGu2/w12BagNPU0zmjCQZYUYqpdHTORggKXwA7C0rnJqoaHf77oyjq?=
 =?us-ascii?Q?Nw9Veg+ObyMLmOemhivZV8uCqhz1evLAuKxn/0JWaAI5UTUnvkabirel3P0V?=
 =?us-ascii?Q?KKO4NS6dDXqBalmrMcpNP1iplSp0tVuiTi/BgbWXUhd+Kx5QAxG5S0g6tjn4?=
 =?us-ascii?Q?AEMMlaoSA9hcm7ff3HnlKXOEppOXvkeZocaxekQVXDgvzd8K7zDiLfI6ymYJ?=
 =?us-ascii?Q?71vGubI8umkl/CUe5VhXj2vI63BiayPs9WNQUB40wbUUSeh8J/uGugWzXJhF?=
 =?us-ascii?Q?2Vzzrheoh9AHw+JKi128piI9P1yqXOKSUpqhEQM7w+TmrFW1teFJVok?=
X-Microsoft-Antispam-Message-Info: QryrLg3Uwl49GmvFS/gK69Xl7yN8tarcIcchfPUU4LBRuvWaouhGXJt6eTBiHcl09kX7N3aZVMxbj2xr61/cyE8+Ue1Bmy0JfIstPxotSSYcYh0cMa/gSq8pCs0oyXtcxlM2G6Bs16xKEunFOePym+ipZ7WXHI/6xL0K0MPaqKwOGCC9YaFXKsn4BmB2LU+e
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4374;6:qPAkLjvV1ZeIP6LlQwBgv0Xvr1InbLzJeYkWxL2A4U3ggv6jjnQ3s+qDjEIV1fC4mcvyug1RCyUc7UTKaRK2sEjfmiSpbFxsGgkLaRFEL8BGRV7vdFZ0n3kqGR4oe0NRO+/V89jrEa+n38VM53hNNnj3R7czvL2Qn0Dp3RZm5PFyvjkGM5+cbfhDQWvFCVdQENMmPSGXtB1V7FQXq7p+vS/0sH7M9nWrM0WUXximHLb7xNoon8KEKAPJy5BuX6VzXQ340wvz1jo1pUaCUukwpJYg0zfJk6xXQHNr61aWtLIEruEbzl+CKS4v35BnUY1hR6qUE8Nj6v8XaXz0BXBGEi4KbXT4NOHqcLNV81DuLaL10pvwHnrd32XCLbfapUEYy9bE2DGXrjP7iRBqDvpAeyXDNc2+mo244XIJpw+xC73lqvzkKzqlholfSySNCoAUFSAxgsYTuTGQA1c6LwXsuw==;5:SFDuCAtJFIT0Bh431xX5S5ZC4XneHuyDZG9dQ/Ykjjv3pyZkjVQ3dULx0jEIIo/8Wnj6eBmiejZCEjjmXSGpqifasZArv/CpwUP/ZadmfALf4LlvXmQP43hSMuadkOKgQ7SYqBClhVWXW7GFS3iyUiowAUMWypVhIdvjJT3vupI=;24:eVBKqwe3ot87YHUb2Rx8p1+jeyhimSFRqg4jshSiQ5bLMpGncuaJJR2OAjeDJkMUOXi0H7pmjfY06aJq5Qv4xaZc4fVn6bSmxyn053kwj2k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4374;7:PXz1zBMaH3PgLCzEEMuk3FH7kAhZoBOekp0ynBdIceIenC581CCjl32y6IVQ9DFqHlim8Nc5lAmO+ltYl2bDzfrTyCwcYEpGr+YQSeARLyIzhSYPbXQ1lg/UGJki0emwcBhoW02tP4ifHcUGEoAbhIwfCgjhGMpNuCl1LicyX57QdcWDvJeGskgmokyfFUBdekI4X3KE86EG+KNurL3e1prLwg9ODsze5UrdHRbwusTAhnscrVCdtpfkre1moC0q
X-MS-Office365-Filtering-Correlation-Id: 79f1b774-0b4b-4e65-bc0f-08d5ba9bb25a
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 19:40:20.4343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f1b774-0b4b-4e65-bc0f-08d5ba9bb25a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4374
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi all,

On Tue, May 15, 2018 at 10:11:50PM +0300, Yury Norov wrote:
> This series enables AARCH64 with ILP32 mode.
> 
> As supporting work, it introduces ARCH_32BIT_OFF_T configuration
> option that is enabled for existing 32-bit architectures but disabled
> for new arches (so 64-bit off_t userspace type is used by new userspace).
> Also it deprecates getrlimit and setrlimit syscalls prior to prlimit64.
> 
> Based on kernel v4.16. Tested with LTP, glibc testsuite, trinity, lmbench,
> CPUSpec.
> 
> This series on github: 
> https://github.com/norov/linux/tree/ilp32-4.16
> Linaro toolchain:
> http://snapshots.linaro.org/components/toolchain/binaries/7.3-2018.04-rc1/aarch64-linux-gnu_ilp32/
> Debian repo:
> http://people.linaro.org/~wookey/ilp32/
> OpenSUSE repo:
> https://build.opensuse.org/project/show/devel:ARM:Factory:Contrib:ILP32
> 
> Changes:
> v3: https://lkml.org/lkml/2014/9/3/704
> v4: https://lkml.org/lkml/2015/4/13/691
> v5: https://lkml.org/lkml/2015/9/29/911
> v6: https://lkml.org/lkml/2016/5/23/661
> v7: https://lkml.org/lkml/2017/1/9/213
> v8: https://lkml.org/lkml/2017/6/19/624
> v9: - rebased on top of v4.16;
>     - signal subsystem reworked to avoid code duplication, as requested
>       by Dave Martin (patches 18 and 20);
>     - new files introduced in series use SPDX notation for license;
>     - linux-api and linux-arch CCed as the series changes kernel ABI;
>     - checkpatch and other minor fixes.

My mail server seems broken. I will try to submit series tomorroe
again. Sorry for noise.

Yury
