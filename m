Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4134569-1526459149-2-7271383025006002103
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
    1526459148; b=O/wuEZ8fJNw2fJ5GCTn3F/UIq5rOIkK3oFBFgZj/np9rcdIE90
    5RAn5A7Q2fMSTmA50fkHgg5vr2H9HY+8PElkmNITGGbLGJjbhzQBdD4R+1bwgsEF
    imuPeN2tSl73szt1m5fsBwh4dlTP9IuA6h5Hq6u9DWLUStoR8mxbXbS6YY09v0MT
    N906wDjYATV2CUUrFtpiSphw2jyNdLiIcX/eujMsvB7zmIIM1rL3itbT1dTu6+H8
    PwmKgf8G4MyvnD4FM+c/mycMlJptW34gRr6nBXHXIDm6+OZmmJ9hyGOLRxUO1Jd4
    M1h6ArB9tOc9qFk6ydgnGdfZeN6vNRvjOwPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526459148; bh=kZ3iBQNdAq/Am27BN+x6fuj8G2h2a8
    KT4nO0Pg83HlY=; b=hS9OauVrA0ZS368M+wtU9+hh8J6yhNtBY3voApCAf4ZrJb
    ZRdsqlMK4szgX4j9EJI1Zgnfn5RDjYrNhfLZGPFjCz7w92JLkHKziJeTk15un7JP
    Q64in7G+13zyhPantCjgXHQ3PM03qVMToQDOtPlMGKyFvyimaJtkzQWhpT/dvgf0
    AT9MZZ0JBeSDRVreNn1LmZaN+7TtII+4jw8YLV4qu09u+aM0t51qQKvscm888JsP
    uQYkOj7qoG3uTiQHtoFgH4CYtPfvUvo6VKXXTtjkY/hgMx4NAUZ2B1dRn2hd2sf8
    AguwGOp1vVMDwY0yPm7RTtHvoy3fwWGExh4CoM0Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=caviumnetworks.onmicrosoft.com
    header.i=@caviumnetworks.onmicrosoft.com header.b=ijXdEYVw x-bits=1024
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
      header.i=@caviumnetworks.onmicrosoft.com header.b=ijXdEYVw x-bits=1024
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
X-CM-Envelope: MS4wfP3ZzTqjqhyL79pEc8f9+5AvvqeHOQSx9fZ2uS6daaTF+Qj6l43wkJJLS1GPfzTQT2X43jxSRxJ47FdZE+1kPkaxFce4FEgk+WxwH0V2CZCOpiWm40Tk
    7eUEMxilDwxS9Cw0sRm1u3WP9XDWvu/lOpkpO0Q+s5eNm1Md537j1zahPxCgPlE5pW0dd4UlJPwDNvpZn6fjvToLwN6WJ8+D0E872HaMy2f54vhCgLRa4kOE
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=sFUR1tI3dlkA:10 a=P23N9hKgfBoA:10 a=l-x4i3o4UXgA:10 a=VUJBJC2UJ8kA:10
    a=ifRc6kEuNzAA:10 a=enOvQawGAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=H8-5QyFSEHwsOpmB4RIA:9 a=x8gzFH9gYPwA:10 a=OuzhcWw_GC9nAYdNdRwA:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbeEPIXX (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 04:23:23 -0400
Received: from mail-dm3nam03on0057.outbound.protection.outlook.com ([104.47.41.57]:31007
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753110AbeEPIXR (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 May 2018 04:23:17 -0400
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
Subject: [PATCH 21/24] arm64: ptrace: handle ptrace_request differently for aarch32 and ilp32
Date: Wed, 16 May 2018 11:19:06 +0300
Message-Id: <20180516081910.10067-22-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [176.59.36.13]
X-ClientProxiedBy: VI1PR08CA0111.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::13) To BYAPR07MB4376.namprd07.prod.outlook.com
 (2603:10b6:a02:c0::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4376;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4376;3:Fm93lf+BpGAn22gQo9W0Ym6Zvfk/C89Y59yPTG7qOG7Z5VZMX2gVuV6Uh066wp6gn2XYgd8U7xzYAfyBYz+XGpUuTga869AEdEZW+q7ESFCBN/0Q7wjdBgU0wMaKQUdFuOVPTII62vt7EO44OTx9d5S7dIBd4dMmBkwNj+m2CQkCygfBdSC5a95v3getQRvIXqrdyPD6bhytPGboUuTEmON2C0nsyP6HZVMkimACeRvQ8d9WE3dOd01PbdhoHPyg;25:6zQGuopHsPe+c4W3JQiSm/HlK+3hq7DqwlTN9Nm0TtDqIDW9hMMT4Yb7RWW787EWzAXb8o7oTX5QAJw0VD7SWRNBl/v1rs8CsIWRxgnIpE3w0NSHsJ8o3zfpWSKxLrXv8DuWSVB8PuTn0KoLgp+tt8xh/ohraCa+RrIH7kqL6Ci2wu0bumX86wWaM9XCuc4daMECxscFtHP/NCLNkHCF9Ut6Y5+FZIYl38BHe7AN/ZevLdIE1szaFQvUJHPIgXMa+CXxx3cWklgfrNAutEqr9K6GJrInPV7ZUUpIqVvDmwTM8xOlXIwg6RfA3GhD7TBJQ+LKdcnN8wt5mFqCgpaU8w==;31:BqGzgpRo3M3O0EyFzxUTvfrBCY85VLGd+ih+YkcqD4YUJywz3Vi3blRrl7k07SZBcc3aS2dM3WYFQsp5Z+IodUhLSIu8SG0tkgxBnKQaEmfC93hMO4PV13uX/fghEmdyTWhBCAlF3sXanmj5KENKmK9lajjaBOaAULYQxVXZu7Toue/S4BdLBk6nSW/osyNWkIAGo1KUNMPUYPMYy1Xla2CfUiJasg+rughk5LanDfU=
X-MS-TrafficTypeDiagnostic: BYAPR07MB4376:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4376;20:rCscleQCR5nHWQumKNJrqQC6+QDQEhWHLX6qN/tOv4RPgJU2p6JCZ02VJy68YS1ULamanNEcy+/5mdrym35r4++mkxEYH5mBHLmivfsl343NrYNSBh/QSeBDglLumngE5w7mWplbfzTeg9HjDUVXTWX9VUs7gVqAN1PBRSINkQ1BXdONo6fLzW+NNNOXcOTOlCI09GWEBQnP9mMv/CpIQTzAW9e5YBW2dW4DxB4n4wKN/VJ9LHp66ZlgDt37w3/EcoSlkZtrQOfFNGoGSeR05MNHT4LYOK+76kVEa+8f6oiGG+TwcXhGNm9dmrHSWVU169/Z+OGKjQkAsTV6crNZV/JvWj29t9E7WaTS6C7RFF1zhgV4GyihJZm5U5rIolJsr9zCxkXZjZVZ7zg4baNQQYXnMYNM6AIK/VUgvUAqMOZ1JHkF5aM6hODfogJHefFw9Ja1GJwfNMlpysF3woHXRJAWVAhLeFT1hJRJ8BW+7+I73vzNuSOa1UQHvW2wjkDvM6DoEiG2eQy3smNsp7Q5nkIK9kdCfDLk63fLuTjyWIk6U4bQN4XQjvd6FCiKwc7Cdbr1wIoxx6libQwkea8GbxeykLMCArBKj8BZzosicdc=;4:KcdkdNhvFeJ9TlIw5yBRjEfkGzMoURwrHIInTPvNeNuoKUZu5eTuIF+Wfl0n3PKDBHLTfSEDN5hvbD6rxKLKHlfpXNtjM+Zy+yI+wubsHCt6uaiu9hSiIsDgaTcBKBUUImjK0p81TegXHMqozZ6jEAl+kO7fIxWoggq+rmeCPVeeVzFLb9yJyYU4+5t9oBpttpDAkiQLNgzZ8czZm1/oBB9bY87Q8ZZQFZ4tJInGBXZYiDdUnwLCY5bVKLOOpf5fVc7WoaiLMtRtT0YFppdG7r5eKCb+jaLA3HdZZP2AvhmRkROJ1RSnfnnHPuTTMiNe
X-Microsoft-Antispam-PRVS: <BYAPR07MB43763C82CFA0549BE3BC3929E3920@BYAPR07MB4376.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BYAPR07MB4376;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4376;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(346002)(366004)(39850400004)(39380400002)(396003)(189003)(199004)(39060400002)(42882007)(59450400001)(6486002)(53936002)(6666003)(4326008)(51416003)(386003)(76176011)(52116002)(446003)(6496006)(50226002)(16586007)(305945005)(7736002)(72206003)(2616005)(26005)(316002)(478600001)(11346002)(36756003)(956004)(105586002)(186003)(16526019)(97736004)(2906002)(486006)(5660300001)(106356001)(8936002)(476003)(76506005)(575784001)(50466002)(48376002)(110136005)(47776003)(66066001)(25786009)(54906003)(7416002)(3846002)(81166006)(7406005)(1076002)(68736007)(81156014)(8676002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4376;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4376;23:HT4tsQZfYCSzueeBdyPKmOHX4ZeJ+a/wIO7VEN//V?=
 =?us-ascii?Q?u/+gQbJvnFcGt4HfFPxjznDIm9aVhAyRRsjJSsKi4T5r141J+xNdDX6rrVKg?=
 =?us-ascii?Q?HedZqlMC1xb+jezkjeoo5SKxFV0V5lvms3IRP5aINSpMZg95No+esNOtXA0P?=
 =?us-ascii?Q?GqoY7y/mnJtvsU0Lj3qaPqKh4wXxEVHlUQBUPUMDG+4SYmGL/mwwvlMpq2Eq?=
 =?us-ascii?Q?Wtx6GT1mL+9MVr7KXqEaO5KPtGvXfqAnc7FxEaNNQhPsffoPg25a62feWk6o?=
 =?us-ascii?Q?3OvChV/xxCKRVuFRlJruXAiA7ZQ7/h0eSKGgAmkTk3CY2jcsGkMK/uct+Ppd?=
 =?us-ascii?Q?+2fjYwj9Bz5Ca5ZcK4efe568Vs/0ra9dZPeV03udQiyf7tdSjqUtpOdeUQGw?=
 =?us-ascii?Q?CgY9gOIji+Nz3ujAKg+sERDhUtsX8zCikfalpzK9P7gPXdaGQEKvOx1yFYMe?=
 =?us-ascii?Q?tmx8+o/f0B4lkI8u5fR8z4Vfcpsk7IyFee07ajissqD25gnKqPMKuA8laBWV?=
 =?us-ascii?Q?9kYBt0UJb+ekKCJ/1DFMDePOymKUcdcXvINwSxjoeHElEEhm7IfrUgG/6lcT?=
 =?us-ascii?Q?PSgbST4UPsQivlkcesbHdpm1d/SOanewxHZMnP1HdmNxekSH1BK3B3vwTAD1?=
 =?us-ascii?Q?5Gq6Lb1yORFqBprCtnJLU8AN6j0kXhVQTWjpB/1yZZrcHebd+INnw7n+N6P5?=
 =?us-ascii?Q?zbMChykiO1funT1erdYyKDSNpXWwVmZirmCenHJL8qmJnBNUrk17mWe2yCIC?=
 =?us-ascii?Q?CZlcwcQZeS/hI9sQNvvAHL8ihEYgl781E61h2K8/rDO0/ZH0PygUaHhVAg9s?=
 =?us-ascii?Q?px/y8kTzVSatXjnaP4bxO69LRtD4vIvbFn9tjmq+ZkI8ww1kbNuioZIJk3/X?=
 =?us-ascii?Q?90t3H016QRucgfIIt8HkaM7lhq3RXvhwa+Jnl7/togZ7hSova8wv3Yp3UKQF?=
 =?us-ascii?Q?8f2lDAG4/6aB9D4Cl2EXLXHwyvI8EiiLXUvARsn9OfqfdNVEzJMRlE4gKugW?=
 =?us-ascii?Q?ErChiFopCsXwIaHU0eBFAfcV4BGZao6mRDQ42bNRbHL4wXNNeQ7jyavW359s?=
 =?us-ascii?Q?3j95yENlzJYgG3a6C8AWuRiIqsBTKO4jXGP5Mnw1HybmUwKhSgMPu2SDNzYv?=
 =?us-ascii?Q?ZmvpaL4vnyITp1Zzciag/dpc8pk1ZRn6tNr0udQE3bSFTaozM+gaollrcblx?=
 =?us-ascii?Q?nFWzP0kBDJLb82D1EsHA+kv+KVIfe4AllCeZU8Z+/e10/CG2P5nHKbA37jIp?=
 =?us-ascii?Q?vqqZX9qHAXovHYYRkkICNPBuBM5hI2ifpqnhZYn5hXXdlipI9okK+8zeFlAb?=
 =?us-ascii?Q?ccFvpHOhUPRLmxJD7yub7KMZ0l7+RSpkRG/WQjZMN+9xtNHy2ku00Bc9E+8I?=
 =?us-ascii?Q?/lqL5v6/nQB/+PrvUbrleJNjRI=3D?=
X-Microsoft-Antispam-Message-Info: Uf5LfSU+vVYScpVJcjVpnQ9oi2zFJcL59QW7lnFzlDIaxH9PZwcvPNGKsHGVtbvrQQLnUzSkluJWyp9iBMYk7uxlCIAOe8Rj7Mt+6uhf61EtZiQflwTIbtJPTuuKvcCa7IqQ92aXTLSDvD6YZdg29ap2/fq8fTna+xyDA9pUN0Hrnd9jYOqt2Bn5GAYEAIod
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4376;6:P2LbDwOK/4N8AKRXc3dJdstViDmMM+PEY2QjdzHHZLG7/LOghE+n0ul0cZcwq0G9g1PXiLY798cLtI40HGYHmyIDuaqBBw4hVUaTQ48H40iKVGyb5eKiV+WoVU7jLMEWn8gPm3wSakuJUCTufsnpOkjzoU1YqYD+GdX3JxRAdTJWdFfeHDXwd/+8+pZ/wOwwPXctkGTiuXsZvqOdlUj8Jl6cZP2pqzInBSxioIFrTDsIHx3nuAo+ETVbh7aYV0LlLQvUBzundLVstcEtYF+WEl9ojZZVu5dty87y1/aQbGhi5OjTIsOgH3mq0vJ72bHZmzHW8qXg98Btl56hHG7ESW6Pe96dTOPuxLD0VqHPv4u9SqtrSm4/eJLdLt0nGAxDlmhtvaDUcHxQSj8Rru6+5j+P0gVroIJa7/jRfDBXuZ3XwOu2/P5IEDIFr4WNrmZVDWOfXTBY57zH6hSCBFWOpQ==;5:QQTiR17Y9AttB0aGoPFCR41SCPtU6Wh7vTWj1EW2p5EJKhO9JxTNHFbLER3IpIwTeMooucip6PCSvMk8v8DXaC1VIwnVxo11l09LOihCDAKK29YGv1ePhtJ1q2jsYowrijmtaog/tvPj9lgjdZbzE+rqGQ9d6MRcLErh+O9+3H8=;24:mUTysO5KCt/ubWUhuU/Ar3JAsuhq/2dAvRc4J1n0viWAcA4vUoed+08KgrENWxofwK/1dcYixtlMgtd7Ggb3XlRJRXW6eTJQWeiDWbmi5c0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4376;7:4hts6yOm7eN5fsJiN7e2PQwdx1SF/Sw3vobGs3OkryMDkyN6H1pL0JwqD6WBPPbhxIfQdktWSGeVlbfhZyPr0iuo18jgkuK7JLzQ3PIafJQeexOgv9iBVkLLqLN82mJAbcPPyPlkmZeTyc168vh4AkO3kpiilhXReFXi6Rf2HS2XA+Byac4VtwMIgnVBEU37vJEJnt+2+fn6dfvqVrrc38/7H449QZ40GNK/W6RdTz2q50UA6JWhH946/ySWrYnh
X-MS-Office365-Filtering-Correlation-Id: 7c042f61-7387-4196-d703-08d5bb064464
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 08:23:12.5075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c042f61-7387-4196-d703-08d5bb064464
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4376
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ILP32 has context-related structures different from both aarch32 and
aarch64/lp64. In this patch compat_arch_ptrace() renamed to
compat_a32_ptrace(), and compat_arch_ptrace() only makes choice between
compat_a32_ptrace() and new compat_ilp32_ptrace() handler.

compat_ilp32_ptrace() calls generic compat_ptrace_request() for all
requests except PTRACE_GETSIGMASK and PTRACE_SETSIGMASK, which need
special handling.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Bamvor Jian Zhang <bamv2005@gmail.com>
---
 arch/arm64/kernel/ptrace.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 4d0a541d049b..da7f47c7e586 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1038,9 +1038,11 @@ static const struct user_regset_view user_aarch64_view = {
 	.regsets = aarch64_regsets, .n = ARRAY_SIZE(aarch64_regsets)
 };
 
-#ifdef CONFIG_AARCH32_EL0
+#ifdef CONFIG_COMPAT
 #include <linux/compat.h>
+#endif
 
+#ifdef CONFIG_AARCH32_EL0
 enum compat_regset {
 	REGSET_COMPAT_GPR,
 	REGSET_COMPAT_VFP,
@@ -1503,7 +1505,7 @@ static int compat_ptrace_sethbpregs(struct task_struct *tsk, compat_long_t num,
 }
 #endif	/* CONFIG_HAVE_HW_BREAKPOINT */
 
-long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
+static long compat_a32_ptrace(struct task_struct *child, compat_long_t request,
 			compat_ulong_t caddr, compat_ulong_t cdata)
 {
 	unsigned long addr = caddr;
@@ -1580,8 +1582,23 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 	return ret;
 }
+
+#else
+#define  compat_a32_ptrace(child, request, caddr, cdata)	(0)
 #endif /* CONFIG_AARCH32_EL0 */
 
+#ifdef CONFIG_COMPAT
+long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
+			compat_ulong_t caddr, compat_ulong_t cdata)
+{
+	if (is_a32_compat_task())
+		return compat_a32_ptrace(child, request, caddr, cdata);
+
+	/* ILP32 */
+	return compat_ptrace_request(child, request, caddr, cdata);
+}
+#endif
+
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 {
 #ifdef CONFIG_AARCH32_EL0
-- 
2.17.0

