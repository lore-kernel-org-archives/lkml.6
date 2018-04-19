Return-Path: <w@1wt.eu>
X-Google-Smtp-Source: AIpwx4+oGmh5OnPeJkaJtxNIGW/6vcuePtWWUz4Ulz9q/5dPLSkAM3/+1InMMKucF35SO4kRw4x2
ARC-Seal: i=1; a=rsa-sha256; t=1524120940; cv=none;
        d=google.com; s=arc-20160816;
        b=Jp3u2ljGIZd7R1rA2WUO6jKBCaprIq9azfjHS67bcT4UpiGnezw5PT2OLXwQA0A1D0
         VMiy9vAhOgEe/btnUtUyU8JvIWoNAIHW3HzKBc9fm/Tu+fy38We8D2IHQiNmx0vj4hIc
         Y2fd9WAmpX6jcqozEXC57q20Cx8Q3y+z8uoBCVwx6f4l/2LbE0UD5fJLUQWaXMp5D0ep
         EX1GmDkuLKOUWsq2gTr2TfgnIu0K4tUsTZi5gG3TCUsHmSjuBu+uWn7MkzZI+xrXqXMP
         CC1OR2wgDtdhayPGnKT1hMj+0HE5s9fpfnjdsu9ev8trJPmza7QYIu3nSXNV5dAqFXBX
         4WBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=acGYTvr4yA3s6mauyBNNRSWiuoyxbJHH9ZGI1bBJo8A=;
        b=N1QNz44xiOTwRFx0OwMXpunXoG1hRLOHPdh5Er1hdpQkFLCmfJ8LDpkBLALmqjsSwB
         GLkPQqvGzkOvCGk25trmVmr2KqsPXYjOZTMiwqZ+k0388GliXM5EQ+tckce/I9iqzLLu
         FwH4nRVSUttcGlPOBas0poAZgjTMb02ISGFxVNEQCZGNEH/bHKZbtaR0HBbUXPL2CqGG
         uvEmLcdraNSXDtPk2/yAQGCRhHeOQux6eMiuZNKDDNhvtFZ6Wq15ghffnynu7/KcoKg5
         B40iwHoJC7XJLKDGIal1cN3DM3ap4XlGX6C1KZBvxNLbx8PR6ZQ+1RpqmYGR2alvY28f
         +cfg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of w@1wt.eu designates 62.212.114.60 as permitted sender) smtp.mailfrom=w@1wt.eu
Date: Thu, 19 Apr 2018 08:55:24 +0200
From: Willy Tarreau <w@1wt.eu>
To: Andrew Jye Shih Chuang <andrewjschuang@gmail.com>
Cc: William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>, Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp-request@lists.libreplanetbr.org
Subject: Re: [PATCH] staging: speakup: separate 80+ chars lines.
Message-ID: <20180419065524.GC21220@1wt.eu>
References: <5ad83b71.1c69fb81.f8458.0d85@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ad83b71.1c69fb81.f8458.0d85@mx.google.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598156108723047342?=
X-GMAIL-MSGID: =?utf-8?q?1598156638900682561?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 03:47:10AM -0300, Andrew Jye Shih Chuang wrote:
> Increase readability of code following the Kernel coding style by breaking long lines and thus eliminating the checkpatch.pl warning.
> 
> Signed-off-by: Andrew Jye Shih Chuang <andrewjschuang@gmail.com>
> ---
>  drivers/staging/speakup/main.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/speakup/main.c b/drivers/staging/speakup/main.c
> index af30b70..2ba9989 100644
> --- a/drivers/staging/speakup/main.c
> +++ b/drivers/staging/speakup/main.c
> @@ -899,12 +899,13 @@ static int get_sentence_buf(struct vc_data *vc, int read_punc)
>  	while (start < end) {
>  		sentbuf[bn][i] = get_char(vc, (u_short *)start, &tmp);
>  		if (i > 0) {
> -			if (sentbuf[bn][i] == SPACE && sentbuf[bn][i - 1] == '.' &&
> +			if (sentbuf[bn][i] == SPACE &&
> +			    sentbuf[bn][i - 1] == '.' &&
>  			    numsentences[bn] < 9) {
>  				/* Sentence Marker */
>  				numsentences[bn]++;
>  				sentmarks[bn][numsentences[bn]] =
> -				    &sentbuf[bn][i];
> +					&sentbuf[bn][i];
>  			}
>  		}

FWIW I personally feel that this multi-line condition block becomes even less
readable than it already was, and is one example where it's possibly better
to ignore the limit or organize the code different. Just as an example, this
one doing the same already looks more readable to me :


  		if (i > 0 && numsentences[bn] < 9 &&
		    sentbuf[bn][i] == SPACE && sentbuf[bn][i - 1] == '.') {
			/* Sentence Marker */
  			numsentences[bn]++;
  			sentmarks[bn][numsentences[bn]] = &sentbuf[bn][i];
  		}

Willy
