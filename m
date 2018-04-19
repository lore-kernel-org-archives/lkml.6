Return-Path: <ashok.raj@intel.com>
X-Google-Smtp-Source: AIpwx4+ZoRM+ON4gkTkGbch+kdo/2qkMmCdGl8+taMjplPSdJ9gRyt56YC6JmC3UK8oSSwwKPPUV
ARC-Seal: i=1; a=rsa-sha256; t=1524122566; cv=none;
        d=google.com; s=arc-20160816;
        b=D1MdMzjAUrAvgZkZVWusjlykGV08hWseNX2GvY2rts2BaXFjQpkaIUqmbTLGZLbZR0
         K4bUtdJPk6Z4l2gRvnu9f80QmU8LI+c9ztnq2WzDP5NYNelTJCGI2c0SUlFtijdHp8O0
         QqPfR37kLtwbR/ina7PesOXSZ7xxMedwgORPjk8dQX0ReKZYESQ8YJ44kUCz+W1l6lNx
         lvml3QaxX6Q0Vad9DaU5wr3ekVqnkxDGw+FR1fnPkUJ1Ld+JKaE25wkFrYnMC6lWilEV
         KIH6BsHLht9zuXKVfDQpEK4pKGVGfmmLIEpmv3MYI222sXjggAmi3KhhJBkBydF0iNxl
         F/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=4Wk0ipn8iXLn40Yfe8dWDbA8jyP0k1+RUU/xcVfxxi0=;
        b=dOQcaKiS2chuasULNsg8v1wzPbNRrscFh0oNrcpfOAt6fzaMji7km610mif+Cz1IZn
         2rc+YqGylhejH8vwKCYVN1pGe3vIRKOi93piDuEw73gwF5GyivSf4vl++kkLHotU+ZyA
         R4UFVySsB8hc8Iw16E/MwQw1nT2WQqDJAys8/OEIpR1JN954RLUX1gp/vuNhFgR/+okp
         sWbtPtSU1SJY7k02Ktt8cvIpzbnx7Vezz4zfC5PZR7uTF+EQ7eTTQ6UrduDoPIPVTX0h
         O/SsB7yU9Q8SJdrciH60DuRS10qq1hpHhvcndZPdM4xznz7uAosYgD1+gO5C7AmNfC/8
         Fu4g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ashok.raj@intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=ashok.raj@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ashok.raj@intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=ashok.raj@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,468,1517904000";
   d="scan'208";a="44446581"
Date: Thu, 19 Apr 2018 00:22:44 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Borislav Petkov <bp@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: Ashok Raj <ashok.raj@intel.com>
Subject: Re: 4.15.17 regression: bisected: timeout during microcode update
Message-ID: <20180419072243.GA7991@araj-mobl1.jf.intel.com>
References: <20180418081140.GA2439@pc11.op.pod.cz>
 <20180418100721.GA5866@pd.tnic>
 <20180418120839.GA5655@pc11.op.pod.cz>
 <20180418122212.GA4290@pd.tnic>
 <20180418135330.GA23580@araj-mobl1.jf.intel.com>
 <20180419053531.GA2224@pc11.op.pod.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419053531.GA2224@pc11.op.pod.cz>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598070825045426546?=
X-GMAIL-MSGID: =?utf-8?q?1598158344876215483?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 07:35:31AM +0200, Vitezslav Samel wrote:
> > - Can you remove your builtin microcode, 
> > - rename the /lib/firmware/intel-ucode so we don't find it during late loading. 
> > - let the system boot completely
> > - then rename the intel-ucode back for this test.
> > - write 1 to reload and see if that update succeeds or fails?
> 
>   Just tested, it fails.
> 
I haven't tested under slackware.. i'll have someone test this and keep you posted.
