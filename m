Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AB8JxZoaQJqekr8S4hW+nH78M021MEu6davOQBfke6nnygYOXb74388l19cba6f72HIdwuOmgi6R
ARC-Seal: i=1; a=rsa-sha256; t=1525374277; cv=none;
        d=google.com; s=arc-20160816;
        b=W+vTYeDXucya6z1vRHq1T27M8pmRg2lUhbD+u0C9WYyoSc10qjdZcgXOo6e95Filax
         iINMiF7HCXTBom21CFgMNkX7aPibMQWRU+6QKsRN8ZGQXI1qcu66GfUxWg+/LX1wb2lK
         Uenul1MGiiDdfqgfl2LmqwPChcdZz1SkHir2v5gR/MEH0NJef0vhjw/+72rFV7hrr45O
         MTzQbkesxkxa3aRBhtJ4wfZ31hIoS0sxrkOSL7gFhS5bS6IG39BUscQ2gfA83RzsK5+I
         82Wj3cGpdxQOvEy89VVIK/UVjpGfU6lVgZwrT9rgYpU4oodHmbttQBgtq39w+7R3UWFY
         faYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=EOaHDlG8ri7hFoVDH15GelTSUyqh2mViMFS9yb5vjAM=;
        b=FGm9vwKl/Cv1jww/osyc2Ty/1uVlctqwzmZ4snvGeVzFxl8DUVpqXVjACiLbair9fC
         QPtGiGGzFr1KjohvXnVlnW5TfEJ8VNOyMP8bD7ETQnCvSpP5aFZsd1OYijhEZEHdNLIu
         K/gPgaLzxExfzUL5BKYXdlZfyrS57eOMQDAbwmrTd5q+9abngGYtsICDKalcdWOEqO3W
         vROuD691gtgdl4FXCecytfTefpV9wHoAbNtDmNbpBhksYCY/jR/ZhjBvIxfTI/IOrIme
         tIRLsxSD0n4HG34ei2QKMgV5npDconoDXBWhK5tNK95u8pHsMaRFtVCYQFmh7eL8NNIN
         RBxw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=jWePqVDS;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.41.109 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=jWePqVDS;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.41.109 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
CC: "Theodore Y. Ts'o" <tytso@mit.edu>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "w@1wt.eu"
	<w@1wt.eu>, "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Thread-Topic: [Ksummit-discuss] bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQcksOAgABIXgCAAA4OAIAAORwAgAD11QCAACPrAIAACxEAgAAM7oCAAAxCgA==
Date: Thu, 3 May 2018 19:04:34 +0000
Message-ID: <20180503190431.GV18390@sasha-vm>
References: <20180501163818.GD1468@sasha-vm>
 <CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
 <20180502195138.GC18390@sasha-vm>
 <CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
 <20180503000620.GA29205@thunk.org> <20180503144612.GJ18390@sasha-vm>
 <20180503165446.GB30522@ZenIV.linux.org.uk> <20180503173422.GR18390@sasha-vm>
 <20180503182039.GC30522@ZenIV.linux.org.uk>
