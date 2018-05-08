Return-Path: <fthain@telegraphics.com.au>
X-Google-Smtp-Source: AB8JxZpvISRiV8GFNIp0uALV2Fr+m61iSGAELbBbzGkuq55ez7eSLWvAwiXru4cbGheWAQAhkpzc
ARC-Seal: i=1; a=rsa-sha256; t=1525768079; cv=none;
        d=google.com; s=arc-20160816;
        b=nOHg360e5zsKAPUVz8uNd23FxPXz2XofTNx7+AtS4MUdX3O/SACLar1T0W1+axSLpd
         kskS3e/B5d+RH2qtEv/24nQhJHt5Drx0iGoH9EnvRN98DhDR2XMjOQygmpEZh7sLdZ36
         NWvgQoCwW0koS0Y+7tQgY/swG3fiiAgvVmeyd9pnOfRG6b8IiSYaY+CzAJsTOAGMczau
         BbwpFDDpl1OCAi2vf04bnwWMlpf6RW2nR+K1RgVu5yx14OfwS5hxNoFlNQC+MO5ibrdt
         Y+IWqBNmJ1ll85crvjSompPAkbJ00YMOKFH3vA51icoRDRqqx8W0DF42l93Usz1ivluH
         YU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:arc-authentication-results;
        bh=I19obB1ID440290giXCxO3yT7L+XGxPi2++kwZ6JMWA=;
        b=jGYsTrwr2/vio1bsBAi71Iw1NpN0VTwY0HKoDezhKh8KG7Bi9p8h4szGZEHya55hOJ
         gfNJJSr/Aopz9SNXWVs27bMbDL40Nuqnt27JoUdzmSW2EmI3phxlPLtKhW14OxJoNgUQ
         tVsvFYpBEOLSK7sbDzPoTAH0ZrJUrw3HunTV5CV23PmldBqYLSCu9UxeOkHy8ZvSIm6k
         y1eOX7c01dxU0e2y3w4y2uqtPe0VuIEVmiYcs2yB/t7evvi+v05tD0bVWd8pOPaYsjvg
         glgeclp8X+rSTxFDzqCpyqBAwhX4r65jX2uQ4cMCNsTzdf+XHs3ubpT+7hsm7jD5N74Y
         5FsA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of fthain@telegraphics.com.au designates 98.124.60.144 as permitted sender) smtp.mailfrom=fthain@telegraphics.com.au
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of fthain@telegraphics.com.au designates 98.124.60.144 as permitted sender) smtp.mailfrom=fthain@telegraphics.com.au
Date: Tue, 8 May 2018 18:27:59 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    linux-m68k <linux-m68k@lists.linux-m68k.org>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nubus: Unconditionally register bus type
In-Reply-To: <CAMuHMdXLTmJt6vKt-E-h2nzWdvv0Rw6J=vLbg55owK_-CRCiiw@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1805081826090.30@nippy.intranet>
References: <5aee5ede.1c69fb81.353b4.5021SMTPIN_ADDED_MISSING@mx.google.com> <CAMuHMdXLTmJt6vKt-E-h2nzWdvv0Rw6J=vLbg55owK_-CRCiiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599677433904135296?=
X-GMAIL-MSGID: =?utf-8?q?1599883790021417766?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 8 May 2018, Geert Uytterhoeven wrote:

> nubus_bus_register() two things:
> 
>   1. Register the NuBus parent device, which represents the bus host,
>   2. Register the NuBus bus, which represents the bus type.
> 
> I think this should be split in two, and only the latter should be done 
> regardless of the presence of NuBus host hardware, to fix the crash.

OK. Thanks.

-- 
