Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF6CC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF15B20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 11:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="EbSYLEq7";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="JXZJd2ef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730763AbfA3LFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:05:30 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:51470 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729299AbfA3LF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 06:05:29 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0UAwtC4016613;
        Wed, 30 Jan 2019 03:04:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=9j0hCCZjQbnT16PyWBsIaWZ8I/E8SMgL4sTp4oLm/dk=;
 b=EbSYLEq7W4FAojO5QtmIF2g7OclmLdwA9f/BSajJysyY1ykfbMtw9Z9gJcJvacIeoUFU
 Bo68dLC4Zc5vcvVknNAxcM/6SLOnpSyAjzETUqNsmLjvvJfl6t8Fa+NhOMslzmH/a/x9
 LyMyEn6807yBEko3XWn7Bx8EIAIHVwaE3pDZOEOJglQBijLcjzFw1+Umbc8AdRswfNTY
 VvgkM5CPW+he6U8yUbSQ78/zY9zwbzj6L2IVNkAXMvtfNDbq3vwtrlNLXAYZ/ABaW2mp
 hGBDyvSWhqbgtIu5Vhyz0mx4Gdv2Wc+7I4GOSQ5ti2L6JA0cNBadPGuMnqM6FR/tlsqu pw== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=dkos@cadence.com
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2051.outbound.protection.outlook.com [104.47.38.51])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2qa8178d88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 30 Jan 2019 03:04:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9j0hCCZjQbnT16PyWBsIaWZ8I/E8SMgL4sTp4oLm/dk=;
 b=JXZJd2efTpqizVoClGDrgDX0VdNfYyCPqtfiqQ2EYJ3GC0a9fRI9ogv0UGJVI/rPdojqBhIVQ2i3yW64wNu3Fp0zzW1uJDzXbSNkC+NszVatGs0Hn4qDhDYa2ryh4FEBwhVk2ptUYW5VZBHx5f5bSTLYD49fqQyStd78LBF6FlU=
Received: from DM5PR07CA0111.namprd07.prod.outlook.com (2603:10b6:4:ae::40) by
 MWHPR07MB3101.namprd07.prod.outlook.com (2603:10b6:300:de::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17; Wed, 30 Jan 2019 11:04:32 +0000
Received: from BY2NAM05FT060.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::206) by DM5PR07CA0111.outlook.office365.com
 (2603:10b6:4:ae::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.29 via Frontend
 Transport; Wed, 30 Jan 2019 11:04:32 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 BY2NAM05FT060.mail.protection.outlook.com (10.152.100.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.2 via Frontend Transport; Wed, 30 Jan 2019 11:04:30 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x0UB4M5l009150
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 30 Jan 2019 06:04:24 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 30 Jan 2019 12:04:21 +0100
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 30 Jan 2019 12:04:21 +0100
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id x0UB4LbU017853;
        Wed, 30 Jan 2019 11:04:21 GMT
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id x0UB4L46017845;
        Wed, 30 Jan 2019 11:04:21 GMT
From:   Damian Kos <dkos@cadence.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Andrzej Hajda" <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <dkos@cadence.com>, <rafalc@cadence.com>, <piotrs@cadence.com>,
        <quentin.schulz@bootlin.com>, <jbergsagel@ti.com>
Subject: [PATCH v7 1/4] drm/rockchip: prepare common code for cdns and rk dpi/dp driver
Date:   Wed, 30 Jan 2019 11:03:18 +0000
Message-ID: <1548846209-16406-2-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1548846209-16406-1-git-send-email-dkos@cadence.com>
References: <1548846209-16406-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(3190300001)(36092001)(199004)(189003)(86362001)(50226002)(186003)(2201001)(26005)(36756003)(356004)(6666004)(7416002)(69596002)(97736004)(8676002)(47776003)(81156014)(8936002)(81166006)(336012)(305945005)(106466001)(53946003)(54906003)(110136005)(476003)(48376002)(2906002)(50466002)(105596002)(11346002)(426003)(68736007)(486006)(446003)(76176011)(2616005)(14444005)(126002)(51416003)(30864003)(87636003)(16586007)(42186006)(4326008)(316002)(53936002)(26826003)(478600001)(921003)(83996005)(2101003)(1121003)(579004)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR07MB3101;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT060;1:EcqnJQIogyaEkUDMB0YOUX2PQ8BlkH1BEowRLxGI3v2xtH1/U88d6LfaJgD16sP3JokEvJMrVsmRX/RV2w5pOwTHRQ+yvX+3xKat6kLUKvLR3sKKjA/fh6Mey0z+CdRSBgjI8M54fH0U45X5HUQQrDbdb+BoS9Fz7dQ5Si/du5U=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f400f88-6d5e-4702-2dab-08d686a2b644
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060);SRVR:MWHPR07MB3101;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3101;3:s2sAnCd1jKo1//eSOwuKaagowqTzIijfilLhR7z+KRnaaHNY75hRlSSY4dCQQbt2X3lx51a2CJw/DQwUq5btrfdVBeBgyXeKCWRWWS05t8XT6JKMHS2XzuIkW3c2ySukKMQcg6naK9vF47uv0h670rv8aYG6EICVzhLpl5g3M6VjrOuyinbEJooCKTaFBhkOJS4v661V/JOo7fQruNsiIt3XFpdTsVr7TlfX+h/EfFL4GxBpJiMlJmSCnPcgQTZql+cAuT4xADkT8ZWa4o1vx6sIRa2Y9mT2nQUn98jNoJcB/LTl10saaXI7VkCl8RxtU4X4IB+tJFk5NGEeENSeVS7I1162v6kmQQW2M4WbPjY1G728TztJJ0aCKckyMN9D;25:632xDuKHhKKQ0aCjcqGQLSQX+lB1WyCPzqOEvfiY/WA3AXR4/LiTMLUdbvC+xPvaDJ4PG8QwglMv98UJcWe1VFNilrrljC2XaCZeF/oLzB4mpxCJX+mBypGqud/dGyDxc7hHqE1AGeICd8Afct0FlF6ZXDAcg63MmsyNUURTQMC3MGE0H10OTehnxuw+KIzSeJphkpZGg+T5D6IlIuxpxtRhey4cTs+zttbfTjFWyGfc0OOe6qKz7GNWN8W/iLJH2c+fbSf7rM9gP4WyyS6ZYkT72I827LANpMACVBWucBsYyr/yGoJizqvKdxG33PalD36nQA6PfoRfEdv794ODCw==
X-MS-TrafficTypeDiagnostic: MWHPR07MB3101:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3101;31:i3XosHj6CZLq7FHdn1EFYYCvYuyviwMsMa+HgXN5N3EG2uCGtrEsrCg8a9Ewq4w8/uHrOcXHC4+PohGVRpZY5ruk7kJ+0Sc/QsLbstxk+Irk9UlZEkP0NzLcL8J7wgb7BiUutyaXJn6ef/8GTe5yCLHsrA358nWDzz8cIgIM6pSIcneECrGn70RxAfqSDTLpDspoSASz8NtQLlpplwEyXooabkRdEbyECPaSknOaykg=;20:rDXkzE1Rogd1qHky4lb4ex2lK8QGQg00aT1MsJwXw8C9H+kjV+ci+caEyUHNNQrD6gKsHajhk5c+lOobIwuU3kmbF4qyZMXopK/ZcP2uOWAzz+smN63yeC9REFjJEvDcCgCwyAzmZcqgzAlxS0efPgsoXrJ+vq/yxRLscswM6Ms7l70jzpWKYB+66FOZafy/+fTuauUqdvur4LRmJM9/zQTz/QUpTAzTiAz3sfxfKpoau2HC/wrvalUmnAJh5EbF3c37XYQvk+ZQHa3W7WqlompKM8p72v4umHCr0viYcYxlQizOs+fFOLKmQdMzcjeg991w89owMBa/cUoCuzm4lM6t4F9HKDMRYMveEaXPfk4lnAaNW0Rp/t5zYcJJLA06ocoUXr1/Hb7RN34MtgKRuJWTP5jQ6fQucYroZVlUFppaMPhgUE3OTcIMKnKNN43mbce2KWML8maTZfHIVhFg70mg4j2jO4SFSOUqc5RlWgkLl/g0C3hJ0HFigO2G4TJw
X-Microsoft-Antispam-PRVS: <MWHPR07MB3101AE3EDEF3467CBBC9C2A9CD900@MWHPR07MB3101.namprd07.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3101;4:GND7C8BaJacj91jMpF/wvpgcZKNPVEZid++GYiiaxUzcOgmsH5EmwzQ58uIOZn1KgrnCBq+81LBGmUxzkrCj0SjIM6hH5HN+DF9nWfTAR6P/VyBB+mf576kl8Q7sF/ime3Pw3vYTIzv2esJUiyGzwAQsq6ryCeqQX6E8A3knPR1BMs9Zrz5h3ZrAIXLzt4AoTtrhWqnaHpJEq68ICObYNK4nXaws+cdpPIdM0RLY2Bnkm7gYNv9GMP0lh4lTDS+fIH9TJtDCjePW9X72J4OoT56dwalYg6NNSF07ApQKf24=
X-Forefront-PRVS: 0933E9FD8D
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR07MB3101;23:q/RaSeOhWL9tbv53PwHNmScQDVu6iUN7F96gS1M2Y?=
 =?us-ascii?Q?Aav0DASgJl7AwMq3zctaqGXEYia3rqoGzqIaDb6eB72d1bkOUtm61zj2Jd52?=
 =?us-ascii?Q?HFdEMH6Jtqybppbalb8hqD8yij9NQM7CBLHjYqkx9jKXjTLq6YZtfZnUGfq+?=
 =?us-ascii?Q?M04dmUIFGkK0rTeuwjeWbN0PceXuZpljXGFP+c2SmUJFr06AjtLehfJ44DgU?=
 =?us-ascii?Q?x37t1lysdOIeksSKU+NP5Q9MuqNO0GsNY0voh2P4/AJUNI59i+WAkoVHJT1V?=
 =?us-ascii?Q?491SuMP2KrVmRW3x9NtYTFseeoDA09Q8V2n8lPutwklQSBXlumJfIzrCyB5b?=
 =?us-ascii?Q?XILCpq6qdRRjS9WOZ/oPGK57lXrvUk9hqGTYSSjPq5AYbExZ61XIkTalJnf2?=
 =?us-ascii?Q?ygCMSHouzgzpgXrApdZupbL+gC8THTN6rwUsd4p9AJKz7AnTeL3DBARyr5aJ?=
 =?us-ascii?Q?10Ysun2RfCw2dzd8BfgmJ15qUf2pKghBqumkW+fu4V6NeDxAVI+Tx9PG9ppH?=
 =?us-ascii?Q?IPCX514AEiDYuMj+pBpPzIfGn1w/yrV6bZBqfzAUqyfa4cdk7+S5ur7ZDN8m?=
 =?us-ascii?Q?3UxNMo6keNgQ9Zjp0ZwYlCy6FAPEeWeT6hAl8EAFGSi8aIWeFufdpNQPgfB3?=
 =?us-ascii?Q?dyYyPIZBTxC3GJSPWjDGRN5ir03E81dIbT6x4+RTCKi9u134/kCZde9N7KOD?=
 =?us-ascii?Q?EU5B/S8iLKayHgbqpoKDawvNr6uie6NOeyNQFsKeR7gY2gmIuLKN78TdmVf+?=
 =?us-ascii?Q?q8nUlv+IDQ9DNfR+q1La7AmLH1p/hioEK8q6JEOE3SOdzIG1ASP/bni7q/GK?=
 =?us-ascii?Q?3GdPZ7b3PXmlaNViAoIcYWeYIr51X4CYGcKuTvLTs2wmGY07C7OqCWYdW8L0?=
 =?us-ascii?Q?0Wvo2hott70iPiz/aKp7rkcVzxospD1+qN0/BMB5uxPEkML4g3tvFniciNj/?=
 =?us-ascii?Q?gHYRH3fbHicodxzTNHl2Y3YsudodtQGeSVAORP7VHJbv5/yNrfN7pcofQdNQ?=
 =?us-ascii?Q?ZLfWWqjyCBp7i2twRv9iNQbBglnZTCGM3iffy4mVP0PARd7k+oth8CYefwKI?=
 =?us-ascii?Q?451R8YwWfyweEvqviAqXFgjJhTuhQskQjFj8wZyCc73sRlLk/rQLPJUkaiLt?=
 =?us-ascii?Q?3cUjUOP/OollmPVLeOhWbhN82jywlL0RT2lvwUr1dAjtQ+b6oe5tAry8sdZ+?=
 =?us-ascii?Q?Www0O7Zw9uz/EeiLKhfCdlO6CPuHEaWtC4sTRYjsa4HcxMX5IYTis2qfijin?=
 =?us-ascii?Q?xkKJBHKr0FCDJlrLnjjOt9j//WZyNEOcglkBa2jPR8H2NIMXVc5eolqD+vmk?=
 =?us-ascii?Q?PJFxbA2e2L77eIrhf31u/+GISvChc3Njcy7IbU5PZWRLRDEmoXNrKFjdcRwL?=
 =?us-ascii?Q?KAhZw=3D=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: VcaMN0DAj0t1QHLaaSWjSM8Jq2+uckkt5M1tHYWkL6CO3kY4dMFWcAu8VEIJoQTUxpRTJ4Otyk5cPyUWmB88YJkaAGdk7PcuqmgNR1ukSpLBTQ9Qgme2W+kQv8GH+wnSXUbz1QF26E/Wpq8Lv81uIfNHMPpaMBNL8s9LYxSaerBGvUc+0a0Ynv1JkyyULEGykbXDnKKgKIMQTHCMahGUv5oeDYuDIB9YKShY7N6oVRDmDTHJfQB3WZ1Se63V5cnoH4Pvz+H9DuDVj0anu0LBG0aP9ikRRv7fIOp0gZfV9de3GRFysNZFU2fljrjJrIp/OTz7m0ktkBygCQPzEmFSEo821Of50kmDVKk9IPQv2jkLii+2xbk93EaB0sLrIwLNwVCQNDXpcG91fNlwL3GsW30RAnDYQFG58cydpOiLfZM=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3101;6:LBBf0YnWplNY/Ox6nf0EWrfkVa/Re4xDDknorpY3bQI07qXJHxYsV/YzeRm4rNWEG/NGPDsZcdRlbElsaOW/2y33TFuD8E4zr2N8IS3mtAf6T3ZhFwvj6MoxQzHCRLCHzAC0/nyksnPOGrSDDu19/nlnrbw/aSkxsj1HWDyBnzhKUB1AccWwrI4WAGhzInakQ07/INIfucorpDkJYCfNFLG2/OlxNL9M6FwtOYt9gllH9DBxR/XHe5+inkaFeDzMfN5P2nTnLoljuUaBvW19HaJZZ/EhmjIot1Z0IH2KgYi4Qp09TQaTCoju5ydzXHn4U38I5W4eUSpjoG6Dtyam14QAq9YtjVsKslYv/wiN+I2cWtvE0E/+qvSNPqKkugt1cjfkZB0UUtAJqrYuMS+G4Y9XYWmX44y3BifadEoyx4E16u+iQVAgLpqeOUJGvEhSd8rqImiEAPt+t8aJ99waFg==;5:/zZ2AzSaE21WOMyMD2+J/uidXPs1TQVbH77HuIy/LtsTpujAuB4y8CbHOJ8v6GwE5pnlg83HgnIOGCMRgRNO1bBdnrFPKTXY+KSTZ3pS83i7Exa3mlMo8JIHuaX6lyaM2Mbk6rYA420jaGXkTt75xRvJ+ajUf8MOwp+seP90uNGoHw1Kne1vOcVP/yNgIjw0tezzS+GykPuNsTIarCBDNA==;7:r8tN/4qi1Puu7SFIqNgDA6dcSBsXThj1vTbVSDOHlbhK0FWPm5G0W8shcklln3khcM1k35Fz1zeEcd83F1tuyWzS8Y7qXs7wh2vbhe9VPuL2cpBL2l2YFA8s9/UWGfvNiUWrV1Th/hhU54A2fd2rQA==
X-Microsoft-Exchange-Diagnostics: 1;MWHPR07MB3101;20:+JTjsyH6j5BduJ6iyI/gFoKVkBJFqZpHrnFW2tk4s2m7CWF5z74T+Vnzlhj5MKDzKtBcvrGuNwu5EwY3V9+49qNtjLzb+sskak4spNCptbEw77flM693s6JuH3ANy0ffuWQGMacOFDua62RiTGss44WK/dCyVajai7Dv56xKTuPdem6sEawqtm1gwUAoDdEtG9/SMD1oUNNhkqQ5uVlxOeaevLLkBNUugqDDfBXpy3kcyw46HsHt/ziNrPchi9EX
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2019 11:04:30.4176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f400f88-6d5e-4702-2dab-08d686a2b644
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3101
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901300089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Extracted common fields from cdn_dp_device to a new cdns_mhdp_device
  structure which will be used by two separate drivers later on.
- Moved some datatypes (audio_format, audio_info, vic_pxl_encoding_format,
  video_info) from cdn-dp-core.c to cdn-dp-reg.h.
- Changed prefixes from cdn_dp to cdns_mhdp
    cdn -> cdns to match the other Cadence's drivers
    dp -> mhdp to distinguish it from a "just a DP" as the IP underneath
      this registers map can be a HDMI (which is internally different,
      but the interface for commands, events is pretty much the same).
- Modified cdn-dp-core.c to use the new driver structure and new function
  names.

Signed-off-by: Damian Kos <dkos@cadence.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/rockchip/cdn-dp-core.c | 220 +++++++------
 drivers/gpu/drm/rockchip/cdn-dp-core.h |  40 +--
 drivers/gpu/drm/rockchip/cdn-dp-reg.c  | 428 +++++++++++++------------
 drivers/gpu/drm/rockchip/cdn-dp-reg.h  | 114 +++++--
 4 files changed, 431 insertions(+), 371 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index f7b9d45aa1d6..2026bc7ffcce 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -31,11 +31,10 @@
 #include <sound/hdmi-codec.h>
 
 #include "cdn-dp-core.h"
-#include "cdn-dp-reg.h"
 #include "rockchip_drm_vop.h"
 
 #define connector_to_dp(c) \
-		container_of(c, struct cdn_dp_device, connector)
+		container_of(c, struct cdn_dp_device, mhdp.connector)
 
 #define encoder_to_dp(c) \
 		container_of(c, struct cdn_dp_device, encoder)
@@ -70,17 +69,18 @@ MODULE_DEVICE_TABLE(of, cdn_dp_dt_ids);
 static int cdn_dp_grf_write(struct cdn_dp_device *dp,
 			    unsigned int reg, unsigned int val)
 {
+	struct device *dev = dp->mhdp.dev;
 	int ret;
 
 	ret = clk_prepare_enable(dp->grf_clk);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "Failed to prepare_enable grf clock\n");
+		DRM_DEV_ERROR(dev, "Failed to prepare_enable grf clock\n");
 		return ret;
 	}
 
 	ret = regmap_write(dp->grf, reg, val);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "Could not write to GRF: %d\n", ret);