In-Reply-To: <20180503182039.GC30522@ZenIV.linux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1033;7:NOaaUiGmTya+Aw/C0zCGq2MYYdSlbX9cnN2nP98N6DeV2/ifS1xj0GTMuinjANwNvFAP4DIH+60LLpCS4CDdsKZv5j9QcQqrDgA7val1V+P2NqJic9TTedCM2YfcUk8NAtVDgm7mbbnKu2Ndxj1Zhgc8v9La87/xfavsHD3IpHBB5kLxxmr0d5Xz+cgW4VIwZjH4XFLjWsGr4drbr1ttrWTjCIZ6gndnGKzcBfwOEnjWf7J4XT0LpHQz4QFL/Sb3;20:O0dmBT+EK4YOEfY0wCmEONm0BZivrN6IzMa9M4v5zAcS8gRFLYCLJzNnBaEKFmJpmb1BcGdzCTDQ9Ad6TCUcZ5l8NqpZkuBInyopDbpNkTqxI53tK1dBTQn5NktVXXeHLEb3XJQHhL/H9BtT24L1iapQyxj3IMp5hSNoP4qI8HU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1033;
x-ms-traffictypediagnostic: MW2PR2101MB1033:
x-microsoft-antispam-prvs: <MW2PR2101MB1033A54008A3D94B068E8DB0FB870@MW2PR2101MB1033.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1033;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1033;
x-forefront-prvs: 066153096A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(396003)(346002)(39860400002)(39380400002)(376002)(43544003)(189003)(199004)(93886005)(33656002)(97736004)(22452003)(10090500001)(2900100001)(53936002)(316002)(5250100002)(10290500003)(2906002)(105586002)(33716001)(14454004)(6436002)(68736007)(1076002)(3846002)(3280700002)(6116002)(478600001)(54906003)(9686003)(6346003)(59450400001)(106356001)(3660700001)(186003)(6506007)(6916009)(76176011)(26005)(5660300001)(6486002)(102836004)(6512007)(72206003)(99286004)(229853002)(8936002)(476003)(66066001)(11346002)(25786009)(86362001)(4326008)(8676002)(575784001)(86612001)(81166006)(6246003)(486006)(7736002)(81156014)(305945005)(446003)(33896004)(556444002)(31884003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1033;H:MW2PR2101MB1003.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: s/VEO+IfXXQz56GRs5GqEqb+D1EMxGUpjAgt6D7tqw5liMGEsZUPdrRt3VUBcQW+iRPbxGLIgUeOragfQr5csIXvtPpI/rBDZY8+zrnlPjBnaCMcsNuH/jg4EqayONhvdmqpF4ZenyGcxkRm1Ob+VbImRUZeP2ueygX2MOr3qgTB4iyuAAiJSSdTXkAdUTss
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C24392948911924A9B908A3DBCF6B369@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c47e37f4-cdab-4d42-cf59-08d5b128b566
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c47e37f4-cdab-4d42-cf59-08d5b128b566
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2018 19:04:34.1765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1033
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599470858368244687?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 07:20:39PM +0100, Al Viro wrote:
>On Thu, May 03, 2018 at 05:34:24PM +0000, Sasha Levin wrote:
>
>> >Moreover, what the hell do you suggest in situation when
>> >	* foofs_barf() is b0rken in quite a few ways.  There's an
>> >easily triggerable memory corruptor that can be fixed locally as well
>> >as something else that needs a change of e.g. ->mkdir() calling
>> >conventions to take care of.  The change is mechanical and fairly
>> >simple, but it's already -rc4.
>>
>> I'm not advocating to forcefully block people from submitting patches
>> after -rc4 (that was Ted's suggesting).
>
>I am, though - change of a method signature when we have several dozens
>of instances does *not* belong in -rc5; if nothing else, it guarantees
>a nightmare pile of conflicts with individual filesystem trees.
>
>> I'm just saying that as a maintainer, you should use your brain and
>> figure out how critical the bug is, how good is the fix and how well was
>> it tested, and decide if you want to merge it in or not.
>>
>> If it fixed the bug and didn't introduce a regression, great! If it
>> messed something else, you'd have some input on how to address it better
>> in the future.
>>
>> I'm trying to come up with a tool/system to help maintainers with
>> this task because right now it's not working too well. I'm not trying to
>> introduce arbitrary rules to make your life miserable.
>
>And I am asking you what kind of rules do you want/expect/would prefer
>for Fixes: pseudo-header.  *I* do not give a flying fuck for its
>contents; I can put it in, if there is a good reason, though.  And
>the obvious consumers of that thing are -stable maintainers.  Including
>yourself.  Which is why I am asking you what should go in there in
>situation described above.  And no, that's not a rhetorical question;
>I really want to know.
>
>Let me describe it again:
>	* a bunch of holes is found in a function; all of them go back
>several years
>	* a clean fix for the whole pile is a composition of
>1) local fix of trivially triggered memory corruptor
>2) tree-wide mechanical change of method signature + matching modification=
s
>of callers of that method (say, all five of them).
>3) further changes in the function in question and its caller (which happe=
ns
>to be an instance of the method modified by (2).
>	* dependencies between parts: (1) is standalone, (3) has a hard
>dependency on (2), (1) can be reordered past (2)+(modified 3), but modific=
ations
>needed in (1) and (3) are not trivial.
>	* the crap fixed by (1) is much more severe than that fixed by (3)
>(and (2) is an equivalent transformation which does not affect behaviour o=
f
>anything).
>	* too late in the cycle for tree-wide patches like (2).
>
>As far as I'm concerned (and if it makes -stable folks' lives unpleasant,
>too fucking bad) the merge order is: (1) as soon as it's sufficiently
>reviewed and tested, (2) and (3) - next merge window.  The only question
>is what kind of metadata should go into commit messages to minimize the
>PITA for -stable folks, *given* *that* *merge* *timing*.

Right, -stable shouldn't affect how/when you merge your patches in.

Also, in scenarios such as this we have enough tools in place to figure
out the dependency chain, and we could address it when backporting to
stable.

I don't want to create additional work that you wouldn't do anyways.
Keep in mind that the Fixes: tag will also be useful for yourself later
on if you have to go back to this patch a few years later.

As to the question you actually asked, assuming patch (3) is important=20
for stable as well (you didn't state it explicitly), the correct=20
tagging would be:

For patch (1):
	Fixes: AAA ("Commit from several years ago that introduced the hole")
	Cc: stable@vger.kernel.org

For patch (2):
	No tags

For patch (3):
	Fixes: AAA ("Commit from several years ago that introduced the hole")
	Cc: stable@vger.kernel.org # commit-id-of-(2)
