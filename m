Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AB8JxZrKyaKG0bRBdcv2chn77L8qcYdRWEWGiyvzzuLqWCt3xB7sS2t/r0U5Mm5srs6LQEimdA/n
ARC-Seal: i=1; a=rsa-sha256; t=1525371158; cv=none;
        d=google.com; s=arc-20160816;
        b=vEWi2ruExXvcJmu5auQhXyxA9CerA+xJviPJUJu1JiYI6t7vyELrdCDghPowyLkG7/
         zAqDIxbIl8j5T85klmDFXGrAANhB49peIHPl5wADOAGzh/o8ZiPW08TkctS84dI0pUmR
         Yt5G0tbopHOuP+8KEu2s2rL3ljovJ7sibSGspg1mSmGD/LcMmByIn40EbqZUMd8oAaQ2
         WFC1X/XR8LJFopsxpjq+MtuVg+pCSD9y5dpb3DkABz3M+It1bKuqaKZeTJ7SG0jzw+Ms
         +lcplFK126MjOS5UamVZ0Y2b5/XOdI74GSfrQ+DV8mBCguJceB4/NNxM8NR+/FXHdiBf
         3WqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=7IVb7hzJ8s0IjmxiblN4q/NMPYSnV4xDvaxQw1GHYpA=;
        b=lbO4fM/VUSi0Wwk87K+zcaHI/D7xohwWWciE45QSg5OeQ+W/aCKlmc2p9vtB/p7tRt
         eMsZwYRHOrYyJHfUEKRIGa8yz9ZHARc8XEYPZT5RW0niS4DOrf5H8WlWjEg12/xA9cI4
         Ic4Yn6RzUf+1rq6JMWSouDWhwavf9hVWYPkXiK6UmGgD//haFyDB8jsltB5G+Uu46GV+
         YmfTcOzuBPht0wfikOKhtQMMLyXFUCUECSaQgrNkemBkGo/PFd0u4u/JaFtVI0lf5+jM
         D7gOPyk2EO2mAcAMEnOGVg2IF+m3EZW/G/utAFKvE5/Nv0C/5QQLJ9fu3AQghEIlKYoK
         DwXA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=LwP0SQUB;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.136 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=LwP0SQUB;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.136 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Willy Tarreau <w@1wt.eu>
CC: "Theodore Y. Ts'o" <tytso@mit.edu>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Thread-Topic: [Ksummit-discuss] bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQcksOAgABIXgCAAA4OAIAAORwAgAD11QCAAAGkgIAAAoMAgAAQrgCAAAPwAIAABbQAgAAPIgCAAAfPgIAABD4A
Date: Thu, 3 May 2018 18:12:36 +0000
Message-ID: <20180503181234.GT18390@sasha-vm>
References: <CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
 <20180503000620.GA29205@thunk.org> <20180503144612.GJ18390@sasha-vm>
 <20180503145205.GD23311@1wt.eu> <20180503150104.GL18390@sasha-vm>
 <20180503160046.GH23311@1wt.eu> <20180503161452.GP18390@sasha-vm>
 <20180503163516.GJ23311@1wt.eu> <20180503172926.GQ18390@sasha-vm>
 <20180503175723.GA23467@1wt.eu>
