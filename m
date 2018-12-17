Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C0CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200F8206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="FeQcP6z5";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="E4367Hx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387685AbeLQPh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:37:56 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:43940 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727760AbeLQPh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:37:56 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBHFab31018337;
        Mon, 17 Dec 2018 07:37:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=DoCNLXwKYkhNsxQZhdDQ5uZZ3MLBxxWJs6aInNA8vcU=;
 b=FeQcP6z5pRC1LWx2GmrRKZz3hES0GxpATX+JtY94etU+23yKAfB2gipNXFE0sqbTgXKe
 xi0X18cgRJoJJF64tS034Ir6YGueR4W/z/wuoS08XL00kUmw/J5evebRIw9ofnV4ABPy
 5PeoC0OPOTl0glvCPidw0SBpF7mWv52JN2oUNmCuiiFoGXKDfHbJEN+cfIKScDQWM+G9
 u6GX+Q/iSLw88m5JBgC+TPie+ZPVJB67OSSbJEZQ+kw9RRUO0e3vZ6CwD7cFlBwWHsYo
 naocV57eAKY9qhdVL7Uxj47pOk7loiZOiH3GxK5maJRHiP0NiVNGAKezPDQMnBDUC1tq 2A== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=jank@cadence.com
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2055.outbound.protection.outlook.com [104.47.49.55])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2pdbx6f47y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Dec 2018 07:37:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoCNLXwKYkhNsxQZhdDQ5uZZ3MLBxxWJs6aInNA8vcU=;
 b=E4367Hx/FMPaApMCflJy68w3m+7rYwgcSyOORDcSvnB+QFdI9iWVQvU56Q3q7w0QJTY/Qd50hW92wceCfN4oHUfmLzm+XfmPitXiBjABAdrKBk4wSg2Fm1qGwx9dSP+w3Wo9iY7cDx+JdHxJQHdupWGYnp8tHAGCrZUZEx/afR0=