+		DRM_DEV_ERROR(dev, "Could not write to GRF: %d\n", ret);
 		return ret;
 	}
 
@@ -91,24 +91,25 @@ static int cdn_dp_grf_write(struct cdn_dp_device *dp,
 
 static int cdn_dp_clk_enable(struct cdn_dp_device *dp)
 {
+	struct device *dev = dp->mhdp.dev;
 	int ret;
 	unsigned long rate;
 
 	ret = clk_prepare_enable(dp->pclk);
 	if (ret < 0) {
-		DRM_DEV_ERROR(dp->dev, "cannot enable dp pclk %d\n", ret);
+		DRM_DEV_ERROR(dev, "cannot enable dp pclk %d\n", ret);
 		goto err_pclk;
 	}
 
 	ret = clk_prepare_enable(dp->core_clk);
 	if (ret < 0) {
-		DRM_DEV_ERROR(dp->dev, "cannot enable core_clk %d\n", ret);
+		DRM_DEV_ERROR(dev, "cannot enable core_clk %d\n", ret);
 		goto err_core_clk;
 	}
 
-	ret = pm_runtime_get_sync(dp->dev);
+	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
-		DRM_DEV_ERROR(dp->dev, "cannot get pm runtime %d\n", ret);
+		DRM_DEV_ERROR(dev, "cannot get pm runtime %d\n", ret);
 		goto err_pm_runtime_get;
 	}
 
@@ -121,18 +122,18 @@ static int cdn_dp_clk_enable(struct cdn_dp_device *dp)
 
 	rate = clk_get_rate(dp->core_clk);
 	if (!rate) {
-		DRM_DEV_ERROR(dp->dev, "get clk rate failed\n");
+		DRM_DEV_ERROR(dev, "get clk rate failed\n");
 		ret = -EINVAL;
 		goto err_set_rate;
 	}
 
-	cdn_dp_set_fw_clk(dp, rate);
-	cdn_dp_clock_reset(dp);
+	cdns_mhdp_set_fw_clk(&dp->mhdp, rate);
+	cdns_mhdp_clock_reset(&dp->mhdp);
 
 	return 0;
 
 err_set_rate:
-	pm_runtime_put(dp->dev);
+	pm_runtime_put(dev);
 err_pm_runtime_get:
 	clk_disable_unprepare(dp->core_clk);
 err_core_clk:
@@ -143,7 +144,7 @@ static int cdn_dp_clk_enable(struct cdn_dp_device *dp)
 
 static void cdn_dp_clk_disable(struct cdn_dp_device *dp)
 {
-	pm_runtime_put_sync(dp->dev);
+	pm_runtime_put_sync(dp->mhdp.dev);
 	clk_disable_unprepare(dp->pclk);
 	clk_disable_unprepare(dp->core_clk);
 }
@@ -176,7 +177,7 @@ static int cdn_dp_get_sink_count(struct cdn_dp_device *dp, u8 *sink_count)
 	u8 value;
 
 	*sink_count = 0;
-	ret = cdn_dp_dpcd_read(dp, DP_SINK_COUNT, &value, 1);
+	ret = cdns_mhdp_dpcd_read(&dp->mhdp, DP_SINK_COUNT, &value, 1);
 	if (ret)
 		return ret;
 
@@ -200,12 +201,13 @@ static struct cdn_dp_port *cdn_dp_connected_port(struct cdn_dp_device *dp)
 
 static bool cdn_dp_check_sink_connection(struct cdn_dp_device *dp)
 {
+	struct device *dev = dp->mhdp.dev;
 	unsigned long timeout = jiffies + msecs_to_jiffies(CDN_DPCD_TIMEOUT_MS);
 	struct cdn_dp_port *port;
 	u8 sink_count = 0;
 
 	if (dp->active_port < 0 || dp->active_port >= dp->ports) {
-		DRM_DEV_ERROR(dp->dev, "active_port is wrong!\n");
+		DRM_DEV_ERROR(dev, "active_port is wrong!\n");
 		return false;
 	}
 
@@ -227,7 +229,7 @@ static bool cdn_dp_check_sink_connection(struct cdn_dp_device *dp)
 		usleep_range(5000, 10000);
 	}
 
-	DRM_DEV_ERROR(dp->dev, "Get sink capability timed out\n");
+	DRM_DEV_ERROR(dev, "Get sink capability timed out\n");
 	return false;
 }
 
@@ -269,7 +271,8 @@ static int cdn_dp_connector_get_modes(struct drm_connector *connector)
 	mutex_lock(&dp->lock);
 	edid = dp->edid;
 	if (edid) {
-		DRM_DEV_DEBUG_KMS(dp->dev, "got edid: width[%d] x height[%d]\n",
+		DRM_DEV_DEBUG_KMS(dp->mhdp.dev,
+				  "got edid: width[%d] x height[%d]\n",
 				  edid->width_cm, edid->height_cm);
 
 		dp->sink_has_audio = drm_detect_monitor_audio(edid);
@@ -287,7 +290,8 @@ static int cdn_dp_connector_mode_valid(struct drm_connector *connector,
 				       struct drm_display_mode *mode)
 {
 	struct cdn_dp_device *dp = connector_to_dp(connector);
-	struct drm_display_info *display_info = &dp->connector.display_info;
+	struct drm_display_info *display_info =
+		&dp->mhdp.connector.display_info;
 	u32 requested, actual, rate, sink_max, source_max = 0;
 	u8 lanes, bpc;
 
@@ -313,7 +317,7 @@ static int cdn_dp_connector_mode_valid(struct drm_connector *connector,
 	sink_max = drm_dp_max_lane_count(dp->dpcd);
 	lanes = min(source_max, sink_max);
 
-	source_max = drm_dp_bw_code_to_link_rate(CDN_DP_MAX_LINK_RATE);
+	source_max = drm_dp_bw_code_to_link_rate(CDNS_DP_MAX_LINK_RATE);
 	sink_max = drm_dp_max_link_rate(dp->dpcd);
 	rate = min(source_max, sink_max);
 
@@ -323,7 +327,7 @@ static int cdn_dp_connector_mode_valid(struct drm_connector *connector,
 	actual = actual * 8 / 10;
 
 	if (requested > actual) {
-		DRM_DEV_DEBUG_KMS(dp->dev,
+		DRM_DEV_DEBUG_KMS(dp->mhdp.dev,
 				  "requested=%d, actual=%d, clock=%d\n",
 				  requested, actual, mode->clock);
 		return MODE_CLOCK_HIGH;
@@ -343,28 +347,29 @@ static int cdn_dp_firmware_init(struct cdn_dp_device *dp)
 	const u32 *iram_data, *dram_data;
 	const struct firmware *fw = dp->fw;
 	const struct cdn_firmware_header *hdr;
+	struct device *dev = dp->mhdp.dev;
 
 	hdr = (struct cdn_firmware_header *)fw->data;
 	if (fw->size != le32_to_cpu(hdr->size_bytes)) {
-		DRM_DEV_ERROR(dp->dev, "firmware is invalid\n");
+		DRM_DEV_ERROR(dev, "firmware is invalid\n");
 		return -EINVAL;
 	}
 
 	iram_data = (const u32 *)(fw->data + hdr->header_size);
 	dram_data = (const u32 *)(fw->data + hdr->header_size + hdr->iram_size);
 
-	ret = cdn_dp_load_firmware(dp, iram_data, hdr->iram_size,
-				   dram_data, hdr->dram_size);
+	ret = cdns_mhdp_load_firmware(&dp->mhdp, iram_data, hdr->iram_size,
+				      dram_data, hdr->dram_size);
 	if (ret)
 		return ret;
 
-	ret = cdn_dp_set_firmware_active(dp, true);
+	ret = cdns_mhdp_set_firmware_active(&dp->mhdp, true);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "active ucpu failed: %d\n", ret);
+		DRM_DEV_ERROR(dev, "active ucpu failed: %d\n", ret);
 		return ret;
 	}
 
-	return cdn_dp_event_config(dp);
+	return cdns_mhdp_event_config(&dp->mhdp);
 }
 
 static int cdn_dp_get_sink_capability(struct cdn_dp_device *dp)
@@ -374,28 +379,29 @@ static int cdn_dp_get_sink_capability(struct cdn_dp_device *dp)
 	if (!cdn_dp_check_sink_connection(dp))
 		return -ENODEV;
 
-	ret = cdn_dp_dpcd_read(dp, DP_DPCD_REV, dp->dpcd,
-			       DP_RECEIVER_CAP_SIZE);
+	ret = cdns_mhdp_dpcd_read(&dp->mhdp, DP_DPCD_REV, dp->dpcd,
+				  DP_RECEIVER_CAP_SIZE);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "Failed to get caps %d\n", ret);
+		DRM_DEV_ERROR(dp->mhdp.dev, "Failed to get caps %d\n", ret);
 		return ret;
 	}
 
 	kfree(dp->edid);
-	dp->edid = drm_do_get_edid(&dp->connector,
-				   cdn_dp_get_edid_block, dp);
+	dp->edid = drm_do_get_edid(&dp->mhdp.connector,
+				   cdns_mhdp_get_edid_block, &dp->mhdp);
 	return 0;
 }
 
 static int cdn_dp_enable_phy(struct cdn_dp_device *dp, struct cdn_dp_port *port)
 {
+	struct device *dev = dp->mhdp.dev;
 	union extcon_property_value property;
 	int ret;
 
 	if (!port->phy_enabled) {
 		ret = phy_power_on(port->phy);
 		if (ret) {
-			DRM_DEV_ERROR(dp->dev, "phy power on failed: %d\n",
+			DRM_DEV_ERROR(dev, "phy power on failed: %d\n",
 				      ret);
 			goto err_phy;
 		}
@@ -405,28 +411,28 @@ static int cdn_dp_enable_phy(struct cdn_dp_device *dp, struct cdn_dp_port *port)
 	ret = cdn_dp_grf_write(dp, GRF_SOC_CON26,
 			       DPTX_HPD_SEL_MASK | DPTX_HPD_SEL);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "Failed to write HPD_SEL %d\n", ret);
+		DRM_DEV_ERROR(dev, "Failed to write HPD_SEL %d\n", ret);
 		goto err_power_on;
 	}
 
-	ret = cdn_dp_get_hpd_status(dp);
+	ret = cdns_mhdp_get_hpd_status(&dp->mhdp);
 	if (ret <= 0) {
 		if (!ret)
-			DRM_DEV_ERROR(dp->dev, "hpd does not exist\n");
+			DRM_DEV_ERROR(dev, "hpd does not exist\n");
 		goto err_power_on;
 	}
 
 	ret = extcon_get_property(port->extcon, EXTCON_DISP_DP,
 				  EXTCON_PROP_USB_TYPEC_POLARITY, &property);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "get property failed\n");
+		DRM_DEV_ERROR(dev, "get property failed\n");
 		goto err_power_on;
 	}
 
 	port->lanes = cdn_dp_get_port_lanes(port);
