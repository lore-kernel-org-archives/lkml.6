Return-Path: <catalin.marinas@arm.com>
X-Google-Smtp-Source: AH8x2248a/TLp36bXxjvkqlBWo4o4yt4RS4Hj//33aeE81434VsutVpcFtM6/8/GMI4V9jsESt16
ARC-Seal: i=1; a=rsa-sha256; t=1518634193; cv=none;
        d=google.com; s=arc-20160816;
        b=mYZQosohYgrGT9B7y4iGkn+jBujn7fmEdlfk7lZwdwienBqqlm1Ik+fHnF4NDK5HNO
         amQi4pZgXPfGkJVW9b9Wy0mBKO07KvVi6ncwkWUB847nyrfEUd7jVRcjawKN8SHifyB1
         JdDeuPDjadfNVEjKC76H6USjKg/9KHzWGesf3jlnkfFISGLM4ZDDFMc3rszCJzNI06ea
         fJOGuIV9evxt8U+ZrVztjI8NKRO1xhdtW8Sln8uVo0BPAZzEqkuzco1GYBw8P/Ix9/Kr
         fu+ag01aiZpPQTpJd3p907x2BvOCHPwmBp769qU1vvA5y1uNvAZgPJN1Mz/1FVWjTyoO
         CIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=xhN3uK9RDg/+uAKSwq4aB8DFbDvRJTerw6krmv4y/Xo=;
        b=j+CulY0XVQGgaCyZKq456znaqNWYc2J/etwHSkebRwBmH0DhwVEYzaflVTyfZbR2I1
         cRmlo6NTB4/D+wXcf11l54QqETsZA+LgfRMzdolJ/rUHPe0snoWegGMjuPuB1RRckxzZ
         +3X2exSnvCzSQRuAeAHzatKrKHxKFimaBaoscyLBF/QYvJ2NaBqbQhxcngxBx1uCvjMG
         mY1q+IRaScL7goMcAc/iC1KP3HBgpBxDDX87yOjQhpZr9MBgWqPUIZpZgucbGjV57g5j
         ey7/Ndpplf5F8urq27w3am+tVlMH5uvEEn6KITXtxr1fQ+JfMtyYAp0vVp+EggoZO7Un
         oUCg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of catalin.marinas@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=catalin.marinas@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of catalin.marinas@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=catalin.marinas@arm.com
Date: Wed, 14 Feb 2018 18:49:48 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Timur Tabi <timur@codeaurora.org>, lkml <linux-kernel@vger.kernel.org>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org,
	stable-commits@vger.kernel.org
Subject: Re: Patch "[Variant 2/Spectre-v2] arm64: Implement branch predictor
 hardening for Falkor" has been added to the 4.14-stable tree
Message-ID: <20180214184947.j6qhxmuzjm333fq4@armageddon.cambridge.arm.com>
References: <1518616386206238@kroah.com>
 <CAOZdJXWZV4TDZchsYeHE_Oh+s1y3yjXE9NxVY9wz-vCkZVhN4w@mail.gmail.com>
 <20180214182346.GD4611@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214182346.GD4611@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1592384775145883169?=
X-GMAIL-MSGID: =?utf-8?q?1592403367713677521?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 07:23:46PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Feb 14, 2018 at 10:16:51AM -0600, Timur Tabi wrote:
> > On Wed, Feb 14, 2018 at 7:53 AM,  <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is a note to let you know that I've just added the patch titled
> > >
> > >     [Variant 2/Spectre-v2] arm64: Implement branch predictor hardening for Falkor
> > >
> > > to the 4.14-stable tree which can be found at:
> > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > >
> > > The filename of the patch is:
> > >      arm64-implement-branch-predictor-hardening-for-falkor.patch
> > > and it can be found in the queue-4.14 subdirectory.
> > >
> > > If you, or anyone else, feels it should not be added to the stable tree,
> > > please let <stable@vger.kernel.org> know about it.
> > 
> > Please note that there is a follow-on patch, also from Shanker, that
> > fixes this patch (it was slightly mangled when merged into 4.16-rc1):
> > 
> > https://www.spinics.net/lists/arm-kernel/msg633726.html
> > 
> > I would love for it to be included in 4.14.20, but it hasn't been
> > merged into Linus' tree yet.  I will send a patch request when it does
> > land in 4.16-rc2.
> 
> There's nothing I can do unless it's in Linus's tree :)

It will land in 4.16-rc2 (already queued on my local tree).

-- 
Catalin
