Return-Path: <bp@suse.de>
X-Google-Smtp-Source: AIpwx4+XB5lvLRD+uXtnk+4D8QsTuHOaXVeUXUR0RQrag2Vg/D/RjnqsH1H/UPgrau0ycYkbyQmG
ARC-Seal: i=1; a=rsa-sha256; t=1524217944; cv=none;
        d=google.com; s=arc-20160816;
        b=OZxgo7rJn+Eph+/9Gb3TZMEciS5+u55FC8992UnniXC99NYc17B2icNwIPju50mtHc
         TcgE7cj1CUcpd40yuMDJhQ2atJKJGd3qYeIaTBB21LDbVdAEIZQIV7Ac8Vk9kJywC9nR
         GsvQJbNuZ2qfzO1KjnEOJEdM1xCxBzxypH8kLy/3iDEYP9zs8XyE+W+Mj9QSTOI+1DHE
         Kr7fAn4E+CP6UxAVxCq5GOLl4+Z99MQF8d+QLNuUI38HN0kuFTzbBrcue/taVBNgA59v
         HqzZvDrzf7iTgq1S16Ky0eqymVdIHNvddrpj2sG6OfAR+mhiZjDC4gpOlIc7NRBeKTxi
         QG4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=nPoQmvB0GZHKbgVZacEoLlyJRTRHWCWBy4quzGUcGR4=;
        b=qxbh+bqfi0HWDXq2j3W8Ou0dG9hki1tlRCK2Usze8ZWrMMu5Ap4buQjsNzXUjA/3KT
         2wiTnP8l2cXqFqM3ITTmyFxNz5H7zZdwDuHgAPcQiSnuC6vcVitpJEYnvw9mxl9HTt2r
         iTOvGLy/DtJcttZvXeMErAfW1oej8pN2quyylOPfS7qp/+bTMJdhikQjmySos8e1SVEj
         cDv2UOhSrt0uXXCHEdXKmo5OsU4IYxa0kAfKUQIsGEu+mSMtIc05DZUm/jSevHKstU+p
         0plRA5tMpNwR51FgvXnrtK1LLEOiQ3lDntYQTpMsq43XlpfMgTzDLtzqIfsNLPWAFXRa
         0maw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bp@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=bp@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bp@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=bp@suse.de
Date: Fri, 20 Apr 2018 11:52:20 +0200
From: Borislav Petkov <bp@suse.de>
To: Vitezslav Samel <vitezslav@samel.cz>
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: 4.15.17 regression: bisected: timeout during microcode update
Message-ID: <20180420095220.GA13977@pd.tnic>
References: <20180418120839.GA5655@pc11.op.pod.cz>
 <20180418122212.GA4290@pd.tnic>
 <20180418135330.GA23580@araj-mobl1.jf.intel.com>
 <20180419053531.GA2224@pc11.op.pod.cz>
 <20180419104829.GE3896@pd.tnic>
 <20180419120239.GA2377@pc11.op.pod.cz>
 <20180419121840.GF3896@pd.tnic>
 <20180419134627.GA2387@pc11.op.pod.cz>
 <20180419163734.GB3905@pd.tnic>
 <20180420062021.GA2253@pc11.op.pod.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180420062021.GA2253@pc11.op.pod.cz>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598070825045426546?=
X-GMAIL-MSGID: =?utf-8?q?1598258355362033856?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 08:20:21AM +0200, Vitezslav Samel wrote:
>   ;-)  This time it works.

Good. :-)

> microcode: __reload_late: CPU1 waiting to exit
> x86/CPU: CPU features have changed after loading microcode, but might not take effect.
> x86/CPU: Please consider either early loading through initrd/built-in or a potential BIOS update.
> ------------------------------------------------------

Ok, and after this happens

$ grep microcode /proc/cpuinfo | uniq

shows only 0x24, correct?

> 	Thank you very much,

No, thank you for reporting and testing!

Ok, cleaned up patches with commit messages coming up.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