-	ret = cdn_dp_set_host_cap(dp, port->lanes, property.intval);
+	ret = cdns_mhdp_set_host_cap(&dp->mhdp, port->lanes, property.intval);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "set host capabilities failed: %d\n",
+		DRM_DEV_ERROR(dev, "set host capabilities failed: %d\n",
 			      ret);
 		goto err_power_on;
 	}
@@ -436,7 +442,7 @@ static int cdn_dp_enable_phy(struct cdn_dp_device *dp, struct cdn_dp_port *port)
 
 err_power_on:
 	if (phy_power_off(port->phy))
-		DRM_DEV_ERROR(dp->dev, "phy power off failed: %d", ret);
+		DRM_DEV_ERROR(dev, "phy power off failed: %d", ret);
 	else
 		port->phy_enabled = false;
 
@@ -454,7 +460,8 @@ static int cdn_dp_disable_phy(struct cdn_dp_device *dp,
 	if (port->phy_enabled) {
 		ret = phy_power_off(port->phy);
 		if (ret) {
-			DRM_DEV_ERROR(dp->dev, "phy power off failed: %d", ret);
+			DRM_DEV_ERROR(dp->mhdp.dev,
+				      "phy power off failed: %d", ret);
 			return ret;
 		}
 	}
@@ -478,16 +485,16 @@ static int cdn_dp_disable(struct cdn_dp_device *dp)
 	ret = cdn_dp_grf_write(dp, GRF_SOC_CON26,
 			       DPTX_HPD_SEL_MASK | DPTX_HPD_DEL);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "Failed to clear hpd sel %d\n",
+		DRM_DEV_ERROR(dp->mhdp.dev, "Failed to clear hpd sel %d\n",
 			      ret);
 		return ret;
 	}
 
-	cdn_dp_set_firmware_active(dp, false);
+	cdns_mhdp_set_firmware_active(&dp->mhdp, false);
 	cdn_dp_clk_disable(dp);
 	dp->active = false;
-	dp->link.rate = 0;
-	dp->link.num_lanes = 0;
+	dp->mhdp.link.rate = 0;
+	dp->mhdp.link.num_lanes = 0;
 	if (!dp->connected) {
 		kfree(dp->edid);
 		dp->edid = NULL;
@@ -500,11 +507,11 @@ static int cdn_dp_enable(struct cdn_dp_device *dp)
 {
 	int ret, i, lanes;
 	struct cdn_dp_port *port;
+	struct device *dev = dp->mhdp.dev;
 
 	port = cdn_dp_connected_port(dp);
 	if (!port) {
-		DRM_DEV_ERROR(dp->dev,
-			      "Can't enable without connection\n");
+		DRM_DEV_ERROR(dev, "Can't enable without connection\n");
 		return -ENODEV;
 	}
 
@@ -517,7 +524,7 @@ static int cdn_dp_enable(struct cdn_dp_device *dp)
 
 	ret = cdn_dp_firmware_init(dp);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "firmware init failed: %d", ret);
+		DRM_DEV_ERROR(dp->mhdp.dev, "firmware init failed: %d", ret);
 		goto err_clk_disable;
 	}
 
@@ -551,8 +558,9 @@ static void cdn_dp_encoder_mode_set(struct drm_encoder *encoder,
 				    struct drm_display_mode *adjusted)
 {
 	struct cdn_dp_device *dp = encoder_to_dp(encoder);
-	struct drm_display_info *display_info = &dp->connector.display_info;
-	struct video_info *video = &dp->video_info;
+	struct drm_display_info *display_info =
+		&dp->mhdp.connector.display_info;
+	struct video_info *video = &dp->mhdp.video_info;
 
 	switch (display_info->bpc) {
 	case 10:
@@ -570,7 +578,7 @@ static void cdn_dp_encoder_mode_set(struct drm_encoder *encoder,
 	video->v_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_NVSYNC);
 	video->h_sync_polarity = !!(mode->flags & DRM_MODE_FLAG_NHSYNC);
 
-	memcpy(&dp->mode, adjusted, sizeof(*mode));
+	memcpy(&dp->mhdp.mode, adjusted, sizeof(*mode));
 }
 
 static bool cdn_dp_check_link_status(struct cdn_dp_device *dp)
@@ -579,11 +587,11 @@ static bool cdn_dp_check_link_status(struct cdn_dp_device *dp)
 	struct cdn_dp_port *port = cdn_dp_connected_port(dp);
 	u8 sink_lanes = drm_dp_max_lane_count(dp->dpcd);
 
-	if (!port || !dp->link.rate || !dp->link.num_lanes)
+	if (!port || !dp->mhdp.link.rate || !dp->mhdp.link.num_lanes)
 		return false;
 
-	if (cdn_dp_dpcd_read(dp, DP_LANE0_1_STATUS, link_status,
-			     DP_LINK_STATUS_SIZE)) {
+	if (cdns_mhdp_dpcd_read(&dp->mhdp, DP_LANE0_1_STATUS, link_status,
+				DP_LINK_STATUS_SIZE)) {
 		DRM_ERROR("Failed to get link status\n");
 		return false;
 	}
@@ -595,15 +603,16 @@ static bool cdn_dp_check_link_status(struct cdn_dp_device *dp)
 static void cdn_dp_encoder_enable(struct drm_encoder *encoder)
 {
 	struct cdn_dp_device *dp = encoder_to_dp(encoder);
+	struct device *dev = dp->mhdp.dev;
 	int ret, val;
 
-	ret = drm_of_encoder_active_endpoint_id(dp->dev->of_node, encoder);
+	ret = drm_of_encoder_active_endpoint_id(dev->of_node, encoder);
 	if (ret < 0) {
-		DRM_DEV_ERROR(dp->dev, "Could not get vop id, %d", ret);
+		DRM_DEV_ERROR(dev, "Could not get vop id, %d", ret);
 		return;
 	}
 
-	DRM_DEV_DEBUG_KMS(dp->dev, "vop %s output to cdn-dp\n",
+	DRM_DEV_DEBUG_KMS(dev, "vop %s output to cdn-dp\n",
 			  (ret) ? "LIT" : "BIG");
 	if (ret)
 		val = DP_SEL_VOP_LIT | (DP_SEL_VOP_LIT << 16);
@@ -618,33 +627,33 @@ static void cdn_dp_encoder_enable(struct drm_encoder *encoder)
 
 	ret = cdn_dp_enable(dp);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "Failed to enable encoder %d\n",
+		DRM_DEV_ERROR(dev, "Failed to enable encoder %d\n",
 			      ret);
 		goto out;
 	}
 	if (!cdn_dp_check_link_status(dp)) {
-		ret = cdn_dp_train_link(dp);
+		ret = cdns_mhdp_train_link(&dp->mhdp);
 		if (ret) {
-			DRM_DEV_ERROR(dp->dev, "Failed link train %d\n", ret);
+			DRM_DEV_ERROR(dev, "Failed link train %d\n", ret);
 			goto out;
 		}
 	}
 
-	ret = cdn_dp_set_video_status(dp, CONTROL_VIDEO_IDLE);
+	ret = cdns_mhdp_set_video_status(&dp->mhdp, CONTROL_VIDEO_IDLE);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "Failed to idle video %d\n", ret);
+		DRM_DEV_ERROR(dev, "Failed to idle video %d\n", ret);
 		goto out;
 	}
 
-	ret = cdn_dp_config_video(dp);
+	ret = cdns_mhdp_config_video(&dp->mhdp);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "Failed to config video %d\n", ret);
+		DRM_DEV_ERROR(dev, "Failed to config video %d\n", ret);
 		goto out;
 	}
 
-	ret = cdn_dp_set_video_status(dp, CONTROL_VIDEO_VALID);
+	ret = cdns_mhdp_set_video_status(&dp->mhdp, CONTROL_VIDEO_VALID);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "Failed to valid video %d\n", ret);
+		DRM_DEV_ERROR(dev, "Failed to valid video %d\n", ret);
 		goto out;
 	}
 out:
