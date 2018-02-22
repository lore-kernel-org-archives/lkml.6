Return-Path: <tommi.t.rantala@nokia.com>
X-Google-Smtp-Source: AH8x224fSvu8+9D7PfolIQbC/ni71rpuwPXGmjuTXMISBeutgrqPfOLzON2IY9dYSdjFhxIwbUXI
ARC-Seal: i=1; a=rsa-sha256; t=1519306684; cv=none;
        d=google.com; s=arc-20160816;
        b=RqDmzTf4Ddzs48q22APb3HqaT84AWggklys8bg2tyt9kAbFNlMRj/pekhF66fwKMXg
         dGfClSlEghH6PAL7d3IyJzogIHoiWpVrabuK4x6KsGW/xMJ+p8MF/7pU36ryGpVmTTub
         EInGIQQuBOpiGSSvZhIxKe/pT6Xu2El83+iscLy+2EiAk0Wtdlwa5S1XhK9OMQRlCiQL
         5+R63163t4BVR5XUx6j7I4wTN6fQY2ozP8/42kBj1tWRvXmH7TkitqfiWl0UPMlF7Eqh
         wjM8XcqisqyaTdAJQm2lUauGdsFUjVs6d23sWY5k6cQH+HhNy3K0xNIGqn40PDtpTgit
         oh4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :in-reply-to:mime-version:user-agent:date:message-id:from:references
         :to:subject:dkim-signature:arc-authentication-results;
        bh=kF3osjFQTdXvYnBaLUUq7+H8bd4ibv0J/iwr5UQDdoM=;
        b=FXLsRCRC4Ag+aSIZR/80nqpPx7bcbW7bfHWz/qzUVIk+qt+OyCVPmuZbjlXphfpjTH
         TwZmELFyT++0qe+hbMPiKCJuXctyO0j5794KP2fKvs5Pziwl3HmOD8SQQ9tzwysoCJTr
         33vxZsbjdZ3HyCM53cS44ebp/Fxw+H4Yx8/GB3AYm741VVBDTs8UMqzDyUsOm16Ey3Qp
         4J6G1CVcyTyT9RiXR+4sTVvTuLBlow9p+2SJhfg0annG/oXXkUeU6TyFVLD51jM7s7wW
         zJcHs+nB5fsGnYfOnUG1btG2B9VFiO1M9fUR4ZYedwNHMt7F3Cif9peNV5xFVyyk7bZD
         QTBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nokia.onmicrosoft.com header.s=selector1-nokia-com header.b=l0mpNDI/;
       spf=pass (google.com: domain of tommi.t.rantala@nokia.com designates 40.107.4.97 as permitted sender) smtp.mailfrom=tommi.t.rantala@nokia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nokia.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nokia.onmicrosoft.com header.s=selector1-nokia-com header.b=l0mpNDI/;
       spf=pass (google.com: domain of tommi.t.rantala@nokia.com designates 40.107.4.97 as permitted sender) smtp.mailfrom=tommi.t.rantala@nokia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nokia.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com;
Subject: Re: backporting "ext4: inplace xattr block update fails to
 deduplicate blocks" to LTS kernels?
To: Theodore Ts'o <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tahsin Erdogan <tahsin@google.com>, Andreas Dilger <adilger@dilger.ca>,
 linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <f3db4b3f-9cb6-c96c-8d31-f2a5f8b4082c@nokia.com>
 <20180221114000.GB6555@kroah.com> <20180221155644.GC9900@thunk.org>
From: Tommi Rantala <tommi.t.rantala@nokia.com>
Message-ID: <5fcdf2b9-9275-4d94-2b4a-e772972130e0@nokia.com>
Date: Thu, 22 Feb 2018 15:37:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180221155644.GC9900@thunk.org>
Content-Type: multipart/mixed;
 boundary="------------3BFFD0D25D988DEB4BC8B503"
