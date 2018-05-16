Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4134569-1526458983-2-6127533279074836201
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
    1526458981; b=jJr7159MWcSgFhEmt8g2wb/ybp1NKp6n9rdXeR8oxDJScIp5S5
    1TW4os1cItk0sXgVy8kekmBHlaIZs6QZt+8Ex8f4wviAIkL5LweiHBuyO9NoFBUZ
    jo7UJmHb4Q0LkaKwoW2Wgm5CZ0viD5vzWCYC7OyUMptX5JbyfeBaDOEJ5vEdMN7g
    FUIr3SFpqI6RA35PCqDWBKXpamslpPKJVdKv4olKhdTMyiVMc/2jmDQAWrntkEqM
    hL2SJt/ny66G70aLsbZeQ81O8zdoPyrdA9sYmu8nl/xQTRYBQWwc7nUg0asuFBfJ
    aIeEektuZpdR1GO+WUscEKrZo7O0zi0q2YZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526458981; bh=iL8U9n2yFre6GNYwR6q1xh3eEcgS8D
    /sI7mvJkolIa4=; b=ZkC6RaZBLGWC8gNlL0paE12JpsMhHGecOKz99x608HF6j7
    zSeIhQeg5+o0DaVkRnmM1s3UYfnIoqmN40ttUPjb5ukKQR9hU7c2snCRbu4EJY3Q
    qOEBrSOSKYBeilw1HURshRgLGhhvmyaECN8MvxCzQ21J+o+Sgke2pmskawwtUeLa
    nboR1W+L+8f0JNau6fQxGxdJQt/QkzfCdDwGXkW0RHcLOHiTTTjQErG/u/OYCvwg
    r4C4bqO1kU5tlaga3t0AiuJxu6yo9bpotCROCYWkTNqLdvkRzSCiVjUBd8g+Ldfg
    Rbdkr7Ww5fHq3+U2x4O4O92CT/mm/A8+uLyiNYfA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=caviumnetworks.onmicrosoft.com
    header.i=@caviumnetworks.onmicrosoft.com header.b=aCrm5uks x-bits=1024
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=caviumnetworks.onmicrosoft.com
      header.i=@caviumnetworks.onmicrosoft.com header.b=aCrm5uks x-bits=1024
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
X-CM-Envelope: MS4wfF+VzPwcvj6MT9coCReUddVZb5B8qvacet+xhmysugt1eDR86KKJrFCD4s1JW0tvMoxyjbgi10zNYuTTZ9zImYs5SdsU+KJT3eKcEQmxlceqr3nNTbN2
    0XNAdCD/0xk8YggyFAxUYa/WijKaYoFt/p5kE7YntudhIVd9m37I1AIbB/dfztczCkuZAnKZ7LkWOGC890YjCErEJfAUIRqXfRFrh9SWagqM3SmQMAJIiesy
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=sFUR1tI3dlkA:10 a=P23N9hKgfBoA:10 a=y8BOmzHIJFQA:10 a=VUJBJC2UJ8kA:10
    a=ifRc6kEuNzAA:10 a=enOvQawGAAAA:8 a=VwQbUJbxAAAA:8 a=ITPo6ULfvKs6OkU8mdUA:9
    a=OrVG1zvluR0IqrID:21 a=ByLqRh7IKuhT6rM1:21 a=x8gzFH9gYPwA:10
    a=OuzhcWw_GC9nAYdNdRwA:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752729AbeEPIW7 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 04:22:59 -0400
