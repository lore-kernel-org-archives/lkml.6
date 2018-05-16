Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4128544-1526459186-2-16835951844053523486
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
    1526459186; b=OTGk8dr2Z5NyHgmjgKLc8N2FjVbD9wRtg4jkEeWspBHJANJ6Sv
    G0qKYyGsbnyQMvq3Or365NlakgYIrnIqmhvrfi4krKKzXhhMyCvlBRTa/5AwP2qH
    sjtCoh6VpI8mH4SOzqBiWO6c1VGt+4bLXIixzdh4vGKnRKNXWGMpX6QNbtRP3oa2
    R/r+F2NWvJQ6M71XgVlx4cDa/4MEBoZKLXNWhA+QN3IsLCA8DS0wAdkkrXmi0I8E
    t6l1Un9AXgvp5KS4Tftxu6a/GeIps9sO5vTu+nQi81W3YPl5z7xtefpKwcdrpt82
    YCRnWuldT6T7vFk12Eb1rTZbRRR3FacJendA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526459186; bh=L25YFGneYb7ZsaajzFAdXAz9YKL6wk
    D6h0lArWDYYxk=; b=lq0TNvshdAyCIqQlCoA5QSf+zeeu6dCA5mYHPCO8ynANcB
    CCMdynpgCN6iwXx7tXtu7l3dIeh0QaqfR/fINeE1B7T2XAgeae4ppRd7eWiCWN29
    jNJ2JTx7nVIJGCKrpvbSoK/K+5i/RAgKJKRma+NYLdhzm2z6NbaPf7cqCruFgV0q
    Th7Z+tXA6RO9Uvr12jwyJqyWlJbMeAvJxvbt7F6sOJDAdCU5vranCt1wlVFFGbTX
    Eg9m0wlTXz7VLlX4k6u7t9hdFJs0pygz1QBp5JYdP9Z2cx0vGakjhjx+naUhn1FF
    7FNa2J8XyN1SaUqY4jqh/pMDans//YXAseAo3NZg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=caviumnetworks.onmicrosoft.com
    header.i=@caviumnetworks.onmicrosoft.com header.b=IBns7yz7 x-bits=1024
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=caviumnetworks.onmicrosoft.com
      header.i=@caviumnetworks.onmicrosoft.com header.b=IBns7yz7 x-bits=1024
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
X-CM-Envelope: MS4wfMqIFgEyLHGhSCGXZo1R05p/UrbwgOpTE81V5dhwd2xJRut4vQDp1eGsnp7PNtvk6/Rb5G6qqylBdmqvI9Rs98VBE+yDkB60yyhMAFWnFbIajoRlNmsP
    Gg9n0a8BNTBDv4uEvkkd7Q2Nk3djMcqEGbqKlU/HNySL56rLx77evyPuo873uzObM18+0GFaY/EAUWSJhw8UhnMEO+lm94cVrAe/tDPFCU1oIB4dYE2t+pZh
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=sFUR1tI3dlkA:10 a=P23N9hKgfBoA:10 a=H9XALQ4oeggA:10 a=VUJBJC2UJ8kA:10
    a=ifRc6kEuNzAA:10 a=enOvQawGAAAA:8 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8
    a=ckEhL5b42KKRoA_7hdkA:9 a=x8gzFH9gYPwA:10 a=OuzhcWw_GC9nAYdNdRwA:22
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753082AbeEPI0G (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 04:26:06 -0400
Received: from mail-sn1nam02on0046.outbound.protection.outlook.com ([104.47.36.46]:25024
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751319AbeEPIWz (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 May 2018 04:22:55 -0400
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
Subject: [PATCH 19/24] arm64: signal32: move ilp32 and aarch32 common code to separated file
Date: Wed, 16 May 2018 11:19:04 +0300
Message-Id: <20180516081910.10067-20-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [176.59.36.13]
X-ClientProxiedBy: VI1PR08CA0111.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::13) To BYAPR07MB4373.namprd07.prod.outlook.com
 (2603:10b6:a02:c0::16)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4373;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4373;3:DILY91qX/3RCf+SaqbCFdd9O3pw+AYjVaESOT7ENBjK9bBNUuFG31I3ZiTdl25oORmHtNqPMiDARCL62/Yaeru7p1927nQWYhPznRjjCxD5u9oRoHV8QxOy4LojZz+D+2ceTBS2ty88gjNN1DVG+YBMnlJE6ceMJTUfewf7HHglArC/v6igVGAyPdNMEGdBMkOvW4UlQdPE3R234hrDcYhB51ZgQ0AC5Dd5PryUXmt7Pi1Ef5Wq42M5Z3zj1dqUU;25:6WVjlGo5KOh+BuRotF2/QVe2iulLVMSObtTH+xKyNLxntvw3B7lL4ef6r+wiXEfYwj9OOrVOb3CoAsvJyQMyPl/YelkBmakPa0WwlrZR5hlmpH7iFAPl7dOghhc3ymu9hhMHnkc/KMS0oim/JRPflbL47+CCuVC+YzlzO9X2zDsipyd8DGn0vCvZBCoFTwd0lbgGbAT41LqKX8Uk+Qdz2uftsgOKiRP4013f6LzX03mXPswuOOxPDxnSIk44z42qBK33RnV3f5Zbd7q61BnM95ik/fhpwjadFkbhbYjdilBLAlyuKga0VtQEpzOaQRSxYJAfARpbHCdQdY4UbX8TvA==;31:bZdc8SW8R37JnMs3x+GnLLnnNoWopvKVXIxPyXhy5czZuG1RIVXHWYAtA+SgRlA9NeDxudl4tfSk5paUfCnTT++Udy5dVgzhWZ8hEAMjXUvkRBMvV2nMRIgzjuul6TYKERkXbklCaGNIs0IlDVk1H8y5SYNUjHTxq+xstVYic0f9NJjBp1XbnOa7H5QHzftcurX/gaYZwv1fK1o6gPHRzHAA6Rd7XbUox0fN2zMsrUg=
X-MS-TrafficTypeDiagnostic: BYAPR07MB4373:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4373;20:eXQACVUyJ7A9HZORlrFKUs8q3BmuJenqWk4kBzrde/06bdbSp7ROBWoZpWobU9HvxKwcfFIpAxL2ePKb2qCywmB/H/NcbYoUaVXN3TM3qW7FxWewWKnLHMSUPX8IgJYS+aQpNXthD1K9AUcFN97vITCLScBgKDBBV0B+14ixw26NBiA50csqhGrio48TqGM/3WjDiL+vj7UKn/lZmz1AHIla9F0Qe8S5xk6t+4yYtafsuXm2C8WryZTluhRRcF/pav6Ruj4Rxt8x0B8bdOnfYo6uiMo7fIPuCPoGG3hej1h1Fx0kOJ9Gb0EVxLOSaiAAP8JasZnirSpisChIFGHUZNn+vUAvFTMuo2qzWUmvC++QK/ogiUbx3AyqF+/McXrnqJLWQJxIQfQw9LVbERAabNQf9b4nAQw8BUIHBxhlqAGfsDz/WfDyz1g6XXSzWRsEyv2dkAD0wIalH2kqZLOszMduBCXSSO5AZWMfNP3Nv7n0X2aMbQtfiVIhz6EZn6nIodPp0d9oMEyzinFo7ApJFE0BcyUSGouJoAKALYU9xJzhOlDUOzW490m8cs1YOcHcueSPFi3XVkzIygrVCTbzDN/3iK7hg/x963IHMXFbOb8=;4:m9StfvWIUyD/CCmAx7SOXJtb5PpayWb9iGJlG+wcBozxVAYBJTMh2XzHIBSneNb0MAIaB4aWSkRRn9rmL8hkU982tCLSBXYS9sOAg56WnUx8n9ih0zDe+OMib1lFUGfoNL2aoKm7JFZGLMEyR1qsbYoFRLmV+JsuA4qfw3WEiMGe7X4lHqzwTIriWB31QyzZa7h65PUtJEAtaF9BFcM/j6rToXP+fEtu5nCJVHq4spsYxMZ6E6HhRO84EU9vEx2UujpAGArPvyP9p26eqkmvzQLpOn0BiMz6KYcoKdIeo2xsFkYs8Ygv9HSQ0L4z4l+v
X-Microsoft-Antispam-PRVS: <BYAPR07MB43738FA566D7A8C89900F7ECE3920@BYAPR07MB4373.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BYAPR07MB4373;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4373;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(39380400002)(396003)(346002)(39860400002)(366004)(189003)(199004)(575784001)(2906002)(305945005)(39060400002)(7736002)(42882007)(7416002)(7406005)(446003)(11346002)(956004)(476003)(2616005)(53936002)(106356001)(68736007)(6666003)(36756003)(47776003)(4326008)(5660300001)(3846002)(6116002)(25786009)(50466002)(72206003)(386003)(76176011)(76506005)(54906003)(110136005)(26005)(6496006)(66066001)(105586002)(1076002)(48376002)(8936002)(50226002)(6486002)(8676002)(486006)(81166006)(81156014)(478600001)(52116002)(186003)(59450400001)(16586007)(97736004)(16526019)(316002)(51416003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4373;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4373;23:TEQUAcTm0hxsKfzP7H0JdcU01/7QKVPXTMd8X4Pe7?=
 =?us-ascii?Q?L19pYa5nKWuoNxIPTEdMpvJ0v68NDuSHT1oUdIP8tiw81DmDtmmyum4AKF6i?=
 =?us-ascii?Q?5ETvgM5Slhrm62ezVX9lR3adN+6HfbI681iZbvqQZRgstb/8xm/0IijtWfa0?=
 =?us-ascii?Q?UWRxSJPQgRjeg87UBphzUOIiX5WKFgjlTQMjdbctnLA9Z8ocLiso+f66uWA+?=
 =?us-ascii?Q?zn3Dfz+qtZczgyGtLEji4GU49TupP1VDzbAqlbOwJtjKqpkt+vAq3E6LHgY2?=
 =?us-ascii?Q?c78UhaOaNEeg0BPVtIVJD9bdowoyqaLObGRYOG2gUEYjh5CeQhquX6FQBabn?=
 =?us-ascii?Q?LDAj/spQHPxwfEwT8lOsntvL6FW+D2XpNukFxAJzaxculnlt79cAqckv+nZ/?=
 =?us-ascii?Q?eto+8CKRAimOJ8lBdCKJWbogCbQSSn4xvokAC1SkyQ9UGt7yCxnaEYkjB5ot?=
 =?us-ascii?Q?9Hb9bRmZJdbTkRkhMf/Jz/pYMxeFygjBFR67hYRO9daU8vkyaVx8T4nu00tx?=
 =?us-ascii?Q?zMf3RNh7fWOu6Pas+kN6ERwke+kQAsVWg9v79iMoO2T+KVKtrN9QkE6M3Rnm?=
 =?us-ascii?Q?YF+o0P/gtF3hMSolBuZF+9VDPLLaTtTWQFvRSvnl1PIeiM+ydE31CZFXBjuu?=
 =?us-ascii?Q?R2XwRw5uZIcyecdjhZPsMlukOON2kb60kwssQBoTR/cGNpc+6UbVjTqgbq31?=
 =?us-ascii?Q?lfTJVOsDF4bepelwCyMBSZRq4HP5q+Ilq60Zn+mKlM1N0ckYMvSJoviQUVJU?=
 =?us-ascii?Q?s7mMeaQKgWmenAMuzwtrw+ICes6IkDQuKdTbCqGf6k99SFoJjxG5Y5Bw96NS?=
 =?us-ascii?Q?zsMx4L4307Fe5tAc46vLoE1CJwk58+4v5HVr1Iy7xRxIgQI7/4aTUWcVYSwx?=
 =?us-ascii?Q?kg/CMSTsetzpyFOPhWz+nhatm39iNpTnqEpf5hq2eDAqdqowBSKt2kWbMmZT?=
 =?us-ascii?Q?dTaeEKbypPXYSIQBcPp4UjToFOjie8J9+nBvxDZ6eAsPdnM6/0jItC6zvSVG?=
 =?us-ascii?Q?nactm/GWQYwPebBX/gtN15dN8NhfaBorD/fBErQT1KJUX2kdWwfVZOApiLEf?=
 =?us-ascii?Q?TzQZzbhdXqEKIIbUTpR2mJUzb3q6or8z496n989mpnZZKSEGFatjlb1Devq7?=
 =?us-ascii?Q?QVvEzbGN84oUnT0fWfaBgzmKyNKvH0A0p/DuXnPSqwD/5fn5FO+bgeeH5dKz?=
 =?us-ascii?Q?5K7xrXKyaGobm/EZZakX/ZUgEiHPF5Y8aUpM4XyN/gQOa9LHmPfjTBh+7m7T?=
 =?us-ascii?Q?FoGf/N7/n9HBkuA5HDTLAUW3nFvpxVeF2M81DCcklHJGkoAGX21Reok7YeEj?=
 =?us-ascii?Q?HeoSHnMPisP4Q4sXDYSdIu1yRoE9mW6kkzZcZVI2M2ys4KjzpzrSW9sqSUXu?=
 =?us-ascii?Q?dzKspnNU1I/C/RZBIsbVEwY2Ew=3D?=
X-Microsoft-Antispam-Message-Info: 3cpCnXBCYFKqbwL8/vUR/h2nOn4KV69HvgQ73EbujgRRrJBo64I6c+IDE3OsynHizz0Qq7sKsT66fLFZYKrOfEgc1IqWmzHkl5AuBnBg7X17kX0iADfGy8NdFKB+C6fCFEnWqudg8TW3xRorxbKSgUc2sC9rP0IPXzhvtp4tB74WJ4svY8rmJKsAZJgPgblv
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4373;6:ai6A8VxFZnKSbLg3kdD4mQUvx2HQJ/aJw6U4OR1bVIRzsVKPrtzfO47CExkWdmnmmM81q1uOR/nlTAKvBygKbOTqX2jhXaYQcdhvUgVYWb+UXFm2taQ4F7FguJNG9A2VfnY/WsGom1qpw9C36NdTl0WCBSw2/GJYi+1pKX6gUgCUbGEu5Kr15I6oekI+RI1wh31/H/EQ8IWhNoZchTsCkTe1KZMymfDpQ9ThDSr37fH9WTLYLWue6lCFPPCbQsOJkpT+HriGz5exqulmuD6YVnM89l9/u9kwOGYc/ncs+FHvIpVJcKZ/VQ0PHuteNe94A7rvsDf9W5Hi8ZHCI5StbPNzjavvo3OR0vpsVhfnc87alAifpNpyI+YigleJqm2w7saZA1o8QTJXdlcoVLzcpPBfvMzRyw/3vvBGyUuKS8OwwQQFqoa1xjgwI7FqhDmcya0hz+Tt2m7pKQD0fxwrzw==;5:g3HeMdbzKLfS3WdgFywOI1IUR/w/8ax1Q67D8reojtYPJw54sq/1Q8+R+d/fjDBUPsGeyz8OVTMdl3iaCd18qC9nv1WpgYYVFpYj2cH+IERage1jcrdw/6+8dalW+WnlNp9npDRE9kqXdjKPBuVtRyEClEZO5kP4pC+owVLhMV8=;24:Q/w1yvbXJJVSQEKr0kPM/KIdcr6z0GJml1FY+smktc3htkDA7xRTJVvOx41CH1uDth44Gw67/CpA7HnYrvznk96DilPyFVvEdMbhit5gvZs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4373;7:wYLmRh/w/csQuUMFF+wD+hnpQ/zc8s+2Kjy/Xd3P3XX9ne2I7H5cjUys4VmZz46oKaz0+G3LkcQrlvOWI0s1fidYoMz+MHYZC6uj7USblC/0b/LzrRuQBpObF3EIx6kAbjtOKEQI+OwRzYYcNLXh7z32iVHLdvtcT40iroOMX+gN3Qbd3wjvKlcFUapldM/hNMdL0muHOGtU0jmtYc2S31bh0SMKYW5v7pLIInmNScXc5eIFA575fTswGDmDde3S
X-MS-Office365-Filtering-Correlation-Id: 02d4fd64-225d-4aa1-5bf4-08d5bb0638eb
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 08:22:53.3033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d4fd64-225d-4aa1-5bf4-08d5bb0638eb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4373
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ILP32 needs to mix 32bit struct siginfo and 64bit sigframe for its signal
handlers. Move the existing compat code for copying siginfo to user space
and manipulating signal masks into signal32_common.c so it can be used to
deliver aarch32 and ilp32 signals.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/include/asm/signal32_common.h | 13 +++++++++
 arch/arm64/kernel/Makefile               |  2 +-
 arch/arm64/kernel/signal32.c             | 23 +--------------
 arch/arm64/kernel/signal32_common.c      | 37 ++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 23 deletions(-)
 create mode 100644 arch/arm64/include/asm/signal32_common.h
 create mode 100644 arch/arm64/kernel/signal32_common.c

diff --git a/arch/arm64/include/asm/signal32_common.h b/arch/arm64/include/asm/signal32_common.h
new file mode 100644
index 000000000000..10bcdf6b8b4c
--- /dev/null
+++ b/arch/arm64/include/asm/signal32_common.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __ASM_SIGNAL32_COMMON_H
+#define __ASM_SIGNAL32_COMMON_H
+
+#ifdef CONFIG_COMPAT
+
+int put_sigset_t(compat_sigset_t __user *uset, sigset_t *set);
+int get_sigset_t(sigset_t *set, const compat_sigset_t __user *uset);
+
+#endif /* CONFIG_COMPAT*/
+
+#endif /* __ASM_SIGNAL32_COMMON_H */
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index a6db407d4089..9e127c47a25c 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -29,7 +29,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 arm64-obj-$(CONFIG_AARCH32_EL0)		+= sys32.o kuser32.o signal32.o 	\
 					   sys_compat.o entry32.o binfmt_elf32.o
 arm64-obj-$(CONFIG_ARM64_ILP32)		+= binfmt_ilp32.o sys_ilp32.o
-arm64-obj-$(CONFIG_COMPAT)		+= entry32_common.o
+arm64-obj-$(CONFIG_COMPAT)		+= entry32_common.o signal32_common.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_ARM64_MODULE_PLTS)	+= module-plts.o
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 739e13b54820..fdcc210028b5 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -26,6 +26,7 @@
 #include <asm/esr.h>
 #include <asm/fpsimd.h>
 #include <asm/signal32.h>
+#include <asm/signal32_common.h>
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
 
@@ -103,28 +104,6 @@ struct a32_rt_sigframe {
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
-static inline int put_sigset_t(compat_sigset_t __user *uset, sigset_t *set)
-{
-	compat_sigset_t	cset;
-
-	cset.sig[0] = set->sig[0] & 0xffffffffull;
-	cset.sig[1] = set->sig[0] >> 32;
-
-	return copy_to_user(uset, &cset, sizeof(*uset));
-}
-
-static inline int get_sigset_t(sigset_t *set,
-			       const compat_sigset_t __user *uset)
-{
-	compat_sigset_t s32;
-
-	if (copy_from_user(&s32, uset, sizeof(*uset)))
-		return -EFAULT;
-
-	set->sig[0] = s32.sig[0] | (((long)s32.sig[1]) << 32);
-	return 0;
-}
-
 /*
  * VFP save/restore code.
  *
diff --git a/arch/arm64/kernel/signal32_common.c b/arch/arm64/kernel/signal32_common.c
new file mode 100644
index 000000000000..21995fc4e0b4
--- /dev/null
+++ b/arch/arm64/kernel/signal32_common.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Based on arch/arm/kernel/signal.c
+ *
+ * Copyright (C) 1995-2009 Russell King
+ * Copyright (C) 2012 ARM Ltd.
+ * Modified by Will Deacon <will.deacon@arm.com>
+ */
+
+#include <linux/compat.h>
+#include <linux/signal.h>
+#include <linux/uaccess.h>
+
+#include <asm/signal32_common.h>
+#include <asm/unistd.h>
+
+int put_sigset_t(compat_sigset_t __user *uset, sigset_t *set)
+{
+	compat_sigset_t	cset;
+
+	cset.sig[0] = set->sig[0] & 0xffffffffull;
+	cset.sig[1] = set->sig[0] >> 32;
+
+	return copy_to_user(uset, &cset, sizeof(*uset));
+}
+
+int get_sigset_t(sigset_t *set, const compat_sigset_t __user *uset)
+{
+	compat_sigset_t s32;
+
+	if (copy_from_user(&s32, uset, sizeof(*uset)))
+		return -EFAULT;
+
+	set->sig[0] = s32.sig[0] | (((long)s32.sig[1]) << 32);
+	return 0;
+}
-- 
2.17.0

