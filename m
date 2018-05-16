Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4134569-1526459300-2-2851699530556175536
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526459299; b=hgGYzg8dwGLFw/dv5J7yz/fG4eFjr9aIPuK7dUaLxGUwIM31bK
    6zbsktJh7BJbAUloON79rb75s5PF3B036pMpqWJegiew5NKZlHHU9KbQrvHKRjF5
    JJXZ05ekl8fPdgG+Rf/95pxMl6wwdU74ThhDgs9vKGBG2zec5iqjNKhczXK46gTm
    Cn+5chDvQyGht5XtPOFI+GPembyKN1PtM94f6A5pz4Ek3rI4Vwso/Qwovam+t8VR
    lgzvtXJqNfsYuj2VikLA3RHZtjXaNGSK1itC8dt2ZUS1dVEhni9OX1TJF6Zzi/da
    2L30Y0G9+8BKP6ms1RnpbB1a6+4grdSUOUmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526459299; bh=w4HifINzgoKpqK49z/INO+lqwE0u8R
    xlqXetS/I71M4=; b=MxFYCGXKFsrUvAuCPPvLmIepEtuwiW3HlVvUXej0l83kzh
    +1c8GdE/OfT6u6/tu1cBptgdHwPaVl/FEmMZXrZhmtwuwXV6Unhun+Fg7F4cEUrL
    WR7czj29AZEl+sG3gA/+jG+KXeYwSloBkwlMdtRuJrucU4joiwR8n7B6S3iuLyAj
    g6y7b7pyNBvbemQnICZWBJB1lW/pjNVxWt6ViSBavEiVhWKc9AhtCccnJgnLb6p9
    HIZclzDDHOfENBIx4P0ycOb57m1ZJCfwlitCSZMGH6+yHxQe/ewWALSPH8kit2h2
    NzHzj7Vuy0AIpXcSRD8V7iLKgzjWfRpWjwndJesg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=caviumnetworks.onmicrosoft.com
    header.i=@caviumnetworks.onmicrosoft.com header.b=opbEQPI1 x-bits=1024
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=caviumnetworks.onmicrosoft.com
      header.i=@caviumnetworks.onmicrosoft.com header.b=opbEQPI1 x-bits=1024
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
X-CM-Envelope: MS4wfJFrX38Rfuied0InmY86hJt0c+LQz4oZukN/oybUEFZtPrmC+iAWMkeb24X5fvwKWfNUM0ZgUa0nTmKxTrJZh8PoaGdTpeOJfR8D3xZbmGru68AwEdRj
    f4jsHjAkD5EwSqyz0fNeR3e7uEaqXKzfv7sy5XxrfAsat2l6XTefxryrfhdNNRAq77FzE6Qj/YJekAVxLV32/quvueNBHMPR7lgzeYGmC4m1jbHcxVcjYQmO
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=sFUR1tI3dlkA:10 a=P23N9hKgfBoA:10 a=bR_0OyIF0roA:10 a=VUJBJC2UJ8kA:10
    a=ifRc6kEuNzAA:10 a=enOvQawGAAAA:8 a=VwQbUJbxAAAA:8 a=f3kIZBr4XWubMGSvvaIA:9
    a=x8gzFH9gYPwA:10 a=OuzhcWw_GC9nAYdNdRwA:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbeEPI1h (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 04:27:37 -0400
Received: from mail-sn1nam02on0078.outbound.protection.outlook.com ([104.47.36.78]:36448
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752405AbeEPIWH (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 May 2018 04:22:07 -0400
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
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: [PATCH 14/24] arm64: change compat_elf_hwcap and compat_elf_hwcap2 prefix to a32
Date: Wed, 16 May 2018 11:18:59 +0300
Message-Id: <20180516081910.10067-15-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [176.59.36.13]
X-ClientProxiedBy: VI1PR08CA0123.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::25) To BYAPR07MB4373.namprd07.prod.outlook.com
 (2603:10b6:a02:c0::16)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4373;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4373;3:Q4lTTTpa51DW1N7PrrLHh/tt7BvOPXmN2J7cRIquI+UXM6m35Urcog6KPb/fElrtMdot1cQuNX5tmwIf5Urfpy1CX00aYFvyjJAmPc4LOInTuWmJqeWS9aKL2ur4GevAstzE4pgWxhT+LP/Lnu6g2YCo+lug5ZUMay9a8PjyTs3cuSCiEYn51y+XNcXdMEotxOok4G06kc5+mJuMQ4Gkx9qV53qQQtnggjvEB4gR+rMZnBQ8paImRwQ0PexvWaxy;25:bi9oXQUORV0bdpT7Ju7+FtQqey6sTRK/We67m1sLy3CemqGodn1j1D3Mtojz9fWFIr+0jm+3sWqJFCKbiv5mZqLnotnZ33DLndliJLgy/TBVjcHmuF0+CNEvsCOUAEfJFXU8xoSYQe3a959VminZIUkTcHWskFnVrnv6Hx6fFwWMJr+L0W55x+hXCvjUJJ6mE7MnD/XJuCOB+ZbKd0fNAOr1DjUD14ERhHy9RLkzz/0VUJSb9zdFK9hgsEZkIxSfmqiASvD8Yk8f03IvHKsxmqqjYZVuyLT84PsC9dHp8YHLA9eYa+OqtX3FvrZbVPNHvp2lW5wBftl+2mRsaP/QMA==;31:P5gSM4hAx+qh0djnKmloG2sld0lzIDTWQ4voWnAln44pRzZhGQmDhKRK2BC21Y8vtYREoJgzI5ChvpgDnnp3dQz+MmmTZsECm9C17I9y8V+2qew6eNsBGK859YtBqmCs5hjDfe/2Yu/kjCF4YVIaJ4lPvUca0AafX2deXCrCdm8+Qe+PmkCpwSTUfySj9n0gGoJTzHb3hko3xg+4Ut1PIGWQ+4/3P/5cTeDp9xjYhfg=
X-MS-TrafficTypeDiagnostic: BYAPR07MB4373:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4373;20:QLNV7d69wOLXOI7tKVxtGVqY4VpYqx3M8P9BtosjnlLcuPwTjH0T374JO/o1SXPBxApmiWpRYaTjVWaO9UQ95wHe0gPDZ1ObSUK60+tktN7JmJ0POHIEVyGy4cyuCQPtUCTIYh0ykAvj1HZpSIIXbmJNljpaTcK/qStCRmeQC3850xjJtgjHuVM/cDJDeq0TbW4B/X/jrtv1ymsTW3y8xHKo3S9fOimJp3Au2XILE6LBtAwBRRBbXEVrL6fiRGKWNH2a512AhXnMq8+6AKlV3dA+HEDPASIh7kXDqOebhyUukrs70MhcK4fMq1tSZJiK7/l+l8iZXoBgoiXqooy75wHXR4wM9eu/vPE7D/8R7MGCX5/S0Ln2VwZI8MA/It+9s2EMB5SQ9HJ33g6PBaHi2WRuH3yiWjesPYRrjULx8YL176I4CLmfnrExuvjPM0UC/xgnOhaOYPcS0C5rOy2oW/JEOmXGLoCYcVMcCpaZ6FszYrJ0Nr60SkeU+6um5ikxtsXsnKap0UmP0Sjii8/1NEiBJUzQ8IYBQ10+apHT1qpKfCeDMq4FcVu6z2peCiTcYW0swBJdY7aUOuTGwYF9CfrQwdyVmYyhG4r76zcCMjU=;4:fOESRxkM/nWvNwst4M3e+gC49OJb4WkeqAviSUvwhGM+nUDFVqQZ6YujqW527nXevMVBV0Ly73dGtKOPCGwlBDZMaNqu4Tvd31kRGmo3w5kH7Uz7xh8aJeY5lwrud7zWhZLy5FSDeuIESOO/F09hZYCf/29OX3ssq2lfXnqrXK6uLodsqI+X3PD6xmTrCuKncXXwHfNj6EnfFjoH5fyMubg+MOkSw/TwB5fWiYghe27zL9arIyQGJyY9XlAwD69sOTDVz3suG8xPQa/6HSQHdQ==
X-Microsoft-Antispam-PRVS: <BYAPR07MB4373D32502C8F16BF248F2E0E3920@BYAPR07MB4373.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BYAPR07MB4373;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4373;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(39380400002)(396003)(346002)(39860400002)(366004)(189003)(199004)(575784001)(2906002)(305945005)(39060400002)(7736002)(42882007)(7416002)(7406005)(446003)(11346002)(956004)(476003)(2616005)(53936002)(106356001)(68736007)(6666003)(36756003)(47776003)(4326008)(5660300001)(3846002)(6116002)(25786009)(50466002)(72206003)(386003)(76176011)(76506005)(54906003)(110136005)(26005)(6496006)(66066001)(105586002)(1076002)(48376002)(8936002)(50226002)(6486002)(8676002)(486006)(81166006)(81156014)(478600001)(52116002)(186003)(16586007)(97736004)(16526019)(316002)(51416003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4373;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4373;23:mBQl4OkqPh85WvOGaREKD+ryf8GxNy0mrjOBWVgml?=
 =?us-ascii?Q?RYLPcDVndHD6Gzf15vjOiXS1NlXkEPSXfu3ezdmc+AqJ1Og/Ef6og31DRkTM?=
 =?us-ascii?Q?5bVUM2stTdBcHYRkg2m0lURTqSEbXsVnvCj5R1iIuw3uP4ZOcPtDtIymZqop?=
 =?us-ascii?Q?sKlwKJ091J7e+kHPBxioqQhhGIK/1M8EHo+J34RureWl60Tf4xnnLeMEcKQs?=
 =?us-ascii?Q?Yn3bVA8tmKtvIjcRXMB72sIut0M84Evtm+zznhC6wgGOcQFFFPyHgekB9LKK?=
 =?us-ascii?Q?/LBaXA5Tfw5MMFtAyOKtBkmbifzMi3OmBI7AqA1uyQbvuElxzr6eKUtPqfTy?=
 =?us-ascii?Q?0PvPCpbzw3BDFc5FID5olmhR4DL+93iWvpwTp6t8tvk7qJH6rb+7QmAOJtTF?=
 =?us-ascii?Q?oWatylOthGGyFJjvQ5cfKRbJcAR2VP0uWckATW6fKR9uAPtr8E3Qqu/oVt/9?=
 =?us-ascii?Q?fhCVwzWaRZGtDuoMkWBbNTBZkyjBsip3Ezp1Z3sBYLnSqbzj8Q82hpzG2hLf?=
 =?us-ascii?Q?gtuPHbQZsY3UZIUHHeH/XAU7JuqXpIdQ+A/uXV4MoljZ6Mu2z2XkNfq3avFc?=
 =?us-ascii?Q?tsJfPnKve4bcS5fID5eT6wxZINuMmJpBcUFZ1r7S9ZaUy2/fVOgpbXbCl18S?=
 =?us-ascii?Q?/j3mWXwAQMfI/fA5Nc30yu0H5mNr0PLzFIDMyv1CKhTJJgOjb1UHdOSmDruR?=
 =?us-ascii?Q?0TUOp/HmHl/RBmYmMcX6ceAUefClVc8wzJC3Bw5fNKg0crIT2pdu9gXZ/+DO?=
 =?us-ascii?Q?1AHBjSXLQBG6fpRdKKhRYAro9HM/k/GHD2GcArszptZ2z5Yc9oFAfY4nAiOd?=
 =?us-ascii?Q?7Bw+jct7OnWjvrOiydDyX4+aIY8lu6aKmX9GmqaOyVaqS6VofVIlqsBk7YNq?=
 =?us-ascii?Q?S1uJa++PsMKj24AnqSY0sxmlNCqTHcrdWTZE8YWC+oJpZ/EMFv92hyZJzmVK?=
 =?us-ascii?Q?2rmyQhglyd6TorD7TO1cF+eXxY9WJAj0tyDNkpI2iHMTTOBIXLvKKaDL8Zbp?=
 =?us-ascii?Q?MW3IMt+TbaZLPLqEe/ukom5RdKgFTCq3YxUp5LVaGoCsglumgq4ShdqgDnQx?=
 =?us-ascii?Q?6SvtI7fORKoWzbn8fEF7xNlGr/4S1Nu7hMnB3tgbHamMbJCW2lKSJcR8dI1X?=
 =?us-ascii?Q?Fxzii7iPkWPYgedXUyVbpx9KAU1fHYLnQJq5L8xWikFgNgvGT3ktJKuvCSos?=
 =?us-ascii?Q?a+rVpGrx+3KPjKnqVjoz/HIvo5iAzb3FfXDS3BRbacXNPP6O99Wv0o9D8BC2?=
 =?us-ascii?Q?j+QYYIj77ke/UDPltHNoJqRWIPgPJe0v8CULNa5KmLZknXeLkT7cutZ78ujD?=
 =?us-ascii?Q?fdKW/mcbB76Dw3kojsdI6gktSD7vNNN3b0ScrSVub88jPppxgODvStGnjlRj?=
 =?us-ascii?Q?1pViA=3D=3D?=
X-Microsoft-Antispam-Message-Info: 9+BAMDj3N+VL7jSvMML8DthMHukI7BXtLcIVsZnZsBTH6G0vx+KCbVAwAaQ6NbELdj/Hai8EdjrX+n2+YvUDbSLR2v+889Rmt+20WFdQnY+rUc0SWUNMjuiyX5Ksie8iNvxk4Y5hopDx4LoPlcQMoSpK4g+kvw1H7GwWAegasCyv6+Ir775H8KLRIhja1q8i
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4373;6:Qg+iEGjgk95Xa0mZkq1BBR9pXLmlIF+OhDjmKMGdwf5JRqrahu6YbNUG84HobpcUaNODsFmA2wwGMMj2/vfs29k2LXML1BdZRZ+p4gDArFbgSZuCdxalVst3eu0ZIXACfHwaDylF3/lnaa7mKOphOkBTNZkc1K7+VVQYQLH/eP9sXMDhJkRCfMiyC2ZtwANYOzwlFeJmMTCAJWfKGnuiIymz3osL70EGnuxpfOoURSD7L8zqTT3AbRcpDo9SRGPdn1R5Nap0G4Ju5yqZOvnie++z2cqJ4zDBFlF02A2jP4P3NcAqCNqoifQ724qC4viiUltzvL3F4BAmY4QZMEBGZq6u7HlrdwoSvXR10QPsKWJZqFiwjGMmMsRaj3k1SO4FmU/q6yoRvGsKjjamxSo3tppJAuQlk+hmcdy6qx70YqlzDCeou4Yckff2oAlvAChA4mVETyh+r4gBnd6tS42Pxg==;5:ewGPeyIKZcXW+y4WWQrMWdWN0ZKWFKuqIoBuGsW6T+CMsqXVtN0m7aoXAwFz/AxfyvOJjjoULWApCWoZL2leT/7jnKvu2F0T9umDub9qCsNCMZTY2IP8BbdikfRPjwMFhCoioCQrZBiNIBV0Fxs+wQYdqzkInUrRTxr9jqkfKyI=;24:r//c3GHNCdDNHm7bX3jdhKaA0aN7FrygDSotnWalnEa95sdNnmCZ2IbyTPLSWnATfhajygtf1VWKKmM/LnT3Zh/t7E4vycn9fHedKmIW+3g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4373;7:/3PXF7LUdE9L2tIExAvQ2Gabc4ajNcO711gvJUUhffZN8MUMl6210wKRluWW/7FTH1akbi/lw5A4C/z7DuHifje0+DbHvCqn1t7fDLaxY4/pga3sCLtaRJdzfPI97+WbxaiNhnE85VTGEpi/gAK2UMht0yVnejmuaEOzkkdk/JrC5PFfWGy8tUeM4Byk71oX7OhZY/XVhh/DOroE76nUtrql4RWR5DizLRtjQtLmC5d3jTwW7EIFGjY1ztzNDjiM
X-MS-Office365-Filtering-Correlation-Id: 9ceff71a-f551-4922-6e2a-08d5bb061c13
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 08:22:05.0682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ceff71a-f551-4922-6e2a-08d5bb061c13
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4373
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ILP32 patch series introduces new type of binaries which is also compat.
So rename existung aarch32 compat_elf_hwcap's helps to avoid confusing.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/include/asm/hwcap.h       |  2 +-
 arch/arm64/kernel/binfmt_elf32.c     |  4 ++--
 arch/arm64/kernel/cpufeature.c       | 14 +++++++-------
 arch/arm64/kernel/cpuinfo.c          | 10 +++++-----
 drivers/clocksource/arm_arch_timer.c |  2 +-
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 99dfd9277559..428b745b5386 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -47,7 +47,7 @@
 #define ELF_HWCAP		(elf_hwcap)
 
 #ifdef CONFIG_AARCH32_EL0
-extern unsigned int compat_elf_hwcap, compat_elf_hwcap2;
+extern unsigned int a32_elf_hwcap, a32_elf_hwcap2;
 #endif
 
 enum {
diff --git a/arch/arm64/kernel/binfmt_elf32.c b/arch/arm64/kernel/binfmt_elf32.c
index 440fa84f62b3..2b49d2a40d8b 100644
--- a/arch/arm64/kernel/binfmt_elf32.c
+++ b/arch/arm64/kernel/binfmt_elf32.c
@@ -20,8 +20,8 @@
 })
 
 #define COMPAT_ARCH_DLINFO
-#define COMPAT_ELF_HWCAP		(compat_elf_hwcap)
-#define COMPAT_ELF_HWCAP2		(compat_elf_hwcap2)
+#define COMPAT_ELF_HWCAP		(a32_elf_hwcap)
+#define COMPAT_ELF_HWCAP2		(a32_elf_hwcap2)
 
 #define compat_arch_setup_additional_pages \
 					aarch32_setup_vectors_page
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 28b7bc582334..4867fb142e86 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -38,15 +38,15 @@ unsigned long elf_hwcap __read_mostly;
 EXPORT_SYMBOL_GPL(elf_hwcap);
 
 #ifdef CONFIG_AARCH32_EL0
-#define COMPAT_ELF_HWCAP_DEFAULT	\
+#define AARCH32_EL0_ELF_HWCAP_DEFAULT	\
 				(COMPAT_HWCAP_HALF|COMPAT_HWCAP_THUMB|\
 				 COMPAT_HWCAP_FAST_MULT|COMPAT_HWCAP_EDSP|\
 				 COMPAT_HWCAP_TLS|COMPAT_HWCAP_VFP|\
 				 COMPAT_HWCAP_VFPv3|COMPAT_HWCAP_VFPv4|\
 				 COMPAT_HWCAP_NEON|COMPAT_HWCAP_IDIV|\
 				 COMPAT_HWCAP_LPAE)
-unsigned int compat_elf_hwcap __read_mostly = COMPAT_ELF_HWCAP_DEFAULT;
-unsigned int compat_elf_hwcap2 __read_mostly;
+unsigned int a32_elf_hwcap __read_mostly = AARCH32_EL0_ELF_HWCAP_DEFAULT;
+unsigned int a32_elf_hwcap2 __read_mostly;
 #endif
 
 DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
@@ -1151,10 +1151,10 @@ static void __init cap_set_elf_hwcap(const struct arm64_cpu_capabilities *cap)
 		break;
 #ifdef CONFIG_AARCH32_EL0
 	case CAP_COMPAT_HWCAP:
-		compat_elf_hwcap |= (u32)cap->hwcap;
+		a32_elf_hwcap |= (u32)cap->hwcap;
 		break;
 	case CAP_COMPAT_HWCAP2:
-		compat_elf_hwcap2 |= (u32)cap->hwcap;
+		a32_elf_hwcap2 |= (u32)cap->hwcap;
 		break;
 #endif
 	default:
@@ -1174,10 +1174,10 @@ static bool cpus_have_elf_hwcap(const struct arm64_cpu_capabilities *cap)
 		break;
 #ifdef CONFIG_AARCH32_EL0
 	case CAP_COMPAT_HWCAP:
-		rc = (compat_elf_hwcap & (u32)cap->hwcap) != 0;
+		rc = (a32_elf_hwcap & (u32)cap->hwcap) != 0;
 		break;
 	case CAP_COMPAT_HWCAP2:
-		rc = (compat_elf_hwcap2 & (u32)cap->hwcap) != 0;
+		rc = (a32_elf_hwcap2 & (u32)cap->hwcap) != 0;
 		break;
 #endif
 	default:
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 23fdf30dc0a3..a57a6fd0afab 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -120,7 +120,7 @@ static const char *const compat_hwcap2_str[] = {
 static int c_show(struct seq_file *m, void *v)
 {
 	int i, j;
-	bool compat = personality(current->personality) == PER_LINUX32;
+	bool aarch32 = personality(current->personality) == PER_LINUX32;
 
 	for_each_online_cpu(i) {
 		struct cpuinfo_arm64 *cpuinfo = &per_cpu(cpu_data, i);
@@ -132,7 +132,7 @@ static int c_show(struct seq_file *m, void *v)
 		 * "processor".  Give glibc what it expects.
 		 */
 		seq_printf(m, "processor\t: %d\n", i);
-		if (compat)
+		if (aarch32)
 			seq_printf(m, "model name\t: ARMv8 Processor rev %d (%s)\n",
 				   MIDR_REVISION(midr), COMPAT_ELF_PLATFORM);
 
@@ -147,14 +147,14 @@ static int c_show(struct seq_file *m, void *v)
 		 * software which does already (at least for 32-bit).
 		 */
 		seq_puts(m, "Features\t:");
-		if (compat) {
+		if (aarch32) {
 #ifdef CONFIG_AARCH32_EL0
 			for (j = 0; compat_hwcap_str[j]; j++)
-				if (compat_elf_hwcap & (1 << j))
+				if (a32_elf_hwcap & (1 << j))
 					seq_printf(m, " %s", compat_hwcap_str[j]);
 
 			for (j = 0; compat_hwcap2_str[j]; j++)
-				if (compat_elf_hwcap2 & (1 << j))
+				if (a32_elf_hwcap2 & (1 << j))
 					seq_printf(m, " %s", compat_hwcap2_str[j]);
 #endif /* CONFIG_AARCH32_EL0 */
 		} else {
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index c3c6a8d48adc..d8b12b9be97b 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -765,7 +765,7 @@ static void arch_timer_evtstrm_enable(int divider)
 	arch_timer_set_cntkctl(cntkctl);
 	elf_hwcap |= HWCAP_EVTSTRM;
 #ifdef CONFIG_AARCH32_EL0
-	compat_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
+	a32_elf_hwcap |= COMPAT_HWCAP_EVTSTRM;
 #endif
 	cpumask_set_cpu(smp_processor_id(), &evtstrm_available);
 }
-- 
2.17.0

