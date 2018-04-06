Return-Path: <mgreer@animalcreek.com>
X-Google-Smtp-Source: AIpwx48Pr/IZtXIx1yIsgpWqlPvIAK9lbI3hIFfsfB04SArZaM62skrZE0oG8PVQcASfgsg7IgVv
ARC-Seal: i=1; a=rsa-sha256; t=1523030496; cv=none;
        d=google.com; s=arc-20160816;
        b=BejAOKqrIKMBsbhNh1W6ztqUUMdCYrsSnYAla/oLLeXVrTe8spVbMHXJj77ZmFrdDf
         3ztnfDWdkEJwyf3dSkkMFzccfhCakK03/Egp/1p3Rcoh/PIkbypI9rhCrgc8h2wJ+eg0
         f3RjDjSaeYU1WfQfbNWYXMQAu1GW75YWzEhbK+1GFMYep9kboIuEnbN+p34k7H1cc+bN
         zHQ2Rd+gO4tUhj+n3++iO+4ZmHL2u8pHdhJ+Fmq/4LNjlLjKhYyYJg706IteTKgIHBe2
         eWxebpVclTWQxqZY7YDMrq3UmZ21PSYH+Wt5I9tawQS++Y/RAAEVqPvcGreZRwx0ceMB
         Apjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organization:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=6AWO1Kk4AmY1FFXubqOHmCCT5BBjqH2phrBABmRgNuo=;
        b=ZCzhM7VswxEW0DSQFZvsE+BpRZy4/UrfcEGV+aQMd6Ec1IvK3BWk4LBeM47kpvsmPl
         JroZVvZkGCJ6ne0jRZuB9g2SnMFQML2VcdQLLybcX1kyWvKbA2lyWonSw6BOy96o2AuP
         MF71tNrnr9S34ZMZq/N6hN31oPdLT+6F4GJctjMkGwe0f2mZig627vsPKmF+W0BQIXXd
         C+XYFg9mjVCQmV7yT8E7Hxr9xgeCpxmwrjjEOdmqVFQQFvs90x0wJ6tmivpH3NE3UixO
         xI7mvSLp8xjIGvliy8dfNrZgeiY4FTISYPHvuUWoAgng+EbI/sqXUzwxN59kkiC0RbvQ
         18GQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=temperror (no key for signature) header.i=@animalcreek.com header.s=mesmtp header.b=BOzSpZ4B;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=ZXGBs6wu;
       spf=neutral (google.com: 66.111.4.29 is neither permitted nor denied by best guess record for domain of mgreer@animalcreek.com) smtp.mailfrom=mgreer@animalcreek.com
Authentication-Results: mx.google.com;
       dkim=temperror (no key for signature) header.i=@animalcreek.com header.s=mesmtp header.b=BOzSpZ4B;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=ZXGBs6wu;
       spf=neutral (google.com: 66.111.4.29 is neither permitted nor denied by best guess record for domain of mgreer@animalcreek.com) smtp.mailfrom=mgreer@animalcreek.com
X-ME-Sender: <xms:3pnHWnhz6-w8Ktg4FU1-kucB1uT3b9oTGF1VWfbYMhqAG0QxqfrKMA>
Date: Fri, 6 Apr 2018 09:01:34 -0700
From: Mark Greer <mgreer@animalcreek.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mark Greer <mgreer@animalcreek.com>,
	Gaurav Dhingra <gauravdhingra.gxyd@gmail.com>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: greybus: Fix warning to limit chars per line
Message-ID: <20180406160134.GB21252@animalcreek.com>
References: <20180403183246.GA23438@stallman>
 <20180405221941.GA21308@animalcreek.com>
 <CAOh2x==-Ayr40WhMNmABVEjaoFfSwQfyN8SH07mzmZTicLBh-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOh2x==-Ayr40WhMNmABVEjaoFfSwQfyN8SH07mzmZTicLBh-A@mail.gmail.com>
Organization: Animal Creek Technologies, Inc.
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596750959468280779?=
X-GMAIL-MSGID: =?utf-8?q?1597013225624123727?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 10:52:17AM +0530, Viresh Kumar wrote:
> On Fri, Apr 6, 2018 at 3:49 AM, Mark Greer <mgreer@animalcreek.com> wrote:
> > On Wed, Apr 04, 2018 at 12:02:46AM +0530, Gaurav Dhingra wrote:
> >> Wrap comment to fix warning "prefer a maximum 75 chars per line"
> >>
> >> Signed-off-by: Gaurav Dhingra <gauravdhingra.gxyd@gmail.com>
> >> ---
> >>  drivers/staging/greybus/audio_codec.h | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/staging/greybus/audio_codec.h b/drivers/staging/greybus/audio_codec.h
> >> index a1d5440..01838d9 100644
> >> --- a/drivers/staging/greybus/audio_codec.h
> >> +++ b/drivers/staging/greybus/audio_codec.h
> >> @@ -23,7 +23,9 @@ enum {
> >>       NUM_CODEC_DAIS,
> >>  };
> >>
> >> -/* device_type should be same as defined in audio.h (Android media layer) */
> >> +/* device_type should be same as defined in audio.h
> 
> This isn't the right way to write a multi-line comment. It should be like:
> 
> /*
>  * XXXX
>  * XXXX
>  */

Ugh, yeah, you're right.  I must have been sleeping.

Mark
--
