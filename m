Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AB8JxZq1CV2bRq9DxEQfDNuyx80EKBmvxvFCK8qGrqX+Wa4nNBbk51JPIbNXe/QbMpgU89DOQTtS
ARC-Seal: i=1; a=rsa-sha256; t=1525290154; cv=none;
        d=google.com; s=arc-20160816;
        b=XVqLiP7x1L6/T66MsvkRrTcqh3XKUduE/5sOAdQcKsMGmbn+/PIAsWJqs8VCbhFah/
         eGCf/yY2st9AE9LIx5myGynWwW91Qo21GeVFIRiiCfH+A+pXA2jEyzEdqR0JIDSCUn6f
         6F/KOX/GtNlISOaerBM/bZCyTIKAPy9Hyo5HUoGyyKTyO/f/VCyaUFzRXQy+3xbilahV
         FYrRU2tN0ThZzHG9Ja5LmRwhRDnt0ei307SAyGMHnt6Ht65x8xZHECJbY9t12Nz2+jq/
         FtsQ36f4VJn20uZzuoWod27ca+85VzOUSuZpIOk5z/+p16q2Lh+nazUw/6WjvEUWPE0V
         TTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=gkIAIbTRrsspykUwHAYnRvVkv9W+oqiLnwlHGIsicvg=;
        b=hrAfqsxl83sVDwAK8JPmkRu1C62H4PiETiSsWa4z1aQj/42CBRtCkZP3SWeBPc5l76
         9oTmNiayaht3WKRnzKJotWEo/v0jFwa05g3D485qGd4UWUcmfGO9+5w7UwlCmvKVcZQ9
         ky1SH002koVFJEa9juYwjzx6AdjuKrv+L5j3MsYOOlxhXGnrM+IC5kEJ8a4FIothYI7a
         DVTABq81DaQGvHUzrNDVlkQ84NozOvEp/dV6bELm1nEsCPbotIWIkF+Cz6wo30tzfS3J
         NDLjFt5fwRht4BExntGaUD8QAH5+rrQFS6EjGl/E/y1OCUWD4bqYPg57SqkhU0nHX1sg
         39NA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=K5DVlZNT;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.129 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=K5DVlZNT;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.129 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Willy Tarreau <w@1wt.eu>
CC: "Theodore Y. Ts'o" <tytso@mit.edu>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>, Greg KH
	<gregkh@linuxfoundation.org>, "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: bug-introducing patches
Thread-Topic: bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQbRuYAgAAEU4CAAA85AIAAEugAgABsW4CAAP7fAA==
Date: Wed, 2 May 2018 19:42:33 +0000
Message-ID: <20180502194139.GA18390@sasha-vm>
References: <20180501163818.GD1468@sasha-vm>
 <20180501194450.GD10479@thunk.org> <20180501200019.GA7397@sasha-vm>
 <20180501205448.GE10479@thunk.org> <20180501220228.GD7397@sasha-vm>
 <20180502043017.GA11938@1wt.eu>
