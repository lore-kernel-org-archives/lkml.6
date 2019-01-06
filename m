Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE096C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87802070C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 19:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="EpNVBHTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfAFT4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 14:56:14 -0500
Received: from mail-eopbgr810107.outbound.protection.outlook.com ([40.107.81.107]:36256
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726050AbfAFT4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 14:56:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zqh+TB4l9kal5cswx8fIBIlYtr/63Uoua/vB1+lggow=;
 b=EpNVBHTJuRW96LUSf+qc8yNngvwj81/bir/tPuD8ALF1pSIloZOAordmKGiVZDFAAhuJReEnl8/gJlNpSPMPArCvwA1MyQOUZySeLH9KBNtuLoWzndoxWzTk8uf9onyNMEAVjm8sFwni7/RX2usWye6oAH3U38hTczve7xlMif0=
Received: from BL0PR0102CA0040.prod.exchangelabs.com (2603:10b6:208:25::17) by
 BYAPR01MB4022.prod.exchangelabs.com (2603:10b6:a03:16::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Sun, 6 Jan 2019 19:56:10 +0000
Received: from CO1NAM03FT059.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::201) by BL0PR0102CA0040.outlook.office365.com
 (2603:10b6:208:25::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1495.6 via Frontend
 Transport; Sun, 6 Jan 2019 19:56:09 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 CO1NAM03FT059.mail.protection.outlook.com (10.152.81.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1471.13 via Frontend Transport; Sun, 6 Jan 2019 19:56:08 +0000
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x06Ju6hH016222
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 6 Jan 2019 14:56:07 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5E98E7A4BFD; Sun,  6 Jan 2019 14:56:06 -0500 (EST)
Date:   Sun, 6 Jan 2019 14:56:06 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-fscrypt@vger.kernel.org>
Subject: Re: [GIT PULL] fscrypt update for 4.21
Message-ID: <20190106195606.GA6741@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fscrypt@vger.kernel.org
References: <20190106134912.GA27028@mit.edu>
 <20190106172005.GA699@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190106172005.GA699@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(136003)(346002)(2980300002)(189003)(199004)(2616005)(6266002)(106002)(97756001)(36756003)(47776003)(336012)(6246003)(1076003)(246002)(356004)(446003)(305945005)(8936002)(8676002)(42186006)(16586007)(36906005)(316002)(54906003)(786003)(11346002)(26005)(486006)(186003)(126002)(90966002)(4326008)(476003)(33656002)(229853002)(23726003)(50466002)(6916009)(88552002)(86362001)(106466001)(75432002)(103686004)(46406003)(478600001)(76176011)(2906002)(58126008)(5660300001)(52956003)(26826003)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR01MB4022;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT059;1:ZHzfkciGcAvEw3Soxu0iRTD+FTViN5v9Vs2mv5Verz7PCFmMuXeP3SzuKmEmslrXWfMJDoQZBusocHf5ZKMoh/t0RPcoTIM5mqjECFay1OjI0KB0wzbSCdXE6aV/U1Xb
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bae9b112-4359-4f5e-475c-08d6741100ae
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4608076)(4709027)(2017052603328)(7153060);SRVR:BYAPR01MB4022;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR01MB4022;3:RuTORpoSg9rr044L9+bdvr9w6OCE9MmutMf0UFUVT1aJky8LdPOpCaoQC3q0QYKTwtqlV5GrkXc9zSpPctSjui/R562snQ39U9GU0Y4RlNe6kzh6wIbL4pbosO9SbGwaA29p4K537gVHEY34bH/22f9U5IDf3RdLJbRQV12GJ94roEIdiNA4J3gn2Y75r3TVZZ/aUItLff3sdgjfKqFNaqEefgCwudWsn6hyzItNl2ejIg/lP9JmrsjvHmOLXoRivcPJHkl7LWveyJeMQsCHdMHc5PUX0MrQ5RNLwe/pd+xeznda+56x2/KfkRTINlHG7/7bp4FR1KCN5USXjRzs6pM6NwHpEn3H03I7U+IcYQ3HxeJ+8r29rLKgNQ4ZmILD;25:rUaoNnNcE97QIWHa5J29pvgovwb9JzDHrzbjkQ4YSSSHE09Jo73oAZbx45tpbw/pK5wNudkj27ycE5QoRbsLUulRhZhQSCzMCdvM0FcPmDw4KPA5tXVfTsWcImqWLEkvoA0LNrLuCHBXaQhIvlS8WSVmcLYCbflim6fhv/avdpQCAQpijN4pU9sJauVk3lQXFBh6yGTe45+YqQI9bzXONNA7LtviMt/tWIcNoELqL5ivNqBWJ8kU0K8BeqObxcrRvoI0Cg13i1lmEfjXapNAFu+Rm72WkwT2CaAkQbY6B8XU2CJlU8cPAZwSvC3rAzNwEIr0hhpEdFCxmlXkhR2ULg==
X-MS-TrafficTypeDiagnostic: BYAPR01MB4022:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BYAPR01MB4022;31:RyuhK9CAkBO3jn7FToAK59ZyI9Je712YG63fZdnKfkGaNA8KK+ZxQpH1KwlLf9kLG9/VaSAY5pBv/nof2i5e7+xU2NXxM12UJrd6Xo8YlpDzcVrKn4Vq8ljtdbnxnRdjoQ1YN8ASnO5gP0+waVhJetKNCszvZ2kbjwGrL7dhp00teSq1JW/Kpqx9cemO9NgcqDA47J0Pibr5dOQBAu0PzAYjf+uYD1HkjN9zXXmqW8M=;20:kHFxn2waGqSFZREAHQCJckEsL8S2hTw2hcw/CXPn5xSj8EtbTk84qPJwovOJBXQfuDFpb4t+iP6MLxMOxJ23AtOU37RP9VNd5JXBwXuj5H+cD8aGKJzKBk9bG3HZiQU01E56mAahvFsMXClepzkmouuO3hxa8ivYB4pTOQq5syY8MgwNxu9WHBPlEa4M8o+wQeBouKiK+XtTMYMZ1pkzCm4fbSGkrLZ0ppdhkeuN9eEs/WK3JFiwZ4yi9OBMU+5iRJGlPJBQS3IgJV8HdZxAzPxQTBZawVjPiotGinFesNRad7we/93fXLtZj+B8EB/mbW6CZGRLRBhPtH54/DxVZAIKeZ3j/Fg3mz/q2qupzWbBQmRi2tzQ2zXfDwQOLpImBYKwAJuJi5yrWYwkzJ7ZhhBcCRHZiFmhCOBn+X2yeTXytUDWzBbylH945JI1Woez52PTUX1akyg8ipmHeTZuOjW3L9BuhHtJWrVo3yAMWrJitQxtdpYftdeEhF9pILCF
X-Microsoft-Antispam-PRVS: <BYAPR01MB4022604B1B769008748FB36FB5880@BYAPR01MB4022.prod.exchangelabs.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93004095)(10201501046)(3231475)(944501520)(52105112)(3002001)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(201702281529075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR01MB4022;BCL:0;PCL:0;RULEID:;SRVR:BYAPR01MB4022;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR01MB4022;4:oDegTqY5A1NU++Dgv6KhNOLk5AusZXjDDXZS6qLD6kIgGCjdW40K6kUFZUVh3l3ur9bQU9dgV6pYY+k6vmTA6frds4APRzcwES7zZ4PRCp82GSgLDCF5HmUYfEqWSkDfi64HE2nLTyG07r2LytbKAbqVNpC3M+tjmoXyHvqt+X2FMKYHLhz1jQANqcykE6B+RH42GXZh2YXY2FLqor73hMrNCUE5CISZLznE74f20WmCq5uUtfQhakHttFlHllfSyo8F7773/OPTdnskKuU+IKZO7g017Ggjxcf2OakWX/E5A4A19Cl3ApdFInZKvd/D
X-Forefront-PRVS: 09090B6B69
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR01MB4022;23:yqGtYUxrX0NdOC7Dby3MGMENS1A9ihKAGTzRm9Yed?=
 =?us-ascii?Q?FBz/g7juGeYkbzhyt8kBhqEyhvzBCw9uglMLD1f+j6EhxcvVQkKsQE+n16iP?=
 =?us-ascii?Q?FD2iyNrZvdXJd52r8dEn+9xBCd4PJuGf2dM+GqhFQljl9RwfFo9+iLgaiTH9?=
 =?us-ascii?Q?pI6G4pRgIUTqLAA0vz1r9DbvH0HGYW6OrD1+g+hG0tYQAPgDGWrDMilHs2GC?=
 =?us-ascii?Q?61i0JHNAvLP3x5BY4WG/f++4A5IlXmjeogIAdt3T+1j9a5bf7D4fAR65H7Yp?=
 =?us-ascii?Q?pZEoemrZN403BOr6S/21nORQqSD82q/r0axoD4UfHx4stAWs4pbg1dbSIg1o?=
 =?us-ascii?Q?1sC7gTFZesv7NjcfzCoZUbibbYvrxF9xgS0hlL+/Rpp6Bn1oGn2kChAx5Y4j?=
 =?us-ascii?Q?82oSPyMpgGFKrLfUNRQFKPaXa34n3UQLqGkAY+2+f15HqTTHxgopTxtu6mP/?=
 =?us-ascii?Q?A3hrh+WesWf0sTzMPIFT6Dws7yhuMRChZhbfj02C9VVr8Z8OhK5yTY+hs6fJ?=
 =?us-ascii?Q?wOnuksSXo65k0dnGtC1iDSpkfU43l/n0a+pVx1FXcDMoYbgt4VUpFYvusD7o?=
 =?us-ascii?Q?l/pCuLntTnA0Yzqg2Q80gcDwAoox5/4DgDRKMaOCP5Ik7g7CCcrnGN676aF8?=
 =?us-ascii?Q?j5UtkZHJo5rMyGI9MO0lUpDAVapyD4vdr1qeK45k3kZlnZTaSA14pzCX5ISd?=
 =?us-ascii?Q?JN2teXdXsqhcfEq2tfpnvSf9YA/q+fKWup4Lgc4WOqVy/sYjVapi/zxRCSyK?=
 =?us-ascii?Q?I/gqLhik5wWo+0OgrMmwzpNja2aQRhnUhf9hLHjIxtJeTekmRv7fi74o+h+A?=
 =?us-ascii?Q?pBxHGqOk8BzgDLdrB4+l2o06UR9V1yWZ3PWOxhDk6c0Uwc6SBpxbD/t1Gkco?=
 =?us-ascii?Q?sEMWxKW2h48T6dS77+ZOYtIoMzK6h8nEMlCFpjaNlFVDPZrVQnpSmGhtUaMZ?=
 =?us-ascii?Q?XbFb8jaKqXFZ8JJ10p5jSNlI2OKLdoLhdGQTNYqozw76kEV2TWcnYmiwvDTW?=
 =?us-ascii?Q?WUf50oPD+0I+SqoAgXUjP07UVyczLGvhl+KYB//Njwg00Q2YMEZ2vMGyq/g6?=
 =?us-ascii?Q?iQ1bjzwpQI0f7EpiFOaLNSVFCE5+ftd8APeMbReupCCTnip3BcPuSLL1NKN2?=
 =?us-ascii?Q?O/g6kx9Cl0QGOYKqkzNDFtj+lJHfWXB1J9+NRVV6FSl/DNoDSOBt4V8aJWgb?=
 =?us-ascii?Q?drT5KwhuTTTuiIlR81gwSQrUPcQeiFOLwFbuopHLrWJnEmqTWrKoTvozg=3D?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: w2AAioLQKlc55RMhHBwdOPw/wJXr/MwLvfCOa+y1/nOCy2sLGFPnSSTqzoHURTKrij2ELPcCrOqLETXjijGvlnzqKXb5FG4XxbE7ifV1X4UsJ2tdm7pH1XbC96+1KXQhtVkEEWXo1m5ao8N68Ef1FbGqnaPL6VlGRO9h65fNkJwsju8S9wHW2X3zlTFVs/ChOoh2Zzb+NpvfAVHtiy1Y5gc62rjxWcd+qHaROZPpMshcU4rl6O8aNREX+aPyWkkhwN057qQrndSFo17w49VHFIyzD8h8GTj+HwK/S8LkqQHuWh8FlbwXmREAc4IupK52
X-Microsoft-Exchange-Diagnostics: 1;BYAPR01MB4022;6:QrCdX5QV7NF3IROQbUnU3uMBEXAUBxSwuVwiiqfcumw9D9SEPbt6thVqwwv9UjKNOdz5Dt7yNzykZiIjMX6yQ4vfSl3j2rjFr3xbEXFPpG5l2eeNliwnh7UaSo+GrcjIpr++KNto3vX5e+eI8gLPjIN+rk/4HzcdsPJwoEj82yxY3nyq9uVX5bmFiWZvGwKQdLCCJC8OVSvpjiO7x2SW8auIb3t/lbYyjmfnlnsKgbC8IAbW8Rf2vk8Utm1PJ5SsQEgbMx8OMxy51qovRZbV8whaXRqN8VudxBO86OUGX0ux7RwNl2pfM7/Yr27qZEoq+ve2/AYK5fBS4dFxLoyTBh2MGXVNt9aNPihEKTGVJD6gsWEjEZ5/Wctg+89ojg0okFiCSvqSxMeiL/nv0g0DkOfb5QOCz+1H/CWRMwWwle04927Z22Yjac4znhtBAd5n99PKY/x2YAhzH22FqzpQ1g==;5:OM+yIK/WQOFaC7+irKwvTu/utciFe69mRVVnEimdeyQbSmbp/W7TPLareguMfnnntBMte5MGtca+4yA+VseOZo7DsjcnoGXl8HWwFHBSzgzJcfNAykt7nio5TmGCl9le0DU8XJaxClMIzqRiSWcuQwprou01jyCNkIkJ22aDnJSYcNbE1USI0RfrISLJIz5PuhMwh6FIqKX3qdVgRm4nUA==;7:7kb0Mkrd7m7OBCKWclSG8a2J9QrTg+7G6qv2L1Xj54hCT7/l+jqLNYG/je9Wy/2ItR+FY+YkWH8ZPMVtP24kYpSBR0mu/Rn2AbsxeZMNoBdhMlYuw3Lw5dDxw59/NOQERJpYGB6AHZeL4X/QfDXzUA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2019 19:56:08.9503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bae9b112-4359-4f5e-475c-08d6741100ae
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2019 at 09:20:07AM -0800, Eric Biggers wrote:

> Hi Ted, that tag is still on an old commit.  Probably you forgot to push.

My scripts check to see that it was right (at least from my view of
git.kernel.org) before it generates the push.  I just checked and it's
correct now, and I haven't done any intervening pushes.  I think it
must have been a stale cache entry that you saw?

	    	       	     	- Ted
