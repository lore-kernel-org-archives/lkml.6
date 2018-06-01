Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3686875-1527877297-2-5331363855381023848
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527877297; b=dkzC/ME29obfteunDXqPbwrevL1JWfwDsul5Nstu6n2Luxme5w
    /TSDBiZnc4MWte5cEjf5egxUjOUlaSTpBPr0ZX8py01Fz7L/0o5brvDGPeLb2ga6
    BzRXxhBOY5Ou7HcnsauMSAfa/EWU4f56mM+dfJSJ/jGISVkpsiF+PB3khxI7zzWI
    OrWWhVq8YJzSs4DTlzeYXafVXhnFGbpi+VAkZfdqHPu2aIu6g/OACTqbmOufCG2z
    KdvixXdwRQJJxpv9UPgFvt3Jqzq2NUDCGQvWBHeo9WzYD1UXmcvdBLFshs0xwg0B
    arD2uVwd5f98xXpMRAHgOIm8eMvn48ZFrgyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527877297; bh=AiTU3EhVeby/xZ64nw+Oi/4d3RrW3f
    7ml+GekAWiMDk=; b=Y9SVTSH/dMgBboT5htK20ip7yBMdFwsURXKi4mc4i/QjJz
    KKEGxRRZL1tB+gA9sJEghXy9cIXfRjNbd2dnl5Xo5MrWMj5TUvxEFWrHiaTScbJd
    8RYAHT0TysEWC2NFr8c6NehCjGNpjn2ww45mkdAKupgRs0dpqd2JESGBNNS+uIrN
    l+clU99BvjiGcvHdg9MZBNPtApfVEcU+lrcszc3MabqOuPbHaQY6VjHcc5Z8qQpg
    jvaHOMut/VH90p5N4HS7E0BvjaXhH2dertP5B/X8veVrBba9W0sS77sKnTZAficS
    QPZskV4fgxCGqzqk+eCeZ5J3eF7R+a3PsNsDgp4Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE9doGPeO7bSan7P+v4xjEvEwH+W7/HStDPWYslAsM5NBqAErvRRdeAMQU1a1j2Zo+9j6QVPmcyAAYk8uwrDnOuBJPZDtJ1HnW4gpAWmKJivEcWvWEwK
    ewLsNir79F6AqM/QyhEwoAMsHJ2+J+eby8UvmwqGACqRwWmo4/hzd6zh4mXbH4+j+h85HGnJsyPAp/NFot0tDnoKstdzXas96K1GXXB4qJrIbmIUHaCjd+4P
    4enu5PlYujO5FAjUTpKLfQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=7mUfYlMuFuIA:10
    a=VnNF1IyMAAAA:8 a=iox4zFpeAAAA:8 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8
    a=VwQbUJbxAAAA:8 a=5uVIzTIbMROP73Z6vtUA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752936AbeFASVe (ORCPT <rfc822;linux@kroah.com>);
        Fri, 1 Jun 2018 14:21:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:35868 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753171AbeFASVJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Jun 2018 14:21:09 -0400
Date: Fri, 1 Jun 2018 20:21:07 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH v4 5/8] ima: based on policy require signed firmware
 (sysfs fallback)
Message-ID: <20180601182107.GO4511@wotan.suse.de>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1527616920-5415-6-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527616920-5415-6-git-send-email-zohar@linux.vnet.ibm.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 29, 2018 at 02:01:57PM -0400, Mimi Zohar wrote:
> Luis, is the security_kernel_post_read_file LSM hook in
> firmware_loading_store() still needed after this patch?  Should it be
> calling security_kernel_load_data() instead?

That's up to Kees to decide as he added that hook, and knows
what LSMs may be doing with it. From my perspective it is confusing
to have that hook there so I think it could be removed now.

Kees?

  Luis

> 
> ---
> 
> With an IMA policy requiring signed firmware, this patch prevents
> the sysfs fallback method of loading firmware.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Luis R. Rodriguez <mcgrof@suse.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Matthew Garrett <mjg59@google.com>
> ---
>  security/integrity/ima/ima_main.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index a565d46084c2..4a87f78098c8 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -475,8 +475,10 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  
>  	if (!file && read_id == READING_FIRMWARE) {
>  		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
> -		    (ima_appraise & IMA_APPRAISE_ENFORCE))
> +		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
> +			pr_err("Prevent firmware loading_store.\n");
>  			return -EACCES;	/* INTEGRITY_UNKNOWN */
> +		}
>  		return 0;
>  	}
>  
> @@ -520,6 +522,12 @@ int ima_load_data(enum kernel_load_data_id id)
>  			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
>  			return -EACCES;	/* INTEGRITY_UNKNOWN */
>  		}
> +		break;
> +	case LOADING_FIRMWARE:
> +		if (ima_appraise & IMA_APPRAISE_FIRMWARE) {
> +			pr_err("Prevent firmware sysfs fallback loading.\n");
> +			return -EACCES;	/* INTEGRITY_UNKNOWN */
> +		}
>  	default:
>  		break;
>  	}
> -- 
> 2.7.5
> 
> 

-- 
Do not panic
