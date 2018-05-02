Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AB8JxZqkqQ9jBTcd4xwJP+F7nCdHlIw39OcGiUnClMWgpeg89Q0ay8kGZmIrij2rvaQBfVxoGmV5
ARC-Seal: i=1; a=rsa-sha256; t=1525270050; cv=none;
        d=google.com; s=arc-20160816;
        b=ZcaQvvGfG91Q/XjXoSxcVDJ8IrOrdvhCNC3LGvoyWtlICxBHZmMPHeQW5N1xS7UGoD
         ZIfaBispgQ/6geyeeM3xsGYNyMRIPqWimr0Gvu0vVqN15fyQvp0tRKDKBkUK73qq9WMk
         Edsf6Yhjyugpf0vg94eZHf6pI8GF3cIlUKVoPWAjzLow6xOJd1ainPfEMbYltALcAx5h
         74ddBSUzWWuUAOYTJV/XwpVjLagKp5JD1/SJGe5Nr8TtQrduOYMxnJbDrc7RIaO7fImS
         UAubBQLzERZ5amYNn6c86HWLngvbA6bxZAzA7gICOWQDiAS2Ft7CzXvZkqQyM6LU+rsc
         YHMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=WM8UEP035wdv0+enhFbPmdiiH8+IWJI9QLM8a0llwsc=;
        b=xLyeLBaqDipLUe9Si4j/nvOwM249/nFHsC5JfMjYHUr/aLZbEsLT5w3TIxdcOF8dYr
         0CJvsajt6zqcQ0V4MEvI8kot3+Y/5vzqFEygdKklrOnxsyCiE6n7cf0tAuAdwTLzTt55
         XfQ70yq1AGBtG9W64E67c+lQtNXbCEhhmIG42eibirUFxVFvehWcuMxoPsaVsbIsl3NP
         42bAwVnmDSUckISQ/eMfX1Eza04vKmJPRZNc3kji10JuP/BUg0prxzsRIqIPMenwjQEh
         0NHf27ST21uqVdNBDfyBOgs4p804ITy8AE3Jt/KVKKe9aOjfrX0GpVu5XzU92cB6FWOA
         IDZw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.88 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,354,1520924400";
   d="scan'208";a="51763366"
Date: Wed, 2 May 2018 17:07:12 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] typec: tcpm: Fix incorrect 'and' operator
Message-ID: <20180502140712.GH12870@kuha.fi.intel.com>
References: <20180430132305.GA20092@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430132305.GA20092@embeddedor.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599177583315006788?=
X-GMAIL-MSGID: =?utf-8?q?1599361569065462279?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 08:23:06AM -0500, Gustavo A. R. Silva wrote:
> Currently, logical and is being used instead of *bitwise* and.
> 
> Fix this by using a proper bitwise and operator.
> 
> Addresses-Coverity-ID: 1468455 ("Logical vs. bitwise operator")
> Fixes: 64f7c494a3c0 ("typec: tcpm: Add support for sink PPS related
> messages")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> index 1ee259b..7ee417a 100644
> --- a/drivers/usb/typec/tcpm.c
> +++ b/drivers/usb/typec/tcpm.c
> @@ -1772,7 +1772,7 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
>  	enum pd_ext_msg_type type = pd_header_type_le(msg->header);
>  	unsigned int data_size = pd_ext_header_data_size_le(msg->ext_msg.header);
>  
> -	if (!(msg->ext_msg.header && PD_EXT_HDR_CHUNKED)) {
> +	if (!(msg->ext_msg.header & PD_EXT_HDR_CHUNKED)) {
>  		tcpm_log(port, "Unchunked extended messages unsupported");
>  		return;
>  	}

Thanks,

-- 
heikki
