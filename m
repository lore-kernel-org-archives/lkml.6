Return-Path: <vinod.koul@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525863337; cv=none;
        d=google.com; s=arc-20160816;
        b=GD5bMRJBu9s7SU1nGR6HmFOZf9FoyQhCLq6bSHWmRRzEE6f3T15tLKz7zsQQQXjR1s
         rwqcGyKeLj8x7AAfT4wxNnF9DdkgDDiIxl+z6sK+KczTYGI3k/DW+W/QvY/k3eEARLSh
         bjYePmISv189C5jJz0Xvbxe+pfoupVSOv/Fh9IpGCPv+oD0bGOg2gNDRAnVOV0NNiLB/
         ylw+1vMthH7XZByUG6vK1dqxK5ISC3U+MVq2o0Ha2LZZHVoQ9BlyHsvYkk0+sCtnPQjx
         0w8WbyNc0ym4tEQ+d/u/OO6qIayz0Xt8wnwaESJUtGdLRRrTxEXnrK9LXSDr6auo32+X
         IGEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=RyZ3nRyQENuK3x2zc2loDnU6wjgSRDYpPVUU/vzh6Yw=;
        b=oA78DpFXHwmtqPh4+C/fn6ZbZ6TCPxJNGQWWG5qaBOxCGZDi7BaJG83VJp28a/VZkj
         JFYe5INjwq2BIRHAj18ltThsns2A9E8R33/llEJnxgwHxuONIaxYVC+zl4Djyv+9637C
         QOxAijeUk0zvKmibJSWvE+qPNcg11wyAfw3uvYrir1X9eYRhP6W27MC+zu7kZEQt28gl
         hLv0b2CXUMlflY/liB7lkhcMuAcA6kSGawlSwRbdtGTeDRHe3azilVo+w4BfXS4CIJdf
         EQveeZpAR7NVGzSKodxBEymgjnUC4mpta4udyF0QAMMkWI2p8VOUhgoSZfXkPnQBMrMW
         z0jA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=MZFum052;
       spf=pass (google.com: domain of vinod.koul@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=vinod.koul@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=MZFum052;
       spf=pass (google.com: domain of vinod.koul@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=vinod.koul@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZrHlkekVH8DQhC8uFeCCyzGvo+DDm72YyPB68tlhzSAt6N7cTIWWoIib6jaiHHkBlr1bY5JEg==
Date: Wed, 9 May 2018 16:25:34 +0530
From: Vinod Koul <vinod.koul@linaro.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mark Brown <broonie@kernel.org>, "w@1wt.eu" <w@1wt.eu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ksummit-discuss@lists.linuxfoundation.org" <ksummit-discuss@lists.linuxfoundation.org>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Ksummit-discuss] bug-introducing patches
Message-ID: <20180509105534.GE7985@vkoul-mobl>
References: <20180503020550.GP2714@sirena.org.uk>
 <20180503031000.GC29205@thunk.org>
 <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
 <20180503224217.GR2714@sirena.org.uk>
 <20180503230905.GA98604@atomide.com>
 <CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
 <20180509084440.GW13402@sirena.org.uk>
 <CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
 <20180509090346.GY13402@sirena.org.uk>
 <20180509204727.7ff38021@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509204727.7ff38021@canb.auug.org.au>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599983675004856510?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 09-05-18, 20:47, Stephen Rothwell wrote:
> On Wed, 9 May 2018 18:03:46 +0900 Mark Brown <broonie@kernel.org> wrote:
> >
> > On Wed, May 09, 2018 at 10:47:57AM +0200, Daniel Vetter wrote:
> > > On Wed, May 9, 2018 at 10:44 AM, Mark Brown <broonie@kernel.org> wrote:  
> > 
> > > > I think this is an excellent idea, copying in Stephen for his input.
> > > > I'm currently on holiday but unless someone convinces me it's a terrible
> > > > idea I'm willing to at least give it a go on a trial basis once I'm back
> > > > home.  
> > 
> > > Since Stephen merges all -fixes branches first, before merging all the
> > > -next branches, he already generates that as part of linux-next. All
> > > he'd need to do is push that intermediate state out to some
> > > linux-fixes branch for consumption by test bots.
> 
> Good idea ... I will see what I can do.
>   
> > True.  It's currently only those -fixes branches that people have asked
> > him to merge separately which isn't as big a proportion of trees as have
> > them (perhaps fortunately given people's enthusiasm for fixes branches
> > that don't merge cleanly with their development branches) so we'd also
> > need to encourage people to add them separately.
> 
> I currently have 44 such fixes branches.  More welcome!

Great so do you want us to send fixes branch or scan the existing trees and add
them.

In case of former please do add slave-dma/fixes as well

~Vinod