Received: from CO2PR07CA0050.namprd07.prod.outlook.com (2603:10b6:100::18) by
 CY1PR07MB2165.namprd07.prod.outlook.com (2a01:111:e400:59d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.22; Mon, 17 Dec
 2018 15:37:46 +0000
Received: from DM3NAM05FT029.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::202) by CO2PR07CA0050.outlook.office365.com
 (2603:10b6:100::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1425.19 via Frontend
 Transport; Mon, 17 Dec 2018 15:37:45 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT029.mail.protection.outlook.com (10.152.98.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1446.5 via Frontend Transport; Mon, 17 Dec 2018 15:37:45 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id wBHFbfob019653
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 17 Dec 2018 10:37:42 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 17 Dec 2018 16:37:42 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 17 Dec 2018 16:37:42 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id wBHFbeok023004;
        Mon, 17 Dec 2018 15:37:40 GMT
Received: (from jank@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id wBHFbeJJ022998;
        Mon, 17 Dec 2018 15:37:40 GMT
From:   Jan Kotas <jank@cadence.com>
To:     <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kotas <jank@cadence.com>
Subject: [PATCH v2 1/2] dt-bindings: gpio: Add bindings for Cadence GPIO
Date:   Mon, 17 Dec 2018 15:36:51 +0000
Message-ID: <20181217153652.20056-2-jank@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181217153652.20056-1-jank@cadence.com>
References: <20181217153652.20056-1-jank@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(2980300002)(36092001)(189003)(199004)(81156014)(106466001)(50466002)(1076002)(76176011)(51416003)(126002)(476003)(8676002)(81166006)(8936002)(186003)(6666004)(2906002)(305945005)(486006)(336012)(26005)(11346002)(446003)(97736004)(50226002)(356004)(107886003)(53936002)(5660300001)(316002)(54906003)(478600001)(69596002)(426003)(2616005)(26826003)(86362001)(4326008)(42186006)(68736007)(87636003)(16586007)(110136005)(47776003)(105596002)(36756003)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2165;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT029;1:SJsQDPfdPt+CfPrBgEoJXruQ2Bd8Y0m4tDM363ifOULQvMc4w89Y5EAoJtYn0f3Sts4AT7TB1j7NbgdV5GB88bOCBwlX8OH0dAanf2ukMjp3KwI21tVdmF+4lW65PB6n
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 189bc1dd-e126-4443-053e-08d66435975e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:CY1PR07MB2165;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2165;3:A3cB9dLWsJy5cyPt+za1MP5RsEqqmyWs+WjcpIVnoSxoIAlZEWPZEebVuBKVZpXpVT/LL/l4OCEevAegqh/0ApFBloCDQYjfaRqAfhO/l7sWRnSv89NJTYDG7KlfcWrbbHDb/eeYHud5KCqVtNEoOT4GKMz24zWqEx9xp0g7T934p5Rx8EDJul6jd2Thx9FjlNwFBl4jbTELoBsUgXbnrUacYFoFJACjXcGVJwynjHGEGjihSVMEVANLHHyr6FFUY4Z9bQ85m1iS8+jATUe9KST2WWfzjLzm1eA8a87DDhWgKn/RYAd8FJ1vSt6gQkUZObj5WmMfPFA4Mt7/Q3ozCg==;25:8HIJ4o9aSZYix1gXW6T2wafGNgRULdpnT6e6ojVlo7boaerC0omEyPPFW8AQK4Et4D5t315CAoIeG7hpwQ8Ttmn8W0XXQjUWgzEOqCaSJxDMUUEMMjuUGknZCzHqRGk6wLnf3PdtZ/ShkjUxoxbNGmviP/uuulxlG3313/EmuRR9BgdwjhZVzVuBQu0jkADTZF4J38l5uvi3vZzX9ccSOasQDnk3EvIPPZM3z1tW5gzm4dFv7Sc53Uy283l/J00QydrJ2m0k5oLzzv9S/7GzHXat2f+g22lVxAm1yvM78zCSTtcQMZj1RJC+a8NH7YDU04EyyVFnEkShhAfEE9oThpTWRygHzet0u33fClbADek=
X-MS-TrafficTypeDiagnostic: CY1PR07MB2165:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2165;31:U7d5ug6Dsw2/4GHIfGEoAfqSmHOd1VwRcC0kOcSWNrSL2Q9F9p2EsFbvJGyD5UTYDBs//bmJWINpcAZZKkQcu48DaRqiGdzBFMffWD5kqrkLhAIDMWswkiXdfXQoPY3ZN+XsFIO/lbjoq+J7+Bt2VRZnUT9K23FD27ce8E8kSKrYMYjBQLCk/a8hoj38xmhXHynYEL0yYlo39+N1wT+uc3bGCQqwyz18cBjUypSfIDw=;20:FInvvMw0MCqv1FN6Vk93pkH5xeMYktRpbotWPRrTrd/QEtv0Be6jr52rDtOUMShr2tPVR+A9SBFUeZ7WHrcAftVdaXz6khciy5w0mu8o153wNwLTSvgS9Ze8wZTLQVi1QgPrMKjifUeGi4bjw0D21tmIeXqrhhr4OzS1E/p6w9EHJr1WPDmfjHaD5OmaZrFNzidDWeXUzvA4q/ftCGiCRM2sw04jyqKaohRCzNi1gEfiJalojMNXR9eK8tx5ANTf7rPVFgYlklhLmNVU5VwHamxWWv0GxDDGoTh2nsG0Qh6kG9GN3tBVDLW70MyRvmsHmWw0M4FGLNyAArDnclRNGQc4Qmif6KlmzuUSkmlsh2I3EK53zfaoq8pcQkQ5M0IQjZ933Tml1lH73UepPf3len+0Lv/cHGcZvpzn6atHBNi2kgfOUliEhGWk9rGh+JG4R0z0b4dmQ1hSNLA2VbChqI+X32RkmtTwQOGhRljUjlSFSivvXTQGbRb2tGbUUjLY
X-Microsoft-Antispam-PRVS: <CY1PR07MB216566E275200D69A8980511D0BC0@CY1PR07MB2165.namprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93003095)(3231475)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:CY1PR07MB2165;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2165;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2165;4:3Ot19waJxODhy64ac+XlmqE8eKCnSbSmgXncPe5FiWbJ0apBk8FNYoUgkXlDdoTWVrFAIPb1zGQBpqBLtZ1yvoYKgh9S5rOnsp0O7J6aBKyOYk16vl0IfhvvYHELNI8Jb1Y0GndGIk99f037/iyXvGt+JoUCv7ODCQFrB1NkK0t+51GONyL34GKPPLH/aO4gyNbJr0Ou/qqQWrm1dvgbVejFsh6C9IO06HeXhyabVZsEBDGr+2rq+mA6+N8RlW7vPH08C31T4x9qXO8aAIGdZg==
X-Forefront-PRVS: 08897B549D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR07MB2165;23:nOc8saeOAuiTzFStbhxz+9dwha/4dRjPs7/j975io?=
 =?us-ascii?Q?Q7UYSV9e89hlQIOcdNVBOHa3qfl59OjJdSBgQKSg4AWf9LkMsS4m+PhwuHEL?=
 =?us-ascii?Q?KaYARNw5yUvKsl0FvjWZcML/DFNkgf6Yf1YRk0F8wXkerrvqP9TrLac+3b2v?=
 =?us-ascii?Q?YZ7Abqk8NuqRX04BJyX2jKtPbRgaUWHKS+T5IZKqjZVFOvOzimNFSgvVci99?=
 =?us-ascii?Q?tv4LbGJqXgz8oKxv9QUdZfJyDNh5wngO1wCFZH0r7qvooS61jkGo8BsMMS1X?=
 =?us-ascii?Q?3gJAdDXP3L+8HIlfE9UowdPxd0A9jnXG5M8HzR3tOoP421aB0xRu7jK9fJTC?=
 =?us-ascii?Q?zluJMoZr/rgpe45QbSyrB01WZS95A9rCB5YZTMOYKYpMOoQj7k7zRij9sUL0?=
 =?us-ascii?Q?AQBG4yx+ZvQYVsU8xa4CNMbFxAnvsy3BI1w4FSev6pP61z4O1jfMUXQOb1B8?=
 =?us-ascii?Q?R0APrjXWqMGrfzwiby5DZ7hPF83DfNGvPEm7lt8z+G2X5ADoTmTh9KRZk+6e?=
 =?us-ascii?Q?DlCiLcK1XvFakLIAMPWUtXkmvI6gfhIQqWnmZjpfaEx613can02kLd9REq4j?=
 =?us-ascii?Q?dXNXDFGpdNvU5yx7m6zAEo3GrpHEULyV9JQ0vgE8qZXdeirMcFRY6GxTLDVw?=
 =?us-ascii?Q?UNBlWcbbVwrtwseN6asMgANPwZRr23IenHaXdEcj6S6F5CNAJ2G8AdrxiJT5?=
 =?us-ascii?Q?XbTPtgHFRSmC+nm/0hXbbO/n6dRjBvED6o5tS8a7CjEbN2pZvJOeAJXpQd1Y?=
 =?us-ascii?Q?MJEKIJXQYDCoe8oar+QAk6QAlr7fdW1hEDblcRfgQw/lrbe3XR44xljwxnTd?=
 =?us-ascii?Q?fn1nDPybStWKARmtIgG3qvL5FJNCam7wVbyUnqVUuQ+00fITpL/agoVVNrt/?=
 =?us-ascii?Q?0KKDBUUrwkPzOModZiyvGvbuluZ1PfHqfBcbox5QnAlc3o8yPUnvR+illS5T?=
 =?us-ascii?Q?npfBVq7LnsrAtMLoniu/C4LyfEXy4sEIm/uFwDO2zD1if5TuWQHfyPE7ooER?=
 =?us-ascii?Q?b8Nt08dQdIMzmfjWv85vJOwKpXWYb9v6/fI51MXHmiHF40BQyi4+xCqT0kZ0?=
 =?us-ascii?Q?lyGf3RxEgHZivlF0RHVvLdomwBdbh6+u3l6fUVX7HAgXrtwnfqT5Kq3/Hvjq?=
 =?us-ascii?Q?uKz6vqP4f93YeILJvAN22dnc6gjDhPqkHS221FzHTkC4kyRmyALnrRsbduya?=
 =?us-ascii?Q?EMb6w2WhSu9Ewc=3D?=
X-Microsoft-Antispam-Message-Info: Uin7x5mu9JV027F8s0tiVGZFQu6NHj9bGsd/AfFN2EV5al1gVujc+TGpvS8dqOwgLb1y1sGHJrS5zTbODglVGTn51/v5Q4zV+S848QvU0owQiRDPm6PtCH/X8PcEcQDiquznFB9SvJg00udpjd7uMN/LLDDXq5VOT7smH7VY8BdYBLYvsTq4prlYI7/WoPKIi6GZLzrmcyI/cQpvxgxuzzC9OJeZ/lnC15tpSOKdMblEbpXDcGeyEH8aTVUm0lrHNwaYZmGOx0EPhpRzR0mkJnFHXMcR81wg4UPkl26nm0ehNNwArU9Swf74fGMQ2cLD
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2165;6:dYb73AnzT4LUoMn0an7yfvq83Zu+9GOkM0pflCzVQRKk0Hm8HRmzXN0Hbl5yV2H+sa+ZO2BLmPR3aIyI+Bv3AVrPXCnahiS4RnxgXnos11FORYLO3TdYbj//MQpCcZ2aIofO7hzco0vmmSbq07VIHkEPyHy0LXOVAIyryLKeQb8vPRpgxH/+HeOrawve4YOfUGMeBxDm5Vv8lIRTkH2429uK5x7Cy3FsfseAYVGe2z1A7ApyxtscmyiZ1+BIedNCoJENEnbe82SzCChqXA75eaL/jvJZqgbjEMiMPe0bjqPtaTC0dSOk0+gGVhA4hqQ7OyqveKnXT/g0hjzWFrBIik5bMq+9Weg4ZNwHwoEY6qa5jjDo98zX6Pv6eBDU4hNaT/3xlcfgdS9GvZdq2CCL29k2hmwGhGY6kkMtSvEWIcnlQF1Ikbz97YABnALxCNrfqrpentPQVyj3ht4oxMurOw==;5:KGTk+k+ASdgcEb1qMx7WqyiNA8ZTOTdKLqN3Elr2Y/jRfQr7Pyb0TRynhoeWtrkSZRMCuNw5DAByYhR+/m8QSYEWh3xJll/AL7eKJAAJEgjd6a8xDM79jrazmATPwzpPBk/u5txQCiSahocmu4SXTBDs4YOAwUhwKgAElRgOHBY=;7:UvptXJMuct8I2RlOEa25PJlejCr50CAxJel1qVYECiDRLxH34Jh62pDchb6jjh5Hf8M9MH7VVei+tPzhfaOG1VmewpQJjPtvafUv1M0Os4cFegRgr+XkKUA5nj24BrAimX8KF0RWOg9dpQa2UfPNRA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2165;20:AjgqDG5j0nBA+G0Jsy8tqBwkMEvCSehKXB4qlUfb0oSwA7Yen1KwAJQfrld7TLOBxCJewdHM1PzgFF0Ap7R4m2yVzBQGVXlH5IfIVoxJUfdj3N7IDHVXQuzlE0zbuhH2Yz6FAoNNMjazAeWcpF948yly7CBmtg/3NGPXYpggx8IK39UgCT0wv22tQk7MiS3TVw731hs/tnyH6FL3G9Wpgyz8tszTYjv/I0z9/OocVLfzTm8hFopAYmdjcFIK/SO+
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2018 15:37:45.0850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 189bc1dd-e126-4443-053e-08d66435975e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2165
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-17_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=520 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812170139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a DT binding documentation for
Cadence GPIO controller.

Signed-off-by: Jan Kotas <jank@cadence.com>
---
 .../devicetree/bindings/gpio/cdns,gpio.txt         | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/cdns,gpio.txt

diff --git a/Documentation/devicetree/bindings/gpio/cdns,gpio.txt b/Documentation/devicetree/bindings/gpio/cdns,gpio.txt
new file mode 100644
index 000000000..c87a47827
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/cdns,gpio.txt
@@ -0,0 +1,44 @@
+Cadence GPIO controller bindings
+
+Required properties:
+- compatible: should be "cdns,gpio-r1p02".
+- reg: the register base address and size.
+- #gpio-cells: should be 2.
+	* first cell is the GPIO number.
+	* second cell specifies the GPIO flags, as defined in
+		<dt-bindings/gpio/gpio.h>. Only the GPIO_ACTIVE_HIGH
+		and GPIO_ACTIVE_LOW flags are supported.
+- gpio-controller: marks the device as a GPIO controller.
+- clocks: should contain one entry referencing the peripheral clock driving
+	the GPIO controller.
+
+Optional properties:
+- ngpios: integer number of gpio lines supported by this controller, up to 32.
+- interrupt-parent: phandle of the parent interrupt controller.
+- interrupts: interrupt specifier for the controllers interrupt.
+- interrupt-controller: marks the device as an interrupt controller. When
+	defined, interrupts, interrupt-parent and #interrupt-cells
+	are required.
+- interrupt-cells: should be 2.
+	* first cell is the GPIO number you want to use as an IRQ source.
+	* second cell specifies the IRQ type, as defined in
+		<dt-bindings/interrupt-controller/irq.h>.
+		Currently only level sensitive IRQs are supported.
+
+
+Example:
+	gpio0: gpio-controller@fd060000 {
+		compatible = "cdns,gpio-r1p02";
+		reg =<0xfd060000 0x1000>;
+
+		clocks = <&gpio_clk>;
+
+		interrupt-parent = <&gic>;
+		interrupts = <0 5 IRQ_TYPE_LEVEL_HIGH>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
-- 
2.15.0