In-Reply-To: <20180502043017.GA11938@1wt.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1096;7:g+1x/VeFLtNm1tOfcbqOnAfGSt+35xPMZsX7vZpLdposd4C1BgX+qljDFBkwLPOuhm0BOic+/ZZ1BlgqA7b3zHZHVK2GqwzN3NdbroRDlXKlXPmw75Gcg2lU5B67p6pAeSwMUH6lEBSXeNT9WfkahBbg6PLb3VwHYxrREVjfoYPU0uAyW37rzU75SjjeIuZI7AEgZtMml96M3LA36UGhl16mmlN+cUhsHCS3ZKhYR/eiyq5LJodV9aElZqa3j2PO;20:8iWsxX2a72Qfn6XseCOP30dMW69W83NGnvsXjpU+LgEfJc5loClo6ktODmctANtFFSm9WkDHIwqJmaypi2w0eDHziyDSG6bfwxBgy/Od7jPuRa9Nvtv6XxrmZcU6PndtpfUZqCe2eMRe3iMBCtvNNkZr6L74KCJnUoQzwseO84E=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:DM5PR2101MB1096;
x-ms-traffictypediagnostic: DM5PR2101MB1096:
x-microsoft-antispam-prvs: <DM5PR2101MB1096B2A4683EACF0730BF75FFB800@DM5PR2101MB1096.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1096;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1096;
x-forefront-prvs: 06607E485E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(39380400002)(366004)(346002)(39860400002)(376002)(199004)(189003)(66066001)(446003)(59450400001)(486006)(11346002)(33896004)(5250100002)(72206003)(10290500003)(478600001)(33716001)(476003)(99286004)(6506007)(102836004)(305945005)(6436002)(6346003)(7736002)(186003)(26005)(6486002)(229853002)(86362001)(6512007)(8936002)(9686003)(81166006)(93886005)(3480700004)(53936002)(6916009)(86612001)(76176011)(6246003)(81156014)(5660300001)(8676002)(10090500001)(3846002)(6116002)(68736007)(106356001)(22452003)(2900100001)(3660700001)(3280700002)(4326008)(25786009)(2906002)(33656002)(316002)(54906003)(1076002)(97736004)(14454004)(105586002)(781001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1096;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: wBwtJOneXwtOCVxzjt1SEsbxczZf7e9aBSj5e0EDE2FSj9WNCyjfnjblyztkL5EyH/Bd8ER45qT98jb7TGjcu98vP28VpbAPCOOeoSjMM5WUrKrK1J+jbA1gEZZuwCrNFRourhiA71RNYcrLcddCSv4FEiJiuC4mouUVnIjTO8s7Cc1rXDWKRgu6LwUcmkhN
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1FCAA105DE9EBD44AF6E8D9BD126E782@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 076cd2b0-90e7-4f15-773f-08d5b064d976
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076cd2b0-90e7-4f15-773f-08d5b064d976
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2018 19:42:33.4090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1096
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599382649051818260?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 06:30:17AM +0200, Willy Tarreau wrote:
>On Tue, May 01, 2018 at 10:02:30PM +0000, Sasha Levin wrote:
>> On Tue, May 01, 2018 at 04:54:48PM -0400, Theodore Y. Ts'o wrote:
>> >Post -rc3 or -rc4, in my opinion bug fixes should wait until the next
>> >merge window before they get merged at all.  (And certainly features
>> >bugs should be Right Out.)  And sure, bug fixes should certainly get
>> >more testing.  So I guess my main objection is your making a blanket
>> >statement about all fixes, instead of breaking out regression fixes
>> >versus bug fixes.  Since in my opinion they are very different animals.=
..
>>
>> I understant your point, you want to make fixes available to testers as
>> soon as possible. This might make sense, as you've mentioned, in < -rc3.
>>
>> So yes, maybe the solution isn't to force -next, but rather add more
>> "quiet time" at the end of the cycle? Make special rules for -rc7/8? Or
>> even add a "test"/"beta" release at the end of the cycle?
>
>I disagree with the proposals above, and for multiple reasons :
>  - leaving a known bug on purpose automatically degrades the quality of
>    each release. Given that less than 100% of the fixes introduce
>    regressions, by not merging any of these fixes, we'll end up with
>    more bugs. That's a very bad idea.
>
>  - this will give a worse image of dot-0 releases, and users will be
>    even less interested in testing them, prefering to wait for the
>    first stable version. In this case what's the point of dot-0 if it
>    is known broken and nobody uses it ?
>
>  - letting fixes rot longer on the developer side will send a very bad
>    signal to developers : "we don't care about your bugs". Companies
>    relying on contractors will have a harder time including fixes in
>    the contract, as it will only cover what's needed to get the feature
>    merged. Again this will put the focus on extremely fast and dirty
>    development, given that fixes will not be considered during the same
>    window.

I'm not advocating to keep bugs in. If there is a fix, but the developer
can't indicate that proper testing was done on the fix we should revert
the new feature rather than merge the untested fix in.

The way I see it, if a commit can get one or two tested-by, it's a good
alternative to a week in -next.

>I'd rather do the exact opposite except for those who introduce too many
>regressions : set up a delay penalty to developers who create too many
>regressions and make this penalty easy to check. I think it will generally
>not affect subsystem maintainers, unless they pull and push lots of crap
>without checking, of course. But it could prove very useful for those
>developing under contract, because companies employing them will want to
>ensure that their work will not be delayed due to a penalty. Thus is will
>be important for these developers to be more careful.
>
>After all, the person proposing a fix always knows better than anyone
>else if this fix was done seriously or not. Developers who do lots of
>testing before sending should not be penalized, and should get their
>fix merged immediately. Those who just send untested patches should be
>trusted much less.

I'm a bit worried about (social) side effects of a scheme like this.

>> From what I see, the same number of bugs-per-line-of-code applies for
>> commits accross all -rc releases, so while it makes sense to get a fix
>> in quickly at -rc1 to allow testing to continue, the same must not
>> happen during -rc8, but unfourtenately it does now.
>
>That's where I strongly disagree, since it would mean releasing with even
>more bugs than today.

Just don't release it. If we don't have a tested fix for a reported
regression either extend the release cycle (-rc10+) or just revert the
new feature and get it in the next merge window.=
