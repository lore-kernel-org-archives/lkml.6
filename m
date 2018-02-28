Return-Path: <tytso@thunk.org>
X-Google-Smtp-Source: AH8x225PIvBLeZY/DD/yB1i3xN1W9QrF4GTJUcgHffdpG1Atk0xFyhK8/nAogmn7iziqk4YQsn7h
ARC-Seal: i=1; a=rsa-sha256; t=1519858778; cv=none;
        d=google.com; s=arc-20160816;
        b=XRIiq2An9CA33SHk2yqFrEX6I0owxSq2OOvHgEMNO399WL1K93jZ0odVcZJYK80ESK
         2I59gJ47X76fylFQDVZDfXsQAsPovkwPHyZQrsZCVmrm0zqWV/ysSlzwzLqYNU07WYCx
         o0r6SQVooqXDEdD7dTlFFmgSoc3BEfbT24vX7NvvA9WvB4VEf+hnODnYQE1gHrNbshoD
         wiG7prvnh66hfyeCGUzu7dmFkCJPB6II7NS1OcFVlNBoGlRHuxrFTUjzJJOejRZ1Cq9n
         mlPY/ZFUf7CXfXju2QHGihB2hUckfUnjkpujlm9KcrHzygqoDnog++qBUaxFjNzOyM+i
         ry3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=K4WnQy7Wn0DXUhjEbA23zPb7HEExIWc5muyADuG54rc=;
        b=GjJwx2E+BYSMt9EFlTIrD2wGsR7cde4Skk70//mP2o9IUgQ3R4YDT0pnEeZEvtheGh
         T64bjDAsoQ4avv3jamMKI4dsSmAQ9UrDvvVfcAB4q/AgPXdeZx7ItgWScMEk+4ZHCZNt
         jZ5WaT9OCvFVFK2FQn3eQjZ4HgJxeSdxyPr3mx6gN/6cu3RjcVuOuDrZvxayfF5v7jUi
         XoPZApgxxLGym0nYcD3mbHXzn2FHSHEkHV8agqQEpbOqM6arckhD4pexMQeuP+C97SfN
         3+l3SRdfMTPXi3UalfqaTeoRQvuyUXMWCT5e9n/D/ZBYNvBYqkSfII67QHQcdRC7DVcw
         kFxw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=HmSzBQAI;
       spf=pass (google.com: domain of tytso@thunk.org designates 2600:3c02::f03c:91ff:fe96:be03 as permitted sender) smtp.mailfrom=tytso@thunk.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=HmSzBQAI;
       spf=pass (google.com: domain of tytso@thunk.org designates 2600:3c02::f03c:91ff:fe96:be03 as permitted sender) smtp.mailfrom=tytso@thunk.org
Date: Wed, 28 Feb 2018 17:59:35 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] random: always fill buffer in get_random_bytes_wait
Message-ID: <20180228225935.GB3862@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
References: <20180204220746.12441-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180204220746.12441-1-Jason@zx2c4.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591509863893639891?=
X-GMAIL-MSGID: =?utf-8?q?1593687437648009329?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 04, 2018 at 11:07:46PM +0100, Jason A. Donenfeld wrote:
> In the unfortunate event that a developer fails to check the return
> value of get_random_bytes_wait, or simply wants to make a "best effort"
> attempt, for whatever that's worth, it's much better to still fill the
> buffer with _something_ rather than catastrophically failing in the case
> of an interruption. This is both a defense in depth measure against
> inevitable programming bugs, as well as a means of making the API a bit
> more useful.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Thanks, applied.

					- Ted
