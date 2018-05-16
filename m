Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4134569-1526458939-2-3173786558180850970
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
    1526458938; b=UogQtm6rxCIbwnIzh4H+wc9Ba7gBXS23kJ1N634YdoMPB0wX1Z
    i4j56iA/CgXPsDeRLxuprMeoP5OmsMLbISnu5mFiDcEaTkMT3rxTYhSc9V6vwpSp
    CerRHARqqp1Q0lYieq1Xe3Anfogx4Ncf67IIsTZmYyd+0lAsVYg6oyKqxXcQio2B
    Lrw89DDIdiVtW9JfWjthB+N1i9AmY8sTOgMLduK96Uds1Mzd6yBsveqgw8cu3dMk
    3oRmdAna99wobhkxnjNJ0dBAIAz4Masdg5w57CAV7PSQ8HdHUlgZ5Ajd5QBlEsAX
    w6psw2OmcUXpZIfalXRjg4DQ7nTRfQG+pZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526458938; bh=UrKozA2FC+Kkq+n92O5v12W80IoBBg
    I5s5AuTCCPScs=; b=m8o90ZuUUAiFKUVnOHZBbkOSPd7+JOtyqZTBRF/brk3Vl2
    3IfhenrdjyZlWj1Vkey+nHLj/gqt/D9r86tawIYRTdaJcCUQlM9+1Q3N/AO+Zdjz
    IUJO28t3F18pWKVj/uVH++tve3+8wkzvz63USJ2nPH/hPJq7FhdiYcpExClLIIQ2
    g5G5HcGx1Xn0BoQtABPZDqNitm5NUdBH1jClvU23CKW91M90STVbpQ+iYeP/ImgD
    JeDgayZk+6JcklY64fl6MIK40J6RuSXQYwsP4KxxV6dL6f27GjJxAYUueZMxRbE5
    OnVRhjX7SYVdbmrQZLA6XdJNnzIeowQpK3MBM+Sw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=caviumnetworks.onmicrosoft.com
    header.i=@caviumnetworks.onmicrosoft.com header.b=RvwF5cHg x-bits=1024
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
      header.i=@caviumnetworks.onmicrosoft.com header.b=RvwF5cHg x-bits=1024
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
X-CM-Envelope: MS4wfOTUpNX5HzK+pwWhov3Oc/EhpAzFy50fREEofchZjb3+gAc2NWQ2OAe77ZFADysIJUEVUeBEMQ/G9lfpHJWYUDbRloE9oBi22XmZ92FO7BOiY9BDrXHX
    BTk9UF+Owm5bIR+TfmRyEmnDcjTR3I12G+pWHfrUliHaR4sRSYYbwQUEaIoReuoBoMQmcpvoCzXIsVq3H8QBCCXDlM6DD3RfPGiQAJfNGqSusG51qggqj8UA
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=sFUR1tI3dlkA:10 a=P23N9hKgfBoA:10 a=wTyAd9q2X0EA:10 a=VUJBJC2UJ8kA:10
    a=ifRc6kEuNzAA:10 a=enOvQawGAAAA:8 a=VwQbUJbxAAAA:8 a=r4SyLdxO9qLy4UnyEgIA:9
    a=x8gzFH9gYPwA:10 a=OuzhcWw_GC9nAYdNdRwA:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752990AbeEPIWJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 04:22:09 -0400
