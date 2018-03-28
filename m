Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AIpwx4/Vi/hFRcLIQoxfECPK4wqHvaOgm/Z1kPvZ1w6jY3LS4HLeNOhNyKCq2PD99A5eC6quQt7a
ARC-Seal: i=1; a=rsa-sha256; t=1522265410; cv=none;
        d=google.com; s=arc-20160816;
        b=SE0fgAGk+Xa13Py5EDyLCM9zYbrySGU/cFcr8h5vEK/Nhb0XGN/zCB0Eb0yFyzhq3H
         emq2p1LB3esebRqkwrhI+eSI220zCDKLwDuTb4kf+U9av/x15jD/ZEeYSG67/pi4dlTe
         3/LM2WbLpoKiRmpV0E6PPBv7IaWRuHaGyWnv+y0gnj1JEgaa6VRzHUL8MD5Vsuo9f6CX
         BawGgE+7NrqDpQGeHQUVRjhN7Ob+ilsY3YxBPGZ9gvEaOUUH2eqOp+UWRfzUv4JSrnVL
         +AJ93HckZNF+k+ji4cAwx4SpwKWai+3pMJqDFOWuCdtu7xsnhFZ5VnuwxNMEGIvshAXD
         rBHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=4KFxOHGR/TASZEWu0Ba4wZ3H0lPVkD0l6czuUXEklJs=;
        b=uDhKsKdxM6VsJzsaBqkU9W5zGE8NxMny1ISG3hirmUaUguk+nO0U1JAEGhKQiuVbF5
         uVMs/TkiWVouYfN6PRD2bIgCR++P4ttsU7imo4W8kIceKDFREhKFdiSDR8uI1L8cksbD
         lyFlwtNRRIXdUu2JKbzDIBaSZeMe8r+v1c4E42eanwwWOYvNWiZV62ZFncaYylu5LMuo
         4M5bbcC1OPcmGHZ/4L8/nRhiFD5cadmLnvmXD+ulsJKW9G2OEod8QRorUtoprzGXy0VX
         aXUREkmZxWuQiprsncpI+DhqWg2FW6LdX5CgzsGeMx8bCZDdEfv/dddioeoYDv+G97AL
         gWZw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=XvNf7GuP;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.33.126 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=XvNf7GuP;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.33.126 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Dave Chinner <david@fromorbit.com>
CC: Sasha Levin <levinsasha928@gmail.com>, "Luis R. Rodriguez"
	<mcgrof@kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, Christoph
 Hellwig <hch@lst.de>, xfs <linux-xfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Julia Lawall
	<julia.lawall@lip6.fr>, Josh Triplett <josh@joshtriplett.org>, Takashi Iwai
	<tiwai@suse.de>, Michal Hocko <mhocko@kernel.org>, Joerg Roedel
	<joro@8bytes.org>
Subject: Re: [PATCH] xfs: always free inline data before resetting inode fork
 during ifree
Thread-Topic: [PATCH] xfs: always free inline data before resetting inode fork
 during ifree
Thread-Index: AQHTwtP9a8CoG3+qW0i20XM40DTMGKPhjRGAgAGo14CAAc86AIABC40A
Date: Wed, 28 Mar 2018 19:30:06 +0000
Message-ID: <20180328193004.GB7561@sasha-vm>
References: <20171123060137.GL2135@magnolia>
 <20180323013037.GA9190@wotan.suse.de> <20180323034145.GH4818@magnolia>
 <20180323170813.GD30543@wotan.suse.de> <20180323172620.GK4818@magnolia>
 <20180323182302.GB9190@wotan.suse.de> <20180325223357.GJ18129@dastard>
 <CA+1xoqdWBumgCn9iw7FH_6VtDnEmd5_Hyw=cY4b9zB=Avhx-4g@mail.gmail.com>
 <20180328033228.GA18129@dastard>
