Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AB8JxZr97bof1vfUu3Uii89n6Hz3KjkgZKeuckE+qrkf215YcsPQQ06djZl9T6smiDwCv5cG0vve
ARC-Seal: i=1; a=rsa-sha256; t=1525470677; cv=none;
        d=google.com; s=arc-20160816;
        b=acqeTOF9RM89NhRYkMPPw6pRkg8S7YyWzXfFzVZG54zuxZyt8oZpmpnPa7zswzCLE2
         dUxGf7B+7MT0F6R2YJ37pmaXcQJ4Bo/IksmszJQgws8ZpSeDBFYYw5uFihglVJkXDtCo
         GP4bRouykfMxDk+81QGxFKqKJ/ObDmfOhl8TiKBw97J/xFXL1FdS0GjiFVhBNkfq5Iu6
         M5T8+Wboef2qx9OoyLb/1uGCiou4rGVxszychaVDO0Sqwc/y9KEfeu4fhUBr28OM70j6
         48FnX+jVAf7LbTUoX2i5EZ3SmD9+AxKJUhIZHNYmcY4BXgBgGNOz3PYZ3//FD6RZRkrQ
         FXhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=GifOhsjOHsokvHJOhNIz81RnkKROdvpihNxJI8vkYbA=;
        b=lSR9LQZM9rt/wxFN4zBF38gPQHk1rG8NvTG23lTUeWfiM35mA2e8LC6OaFr+4pTq9k
         M4fmlvBunyCYXo/qZcCd6Sr6HIwIb+yuTA1kBD2aw5yOZ7SjMnv8VdO4f9f5jFbfI1d0
         ZCC1HuDId1A8RFaCluP+VVXutwtLaxzPgychL5+MZClbJLnSj9ppuq9hKNZPzjFv10UK
         4mdFLUQh9Ezx4pEkpqzeP+aUl1LS6we5G+9Nc5cjloFfva44Etq/XIynnkCnE+guhnC6
         hkeQ1i45jj3e51JItmplIxJ2rQo4BJlvg/S5qwPYBmDTL8I7BSmX2nQ7WReBk10u0m5h
         gLsw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=bF65tMQJ;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.125 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=bF65tMQJ;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.125 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
CC: "Theodore Y. Ts'o" <tytso@mit.edu>, Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Thread-Topic: [Ksummit-discuss] bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQcksOAgABIXgCAAA4OAIAAORwAgAD11QCAACPrAIAACxEAgAAM7oCAAAxCgIAA+ZwAgAAq2oCAAAqwAIAAS9OAgAA7VoCAAAbpgIAAA66A
Date: Fri, 4 May 2018 21:51:14 +0000
Message-ID: <20180504215111.GX18390@sasha-vm>
References: <20180503144612.GJ18390@sasha-vm>
 <20180503165446.GB30522@ZenIV.linux.org.uk> <20180503173422.GR18390@sasha-vm>
 <20180503182039.GC30522@ZenIV.linux.org.uk>
 <8669.1525427874@warthog.procyon.org.uk> <87fu377gbu.fsf@intel.com>
 <20180504130932.GI29205@thunk.org> <20180504174055.GF4649@kroah.com>
 <20180504211317.GK29205@thunk.org>
 <1525469881.4114.5.camel@HansenPartnership.com>
