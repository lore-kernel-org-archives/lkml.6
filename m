Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4128544-1526459412-2-16860769659702674427
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enrosv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526459412; b=kuX7WgKIQcc2yChVYMX6MukbO7wfYHmh3FT3EOMLccHpRe7XMD
    JwvIxXi/JfMzrFT4sytTO0xb/o3JpnUHZFPZBBrq1CHQhdMs6bDWiVhZSkkcJpld
    7me/1AL1cjPZlJjLaZn0nCnqHxCYvUHPG1lQM+g9QKqthI2X0d5mQvj8aJaDrQ60
    pJAU9TMYyHySrj+iLSt5IwwFtanHgCc3RmHSa+JBWXvtuhB+wy2QM8qbsVCqWuIJ
    /oqzIVka5wo/qs2UlpBvNaoq9BUgd9S1ggM5HqdNXMIq5nTlo9DXeCCkfUsroQPk
    y+WquU8fzsFNtCXybhzabOsZxizFBHG7aizA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526459412; bh=e0x91OIoIov+67zVtiMq5lSfomT5TV
    2jD2MlhaItinE=; b=m6S4cTxOp7FLtT9KFY9eYtya4W5pP6txfxrYxTOWdUb41j
    yiRBGuq1Dfrp2f0v00zBcyJktol0Y0sS9LyF3K9gkEMEyEGhTDJCsxjcs2T+w2N/
    m7bg03FxXgYtMkvnO5Kh7GwxoSBCjkWxQPyrie4BpgwmTtx18WJ3rra5X/sDiXsu
    WwS3A9dE3dcCBvTEPYeS0xkhw5OEaIX5KTWD/wGhA59Ij+qWSTwsYm7wZ5FVdOCd
    A0G7TvPqAI+13fS5pdD29QXqxjwdvxQQuEhO8DCztyV6cQ4Z282UUh5UjAVWxBBt
    vTfVQtBecqD0t41Z9CWrlwpXXoz8VFdVSY/5QxwA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=caviumnetworks.onmicrosoft.com
    header.i=@caviumnetworks.onmicrosoft.com header.b=hvz/x5kG x-bits=1024
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
      header.i=@caviumnetworks.onmicrosoft.com header.b=hvz/x5kG x-bits=1024
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
X-CM-Envelope: MS4wfAHbNYpstBj72JtwDBUccgLUpFYHw3/bkrbsbZ+QHtuH89rTkD1uG8u0OBdNBlRkwpvnfWGFQbVsQ/as5PkvU/gE85JES79diLJsCAQouxLOJxKagffz
    zQLXZ6mCoSQEo3daHlmA1oswOsGwP6JZfIkUWe1Yd30kCJ1GVKQumlRkmOEqUCg/2gqSqp5ksrsmDiE1JtNv9/kCph1YrzIBxe1mY9zQygXvjG6kptHSprOE
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=sFUR1tI3dlkA:10 a=P23N9hKgfBoA:10 a=Vyf5Uv9DvnYA:10 a=VUJBJC2UJ8kA:10
    a=ifRc6kEuNzAA:10 a=enOvQawGAAAA:8 a=7QvuB2UPAAAA:8 a=VwQbUJbxAAAA:8
    a=gFUc5ZMiB46YYna9KnEA:9 a=x8gzFH9gYPwA:10 a=OuzhcWw_GC9nAYdNdRwA:22
    a=PyAPxfarwdVEPLbpdMBu:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752804AbeEPIUN (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 04:20:13 -0400
Received: from mail-sn1nam02on0064.outbound.protection.outlook.com ([104.47.36.64]:26144
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752336AbeEPIUE (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 May 2018 04:20:04 -0400
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
Subject: [PATCH 03/24] compat ABI: use non-compat openat and open_by_handle_at variants
Date: Wed, 16 May 2018 11:18:48 +0300
Message-Id: <20180516081910.10067-4-ynorov@caviumnetworks.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516081910.10067-1-ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [176.59.36.13]
X-ClientProxiedBy: VI1PR08CA0124.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::26) To BYAPR07MB4373.namprd07.prod.outlook.com
 (2603:10b6:a02:c0::16)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4373;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4373;3:FvBYHDpxWNr5v3ICvAe0MrhtwnQOaRkpSgNUZgUhfm1NmjRqmchpLgZT8OoAyUEVpF46zYYEK5Okp9gam4NcOc/ZbYHCywh9a1eVvEhcFb73FFofgPoXJBzz1NIDFluuWf5Qx7CK1yHwzO0eED7jo3tOPtzVXPJd6czJ2RJgTISzeEBMpYcUCCkx2MeFfWGXa+/npfWThbvVAZ6yvVvIRx4KApDeC8PU/j/MEwEpBm6jkN++2nn/zuOeHfYRS83H;25:jL4K8ZLmY+EhjFRkYYeMppalzd0ozM03HVFp0b8sG9iEelwoVWdCgAqqh8hRT8YIA/UK/SbSklbX3+70tLYLsDZXWxd38ihOpez5n/h/oTljc2os4YsM31oCy25SdVgjHiPQtlIxQ/0LA+9uepZJfgAGzDnSzFKdocWNGlJUykAyTNIMGejrOIOAN+G6Bx1vNldtE2BAJNJ+OJ7nbf+o263hxNEqOKnKO9G7Hupk2OxhDCxBrMEdw/pANkymo4PbGqlHAU9zKtBmOL/WUnIQHf9scOrmE/xXYLOPO4JCgHC8JYNIHnq4qL11NPbsO0nxcAbtub3oOZk5rirqkwS95A==;31:etVZHv3Wc7RukIx6G4V/29JUk8SjH1JcAQTU04y04c1xDrKbdl8jkOGtYTSpgwzKJx7Nrs8NmLr7B6qmpm3o8aYL6EKhIyNfipZsYTAi4389uMXoXts/xr6AbIw10zaabnDGdFb61T+LwD987GkXv0boJIWQH5urq+KQRpIaYrGp347LuolCwZFGRVVmaztF2IkHe/XdVTVGCGf+cfP5HSGMSNf1o23e2Ar32j7og6E=
X-MS-TrafficTypeDiagnostic: BYAPR07MB4373:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4373;20:Q9I7QLv4jk2LojcHkvC4DcSoTdfzZdabnOgy7ilrg7Bu1byH7LzrdFwe3Wr+vLVvPZAjsgHacPHyU07FtxjLFGUPa0uFO2sbQSgKLpXNQRGB1y73TFzI75c9jNKm6Wm5ggsbS0eSHfCS2a5KHDEft5Q86AUqes43yvHh97RjZLytQOhb3XxsgCBZo4Z6uxDOQoOeUR//PqKpA6XEY6xLfvQHxfXxpYPrMiHDlP4VTsBnP5tVetQFKaPYO0DQqFokqOVK6GDFJKzIy707kP8pKVCjx9kSJxx7rPxQHHmW4ZCGvz0MMIWjjqqzRQ46i+Cx0SVHS4R0R23dHsSJD2e+/h0dgbID63J+Yr5KwdOaY8qRpyagPKXa0/kO1GstP2eB4VE2K9n2Ywg9szEf6gJkWn9crrQ3BnBhsPN2uqG3xbXC3X/0HzB4RaXGuc6rh3I8r/ZqwJeOvw52FWdDSxzGnN3QWVtokSwlwfwvQjEew4AuwC9M8QZfnf+EOXmgu99bo8ACRGgRzCpv3W835hhshGOqUoRWR6H2BCcY2pqpcx+eDmVqeowTx6XmbGE3F3UpMo17Fd12G5YRIXjE/JD65zQ0lAH1wvgvcaPntdNkNMY=;4:wF0A1db8Yy1fpQp1J00ivfgJ0kDtBy53YIhUPe4vUk41dZVpvMeKaR3HzBCmNMgCeiwf68zmwzt/2UmluDIXXVrpF/c3femoAojjfqmGuFlKTf80mEN+IFP/qos8dMzdQNGshS0sldDiN/edvBrSLi5WxCn0HGGZ/U1EFLBjfIy7aE7PB2wWgfXTKJt9FRKO4Xkxz9bNh5GtdW9DTIgGMuvlyPjTDRWOlAqpGVeahII4o2vKGJgVal7dygvObmPilf17fREYxOhTXlUxdP78MA==
X-Microsoft-Antispam-PRVS: <BYAPR07MB4373EB0E160548352A7A69F0E3920@BYAPR07MB4373.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(93006095)(3002001)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BYAPR07MB4373;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4373;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(39380400002)(396003)(346002)(39860400002)(366004)(189003)(199004)(2906002)(305945005)(39060400002)(7736002)(42882007)(7416002)(7406005)(446003)(11346002)(956004)(476003)(2616005)(53936002)(106356001)(68736007)(6666003)(36756003)(47776003)(4326008)(5660300001)(3846002)(6116002)(25786009)(50466002)(72206003)(386003)(76176011)(76506005)(54906003)(110136005)(26005)(6496006)(66066001)(105586002)(1076002)(48376002)(8936002)(50226002)(6486002)(8676002)(486006)(81166006)(81156014)(478600001)(52116002)(186003)(59450400001)(16586007)(97736004)(16526019)(316002)(51416003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4373;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4373;23:jJF3EtXbQgt8055cR3uDqgUo63ROMUPWXUbIUl/FA?=
 =?us-ascii?Q?6itRxLByk6UDbIKpMEgcBS3hfSQMkH2h2oYkBa6PcKlR3tzlWbzpYbdahFuP?=
 =?us-ascii?Q?b3MOQ+XBNDtD1MTriXDrHb7vNmkczbigvfat8ylU194zIdAKISOdEreqrRk9?=
 =?us-ascii?Q?lKyOE0almhPJVWP/tzBLeCMJJwhLlBiy997/12V/OFV9d84WiwH/B05FN9oG?=
 =?us-ascii?Q?2Hvv0ux65QvylgElkLcq4pb2Lyk4r3w2YKVWrfEpirI9QZCGIzO4D4o+b6d1?=
 =?us-ascii?Q?izyLO4ttVa0r2xIxys9/kS95gPPP7s0hv7q65a9OqYx+PJK7NOO9I560UZmi?=
 =?us-ascii?Q?HGENtpAMqy0oFUZr5AmTvc2o1os9wMOVp+xd+aVDzHE5bVQo5TqNs8NO4W7o?=
 =?us-ascii?Q?eKCUNU9rT651BW3zpR2wQynbBVoxqueyTHNkkhZ5N09jE3APoCOEY8JyNzm/?=
 =?us-ascii?Q?cWOJt+hvYoojMVl2Wy2ZnEvWYA1PJHt2OWH9Dc+5oB68SlYboxQTW3CjrviS?=
 =?us-ascii?Q?Eu5t6s4NfUZVhwVh/+FoVygI9rggJ7OMTjfHjiqDYV0egaiGIUiVArWiT7vj?=
 =?us-ascii?Q?HISWRMdr6RfhQvQErqc0QgLTqDw4H57t5nyujA1mcs4qzlcY8+DJlSJXkIay?=
 =?us-ascii?Q?5CB5Ym5xNN4ZO7seFxwRi2U6t+3mSdh6BUkK2AnpJUlWR7JE6lPxsVS2belE?=
 =?us-ascii?Q?R5s0FJY/rsu30iaddHXtZ58fCqj14wDilyUms6P9IDazWLPozD8+DNK/f2NL?=
 =?us-ascii?Q?Czsr2IhMBmGk4mSnTk4ZGTW1dOvuj6S7yAFw8GX+CdaiN2fzNzu9ft3wdCQY?=
 =?us-ascii?Q?Bjf1phNHWX2fsB7vo2cT3FUuyvNcA0vS06kcCePr67hWo2N/+x/scjuysvQ8?=
 =?us-ascii?Q?BSN81pdfmioReSMGlY1tUSh82HnYcKB2ENGZWnc7RXQVwXOx2oM/u8YG56+7?=
 =?us-ascii?Q?n1/3dnjb1+0lqKGIbWQGWiZrULTPi/buNmiyR4lMVBwPsXmsNcLNcHWGrHdc?=
 =?us-ascii?Q?sm1FhB8tGR4Mv2WRqKt1aDnlJm1/fCP0G+2vo+GSX0Q1B2lL4e/dW68MagBS?=
 =?us-ascii?Q?eUjMXYSUbv3WrbgIMTeLZBJiC5kqXv5z5TRhMXb6fDqGOHaF5+xl5Q7fnjQq?=
 =?us-ascii?Q?LnIbnFn6s1/cxD/90L75m4xyIZ/ebFO8i77YsvlOa28tdytNTDV5sgbjrBPW?=
 =?us-ascii?Q?azn3pwWN+jzQZ28XPwpXudwd2t0dEAkn7UCbEFZ4RMO8aEK3+pxHRv1BUof4?=
 =?us-ascii?Q?uLQdG76H12RhqpgnDD9IWZYloWZk4nuiK1m75OVHjsMwftStbt1lkBPyIRPS?=
 =?us-ascii?Q?19CyZiEFU1Y/4M7oBVsoW7Qq13kxbc+xsaVmVaCm1BW3mDPrQV415zdmeom9?=
 =?us-ascii?Q?pR4fw=3D=3D?=
X-Microsoft-Antispam-Message-Info: WPV12xSC8XUVwnloA7KOibRFnnRPYH97f4eug6KQCAA96fFaxqMQWE2CTChU3TEZCtmijFT8VwSL1t616HhPYb5N/jNEQcV5e2nXAH+X/ijZ7g8aCTKDja3eAe1/ZBfEKrLK4/qcz41a3wg1XP//GqXMyz0WK2saYX5WDg4QUvBmIN58NqhVyCbALPZKHJ/i
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4373;6:3X/uqSAROwnJrg9Lcpl3PutHfN0D0KOfnyA6yHSQsqqHeu6LEslvSDqjxwc2Ef/J8mrW1pyyvidpUkgLZIGwNkPhrty9j5kCqgMBRr0OXuqVmbBgX/HSSCx9HYe0i2yyGuaOr+0crqNpIqZvv4f1p2kiBWARnLMq1plqxicEFAvPlePX94ZzT9dHfWul88AJ4gyFQfhcjU/4zhRg6yAAG9uqRPwfJmmDE5F279b28J4GogT7unCEwVT6oWQfL/7dj8YYlZ9DG5xjmFKKNr4WfwK7i2FYTFnWWterVRt4qY+BeCzHq18M5gDHq0Clcy4wgmoQgfqRkK8plIKlOcfY6YgWGjSy5tQXiUUL6wemZwo7iYcVkz3FR9vw1SnsQ1O5hZExIPuxTXEJxJo14EzoAgJPLKvxVk8fpIAvH1Ff56/mbHyxEZWnNxat8TAcUK2b7BoIDLqIhJC94y5dF0rq9w==;5:pe/P13NELynVPk52eKPifme/TBojtxPgxdVUHzqSk0Pbb2siU8/mJEv7Xg4nK4t9nhINtLBdbG0vReDHZ+djgspNZ70V8oxa2SSkEnYY7Mv7FO9QidUyFcBc+dnc84UbWSetxSl98fk2C94iFgd49wzTDeVMNxmnz4KKAQXbf3U=;24:LS577eft9tcqtoOW0nipH+qHqoacsKfXW6cVo1w9aoUiR2BKS2yLFFEfy5QiqhnAD2KgmRqHdlbWDOYBx/Bbxr/8iNglhu5L2EmMzG+b/dI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4373;7:7phcWE6TFejJMkdSZEXQEZnVuMG+zb9AmwDS5ZzyzQ7MVqce2tiYxLc+VSmtaCBoolM+SDdkf13unipVetTHUAHz/zqzjDz9MclM4SNEZGu141MKnrYMm5mfpZUK7Cp5Sl32AFhMrQVlPKtLbhOb5h6keutm3E7VwNrALIYX7eMMCx901vhO++0w6RvzrrWfgYcdCkgXR/We2YFC75SdulH2WOqAVZKEKVjH2ivP+ZA1yU6IfEeDhRAtoLVx4nVs
X-MS-Office365-Filtering-Correlation-Id: c6592bf8-6008-4951-5f88-08d5bb05d329
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 08:20:02.8477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6592bf8-6008-4951-5f88-08d5bb05d329
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4373
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The only difference between native and compat openat and open_by_handle_at
is that non-compat version forces O_LARGEFILE, and it should be the
default behaviour for all architectures, as we are going to drop the
support of 32-bit userspace off_t.

The exception is tile32 that continues with compat version of syscalls.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Chris Metcalf <cmetcalf@ezchip.com> [for tile]
---
 arch/tile/kernel/compat.c         | 3 +++
 include/uapi/asm-generic/unistd.h | 5 ++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/tile/kernel/compat.c b/arch/tile/kernel/compat.c
index bdaf71d31a4a..3b7853c59395 100644
--- a/arch/tile/kernel/compat.c
+++ b/arch/tile/kernel/compat.c
@@ -103,6 +103,9 @@ COMPAT_SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned int, offset_high,
 #define compat_sys_readahead sys32_readahead
 #define sys_llseek compat_sys_llseek
 
+#define sys_openat		compat_sys_openat
+#define sys_open_by_handle_at	compat_sys_open_by_handle_at
+
 /* Call the assembly trampolines where necessary. */
 #define compat_sys_rt_sigreturn _compat_sys_rt_sigreturn
 #define sys_clone _sys_clone
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 8b87de067bc7..426a1a496d9d 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -179,7 +179,7 @@ __SYSCALL(__NR_fchownat, sys_fchownat)
 #define __NR_fchown 55
 __SYSCALL(__NR_fchown, sys_fchown)
 #define __NR_openat 56
-__SC_COMP(__NR_openat, sys_openat, compat_sys_openat)
+__SYSCALL(__NR_openat, sys_openat)
 #define __NR_close 57
 __SYSCALL(__NR_close, sys_close)
 #define __NR_vhangup 58
@@ -676,8 +676,7 @@ __SYSCALL(__NR_fanotify_mark, sys_fanotify_mark)
 #define __NR_name_to_handle_at         264
 __SYSCALL(__NR_name_to_handle_at, sys_name_to_handle_at)
 #define __NR_open_by_handle_at         265
-__SC_COMP(__NR_open_by_handle_at, sys_open_by_handle_at, \
-	  compat_sys_open_by_handle_at)
+__SYSCALL(__NR_open_by_handle_at, sys_open_by_handle_at)
 #define __NR_clock_adjtime 266
 __SC_COMP(__NR_clock_adjtime, sys_clock_adjtime, compat_sys_clock_adjtime)
 #define __NR_syncfs 267
-- 
2.17.0