Received: from mail-dm3nam03on0080.outbound.protection.outlook.com ([104.47.41.80]:41283
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752716AbeEPIWr (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 May 2018 04:22:47 -0400
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
Subject: [PATCH 18/24] arm64: signal: share lp64 signal structures and routines to ilp32
Date: Wed, 16 May 2018 11:19:03 +0300
Message-Id: <20180516081910.10067-19-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [176.59.36.13]
X-ClientProxiedBy: VI1PR08CA0121.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::23) To SN6PR07MB4381.namprd07.prod.outlook.com
 (2603:10b6:805:58::12)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4381;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4381;3:QBANSMVlzKfo28s8Z6/+1TnpTvnpjOq5ik/RHr8xhe2D9dC5oL/y49qGQRYxZFIb1de5iS2sh1OKsYz5CmBlB7SKs4WQWa3SK8/TGjg6sqEwOlboNUP7JCpcQLPuKJlA+hkpCsTtssup0+SZK7RYJRW+Ghg2d4+iekObgAzC/f+zqEpmnM+NkzJ93TZJvY/J2HHb9rPuS2FIYPdkheOrBl5t3IP9PvkC2lEQ5O//fbr8/JQIMbEBFI89N7CcvFqU;25:0aKia9i04By5xpiFQcDFxjtGvRCYoIM7aGenkj/NXf5jhYh7RKGmRjB1d3xSV95O/F2jtQtcq1KExP3UCQR0JOkFMobmHfsY1aIX/qXblN8R66sMY1GsCup8AV4dXPxV9ykLcVLJOCyJEbNqpnweL5vkouwtGNoFRVpbGC2kJyCoYTC2j/E+/l6vhKuw/6ejn7DgaOPcEsUkN1QLI6DOJo3K/k7RranU/dGCqepOqKwBXWTplHwajT3OrJeRXRe4FysWalEk23Yp0aJOkEZTSBd1vhXJHROBGovYrgvKO7JZk/iccTYDA69Rt3psdbU2A9TVn+l++p+rfA7W1g0TNg==;31:gC2p0Ytp175g/uQxPIP+/ilkrvJfxdx4n5yziUUpzbuy4/q3IuUAIVggw5TmXFW7DdVw6ZslpSc2mhkqEPIKTZQqbHUkWwe0WIYQ8ATEjGYuIA07/R38SfAool6S19TYRbV0FMw0eUr53QMOM6zajGVUZJKiA9D5T2Qt9oKe6XZAep0mhO14P8GYiCmBf5cZQUPkd0Obx/uFQq9KIJU75ambdjOBDCYpHeBoHpTNmY4=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4381:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4381;20:FmNSLQeVyO8cZrGiRpwa9ZG8ZmFUkjlnSN8jvifdN39pLJh7nkgPXZ6/74DeIfZrM3/n6s7rbog+e3zJUroxWPW9z3xIMTghgBlE/l3cOItxcjz3iOO6V7z86eKcGHT/zpN/kaSfnZCusKHMhHmoyusuHLhL0iEXBHFR5knk1twpmofPcM+ONBubDbnVfag+B6B1rWt+dCR3MAiUCYCJcCysX0D212PuVuYtjSOLLvmgKyTGfRyaMX5/k4vG5BnUgWm6BGyx8Xzv90z/dqwLrSFW4y4mFl+Kp+gF9G2t25IA5KNlaMzzkmypI5gomw5kD7gIFV4q+btUv/qh+6VTPp/B1667u0L2oVH1HA8n6cXrpbcDw2v+mLLlWJZebp0dy7p4nXhtrzJt7GjfS0s+nTd/KOB9LTnEEq1mIdZUkK4BC+/TmMUHAcpxkwUc8GQuwvhG0ee+Qn4jGbH5Zb4BxLwtAD2Mi6Y61sPVG9vMBPzOtqEW5vBjrbOtrZYcatueqCUqLUT6/0UGJIiwTCRUTrpJILZv4PfgSH01X3s7EySmlsacUpFLgAJFiJpjN3JpbmqUawhJhvnoBjHh3mUa78EW73ou5wfcITbzffwVMxg=;4:qrpVwTXCve/VEumlXzM45qe7joXQlpS3vp4s4sfl4PLMhtQ2EIK4slrxZ0nvOdMqoycA950IORQVQLboBb0VQV1oijklOCXHwAExZDvqhlrojJItG1+HUmsdzd6bY+NNxjGOzaC9GpoWyOKBIkuw2UCMH0aJCWhu/SaqcTuGA+5IQjspLYkrk3eZhCE2pJLBOZQ/awfSoo84eyzZVMSKpeXVME2uXGOhcCZG7Y8i/7s8XwuwoZxQSSfdBX4QGvRk69Bi2jl0qtdfr+dXTWT8SQ==
X-Microsoft-Antispam-PRVS: <SN6PR07MB4381D4006AE7AE04D47051B1E3920@SN6PR07MB4381.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN6PR07MB4381;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4381;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(376002)(396003)(39380400002)(346002)(366004)(199004)(189003)(386003)(478600001)(5660300001)(16586007)(6666003)(36756003)(2906002)(54906003)(316002)(110136005)(68736007)(97736004)(51416003)(76176011)(72206003)(6496006)(52116002)(3846002)(7416002)(7406005)(53936002)(59450400001)(1076002)(16526019)(26005)(186003)(6116002)(486006)(66066001)(47776003)(6486002)(7736002)(305945005)(42882007)(446003)(476003)(956004)(2616005)(76506005)(25786009)(50466002)(106356001)(4326008)(81156014)(39060400002)(50226002)(105586002)(8936002)(11346002)(48376002)(81166006)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4381;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4381;23:lCurgLHPz8WPQKi6aOmN/9oz81qrUDf+89Po1bgkC?=
 =?us-ascii?Q?P7l6JgdM9wjgAMEVbm6kcVFYEbD/2r9YIUVDNcRaONZ8HbGG+GxjH7BnQlFM?=
 =?us-ascii?Q?SN1ky/P73hllNcYsvGkPcZtCd6RMzAeJXoW2HS2iDYwtgnLh0EbVMCrsqI5G?=
 =?us-ascii?Q?pLFI8buZBtanx7aIAnyvH9THj4bPz3pe2K1XPAyO8Bac1ih8IgUNpuADV1gl?=
 =?us-ascii?Q?npLJtbONQvQPXK//k1XOVAZVEYxvKESRgp7M5n5DsiG2kouzEAwd7M55lr5j?=
 =?us-ascii?Q?OUSQRchzwjN72ztgrjXJ8C8evi393pBxzXFiD27pbonVMyhhWcZe4MRr/Op4?=
 =?us-ascii?Q?4IuDc6yZVdrlDkKPoPb04RvWm0s0CesBWeUk6UEVjbT2ehdZOfSe2gVzIDuG?=
 =?us-ascii?Q?avNYiTiEu9qAHNdAG4noFPkMlDRLmZ75MpdAMKXcBLnK2936Z3Ok865aIpy0?=
 =?us-ascii?Q?A3ZwXixbgrBkTJl7rnhnYP60YCYbxNb6RI7/TcAcD89hI4tZw1PfMjxLiuHv?=
 =?us-ascii?Q?RTerPXmrthvNHOSJ7bh5uHj2+SmdV6XAGyS4Y027xyFtDRk65I5RfAjnmSMJ?=
 =?us-ascii?Q?LV6zkpqa/sT+zmqR2E1+fxZUoNy89MhgS1GR11Wroc/bXIIGX6mno4xMY+VW?=
 =?us-ascii?Q?45A80OUXSHLgjhgrKLqHN70gUDhncBP0tLna/H0R1GoitgG6PEiWrjZ8QrGZ?=
 =?us-ascii?Q?JvEpzfbrlYWBbfMxLMIhPRec/eK1Kl5NVgqmhebNh7RnTcWT2hhe6vZF7GpP?=
 =?us-ascii?Q?I1Aj1vTjBkc2KZ89WAgvYKy6ZXtDtBsLaZdxvfO6ABGla8XttciIzn8NrveM?=
 =?us-ascii?Q?30kKFGlqvRhNg3zB81s6XyXguTN/PQUtHHZTNr2yjEB9Msb15vmLWmJHpdUJ?=
 =?us-ascii?Q?Uhx+2+erqWOT47TU/qzoFLVqFcgFthHNiweZH8vaMPVuYJZ0kJGFL9kuLOlU?=
 =?us-ascii?Q?vpsI1xCpWxKzBfkWQkf4LmnGh9gpUQzjhSz8BfxUys7VwUQHv9TohCE56/KM?=
 =?us-ascii?Q?F4vL5gkeS9g2mNHRpERATfy0zND1pO5hMal7FeqkcjT4Cvj3aYv0FBu+qCRD?=
 =?us-ascii?Q?jFFpM3qU7+1AlW5Coc0fyk4pusMRIgIlqAkvlHzXHsJr0iRVGHPL0vzZru60?=
 =?us-ascii?Q?AKhdvUWDon3lRKlB7gQmbwnP2Y4SDUy5ZWnMYPbtdiBZTW0hPzp01xCLS37q?=
 =?us-ascii?Q?oDtkIVYkkGk+Gpj25qO8pj+kzTrnt9vl6EHXUbV66n7nVBfDMcI9iCW2twJJ?=
 =?us-ascii?Q?dZ0GjjePk0KQtQl4jk9NbNfSN8WjC9MAX8nkNGU0hPHMMA6obya2qm4WRPgS?=
 =?us-ascii?Q?HvncKkNvSqNrO08YlHiwRS9OFoT/GxjWNYO4Ji+EuZzIblDCp9EhPm4B9zOY?=
 =?us-ascii?Q?+p+cQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: oOojlP17Q1Sicj442UMzmU114MPQkLJJt1w4DqmAI/1Q1TPsRAIWVfxv2/XF/3vt+CJ7ObsXBX4JoUa/ElCyx5X2DgiDvITV6wbxdYHKUZGgx4G8is120uyTuGfkpNwLIGCsu+7KMWDaHIqCDZHoICU8J6bzeDIalO31UU833npHZMzYS2WUi3LjMxWfxfbD
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4381;6:qQGZQa7EsMM9l4uaLrKb2B+qitCbq09M27kRbP2S0zywH/hohti9vYOt+hsC2mwpKSLACurTQxkA/B21/9Z/M9Oys9GkvJsDuozbYQhitXKDpd5qZ2SDGJeCf9ZLQ50SnEIzeNToA0gMR3z3DV8izz5PxXm0te4Ln0uYX/HTIZgOtsEab0cEBGQOpr0qgBg/fSwYdpBlV5AuXn4c9aBYi08LyJ/l1CK5kUM8qZLN3jP/glOeOfqJ0r7REb2Mg1yjbnr8rqYlWYvwaFovNa1wMUZnhTI+fx/E1j4OjRubrKMxa184o5RAFE0VD3h6cSHHP8Masxot9kSD2buCiCPrAwLhxd+5+wyP+SmidhvYp0uxRCtG5ozil9nZpDm/bv3H9jC64nXSY2ECPHiaOFFkETamVzrFkxF2svyn0krh4votb3cd7VBhXo+zLbKVJ/IhW7wWgCDsOrGA5UKD66gImw==;5:Xga3SyukxhnCf3RWVoQUZKYa62FGXkJVsbXXcLbXeadB0qnVKV0oUotj7wClEtz/YnFZrOGXEUwBYbj3/U+bfnwRlcoHZY0gpMHoSeq/qBpe3iVClPKCdvwrJ3wU6qmRb963RD1IpxS/mE4XPYnjSbcALXcrIInlptC6/Nr0Xe0=;24:DY1niTohacreNqDjV1Hw3JE+E3Q5ek2ZMNpcvcPCkKJ530+iSKNFILZL3+50K/rK/XKqH/3ovGUhY/7PY2uHGDWqTJCigzmdsAUX9A5nQsA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4381;7:UBWdEj4UOjyHbTslzgLLclidMcaj84Lo0A20bhBuRRGXzRTebL7hb4MW2pypRYOgxMGKh6qbWbMpds7SrwHV/EylcAMkQxCDfR3Gi/ZI9juJXUmxcG11hyWbK+e/jjqGSmTkfNu5uQOAgoeYciKJSAMYaAklFvM+8hmqppXRl/vghtAE4k1YyM2SpGMg5uib2yqJgG/9M2VJ5LDYwsKHn2HWWF2mXfPjE6qmLNEu3RbsWRmA8fpe0Vm9Tc6rGZrU
X-MS-Office365-Filtering-Correlation-Id: 0515d64b-33c3-4627-800c-08d5bb063206
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 08:22:41.9402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0515d64b-33c3-4627-800c-08d5bb063206
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4381
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Following patches of the series introduce ILP32-specific structures and
handlers for signal subsystem. In this patch, functions and structures
that common for LP64 and ILP32 are moved to
arch/arm64/include/asm/signal_common.h to let ILP32 code reuse them. Some
functions work with struct rt_sigframe which differs for ILP32. Therefore,
to let ILP32 generate correct code, body of that functions are moved to
arch/arm64/include/asm/signal_common.h. Others just declared in new header.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/include/asm/signal_common.h | 306 ++++++++++++++++++++++
 arch/arm64/kernel/signal.c             | 336 ++++---------------------
 2 files changed, 359 insertions(+), 283 deletions(-)
 create mode 100644 arch/arm64/include/asm/signal_common.h

diff --git a/arch/arm64/include/asm/signal_common.h b/arch/arm64/include/asm/signal_common.h
new file mode 100644
index 000000000000..84abe973e8b3
--- /dev/null
+++ b/arch/arm64/include/asm/signal_common.h
@@ -0,0 +1,306 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+/*
+ * Copyright (C) 1995-2009 Russell King
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (C) 2018 Cavium Networks.
+ */
+
+#ifndef __ASM_SIGNAL_COMMON_H
+#define __ASM_SIGNAL_COMMON_H
+
+#include <linux/uaccess.h>
+#include <asm/fpsimd.h>
+
+#define EXTRA_CONTEXT_SIZE round_up(sizeof(struct extra_context), 16)
+#define TERMINATOR_SIZE round_up(sizeof(struct _aarch64_ctx), 16)
+#define SIGCONTEXT_RESERVED_SIZE sizeof(((struct sigcontext *)0)->__reserved)
+#define RT_SIGFRAME_RESERVED_OFFSET \
+		offsetof(struct rt_sigframe, uc.uc_mcontext.__reserved)
+
+/*
+ * Sanity limit on the approximate maximum size of signal frame we'll
+ * try to generate.  Stack alignment padding and the frame record are
+ * not taken into account.  This limit is not a guarantee and is
+ * NOT ABI.
+ */
+#define SIGFRAME_MAXSZ SZ_64K
+
+struct rt_sigframe_user_layout {
+	void __user *sigframe;
+	struct frame_record __user *next_frame;
+
+	unsigned long size;	/* size of allocated sigframe data */
+	unsigned long limit;	/* largest allowed size */
+
+	unsigned long fpsimd_offset;
+	unsigned long esr_offset;
+	unsigned long sve_offset;
+	unsigned long extra_offset;
+	unsigned long end_offset;
+};
+
+struct user_ctxs {
+	struct fpsimd_context __user *fpsimd;
+	struct sve_context __user *sve;
+};
+
+struct frame_record {
+	u64 fp;
+	u64 lr;
+};
+
+void __user *apply_user_offset(struct rt_sigframe_user_layout const *user,
+			       unsigned long offset);
+
+int setup_sigframe_layout(struct rt_sigframe_user_layout *user);
+int setup_extra_context(char __user *sfp, unsigned long sf_size,
+			char __user *exprap);
+int __parse_user_sigcontext(struct user_ctxs *user,
+				   struct sigcontext __user const *sc,
+				   void __user const *sigframe_base);
+#define parse_user_sigcontext(user, sf)					\
+	__parse_user_sigcontext(user, &(sf)->uc.uc_mcontext, sf)
+
+int preserve_fpsimd_context(struct fpsimd_context __user *ctx);
+int restore_fpsimd_context(struct fpsimd_context __user *ctx);
+
+#ifdef CONFIG_ARM64_SVE
+int preserve_sve_context(struct sve_context __user *ctx);
+int restore_sve_fpsimd_context(struct user_ctxs *user);
+#else /* ! CONFIG_ARM64_SVE */
+
+/* Turn any non-optimised out attempts to use these into a link error: */
+extern int preserve_sve_context(void __user *ctx);
+extern int restore_sve_fpsimd_context(struct user_ctxs *user);
+
+#endif /* ! CONFIG_ARM64_SVE */
+
+int sigframe_alloc(struct rt_sigframe_user_layout *user,
+		   unsigned long *offset, size_t size);
+int sigframe_alloc_end(struct rt_sigframe_user_layout *user);
+
+void __setup_return(struct pt_regs *regs, struct k_sigaction *ka,
+		    struct rt_sigframe_user_layout *user, int usig);
+
+static void init_user_layout(struct rt_sigframe_user_layout *user)
+{
+	memset(user, 0, sizeof(*user));
+	user->size = RT_SIGFRAME_RESERVED_OFFSET;
+
+	user->limit = user->size + SIGCONTEXT_RESERVED_SIZE;
+
+	user->limit -= TERMINATOR_SIZE;
+	user->limit -= EXTRA_CONTEXT_SIZE;
+	/* Reserve space for extension and terminator ^ */
+}
+
+static size_t sigframe_size(struct rt_sigframe_user_layout const *user)
+{
+	return round_up(max(user->size, sizeof(struct rt_sigframe)), 16);
+}
+
+static int get_sigframe(struct rt_sigframe_user_layout *user,
+			 struct ksignal *ksig, struct pt_regs *regs)
+{
+	unsigned long sp, sp_top;
+	int err;
+
+	init_user_layout(user);
+	err = setup_sigframe_layout(user);
+	if (err)
+		return err;
+
+	sp = sp_top = sigsp(regs->sp, ksig);
+
+	sp = round_down(sp - sizeof(struct frame_record), 16);
+	user->next_frame = (struct frame_record __user *)sp;
+
+	sp = round_down(sp, 16) - sigframe_size(user);
+	user->sigframe = (void __user *)sp;
+
+	/*
+	 * Check that we can actually write to the signal frame.
+	 */
+	if (!access_ok(VERIFY_WRITE, user->sigframe, sp_top - sp))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int restore_sigframe(struct pt_regs *regs,
+			    struct rt_sigframe __user *sf)
+{
+	sigset_t set;
+	int i, err;
+	struct user_ctxs user;
+
+	err = get_sigset(&set, &sf->uc.uc_sigmask);
+	if (err == 0)
+		set_current_blocked(&set);
+
+	for (i = 0; i < 31; i++)
+		__get_user_error(regs->regs[i], &sf->uc.uc_mcontext.regs[i],
+				 err);
+	__get_user_error(regs->sp, &sf->uc.uc_mcontext.sp, err);
+	__get_user_error(regs->pc, &sf->uc.uc_mcontext.pc, err);
+	__get_user_error(regs->pstate, &sf->uc.uc_mcontext.pstate, err);
+
+	/*
+	 * Avoid sys_rt_sigreturn() restarting.
+	 */
+	forget_syscall(regs);
+
+	err |= !valid_user_regs(&regs->user_regs, current);
+	if (err == 0)
+		err = parse_user_sigcontext(&user, sf);
+
+	if (err == 0) {
+		if (!user.fpsimd)
+			return -EINVAL;
+
+		if (user.sve) {
+			if (!system_supports_sve())
+				return -EINVAL;
+
+			err = restore_sve_fpsimd_context(&user);
+		} else {
+			err = restore_fpsimd_context(user.fpsimd);
+		}
+	}
+
+	return err;
+}
+
+static int setup_sigframe(struct rt_sigframe_user_layout *user,
+			  struct pt_regs *regs, sigset_t *set)
+{
+	int i, err = 0;
+	struct rt_sigframe __user *sf = user->sigframe;
+
+	/* set up the stack frame for unwinding */
+	__put_user_error(regs->regs[29], &user->next_frame->fp, err);
+	__put_user_error(regs->regs[30], &user->next_frame->lr, err);
+
+	for (i = 0; i < 31; i++)
+		__put_user_error(regs->regs[i], &sf->uc.uc_mcontext.regs[i],
+				 err);
+	__put_user_error(regs->sp, &sf->uc.uc_mcontext.sp, err);
+	__put_user_error(regs->pc, &sf->uc.uc_mcontext.pc, err);
+	__put_user_error(regs->pstate, &sf->uc.uc_mcontext.pstate, err);
+
+	__put_user_error(current->thread.fault_address,
+			 &sf->uc.uc_mcontext.fault_address, err);
+
+	err |= put_sigset(set, &sf->uc.uc_sigmask);
+
+	if (err == 0) {
+		struct fpsimd_context __user *fpsimd_ctx =
+			apply_user_offset(user, user->fpsimd_offset);
+		err |= preserve_fpsimd_context(fpsimd_ctx);
+	}
+
+	/* fault information, if valid */
+	if (err == 0 && user->esr_offset) {
+		struct esr_context __user *esr_ctx =
+			apply_user_offset(user, user->esr_offset);
+
+		__put_user_error(ESR_MAGIC, &esr_ctx->head.magic, err);
+		__put_user_error(sizeof(*esr_ctx), &esr_ctx->head.size, err);
+		__put_user_error(current->thread.fault_code,
+				 &esr_ctx->esr, err);
+	}
+
+	/* Scalable Vector Extension state, if present */
+	if (system_supports_sve() && err == 0 && user->sve_offset) {
+		struct sve_context __user *sve_ctx =
+			apply_user_offset(user, user->sve_offset);
+		err |= preserve_sve_context(sve_ctx);
+	}
+
+	if (err == 0 && user->extra_offset)
+		setup_extra_context((char __user *)user->sigframe, user->size,
+				    (char __user *)apply_user_offset(user,
+						   user->extra_offset));
+
+	/* set the "end" magic */
+	if (err == 0) {
+		struct _aarch64_ctx __user *end =
+			apply_user_offset(user, user->end_offset);
+
+		__put_user_error(0, &end->magic, err);
+		__put_user_error(0, &end->size, err);
+	}
+
+	return err;
+}
+
+static long __sys_rt_sigreturn(struct pt_regs *regs)
+{
+	struct rt_sigframe __user *frame;
+
+	/* Always make any pending restarted system calls return -EINTR */
+	current->restart_block.fn = do_no_restart_syscall;
+
+	/*
+	 * Since we stacked the signal on a 128-bit boundary, then 'sp' should
+	 * be word aligned here.
+	 */
+	if (regs->sp & 15)
+		goto badframe;
+
+	frame = (struct rt_sigframe __user *)regs->sp;
+
+	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
+		goto badframe;
+
+	if (restore_sigframe(regs, frame))
+		goto badframe;
+
+	if (restore_altstack(&frame->uc.uc_stack))
+		goto badframe;
+
+	return regs->regs[0];
+
+badframe:
+	if (show_unhandled_signals)
+		pr_info_ratelimited("%s[%d]: bad frame in %s: pc=%08llx sp=%08llx\n",
+				    current->comm, task_pid_nr(current), __func__,
+				    regs->pc, regs->sp);
+	force_sig(SIGSEGV, current);
+	return 0;
+}
+
+static int __setup_rt_frame(int usig, struct ksignal *ksig,
+				sigset_t *set, struct pt_regs *regs)
+{
+	struct rt_sigframe_user_layout user;
+	struct rt_sigframe __user *frame;
+	int err = 0;
+
+	fpsimd_signal_preserve_current_state();
+
+	if (get_sigframe(&user, ksig, regs))
+		return 1;
+
+	frame = user.sigframe;
+
+	__put_user_error(0, &frame->uc.uc_flags, err);
+	__put_user_error((typeof(frame->uc.uc_link)) 0,
+			  &frame->uc.uc_link, err);
+
+	err |= __save_altstack(&frame->uc.uc_stack, regs->sp);
+	err |= setup_sigframe(&user, regs, set);
+	if (err == 0) {
+		setup_return(regs, &ksig->ka, &user, usig);
+		if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
+			err |= copy_siginfo_to_user(&frame->info, &ksig->info);
+			regs->regs[1] = (unsigned long)&frame->info;
+			regs->regs[2] = (unsigned long)&frame->uc;
+		}
+	}
+
+	return err;
+}
+
+#endif /* __ASM_SIGNAL_COMMON_H */
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 0a829f6f1832..c1a2523bac02 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -41,6 +41,10 @@
 #include <asm/ptrace.h>
 #include <asm/signal32.h>
 #include <asm/vdso.h>
+#include <asm/signal_ilp32.h>
+
+#define get_sigset(s, m) __copy_from_user(s, m, sizeof(*s))
+#define put_sigset(s, m) __copy_to_user(m, s, sizeof(*s))
 
 /*
  * Do a signal return; undo the signal stack. These are aligned to 128-bit.
@@ -49,57 +53,12 @@ struct rt_sigframe {
 	struct siginfo info;
 	struct ucontext uc;
 };
+struct rt_sigframe_user_layout;
 
-struct frame_record {
-	u64 fp;
-	u64 lr;
-};
-
-struct rt_sigframe_user_layout {
-	struct rt_sigframe __user *sigframe;
-	struct frame_record __user *next_frame;
-
-	unsigned long size;	/* size of allocated sigframe data */
-	unsigned long limit;	/* largest allowed size */
-
-	unsigned long fpsimd_offset;
-	unsigned long esr_offset;
-	unsigned long sve_offset;
-	unsigned long extra_offset;
-	unsigned long end_offset;
-};
-
-#define BASE_SIGFRAME_SIZE round_up(sizeof(struct rt_sigframe), 16)
-#define TERMINATOR_SIZE round_up(sizeof(struct _aarch64_ctx), 16)
-#define EXTRA_CONTEXT_SIZE round_up(sizeof(struct extra_context), 16)
-
-static void init_user_layout(struct rt_sigframe_user_layout *user)
-{
-	const size_t reserved_size =
-		sizeof(user->sigframe->uc.uc_mcontext.__reserved);
-
-	memset(user, 0, sizeof(*user));
-	user->size = offsetof(struct rt_sigframe, uc.uc_mcontext.__reserved);
-
-	user->limit = user->size + reserved_size;
-
-	user->limit -= TERMINATOR_SIZE;
-	user->limit -= EXTRA_CONTEXT_SIZE;
-	/* Reserve space for extension and terminator ^ */
-}
-
-static size_t sigframe_size(struct rt_sigframe_user_layout const *user)
-{
-	return round_up(max(user->size, sizeof(struct rt_sigframe)), 16);
-}
+static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
+			 struct rt_sigframe_user_layout *user, int usig);
 
