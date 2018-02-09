Return-Path: <darren.kenny@oracle.com>
X-Google-Smtp-Source: AH8x2279KMhaDrZBRbwZGTZAIbI/lEMzNiWaNoROC0hzvGdbl/IzcqNFXXU0MAUwyh/O/Xjf6utD
ARC-Seal: i=1; a=rsa-sha256; t=1518187192; cv=none;
        d=google.com; s=arc-20160816;
        b=eJpbBQrOkutRWbzc4bjqCL6c/vNi8v4FWkCm2zG28Jd/zl7oN05xfFUJdN/Xlel7tc
         xNvzvZlIv2qd4opu0mAivNXftUHh+5o0TUCKvx7BT6mx03UOO2kkFHwjGrYOBy/wb5Ph
         ML0cudCVJzFsGXdq2/SHGkOaQWC6F3RxEQMkJ9VxkoC5G3iY/s6NPtan9TNdXA3XYZYu
         3iy15H8WiKq+6VpmQ9umaBb2ez7Y3mck/XZZ2mo7IIa+4vD4esppQJHDqjUk/XGv4l/i
         boza1dcwQUT1Sjwgyn89/X3VpUwnLBHtgk9uQfF2ymHW9z597AIPMf1/8+1ZqOsH7f4+
         p49A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=mHkQgzIEI6bJE9idOMciw/p2GP2A/4UGmK3vKCCvhXw=;
        b=OlOFWAuxcgjyGCzV/On6t8SCC0dALJ33kxjrtx5n6on+tnzUBRiHcb96KiRjeXUrxr
         sRLugmNL7mJVQwsmfy7Sr+MN/e3v/M0c5D8Kfo3HkBn1SvIUjhTEdQUYvUfUogRMT7d5
         Bf9tBl0YcTAPCwgwB59/GIW+nthNPCUf599ClKlGqdxBGQIrbBoacEPU2479EF+wRV5U
         8aZXMGEj/yWA6wo8IrqY/yQyxkw8hPRI2d24UyF4+YV8am6yzwxgRAAm4S2b7VMGVfai
         5xEqLgWiFehienexHJpdOKGe3yejvtt170y04CSfoatdh2ojG9oqhLyhbvvwA0CUVbUE
         rZXg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=MHMUPYlg;
       spf=pass (google.com: domain of darren.kenny@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=darren.kenny@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=MHMUPYlg;
       spf=pass (google.com: domain of darren.kenny@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=darren.kenny@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Fri, 9 Feb 2018 14:39:02 +0000
From: Darren Kenny <darren.kenny@oracle.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Kyle Huey <me@kylehuey.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
        Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH] x86/spectre_v2: Remove 0xc2 from spectre_bad_microcodes
Message-ID: <20180209143902.qews3torgbxjr25p@starbug-vm.ie.oracle.com>
References: <20180209141054.gfzioctavbpnjckl@starbug-vm.ie.oracle.com>
 <1518186567.3677.245.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <1518186567.3677.245.camel@infradead.org>
User-Agent: NeoMutt/20171215
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8799 signatures=668665
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=932
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802090187
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591932870470343348?=
X-GMAIL-MSGID: =?utf-8?q?1591934654003017933?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 09, 2018 at 02:29:27PM +0000, David Woodhouse wrote:
>On Fri, 2018-02-09 at 14:10 +0000, Darren Kenny wrote:
>> According to the latest microcode update from Intel (on Feb 8, 2018) on
>> Skylake we should be using the microcode revisions 0xC2***, so we need
>> to remove that from the blacklist now.
>
>The doc also suggests that Gemini Lake 0x22 is also now known to be OK.
>I'll do a full pass over it and bring the list completely up to date.
>
>Thanks.

OK, let me know if you need me to do anything.

Thanks,

Darren.