In-Reply-To: <20180503175723.GA23467@1wt.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0921;7:xBvchK5ldMzmexthj9YnLWJVkURP8hbQHERPkAQXeotj9KnNe6336YVPnDmPRlBOxgoTXmaofu2x23IN4Bq9lNgJc5lYYZ8ikEmm6dJ120jCE4xePeSUFqC5REhQnzU3+FlTiWvM2CbEDFgKihWMdqlzUI5X6HnRnSdHfcsSsnEzdXoTm+CmXtnNawWbH+Qul+YxxnLj0m4mxvV5/DJOYgZXWnebX02fI8xTP2cifwuR+4sSrcNCna+94fgS7ndl;20:0QmfTTHA4wHyUDNmNq/8CE0G51SbG2dFr+LrLYZs3+u1tKW3sqt58oVAFQqmAfvGtkzc82y7MohRRQX55pgYSXLwsLaOHBEj6WhkOQCoQGRhn1jKASEqAexehZuAPLcxwFdO9Ov4xmshnqYCcTfnJYGWfx9aUSFFrckDuD227n8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB0921;
x-ms-traffictypediagnostic: MW2PR2101MB0921:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0921FC9C747AD155A851735FFB870@MW2PR2101MB0921.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(2018427008)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0921;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0921;
x-forefront-prvs: 066153096A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(39380400002)(376002)(346002)(39860400002)(396003)(199004)(189003)(6916009)(68736007)(229853002)(54906003)(33656002)(81156014)(8676002)(8936002)(3846002)(1076002)(14454004)(81166006)(6116002)(476003)(486006)(3660700001)(446003)(11346002)(6436002)(6486002)(3280700002)(2906002)(93886005)(99286004)(7736002)(6506007)(76176011)(26005)(59450400001)(316002)(186003)(22452003)(102836004)(33896004)(9686003)(2900100001)(105586002)(66066001)(478600001)(106356001)(305945005)(86612001)(86362001)(575784001)(72206003)(10290500003)(53936002)(6512007)(25786009)(6246003)(5660300001)(5250100002)(97736004)(10090500001)(33716001)(4326008)(781001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0921;H:MW2PR2101MB1003.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: wP6Pya450u3tlkvt406MA58kQKiEKj1rFysSbphXR0FahEr1AxQFK2xjfuKKO/+0QXEeEC5tl/sjWtB3Y/E20tXklWFBD//mbJYqVVrU8D+36BW/vUVAQBkxwVslTNGDP3ZUqzeVq20Pg1ErLHCA8zq9zbBnzT5GR8vjt6pXqgA3+8jLQApQbbzGMKmXm06s
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <475EDAC50CA8E2408D6D35C296CADBA0@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c2e4aed7-98d8-46cc-8aa9-08d5b121732a
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e4aed7-98d8-46cc-8aa9-08d5b121732a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2018 18:12:36.5748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0921
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599467588018841143?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 07:57:23PM +0200, Willy Tarreau wrote:
>On Thu, May 03, 2018 at 05:29:29PM +0000, Sasha Levin wrote:
>> I tried pulling all the fixes that went in 4.17 (so far) for bugs that
>> were introduced as fixes in the v4.16 cycle, I got this list:
>>
>> d65026c6c62e v4.16-rc7 5 6b1e6cc7855b v4.7   d14d2b78090c
>> 63489f8e8211 v4.16-rc6 13 045c7a3f53d9 v4.11-rc6   5df63c2a149a
>> 5dcd8400884c v4.16-rc6 6 0759e552bce7 v4.7   bd28899dd34f
>> 0ef58b0a05c1 v4.16-rc6 6 0cf737808ae7 v4.14   a56d99d71466 7992894c305e =
2afc5d61a719
>> 8936ef7604c1 v4.16-rc6 6 6c8702c60b88 v4.9   a957fa190aa9
>> bbc09e7842a5 v4.16-rc6 6 65a206c01e8e v4.13   3239534a79ee
>> 6a2cf8d3663e v4.16-rc5 12 d64d6c5671db v4.15   6d6340672ba3
>> 859d880cf544 v4.16-rc4 14 b68a68d3dcc1 v4.15   8420f71943ae
>> e39a97353e53 v4.16-rc4 16 2a842acab109 v4.12   cbe095e2b584
>> a27fd7a8ed38 v4.16-rc4 19 f214f915e7db v4.13   bffd168c3fc5
>> 0f9da844d877 v4.16-rc2 16 28128c61e08e v4.16-rc2   a95b37e20db9
>> 7324f5399b06 v4.16-rc2 19 186b3c998c50 v4.14   51568d69407d
>> e78c637127ee v4.16-rc3 25 187d7967a5ee v4.4   e988867fd774
>> ca9eee95a2de v4.16-rc3 25 d717f7352ec6 v4.12   e988867fd774
>>
>> So out of 755 commits, 14 have been fixed, that's about 2% and we're not
>> even done with 4.17.
>
>OK but this is low. Quite frankly, at 2% regressions, even if this is
>never fun, it means 98% of the fixes were right. Now just delay them
>longer and you'll have 500 commits instead of 755, thus 255 more bugs
>unfixed in the release just to try to save 14 wrong ones. *this* is
>the problem I'm concerned about by enforcing extra delays on everyone.
>This is the reason why in my opinion the most important is to raise
>awareness about this so people are more careful or more verbose (and
>more detailed commit messages don't hurt, I think all stable maintainers
>have many times thought "WTF is this supposed to fix?"), and then remind
>everyone that when some get caught abusing, they'll get a public blame.

This is low because we're only about a month in 4.17. Historical=20
figures are around 7% for these kinds of commits.

I'm also not trying to argue whether 7% is high or low, only that it's 3
times as many bugs per line of code than what we get from the merge
window.

Isn't the merge window supposed to be the "risky" part?

I understand your concern about delays, I'm not arguing for or against
it, I'm just trying to discuss option.

For example, how about extending the release cycle until the amount of
fixes for regressions introduced in the current merge window drops under
a certain thershold? (so go to -rc20 if we need to).

It has the advantage of less bugs when the kernel is released, it
doesn't stop bug fixes from coming in and it prevents the urge some
folks have to push things in last minute. OTOH, it makes the release
cycle unpredictable time-wise.=