-/*
- * Sanity limit on the approximate maximum size of signal frame we'll
- * try to generate.  Stack alignment padding and the frame record are
- * not taken into account.  This limit is not a guarantee and is
- * NOT ABI.
- */
-#define SIGFRAME_MAXSZ SZ_64K
+#include <asm/signal_common.h>
 
 static int __sigframe_alloc(struct rt_sigframe_user_layout *user,
 			    unsigned long *offset, size_t size, bool extend)
@@ -144,14 +103,14 @@ static int __sigframe_alloc(struct rt_sigframe_user_layout *user,
  * signal frame.  The offset from the signal frame base address to the
  * allocated block is assigned to *offset.
  */
-static int sigframe_alloc(struct rt_sigframe_user_layout *user,
+int sigframe_alloc(struct rt_sigframe_user_layout *user,
 			  unsigned long *offset, size_t size)
 {
 	return __sigframe_alloc(user, offset, size, true);
 }
 
 /* Allocate the null terminator record and prevent further allocations */
-static int sigframe_alloc_end(struct rt_sigframe_user_layout *user)
+int sigframe_alloc_end(struct rt_sigframe_user_layout *user)
 {
 	int ret;
 
@@ -168,7 +127,7 @@ static int sigframe_alloc_end(struct rt_sigframe_user_layout *user)
 	return 0;
 }
 
-static void __user *apply_user_offset(
+void __user *apply_user_offset(
 	struct rt_sigframe_user_layout const *user, unsigned long offset)
 {
 	char __user *base = (char __user *)user->sigframe;
@@ -176,7 +135,7 @@ static void __user *apply_user_offset(
 	return base + offset;
 }
 
-static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
+int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 {
 	struct user_fpsimd_state const *fpsimd =
 		&current->thread.fpsimd_state.user_fpsimd;
@@ -194,7 +153,7 @@ static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 	return err ? -EFAULT : 0;
 }
 
-static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
+int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 {
 	struct user_fpsimd_state fpsimd;
 	__u32 magic, size;
@@ -223,15 +182,9 @@ static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 	return err ? -EFAULT : 0;
 }
 
-
-struct user_ctxs {
-	struct fpsimd_context __user *fpsimd;
-	struct sve_context __user *sve;
-};
-
 #ifdef CONFIG_ARM64_SVE
 
-static int preserve_sve_context(struct sve_context __user *ctx)
+int preserve_sve_context(struct sve_context __user *ctx)
 {
 	int err = 0;
 	u16 reserved[ARRAY_SIZE(ctx->__reserved)];
@@ -263,7 +216,7 @@ static int preserve_sve_context(struct sve_context __user *ctx)
 	return err ? -EFAULT : 0;
 }
 
-static int restore_sve_fpsimd_context(struct user_ctxs *user)
+int restore_sve_fpsimd_context(struct user_ctxs *user)
 {
 	int err;
 	unsigned int vq;
@@ -326,15 +279,9 @@ static int restore_sve_fpsimd_context(struct user_ctxs *user)
 	return err ? -EFAULT : 0;
 }
 
-#else /* ! CONFIG_ARM64_SVE */
-
-/* Turn any non-optimised out attempts to use these into a link error: */
-extern int preserve_sve_context(void __user *ctx);
-extern int restore_sve_fpsimd_context(struct user_ctxs *user);
-
 #endif /* ! CONFIG_ARM64_SVE */
 
-static int __parse_user_sigcontext(struct user_ctxs *user,
+int __parse_user_sigcontext(struct user_ctxs *user,
 				   struct sigcontext __user const *sc,
 				   void __user const *sigframe_base)
 {
@@ -492,91 +439,13 @@ static int __parse_user_sigcontext(struct user_ctxs *user,
 	return -EINVAL;
 }
 
-#define parse_user_sigcontext(user, sf)					\
-	__parse_user_sigcontext(user, &(sf)->uc.uc_mcontext, sf)
-
-static int restore_sigframe(struct pt_regs *regs,
-			    struct rt_sigframe __user *sf)
-{
-	sigset_t set;
-	int i, err;
-	struct user_ctxs user;
-
-	err = __copy_from_user(&set, &sf->uc.uc_sigmask, sizeof(set));
-	if (err == 0)
-		set_current_blocked(&set);
-
-	for (i = 0; i < 31; i++)
-		__get_user_error(regs->regs[i], &sf->uc.uc_mcontext.regs[i],
-				 err);
-	__get_user_error(regs->sp, &sf->uc.uc_mcontext.sp, err);
-	__get_user_error(regs->pc, &sf->uc.uc_mcontext.pc, err);
-	__get_user_error(regs->pstate, &sf->uc.uc_mcontext.pstate, err);
-
-	/*
-	 * Avoid sys_rt_sigreturn() restarting.
-	 */
-	forget_syscall(regs);
-
-	err |= !valid_user_regs(&regs->user_regs, current);
-	if (err == 0)
-		err = parse_user_sigcontext(&user, sf);
-
-	if (err == 0) {
-		if (!user.fpsimd)
-			return -EINVAL;
-
-		if (user.sve) {
-			if (!system_supports_sve())
-				return -EINVAL;
-
-			err = restore_sve_fpsimd_context(&user);
-		} else {
-			err = restore_fpsimd_context(user.fpsimd);
-		}
-	}
-
-	return err;
-}
-
 asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
 {
-	struct rt_sigframe __user *frame;
-
-	/* Always make any pending restarted system calls return -EINTR */
-	current->restart_block.fn = do_no_restart_syscall;
-
-	/*
-	 * Since we stacked the signal on a 128-bit boundary, then 'sp' should
-	 * be word aligned here.
-	 */
-	if (regs->sp & 15)
-		goto badframe;
-
-	frame = (struct rt_sigframe __user *)regs->sp;
-
-	if (!access_ok(VERIFY_READ, frame, sizeof (*frame)))
-		goto badframe;
-
-	if (restore_sigframe(regs, frame))
-		goto badframe;
-
-	if (restore_altstack(&frame->uc.uc_stack))
-		goto badframe;
-
-	return regs->regs[0];
-
-badframe:
-	if (show_unhandled_signals)
-		pr_info_ratelimited("%s[%d]: bad frame in %s: pc=%08llx sp=%08llx\n",
-				    current->comm, task_pid_nr(current), __func__,
-				    regs->pc, regs->sp);
-	force_sig(SIGSEGV, current);
-	return 0;
+	return __sys_rt_sigreturn(regs);
 }
 
 /* Determine the layout of optional records in the signal frame */
-static int setup_sigframe_layout(struct rt_sigframe_user_layout *user)
+int setup_sigframe_layout(struct rt_sigframe_user_layout *user)
 {
 	int err;
 
@@ -608,123 +477,50 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user)
 	return sigframe_alloc_end(user);
 }
 
-
-static int setup_sigframe(struct rt_sigframe_user_layout *user,
-			  struct pt_regs *regs, sigset_t *set)
+int setup_extra_context(char __user *sfp, unsigned long sf_size,
+			char __user *extrap)
 {
-	int i, err = 0;
-	struct rt_sigframe __user *sf = user->sigframe;
-
-	/* set up the stack frame for unwinding */
-	__put_user_error(regs->regs[29], &user->next_frame->fp, err);
-	__put_user_error(regs->regs[30], &user->next_frame->lr, err);
-
-	for (i = 0; i < 31; i++)
-		__put_user_error(regs->regs[i], &sf->uc.uc_mcontext.regs[i],
-				 err);
-	__put_user_error(regs->sp, &sf->uc.uc_mcontext.sp, err);
-	__put_user_error(regs->pc, &sf->uc.uc_mcontext.pc, err);
-	__put_user_error(regs->pstate, &sf->uc.uc_mcontext.pstate, err);
-
-	__put_user_error(current->thread.fault_address, &sf->uc.uc_mcontext.fault_address, err);
-
-	err |= __copy_to_user(&sf->uc.uc_sigmask, set, sizeof(*set));
-
-	if (err == 0) {
-		struct fpsimd_context __user *fpsimd_ctx =
-			apply_user_offset(user, user->fpsimd_offset);
-		err |= preserve_fpsimd_context(fpsimd_ctx);
-	}
-
-	/* fault information, if valid */
-	if (err == 0 && user->esr_offset) {
-		struct esr_context __user *esr_ctx =
-			apply_user_offset(user, user->esr_offset);
-
-		__put_user_error(ESR_MAGIC, &esr_ctx->head.magic, err);
-		__put_user_error(sizeof(*esr_ctx), &esr_ctx->head.size, err);
-		__put_user_error(current->thread.fault_code, &esr_ctx->esr, err);
-	}
-
-	/* Scalable Vector Extension state, if present */
-	if (system_supports_sve() && err == 0 && user->sve_offset) {
-		struct sve_context __user *sve_ctx =
-			apply_user_offset(user, user->sve_offset);
-		err |= preserve_sve_context(sve_ctx);
-	}
-
-	if (err == 0 && user->extra_offset) {
-		char __user *sfp = (char __user *)user->sigframe;
-		char __user *userp =
-			apply_user_offset(user, user->extra_offset);
-
-		struct extra_context __user *extra;
-		struct _aarch64_ctx __user *end;
-		u64 extra_datap;
-		u32 extra_size;
-
-		extra = (struct extra_context __user *)userp;
-		userp += EXTRA_CONTEXT_SIZE;
-
-		end = (struct _aarch64_ctx __user *)userp;
-		userp += TERMINATOR_SIZE;
+	int err = 0;
+	struct extra_context __user *extra;
+	struct _aarch64_ctx __user *end;
+	u64 extra_datap;
+	u32 extra_size;
 
-		/*
-		 * extra_datap is just written to the signal frame.
-		 * The value gets cast back to a void __user *
-		 * during sigreturn.
-		 */
-		extra_datap = (__force u64)userp;
-		extra_size = sfp + round_up(user->size, 16) - userp;
+	extra = (struct extra_context __user *)extrap;
+	extrap += EXTRA_CONTEXT_SIZE;
 
-		__put_user_error(EXTRA_MAGIC, &extra->head.magic, err);
-		__put_user_error(EXTRA_CONTEXT_SIZE, &extra->head.size, err);
-		__put_user_error(extra_datap, &extra->datap, err);
-		__put_user_error(extra_size, &extra->size, err);
+	end = (struct _aarch64_ctx __user *)extrap;
+	extrap += TERMINATOR_SIZE;
 
-		/* Add the terminator */
-		__put_user_error(0, &end->magic, err);
-		__put_user_error(0, &end->size, err);
-	}
+	/*
+	 * extra_datap is just written to the signal frame.
+	 * The value gets cast back to a void __user *
+	 * during sigreturn.
+	 */
+	extra_datap = (__force u64)extrap;
+	extra_size = sfp + round_up(sf_size, 16) - extrap;
 
-	/* set the "end" magic */
-	if (err == 0) {
-		struct _aarch64_ctx __user *end =
-			apply_user_offset(user, user->end_offset);
+	__put_user_error(EXTRA_MAGIC, &extra->head.magic, err);
+	__put_user_error(EXTRA_CONTEXT_SIZE, &extra->head.size, err);
+	__put_user_error(extra_datap, &extra->datap, err);
+	__put_user_error(extra_size, &extra->size, err);
 
-		__put_user_error(0, &end->magic, err);
-		__put_user_error(0, &end->size, err);
-	}
+	/* Add the terminator */
+	__put_user_error(0, &end->magic, err);
+	__put_user_error(0, &end->size, err);
 
 	return err;
 }
 
-static int get_sigframe(struct rt_sigframe_user_layout *user,
-			 struct ksignal *ksig, struct pt_regs *regs)
+void __setup_return(struct pt_regs *regs, struct k_sigaction *ka,
+		struct rt_sigframe_user_layout *user, int usig)
 {
-	unsigned long sp, sp_top;
-	int err;
-
-	init_user_layout(user);
-	err = setup_sigframe_layout(user);
-	if (err)
-		return err;
-
-	sp = sp_top = sigsp(regs->sp, ksig);
-
-	sp = round_down(sp - sizeof(struct frame_record), 16);
-	user->next_frame = (struct frame_record __user *)sp;
 
-	sp = round_down(sp, 16) - sigframe_size(user);
-	user->sigframe = (struct rt_sigframe __user *)sp;
-
-	/*
-	 * Check that we can actually write to the signal frame.
-	 */
-	if (!access_ok(VERIFY_WRITE, user->sigframe, sp_top - sp))
-		return -EFAULT;
+	regs->regs[0] = usig;
+	regs->sp = (unsigned long)user->sigframe;
+	regs->regs[29] = (unsigned long)&user->next_frame->fp;
+	regs->pc = (unsigned long)ka->sa.sa_handler;
 
-	return 0;
 }
 
 static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
@@ -732,10 +528,7 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 {
 	__sigrestore_t sigtramp;
 
-	regs->regs[0] = usig;
-	regs->sp = (unsigned long)user->sigframe;
-	regs->regs[29] = (unsigned long)&user->next_frame->fp;
-	regs->pc = (unsigned long)ka->sa.sa_handler;
+	__setup_return(regs, ka, user, usig);
 
 	if (ka->sa.sa_flags & SA_RESTORER)
 		sigtramp = ka->sa.sa_restorer;
@@ -748,32 +541,7 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
 			  struct pt_regs *regs)
 {
-	struct rt_sigframe_user_layout user;
-	struct rt_sigframe __user *frame;
-	int err = 0;
-
-	fpsimd_signal_preserve_current_state();
-
-	if (get_sigframe(&user, ksig, regs))
-		return 1;
-
-	frame = user.sigframe;
-
-	__put_user_error(0, &frame->uc.uc_flags, err);
-	__put_user_error(NULL, &frame->uc.uc_link, err);
-
-	err |= __save_altstack(&frame->uc.uc_stack, regs->sp);
-	err |= setup_sigframe(&user, regs, set);
-	if (err == 0) {
-		setup_return(regs, &ksig->ka, &user, usig);
-		if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
-			err |= copy_siginfo_to_user(&frame->info, &ksig->info);
-			regs->regs[1] = (unsigned long)&frame->info;
-			regs->regs[2] = (unsigned long)&frame->uc;
-		}
-	}
-
-	return err;
+	return __setup_rt_frame(usig, ksig, set, regs);
 }
 
 static void setup_restart_syscall(struct pt_regs *regs)
@@ -802,6 +570,8 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 			ret = a32_setup_rt_frame(usig, ksig, oldset, regs);
 		else
 			ret = a32_setup_frame(usig, ksig, oldset, regs);
+	} else if (is_ilp32_compat_task()) {
+		ret = ilp32_setup_rt_frame(usig, ksig, oldset, regs);
 	} else {
 		ret = setup_rt_frame(usig, ksig, oldset, regs);
 	}
-- 
2.17.0