In-Reply-To: <20180328033228.GA18129@dastard>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1046;7:2JTplFuW4PgR/Lk144o5vPmT6nouHvaCu3Kj+ZqCByzFGnDkBRx+731DCGtCIduX3IybbIOd1vZHd59Tvteaan8Y2KrwTkHeGom4x6K/UtYmwELrgspyLxpOc8a3yde7jFolQUZQPUdm9iXZaGfGlWP8mJarhb1llxull7ptSE2acF8G/YlS7w1x6t38rbhah4P1jYsFr6fzkVT2pInGe5RycOeVlpYsWHr3RHgnx+cGb9nyQJyLeSd77LIwoXhv;20:KKhck4irV8WrTMOzHFST4FtHvzFhrI4NsJ0IB7hfRp4fTco9cF8EhIl62WwCsj6HL2uXb9VyLjLXIGoL7S3vPkx5DJBHWTSsYyeEHn1lcUlBkqRrpX5HoMHx0dqzN8lSEIedILrsjUZ+fdmlKBy2TIKbPatWA4aIZZqbtyoPSHo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3771cd97-c845-44ce-f642-08d594e25033
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1046;
x-ms-traffictypediagnostic: DM5PR2101MB1046:
x-microsoft-antispam-prvs: <DM5PR2101MB10467F837F258DFD341D91E4FBA30@DM5PR2101MB1046.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1046;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1046;
x-forefront-prvs: 06259BA5A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(376002)(346002)(39860400002)(39380400002)(396003)(189003)(199004)(97736004)(3660700001)(81156014)(7416002)(316002)(68736007)(93886005)(81166006)(305945005)(7736002)(6916009)(2900100001)(66066001)(5660300001)(106356001)(22452003)(8936002)(10290500003)(105586002)(54906003)(102836004)(6506007)(486005)(476003)(486005)(5250100002)(86362001)(478600001)(72206003)(33896004)(39060400002)(76176011)(53936002)(26005)(11346002)(4326008)(14454004)(6346003)(2906002)(25786009)(446003)(186003)(6436002)(99286004)(10090500001)(33656002)(86612001)(3280700002)(1076002)(6512007)(9686003)(6486002)(229853002)(33716001)(3846002)(8676002)(6246003)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1046;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: DXILXLOLHEOxV4I2E8HdjlW1Ix64b9tqGORUDn/Pwy/fXVuQHFcjmbCbsHGMXKtJfIxyypmX0OQ2U902w82T6d0Cdndnn1DdWyY7CkyEy5BLvqslbnEkOWRLjc6S7j0G7GPNIedTi0qv1H5qIPVNXkHw+Pc5WsypdnqaI7eE+VAIbC7BzuRrQ0kJx1WD05XgM0FnN76wpfnCwIROU3j2glXY7oVk8933DYjfY25/znYDR7DuS6hl6J0JwtZ6urzOJHVIlFBW2kto9ceHKkE0zg8b6OShxKYg9vkLjOgwzF26gW827vgrj+4kWHJQu/QhHxd0ctflJD+VRANq2JmQZA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12005E4348B1064B9395E20EC95B03D6@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3771cd97-c845-44ce-f642-08d594e25033
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2018 19:30:06.9624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1046
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595753768288631831?=
X-GMAIL-MSGID: =?utf-8?q?1596210974099661807?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 02:32:28PM +1100, Dave Chinner wrote:
>How much time are your test rigs going to be able to spend running
>xfstests? A single pass on a single filesysetm config on spinning
>disks will take 3-4 hours of run time. And we have at least 4 common
>configs that need validation (v4, v4 w/ 512b block size, v5
>(defaults), and v5 w/ reflink+rmap) and so you're looking at a
>minimum 12-24 hours of machine test time per kernel you'd need to
>test.

No reason they can't run in parallel, right?

>> > From: Sasha Levin <alexander.levin@microsoft.com>
>> > To: Sasha Levin <alexander.levin@microsoft.com>
>> > To: linux-xfs@vger.kernel.org, "Darrick J . Wong" <darrick.wong@oracle=
.com>
>> > Cc: Brian Foster <bfoster@redhat.com>, linux-kernel@vger.kernel.org
>> > Subject: Re: [PATCH] xfs: Correctly invert xfs_buftarg LRU isolation l=
ogic
>> > In-Reply-To: <20180306102638.25322-1-vbendel@redhat.com>
>> > References: <20180306102638.25322-1-vbendel@redhat.com>
>> >
>> > Hi Vratislav Bendel,
>> >
>> > [This is an automated email]
>> >
>> > This commit has been processed by the -stable helper bot and determine=
d
>> > to be a high probability candidate for -stable trees. (score: 6.4845)
>> >
>> > The bot has tested the following trees: v4.15.12, v4.14.29, v4.9.89, v=
4.4.123, v4.1.50, v3.18.101.
>> >
>> > v4.15.12: OK!
>> > v4.14.29: OK!
>> > v4.9.89: OK!
>> > v4.4.123: OK!
>> > v4.1.50: OK!
>> > v3.18.101: OK!
>> >
>> > Please reply with "ack" to have this patch included in the appropriate=
 stable trees.
>
>That might help, but the testing and validation is completely
>opaque. If I wanted to know what that "OK!" actually meant, where
>do I go to find that out?

This is actually something I want maintainers to dictate. What sort of
testing would make the XFS folks happy here? Right now I'm doing
"./check 'xfs/*'" with xfstests. Is it sufficient? Anything else you'd like=
 to see?

--
Thanks,
Sasha=
