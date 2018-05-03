Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AB8JxZrpzXqSYoAnAMpv4Yn+aF/Sn1EMhz76zfMGNyLmwfl7cc0f6H4JcX2zZo+8ZQ6v+QUYQOWv
ARC-Seal: i=1; a=rsa-sha256; t=1525359339; cv=none;
        d=google.com; s=arc-20160816;
        b=gFfmv/5NUTR8UtBoDx/vZ6AK7tzDHv+o5mX8LRGOhUwh3P7srh1pSpTCn6dtCFm92T
         6GwpJR8Q3DBBYYPrwqUbEFw6bVB3oBPvmtJvw/LOaTLMTTDXdF0WovlP6txZpAdfZd3E
         YYds7I+O2LSV7NSZx6tfAtHDhpi52nqoNj3/PfkmAidp47fMq9qPBqZ+CiavSTg0hCr7
         k/DmsBvQSlaDQSDCF/qpWMrVRMXT4d3AZtZUZJoIl3zb/r/Zjkdw1++zSmOFdVdjT8K8
         m/gPjIZteDK9kXPqtoz70h3V+J1U0UZheSQxhAyeZoAO2hKl2eoNlxG56JkgofhX61fc
         0kEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id
         :spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=gTrumQkbsBh7et8Yckm9Pus0wTRCzQLc0vr+Hzp0NWo=;
        b=iEiTfmbaPRP2T1Utpc9qDQBuaCuvlHf4sLtIF1F9MqHBhnJP4kEOxleXimEMEuWoUz
         nKFasaEJNRgCyPxnkBs6n+Al1pIpWlHvNSzAZKpq9dlDjImMQ4Xy3PWv/UspK/igQc6L
         daD7/uV4kzoecqZwfebDN4NENsTJoorWebgRc/RvdnoXVptHa1MYebl6f7/WPTaEuzeU
         8dqV+o8qtjIZvZcNyhZH721SJEq2IcdiMIe07YDN9qGgz9rxJj1FPnf3JldBvYbAZ1UJ
         R85H8z+p8UgLswchdziSGTQinE+iDgLPaNxQb7WXu7B+nfkSPMzRmOQX1A7ojxYbdEuv
         J3JQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=oYE4d7dd;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.32.106 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=oYE4d7dd;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.32.106 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: "Theodore Y. Ts'o" <tytso@mit.edu>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "w@1wt.eu"
	<w@1wt.eu>, "ksummit-discuss@lists.linuxfoundation.org"
	<ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Thread-Topic: [Ksummit-discuss] bug-introducing patches
Thread-Index: AQHT4WrQpZfAdTeY4k22b0OVmzGN0aQcksOAgABIXgCAAA4OAIAAORwAgAAI/wCAAO9ygA==
Date: Thu, 3 May 2018 14:55:36 +0000
Message-ID: <20180503145533.GK18390@sasha-vm>
References: <20180501163818.GD1468@sasha-vm>
 <CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
 <20180502195138.GC18390@sasha-vm>
 <CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
 <20180503000620.GA29205@thunk.org>
 <ed65dc49-dad0-21a1-676c-f9ba43ba5c6c@roeck-us.net>
