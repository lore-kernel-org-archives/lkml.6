Return-Path: <jsimmons@infradead.org>
X-Google-Smtp-Source: AIpwx4/FzIJNzZTparJrR/KiokjGH/QhUmBk465bQ75IiM4AFzYno+utdWm9dqmlqaz6ZtsgRCRn
ARC-Seal: i=1; a=rsa-sha256; t=1522436211; cv=none;
        d=google.com; s=arc-20160816;
        b=hYMxUN1MJApB1nlR/LcD5C8+r35qsCEELdqWRmj0I8NL373ik/53hn4YLPdMe7oW/R
         e5SsY92IGVtkXfaJSdzi1rJNDgvG1bw8JQNxlB7kyXR/tXJxhixlMDv75Qs4yzPrs/Dx
         zPwieNvzrFbq903ZxCgAbFV6OdW7IYNQ5DMdvZIUgOelniIuNxZnGA4QDKfnMGHZvukL
         0bvI8TUIk68PTnjhuPX00XH8YTs1T2v4N4Hn181lNOPJvjLA7+/6zOyMvZBJEf7zJTww
         F983m47gyhxrdbV66wwY8eR2P9qVmGRLagNMiDeRZs8NupBQHaxQY0FPPNOw03sE/tdS
         z1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=2HoXMpMw1reW+gTjEjEvIDXKeMYsl4ov9tggmed1z0A=;
        b=WafG4fa9PO/FncZTiMj9fBtE+9d5s29QRi2CMo7fMUgcj6gSq8uxJgUELWvMyCC5QF
         NlWOyFdXPL+SQjYpRKSzJwEhvQeDOrq6ht1GR8rdU8BLi6OujUF00PI10szTkxCWzqE7
         Fs5lKToHMgp5vWPmXfJk4R2qLc5i+FwFh/DJBV6naoXfe1AEyXEj+B2aW41DGwrZpej+
         zbvms40FHmnFWco2CExYLVACneXDTag2o8stqZDz/jmhAmb/MdCQG/J7unDAHexb/V8n
         2Oq/HPm6b0dpicnDIToaD4rvHDyo+72DnIUsFo2AqQzp2sKPpDere+4QT1xn6REwwJF3
         ok7w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=YxHgJWC8;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=casper.20170209 header.b=YxHgJWC8;
       spf=pass (google.com: best guess record for domain of jsimmons@infradead.org designates 2001:8b0:10b:1236::1 as permitted sender) smtp.mailfrom=jsimmons@infradead.org
Date: Fri, 30 Mar 2018 19:56:45 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: NeilBrown <neilb@suse.com>
cc: Oleg Drokin <oleg.drokin@intel.com>,
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    Andreas Dilger <andreas.dilger@intel.com>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 01/17] staging: lustre: remove invariant in
 cl_io_read_ahead()
In-Reply-To: <152229760825.27689.17083243052405696738.stgit@noble>
Message-ID: <alpine.LFD.2.21.1803301956160.9681@casper.infradead.org>
References: <152229732768.27689.4800156943561963977.stgit@noble> <152229760825.27689.17083243052405696738.stgit@noble>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180330_195646_021394_C027CC93 
X-CRM114-Status: GOOD (  13.58  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: SpamAssassin version 3.4.1 on casper.infradead.org summary:
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596244766664542197?=
X-GMAIL-MSGID: =?utf-8?q?1596390073453257184?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> This invariant can fail as ci_type is somtimes CIS_INIT.
> 
> According to Jinshan Xiong, or of the most recent significant
> change to this code, "We should get rid of it."
> 
> So do that.

Reviewed-by: James Simmons <jsimmons@infradead.org>
 
> Fixes: 1e1db2a97be5 ("staging: lustre: clio: Revise read ahead implementation")
> Cc: Jinshan Xiong <jinshan.xiong@intel.com>
> Signed-off-by: NeilBrown <neilb@suse.com>
> ---
>  drivers/staging/lustre/lustre/obdclass/cl_io.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/lustre/lustre/obdclass/cl_io.c b/drivers/staging/lustre/lustre/obdclass/cl_io.c
> index ab84e011b560..fcdae6029258 100644
> --- a/drivers/staging/lustre/lustre/obdclass/cl_io.c
> +++ b/drivers/staging/lustre/lustre/obdclass/cl_io.c
> @@ -599,7 +599,6 @@ int cl_io_read_ahead(const struct lu_env *env, struct cl_io *io,
>  	int		       result = 0;
>  
>  	LINVRNT(io->ci_type == CIT_READ || io->ci_type == CIT_FAULT);
> -	LINVRNT(io->ci_state == CIS_IO_GOING || io->ci_state == CIS_LOCKED);
>  	LINVRNT(cl_io_invariant(io));
>  
>  	cl_io_for_each(scan, io) {
> 
> 
> 