Received: from mail-cys01nam02on0055.outbound.protection.outlook.com ([104.47.37.55]:55030
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752956AbeEPIWA (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 May 2018 04:22:00 -0400
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
Subject: [PATCH 13/24] arm64: introduce binfmt_elf32.c
Date: Wed, 16 May 2018 11:18:58 +0300
Message-Id: <20180516081910.10067-14-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [176.59.36.13]
X-ClientProxiedBy: VI1PR08CA0110.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::12) To BN7PR07MB4371.namprd07.prod.outlook.com
 (2603:10b6:406:b5::11)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:BN7PR07MB4371;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4371;3:V8TKiRVLrT4dZFEkIrYB3lSwZ0SwbJt5ZDGK7b1kb669h/idSjoSwAyNT4JJqXtsUsl5v/P1GH/KLvl18CNKIeUmiGl0s/Js3o3A/JNyfQpAeFzAjW/iirAA7Sl97QeMs0Xrr2dlDzQexrsbEchUG/k1gaHvp2c4kmKD7LBKrj2Rw205MK+/CHdorloILfmcuq9paUaG7KDP6g91p8nzDhWq05UaX1VMMgcZkfWqScaD1VByoV/cfupLMw5ThCn6;25:XuHbCkjpaoQltemGqnG168wblIs1fiw8+uAL50mWZCPLbMSxc9IYtQaGVKiZD2T23KW19CtqnJCYrXeeOxzas1oO7eb33SIiLsR0DnJlhXJ3B3RBsMo5L/QF2RH3xQvkFpa9ip5RDvNzE/x3G74qk2zQ+M8T4yzP2DJCltJr4w6YKl5SXxyd0SAvdbiIor8yrHi3nSZWPxieLwi2YdIXhlZx18QFwtZSK4F8Sd1u0XHYxFqsHDl56QrVBSLggnNa41fcZ8u8HZS0SeQ+pyR5N2G5a3c2F8psCZnayYdB+dqrE0NaxU7G/zzzOpMyKjkL9TyhsxGB3emHbrDyLGrAPA==;31:Kg9tEcobjjPeV9VCIV9l33om5TPjKYMCPPAOJ14yUuMKRnuBnA2y5u3DdNIFRi8JazK9iTpK4OWT10ukXA20LYpo2vc4K543usyVaZT55J7EQxCU1g0ija/VfwK3NWt30Jby1mO0TgN5Z9KQYkPaLzznIG3v8/sM5/cjeJJUbiOgUzi6fSf7n3vzoNi60Vjpln6Yu4tLtslv1fLKfnTAs+/JsMLHe4zlJbITPTjCTJc=
X-MS-TrafficTypeDiagnostic: BN7PR07MB4371:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4371;20:qZ0TLJgzESj62T3GBVmKIAOwPA6Xv/xJ75RIyjrQQhSn5eIuVpWLzLnisR95cuC+ol72iI1JtV8wUcezMNk75g3z6PELYsi8Vk8zmPcYAgivFC32gvTFygLQfONJPVzbai870YQEHO1iwH+OF6+btTjWxT0L/P6UBE7jhrTx7s7QciPf/Ws5KAodNTJzHdikvIz13mcWarmXbqRCosx3RxiU+rbZLKK5zfLMOfueEfwL2E2FiHXsFx3aJQh3LtZrZyFel3mfqEsvpjKeoyoRDPc7u2GQoT9Y/QkpsQQ3gP6JzbArsAH2tH1lm2nfkhGqxWCkXXa8KzeQDu02yN9TC6xQRWq46vFdDhcYsH5T9z/bRvGJF/9oyS4naCCit2uKXQJAAyU2i6hAOnQG+jnQIdhRAMVBKH8iQ+cPRHr+/cNL0eb0hjBYrVw4fzOw2JNhVFhiEU4/WGfdby0UFUbxQbB3yd4mmRvUC9Szg0owkzb5P6SNGRVU0ohOEM2KoTCj9WWQM/3+5fRrWQpMt2WO7lqpgnehou4eh2tjFuMfwo2eRBJyr4foMjPm48A1HvC0VHT9/YxlZyceML3urhQf92F7O6qjn8LFu0xefWBvHGY=;4:X0SYrH9RJq/6Qtki40OmPvtSxVvJ3jbcUJl86JgSwaTEpeKPBrPwd56MlFpVCChpa8BtnTwF+Yq2C9y+/c1SY9XJJ8pg/kaCNSfQMoRQSYSvw7ve6QfJNeKrsFmS7lGsZqHK/0cSNMnofr9fNYBIqbqMX5fVzXq0K2oRRHLY7wCC62xCgIgz39KbmAmTTqVpqOhyWKinTXsWOedoC5vxpe1bmWBU52UWIrhv3js2zyiA49F7CRm1v33RHKfC9VHKJ1TzkQi5s4tPPUz5w4kzvg==
X-Microsoft-Antispam-PRVS: <BN7PR07MB43710252D8F0C0A9D8E2F3F3E3920@BN7PR07MB4371.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:BN7PR07MB4371;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4371;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(346002)(39850400004)(366004)(396003)(39380400002)(199004)(189003)(956004)(2906002)(3846002)(2616005)(7406005)(42882007)(486006)(76176011)(446003)(6116002)(16586007)(16526019)(76506005)(386003)(50226002)(51416003)(476003)(305945005)(11346002)(7736002)(25786009)(7416002)(53936002)(4326008)(72206003)(6486002)(5660300001)(316002)(66066001)(39060400002)(52116002)(47776003)(48376002)(97736004)(81166006)(50466002)(81156014)(36756003)(54906003)(478600001)(106356001)(6496006)(186003)(68736007)(8676002)(8936002)(1076002)(105586002)(110136005)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4371;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4371;23:Sp+MWNVXTN+Xs35xFjbI+YxTQM00fp+D1rliHWuh7?=
 =?us-ascii?Q?xBWAcX/+N6vdDr8Ghnf1GkESRqwV/3VzFS8KjLiJgDdFRRiLiMOGwklwn7Mv?=
 =?us-ascii?Q?0nIvcrDGj05fZggdA+5OqYlJWVZzghMYwr1Yrl3nPoZ1UrpzR8QzYzTNSIEh?=
 =?us-ascii?Q?Zpmnxrr0Eftml2ENPjlIl+TC1Tlngyb4YEGlcL8G8/+IeGbh+pUGBL+HA049?=
 =?us-ascii?Q?+QsxxnhAPyjyd+bSnzOxIYnmwWRsgomGA42ESLOqIFrfaUzlIorkfbzQTGvX?=
 =?us-ascii?Q?287EptEoTJXHR2EIPqDAUfsbPRGYUzgft9xdSxoYFIGV7kB79PwDCqnT+C4s?=
 =?us-ascii?Q?Z2Deyq7KXHGRLYKyXrHrDcwrtQEZEMRUwp8AhSI3j8wlo9TlpMSZ/lXd5lf2?=
 =?us-ascii?Q?5ivUIM+GqkNl359EhIcB5Pa6Pddgseddek7TrMcsGirmCggK6wvj5f5RZSnY?=
 =?us-ascii?Q?fybLVE6BqL7DXRmxuoIE8Ab7ko03bK7unoQbYDe11igqzVFNNkxLyp/4vONw?=
 =?us-ascii?Q?5CIa/kv04Ivhik4C3KriglOStzu5HYKq3mB8Xs8DbQx8EgfvMJWWTKEcarQV?=
 =?us-ascii?Q?3KBQhMg9aZ+tXtDWZm5g2xMyEJDw7mY1cqz5YBXT5HWGVBmjBSAP2dsYXmgB?=
 =?us-ascii?Q?zCM7X8NrJzAZGd9awW43uH1FStmDIVxhT6wXiYw0bpiF01VHDvU4GvXera/E?=
 =?us-ascii?Q?1GtVxTnzlty5mkbZyvp4IJLXyMixu56rCOeAh1sccS44dhoU7cT+TufI0OpM?=
 =?us-ascii?Q?OwlDuxc/f2kwnu4phw5AHEDNiN9i4ZFbBAmCpo+JbTiSAtiEmD6vqcH4fnga?=
 =?us-ascii?Q?qvwCp4VjWx5z9ptmIOH5McWjZgyMDh1NKYm2/HqK2MVsU2iJpaGaQkZrJ9gk?=
 =?us-ascii?Q?c0U6lImkAG5CaobUP1kO4VY+FMsYwfx+5Ze6SLdfP3mkNelQw3aIKCAqcw3e?=
 =?us-ascii?Q?gixkKbsEi214UxR1/mIBUUlPNRR62oLhu7hZpAL3HBc7hS0utOcPjcBEFbwJ?=
 =?us-ascii?Q?Xrfi44TzWb0xMDKDMYOKdNEyG7zEM6mdGhT9RQd94ytaid6DtQa2syb4jZm5?=
 =?us-ascii?Q?EdVvDGU0FTHlHgtfnGeLacNAGjVdjRnz5QRBn2U9d3d3EhcFQsci8go+KQ/C?=
 =?us-ascii?Q?NdCOkWizD7tZWeegtWYaJy0EkCWepBpLNqd1ulhkLesBNeb4I3b8BdalTBKW?=
 =?us-ascii?Q?hw0UCCfUQ1uzfgz+fpCznFeuj79D9ndu7TYey/AcmwZdh8+qoCYrEqL7XWJh?=
 =?us-ascii?Q?VFony+vBxYH6qfgsR+ZeQhfrxunnZwn1l+f/xQcs1JfFJ34xlcR0XuK0DTrz?=
 =?us-ascii?Q?v3Ganig642wU+yc/Wg/HvY=3D?=
X-Microsoft-Antispam-Message-Info: 1NODsKsTFp0IGs41Io43uhXXmqM7i3xgjzSRPEw//2vxMdIeMsM1exzaCPwXx8n8vUBBXlfQWeTn/xVVyHGnVjy/9SIO60SY0kn8slImTPgghAn4yyB32/amN2LahOa97oex0+UO9as2LV3k0bEkIWNstfpbWjz7z3kk4tnb+BV2m/G1LUHzxLPd3M0pkAFH
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4371;6:Tr02gnCWVUv/GTAZtpGS/ldKrR0lFrGw1oG4lR8MDNVkXbUV5lI4hiwD+MAhInGiphv3DZKzBh9KbWw0FP5tNu/yDokvSY9mdChN7ktrUFcSAKFqNSLG4R9phCElkV2uNdy54mzS6CvPnZJNWrDixW9bIOrJYylp0D4AC+PKBWxQzejcTqM8deE72eN0Smnq02MyWNUfVfMjI28gqmMOTFfXI9ixzUBWdBchw763SEtl9Ba9i/4VzUrpbI4z3sp6CV58baKoE3banXbX0vCk+iEMCREzX0HXYAvUizavU0msntiZxdeNktfEAd8YSKeMH38W1BpPtbjWWAeJdCXURAx6uekbJldYvupWBEr+P/StuvczBx8gB/vk8S2+dx/3Yl1lJNC/wMcWU5qRAbqXnV5HIAdihNXzCmJvEYduTf4Sy//+8HjVsf99DzaYJblm/xRJF/QhIHW6aQqpcLODHQ==;5:Xzl4faR+5T+fDhgqASoHrUCjSJXpSuQx8Kc87HaO0+GxzR72AJYArI0oOBFdFmllAnrp6v/5U4UIgULJ/fMzVZXLh/qoQH0n7EDUbsbhfvlnluvckEldzkTnRuw/ACyYDX2cZ9KPtvKNHeUVYypdPH5vu1r3TVDvR7eoL2L8ncw=;24:Um6bMRoDQ7d6NCyn1Mlh1+Tl4bW6qCihYjMoHO6J+sLutMCqrR/1kcPffT94Cc7Raia8NqU69PdULVseFMnAJ5zBiKkwA77eUHJuCdXeG+0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4371;7:QR6HKJ6TTYVSq9Zm0L384ukvDDk/yZYaq2+5NBIzgMXhjQhBOvMjoSccBc7seWkv0z6C9asdsY0zlh/QXLRUZLQPrbr8h/jWo1dSQ361jjIc/EjccFVuk2IcquN6eRWgs4IajCT0UcnTSYyovsvcowy/WYs0FxImQC++xyXNqIY0ebbynsDxKPPdFydWlCKunLSnmobK+/Wt+YYFzC4KHJedsjuLjxbzjIPZi/q8v0gGxNqJ7yeifkkIvLEB8Ag8
X-MS-Office365-Filtering-Correlation-Id: 3779ca4d-f6d8-4335-18f4-08d5bb06177e
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 08:21:57.4568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3779ca4d-f6d8-4335-18f4-08d5bb06177e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4371
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As we support more than one compat formats, it looks more reasonable
to not use fs/compat_binfmt.c. Custom binfmt_elf32.c allows to move aarch32
specific definitions there and make code more maintainable and readable.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/Kconfig               |  1 -
 arch/arm64/include/asm/elf.h     | 26 +++---------------------
 arch/arm64/include/asm/hwcap.h   |  2 --
 arch/arm64/kernel/Makefile       |  2 +-
 arch/arm64/kernel/binfmt_elf32.c | 35 ++++++++++++++++++++++++++++++++
 5 files changed, 39 insertions(+), 27 deletions(-)
 create mode 100644 arch/arm64/kernel/binfmt_elf32.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a16916be20f5..0685754a9f7b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1232,7 +1232,6 @@ config AARCH32_EL0
 	bool "Kernel support for 32-bit EL0"
 	def_bool y
 	depends on ARM64_4K_PAGES || EXPERT
-	select COMPAT_BINFMT_ELF if BINFMT_ELF
 	select HAVE_UID16
 	select OLD_SIGSUSPEND3
 	select COMPAT_OLD_SIGACTION
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 023b2fbc1454..f04b27bd9bb6 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -175,36 +175,16 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 
 /* PIE load location for compat arm. Must match ARM ELF_ET_DYN_BASE. */
 #define COMPAT_ELF_ET_DYN_BASE		0x000400000UL
+#endif /*CONFIG_COMPAT */
 
+#ifdef CONFIG_AARCH32_EL0
 /* AArch32 registers. */
 #define COMPAT_ELF_NGREG		18
 typedef unsigned int			compat_elf_greg_t;
 typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
-
-/* AArch32 EABI. */
-#define EF_ARM_EABI_MASK		0xff000000
-#define compat_elf_check_arch(x)	(system_supports_32bit_el0() && \
-					 ((x)->e_machine == EM_ARM) && \
-					 ((x)->e_flags & EF_ARM_EABI_MASK))
-
-#define compat_start_thread		compat_start_thread
-/*
- * Unlike the native SET_PERSONALITY macro, the compat version maintains
- * READ_IMPLIES_EXEC across an execve() since this is the behaviour on
- * arch/arm/.
- */
-#define COMPAT_SET_PERSONALITY(ex)					\
-({									\
-	clear_thread_flag(TIF_32BIT_AARCH64);				\
-	set_thread_flag(TIF_32BIT);					\
- })
-#define COMPAT_ARCH_DLINFO
 extern int aarch32_setup_vectors_page(struct linux_binprm *bprm,
 				      int uses_interp);
-#define compat_arch_setup_additional_pages \
-					aarch32_setup_vectors_page
-
-#endif /* CONFIG_COMPAT */
+#endif /* CONFIG_AARCH32_EL0 */
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 2c7fc5d89813..99dfd9277559 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -47,8 +47,6 @@
 #define ELF_HWCAP		(elf_hwcap)
 
 #ifdef CONFIG_AARCH32_EL0
-#define COMPAT_ELF_HWCAP	(compat_elf_hwcap)
-#define COMPAT_ELF_HWCAP2	(compat_elf_hwcap2)
 extern unsigned int compat_elf_hwcap, compat_elf_hwcap2;
 #endif
 
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index cff1a78bdf4c..c63e0164fc12 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -27,7 +27,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,objcopy)
 
 arm64-obj-$(CONFIG_AARCH32_EL0)		+= sys32.o kuser32.o signal32.o 	\
-					   sys_compat.o entry32.o
+					   sys_compat.o entry32.o binfmt_elf32.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_ARM64_MODULE_PLTS)	+= module-plts.o
diff --git a/arch/arm64/kernel/binfmt_elf32.c b/arch/arm64/kernel/binfmt_elf32.c
new file mode 100644
index 000000000000..440fa84f62b3
--- /dev/null
+++ b/arch/arm64/kernel/binfmt_elf32.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Support for AArch32 Linux ELF binaries.
+ */
+
+/* AArch32 EABI. */
+#define EF_ARM_EABI_MASK		0xff000000
+
+#define compat_start_thread		compat_start_thread
+/*
+ * Unlike the native SET_PERSONALITY macro, the compat version inherits
+ * READ_IMPLIES_EXEC across a fork() since this is the behaviour on
+ * arch/arm/.
+ */
+#define COMPAT_SET_PERSONALITY(ex)					\
+({									\
+	clear_thread_flag(TIF_32BIT_AARCH64);				\
+	set_thread_flag(TIF_32BIT);					\
+})
+
+#define COMPAT_ARCH_DLINFO
+#define COMPAT_ELF_HWCAP		(compat_elf_hwcap)
+#define COMPAT_ELF_HWCAP2		(compat_elf_hwcap2)
+
+#define compat_arch_setup_additional_pages \
+					aarch32_setup_vectors_page
+
+/* AArch32 EABI. */
+#define compat_elf_check_arch(x)	(system_supports_32bit_el0() && \
+					 ((x)->e_machine == EM_ARM) && \
+					 ((x)->e_flags & EF_ARM_EABI_MASK))
+
+
+#include "../../../fs/compat_binfmt_elf.c"
-- 
2.17.0

