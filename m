Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA5FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 14:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CD12146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 14:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mit.edu header.i=@mit.edu header.b="P2WuwNq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbeL1OAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 09:00:33 -0500
Received: from mail-eopbgr690098.outbound.protection.outlook.com ([40.107.69.98]:13920
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727328AbeL1OAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 09:00:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=430MaAxJLp8pGCFEWoYhf6+WBidCR98xBgF+vT3iMaI=;
 b=P2WuwNq2RmBh3+9YDEd9FtbtJ8JqbhurWWDFZj0BjtDMK0gUp/TaY1DeO6Nkc6bbfA7JKTq1Llk/2JdXCIr0td1KHtogqCAKGoA7JHRWYhEA535CpYuAiPf9Bl+uiM9REQdcJJbhlN2ptGuA0fzuAQazNEKgM1YvyBF47Kh4Y+w=
Received: from SN6PR0102CA0007.prod.exchangelabs.com (2603:10b6:805:1::20) by
 DM5PR0102MB3319.prod.exchangelabs.com (2603:10b6:4:9e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Fri, 28 Dec 2018 13:57:35 +0000
Received: from CO1NAM03FT014.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::209) by SN6PR0102CA0007.outlook.office365.com
 (2603:10b6:805:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1471.20 via Frontend
 Transport; Fri, 28 Dec 2018 13:57:35 +0000
Authentication-Results: spf=pass (sender IP is 18.9.28.11)
 smtp.mailfrom=mit.edu; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=mit.edu;
Received-SPF: Pass (protection.outlook.com: domain of mit.edu designates
 18.9.28.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=18.9.28.11; helo=outgoing.mit.edu;
Received: from outgoing.mit.edu (18.9.28.11) by
 CO1NAM03FT014.mail.protection.outlook.com (10.152.80.101) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1471.13 via Frontend Transport; Fri, 28 Dec 2018 13:57:33 +0000
Received: from callcc.thunk.org ([12.43.240.133])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id wBSDvTi2012311
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Dec 2018 08:57:29 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0D0447A490B; Fri, 28 Dec 2018 08:57:29 -0500 (EST)
Date:   Fri, 28 Dec 2018 08:57:28 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Bon Onlines <bononlines@gmail.com>,
        Bernd Petrovitsch <bernd@petrovitsch.priv.at>
CC:     Raul Miller <rauldmiller@gmail.com>,
        OpenBSD general usage list <misc@openbsd.org>,
        <linux-kernel@vger.kernel.org>, <freebsd-women@freebsd.org>,
        <freebsd-chat@freebsd.org>, <owner-misc@openbsd.org>
Subject: Re: Why is no one discussing this anymore?
Message-ID: <20181228135728.GD5864@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Bon Onlines <bononlines@gmail.com>,
        Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        Raul Miller <rauldmiller@gmail.com>,
        OpenBSD general usage list <misc@openbsd.org>,
        linux-kernel@vger.kernel.org, freebsd-women@freebsd.org,
        freebsd-chat@freebsd.org, owner-misc@openbsd.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6b305c25-cf15-ac5d-d246-7c2e3c902f1b@petrovitsch.priv.at>
 <CANV0cTm1PfB61hg-zcxDqdwCKOLSoX0evkwWmv0fHGxgxsf4iQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:18.9.28.11;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(376002)(396003)(2980300002)(189003)(199004)(50466002)(26826003)(2906002)(305945005)(106466001)(478600001)(8676002)(47776003)(97756001)(8936002)(33656002)(88552002)(36756003)(356004)(5660300001)(36906005)(16586007)(11346002)(6246003)(186003)(46406003)(52956003)(75432002)(26005)(4326008)(54906003)(486006)(58126008)(2616005)(336012)(786003)(316002)(23726003)(476003)(86362001)(6266002)(1076003)(42186006)(39060400002)(110136005)(106002)(90966002)(229853002)(103686004)(246002)(14444005)(126002)(18370500001)(55214005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR0102MB3319;H:outgoing.mit.edu;FPR:;SPF:Pass;LANG:en;PTR:outgoing-auth-1.mit.edu;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT014;1:bLwzfLzrLWhI/nfbDZPOLmo6tqqn3m82hm4z+nAWLIrcVs/AQVVzw+09GSi15KV94B//Z5ooTE+JcUcNo8Qgx6LKCEj1nq2AVISuOLBNj8nQwoUt8vxxpWPJTXH4t3oi
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c883f9a-c6d2-4924-d4dc-08d66ccc6add
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4608076)(4709027)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:DM5PR0102MB3319;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0102MB3319;3:x/G0Q/AqSyB+KDNXNwr/U7pja632xcJVqj7ERcboTCKqWy0HH9srCJkOPKitoHI5ySz6Wf9aZGvimJkWRj+d/pAfSHsEPYTl/PmEV9/jtLKV5CjOxMOUZxBMXZr7s2fpkyi6EcT/i/aSz8VtoktTTCGqdpcQL2qiM0SZWE/XV+0/3K7jTBhsu11kPKvQ4tDxp6g0u/6V47MFTWfRsht/tT99ItxSMRepKDd6M0vo7LUdh8hG6Z88L9CmBlUlunizmuxfKFOxbLUju4I6zxjNCjWbA6ZZyJUkux31sLVKgfyFDnGqY+dE1SzwKqNBs6JV2DABLGo+dKNClUDfGQOZ6g==;25:Phoe7oqtYYHxSjFh2k66Oq2cu0lLOEI7LmmKnlw7cLrwXGnZfTusW7eXzBQHQxWPIb+kobxLIaMXDAyd+qmFK+kdGbcjMlx/VsBqX9KSpb5fosgJ+9F151g6+K4hSn417hqYhQSGLu/PoxTJy0y0ZOJKRtX1QVPRiXwvac5S8Ar4EFhmuC3rRsbNtz1ckZYVwUoV/SSWYONv7yUPjYccVKwwXAvy/aFaOoTlAFTFCzpA+vrORsickwftpOoiC2ZOUXohs7bLotxUQ/M0xOkBuzWrAOsG3RqdaoF+o0+Ioru8a3UBL2p0ZKjv+e2biQbsFwOupWPgrtn7e134DVMwNA==;31:i7KVxwtJ+AEhDhuNkuLGv0mTT0A/FA8gGDQMftbjlINZ3qpct/BaS3n/zWfTLOtK/M30gocbeGivF5qTEbBssGHHr0gvcKH6BPmQvcyvIx9zuTnJGMszYvbeD97SpH7eM2KReEnAMYjACKUUCyj6hI+rY9UCaXNVWDEbbF7Qn0Qoh5Jdx1kyQtXmieF114inCPRfE9D/UxiTcswyCJmwGNT8lM6S1rFt2AiqS1Rs5xM=
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3319:
X-LD-Processed: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0102MB3319;20:AbrybFJKImNnpxjqRUs4QBb/wUSKqzwf5wOkfo7bqD+W6dmB3Mj81ZvSPKUMYYXnN1/6owyWw4LsNgZ9wU7KxKqkLWIF8LHeox952+8euxS52ulOry6et5+XxZc5mypJoEcm4DS97Etd5JGceJKA1LMkYAvzxmeyrDHwt2k0teYN5y/sCXvATXLdrXroA7fx19wwznTKyMF4XIPER49cbCVep/WHyEpqVqEvr4I80x6eC8KiaZubbDBgDMfwAuZ2ZfyvzfasHn+wfXhp7slv+AO4/4WALzDcHfsk7VOKBsoisGxI+cVE9GUl/mdp9PnujoLIgZ4qvExmXn+tvpmQI60ofm+gjFCuEsTr4zvhZ8QSqICQywAOW+EQAaLIlkGnTWjf64AUFeRZ45mlpoPW6WLIU+yrp7p1ZqWVQctwz/kcjrp5WZPFjhl5STxja3WENCVU0F3XQkbj5P1MAUu/9zT4ULB9LdBShS96jMQkya5POsewiPDvJt2zC1AlvDBK;4:MtFSXk3z+qWw0RKArrb52s0RbUWTygkTLD6DPqb0s10Jf+Rc8QHO7F1z8d4yal+fO6PMu+q2KBg/AE6GeZ6e9Ck504duo8WVXU6WMBrsd0v0tpQh7raIeSE/KpvAdQOu9+VGrNoQkqVDfwnTSM/kYJV0BNFyNrWvHFeXGjk5ggJJHnMvnfF+d731/W2iRFkWLjkyoONMwUYqyM85LMT+dn/Xl1elzi2KDbZwYPlbGHibkcqPq1ILD8GIYcpOk9v2wRdu3JCIpTGsgH0JzIOteg==
X-Microsoft-Antispam-PRVS: <DM5PR0102MB3319ACAEDF41E672EEBB43DEB5B70@DM5PR0102MB3319.prod.exchangelabs.com>
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93004095)(3002001)(10201501046)(6041310)(201703131423095)(201702281528075)(201702281529075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM5PR0102MB3319;BCL:0;PCL:0;RULEID:;SRVR:DM5PR0102MB3319;
X-Forefront-PRVS: 09007040D4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR0102MB3319;23:FmGskhzHQYbVX6mYJG1q5cN4q7aSM7C7N3+QMgB?=
 =?us-ascii?Q?3+0Y6decLaZo6WjgY6GpqBJ+Wv2BMWWbR5amSOUc+YuzuIiJR/vNDk/WY/S4?=
 =?us-ascii?Q?2FaMPxH4bcwcO5t/Cn+Xu2Roj4caVttghy0SFrWH0JM1p6xyeMRJ0sjtz1Xz?=
 =?us-ascii?Q?Q4nHbGhmWZC4SIRXjNUtmLSY2txCIpV9L1YKIMS7g7iYgGohl+4oFjisa00O?=
 =?us-ascii?Q?eGHl1zwt34WO1qKUe1+S3W+VhfRchV4wcGI9aWijl6u4/onIYVJrKcW+QrJK?=
 =?us-ascii?Q?dg9kPLq/I2q073agPgGYyQ0n5fgaIM6jBvHHLMos1I2hU3E67bNjyWHd29Xg?=
 =?us-ascii?Q?tqBwIXsHoIu9tCIjmVEvydVMcg0qfe8EL58YObOvyTYx6MwqYJ+coTaFGOQj?=
 =?us-ascii?Q?aQ+RgI2x4sl0PMMAqmfSoXo1zA2L6W9Yg9ZTMf9HRphsskFCCxy6THn1ZCf6?=
 =?us-ascii?Q?968kTJNbxamYZywZVGME5V3udjCvc8CDZ2PKiBa31Gfg++2e8dutWIgs3VlG?=
 =?us-ascii?Q?wjoiDCag6PzCrZJMBLQyLrUF8M2hPOI6a8VjK6QFQpbvjDPy2BoZ8nh+jUAS?=
 =?us-ascii?Q?3eDXFiArwVkhuQ73JwYyC1kA8VWgsjxlx/yTQRlZPIsAsaew+yHKUnV1dcLQ?=
 =?us-ascii?Q?bgL+pDDsyRSk+NWn3k5OTRhtfFGGvH0KSzN5G0AfkGx5q5FlANc7o7iWOxsd?=
 =?us-ascii?Q?KjWJOyMWuQJIWvF0GqmElSn4tbPKZp7Xh3MiWo9pqccaFfTwuhBsysH/5jxO?=
 =?us-ascii?Q?97EHXeNRxrYgsJ6x0W33GYAOnHzR1ysCujlIqjpciVaMgHeiEVFiiMQPSwS6?=
 =?us-ascii?Q?HWh5aZfbazpKKx6d7VSXoQNrWCLzkZbNFVRcja3UA95vlbsv2T66IVzXQ6Ap?=
 =?us-ascii?Q?Z/6ohlAZYQ0jXZpt/SaIw62EaIliPJzrFeRzbU9xSbwRoQfN2bRTwpqR3hlb?=
 =?us-ascii?Q?9l8inju6bHiDuDJYe9g1cb+iMSvNKn1jrotg2rgAxyT1jWa1Dx/VyVCsj3vE?=
 =?us-ascii?Q?xWgY29Ty6xyFuurGnXrX92xj8e/laJtajmlxDkawwEic4La2NaqxoiW+ATaV?=
 =?us-ascii?Q?HFZN7JQ4COtTr9zydwg729euq0x1kViks2/jEOvU8+9uEcFTQUyfaJZwXPap?=
 =?us-ascii?Q?emEriPWYFLMmE7yGCVY1uNyYfReNxSSsUhcj+RAoVL0AmAgbfUkuacGDUkG2?=
 =?us-ascii?Q?VlqQdutTXDpbB8YuUEjpw0Q/uxqYQtrjHImvNjTNKn9PflXgfXr8BkCI1HYH?=
 =?us-ascii?Q?T4ybz+CeXYnht8nn0CB3hxM7Ko/M8xgzGmxtAl8Qm?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: XPyYUapArAgZ1Mv7IF/1Dch3ed98w64qrecPaqJV3Slc50j12RjIQmRIMACGLfjLAprjiWeGKJ4i1foMhspDp4pUK25lJ1PvNVgShEiDjKneK02yBNJN9lFR0FIW01MPJTc8sV9Uc2jmRTm/eCWbThxuJf0RUce5IER1pG6nwZ6ZyGtDN4FWfA94t4L7EJrKzotUkXkGyhxayaGAPP//H9zXaPdhJ9pMToXGTw2ACFR8QkpHkUYW+QAftt3Duxx1mRJCn8fzbZJSnWPTRTWi9gKU0uGofGIpxLTIDxdHcoMKZJ97YIarOMrPFsb9gOfN
X-Microsoft-Exchange-Diagnostics: 1;DM5PR0102MB3319;6:Wq78h+EbKgkeVlkoI93g95aEqXOdy1UI3IkCrnXHRupiy1t3L4jAsjOxNCPgQLUSrZnpl9+hc21tBY67vc/NYKbVeAYTfQiGUYS/eOXeE/yVzjER7SpARREFX8jiRlT5oHoF112zM9ckpSPIdYQlikYWRwh13/I9n7SXcC42eyq14N1dhdFYWN1cAVECTD/+Ww5hCXPJ3jgsrLeNm99M0QZsX47gego9GAq3evfYDKhvME+ne7gM/BN0WQQFLur1su99WbH7649qwoC2/Dm+pi7MJLwJB1imKoXtgAmy8m7MJzJgp+kD1cweQTBLuTVD7f6zZy27QwwJfYRUafcpEvLPXc7r0gJBDhs4PoiDhTmE86PPp4EbYuVV6ECoGG1WzpkkL8NuKjKHlPaSwojlttl/GrySYNuPvG9APw4IhAvpB5AQksbYdZKWbatbCbwJV/OS0+NWWcwteFelVP6NSw==;5:45HNJPC+7J085gP4Kf+sV/dXbpocjhqMTFKjg3yTvUAL9pvFNeFv7xuB2g6EurGLdy+qHI04xFDnpi1Hz7s7GzilerzB3Kmnge+odSZNBCoA+Q2sFw2sSzZWK6QpZahk9+eDj3ipptrrg1mZC/cA9kLjmZBG3jxD9HnIbDcKt3Y=;7:xQewRkJQiM6uBYLyCU4fDyr06EbU0lLsutO/g/Efcnn4bhaiwY/UTh8OelDnJ0y3QJWB/Kmw9erPoz3JZo/SAjsSEzxojnZnoM5k3ki+id6CI2iLQIZ4S/9jmlDFmW+ipK1aGfqhGt5xiCTlhBfOpg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mit.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2018 13:57:33.6554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c883f9a-c6d2-4924-d4dc-08d66ccc6add
X-MS-Exchange-CrossTenant-Id: 64afd9ba-0ecf-4acf-bc36-935f6235ba8b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=64afd9ba-0ecf-4acf-bc36-935f6235ba8b;Ip=[18.9.28.11];Helo=[outgoing.mit.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0102MB3319
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


         +-------------------+             .:\:\:/:/:.            
         |   PLEASE DO NOT   |            :.:\:\:/:/:.:           
         |  FEED THE TROLLS  |           :=.' -   - '.=:          
         |                   |           '=(\ 9   9 /)='          
         |   Thank you,      |              (  (_)  )             
         |       Management  |              /`-vvv-'\             
         +-------------------+             /         \            
                 |  |        @@@          / /|,,,,,|\ \           
                 |  |        @@@         /_//  /^\  \\_\          
   @x@@x@        |  |         |/         WW(  (   )  )WW          
   \||||/        |  |        \|           __\,,\ /,,/__           
    \||/         |  |         |          (______Y______)          
/\/\/\/\/\/\/\/\//\/\\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
==================================================================


I recommend that people not respond to vsnsdualce@memeware.net,
visionsofalice@redchan.it, and in general, any e-mail coming from
domains served by the cock.li service (which comes from the IP address
185.100.85.212).  As you can tell if you go to its web page, this
mailer serves the following domains:

	cock.li, airmail.cc, 8chan.co, redchan.it, 420blaze.it,
	aaathats3as.com, cumallover.me, dicksinhisan.us,
	loves.dicksinhisan.us, wants.dicksinhisan.us, dicksinmyan.us,
	loves.dicksinmyan.us, wants.dicksinmyan.us, goat.si, horsefucker.org,
	national.shitposting.agency, nigge.rs, tfwno.gf, cock.lu, cock.email,
	firemail.cc, getbackinthe.kitchen, memeware.net, cocaine.ninja,
	waifu.club, rape.lol, and nuke.africa

This has been a public service announcement.

"Never to wrestle with a pig. You get dirty, and besides, the pig
likes it." - George Bernard Shaw
