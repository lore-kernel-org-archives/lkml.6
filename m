Return-Path: <kieran.bingham@ideasonboard.com>
X-Google-Smtp-Source: AG47ELuClUhf5Dm43clp3DvpN/EzcwOV8RZoYHovQPktDg854Gzm6NU/njs7cifLWv2yOoDZFp8q
ARC-Seal: i=1; a=rsa-sha256; t=1521281527; cv=none;
        d=google.com; s=arc-20160816;
        b=R0ohUH6eVufbkb3GYyacH/uv8ND2Vp6igd+jKbV6z3FWBO7eQgxEKiSMCslbX9UqLE
         ZEKtzQQ4kwLKLXPrkn1h37mr3Gz1ZT49ypru8LV2SbS4SkRm2nxd4tlIlbiT1ee+3viY
         0pZogXQbMGJdusq3L26Qh6/YbAOURfemlfA92jQsZ2wsb33aOD59nKy4eeJNVIa9aUbx
         FfeFI+uoCoU1KS8f1uwoTNB0rj6O6YuPbHTPxJzprKGEPnPc57fTtXRzTNlzSHbcdvZE
         tzflO3kXq0lMB9IbIvWADWqI6yKWFyp/UdWd1Xh/nDTxsvlzrmQ33GYzDpDAjjpFAKvP
         QqBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=pBvPKQ/69xg/zepnr3aycVLXseDHrytCrCM7KOh+YWE=;
        b=t0CnrDOtt1zO3iBH1rJspkuLDuOukMUskmyGmQ8KdMqPT3IvGx3LXavc0Wnif/DRjj
         dP2FlNOZq1Ar2bfH+lhxTjdDVtJwe1pe3T2W/PAGradckWaCzulTld3Hbct+IpuPB2jq
         wQuHZbZ9bV6L93G1Lf/ZO+sa5VYYcnwB5pFAUkZ0Jc6Kz09IKAVwTsXBIObAkFlnXSxS
         JD5vbdBRJTrx4v/ktbpJD1dpJi4/lfHxAnNmbNmElztc/Ff0RD3PmVmBLm50yjOzwrkF
         eyOpcBEBT3vfRotKGa1Mq5yN2HJrexi6hDSV93OyTPiiasFOG16p4t94HddnNxQBTX9O
         1Q5A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@ideasonboard.com header.s=mail header.b=Irotrwdj;
       spf=pass (google.com: domain of kieran.bingham@ideasonboard.com designates 185.26.127.97 as permitted sender) smtp.mailfrom=kieran.bingham@ideasonboard.com
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@ideasonboard.com header.s=mail header.b=Irotrwdj;
       spf=pass (google.com: domain of kieran.bingham@ideasonboard.com designates 185.26.127.97 as permitted sender) smtp.mailfrom=kieran.bingham@ideasonboard.com
Subject: Re: [PATCH][RFC] kernel.h: provide array iterator
To: Joe Perches <joe@perches.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, linux-kernel@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-media@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Kees Cook <keescook@chromium.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 Ian Abbott <abbotti@mev.co.uk>
References: <1521108052-26861-1-git-send-email-kieran.bingham@ideasonboard.com>
 <b6af11b9-d697-59ec-6acc-80f0657a3e11@prevas.dk>
 <1521225943.6119.10.camel@perches.com>
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <5f027b5c-7419-d4f2-53a7-28805baa7193@ideasonboard.com>
Date: Sat, 17 Mar 2018 11:12:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1521225943.6119.10.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594997409535098266?=
X-GMAIL-MSGID: =?utf-8?q?1595179298597655165?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Joe,

On 16/03/18 19:45, Joe Perches wrote:
> On Fri, 2018-03-16 at 16:27 +0100, Rasmus Villemoes wrote:
>> On 2018-03-15 11:00, Kieran Bingham wrote:
>>> Simplify array iteration with a helper to iterate each entry in an array.
>>> Utilise the existing ARRAY_SIZE macro to identify the length of the array
>>> and pointer arithmetic to process each item as a for loop.
> 
> I recall getting negative feedback on a similar proposal
> a decade ago:
> 
> https://lkml.org/lkml/2007/2/13/25

Thanks for the reference. I didn't know about this.

Your suggestion at https://lkml.org/lkml/2007/2/13/25 looks remarkably similar
to my implementation though :-D  (Perhaps even a bit neater, I may have to
incorporate some of your suggestion)


> Not sure this is different.
> 

I count three disagreements in that series. But I'm sure I have more positive
responses already... (Though no 'official Acks' yet ...)

How many ACKs do I need for this to be accepted ? or do the past-nack's have
full veto?

I still believe the use of an iterator in my case [0] makes *absolute sense*
(thus it must make sense elsewhere)

I'm not suggesting a full tree conversion here (though that has been suggested
earlier in the thread) but the ability to add a convenience macro in a common
location, so that it can be used when desired.

In my instance, I have an array of structures which I want to iterate. I believe
this make my code more readable. I have already had another vote to say that
they thought the same.

I'm certain that throughout the media tree there are a lot of use cases where
arrays of structures define types which must be searched where this macro could
also make sense.

Do I need to start a poll to determine if this is a worthy pursuit? or am I to
give up and stop in my tracks (I'm a bit too tenacious usually to give up - so
someone 'high up' better make a clear statement saying ... just give up...
otherwise I likely won't)

Either way - I intend to add an equivalent macro to the UVC driver [1][2]
(because as I said - I believe it makes sense), and I have the support of the
maintainer there, so It seems a shame to have to duplicate the implementation in
other use cases where this would make the code more friendly.


/me awaits a NACK-FULL-STOP, or now fears if I'm about to be the cause of a
flame war :-S

[0]
https://git.kernel.org/pub/scm/linux/kernel/git/kbingham/rcar.git/commit/?h=kernel/array-iterator

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/kbingham/rcar.git/commit/?h=kernel/array-iterator&id=3dece696e5b19d79c94f88c9df77482542d49a75

[2]
https://git.kernel.org/pub/scm/linux/kernel/git/kbingham/rcar.git/commit/?h=kernel/array-iterator&id=a31a5424a6577e14d46ce24ef0eff35de3e089bc

--
Kieran
