Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AH8x225V90qJ0++geGJkzCmU1Tdk6+RMr2JahpY2Ctg3d4WNHZx5lUwWNniKxCU+hRUn4rMS+gJ9
ARC-Seal: i=1; a=rsa-sha256; t=1517882542; cv=none;
        d=google.com; s=arc-20160816;
        b=bVQhH9ibzfoaJEB3AHn58NsizTOa3IOOjJyRSa93gGjheHh7RYTAHrAzD4dF98h7DG
         AdjQP8zFfNlWzDA6XX7eFAxN97eGBATRjbbMw6UPEvSdxrnr/e8Hmy+DO8cJr+ZNKjOd
         su46A7o2AkSyHMPEcpnDfc7ebndSWHIwN5fRRo70UiKOWrAD95nJD+nG9OgKMkuUxX+C
         Q/b7VA10jHtv3/hMxMTayG/mzsRFj2ahBdp8j7OqzQw3sLc/CbENsDR/rmNQNSNlTn5v
         fxBee0YCTvglXe1zoWscbhY7vCfKxtCNMxiaMBKg6n/NC9DVtghwkQqMwYtIC0myy6/J
         AC8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=im4djNRSMs9IWk6jCRw1gdTeAC+m+QQT4Rp7u07Dpzs=;
        b=C4aXlgai/AFNr029eIhpTVKCQNYOkjOiQwwMeWkN1/fN8AEFCfTUTbPaEt5OMyC/xy
         eoIC33+pKMqpz5ZKWWXd+OR5k78hZkQE6Jz2lD4HM5iPLj5ywrY3OTPgWtONY8gPqfq1
         iS4kJjq68IenLD5rTT5IaiIelmJXzF4BPGoAHo6/6UDBqMCyqAqhOf9q6RLWzR9qshUO
         9gYQpadG4x3SMCIXWlcNMCuGmTQ/8dew4AMir6RDr4g7bCTCuz8GQel0Y1HHmddOeUYm
         uuZW7ptn7vcB3KRuw+o2iB5M17oScW2pRw5EzXoG3/Xve8Jw3Ha93aqqRy7MG7xYt416
         oBUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=eeY35pzU;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.138 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=eeY35pzU;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.138 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Pavel Machek <pavel@ucw.cz>
CC: Greg KH <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, Matthieu CASTET <matthieu.castet@parrot.com>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, Jacek Anaszewski
	<jacek.anaszewski@gmail.com>
Subject: Re: [PATCH AUTOSEL for 4.14 065/110] led: core: Fix brightness
 setting when setting delay_off=0
Thread-Topic: [PATCH AUTOSEL for 4.14 065/110] led: core: Fix brightness
 setting when setting delay_off=0
Thread-Index: AQHTnRjyue81aK36CEu9eh05vWJz5aOTItkAgABBrICAAI/mgIAAJC0AgABlUACAAiTmgA==
Date: Tue, 6 Feb 2018 02:02:19 +0000
Message-ID: <20180206020210.m6gl7vai4p6azb6s@sasha-lappy>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
 <20180203180015.29073-65-alexander.levin@microsoft.com>
 <20180203203525.GA5860@amd> <20180204003029.2lkcmh6wvzpnlrls@sasha-lappy>
 <20180204090531.GA29468@amd> <20180204111500.GB14797@kroah.com>
 <20180204171736.GA1388@amd>
In-Reply-To: <20180204171736.GA1388@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;7:ghjPmZZQHjTMMJM/O0cI/xYFShjnUXqmVxQXFSahhyqhYDcBMBB9ShVOQm9SeiuM8YkA6cArldqT2PSLa3shpJ221sZlmcABUxZy4v54o7oUyfMFKxtYjKxSS6iuTnX+/gak61ENNmo9mxtL3a+UzRUJ9d6rxfvJe3vomvq+F9g4gCYyHz1/R/No89nRkRZl225x+eu8G+38bqdTFdyn53DeTjoiA/DRskfdldttiLXPnUDxH6ovNSTD0rfWRP3E
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f6c60696-3d94-4cdc-b8d7-08d56d05a7ac
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
x-microsoft-antispam-prvs: <DM5PR2101MB1080CEEECAE302448B94300AFBFD0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231101)(2400082)(944501161)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 0575F81B58
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(39380400002)(39860400002)(396003)(346002)(376002)(199004)(189003)(76176011)(10290500003)(2906002)(25786009)(86362001)(72206003)(3846002)(6506007)(66066001)(81166006)(81156014)(6116002)(229853002)(8676002)(4326008)(53936002)(5660300001)(3280700002)(6486002)(59450400001)(33896004)(3660700001)(97736004)(68736007)(14454004)(5250100002)(10090500001)(478600001)(6246003)(186003)(22452003)(105586002)(9686003)(316002)(7736002)(54906003)(106356001)(305945005)(6436002)(99286004)(39060400002)(2950100002)(33716001)(6346003)(2900100001)(93886005)(6916009)(8936002)(26005)(6512007)(86612001)(102836004)(1076002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: 7ynQKSAgG1DjFC3jmXfEabAfwZbt3sUaZ78Vmj84ROmRSpWI5XN4/oZ2ny25AUMKQP1iJA9MBZaYRTJGC1cTvA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20CCE1AC4EC69D4094B6297C12D5B03A@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c60696-3d94-4cdc-b8d7-08d56d05a7ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2018 02:02:19.6730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1591491593744715241?=
X-GMAIL-MSGID: =?utf-8?q?1591615205342412331?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 04, 2018 at 06:17:36PM +0100, Pavel Machek wrote:
>
>> > > >> *** if brightness=3D0, led off
>> > > >> *** else apply brightness if next timer <--- timer is stop, and w=
ill never apply new setting
>> > > >> ** otherwise set led_set_brightness_nosleep
>> > > >>
>> > > >> To fix that, when we delete the timer, we should clear LED_BLINK_=
SW.
>> > > >
>> > > >Can you run the tests on the affected stable kernels? I have feelin=
g
>> > > >that the problem described might not be present there.
>> > >
>> > > Hm, I don't seem to have HW to test that out. Maybe someone else doe=
s?
>> >
>> > Why are you submitting patches you have no way to test?
>>
>> What?  This is stable tree backporting, why are you trying to make a
>> requirement for something that we have never had before?
>
>I don't think random patches should be sent to stable just because
>they appeared in mainline. Plus, I don't think I'm making new rules:
>
>submit-checklist.rst:
>
>13) Has been build- and runtime tested with and without ``CONFIG_SMP``
>and
>    ``CONFIG_PREEMPT.``
>
>stable-kernel-rules.rst:
>
>Rules on what kind of patches are accepted, and which ones are not,
>into the "-stable" tree:
>
> - It must be obviously correct and tested.
> - It must fix a real bug that bothers people (not a, "This could be a
>   problem..." type thing).

So you're saying that this doesn't qualify as a bug?

>> This is a backport of a patch that is already upstream.  If it doesn't
>> belong in a stable tree, great, let us know that, saying why it is so.
>
>See jacek.anaszewski@gmail.com 's explanation.

I might be missing something, but Jacek suggested I pull another patch
before this one?

--=20

Thanks,
Sasha=
