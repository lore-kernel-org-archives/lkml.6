Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4134569-1526458870-2-14622691029862668486
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES roen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526458870; b=np/CQqT/4Mas7B/firXHeYAJp1EkXhUIHTg1h9ba82lveaCKM6
    pqincWORwbFfoi3KLegQANs/Q9YcrATYjbq0mNO7plP9O7LDaFjZdshm+jBMfIvv
    8vrls7e0YDeUrTDWPzlljrhh2hruXhowGev6+BPhjLgnpNFQ7I+mssINle1WnjsT
    OblYZGriFQnyVU2cUNmZ2FmsccYuqS+LlGoUFYY1YEBgDhhn8wkIwpJl8nZrMPli
    s/cwUl36WVbbZcSqkWVYEFN/hN4wM/TQAcG8n65IkFTn1w3BwbaAvaxamJ6uCPpx
    7OBUlP9WSXCmf/WJ7dIAT4xu86x+NKAixh3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526458870; bh=EcRYoso1M85Bk2b3wTJRrEpV0HgcPr
    ri0ZtSjn4XXtg=; b=bJNx2BgVyll1UVQiZNJMiWRzgEI4yfxJAg93KHKIYaRvPK
    0v85QR5KKG3jrkpN7kVbHLpDBFlJiIasBIXORl+K7moMPf4wrW67FNEFWmd7gBHZ
    tzL4X36Y+XDDmBwTQZV4/HMTZFBnxvxjPm8bLUNw6B++ZDE+fWwtWsBgGjdtpHnb
    +DFMi2zhyrnIbNKbbPfMSI5FwS/MuAB1kd2Cr2MjtGg6h9TPflN8tHJQYIhhhvxy
    krDON4ADeDQeU4b4AEyvqjyMu0ma+zg0WG18H4RPVrKORoO3oR3SvXFBUtuGu5sz
    IuQC7FM2jHeBYuV2cOI5ZLvEpIYapJorH33DnNGA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=caviumnetworks.onmicrosoft.com
    header.i=@caviumnetworks.onmicrosoft.com header.b=N14R3csl x-bits=1024
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=caviumnetworks.onmicrosoft.com
      header.i=@caviumnetworks.onmicrosoft.com header.b=N14R3csl x-bits=1024
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
X-CM-Envelope: MS4wfOaX8LlvAEtVk7mvYdMSrxfS5WeUUgxJBc3EqkgBgAjhzv8KwbC38fsENpclAFizaj5HbXEd0D+VjJMRfl4Nn3pJT7V+yvlqsqNNyB1RagFikea1DPMc
    lo5dwrRty65FkSAIF+9mVtmmAyXYMVOknHwSZCApbuHfzE3CpXnPXgoZOuM3qLGGTXRBbuKri6mkgFWYLocD673h4g+DdfRuyEiJ2j8JWYMKwIZbLavEy7ej
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=sFUR1tI3dlkA:10 a=P23N9hKgfBoA:10 a=SnKtspMOcyoA:10 a=VUJBJC2UJ8kA:10
    a=ifRc6kEuNzAA:10 a=enOvQawGAAAA:8 a=VwQbUJbxAAAA:8 a=7A9Azwg05-im4g7_TEkA:9
    a=x8gzFH9gYPwA:10 a=OuzhcWw_GC9nAYdNdRwA:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752831AbeEPIUx (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 04:20:53 -0400
Received: from mail-dm3nam03on0073.outbound.protection.outlook.com ([104.47.41.73]:35872
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751904AbeEPIUs (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 May 2018 04:20:48 -0400
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
Subject: [PATCH 06/24] thread: move thread bits accessors to separated file
Date: Wed, 16 May 2018 11:18:51 +0300
Message-Id: <20180516081910.10067-7-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [176.59.36.13]
X-ClientProxiedBy: VI1PR08CA0116.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::18) To BYAPR07MB4376.namprd07.prod.outlook.com
 (2603:10b6:a02:c0::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4376;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4376;3:MRdyN7uWHM+UfBRjGgFI4bkbFabFzadpv8GMFcGEVJtwmVQZPPO3Entv+ZwtScX5PO4bmgXZkgJZLaZyVpdv0PKQsjOS2hixNaa+9/IOIPLwOcMJbxrVQ7ELRYSmcP64cumppYKhxdawkwZeHBQ2TAla8x9ct0cHgLzLNRwC+VEPmlYTdCyjZwrlEmKOmsyMnZJ3VB5duVVMqI8aH+71P/8xGQvKeP++Sy0pyaig8ghYlX69JrBnjWVOb5mPfMe2;25:oQMTthZn7PyT2zVbF/+OfGQVjgZMQ+EihQpVXrm9J7kq3COA/AEMgCWCJwlgxxu/hnt3Klhh6Fmpu5HTSapDDpfKwVoITRMr7BzYXnU6wGtauRlSvYikMrsijuQMoVvz76XJrtdIEs7sZr7WjP7sStyD0sTs3ZJ0lMfgpcANTBUkoWWZFe3zjdQ31NV3ZbXCGHgY7wfHLK6DPaTf3PPutJCLFz3QlbtYLMIBXSexNJ4rU0JVc/TlQEa5g71wM8f6bFIe8uOjMUB4y7ketdOX3d8bXBwUr+ilpsB+kX1RjyRsU/yNAiOuXpa5tzhYl2+dt4n94Yb2J5a41Qhgo4QE0A==;31:x6puukXLwKzVGNaHNCW57M9lBxwagm9LPk1HqYyadzigqCXkjCi4cZ5afaHq3g4grAO1aUCrM7aQcA9UvUvFJ9hp98DJquBJl0Nmo0u1eufNF1BPqIijmMkADzHGdgdI57tPJwLInffazYcizn/9m3PQYAJBTtVVhxsXaas6UIX13HIZ5ZbkYVrHdEQyJGbQji052WvtyYclo44J9naiKBcgF2pxmmfvvfgOm3pp3u4=
X-MS-TrafficTypeDiagnostic: BYAPR07MB4376:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4376;20:Jyapb+w38GqL5fQQcvZB4AD2u7qH0/pMmjq26AdIyYJVEY/VNRX11bDDYHG0hhWBY4lYNO2weO1qjOURrGtZZwYtin3UxhZ4BEAl9eux9257aN2pAajM8ImYwYHlchKKmSvoMuitW92VTHhv+2HRa7nhgwtZ11tfWWeHNBSXyG9ztaWy6UMU9RJZmXrsPMvvJKrlaYqao9WlkwORKL6D2caew7m/g5XjWUHFSnO+1UfGZYHHEzs5YexTRqgX8s5k/gfDbVpSclBqWB1cmwhmoeXE956w7X3U28JoUzpy+AhhduwwFR35JB5vdlizUnKBsbTEaWCpw6WoCEHJdw/IQC8CedErL1ogf/T08DUkzpBeYxX9ZTUQoGPSipsgLrF13WUqjdbvjCXQCMSj8GRFdEY1A5Nho7esDCFsX30JOxTBj2Fvv0ZU62EqMh7T1PD7c5i14EHs4a4QREEHBXNuH/IJnkFOU8aKgCl1nys8yEzyA7q/GRwMBDpnsUCX0aYn3mJJHrpX/UHjenz2dAddn8aTBzsNxz9NEv9Rx77AJbG9Y5ADWHuuPgt/9q7u8sQ8wJVAi7s3Kz0/Xhs59vPDaqy2UJfu+AjHOAlBC9Sz9PE=;4:VruydIPwbryDqoZKZKx/capTmkj1DZIbbOaIiPihQ/aaE0pQoAjM8+UjgN1jh7YAypwStnbQVU0++bloYt5WCgqeMkVupTeMTzNlVZV+J1vKwjx4PsZIKSiyKKkiYgzN1QwUowGlMNnK5xbXhTZwB40UGZXaceK6s3jdfI4/oIcpffo+J+RZxlbo6qma28U1cYs8RIz7FHqzP199KEbZjG1qiEQQkJnfxjJgK5ihwisrP+FOr7TGNFrPbIZJtzj46TMYx4qf8UWF6IyTEW+rtw==
X-Microsoft-Antispam-PRVS: <BYAPR07MB4376A3385E3EC0994524EBCDE3920@BYAPR07MB4376.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BYAPR07MB4376;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4376;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(346002)(366004)(39850400004)(39380400002)(396003)(189003)(199004)(39060400002)(42882007)(59450400001)(6486002)(53936002)(6666003)(4326008)(51416003)(386003)(76176011)(52116002)(446003)(6496006)(50226002)(16586007)(305945005)(7736002)(72206003)(2616005)(26005)(316002)(478600001)(11346002)(36756003)(956004)(105586002)(186003)(16526019)(97736004)(2906002)(486006)(5660300001)(106356001)(8936002)(476003)(76506005)(50466002)(48376002)(110136005)(47776003)(66066001)(25786009)(54906003)(7416002)(3846002)(81166006)(7406005)(1076002)(68736007)(81156014)(8676002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4376;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4376;23:Y+Ae4WdwiUNuLk5kSCCeJLi42tPcYEcxyw+1sxSjP?=
 =?us-ascii?Q?yIvvjPUTRD3ifZVgk88omwtU2H+dInxjzeisT6/o+ew1Cvlv11aJvnAyeV0E?=
 =?us-ascii?Q?HzbrpJkgjkODoWg6Okb7yYe18Xnm6LZp+rcxD4OeXHYHRORySbphql0tg0Vp?=
 =?us-ascii?Q?chC1MWbO7JY2tgs8RTfHnpMbJufx2MQ5Re4psKYKHUN6b0xrtfk1FmJFotZz?=
 =?us-ascii?Q?P6n9MZSt90YrJVL11EU5z+UNxKZjk3UAu467dJ7ry3ES7G/eBTEJutjS8EjC?=
 =?us-ascii?Q?rFd1FD+yCGT9eMyIChyR76TyLn34QEkBJbV0lmGcJ5J78ZBWwn8tjzhWySe4?=
 =?us-ascii?Q?OSAAnz8wy9WVvDkvA3daH8TaRTF1JaVWxPJ0F/lrkv2SksKu7Ztxd9CspgTe?=
 =?us-ascii?Q?+nb2rmzQH0XEk1c7YumlPXzR0iFI4Z+R14IVRi1MVE7VAQxpR7DFvrPlTeMF?=
 =?us-ascii?Q?xoi2iyMl0mDFBB39wtTEJwtRbNyQZIBKt8/Bkc/gywWG2pFMx2QHW9KedidS?=
 =?us-ascii?Q?sxmIfVw4i8ISngm2vGAtPO9bTpGwLIoBBoC7ScAHFxmdMemrOmfBXi+ntfn1?=
 =?us-ascii?Q?/5UbwgX/PcQvVSJacfRoZ+LqaVEacEneAfsyISjmCOZXcP1+OniQWTAnDSTC?=
 =?us-ascii?Q?nYRIkM8Fm6sa91JOAasae3U8knE88ZEz6NeMDEtWS3QRxnguujwamfWAWoh0?=
 =?us-ascii?Q?fEgtX6mX7f0qfesKOsCzftWne+KkcOEVrqY3BCDB9Ih1qDPtAvNosAsiRUK+?=
 =?us-ascii?Q?XoY9lFQI5an2VmH1HIUKq8O+zQ38zGvVApp8dG57tKENigNbJKKszdN82rJb?=
 =?us-ascii?Q?6NQeJMPkPqPVa7GAsm6d4He9AZCXD/24uGDhZeJ5VzaPRoS+yjeTUPr+viUl?=
 =?us-ascii?Q?/mg7PCqVOmtX2BcOW16rw62vQJySUwt/QkgyepEr+2wjsswxgCYVtmPurduZ?=
 =?us-ascii?Q?y88IA3W/p5BxoKgmZ7D9V4bSgAAYyuIgG/p9o3tMSXdoM0cwWnE/dn9vk5Z9?=
 =?us-ascii?Q?UmxboOktxzWvI8/tXduGqqfKDgQ7skyvwF7/bfiRWjr77SqJvdBrHe2xZKKe?=
 =?us-ascii?Q?3/t7N9ch3JTls220/xwk3LEyQ9m6wwNc19VnNNYuYhnv2tBeRpioAzurFUEP?=
 =?us-ascii?Q?zJdNoe/+XWQsRH9w5JFmj9jVFIGLJq1L5BcqBxJSoWX+k38i39MAAjZtnP6j?=
 =?us-ascii?Q?38gDLWtwZ1/5+zLYy1nZHRt+ctcarjSr45gvzAsxizx1lsAmd/URTwU7DKSn?=
 =?us-ascii?Q?OVbeIcmYzhjvmEMEEomNLLf2cIPB11TeTAGtACxcRpq5PmqhScMDVFhou5NI?=
 =?us-ascii?Q?Avip5QPqr/3ic/Wrpx2prtWgKKtu15HFc8PNS4Sm664eA/POOd2KysRTNIeT?=
 =?us-ascii?Q?aAL4g=3D=3D?=
X-Microsoft-Antispam-Message-Info: Lj7tFqPXMjvk/Xhznz05JLuIxaiVbrri/ar2SyIsZ2zXaJ4PCXYDaWFw8lzsRLlPNY2yjsyMm/eAxE0HQ3felnI6T0Nx8y71RDUe//3DFsSaUtZN7W+2qGhZY40CRk8Qs4ChUuz4Pq2uhcCv0VTDWvGzjwkFPV/AkhyHY2qxLyDq+eK62MavcV5F+rz0qlAl
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4376;6:PISO3ImZ8UDCM/XOiYCEoK0xSzQ3VA3jHxRATvaAwO77muDdtXxB15PKneKpZ3NFpefF42xGRy8/cRyhXFTU0kzeKTEWAboRSAF1LDZWUtHlS3SV5os4n97DtgoBHVyL+Lsx5a/+NbQRcbQyNHx7PGyVF496r+FdqQ7jwNfYdcH+6XwomkS6DtiL3NgHrcMUDue5wcbw+xh1pbJQ8eQZYP7+EZtjFWMo4esMqKAi3R1Jo+tNWjan0WyQO27hQGvXZXYJb5z3ewE94gQbsRvA2vjWCRhXu+E0TzZ6dTclC0HdchmSqgGniwwwIcj29oWeYI9Z4EkUKNaAChEupHCBh27j/2ssRHLLXU3Pd5+mE59dZcznKJ+gJpbga0DhVnCK/Th18Mgy+qPwxapo/dGUv1Hpxi+idqae4B1trtCBidqaU0eWzamUzLauP4qgNpL95CFnBX0hCkbvekwmIBPqjA==;5:C1ygaMtIBhrziOKDT0IbPiKB9+0E/gdyAiqf99xa8tcZrvYZ7RHzgusRQcwylyb2LZDRpuPaQfz/Hs7ATMp9E72yF9gPF2I3PPgtZXekwxzUPKnk4/Dj+ZBfDG6JN7FQhVd7QJn2Y9bmKY8j6qLDgw1Uugta3/6dkPwVCcPK7jM=;24:dbSghtACev4FMqfs/8gsvPj02qBOxLWr+spsUZtyi7AulTbwn+TDQXorH89SNJqcJfGtRHMoeCPHYkD5kMqkx7y6hQiy7vaKLfo14Hea6YM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4376;7:aNQ4cMrveyW+sm2xFAlkH1qdxRtAAeiRcmU3mdsEOH+VjrSLM6H/UBbfYAdUSOGP2w4EK1Zy27bG9hoS+E3Vnrtu+CkOFIE9Z3AURKaC+85jOyiucP6WztbEIliQB8N9jMXgJeLbNttTaJk2g1YEaEImtbuynILBr5HOBTuSOJBQUnWJ2GNMoG19oYQQxmSuIzhXAtaqU+9MjSFwb6oGz28FvAt2JnV3tKG5E81/7sh1FALBByAadIitgR6d+ROo
X-MS-Office365-Filtering-Correlation-Id: a06266f0-582f-414b-5ca8-08d5bb05eb84
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 08:20:43.5375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a06266f0-582f-414b-5ca8-08d5bb05eb84
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4376
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thread bits may be accessed from low-level code, so isolating is a measure
to avoid circular dependencies in header files.

The exact reason for circular dependency is WARN_ON() macro added in patch
edd63a27 "set_restore_sigmask() is never called without SIGPENDING (and
never should be)"

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 include/linux/sched.h       |  1 +
 include/linux/thread_bits.h | 76 +++++++++++++++++++++++++++++++++++++
 include/linux/thread_info.h | 64 +------------------------------
 3 files changed, 78 insertions(+), 63 deletions(-)
 create mode 100644 include/linux/thread_bits.h

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b161ef8a902e..c1bddf06baed 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -27,6 +27,7 @@
 #include <linux/signal_types.h>
 #include <linux/mm_types_task.h>
 #include <linux/task_io_accounting.h>
+#include <linux/thread_bits.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
diff --git a/include/linux/thread_bits.h b/include/linux/thread_bits.h
new file mode 100644
index 000000000000..7512f8527e9a
--- /dev/null
+++ b/include/linux/thread_bits.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+/* Common low-level thread bits accessors */
+
+#ifndef _LINUX_THREAD_BITS_H
+#define _LINUX_THREAD_BITS_H
+
+#ifndef __ASSEMBLY__
+
+/*
+ * For per-arch arch_within_stack_frames() implementations, defined in
+ * asm/thread_info.h.
+ */
+enum {
+	BAD_STACK = -1,
+	NOT_STACK = 0,
+	GOOD_FRAME,
+	GOOD_STACK,
+};
+
+#include <linux/bitops.h>
+#include <asm/thread_info.h>
+
+#ifdef CONFIG_THREAD_INFO_IN_TASK
+/*
+ * For CONFIG_THREAD_INFO_IN_TASK kernels we need <asm/current.h> for the
+ * definition of current, but for !CONFIG_THREAD_INFO_IN_TASK kernels,
+ * including <asm/current.h> can cause a circular dependency on some platforms.
+ */
+#include <asm/current.h>
+#define current_thread_info() ((struct thread_info *)current)
+#endif
+
+/*
+ * flag set/clear/test wrappers
+ * - pass TIF_xxxx constants to these functions
+ */
+
+static inline void set_ti_thread_flag(struct thread_info *ti, int flag)
+{
+	set_bit(flag, (unsigned long *)&ti->flags);
+}
+
+static inline void clear_ti_thread_flag(struct thread_info *ti, int flag)
+{
+	clear_bit(flag, (unsigned long *)&ti->flags);
+}
+
+static inline int test_and_set_ti_thread_flag(struct thread_info *ti, int flag)
+{
+	return test_and_set_bit(flag, (unsigned long *)&ti->flags);
+}
+
+static inline int test_and_clear_ti_thread_flag(struct thread_info *ti, int flag)
+{
+	return test_and_clear_bit(flag, (unsigned long *)&ti->flags);
+}
+
+static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
+{
+	return test_bit(flag, (unsigned long *)&ti->flags);
+}
+
+#define set_thread_flag(flag) \
+	set_ti_thread_flag(current_thread_info(), flag)
+#define clear_thread_flag(flag) \
+	clear_ti_thread_flag(current_thread_info(), flag)
+#define test_and_set_thread_flag(flag) \
+	test_and_set_ti_thread_flag(current_thread_info(), flag)
+#define test_and_clear_thread_flag(flag) \
+	test_and_clear_ti_thread_flag(current_thread_info(), flag)
+#define test_thread_flag(flag) \
+	test_ti_thread_flag(current_thread_info(), flag)
+
+#endif /* !__ASSEMBLY__ */
+#endif /* _LINUX_THREAD_BITS_H */
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 34f053a150a9..793ab9b290ad 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -11,30 +11,9 @@
 #include <linux/types.h>
 #include <linux/bug.h>
 #include <linux/restart_block.h>
-
-#ifdef CONFIG_THREAD_INFO_IN_TASK
-/*
- * For CONFIG_THREAD_INFO_IN_TASK kernels we need <asm/current.h> for the
- * definition of current, but for !CONFIG_THREAD_INFO_IN_TASK kernels,
- * including <asm/current.h> can cause a circular dependency on some platforms.
- */
-#include <asm/current.h>
-#define current_thread_info() ((struct thread_info *)current)
-#endif
+#include <linux/thread_bits.h>
 
 #include <linux/bitops.h>
-
-/*
- * For per-arch arch_within_stack_frames() implementations, defined in
- * asm/thread_info.h.
- */
-enum {
-	BAD_STACK = -1,
-	NOT_STACK = 0,
-	GOOD_FRAME,
-	GOOD_STACK,
-};
-
 #include <asm/thread_info.h>
 
 #ifdef __KERNEL__
@@ -49,47 +28,6 @@ enum {
 # define THREADINFO_GFP		(GFP_KERNEL_ACCOUNT)
 #endif
 
-/*
- * flag set/clear/test wrappers
- * - pass TIF_xxxx constants to these functions
- */
-
-static inline void set_ti_thread_flag(struct thread_info *ti, int flag)
-{
-	set_bit(flag, (unsigned long *)&ti->flags);
-}
-
-static inline void clear_ti_thread_flag(struct thread_info *ti, int flag)
-{
-	clear_bit(flag, (unsigned long *)&ti->flags);
-}
-
-static inline int test_and_set_ti_thread_flag(struct thread_info *ti, int flag)
-{
-	return test_and_set_bit(flag, (unsigned long *)&ti->flags);
-}
-
-static inline int test_and_clear_ti_thread_flag(struct thread_info *ti, int flag)
-{
-	return test_and_clear_bit(flag, (unsigned long *)&ti->flags);
-}
-
-static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
-{
-	return test_bit(flag, (unsigned long *)&ti->flags);
-}
-
-#define set_thread_flag(flag) \
-	set_ti_thread_flag(current_thread_info(), flag)
-#define clear_thread_flag(flag) \
-	clear_ti_thread_flag(current_thread_info(), flag)
-#define test_and_set_thread_flag(flag) \
-	test_and_set_ti_thread_flag(current_thread_info(), flag)
-#define test_and_clear_thread_flag(flag) \
-	test_and_clear_ti_thread_flag(current_thread_info(), flag)
-#define test_thread_flag(flag) \
-	test_ti_thread_flag(current_thread_info(), flag)
-
 #define tif_need_resched() test_thread_flag(TIF_NEED_RESCHED)
 
 #ifndef CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES
-- 
2.17.0