@@ -660,7 +669,8 @@ static void cdn_dp_encoder_disable(struct drm_encoder *encoder)
 	if (dp->active) {
 		ret = cdn_dp_disable(dp);
 		if (ret) {
-			DRM_DEV_ERROR(dp->dev, "Failed to disable encoder %d\n",
+			DRM_DEV_ERROR(dp->mhdp.dev,
+				      "Failed to disable encoder %d\n",
 				      ret);
 		}
 	}
@@ -704,7 +714,7 @@ static const struct drm_encoder_funcs cdn_dp_encoder_funcs = {
 
 static int cdn_dp_parse_dt(struct cdn_dp_device *dp)
 {
-	struct device *dev = dp->dev;
+	struct device *dev = dp->mhdp.dev;
 	struct device_node *np = dev->of_node;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *res;
@@ -716,10 +726,10 @@ static int cdn_dp_parse_dt(struct cdn_dp_device *dp)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dp->regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(dp->regs)) {
+	dp->mhdp.regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(dp->mhdp.regs)) {
 		DRM_DEV_ERROR(dev, "ioremap reg failed\n");
-		return PTR_ERR(dp->regs);
+		return PTR_ERR(dp->mhdp.regs);
 	}
 
 	dp->core_clk = devm_clk_get(dev, "core-clk");
@@ -734,10 +744,10 @@ static int cdn_dp_parse_dt(struct cdn_dp_device *dp)
 		return PTR_ERR(dp->pclk);
 	}
 
-	dp->spdif_clk = devm_clk_get(dev, "spdif");
-	if (IS_ERR(dp->spdif_clk)) {
+	dp->mhdp.spdif_clk = devm_clk_get(dev, "spdif");
+	if (IS_ERR(dp->mhdp.spdif_clk)) {
 		DRM_DEV_ERROR(dev, "cannot get spdif_clk\n");
-		return PTR_ERR(dp->spdif_clk);
+		return PTR_ERR(dp->mhdp.spdif_clk);
 	}
 
 	dp->grf_clk = devm_clk_get(dev, "grf");
@@ -746,10 +756,10 @@ static int cdn_dp_parse_dt(struct cdn_dp_device *dp)
 		return PTR_ERR(dp->grf_clk);
 	}
 
-	dp->spdif_rst = devm_reset_control_get(dev, "spdif");
-	if (IS_ERR(dp->spdif_rst)) {
+	dp->mhdp.spdif_rst = devm_reset_control_get(dev, "spdif");
+	if (IS_ERR(dp->mhdp.spdif_rst)) {
 		DRM_DEV_ERROR(dev, "no spdif reset control found\n");
-		return PTR_ERR(dp->spdif_rst);
+		return PTR_ERR(dp->mhdp.spdif_rst);
 	}
 
 	dp->dptx_rst = devm_reset_control_get(dev, "dptx");
@@ -804,7 +814,7 @@ static int cdn_dp_audio_hw_params(struct device *dev,  void *data,
 		goto out;
 	}
 
-	ret = cdn_dp_audio_config(dp, &audio);
+	ret = cdns_mhdp_audio_config(&dp->mhdp, &audio);
 	if (!ret)
 		dp->audio_info = audio;
 
@@ -822,7 +832,7 @@ static void cdn_dp_audio_shutdown(struct device *dev, void *data)
 	if (!dp->active)
 		goto out;
 
-	ret = cdn_dp_audio_stop(dp, &dp->audio_info);
+	ret = cdns_mhdp_audio_stop(&dp->mhdp, &dp->audio_info);
 	if (!ret)
 		dp->audio_info.format = AFMT_UNUSED;
 out:
@@ -841,7 +851,7 @@ static int cdn_dp_audio_digital_mute(struct device *dev, void *data,
 		goto out;
 	}
 
-	ret = cdn_dp_audio_mute(dp, enable);
+	ret = cdns_mhdp_audio_mute(&dp->mhdp, enable);
 
 out:
 	mutex_unlock(&dp->lock);
@@ -853,7 +863,8 @@ static int cdn_dp_audio_get_eld(struct device *dev, void *data,
 {
 	struct cdn_dp_device *dp = dev_get_drvdata(dev);
 
-	memcpy(buf, dp->connector.eld, min(sizeof(dp->connector.eld), len));
+	memcpy(buf, dp->mhdp.connector.eld,
+	       min(sizeof(dp->mhdp.connector.eld), len));
 
 	return 0;
 }
@@ -887,6 +898,7 @@ static int cdn_dp_request_firmware(struct cdn_dp_device *dp)
 	int ret;
 	unsigned long timeout = jiffies + msecs_to_jiffies(CDN_FW_TIMEOUT_MS);
 	unsigned long sleep = 1000;
+	struct device *dev = dp->mhdp.dev;
 
 	WARN_ON(!mutex_is_locked(&dp->lock));
 
@@ -897,13 +909,13 @@ static int cdn_dp_request_firmware(struct cdn_dp_device *dp)
 	mutex_unlock(&dp->lock);
 
 	while (time_before(jiffies, timeout)) {
-		ret = request_firmware(&dp->fw, CDN_DP_FIRMWARE, dp->dev);
+		ret = request_firmware(&dp->fw, CDN_DP_FIRMWARE, dev);
 		if (ret == -ENOENT) {
 			msleep(sleep);
 			sleep *= 2;
 			continue;
 		} else if (ret) {
-			DRM_DEV_ERROR(dp->dev,
+			DRM_DEV_ERROR(dev,
 				      "failed to request firmware: %d\n", ret);
 			goto out;
 		}
@@ -913,7 +925,7 @@ static int cdn_dp_request_firmware(struct cdn_dp_device *dp)
 		goto out;
 	}
 
-	DRM_DEV_ERROR(dp->dev, "Timed out trying to load firmware\n");
+	DRM_DEV_ERROR(dev, "Timed out trying to load firmware\n");
 	ret = -ETIMEDOUT;
 out:
 	mutex_lock(&dp->lock);
@@ -924,8 +936,9 @@ static void cdn_dp_pd_event_work(struct work_struct *work)
 {
 	struct cdn_dp_device *dp = container_of(work, struct cdn_dp_device,
 						event_work);
-	struct drm_connector *connector = &dp->connector;
+	struct drm_connector *connector = &dp->mhdp.connector;
 	enum drm_connector_status old_status;
+	struct device *dev = dp->mhdp.dev;
 
 	int ret;
 
@@ -942,44 +955,45 @@ static void cdn_dp_pd_event_work(struct work_struct *work)
 
 	/* Not connected, notify userspace to disable the block */
 	if (!cdn_dp_connected_port(dp)) {
-		DRM_DEV_INFO(dp->dev, "Not connected. Disabling cdn\n");
+		DRM_DEV_INFO(dev, "Not connected. Disabling cdn\n");
 		dp->connected = false;
 
 	/* Connected but not enabled, enable the block */
 	} else if (!dp->active) {
-		DRM_DEV_INFO(dp->dev, "Connected, not enabled. Enabling cdn\n");
+		DRM_DEV_INFO(dev, "Connected, not enabled. Enabling cdn\n");
 		ret = cdn_dp_enable(dp);
 		if (ret) {
-			DRM_DEV_ERROR(dp->dev, "Enable dp failed %d\n", ret);
+			DRM_DEV_ERROR(dev, "Enable dp failed %d\n", ret);
 			dp->connected = false;
 		}
 
 	/* Enabled and connected to a dongle without a sink, notify userspace */
 	} else if (!cdn_dp_check_sink_connection(dp)) {
-		DRM_DEV_INFO(dp->dev, "Connected without sink. Assert hpd\n");
+		DRM_DEV_INFO(dev, "Connected without sink. Assert hpd\n");
 		dp->connected = false;
 
 	/* Enabled and connected with a sink, re-train if requested */
 	} else if (!cdn_dp_check_link_status(dp)) {
-		unsigned int rate = dp->link.rate;
-		unsigned int lanes = dp->link.num_lanes;
-		struct drm_display_mode *mode = &dp->mode;
+		unsigned int rate = dp->mhdp.link.rate;
+		unsigned int lanes = dp->mhdp.link.num_lanes;
+		struct drm_display_mode *mode = &dp->mhdp.mode;
 
-		DRM_DEV_INFO(dp->dev, "Connected with sink. Re-train link\n");
-		ret = cdn_dp_train_link(dp);
+		DRM_DEV_INFO(dev, "Connected with sink. Re-train link\n");
+		ret = cdns_mhdp_train_link(&dp->mhdp);
 		if (ret) {
 			dp->connected = false;
-			DRM_DEV_ERROR(dp->dev, "Train link failed %d\n", ret);
+			DRM_DEV_ERROR(dev, "Train link failed %d\n", ret);
 			goto out;
 		}
 
 		/* If training result is changed, update the video config */
 		if (mode->clock &&
-		    (rate != dp->link.rate || lanes != dp->link.num_lanes)) {
-			ret = cdn_dp_config_video(dp);
+		    (rate != dp->mhdp.link.rate ||
+		     lanes != dp->mhdp.link.num_lanes)) {
+			ret = cdns_mhdp_config_video(&dp->mhdp);
 			if (ret) {
 				dp->connected = false;
-				DRM_DEV_ERROR(dp->dev,
+				DRM_DEV_ERROR(dev,
 					      "Failed to config video %d\n",
 					      ret);
 			}
@@ -1048,7 +1062,7 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
 
 	drm_encoder_helper_add(encoder, &cdn_dp_encoder_helper_funcs);
 
-	connector = &dp->connector;
+	connector = &dp->mhdp.connector;
 	connector->polled = DRM_CONNECTOR_POLL_HPD;
 	connector->dpms = DRM_MODE_DPMS_OFF;
 
@@ -1072,7 +1086,7 @@ static int cdn_dp_bind(struct device *dev, struct device *master, void *data)
 		port = dp->port[i];
 
 		port->event_nb.notifier_call = cdn_dp_pd_event;
-		ret = devm_extcon_register_notifier(dp->dev, port->extcon,
+		ret = devm_extcon_register_notifier(dp->mhdp.dev, port->extcon,
 						    EXTCON_DISP_DP,
 						    &port->event_nb);
 		if (ret) {
@@ -1099,7 +1113,7 @@ static void cdn_dp_unbind(struct device *dev, struct device *master, void *data)
 {
 	struct cdn_dp_device *dp = dev_get_drvdata(dev);
 	struct drm_encoder *encoder = &dp->encoder;
-	struct drm_connector *connector = &dp->connector;
+	struct drm_connector *connector = &dp->mhdp.connector;
 
 	cancel_work_sync(&dp->event_work);
 	cdn_dp_encoder_disable(encoder);
@@ -1159,7 +1173,7 @@ static int cdn_dp_probe(struct platform_device *pdev)
 	dp = devm_kzalloc(dev, sizeof(*dp), GFP_KERNEL);
 	if (!dp)
 		return -ENOMEM;
-	dp->dev = dev;
+	dp->mhdp.dev = dev;
 
 	match = of_match_node(cdn_dp_dt_ids, pdev->dev.of_node);
 	dp_data = (struct cdn_dp_data *)match->data;
@@ -1204,7 +1218,7 @@ static int cdn_dp_remove(struct platform_device *pdev)
 	struct cdn_dp_device *dp = platform_get_drvdata(pdev);
 
 	platform_device_unregister(dp->audio_pdev);
-	cdn_dp_suspend(dp->dev);
+	cdn_dp_suspend(dp->mhdp.dev);
 	component_del(&pdev->dev, &cdn_dp_component_ops);
 
 	return 0;
@@ -1214,7 +1228,7 @@ static void cdn_dp_shutdown(struct platform_device *pdev)
 {
 	struct cdn_dp_device *dp = platform_get_drvdata(pdev);
 
-	cdn_dp_suspend(dp->dev);
+	cdn_dp_suspend(dp->mhdp.dev);
 }
 
 static const struct dev_pm_ops cdn_dp_pm_ops = {
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.h b/drivers/gpu/drm/rockchip/cdn-dp-core.h
index 48fef95cb3c6..5573a6277621 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.h
@@ -20,38 +20,10 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
 #include "rockchip_drm_drv.h"
+#include "cdn-dp-reg.h"
 
 #define MAX_PHY		2
 
-enum audio_format {
-	AFMT_I2S = 0,
-	AFMT_SPDIF = 1,
-	AFMT_UNUSED,
-};
-
-struct audio_info {
-	enum audio_format format;
-	int sample_rate;
-	int channels;
-	int sample_width;
-};
-
-enum vic_pxl_encoding_format {
-	PXL_RGB = 0x1,
-	YCBCR_4_4_4 = 0x2,
-	YCBCR_4_2_2 = 0x4,
-	YCBCR_4_2_0 = 0x8,
-	Y_ONLY = 0x10,
-};
-
-struct video_info {
-	bool h_sync_polarity;
-	bool v_sync_polarity;
-	bool interlaced;
-	int color_depth;
-	enum vic_pxl_encoding_format color_fmt;
-};
-
 struct cdn_firmware_header {
 	u32 size_bytes; /* size of the entire header+image(s) in bytes */
 	u32 header_size; /* size of just the header in bytes */
@@ -70,11 +42,9 @@ struct cdn_dp_port {
 };
 
 struct cdn_dp_device {
-	struct device *dev;
+	struct cdns_mhdp_device mhdp;
 	struct drm_device *drm_dev;
-	struct drm_connector connector;
 	struct drm_encoder encoder;
-	struct drm_display_mode mode;
 	struct platform_device *audio_pdev;
 	struct work_struct event_work;
 	struct edid *edid;
@@ -85,22 +55,16 @@ struct cdn_dp_device {
 	bool suspended;
 
 	const struct firmware *fw;	/* cdn dp firmware */
-	unsigned int fw_version;	/* cdn fw version */
 	bool fw_loaded;
 
-	void __iomem *regs;
 	struct regmap *grf;
 	struct clk *core_clk;
 	struct clk *pclk;
-	struct clk *spdif_clk;
 	struct clk *grf_clk;
-	struct reset_control *spdif_rst;
 	struct reset_control *dptx_rst;
 	struct reset_control *apb_rst;
 	struct reset_control *core_rst;
 	struct audio_info audio_info;
-	struct video_info video_info;
-	struct drm_dp_link link;
 	struct cdn_dp_port *port[MAX_PHY];
 	u8 ports;
 	u8 lanes;
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.c b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
index 6c8b14fb1d2f..a32ee26fd36b 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.c
@@ -22,19 +22,19 @@
 #include "cdn-dp-core.h"
 #include "cdn-dp-reg.h"
 
-#define CDN_DP_SPDIF_CLK		200000000
+#define CDNS_DP_SPDIF_CLK		200000000
 #define FW_ALIVE_TIMEOUT_US		1000000
 #define MAILBOX_RETRY_US		1000
 #define MAILBOX_TIMEOUT_US		5000000
 #define LINK_TRAINING_RETRY_MS		20
 #define LINK_TRAINING_TIMEOUT_MS	500
 
-void cdn_dp_set_fw_clk(struct cdn_dp_device *dp, unsigned long clk)
+void cdns_mhdp_set_fw_clk(struct cdns_mhdp_device *mhdp, unsigned long clk)
 {
-	writel(clk / 1000000, dp->regs + SW_CLK_H);
+	writel(clk / 1000000, mhdp->regs + SW_CLK_H);
 }
 
-void cdn_dp_clock_reset(struct cdn_dp_device *dp)
+void cdns_mhdp_clock_reset(struct cdns_mhdp_device *mhdp)
 {
 	u32 val;
 
@@ -50,16 +50,16 @@ void cdn_dp_clock_reset(struct cdn_dp_device *dp)
 	      DPTX_SYS_CLK_EN |
 	      CFG_DPTX_VIF_CLK_RSTN_EN |
 	      CFG_DPTX_VIF_CLK_EN;
-	writel(val, dp->regs + SOURCE_DPTX_CAR);
+	writel(val, mhdp->regs + SOURCE_DPTX_CAR);
 
 	val = SOURCE_PHY_RSTN_EN | SOURCE_PHY_CLK_EN;
-	writel(val, dp->regs + SOURCE_PHY_CAR);
+	writel(val, mhdp->regs + SOURCE_PHY_CAR);
 
 	val = SOURCE_PKT_SYS_RSTN_EN |
 	      SOURCE_PKT_SYS_CLK_EN |
 	      SOURCE_PKT_DATA_RSTN_EN |
 	      SOURCE_PKT_DATA_CLK_EN;
-	writel(val, dp->regs + SOURCE_PKT_CAR);
+	writel(val, mhdp->regs + SOURCE_PKT_CAR);
 
 	val = SPDIF_CDR_CLK_RSTN_EN |
 	      SPDIF_CDR_CLK_EN |
@@ -67,53 +67,53 @@ void cdn_dp_clock_reset(struct cdn_dp_device *dp)
 	      SOURCE_AIF_SYS_CLK_EN |
 	      SOURCE_AIF_CLK_RSTN_EN |
 	      SOURCE_AIF_CLK_EN;
-	writel(val, dp->regs + SOURCE_AIF_CAR);
+	writel(val, mhdp->regs + SOURCE_AIF_CAR);
 
 	val = SOURCE_CIPHER_SYSTEM_CLK_RSTN_EN |
 	      SOURCE_CIPHER_SYS_CLK_EN |
 	      SOURCE_CIPHER_CHAR_CLK_RSTN_EN |
 	      SOURCE_CIPHER_CHAR_CLK_EN;
-	writel(val, dp->regs + SOURCE_CIPHER_CAR);
+	writel(val, mhdp->regs + SOURCE_CIPHER_CAR);
 
 	val = SOURCE_CRYPTO_SYS_CLK_RSTN_EN |
 	      SOURCE_CRYPTO_SYS_CLK_EN;
-	writel(val, dp->regs + SOURCE_CRYPTO_CAR);
+	writel(val, mhdp->regs + SOURCE_CRYPTO_CAR);
 
 	/* enable Mailbox and PIF interrupt */
-	writel(0, dp->regs + APB_INT_MASK);
+	writel(0, mhdp->regs + APB_INT_MASK);
 }
 
-static int cdn_dp_mailbox_read(struct cdn_dp_device *dp)
+static int cdns_mhdp_mailbox_read(struct cdns_mhdp_device *mhdp)
 {
 	int val, ret;
 
-	ret = readx_poll_timeout(readl, dp->regs + MAILBOX_EMPTY_ADDR,
+	ret = readx_poll_timeout(readl, mhdp->regs + MAILBOX_EMPTY_ADDR,
 				 val, !val, MAILBOX_RETRY_US,
 				 MAILBOX_TIMEOUT_US);
 	if (ret < 0)
 		return ret;
 
-	return readl(dp->regs + MAILBOX0_RD_DATA) & 0xff;
+	return readl(mhdp->regs + MAILBOX0_RD_DATA) & 0xff;
 }
 
-static int cdp_dp_mailbox_write(struct cdn_dp_device *dp, u8 val)
+static int cdp_dp_mailbox_write(struct cdns_mhdp_device *mhdp, u8 val)
 {
 	int ret, full;
 
-	ret = readx_poll_timeout(readl, dp->regs + MAILBOX_FULL_ADDR,
+	ret = readx_poll_timeout(readl, mhdp->regs + MAILBOX_FULL_ADDR,
 				 full, !full, MAILBOX_RETRY_US,
 				 MAILBOX_TIMEOUT_US);
 	if (ret < 0)
 		return ret;
 
-	writel(val, dp->regs + MAILBOX0_WR_DATA);
+	writel(val, mhdp->regs + MAILBOX0_WR_DATA);
 
 	return 0;
 }
 
-static int cdn_dp_mailbox_validate_receive(struct cdn_dp_device *dp,
-					   u8 module_id, u8 opcode,
-					   u16 req_size)
+static int cdns_mhdp_mailbox_validate_receive(struct cdns_mhdp_device *mhdp,
+					      u8 module_id, u8 opcode,
+					      u16 req_size)
 {
 	u32 mbox_size, i;
 	u8 header[4];
@@ -121,7 +121,7 @@ static int cdn_dp_mailbox_validate_receive(struct cdn_dp_device *dp,
 
 	/* read the header of the message */
 	for (i = 0; i < 4; i++) {
-		ret = cdn_dp_mailbox_read(dp);
+		ret = cdns_mhdp_mailbox_read(mhdp);
 		if (ret < 0)
 			return ret;
 
@@ -137,7 +137,7 @@ static int cdn_dp_mailbox_validate_receive(struct cdn_dp_device *dp,
 		 * clear the mailbox by reading its contents.
 		 */
 		for (i = 0; i < mbox_size; i++)
-			if (cdn_dp_mailbox_read(dp) < 0)
+			if (cdns_mhdp_mailbox_read(mhdp) < 0)
 				break;
 
 		return -EINVAL;
@@ -146,14 +146,14 @@ static int cdn_dp_mailbox_validate_receive(struct cdn_dp_device *dp,
 	return 0;
 }
 
-static int cdn_dp_mailbox_read_receive(struct cdn_dp_device *dp,
-				       u8 *buff, u16 buff_size)
+static int cdns_mhdp_mailbox_read_receive(struct cdns_mhdp_device *mhdp,
+					  u8 *buff, u16 buff_size)
 {
 	u32 i;
 	int ret;
 
 	for (i = 0; i < buff_size; i++) {
-		ret = cdn_dp_mailbox_read(dp);
+		ret = cdns_mhdp_mailbox_read(mhdp);
 		if (ret < 0)
 			return ret;
 
@@ -163,8 +163,8 @@ static int cdn_dp_mailbox_read_receive(struct cdn_dp_device *dp,
 	return 0;
 }
 
-static int cdn_dp_mailbox_send(struct cdn_dp_device *dp, u8 module_id,
-			       u8 opcode, u16 size, u8 *message)
+static int cdns_mhdp_mailbox_send(struct cdns_mhdp_device *mhdp, u8 module_id,
+				  u8 opcode, u16 size, u8 *message)
 {
 	u8 header[4];
 	int ret, i;
@@ -175,13 +175,13 @@ static int cdn_dp_mailbox_send(struct cdn_dp_device *dp, u8 module_id,
 	header[3] = size & 0xff;
 
 	for (i = 0; i < 4; i++) {
-		ret = cdp_dp_mailbox_write(dp, header[i]);
+		ret = cdp_dp_mailbox_write(mhdp, header[i]);
 		if (ret)
 			return ret;
 	}
 
 	for (i = 0; i < size; i++) {
-		ret = cdp_dp_mailbox_write(dp, message[i]);
+		ret = cdp_dp_mailbox_write(mhdp, message[i]);
 		if (ret)
 			return ret;
 	}
@@ -189,7 +189,7 @@ static int cdn_dp_mailbox_send(struct cdn_dp_device *dp, u8 module_id,
 	return 0;
 }
 
-static int cdn_dp_reg_write(struct cdn_dp_device *dp, u16 addr, u32 val)
+static int cdns_mhdp_reg_write(struct cdns_mhdp_device *mhdp, u16 addr, u32 val)
 {
 	u8 msg[6];
 
@@ -199,12 +199,12 @@ static int cdn_dp_reg_write(struct cdn_dp_device *dp, u16 addr, u32 val)
 	msg[3] = (val >> 16) & 0xff;
 	msg[4] = (val >> 8) & 0xff;
 	msg[5] = val & 0xff;
-	return cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_WRITE_REGISTER,
-				   sizeof(msg), msg);
+	return cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+				      DPTX_WRITE_REGISTER, sizeof(msg), msg);
 }
 
-static int cdn_dp_reg_write_bit(struct cdn_dp_device *dp, u16 addr,
-				u8 start_bit, u8 bits_no, u32 val)
+static int cdns_mhdp_reg_write_bit(struct cdns_mhdp_device *mhdp, u16 addr,
+				   u8 start_bit, u8 bits_no, u32 val)
 {
 	u8 field[8];
 
@@ -217,11 +217,12 @@ static int cdn_dp_reg_write_bit(struct cdn_dp_device *dp, u16 addr,
 	field[6] = (val >> 8) & 0xff;
 	field[7] = val & 0xff;
 
-	return cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_WRITE_FIELD,
-				   sizeof(field), field);
+	return cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+				      DPTX_WRITE_FIELD, sizeof(field), field);
 }
 
-int cdn_dp_dpcd_read(struct cdn_dp_device *dp, u32 addr, u8 *data, u16 len)
+int cdns_mhdp_dpcd_read(struct cdns_mhdp_device *mhdp,
+			u32 addr, u8 *data, u16 len)
 {
 	u8 msg[5], reg[5];
 	int ret;
@@ -231,28 +232,28 @@ int cdn_dp_dpcd_read(struct cdn_dp_device *dp, u32 addr, u8 *data, u16 len)
 	msg[2] = (addr >> 16) & 0xff;
 	msg[3] = (addr >> 8) & 0xff;
 	msg[4] = addr & 0xff;
-	ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_READ_DPCD,
-				  sizeof(msg), msg);
+	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+				     DPTX_READ_DPCD, sizeof(msg), msg);
 	if (ret)
 		goto err_dpcd_read;
 
-	ret = cdn_dp_mailbox_validate_receive(dp, MB_MODULE_ID_DP_TX,
-					      DPTX_READ_DPCD,
-					      sizeof(reg) + len);
+	ret = cdns_mhdp_mailbox_validate_receive(mhdp, MB_MODULE_ID_DP_TX,
+						 DPTX_READ_DPCD,
+						 sizeof(reg) + len);
 	if (ret)
 		goto err_dpcd_read;
 
-	ret = cdn_dp_mailbox_read_receive(dp, reg, sizeof(reg));
+	ret = cdns_mhdp_mailbox_read_receive(mhdp, reg, sizeof(reg));
 	if (ret)
 		goto err_dpcd_read;
 
-	ret = cdn_dp_mailbox_read_receive(dp, data, len);
+	ret = cdns_mhdp_mailbox_read_receive(mhdp, data, len);
 
 err_dpcd_read:
 	return ret;
 }
 
-int cdn_dp_dpcd_write(struct cdn_dp_device *dp, u32 addr, u8 value)
+int cdns_mhdp_dpcd_write(struct cdns_mhdp_device *mhdp, u32 addr, u8 value)
 {
 	u8 msg[6], reg[5];
 	int ret;
@@ -263,17 +264,17 @@ int cdn_dp_dpcd_write(struct cdn_dp_device *dp, u32 addr, u8 value)
 	msg[3] = (addr >> 8) & 0xff;
 	msg[4] = addr & 0xff;
 	msg[5] = value;
-	ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_WRITE_DPCD,
-				  sizeof(msg), msg);
+	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+				     DPTX_WRITE_DPCD, sizeof(msg), msg);
 	if (ret)
 		goto err_dpcd_write;
 
-	ret = cdn_dp_mailbox_validate_receive(dp, MB_MODULE_ID_DP_TX,
-					      DPTX_WRITE_DPCD, sizeof(reg));
+	ret = cdns_mhdp_mailbox_validate_receive(mhdp, MB_MODULE_ID_DP_TX,
+						 DPTX_WRITE_DPCD, sizeof(reg));
 	if (ret)
 		goto err_dpcd_write;
 
-	ret = cdn_dp_mailbox_read_receive(dp, reg, sizeof(reg));
+	ret = cdns_mhdp_mailbox_read_receive(mhdp, reg, sizeof(reg));
 	if (ret)
 		goto err_dpcd_write;
 
@@ -282,53 +283,53 @@ int cdn_dp_dpcd_write(struct cdn_dp_device *dp, u32 addr, u8 value)
 
 err_dpcd_write:
 	if (ret)
-		DRM_DEV_ERROR(dp->dev, "dpcd write failed: %d\n", ret);
+		DRM_DEV_ERROR(mhdp->dev, "dpcd write failed: %d\n", ret);
 	return ret;
 }
 
-int cdn_dp_load_firmware(struct cdn_dp_device *dp, const u32 *i_mem,
-			 u32 i_size, const u32 *d_mem, u32 d_size)
+int cdns_mhdp_load_firmware(struct cdns_mhdp_device *mhdp, const u32 *i_mem,
+			    u32 i_size, const u32 *d_mem, u32 d_size)
 {
 	u32 reg;
 	int i, ret;
 
 	/* reset ucpu before load firmware*/
 	writel(APB_IRAM_PATH | APB_DRAM_PATH | APB_XT_RESET,
-	       dp->regs + APB_CTRL);
+	       mhdp->regs + APB_CTRL);
 
 	for (i = 0; i < i_size; i += 4)
-		writel(*i_mem++, dp->regs + ADDR_IMEM + i);
+		writel(*i_mem++, mhdp->regs + ADDR_IMEM + i);
 
 	for (i = 0; i < d_size; i += 4)
-		writel(*d_mem++, dp->regs + ADDR_DMEM + i);
+		writel(*d_mem++, mhdp->regs + ADDR_DMEM + i);
 
 	/* un-reset ucpu */
-	writel(0, dp->regs + APB_CTRL);
+	writel(0, mhdp->regs + APB_CTRL);
 
 	/* check the keep alive register to make sure fw working */
-	ret = readx_poll_timeout(readl, dp->regs + KEEP_ALIVE,
+	ret = readx_poll_timeout(readl, mhdp->regs + KEEP_ALIVE,
 				 reg, reg, 2000, FW_ALIVE_TIMEOUT_US);
 	if (ret < 0) {
-		DRM_DEV_ERROR(dp->dev, "failed to loaded the FW reg = %x\n",
+		DRM_DEV_ERROR(mhdp->dev, "failed to loaded the FW reg = %x\n",
 			      reg);
 		return -EINVAL;
 	}
 
-	reg = readl(dp->regs + VER_L) & 0xff;
-	dp->fw_version = reg;
-	reg = readl(dp->regs + VER_H) & 0xff;
-	dp->fw_version |= reg << 8;
-	reg = readl(dp->regs + VER_LIB_L_ADDR) & 0xff;
-	dp->fw_version |= reg << 16;
-	reg = readl(dp->regs + VER_LIB_H_ADDR) & 0xff;
-	dp->fw_version |= reg << 24;
+	reg = readl(mhdp->regs + VER_L) & 0xff;
+	mhdp->fw_version = reg;
+	reg = readl(mhdp->regs + VER_H) & 0xff;
+	mhdp->fw_version |= reg << 8;
+	reg = readl(mhdp->regs + VER_LIB_L_ADDR) & 0xff;
+	mhdp->fw_version |= reg << 16;
+	reg = readl(mhdp->regs + VER_LIB_H_ADDR) & 0xff;
+	mhdp->fw_version |= reg << 24;
 
-	DRM_DEV_DEBUG(dp->dev, "firmware version: %x\n", dp->fw_version);
+	DRM_DEV_DEBUG(mhdp->dev, "firmware version: %x\n", mhdp->fw_version);
 
 	return 0;
 }
 
-int cdn_dp_set_firmware_active(struct cdn_dp_device *dp, bool enable)
+int cdns_mhdp_set_firmware_active(struct cdns_mhdp_device *mhdp, bool enable)
 {
 	u8 msg[5];
 	int ret, i;
@@ -340,14 +341,14 @@ int cdn_dp_set_firmware_active(struct cdn_dp_device *dp, bool enable)
 	msg[4] = enable ? FW_ACTIVE : FW_STANDBY;
 
 	for (i = 0; i < sizeof(msg); i++) {
-		ret = cdp_dp_mailbox_write(dp, msg[i]);
+		ret = cdp_dp_mailbox_write(mhdp, msg[i]);
 		if (ret)
 			goto err_set_firmware_active;
 	}
 
 	/* read the firmware state */
 	for (i = 0; i < sizeof(msg); i++)  {
-		ret = cdn_dp_mailbox_read(dp);
+		ret = cdns_mhdp_mailbox_read(mhdp);
 		if (ret < 0)
 			goto err_set_firmware_active;
 
@@ -358,16 +359,16 @@ int cdn_dp_set_firmware_active(struct cdn_dp_device *dp, bool enable)
 
 err_set_firmware_active:
 	if (ret < 0)
-		DRM_DEV_ERROR(dp->dev, "set firmware active failed\n");
+		DRM_DEV_ERROR(mhdp->dev, "set firmware active failed\n");
 	return ret;
 }
 
-int cdn_dp_set_host_cap(struct cdn_dp_device *dp, u8 lanes, bool flip)
+int cdns_mhdp_set_host_cap(struct cdns_mhdp_device *mhdp, u8 lanes, bool flip)
 {
 	u8 msg[8];
 	int ret;
 
-	msg[0] = CDN_DP_MAX_LINK_RATE;
+	msg[0] = CDNS_DP_MAX_LINK_RATE;
 	msg[1] = lanes | SCRAMBLER_EN;
 	msg[2] = VOLTAGE_LEVEL_2;
 	msg[3] = PRE_EMPHASIS_LEVEL_3;
@@ -376,22 +377,22 @@ int cdn_dp_set_host_cap(struct cdn_dp_device *dp, u8 lanes, bool flip)
 	msg[6] = flip ? LANE_MAPPING_FLIPPED : LANE_MAPPING_NORMAL;
 	msg[7] = ENHANCED;
 
-	ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX,
-				  DPTX_SET_HOST_CAPABILITIES,
-				  sizeof(msg), msg);
+	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+				     DPTX_SET_HOST_CAPABILITIES,
+				     sizeof(msg), msg);
 	if (ret)
 		goto err_set_host_cap;
 
-	ret = cdn_dp_reg_write(dp, DP_AUX_SWAP_INVERSION_CONTROL,
-			       AUX_HOST_INVERT);
+	ret = cdns_mhdp_reg_write(mhdp, DP_AUX_SWAP_INVERSION_CONTROL,
+				  AUX_HOST_INVERT);
 
 err_set_host_cap:
 	if (ret)
-		DRM_DEV_ERROR(dp->dev, "set host cap failed: %d\n", ret);
+		DRM_DEV_ERROR(mhdp->dev, "set host cap failed: %d\n", ret);
 	return ret;
 }
 
-int cdn_dp_event_config(struct cdn_dp_device *dp)
+int cdns_mhdp_event_config(struct cdns_mhdp_device *mhdp)
 {
 	u8 msg[5];
 	int ret;
@@ -400,49 +401,50 @@ int cdn_dp_event_config(struct cdn_dp_device *dp)
 
 	msg[0] = DPTX_EVENT_ENABLE_HPD | DPTX_EVENT_ENABLE_TRAINING;
 
-	ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_ENABLE_EVENT,
-				  sizeof(msg), msg);
+	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+				     DPTX_ENABLE_EVENT, sizeof(msg), msg);
 	if (ret)
-		DRM_DEV_ERROR(dp->dev, "set event config failed: %d\n", ret);
+		DRM_DEV_ERROR(mhdp->dev, "set event config failed: %d\n", ret);
 
 	return ret;
 }
 
-u32 cdn_dp_get_event(struct cdn_dp_device *dp)
+u32 cdns_mhdp_get_event(struct cdns_mhdp_device *mhdp)
 {
-	return readl(dp->regs + SW_EVENTS0);
+	return readl(mhdp->regs + SW_EVENTS0);
 }
 
-int cdn_dp_get_hpd_status(struct cdn_dp_device *dp)
+int cdns_mhdp_get_hpd_status(struct cdns_mhdp_device *mhdp)
 {
 	u8 status;
 	int ret;
 
-	ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_HPD_STATE,
-				  0, NULL);
+	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+				     DPTX_HPD_STATE, 0, NULL);
 	if (ret)
 		goto err_get_hpd;
 
-	ret = cdn_dp_mailbox_validate_receive(dp, MB_MODULE_ID_DP_TX,
-					      DPTX_HPD_STATE, sizeof(status));
+	ret = cdns_mhdp_mailbox_validate_receive(mhdp, MB_MODULE_ID_DP_TX,
+						 DPTX_HPD_STATE,
+						 sizeof(status));
 	if (ret)
 		goto err_get_hpd;
 
-	ret = cdn_dp_mailbox_read_receive(dp, &status, sizeof(status));
+	ret = cdns_mhdp_mailbox_read_receive(mhdp, &status, sizeof(status));
 	if (ret)
 		goto err_get_hpd;
 
 	return status;
 
 err_get_hpd:
-	DRM_DEV_ERROR(dp->dev, "get hpd status failed: %d\n", ret);
+	DRM_DEV_ERROR(mhdp->dev, "get hpd status failed: %d\n", ret);
 	return ret;
 }
 
-int cdn_dp_get_edid_block(void *data, u8 *edid,
+int cdns_mhdp_get_edid_block(void *data, u8 *edid,
 			  unsigned int block, size_t length)
 {
-	struct cdn_dp_device *dp = data;
+	struct cdns_mhdp_device *mhdp = data;
 	u8 msg[2], reg[2], i;
 	int ret;
 
@@ -450,22 +452,23 @@ int cdn_dp_get_edid_block(void *data, u8 *edid,
 		msg[0] = block / 2;
 		msg[1] = block % 2;
 
-		ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_GET_EDID,
-					  sizeof(msg), msg);
+		ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+					     DPTX_GET_EDID, sizeof(msg), msg);
 		if (ret)
 			continue;
 
-		ret = cdn_dp_mailbox_validate_receive(dp, MB_MODULE_ID_DP_TX,
-						      DPTX_GET_EDID,
-						      sizeof(reg) + length);
+		ret = cdns_mhdp_mailbox_validate_receive(mhdp,
+							 MB_MODULE_ID_DP_TX,
+							 DPTX_GET_EDID,
+							 sizeof(reg) + length);
 		if (ret)
 			continue;
 
-		ret = cdn_dp_mailbox_read_receive(dp, reg, sizeof(reg));
+		ret = cdns_mhdp_mailbox_read_receive(mhdp, reg, sizeof(reg));
 		if (ret)
 			continue;
 
-		ret = cdn_dp_mailbox_read_receive(dp, edid, length);
+		ret = cdns_mhdp_mailbox_read_receive(mhdp, edid, length);
 		if (ret)
 			continue;
 
@@ -474,13 +477,13 @@ int cdn_dp_get_edid_block(void *data, u8 *edid,
 	}
 
 	if (ret)
-		DRM_DEV_ERROR(dp->dev, "get block[%d] edid failed: %d\n", block,
-			      ret);
+		DRM_DEV_ERROR(mhdp->dev, "get block[%d] edid failed: %d\n",
+			      block, ret);
 
 	return ret;
 }
 
-static int cdn_dp_training_start(struct cdn_dp_device *dp)
+static int cdns_mhdp_training_start(struct cdns_mhdp_device *mhdp)
 {
 	unsigned long timeout;
 	u8 msg, event[2];
@@ -489,26 +492,28 @@ static int cdn_dp_training_start(struct cdn_dp_device *dp)
 	msg = LINK_TRAINING_RUN;
 
 	/* start training */
-	ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_TRAINING_CONTROL,
-				  sizeof(msg), &msg);
+	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+				     DPTX_TRAINING_CONTROL, sizeof(msg), &msg);
 	if (ret)
 		goto err_training_start;
 
 	timeout = jiffies + msecs_to_jiffies(LINK_TRAINING_TIMEOUT_MS);
 	while (time_before(jiffies, timeout)) {
 		msleep(LINK_TRAINING_RETRY_MS);
-		ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX,
-					  DPTX_READ_EVENT, 0, NULL);
+		ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+					     DPTX_READ_EVENT, 0, NULL);
 		if (ret)
 			goto err_training_start;
 
-		ret = cdn_dp_mailbox_validate_receive(dp, MB_MODULE_ID_DP_TX,
-						      DPTX_READ_EVENT,
-						      sizeof(event));
+		ret = cdns_mhdp_mailbox_validate_receive(mhdp,
+							 MB_MODULE_ID_DP_TX,
+							 DPTX_READ_EVENT,
+							 sizeof(event));
 		if (ret)
 			goto err_training_start;
 
-		ret = cdn_dp_mailbox_read_receive(dp, event, sizeof(event));
+		ret = cdns_mhdp_mailbox_read_receive(mhdp, event,
+						     sizeof(event));
 		if (ret)
 			goto err_training_start;
 
@@ -519,77 +524,80 @@ static int cdn_dp_training_start(struct cdn_dp_device *dp)
 	ret = -ETIMEDOUT;
 
 err_training_start:
-	DRM_DEV_ERROR(dp->dev, "training failed: %d\n", ret);
+	DRM_DEV_ERROR(mhdp->dev, "training failed: %d\n", ret);
 	return ret;
 }
 
-static int cdn_dp_get_training_status(struct cdn_dp_device *dp)
+static int cdns_mhdp_get_training_status(struct cdns_mhdp_device *mhdp)
 {
 	u8 status[10];
 	int ret;
 
-	ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_READ_LINK_STAT,
-				  0, NULL);
+	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+				     DPTX_READ_LINK_STAT, 0, NULL);
 	if (ret)
 		goto err_get_training_status;
 
-	ret = cdn_dp_mailbox_validate_receive(dp, MB_MODULE_ID_DP_TX,
-					      DPTX_READ_LINK_STAT,
-					      sizeof(status));
+	ret = cdns_mhdp_mailbox_validate_receive(mhdp, MB_MODULE_ID_DP_TX,
+						 DPTX_READ_LINK_STAT,
+						 sizeof(status));
 	if (ret)
 		goto err_get_training_status;
 
-	ret = cdn_dp_mailbox_read_receive(dp, status, sizeof(status));
+	ret = cdns_mhdp_mailbox_read_receive(mhdp, status, sizeof(status));
 	if (ret)
 		goto err_get_training_status;
 
-	dp->link.rate = status[0];
-	dp->link.num_lanes = status[1];
+	mhdp->link.rate = status[0];
+	mhdp->link.num_lanes = status[1];
 
 err_get_training_status:
 	if (ret)
-		DRM_DEV_ERROR(dp->dev, "get training status failed: %d\n", ret);
+		DRM_DEV_ERROR(mhdp->dev, "get training status failed: %d\n",
+			      ret);
 	return ret;
 }
 
-int cdn_dp_train_link(struct cdn_dp_device *dp)
+int cdns_mhdp_train_link(struct cdns_mhdp_device *mhdp)
 {
 	int ret;
 
-	ret = cdn_dp_training_start(dp);
+	ret = cdns_mhdp_training_start(mhdp);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "Failed to start training %d\n", ret);
+		DRM_DEV_ERROR(mhdp->dev, "Failed to start training %d\n",
+			      ret);
 		return ret;
 	}
 
-	ret = cdn_dp_get_training_status(dp);
+	ret = cdns_mhdp_get_training_status(mhdp);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "Failed to get training stat %d\n", ret);
+		DRM_DEV_ERROR(mhdp->dev, "Failed to get training stat %d\n",
+			      ret);
 		return ret;
 	}
 
-	DRM_DEV_DEBUG_KMS(dp->dev, "rate:0x%x, lanes:%d\n", dp->link.rate,
-			  dp->link.num_lanes);
+	DRM_DEV_DEBUG_KMS(mhdp->dev, "rate:0x%x, lanes:%d\n", mhdp->link.rate,
+			  mhdp->link.num_lanes);
 	return ret;
 }
 
-int cdn_dp_set_video_status(struct cdn_dp_device *dp, int active)
+int cdns_mhdp_set_video_status(struct cdns_mhdp_device *mhdp, int active)
 {
 	u8 msg;
 	int ret;
 
 	msg = !!active;
 
-	ret = cdn_dp_mailbox_send(dp, MB_MODULE_ID_DP_TX, DPTX_SET_VIDEO,
-				  sizeof(msg), &msg);
+	ret = cdns_mhdp_mailbox_send(mhdp, MB_MODULE_ID_DP_TX,
+				     DPTX_SET_VIDEO, sizeof(msg), &msg);
 	if (ret)
-		DRM_DEV_ERROR(dp->dev, "set video status failed: %d\n", ret);
+		DRM_DEV_ERROR(mhdp->dev, "set video status failed: %d\n", ret);
 
 	return ret;
 }
 
-static int cdn_dp_get_msa_misc(struct video_info *video,
-			       struct drm_display_mode *mode)
+static int cdns_mhdp_get_msa_misc(struct video_info *video,
+				  struct drm_display_mode *mode)
 {
 	u32 msa_misc;
 	u8 val[2] = {0};
@@ -635,10 +643,10 @@ static int cdn_dp_get_msa_misc(struct video_info *video,
 	return msa_misc;
 }
 
-int cdn_dp_config_video(struct cdn_dp_device *dp)
+int cdns_mhdp_config_video(struct cdns_mhdp_device *mhdp)
 {
-	struct video_info *video = &dp->video_info;
-	struct drm_display_mode *mode = &dp->mode;
+	struct video_info *video = &mhdp->video_info;
+	struct drm_display_mode *mode = &mhdp->mode;
 	u64 symbol;
 	u32 val, link_rate, rem;
 	u8 bit_per_pix, tu_size_reg = TU_SIZE;
@@ -647,13 +655,13 @@ int cdn_dp_config_video(struct cdn_dp_device *dp)
 	bit_per_pix = (video->color_fmt == YCBCR_4_2_2) ?
 		      (video->color_depth * 2) : (video->color_depth * 3);
 
-	link_rate = drm_dp_bw_code_to_link_rate(dp->link.rate) / 1000;
+	link_rate = drm_dp_bw_code_to_link_rate(mhdp->link.rate) / 1000;
 
-	ret = cdn_dp_reg_write(dp, BND_HSYNC2VSYNC, VIF_BYPASS_INTERLACE);
+	ret = cdns_mhdp_reg_write(mhdp, BND_HSYNC2VSYNC, VIF_BYPASS_INTERLACE);
 	if (ret)
 		goto err_config_video;
 
-	ret = cdn_dp_reg_write(dp, HSYNC2VSYNC_POL_CTRL, 0);
+	ret = cdns_mhdp_reg_write(mhdp, HSYNC2VSYNC_POL_CTRL, 0);
 	if (ret)
 		goto err_config_video;
 
@@ -667,13 +675,13 @@ int cdn_dp_config_video(struct cdn_dp_device *dp)
 	do {
 		tu_size_reg += 2;
 		symbol = tu_size_reg * mode->clock * bit_per_pix;
-		do_div(symbol, dp->link.num_lanes * link_rate * 8);
+		do_div(symbol, mhdp->link.num_lanes * link_rate * 8);
 		rem = do_div(symbol, 1000);
 		if (tu_size_reg > 64) {
 			ret = -EINVAL;
-			DRM_DEV_ERROR(dp->dev,
+			DRM_DEV_ERROR(mhdp->dev,
 				      "tu error, clk:%d, lanes:%d, rate:%d\n",
-				      mode->clock, dp->link.num_lanes,
+				      mode->clock, mhdp->link.num_lanes,
 				      link_rate);
 			goto err_config_video;
 		}
@@ -682,16 +690,16 @@ int cdn_dp_config_video(struct cdn_dp_device *dp)
 
 	val = symbol + (tu_size_reg << 8);
 	val |= TU_CNT_RST_EN;
-	ret = cdn_dp_reg_write(dp, DP_FRAMER_TU, val);
+	ret = cdns_mhdp_reg_write(mhdp, DP_FRAMER_TU, val);
 	if (ret)
 		goto err_config_video;
 
 	/* set the FIFO Buffer size */
 	val = div_u64(mode->clock * (symbol + 1), 1000) + link_rate;
-	val /= (dp->link.num_lanes * link_rate);
+	val /= (mhdp->link.num_lanes * link_rate);
 	val = div_u64(8 * (symbol + 1), bit_per_pix) - val;
 	val += 2;
-	ret = cdn_dp_reg_write(dp, DP_VC_TABLE(15), val);
+	ret = cdns_mhdp_reg_write(mhdp, DP_VC_TABLE(15), val);
 
 	switch (video->color_depth) {
 	case 6:
@@ -712,136 +720,137 @@ int cdn_dp_config_video(struct cdn_dp_device *dp)
 	};
 
 	val += video->color_fmt << 8;
-	ret = cdn_dp_reg_write(dp, DP_FRAMER_PXL_REPR, val);
+	ret = cdns_mhdp_reg_write(mhdp, DP_FRAMER_PXL_REPR, val);
 	if (ret)
 		goto err_config_video;
 
 	val = video->h_sync_polarity ? DP_FRAMER_SP_HSP : 0;
 	val |= video->v_sync_polarity ? DP_FRAMER_SP_VSP : 0;
-	ret = cdn_dp_reg_write(dp, DP_FRAMER_SP, val);
+	ret = cdns_mhdp_reg_write(mhdp, DP_FRAMER_SP, val);
 	if (ret)
 		goto err_config_video;
 
 	val = (mode->hsync_start - mode->hdisplay) << 16;
 	val |= mode->htotal - mode->hsync_end;
-	ret = cdn_dp_reg_write(dp, DP_FRONT_BACK_PORCH, val);
+	ret = cdns_mhdp_reg_write(mhdp, DP_FRONT_BACK_PORCH, val);
 	if (ret)
 		goto err_config_video;
 
 	val = mode->hdisplay * bit_per_pix / 8;
-	ret = cdn_dp_reg_write(dp, DP_BYTE_COUNT, val);
+	ret = cdns_mhdp_reg_write(mhdp, DP_BYTE_COUNT, val);
 	if (ret)
 		goto err_config_video;
 
 	val = mode->htotal | ((mode->htotal - mode->hsync_start) << 16);
-	ret = cdn_dp_reg_write(dp, MSA_HORIZONTAL_0, val);
+	ret = cdns_mhdp_reg_write(mhdp, MSA_HORIZONTAL_0, val);
 	if (ret)
 		goto err_config_video;
 
 	val = mode->hsync_end - mode->hsync_start;
 	val |= (mode->hdisplay << 16) | (video->h_sync_polarity << 15);
-	ret = cdn_dp_reg_write(dp, MSA_HORIZONTAL_1, val);
+	ret = cdns_mhdp_reg_write(mhdp, MSA_HORIZONTAL_1, val);
 	if (ret)
 		goto err_config_video;
 
 	val = mode->vtotal;
 	val |= (mode->vtotal - mode->vsync_start) << 16;
-	ret = cdn_dp_reg_write(dp, MSA_VERTICAL_0, val);
+	ret = cdns_mhdp_reg_write(mhdp, MSA_VERTICAL_0, val);
 	if (ret)
 		goto err_config_video;
 
 	val = mode->vsync_end - mode->vsync_start;
 	val |= (mode->vdisplay << 16) | (video->v_sync_polarity << 15);
-	ret = cdn_dp_reg_write(dp, MSA_VERTICAL_1, val);
+	ret = cdns_mhdp_reg_write(mhdp, MSA_VERTICAL_1, val);
 	if (ret)
 		goto err_config_video;
 
-	val = cdn_dp_get_msa_misc(video, mode);
-	ret = cdn_dp_reg_write(dp, MSA_MISC, val);
+	val = cdns_mhdp_get_msa_misc(video, mode);
+	ret = cdns_mhdp_reg_write(mhdp, MSA_MISC, val);
 	if (ret)
 		goto err_config_video;
 
-	ret = cdn_dp_reg_write(dp, STREAM_CONFIG, 1);
+	ret = cdns_mhdp_reg_write(mhdp, STREAM_CONFIG, 1);
 	if (ret)
 		goto err_config_video;
 
 	val = mode->hsync_end - mode->hsync_start;
 	val |= mode->hdisplay << 16;
-	ret = cdn_dp_reg_write(dp, DP_HORIZONTAL, val);
+	ret = cdns_mhdp_reg_write(mhdp, DP_HORIZONTAL, val);
 	if (ret)
 		goto err_config_video;
 
 	val = mode->vdisplay;
 	val |= (mode->vtotal - mode->vsync_start) << 16;
-	ret = cdn_dp_reg_write(dp, DP_VERTICAL_0, val);
+	ret = cdns_mhdp_reg_write(mhdp, DP_VERTICAL_0, val);
 	if (ret)
 		goto err_config_video;
 
 	val = mode->vtotal;
-	ret = cdn_dp_reg_write(dp, DP_VERTICAL_1, val);
+	ret = cdns_mhdp_reg_write(mhdp, DP_VERTICAL_1, val);
 	if (ret)
 		goto err_config_video;
 
-	ret = cdn_dp_reg_write_bit(dp, DP_VB_ID, 2, 1, 0);
+	ret = cdns_mhdp_reg_write_bit(mhdp, DP_VB_ID, 2, 1, 0);
 
 err_config_video:
 	if (ret)
-		DRM_DEV_ERROR(dp->dev, "config video failed: %d\n", ret);
+		DRM_DEV_ERROR(mhdp->dev, "config video failed: %d\n", ret);
 	return ret;
 }
 
-int cdn_dp_audio_stop(struct cdn_dp_device *dp, struct audio_info *audio)
+int cdns_mhdp_audio_stop(struct cdns_mhdp_device *mhdp,
+			 struct audio_info *audio)
 {
 	int ret;
 
-	ret = cdn_dp_reg_write(dp, AUDIO_PACK_CONTROL, 0);
+	ret = cdns_mhdp_reg_write(mhdp, AUDIO_PACK_CONTROL, 0);
 	if (ret) {
-		DRM_DEV_ERROR(dp->dev, "audio stop failed: %d\n", ret);
+		DRM_DEV_ERROR(mhdp->dev, "audio stop failed: %d\n", ret);
 		return ret;
 	}
 
-	writel(0, dp->regs + SPDIF_CTRL_ADDR);
+	writel(0, mhdp->regs + SPDIF_CTRL_ADDR);
 
 	/* clearn the audio config and reset */
-	writel(0, dp->regs + AUDIO_SRC_CNTL);
-	writel(0, dp->regs + AUDIO_SRC_CNFG);
-	writel(AUDIO_SW_RST, dp->regs + AUDIO_SRC_CNTL);
-	writel(0, dp->regs + AUDIO_SRC_CNTL);
+	writel(0, mhdp->regs + AUDIO_SRC_CNTL);
+	writel(0, mhdp->regs + AUDIO_SRC_CNFG);
+	writel(AUDIO_SW_RST, mhdp->regs + AUDIO_SRC_CNTL);
+	writel(0, mhdp->regs + AUDIO_SRC_CNTL);
 
 	/* reset smpl2pckt component  */
-	writel(0, dp->regs + SMPL2PKT_CNTL);
-	writel(AUDIO_SW_RST, dp->regs + SMPL2PKT_CNTL);
-	writel(0, dp->regs + SMPL2PKT_CNTL);
+	writel(0, mhdp->regs + SMPL2PKT_CNTL);
+	writel(AUDIO_SW_RST, mhdp->regs + SMPL2PKT_CNTL);
+	writel(0, mhdp->regs + SMPL2PKT_CNTL);
 
 	/* reset FIFO */
-	writel(AUDIO_SW_RST, dp->regs + FIFO_CNTL);
-	writel(0, dp->regs + FIFO_CNTL);
+	writel(AUDIO_SW_RST, mhdp->regs + FIFO_CNTL);
+	writel(0, mhdp->regs + FIFO_CNTL);
 
 	if (audio->format == AFMT_SPDIF)
-		clk_disable_unprepare(dp->spdif_clk);
+		clk_disable_unprepare(mhdp->spdif_clk);
 
 	return 0;
 }
 
-int cdn_dp_audio_mute(struct cdn_dp_device *dp, bool enable)
+int cdns_mhdp_audio_mute(struct cdns_mhdp_device *mhdp, bool enable)
 {
 	int ret;
 
-	ret = cdn_dp_reg_write_bit(dp, DP_VB_ID, 4, 1, enable);
+	ret = cdns_mhdp_reg_write_bit(mhdp, DP_VB_ID, 4, 1, enable);
 	if (ret)
-		DRM_DEV_ERROR(dp->dev, "audio mute failed: %d\n", ret);
+		DRM_DEV_ERROR(mhdp->dev, "audio mute failed: %d\n", ret);
 
 	return ret;
 }
 
-static void cdn_dp_audio_config_i2s(struct cdn_dp_device *dp,
-				    struct audio_info *audio)
+static void cdns_mhdp_audio_config_i2s(struct cdns_mhdp_device *mhdp,
+				       struct audio_info *audio)
 {
 	int sub_pckt_num = 1, i2s_port_en_val = 0xf, i;
 	u32 val;
 
 	if (audio->channels == 2) {
-		if (dp->link.num_lanes == 1)
+		if (mhdp->link.num_lanes == 1)
 			sub_pckt_num = 2;
 		else
 			sub_pckt_num = 4;
@@ -851,15 +860,15 @@ static void cdn_dp_audio_config_i2s(struct cdn_dp_device *dp,
 		i2s_port_en_val = 3;
 	}
 
-	writel(0x0, dp->regs + SPDIF_CTRL_ADDR);
+	writel(0x0, mhdp->regs + SPDIF_CTRL_ADDR);
 
-	writel(SYNC_WR_TO_CH_ZERO, dp->regs + FIFO_CNTL);
+	writel(SYNC_WR_TO_CH_ZERO, mhdp->regs + FIFO_CNTL);
 
 	val = MAX_NUM_CH(audio->channels);
 	val |= NUM_OF_I2S_PORTS(audio->channels);
 	val |= AUDIO_TYPE_LPCM;
 	val |= CFG_SUB_PCKT_NUM(sub_pckt_num);
-	writel(val, dp->regs + SMPL2PKT_CNFG);
+	writel(val, mhdp->regs + SMPL2PKT_CNFG);
 
 	if (audio->sample_width == 16)
 		val = 0;
@@ -871,7 +880,7 @@ static void cdn_dp_audio_config_i2s(struct cdn_dp_device *dp,
 	val |= AUDIO_CH_NUM(audio->channels);
 	val |= I2S_DEC_PORT_EN(i2s_port_en_val);
 	val |= TRANS_SMPL_WIDTH_32;
-	writel(val, dp->regs + AUDIO_SRC_CNFG);
+	writel(val, mhdp->regs + AUDIO_SRC_CNFG);
 
 	for (i = 0; i < (audio->channels + 1) / 2; i++) {
 		if (audio->sample_width == 16)
@@ -880,7 +889,7 @@ static void cdn_dp_audio_config_i2s(struct cdn_dp_device *dp,
 			val = (0x0b << 8) | (0x0b << 20);
 
 		val |= ((2 * i) << 4) | ((2 * i + 1) << 16);
-		writel(val, dp->regs + STTS_BIT_CH(i));
+		writel(val, mhdp->regs + STTS_BIT_CH(i));
 	}
 
 	switch (audio->sample_rate) {
@@ -914,56 +923,57 @@ static void cdn_dp_audio_config_i2s(struct cdn_dp_device *dp,
 		break;
 	}
 	val |= 4;
-	writel(val, dp->regs + COM_CH_STTS_BITS);
+	writel(val, mhdp->regs + COM_CH_STTS_BITS);
 
-	writel(SMPL2PKT_EN, dp->regs + SMPL2PKT_CNTL);
-	writel(I2S_DEC_START, dp->regs + AUDIO_SRC_CNTL);
+	writel(SMPL2PKT_EN, mhdp->regs + SMPL2PKT_CNTL);
+	writel(I2S_DEC_START, mhdp->regs + AUDIO_SRC_CNTL);
 }
 
-static void cdn_dp_audio_config_spdif(struct cdn_dp_device *dp)
+static void cdns_mhdp_audio_config_spdif(struct cdns_mhdp_device *mhdp)
 {
 	u32 val;
 
-	writel(SYNC_WR_TO_CH_ZERO, dp->regs + FIFO_CNTL);
+	writel(SYNC_WR_TO_CH_ZERO, mhdp->regs + FIFO_CNTL);
 
 	val = MAX_NUM_CH(2) | AUDIO_TYPE_LPCM | CFG_SUB_PCKT_NUM(4);
-	writel(val, dp->regs + SMPL2PKT_CNFG);
-	writel(SMPL2PKT_EN, dp->regs + SMPL2PKT_CNTL);
+	writel(val, mhdp->regs + SMPL2PKT_CNFG);
+	writel(SMPL2PKT_EN, mhdp->regs + SMPL2PKT_CNTL);
 
 	val = SPDIF_ENABLE | SPDIF_AVG_SEL | SPDIF_JITTER_BYPASS;
-	writel(val, dp->regs + SPDIF_CTRL_ADDR);
+	writel(val, mhdp->regs + SPDIF_CTRL_ADDR);
 
-	clk_prepare_enable(dp->spdif_clk);
-	clk_set_rate(dp->spdif_clk, CDN_DP_SPDIF_CLK);
+	clk_prepare_enable(mhdp->spdif_clk);
+	clk_set_rate(mhdp->spdif_clk, CDNS_DP_SPDIF_CLK);
 }
 
-int cdn_dp_audio_config(struct cdn_dp_device *dp, struct audio_info *audio)
+int cdns_mhdp_audio_config(struct cdns_mhdp_device *mhdp,
+			   struct audio_info *audio)
 {
 	int ret;
 
 	/* reset the spdif clk before config */
 	if (audio->format == AFMT_SPDIF) {
-		reset_control_assert(dp->spdif_rst);
-		reset_control_deassert(dp->spdif_rst);
+		reset_control_assert(mhdp->spdif_rst);
+		reset_control_deassert(mhdp->spdif_rst);
 	}
 
-	ret = cdn_dp_reg_write(dp, CM_LANE_CTRL, LANE_REF_CYC);
+	ret = cdns_mhdp_reg_write(mhdp, CM_LANE_CTRL, LANE_REF_CYC);
 	if (ret)
 		goto err_audio_config;
 
-	ret = cdn_dp_reg_write(dp, CM_CTRL, 0);
+	ret = cdns_mhdp_reg_write(mhdp, CM_CTRL, 0);
 	if (ret)
 		goto err_audio_config;
 
 	if (audio->format == AFMT_I2S)
-		cdn_dp_audio_config_i2s(dp, audio);
+		cdns_mhdp_audio_config_i2s(mhdp, audio);
 	else if (audio->format == AFMT_SPDIF)
-		cdn_dp_audio_config_spdif(dp);
+		cdns_mhdp_audio_config_spdif(mhdp);
 
-	ret = cdn_dp_reg_write(dp, AUDIO_PACK_CONTROL, AUDIO_PACK_EN);
+	ret = cdns_mhdp_reg_write(mhdp, AUDIO_PACK_CONTROL, AUDIO_PACK_EN);
 
 err_audio_config:
 	if (ret)
-		DRM_DEV_ERROR(dp->dev, "audio config failed: %d\n", ret);
+		DRM_DEV_ERROR(mhdp->dev, "audio config failed: %d\n", ret);
 	return ret;
 }
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-reg.h b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
index c4bbb4a83319..3cb40d719515 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-reg.h
+++ b/drivers/gpu/drm/rockchip/cdn-dp-reg.h
@@ -395,7 +395,7 @@
 #define HDCP_TX_IS_RECEIVER_ID_VALID_EVENT	BIT(7)
 
 #define TU_SIZE					30
-#define CDN_DP_MAX_LINK_RATE			DP_LINK_BW_5_4
+#define CDNS_DP_MAX_LINK_RATE			DP_LINK_BW_5_4
 
 /* audio */
 #define AUDIO_PACK_EN				BIT(8)
@@ -459,24 +459,96 @@ enum vic_bt_type {
 	BT_709 = 0x1,
 };
 
-void cdn_dp_clock_reset(struct cdn_dp_device *dp);
-
-void cdn_dp_set_fw_clk(struct cdn_dp_device *dp, unsigned long clk);
-int cdn_dp_load_firmware(struct cdn_dp_device *dp, const u32 *i_mem,
-			 u32 i_size, const u32 *d_mem, u32 d_size);
-int cdn_dp_set_firmware_active(struct cdn_dp_device *dp, bool enable);
-int cdn_dp_set_host_cap(struct cdn_dp_device *dp, u8 lanes, bool flip);
-int cdn_dp_event_config(struct cdn_dp_device *dp);
-u32 cdn_dp_get_event(struct cdn_dp_device *dp);
-int cdn_dp_get_hpd_status(struct cdn_dp_device *dp);
-int cdn_dp_dpcd_write(struct cdn_dp_device *dp, u32 addr, u8 value);
-int cdn_dp_dpcd_read(struct cdn_dp_device *dp, u32 addr, u8 *data, u16 len);
-int cdn_dp_get_edid_block(void *dp, u8 *edid,
-			  unsigned int block, size_t length);
-int cdn_dp_train_link(struct cdn_dp_device *dp);
-int cdn_dp_set_video_status(struct cdn_dp_device *dp, int active);
-int cdn_dp_config_video(struct cdn_dp_device *dp);
-int cdn_dp_audio_stop(struct cdn_dp_device *dp, struct audio_info *audio);
-int cdn_dp_audio_mute(struct cdn_dp_device *dp, bool enable);
-int cdn_dp_audio_config(struct cdn_dp_device *dp, struct audio_info *audio);
+enum audio_format {
+	AFMT_I2S = 0,
+	AFMT_SPDIF = 1,
+	AFMT_UNUSED,
+};
+
+struct audio_info {
+	enum audio_format format;
+	int sample_rate;
+	int channels;
+	int sample_width;
+};
+
+enum vic_pxl_encoding_format {
+	PXL_RGB = 0x1,
+	YCBCR_4_4_4 = 0x2,
+	YCBCR_4_2_2 = 0x4,
+	YCBCR_4_2_0 = 0x8,
+	Y_ONLY = 0x10,
+};
+
+struct video_info {
+	bool h_sync_polarity;
+	bool v_sync_polarity;
+	bool interlaced;
+	int color_depth;
+	enum vic_pxl_encoding_format color_fmt;
+};
+
+struct cdns_mhdp_host {
+	unsigned int	link_rate;
+	u8	lanes_cnt;
+	u8	volt_swing;
+	u8	pre_emphasis;
+	u8	pattern_supp;
+	u8	fast_link;
+	u8	lane_mapping;
+	u8	enhanced;
+};
+
+struct cdns_mhdp_sink {
+	unsigned int	link_rate;
+	u8	lanes_cnt;
+	u8	pattern_supp;
+	u8	fast_link;
+	u8	enhanced;
+};
+
+struct cdns_mhdp_device {
+	void __iomem		*regs;
+
+	struct device		*dev;
+
+	struct drm_dp_link	link;
+	struct drm_connector	connector;
+	struct clk		*spdif_clk;
+	struct reset_control	*spdif_rst;
+
+	struct drm_dp_aux	aux;
+	struct cdns_mhdp_host	host;
+	struct cdns_mhdp_sink	sink;
+	struct drm_bridge	bridge;
+	struct phy		*phy;
+	void __iomem		*dbg_regs;
+
+	struct video_info	video_info;
+	struct drm_display_mode	mode;
+	unsigned int		fw_version;
+};
+
+void cdns_mhdp_clock_reset(struct cdns_mhdp_device *mhdp);
+void cdns_mhdp_set_fw_clk(struct cdns_mhdp_device *mhdp, unsigned long clk);
+int cdns_mhdp_load_firmware(struct cdns_mhdp_device *mhdp, const u32 *i_mem,
+			    u32 i_size, const u32 *d_mem, u32 d_size);
+int cdns_mhdp_set_firmware_active(struct cdns_mhdp_device *mhdp, bool enable);
+int cdns_mhdp_set_host_cap(struct cdns_mhdp_device *mhdp, u8 lanes, bool flip);
+int cdns_mhdp_event_config(struct cdns_mhdp_device *mhdp);
+u32 cdns_mhdp_get_event(struct cdns_mhdp_device *mhdp);
+int cdns_mhdp_get_hpd_status(struct cdns_mhdp_device *mhdp);
+int cdns_mhdp_dpcd_write(struct cdns_mhdp_device *mhdp, u32 addr, u8 value);
+int cdns_mhdp_dpcd_read(struct cdns_mhdp_device *mhdp,
+			u32 addr, u8 *data, u16 len);
+int cdns_mhdp_get_edid_block(void *mhdp, u8 *edid,
+			     unsigned int block, size_t length);
+int cdns_mhdp_train_link(struct cdns_mhdp_device *mhdp);
+int cdns_mhdp_set_video_status(struct cdns_mhdp_device *mhdp, int active);
+int cdns_mhdp_config_video(struct cdns_mhdp_device *mhdp);
+int cdns_mhdp_audio_stop(struct cdns_mhdp_device *mhdp,
+			 struct audio_info *audio);
+int cdns_mhdp_audio_mute(struct cdns_mhdp_device *mhdp, bool enable);
+int cdns_mhdp_audio_config(struct cdns_mhdp_device *mhdp,
+			   struct audio_info *audio);
 #endif /* _CDN_DP_REG_H */
-- 
2.17.1

