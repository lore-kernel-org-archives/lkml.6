Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEE6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933AE20673
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="nmuRjW4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 933AE20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbeGRIQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:16:26 -0400
Received: from mail-cys01nam02on0040.outbound.protection.outlook.com ([104.47.37.40]:21440
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbeGRIQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOk5xXqbTe1H+B/rpuxkqx7iT7/QpwD8TLH00pqvFKo=;
 b=nmuRjW4AWN2fn0R1xAK17L7gY18ro7if5zgrmpyL0tznpg0d6AvT9kN+WD1e4iauRdyn1G56XvKlzKOxQ8V0KARPsLPjwA3GssPHlptn6yrjpAFQaAS4vr80JVPmMzarK3padbzt6akbe8Z9f+T1zbMXfRtbkytZWh3ybM1dOQg=
Received: from CY4PR02CA0016.namprd02.prod.outlook.com (2603:10b6:903:18::26)
 by CY1PR0201MB1916.namprd02.prod.outlook.com (2a01:111:e400:527e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Wed, 18 Jul
 2018 07:39:10 +0000
Received: from CY1NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by CY4PR02CA0016.outlook.office365.com
 (2603:10b6:903:18::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Wed, 18 Jul 2018 07:39:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT031.mail.protection.outlook.com (10.152.75.180) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.952.17
 via Frontend Transport; Wed, 18 Jul 2018 07:39:10 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:49448 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ffh3F-0006sb-Kj; Wed, 18 Jul 2018 00:39:09 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ffh3A-00048e-Hl; Wed, 18 Jul 2018 00:39:04 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6I7cxkq005075;
        Wed, 18 Jul 2018 00:38:59 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1ffh35-00045o-1e; Wed, 18 Jul 2018 00:38:59 -0700
Subject: Re: [PATCH] arm: dts: zynq: Fix memory size on the Zybo Z7 board
To:     Luis Araneda <luaraneda@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180626232025.14003-1-luaraneda@gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <2a551619-63ad-253b-33ae-e3d538aeed9a@xilinx.com>
Date:   Wed, 18 Jul 2018 09:38:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180626232025.14003-1-luaraneda@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(346002)(39860400002)(2980300002)(438002)(189003)(199004)(31696002)(65806001)(110136005)(58126008)(336012)(316002)(54906003)(426003)(230700001)(305945005)(23676004)(39060400002)(2486003)(64126003)(6666003)(14444005)(50466002)(65956001)(229853002)(106002)(36386004)(446003)(8936002)(4326008)(186003)(26005)(44832011)(77096007)(47776003)(76176011)(53546011)(9786002)(5660300001)(65826007)(486006)(356003)(476003)(81156014)(2616005)(36756003)(81166006)(2906002)(6246003)(126002)(11346002)(8676002)(478600001)(106466001)(31686004)(63266004)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0201MB1916;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT031;1:PzI5tLW6DlZAUaAyPuc4VBJOHNl0UqlaZZFux0cWvqHSfyiH4X0zhurd9LakpGSmzN/VHWWGu50K3p1z1I0Ig02bx5nf2+JYTs/TE8mFiOv2GP59x7v3ZMQ0pdMkF/rY
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b49cb320-20d5-460d-78f7-08d5ec818d23
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:CY1PR0201MB1916;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1916;3:exRY9TFDl5CuDp8HOvC+thPLIYSR/Op3VbMJ1TudeXM8F1VLsArfp7p3pWN+anPNIYPZoCbO4DK6Hlq5p9JhBml1Mx4TaOSIxqDLXqTF/7/5KMf5i8uz/4oMo7o61/vy2/5CgkUK9mSKUyQg9wkcwbqYHoumpMS6e/gaBbZ+csaQv2OIQLQj9kSdyYLq3P+B3aPv4fQtvoWm5kKngnJ5YPglnN1pj9K4R+UXl7/n634dSHXLku6kN3nVNlQrbFFux9rW6kAMYzHSfX+uh5WFTiSq3XSjnbjokDR/Sa4pR8KxeoUtpMZ4Ed0K7SS5vZ7UpqmLyytdu0qndMQwagVS4LPeQKaE8oOjtLby0+HBCC0=;25:FSaynd5GvXH27N6A3lEgMwhYljLDPocPLCuz3Ya1hrk4HckLVIVhSsyBIpxGshdTkbuLh1Gy1F0XeCL1537+tO+HaViJK9rWyLYi5T50AtLHH9KZReGxR8d44trTvrhEGYiYlEj4N69Jh2anvUeCED5i3SU+GcPu11oC1V8sI1tI2x/nvc3VpXOVlODIMAxvIayx/gyfrN6QpZpCrs1zlcfyv8c6HnoiV3MWvZoTrViqnUecLixSgAOEVsl0Seeesc/PlDbhj0RsgZR4TfqoJ3ft6FAwxYnoji64qxf5YDM15aGypzlFUZl7VN4yO3/WwCedD1Rgr7pQDkomrQmFig==
X-MS-TrafficTypeDiagnostic: CY1PR0201MB1916:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1916;31:KK1XHTxTlrD5Nrkzkj16RyOADh/MIitX21wSeSTJBv5sDqjhl2zZPK+vZh4afOjxAWf0Zq0Ii94AZB5aYlFNywF6x/PApkQVVDB/fU5eP81x9VJYBgRndPw5guP88Wf4zBbN1/13Ot98TjONU7aM1nxoV0S/aqw3UmNjvZZXXcAR2m40xwJ1QzJ0lCgEOTLbnQ8d5kHoXM1Dc23mwsi/kizroOOPKmzA1vaj30ZtqG8=;20:2ov3aVf3vZOJTXrkXbe+961HBw4iXjqB+Kv+Ryz8FU9u2l+wYqw45b/AqpBPwI2+1p8St/bU5GFg9NTvIQQHMrVfWySisoxdQkRIw6L55UQpvRM74pJaFMXkEcGPS96JdknIpQbmNLyKqG8rMjj7mOFhjSEx20SMGNaRL9A17kLChCySyrXL4THF/SvbFIf0oyczguYGQIsjrsLzVfkjczKyDbGkk9/3U1Nl2e1Y6Ekx62V/R9Yb1leO8VRNPyGuocw35nBTR0OYdstudLM5wnJUNQrYv8H2CcMAth2lgw2cch9C8PNa0OegCy1KxtRJZLOAYptm++jBvonO598lO+aygyJwLdqW51KXIEH4TyzmTfjr1ujFl59rq5CqeSAcQn785Dzx/MDQ/F+aBPHtAFBU7OvPqfqyWjVHPFnzerLRVgXHCWSZUMe+pxIea/jBX1d4qWLfwWH95TXPcgVQs4UH/nROO4XtYXfSjelwbKbzM0538be8fThy12r907S5
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY1PR0201MB19164C90184F5006E4402D2EC6530@CY1PR0201MB1916.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(10201501046)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR0201MB1916;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0201MB1916;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1916;4:FA/TkrKf2WgVMSUaKuc5B8tJhqTsm9r5Gru6xGp0D0qqQVNwyXB3MOhGqDjuHYY+tyZEZntBqnoKshuG+QMqSoNacvTsR91lF57v2h8jzlE3gIjsrItMTg9u+xe3Yoxpx3KxEmLzaJ4/AI3IHrjPbXJF4mJyUMBCs3d5DzAFPZNAyEvn9r/pYMfv3Yx6yfHA1VGmz0sWMv9PrsF5AUfFeZ3qEuZllgm3MI9fCx0Gl9nKf3hBvM+WIj4JJbhGgMd5MNdZaoH8NPjxDgOKu3fk1fpExd2MdmV2RA9WZYgbR4wNdLZUEIsE3lJX5R/NZf1v
X-Forefront-PRVS: 0737B96801
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjAyMDFNQjE5MTY7MjM6aWxVcEZCbG9tclJtS1dXR0ZGU29Jbjht?=
 =?utf-8?B?Vm5PdEU0SGllRGhyMkFpZG1KM2xVY0IzQzROU01RZ2VidEdGeUoyZDVBVXVL?=
 =?utf-8?B?bmhMMklMMGVpWUd3bER2STFXWTQzSW5QaWVDZnV0ZkVnbVg5T1gzR0FQRmRt?=
 =?utf-8?B?Q0h4QW9LdUV3amtxYlMrRTZzaVR1dlZMeVEwbmg5cGMxMXdBRUVEaGlxaGJr?=
 =?utf-8?B?OXJDRlRzNDA0ZmpIYVdHdFh2RTVNaGlxZmg3V0NwNDBhVUJsbXlvK2ZJMmYz?=
 =?utf-8?B?QU05UVBMaFBBWmlhNXEvRnVwcUFrdUsyRGVEMGFDYkhpZWc2WnBZUFFraUtM?=
 =?utf-8?B?UGoyZm1YSDUyUzlBVnRPb2pQLzlvN3UwRXR3bEhRc1BLSmQrK0lxM2k3cUxq?=
 =?utf-8?B?dUhCYnhFYnJtMEFNRlJ6TWx3M2dxVDJnZVdnSWxwM0RuYXZWTWZJU3hzZkhM?=
 =?utf-8?B?Q2RoODhrMWljUnQ1TkkyV2ZlOXZYanpiOWF0QUgrTVFqNUpEN0wrR0JNamRC?=
 =?utf-8?B?M0lnZ2cwWk1pcG0wWCt5OS9qYkVQcXcxYjd6REpOVmxZN05leTJaZkxPejFB?=
 =?utf-8?B?TS9hU1F1d0dSbFd2RHcza0ZGWHhDWkU5ZmVaaDEyNERRZHpiMmV2VFJkY2FR?=
 =?utf-8?B?K0NKQXJ5V0I5YUplZm9KREE5bWl3b21tRVozWUN6ZVVabTcvay9NTkJRL0NC?=
 =?utf-8?B?bHFuYmVJZVpxYng0LzNYclR4dFZBRTZQLzIrM2NkV2U1cVFBVzZYSVBtTzFH?=
 =?utf-8?B?ZnNrMkxHV0NlZ2xDbjRmNWpkL3VUM3cyditXNm5KRGtXcS9GejcrWDJpTWlJ?=
 =?utf-8?B?YXpNWWRDclFQMTZkWHBwVkFkZzE0T2xkc3lGd3F3MTVJRG5XbEdiUk1keW5n?=
 =?utf-8?B?ZTRodGhvUGgrcGZ3SlBZeUhYU1o0ejIxcEtwNzhQZVJ5UVp1KzJmKzRKZE0y?=
 =?utf-8?B?QzdKaGIvTkp4ZlFZdDE2VHpYUWRUQm5yT3ByY0RHY2xNNHBxZkJCVVdtbGtv?=
 =?utf-8?B?NE5LZGZPNGd3QVVBM1JRSWszMmFPR0NEZHNuOG5rWVEwMUdQeHByQjd2djFv?=
 =?utf-8?B?SG1xVUlzTWJITlpXNTlqa1E3d1d2WS83RkpHWmNMcHB3cG9zQ3dGRGp4aGx6?=
 =?utf-8?B?Q3EwYms3Z0hrSEVJa3c0TkpESkhYNkhncTVGanhsRHZtcG1XemRDM3VDME9S?=
 =?utf-8?B?NGxJTHpTNmV2MGE0aDl2T0NZUXhTbURMTytHMkMxbDVneFJtdXR5OEwrNUZ4?=
 =?utf-8?B?RHQ4NUZLaGdDNWd4cTlzS0tyYmk2YlhLSnhwZDZVbyt3V3ZLZElETWtVaUl2?=
 =?utf-8?B?U0xFMHR5bWg2U2l5clNEZjJOZU1UbThuWlB0K2ozdWZOdTJQZ0lJSmczcUJE?=
 =?utf-8?B?RDFYY0ZDcVNRUGpiK3hpWDc1b21GT1RWMkwxYzYxL3RESktjSjltVENBaEZj?=
 =?utf-8?B?eFZwaXRkamRZeXdZWDhqS2RUU242YjN6V0FTblJoVkUydlpvNFpRUnRwTm1m?=
 =?utf-8?B?WERsNGxHY2Rtc0xiaXBhNTNqcFB2bEQ1Z21kYW9iUW1UKzBJcDJqNXZEa0J3?=
 =?utf-8?B?U0hMN0dsR3UwaFNhRTUvMkJvNVl2d3FwMC84dVRQUG1YRXdpUDVCcUJzK0do?=
 =?utf-8?B?NzhEdnZvTFllMExjRGZEZE03WlNpcWZaRWU2K2d3ZDlMbnF0RkdQSVJnUDIz?=
 =?utf-8?B?T0FZdVkyQVFPdEQyNko4ZDh4U3VheVgxS3dGdEcwaG1uTVQ0Y1ZrNFl2d0pn?=
 =?utf-8?B?ZDZkQ2hhNW5ZMjRTRkhCcFBlbVUxOE92NnNvTGgxYVdjSVgwMStSOXhmbTVW?=
 =?utf-8?B?RW02REF5WERUSHdPSTBIL1RpaFNZVDVVZ3I1NkZPYlBRRDMvdz09?=
X-Microsoft-Antispam-Message-Info: ruVfuVUhn0tCtLEwxzhzp4dLRa0S9jKs5lkg0Y6C8BvBBKTprc9OYB6PucXTUGz6mlTUfpvDHjaTkvxBkIE+fFhAS3JTQJ0HBP1Dv2UpFh9c81CVtDEL8wCtlk7628/5lupZu81wU6FRw4t4BJ9f1FTfmBIs6DB3mmuTKosb7IvQXR6X8/9Kb/TFy1vZSNxUPgu83pyoxbj+devquFJiTCwmW57x5ggD3kBhyKgL0cPenGlIXdOnurhMV7vvepzeJNr26qqZ0fuetHsVHp5eGMa3uwAClDA854D8AQQ7k30+FKN0qDkXKQBnnoRoqC62jYZckmYJ3jAfgYwqjxVPSLkj8GR5SKXMAKGh8I70r6w=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1916;6:yo1CXE2TYfm7kEO5QEaGRx04O5e8HS0+ZRiZIPdo+C4REb9vcsIW951+afPmlCv+FC3oP4EvqKOJ+X/DUpMM/bXa4HUWbg9Z6DjWhrgiM/yJBgb6B4Wob/dxnvMna+arAC2AEcjSu8AJrx0jAywkJbbuLBqs9UmQVaElv46/TlTq2HkAmfs44Ze48MHYaHEfWVf3exID0Xz/fOKttozh/nYL0VwtvK+Otg0NQQsxYFf99RQFuYQpTN5itN8aoezOFr2w9sWTCEEvRV9TUpt+iOdpHkjj3VdUFtsW6K4zR7Es97LWrD4sZfexuOJO0Fm25S25roJtnvqjw2waLualjqhL2Ky6Z6dTkgyKmD5416/5AnOOzKpvu+keBB0CJiRN9BqoppxIRp9vEyIjuFXvEqYeDUXCxaoS55jXdyIYZmNwbHm8zvUvOXajgc6SJy4Fn7sIvWucaFRNJocQ4H5krQ==;5:EsKtb+cxpWsBjepUM/E6E2g5TmaFETh3dwdzffGYAtbIlreyRfuu4WNJP/u4tg5JinOk1Lj5/WfGFLTGOQr4Ph5+o709PSpaxZCPydIK/qCZN3YKnhDAq8a4qQIwuvAg4UqWNVY1s/9dWiMQIoDNRb1/xBw4ajbh8977pM6XP8E=;24:0I0Xm7hZ4ozSxTtCdpC4lvbSx4YNWYhL8+GqsyfcLTnmn6gy7wfOYG/LWNBtMMl858Rrs3P5Ua44ci/oxivAwHMnbtpGp0MfepppPb16cOY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0201MB1916;7:asqQ9f0IzTxkGF0v+gi2jf9GTe2pDjgyepKPg/oSzMJTNfJkeE6nuNJUVsuk7SfQ0IMgjZdK5o9UdXoUWlN/FPOXHVDAimZrx7AuMQtEKTAHffQNRQlxWRINlC8+DVcYYg0Wamh5o7nkpt4mj5k9GsoixHw+5/2wlcF1RHqRECMHIezK15gIAQqmyG91q7SsHahbtJ75Kc6Y+VAR0pwYbLRP43TcZxgaXfPHkFZJm65y+P8Wd3SB45lpRJo09IGN
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 07:39:10.1891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b49cb320-20d5-460d-78f7-08d5ec818d23
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0201MB1916
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.6.2018 01:20, Luis Araneda wrote:
> According to the reference manual, the board has two Micron
> MT41K256M16HA-125 DDR3L memory ICs, which have 512 MiB each
> 
> Tested on a ZYBO-Z7-20 board
> 
> Signed-off-by: Luis Araneda <luaraneda@gmail.com>
> ---
>  arch/arm/boot/dts/zynq-zybo-z7.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/zynq-zybo-z7.dts b/arch/arm/boot/dts/zynq-zybo-z7.dts
> index 1e713dc98..bc81ebee5 100644
> --- a/arch/arm/boot/dts/zynq-zybo-z7.dts
> +++ b/arch/arm/boot/dts/zynq-zybo-z7.dts
> @@ -13,7 +13,7 @@
>  
>  	memory@0 {
>  		device_type = "memory";
> -		reg = <0x0 0x20000000>;
> +		reg = <0x0 0x40000000>;
>  	};
>  
>  	chosen {
> 

This was already applied through different series.

Thanks,
Michal