In-Reply-To: <1525469881.4114.5.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1019;7:wrbxh3yrJTdErRJkoyhYQWPoflicqT5xyTzfI//v10kgJ1lRwO4dLIDrqMpLmpb82J/v6KhxkuDUHziEgEK+DtTESEXXdo/CJNZPoZ9crqWS41mFvdMuk5LjjtKbj5jaUxfs3WFIF45uNPz0SZLQ0VJv7VzcuQ/DF0AWL9gv4z8mBBcdihpoLf3MjMEKJH6QZaWwE9X3Hb8Hb8VqxRes61dZ4sej3yd2WZHmwHkBXzkFc/i1HuHV9VIkMwGW3sFF;20:p+t3omBy7dWIEawIM+7vp3IuLPjCD+xiHhi4fNqiqnqeZqoI6CMB/lvbiHbSJMhYPbp/iIboZr6G2hm9yukSxubuRq3dpaUXHQ7Jgi8UJ3KE/EzDIsnLq4OOYApbBeH5WOf9iG3+bNT63caLWRo45iKKHNX7QUD09Q6hgwNSVCM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1019;
x-ms-traffictypediagnostic: MW2PR2101MB1019:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1019BE0D3B9194E2071EBD15FB860@MW2PR2101MB1019.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149012)(150012)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:MW2PR2101MB1019;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1019;
x-forefront-prvs: 06628F7CA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(396003)(346002)(376002)(39380400002)(39860400002)(199004)(189003)(377424004)(316002)(478600001)(2900100001)(14454004)(10290500003)(81166006)(81156014)(33656002)(66066001)(72206003)(561944003)(8676002)(54906003)(86362001)(6246003)(86612001)(106356001)(68736007)(6916009)(53936002)(6486002)(93886005)(25786009)(22452003)(6436002)(229853002)(6306002)(97736004)(6116002)(3846002)(11346002)(4326008)(1076002)(102836004)(6512007)(33896004)(5660300001)(2906002)(59450400001)(9686003)(446003)(76176011)(5250100002)(6506007)(33716001)(10090500001)(966005)(305945005)(105586002)(8936002)(3660700001)(7736002)(3280700002)(186003)(476003)(26005)(99286004)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1019;H:MW2PR2101MB1003.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: sxW0uYfthKajGs0BpjnFP4xD1C6mw2ohO8P2EjbKGmRTt5k3E+S83FAv4jbHJT48KJPLoA3+WSVWThqOvXzmo98XLmoL659OQucVNx3xXZUMjcV465liLsxrOCUnRXkDYYWtoowOpyN6FrTuveIg7edq8THlbrmYRxjLkub9oTz3q1y3MxJ6PVKmjAlo6KdB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <4E617C543807154F9DBC199DF9BA7781@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6143654a-7841-4e3f-f469-08d5b2092861
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6143654a-7841-4e3f-f469-08d5b2092861
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2018 21:51:14.3344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1019
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599571940732239655?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 02:38:01PM -0700, James Bottomley wrote:
>On Fri, 2018-05-04 at 17:13 -0400, Theodore Y. Ts'o wrote:
>> If it's not necessary, fine.=A0=A0But we should still delete what is
>> currently documented in stable_kernel_rules and was introduced in
>> 8e9b9362266d, because it doesn't describe current practice.
>
>It definitely doesn't seem to describe current practice.  It looks like
>it got applied because the commit description bears a somewhat strange
>relation to the actual text that was added:  The commit talks about the
> original script that used to forward to stable (although it got me and
>hpa confused) which seems to refer to a tiny deletion and the rest is
>adding an Ingo one off proposal for dependencies.

The usage for something like this is only if a commit that we didn't
previously think would go to stable now has to because it's a dependency
of a new -stable commit, so the expected usage will be pretty small
anyways.

I don't have an objection to moving this to it's own tag. It will make
my scripts somewhat simpler for sure.

>For the record: Greg runs his own script now and I'm not involved.
>
>Current process (at least from the SCSI centric view) is that if we
>screw up and forward a commit with missing dependencies to stable via a
>cc: tag, it won't apply and Greg tells us to fix it, which we do.  That
>seems to be an adequately functional process for the odd times we run
>into this.

Assuming a commit won't apply/fail to build because of dependencies is
really not a safe approach, which I keep getting reminded of quite
often.

See for example this patch:

	https://patchwork.kernel.org/patch/10243707/

It will apply and build, but will fail to boot on a particular flavor=20
of ARMv7, and this is just the obvious failure modes of approaches like
these.

So again, I don't have a an objection to changing the docs or the way
it's being done now, but the new way should make it very easy for folks
to list dependency chains if they want to.=
