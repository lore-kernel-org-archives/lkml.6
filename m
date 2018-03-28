Return-Path: <mka@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522260898; cv=none;
        d=google.com; s=arc-20160816;
        b=WF6ZBJqubjF3K/4KtMvPaKFOIkwL3SoFwF1yaRfoZ3VpMGdoHGDixDwxh+z9l3UTv5
         bmXyCAsbCGUL9pXJoI2t/DUx18CQNbPda8VPNhsc2wmOVeCWz0DW2wbo98XKFz0O7ayK
         EhDeGopUYU7wrKntUt5Qt0VFOJ1E3eX0jR3Jkz9suYGnGXiThw871JBItvNzcaqVY5Uu
         EFcgD3hDS4G9V5gGB4Scyw7BCESGedVULjGh9r2y0Dxvx8FNVifUNvIGIf2JQoakzDvd
         jac+LqnF8fmHmU6nMBhfS8qDSlHtChV55yXvdewJ41A6bRG6aLIHJjKyUM6VOkK8FweN
         igMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Ka9kpGbPf9WH/wnesWygolwV3xUHwjCRVy5wySNePjQ=;
        b=M3mb4xbO9H3vPTkptGT9U8//WShy/GI/B9v/HsRd0G+YF9z/3J06RGEaR7kH/GY9rG
         PdNz6VW10gWVzR4s7fS18G9wmyNPpPktjeHCGKoI6tllmaYAeZpvv2knYNU5/8bTNobL
         nn4VeXmCZl7XDBL0H7cgD89fc4GRkl82IFeQKoMEYkXfsX8nlb0yjNEHqbwPKxNhG+M8
         TGazlqqIgGNE9OSPSi2Ss5k41cEhMNolHEsxMtQvHM9Wn7bGXt66+IhAeMO/uW6rAb2G
         R7EIx0iR6zWgPLKyotC8CxG0Ft34AD5WMOagh/D1gpf97ZtW67nctp40LiqGLGOXmM1Z
         bY1w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=B9T6jcub;
       spf=pass (google.com: domain of mka@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=mka@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=B9T6jcub;
       spf=pass (google.com: domain of mka@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=mka@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx4+Owohrwalq9bAdiDpkTibw64SW3ZgozJZ9dy35Voxl1tYIp+lLTbDbElEn/FqnrC86+8X9qw==
Date: Wed, 28 Mar 2018 11:14:56 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Manoj Gupta <manojgupta@chromium.org>, linux-kernel@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] debugfs: Check return value of debugfs_real_fops() for
 NULL
Message-ID: <20180328181456.GA87376@google.com>
References: <20180327235553.210165-1-mka@chromium.org>
 <20180328061616.GA8212@kroah.com>
 <CAAMbb052mY1TOLzM=8Lpv2gU95X-R40zaMWNZKd1vX-+49R88Q@mail.gmail.com>
 <20180328180556.GB32098@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180328180556.GB32098@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596137136019067169?=
X-GMAIL-MSGID: =?utf-8?q?1596206243242229166?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

El Wed, Mar 28, 2018 at 08:05:56PM +0200 Greg Kroah-Hartman ha dit:

> 
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
> 
> A: No.
> Q: Should I include quotations after my reply?
> 
> http://daringfireball.net/2007/07/on_top
> 
> On Wed, Mar 28, 2018 at 07:47:53AM -0700, Manoj Gupta wrote:
> > Please note that there is nothing wrong in the generated code, just
> > that it confuses objtool.
> 
> Then fix the tool, the C code is correct :)
> 
> > Clang has simply omitted the statement where NULL is returned since
> > the pointer was always dereferenced post inlining.
> 
> Then tell clang not to do that, like we tell gcc not to do that as that
> is a foolish thing for a compiler to do when building the kernel.

Thanks all for your input, we'll try to get
-fno-delete-null-pointer-checks or a similar flag to be added to
clang.