In-Reply-To: <ed65dc49-dad0-21a1-676c-f9ba43ba5c6c@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1050;7:2/1xGe1+dim/FsCRbhyz7HFbXcS/i6rTEGUmXIzkkZTQBVBhOXzSPt+Jj0qc0uYmRy42UtDtTIK5RqyGQ2yk4fUI4KeE5rzRU4aqQxGWdXnYw7tYK9t5RlO0aacNHHwIhgpQmL9Ih4IUJpbyPNbva7VYAqPNGRSsaMqDT3AQ/suhMxwGLUZQ3ytcz4Q3LGYcbkMU93Ut3OG8gL8mpqpv0X5r42UjCTFT5VaNSZPITHh0CVxTscy/QVf9U5PlEFUE;20:i42XANw2EBi9d65NSq5dA01GfYH2WzMJZ2EN73N9K9+C4+bZsz/E4xk6SSQlVHdrXewxO+JiMljI5E1VtzatRN+egQfpbgu5+v2Kvvbrax/Yon0YgGlOxWSKw4sIMHf2TMi+/9ULkZu63v+n2hw9xGWWaE/NqtQK5PYLp5JwjGY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1050;
x-ms-traffictypediagnostic: MW2PR2101MB1050:
x-microsoft-antispam-prvs: <MW2PR2101MB1050799EFD21A8D060E27836FB870@MW2PR2101MB1050.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1050;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1050;
x-forefront-prvs: 066153096A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(396003)(346002)(39860400002)(39380400002)(376002)(189003)(199004)(51444003)(105586002)(14454004)(8936002)(106356001)(68736007)(6506007)(99286004)(81166006)(81156014)(10090500001)(33896004)(2906002)(8676002)(1076002)(59450400001)(3846002)(316002)(76176011)(33656002)(66066001)(22452003)(6916009)(4326008)(6116002)(7736002)(2900100001)(305945005)(93886005)(25786009)(11346002)(6246003)(5250100002)(446003)(229853002)(33716001)(3660700001)(486006)(9686003)(6436002)(476003)(72206003)(6486002)(6512007)(86612001)(54906003)(26005)(53936002)(102836004)(10290500003)(5660300001)(6346003)(186003)(3280700002)(478600001)(86362001)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1050;H:MW2PR2101MB1003.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: ouQWDg4yD4iOh4IUps39iquYZGQuMV/323uMGw7S0/C/Y2pVZCNEGSbr7HtCzoL4C+r+4haQ9Tq9/SRY5qNnBc2dX/rreCuVHRrRCoD3oALS84mo/IlaI/rKNpfMNuV+gxuJWjpz5qnNoajeX9ueHnweeLJwGe8smzJv8y3OAY+y4Kw0NHNL2Xnsuc8Pss/k
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <694DD0E4A200374191C4CF1CFDF8C0C6@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 2a1a09d1-6ef5-4a78-537f-08d5b105eddb
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1a09d1-6ef5-4a78-537f-08d5b105eddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2018 14:55:36.4288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1050
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599455195231834797?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 05:38:32PM -0700, Guenter Roeck wrote:
>On 05/02/2018 05:06 PM, Theodore Y. Ts'o wrote:
>>On Wed, May 02, 2018 at 10:41:56PM +0200, Geert Uytterhoeven wrote:
>>>
>>>Between v4.17-rc1 and v4.17-rc3, there are 660 non-merge commits, of whi=
ch
>>>   - 245 carry a Fixes tag,
>>>   - 196 carry a CC stable,
>>>   - 395 contain the string "fix".
>>>(non-mutually exclusive)
>>>
>>>That leaves us with 200 commits not falling in the bugfix category.
>>
>>Some non-bug fixes are allowed in -rc2.  So perhaps what might be
>>interesting is to look at v4.16 (which is completed), and look at the
>>distribution of commits:
>>
>>	* regressions fixes (for bugs introduced during the current
>>		release cycle)
>>	* "normal" bug fixes
>>	* commits which don't touch code (e.g., spelling or
>>		documentation-only fixes)
>>	* other commits (features or cleanup fixes)
>>
>>at each rcX level.  The historic "standard" has been feature commits
>>in -rc1 and -rc2 (tolerated, but ideally should before the merge
>>window), bug fixes / regressions in -rc3 and -rc4, and after -rc4,
>>regression fixes only.  It would be interesting to see how well we
>>have been holding to the historical ideal.
>>
>>It would then be intersting to use Sasha's analysis to see whether
>>there are more bug fixes caused by regression fixes versus normal bug
>>fixes, and whether or not they are common when fixes come "out of
>>cycle" --- for example, a non-regression bug fix in -rc5 or -rc6.
>>
>>Because if that last is the case, then the prescription is very simple
>>and not controversial --- bug fixes found post -rc4 should be held to
>>the next merge window.
>>
>
>Holding up even fixes for severe bugs for 4-6 weeks ? Seriously, that is
>unrealistic. Holding up the fix for the next SpeckHammer because it was no=
t
>ready before -rc4 ? I don't think so.

For severe problems, the patch usually gets more than enough reviews and
testing, so I don't see a need to soak it in -next more than some
minimal amount of time to get bot coverage.

However, these things show up only a few times per year. Most of the
fixes even in late -rc cycles are for older bugs that aren't too
critical. We can't base our decision on severe bugs that get exceptional
treatment anyways (see PTI getting pushed in -stable).

>Even when not counting severe problems, you are adding lots of additional =
work
>for those who do and want to rely on stable releases to merge in bug fixes=
.
>Sure, I am at times annoyed having to deal with a regression in a stable
>release, but it very much beats digging through various mailing lists for
>pending patches to fix CVEs, or for crashes seen in the field, just becaus=
e
>they are held hostage by some restrictive process. Even worse, I'd end up
>picking the regressions anyway because I can _not_ wait those 4-6 weeks
>plus the time it takes for the fixes to show up in a stable release.

I think that for -stable we don't have a good idea how soon we want to
merge patches in. On one hand enterprise distro folks complain we're
jumping the gun, and on the other hand folks like yourself claim we're
too slow :)

>Really, that just makes the situation worse for everyone. We would be much
>better off by further improving test coverage.

I'm definitely not saying "no" to more test coverage, but these are work
streams that can happen in parallel.=
