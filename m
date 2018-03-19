Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3444635-1521482735-2-1378126768984063782
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='IL'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521482734; b=aOOZXMzra4X86xPp1LC//EW/s2lUty0+DqZJGJgSW1Q3sDT
    J9qpHTXDAQP6Yw3EnDPqz+iGhmT2L2LohbpLATcI9mtSF2ltkJ/sZC4Qhc0qiLD/
    UuJlkqL75c7/nDWF2w3kGSaPUl+dEmzYHlsTcruGj99XLzfDH9HNWBz7gaCW7Jdh
    wJyoFPWwaZt/iC299Y9LwG7jqWP83i4ok3vv5mPLJV5v4Dq4Rq6IXLqBLMntVMRI
    9zCpSa/OOpKCHFRmlt8xOnMM+eHBIsHq7/MFw9ssxLnnjBj7Ebdc3tOeOmtv0AHp
    vnqVaJH+GktjQdnnUJVWVC45Kb1FLmbfk15fEQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521482734; bh=BN8QTHUl1hU0IGB9CxUUT7Vsou
    k7NyFsU2rdOurlUwI=; b=i90ASnT4mtwjwuUT2Iek0dHKfuuE+fRkcQrS1oNgAU
    5huPgXFWboLyQsMP7+1SS3GjHJOAbvwh3pe4tE7ktUznfr/7I63eAErOSR3hIt4N
    4JfbNfYIG+7dqF0YNAq34FBExUpKa1AaldAZ3wIJ8t4das8925cXCT8cFM9k+rjK
    YB9Jwt8UHoJkfDpC2Dx+vQpuVQ2loCa7LEpmLKh9XcdDE1DbIKgBPMItNFzns9R1
    oUzT6oJ6awQ9bcNlp1W1vwlIJke6+r04XJj8mnFJF/dHDWmKMnPQ7/tPZpxFe4qk
    JHbPUFjNZSN8Gg4d9ABPas/VkQWlom0dz0KPRqxQ8YPw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=mellanox.com header.i=@mellanox.com header.b=D96iINRD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=mellanox.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujggfihhsphejsehttdertddtredvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesmhgvlhhlrghnohigrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdduleefrdegjedrudeihedrvdehudenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduuddttdefnecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mellanox.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=mellanox.com header.i=@mellanox.com header.b=D96iINRD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=mellanox.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujggfihhsphejsehttdertddtredvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesmhgvlhhlrghnohigrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdduleefrdegjedrudeihedrvdehudenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduuddttdefnecuvehluhhsthgvrhfuihiivgepfe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mellanox.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967147AbeCSSFN (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:05:13 -0400
Received: from mail-eopbgr40062.outbound.protection.outlook.com ([40.107.4.62]:24096
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030390AbeCSSEl (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 14:04:41 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=idosch@mellanox.com;
Date: Mon, 19 Mar 2018 20:04:34 +0200
From: Ido Schimmel <idosch@mellanox.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH AUTOSEL for 4.15 058/124] ipv6: Set nexthop flags during
 route creation
Message-ID: <20180319180434.GA13336@splinter>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
 <20180319154645.11350-58-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319154645.11350-58-alexander.levin@microsoft.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: VI1PR0501CA0003.eurprd05.prod.outlook.com
 (2603:10a6:800:92::13) To VI1PR0501MB2016.eurprd05.prod.outlook.com
 (2603:10a6:800:36::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 040012a2-cf28-424e-bf9d-08d58dc3e187
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0501MB2016;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2016;3:oIfdl/MzK8CMxxOm7NWsEAFqm7o9j4y/7QnRXdG9JtAIXA6rQeon0A3nhNJ89nRB9ZbhO0iKnnZGyPO/5WvobXoua67rOzD44O6LW8+SfV+zg73H+84N1ILSA+wOjYualpOGeLLCS9CcEYZ9wxkJm1od27z80PuIhVTWBScSfGzvMHFmTvBBXVSngQXOj0eLy5baHPPEJ7ali/+X/yuivYCJRAGCsH5nFDH6dTw+a3/tWDnM0xUgO+Nji9mkEDul;25:1sQz2k0otDuLiin8bsnGJLTnwDq7KfgB9Urp9lK7AG1eaRDphrQ29ApwubE07atJOC+551095DTnkDTrMAhfjLPgR3Oy6fyHf5uKBAWblMnCo2egBr9mcji6Up1Gt3U3pW9sB7uQBZIg90K8duq8FbV5DwFp00SxcT9fN2x4UKV7nSC/hpSqwT/OSVtFyWSUBK6vbStDGxvja8t3w4szy69vPRCdAMoeBJagJh80YZsW47G2P7/AnVApriZkv5jP8gUGdLIqO0aVw38psx05EubTZS8ks04Nt6RS5phhXHSv2eDY7ihIgFiINcLvlzHIizpKfJlLSCM+gwt4Y9nk7Q==;31:vDUs5S8KiV49Lm/uCUadauiLMjGldeYlMDUC470hPcLGCvVLmEtKanaNJXqL1Jf++soyzAF5ltf8jrJv9mn3RFpCZi9bqz4lci1BDT9Xbvij8ZYBSvw9dvV9XYSxUrDvViKdkGHeAiNzxmPsgMfcpP2MJNjITGZrovBHMh8NkGOLCl9jEO0tKh+YjvMnLepCvl9HGSWG4LvtBQAVw9wlQ7yk5A+LKrixUKdD4qhSOiA=
X-MS-TrafficTypeDiagnostic: VI1PR0501MB2016:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2016;20:W7JAxRGyY5Ouk3gT9Kgjz/aEs7pIJgWs4Qwqv9ZsPsn4AtPwQMlABVtADrhZc04Z1iRzw8+wMlT8teR3FW0oj69kE7QcURtqgYN1+0IpNLG1WL6dRKA7TR9UOQMft/jqglyKPsM/mI7/Iq3x7j+3zWAEqachteqDzxiXd8MwH03tSImHhmXDvxNgbBxx6Yvi/dfAB3392j3cEU9Tb2fhhNyw7/sSlINnLQtG/LzG95rzFDDBTffKyKPIrv2dw55uCdWsSmRQxOSy/OqRTVsZ+38FAt0nW5mGGJFsJ50miafYwR1smnkdGQUpWpi81lfDvhQjDvibxuUuA5hKtRykOLq9chH89de9Uq4qUjG3VcszGLq0GuXqzu0iqzoxSFDW6Gy/zV7RVck/nNs1X+wzJDy4k16nCTmD9+haeLEQnxLN4dpowJBxd3CEMx78rR/9YuLCh5ubPoaVGG+YfpYN4SBdQz149a6AXfCYtn6EJVmj0uJ8CMkEj5KbizhSfq19;4:rORLaTbFIhUEUbxGx/59Oc4G5XA9xJBhsOcc6B5Cig1CB+joqS9CtixwCObvh+Naeo8EW7AJK4Z6RntTmtdRdi0ZhsnVX8bJg0SG96mF0Duide1LN+20wxSe/0FMbOb/pyV4pNvRr7zCKnUsBuje084rdXzHCsTANUw/cBsiXSNH9U2w8gv10bkYHGLRpGOexJNf0idVBz4ZbIYCbG5uQsENTk2WJQZYPm1TPJrbzwvWjpBZLvPlbdolqNZo4mWqrZELNk1X3bkESjkiDOKaMGWLoGYhRa0LaPgEiuo7qLACNiKycS72UvIUzv1ANHIe/oi78fC4w5oTe82XwGThDnwBbT1g7MkEtsLtHWkXpl8jztJXyQacBe1Ysjs052dg
X-Microsoft-Antispam-PRVS: <VI1PR0501MB20169E55609295AF6682D426BFD40@VI1PR0501MB2016.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171)(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231221)(944501244)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:VI1PR0501MB2016;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0501MB2016;
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(39860400002)(39380400002)(396003)(346002)(366004)(376002)(199004)(189003)(68736007)(1511001)(229853002)(6116002)(76176011)(6666003)(23726003)(6246003)(478600001)(3846002)(1076002)(54906003)(2950100002)(86362001)(53936002)(5660300001)(6916009)(47776003)(45080400002)(105586002)(305945005)(33896004)(7736002)(8676002)(81156014)(2906002)(81166006)(76506005)(8936002)(25786009)(16586007)(66066001)(186003)(16526019)(26005)(6486002)(386003)(58126008)(52116002)(9686003)(316002)(50466002)(6496006)(106356001)(33716001)(33656002)(8666007)(97736004)(4326008)(18370500001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0501MB2016;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0501MB2016;23:a/jyIcK2kqM897EDmELFGUHLl7o//iQdDJe8QhW?=
 =?us-ascii?Q?eVv65Y0zcJpOpAkTQ2UCzSEYmPliq5QwEzLSQqwLjKT6lt/seApPeE8c7fAO?=
 =?us-ascii?Q?qkxYeDZpgFJJ/l6j9sP+e/M9u+Px6ANecmIF1kyZzIWt5S9gF1jAGJ4HHM+4?=
 =?us-ascii?Q?Zd3OvyTjBy/h8KCsgvd1MVw6Y+15SrOvYc7FvTI7QzEbrjiGZIREDEdKB0A2?=
 =?us-ascii?Q?Mrf6Y1LSIkm5+LMsOM8LCD4lKWuK/aXKwd9YOXsvcpoyQtVSl4JXulacn9v/?=
 =?us-ascii?Q?6JTIlncSRrbb9jDSqT6ECJ+pd+hsxBADaWhOCPVa7SxsturUVmwxlp0l7pw9?=
 =?us-ascii?Q?HPctFtZaaY2jsh8cd7fBC54pegjtvukbFmdV+V744H1h1NKVTTe3ek8mHJeO?=
 =?us-ascii?Q?d4742rJhzCNUmWqcR5rt2BdbJ7VisrntoHrAsipstvNK5BjkAZ6ADxJnveZM?=
 =?us-ascii?Q?FhVDaJU6rriaxiE4IYc3DAPl74vQjTXqONUG7avp1097llDaQM1UNbKgsKVb?=
 =?us-ascii?Q?EckFPwAe9lKdgpypv7qA/QqS8HmjitiJhIPqLshJvf+vKhNwqrFWWlgsZPDG?=
 =?us-ascii?Q?XEMyiE9zLtUEggI3Kw7gDqjVz47rLtdcKNjW4wSJVV/Gh75hh6GYQ/qIqFQh?=
 =?us-ascii?Q?jcUFeDCM4uxNud2m9pSNqEhuVifAVAbSKF1mySGJVymTx40K9Qf9Si9V2fZ2?=
 =?us-ascii?Q?1oIiiHjkYDyRJeWrQx/zppVzg5mdlgliOpSAO+rZ+EzlaudrZZ9DtIq+mCKt?=
 =?us-ascii?Q?5yg6kYyQPJxa70aWvuQn77kqMvvArNk9xR2bFB/ssdPLeqQOKb4pf+ZM8Sh8?=
 =?us-ascii?Q?wIMF6KnepQAkKfF0asfL58mU1euy8CI36/lF1g7FPwxjF7OItEFE7SGlQAYr?=
 =?us-ascii?Q?xYQwZ1Ij1SYX7wP7hZf8wvpqxFVuD7GP6kwK3ADTMxVZ+UiHDrb2dAkPxRY1?=
 =?us-ascii?Q?fxUm6/4ursQCGBt5qLJe6KU4J4Zb7Rx9RqXdZQHcpZTr2Q0qKCfjvl3YMuSb?=
 =?us-ascii?Q?W1RCJ5azYCoulsFj3k588+B/IPSakTEMWv5FtSZemDz/kgL+SgV1CcNu970V?=
 =?us-ascii?Q?Ik+Em4YTihhj2MwlIkegweZa+/839SHcl59YIrJw/7QBhQD4KKipi06vnneA?=
 =?us-ascii?Q?DXVSxeqIq99i2qW+Hw3tBqBrSdD3/3DAwWcEBxLTa/tZ6RdhEZ9Mp/tLafDy?=
 =?us-ascii?Q?bwV+/1DVQI5nODP7ql8sbHNWhbd0TEjDTdlAxOynWOOE1IL65ha9XVmYcPuD?=
 =?us-ascii?Q?KwP/ZEasp3raD7oFPPa57ZxO63vb1bOGG+IauBZPcAfpfNiOTfbeU/6XX+fc?=
 =?us-ascii?Q?I1VZEfIZsNahxy9Nu15M6z8TebyRH/dgN1gJSVuPt4aQjYT/Yw54tBk7ebqm?=
 =?us-ascii?Q?kGz3xX5L0rs85LPAnVJO1ZUbe72E=3D?=
X-Microsoft-Antispam-Message-Info: VxJyXmQULxkalqMcu19EE9g4mZyIgh/Wqy8+lIokOt2CxOC7e1XTqm/7WqKJ89PfP2JQgBYepZp05sL7h0bYyVkbUY6YC9eRzHTnlxhtzrM2p3IEmnXSfL/dJD+1X7O/ZeDlhBVeQRHKYZGwCQB3710tpjKopwj+NeexsBV2m2RwQDmpMg0qjVwtT5dn6tjw
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0501MB2016;6:CReFezqdjlWCuJcf8+fD+m0G/LS6WIE34x5uFTosPY5R3TcYyhQdnU0/N8zKeULcHHIxYSIgSvL95ZN9YgKqq5FWKUfkw9EyJA79yyyvf376nyqADN1Bd989ltGgZ5tSoABlZYA0Ox9nk8I5F7+s6koEM6jn2+cyZo7c1QPlf+QYCj8JX9yW6NOaI7UMkOeDpJptO1egllAT6gxRa5faf8O/VQCd6P038Yfxi8R7keVxTE6QBfeiaW1Ky/McFn+iI6bGBE5R3fz3S570bVPN5l4azRfedp7z0vlZ7NGEUN88OX0+RaQ5DXO4Stze360DTWymUzXPyi3XCkilFxo3EDcgwI60cf8cPcVR9She3Xk=;5:Sg0JkzuNa57BUaDrVuc/ek9t8aTTzWHyk6eoCQIvJOdzuIBuZDAxZxu08X1a0bezHAj0Md5ie9ZXgiC40JD6aVMr/xAFULWA5Y+v2w7kA8QSk8kltGH0qEuRdfEKMH+qWy35sA+5F3QqSvfn7RlAs4CQCUMyPVaFJrGlq4v+XkU=;24:bor2mRoF+hwLKdwNr6p6fPnGkDmHBxQ7ktN7LwMbxSd2NoLYHDpUP5T/HCNRJTN0FSrhfbmHVzgooKUx7cq2PZuLOIgwcxrusV1MSlNBTNI=;7:kn+cpspp/8LB5dSGeGMPTdSBS3SUhybIj6Vg0rqoA9nUiLQ9dAcV6jgrJP9hUaYvRDZqwWKSufyArFPXrqwo42yDMLvcPcZayStdHExHpoQ1cCK4Y0mAlMTWyEyVJGZ/aSIRPRqQczKYExTxm9RurXZtkOJgwAl1latSkZCEdrjg5ll7m/Xo1fqfnajqNcZIrKbXi+YX7Lgg7lPbOG2h70yodmHRkgql5s02bj/lOtOtANPK1E3y2AXhiKCfHVHq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 18:04:38.2514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 040012a2-cf28-424e-bf9d-08d58dc3e187
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0501MB2016
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 03:48:00PM +0000, Sasha Levin wrote:
> From: Ido Schimmel <idosch@mellanox.com>
> 
> [ Upstream commit 5609b80a37f69f796548339e675256188b29c17d ]
> 
> It is valid to install routes with a nexthop device that does not have a
> carrier, so we need to make sure they're marked accordingly.
> 
> As explained in the previous patch, host and anycast routes are never
> marked with the 'linkdown' flag.
> 
> Note that reject routes are unaffected, as these use the loopback device
> which always has a carrier.
> 
> Signed-off-by: Ido Schimmel <idosch@mellanox.com>
> Acked-by: David Ahern <dsahern@gmail.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>

Hi Sasha,

It doesn't really make sense to take this patch to 4.15 (and 4.14 from
your other mail). The flag is never used there.

In these kernels the flag is dumped to user space based on a carrier
check. See commit 44c9f2f206f8 ("ipv6: Check nexthop flags in route dump
instead of carrier").

Similarly, during route lookup the carrier is checked and not the flag.
See commit 14c5206c2d02 ("ipv6: Check nexthop flags during route lookup
instead of carrier").

Thanks
