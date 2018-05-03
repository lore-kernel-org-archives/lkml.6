Return-Path: <w@1wt.eu>
X-Google-Smtp-Source: AB8JxZpM4k2prBcfQWC8OPpl2cU57GWoY8P29OLDSosInNtFb2T6ra4aejrfGMyf/IpwPwofn3ou
ARC-Seal: i=1; a=rsa-sha256; t=1525314654; cv=none;
        d=google.com; s=arc-20160816;
        b=tYG+BN2Rn198LRo5qcYuYb/aj/Ptx5lcN7XEwQTRammAm8iWX5MnufuFR3hfMM4pj1
         Qyd2sit1NCwBVG8YM25+D1qLj4xgVCgaB4Wf3S1w1wTcLX+9UyvY9l+9R36pT98VbCGT
         9DO70d3qXqPg8TYmBn62E0fHDMqn9uw7Fy5KgakLu8euRO+MXf3vi3krvJXx1FqR0Q3J
         Op+Znr3/7Sw7YmoP6jnIYdwqUoRLyzw846jP19rkhMsTihZb3tmKISeR+/Vkv6cejse2
         Z5zBIcvfLnlE0ltJrGQ4fOLR3KnMZBm5TwgWRk61lsFXtsMMcxGKUpv8WSdbkN04CNdw
         YrGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=z6nc+3s9vLk0ZJ2WDAv7Am0F4Kn2gzQLfg24yfvS0Zk=;
        b=MsB0+qX9uywzspMp/qnRSNDVFky+gvr1J5U/hAmEl5sxmsxVKTukDbL2U2BRqJnInj
         BR7/iQXISVWdlZ8Qcrxczs9yYAVJHrD17aKZQYUNybETjjpHEH0ETJpOfFf6+2fBCojG
         Rf3/2hLJ0syWoquXqSqKYPYfPfn8OHQoxqAlAlipZrsLzrpoiczijeyowmRUDefxk20L
         flJq1XytXF6Gpkhmz4zslo6wjE6Tpgg2yCezjJ6ezdMCDfp600jjyTwt+DwsUsgK1125
         nJWz/4fm9t2EdugDCubrVXOk16AMGICgn53QxPqhqKcZmWCJM2NamBs7uOmwKL3dMY0b
         vwHA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Date: Thu, 3 May 2018 04:30:52 +0200
From: Willy Tarreau <w@1wt.eu>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180503023052.GA12856@1wt.eu>
References: <20180501163818.GD1468@sasha-vm>
 <CAMuHMdWNFz_9OpddZ6tTaQcNVH01pkhwd0+3Z31uDcZvbkV6Ow@mail.gmail.com>
 <20180502195138.GC18390@sasha-vm>
 <CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
 <20180503000620.GA29205@thunk.org>
 <ed65dc49-dad0-21a1-676c-f9ba43ba5c6c@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed65dc49-dad0-21a1-676c-f9ba43ba5c6c@roeck-us.net>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599408339300426689?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 05:38:32PM -0700, Guenter Roeck wrote:
> > Because if that last is the case, then the prescription is very simple
> > and not controversial --- bug fixes found post -rc4 should be held to
> > the next merge window.
> > 
> 
> Holding up even fixes for severe bugs for 4-6 weeks ? Seriously, that is
> unrealistic. Holding up the fix for the next SpeckHammer because it was not
> ready before -rc4 ? I don't think so.

That's exactly what I explained earlier in this thread, it will actually
make the resulting kernels even worse as soon as there is less than 100%
regression (which is the case, since some fixes are valid). Postponing
valid fixes because some of them might be wrong is a bad idea. We need
to trust the developer regarding the test coverage and the developer has
to become trusted by openly indicating the type of testing run on the
patch. From there it will become easier to decide whether to revert a
whole patch set after a few failed fixes, or to take a few more fixes
in hopes that ultimately everything will be good.

Willy
