Return-Path: <andreas.dilger@intel.com>
X-Google-Smtp-Source: AIpwx49JkF3docxjWvkxLR444gN2K8Cqj6Ziee2FT/EBGqcOE8eJD04uUMqZRf5rZSfBXv6NkQ5c
ARC-Seal: i=1; a=rsa-sha256; t=1522829446; cv=none;
        d=google.com; s=arc-20160816;
        b=NHxFRXEDAYaCpoJUKtIUv6MTqdMwhvb6OOHC1bWZqYnCai0jdxTJGc5qzroU6Cxdh7
         Ed9508nHuOTujBtX1H1g2mkp7DINV+cPo45up715J15xnGVGjParoUDz08CAVUIcNFR6
         1OS+FpRJNc65GB24YT3pGo24s/h+jLDUPXINdsIZoMHQwNzzSZ/UHhz8ZZ9woIl5IpRX
         gl0V1cDLy7mgQ2iARiqV9Ro9NzxaqGS9ZnNDS7zdmYLS5bjkco6FIXHRAqmlF/2B/HfE
         u1dMX61o7lxAPSg2O/INwlkCyTS+rc8j+Ukn5f3x0xogizPbLqVc9r891KybIeFF4Sur
         U4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=YMBmhvQs8P/lu6bYis5839kZEGbLhb53gQi4C4hRjdY=;
        b=LpvCoC7QXAzuBpM2QxH9Z9hDqYgx+03zjCifa6+8kZDxr50cxwzxRhUlYPhqcS8xj4
         pI8ThPzKxouAclCjlUZoaEVMQqCoHVwJWYMi7VoYhUB50Rrg09hV6TmlUyykutjt8oLa
         NDanN67OoxSM3C70787RAbXgaxUbc49YME1emspDmJ5gDA1f0RG1LnoejCLZIYhW1oFT
         WFXDaxEigbEBIrCVFaDGVKUsUSDbJdNY7WGmyIC0wAb16XLB4+B9aiHVcc/G7jVwDCrs
         c3SGB5suvbLKycyQq8W0ssUjFwQOs8UyWfZT3MOVHhJ2famrwb7pjQG5Q2boiCAgaBeD
         iSFw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andreas.dilger@intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=andreas.dilger@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,405,1517904000";
   d="scan'208";a="34139511"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: NeilBrown <neilb@suse.com>
CC: James Simmons <jsimmons@infradead.org>, "Drokin, Oleg"
	<oleg.drokin@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Lustre
 Development List" <lustre-devel@lists.lustre.org>
Subject: Re: [lustre-devel] [PATCH 11/17] staging: lustre: libcfs: discard
 cfs_time_shift().
Thread-Topic: [lustre-devel] [PATCH 11/17] staging: lustre: libcfs: discard
 cfs_time_shift().
Thread-Index: AQHTyFmnPaab2m4I+kyw4VsVO58/aKPuV+IAgAAv/ICAAjWlAA==
Date: Wed, 4 Apr 2018 08:10:44 +0000
Message-ID: <CB90FEDF-3F67-46A7-8EC3-ABC788E7978C@intel.com>
References: <152229732768.27689.4800156943561963977.stgit@noble>
 <152229760863.27689.4681198496926109808.stgit@noble>
 <alpine.LFD.2.21.1803302001440.9681@casper.infradead.org>
 <0B6A147C-7E98-4B00-AF32-AF8843484CF9@intel.com>
 <87muyl1bzs.fsf@notabene.neil.brown.name>
In-Reply-To: <87muyl1bzs.fsf@notabene.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.8.93]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AC47B2A255C0A040BDE0C278AED4F2BB@intel.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244842312934549?=
X-GMAIL-MSGID: =?utf-8?q?1596802410304140632?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Apr 2, 2018, at 16:26, NeilBrown <neilb@suse.com> wrote:
> On Mon, Apr 02 2018, Dilger, Andreas wrote:
>> On Mar 30, 2018, at 13:02, James Simmons <jsimmons@infradead.org> wrote:
>>>> This function simply multiplies by HZ and adds jiffies.
>>>> This is simple enough to be opencoded, and doing so
>>>> makes the code easier to read.
>>>>=20
>>>> Same for cfs_time_shift_64()
>>>=20
>>> Reviewed-by: James Simmons <jsimmons@infradead.org>
>>=20
>> Hmm, I thought we were trying to get rid of direct HZ usage in modules,
>> because of tickless systems, and move to e.g. msecs_to_jiffies() or simi=
lar?
>=20
> Are we?  I hadn't heard but I could easily have missed it.
> Documentation/scheduler/completion.txt does say
>=20
>    Timeouts are preferably calculated with
>    msecs_to_jiffies() or usecs_to_jiffies().
>=20
> but is isn't clear what they are preferred to.  Do you remember where
> you heard? or have a reference?

I thought the goal was to avoid hard-coding the HZ value so that kernels
could have variable clock rates in the future.

Cheers, Andreas

> $ git grep ' \* *HZ'  |wc
>   2244   15679  170016
> $ git grep msecs_to_jiffies | wc
>   3301   13151  276725
>=20
> so msecs_to_jiffies is slightly more popular than "* HZ" (even if you add
> in "HZ *").  But that could just be a preference for using milliseconds
> over using seconds.
>=20
> $ git grep msecs_to_jiffies   | grep -c '[0-9]000'
> 587
>=20
> so there are only 587 places that msecs_to_jiffies is clearly used in
> place of multiplying by HZ.
>=20
> If we were to pursue this, I would want to add secs_to_jiffies() to
> include/linux/jiffies.h and use that.
>=20
> Thanks,
> NeilBrown
> _______________________________________________
> lustre-devel mailing list
> lustre-devel@lists.lustre.org
> http://lists.lustre.org/listinfo.cgi/lustre-devel-lustre.org

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation
