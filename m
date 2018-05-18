Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526638213; cv=none;
        d=google.com; s=arc-20160816;
        b=0lgIo2TZZRkL44BhLDu+VegT8uocbzxUvD7Q/8ubp92wNCJdDTFzxrkHG1LI5x84K/
         PEQc6nyMFJcyCaP9OIV1guQG6re0RtrwH0gqBouguPa0Dm88q54HDputA36CVBaLOdbv
         D4+Js0GQ29YBorGRtP7XdFR0FQMsWHXpke4naEsolrOu+rRSlyqtwFc8KvMLW0om33pW
         yaQljU1zW0WYIVyl+pkFv352TUT2pmPILmJGMEhxzn0JTH7nXQE+TgNzA0aQpGP69k4r
         8JMnridrBlaQAv7QXEiGvGmp9YznCZNI859K6A/seVq/AAUt3cny0bMmlm1GbpLAn59F
         fe9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=wGqAb5wNzxwd3j3fXVdG/szvJjT4WXVIKtT4jI5w9O8=;
        b=IfS2bO8khRP+NCzOxCyvZuGAVved7l7X38+/xefvRUz+SBgkdzMKlOLGkjtyVYVONN
         GafHk4Cfk5+7+rTzhXXTl2d6esBTlcwZDfAe53Gn1kznE7lopNJ3DohIn1ZH4OR9DHXX
         lpgr7aoCojvsAbOwSkssT3AdjqB36RGsxFItGz7CzYscscDhDEUoiKtHyndezdgCCrkR
         evDXponyEQzKjtqFfHriGJc685il0p8uJV1ZUO9e5hgWGGqIcJAmPtfNgLN+ChUMmPcW
         qbnRXQVPIpvj2U+Mh/OJJeirUE4XFa24Qd0L6FcmmRL1BCjUlmjePD64sEic1T06d3ox
         8eFg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=aiqnd3gO;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=aiqnd3gO;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZqwlEuACqXllcELdpxLZkseoz4oWYCO4KtfwWXncqhkjmVThHHXpsdsC6oBrup++f/YCYWSMg==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 18 May 2018 12:10:10 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Li Zhijian <lizhijian@cn.fujitsu.com>,
	linux-kselftest@vger.kernel.org, tglx@linutronix.de,
	gregkh@linuxfoundation.org, pombredanne@nexb.com,
	ebiederm@xmission.com, luto@kernel.org,
	linux-kernel@vger.kernel.org, philip.li@intel.com,
	leist.fnst@cn.fujitsu.com, zhijianx.li@intel.com
Subject: Re: [PATCH 1/2] tools/testing/selftests/x86: fix warning:
 "SEGV_PKUERR|SEGV_BNDERR" redefined
Message-ID: <20180518101010.GA924@gmail.com>
References: <1525770870-19067-1-git-send-email-lizhijian@cn.fujitsu.com>
 <8f91739f-5d63-e6c9-7bf9-4c970237bcf8@intel.com>
 <486b5b09-d45f-5d79-cb8a-9ea3537ae048@kernel.org>
 <20180514093157.GB27428@gmail.com>
 <68755e04-3954-e193-8ba3-e96930075622@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68755e04-3954-e193-8ba3-e96930075622@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599886734267032257?=
X-GMAIL-MSGID: =?utf-8?q?1600796191305312715?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Shuah Khan <shuah@kernel.org> wrote:

> On 05/14/2018 03:31 AM, Ingo Molnar wrote:
> > 
> > * Shuah Khan <shuah@kernel.org> wrote:
> > 
> >> On 05/08/2018 10:25 AM, Dave Hansen wrote:
> >>> On 05/08/2018 02:14 AM, Li Zhijian wrote:
> >>>> SEGV_PKUERR and SEGV_BNDERR are defined since glibc-2.27
> >>>
> >>>
> >>> Acked-by: Dave Hansen <dave.hansen@intel.com>
> >>>
> >>
> >> Thanks. Queuing this up for 4.17-rc5
> > 
> > Please drop these patches, I have fixed them slightly differently and there are 
> > dependencies with followup patches.
> > 
> > Tanks,
> > 
> > 	Ingo
> > 
> 
> Dropped now.

Thanks!

	Ingo