Content-Language: en-US
X-Originating-IP: [131.228.32.176]
X-ClientProxiedBy: DB3PR0202CA0004.eurprd02.prod.outlook.com
 (2603:10a6:8:1::17) To VI1PR07MB1328.eurprd07.prod.outlook.com
 (2a01:111:e400:5a03::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8e6f9698-cfb0-4b35-82cf-08d579f97e77
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(49563074)(7193020);SRVR:VI1PR07MB1328;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1328;3:ZP7YgvJO3SiGrNPoWcbzGN9t/bEBxj0sz9FsQ8xKUknm5OC/1GCAAodbLDXavu9S0Yce77++K+lPqmVzfIJXglxeXJ7vQ8XGfRYMP7dB56+QpQMcWEPqneHGD3Oc+L3aUw22WayzJDBeivn3kJt9O4t2ka9aScSF8bs35c744dUDrvraZr+T2Vrvqr4A8xz3YAO4BROXMNuKDhRsGxn8IowC/yJf30hHBmCVYdIG0dfceHRcj36zZ6Y1m1lPrNTa;25:JEwCWvqD6rjzU23M0yWoElfMVkj8c2q78K27tNZk//uqZ8/qGXmD0QVcVOJJknNe42+iaKlX7WQHvmlnU6JJRAk1SIaF+ClPaCqbyxsrRDATndsldS8mgakBBwGnRTLKS0w2YPF/En7hq/97Q0VelAQ7O19hVd9mQHXTJPylQFZiwz/8y2v6hjX++x1rMFqSwCjgDe4hmS+zVl7kLfpaCN22u7sa0yk/sAIwCmnLxIll1oM8QzyCPSOzVPQ2cmbZlv8MrRe+lnkYQk+yyfpMlIvyewPApbMB9C8KQzpeTZqUfc4SMmfqMyjZxq/2vGupHC2any/dNBkCUU0c4vAYjQ==;31:jlDLsJQjqL8YK6O8JQCXWaJDIZyOVF/L06UsWhS9cQ2mQtOEDgwyyXZAGxGxCoTPek6ERtgOeMYsAUVSX/1/74jV6leaVSJ2HOlYFQbrpk4k8E1CxOeJjUo8JDM60pOk5eUv/yfcYyRaoO7l4g85BULRssPFayguyeNupXubvlY+0WOiGpOh+YufO6PjWAF8LqdSRPeIaa3V8doqJoQbLsNu+sG5EODR4qocV24utco=
X-MS-TrafficTypeDiagnostic: VI1PR07MB1328:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1328;20:ynUoqaMy0xYyuhUPJ80xxB21Zfi56uw5o6OKPfbBr8/87pfvegJ2ytqoY7l4qzpEQzIzwld7E9Ub6ti76sXdjybb7ZGPmUWqy3GNijuOF53tpQeAPNAKJGLjV9qZAqcMSFp4vnNtAwLRk+q1JTC/Q8HYf5ux1Yr5xSXTuNEE/wr4QAVNRpj7lo88AgZMIms+cywNEHvv0ZLn1bhTjKfhwzQbQfNSgwX+mJHVa+EAvaZG2QJE1LlGdrB2WmCQhG3rrqFwibzxcWHgZDX513QX5YZqHKBBdZqXYuqwAXAVbo456q8rmHoh5GMtewnIZGtNtSs97iD3v/L+rN24gf8fU3+pgLzdNSz8/Vmvh8rBPEmdUx4eaLn5F+j21N5A3zSXgcL0dVz3dIlmvo0DxtPVjVzetbg6sLJw+8LNrHEmSgwj6QqVR+UhU2t7qc7aRBn3VuZYsy89uvY3O8quP4oRjm6UynYC8vVhQ7/4nLAKB1sefYGbLgWXS7xbEuEc9BlU;4:AFRjNWL1nREl7nifs7psR1BiDhXeciaH6o4qfzHzOdhrvgOs+PgKWTrOhb59DfswL5lHCKnUgV8Uour9DH6xV+UQ+t9X1SGofUf9LdfLRc1hj3frvzot61QruCti9obNctNpn4jaYaBvz5C1bJ1lHKLarnEyxjIy+DnuV1uwAP+07nROkv32Dr+GDoXFh+36fCYgj1AbNLv2jatDu3kc96ZOWgbkUabdBZyqImNx1m5HHwbDOcwcVDrIELWXmTR7+8MxlqYSNlyWvBEiPTKJCUIR7Vv6uQO7q4BJN+10JO3hs5XPkCpHgMadqFj2m4UBaJwF6W5xH1zkk5nMzti29pdatriQiQojeUVFxXsexV8=
X-Microsoft-Antispam-PRVS: <VI1PR07MB13288D5927D3FA9C2E5B3755B4CD0@VI1PR07MB1328.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820)(84791874153150);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(102415395)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(11241501184)(806099)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR07MB1328;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB1328;
X-Forefront-PRVS: 059185FE08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(396003)(376002)(366004)(39380400002)(39860400002)(189003)(199004)(51914003)(6306002)(15650500001)(52116002)(105586002)(3846002)(65956001)(65806001)(2906002)(66066001)(53936002)(65826007)(4610100001)(2171002)(305945005)(6246003)(5890100001)(77096007)(7736002)(26005)(33964004)(53546011)(25786009)(386003)(59450400001)(186003)(6486002)(2476003)(84326002)(16526019)(8936002)(316002)(478600001)(31696002)(270700001)(568964002)(966005)(575784001)(86362001)(81156014)(81166006)(5660300001)(8676002)(58126008)(2950100002)(16586007)(6116002)(16576012)(37036004)(110136005)(6666003)(229853002)(31686004)(64126003)(97736004)(76176011)(68736007)(106356001)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB1328;H:[10.145.143.144];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR07MB1328;23:DiC38N5hv6tGB6sqhOpQxN0cN1/qDbQuVsGmcE5QA?=
 =?us-ascii?Q?s9FhtIy1F4mxeh4HNQbtUa7CWrH/xyCTEyQBXtVKLyTH23mDd1hT+rGNgQLj?=
 =?us-ascii?Q?Itc5+0YrzjRl0DjePnfEPZPSZR49EgI7w5aWqIanSNeYHQzFFN8WnWKmNaen?=
 =?us-ascii?Q?H5kpXAe3HmCl0uDf0YxaV+JcANo81XlyTWAQjvrd9os1t1M7BGgOzq+jVly7?=
 =?us-ascii?Q?2gso+K/WENUE1g4YjFGLa2Yosdjwpo8/fw0HB4r18BcDaj8ge490qdoK5Nyo?=
 =?us-ascii?Q?CkoXrRKIL0gfUgA7Go7zwa4QyWTpXI1COFy6NY6lLpWmUXJgCY8OSw06PlKF?=
 =?us-ascii?Q?Tv+lJ2vAslknlwxjKjGgzY20W8AAgko5fFiK1BQcE3UjuwYFX9GJ93GG9rWa?=
 =?us-ascii?Q?cq2Ciw6CFLYRTq8k9FmIKBQCYmppDBgk8GRUgUFZjMP49r1G6aXYVwMoDIor?=
 =?us-ascii?Q?NVntvxk5HnB00tsWX7WX84SX1XGiGFDQxxzNUWI+9nbvpPM7zGLowflf0KCA?=
 =?us-ascii?Q?EgCygTDhXZUYd2s/5fJ5tcIVAnTrPrFbebcdW1rIbvGpHN1mo8qaHoIK0/9X?=
 =?us-ascii?Q?Wi17Cw14US6PHa/3voO+9jD09J9vwDy0GgvULsFUzvSUz7AT0PWu7vzAgb0I?=
 =?us-ascii?Q?7CMTqlrRUOQYtSujvKAgbM3a8N4w1oVXj7pt9477O1K9fDwyL6gG8Qj86zB2?=
 =?us-ascii?Q?WHRL1/0n0oN2peREA91fqD/uk4tgemfk8/YvGlRy0f7dvDKd6EvZwQJTJa4Z?=
 =?us-ascii?Q?6JjD2lbRaOLP0/OJ5NWaTjLwhud1xDAu0VIyDNf7O0tq/tVd/lIKgNqS9Ypz?=
 =?us-ascii?Q?6uUOPE42eJD4LLUO7EP++0ns/1mExrAi5fLLKDPdxbt/2B19p8VdeTqlECQ3?=
 =?us-ascii?Q?y1cO6wsHhdVcJc5x9WSUj1hmWno+gpl02ND0r45iY7RIBg/4C67/XCm2Qty3?=
 =?us-ascii?Q?fnuOWfFg7PwH3PJSCORtEC6KZhNOq8q6A0+7GExNiba3kyFvl0B8rCsfX4Ue?=
 =?us-ascii?Q?NfiwpuTD3LIVsnT71K/4Og90Ekuwp9F+RHsDoMOqPaU6LOuiY49ZdbWp6560?=
 =?us-ascii?Q?omxDztKjheb1lDoEunICk+UIPTWNsEmCCYroc4MShHfsO4QU2N/cPZ4UEnBQ?=
 =?us-ascii?Q?G0omqG8pR7JwXBxa11AcbBo33iMeJjGxUuovZBpDxRR1rIMa37P53Te8LyoS?=
 =?us-ascii?Q?Xf5dlGKQ7JTvcNwR4IAFyJmnosZtVH/Ipos7sigU+HAjvrbBtqbKwRm2wU0H?=
 =?us-ascii?Q?do4NNLtFnmkgLU1jUNeAFzuv2sDEoayLMSGEzIDXyl3NKnEF22AUyUlgMTJs?=
 =?us-ascii?Q?Msp44FTBYIKp27vyOOZ0eiQsjafLxfbfsDQtTXLNpVbwe1VFihYph+UZFru+?=
 =?us-ascii?Q?bcq/FLEFyxXYgnbhAOslU9/BvSYUOBmwaaEkNLY5bSvQxGrUTJfesU/o7Fj2?=
 =?us-ascii?Q?6M+eEuIMmECs+4mNmKfF2yc+s7lCKcwlovDjSOGix1gwVsIoCxf7kp1YcLZd?=
 =?us-ascii?Q?BufK1O0o5NT3rJNXKYyh0yTWWJc8Zme/RaYzZ6TSXsxyU/DMovQMHifGMv6t?=
 =?us-ascii?Q?6DYLK86CDh6MkcCMg=3D=3D?=
X-Microsoft-Antispam-Message-Info: 4312jjanVjjBDwKDNR27yxoyVIv5srH6hRJTUIvp9XQ/2PtzfmE8O2Tn8z4dnKl0TXsa7iCGQDhXmHC4G13WUg==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1328;6:NiT3W2mEaV0/jH22wcXEQ+Yb3YnxDcro7HjflP36gTtA+KwGXSRJT0AtYL2s+RGl5cEcS4AyDPgXNfJb7l1QxdF0Ei4becyWx9EOO6DA7ukKRrolGO8MoEQmdR8Vs5RifmfxoD0bVTGyg77oAC8CiWeMY1RVP9GmIYHAGY/0Bk4Rbo+nl3flpJYnCw4kle8Wp8KTEqLh8YDlgwes0RyYLNr3m/suRNRNPQ1mxiFSTw3oI7pt60eyQYQ2vgFYjGlDoLrWgwSJL47GT9EciJ0ce3GI3hU0DMRyymhejirD6/dgpzysz3OI+HONeSJ4rpmiSJ5XN6SINhzUfEDEv6makrFwz9dt1ngwTFqFGTR1IkA=;5:uroIohThdTuE5oOyvCxNAe0bQUwuTheZiq1HKlSFDe50odgeBGexN1RPtpjmBvtGCiQL1Pun2VZSWutBZzGzjndZRFxMpEcORFqPGWC75Vq4H5MYwYwAfqbSrVfhr3B0UAWEIsdL5pY7/WDHPzNlDJaxmXg86sXyESkZWhj0q8Y=;24:nNfTXz9ha3vknvf+T1ex3A8HEcQ8IOSoHqfDU+Cw1ngKsdpQeuBTerkXlWHF2w/PwxXtK0GIPrrc3GJeC7dYgC+28jB1ubfzBCN0eIlUzVU=;7:lUHhrQ7DwRDYf782/Ak1lhMu5TOUKZVpdF9mXpVvYgZasx90/TAyq1kgI6kOzqaXMYnBOL8R4I4FeIZp4EsP+tiskvGMnynPy33oqZUIz3VQrKMQ9+1CWZ945GSuJlk1PVhh0BuapkcJqqi3i8y/fDDnVow3C6KjY1PnroF/LZtDpBnlCtnGl3kkZE/QOWyY8TUSZFUXNqqS9dStct6e70siNw2Mh+hPDYDxDRElGba6tCYOVo5HkXY0QQzpyw68
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2018 13:38:01.1340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6f9698-cfb0-4b35-82cf-08d579f97e77
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB1328
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592836024079579824?=
X-GMAIL-MSGID: =?utf-8?q?1593108526170795414?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a multi-part message in MIME format.
--------------3BFFD0D25D988DEB4BC8B503
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.02.2018 17:56, Theodore Ts'o wrote:
> On Wed, Feb 21, 2018 at 12:40:00PM +0100, Greg Kroah-Hartman wrote:
>> On Mon, Feb 19, 2018 at 03:26:37PM +0200, Tommi Rantala wrote:
>>>
>>> OK to backport it?
>>> I tested it briefly in 4.9, seems to work.
> 
> It looks sane, but it would be nice if I can get people who are
> backporting ext4 patches to make sure there are no regressions using
> one of kvm-xfstests[1] or gce-xfstests[2][3].....
> 
> [1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-xfstests.md
> [2] https://github.com/tytso/xfstests-bld/blob/master/Documentation/gce-xfstests.md
> [3] https://thunk.org/gce-xfstests
> 
> I do run regression tests[4] on stable kernels when I have time, but
> it scales much better when other people can help.
> 
> [4] https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/tag/?h=ext4-4.9.54-1
> 
>> I need an ack from the ext4 maintainers before I can take this...
> 
> Greg, you can go ahead and take this, but in the future I'd appreciate
> it if ext4 backporters could at least run a smoke test (which takes
> less than 15 minutes on GCE) before and after the patch, and report no
> test regressions.

Thanks for the instructions!

Smoke test results 4.9.82 with and without the patch (attached, to avoid 
email client mangling it), no new failures:

-------------------- Summary report
KERNEL:    kernel 4.9.82-xfstests #2 SMP Thu Feb 22 14:58:27 EET 2018 x86_64
CPUS:      2
MEM:       1989.2

ext4/4k: 271 tests, 7 failures, 34 skipped, 737 seconds
   Failures: generic/081 generic/383 generic/384 generic/386
     generic/441 generic/451 generic/472
Totals: 271 tests, 34 skipped, 7 failures, 0 errors, 685s


-------------------- Summary report
KERNEL:    kernel 4.9.82-xfstests-00001-gb98ae0251413 #1 SMP Thu Feb 22 
14:31:01 EET 2018 x86_64
CPUS:      2
MEM:       1989.2

ext4/4k: 271 tests, 7 failures, 34 skipped, 749 seconds
   Failures: generic/081 generic/383 generic/384 generic/386
     generic/441 generic/451 generic/472
Totals: 271 tests, 34 skipped, 7 failures, 0 errors, 694s

FSTESTVER: e2fsprogs v1.43.6-85-g7595699d0 (Wed, 6 Sep 2017 22:04:14 -0400)
FSTESTVER: fio  fio-3.2 (Fri, 3 Nov 2017 15:23:49 -0600)
FSTESTVER: quota  4d81e8b (Mon, 16 Oct 2017 09:42:44 +0200)
FSTESTVER: stress-ng 977ae35 (Wed, 6 Sep 2017 23:45:03 -0400)
FSTESTVER: xfsprogs v4.14.0-rc2-1-g19ca9b0b (Mon, 27 Nov 2017 10:56:21 
-0600)
FSTESTVER: xfstests-bld ff7b8c2 (Wed, 13 Dec 2017 21:24:24 -0500)
FSTESTVER: xfstests linux-v3.8-1832-gafeee2d9 (Sun, 31 Dec 2017 13:35:28 
-0500)
FSTESTCFG: 4k
FSTESTSET: -g quick
FSTESTOPT: aex


Tommi

--------------3BFFD0D25D988DEB4BC8B503
Content-Type: text/x-patch;
 name="0001-ext4-inplace-xattr-block-update-fails-to-deduplicate.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ext4-inplace-xattr-block-update-fails-to-deduplicate.pa";
 filename*1="tch"

>From b98ae025141361b9e92fdd470dfd2314a64a47d0 Mon Sep 17 00:00:00 2001
From: Tahsin Erdogan <tahsin@google.com>
Date: Sat, 5 Aug 2017 22:41:42 -0400
Subject: [PATCH] ext4: inplace xattr block update fails to deduplicate blocks

commit ec00022030da5761518476096626338bd67df57a upstream.

When an xattr block has a single reference, block is updated inplace
and it is reinserted to the cache. Later, a cache lookup is performed
to see whether an existing block has the same contents. This cache
lookup will most of the time return the just inserted entry so
deduplication is not achieved.

Running the following test script will produce two xattr blocks which
can be observed in "File ACL: " line of debugfs output:

  mke2fs -b 1024 -I 128 -F -O extent /dev/sdb 1G
  mount /dev/sdb /mnt/sdb

  touch /mnt/sdb/{x,y}

  setfattr -n user.1 -v aaa /mnt/sdb/x
  setfattr -n user.2 -v bbb /mnt/sdb/x

  setfattr -n user.1 -v aaa /mnt/sdb/y
  setfattr -n user.2 -v bbb /mnt/sdb/y

  debugfs -R 'stat x' /dev/sdb | cat
  debugfs -R 'stat y' /dev/sdb | cat

This patch defers the reinsertion to the cache so that we can locate
other blocks with the same contents.

Signed-off-by: Tahsin Erdogan <tahsin@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 fs/ext4/xattr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 3eeed8f0aa06..3fadfabcac39 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -837,8 +837,6 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 				if (!IS_LAST_ENTRY(s->first))
 					ext4_xattr_rehash(header(s->base),
 							  s->here);
-				ext4_xattr_cache_insert(ext4_mb_cache,
-					bs->bh);
 			}
 			ext4_xattr_block_csum_set(inode, bs->bh);
 			unlock_buffer(bs->bh);
@@ -959,6 +957,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 		} else if (bs->bh && s->base == bs->bh->b_data) {
 			/* We were modifying this block in-place. */
 			ea_bdebug(bs->bh, "keeping this block");
+			ext4_xattr_cache_insert(ext4_mb_cache, bs->bh);
 			new_bh = bs->bh;
 			get_bh(new_bh);
 		} else {
-- 
2.14.3


--------------3BFFD0D25D988DEB4BC8B503--
